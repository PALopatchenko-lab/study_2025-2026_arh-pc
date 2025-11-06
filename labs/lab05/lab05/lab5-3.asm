SECTION .data
    msg: DB 'Введите строку:',10
    msgLen: EQU $-msg
    msg2: DB 'Вы ввели:',10
    msg2Len: EQU $-msg2

SECTION .bss
    buf1: RESB 80

SECTION .text
    GLOBAL _start
_start:
    ; Вывод приглашения "Введите строку"
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, msgLen
    int 0x80
    
    ; Ввод строки с клавиатуры
    mov eax, 3
    mov ebx, 0
    mov ecx, buf1
    mov edx, 80
    int 0x80
    
    ; Сохраняем длину введенной строки
    mov esi, eax
    
    ; Вывод введенной строки
    mov eax, 4
    mov ebx, 1
    mov ecx, buf1
    mov edx, esi
    int 0x80
    
    ; Завершение программы
    mov eax, 1
    mov ebx, 0
    int 0x80
