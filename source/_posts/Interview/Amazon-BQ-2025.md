---
title: Amazon-BQ-2025
date: 2025-02-14 07:50:51
categories: Interview
tags:
---

### Q1: not enough data,but you have to  make decision
An alert occurred due to a sharp increase in CPU and memory usage on one instance, and the root cause was unclear in a short time. The oncall was a junior engineer with little experience, and the issue needed urgent resolution. I took responsibility to migrate the instance and supported the oncall in handling the situation. Afterward, our team implemented a new metric to detect this kind of issue earlier, before instance-level alerts are triggered.

### Q2 earn trust. 
The Apple service bug caused online Redis data to be corrupted, and ads couldn’t be delivered to users. While waiting for the external fix, we wanted to take action in parallel. I proposed backfilling data from the previous day’s Hive table into online Redis. With 1M QPS, this was risky. I built a fast service, verified it with unit tests and 10 real messages, and used a grey release to backfill gradually. I fixed the issue two days before Apple’s fix and avoided revenue loss. I later proposed this as a standard disaster tolerance solution across teams. 

### competing project

### prioritize the the project
In the Privacy Policy Center project, I prioritized the frontend work first to demo platform features early, reduce migration risk, and gather user feedback. This allowed us to validate the direction before tackling the backend refactor. My manager supported the decision, and users gave positive feedback on the early demo. Their input helped refine the design, and the phased approach led to a smoother backend transition.

### conflict
We had an urgent feature to launch involving dynamic JSON rule updates for ad delivery. A teammate (PM or Engineer) wanted to release all changes at once to save time, while I pushed for a grey rollout due to the high QPS and risk of breaking delivery logic. The urgency caused some tension, but I proposed reviewing similar past incidents and consulted SRE to assess risk. After aligning, we agreed on a phased rollout. It went smoothly without issues, and the teammate later appreciated the safer approach. This helped us build mutual respect and improved future collaboration.

## Strauggle
dependency API. 

unclear requirment

implement fall back logic

## Questions:
### 1. tell me the cases:

Minor project, different ages. source different age select most stricted one

帮助公司省钱，避免了官司

### 2. tell me why you can not find the issue early? other team API version update.

### 3. tell me the case mentor others
OOM issue.

### 4. tell me great complishment.

### 5. tell me your wrong direction


### 6. Tech mistake: Priority Qeueu OOM.


### 7. Take risk: 新的 API get region， risk， not full test  , code switch

### 8. Miss tell miss ddl.
reporitise the tasks. 

## Amazon 10 条军规
### 1. Customer Obsession: Business Integrity Appeal Project

1. set different groups for users. 
Help engineering reduce the Oncall number of ticket, let the good advertiser's ticket can be handled faster.

### 2.Dive Deep: Oncall OOM issue.

### 3. Bias for Action: 
Policy Center Platform, api data permission is waiting for approvel, hard code to demo
In the Policy Center Platform project,  
our service needs to call the Chinese team's API  
to retrieve data and display it in the Web UI.  

However, since the API permission is still awaiting approval  
and the Chinese team is on public holiday for the Spring Festival,  
I decided to temporarily hardcode the data  
in the backend for the demo scheduled for tomorrow.  

The user was satisfied with the sample data MVP  
and provided positive feedback.  

Through this experience, I learned to proactively  
consider holiday schedules and code freeze periods  
to better anticipate and mitigate potential delays in the future.

### 4. Insist on the highest standards: SLA 99.9% to 99.99 %
### 5. Ownership: Apple ID oncall
### 6. Earns Trust: Policy Center SOP
### 7. Deliver Results: Bloomber Cache
### 8. Learn and Be Curious: Learn C++, database, Open Source Antlr4 tool
### 9. Have backbone, disagree and commit : compare tool algotrithm
### 10.Invent & Simplify: Rule Simplification from Jason to Domain language

## 不好的项目:
1. one mistake:
* cpc ctr problem. focus on tech, ignore the business envrioment, thresholde 

* priorityqueue top k, beta

2. Miss Deadline. It does not miss the deadline, PC platform, release the mvp first.

3. Conflicts:   PC platform Permission, Metrics for auditor, PM ask for all permission, but I think the core requirments is let auditor know the business impact, and how the regulation is applied in system. Some engineering permssion and metrics is not the key componenet

## Amazon AWS:
Automation Project:

The documentaion automation.

1. Conflict with PM. 
PM ask to do the full automation, but I think we can release mvp and waiting for feedback.

2. Miss Deadline:
System refactor, too many tasks and high risk, replace the rule engine first and then iterate.
Piroritize the tasks into smaller pieces and release mvp


## Tiktok Data Engineering 

1. Offline data backfill, different source data is not accurate
2. offline to online, QPS is high, urgent
3. real time counter.
