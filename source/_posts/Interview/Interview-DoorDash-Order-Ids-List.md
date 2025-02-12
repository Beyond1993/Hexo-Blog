---
title: DoorDash-Order-Ids-List
date: 2025-02-12 12:38:54
categories: Interview
tags:
---

给一个order_ids list, 要求每次找到eligible的数并且返回最小的那个数（可以想象成这个数在原数组里就不存在了）。eligible的条件是，这个数必须比左右两边的数都大。
ex.
input: order_list = ‍‌‌‌‍‌‌‍‌‍‍‌‍‍‍‍‍‍‌‌‌[3,5,1,4,2]
output: [4,2,5,3,1]
第一次遍历，满足条件的数是5,4，返回4
第二次遍历，满足条件的数是5,2，返回2
第三次遍历，满足条件的数是5，返回5，
第四次遍历，满足条件的数是3，返回3
最后返回1。
这道题的难点是要如何记录每个数邻点，因为一旦找到一个满足条件的最小数，它左右两个点的eligibility就有可能变化，我们需要再次判断。
一开始给了O(n^2)的时间复杂度，就像上面一样遍历。面试官要求用更小的时间复杂度。我提出可以用heap存eligible num，面试官同意。后面在他的提示下（这段交流花了过多时间），用map存每个点的邻点。
遍历完一边数组后，得到一个起始的heap=[4,5]。当把4从heap中pop出来以后，对map进行更新，把4从map中移走，4的邻点相连，然后再判断两个邻点的eligibilty 看是否需要加进heap。以此类推。

```python
import heapq

def find_eligible_numbers(order_list):
    n = len(order_list)
    result = []
    heap = []
    index_map = {i: order_list[i] for i in range(n)}  # Mapping index to value

    # Function to check if a number is eligible
    def is_eligible(index):
        if index < 0 or index >= len(order_list):
            return False
        left = order_list[index - 1] if index - 1 >= 0 else float('-inf')
        right = order_list[index + 1] if index + 1 < len(order_list) else float('-inf')
        return order_list[index] > left and order_list[index] > right

    # Initially add all eligible elements into the min-heap
    for i in range(n):
        if is_eligible(i):
            heapq.heappush(heap, (order_list[i], i))  # Use (value, index) for handling duplicates

    # To keep track of processed elements
    processed = set()

    while heap:
        min_val, index = heapq.heappop(heap)  # Pop the smallest eligible value
        if index in processed:  # Skip if already processed
            continue
        result.append(min_val)
        processed.add(index)
        order_list[index] = float('-inf')  # Mark as removed

        # Check the neighbors if they become eligible
        for neighbor in [index - 1, index + 1]:
            if 0 <= neighbor < n and is_eligible(neighbor):
                heapq.heappush(heap, (order_list[neighbor], neighbor))

    return result

# Example usage
order_list = [3, 5, 1, 5, 1, 4, 2]
print(find_eligible_numbers(order_list))  # Expected output: [4, 2, 5, 5, 3, 1, 1]

```
