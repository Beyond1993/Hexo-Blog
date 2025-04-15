---
title: DoorDash-Debug-Dash-Order
date: 2025-04-15 11:49:52
categories: Interview
tags:
---

https://www.1point3acres.com/bbs/thread-1119279-1-1.html

题目描述:

debugging：也是地里见过的面经分配dasher，期间可以run code 来debug
数据结构就是一个map<integer, Dasher> ， key是index， value是一个简单的dasher class, 每个dasher 有个id
初始化map的时候index是从0开始，每次加1，然后map的key都是连续的，比如最开始有5个dasher就是0,1,2,3,4
每次分配dasher的时候随机从这些dasher中选择一个，然后把这个dasher从map中删除。删除后仍然希望map的index是从0开始连续的。
比如[0,1,2,3,4] -> {3, dasher(3)} 被选中，剩下的map里是[0,1,2,4]  这个时候需要adjustmap，把map里最大的entry {4, dasher(4}} 先移除，然后重新加入到map里使它index为3, 这个entry变成 {3, dasher(4)}
这样map里的index还是从0开始连续递增的。
bug的问题就是在如何调整这个map使index连续，看出来之后写一遍逻辑就好了。
其他bug比如这个method not threadsafe，我说可给method加上synchronized ，然后call remoteRecordService的时候应该async， 如果这个remoteRecordService fail不应该block

```python
import random

class Dasher:
    def __init__(self, dasher_id):
        self.id = dasher_id

    def __repr__(self):
        return f"Dasher(id={self.id})"

class DasherManager:
    def __init__(self, dasher_list):
        self.dashers = {i: dasher for i, dasher in enumerate(dasher_list)}

    def remove_random_dasher(self):
        if not self.dashers:
            return None

        # 随机选择一个 index
        indices = list(self.dashers.keys())
        rand_idx = random.choice(indices)

        removed = self.dashers[rand_idx]
        del self.dashers[rand_idx]

        last_idx = len(self.dashers)  # 注意，已经删除了一个
        if rand_idx != last_idx:
            # 把最后一个移动到 rand_idx 的位置
            last_dasher = self.dashers[last_idx]
            del self.dashers[last_idx]
            self.dashers[rand_idx] = last_dasher

        return removed

    def add_dasher(self, dasher):
        self.dashers[len(self.dashers)] = dasher

    def get_dashers(self):
        return dict(sorted(self.dashers.items()))

# 示例用法
if __name__ == "__main__":
    initial_dashers = [Dasher(i) for i in range(5)]
    manager = DasherManager(initial_dashers)

    print("Initial:", manager.get_dashers())
    removed = manager.remove_random_dasher()
    print("Removed:", removed)
    print("After Removal:", manager.get_dashers())

    manager.add_dasher(Dasher(99))
    print("After Adding New Dasher:", manager.get_dashers())
```

