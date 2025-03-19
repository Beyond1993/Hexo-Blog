---
title: DoorDash-Debug
date: 2025-03-19 06:47:28
categories: LeetCode
tags:
---

https://leetcode.com/discuss/post/5837893/doordash-onsite-interview-by-anonymous_u-ljv0/

https://www.1point3acres.com/bbs/thread-1066887-1-1.html

https://www.1point3acres.com/bbs/thread-1110687-1-1.html

https://www.1point3acres.com/bbs/thread-1110839-1-1.html


https://www.1point3acres.com/bbs/thread-1110797-1-1.html


```python

from sortedcontainers import SortedDict
import hashlib
import bisect

class Pod:
    def __init__(self, hostname, port):
        self.hostname = hostname
        self.port = port

class Backend:
    def __init__(self, pod: Pod, state: bool = True):
        self.pod = pod
        self.state = state

    def is_active(self):
        return self.state

    def set_state(self, state: bool):
        self.state = state

class StickyRequestBalancer:
    def __init__(self, backends, virtual_nodes=100):
        self.backends = set(backends)
        self.virtual_nodes = virtual_nodes
        self.ring = SortedDict()  # hash -> backend
        self.node_map = {}  # backend -> list of hashes
        self._generate_ring()

    def _hash(self, key: str):
        return int(hashlib.md5(key.encode('utf-8')).hexdigest(), 16)

    def _generate_ring(self):
        self.ring.clear()
        self.node_map.clear()
        for backend in self.backends:
            self._add_backend_to_ring(backend)

    def _add_backend_to_ring(self, backend):
        hashes = []
        for i in range(self.virtual_nodes):
            key = f"{backend.pod.hostname}:{backend.pod.port}-vn{i}"
            hash_key = self._hash(key)
            self.ring[hash_key] = backend
            hashes.append(hash_key)
        self.node_map[backend] = hashes

    def add_backend(self, backend: Backend):
        if backend in self.backends:
            return
        self.backends.add(backend)
        self._add_backend_to_ring(backend)

    def remove_backend(self, backend: Backend):
        if backend not in self.backends:
            return
        hashes = self.node_map.pop(backend, [])
        for hash_key in hashes:
            if hash_key in self.ring:
                del self.ring[hash_key]
        self.backends.remove(backend)

    def set_backend_state(self, backend: Backend, state: bool):
        backend.set_state(state)

    def get_backend(self, request_id: str):
        if not self.ring:
            raise Exception("No active backends")
        request_hash = self._hash(request_id)
        keys = list(self.ring.keys())
        idx = bisect.bisect_left(keys, request_hash)

        searched = 0
        while searched < len(keys):
            real_idx = (idx + searched) % len(keys)
            backend = self.ring[keys[real_idx]]
            if backend.is_active():
                return backend
            searched += 1

        raise Exception("No active backends available")
```

```python
import unittest

class TestStickyRequestBalancer(unittest.TestCase):
    def setUp(self):
        self.backend1 = Backend(Pod("host1", 8080))
        self.backend2 = Backend(Pod("host2", 8080))
        self.backend3 = Backend(Pod("host3", 8080))

        self.balancer = StickyRequestBalancer([self.backend1, self.backend2])

    def test_basic_round_robin_behavior(self):
        # sticky 应该 consistent hash 到固定 backend
        request1 = "user_1"
        request2 = "user_2"
        backend_a = self.balancer.get_backend(request1)
        backend_b = self.balancer.get_backend(request2)

        # 同一个 request_id 应该 sticky
        self.assertEqual(backend_a, self.balancer.get_backend(request1))
        self.assertEqual(backend_b, self.balancer.get_backend(request2))

    def test_inactive_backend(self):
        # 将 backend1 下线
        self.backend1.set_state(False)
        request1 = "user_1"
        backend = self.balancer.get_backend(request1)
        # hash 可能原本在 backend1，但 backend1 down 了，应该 fallback 到其他 active backend
        self.assertTrue(backend.is_active())
        self.assertNotEqual(backend, self.backend1)

    def test_add_backend(self):
        # 加 backend3，ring 上多了节点
        self.balancer.add_backend(self.backend3)
        self.assertIn(self.backend3, self.balancer.backends)
        # backend3 应该能分到请求
        found = False
        for i in range(100):
            if self.balancer.get_backend(f"user_{i}") == self.backend3:
                found = True
                break
        self.assertTrue(found)

    def test_remove_backend(self):
        # 删除 backend2，应该不再出现在 ring 上
        self.balancer.remove_backend(self.backend2)
        for i in range(100):
            backend = self.balancer.get_backend(f"user_{i}")
            self.assertNotEqual(backend, self.backend2)

    def test_remove_all_backends(self):
        self.balancer.remove_backend(self.backend1)
        self.balancer.remove_backend(self.backend2)
        with self.assertRaises(Exception):
            self.balancer.get_backend("user_x")

if __name__ == '__main__':
    unittest.main()
```


