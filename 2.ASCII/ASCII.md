# ASCII：字母输出与循环（ASCII1～ASCII3）

## 一、题目与实现

输出26个小写英文字母，每行13个：

```text
abcdefghijklm
nopqrstuvwxyz
```

| 版本 | 实现方式 | 本次关注点 |
|---|---|---|
| ASCII1（8086） | 双重循环，使用`LOOP`控制次数 | `CX`既是循环计数器，嵌套时需要保存外层`CX` |
| ASCII2（8086） | 使用`CMP`和条件跳转代替`LOOP` | 计数器更新、比较结果和跳转边界 |
| ASCII3（C/x64） | 两层`for`循环输出字符 | C语句与`CMP/Jcc`、局部变量、函数调用的对应关系 |

## 二、编译与调试

汇编版本在DOSBox-X中分别执行汇编、链接、运行；例如：

```dos
MASM ASCII1.ASM;
LINK ASCII1.OBJ;
ASCII1
DEBUG ASCII1.EXE
```

使用`U`查看循环位置，`R`检查`CX`、`DL`和标志位，`T`单步跟踪循环及分支；对不需要进入的`INT 21H`可用`P`越过。ASCII1重点检查外层循环的`CX`是否在内层前后通过`PUSH/POP`保护；ASCII2重点检查`CMP`后实际跳转的条件。

C版本的编译与反汇编命令：

```bat
gcc -O0 -g -fno-omit-frame-pointer ASCII3.c -o ASCII3.exe
objdump -d -M intel -S ASCII3.exe > ASCII3_disasm.txt
```

已对ASCII3生成的Windows x86-64反汇编进行过注释，分析以`main`为主，不把MinGW运行库启动代码当作题目核心。

## 三、结果与检查

- 三个版本都应输出相同的两行字母。ASM版重点核对：`DL`从`61H`（`a`）依次递增到`7AH`（`z`）；每行13个，不多不少。
- ASCII1核对内层`CX`从13递减至0时，外层循环次数仍正确；ASCII2核对最后一轮分支条件。
- ASCII3反汇编中可观察到`i<2`、`j<13`对应的条件比较及跳转，局部变量通过栈帧访问。

## 四、学习心得

这次主要理解了三种循环写法的对应关系。8086的`LOOP`隐式修改`CX`，嵌套循环要留意寄存器保护；`CMP`配合条件跳转更接近C语言中循环的条件判断。阅读C反汇编时，应该重点看`main`中的比较、跳转与变量变化，而不是全部运行库代码。
