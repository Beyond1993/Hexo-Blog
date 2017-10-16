---
title: Java-Gradle
date: 2017-10-16 05:46:50
categories: Java
tags:
---

构建：每一次Gradle的构建都包含一个或多个项目。

项目：是指我们的构建产物（比如Jar包）或实施产物（将应用程序部署到生产环境）。一个项目包含一个或多个任务。

任务：是指不可分的最小工作单元，执行构建工作（比如编译项目或执行测试）。

Gradle构建脚本（build.gradle）指定了一个项目和它的任务。

Gradle属性文件（gradle.properties）用来配置构建属性。

Gradle设置文件（gradle.settings）对于只有一个项目的构建而言是可选的，如果我们的构建中包含多于一个项目，那么它就是必须的，因为它描述了哪一个项目参与构建。每一个多项目的构建都必须在项目结构的根目录中加入一个设置文件。

默认的项目结构如下：

src/main/java目录包含了项目的源代码。

src/main/resources目录包含了项目的资源（如属性文件）。

src/test/java目录包含了测试类。

src/test/resources目录包含了测试资源。所有我们构建生成的文件都会在build目录下被创建，这个目录涵盖了以下的子目录，这些子目录我们会在这篇教程中提到，另外还有一些子目录我们会放在以后讲解。

classes目录包含编译过的.class文件。

libs目录包含构建生成的jar或war文件。

一：构建项目

gradle 没有自动生成目录的命令，但是 gradle 标准目录和maven 相同 

可以在build.gradle 里 增加一个task


task "create-dirs" << {
   sourceSets*.java.srcDirs*.each { it.mkdirs() }
   sourceSets*.resources.srcDirs*.each { it.mkdirs() }
}
执行 task 

gradle create-dirs



 在 src/main/java/net/petrikainulainen/gradle 下 创建文件



HelloWorld.java

package com.cmu.gradle;

public class HelloWorld {

    public static void main(String[] args) {
        System.out.println("Hello World!");
    }
}


在项目根目录下：

build.gradle：

apply plugin: 'java'
 
jar {
    manifest {
        attributes 'Main-Class': 'com.cmu.gradle.HelloWorld'
    }
}


gradle build  生成可执行文件 jar

gradle assemble 生成可执行文件 ,并打包依赖



二：打包依赖：



去maven 仓库 

http://mvnrepository.com/

找到包



repositories {
    mavenCentral()
}

dependencies {
    compile 'org.xerial:sqlite-jdbc:3.7.2'

}



依赖打包；将运行时的依赖打成完整的一个包，而不是放在jre/lib/ext目录下



apply plugin: 'java'
 
repositories {
    mavenCentral()
}
 
dependencies {
    compile 'log4j:log4j:1.2.17'
    testCompile 'junit:junit:4.11'
}
 
jar {
    from { configurations.compile.collect { it.isDirectory() ? it : zipTree(it) } }
    manifest {
        attributes 'Main-Class': 'net.petrikainulainen.gradle.HelloWorld'
    }
}
 

据说可以这样 但是，报错



Cannot convert the provided notation to a File or URI: [ZIP '/home/wanye/Desktop/java/jdbc-sqlite/libs/sqlite-jdbc-3.8.11.2.jar'].

The following types/formats are supported:

  - A String or CharSequence path, for example 'src/main/java' or '/usr/include'.

  - A String or CharSequence URI, for example 'file:/usr/include'.

  - A File instance.

  - A URI or URL instance.


