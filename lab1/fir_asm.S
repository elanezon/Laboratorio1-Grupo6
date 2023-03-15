.global fir_asm

fir_asm:

#addi x6, zero, 1         #b0 y b4
addi a5, zero, -2         #b1 y b3
addi a6, zero, 3          #b2
addi a7, zero, 2

DOS:
    add t0, zero, a5
    add t1, zero, a1
    addi a1, zero, 3
    j MULT

TRES:
    add t0, zero, a6
    add t1, zero, a2
    addi a2, zero, 4
    j MULT

CUATRO:
    add t0, zero, a5
    add t1, zero, a3
    addi a3, zero, 5
    j MULT

CINCO:
    add a0, a0, a4

SALIDA:
    #mv a0, s2
    jr ra

READY:
    add a0, a0, t5
    addi a7, a7, 1
    beq a7, a1, TRES
    beq a7, a2, CUATRO
    beq a7, a3, CINCO




MULT:
    add t2, zero, zero #inicializa counter
    add t5, zero, zero
    addi t6, zero, -1

    blt t0, zero, Negativo1 #Si el primer numero es negativo
    blt t1, zero, Negativo2 #Si el segundo numero es negativo

Loop:
    beq t2, t1, DONE_MULT
    add t5, t5, t0
    addi t2, t2, 1
    jal zero, Loop



Negativo1:
    addi t0, t0, -1
    xori t0, t0, 0xFFFFFFFF 
    addi t3, zero, 1
    addi t6, zero, 1
    blt t1, zero, Negativo2   #Si el segundo numero es negativo
    jal zero, Loop            #Si el segundo numero no es negativo hace la Multiplicacion

Negativo2:
    addi t1, t1, -1
    xori t1, t1, 0xFFFFFFFF
    addi t4, zero, 1
    addi t6, zero, 1
    beq t3, t4, dos_negativos
    jal zero, Loop

dos_negativos:
    addi t6, zero, -1
    addi t3, zero, 0
    addi t4, zero, 0
    jal zero, Loop

DONE_MULT:
    bge t6, zero, Complemento2
    jal zero, READY

Complemento2:
    xori t5, t5, 0xFFFFFFFF
    addi t5, t5, 1
    addi t6, zero, 24
    jal zero, READY
