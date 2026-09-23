.globl _start

_start:
    jal main
    li a0, 0
    li a7, 93 # exit
    ecall


main:
    jal read

    li     

    # Roda até b = 0 e a = b, a é MDC
    1: 
    beqz a1, 1f
    rem t0, a0, a1 
    mv a0, a1
    mv a1, t0
    bnez a1, 1b

    1:
    mv a1, a2
    mul t0, a0, a1
    div a3, t0, a0
    ret
    # Transforma a4 no MMC

read:
    li a0, 0            # file descriptor = 0 (stdin)
    la a1, input_address # buffer
    li a2, 6            # size - Reads 6 bytes.
    li a7, 63           # syscall read (63)
    ecall
    ret

write:
    li a0, 1            # file descriptor = 1 (stdout)
    la a1, result       # buffer
    li a2, 5            # size - Writes 5 bytes.
    li a7, 64           # syscall write (64)
    ecall
    ret

.bss

input_address: .skip 0x06  # buffer

result: .skip 0x5
