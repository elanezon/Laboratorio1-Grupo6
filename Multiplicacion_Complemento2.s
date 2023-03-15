INIT:
addi t0, x0, 4
addi t1, x0, 6

MULT:
    add t2, x0, x0 #inicializa counter
    add t5, x0, x0
    addi t6, x0, -1

    blt t0, x0, Negativo1 #Si el primer numero es negativo
    blt t1, x0, Negativo2 #Si el segundo numero es negativo

Loop:
    add t5, t5, t0
    addi t2, t2, 1
    beq t2, t1, DONE_MULT
    jal x0, Loop



Negativo1:
    addi t0, t0, -1
    xori t0, t0, 0xFFFFFFFF
    addi t3, x0, 1
    addi t6, x0, 1
    blt t1, x0, Negativo2 #Si el segundo numero es negativo
    jal x0, Loop #Si el segundo numero no es negativo hace la Multiplicacion

Negativo2:
    addi t1, t1, -1
    xori t1, t1, 0xFFFFFFFF
    addi t4, x0, 1
    addi t6, x0, 1
    beq t3, t4, 2Negativos
    jal x0, Loop

2Negativos:
    addi t6, x0, -1
    addi t3, x0, 0
    addi t4, x0, 0
    jal x0, Loop

DONE_MULT:
    bge t6, x0, Complemento2
    jal x0, INIT

Complemento2:
    xori t5, t5, 0xFFFFFFFF
    addi t5, t5, 1
    addi t6, x0, 24
    jal x0, INIT
