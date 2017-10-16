---
title: Python-Nummy
date: 2017-10-16 05:30:25
categories: Python
tags:
---

一、概述
Python 里 numpy，scipy,matplotlib,scikit-learn 是常用的三个库。
numpy :        运算矩阵。通过数组形式将Python循环放入C语言中，加快循环速度。

scipy：         信号处理及数值计算的一些工具。

scikit-learn：机器学习相关的算法（如聚类算法，SVM等）。

matplotlib：一个画图工具。

二、安装

Ubuntu 下的安装




sudo apt-get install python-numpy o

sudo apt-get install python-scipy


sudo apt-get install python-matplotlib o

sudo apt-get install python-sklearn o



使用pip

 pip install sklearn



这次跑我涛的PCA，用到了mahout 这个机器学习工具。

但每次跑必须要

mahout hadoop jar newPCA-team022-0.1-latest.jar  originalMatrixData/testdatas.txt output tmpdir

可是 mahout 并没有hadoop 这个算法。所以觉的很奇怪。



运行：

$ hadoop jar newPCA-team022-0.1-latest.jar  originalMatrixData/testdatas.txt output tmpdir

报错：Exception in thread "main" java.lang.NoClassDefFoundError: org/apache/mahout/math/Matrix



编译通过，运行找不到类，应该是动态加载类找不到的问题。



对于hadoop 来说，有以下解决方法：

一。直接把类扔到 hadoophome/share/hadoop/common/lib 文件下，此方法有效，但要是每个节点都这样放就很麻烦。

二。

（1） 在运行脚本中添加classpath.

在$HADOOP_HOME/conf/hadoop_env.sh 或者$HADOOP_HOME/bin/hadoop-config.sh中添加：

export HADOOP_CLASSPATH=$HADOOP_HOME/my_jars

然后将你自己的jar包和第三方jar包分发到各个TaskTracker的HADOOP_CLASSPATH目录下（别忘了所有TaskTracker上的hadoop_env.sh和hadoop-config.sh均按以上方法添加HADOOP_CLASSPATH环境变量）

【注】hadoop_env.sh和hadoop-config.sh是所有hadoop运行脚本（start-all.sh, start-dfs.sh等）一定会引用的配置脚本，可以将一些最基本的环境变量或者配置参数加到这两个文件中。

三。

 使用“-libjars“参数，支持这个功能，需要按照如下方式编写Hadoop程序：

public class MyHadoopJob extends Configured implements Tool {

 

   public static class  MapClass

 

      extends Mapper{

 

      //your mapper

 

   }

 

   public static class  Reduce

 

      extends  Reducer{

 

      //your reducer

 

   }

 

//设定并读取应用程序相关的，自己定义的一些参数

 

   public int run(String[] args)  throws Exception {

 

      if(args.length < 2) {

 

         printUsage();

 

        return 2;

 

    }

 

   Job job = new Job(getConf());

 

   …......

 

   }

 

   //真正的main函数

 

   public static void main(String[] args) throws  Exception{

 

      int  res = ToolRunner.run(new Configuration(), new SleepJob(), args);

 

      System.exit(res);

 

   }

 

}

运行作业：

#run_myjob.sh

bin/hadoop jar myjob.jar MyHadoopJob \

-D mapred.job.name=MyHadoopJob \

-D mapred.map.tasks=24 \

-D mapred.mreduce.tasks=12 \

-D mapred.input.dir=/test/input1,test/input2 \

-D mapred.output.dir=/test/output \

-libjars myjob.jar,third-party.jar

-my1 5 \

-my2 china

运行./run_myjob.sh

其中 “-libjars“指定本地两个jar文件，Hadoop自动会把这两个文件分发到各个TaskTracker的临时工作目录下，用完后自动删除。

3. 解决方案比较

第一种方法过于笨拙，每次都要人工地将jar包分发到各个TaskTracker上，如果集群很大，非常耗时；第二种方法利用了Hadoop内部机制进行jar包分发，非常方便。实际上，在Hadoop example中，除了WordCount例子外，其他所有例子均采用了方案2的设计方法。



四。可以尝试这段代码

if (line.hasOption("libjars")) {  

  conf.set("tmpjars",   

           validateFiles(line.getOptionValue("libjars"), conf));  

  //setting libjars in client classpath  

  URL[] libjars = getLibJars(conf);  

  if(libjars!=null && libjars.length>0) {  

    conf.setClassLoader(new URLClassLoader(libjars, conf.getClassLoader()));  

    Thread.currentThread().setContextClassLoader(  

        new URLClassLoader(libjars,   

            Thread.currentThread().getContextClassLoader()));  

  }  

}

参考链接：http://dongxicheng.org/mapreduce/run-hadoop-job-problems/
