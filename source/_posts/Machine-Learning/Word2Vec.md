---
title: Word2Vec
date: 2017-12-06 04:43:40
categories: Machine-Learning
tags:
---

http://blog.csdn.net/mytestmy/article/details/26969149
http://ginobefunny.com/post/learning_word2vec/
https://www.youtube.com/watch?v=pw187aaz49o

word2vec 是 nlp 的技巧。

中文 ，英语 --> Audio
汉语， 英文 --> Text

暂时把语言理解成text

小明是一个人。
a sequence of symbols

自然语言处理，两个流派

Probalistic Model, Logistic Model

针对 Logidtic Model: 
有一个set 主语， 谓语


a, b, c

Grammer

{
 a -> b
 a -> c
 c -> b
 b -> b
} 

abbb 可以
acb 可以
bc 不可以

逻辑式的定义，针对于大规模的数据，需要定义更大规模的语法集，语法结构。

Probalistic Model

I love you !

Do you ?

基于 Sequen \ Text \ Token Symbol, 利用 Statictics Learned

Unpupervised Learning
PCA --> Dimmension Reduction
K-mean Cluster 
DB-> can
t - ISN

Feature Learning
Feature Extraction

Supervised Learning
X, Y  f(x) --> y

Unsupervised Learning 怎么定义
X,  f(x) ---descrip--> S,  S1 {x1,x2,x3}, S2 {x4,x5,x6}

这些数据属于一个set, 是一个feature, 这些数据属于另一种 feature

DNN 其实就是 feature extraction的方法，是非监督式学习的方法

Autoencoder 做信息预处理
原始数据进来，再逐层回去，金字塔算法

rawText  --> Word2Vec --> feature

其实是 feature extraction
TextSpace ---> Vector Space

vector <==> word

A vector is the feature of word.

word2vec 是一类方法

1. 一种是基于 Count Based 方法

2. Probalistic 

滑窗是5
I love you so much ! \n
I love her.

```text
      I love you so much her
I     0  2    1  0   0   1
love  2  0    1  1   0   1 
you   1  1    0  1   1   0
so    0  1    1  0   1   0
much  0  0    1  1   0   0
her   1  1    0  0   0   0
```

要用 6 * 6 储存
n^2 unique n words

矩阵很大，其实很多地方都是0 

I love you so much

滑窗之滑上文或者下午

建立两层的神经网络

五个单词

```text
+-+
| |
| |   
| |
| |
| |
+-+
```
输出是softmax, 代表可能性

one hot code

I [1,0,0,0,0] ==> 输出 love [0,1,0,0,0]

love [0,1,0,0,0] ==> I [1,0,0,0,0], you [0,0,1,0,0]

一个滑窗训练3次

cross-entrofy 意义?

假设我们有一千个点


10万个词，

100 * 100，000

100 维的向量, 映射到100000个单词，cost 非常大

用 Skip gram 做优化.

CBOW  是用 滑窗的词，预测中心词
Skip-gram 是中心词预测滑窗词








