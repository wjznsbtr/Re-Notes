# mielecrackme

## 0x00

首先查找参考文本字串，发现cannabis可能为序列号，以下开始验证是否正确。

作者提示到，lstrcmpA这个函数会直接进行字符串的比较，直接ctrl+N搜索这个函数并设置断点

![image-20251008222654846](mielecrackme1.assets/image-20251008222654846.png)

F9运行，输入cannbis，程序duan'z