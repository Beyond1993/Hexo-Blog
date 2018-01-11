---
title: Interview-Rubrik
date: 2018-01-09 23:10:19
categories: Interview
tags:
---

1 . paths Number
首先是给定一个M x N grid，求从左下角走到右下角有多少种可能的路径。
限 制:只可以走三个方向 right, diagonally right up, diagonally right down 

Follow up，现在给定额外参数h，求问高度超过h的路径有多少?某条路径的高 度为其最高点。
```cpp
class Solution { 

  public:
    int numberOfPaths (int m, int n) { 
      vector<vector<int>> dp(m, vector<int>(n,0)); 
      int i = 0;
      while (i < m && i < n) {
        dp[i][i] = 1;
        i++; 
      }
      for (int i = 1; i < n; i++) { 
        int j = 0, k = i;
        while (k < n && j < m) {
          int d1 = 0, d2 = 0, d3 = 0;
          d1 = dp[j][k-1];
          if (j > 0) d2 = dp[j-1][k-1]; 
          if (j < m - 1) d3 = dp[j+1][k-1]; 
          dp[j][k] = d1 + d2 + d3;
          k++; 
          j++; 
        }
      }
      return dp[0][n - 1]; 
    }
};

int main() { 
  Solution sl;
  int res = sl.numberOfPaths(3,4); 
  int res1 = sl.numberOfPaths(1,4); 
  cout<<res - res1<<endl;
}
```
2. Leetcode2 Add two numbers:

```cpp
class Solution { 
public: 
  ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) { 
    ListNode* dummy = new ListNode(0), *p = dummy; int carry = 0;
    while(l1 || l2 || carry) {
      int sum = 0;
      if (l1) { 
        sum += l1->val; l1 = l1->next;
      } 
      if (l2) {
        sum += l2->val; l2 = l2->next;} sum += carry;
        carry = sum/10;
        p->next = new ListNode(sum%10); 
        p = p->next;
    }
    return dummy->next; 
  }
};
```
3. leetcode7:Palindrome Number
```cpp
class Solution { 
public:
  bool isPalindrome(int x) {
  if (x < 0 || (x != 0) && (x%10 == 0)) return false; 
    int res = 0;
    while (res < x) {
      res = res*10 + x%10;
      x /= 10; 
    }
    return (x == res)||(res/10 == x); 
  }
};
follow up: at least k elements
```
4. leetcode:53 Maximum Subarray
follow up: at least k elements

```cpp
class Solution { 
public:
  int maxSubArray(vector<int>& nums) {
    if (nums.empty()) return 0;
    int curSum = nums[0], maxSum = nums[0]; 
    for (int i = 1; i < nums.size(); i++) {
      curSum = max(curSum + nums[i], nums[i]);
      maxSum = max(curSum, maxSum); 
    }
    return maxSum; 
}
//follow up, at least k element in the subArray 

int maxSubArray(vector<int>& nums, int k) {
  if (nums.empty()) return 0;
  int prefix = 0;
  for(int i = 0; i < k - 1; i++) prefix += nums[i]; 
  int curSum = prefix, maxSum = prefix;
  for (int i = k - 1; i < nums.size(); i++) {
    curSum = max(prefix + nums[i], curSum + nums[i]); 
    maxSum = max(curSum, maxSum);
    prefix = prefix - nums[i - k + 1] + nums[i]; 
  }
  return maxSum; 
  }
};
int main() {
  vector<int> nums{-4, -2, 1, -3}; 
  Solution sl;
  int res = sl.maxSubArray(nums, 2); 
  cout<< res<<endl;
  return 0;
}
```

