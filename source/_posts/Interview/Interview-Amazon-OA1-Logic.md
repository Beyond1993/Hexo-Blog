---
title: Interview-Amazon-OA1-Logic
date: 2017-09-03 22:32:57
categories: Interview
tags:
---
http://www.1point3acres.com/bbs/thread-210460-1-1.html
http://wdxtub.com/interview/14520850399861.html

成功不可复制，但是失败总是一样的：
http://www.1point3acres.com/bbs/thread-203776-1-1.html
http://www.1point3acres.com/bbs/thread-224773-1-1.html
http://www.1point3acres.com/bbs/thread-203921-1-1.html

<!--想不到时隔半年多，又开始面亚麻了。
http://www.1point3acres.com/bbs/thread-210460-1-1.html
之前OA1挂掉的惨痛经历历历在目。

之前的失败主要有
1. 自以为是，以为别人进亚麻很简单，自己也定然万无一失。 没有足够重视。

2. 轻敌冒进，在OA1还没有完全掌握的情况下，就开始复习OA2了。用兵之道，在于步步为营，稳扎稳打。专注眼前。

3. 只看到别人成功案例，而忽视了失败的情况，幸存者误差。 在查面经的同时，也要查跪经。

4. 失败之后。哀伤感叹，浪费了很多精力与时间。

5. 看似简单的题，限时的面试，考试环境中,往往就很容易做不出来，这种情况就是要求极高的心里素质，和冷静思考的能力。

这让我想到当年明月在明朝那些事里写的名将是怎样练成的，带领几十万人，一个细小的决定可能决定里几十万人的生死，在任何情况下都要保持冷静。
作出正确判断。自己当个班长都当不好，面个试还紧张的要死。真是觉得做英雄的真是非常人，行非常事。
-->
这篇博客来主要目的是搜集尽可能全的亚马逊OA1题目，同学们有啥新题补充，或者发现有误，请email: beyondfengwei@gmail.com 
所有内容来自互联网网。 侵权则删。

做OA前认真复习，做的时候忘记原题。前面小题抓紧时间。后面大题仔细推敲.
<!-- more -->
### 推理
虽然大多数的推理题，都是转化为数字，但是字母题侧重于位置，间隔，奇偶，映射。
而数字题侧重于数学推导，求和，平方，斐波拉契额数列，按位与，n^2,n^3, n^3 - n, n^n, 2^n,倍数

##### 字母推理

• D, H, L, (p) (P，等间距)

• QPS : TSV -> IHK : (LKN) 都是+3

• EAGLE : FZHKF -> THANKS : (UGBMLR) +1, -1 找规律的(**奇数+1偶数- 1**)

• FASTER : HCUVGT -> SLOWER --> (UNQYGT) (+2)

• ADBC : EHFG -> ILJK : (MPNO)(4个字母一组,ABCD,再将最后一个D放到第二个位置)

• JOHN : LSNV -> MARK : (OEXS)(+2 +4 +6 +8)

• COMPUTER : PMOCRETU -> TELEVISION : (VELETNOISI)(**先均分成两半，对每一半的字母顺序进行颠倒**)

• A17R : D12P -> G7N : (J7Q) (R=A+17, J=G+3)
A17R: D12P - > G7N: J2L （R=A+17, 17 – 12 = 5）

• COMPUTER : GKQLYPIN -> SENATE : WARWXA(奇数+4偶数-4)

• KPQR : LRTV -> DGHY : (EIKC) (前后相减每一位的增加分别为1,2,3,4)

• ACFJ : CEHL -> PRUY : (RTWA) (前后相减每一位的增加分别为1,2,3,4)

• VAILANT : UBKJZOS -> TRANSCEND : SSCLRDGLC (面经有误，奇数对:奇数-1，偶数+1，偶数对:奇数-2，偶数+2)

• VALIANT : UBKJZOS :: TRANSCEND -> SSZORDDOC  (奇数-1,偶数 +1)

• MQD : KRK -> SWM : ( QXT) (13, 17, 4, 11, 18, 11 => 13 - 18 = -5, 17 - 11 = 6, 4 - 11 = -7；5,6,7连续,正负号交替；另一个answer是NCF) 注意最后的位置

MQD:KRK   SWM: TXQ（13, 17,  4；11, 18, 11交叉（13-18）（17-11） （4-11））
• AD5 : ED9 求和

• ASSERTIVENESS-> SENSSAEVISTRE : MULTINATIONAL -> ?
(记录ASSERTIVENESS每个字母的位置，再记录下SENSSAEVISTRE每个字 母的位置，找出mapping关系(比如A在ASSERTIVENESS中第一个位 置，在SENSSAEVISTRE第六个位置，那么1->6)。最后记录 MULTINATIONAL每个字母的顺序，按照之前找出的mapping对找出来 (如M肯定会在所求字符串的第六个位置)。这种题字符串的长度和所 包含的字母个数肯定是一样的。)
重复字母的情况是有一定规律的:ASSERTIVENESS-> SENSSAEVISTRE , 123456789,10,11,12,13 -> 12,11,10,3,2,1,9,8,7,13,6,5,4 (用重复的字母把字符串隔开，就能看到排 列顺序了)【2】ass 【5】ert 【3】ive 【1】nes 【4】s

ASS ERT IVE NES S 
SEN SSA EVI S TRE 

MUL TIN ATI ONA L
ANO LUM ITA L NIT

