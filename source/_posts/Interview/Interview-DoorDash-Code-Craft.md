---
title: DoorDash-Code-Craft
date: 2025-03-29 09:15:49
categories: Interview
tags:
---

https://www.1point3acres.com/bbs/thread-1114873-1-1.html

codecraft：写一个 get bootstrap API，取 customerId，address 和 payment 信息。注意 call 这些 API 里面failing handle的问题。

https://www.1point3acres.com/bbs/thread-1104009-1-1.html

CodeCraft也是面经题，写一个API输入dasher ID，输出payment，中间假定有delivery service可以提供delivery list。逻辑就是看这个dasher deliver了多少订单，根据时间算工资，rate也是给定的fix值。这题就是要写很多class，同时完成code logic，边写边和面试官讨论各种各样的问题，根据问题优化code。


https://www.1point3acres.com/bbs/thread-1119279-1-1.html

https://www.1point3acres.com/bbs/thread-1120639-1-1.html



```python
from datetime import datetime, timedelta
from typing import List

class Delivery:
    def __init__(self, pickup_completed_time: datetime, dropoff_time: datetime):
        self.pickup_completed_time = pickup_completed_time
        self.dropoff_time = dropoff_time

    def duration_in_minutes(self) -> float:
        return (self.dropoff_time - self.pickup_completed_time).total_seconds() / 60

class DeliveryService:
    def get_deliveries_for_dasher(self, dasher_id: str) -> List[Delivery]:
        # In a real system, fetch from DB or API
        return [
            Delivery(datetime(2025, 4, 8, 10, 50), datetime(2025, 4, 8, 11, 20)),  # Peak
            Delivery(datetime(2025, 4, 8, 14, 0), datetime(2025, 4, 8, 14, 25)),    # Non-peak
            Delivery(datetime(2025, 4, 8, 17, 10), datetime(2025, 4, 8, 17, 40))     # Peak
        ]

class PaymentCalculator:
    def __init__(self, base_rate: float, peak_hour_multiplier: float):
        self.base_rate = base_rate
        self.peak_hour_multiplier = peak_hour_multiplier

    def is_peak_hour(self, dt: datetime) -> bool:
        weekday = dt.weekday()
        hour = dt.hour
        if weekday < 5:  # Weekdays
            return (11 <= hour < 13) or (17 <= hour < 19)
        else:  # Weekends
            return True

    def calculate_payment(self, deliveries: List[Delivery]) -> float:
        total_payment = 0.0
        for delivery in deliveries:
            duration = delivery.duration_in_minutes()
            rate = self.base_rate
            if self.is_peak_hour(delivery.pickup_completed_time):
                rate *= self.peak_hour_multiplier
            total_payment += duration * rate
        return total_payment

class PaymentAPI:
    def __init__(self, delivery_service: DeliveryService, calculator: PaymentCalculator):
        self.delivery_service = delivery_service
        self.calculator = calculator

    def get_payment(self, dasher_id: str) -> float:
        deliveries = self.delivery_service.get_deliveries_for_dasher(dasher_id)
        return self.calculator.calculate_payment(deliveries)

# ==== Example Usage ====
if __name__ == "__main__":
    delivery_service = DeliveryService()
    calculator = PaymentCalculator(base_rate=0.5, peak_hour_multiplier=1.5)
    payment_api = PaymentAPI(delivery_service, calculator)

    dasher_id = "dasher_123"
    payment = payment_api.get_payment(dasher_id)

    print(f"Total payment for {dasher_id}: ${payment:.2f}")
```

https://www.1point3acres.com/bbs/thread-1110687-1-1.html

* input是dasherId，output是reward。然后会有一个sample data，是一个list，每一个item大致是{dasherId: 1, deliveryId: 1, timestamp: "2024-01-01 00:00:00", status: "ACCEPTED"} 这样的，然后每个delivery会有两条记录，一个是accept，一个是cancel或者delivered，然后按规则计算reward。follow up是给了一个rush hour window，rush hour里reward翻倍。总体来说思路很简单，但是timestamp的处理比较麻烦，最好提前熟悉一下。要写整个class包括测试时间还是比较紧张的


