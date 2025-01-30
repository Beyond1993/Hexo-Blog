---
title: Amazon-SDE-II-OA-WarehouseCapacity
date: 2024-06-23 05:19:19
categories: Interview
tags:
---

OA for Amazon SDE 2 position and below is one of the questions that I got.
can anyone help me with the solution for this please?


Question)
In Amazon's highly efficient logistics network, minimizing operational overhead and optimizing package routing is crucial to ensure smooth deliveries across various regions.


The network consists of n warehouses, numbered from 1 to n, each strategically positioned at its corresponding index. Each warehouse has a specific storage capacity, given by warehouseCapacity, where warehouse Capacity[i] represents the capacity of the warehouse located at position/(assuming 1-based indexing).


These warehouses are organized in a non-decreasing order of their storage capacities, meaning each warehouse's storage capacity is greater than or equal to the one before it. Each warehouse must establish a connection to a distribution hub positioned at a location greater than or equal to its own. This means that a warehouse at position/can only connect to a hub at position j, where j >= i


To optimize inventory routing, Amazon has placed a central high-capacity distribution hub at the last warehouse, located at position n. This hub serves as the main connection point for all warehouses if necessary. The cost of establishing a connection from warehouse at i to a hub at position j is given by warehouseCapacity[j] - warehouseCapacity[i].


Given a queries of the form (hubA, hubB), where two additional high-performance distribution hubs are deployed at warehouses hubA and hubB (1 ≤ hubA < hubB <n), the goal is to calculate the minimum total connection cost for all warehouses, considering the nearest available. distribution hub at or beyond each warehouse's position.


Note:


The problem statement assumes 1-based indexing for the warehouseCapacity array.


•⁠ ⁠Each query is independent, i.e., the changes made do not persist for subsequent queries.


Each warehouse connects to the nearest hub at or beyond its position (either huba, hubB, or the central hub at n) to minimize the overall connection cost.


Example


n=5


warehouseCapacity [3, 6, 10, 15, 20]


q=1


additionalHubs = [[2, 4]]


In this case there is q = 1 query with two additional high-performance distribution hubs at position hubA = 2 and hubB = 4.


Once additional distribution hubs are installed at positions hubA = 2 and hubB = 4:


•⁠ ⁠1st warehouse will connect to the nearest available distribution hub at position 2, cost incurred 6-3=3


2nd warehouse is itself a distribution hub, so cost incurred = 0


•⁠ ⁠3rd warehouse will connect to the nearest available distribution hub at position 4, cost incurred =15-10=5


•⁠ ⁠4th and 5th warehouses are itself a distribution hub, so cost incurred = 0+0=0


Thus, the total connection cost (6-3)+(0)+(15-10)+(0)+(0)=8. Hence, return [8] as the answer.


Function Description


Complete the function getMinConnectionCost in the editor below.


getMinConnectionCost has the following parameters:


int warehouseCapacity[n]: a non-decreasing array of integers representing the storage capacities of the warehouses


int additional Hubs[q][2]: an array where each element denotes the positions of two additional distribution hubs installed for a query


Returns


long int[q]: the answers for each query


Input format for custom testing


The first line contains an integer, n, the number of elements in warehouseCapacity.


