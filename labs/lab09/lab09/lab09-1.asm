%include 'in_out.asm'

SECTION .data
    msg: DB 'Введите x: ',0
    result: DB 'f(g(x)) = ',0

SECTION .bss
    x: RESB 80
    res: RESB 80

SECTION .text
GLOBAL _start
_start:

;---
; Основная программа
;---
    mov eax, msg
    call sprint

    mov ecx, x
    mov edx, 80
    call sread

    mov eax, x
    call atoi        ; Преобразуем введенную строку в число (результат в EAX)

    call _calcul     ; Вызов подпрограммы _calcul с x в EAX

    mov eax, result
    call sprint
    mov eax, [res]   ; Берем результат из памяти
    call iprintLF

    call quit

;---
; Подпрограмма вычисления f(g(x))
; Вход: x в EAX
; Выход: результат в [res]
;---
_calcul:
    push eax         ; Сохраняем исходный x
    
    call _subcalcul  ; Вызываем g(x), результат в EAX
    
    ; Вычисляем f(g(x)) = 2*g(x) + 7
    mov ebx, 2
    mul ebx          ; EAX = g(x) * 2
    add eax, 7       ; EAX = 2*g(x) + 7
    
    mov [res], eax   ; Сохраняем окончательный результат
    
    pop eax          ; Восстанавливаем EAX
    ret

;---
; Подпрограмма вычисления g(x) = 3x - 1
; Вход: x в стеке (передан через call из _calcul)
; Выход: результат в EAX
;---
_subcalcul:
    ; Берем x из стека (адрес возврата 4 байта, потом сохраненный EAX)
    mov eax, [esp + 4]  ; Берем x, который был сохранен в _calcul
    
    ; Вычисляем g(x) = 3x - 1
    mov ebx, 3
    mul ebx          ; EAX = x * 3
    sub eax, 1       ; EAX = 3x - 1
    
    ret
