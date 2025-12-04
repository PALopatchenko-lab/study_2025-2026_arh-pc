%include 'in_out.asm'

SECTION .data
filename db 'readme.txt', 0h
msg db 'Введите строку для записи в файл: ', 0h

SECTION .bss
contents resb 255

SECTION .text
global _start
_start:

; --- Печать сообщения
mov eax, msg
call sprint

; --- Ввод строки
mov ecx, contents
mov edx, 255
call sread

; --- СОЗДАНИЕ файла (sys_creat)
mov ecx, 0777o    ; права доступа rwxrwxrwx
mov ebx, filename
mov eax, 8        ; sys_creat
int 0x80

; --- Проверка на ошибку
cmp eax, 0
jl error

; --- Сохраняем дескриптор
mov esi, eax

; --- Запись в файл (sys_write)
mov eax, contents
call slen         ; получаем длину строки
mov edx, eax      ; количество байтов для записи
mov ecx, contents ; строка
mov ebx, esi      ; дескриптор
mov eax, 4        ; sys_write
int 0x80

; --- Закрытие файла
mov ebx, esi
mov eax, 6        ; sys_close
int 0x80

jmp end_program

error:
mov eax, error_msg
call sprint

end_program:
call quit

; --- Данные для ошибки
SECTION .data
error_msg db 'Ошибка при создании файла!', 0h
