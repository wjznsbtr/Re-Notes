# Crackme01

## 0x00 入口点：

![Snipaste_2025-09-23_19-23-31](C:\Users\wjzns\Desktop\Notes\CrueHead'а Crackme\Crackme01.assets\Snipaste_2025-09-23_19-23-31.png)

通过状态栏得知入口点为**401000**

## 0x01

![Snipaste_2025-09-23_22-11-05](C:\Users\wjzns\Desktop\Notes\CrueHead'а Crackme\Crackme01.assets\Snipaste_2025-09-23_22-11-05.png)

输入注册码后，程序弹出窗口，提示是否正确，因此可以从**MessageBox**着手分析。Ctrl+N找到MessageBoxA函数，右键反汇编窗口中跟随，发现函数位于**user32**模块，地址为**763F05B0**。

![Snipaste_2025-09-23_22-21-01](C:\Users\wjzns\Desktop\Notes\CrueHead'а Crackme\Crackme01.assets\Snipaste_2025-09-23_22-21-01.png)

在命令栏中输入bp MessageBoxA给该函数设置断点，并在retn 10处也设置一个。按下F9运行起来，输入名称和序列号

![Snipaste_2025-09-23_22-30-29](C:\Users\wjzns\Desktop\Notes\CrueHead'а Crackme\Crackme01.assets\Snipaste_2025-09-23_22-30-29.png)

单击确定。提示断点位于user32.MessageBoxA

![Snipaste_2025-09-23_22-31-48](C:\Users\wjzns\Desktop\Notes\CrueHead'а Crackme\Crackme01.assets\Snipaste_2025-09-23_22-31-48.png)

此时我们可以在堆栈中看到函数的四个参数值，其中hOwner为父窗口句柄，Text为要显示的消息，Title是对话框标题，Style即风格。其他相关内容参考

https://learn.microsoft.com/zh-cn/windows/win32/api/winuser/nf-winuser-messageboxa



根据stdcall的调用约定,API的参数通常从右至左的在堆栈中排列，堆栈的顶部存放返回地址，这里是004013C1

![Snipaste_2025-09-23_22-33-25](C:\Users\wjzns\Desktop\Notes\CrueHead'а Crackme\Crackme01.assets\Snipaste_2025-09-23_22-33-25.png)

可以看到Text值是 No luck there,mate!，以及Title为 No luck！这说明我们输入的命名或序列号不正确。

按下F9，单击是，程序停在retn 10处。retn 10意味着除了堆栈指针向高地址移动4字节，esp还要增加10h，加起来esp一共增加20。按下F7，查看esp的值

![Snipaste_2025-09-23_22-56-46](C:\Users\wjzns\Desktop\Notes\CrueHead'а Crackme\Crackme01.assets\Snipaste_2025-09-23_22-56-46.png)

发现与推测一致，并且MessageBoxA函数的堆栈空间也被清理

按下F9，断点再次出发并弹出No luck！提示框，从堆栈窗口中看到返回地址是40137D，右键该地址，选择反汇编窗口中跟随。

根据窗口消息内容可以猜测：提示正确与提示错误都会调用MessageBoxA函数，相关判断代码逻辑紧凑，两者汇编代码相距不远。

![Snipaste_2025-09-28_22-29-23](C:\Users\wjzns\Desktop\Notes\CrueHead'а Crackme\Crackme01.assets\Snipaste_2025-09-28_22-29-23.png)

可以看到有两个MessageBoxA的调用，其中开始于40134D的对应Good Work，开始于401362的对应No luck。

![Snipaste_2025-09-28_22-54-56](C:\Users\wjzns\Desktop\Notes\CrueHead'а Crackme\Crackme01.assets\Snipaste_2025-09-28_22-54-56-1759072712733-14.png)

突出显示401362一行，提示本地调用来自00401245，右键转到401265，看看发生了什么

![Snipaste_2025-09-28_22-59-24](C:\Users\wjzns\Desktop\Notes\CrueHead'а Crackme\Crackme01.assets\Snipaste_2025-09-28_22-59-24.png)

看到了熟悉的401362和40134D。由此可见，这是判断显示No luck还是Good work提示框的比较代码。

因此在上面一行跳转处按下F2设置断点。同时单击工具栏中b按钮，删除对MessageBoxA函数的断点。

![Snipaste_2025-09-28_23-04-54](C:\Users\wjzns\Desktop\Notes\CrueHead'а Crackme\Crackme01.assets\Snipaste_2025-09-28_23-04-54.png)

按下F9，输入名称和序列号，并点击确定，跳转没有发生，因为eax与ebx不相等，所以执行call 401362这行，弹出No luck提示框。

![Snipaste_2025-09-28_23-10-43](C:\Users\wjzns\Desktop\Notes\CrueHead'а Crackme\Crackme01.assets\Snipaste_2025-09-28_23-10-43.png)

我们知道je是判断结果为1才跳转，如果我们把Z修改为1，跳转就可以实现

![image-20250929163901484](C:\Users\wjzns\Desktop\Notes\CrueHead'а Crackme\Crackme01.assets\image-20250929163901484.png)

如图所示，弹出Good Work消息框。然而，我们注意到代码中有两处Noluck提示框，CrackMe当名称中包含数字的时候会提示No  luck消息框,当序列号错误的时候还会提示No luck消息框。

我们输入带有数字的名称，弹出Noluck消息框，单击ok，代码在je处中断。F9后，又弹出No luck消息框，点击确定。与教程不同的是我这里堆栈窗口并没有显示返回地址为4013C1。暂时先往下看

![image-20250929194051834](C:\Users\wjzns\Desktop\Notes\CrueHead'а Crackme\Crackme01.assets\image-20250929194051834.png)

我们看到该跳转来自40138B，而40138B下面是很多跳转和比较指令，在此处设置断点。

F9让程序运行起来，输入名称和序列号，点击确定。接下来一直按f9，发现只有检测到数字的时候才会弹No luck

以下是循环检测的逻辑和代码：

```
将输入的字符串从左到右依次提取出来，保存至al中，进行检测。

检测到值为空，关闭窗口

检测到小写字母，会给对应的ascll码减去20h，转换成大写字母，之后esi+1，检测下一个字符；

检测到数字或特殊字符，跳转到4013AC，弹No luck；
```

![image-20250929221249018](C:\Users\wjzns\Desktop\Notes\CrueHead'а Crackme\Crackme01.assets\image-20250929221249018.png)

因此关键在于程序对数字或特殊字符的检测，上面提到al小于0x41的时候，cmp al,0x41指令导致C标志位被置1从而引发跳转，那么我们可以在检测数字时将C标志位置0，这样跳转就不会发生了。接下来，我们再把0标志位置1，实现跳转。

![image-20250929221709209](C:\Users\wjzns\Desktop\Notes\CrueHead'а Crackme\Crackme01.assets\image-20250929221709209.png)

但我们不能每次都修改标志位的值，所以我们需要通过程序补丁的方式，确保每次都可以弹Good Work消息框。

这里我们把40138B处代码改为nop，而401243处代码需要完成跳转，把je改为jmp即可。

再打开断点窗口，删除两处的断点，最后在反汇编窗口右键把所有修改保存到可执行程序，就算大功告成了。

![image-20250929222918136](C:\Users\wjzns\Desktop\Notes\CrueHead'а Crackme\Crackme01.assets\image-20250929222918136.png)