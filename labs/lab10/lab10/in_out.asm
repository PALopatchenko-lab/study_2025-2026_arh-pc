section .text

; --- sprint (вывод строки)
sprint:
    push eax
    push ebx
    push ecx
    push edx
    
    mov ecx, eax    ; Адрес строки
    call slen       ; Длина строки в edx
    mov eax, 4      ; sys_write
    mov ebx, 1      ; stdout
    int 0x80
    
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

; --- sprintLF (вывод строки с переводом строки)
sprintLF:
    call sprint
    
    push eax
    mov eax, 0xA
    push eax
    mov eax, esp
    call sprint
    pop eax
    pop eax
    ret

; --- slen (длина строки)
slen:
    push ebx
    mov ebx, eax
    
nextchar:
    cmp byte [eax], 0
    jz finished
    inc eax
    jmp nextchar
    
finished:
    sub eax, ebx
    pop ebx
    ret

; --- sread (ввод строки)
sread:
    push ecx
    push edx
    push ebx
    
    mov eax, 3      ; sys_read
    mov ebx, 0      ; stdin
    int 0x80
    
    pop ebx
    pop edx
    pop ecx
    ret

; --- iprint (вывод числа)
iprint:
    push eax
    push ecx
    push edx
    push esi
    mov ecx, 0
    
divideLoop:
    inc ecx
    mov edx, 0
    mov esi, 10
    idiv esi
    add edx, 48
    push edx
    cmp eax, 0
    jnz divideLoop
    
printLoop:
    dec ecx
    mov eax, esp
    call sprint
    pop eax
    cmp ecx, 0
    jnz printLoop
    
    pop esi
    pop edx
    pop ecx
    pop eax
    ret

; --- quit (завершение программы)
quit:
    mov eax, 1      ; sys_exit
    mov ebx, 0      ; код возврата 0
    int 0x80
