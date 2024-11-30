
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
    ; In a real-world Assembly program, you'd need to use a syscall to get time and generate randomness.

    mov dword [score], 0          ; Initialize score to 0
    mov eax, 2                    ; "Randomly" selected number to guess
    mov ebx, 0                    ; Counter for user guesses

guess_loop:
    ; Prompt user
    mov eax, 4                    ; Syscall number for sys_write
    mov ebx, 1                    ; File descriptor (stdout)
    mov ecx, prompt               ; Address of prompt message
    mov edx, 33                   ; Length of the prompt message
    int 0x80                      ; Call kernel

    ; Read user input
    mov eax, 3                    ; Syscall number for sys_read
    mov ebx, 0                    ; File descriptor (stdin)
    mov ecx, guess                ; Address to store user input
    mov edx, 1                    ; Read 1 byte (char)
    int 0x80                      ; Call kernel

    ; Convert ASCII input to integer
    sub byte [guess], '0'         ; Convert ASCII to integer (e.g., '2' -> 2)

    ; Compare guess with "random" number (2)
    mov al, [guess]               ; Load user guess
    cmp al, 2                     ; Compare with "random" number (2)
    je correct_guess              ; Jump to correct_guess if equal

wrong_guess:
    ; Print "Wrong guess"
    mov eax, 4                    ; Syscall number for sys_write
    mov ebx, 1                    ; File descriptor (stdout)
    mov ecx, wrong                ; Address of wrong message
    mov edx, 12                   ; Length of wrong message
    int 0x80                      ; Call kernel
    jmp guess_loop                ; Continue looping

correct_guess:
    ; Print "Correct guess"
    mov eax, 4                    ; Syscall number for sys_write
    mov ebx, 1                    ; File descriptor (stdout)
    mov ecx, correct              ; Address of correct message
    mov edx, 19                   ; Length of correct message
    int 0x80                      ; Call kernel

    ; Increment score
    mov eax, [score]
    inc eax
    mov [score], eax              ; Save the updated score

    ; Print score
    mov eax, 4                    ; Syscall number for sys_write
    mov ebx, 1                    ; File descriptor (stdout)
    mov ecx, score_msg            ; Address of score message
    mov edx, 15                   ; Length of score message
    int 0x80                      ; Call kernel

    ; Print score number
    mov eax, 4                    ; Syscall number for sys_write
    mov ebx, 1                    ; File descriptor (stdout)
    mov ecx, score                ; Address of score number
    mov edx, 4                    ; Length of score number (32-bit integer)
    int 0x80                      ; Call kernel

    ; Print newline
    mov eax, 4                    ; Syscall number for sys_write
    mov ebx, 1                    ; File descriptor (stdout)
    mov ecx, newline              ; Address of newline
    mov edx, 1                    ; Length of newline
    int 0x80                      ; Call kernel

    ; Exit program
    mov eax, 1                    ; Syscall number for sys_exit
    xor ebx, ebx                  ; Return 0 status code
    int 0x80                      ; Call kernel
