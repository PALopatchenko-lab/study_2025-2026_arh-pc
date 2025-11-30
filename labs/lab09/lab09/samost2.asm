%include 'in_out.asm'

SECTION .data
    result_msg: DB 'Результат: ',0

SECTION .text
GLOBAL _start
_start:
    ; ---- Вычисление выражения (3+2)*4+5
    mov ebx, 3      ; EBX = 3
    mov eax, 2      ; EAX = 2
    add ebx, eax    ; EBX = 3 + 2 = 5
    
    mov eax, ebx    ; переносим результат в EAX для умножения
    mov ecx, 4      ; ECX = 4
    mul ecx         ; EAX = 5 * 4 = 20 
    
    add eax, 5      ; EAX = 20 + 5 = 25 
    mov edi, eax    ; EDI = 25

    ; ---- Вывод результата на экран
    mov eax, result_msg
    call sprint
    mov eax, edi
    call iprintLF
    call quit
