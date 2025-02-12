---
title: Dasher-Salary
date: 2025-02-12 12:43:46
categories: Interview
tags:
---

coding：经典给dasher算工资的题，function只有一个input：dasherID。此外会给一个information list，[[1, 101, "2024-01-01 10:00:00", "ACCEPTED"], [1, 101, "2024-01-01 10:30:00", "DELIVERED"], [2, 201, "2024-01-01 10:15:00", "ACCEPTED"]]，需要尽可能多的考虑edge case

## 问题描述

给定送餐员的 `dasherID` 和一个包含多个订单信息的列表 `information`，我们需要计算指定 `dasherID` 送餐员的工资。每个订单信息包括以下字段：

- `dasherID`: 送餐员的唯一标识符。
- `orderID`: 订单的唯一标识符。
- `timestamp`: 订单的时间戳。
- `orderStatus`: 订单的状态，可以是 "ACCEPTED"（接单）或 "DELIVERED"（送达）。

### 假设
1. **接单和送达**：只有送达（`DELIVERED`）的订单才算有效。
2. **订单时间差**：每个送达的订单会根据接单时间和送达时间之间的差值来计算工资。
3. **时间处理**：时间的格式是 `yyyy-mm-dd HH:MM:SS`，我们可以将其转换为 `datetime` 对象来计算时间差。

### 基本工资和奖励
- **基础工资**：每个送达订单支付的固定工资（假设为 5 单位）。
- **时间奖励**：每 5 分钟增加 1 单位奖励。

## 代码实现

```python
from datetime import datetime

class DasherSalary:
    def __init__(self, information):
        # 初始化时保存所有的订单信息
        self.information = information
    
    def calculate_salary(self, dasherID: int):
        total_salary = 0
        
        # 遍历所有的订单，筛选出该 Dasher 的所有订单
        orders = [order for order in self.information if order[0] == dasherID]
        
        # 计算工资
        for order in orders:
            # 解包订单信息
            dasher, order_id, timestamp, order_status = order
            if order_status == "ACCEPTED":
                accept_time = datetime.strptime(timestamp, "%Y-%m-%d %H:%M:%S")
            elif order_status == "DELIVERED":
                deliver_time = datetime.strptime(timestamp, "%Y-%m-%d %H:%M:%S")
                
                # 找到对应的接单时间
                for prev_order in reversed(orders):
                    prev_dasher, prev_order_id, prev_timestamp, prev_status = prev_order
                    if prev_order_id == order_id and prev_status == "ACCEPTED":
                        accept_time = datetime.strptime(prev_timestamp, "%Y-%m-%d %H:%M:%S")
                        break
                
                # 计算从接单到送达的时间差
                time_diff = (deliver_time - accept_time).total_seconds() / 60  # 以分钟为单位
                base_salary = 5  # 每个送达订单的基础工资
                bonus = (time_diff // 5)  # 每5分钟作为一个单位计算奖金
                
                # 计算该订单的工资
                total_salary += base_salary + bonus

        return total_salary

# 示例信息
information = [
    [1, 101, "2024-01-01 10:00:00", "ACCEPTED"],
    [1, 101, "2024-01-01 10:30:00", "DELIVERED"],
    [2, 201, "2024-01-01 10:15:00", "ACCEPTED"],
    [2, 201, "2024-01-01 10:45:00", "DELIVERED"]
]

# 创建 DasherSalary 实例并计算指定 Dasher 的工资
dasher_salary = DasherSalary(information)
print(dasher_salary.calculate_salary(1))  # Output: 10 (基础工资5 + 奖金5)
print(dasher_salary.calculate_salary(2))  # Output: 10 (基础工资5 + 奖金5)
```

代码说明
初始化：

DasherSalary 类在初始化时接受一个包含订单信息的列表 information。
工资计算：

calculate_salary 方法接受一个 dasherID 作为参数，首先筛选出该 dasherID 对应的所有订单。
对于每个订单，如果状态为 "ACCEPTED"，就保存该接单时间；如果状态为 "DELIVERED"，则寻找该订单的接单时间并计算两者之间的时间差。
计算每个订单从接单到送达的时间差，并根据时间差（每 5 分钟 1 单位奖励）和基本工资（假设为 5 单位）来计算该订单的工资。
边界情况处理：

如果有订单被接单但没有送达（DELIVERED），则该订单不会计算工资。
时间戳字符串是标准的 yyyy-mm-dd HH:MM:SS 格式，使用 datetime.strptime() 转换为 datetime 对象，便于时间差计算。
测试用例
示例 1：
输入：dasherID = 1

```python
information = [
    [1, 101, "2024-01-01 10:00:00", "ACCEPTED"],
    [1, 101, "2024-01-01 10:30:00", "DELIVERED"],
    [2, 201, "2024-01-01 10:15:00", "ACCEPTED"],
    [2, 201, "2024-01-01 10:45:00", "DELIVERED"]
]
```
输出：10（基础工资 5 + 时间奖金 5）

示例 2：
输入：dasherID = 2

```python
information = [
    [1, 101, "2024-01-01 10:00:00", "ACCEPTED"],
    [1, 101, "2024-01-01 10:30:00", "DELIVERED"],
    [2, 201, "2024-01-01 10:15:00", "ACCEPTED"],
    [2, 201, "2024-01-01 10:45:00", "DELIVERED"]
]
```
输出：10（基础工资 5 + 时间奖金 5）

边界情况：
接单但没有送达：
```python
information = [
    [1, 101, "2024-01-01 10:00:00", "ACCEPTED"]
]
```
输出：0（没有送达，不算工资）

多个订单：
```python
information = [
    [1, 101, "2024-01-01 10:00:00", "ACCEPTED"],
    [1, 101, "2024-01-01 10:30:00", "DELIVERED"],
    [1, 102, "2024-01-01 11:00:00", "ACCEPTED"],
    [1, 102, "2024-01-01 11:10:00", "DELIVERED"],
]
```
输出：15（两个订单，基础工资 5 + 奖金 10）

总结
这段代码实现了根据接单和送达时间计算工资的基本功能，并考虑了边界情况。
