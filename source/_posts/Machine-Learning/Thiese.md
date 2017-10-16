---
title: Reinforcement-Learning
date: 2017-10-16 06:12:57
categories: Machine-Leaning
tags:
---

Abstract 

With the development of computer science, intelligent educational system become more and more popular. 

There are many famous project in this area, such as MOOC, Courser, Anki, Mnemosyne. 

However, most of current project is base on basic algorithm and not personal for every student. 

Therefore, it’s necessary to select different strategy for individuals. 

Reinforcement learning is a branch of machine learning, which is efficient to get a good policy by sequence actions. 

RL can create a personal schedule for every students,

Moreover, it breaks through the restriction of teachers, classroom and platform.

Traditional algorithms in intelligent educational area focus on machine learning, or online method of reinforcement learning. 

In this thesis we use offline method in reinforcement learning to analysis the log data from Mnenosyne. 

Moreover, we try use reinforcement learning algorithm with Chinese learning which is a new idea for Chinese learning. In this thesis, we use Fitted Q iteration. 

Perhaps the most popular algorithm in batch RL which is introduced by Damien Ernst. (FQI, Ernst et al (2005a)). 



It can be seen as the ‘Q-Learning of batch RL’,as it is actually a straight-forward transfer of the basic Q-learning update-rule to the batch case.



Introduction

With the development of the Internet, the online courses are becoming increasingly popular. 

There are several types of online course platform, which include online video, online quiz, distance course.

 

For online video, which is usually recorded by teachers, is content-rich, easy to understand, but the interaction is poor. 

Therefore it is suitable for simple introductory courses or lectures. 

However, it is not helpful for students to understanding some difficult knowledge, and apply theory into practice process.

 

For online quiz, students can learn knowledge by practice. 

However, most of the traditional online exam only provide some single, simple questions and strategy, 

so it is not enough for students in different learning levels. 

Moreover, in most of cases, the online quiz only use the standard answer for detecting whether the solution is correct, 

all of these disadvantages limit students' learning efficiency greatly. 

 

For distance courses, teachers and students can interact online, 

and the teacher can be able to find the lack of students knowledge and answer the question of students immediately.

It is also efficient to provide online testing, evaluation, feedback. 

But the human cost is very large in this form, it is not easy to copy extensively.

 

The Intelligent Teaching System(ITS) become more and more import, it provides thousands of education opportunities to people, 

but it still has far to go.

One key to improve the ITS is to improve the Artificial Intelligent( AI) algorithm. 

Current algorithms are really simple, usually just  records the number of correct or wrong answer, use basic regression methods of marching learning .

In this thesis, we will discuss how to develop appropriate learning strategies for every student though history information of students with reinforcement learning method.

 

There are 7 parts of this thesis: part one is the introduction, part 2 explain the reinforcement learning algorithm and batch reinforcement learning, 

in part3, we apply the batch RL algorithm into a classical simple example (grid word), in part4, we apply the batch RL algorithm into real project, 

part 5 is we analysis the result, and give the conclusion, part 6 we discuss the disadvantage and wok we will do in the future, part 7 is the reference.


