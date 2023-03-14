
#[1,-2,3,-2,1]
#
#[3,4,2,-3,-5,0,2,7,5,1]

fir_asm:
addi a0, x0, 1
addi a1, x0, 2
addi a2, x0, 3
addi a3, x0, 4
addi a4, x0, 5

#addi x6, x0, 1         #b0 y b4
addi x7, x0, 2          #b1 y b3
addi x8, x0, 3          #b2

addi x9, x0, 0          #CONTADOR
addi s2, x0, 0         #RESULTADO MULTIPLICACION
addi s3, x0, 0         #FINAL

HOLA:
    add s3, s3, a0

DOS:
    bne x9, x7, MULT_2
    add s3, s3, s2
    addi x9, x0, 0
    addi s2, x0, 0

TRES:
    bne x9, x8, MULT_3
    add s3, s3, s2
    addi x9, x0, 0
    addi s2, x0, 0

CUATRO:
    bne x9, x7, MULT_4
    add s3, s3, s2
    addi x9, x0, 0
    addi s2, x0, 0
    
CINCO:       
    add s2, s2, a4

SALIDA:
    mv a0, s3
    jr ra

MULT_2:
    beq x9, x7, DOS
    addi x9, x9, 1
    add s2, s2, a1
    jal x0, MULT_2

MULT_3:
    beq x9, x8, TRES
    addi x9, x9, 1
    add s2, s2, a2
    jal x0, MULT_3

MULT_4:
    beq x9, x7, CUATRO
    addi x9, x9, 1
    add s2, s2, a3
    jal x0, MULT_4