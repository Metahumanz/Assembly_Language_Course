
.MODEL SMALL
.STACK 100H

.DATA
    PROMPT DB 'Input a number (1-100): $'
    RESULT DB 13,10,'Sum = $'
    ERROR  DB 13,10,'Invalid input!$'
    NEWLINE DB 13,10,'$'

    ; Keyboard input buffer
    BUFFER DB 4,0,4 DUP(0)

.CODE
MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX

    ; 1. Display prompt
    MOV DX, OFFSET PROMPT
    MOV AH, 09H
    INT 21H

    ; 2. Read keyboard input
    MOV DX, OFFSET BUFFER
    MOV AH, 0AH
    INT 21H

    ; 3. Get input length
    MOV CL, [BUFFER+1]
    MOV CH, 0
    JCXZ INVALID

    MOV SI, OFFSET BUFFER+2
    MOV BX, 0

    ; 4. Convert ASCII to decimal number
INPUT_LOOP:
    MOV AL, [SI]

    CMP AL, '0'
    JB INVALID
    CMP AL, '9'
    JA INVALID

    SUB AL, '0'
    MOV AH, 0
    MOV DI, AX

    ; BX = BX * 10 + digit
    MOV AX, BX
    MOV DX, 10
    MUL DX
    ADD AX, DI
    MOV BX, AX

    CMP BX, 100
    JA INVALID

    INC SI
    LOOP INPUT_LOOP

    ; Check input range (1-100)
    CMP BX, 1
    JB INVALID

    ; 5. Calculate 1+2+...+N
    MOV CX, BX
    MOV BX, 1
    MOV AX, 0

SUM_LOOP:
    ADD AX, BX
    INC BX
    LOOP SUM_LOOP

    ; 6. Display result message
    PUSH AX
    MOV DX, OFFSET RESULT
    MOV AH, 09H
    INT 21H
    POP AX

    ; 7. Print decimal result
    CALL PRINT_DEC
    JMP FINISH

INVALID:
    MOV DX, OFFSET ERROR
    MOV AH, 09H
    INT 21H

FINISH:
    MOV DX, OFFSET NEWLINE
    MOV AH, 09H
    INT 21H

    MOV AX, 4C00H
    INT 21H
MAIN ENDP

; Convert AX to decimal ASCII and print
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