• 原题字母，这里直接用数字表示:4，5，12，8，9 => 3，4，1，7，8问 13, 21, 13, 2, 1, 9 => ? 
(网上解法有:
4, 5, 12, 8, 9 => (4 - 1), (5 - 1), (1 - 0)(2 - 1), (8 - 1), (9 - 1)，so13, 21, 13, 2, 1, 9 => 02, 10, 02, 1, 0,8 
或者
4 5 12 8 9 -> 3 4 1 7 8 (每位都-1) 13 21 13 2 1 9 -> 02 10 02 1 26 8 就是2 10 2 1 26 8 (B J B A Z H)

ACG->HJN DGM-> KNT （a1’ – a1 = 7, a2’ – a2 = 7, a3’ – a3 = 7）
ADGJM: PSXRV(FINRV) : KNQTW : PSVYB 其他都是差2，选第二个
AFK : TWB : PUZ : DIN (间隔4)
AZP: ZAR :: TXK: SYM (-1, +1, +2)
bb c MN : dd e OP : gg f QP : mm n WX (第二个字母是第一出现字母的后一个)
BAD: FEH, POS, TSV (-1, +3)
BCEH : PQSV : CDGK : STVY (第二三位间隔2)
BECD: FTGH :: JMKL : NQOP 同上，+4
BHE : FLI => JPM :(NTQ) (每位+4)
CEH : PRV: TVY: MOR (间隔：+2, +3)
DEB: FGD: PQN: TUR  (第二位第三位差3)
DELHI : CDAGH =>MUMBAI : BJBAZH
DICE : 3824 =>EDGE : 4364 (每位减1)
DJ:  WQ =>  FK : UP (DJ +6, WQ -6; FK + 5, UP -5)
EXAM: FYBN :: TEST :  UFTU (+1)
FHKO,CEHL, ZBEJ, XZCG 数字+2 +3 +4.
KML : PRQ: NPQ : TVU (第三位是第一和第二位间隔的字母)
LOMN : HJIK: QTRS : UXVW (第一位和第二位差3)
MARKET->12-26-17-10-4-19. PRODUCT: 15,17,14,3,20,2,19(-1)
NORMAL : LAMRON =>SYSTEM : (METSYS)就是把字母顺序倒过来
POM,KJH, TSQ, VUS 数字-1-2
QDXM : SFYN :: UIOZ :WKPA (a1’ = a1+2, a2’ = a2+2, a3’=a3+1, a4’ = a4+1)
QSV :CFK : PSX : RUZ
SOUP: RPTQ => TOUR: SPTS (-1, +1, -1, +1)
STUMP : PQRJM => PITCH: MFQZE (每位减3)
TENNIS : UDOMJR =>CRICKET : DQJBLDU (+1, -1)

##### 数字推理

##### 间隔
###### 简单间隔
• 46 : 64 -> 82 : (100) (差为18)

• 3,6,18,108,(1944) (18 \* 6 = 108，所以应该是18 \* 108)

###### 按位间隔
• 985 : 874 -> 763 : (652) (每一位减一即可)

• 865 : 532 -> 976 : (643) (右边是左边每一位减三)

###### 奇偶间隔
• 2,3,7,8,13,14,(20) (相差1,4,1,5,1,6)

• 2 8 5 6 8 (4) 11 (分奇偶, 2、5、8、11， 加3得来的。另外一组应该是减2，也就是8、6、4)

• 0 2 3 5 8 10 15 17 24 26 -> 35  (+2,+1,+2,+3,+2,+5,+2,+7,+2,+9)
###### 递增间隔
• 3 7 13 21 (31) (间隔4,6,8,10)

• 5 11 19 29 (41) (间隔6,8,10,12)

• 0, 2, 6, 12, 20, (30)（间隔2，4，6，8）

• 0, 3, 8,15 -> 24 (间隔3,5,7,9)

• 82, 97, 114, 133, (154) (间隔15, 17, 19, 21)

• 10 74 202 394 650 (间距递增64，64，128，192，256)

• 3, 11, 25, 45, --> 71 (间隔8 ,14,20,26)

##### 平方 指数 反正就是2^n, 3^n, 4^n ,n^2, n^3,n^4
• 10 14 23 39 64 (100) (间距为完全平方数)

• 1,1,4,2,13,3,40,4,(121) ( 1+3 ^ 1 = 4，4+3 ^ 2 = 13，13 + 3 ^ 3 = 40，40 + 3 ^ 4 = 121)

• 1 5 7 (8) (1 + 2^2 = 5， 5 + 2^1 = 7 ，7 + 2^0 = 8)

• 3 6 15 42 123 (3 + 3^1 = 6, 6 + 3^2 = 15, 15 + 3^3 = 42, 42+ 3^4 = 123)

• 1:4:27:256:3125 (n^n)

• 2, 5, 26，(677) (规律是当前数字是前一个数字平方加1)

##### 求和，斐波拉契数列

• 27 : 24 -> 64 : (60)(27=3^3,3^3\-3=24,64=4^3,4^3\-4=60)

• 0 1 1 2 4 8 (16)(16前面的所有数加起来)

• 8, 8, 15, 23, 38, (61)

• 0 1 1 2 3 7 22 (0 \* 1 + 1 = 1, 1 \* 1 + 1 = 2, 1 \* 2+ 1 =3, 2 \* 3+1 = 7, 3 \* 7 + 1 = 22)
#### 递推表达式
• 24 : 50 => 102 : 206 ( x \* 2 + 2)

• 5, 9, 16, 29, (54)（9 = 5\*2 – 1, 16 = 9 \* 2 – 2, 29 = 16\*2 – 3,）

• 4,12,6,18,12,36,30, 90（4 \* 3 = 12,12 \- 6 = 6,6 \* 3= 18,18 \- 6= 12,12 \* 3= 36,36 \- 6=30）

• 0.28 0.56 1.68 (6.72) (0.56 = 0.28 \* 2, 1.68 = 0.56 \* 3, 6.72 = 1.68 \* 4)

• 3, 15, 35, 63, (99) (3 = 1 \* 3, 15 = 3 \* 5, 35 = 5 \* 7, 63 = 7 \* 9, 99 = 9 \* 11)

##### 居然还有质数
• 16 30 46 62 82（13+3， 29+1， 43+3， 61+1 然后前面的都是质数，每个质数之间隔了三个质数， 61之后第四个质数是79， 79+3=82，或者16加上后面的数为第二个的结果）

### 排异题
间距，奇偶，交叉
• BGL DIN MRW (HLR) (差5差6, 选HLR)

• PRS TVX FIK (LME) (前三项为递增)

• JLP (LNT) TVZ DFJ (10,12,16; 12,14,20; 20,22,26; 4,6,10; 差2差4递增，面经还有一种解法是首字母是不是4的倍数，我觉的不对，如果只考虑首字母，没必要给出三个字母，这种推理题一般不会给出无用条件)
JLP LNT TVZ DFJ（a1+2 = a2, a2+4 = a3, 故选2）

• (ABIJ) DEHI MNQR STWX (ABIJ前后一对间距不同) (1,2,9,10; 4,5,8,9; 13,14,17,18; 19,20,23,24)

• ADP QTS HKR STE (选1?都是完全平方数?，或者QTS，位与的结果不是 0?, 这题个人更偏向于国外网站选的是STE, 顺序加起来不为奇数，像这种题，偏向于 三个 是什么， 另一个不是)

• RHCAI OEST HNDA ADEH(RHCAI?只有这个不是身体部位?)

• ADF MPR ILN EHJ(2?只有它不是以元音开头?)
ADF MPR ILN EHJ（元音开头，位与操作，ILN不是0）

• STV XY A KKT BDE(其他都是两偶一奇，只有KKT是两奇一偶)

• AE5 DF6 HN14 KP2(选KP2，因为P!=2)

• HIK DGJ LPT SUW (1，因为不是等间距)

• LKJI (XYWV) WVUT KJIH(其他三个是相邻倒序)

• 956 794 884 678(678，前几组加起来和都是20)

• (1,4,16)  (17,20,24)   (8,11,18)  (19,20,5) (最后一个，间距不是3的倍数)


### 逻辑推理小题

#### 自定义表达式。 这题一定要审题清楚，不能想当然。
例题1.
The given signs denote the following operations / relationships

A - B means A plus B
A # B means A multipled with B
A / B means A is greater than or equal to B
A ? B means A is less than B
On the basis of this information, and assuming that the given statements are true, find out which of the two conclusions(I and II) is / are definitely true.

Statements
(V # X) / (V -X), X ? Y and Z / Y
Conclusion:
I. X ? Y 
II. (V - X) ? (V # X)  

• Only conclusion I is true
• Only conclusion II is true
• Both the conclusion are true
• Neither conclusion I nor II is true

注意 - 是 plus, ／ 是 大于等于, ? 是 小于。

例题2.
“％” "means greater than;"
“>”  "means equal;"  
“=”  "means is not less than;" 
“@”  "means not equal;"
“#”  "means less than;"
“星号”  "means no greater than."
然后给了三个条件：
A%B (A > B),  C=E (C >= E), D*B (D<=B)， 
问:
1）A#D (根据条件可推出 A >= D, A#D = A < D, 不对)   
2）C*E 里面哪个是成立的（C*E=C < E, 根据条件不对），所以两个都不成立

例题3.
The given signs denote the following operations/relationships:
“%” denotes “greater than”
“>” denotes “equal to”
“=” denotes “not less than”
“@” denotes “not equal to”
“#” denotes “less than”. 
“*” denotes “not greater than”
on the basis of this information and assuming that the given statements are true, find out which of the two conclusions (I and II) is/are definitely true.
Statements: P > S, S@T, P#R Conclusion: I. S%R II. P@T
A Only conclusion I is true
B Only conclusion II is true. 
C Neither conclusion I nor II is true
D Both conclusion I and II are true

####  走路问题
这里的take an about-turn, turn around, 都是reverse turn. 向后转的意思。

1. If northwest becomes east, northeast becomes south, and so on, what does southeast become? (west)

2. Lily can't find her home, she is 25 yards southwest of her home, then she walked 20 yards toward north, where is her home from her now? (15 yards, east)

3. 还有一个面朝北的朋友，先左走15m，然后一个about-turn走了30，这货在哪（about turn指的是向后转。先向西走15m，然后向东走30m，应该在东15m）

4. 小明往东南走4 miles，往西走8 miles， 再往西北走4 miles。现在小明离出发 点是什么方位?(正西8 miles, 平行四边形)

5. **这题是易错题，用笔模拟小明，仔细走一遍
小明面朝南，往左走20miles， 再往右走 10miles， 再往左走30miles。 现在 小明离出发点是什么方位?(大致东南方向?)
这题居然错了.**

6. 小明从原点出发往北走了一段距离，左转走了10再左转走了20，发现自己在出发点西侧10，问一开始往北走了多少？(20) 

7. 南5西4南7东4北5，问方向、离原点距离(在原点正南7处) 
一个人从point 1向south走了20miles，然后turn right， 有向前走了30miles，然后第二次turn right,再向前走了20miles。问第二次turn right后朝什么方向前进。(N)

8. Consider the direction codes given below:
">" means ‘moves 3 yards to the north’
"<" means ‘moves 10 yards to the east’
"+" means ‘moves 7 yards to the west’.
"-" means ‘moves 15 yards to the south’
What is the new position of ‘Z’ with respect to its initial position if its movement is (Z+Z > Z < Z-)?
A 3 yards east and 12 yards north
B 3 yards east and 12 yards south
C 3 yards west and 12 yards south
D 3 yards west and 12 yards north

9. 向东4 miles，向北8miles， 向西2miles， 求最后方位 northeast

10. A man jogs 4 miles towards east, then 8 miles towards north and from there he goes 2 miles towards west. In which direction is he, from his starting point.
A East
B North-east
C North-west.
D  West

11. Jenny has lost her way home. She was standing 25 yards away from house in the SW direction. Walk 20 yards north and reaches point ‘A’. how far and in which direction would she have to walk to reach her house.. 鐗涗汉浜戦泦,涓€浜╀笁鍒嗗湴
A 20 yards, east
B 15 yards, east
C 15 yards, west
D 20 yards, west

12. Elijah travelled a distance of 80 miles towards north. Then he turned right and travelled 65 miles. He turned northwards and travelled 45 miles. He travelled further, by turning 45 clockwise. Towards which direction is he driving now?
A North
B West
C South west
D North east

####  楼层坐人问题
一个楼有3层，每个level 坐一些人，第二层能坐最多，一共坐66个人。给了两个条件求第二层坐了多少人。
1，其中有一层坐了21 人。
2，第二层比其中一层多座了2人 我选的可以求出第二层多少人， 21，22， 23. 第二层23人。

这题有点小trick, 运用反正法，
假如第二层是21人，其中必有一层是19人，剩下一层是26人。 这样第二层至少26个作为，坐19人的那层最多14个座位，坐不下19人。
所以只能第二层是23人，其他两层有一个是21,另一个是22，但具体不确定。

#### 年龄问题

推断一个人的年龄 (1)知道所有人的平均年龄 (2)所有人年龄都一样， 问(1)和(2)怎么来推断这个人的年龄
有点奇怪，所有人年龄一样，那不就是平均年龄？

妹妹比哥哥小5岁(或其他数字) ， 哥哥1988年，判断能计算什么(妹妹的年龄，妹妹的出生年)

# 求日期
关于亚麻生日问题的原题，有同学知道请发邮件到beyondfengwei@gmail.com
生日在9月19~25， leap year，判断能否能计算出生日 ????? (29, common year 28)
完全不懂这题在说啥。。
说我生日在二月和十月之间，在四月和八月之间，（都是non-inclusive)，你猜猜我生日到底几月啊。（这什么意思。。谁遇到过可以给我解释一下不）

On what date was the car purchased by Lily?  
Statement:
I) certainly before 19 October, 2009 but definitely not before 16 October, 2009
II) certainly after 17 October, 2009 but not later than 20 October, 2009. Waral 
A)I alone is sufficient for answering the question. From 1point 3acres bbs
B)II alone is sufficient for answering the question  
C)Both together are sufficient for answering the question (18th, Oct)
D)Both together are not sufficient for answering the question
E)Either is sufficient for answering the question

