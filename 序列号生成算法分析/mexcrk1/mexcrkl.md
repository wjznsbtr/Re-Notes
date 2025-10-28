# mexcrkl

先执行到crack1模块，然后查找字符串

![image-20251028200321402](mexcrkl.assets/image-20251028200321402.png)

找到Benadry1，进去看看

![image-20251028200405403](mexcrkl.assets/image-20251028200405403.png)

看到je指令跳转到正确status，因此上面的call指令决定je是否跳转。

在call指令处打断点，跟进去，发现代码时直接比较输入的序列号与正确序列号是否相同，所以正确序列号时Benadryl

![image-20251028200646337](mexcrkl.assets/image-20251028200646337.png)

![image-20251028200733728](mexcrkl.assets/image-20251028200733728.png)

提示输入正确。