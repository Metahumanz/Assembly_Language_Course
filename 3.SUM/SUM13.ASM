
.MODEL SMALL
.STACK 100H

.CODE
MAIN PROC
    ; Initialize sum on stack
    MOV AX, 0
    PUSH AX

    MOV BX, 1
    MOV CX, 100

SUM_LOOP:
    ; Get sum from stack
    POP AX

    ; Add current number
    ADD AX, BX

    ; Save sum back to stack
    PUSH AX

    INC BX
    LOOP SUM_LOOP

    ; Get final result
    POP AX
    CALL PRINT_DEC

    MOV AX, 4C00H
    INT 21H
MAIN ENDP

; Print unsigned decimal number in AX
PRINT_DEC PROC
    MOV BX, 10
    MOV CX, 0

DIV_LOOP:
    MOV DX, 0
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE DIV_LOOP

PRINT_LOOP:
    POP DX
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    LOOP PRINT_LOOP

    RET
PRINT_DEC ENDP

END MAIN
