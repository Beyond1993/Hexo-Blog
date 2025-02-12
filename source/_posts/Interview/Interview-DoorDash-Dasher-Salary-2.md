---
title: Dasher-Salary-2
date: 2025-02-12 12:59:09
categories: Interview
tags:
---

Part 1: Basic Payment Model
You are in charge of implementing the dasher payment model. The first version of the payment model is based on how much time a dasher spends on each order. Given the sequence of accepted and fulfilled order activities from a dasher on a given day, calculate their pay using the following rules:

Base pay rate: $0.30 per minute.
Multi-order pay rate: The number of ongoing deliveries multiplied by the base pay rate (when delivering multiple orders at the same time).
Assumptions:

All order activities occur on the same calendar day.
The order activity sequence is valid. Every order is fulfilled by the end of the day (no duplicates, no fulfillment without pickup, no pickup without fulfillment, etc.).
Example:
Input:
06:15 - Dx accepted order A
06:18 - Dx accepted order B
06:36 - Dx fulfilled order A
06:45 - Dx fulfilled order B

Output:
Final pay: $14.4

Explanation:

06:15 - 06:18 → Pay = 3 minutes × $0.30 = $0.90
06:18 - 06:36 → Pay = 2 orders × $0.30 × 18 minutes = $10.80
06:36 - 06:45 → Pay = 9 minutes × $0.30 = $2.70
Part 2: Adjusting for Wait Time at Pickups
The previous version of the payment model overcounts the time a dasher spends between arrival and pickup (e.g., food packing, paying, wait time). The updated model still gives credit for multi-order deliveries but excludes wait time at pickup locations from overlapping with other orders.

Example:
Input:
06:15 - Dx accepted order A
06:18 - Dx accepted order B
06:19 - Dx arrived at pick-up location for A
06:22 - Dx picked up order A
06:30 - Dx arrived at pick-up location for B
06:33 - Dx picked up order B
06:36 - Dx fulfilled order A
06:45 - Dx fulfilled order B

Output:
Final pay: $12.6

Explanation:

06:15 - 06:18 → Pay = 3 minutes × $0.30 = $0.90
06:18 - 06:19 → Pay = 2 orders × $0.30 = $0.60
06:19 - 06:22 → Pay = 3 minutes × $0.30 = $0.90
06:22 - 06:30 → Pay = 2 orders × $0.30 × 8 minutes = $4.80
06:30 - 06:33 → Pay = $0.90
06:33 - 06:36 → Pay = 2 orders × $0.30 × 3 minutes = $1.80
06:36 - 06:45 → Pay = 9 minutes × $0.30 = $2.70
Part 3: Peak Hour Pay
To ensure enough dashers are available during rush hours, peak hours double the pay within specific time windows. Given the peak hour windows and the order activity sequence, calculate the new pay.

Example:
Input:
Peak pay windows: [["06:20", "06:30"]]
06:15 - Dx accepted order A
06:18 - Dx accepted order B
06:19 - Dx arrived at pick-up location for A
06:22 - Dx picked up order A
06:30 - Dx arrived at pick-up location for B
06:33 - Dx picked up order B
06:36 - Dx fulfilled order A
06:45 - Dx fulfilled order B

Output:
Final pay: $18.0

Explanation:

06:15 - 06:18 → Pay = $0.90
06:18 - 06:19 → Pay = $0.60
06:19 - 06:20 → Pay = $0.30
06:20 - 06:22 → Peak Pay = 2 minutes × $0.60 = $1.20
06:22 - 06:30 → Peak Pay = 2 orders × $0.60 × 8 minutes = $9.60
06:30 - 06:33 → Pay = $0.90
06:33 - 06:36 → Pay = 2 orders × $0.30 × 3 minutes = $1.80
06:36 - 06:45 → Pay = $2.70

```python
from datetime import datetime

def parse_time(time_str):
    return datetime.strptime(time_str, "%H:%M")

def calculate_pay(events, peak_hours=None):
    base_rate = 0.3
    peak_hours = [(parse_time(start), parse_time(end)) for start, end in (peak_hours or [])]
    
    active_orders = 0
    last_time = None
    total_pay = 0.0
    ongoing_orders = {}
    
    for event in events:
        time_str, action = event.split(": ", 1)
        time = parse_time(time_str)
        
        if last_time is not None:
            duration = (time - last_time).seconds / 60
            pay_rate = active_orders * base_rate
            
            for peak_start, peak_end in peak_hours:
                if last_time < peak_end and time > peak_start:
                    peak_start_effective = max(last_time, peak_start)
                    peak_end_effective = min(time, peak_end)
                    peak_duration = (peak_end_effective - peak_start_effective).seconds / 60
                    regular_duration = duration - peak_duration
                    total_pay += (regular_duration * pay_rate) + (peak_duration * pay_rate * 2)
                    break
            else:
                total_pay += duration * pay_rate
        
        last_time = time
        
        if "accepted" in action:
            order_id = action.split()[-1]
            ongoing_orders[order_id] = "accepted"
            active_orders += 1
        elif "arrived at pick up location" in action:
            order_id = action.split()[-1]
            ongoing_orders[order_id] = "arrived"
        elif "picked up" in action:
            order_id = action.split()[-1]
            ongoing_orders[order_id] = "picked up"
        elif "fulfilled" in action:
            order_id = action.split()[-1]
            ongoing_orders.pop(order_id, None)
            active_orders -= 1
    
    return round(total_pay, 2)

# Example usage
events = [
    "06:15: Dx accepted order A",
    "06:18: Dx accepted order B",
    "06:19: Dx arrived at pick up location for A",
    "06:22: Dx picked up order A",
    "06:30: Dx arrived at pick up location for B",
    "06:33: Dx picked up order B",
    "06:36: Dx fulfilled order A",
    "06:45: Dx fulfilled order B",
]
peak_hours = [["06:20", "06:30"]]

print(f"Final pay: ${calculate_pay(events, peak_hours)}")

```