####  排名问题
给两个条件： I. 班级总人数38， II 比小王分数低的有19人选 (结合I,II两个条件可以决定小王在班级的排名) 

#### 买车问题
给两个条件: I. 小王买车时间 <10/19 且 >=10/16 
II.小王买车时间 >10/17 且 <=10/20
选 (结合I,II 两个条件可以确定小王具体买车时间.) 

#### 球堆问题
是桌上一堆球，取掉7个不少于23个， 加上6个不多于20个，问能否推断桌上几个球 (不能，不成立)

#### 电离能
Problem Question: Ionization energy decreases with the increasing size of metal atoms. Out of cesium, lithium, postassium and sodium, which will have the lowest ionization energy?
Statements:
I) Lithium has the smallest size
II) The size of postassium and cesium is greater than that of lithium.

• Statement I alone is sufficient for answering the problem question 
• Statement II alone is sufficient for answering the problem question 
• Both statements put together are sufficient for answering the problem question
• Both statements even put together are not sufficient for answering the problem question
• Either of the statements is sufficient for answering the problem question

together are not sufficient 

#### 买卖冰箱
问想要求今年有多少个冰箱sold了，需要下述哪几个条件
1. 今年售出的冰箱是去年的3倍
2. 去年sold了40个冰箱
我的答案是两个条件都需要

