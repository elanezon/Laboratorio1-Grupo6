fir_asm:
addi a0, zero, -5
addi a1, zero, -3
addi a2, zero, 2
addi a3, zero, 4
addi a4, zero, 3

#addi x6, zero, 1         #b0 y b4
addi s0, zero, -2         #b1 y b3
addi s1, zero, 3          #b2

addi s2, zero, 0         #FINAL
addi s3, zero, 2

UNO:
    add s2, s2, a0

DOS:
    add t0, zero, s0
    add t1, zero, a1
    addi s4, zero, 3
    j MULT

TRES:
    add t0, zero, s1
    add t1, zero, a2
    addi s5, zero, 4
    j MULT

CUATRO:
    add t0, zero, s0
    add t1, zero, a3
    addi s6, zero, 5
    j MULT

CINCO:       
    add s2, s2, a4

SALIDA:
    #mv a0, s2
    #jr ra
    j SALIDA

READY:
    add s2, s2, t5
    addi s3, s3, 1
    beq s3, s4, TRES
    beq s3, s5, CUATRO
    beq s3, s6, CINCO




MULT:
    add t2, zero, zero #inicializa counter
    add t5, zero, zero
    addi t6, zero, -1

    blt t0, zero, Negativo1 #Si el primer numero es negativo
    blt t1, zero, Negativo2 #Si el segundo numero es negativo

Loop:
    add t5, t5, t0
    addi t2, t2, 1
    beq t2, t1, DONE_MULT
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
    beq t3, t4, 2Negativos
    jal zero, Loop

2Negativos:
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