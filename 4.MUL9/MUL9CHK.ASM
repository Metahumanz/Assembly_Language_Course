
; MUL9CHK.ASM
; 功能：检查9*9乘法表，输出所有错误位置
; 环境：MASM 5.0 + DOSBox-X

; ==================== 栈段 ====================
STACKS SEGMENT STACK
    DW 256 DUP(?)             ; 分配512字节栈空间
STACKS ENDS

; ==================== 数据段 ====================
DATA SEGMENT

TABLE DB 7,2,3,4,5,6,7,8,9
      DB 2,4,7,8,10,12,14,16,18
      DB 3,6,9,12,15,18,21,24,27
      DB 4,8,12,16,7,24,28,32,36
      DB 5,10,15,20,25,30,35,40,45
      DB 6,12,18,24,30,7,42,48,54
      DB 7,14,21,28,35,42,49,56,63
      DB 8,16,24,32,40,48,56,7,72
      DB 9,18,27,36,45,54,63,72,81

HEADER_MSG DB 'x y',0DH,0AH,'$'

; 下面三个DB连续存储，组成完整的错误提示字符串
ERROR_ROW DB '0'
          DB ' '
ERROR_COL DB '0'
          DB '   error',0DH,0AH,'$'

DONE_MSG DB 0DH,0AH,'accomplish!',0DH,0AH,'$'

DATA ENDS

; ==================== 代码段 ====================
CODE SEGMENT
ASSUME CS:CODE, DS:DATA, SS:STACKS

START:
    MOV AX,DATA              ; 获取数据段地址
    MOV DS,AX                ; 初始化DS

    MOV DX,OFFSET HEADER_MSG ; 输出标题
    MOV AH,09H
    INT 21H

    CALL CHECK_TABLE         ; 调用乘法表检查过程

    MOV DX,OFFSET DONE_MSG   ; 输出完成提示
    MOV AH,09H
    INT 21H

    MOV AX,4C00H             ; 正常退出程序
    INT 21H

; ==================== 检查过程 ====================
CHECK_TABLE PROC NEAR

    PUSH AX                  ; 保存调用者的寄存器
    PUSH BX
    PUSH CX
    PUSH SI

    MOV SI,OFFSET TABLE      ; SI指向表中第一个元素
    MOV BL,1                 ; BL保存行号x，范围1~9

ROW_LOOP:
    MOV BH,1                 ; BH保存列号y，范围1~9
    MOV CX,9                 ; 每行检查9个元素

COL_LOOP:
    MOV AL,BL                ; AL = x
    MUL BH                   ; AX = AL * BH = x*y

    CMP AL,[SI]              ; 比较计算结果和表中数据
    JE ITEM_OK               ; 相等则跳过报错

    CALL PRINT_ERROR         ; 不相等，输出错误位置

ITEM_OK:
    INC SI                   ; 指向下一个表元素
    INC BH                   ; 列号加1
    LOOP COL_LOOP            ; CX减1，不为0继续内层循环

    INC BL                   ; 行号加1
    CMP BL,10                ; 是否已经检查完9行
    JB ROW_LOOP              ; BL小于10，继续下一行

    POP SI                   ; 按相反顺序恢复寄存器
    POP CX
    POP BX
    POP AX

    RET                      ; 返回主程序
CHECK_TABLE ENDP

; ==================== 错误输出过程 ====================
PRINT_ERROR PROC NEAR

    PUSH AX                  ; 保存调用者的寄存器
    PUSH BX
    PUSH CX
    PUSH DX

    MOV AL,BL                ; 取得行号x
    ADD AL,'0'               ; 数字转ASCII字符
    MOV ERROR_ROW,AL         ; 修改错误提示的行号字符

    MOV AL,BH                ; 取得列号y
    ADD AL,'0'               ; 数字转ASCII字符
    MOV ERROR_COL,AL         ; 修改错误提示的列号字符

    MOV DX,OFFSET ERROR_ROW  ; 输出完整错误提示
    MOV AH,09H
    INT 21H

    POP DX                   ; 恢复寄存器
    POP CX
    POP BX
    POP AX

    RET                      ; 返回检查过程
PRINT_ERROR ENDP

CODE ENDS
END START
