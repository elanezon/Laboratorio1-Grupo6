#include <stdio.h>

extern void add_asm(void);

int add(int a, int b);
int add(int a, int b) {
	add_asm();
}
