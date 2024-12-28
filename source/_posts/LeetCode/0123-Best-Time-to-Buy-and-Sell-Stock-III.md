---
title: 0123 Best Time to Buy and Sell Stock III
date: 2018-01-01 03:22:28
categories: LeetCode
tags:
---

Say you have an array for which the ith element is the price of a given stock on day i.

Design an algorithm to find the maximum profit. You may complete at most two transactions.

Note: You may not engage in multiple transactions at the same time (i.e., you must sell the stock before you buy again).

Example 1:

Input: [3,3,5,0,0,3,1,4]
Output: 6
Explanation: Buy on day 4 (price = 0) and sell on day 6 (price = 3), profit = 3-0 = 3.
             Then buy on day 7 (price = 1) and sell on day 8 (price = 4), profit = 4-1 = 3.
Example 2:

Input: [1,2,3,4,5]
Output: 4
Explanation: Buy on day 1 (price = 1) and sell on day 5 (price = 5), profit = 5-1 = 4.
             Note that you cannot buy on day 1, buy on day 2 and sell them later, as you are
             engaging multiple transactions at the same time. You must sell before buying again.
Example 3:

Input: [7,6,4,3,1]
Output: 0
Explanation: In this case, no transaction is done, i.e. max profit = 0.


最多可以买卖2次
```python
class Solution(object):
    def maxProfit(self, prices: List[int]) -> int:
        t1_cost, t2_cost = float("inf"), float("inf")
        t1_profit, t2_profit = 0, 0

        for price in prices:
            # the maximum profit if only one transaction is allowed
            # for first buy price ,the lower,the better
            t1_cost = min(t1_cost, price)
            # the profit left after first sell,the higher,the better
            t1_profit = max(t1_profit, price - t1_cost)

            # reinvest the gained profit in the second transaction
            # the cost of second buy ,the lower,the better 
            t2_cost = min(t2_cost, price - t1_profit)
            # afterSecondSell will be the max profit ultimately
            t2_profit = max(t2_profit, price - t2_cost)

        return t2_profit
```

```python
def maxProfit(prices):
    # Initialize variables for tracking the best outcomes
    first_buy = float('inf')  # for first buy price, the lower, the better
    after_first_sell = 0  # the profit after first sell, the higher, the better
    after_second_buy = float('-inf')  # the profit left after second buy, the higher, the better
    after_second_sell = 0  # the profit left after second sell, the higher, the better

    for cur_price in prices:
        first_buy = min(first_buy, cur_price)  # for first buy price, the lower, the better
        after_first_sell = max(after_first_sell, cur_price - first_buy)  # the profit after first sell, the higher, the better
        after_second_buy = max(after_second_buy, after_first_sell - cur_price)  # the profit left after second buy, the higher, the better
        after_second_sell = max(after_second_sell, after_second_buy + cur_price)  # the profit left after second sell, the higher, the better

    return after_second_sell  # after_second_sell will be the max profit ultimately

# Example usage
prices = [3, 3, 5, 0, 0, 3, 1, 4]
print(maxProfit(prices))  # Output: 6
```


```python
class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        if not prices:
            return 0

        after_first_buy_profit = float('-inf')
        after_first_sell_profit = 0
        after_second_buy_profit = float('-inf')
        after_second_sell_profit = 0

        for price in prices:
            ## buy 要花钱，所以是profit 是 - price
            after_first_buy_profit = max(after_first_buy_profit, -price)  # Maximize the profit after the first buy
            after_first_sell_profit = max(after_first_sell_profit, price + after_first_buy_profit)  # Maximize profit after first sell
            after_second_buy_profit = max(after_second_buy_profit, after_first_sell_profit - price)  # Maximize the effective cost of the second buy
            after_second_sell_profit = max(after_second_sell_profit, after_second_buy_profit + price)  # Maximize profit after second sell

        return after_second_sell_profit
        
```

