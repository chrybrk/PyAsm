format ELF64 executable

sys_read            equ 0
sys_write           equ 1
sys_open            equ 2
sys_mmap            equ 9
sys_exit            equ 60

STDIN               equ 0
STDOUT              equ 1
STDERR              equ 2
NULL                equ 0

O_RDONLY            equ 0
PROT_READ           equ 1
PROT_WRITE          equ 2
MAP_PRIVATE         equ 2
MAP_ANONYMOUS       equ 32
MAP_FAILED          equ 0xffffffffffffffff

PROT_READ_or_PROT_WRITE         equ 3
MAP_PRIVATE_or_MAP_ANNOYMOUS    equ 34

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

; void *mmap(void addr[.length], size_t length, int prot, int flags, int fd, off_t offset);
macro mmap addr, length, prot, flags, fd, offset
{
    mov rax, sys_mmap
    mov rdi, addr
    mov rsi, length
    mov rdx, prot
    mov rcx, flags
    mov r8, fd
    mov r9, offset
    syscall
}

macro print_file char, buffer, length
{
    ; NOTE
    ; loop until rdx != length of buffer
    ; extract each byte from buffer

    mov rdx, 0
.loop:
    push rdx ; store rdx

    mov rax, buffer ; rax = &buffer
    mov eax, [rax+rdx] ; calculate next byte
    mov byte [char], al ; lower eax [ al ], stores byte

    write STDOUT, char, 1 ; output byte, NOTE: changing 1 => to any other number will result in buffer overflow

    mov byte [char], 10 ; 10 represents a newline
    write STDOUT, char, 1 ; again output byte

    ; some random shit, future me will understand
    pop rdx
    inc rdx
    mov rcx, [len]
    dec rcx
    cmp rdx, rcx
    jle .loop
}

segment readable executable
entry main

main:
    open pathname, O_RDONLY ; open returns rax: file descriptor (fd)
    cmp rax, 0
    jl .err
    mov qword [file_fd], rax

    read qword [file_fd], buffer, MAX_READ
    mov qword [len], rax

    write STDOUT, buffer, [len] ; print buffer

    mov dword [structure], 10
    mov dword [structure+4], 20

    write STDOUT, ok_msg, ok_msg_len ; OK, if everything went well.
    exit 0

.err:
    write STDERR, err_msg, err_msg_len
    exit 1

segment readable writable
pathname db "main.py"
file_fd dq 0
len dq 0

; msg
err_msg db "[ERR]: ERROR!", 10
err_msg_len = $ - err_msg

ok_msg db "[INFO]: OK!", 10
ok_msg_len = $ - ok_msg

char db 0
buffer db 0
structure rq 1024