#### 兴趣小组
假设人们可以有3种兴趣，且每人至少有一个
I. 135个人中，只有5个人有3种兴趣，有100个人有1种兴趣.
II. 400个人中，有35个人至少有2种兴趣
问，是否能得出exactly 2个兴趣的人数

只有I能得出

#### 哪天买车
conditions: 
I. Before 10/19/2009, not before 10/16/2009
II. after 10/17/2009, not later than 10/20/2009
问LILY哪天买的车？
选的I, II两个条件加一起可以得出

#### 今年生日
说小红this year的birthday是which day？.
I. It's on May 26th,May 27th being Wednesday.
II. It's not on Monday.
I only is sufficient。

#### 妹妹年龄
问妹妹今年多大啦？
I.妹妹比哥哥小xx岁
II.哥哥比妈妈小yy岁，妈妈zz年生的
I, II 加一起可以得出
### 阅读理解
这是个阅读理解题。应当掌握托福阅读理解的技巧。
阅读理解中，错误选项的设置，无非是
无中生有
张冠李戴
以偏概全

所以此题的解题技巧就是，先确定句子成分，找出关键概念，关键概念间的关系。
#### 销售员问题
Sales drives in big organizations, many a times, fall flat on the face. A research showed that an average buyer remembers only 20% of the things discussed during a sales call. 
The saddest part is that the sales team doesn’t get to choose what those 20% of things would be. The world today is cluttered with information and thus it is essential that the sales team represents their product/service in the best possible manner. 
It is like answering questions that children ask. Expect and out of context questions and reply to each one of them, patiently, in a way that the customers understand the intricacies. 
You can use technical terms to explain your product and its features. No doubt, it will be an accurate methodology but certainly not the right one. 
Simplify your message and see how well your client remembers you and your presentation when you meet him to finally close the deal.
1. A regular buyer would remember more than 20% of the details after a sales meeting
2. A customer is as gullible as a child and hence may ask many questions.
3. A better sales person would be the one who is able to explain the features of his/her product in a simple manner
4. If you simplify your message, the customer would remember your entire presentation.