5. leetcode 7. Reverse Integer
```cpp
class Solution {
public:
  int reverse(int x) {
    long long res = 0; int sign = 1;
    if (x < 0) {
      x = -x;
      sign = -1; 
    }
    while (x > 0) {
      res = res*10 + x%10;
      x /= 10;
      if (res > INT_MAX) 
        return 0;
      }
   return sign*res; 
  }
};
```
8. Clone list
```cpp
struct ListNode{ int val;
ListNode* next, *random;
ListNode(int x):val(x), next(NULL), random(NULL){} };
class Solution { public:
ListNode *cloneLinkList(ListNode* node) { 
unordered_map<int, ListNode*> m;
return clone(node, m); 
}
ListNode* clone(ListNode* node, unordered_map<int, ListNode*> &m) { if (!node) return NULL;
if (m.count(node->val)) return m[node->val];
m[node->val] = newNode;
if(node->next) newNode->next = clone(node->next, m); if(node->random) newNode->random = clone(node->random, m);
ListNode *newNode = new ListNode(node->val);

ListNode* clone(ListNode* node, unordered_map<int, ListNode*> &m) { ListNode *newNode = new ListNode(node->val);
if (!node) return NULL;
if (m.count(node->val)) return m[node->val];
 m[node->val] = newNode;
if(node->next) newNode->next = clone(node->next, m); if(node->random) newNode->random = clone(node->random, m); return newNode;
} };
int main() {
Solution sl;
ListNode *n1 = new ListNode(0);
ListNode *n2 = new ListNode(1);
ListNode *n3 = new ListNode(2);
n1->next = n2;
n1->random = n3;
n2->next = n3;
n2->random = n1;
n3->next = n1;
n3->random = n2;
ListNode *res = sl.cloneLinkList(n1);
cout<< "node1's val = " << res->val<< "node->next "<<res->next->val<< "node->
random"<< res->random->val<<endl;
return 0; }
```
9. Next Permutation


10. 我应该只写出了第一问，然后就被follow up打趴了。要求实现一个 threadpool，每个队列存储的是thread并且有自己的weight. 第一问是写一个method， 根据每个weight，return random index。 比如有2 个queue, weight是[1， 2], 那么就是1/3的概率return 0, 2/3的概率return 1.

11. Design and implement key value system
//
// string -> string
// Insert a key-value pair or modify a value
void put(string key, string value);
// Delete a key-value pair void delete(string key);
// Gets a value given a snapshot string get(string key, Snapshot snap);
// Take a snapshot Snapshot takeSnapshot();
// Delete a snapshot
void deleteSnapshot(Snapshot snap);
// put(k1,v1)
// put(k2,v2)
// put(k3,v3).
// takeSnapshot -> snap1 { k1 -> v1, k2 -> v2, k3 -> v3 }
// get(k1,snap1) -> v1
// put(k1,v4)
// delete(k3)
// takeSnapshot -> snap2 { k1 -> v4, k2 -> v2 } // get(k1,snap2) -> v4
// get(k1,snap1) -> v1
// get(k3,snap2) -> XX
 // deleteSnapshot(snap1)
// get(k1,snap1) -> XX. 

// get(k1,snap1) -> v1 // get(k3,snap2) -> XX
// deleteSnapshot(snap1)
// get(k1,snap1) -> XX. from: 1point3acres.com/bbs
// Space efficient > time efficient
key -> value
key {snap_id, _new_value} */

```cpp
class SnapShot { 
public:
  int id;
  SnapShot(int val): id(val){} 
};
class Solution { 
  public:
    void put(string key, string value) {
      temp[key] = value; 
    }
    void delete1(string key) { 
      temp.erase(key);
      snap.erase(key); 
    }
    SnapShot* takeSnapShot () {
    SnapShot *res = new SnapShot(count); 
    count++;
    return res;
  }

  string get(string key, SnapShot* snapShot) {
    if (!snap[key].count(snapShot->id)) return "XX";
      return snap[key][snapShot->id]; 
    }

  void deleteSnapshot(SnapShot* snapShot) { 
    int id1 = snapShot->id;
    for (auto a: snap) {
      if(a.second.count(id1)) a.second.erase(id1); }
      return; 
    }
  private:
    unordered_map<string,string> temp; // present key and value. // Key,snapID, Value
    unordered_map<string, unordered_map<int,string>> snap;
    int count;
};
int main (){
  return 0; 
}
```

电面总结:
20分钟讲背景，一直challenge 我的背景不符合， why rubrik，为什么测试岗，中 途信号不好，两次断掉，recruiter忘了给发codepad链接，向面试官问问题化解尴 尬与等待时间
20分钟后开始做题
第一题
1 23 456
 // 'abcd....z'
