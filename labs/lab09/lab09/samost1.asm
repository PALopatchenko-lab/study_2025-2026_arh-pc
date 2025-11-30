%include 'in_out.asm'

SECTION .data
    func_msg db 'Функция: f(x)=5(2+x)',0h
    result_msg db 'Результат: ',0h

SECTION .text
    global _start

_start:
    pop ecx         ; argc - количество аргументов
    pop edx         ; argv[0] - имя программы
    sub ecx, 1      ; уменьшаем количество аргументов на 1 (убираем имя программы)
    cmp ecx, 0
    jz _no_args
    
    mov eax, func_msg
    call sprintLF
    
    mov esi, 0      ; Сумма результатов

process_args:
    pop eax         ; берем следующий аргумент
    call atoi       ; преобразуем строку в число (eax = x)
    
    ; ВЫЗОВ ПОДПРОГРАММЫ для вычисления f(x)
    call _calculate_function
    
    add esi, eax    ; Добавляем результат к сумме
    
    loop process_args
    jmp _output_result

_no_args:
    mov esi, 0

_output_result:
    mov eax, result_msg
    call sprint
    mov eax, esi
    call iprintLF
    call quit

; --------------------------------------------------
; ПОДПРОГРАММА: _calculate_function
; Вычисляет f(x) = 5(2 + x)
; Вход:  x в EAX
; Выход: результат в EAX
; Сохраняет: все регистры кроме EAX
; --------------------------------------------------
_calculate_function:
    push ebx        ; Сохраняем EBX, так как он используется
    
    ; Вычисляем f(x) = 5(2 + x)
    add eax, 2      ; eax = x + 2
    mov ebx, 5
    mul ebx         ; eax = 5 * (x + 2)
    
    pop ebx         ; Восстанавливаем EBX
    ret             ; Возврат из подпрограммы
