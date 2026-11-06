# Hello World：三种执行方式

## 题目与实现
使用DOS 21H中断的AH=09H功能显示`Hello world!`，并通过AH=4CH退出。比较`LEA DX,Hello`与`MOV DX,OFFSET Hello`，最后不用汇编器，改由DEBUG手动写入机器码及字符串。

## 调试记录
1. DOSBox-X中使用`MASM HELLO.ASM;`、`LINK HELLO.OBJ;`、`HELLO`。
2. DEBUG机器码版用`E`写入`Hello$`和指令字节，再用`D`查看内存、`U`查看反汇编、`G`运行；用`Q`退出DEBUG。
3. 原先未定义栈段时曾遇到LINK的`L4021 no stack segment`警告；可以通过声明栈段消除。

## 结果与检查
传统EXE版已输出`Hello world!`；DEBUG机器码版也成功输出字符串并正常返回。比较发现LEA和OFFSET都可取得字符串偏移地址，但汇编指令形式不同。还尝试查看`.LST`、`.CRF/.REF`辅助文件。

## 学习心得
区分`DS:DX`地址、`AH`中断功能号与字符串结束符`$`；理解源码、机器码、内存内容之间的关系。
