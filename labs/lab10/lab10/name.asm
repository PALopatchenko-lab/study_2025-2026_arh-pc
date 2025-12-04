%include 'in_out.asm'

SECTION .data
filename db 'name.txt', 0h          ; Имя создаваемого файла
question db 'Как Вас зовут? ', 0h   ; Приглашение для ввода
message db 'Меня зовут ', 0h        ; Начало сообщения для записи
newline db 0xA, 0h                  ; Символ новой строки

SECTION .bss
name resb 255        ; Буфер для ввода имени

SECTION .text
global _start

_start:
    ; --- Вывод приглашения "Как Вас зовут?"
    mov eax, question
    call sprint

    ; --- Ввод имени с клавиатуры
    mov ecx, name
    mov edx, 255
    call sread

    ; --- Убираем символ новой строки из введённой строки
    mov edi, name
    call strlen
    dec eax                ; Переходим на последний символ
    mov byte [name + eax], 0  ; Заменяем \n на \0

    ; --- СОЗДАНИЕ файла name.txt (sys_creat)
    mov ecx, 0644o         ; Права доступа: rw-r--r--
    mov ebx, filename
    mov eax, 8             ; sys_creat
    int 0x80

    cmp eax, 0             ; Проверка на ошибку
    jl error

    ; --- Сохраняем дескриптор файла
    mov esi, eax

    ; --- ЗАПИСЬ в файл сообщения "Меня зовут " (sys_write)
    mov edx, 11            ; Длина строки "Меня зовут "
    mov ecx, message
    mov ebx, esi           ; Дескриптор файла
    mov eax, 4             ; sys_write
    int 0x80

    ; --- ЗАПИСЬ в файл введённого имени
    mov eax, name
    call slen              ; Получаем длину имени
    mov edx, eax
    mov ecx, name
    mov ebx, esi
    mov eax, 4
    int 0x80

    ; --- ЗАПИСЬ в файл символа новой строки
    mov edx, 1             ; Длина символа новой строки
    mov ecx, newline
    mov ebx, esi
    mov eax, 4
    int 0x80

    ; --- ЗАКРЫТИЕ файла (sys_close)
    mov ebx, esi
    mov eax, 6             ; sys_close
    int 0x80

    ; --- Сообщение об успехе
    mov eax, filename
    call sprint
    mov eax, success_msg
    call sprintLF
    jmp end_program

error:
    mov eax, error_msg
    call sprintLF

end_program:
    call quit

SECTION .data
error_msg db 'Ошибка при создании файла!', 0h
success_msg db ' успешно создан и заполнен.', 0h

; --- Дополнительная функция для определения длины строки
strlen:
    push edi
    mov edi, eax
    xor ecx, ecx
    not ecx
    xor al, al
    cld
    repne scasb
    not ecx
    dec ecx
    mov eax, ecx
    pop edi
    ret
