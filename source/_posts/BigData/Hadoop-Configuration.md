---
title: Hadoop-Configuration
date: 2017-10-16 05:39:37
categories: Bigdata
tags:
---


http://www.powerxing.com/install-hadoop/

o环境 ：ubuntu 16.04   ， Hadoop 2.4.0 java-8-openjdk-amd64

o

o一.hadoop三种安装模式

o1，单机模式：Hadoop的默认模式。当首次解压Hadoop的源码包时，Hadoop无法了解硬件安装环境，便保守地选择了最小配置。在这种默认模式下所有3个XML文件均为空。当配置文件为空时，Hadoop会完全运行在本地。因为不需要与其他节点交互，单机模式就不使用HDFS，也不加载任何Hadoop的守护进程。该模式主要用于开发调试MapReduce程序的应用逻辑， 而不会与守护进程交互，避免引起额外的复杂性。（选自 hadoop in action）

o

o2.伪分布模式：在“单节点集群”上运行hadoop，所有守护进程运行于同一台主机上，但此时Hadoop将使用分布式文件系统，而且各jobs也是由JobTracker服务管理的独立进程。同时，由于伪分布式的Hadoop集群只有一个节点，因此HDFS的块复制将限制为单个副本，其secondary-master和slave也都将运行于本地主机。此种模式除了并非真正意义的分布式之外，其程序执行逻辑完全类似于完全分布式，该模式在单机模式之上增加了代码调试功能，允许你检查内存使用情况，HDFS输入输出，以及其他的守护进程交互，因此，常用于开发人员测试程序执行。



3.全分布模式：真正的分布式集群。



二.现采用伪分布模式：

1,下载hadoop 2.0.4

2,配置环境变量：

ovim ./.bashrc

export HADOOP_HOME=/home/wanye/softWare/hadoop-2.4.0

export PATH=$PATH:$HADOOP_HOME/bin

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$CLASSPATH

export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH

source ./.bashrc

o3.配置hadoop 

o

o进入hadoop2.4.0文件夹，配置etc/hadoop中的文件。

ohadoop-env.sh

oexport JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64

o另外可选的添加上：

oexport HADOOP_COMMON_LIB_NATIVE_DIR=${HADOOP_HOME}/lib/native

oexport HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib"

o

ocore-site.xml，做如下配置：





 

       fs.default.name 

       hdfs://127.0.0.1:9000 

    



   

dfs.namenode.name.dir

file:/homewanye/softWare/hadoop-2.4.0/dfs/name







dfs.datanode.data.dir

   file:/home/wanye/softWare/hadoop-2.4.0/dfs/data

   









ohdfs-site.xml，做如下配置（系统默认文件保存3份，因伪分布模式，故改为1份）：



o

 

dfs.replication

1





dfs.namenode.name.dir

/home/wanye/softWare/hadoop-2.4.0/dfs/name





dfs.datanode.data.dir

/home/wanye/softWare/hadoop-2.4.0/dfs/data







o/*mapred-site.xml,做如下配置：



o                mapreduce.jobtracker.address 

               localhost:9001 

         

o这里2.4.0中没有这个文件，可以新建一个

o*/

o

o或者直接修改mapred-site.xml.template





mapreduce.framework.name

   yarn







yarn-site.xml，如下配置：



mapreduce.framework.name

yarn





yarn.nodemanager.aux-services

mapreduce_shuffle



o

o

o三.ssh免密码 登陆 ( 并没有设置)

o四.开始测试

o$HADOOP_HOME/bin/hadoop namenode –format格式化结点信息

最后一句出现shutting down什么玩意，中间没有warn或者fatal error应该就对了。

第二步：然后，开始$HADOOP_HOME/sbin/start-all.sh.

o

http://localhost:50070/

o出现页面即为成功。

o

o

o(1)执行命令jps会有5个进程，分别是NameNode、

oDataNode、SecondaryNameNode、JobTracker,

oTaskTracker

但我只看到两个进程，查看log文件



报错和解决方案



o2016-04-24 19:02:33,942 WARN org.apache.hadoop.util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable

odatanode.log:

ojava.lang.VerifyError: class org.apache.hadoop.hdfs.protocol.proto.ClientDatanodeProtocolProtos$RefreshNamenodesResponseProto overrides final method getUnknownFields.()Lcom/google/protobuf/UnknownFieldSet;

at java.lang.ClassLoader.defineClass1(Native Method)

at java.lang.ClassLoader.defineClass(ClassLoader.java:763)

at java.security.SecureClassLoader.defineClass(SecureClassLoader.java:142)

at java.net.URLClassLoader.defineClass(URLClassLoader.java:467)

at java.net.URLClassLoader.access$100(URLClassLoader.java:73)

at java.net.URLClassLoader$1.run(URLClassLoader.java:368)

at java.net.URLClassLoader$1.run(URLClassLoader.java:362)

at java.security.AccessController.doPrivileged(Native Method)

at java.net.URLClassLoader.findClass(URLClassLoader.java:361)

at java.lang.ClassLoader.loadClass(ClassLoader.java:424)

at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:331)

at java.lang.ClassLoader.loadClass(ClassLoader.java:357)

at org.apache.hadoop.hdfs.protocolPB.ClientDatanodeProtocolServerSideTranslatorPB.(ClientDatanodeProtocolServerSideTranslatorPB.java:63)

at org.apache.hadoop.hdfs.server.datanode.DataNode.initIpcServer(DataNode.java:411)

at org.apache.hadoop.hdfs.server.datanode.DataNode.startDataNode(DataNode.java:743)

at org.apache.hadoop.hdfs.server.datanode.DataNode.(DataNode.java:281)

at org.apache.hadoop.hdfs.server.datanode.DataNode.makeInstance(DataNode.java:1878)

at org.apache.hadoop.hdfs.server.datanode.DataNode.instantiateDataNode(DataNode.java:1772)

at org.apache.hadoop.hdfs.server.datanode.DataNode.createDataNode(DataNode.java:1812)

at org.apache.hadoop.hdfs.server.datanode.DataNode.secureMain(DataNode.java:1988)

at org.apache.hadoop.hdfs.server.datanode.DataNode.main(DataNode.java:2012)

o然而并没解决！

o之前用hadoop 搭建伪分布模式，一直起不来5个进程，报错。

o今天用hadoop 跑 涛哥的PCA，又报错！相同的错，怒了，没办法，只有少侠重新来过了。

o

o下载，解压：

o$ cd ~/softWare/

o$ wget https://archive.apache.org/dist/hadoop/core/hadoop-2.4.0/hadoop-2.4.0.tar.gz

o$ tar xzvf hadoop­2.4.0.tar.gz

o直接下载特别慢，但是可以用aws作为文件中转 共133M

o

o导入环境变量（要设好jdk)：

o

oexport HADOOP_HOME=/home/wanye/softWare/hadoop-2.4.0
export PATH=$PATH:$HADOOP_HOME/bin

o

o
o

o最后别忘了 source ~/.bashrc 使配置生效

o

最后我把/jre/lib/ext 里关于 mahout 的包全部拿出来了，就好了！ 所以在配置java 项目时，不要图方便把需要的包放入系统里，可能会有冲突。要单独配置，加环境变量
