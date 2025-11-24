%include 'in_out.asm'

SECTION .data
    msg1 db 'Введите N: ',0h

SECTION .bss
    N resb 10

SECTION .text
    global _start

_start:
    mov eax, msg1
    call sprint
    
    mov ecx, N
    mov edx, 10
    call sread
    
    mov eax, N
    call atoi
    mov [N], eax
    
    mov ecx, [N]    ; Счетчик цикла

label:
    mov [N], ecx    ; Сохраняем текущее значение ecx
    mov eax, [N]    ; Загружаем для вывода
    call iprintLF   ; Вывод значения
    loop label      ; ecx уменьшается автоматически здесь
    
    call quit