```python
import threading

class StickyRequestBalancer:
    def __init__(self, backends, virtual_nodes=100):
        self.backends = set(backends)
        self.virtual_nodes = virtual_nodes
        self.ring = SortedDict()  # hash -> backend
        self.node_map = {}  # backend -> list of hashes
        self.lock = threading.RLock()
        self._generate_ring()

    def _hash(self, key: str):
        return int(hashlib.md5(key.encode('utf-8')).hexdigest(), 16)

    def _generate_ring(self):
        for backend in self.backends:
            self._add_backend_to_ring(backend)

    def _add_backend_to_ring(self, backend):
        hashes = []
        for i in range(self.virtual_nodes):
            key = f"{backend.pod.hostname}:{backend.pod.port}-vn{i}"
            hash_key = self._hash(key)
            self.ring[hash_key] = backend
            hashes.append(hash_key)
        self.node_map[backend] = hashes

    def add_backend(self, backend: Backend):
        with self.lock:
            if backend in self.backends:
                return
            self.backends.add(backend)
            self._add_backend_to_ring(backend)

    def remove_backend(self, backend: Backend):
        with self.lock:
            if backend not in self.backends:
                return
            hashes = self.node_map.pop(backend, [])
            for hash_key in hashes:
                if hash_key in self.ring:
                    del self.ring[hash_key]
            self.backends.remove(backend)

    def set_backend_state(self, backend: Backend, state: bool):
        with self.lock:
            backend.set_state(state)

    def get_backend(self, request_id: str):
        with self.lock:
            if not self.ring:
                raise Exception("No active backends")
            request_hash = self._hash(request_id)
            keys = list(self.ring.keys())
            idx = bisect.bisect_left(keys, request_hash)

            searched = 0
            while searched < len(keys):
                real_idx = (idx + searched) % len(keys)
                backend = self.ring[keys[real_idx]]
                if backend.is_active():
                    return backend
                searched += 1

            raise Exception("No active backends available")
```

```python
import unittest
import threading
import time
import random

class TestStickyBalancerThreadSafety(unittest.TestCase):
    def setUp(self):
        self.backend1 = Backend(Pod("host1", 8080))
        self.backend2 = Backend(Pod("host2", 8080))
        self.backend3 = Backend(Pod("host3", 8080))
        self.balancer = StickyRequestBalancer([self.backend1, self.backend2])

    def worker_get(self, thread_id):
        for _ in range(100):
            try:
                backend = self.balancer.get_backend(f"user_{thread_id}_{random.randint(0, 50)}")
                self.assertTrue(backend.is_active())
            except Exception as e:
                # 在全部 backend down 掉的情况下，get_backend 可能抛异常
                pass

    def worker_add_remove(self):
        for _ in range(20):
            backend = Backend(Pod(f"dynamic_host_{random.randint(1000, 9999)}", 8080))
            self.balancer.add_backend(backend)
            time.sleep(0.01)
            self.balancer.remove_backend(backend)

    def test_concurrent_access(self):
        threads = []
        # 5 个 get_backend 的线程
        for i in range(5):
            t = threading.Thread(target=self.worker_get, args=(i,))
            threads.append(t)
        # 2 个 add/remove backend 的线程
        for _ in range(2):
            t = threading.Thread(target=self.worker_add_remove)
            threads.append(t)
        # 启动所有线程
        for t in threads:
            t.start()
        # 等待所有线程结束
        for t in threads:
            t.join()

        # 最后检查 backend1/2 仍在
        self.assertIn(self.backend1, self.balancer.backends)
        self.assertIn(self.backend2, self.balancer.backends)

```
