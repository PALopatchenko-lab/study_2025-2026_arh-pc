SECTION .data
    msg: DB 'f(x)=5(x+18)-28', 10
    len_msg: EQU $-msg
    res1: DB 'x1=2: 72', 10
    len_res1: EQU $-res1
    res2: DB 'x2=3: 77', 10
    len_res2: EQU $-res2

SECTION .text
GLOBAL _start

_start:
    ; Вывод сообщения
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, len_msg
    int 0x80

    ; Вывод результата для x1=2
    mov eax, 4
    mov ebx, 1
    mov ecx, res1
    mov edx, len_res1
    int 0x80

    ; Вывод результата для x2=3
    mov eax, 4
    mov ebx, 1
    mov ecx, res2
    mov edx, len_res2
    int 0x80

    ; Завершение программы
    mov eax, 1
    mov ebx, 0
    int 0x80
