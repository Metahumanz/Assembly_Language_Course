
.MODEL SMALL
.STACK 100H
.CODE

MAIN PROC
    MOV BL, 'a'         ; Current character
    MOV CL, 0           ; Characters in current line

PRINT_NEXT:
    MOV DL, BL
    MOV AH, 02H
    INT 21H             ; Print character

    INC BL              ; Next character
    INC CL              ; Increase line counter

    CMP CL, 13          ; Printed 13 characters?
    JNE CHECK_LAST      ; If not, skip newline

    MOV DL, 0DH
    MOV AH, 02H
    INT 21H             ; Carriage return

    MOV DL, 0AH
    MOV AH, 02H
    INT 21H             ; Line feed

    MOV CL, 0           ; Reset line counter

CHECK_LAST:
    CMP BL, 'z'         ; Next character <= z?
    JBE PRINT_NEXT      ; If yes, continue

    MOV AX, 4C00H
    INT 21H             ; Exit program

MAIN ENDP
END MAIN