```python
from datetime import datetime
from collections import defaultdict
from concurrent.futures import ThreadPoolExecutor
import threading

class DasherRewardCalculator:
    BASE_REWARD = 1.0
    CANCELLED_REWARD_RATIO = 0.3

    def __init__(self, sample_data, rush_hour_windows, company_balance: float):
        self.sample_data = sample_data
        self.rush_hours = [
            (self._parse_time(start), self._parse_time(end)) for start, end in rush_hour_windows
        ]
        self.company_balance = company_balance
        self.lock = threading.Lock()

    def _parse_time(self, ts):
        return datetime.strptime(ts, "%Y-%m-%d %H:%M:%S")

    def _is_rush_hour(self, time):
        for start, end in self.rush_hours:
            if start <= time <= end:
                return True
        return False

    def _compute_reward(self, records):
        statuses = {r["status"] for r in records}
        accepted_ts_str = [r["timestamp"] for r in records if r["status"] == "ACCEPTED"]
        if not accepted_ts_str:
            return 0.0  # no accepted = invalid
        accepted_time = self._parse_time(accepted_ts_str[0])

        if "DELIVERED" in statuses:
            reward = self.BASE_REWARD
        elif "CANCELLED" in statuses:
            reward = self.BASE_REWARD * self.CANCELLED_REWARD_RATIO
        else:
            return 0.0

        if self._is_rush_hour(accepted_time):
            reward *= 2
        return reward

    def calculate_reward(self, dasher_id):
        # Step 1: gather this dasher's deliveries
        deliveries = defaultdict(list)
        for entry in self.sample_data:
            if entry["dasherId"] == dasher_id:
                deliveries[entry["deliveryId"]].append(entry)

        total_reward = 0.0
        for delivery_id, records in deliveries.items():
            if len(records) != 2:
                continue
            reward = self._compute_reward(records)
            total_reward += reward

        # Step 2: Deduct from company balance under lock
        with self.lock:
            if self.company_balance >= total_reward:
                self.company_balance -= total_reward
                return total_reward
            else:
                return 0.0  # Not enough balance
       
    def calculate_all_rewards(self, dasher_ids: list, max_workers: int = 4) -> dict:
        """
        Returns a dictionary {dasher_id: reward}, rewards 0 if balance insufficient.
        """
        with ThreadPoolExecutor(max_workers=max_workers) as executor:
            ## futures = {executor.submit(self.calculate_reward, dasher_id): dasher_id for dasher_id in dasher_ids}
            futures = {}
            for dasher_id in dasher_ids:
                future = executor.submit(self.calculate_reward, dasher_id)
                futures[future] = dasher_id
            
            results = {}
            for future in futures:
                dasher_id = futures[future]
                results[dasher_id] = future.result()
            return results

    def get_company_balance(self):
        with self.lock:
            return self.company_balance


if __name__ == "__main__":
    sample_data = [
        {"dasherId": 1, "deliveryId": 100, "timestamp": "2024-01-01 18:30:00", "status": "ACCEPTED"},
        {"dasherId": 1, "deliveryId": 100, "timestamp": "2024-01-01 18:45:00", "status": "DELIVERED"},
        {"dasherId": 1, "deliveryId": 101, "timestamp": "2024-01-01 15:00:00", "status": "ACCEPTED"},
        {"dasherId": 1, "deliveryId": 101, "timestamp": "2024-01-01 15:20:00", "status": "DELIVERED"},
        {"dasherId": 1, "deliveryId": 102, "timestamp": "2024-01-01 19:00:00", "status": "ACCEPTED"},
        {"dasherId": 1, "deliveryId": 102, "timestamp": "2024-01-01 19:05:00", "status": "CANCELLED"},
        {"dasherId": 2, "deliveryId": 200, "timestamp": "2024-01-01 18:00:00", "status": "ACCEPTED"},
        {"dasherId": 2, "deliveryId": 200, "timestamp": "2024-01-01 18:30:00", "status": "DELIVERED"},
    ]

    rush_hours = [("2024-01-01 18:00:00", "2024-01-01 20:00:00")]
    initial_balance = 5.0  # try changing this to 3.0 to simulate insufficient balance

    calc = DasherRewardCalculator(sample_data, rush_hours, initial_balance)

    rewards = calc.calculate_all_rewards([1, 2])
    print("Dasher Rewards:", rewards)
    print("Remaining Company Balance:", calc.get_company_balance())

```
