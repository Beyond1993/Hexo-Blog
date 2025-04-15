---
title: DoorDash-Debug-Consistent-Hashing
date: 2025-04-15 11:48:34
categories: Interview
tags:
---

题目描述：

给出一堆代码 需要debug 需要实现一个round robin 的request分发

（大概3个bugs一个是round robin 实现不对，还有test case 有一个bug） 

follow up是 implmenet consistent hashing （一定要用java 写因为python没有TreeMap）

consistent 代码:

**核心逻辑很简单，就是先算出hash 值，在取离这个hash 值最近的服务器** 可以通过 treeMap ceiling, 取大于这个hash 值最小的数
https://blog.csdn.net/themagickeyjianan/article/details/121331771

```python
import bisect
import unittest

class Pod:
    def __init__(self, hostname, port):
        self.hostname = hostname
        self.port = port

    def __repr__(self):
        return f"{self.hostname}:{self.port}"

class Backend:
    def __init__(self, pod: Pod, state: bool = True):
        self.pod = pod
        self.state = state

    def is_active(self):
        return self.state

    def set_state(self, state: bool):
        self.state = state

    def __repr__(self):
        status = "active" if self.state else "inactive"
        return f"{self.pod} ({status})"


class ConsistentHashRing:
    def __init__(self):
        self.server_map = {}
        self.sorted_keys = []

    def add_backend(self, hash_key: int, backend: Backend):
        self.server_map[hash_key] = backend
        self.sorted_keys = sorted(self.server_map.keys())

    def get_backend(self, hash_value: int):
        if not self.sorted_keys:
            return None

        index = bisect.bisect_left(self.sorted_keys, hash_value)
        if index == len(self.sorted_keys):
            index = 0  # wrap around
        return self.server_map[self.sorted_keys[index]]


class TestConsistentHashing(unittest.TestCase):

    def setUp(self):
        self.ring = ConsistentHashRing()
        self.ring.add_backend(11, Backend(Pod("server1.example.com", 8080)))
        self.ring.add_backend(22, Backend(Pod("server2.example.com", 8080)))
        self.ring.add_backend(33, Backend(Pod("server3.example.com", 8080)))
        self.ring.add_backend(44, Backend(Pod("server4.example.com", 8080)))
        self.ring.add_backend(55, Backend(Pod("server5.example.com", 8080)))

    def test_exact_match(self):
        backend = self.ring.get_backend(33)
        self.assertEqual(backend.pod.hostname, "server3.example.com")

    def test_between_keys(self):
        backend = self.ring.get_backend(30)
        self.assertEqual(backend.pod.hostname, "server3.example.com")

    def test_wraparound(self):
        backend = self.ring.get_backend(100)
        self.assertEqual(backend.pod.hostname, "server1.example.com")

    def test_first_key_match(self):
        backend = self.ring.get_backend(11)
        self.assertEqual(backend.pod.hostname, "server1.example.com")

    def test_toggle_backend_state(self):
        backend = self.ring.get_backend(22)
        self.assertTrue(backend.is_active())
        backend.set_state(False)
        self.assertFalse(backend.is_active())

    def test_empty_ring(self):
        empty_ring = ConsistentHashRing()
        self.assertIsNone(empty_ring.get_backend(42))


if __name__ == "__main__":
    unittest.main()
```

thread safe version:
```python
import threading

class ConsistentHashRing:
    def __init__(self):
        self.server_map = {}
        self.sorted_keys = []
        self.lock = threading.Lock()

    def add_backend(self, hash_key: int, backend: Backend):
        with self.lock:
            self.server_map[hash_key] = backend
            self.sorted_keys = sorted(self.server_map.keys())

    def get_backend(self, hash_value: int):
        with self.lock:
            if not self.sorted_keys:
                return None

            index = bisect.bisect_left(self.sorted_keys, hash_value)
            if index == len(self.sorted_keys):
                index = 0  # wrap around
            return self.server_map[self.sorted_keys[index]]
```


