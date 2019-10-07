---
title: 0952 Largest Component Size by Common Factor
date: 2019-10-07 01:56:02
categories: LeetCode
tags:
---


Input: [2,3,6,7,4,12,21,39]
Output: 8

这个case 过不了

```java
class Solution {
    Map<Integer, Integer> father = new HashMap<>();
    Map<Integer, Integer> count = new HashMap<>();
    
    public int largestComponentSize(int[] A) {
        Arrays.sort(A);
        int max = 1;
        for (int i = 0; i < A.length; i++) {
            father.put(A[i], A[i]);
        }
        
        for (int i = 0; i < A.length; i++) {
            for (int j = i + 1; j < A.length; j++) {
                if (gcd(A[i], A[j]) > 1) {
                    union(A[i], A[j]);
                }
            }
        }      
        for (Map.Entry<Integer, Integer> e : count.entrySet() ) {
            max = Math.max(e.getValue(), max);
        }        
        return max;
    }
    
    public void union(int a, int b) 
    {
        int father_a = find(a);
        int father_b = find(b);
        
        if (father_a == father_b) {
            return;
        }
        
        father.put(father_b, father_a);
        count.put(father_a, count.getOrDefault(father_a, 1) + 1);   
    }
    
    public int find(int a) {
        if (father.get(a) == a) {
            return a;
        }
        father.put(a, find(father.get(a)));
        return father.get(a);
    }
    
    public int gcd(int a, int b) {
        return b == 0 ? a : gcd(b, a % b);
    }
}
```



```java
class Solution {
    public int largestComponentSize(int[] A) {
        int N = A.length;

        // factored[i] = a list of unique prime factors of A[i]
        ArrayList<Integer>[] factored = new ArrayList[N];
        for (int i = 0; i < N; ++i) {
            factored[i] = new ArrayList<Integer>();
            int d = 2, x = A[i];
            while (d * d <= x) {
                if (x % d == 0) {
                    while (x % d == 0)
                        x /= d;
                    factored[i].add(d);
                }

                d++;
            }

            if (x > 1 || factored[i].isEmpty())
                factored[i].add(x);
        }

        // primesL : a list of all primes that occur in factored
        Set<Integer> primes = new HashSet();
        for (List<Integer> facs: factored)
            for (int x: facs)
                primes.add(x);

        int[] primesL = new int[primes.size()];
        int t = 0;
        for (int x: primes)
            primesL[t++] = x;

        // primeToIndex.get(v) == i  iff  primes[i] = v
        Map<Integer, Integer> primeToIndex = new HashMap();
        for (int i = 0; i < primesL.length; ++i)
            primeToIndex.put(primesL[i], i);

        DSU dsu = new DSU(primesL.length);
        for (List<Integer> facs: factored)
            for (int x: facs)
                dsu.union(primeToIndex.get(facs.get(0)), primeToIndex.get(x));

        int[] count = new int[primesL.length];
        for (List<Integer> facs: factored)
            count[dsu.find(primeToIndex.get(facs.get(0)))]++;

        int ans = 0;
        for (int x: count)
            if (x > ans)
                ans = x;
        return ans;
    }
}

class DSU {
    int[] parent;
    public DSU(int N) {
        parent = new int[N];
        for (int i = 0; i < N; ++i)
            parent[i] = i;
    }
    public int find(int x) {
        if (parent[x] != x) parent[x] = find(parent[x]);
        return parent[x];
    }
    public void union(int x, int y) {
        parent[find(x)] = find(y);
    }
}
```