Each line/of the n subsequent lines (where 0 <=(<n) contains an integer, warehouseCapacity[i].


The next line contains an integer, q, the number of rows in additional Hubs.


The next line contains an integer, 2, the number of columns in additional Hubs.


Each line of the q subsequent lines (where 0 <= i < n) contains 2 space-separated integers, additional Hubs[i][0] and additional Hubs[i][1].


Sample Case 0


Sample Input For Custom Testing


STDIN FUNCTION


6 -> warehouseCapacity[] size n = 6


0 -> warehouseCapacity = [8, 2, 5, 9, 12, 18]


2


5


9


12


18


2 -> number of queries q = 2


2 -> number of columns = 2


2 5 -> additional Hubs [ [2, 5] , [1, 3] ]


1 3


Sample Output


12


18


Explanation


In this case we have n = 6, warehouseCapacity = [0, 2, 5, 9, 12, 18), q = 2, additionalHubs = [[2, 5], [1, 3]].


Since we have initially 1 central hub at position n. So total connection cost = (18-0)+(18-2)+ (18-5)+(18-9)+(18-12)+(18-18) = 62.


•⁠ ⁠In first query, we build 2 additional distribution hubs at positions 2 and 12. Now:


1st warehouse will connect to the nearest available distribution hub at position 2, cost


incurred = 2-0=2


•⁠ ⁠2nd warehouse is itself a distribution hub, so cost incurred = 0


3rd warehouse will connect to the nearest available distribution hub at position 5, cost incurred = 12-5=7


•⁠ ⁠4th warehouse will connect to the nearest available distribution hub at position 5, cost incurred 12-9=3


5th warehouse is itself a distribution hub, so cost incurred = 0


6th warehouse is itself a distribution hub, so cost incurred = 0


Thus, the total connection cost=2+0+7+3+0+0=12.


In second query, we build 2 additional distribution hubs at positions 1 and 3. Now:


1st warehouse is itself a distribution hub, so cost incurred = 0


2nd warehouse will connect to the nearest available distribution hub at position 3, cost incurred = 5-2=3


3rd warehouse is itself a distribution hub, so cost incurred = 0


4th warehouse will connect to the nearest available distribution hub at position 6, cost incurred = 18-9 =9


5th warehouse will connect to the nearest available distribution hub at position 6, cost incurred = 18-12 = 6


6th warehouse is itself a distribution hub, so cost incurred = 0


Thus, the total connection cost-0+3+0+9+6+0-18.


Thus, the answer is [12, 18].


Sample Input 2 For Custom Testing


STDIN Function


4 -> warehouseCapacity[] size n=4


2 -> warehouseCapacity [2, 6, 8, 14]


6


8


14


1 -> number of queries q = 1


2 -> number of columns


1 2 -> additionalHubs c * [[1, 2]]


Sample Output


6


Explanation


In this case we have n = 4 warehouseCapacity =[ 2, 6 , 8, 14], q = 1 additionalHubs = [[1, 2]]


Initially, there is 1 distribution hub at warehouse number . So distance travelled is (14-2) + (14-6) + (14 - 8) + (14 - 14) = 26 . com (14 - 2) +(14-


In the first query, we build 2 additional distribution hubs at positions 1 and 2. Now:


1st warehouse is itself a distribution hub, so cost incurred = 0


2nd warehouse is itself a distribution hub, so cost incurred = 0


3rd warehouse will connect to the nearest available distribution hub at position 4, cost


incurred-14-8-6


4th warehouse is itself a distribution hub, so cost incurred = 0


Thus, the total connection cost 0 + 0 + 6 + 0 = 6


Thus, the answer is [6].

```python
def getMinConnectionCost(warehouseCapacity, hubs):
    n = len(warehouseCapacity)
    prefix = [0] * n
    total_sum = 0
    
    # Compute the prefix sum array
    for i in range(n):
        total_sum += warehouseCapacity[i]
        prefix[i] = total_sum
    
    # List to store the results of each query
    ans = []
    
    # Process each query
    for hub in hubs:
        hubA, hubB = sorted(hub)  # Sort the hubs (since only two hubs per query)
        ans.append(computeCost(warehouseCapacity, prefix, hubA, hubB, n))
    
    return ans

def computeCost(warehouseCapacity, prefix, hubA, hubB, n):
    res = 0
    
    # Cost from warehouse 1 to warehouse hubA-1
    if hubA >= 2:
        res += ((hubA - 1) * warehouseCapacity[hubA - 1]) - prefix[hubA - 2]
    
    # Cost from warehouse hubA to hubB
    if hubA != hubB and hubB >= 2:
        res += ((hubB - hubA - 1) * warehouseCapacity[hubB - 1]) - (prefix[hubB - 2] - prefix[hubA - 1])
    
    # Cost from warehouse hubB to the last warehouse n
    if hubB != n:
        res += ((n - hubB - 1) * warehouseCapacity[n - 1]) - (prefix[n - 2] - prefix[hubB - 1])
    
    return res

# Example usage
warehouseCapacity = [8, 2, 5, 9, 12, 18]
hubs = [[2, 5], [1, 3]]

result = getMinConnectionCost(warehouseCapacity, hubs)
print(result)  # Output: [12, 18]
```
