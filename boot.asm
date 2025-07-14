[org 0x7c00]
[bits 16]

start:
    ; 清屏
    mov ah, 0x06
    mov al, 0          ; 滚动全部行
    mov bh, 0x07       ; 属性
    mov cx, 0x0000     ; 左上角 (0,0)
    mov dx, 0x184f     ; 右下角 (24,79)
    int 0x10

    mov si, msg
.print:
    lodsb
    or al, al
    jz .hang
    mov ah, 0x0e
    mov bh, 0x00
    mov bl, 0x07
    int 0x10
    jmp .print

.hang:
    jmp $

msg: db "hello, world", 0

times 510-($-$$) db 0
db 0x55, 0xaa