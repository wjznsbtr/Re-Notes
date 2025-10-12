# crakmeeasy

ctrl + N查看API列表，对两个熟悉的函数“GetDlgItemTextA”和“MessageBoxA”设下断点。

F9运行，随便输入一个序列号并单击check。

![image-20251012195424442](crakmeeasy.assets/image-20251012195424442.png)

程序断在GetDlgItemTextA，从堆栈窗口中可以看到

![image-20251012200206526](crakmeeasy.assets/image-20251012200206526.png)

我们输入的序列号将要存储在“02500A30”地址，在数据窗口中跟随，执行到返回并按F7回到主程序，可以看到我们的序列号保存到该缓冲区

![image-20251012200404825](crakmeeasy.assets/image-20251012200404825.png)

接下来看看程序时如何对序列号进行处理的。

![image-20251012200650453](crakmeeasy.assets/image-20251012200650453.png)

我们看到一个字符串10445678951，该字符串可能和序列号有关。

首先程序将字符串保存到eax中

![image-20251012200844620](crakmeeasy.assets/image-20251012200844620.png)

然后，下面黄框处代码是将eax中的字符串4个字节为一组，依次存到指定内存地址

![image-20251012201555391](crakmeeasy.assets/image-20251012201555391.png)

之后lea指令将字符串尾部地址存到eax中

![image-20251012202101427](crakmeeasy.assets/image-20251012202101427.png)

以上是对字符串的存储。

后面调用memset函数，有三个参数

![image-20251012202725916](crakmeeasy.assets/image-20251012202725916.png)

分别是n（需要填充的字节数），s（待填充内存单元的起始地址）和c（待填充的值）。

F8步过该函数，可以看到字符串后面8个字节都被0填充。









