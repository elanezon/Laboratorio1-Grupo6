# Laboratorio 1: 5-tap FIR filter
### EL4314 - Arquitectura de Computadoras I
### Escuela de Ingeniería Electrónica
### Tecnológico de Costa Rica

<br/><br/>

### Preámbulo

Para el desarrollo de este laboratorio, usted deberá contar con una instalación de Linux, ya sea de forma nativa o mediante una máquina virtual. La siguiente es una [guía de creación de una máquina virtual con Ubuntu 22.04 LTS](https://github.com/EL4314/Laboratorio1_1Sem23/wiki/Guia_VM).

Una vez que ya tenga su máquina virtual, o si ya cuenta con una instalación nativa, proceda a instalar LiteX con la siguiente [guía instalación de LiteX](https://github.com/EL4314/Laboratorio1_1Sem23/wiki/Guia_instalacion_LiteX).

<br/><br/>

### 5-tap FIR filter

En este laboratorio usted implementará un [filtro FIR](https://es.wikipedia.org/wiki/FIR_(Finite_Impulse_Response)) (_Finite Impulse Response_) empleando lenguaje ensamblador para RV32I. Dicho filtro se ejecutará en un sistema en chip (SoC), creado con LiteX, y en el cual se tendrá un _core_ de RISC-V.

Un filtro FIR se define matemáticamente como:

$$\displaystyle y_{n}=\sum _{k=0}^{N-1}b_{k}x_{n-k}$$

lo cual se puede expresar alternativamente como:

$$
\displaystyle \begin{aligned}y[n] & = b_{0}x[n]+b_{1}x[n-1]+\cdots +b_{N}x[n-N]\\ 
     & = \sum _{i=0}^{N}b_{i}\cdot x[n-i] \\
     \end{aligned}
$$

Como se observa de las anteriores ecuaciones, el cálculo de la salida $y[n]$ depende de las muestras (entradas) $x[n]$ y las anteriores hasta la $x[n-N]$. Para el caso del filtro a implementar, 5-tap, requerira de la muestra $x[n]$ y las anteriores 4. 

Para el filtro a implementar, considere que los coeficientes $[b_0, b_1, b_2, b_3, b_4]$ el valor de los coeficientes como $[1,-2,3,-2,1]$.

<br/><br>

### Implementación
Para la implementación de su programa, deberá guiarse con código de ejemplo que le es provisto en este repositorio. Deberá crear una archivo en C, `fir.c` (y su correspondiente `fir.h`) que le permita capturar del usuario 10 muestras (entradas) a ser filtradas, así como desplegar el correspondiente resultado. Por ejemplo, se espera recibir una entrada como se muestra a continuación. El resultado obtenido se deberá mostrar como se ejemplifica. 

```bash
lab1> fir
[3,4,2,-3,-5,0,2,7,5,1]

Resultado
[3,-2,3,-1,2,1,-5,10,-8,8]
```


Las funcionalidades que implemente en dicho `fir.c` solamente serán para la captura y preparación de los datos que se procesarán con el filtro que será implementado en lenguaje ensamblador.

El programa en lenguaje ensamblador deberá recibir una muestra a la vez y ser capaz de almacenar hasta 4 muestras anteriores para poder realizar el filtrado de manera apropiada. Debido a que el filtro implica la suma de las entradas escaladas por los coeficientes, y que usted se debe limitar al uso de las instrucciones del ISA RV32I, deberá implementar una forma eficiente para realizar la multiplicación, considerando que las entradas y los coeficientes son enteros con signo.

_Hint_: El siguiente fragmento de código ilustra, desde la perspectiva de C, la entrada y la salida a su programa para el filtro que deberá implementar en lenguaje ensamblador.

```c
int fir(int xn) {
    ...
    return yn;
}
```

<br/><br>

### Resultados
Evalúe su implementación del filtro para al menos los siguientes casos:

````
[0,1,2,1,0,-1,-2,-1,0,1]
[-4,5,2,0,3,-3,1,4,2,-7]
[0,0,0,1,0,0,0,0,0,0]
[0,1,2,3,4,0,1,2,3,4]
````
y agregué acá los resultados obtenidos para estos conjuntos de datos de entrada.

````
[]
[]
[]
[]
````

<br/><br>

### Construcción del SoC y del código

Empleando LiteX, usted podrá construir un SoC para ejecutar el código desarrollar. Empleando:

```bash
litex_sim --integrated-main-ram-size=0x10000 --cpu-type=vexriscv --no-compile-gateware
```

podrá crearlo. Como producto de este comando, se producirá una carpeta `build`, la cuál deberemos referenciar al compilar el código.

En la carpeta `lab1` de este repositorio se encuentra el código de referencia a utilizar y modificar. En dicha carpera usted deberá agregar su código fuente, tanto `.c/.h` como `.S`. Además, deberá modificar el `Makefile` para asegurarse de que su código se compile y quede dentro del `.bin`.


```makefile
OBJECTS   = helloc.o add_asm.o add.o fir_asm.o fir.o crt0.o main.o
```

Una vez realizadas las modificaciones necesarias, desde la carpeta `lab1` podrá ejecutar un script de Python que se encargará de disparar la compilación 

```bash
./lab1.py --build-path=../build/sim
```

Para cargar el `.bin` generado y que se ejecute en el SoC, usted deberá ejecutar:

```bash
litex_sim --integrated-main-ram-size=0x10000 --cpu-type=vexriscv --ram-init=./lab1/lab1.bin
```

<br/><br>

### Evaluación
Este laboratorio se evaluará con la siguiente rúbrica


| Rubro | % | C | EP | D | NP |
|-------|---|---|----|---|----|
|`fir_asm.S` produce el resultado correcto| 50|   |    |   |    |
|Integración en `main.c`|30|   |    |   |    |
|Uso de repositorio |20|   |    |   |    |

C: Completo,
EP: En progreso ($\times 0,8$),
D: Deficiente ($\times 0,5$),
NP: No presenta ($\times 0$)

- El uso del repositorio implica que existan contribuciones de todos los miembros del equipo. El último _commit_ debe registrarte antes de las 23:59 del miércoles 15 de marzo de 2023.
