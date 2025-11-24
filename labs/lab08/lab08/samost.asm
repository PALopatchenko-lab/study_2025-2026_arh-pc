%include 'in_out.asm'

SECTION .data
    func_msg db 'Функция: f(x)=5(2+x)',0h
    result_msg db 'Результат: ',0h

SECTION .text
    global _start

_start:
    pop ecx
    pop edx
    sub ecx, 1
    cmp ecx, 0
    jz _no_args
    
    mov eax, func_msg
    call sprintLF
    
    mov esi, 0      ; Сумма результатов

process_args:
    pop eax
    call atoi       ; eax = x
    
    ; f(x) = 5(2 + x)
    add eax, 2      ; eax = x + 2
    mov ebx, 5
    mul ebx         ; eax = 5 * (x + 2)
    
    add esi, eax    ; Добавляем к сумме
    
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
