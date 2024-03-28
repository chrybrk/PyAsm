format ELF64 executable

; Task
; - Able to read file from somewhere
; - Able to parse it

sys_read equ 0
sys_write equ 1
sys_open equ 2
sys_exit equ 60

STDIN equ 0
STDOUT equ 1
STDERR equ 2

O_RDONLY equ 0

MAX_READ equ 1024 ; bytes

macro write fd, buffer, count
{
    mov rax, sys_write
    mov rdi, fd
    mov rsi, buffer
    mov rdx, count
    syscall
}

macro exit code
{
    mov rax, sys_exit
    mov rdi, code
    syscall
}


; int open(const char *pathname, int flags);
macro open pathname, flags
{
    mov rax, sys_open
    mov rdi, pathname
    mov rsi, flags
    syscall
}

macro read fd, buffer, length
{
    mov rax, sys_read
    mov rdi, fd
    mov rsi, buffer
    mov rdx, length
    syscall
}

segment readable executable
entry main

main:
    open pathname, O_RDONLY
    cmp rax, 0
    jl .err
    mov qword [file_fd], rax

    read qword [file_fd], buffer, MAX_READ
    mov qword [len], rax

    write STDOUT, buffer, [len]

    write STDOUT, ok_msg, ok_msg_len 
    exit 0

.err:
    write STDERR, err_msg, err_msg_len
    exit 1

segment readable writable
pathname db "main.c"
file_fd dq 0
len dq 0

; msg
err_msg db "[ERR]: ERROR!", 10
err_msg_len = $ - err_msg

ok_msg db "[INFO]: OK!", 10
ok_msg_len = $ - ok_msg

buffer db 0
