---
title: Citadel
date: 2020-09-04 12:01:17
categories: Interview
tags:
---


```java
public static List<Integer> get(List<List<Integer>> bids, int totalShare) {
		Map<Integer, Integer> origin = new HashMap<>();
		Map<Integer, List<List<Integer> > > priceBidsMap = new HashMap<>();
		List<Integer> prices = new ArrayList<>();
		
        for (List<Integer> bid : bids) {
            priceBidsMap.put(bid.get(2), new ArrayList());
        }
        
		for (List<Integer> bid : bids) {
			origin.put(bid.get(0), bid.get(1));
			priceBidsMap.get(bid.get(2)).add(bid);
			prices.add(bid.get(2));
		}
        
        for (Integer price : prices) {
            List<List<Integer>> tmp = priceBidsMap.get(price);
            Collections.sort(tmp, (a,b) -> a.get(3) - b.get(3));
            priceBidsMap.put(price, tmp);
        }
		
		Collections.sort(prices, Collections.reverseOrder());
		
		for (Integer price : prices) {
			if (totalShare == 0) {
				break;
			}
			List<List<Integer>> curBids = priceBidsMap.get(price);
			if (curBids.size() == 1) {
				List<Integer> curBid = curBids.get(0);
				int allot = curBid.get(1) < totalShare ? curBid.get(1) : totalShare;
				curBid.set(1, curBid.get(1) - 1);
				totalShare -= allot;
			} else {
                
				while(totalShare > 0) {
                    int count = 0;
					for(List<Integer> bid : curBids) {
						if (totalShare == 0) break;
						if (bid.get(1) == 0) {
							count++;
							continue;
						}
						bid.set(1, bid.get(1) - 1);
						totalShare -= 1;
					}
                    System.out.println(count + " " + curBids.size());
					if (count == curBids.size()) break;
				}
			}
		}
		
		List<Integer> res = new ArrayList<>();
		for (List<Integer> bid : bids) {
			if (bid.get(1) == origin.get(bid.get(0))) {
				res.add(bid.get(0));
			}
		}
		return res;
	}
}

```


```java
public static int[][] findBeforeMatrix(int[][] after) {
       int R = after.length;
       int C = after[0].length;

       for (int i = 0; i < R; i++) {
           for (int j = C - 1; j >= 1; j--) {
               after[i][j] -= after[i][j - 1];
           }
       }

       for (int i = R - 1; i >= 1; i--) {
           for (int j = 0; j < C; j++) {
               after[i][j] -= after[i - 1][j];
           }
       }

       return after;
}
```


```java
package com.example.demo.controller;

import java.util.HashMap;
import java.util.Map;

public class ThrottlingGateWay {
    public static final int MAX_PER_SECOND = 3;
    public static final int MAX_TEN_SECONDS = 20;
    public static final int MAX_PER_MINUTE = 60;

    public static void main(String[] args) {
        int[] requestTime1 = new int[] {1,1,1,1,2,2,2,3,3,3,4,4,4,11,11,11,6,6,6,5,5,5};
        int[] requestTime2 = new int[] {1,1,1,1,2,2,2,3,3,3,4,4,4,11,11,11,11,6,6,6,5,5,5,7,7,7,7};
        ThrottlingGateWay gateWay = new ThrottlingGateWay();
        System.out.println(gateWay.droppedRequests(requestTime1));
    }

    private int droppedRequests(int[] requestTime) {
        if (requestTime == null || requestTime.length == 0) {
            return 0;
        }
        int drop = 0;
        Map<Integer, Integer> map = new HashMap<>();
        int lastReqTime = 0;
        for (int r : requestTime) {
            map.put(r, map.getOrDefault(r, 0) + 1);
            lastReqTime = Math.max(lastReqTime, r);
        }

        int[] presum = new int[lastReqTime + 1];
        for (int i = 1; i < presum.length; ++ i) {
            int numReqThisSecond = map.getOrDefault(i, 0);
            presum[i] = presum[i - 1]+ numReqThisSecond;
            if (numReqThisSecond == 0) {
                continue;
            }

            int toDrop = 0;
            if (numReqThisSecond > MAX_PER_SECOND) {
                toDrop = Math.max(toDrop, numReqThisSecond - MAX_PER_SECOND);
            }

            int timeTenSecondsAgo = Math.max(i - 10, 0);
            int numReqPastTenSecond = presum[i] - presum[timeTenSecondsAgo];
            if (numReqPastTenSecond > MAX_TEN_SECONDS) {
                int numReqExceed = Math.min(numReqThisSecond, numReqPastTenSecond - MAX_TEN_SECONDS);
                toDrop = Math.max(toDrop, numReqExceed);
            }

            int timeOneMinuteAgo = Math.max(i - 60, 0);
            int numReqPastMinute = presum[i] - presum[timeOneMinuteAgo];
            if (numReqPastMinute > MAX_PER_MINUTE) {
                int numReqExceed = Math.min(numReqThisSecond, numReqPastMinute - MAX_PER_MINUTE);
                toDrop = Math.max(toDrop, numReqExceed);
            }
            drop += toDrop;
        }

        return drop;
    }
}
```
