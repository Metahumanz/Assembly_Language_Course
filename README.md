# 汇编语言课程练习

基于 **8086/x86、MASM 和 DOSBox-X** 的课堂练习；部分题目使用 C 语言、GCC 和反汇编工具辅助对照。

## 目录结构

```text
Assembly_Language/
├── 1.helloworld/     # Hello World 入门
├── 2.ASCII/          # ASCII、循环等练习及 C/汇编对照
├── 3.SUM/            # 求和及相关练习
├── .../              # 后续作业按需添加
├── .gitignore
└── README.md
```

每个作业目录按需保存 `.ASM`、`.C`、`.s`、笔记或反汇编 `.txt` 等文件。编译产生的 `.OBJ`、`.EXE`，以及仓库根目录的 MASM/LINK 工具和个人 DOSBox-X 配置不提交。

## 常用命令

### DOSBox-X：挂载与切换目录

在 **DOSBox-X 内** 执行（若已自动挂载 C 盘，则跳过第一行）：

```dos
MOUNT C C:\VScodework\Assembly_Language
C:
DIR
CD 3.SUM
DIR
CD ..
```

> 注意：DOS 环境可能将较长目录名显示为 8.3 短文件名；进入 `1.helloworld`、`2.ASCII` 失败时，先用 `DIR` 查看 DOSBox-X 实际显示的名称。

### MASM：汇编、链接、运行

在 **DOSBox-X 内**，以 `3.SUM/SUM11.ASM` 为例：

```dos
C:
CD 3.SUM
C:\MASM.EXE SUM11.ASM;
C:\LINK.EXE SUM11.OBJ;
SUM11.EXE
```

分号用于采用 MASM/LINK 的后续默认选项；工具放在仓库根目录，因此从作业子目录运行时使用 `C:\MASM.EXE`、`C:\LINK.EXE`。

### GCC：编译 C 程序

以下命令在 **Windows PowerShell / CMD** 中、仓库根目录下执行，需已安装并配置 `gcc`：

```powershell
gcc -x c -O0 -g 2.ASCII/ASCII3.C -o 2.ASCII/ASCII3.exe
```

`-x c` 明确按 C 语言编译（特别是文件名使用大写 `.C` 时）；`-O0` 关闭优化，`-g` 保留调试信息，便于对照源代码与反汇编。

### GCC / objdump：生成汇编和反汇编

```powershell
# C 源码生成汇编文本（Intel 语法）
gcc -x c -O0 -S -masm=intel 2.ASCII/ASCII3.C -o 2.ASCII/ASCII3.s

# 反汇编已编译的 EXE，并尽量穿插对应的 C 源代码
objdump -d -S -M intel 2.ASCII/ASCII3.exe > 2.ASCII/ASCII3_disasm.txt
```

说明：这里 GCC/objdump 生成的通常是 **Windows 32/64 位汇编**，不等同于 DOSBox-X 中运行的 **8086 16 位 MASM**；主要用来观察 C 和汇编的对应关系。
