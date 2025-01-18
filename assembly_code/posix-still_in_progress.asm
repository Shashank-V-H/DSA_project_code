
section .data
    prompt db "Guess the random number between 1 and 3: ", 0
    correct db "You guessed it right!", 0
    wrong db "Wrong guess.", 0
    score_msg db "Your score is: ", 0
    newline db 10, 0

section .bss
    guess resb 1          ; To store the user's guess
    score resd 1          ; To store the score

section .text
    global _start

_start:
    ; Initialize the random seed (using current time)
    ; For simplicity, we use a fixed "random" number, e.g., 2

    mov dword [score], 0          ; Initialize score to 0
    mov eax, 2                    ; "Randomly" selected number to guess
    mov ebx, 0                    ; Counter for user guesses

guess_loop:
    ; Prompt user
    mov rax, 0x2000004            ; Syscall number for write
    mov rdi, 1                    ; File descriptor (stdout)
    mov rsi, prompt               ; Address of prompt message
    mov rdx, 33                   ; Length of the prompt message
    syscall                       ; Call kernel

    ; Read user input
    mov rax, 0x2000003            ; Syscall number for read
    mov rdi, 0                    ; File descriptor (stdin)
    mov rsi, guess                ; Address to store user input
    mov rdx, 1                    ; Read 1 byte (char)
    syscall                       ; Call kernel

    ; Convert ASCII input to integer
    sub byte [guess], '0'         ; Convert ASCII to integer (e.g., '2' -> 2)

    ; Compare guess with "random" number (2)
    mov al, [guess]               ; Load user guess
    cmp al, 2                     ; Compare with "random" number (2)
    je correct_guess              ; Jump to correct_guess if equal

wrong_guess:
    ; Print "Wrong guess"
    mov rax, 0x2000004            ; Syscall number for write
    mov rdi, 1                    ; File descriptor (stdout)
    mov rsi, wrong                ; Address of wrong message
    mov rdx, 12                   ; Length of wrong message
    syscall                       ; Call kernel
    jmp guess_loop                ; Continue looping

correct_guess:
    ; Print "Correct guess"
    mov rax, 0x2000004            ; Syscall number for write
    mov rdi, 1                    ; File descriptor (stdout)
    mov rsi, correct              ; Address of correct message
    mov rdx, 19                   ; Length of correct message
    syscall                       ; Call kernel

    ; Increment score
    mov eax, [score]
    inc eax
    mov [score], eax              ; Save the updated score

    ; Print score
    mov rax, 0x2000004            ; Syscall number for write
    mov rdi, 1                    ; File descriptor (stdout)
    mov rsi, score_msg            ; Address of score message
    mov rdx, 15                   ; Length of score message
    syscall                       ; Call kernel

    ; Print newline
    mov rax, 0x2000004            ; Syscall number for write
    mov rdi, 1                    ; File descriptor (stdout)
    mov rsi, newline              ; Address of newline
    mov rdx, 1                    ; Length of newline
    syscall                       ; Call kernel

    ; Exit program
    mov rax, 0x2000001            ; Syscall number for exit
    xor rdi, rdi                  ; Return 0 status code
    syscall                       ; Call kernel