#### 印度公司问题

It has been proven by research that in India, a company which purchases saturation radio advertising will get maximum brand recognition.
which option you can select:

1. A high degree of brand recognition will help a company win a higher share of the market.
2. Radio has wide listenership and companies intending to increase their awareness,should advertise it.
3. For maximum brand recognition, a company need not spend on media channels other than radio publicizing.
4. Brand recognition in India is more heavily dependent on where the brand advertises than the quality of its offering.

key conception: staturation advertising  <---> brand recognition
relationship : maximun

A option, brand recopgnitino <--> share of the market. wrong 张冠李戴
B option, radio advertiseing increase their awareness. right 
C option, not spend ohter than the radio.wrong. 无中生有
D option, Brand recognition <---> brand advertisers , quality. 无中生有。

#### 科幻小说 
有个fiction网站，是用来给科幻小说的读者来yy接下来桥段的，读者可以自己在上面续写科幻小说。比如哈利波特，如果哈利最开始没加入格兰芬多加入斯莱特林了呢？如果哈利没和好人做朋友而是成为马尔福集团的一份子了呢？
etc. 那么接下来剧情咋发展呢？有的作者觉得这个网站挺好的，因为可以受到启发，或者看看读者希望剧情如何发展。有的作者觉得这网站挺破的，因为你自己写故事为毛不自己新开一个坑写呢？而且还会干扰我思路。
1. 读科幻小说可以增加想象力。
2. 这个网站有好有坏。 
3. 网站上的同人使得原作黯然失色。
4. 作者们都反对这个网站。
选 有好有坏.

#### 气候与糖价
说由于气候和糖的种植者积极性（因为糖价低，大家不爱种）的原因，很多人都去选择种jute了。最近四年糖价回升，并与jute价格持平了。问能推出什么：
a. 糖农会回来继续种糖
b. 糖价会继续攀升
其他两个答案肯定不对，不记得了。
这题我选的是糖农会回来种糖。后来发现应该是糖价继续攀升。因为跟jute同价格的话，不会吸引糖浓回来，只有糖价高于jute之后，糖农才会回来。

#### 电子邮件
现在员工都喜欢查看和及时回复email，说是上班时候也喜欢是不是看手机，这种行为影响了deadline, process啥的， 我选的选项是email has an adverse affect on performance

#### motor效应
说小孩和大人学习，会cooking，针线活什么的，叫做motor效应？实习精准的肌肉永远。简直完美~~~ 然后5个判断，选正确的。我选的是ride a biking也是motor

#### 真人秀
真人秀 (答案： 参加的人通过做bizarre 的事情得到钱

#### 电视剧
电视剧制作人总弄一种套路： 一个美女，一个 tranditional女（长相平庸之类的），争一个帅哥（hero），套路都是 帅哥先跟美女好，后来发现美女没有心灵美，traditional女有， 后来就跟t女好了结婚了。 因为creator知道masses大众喜欢story 有complexity 并且能challenge一下happy ending的套路。选项全忘了。容易选

#### 恩爱生活
一男的周末喜欢在图书馆看书上网 他女票喜欢看 travel dramma 然后它们都爱运动 所以它们会一起去健身房， 晚上回来路上买蔬菜水果， 女的做饭男的在自己的library看书。 我选的选项是男的有一定数量的藏书。

#### 顾客所想
顾客不是很容易被操作，因为他们很清楚的知道别人跟他们想的不一样的。商店并不能get到顾客真正想要的

#### 课程表
排课表：有物理，化学，生物，然后有一些要求，问你能从哪些条件得出化学课排在哪一位，我选的是两个条件都要

#### UFO
一个是讲ufo的，很多目击ufo的照片啥的都证明是假的，所以很多人说ufo不存在，
但很多科学家认为不能否认不存在，选项是虽然有些照片是假的,但不能说明ufo不存在。

#### 星球疑云
科学家在Z星球发现了干涸的河床！科学家推断（speculate), 当时Z星球上存在累死地球的，atmosphere ，absorb heat from sun，然后星球上发生了一次可以把 atmosphere taken away 的事件, 使星球变成了 vacuum 状态，annihilating life.
问这些可以infer to:，我选的atmosphere 是support life的必要前提条件.

#### 外星人
有一道有关外星人的题目，大致是有很多人声称见到过飞碟和外星人， 有人甚至拍了照片，但有很多照片被证明是自然现象或是飞机卫星， 最后说也有很多其他证据说明外星人的存在。
（我选的是最后 一个， 尽管有很多照片被证明是假的，但也不能否定外星人存在的 可能性）
Case A-信息不足 case B-满足

