; Hello World - 方法二：OFFSET 获取字符串偏移地址
; MASM 5.x / DOSBox-X，8086 16-bit DOS EXE
;
; 与老师《hello剖析.pdf》源码二对应。
; 唯一需要比较的核心指令：MOV DX, OFFSET HELLO vs LEA DX, HELLO。

.MODEL SMALL
.STACK 100H
.DATA
    HELLO DB 'Hello world!', 0DH, 0AH, '$'
.CODE
START:
    MOV AX, @DATA
    MOV DS, AX

    MOV DX, OFFSET HELLO ; 方法二：由汇编器计算 HELLO 的偏移值，作为立即数装入 DX
    MOV AH, 09H
    INT 21H

    MOV AX, 4C00H
    INT 21H
END START
