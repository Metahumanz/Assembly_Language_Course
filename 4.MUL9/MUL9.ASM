
.MODEL SMALL
.STACK 100H

.DATA
    MSG_TITLE DB 'The 9mul9 table:', 13, 10, '$'

.CODE

MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX

    ; Print title
    LEA DX, MSG_TITLE
    MOV AH, 09H
    INT 21H

    ; Outer loop: 9 down to 1
    MOV SI, 9

ROW_LOOP:
    ; Inner loop: 1 up to SI
    MOV DI, 1

COL_LOOP:
    ; Print one multiplication expression
    CALL PRINT_CELL

    ; Check if current row is finished
    CMP DI, SI
    JE ROW_END

    ; Print three spaces
    MOV DL, ' '
    CALL PRINT_CHAR
    CALL PRINT_CHAR
    CALL PRINT_CHAR

    ; Next column
    INC DI
    JMP COL_LOOP

ROW_END:
    ; Print CR and LF
    MOV DL, 13
    CALL PRINT_CHAR

    MOV DL, 10
    CALL PRINT_CHAR

    ; Next row
    DEC SI
    JNZ ROW_LOOP

    ; Exit program
    MOV AX, 4C00H
    INT 21H
MAIN ENDP


; ========================================
; PRINT_CELL
; Input: SI = row, DI = column
; Output: row*column=result
; Save and restore registers
; ========================================

PRINT_CELL PROC
    PUSH AX
    PUSH BX
    PUSH DX

    ; Print row number
    MOV AX, SI
    CALL PRINT_NUM

    ; Print '*'
    MOV DL, '*'
    CALL PRINT_CHAR

    ; Print column number
    MOV AX, DI
    CALL PRINT_NUM

    ; Print '='
    MOV DL, '='
    CALL PRINT_CHAR

    ; Calculate SI * DI
    MOV AX, SI
    MOV BX, DI
    MUL BX

    ; Print result
    CALL PRINT_NUM

    ; Restore registers
    POP DX
    POP BX
    POP AX

    RET
PRINT_CELL ENDP


; ========================================
; PRINT_NUM
; Input: AX = number (0 to 99)
; Convert number to ASCII and print
; ========================================

PRINT_NUM PROC
    PUSH AX
    PUSH BX
    PUSH DX

    ; Divide by 10
    MOV BX, 10
    XOR DX, DX
    DIV BX

    ; AX = tens digit
    ; DX = ones digit
    CMP AX, 0
    JE PRINT_ONES

    ; Print tens digit
    PUSH DX
    MOV DL, AL
    ADD DL, '0'
    CALL PRINT_CHAR
    POP DX

PRINT_ONES:
    ; Print ones digit
    ADD DL, '0'
    CALL PRINT_CHAR

    POP DX
    POP BX
    POP AX

    RET
PRINT_NUM ENDP


; ========================================
; PRINT_CHAR
; Input: DL = ASCII character
; DOS INT 21H, AH = 02H
; ========================================

PRINT_CHAR PROC
    PUSH AX
    PUSH DX

    MOV AH, 02H
    INT 21H

    POP DX
    POP AX

    RET
PRINT_CHAR ENDP

END MAIN
