%include 'in_out.asm'

section .data
    a dd 41
    b dd 62
    c dd 35
    msg db "Наименьшее число: ",0

section .bss
    min resd 1

section .text
global _start

_start:
    ; Записываем 'a' в переменную 'min'
    mov eax, [a]
    mov [min], eax

    ; Сравниваем 'min' и 'b'
    mov ebx, [b]
    cmp eax, ebx
    jl check_c      ; если min < b, переходим к сравнению с c
    mov [min], ebx  ; иначе min = b

check_c:
    ; Сравниваем 'min' и 'c'
    mov eax, [min]
    mov ecx, [c]
    cmp eax, ecx
    jl print_result ; если min < c, выводим результат
    mov [min], ecx  ; иначе min = c

print_result:
    mov eax, msg
    call sprint     ; Вывод "Наименьшее число: "
    mov eax, [min]
    call iprintLF   ; Вывод значения min

    call quit       ; Завершение программы
