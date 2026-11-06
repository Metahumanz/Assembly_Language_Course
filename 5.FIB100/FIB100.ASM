; FIB100.ASM - 8086 / MASM 5.0 / DOSBox-X
; Fibonacci recursion with memoization, n in [1,100].
; Each number occupies 5 words (80 bits, low word first).

DATA SEGMENT
    PROMPT      DB 0DH,0AH,'Input n (1..100): $'
    BAD_INPUT   DB 0DH,0AH,'Invalid input. Please enter 1..100.',0DH,0AH,'$'
    RESULT_MSG  DB 0DH,0AH,'F(n) = $'
    CRLF        DB 0DH,0AH,'$'

    ; INT 21H / AH=0AH: max length, actual length, characters.
    INPUT_BUF   DB 6,0,6 DUP(0)
    N_VALUE     DW 0

    ; F(0) = 0, F(1) = 1; each entry is 80-bit (5 x DW).
    FIB_TABLE   DW 0,0,0,0,0
                DW 1,0,0,0,0
                DW 495 DUP(0)    ; remaining 99 entries
    READY       DB 1,1,99 DUP(0)

    WORK80      DW 5 DUP(0)      ; temporary 80-bit quotient
    TEN         DW 10
    DIGITS      DB 32 DUP('$')   ; room for F(100) and '$'
DATA ENDS

STACKSEG SEGMENT PARA STACK 'STACK'
    DB 4096 DUP(?)               ; 4 KiB stack
STACK_TOP LABEL WORD
STACKSEG ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA, SS:STACKSEG

START:
    ; Explicit SS:SP setup as required by the exercise.
    MOV AX,STACKSEG
    MOV SS,AX
    MOV SP,OFFSET STACK_TOP
    MOV AX,DATA
    MOV DS,AX

    CALL READ_N
    MOV AX,N_VALUE
    PUSH AX                      ; pass n on stack
    CALL FIB
    ADD SP,2                     ; caller removes the argument

    MOV DX,OFFSET RESULT_MSG
    MOV AH,09H
    INT 21H
    CALL PRINT_FIB

    MOV DX,OFFSET CRLF
    MOV AH,09H
    INT 21H
    MOV AX,4C00H
    INT 21H

; Read and validate a decimal integer n (1..100).
READ_N PROC NEAR
READ_AGAIN:
    MOV DX,OFFSET PROMPT
    MOV AH,09H
    INT 21H
    MOV DX,OFFSET INPUT_BUF
    MOV AH,0AH
    INT 21H

    XOR CH,CH
    MOV CL,[INPUT_BUF+1]
    JCXZ INPUT_ERROR            ; reject empty input
    MOV SI,OFFSET INPUT_BUF+2
    XOR AX,AX                   ; AX holds accumulated number
PARSE_DIGIT:
    MOV DL,[SI]
    CMP DL,'0'
    JB INPUT_ERROR
    CMP DL,'9'
    JA INPUT_ERROR
    SUB DL,'0'
    PUSH DX                     ; MUL modifies DX; preserve digit
    MOV BX,10
    MUL BX                       ; AX = AX * 10
    POP DX
    XOR DH,DH
    ADD AX,DX                   ; AX = AX * 10 + digit
    CMP AX,100
    JA INPUT_ERROR
    INC SI
    LOOP PARSE_DIGIT

    CMP AX,1
    JB INPUT_ERROR
    MOV N_VALUE,AX
    RET
INPUT_ERROR:
    MOV DX,OFFSET BAD_INPUT
    MOV AH,09H
    INT 21H
    JMP READ_AGAIN
READ_N ENDP

; FIB(n): recursively populate memo table for F(n).
; Stack parameter: [BP+4] = n, results are stored in FIB_TABLE.
; F(n-1) and F(n-2) are both called via CALL FIB.
FIB PROC NEAR
    PUSH BP
    MOV BP,SP
    PUSH BX
    PUSH SI
    PUSH DI
    PUSH CX

    MOV BX,[BP+4]
    CMP BYTE PTR READY[BX],1
    JE FIB_DONE                 ; F(0)/F(1), or cached result

    MOV AX,BX
    DEC AX
    PUSH AX
    CALL FIB                    ; first recursive call: F(n-1)
    ADD SP,2

    MOV BX,[BP+4]
    SUB BX,2
    PUSH BX
    CALL FIB                    ; second recursive call: F(n-2)
    ADD SP,2

    ; DI = offset of F(n), SI = F(n-1), BX = F(n-2).
    MOV BX,[BP+4]
    MOV AX,BX
    MOV CX,10                   ; 5 words * 2 bytes
    MUL CX
    MOV DI,AX
    MOV SI,DI
    SUB SI,10
    MOV BX,DI
    SUB BX,20

    ; Little-endian 80-bit addition, carry propagated with ADC.
    MOV AX,FIB_TABLE[SI]
    ADD AX,FIB_TABLE[BX]
    MOV FIB_TABLE[DI],AX
    MOV AX,FIB_TABLE[SI+2]
    ADC AX,FIB_TABLE[BX+2]
    MOV FIB_TABLE[DI+2],AX
    MOV AX,FIB_TABLE[SI+4]
    ADC AX,FIB_TABLE[BX+4]
    MOV FIB_TABLE[DI+4],AX
    MOV AX,FIB_TABLE[SI+6]
    ADC AX,FIB_TABLE[BX+6]
    MOV FIB_TABLE[DI+6],AX
    MOV AX,FIB_TABLE[SI+8]
    ADC AX,FIB_TABLE[BX+8]
    MOV FIB_TABLE[DI+8],AX

    MOV BX,[BP+4]
    MOV BYTE PTR READY[BX],1
FIB_DONE:
    POP CX
    POP DI
    POP SI
    POP BX
    POP BP
    RET
FIB ENDP

; Print 80-bit F(n) in decimal using repeated 80-bit / 10.
; DX is the remainder carried between successive 16-bit words.
PRINT_FIB PROC NEAR
    MOV AX,N_VALUE
    MOV BX,10
    MUL BX
    MOV SI,AX                   ; entry offset: n * 10
    MOV DI,OFFSET WORK80
    MOV CX,5
COPY_WORDS:
    MOV AX,FIB_TABLE[SI]
    MOV [DI],AX
    ADD SI,2
    ADD DI,2
    LOOP COPY_WORDS

    MOV DI,OFFSET DIGITS+31
    MOV BYTE PTR [DI],'$'
    DEC DI
NEXT_DECIMAL_DIGIT:
    XOR DX,DX
    MOV SI,8                    ; from most significant word
    MOV CX,5
DIVIDE_WORD:
    MOV AX,WORK80[SI]
    DIV TEN                     ; DX:AX / 10 => AX and remainder DX
    MOV WORK80[SI],AX
    SUB SI,2
    LOOP DIVIDE_WORD

    ADD DL,'0'
    MOV [DI],DL
    DEC DI

    MOV AX,WORK80
    OR AX,WORK80+2
    OR AX,WORK80+4
    OR AX,WORK80+6
    OR AX,WORK80+8
    JNZ NEXT_DECIMAL_DIGIT

    INC DI
    MOV DX,DI
    MOV AH,09H
    INT 21H
    RET
PRINT_FIB ENDP

CODE ENDS
END START
