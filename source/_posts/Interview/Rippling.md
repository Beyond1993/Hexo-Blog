---
title: Ripping
date: 2025-06-10 04:14:13
categories: Interview
tags:
---


第一轮 SD: Goole News 题目
https://www.1point3acres.com/bbs/thread-1130291-1-1.html
https://www.1point3acres.com/bbs/thread-1128128-1-1.html
Snapshot题目
https://www.1point3acres.com/bbs/thread-1125149-1-1.html
Music player题目
https://www.1point3acres.com/bbs/thread-1099955-1-1.html
https://www.1point3acres.com/bbs/thread-1115169-1-1.html
https://www.1point3acres.com/bbs/thread-1099791-1-1.html
https://www.1point3acres.com/bbs/thread-1114831-1-1.html
KV Store题目
https://www.1point3acres.com/bbs/thread-1084048-1-1.html
https://www.1point3acres.com/bbs/thread-1098036-1-1.html
https://www.1point3acres.com/bbs/thread-1087129-1-1.html
外卖题目
https://www.1point3acres.com/bbs/thread-1106246-1-1.html
https://www.1point3acres.com/bbs/thread-1121843-1-1.html
https://www.1point3acres.com/bbs/thread-1121468-1-1.html
https://www.1point3acres.com/bbs/thread-1127613-1-1.html


```python
import bisect
import time
import unittest

# === Core Classes ===

class DeliveryRecord:
    def __init__(self, start_time: int, end_time: int):
        if end_time - start_time > 3 * 3600:
            raise ValueError("Delivery cannot exceed 3 hours.")
        self.start = start_time
        self.end = end_time
        self.seconds = end_time - start_time
        self.paid = False

class Driver:
    def __init__(self, driver_id: int, usd_hourly_rate: float):
        self.driver_id = driver_id
        self.rate_cents_per_hour = int(round(usd_hourly_rate * 100))
        self.records = []
        self.end_times = []
        self.paid_pointer = 0

    def add_record(self, start_time: int, end_time: int):
        record = DeliveryRecord(start_time, end_time)
        idx = bisect.bisect_right(self.end_times, end_time)
        self.records.insert(idx, record)
        self.end_times.insert(idx, end_time)

    def pay_up_to(self, pay_time: int):
        idx = bisect.bisect_right(self.end_times, pay_time, lo=self.paid_pointer)
        for i in range(self.paid_pointer, idx):
            self.records[i].paid = True
        self.paid_pointer = idx

    def _calculate_cost(self, records) -> int:
        return sum(int(round((r.seconds / 3600) * self.rate_cents_per_hour)) for r in records)

    def total_paid(self) -> float:
        return self._calculate_cost(r for r in self.records if r.paid) / 100.0

    def total_unpaid(self) -> float:
        return self._calculate_cost(r for r in self.records if not r.paid) / 100.0

    def total_cost(self) -> float:
        return self._calculate_cost(self.records) / 100.0

    def was_online_in_window(self, window_start: int, window_end: int) -> bool:
        idx = bisect.bisect_left(self.end_times, window_start)
        while idx < len(self.records):
            record = self.records[idx]
            if record.start < window_end:
                return True
            idx += 1
        return False

class DriverSystem:
    def __init__(self):
        self.drivers = {}

    def add_driver(self, driver_id: int, usd_hourly_rate: float):
        if driver_id in self.drivers:
            raise ValueError(f"Driver {driver_id} already exists.")
        self.drivers[driver_id] = Driver(driver_id, usd_hourly_rate)

    def record_delivery(self, driver_id: int, start_time: int, end_time: int):
        if driver_id not in self.drivers:
            raise ValueError(f"Driver {driver_id} not found.")
        self.drivers[driver_id].add_record(start_time, end_time)

    def get_total_cost(self) -> float:
        return round(sum(driver.total_cost() for driver in self.drivers.values()), 2)

    def pay_up_to(self, pay_time: int):
        for driver in self.drivers.values():
            driver.pay_up_to(pay_time)

    def total_cost_unpaid(self) -> float:
        return round(sum(driver.total_unpaid() for driver in self.drivers.values()), 2)

    def get_driver_cost(self, driver_id: int) -> dict:
        if driver_id not in self.drivers:
            raise ValueError(f"Driver {driver_id} not found.")
        driver = self.drivers[driver_id]
        return {
            "paid": round(driver.total_paid(), 2),
            "unpaid": round(driver.total_unpaid(), 2)
        }

    def max_simultaneous_drivers_24h_before(self, end_time: int) -> int:
        window_start = end_time - 86400
        events = []
        for driver in self.drivers.values():
            for record in driver.records:
                if record.end > window_start and record.start < end_time:
                    start = max(record.start, window_start)
                    end = min(record.end, end_time)
                    events.append((start, +1))
                    events.append((end, -1))
        events.sort(key=lambda x: (x[0], -x[1]))
        max_active = 0
        current_active = 0
        for _, delta in events:
            current_active += delta
            max_active = max(max_active, current_active)
        return max_active

    def count_online_drivers(self, timestamp: int) -> int:
        start_window = timestamp - 86400
        count = 0
        for driver in self.drivers.values():
            if driver.was_online_in_window(start_window, timestamp):
                count += 1
        return count

# === Unit Tests ===

class TestDriverSystem(unittest.TestCase):
    def setUp(self):
        self.ds = DriverSystem()
        self.now = int(time.time())
        self.ds.add_driver(1, 10.0)  # $10/hour
        self.ds.add_driver(2, 15.0)  # $15/hour

        # 1 hour delivery for driver 1 → $10.00
        self.ds.record_delivery(1, self.now - 3600, self.now)

        # 1.5 hour delivery for driver 2 → $22.50
        self.ds.record_delivery(2, self.now - 5400, self.now)

    def test_total_cost(self):
        self.assertAlmostEqual(self.ds.get_total_cost(), 32.50, places=2)

    def test_unpaid_cost(self):
        self.assertAlmostEqual(self.ds.total_cost_unpaid(), 32.50, places=2)
        self.ds.pay_up_to(self.now)
        self.assertEqual(self.ds.total_cost_unpaid(), 0.0)
        self.assertAlmostEqual(self.ds.get_total_cost(), 32.50, places=2)

    def test_online_count(self):
        self.assertEqual(self.ds.count_online_drivers(self.now), 2)

    def test_max_simultaneous(self):
        self.assertEqual(self.ds.max_simultaneous_drivers_24h_before(self.now), 2)

if __name__ == "__main__":
    unittest.main()
```



