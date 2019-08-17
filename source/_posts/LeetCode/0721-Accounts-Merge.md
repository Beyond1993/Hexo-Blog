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
