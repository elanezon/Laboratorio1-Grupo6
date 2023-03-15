#include <stdio.h>

extern void fir_asm(void);

int fir(int a,int b,int c,int d,int e); 
int fir(int a,int b,int c,int d,int e) {
	fir_asm();
}