// 'cdef....b'

1
23 456
 // 'abcd....z'
// 'cdef....b'
// 'abc' -> 'cde' // 'aby' -> 'cda' //
// Implement a function that takes in two arguments. The first argument is going to be an unecrypted string
// consisting only of the characters 'a'->'z'. The second argument is going to be an arbitrary string..
//
// Return whether the second argument could be a shift cipher encrypted version of the unencrypted string.. more info on 1point3acres.com
// e.g. ('abc', 'cde') : true
// ('aby', 'cda') : true
// ('abc', 'cdf') : false
class Solution { public:
bool encrypt(string a, string b) {
if (a.size() != b.size()) return false;
unordered_map <char,int> m;
int k = 0;
for (char i = 'a'; i <= 'z'; i++) m[i] = k++;
int dist = (a[0] >= b[0])? (a[0] - b[0]):(a[0] + 26 -
b[0]);
for (int i = 1; i < a.size(); i++) {
26 - b[i]);
int tmp = (a[i] >= b[i])? (a[i] - b[i]):(a[i] +
if (tmp != dist) return false; }
return true; }
};
int main() { Solution sl;
bool res = sl.encrypt("abc", "cdf");
}
cout<<res<<endl;

int main() { cout<<res<<endl;
Solution sl;
bool res = sl.encrypt("abc", "cdf");
 } 2.
// you have a list of boxes, they have different height, width, length. They're not rotatable. You want to find the tallest stack you can build with that list of boxes. You don't have to use all of the boxes. You can only stack smaller boxes (width AND length have to be smaller) on top of bigger boxes.
class Solution { public:
int height(vector<vector<int>> &boxes) { int n = (int)boxes.size();
if(n == 0) return 0;
vector<int> res(n,0);
auto f = [](vector<int> a, vector<int> b) { if (a[1] > b[1]) return true;
else if (a[1] < b[1]) return false;
else{
return (a[2] >= b[2]); }
};
sort(boxes.begin(), boxes.end(), f);
for (int i = 0; i < n; i++) res[i] = boxes[i][0]; for (int i = 0; i < n; i++) {
for (int j = i + 1; j < n; j++) {
if(boxes[j][1] <= boxes[i][1] && boxes[j][2] <= boxes[i][2])
res[j] = max(res[j], res[i] + boxes[j][0]); }
}
int maxRes = 0;
for (int a: res) maxRes = max(maxRes, a); return maxRes;
}
};
int main() {
Solution sl;

for (int a: res) maxRes = max(maxRes, a);
return maxRes; }
};
int main() {
Solution sl;
vector<int> a{2,5,6}, b{3,6,4}, c{4,4,5}, d{7,6,3}, f{2,6,4}; vector<vector<int>> boxes;
boxes.push_back(a);
boxes.push_back(b);
boxes.push_back(c);
boxes.push_back(d);
boxes.push_back(f);
int res = sl.height(boxes);
cout << res <<endl;
return 0;
}
/*
Company A owns 10% of Company B. Company B owns 5% of Company C CompanyAowns 2%ofCompanyC
How much of Company C does A own? 2.5%
Exercise:
1) double getOwnership(source, target) i.e (A, C) => 0.025. 2) Model this, state assumptions.
*/
class Solution { public:
double getResult(unordered_map<string, unordered_map<string, double>> &companies, string comp1, string comp2) {
unordered_set<string> visited;
double res = 0, out = 1;
dfsHelper(companies, comp1, comp2, visited, out, res); return res;
}
 void dfsHelper(unordered_map<string, unordered_map<string, double>> &companies, string comp1, string comp2, unordered_set<string> &visited, double out, double &res) {
if (visited.count(comp1))return;

return res;
}
void dfsHelper(unordered_map<string, unordered_map<string, double>> &companies, string comp1, string comp2, unordered_set<string> &visited, double out, double &res) {
if (visited.count(comp1))return;
if (comp1 == comp2) return;
if (!companies.count(comp1)) return; visited.insert(comp1);
for (auto nextComp: companies[comp1]) {
double newOut = out*nextComp.second; if (nextComp.first == comp2) {
res += newOut; }
else dfsHelper(companies, nextComp.first, comp2, visited, newOut, res); }
return; }
};
int main() {
Solution sl;
unordered_map<string, unordered_map<string, double>> companies; companies["A"]["B"] = 0.1;
companies["B"]["C"] = 0.05;
companies["A"]["C"] = 0.02;
double res = sl.getResult(companies, "A", "C");
cout << res<<endl;
return 0;
}
给一堆词和一个document，求一个最小子串，使得子串包含所有词(假设子串 之间不会share前缀后缀)
#include <iostream> #include <map> #include <vector> #include <climits> #include <algorithm>
 #include <string> using namespace std;

