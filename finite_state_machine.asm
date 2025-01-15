.386
.model flat, stdcall
.stack 4096
include Irvine32.inc

.data
promptInput BYTE "Enter a 5-digit PIN: ", 0
validMsg BYTE "Valid PIN", 0
invalidMsg BYTE "Invalid PIN at position: ", 0
invalidValueMsg BYTE "Invalid value: ", 0
newline BYTE 0Dh, 0Ah, 0
pinCode BYTE 5 DUP(?)
result db 5 DUP(0)

.code
main PROC
    ; Виводимо запит на введення PIN-коду
    mov edx, OFFSET promptInput
    call WriteString
    mov edx, OFFSET pinCode
    mov ecx, 6
    call ReadString

    ; Виклик процедури Validate_PIN
    mov esi, OFFSET pinCode
    call Validate_PIN

    ; Перевірка результату
    cmp eax, 0
    je PINValid
    ; Недійсний PIN-код
    mov edx, OFFSET invalidMsg
    call WriteString
    add eax, 30h        ; Перетворюємо позицію в ASCII
    mov dl, al
    call WriteChar
    call Crlf

    mov edx, OFFSET invalidValueMsg
    call WriteString
    mov al, [result + eax - 1] ; Отримуємо значення з масиву `result` (позиція -1 через 0-індексацію)
    add al, '0'         ; Перетворюємо число назад в ASCII
    mov dl, al
    call WriteChar
    call Crlf

    jmp EndProgram

PINValid:
    ; Дійсний PIN-код
    mov edx, OFFSET validMsg
    call WriteString

EndProgram:
    call Crlf
    exit
main ENDP

; Validate_PIN: Перевіряє дійсність PIN-коду
; Вхід: ESI - вказівник на масив із 5 цифр
; Вихід: EAX - 0, якщо PIN дійсний; позиція (1-5), якщо недійсний
Validate_PIN PROC
    push esi
    push ebx

    mov ecx, 0          ; Ініціалізація змінної для позиції (від 0)
    xor eax, eax        ; Обнулюємо EAX (результат)

ValidateLoop:
       mov al, BYTE PTR [esi]    ; Беремо наступну цифру
    sub al, '0'               ; Перетворюємо ASCII в число

    mov [result + ecx], al    ; Зберігаємо цифру в масив result

    ; Перевірка відповідно до позиції
    mov ebx, ecx              ; Копіюємо номер позиції в ebx
    cmp ebx, 0                ; Якщо позиція 1 (ecx = 0)
    je CheckPosition1
    cmp ebx, 1                ; Якщо позиція 2 (ecx = 1)
    je CheckPosition2
    cmp ebx, 2                ; Якщо позиція 3 (ecx = 2)
    je CheckPosition3
    cmp ebx, 3                ; Якщо позиція 4 (ecx = 3)
    je CheckPosition4
    cmp ebx, 4                ; Якщо позиція 5 (ecx = 4)
    je CheckPosition5

    ; Якщо позиція перевищує 5, завершуємо перевірку
    jmp Invalid

CheckPosition1:
    cmp al, 5                 ; Перевіряємо, чи цифра >= 5
    jl Invalid
    cmp al, 9                 ; Перевіряємо, чи цифра <= 9
    jg Invalid
    jmp NextDigit

CheckPosition2:
    cmp al, 2                 ; Перевіряємо, чи цифра >= 2
    jl Invalid
    cmp al, 5                 ; Перевіряємо, чи цифра <= 5
    jg Invalid
    jmp NextDigit

CheckPosition3:
    cmp al, 4                 ; Перевіряємо, чи цифра >= 4
    jl Invalid
    cmp al, 8                 ; Перевіряємо, чи цифра <= 8
    jg Invalid
    jmp NextDigit

CheckPosition4:
    cmp al, 1                 ; Перевіряємо, чи цифра >= 1
    jl Invalid
    cmp al, 4                 ; Перевіряємо, чи цифра <= 4
    jg Invalid
    jmp NextDigit

CheckPosition5:
    cmp al, 3                 ; Перевіряємо, чи цифра >= 3
    jl Invalid
    cmp al, 6                 ; Перевіряємо, чи цифра <= 6
    jg Invalid
    jmp NextDigit

NextDigit:
    ; Якщо цифра дійсна
    inc esi                   ; Переходимо до наступної цифри
    inc ecx                   ; Збільшуємо позицію

    ; Якщо позиція досягла 5, завершуємо перевірку
    cmp ecx, 5
    je EndValidate

    jmp ValidateLoop


EndValidate:
    xor eax, eax          ; Якщо всі цифри коректні, повертаємо 0
    pop ebx
    pop esi
    ret

Invalid:
    ; Недійсна цифра, повертаємо позицію
    mov eax, ecx
    add eax, 1             ; Позиція буде від 1 до 5
    pop ebx
    pop esi
    ret

Validate_PIN ENDP

END main

