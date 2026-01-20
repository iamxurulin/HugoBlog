---
title: "Java中的Exception和Error有什么区别"
date: 2025-12-24 16:50:46
categories:
- 八股
tags:
  - Java
draft: false
---

在Java中，Exception和Error两者都是**Throwable**类的子类。

总体上来说，**Exception**是指可以被处理的程序异常，属于业务逻辑的范畴，常见的异常有NullPointerException和IOException等等；

而**Error**则指的是系统级的不可恢复的错误，错误出现以后一般就意味着进程需要终止或者重启，常见的错误有OutOfMemoryError、StackOverflowError等等。

如果细分的话，Exception又可以分为Checked Exception和Unchecked Exception，也就是**受检异常**和**非受检异常**。

常见的**受检异常**有IOException和SQLException，它们都是从Exception继承过来但是并不继承RuntimeException，在编译的时候必须使用try-catch块或者throws声明进行抛出这样的显式处理。

而**非受检异常**如NullPointerException和IndexOutOfBoundsException都是继承自RuntimeException，它们就不需要进行显式的处理，而是运行的时候才会抛出。

### 异常处理时需要注意的点：

1.如果什么异常都使用通用Exception，而不是特定的异常，那么其他同事在分析这段代码时就无法一眼看出这段代码**实际想要捕获的异常**。

所以，尽量**不要捕获类似于Exception这样的通用异常，而应该捕获特定的异常**。


2.如果我们在捕获异常之后不把异常进行抛出或者使用catch之后再用e.printStackTrace()输出一个标准错误流，这样操作的话也许这只是一个非常简单的bug，但是你仍然不知道是哪里出错了以及出错的原因。

所以，我们可以按需自定义一定的格式，**将详细的信息输入到日志系统中，这样的话便于后续进行错误的排查**。

3.想象这样一种场景，如果一个方法，这个方法内部调用了其他好几个方法，现在这个最开始的方法的某个参数传入了一个null值，但是，你并没有立刻处理这个情况，而是在这个最开始的方法调用了好几个方法之后才爆出这里其实最开始就有一个空指针。

这样就会造成其实你明明只需要在最开始只抛出一点点信息就能够定位到这个错误所在的地方，但是当最开始的方法调用了其他好几个方法之后你再抛出的可能就是很多的堆栈信息。

因此 ，最好**不要延迟处理异常**。

4.try-catch中的代码会影响JVM对代码的优化，因此，使用try-catch块时，不推荐try住一大段代码，而是在必要的代码段使用try-catch，也就是说**try-catch的范围应该尽量小**。

5.在控制程序的流程这一块，我们一般采取的原则是能用if/else语句来控制的话就不要用异常，直白点说就是**不要通过异常来控制程序的流程**。

6.在finally中return或者处理返回值往往会发生覆盖try中的return的情况，因此，最好**不要在finallly中处理返回值或者return**。