#include <vector>
#include <climits> #include <algorithm>
#include <string> using namespace std;
class Solution { public:
string p2 (vector<string> &wordDict, string &s) { unordered_map<string ,int> m;
for (string str: wordDict)
m[str]++;
int count = wordDict.size(), minStart = 0, start = 0, end = 0, minLen = INT_MAX; while (end < s.size()) {
bool change = false;
for (int i = 0; i < wordDict.size(); i++) {
if ((end + wordDict[i].size() < s.size()) && s.substr(end, wordDict[i].size()) == wordDict[i]) {
if (m[wordDict[i]] > 0) count--; m[wordDict[i]]--;
end += wordDict[i].size(); change = true;
break; }
}
if (!change) end++; while (count == 0) {
bool move = false;
if (end - start < minLen) {
minLen = min(minLen, end - start);
minStart = start; }
for (int i = 0; i < wordDict.size(); i++) {
if ((start + wordDict[i].size() <= end) && s.substr(start, wordDict[i].size()) ==
wordDict[i]) {
if (m[wordDict[i]] == 0) count++;
m[wordDict[i]]++;
start += wordDict[i].size(); move= true;
break;
 }
if (!move) start++; }
}

move= true; break;
 }
if (!move) start++; }
}
return (minLen == INT_MAX)? "": s.substr(minStart, minLen); }
};
int main() {
Solution sl;
vector<string> wordDict; wordDict.push_back("ab"); wordDict.push_back("cd"); wordDict.push_back("ef"); wordDict.push_back("gh");
string s = "iabbbefedabefghabcdef"; string res = sl.p2(wordDict, s); cout<< "res is: " << res<<endl; return 0;
}
给一个vector<vector<string>> 输入，求等价类并输出等价类中 vector<string>的下标;vector<string>的等价关系定义为，如果两个vector 中有相同的string，则它们等价。
#include <iostream> #include <vector>
class Solution { public:
vector<vector<int>> p1(vector<vector<string>> &input) { vector<vector<int>> res;
if (input.size() == 0) return res; father.resize(input.size(), 0);
rank.resize(input.size(), 0);
for (int i = 0; i < input.size(); i++) father[i] = i; for (int i = 0; i < input.size(); i++) {
for (int j = i + 1; j < input.size(); j++) { if (findEqual(input[i], input[j])) {
makeUnion(i,j);
}
}

rank.resize(input.size(), 0);
for (int i = 0; i < input.size(); i++) father[i] = i; for (int i = 0; i < input.size(); i++) {
 for (int j = i + 1; j < input.size(); j++) { if (findEqual(input[i], input[j])) {
makeUnion(i,j); }
} }
vector<vector<int>> bucket(input.size()); for (int i = 0; i < father.size(); i++) {
bucket[father[i]].push_back(i); }
for (int i = 0; i < bucket.size(); i++) {
if (!bucket[i].empty()) res.push_back(bucket[i]); }
return res; }
bool findEqual(vector<string> v1, vector<string> v2) { for (int i = 0; i < v1.size(); i++) {
for (int j = 0; j < v2.size(); j++) {
if (v1[i] == v2[j]) return true; }
}
return false; }
void makeUnion(int i,int j) {
int rootp = findFather(i);
int rootq = findFather(j); if(rootp == rootq) return; if(rank[rootp] == rank[rootp]) {
father[rootq] = rootp;
rank[rootp]++; }
else if(rank[rootp] > rank[rootq]) father[rootq] = rootp; else father[rootp] = rootq;
return;
}
int findFather (int i){
if (father[i] == i) return i; father[i] = findFather(father[i]);
return father[i];

return;
}
int findFather (int i){
if (father[i] == i) return i; father[i] = findFather(father[i]); return father[i];
}
private:
vector<int> father, rank; };
int main() {
Solution sl;
vector<vector<string>> input; vector<string> a{"abc", "def"}; vector<string> b{"def", "ghi"}; vector<string> c{"abc", "ghi", "jkl"}; vector<string> d{"d", "e"}; vector<string> e{"e", "f"}; input.push_back(a); input.push_back(b); input.push_back(c); input.push_back(d); input.push_back(e); vector<vector<int>> res = sl.p1(input); for (auto a: res) {
for (auto b: a) {
cout << b<<" "; }
cout<<endl; }
return 0; }
class Solution { public:
vector<vector<int>> p1(vector<vector<string>> &input) { vector<vector<int>> res;
if (input.size() == 0) return res;
 rank.resize(input.size(), 0); unordered_map<string, vector<int>> m; for(int i = 0; i < input.size();i++) father[i] = i;
father.resize(input.size(), 0);

vector<vector<int>> res;
if (input.size() == 0) return res;
 rank.resize(input.size(), 0); unordered_map<string, vector<int>> m; for(int i = 0; i < input.size();i++) father[i] = i;
for (int i = 0; i < input.size(); i++) { for (auto str: input[i]){
m[str].push_back(i); }
}
for (auto a: m) {
for (int i = 1; i < a.second.size(); i++) {
makeUnion(a.second[0], a.second[i]); }
}
vector<vector<int>> bucket(input.size()); for (int i = 0; i < father.size(); i++) {
bucket[father[i]].push_back(i); }
for (int i = 0; i < bucket.size(); i++) {
if (!bucket[i].empty()) res.push_back(bucket[i]); }
return res; }
void makeUnion(int i,int j) {
int rootp = findFather(i);
int rootq = findFather(j); if(rootp == rootq) return; if(rank[rootp] == rank[rootp]) {
father[rootq] = rootp;
rank[rootp]++; }
else if(rank[rootp] > rank[rootq]) father[rootq] = rootp; else father[rootp] = rootq;
return;
}
int findFather (int i){
if (father[i] == i) return i;
father.resize(input.size(), 0);
father[i] = findFather(father[i]);

else father[rootp] = rootq;
return; }
 int findFather (int i){
if (father[i] == i) return i; father[i] = findFather(father[i]); return father[i];
}
private:
vector<int> father, rank; };


1. Clone Linked List
Clone linked list 里面有 random 结点。不需要像 leetcode 上面给的解法用 random 那么烦，
只需要 hashmap 就可以了。
思路 1:可以用 extra space: Hashmap, oldNode : newNode, scan hashmap to set next and
random
思路 2:不可以用 extra space: oldNode1 -> newNode1 -> oldNode2 -> newNode2 https://leetcode.com/problems/copy-list-with-random-pointer/description/
2_1. Maximum subarray sum
https://leetcode.com/problems/maximum-subarray/description/
2_2. Maximum subarray sum with at least k-numbers or at most k-numbers
http://www.geeksforgeeks.org/largest-sum-subarray-least-k-numbers/
Slide window
Follow up: 如果这个 array 十分巨大，存在 disk 里面，然后给你有限的 memory 空间，该怎
么处理?
3. LRU
4-1. Task Scheduler – Count
https://leetcode.com/problems/task-scheduler/description/
4-2 Task Schedule – Output Sequence
Follow up of 4-1: return the sequence
4-3. Task Schedule – Topological Sort
任务集合 S，T=func(F)。F 是已完成任务集合，T 是下一步可以运行的集合，完成一个任务调一
次 func，任务出现 Error 就停止所有任务，做一个 scheduler。
不知道该答什么，扯到 multithread 上了，不知道是不是找死，网上见过类似的问题，把大概意思 讲清楚了，但 code 写的一塌糊涂
   https://leetcode.com/problems/lru-cache/description/
  
5. Key Value Snapshot Store
http://www.1point3acres.com/bbs/thread-279684-1-1.html http://www.1point3acres.com/bbs/thread-141712-1-1.html
6. Accounts Merge
https://leetcode.com/problems/accounts-merge/
Given an array of contacts with phone numbers/emails you should detect and union identical contacts. For example, given the following contacts array:
[
[ "John", "john@gmail.com", "john@fb.com"],
[ "Dan", "dan@gmail.com", "+1234567"],
[ "john123", "+5412312", "john123@skype.com"], [ "john1985", "+5412312", "john@fb.com"]
]
We can see that john1985, John and john123 are the same person by their contact information.
We should output
[[ 0, 2, 3], [1]] (0,2,3 are the same person and 1 is another one)
7. Balanced Binary Tree Leaf Nodes
给两个 Balanced Binary Tree，返回他们所有的 leaf node 是否的都一样，包括顺序。
Leaf node 不一定要在同一个 level 上。
先做了一个 recursive 的解法，小哥看没有什么问题，就问我能不能用 iterative 的方法做出来。 Queue 存第一个树的叶节点，然后 pop 看是否 match 第二棵树
8. Calendar Event Notification
设计一个 Calendar class， 包含两个 functions:AddEvent() 和 NotifyUser()， 每一个 Event 上都有一个时间，当时间到的时候要提醒用户。
Events 按照发生时间排序，用了 priority queue
9-1. Min Stack
https://leetcode.com/problems/min-stack/description/
    
9-2. Median Stack
面试官是期待用 BST 做，然后利用每个节点记住左右两边节点的个数来优化，使得找
median 更快
10. 设计 - 扫雷游戏 http://www.1point3acres.com/bbs/thread-290500-1-1.html
一阶段是布雷，一阶段是扫，然后小哥说布雷不用做了，假设你的 constructor 就传入了布好雷的 matrix。(表示很失望，不能 show 一发 O(k) partial Fisher-Yates 随机算法了)
扫雷就是一个 clickTile(int row, int col)函数，有三种情况:
1. 周围有雷，比如周围有4个雷，就显示4
2. 周围没有雷，需要探索到一大片直到有雷的区域 3. 踩到雷，直接lose
这里需要设计如何返回结果包含所有信息，我做了一个 ReturnType 包含有没有死，探索出来的一 圈点的 list，每个点包含坐标和周围雷数(count)信息。
对于第一三情况很简单，对第二种就 DFS 搜一下，搜到边界就加到要返回的 list 里。
Follow up 比如是再给你一个 markTile(int row, int col)和 hasWon()的 API，设计扫雷机器人，说说思 路就行。这里我说了有时候是 50%运气的，不能完全扫对，小哥说没事，做一个能扫多少扫多少 的，不猜。
12. The Skyline Problem
Leetcode 218. The Skyline Problem https://leetcode.com/problems/the-skyline-problem/description/
11. Readers Writers Problem 11-1. Readers Preference
11-2. Writers Preference
13. Find Local Maximum
1: 找所有 local maximum，array 满足两个条件
1. |a[i] - a[i-1]| = 1
  
2. The local maxima are sparse
E.g. 1 2 3 4 5 6 7 8 7 6 5 4 3 4 5 6 7 6 5 => [8 7]
【思路】类似 binary search，给了 hint 才做出来的。比较 abs(arr[left]-arr[right])是不是等于 right - left, 来判断中间是不是有 local maximum。
要注意 boundary，楼主就忘记了，然后 interviewer 问才加的。。。
14. Good Node
找最小 swap 使所有节点都有 path 到起始 good node
Directed Graph with each node having exactly one outgoing edge Good Node:
- A node which is marked as good
- A node which has a path to good node
One node in the graph is marked good
Swap: n1 -> n2 => n1 -> n3，可以改变任何一个 edge 的 start 和 end node. Minimum number of swaps to make all nodes good
我是用 DFS 做的，感觉用 union find 应该也可以做。
15. Max Subarray Sum
给一个 array,里面是排好序的正数，可能会有重复。目标找出 maximum sum。如果一个数字出现 多次，可以把所有的都加进结果。但是不可以包含相邻的数字。比如说如果结果包含了 2，那就 不能再包含 1 或者 3。
提出了 dp 的解法，O(n^2)的时间。小哥问还能更快一点吗。想了一会提出了用 treemap 的解法 O(nlogn)，但是感觉小哥还是不满意。最后没有其他的想法，就实现了这个解法。写完之后还有 时间，结果小哥说不然我们 run 一下吧。汗 -_-|| 结果就开始了 debug 之旅。。。 最后问了问 题，第一轮结束。
16. Cut Tree
给一个 tree 的数据结构，每一个 node 可以有多个子节点。定义一个操作 break, 就是把某一个 edge 切断，这样一个树会被切成两个小树，并且要求每个小树里面要有偶数个 node，否则不可

以这样切。现在给一个 root, 要求尽可能把这个树切最多的小树，然后返回所有小树的 root。如果 这个树不能被切小，throw an exception.
这题的题设就挺复杂了，面试官讲了大概 15-20 分钟,还举了几个例子。我当时想了一个类似 greedy 的解法。先求出把每一个 node 作为 root，这个树所包含的所有子节点的个数。然后扫这 棵树，如果总数是奇数，则不可能平分，throw an exception. 否则我们就 recursively 切 count 为偶 数的子节点。
17. Same Subtree
国人，二叉树，所有相同子树集合，见过这题，应该把子树都 serialize 存 hash 就行吧，当时没反
应过来，面试官也要求先写最简单方法然后讨论复杂度优化
18. Unencrypted String
Unencrypted string: 'abcd....z'
Encrypted string: 'cdef ....b'.
e.g. 'abc' -> 'cde', 'aby' -> 'cda'
Implement a function that takes in two arguments. The first argument is going to be an unencrypted string consisting only of the characters 'a'->'z'. The second argument is going to be an arbitrary string.
Return whether the second argument could be a shift cipher encrypted version of the unencrypted string.
e.g. ('abc', 'cde') : true, ('aby', 'cda') : true, ('abc', 'cdf') : false Follow up:
Function where the input is a list of strings, all of the same length and all consisting only of the characters 'a'->'z'. We want to group together all the strings that are shifted versions of one another such that all strings that are equivalent shifted versions of one another are contained in the same set.
(["abc", "cde", "def", "acb", "bdc"]) -> [["abc", "cde", "edf"], ["acb", "bdc"]]
19. List All Files
问了说在 root 下，想要找出目录下所有文件的文件名应该用什么数据结构，说白了就是 Leetcode_341 然后就开始问如果是多线程怎样设计合理，怎么分配 thread，最后问了如果内存不 够用了 deadlock 了怎么办
给一个文件树，让 implement 多线程 写 producer-consumer queue 遍历这个文件树 Similar Question:
https://leetcode.com/problems/flatten-nested-list-iterator/description/
 
20. Path Count
首先是给定一个 M x N grid，求从左下角走到右下角有多少种可能的路径。限制:只可以走三个方
向 right, diagonally right up, diagonally right down
Follow up，现在给定额外参数 h，求问高度超过 h 的路径有多少?某条路径的高度为其最高点
21. Stack Tallest Boxes
You have a list of boxes, they have different height, width, length. They're not rotatable. You want to find the tallest stack you can build with that list of boxes. You don't have to use all of the boxes. You can only stack smaller boxes (width AND length have to be smaller) on top of bigger boxes.
// [h, w, l]
// [2, 5, 6] // [3, 5, 4] // [4, 4, 3] // ==> 9
// case 2
// [2, 5, 6]
// [3, 6, 4]
// [4, 4, 5]
// [7, 6, 3]
// => box1 as bottom, (b1, b3) 2 + 4 = 6 // => box2, (b2, b4) 3 + 7 = 10
// => 10
【思路】其实是 Longest Increasing Subsequence (LIS)的变种，用 DP 可以在 O(n^2)解决
22. Company Stock
Company A owns 10% of Company B
Company B owns 5% of Company C
Company A owns 2% of Company C
How much of Company C does A own? 2.5%
Exercise:
1) double getOwnership(source, target) i.e (A, C) => 0.025 2) Model this, state assumptions

