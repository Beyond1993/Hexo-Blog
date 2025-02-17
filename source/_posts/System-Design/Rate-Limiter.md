---
title: Design Rate Limiter
date: 2019-10-19 16:32:27
categories: System Design
tags:
---

# 🚀 Redis 限流算法（Python 实现）

## 1️⃣ 计数器限流 (Fixed Window, `INCR`)
### ✅ 适用场景
- **简单 API 限流**，适用于固定窗口，如每分钟最多 100 次请求。
- **高性能、实现简单**，但可能有窗口边界问题。

### 📌 Python 实现 (`redis-py`)

```python
import redis

r = redis.StrictRedis(host='localhost', port=6379, decode_responses=True)

def fixed_window_rate_limiter(key, limit, expire_time):
    current_count = r.incr(key)  # 计数 +1
    if current_count == 1:
        r.expire(key, expire_time)  # 设置窗口过期时间

    return current_count <= limit  # 超出限制返回 False
```

```python
def leaky_bucket_rate_limiter(key, capacity, leak_rate):
    current_time = int(time.time())
    
    # 获取当前漏桶状态
    last_request_time, current_water_level = client.hmget(key, ['last_request_time', 'current_water_level'])
    last_request_time = int(last_request_time or 0)
    current_water_level = int(current_water_level or 0)
    
    # 计算时间差，模拟漏水过程
    if last_request_time > 0:
        elapsed_time = current_time - last_request_time
        leak_amount = elapsed_time * leak_rate
        current_water_level = max(current_water_level - leak_amount, 0)  # 确保水量不小于0
    
    # 检查是否超出桶的容量
    if current_water_level + 1 > capacity:
        return False  # 超过容量，拒绝请求
    
    # 更新漏桶状态
    client.hmset(key, {
        'last_request_time': current_time,
        'current_water_level': current_water_level + 1
    })
    return True

# 示例使用
print(leaky_bucket_rate_limiter('api_request', capacity=100, leak_rate=1))  # 容量100，每秒漏1个请求

```

```python
import threading
import time

class LeakyBucket:
    def __init__(self, capacity, leak_rate):
        self.capacity = capacity
        self.leak_rate = leak_rate  # 每秒流出的请求数
        self.water = 0  # 当前水量
        self.last_time = time.time()
        self.lock = threading.Lock()

    def allow_request(self):
        with self.lock:
            now = time.time()
            elapsed = now - self.last_time
            self.water = max(0, self.water - elapsed * self.leak_rate)  # 按速率减少水量
            self.last_time = now

            if self.water < self.capacity:
                self.water += 1  # 新增请求
                return True
            return False  # 水满，请求被限流

```


```python
import time

def token_bucket_limiter(key, capacity, refill_rate):
    now = time.time()
    last_time, tokens = r.hmget(key, "last_time", "tokens")

    if last_time is None:
        last_time, tokens = now, capacity  # 初始化

    last_time = float(last_time)
    tokens = float(tokens)

    elapsed = now - last_time
    new_tokens = min(capacity, tokens + elapsed * refill_rate)  # 补充令牌

    if new_tokens >= 1:
        r.hmset(key, {"tokens": new_tokens - 1, "last_time": now})
        return True  # 允许请求
    else:
        return False  # 限流
```


### 🚀 Redis 限流算法比较

| **算法** | **原理** | **流量模式** | **是否允许突发** | **实现方式** | **适用场景** | **优点** | **缺点** |
|----------|--------|------------|-----------------|------------|-----------|---------|---------|
| **计数器 (Fixed Window, `INCR`)** | 设定固定时间窗口 (`INCR` 计数) | 固定窗口 | ❌ 不允许突发 | `INCR + EXPIRE` | **简单限流**, API 调用 | **实现简单**, 性能高 | 窗口边界问题, 瞬时突发可能超限 |
| **滑动窗口 (Sliding Window, `ZSET`)** | 记录请求时间戳，移除过期请求 | 滑动窗口 | ❌ 不允许突发 | `ZADD + ZREMRANGEBYSCORE` | **平滑限流**, 防止临界爆发 | **窗口平滑**, 没有边界效应 | `ZSET` 操作较重, 性能稍低 |
| **漏桶 (Leaky Bucket)** | 固定速率处理请求，超出部分丢弃 | 严格匀速 | ❌ 不允许突发 | `Redis HSET` / 队列 | **平滑处理**, 网络带宽限流 | **平滑流量**, 保护后端 | **响应慢**, 不能处理突发 |
| **令牌桶 (Token Bucket)** | 按固定速率补充令牌, 请求消耗令牌 | 允许突发 | ✅ 允许短时间突发 | `HSET + Lua` | **高并发 API 限流** | **支持突发流量**, 高效 | **超限后请求受限**, 需要额外管理 |

### 🔹 选择建议

| **需求** | **推荐算法** |
|----------|-----------|
| **简单 API 限流，性能优先** | `INCR` 计数器 |
| **需要平滑流量，避免窗口边界问题** | `ZSET` 滑动窗口 |
| **匀速流量控制（带宽、任务队列）** | 漏桶（Leaky Bucket） |
| **支持突发请求，但长期受控** | 令牌桶（Token Bucket） |

