---
title: 0721 Accounts Merge
date: 2019-08-17 22:08:21
categories: LeetCode
tags:
---

ccounts Merge
Solved
Medium
Topics
Companies
Hint
Given a list of accounts where each element accounts[i] is a list of strings, where the first element accounts[i][0] is a name, and the rest of the elements are emails representing emails of the account.

Now, we would like to merge these accounts. Two accounts definitely belong to the same person if there is some common email to both accounts. Note that even if two accounts have the same name, they may belong to different people as people could have the same name. A person can have any number of accounts initially, but all of their accounts definitely have the same name.

After merging the accounts, return the accounts in the following format: the first element of each account is the name, and the rest of the elements are emails in sorted order. The accounts themselves can be returned in any order.

 

Example 1:

Input: accounts = [["John","johnsmith@mail.com","john_newyork@mail.com"],["John","johnsmith@mail.com","john00@mail.com"],["Mary","mary@mail.com"],["John","johnnybravo@mail.com"]]
Output: [["John","john00@mail.com","john_newyork@mail.com","johnsmith@mail.com"],["Mary","mary@mail.com"],["John","johnnybravo@mail.com"]]
Explanation:
The first and second John's are the same person as they have the common email "johnsmith@mail.com".
The third John and Mary are different people as none of their email addresses are used by other accounts.
We could return these lists in any order, for example the answer [['Mary', 'mary@mail.com'], ['John', 'johnnybravo@mail.com'], 
['John', 'john00@mail.com', 'john_newyork@mail.com', 'johnsmith@mail.com']] would still be accepted.
Example 2:

Input: accounts = [["Gabe","Gabe0@m.co","Gabe3@m.co","Gabe1@m.co"],["Kevin","Kevin3@m.co","Kevin5@m.co","Kevin0@m.co"],["Ethan","Ethan5@m.co","Ethan4@m.co","Ethan0@m.co"],["Hanzo","Hanzo3@m.co","Hanzo1@m.co","Hanzo0@m.co"],["Fern","Fern5@m.co","Fern1@m.co","Fern0@m.co"]]
Output: [["Ethan","Ethan0@m.co","Ethan4@m.co","Ethan5@m.co"],["Gabe","Gabe0@m.co","Gabe1@m.co","Gabe3@m.co"],["Hanzo","Hanzo0@m.co","Hanzo1@m.co","Hanzo3@m.co"],["Kevin","Kevin0@m.co","Kevin3@m.co","Kevin5@m.co"],["Fern","Fern0@m.co","Fern1@m.co","Fern5@m.co"]]
 

Constraints:

1 <= accounts.length <= 1000
2 <= accounts[i].length <= 10
1 <= accounts[i][j].length <= 30
accounts[i][0] consists of English letters.
accounts[i][j] (for j > 0) is a valid email.


```python
class Solution:
    class UnionFind:
        def __init__(self, n):
            self.father = [i for i in range(n) ]
        
        def Find(self, index):
            if self.father[index] == index:
                return index
            self.father[index] = self.Find(self.father[index])
            return self.father[index]

        def Union(self, index1, index2):
            father1 = self.Find(index1)
            father2 = self.Find(index2)

            if father1 != father2:
                self.father[father1] = self.father[father2]

    def accountsMerge(self, accounts: List[List[str]]) -> List[List[str]]:
        emailMap = {}
        n = len(accounts)
        uf = self.UnionFind(len(accounts))       
            
        for i, account in enumerate(accounts):
            for email in account[1:]:
                if email not in emailMap:
                    emailMap[email] = [i]
                else:
                    emailMap[email].append(i)           
        
        for email, value in emailMap.items():
            for i in range(1, len(value)):
                uf.Union(value[i-1], value[i])
        
        emails = [set() for _ in range(n)]
        for i in range(n):
            index = uf.Find(i)
            for email in accounts[i][1:]:  # Skip the name, only add emails
                emails[index].add(email)

        # Step 4: Build the result list
        result = []
        seen_roots = set()  # Keep track of the roots we've already processed
        for i in range(n):
            root = uf.Find(i)
            if root not in seen_roots and emails[root]:
                seen_roots.add(root)
                merged_account = [accounts[i][0]] + sorted(emails[root])  # Name + sorted emails
                result.append(merged_account)

        return result
```



```c++
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
