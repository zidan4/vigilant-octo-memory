
section .data
    prompt_amount db "Enter amount in USD: ", 0
    prompt_currency db "Select currency (1=EUR, 2=GBP, 3=JPY, 4=INR): ", 0
    result_format db "Converted amount: %.2f", 10, 0   ; "%.2f" for two decimal places
    newline db 10, 0
    currency_rates dq 0.85, 0.75, 110.50, 82.00  ; USD to EUR, GBP, JPY, INR

section .bss
    amount resq 1     ; Storage for user input amount
    currency_choice resq 1  ; Storage for selected currency

section .text
    global _start
    extern printf, scanf

_start:
    ; Prompt for amount
    mov rdi, prompt_amount
    call print_string

    ; Read user input (amount in USD)
    mov rsi, amount
    mov rdi, scanf_format
    call scanf

    ; Prompt for currency choice
    mov rdi, prompt_currency
    call print_string

    ; Read user input (currency choice)
    mov rsi, currency_choice
    mov rdi, scanf_format_int
    call scanf

    ; Validate input (must be 1-4)
    mov rax, [currency_choice]
    cmp rax, 1
    jl exit_program   ; Invalid choice → exit
    cmp rax, 4
    jg exit_program   ; Invalid choice → exit

    ; Convert currency
    dec rax           ; Convert choice (1-4) to index (0-3)
    mov rbx, 8        ; Each rate is 8 bytes (double)
    mul rbx           ; rax = index * 8
    lea rdx, [currency_rates]  ; Base address of rates
    add rdx, rax      ; Point to selected rate

    fld qword [amount]  ; Load amount into FPU stack
    fmul qword [rdx]    ; Multiply by selected exchange rate

    ; Print formatted result
    sub rsp, 8          ; Align stack (for printf)
    fstp qword [rsp]    ; Store result
    mov rdi, result_format
    call printf
    add rsp, 8          ; Restore stack

exit_program:
    ; Exit syscall
    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; status: 0
    syscall

print_string:
    mov rsi, rdi        ; Load string into RSI
    mov rdx, 100        ; Assume max length 100
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; stdout
    syscall
    ret

scanf_format:
    db "%lf", 0
scanf_format_int:
    db "%ld", 0