23. Read4k
https://discuss.leetcode.com/category/166/read-n-characters-given-read4 https://discuss.leetcode.com/category/167/read-n-characters-given-read4-ii-call-multiple-times
Given API: int Read4K(char[] buffer);
It reads data from a file and records the position so that the next time when it is called it read the next 4k chars (or the rest of the file, whichever is smaller) from the file. The return is the number of chars read.
Todo: Use above API to Implement API
"int Read(char[] buffer, int n)" which reads any number of chars from the file
需要处理 read 的来源不仅是 File, 还有网络端口的情况(如果端口慢，导致一次读 4k 的时候，有 可能读不到 4K，但不是 End of File，所以应该继续读)
24. Sparse Matrix Multiplication 稀疏矩阵相乘
Given two sparse matrices A and B, return the result of AB.
You may assume that A's column number is equal to B's row number.
  Example:
A = [[ 1, 0, 0 ], [-1, 0, 3 ]]
| 1 00 |
AB = | -1 0 3 | x | 0 0 0 | = | -7 0 3 |
| 0 01 |
25. K closest coordinate
Given a list of coordinates, find k closest coordinates that are outside radius r (radius 是相对原点而言
的) -> kth smallest element 变种 heap https://leetcode.com/problems/top-k-frequent-elements/description/
26. Fraction to Recurring Decimal
B = [ [ 7, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 1 ]]
|70 0 | | 70 0 |
 
