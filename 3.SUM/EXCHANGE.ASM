
.MODEL SMALL
.STACK 100H

.DATA
    prompt DB 'Please input a Hex number: $'
    resultMsg DB 13,10,'The Dec number:',13,10,'$'
    errorMsg DB 13,10,'Invalid input!$'
    buffer DB 3,0,3 DUP(0)

.CODE
MAIN PROC
    ; 1. 初始化数据段
    MOV AX, @DATA
    MOV DS, AX

    ; 2. 显示输入提示
    MOV DX, OFFSET prompt
    MOV AH, 09H
    INT 21H

    ; 3. 接收1~2位十六进制字符
    MOV DX, OFFSET buffer
    MOV AH, 0AH
    INT 21H

    MOV CL, [buffer+1]
    XOR CH, CH
    JCXZ BAD_INPUT

    MOV SI, OFFSET buffer+2
    XOR BX, BX

NEXT_CHAR:
    MOV AL, [SI]

    ; 4. ASCII字符转换为数值0~15
    CMP AL, '0'
    JB BAD_INPUT
    CMP AL, '9'
    JBE IS_DIGIT

    CMP AL, 'a'
    JB CHECK_UPPER
    CMP AL, 'f'
    JA BAD_INPUT
    SUB AL, 20H

CHECK_UPPER:
    CMP AL, 'A'
    JB BAD_INPUT
    CMP AL, 'F'
    JA BAD_INPUT
    SUB AL, 'A'-10
    JMP SAVE_VALUE

IS_DIGIT:
    SUB AL, '0'

SAVE_VALUE:
    ; 5. 原数乘16，再加当前位
    SHL BL, 1
    SHL BL, 1
    SHL BL, 1
    SHL BL, 1
    ADD BL, AL

    INC SI
    LOOP NEXT_CHAR
    JMP CONVERT_DONE

BAD_INPUT:
    MOV DX, OFFSET errorMsg
    MOV AH, 09H
    INT 21H
    JMP FINISH

CONVERT_DONE:
    ; 6. 显示结果提示
    MOV DX, OFFSET resultMsg
    MOV AH, 09H
    INT 21H

    ; 7. 把数值转换成十进制数字
    MOV AL, BL
    XOR AH, AH
    MOV BX, 10
    XOR CX, CX

DIV_LOOP:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE DIV_LOOP

    ; 8. 借助栈，逆序打印各位数字
PRINT_LOOP:
    POP DX
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    LOOP PRINT_LOOP

FINISH:
    MOV AX, 4C00H
    INT 21H
MAIN ENDP
END MAIN