#### 炒鱿鱼
Saira一直都是受同事们敬仰的一位好员工直到她因为bipola院合征带来的问题需要体假一段时间。不久后她就被炒鱿鱼了公司给出的理由是她的病情导致她工作效率低下并且会无意识地冒犯上级(bipoIar综合征的症状之一就是在无意识的情况下说各种话说个不停）。
而最终法院裁 定Salra被炒鱿鱼是因为公司相信了关于这种病的种种rn尹h（就是歧视）。问哪个选项是对的？（选 Saira被炒鱿鱼不是因为她自己有错其余几个选项都是空穴来风）l 

#### 作家和配图 
作家和网上配图什么的关系。 我选的是：这种行为对作家有好处也有坏处。

### 阅读理解大题
#### 环保公司问题
选择是否将候选公司放到一个环保list上，条件
1 have Environment Clearance Certificate ECC (一种认证)
2 developed at least 3 solar products.
3 none of their products are from synthetic 
4 headquater in Texas
5 have a grade A certified unit of its products.
6 not have any legal dispute ralated to land or forest, pending against them 
如果不满足2,但是有一种产品正在试验中:推荐给COO
如果不满足5:推荐给Director of the company

#### 录用 PM
一个公司要招PM，合理的candidate需满足以下条件:
1. 本科是学CS的
2. 有MBA学位
3. 本科GPA 3.0+
4. 如果没有MBA学位，但是工作5年以上，需上报HR
5. 本科不是学CS，但是在CS相关工作3年以上，上报HR 
那么，请问:闰土本科学热水锅炉维修的，GPA 4.0，没有念过MBA，在 Google修了5年的锅炉，当了3年的程序员，则应该: D
A. 录用
B. 不录用
C. 条件不充分
D. 上报HR

另一个条件:
1 候选人必须有硕士学位，且GPA为A
2 必须有两年以上工作经验，
3 若1不满足报告director 小明从事某工作三年，有CS和MBA，本科GPA为A-则:报告主管。
又一个条件条件是:
1 Master in commerce and at least B / have CPA 2 年龄大于20 ，小于25
3 流利的英语和西班牙语.
4 愿意付125刀押金
5 愿意承诺为公司工作5年
• 如果1不满足-> refer to M director
• 如果4不满足 -> refer to chair man .

#### 快递收费
快递费要不要收的问题。条件是
1 地区code 大于10一类，小于10 另一类
2 商品价格超过500
3 不是deal的时候买得
4 之前没有bulk 超过5%的折扣.
5 客户有优良购买记录3年
• 如果不满足2，那么要是他满足地区code小于10，收10刀，大于10，收8刀。
• 如果不满足3，那么region code小于10，收5刀，大于10，收12刀
• 若不满足两条，则必须付全款。

来了一个老头，买了150刀的东西，不是deal的时候买的，也没有之前折扣。问 他可不可以不付运费。
选:不满足两条，2,3 附全款30刀

第二个case, Emma, 从ABC买了4年，没有bulk discount, area code 08, 上个月买了150的东西，有2%special discount, 有dealership, 加粗的不满足，也交30

The following are the details of the procedure of deciding delivery charges for goods bought from ABC company. 
1. The customers are divided into two categories: those who have sales region code of 10 or above into one category and those with a code
2. must have bought goods worth $500 or more in the previous month
3. must not have dealership of any other similar company.
4. must not have availed bulk discount before
5. must have been provided a special discount of 5% or less than that in the previous dealings
6. must have been regularly ordering for more than 3 years
however,
7. if the customer fulfills all the conditions except (2), and if the sales region code is less than 10, delivery charges of $10 would be levied. Delivery charges of $8 would be levied for a code more than 10
8. if the candidate fulfills all the conditions except (3), and if the sales region code is less than 10, deliver charges of $5 would be levied. Deliver charges of $12 would be levied for a code more than 10.
9. If the customer does not fulfill 2 or more of the conditions stated above, then he/she would have to pay delivery charges of $30 irrespective of the sales region.

Q1. Jacob is a customer whose sales region code is 14. He had bought goods worth $150 from ABC company in June. He does not have dealership of any other similar company. He has never been provided any bulk discount or special discount.
A. He need not pay any delivery charges
B. He would have to pay $30 as delivery charges
C. has to pay $10
D. has to pay $8
E. Data insufficient

Q2. Emma is a customer whose sales region code is 08. She has been regularly ordering goods from ABC company for more than 4 years. She has also purchases goods worth $150 in the previous month. She has never been provided with any bulk discount, but has been given a special discount of 2%. However, she has dealership of some other similar company.
A. She need not pay any deliver charges
B. She would have to pay $30 as delivery charges
C. She has to pay $10
D. She has to pay $12
E. Data insufficient
####  四人位置
解题顺序：
step1: 先确定物体的位置，咖啡机和洗手间的和白板的位置。
step2: 再确定人的位置。

There are four coordinators named Lily, Cathy,Mary and Nina. Each coordinator is at a different corner of the rectangle meeting hall. A coffee vending machine is situated at one of the corners and a restroom at another corner of the meeting hall. Lily and Cathy are at either sides of the white board, which is situated at the center of the
side which is opposite to the side at whose corners the coffee vending machine and the restroom are located. Coordinator Mary is not at the corner where the restroom is located.

Q1. Which of the following cannot be true?
1 Lily is not on the side of the hall where the white board is placed
2 Nina is adjacent to the restroom at one corner
3 Cathy is at the corner, adjacent to the coffee vending machine.
4 Mary is adjacent to the coffee vending machine, at one corner of the hall 5 Lily is at the corner, adjacent to the coffee machine

Q2 which of the -hallowing pairs are at the diagonal corners .
Restroom and Nina 
(Nina and Lily) 
Mary and coffee vending machine 
Cathy and Lily Nina and Mary 


重点是这句“on either sides of the white board”，俩人分别在whiteboard的一侧， 而不是一定要在同一面hall的white board side.但是我觉得面经错了，L 和 C 必须再同一面墙上.
确定物体位置


```text
_________________________
| ?                   ?(R)|
| ||                      |
| ||(W)                   |
| ||                      |
| ?__________________ ?(V)|

确定人位置
___________________________
| C                   N(R)|
| ||                      |
| ||(W)                   |
| ||                      |
| L__________________ M(V)|

题目里如果提到了 “at one corner”，比如2和4，应该就是说在Nina跟restroom在同一个角落

错误:
__________________________
| N                   C(R)| 
| |                       |
| |(W)                    |
| |                       |
| L__________________ M(V)|
```

#### 八产品
A manufacture company has 8 products and 4 divisions. Four divisions are lead by Alan, Betty, Cathy, Diana. The 8 products are: mixer, iron, water pump, geyser, juicer, blender, grinder, and heater. Each division produces 2 products, no 2 divisions produces the same product. Diana’s division produced Geyser, Cathy’s division produces water pump. Mixer and iron areproduced by division lead by Alan and Betty respectively. The division that produces mixer doesn’t produce blender.
Four questions:
1. if the division that produces mixer doesn’t produce juicer, which of the following statement is true?
4. if the division that produces mixer also produces juicer,how many ways are there for product pairs? (3! = 6)
For factory problems, take care of the global assumptions andl ocal assumptions.

####  出差问题
说有M1,M2,M3,M4,M5和W1,W2,W3。出差必须派至少三男一女。M1和M3不能共存，M4和W2不能共存。
至少
第一问问如果派了M2和M3和W2，还可以派谁 (至少三男一女则M1和M4都不可能，所以M5, W1,W3) 
第二问问如果M1 M2去了，还可以派谁。(M5W2W1W3,M4W1W3,M5M4W1W3) 
第三问如果去了四个男生，那么谁不能选。(W2,因为M1和M3不能共存，则M4一定在，则W2不能在)

#### 圆桌问题
圆桌问题解题技巧：
不同于房子顺序问题，圆桌问题没有初始化的下标.
setp1: 找相邻，将确定连续相邻的字母确定为初始下标。如例题一中的(AGE) 或者 (EGA) 定为 下标 1,2,3
step2: 找对面，可能对面的位置(1,5) (2,6) (3,7) (4,8), BH面对面,BH只可能是4,8 或8,4
step3: 找间隔，C?F, C和F之间只可能是D.

得出圆桌类型：
AGE B CDF H, AE可互换，BH可互换.
 

一圆桌坐八人ABCDEFGH. F在C右边两位,AE坐G两边, BH面对面: 
• 问D对面是谁? G
• 以下哪两人坐对面? D&G
• 谁坐D旁边? C
• AB不坐隔壁, F对面坐A, 反时针方向可能的坐法? EGA H CDF B

 八角桌， B和H正对着，F在C的右边两个位置，A 和E在G的两 侧，C朝北。

A, B, C, D, E, F, G, H are sitting around a round table. ‘F’ is two places to the right of ‘C’. ‘A’ and ‘E’ are on either side of ‘G’. ‘B’ and ‘H’ are opposite to each other. ‘C’ is facing north.
Q1 Who is sitting opposite to ‘D’ ? G
Q2 以下哪两人坐对面? D&G.
Q3 谁坐D旁边? C. 
Q4 which of the following arrangements (in anti-clockwise) is possible?
A  AGEBDCFH
B  AGEBCDHF
C  AGEBCDFH
D  ABFDCHEG

#### 团团坐，排排坐问题
6人团团坐问题，有六个人 GASMNR, 注意理解 G, A，S 两两不能对坐，所以总体来说分两种情况，GAS三人间隔而坐，或者GAS全都挨着坐。所有团团做的问题都围绕此基础展开。有
Q1. If R 在A S 中间，问你R对面是谁(G)。
Q2. if G左右是A R,问A 对面是谁(M or N)。
Q3. if NAR 连着坐， M两边是谁(S & G). 
Q4. if NAR 连着坐， A对面是谁（M）


说甲乙丙丁排排坐，甲在乙右边，丙在丁右边，能不能推断粗谁最右。（不能）


####  七房间排序问题：
七房间排序问题解题技巧：七房间排序问题，和圆桌问题的不同之处在于，圆桌是没有初始位置下标的。
step1: 找相邻， 
step2: 找位置。
step3: 找间隔

有PQRSTUV7个房子，UP不能在2端，V在中间3个房子中的一个，TQ相邻，VR之间有2个，其中有一个是Q，QR不相邻，推测出位置就做出来，基于此题有4个问题。
VR之间有两个，Q在其中，TQ相邻，推出 VQTR，要注意取反, 或者 RTQV
V是中间三个房子中一个，决定了V一定在最中间,
又UP不能在两端，有一端必定是S.

S(UP)VQTR
RTQV(UP)S

UP可以互换

#### 石油公司招聘

Conditions for appointing a distributor, for petroleum gas throughout Georgia, are as follows. The applicant should:
Be an American by nationality
Be in the age group of 21-50 years as on 5th September, 2008
Be at least a high school graduate or any other recognized equivalent
Be a resident of Georgia. He/she should have stayed in Georgia for not less than 5 years, immediately preceding the date of application.
Have a family income of not more than $30,000 annually.
Not have dealership of any oil company
Not have any close relative as a dealer/distributor of any oil company
However,
Restrictions related to annual income would not be applicable to applicants working in corporations, owned or controlled by state departments. Such a case should be referred to the Managing Director
For unemployed applicants who hold at least a bachelor’s degree, conditions (6) and (7) may be waived
If an applicant is from a rural district but is not a resident of Georgia, the case may be referred to the Chairman.

Q1.William Trevino, who works in a public corporation owned by a state department, is an American by nationality. He is 23 years of age. He holds a bachelor’s degree and has an annual income of $35,000. He has been staying in Georgia for 7 years. Neither he nor any of his relatives works as a distributor or a dealer for any oil company.
He should be selected
He should not be selected
Insufficient data
The case should be referred to Managing Director
The case should be referred to the Chairman.
选Manager

Q2. Anna, a non-Georgia, American citizen, is a high school graduate with family income of $20,000 per annum. Her date of birth is 15.03.1985. she does not have dealership of any oil company nor des she has any close relative as a dealer or a distributor. She lives in a rural district.
She should be selected
She should not be selected. 
Insufficient data.
The case should be referred to Managing Director.
The case should be referred to the Chairman
选Chairman

#### 招聘工程师
An IT company has decided to recruit software developers. Conditions for selections of a candidate are as follows:
Should have at least a bachelor’s degree in engineering.
Should have scored at least 60% marks in his/her bachelor’s degree and 80% marks in 12th grade.
Must have at least 1 year’s work experience
Should be willing to sign a bond of 2 years.
Should not be more than 28 years and not less than 21 years of age as on 01.02.2012
However,
Candidates who fulfill all conditions except (1), but have obtained 75% in their bachelor’s degree (any computer applications degree like BCA) and have at least 3 years of work experience, may be referred to the Director
Who fulfill all conditions except (4), but are willing to pay an amount of $1000 as security deposit should be referred to the President
Who fulfill all conditions except (3), but are IT engineers may be referred to Deputy General Manager.
Alexander is an IT engineer with 65% marks in his bachelor’s degree and 88% marks in 12th grade. He completed his bachelor’s degree in engineer, in 2007 and immediately started working in a private firm. He is not ready to sign a bond but doesn’t mind paying a sum of $1000 as security deposit. He was 26 years old as on 01.01.2012
A He should not be recruited
B He should be recruited
C He should be referred to the President.
D He should be referred to the Deputy General Manager
E Data insufficient
小O，BCA 76%， 2年经验，不愿签两年bond，答案（直接拒了）

例题2.
挑候选人：条件是： 
1. Master in commerce and at least B / have CPA
2. 年龄大于20 ，小于25
3. 流利的英语和西班牙语. 
4. 愿意付125刀押金
5. 愿意承诺为公司工作5年
除了1都满足-> refer to Manager director. 
除了4都满足 -> refer to chairman .  
23岁， 有CPA，懂SPANISH, ENGLISH， 愿意付100刀deposit， 愿意5年undertaking (to chairman)
Master, 成绩A， 懂SPANISH, ENGLISH， 愿意5年undertaking， ready to pay the required amount as deposit. 生日是01.11.1994 (ACCEPT)

#### 比身高
有四个人R M K G(其实都有名字的，为了偷懒只记录了首字母)，哪个人最高？
给了两个条件：
1. M 比G高，但是M比R矮
2. K比M高
（这两个条件加起来也得不出来）.

#### 电商网站
Buyme和INXsell两个卖东西的网站。区别是Buyme允许买卖二手。人们可以在上面卖book, bike, treadmill. 卖家设最低价，买家竞价，最后标得最高价的人必须买下，否则可以采取司法程序处理。但Buyme对于拍卖的物品没有保障。INXsell可以直接从生产商购买产品。
A. 两个网站都是online buying and selling 的web-portals.
B. buyme上仅仅可以拍卖book, bike, treadmill这几样二手物品。
C. 两个网站唯一区别是，Buyme允许买二手物品
D. buyme上出售的物品lowest price可以低至0
E. 竞得最高价的人必须要买下商品

选E

#### 公司分配住宿
条件：
1至少10年在公司工作工作其中至少4年是manager 
2包括自己在内family人数不能超过5人 
3以58岁为退体年龄至少还要工作5年才能退休 
4没有自己的house 
5不能住在配偶mate spouse的house里 
6如果仅不满足1而且还是manager 的话上报给Finance Director 
7如果仅不满足3而且还是senior manager的话上报给Manager Director
8如果是从外地搬来的可以不满足条件1 
Q1 Jonh家里3个人,没有房子作为senior marager 4年,一共工作12年,2020年退休,问是否满足 
Q2 老王家里3个人租房子住，作为manager 5年, 工作 11年，年龄42岁。
Q3 第二问那个女的没说家里有几个人，所以我选了信息不足，关键在于children，这是复数，可能有2个孩子，也可能有4个孩子。


#### 想要获得promotion，给出以下10个条件：
1. 至少工作5年
2. 至少获得学士学位
3. 写作成绩不低于60
4. Group discussion成绩不低于65
5. Interview成绩不低于 60
6. 无犯罪记录
7. 年龄在30～45岁之间
8. 学术大于60. From 1point 3acres bbs
9. 如果不满足3，而且group discussion成绩不低于75，interview不低于70，上报给general manager.
10. 如果不满足8，上报给executive director

