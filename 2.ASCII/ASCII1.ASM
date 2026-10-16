
.MODEL SMALL
.STACK 100H
.CODE

MAIN PROC
    MOV BL, 'a'         ; 从字母a开始
    MOV CX, 2           ; 外层循环：2行

OUTER_LOOP:
    PUSH CX             ; 保存外层CX
    MOV CX, 13          ; 内层循环：13个字符

INNER_LOOP:
    MOV DL, BL          ; 当前字符放到DL
    MOV AH, 02H         ; DOS输出字符功能
    INT 21H             ; 打印字符

    INC BL              ; 下一个字母
    LOOP INNER_LOOP     ; CX减1，非0则继续

    MOV DL, 0DH         ; 回车
    MOV AH, 02H
    INT 21H

    MOV DL, 0AH         ; 换行
    MOV AH, 02H
    INT 21H

    POP CX              ; 恢复外层CX
    LOOP OUTER_LOOP     ; 继续下一行

    MOV AX, 4C00H       ; 结束程序
    INT 21H

MAIN ENDP
END MAIN
