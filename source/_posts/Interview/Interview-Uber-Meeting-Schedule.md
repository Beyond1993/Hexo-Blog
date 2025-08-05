---
title: Meeting Scheduler
date: 2025-08-05 14:01:22
categories: Interview
tags:
---

📌 题目描述
给定多个会议室 [RoomA, RoomB, RoomC, ...]，实现一个调度系统，要求支持：

scheduleMeeting(start, end)

找到一个空闲的会议室，在 [start, end) 预订会议

返回会议室名称

如果所有会议室冲突，返回 None

cancelMeeting(roomName, start, end)（可选扩展）

取消该房间的会议

成功返回 True，否则 False

说明：

会议区间为半开区间 [start, end)，结束时间等于下一个会议的开始时间时不冲突

要求查找与插入尽量高效


📌 核心思路
类设计

MeetingRoom：管理单个房间的预约

Scheduler：管理所有房间调度

冲突检测

用 SortedList 存 (start, end)，按 start 排序

二分查找插入点

检查前一个区间是否结束晚于 start

检查后一个区间是否开始早于 end

数据结构

SortedList：支持 O(log M) 查找，O(log M + √M) 插入/删除

M = 一个房间的会议数

```python
from sortedcontainers import SortedList

class MeetingRoom:
    def __init__(self, name):
        self.name = name
        self.bookings = SortedList()  # [(start, end)]

    def isAvailable(self, start, end):
        i = self.bookings.bisect_right((start, end))
        # 检查前一个会议
        if i > 0 and self.bookings[i-1][1] > start:
            return False
        # 检查后一个会议
        if i < len(self.bookings) and self.bookings[i][0] < end:
            return False
        return True

    def book(self, start, end):
        self.bookings.add((start, end))

    def cancel(self, start, end):
        i = self.bookings.bisect_left((start, end))
        if i < len(self.bookings) and self.bookings[i] == (start, end):
            del self.bookings[i]  # O(log M + √M)
            return True
        return False


class Scheduler:
    def __init__(self, room_names):
        self.rooms = [MeetingRoom(name) for name in room_names]

    def scheduleMeeting(self, start, end):
        for room in self.rooms:
            if room.isAvailable(start, end):
                room.book(start, end)
                return room.name
        return None

    def cancelMeeting(self, room_name, start, end):
        for room in self.rooms:
            if room.name == room_name:
                return room.cancel(start, end)
        return False
```

