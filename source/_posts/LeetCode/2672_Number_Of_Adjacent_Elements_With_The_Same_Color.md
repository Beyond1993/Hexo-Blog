---
title: 2672 Number Of Adjacent Elements With The Same Color
date: 2025-05-03 07:09:42
categories: LeetCode
tags:
---

你有一个长度为 n 的数组，初始时所有元素都是 0（表示未染色）。现在你会依次执行一些操作（每个操作是一个 query），每个操作形如 [index, color]，表示将数组中下标为 index 的位置染成指定颜色 color。

每次操作后，统计并返回相邻两个元素颜色相同的对数（即 arr[i] == arr[i+1] 且不为 0）。

```python
class Solution:
    def colorTheArray(self, n: int, queries: List[List[int]]) -> List[int]:
        colors, count, result = [0] * n, 0, []

        for query in queries:
            index = query[0]
            color = query[1]
            cur_color = colors[index]

            left = index - 1
            right = index + 1

            if color == cur_color:
                result.append(count)
                continue

            if left >= 0:
                # 如果左边和当前颜色相等，说明是新形成的一对
                if colors[left] == color:
                    count += 1
                # 如果左边颜色和之前颜色相当，并且和新来的颜色不等，并且 cur_color 不是初始的0,
                elif colors[left] == cur_color and colors[left] != color and cur_color != 0:
                    count -= 1

            if right < n:
                # 如果右边和当前颜色相等，说明是新形成的一对
                if colors[right] == color:
                    count += 1
                # 如果右边颜色和之前颜色相当，并且和新来的颜色不等，并且 cur_color 不是初始的0,
                elif colors[right] == cur_color and colors[right] != color and cur_color != 0:
                    count -= 1

            # 别忘了更新颜色
            colors[index] = color
            result.append(count)

        return result
```