测试一个backend 失效，转移到下一个:
```python
import bisect
import unittest

class Pod:
    def __init__(self, hostname, port):
        self.hostname = hostname
        self.port = port

    def __repr__(self):
        return f"{self.hostname}:{self.port}"

class Backend:
    def __init__(self, pod: Pod, state: bool = True):
        self.pod = pod
        self.state = state

    def is_active(self):
        return self.state

    def set_state(self, state: bool):
        self.state = state

    def __repr__(self):
        status = "active" if self.state else "inactive"
        return f"{self.pod} ({status})"


class ConsistentHashRing:
    def __init__(self):
        self.server_map = {}
        self.sorted_keys = []
        self.key_mapping = {}

    def add_backend(self, hash_key: int, backend: Backend):
        self.server_map[hash_key] = backend
        self.sorted_keys = sorted(self.server_map.keys())

    def update_backend_state(self, hash_key: int, state: bool):
        backend = self.server_map.get(hash_key)
        if backend:
            backend.set_state(state)

    def get_backend(self, hash_value: int):
        if not self.sorted_keys:
            return None

        index = bisect.bisect_left(self.sorted_keys, hash_value)
        if index == len(self.sorted_keys):
            index = 0  # wrap around
        
        # Skip inactive backends
        # 在一个循环结构中向前推进一个位置，并在达到末尾时回到开头。这是一种实现 “环形结构” 的常见技巧，用于在列表中循环查找下一个元素。
        while not self.server_map[self.sorted_keys[index]].is_active():
            index = (index + 1) % len(self.sorted_keys)
        
        return self.server_map[self.sorted_keys[index]]

    def get_backend_for_hash(self, hash_value: int):
        index = bisect.bisect_left(self.sorted_keys, hash_value)
        if index == len(self.sorted_keys):
            index = 0  # wrap around
        return self.server_map[self.sorted_keys[index]]

    def add_key(self, hash_value: int):
        backend = self.get_backend_for_hash(hash_value)
        self.key_mapping[hash_value] = backend


class TestConsistentHashing(unittest.TestCase):

    def setUp(self):
        self.ring = ConsistentHashRing()
        # Add 10 backends with hash values from 1 to 10
        for i in range(1, 11):
            self.ring.add_backend(i, Backend(Pod(f"server{i}.example.com", 8080)))

        # Add some keys to the ring for testing
        for i in range(1, 11):
            self.ring.add_key(i)

    def test_exact_match(self):
        backend = self.ring.get_backend(5)
        self.assertEqual(backend.pod.hostname, "server5.example.com")

    def test_inactive_backend_returns_next_active_backend(self):
        # Deactivate backend with hash 3
        self.ring.update_backend_state(3, False)
        
        # Test that key 4, which would normally map to backend 3, is now assigned
        # to the next active backend in the ring
        backend = self.ring.get_backend(4)
        self.assertEqual(backend.pod.hostname, "server4.example.com")

    def test_empty_ring(self):
        empty_ring = ConsistentHashRing()
        self.assertIsNone(empty_ring.get_backend(42))


if __name__ == "__main__":
    unittest.main()
```


换一个策略，随机分配到active backend

```python
import bisect
import random
import unittest

class Pod:
    def __init__(self, hostname, port):
        self.hostname = hostname
        self.port = port

    def __repr__(self):
        return f"{self.hostname}:{self.port}"

class Backend:
    def __init__(self, pod: Pod, state: bool = True):
        self.pod = pod
        self.state = state

    def is_active(self):
        return self.state

    def set_state(self, state: bool):
        self.state = state

    def __repr__(self):
        status = "active" if self.state else "inactive"
        return f"{self.pod} ({status})"

class ConsistentHashRing:
    def __init__(self):
        self.server_map = {}
        self.sorted_keys = []

    def add_backend(self, hash_key: int, backend: Backend):
        self.server_map[hash_key] = backend
        self.sorted_keys = sorted(self.server_map.keys())

    def update_backend_state(self, hash_key: int, state: bool):
        backend = self.server_map.get(hash_key)
        if backend:
            backend.set_state(state)

    def get_backend(self, hash_value: int):
        if not self.sorted_keys:
            return None

        index = bisect.bisect_left(self.sorted_keys, hash_value)
        if index == len(self.sorted_keys):
            index = 0  # wrap around

        backend = self.server_map[self.sorted_keys[index]]

        if backend.is_active():
            return backend
        else:
            # fallback: randomly select from active backends
            active_backends = [b for b in self.server_map.values() if b.is_active()]
            if not active_backends:
                return None
            return random.choice(active_backends)

# ----------------------
# ✅ Unit Tests
# ----------------------

class TestConsistentHashing(unittest.TestCase):
    def setUp(self):
        self.ring = ConsistentHashRing()
        # Add 10 backends with hash values from 1 to 10
        for i in range(1, 11):
            pod = Pod(f"server{i}.example.com", 8080)
            backend = Backend(pod)
            self.ring.add_backend(i, backend)

    def test_exact_match(self):
        backend = self.ring.get_backend(5)
        self.assertEqual(backend.pod.hostname, "server5.example.com")

    def test_inactive_backend_fallback_to_random_active(self):
        # Disable the expected backend
        self.ring.update_backend_state(5, False)

        # Get a backend for the same hash key
        backend = self.ring.get_backend(5)

        self.assertNotEqual(backend.pod.hostname, "server5.example.com")
        self.assertTrue(backend.is_active())

    def test_all_backends_inactive_returns_none(self):
        for i in range(1, 11):
            self.ring.update_backend_state(i, False)
        self.assertIsNone(self.ring.get_backend(42))

    def test_random_fallback_multiple_times(self):
        self.ring.update_backend_state(3, False)
        seen = set()
        for _ in range(20):
            backend = self.ring.get_backend(3)
            self.assertTrue(backend.is_active())
            seen.add(backend.pod.hostname)
        self.assertGreater(len(seen), 1)  # Should vary due to randomness

if __name__ == "__main__":
    unittest.main()
```
