; Hello World - 方法一：LEA 获取字符串偏移地址
; MASM 5.x / DOSBox-X，8086 16-bit DOS EXE
;
; 与老师《hello剖析.pdf》源码一对应。
; 在老师原始示例基础上补充 .STACK 100H，避免没有栈段的链接警告。

.MODEL SMALL
.STACK 100H
.DATA
    HELLO DB 'Hello world!', 0DH, 0AH, '$'
.CODE
START:
    MOV AX, @DATA      ; 数据段地址 -> AX
    MOV DS, AX         ; 初始化 DS（不能直接把立即数送入 DS）

    LEA DX, HELLO      ; 方法一：计算 HELLO 的有效地址，将偏移地址存入 DX
    MOV AH, 09H        ; DOS INT 21H 的 09H 功能：显示 DS:DX 指向的 $ 结尾字符串
    INT 21H

    MOV AX, 4C00H      ; DOS INT 21H 的 4CH 功能：结束程序，退出码 00H
    INT 21H
END START
