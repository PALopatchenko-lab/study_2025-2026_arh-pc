%include 'in_out.asm'

section .data
    msg_x db "Введите x: ", 0
    msg_a db "Введите a: ", 0
    msg_result db "f(x) = ", 0

section .bss
    x resd 1
    a resd 1
    result resd 1

section .text
global _start

_start:
    ; Ввод x
    mov eax, msg_x
    call sprint
    mov ecx, x
    mov edx, 10
    call sread
    mov eax, x
    call atoi
    mov [x], eax

    ; Ввод a
    mov eax, msg_a
    call sprint
    mov ecx, a
    mov edx, 10
    call sread
    mov eax, a
    call atoi
    mov [a], eax

    ; Вычисление f(x)
    mov ebx, [x]
    cmp ebx, 2
    jg case_x_gt_2   ; если x > 2

    ; Случай x ≤ 2: f(x) = 3a
    mov eax, [a]
    mov ecx, 3
    mul ecx          ; eax = 3 * a
    jmp store_result

case_x_gt_2:
    ; Случай x > 2: f(x) = x - 2
    mov eax, [x]
    sub eax, 2

store_result:
    mov [result], eax

    ; Вывод результата
    mov eax, msg_result
    call sprint
    mov eax, [result]
    call iprintLF

    call quit
