
#[1,-2,3,-2,1]
#
#[3,4,2,-3,-5,0,2,7,5,1]
addi a1, x0, 0
addi a2, x0, 0
addi a3, x0, 0
addi a4, x0, 0

addi x6, x0, 1      #b0 y b4
addi x7, x0, 2     #b1 y b3
addi x8, x0, 3      #b2

addi x9, x0, 0      #CONTADOR
addi x10, x0, 0     #RESULTADO MULTIPLICACION
addi x11, x0, 0     #FINAL

addi x12, x0, 10    #VALOR 10
addi x13, x0, 0     #CONTADOR FINAL

HOLA:
    bne x9, x6, MULT_1      #SI NO SON IGUALES, O SEA NO SE HA HECHO MULT, VAYA A HACERLA
    add x11, x11, x10       #RESULTADO DE PRIMERA MULT
    addi x9, x0, 0          #SI YA LA HIZO, SIGA A LA SIGUIENTE
    beq x13, x12, END
    jal x0, DOS
DOS:
    bne x9, x7, MULT_2
    add x11, x11, x10
    addi x9, x0, 0
    jal x0, TRES
TRES:
    bne x9, x8, MULT_3
    add x11, x11, x10
    addi x9, x0, 0
    jal x0, CUATRO
CUATRO:
    bne x9, x7, MULT_4
    add x11, x11, x10
    addi x9, x0, 0
    jal x0, CINCO
CINCO:
    bne x9, x6, MULT_5
    add x11, x11, x10 
    addi x9, x0, 0
    jal x0, CAMBIO

MULT_1:       
    beq x9, x6, HOLA
    addi x9, x9, 1
    add x10, x10, a0
    jal x0, MULT_1

MULT_2:
    beq x9, x7, DOS
    addi x9, x9, 1
    add x10, x10, a1
    jal x0, MULT_2

MULT_3:
    beq x9, x8, TRES
    addi x9, x9, 1
    add x10, x10, a2
    jal x0, MULT_3

MULT_4:
    beq x9, x7, CUATRO
    addi x9, x9, 1
    add x10, x10, a3
    jal x0, MULT_4

MULT_5:
    beq x9, x6, CINCO
    addi x9, x9, 1
    add x10, x10, a4
    jal x0, MULT_5

CAMBIO:
    add a0, x0, a1
    add a1, x0, a2
    add a2, x0, a3
    add a3, x0, a4
    add a4, x0, a5
    jal x0, HOLA

END:
    add x0, x0, x0



#UNO:
#    sw x11, 0(a0)   #SE GUARDA EN LA SALIDA LA ENTRADA PORQUE ES MULT POR 1
#    add a1, x0, a0  #SE CAMBIA EL VALOR DE N A N-1
#
#    jal x0, DOS     #SE VA A LA MULT CON 2 VALORES

#DOS:



