---
title: Interview-HA-OA
date: 2020-05-03 10:47:10
categories: Interview
tags:
---


```c++
#include <iostream>
#include <fstream>
#include <vector>
#include <utility> // pair
#include <stdexcept> // runtime_error
#include <sstream> // intstream
#include <map>
#include <set>
#include <deque>
using namespace std;

vector<vector<int> > read_csv(string filename){

    vector<vector<int> > result;

    ifstream myFile(filename);

    if(!myFile.is_open()) throw runtime_error("Could not open file");

    string line;
    int val;

    while(getline(myFile, line))
    {
        stringstream ss(line);
        vector<int> temp;
        while(ss >> val){
            temp.push_back(val);
            if(ss.peek() == ',') ss.ignore();
        }
        result.push_back(temp);
    }
    myFile.close();
    return result;
}

map<int, deque<int> > getChains(vector<vector<int> > inputs)
{
  map<int, deque<int> > header;
  map<int, int > tail;

  for (int i = 0; i < inputs.size(); i++) {
      int start_job = inputs[i][0];
      int time = inputs[i][1];
      int next_job = inputs[i][2];

      //cout << start_job << " " << time << " " << next_job << endl;
      
      if (map1.find(start_job) != map2.end() ||
          map2.find(next_job) != map2.end()) {
          throw new string("Wrong");
      }

      if (header.find(next_job) != header.end()) {
         deque<int>& dq = header[next_job];
         dq.push_front(start_job);
         header[start_job] = dq;
         header.erase(next_job);
      }
      else if (tail.find(start_job) != tail.end()) {
         int headerKey = tail[start_job];
         deque<int>& dq = header[headerKey];
         dq.push_back(next_job);
         tail[next_job] = headerKey;
         tail.erase(start_job);
      } else {
         deque<int> dq;
         dq.push_back(start_job);
         dq.push_back(next_job);
         header[start_job] = dq;
         tail[next_job] = start_job;
      }
  }
  return header;
}

int main()
{
    vector<vector<int> > res = read_csv("input.csv");

    map<int, deque<int>  > chain = getChains(res);

    for (auto e : chain) {
        for (auto i : e.second) {
            cout << i << " ";
        }
        cout << endl;
    }
    cout<<endl;
}
```

```c++
#include <iostream>
#include <fstream>
#include <vector>
#include <utility> // pair
#include <stdexcept> // runtime_error
#include <sstream> // intstream
#include <map>
#include <set>
#include <deque>
#include <algorithm>
using namespace std;

struct Result {
    int start_job;
    int end_job;
    int total_time;
    int job_nums;
};

vector<vector<int> > read_csv(string filename){

    vector<vector<int> > result;

    ifstream myFile(filename);

    if(!myFile.is_open()) throw runtime_error("Could not open file");

    string line;
    int val;

    while(getline(myFile, line))
    {
        stringstream ss(line);
        vector<int> temp;
        while(ss >> val){
            temp.push_back(val);
            if(ss.peek() == ',') ss.ignore();
        }
        result.push_back(temp);
    }
    myFile.close();
    return result;
}

vector<Result> getChains(vector<vector<int> > inputs)
{
  map<int, Result > header;
  map<int, int > tail;

  vector<Result> chains;

  for (int i = 0; i < inputs.size(); i++) {
      int start_job = inputs[i][0];
      int time = inputs[i][1];
      int next_job = inputs[i][2];

      //cout << start_job << " " << time << " " << next_job << endl;

      if (map1.find(start_job) != map2.end() ||
          map2.find(next_job) != map2.end()) {
          throw new string("Wrong");
      }

      // in next_job in header
      if (header.find(next_job) != header.end()) {
         Result& r = header[next_job];
         r.start_job = start_job;
         //r.time[start_job] = time;
         r.total_time += time;
         r.job_nums++;
         header[start_job] = r;
         header.erase(next_job);
      }
      // in start_job in tail
      else if (tail.find(start_job) != tail.end()) {
         int headerKey = tail[start_job];
         Result& r = header[headerKey];
         r.end_job = next_job;
         r.total_time += time;
         r.job_nums++;
         tail[next_job] = headerKey;
         tail.erase(start_job);
      } else { //new chain
         Result r;
         r.start_job = start_job;
         r.end_job = next_job;
         r.total_time = time;
         r.job_nums = 1;
         header[start_job] = r;
         tail[next_job] = start_job;
      }
  }
  transform(header.begin(),
            header.end(),
            back_inserter(chains),
            [](const pair<int,Result>& p) { return p.second; }
            );
  sort(chains.begin(), chains.end(), [](const Result& lhs, const Result& rhs) {
      return rhs.total_time < lhs.total_time;
   });
  return chains;
}

int main()
{
    vector<vector<int> > res = read_csv("input.csv");

    vector<Result> chain = getChains(res);

    for (auto r : chain) {
        cout << "start job: " << r.start_job << endl;
        cout << "end_job: " << r.end_job << endl;
        cout << "total_time: " << r.total_time << endl;
        cout << "total_num: " << r.job_nums << endl;
        cout << "avg time: " << r.total_time * 1.0 / r.job_nums * 1.0 << endl;
        cout<<endl;
    }
}
```

