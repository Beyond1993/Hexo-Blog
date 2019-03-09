---
title: CMU-18645-Learn-CUDA
date: 2017-12-13 19:39:29
categories: CMU
tags:
---
http://bbs.csdn.net/topics/390798229
http://notes.maxwi.com/2015/06/11/CUDA-study-notes/

CUDA is an extension to C/C++ that  allows programming of NVIDIA GPUs
-- language extensions for defining kernels
-- API functions for memory management

NVIDIA GPUs have a  2-level hierarchy
-- Multiple Streaming Multiprocessors(SMs), each with multiple cores

In CUDA this is abstracted as Grid of Thread Blocks

CUDA introduces a new dim3 type


主要概念与名称
主机
        将CPU及系统的内存（内存条）称为主机。
设备
        将GPU及GPU本身的显示内存称为设备。
线程(Thread)
        一般通过GPU的一个核进行处理。（可以表示成一维，二维，三维，具体下面再细说）。
线程块(Block)
1. 由多个线程组成（可以表示成一维，二维，三维，具体下面再细说）。
2. 各block是并行执行的，block间无法通信，也没有执行顺序。
3. 注意线程块的数量限制为不超过65535（硬件限制）。
线程格(Grid) 由多个线程块组成（可以表示成一维，二维，三维，具体下面再细说）。

线程束(warp)
在CUDA架构中，线程束是指一个包含32个线程的集合，这个线程集合被“编织在一起”并且“步调一致”的形式执行。在程序中的每一行，线程束中的每个线程都将在不同数据上执行相同的命令。
核函数（Kernel）
1. 在GPU上执行的函数通常称为核函数。
2. 一般通过标识符__global__修饰，调用通过<<<参数1,参数2>>>，用于说明内核函数中的线程数量，以及线程是如何组织的。
3. 以线程格（Grid）的形式组织，每个线程格由若干个线程块（block）组成，而每个线程块又由若干个线程（thread）组成。
4. 是以block为单位执行的。
5. 叧能在主机端代码中调用。
6. 调用时必须声明内核函数的执行参数。
7. 在编程时，必须先为kernel函数中用到的数组或变量分配好足够的空间，再调用kernel函数，否则在GPU计算时会发生错误，例如越界或报错，甚至导致蓝屏和死机。

![](/images/CUDA.png)


__host__ 
__device__
__global__
__shared__

有时候会看见CUDA 有 __host__ __device__ 修饰同一个函数

Sometimes the same functionality is needed in both the host and the device portions of CUDA code. To avoid code duplication, CUDA allows such functions to carry both __host__ and __device__ attributes,


4.9 共享内存： CUDA可以在声明时通过__shared__关键字,使变量驻留在共享内存中。共享内存中的变量可以被同一线程块中的线程所共享，所以可以通过共享内存来实现同一线程块中的线程之间进行通信，且共享内存位于物理GPU上，其访问延迟要远远低于普通缓冲区。使用方法即是将__shared__添加到变量声明中。


当需要多个线程块并且每个线程块又包含多个线程时，索引计算方法为：int tid = threadIdx.x + blockIdx.x * blockDim.x;，其中索引tid相当于一个以线程块为行，线程为列的二维集合中某格所在的索引值。所以threadIdx.x表示当前线程所在线程块中某行的索引，blockIdx.x表示线程块索引，blockDim.x表示每个线程块中的线程数量。gridDim.x表示当前线程格中线程块的数量，线程格其实就是当前正在运行的线程块集合。如下图所示:
![](http://notes.maxwi.com/2015/06/11/CUDA-study-notes/tid.jpg)
![](http://notes.maxwi.com/2015/06/11/CUDA-study-notes/threads_organization.jpg)

关于偏移量

int objectId = blockIdx.x * blockDim.x + threadIdx.x;

先确定 blockId.x, 再确定  blockDim.x, 最后确定 threadIdx.x。

不同维度的built-in variable
gridDim
   This variable is of type dim3 (see SecIon B.3.2) and contains the dimensions of the grid.
blockIdx
   This variable is of type uint3 (see SecIon B.3.1) and contains the block index within the grid.
blockDim
   This variable is of type dim3 (see SecIon B.3.2) and contains the dimensions of the block.
threadIdx
   This variable is of type uint3 (see SecIon B.3.1) and contains the thread index within the block.
warpSize
   This variable is of type int and contains the warp size in threads (see SecIon 4.1 for the
definiIon of a warp).



在我们的作业k-means 中，用这样一段代码， 使得每一个 object 都对应了，一个线程. 
