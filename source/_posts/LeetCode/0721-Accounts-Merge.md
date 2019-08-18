---
title: 0721 Accounts Merge
date: 2019-08-17 22:08:21
categories: LeetCode
tags:
---


```java
class Solution {
public:
    vector<vector<string>> accountsMerge(vector<vector<string>>& accounts) {
        vector<vector<string>> res;
        if (accounts.empty()) return res;
        int n = accounts.size();
        map<string, vector<int>> map;
        set<int> set;
        for (int i = 0; i < n; i++) {
            for (int j = 1; j <accounts[i].size(); j++) {
                map[accounts[i][j]].push_back(i);
            }
        }
        
        auto cmp = [](std::pair<string, vector<int>> & a, std::pair<string, vector<int>> & b) 
        {
            return a.second.size() > b.second.size();  
        };
        std::vector<std::pair<string, vector<int>> > pairs;
        for (auto itr = map.begin(); itr != map.end(); ++itr)
              pairs.push_back(*itr);
        sort(pairs.begin(), pairs.end(), cmp);
        
        for (auto m : pairs) {
            vector<string> temp;
            string name = "";
            for (auto i : m.second) {
                if (name == "") {
                    name = accounts[i][0];
                }
                
                if (set.find(i) != set.end()) {
                    continue;
                }
                
                set.insert(i);
                temp.insert(temp.begin(), accounts[i].begin() + 1, accounts[i].end());
            }
            
            if (!temp.empty()) {
                unique(temp.begin(), temp.end());
                for (auto a : temp) {
                    cout << a << endl;
                }
                sort(temp.begin(), temp.end());
            
                temp.insert(temp.begin(), name);
                res.push_back(temp);
            }
        }
        return res;
     }
};
```


```java

class Solution {
    
    public List<List<String>> accountsMerge(List<List<String>> accounts) {
        UnionFind uf = new UnionFind();
        Map<String, String> emailToName = new HashMap<>();
        Map<String, Integer> emailToID = new HashMap<>();
        int id = 0;
        for (List<String> account: accounts) {
            String name = "";
            for (String email : account) {
                if (name == "") {
                    name = email;
                    continue;
                }
                
                emailToName.put(email, name);
                if (!emailToID.containsKey(email)) {
                    emailToID.put(email, id++);
                }
                // 以第一个 email 为root, union  
                uf.union(emailToID.get(account.get(1)), emailToID.get(email));
            }
        }
        
        Map<Integer, List<String>> res = new HashMap<>();
        
        // 找到相同的 ID 的 component 放到一起
        for (String email : emailToName.keySet()) {
            int index = uf.find(emailToID.get(email));
            res.computeIfAbsent(index, x -> new ArrayList()).add(email);
        }
        
        // 给这个 component 加上 Name
        for (List<String> component: res.values()) {
            Collections.sort(component);
            component.add(0, emailToName.get(component.get(0)));
        }
        
        return new ArrayList(res.values());
    }
    
    class UnionFind {
        int[] father;
        public UnionFind() {
            father = new int[10001];
            for (int i = 0; i <= 10000; i++) {
                father[i] = i;
            }
        }
            
        public int find(int x) {
            if (father[x] == x) return x;
            return find(father[x]);
        }

        public void union(int x, int y) {
            father[find(x)] = find(y);
        }
        
    }
}
```
