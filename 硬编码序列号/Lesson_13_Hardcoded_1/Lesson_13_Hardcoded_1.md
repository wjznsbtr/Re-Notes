# Leccion 13 HARDCODED 1 

## 0x00查找序列号

既然是硬编码序列号，那么序列号字符串肯定出现在程序中，在反汇编窗口单击右键，查找所有参考文本字串。

![image-20251004131031079](C:\Users\wjzns\Desktop\Notes\硬编码序列号\Lesson_13_Hardcoded_1\Lesson_13_Hardcoded_1.assets\image-20251004131031079.png)

第一个很有可能就是我们想要的序列号。

## 0x01验证序列号

为了验证该序列号是否正确，打开API列表

![image-20251004133901619](C:\Users\wjzns\Desktop\Notes\硬编码序列号\Lesson_13_Hardcoded_1\Lesson_13_Hardcoded_1.assets\image-20251004133901619.png)

看到了我们熟悉的GetDlgItemTextA函数和MessageBoxA函数，给两个函数设置断点，按下F9运行CrackMe。

我们随便输入一个序列号，单击“Verificar”

![image-20251004134345144](C:\Users\wjzns\Desktop\Notes\硬编码序列号\Lesson_13_Hardcoded_1\Lesson_13_Hardcoded_1.assets\image-20251004134345144.png)

程序在GetDlgItemTextA处中断

![image-20251004134511576](C:\Users\wjzns\Desktop\Notes\硬编码序列号\Lesson_13_Hardcoded_1\Lesson_13_Hardcoded_1.assets\image-20251004134511576.png)

该函数用于获取序列号，获取后保存在Buffer中，在Bufffer处右键，选择数据窗口中跟随。

由于设置了断点，地址403010还没有任何数据

![image-20251004135049206](C:\Users\wjzns\Desktop\Notes\硬编码序列号\Lesson_13_Hardcoded_1\Lesson_13_Hardcoded_1.assets\image-20251004135049206.png)

我们执行到该函数返回，现在可以在数据窗口中看到我们刚刚输入的序列号

![image-20251004135216237](C:\Users\wjzns\Desktop\Notes\硬编码序列号\Lesson_13_Hardcoded_1\Lesson_13_Hardcoded_1.assets\image-20251004135216237.png)

按下F7返回到主线程。

![image-20251004135254582](C:\Users\wjzns\Desktop\Notes\硬编码序列号\Lesson_13_Hardcoded_1\Lesson_13_Hardcoded_1.assets\image-20251004135254582.png)

看到这里是比较明显的比较跳转指令，会根据序列号判断跳转到哪个MessageBoxA。

分析一下代码，代码会把序列号前四个字节存入ebx，再把它与403008处dword内容(FIAC)进行比胶，如果相等，那么0标志位被置1，跳转到401087，即弹出正确消息框，否则弹出错误消息框。

因此输入qwertyuiop后，会弹出错误提示框。

按下F9，弹出Mal Muy Mal（错误）。输入正确序列号（FIAC）再试一遍

![image-20251004140154112](C:\Users\wjzns\Desktop\Notes\硬编码序列号\Lesson_13_Hardcoded_1\Lesson_13_Hardcoded_1.assets\image-20251004140154112.png)

弹出正确提示框