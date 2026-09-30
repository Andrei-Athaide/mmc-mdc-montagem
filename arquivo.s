.globl _start

_start:
    jal main
    li a0, 0
    li a7, 93 # exit
    ecall


main:
    addi sp, sp, -4
    sw ra, 0(sp)
    
    jal read

    lb t0, 0(a1)
    lb t1, 1(a1)
    lb t2, 3(a1)
    lb t3, 4(a1)

    li t4, 48
    sub t0, t0, t4 
    sub t1, t1, t4
    sub t2, t2, t4
    sub t3, t3, t4 

    li t5, 10
    mul t0, t0, t5
    add t0, t0, t1
    mul t2, t2, t5
    add t2, t2, t3

    mv a0, t0
    mv a1, t2 

    1: 
    beqz t2, 1f
    rem t6, t0, t2 
    mv t0, t2
    mv t2, t6
    bnez t2, 1b

    1:
    mul t6, a0, a1 
    div a3, t6, t0

    la t0, result
    li t1, 1000
    li t4, 10
    
    li t1, 1000
    div t2, a3, t1
    mul t3, t2, t1
    sub a3, a3, t3
    addi t2, t2, 48 
    sb t2, 0(t0)
    li t1, 100
    div t2, a3, t1
    mul t3, t2, t1
    sub a3, a3, t3
    addi t2, t2, 48
    sb t2, 1(t0)
    li t1, 10
    div t2, a3, t1
    mul t3, t2, t1
    sub a3, a3, t3
    addi t2, t2, 48
    sb t2, 2(t0)
    addi a3, a3, 48
    sb a3, 3(t0)
    li t1, '\n'
    sb t1, 4(t0)

    jal write

    lw ra, 0(sp)
    addi sp, sp, 4
    ret

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