https://leetcode.com/problems/fraction-to-recurring-decimal/description/
27. Needle and Haystack
题目是给一个 character list 叫 haystack 和另一个 character list 叫 needles，然后在 haystack 里找出 包含 needles 里所有 character 的 min subarray 的 size
有3个条件
1. Haystack 和 needles 没有 duplicate character
2. 必有一个解
3. 在 subarray 里的 character 顺序不要紧，只要包含就好了
Follow up.
1. Haystack 的长度 >> needles 的长度
2. Haystack 的长度和 needles 的长度很接近
3. Haystack 可能有 duplicate character. (https://leetcode.com/problems/minimum-window- substring/description/)
28. Rotate 2D Matrix
Coding 是 rotate 2D matrix. 我的算法是先轴对称(一直没想起来轴对称旋转的英语怎么说)旋 转，然后再左右对称旋转。事后我发现，其实直接用 math 的方法的空间复杂度比我的解法要 低，我没有写 in-place 的解法 。
29. Merge Intervals
https://leetcode.com/problems/merge-intervals/description/
30. Basic Calculator II
https://leetcode.com/problems/basic-calculator-ii/description/
31. String Chain
给一个 List<List<string>> 输入，求等价类并输出等价类中 List<string>的下标;List<string>的等价关
系定义为，如果两个 List 中有相同的 string，则它们等价。
举例:对于[['abc', 'def'],['def','ghi'],['abc','ghi','jkl']]，输出[0,1,2]，因为 input[0]中有'abc',input[2]中 有'abc'，所以[0,2]等价，同理[1,2]等价，故[0,1,2]为一个等价类，输出[[0,1,2]]。
     
32. N Queens
https://leetcode.com/problems/n-queens/description/
33. Longest Prefix Word
提供一个字典，里面有很多 word，实现这样一个类，每次 query 的时候返回这个 query string 为
prefix 的最长 word，跟三哥讨论了很多优化的细节
Trie: TrieNode with val, height and Map<Character, TrieNode> children
34. Flip Game
http://www.cnblogs.com/jcliBlogger/p/4882201.html
35. Flip Game2
http://www.cnblogs.com/jcliBlogger/p/4886741.html
36. Next Permutation
https://leetcode.com/problems/next-permutation/description/
37. 3Sum
https://leetcode.com/problems/3sum/description/
 




