// This file is Copyright (c) 2020 Florent Kermarrec <florent@enjoy-digital.fr>
// License: BSD
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <irq.h>
#include <libbase/uart.h>
#include <libbase/console.h>
#include <generated/csr.h>


/*-----------------------------------------------------------------------*/
/* Uart                                                                  */
/*-----------------------------------------------------------------------*/

static char *readstr(void)
{
	char c[2];
	static char s[64];
	static int ptr = 0;

	if(readchar_nonblock()) {
		c[0] = getchar();
		c[1] = 0;
		switch(c[0]) {
			case 0x7f:
			case 0x08:
				if(ptr > 0) {
					ptr--;
					fputs("\x08 \x08", stdout);
				}
				break;
			case 0x07:
				break;
			case '\r':
			case '\n':
				s[ptr] = 0x00;
				fputs("\n", stdout);
				ptr = 0;
				return s;
			default:
				if(ptr >= (sizeof(s) - 1))
					break;
				fputs(c, stdout);
				s[ptr] = c[0];
				ptr++;
				break;
		}
	}

	return NULL;
}

static char *get_token(char **str)

{
	char *c, *d;
	c = (char *)strchr(*str, ' ');
	if(c == NULL) {
		d = *str;
		*str = *str+strlen(*str);
		return d;
	}
	*c = 0;
	d = *str;
	*str = c+1;
	return d;
}

static void prompt(void)

{
	printf("\e[92;1mlab1\e[0m> ");

}

/*-----------------------------------------------------------------------*/
/* Help                                                                  */
/*-----------------------------------------------------------------------*/

static void help(void)

{
	puts("\nLiteX minimal - Lab 1 "__DATE__" "__TIME__"\n");
	puts("Available commands:");
	puts("help               - Show this command");
	puts("reboot             - Reboot CPU");
	puts("helloc             - Hello C");
	puts("fir                - Fir filter");
}

/*-----------------------------------------------------------------------*/
/* Commands                                                              */
/*-----------------------------------------------------------------------*/

static void reboot_cmd(void)
{
	ctrl_reset_write(1);
}

extern void helloc(void);

static void helloc_cmd(void)
{
	printf("Hello C demo...\n");
	helloc();
}

extern int fir(int a,int b,int c,int d,int e); 

static void fir_cmd(void){

	char *str1;
	char *token1;
	printf("Ingrese los valores : \n");
	str1 = readstr();
	while(str1 == NULL){
		str1 = readstr();
	}	

	token1 = get_token(&str1);	
	int lentoken = strlen(token1);
	//printf("%d \n", lentoken);
	char numstring[lentoken];
	int j = 0;
	int k = 0;
	int nums[10];

	for (int i = 1; i < lentoken; i++){
		if (token1[i] != ','){
			numstring[j] = token1[i]; 
			j++;
		}else {
			nums[k] = atoi(numstring);
			for(int q=0;q<lentoken;q++){
    				numstring[q] = 0;
    			}
			
			k++;
			j = 0;
		}
	}
	nums[k] = atoi(numstring);

	//int size = sizeof(nums)/sizeof(nums[0]);
	//for (int i = 0; i < size; i++){
	//	printf("%d," , nums[i]);
	//}

	//int finalNum[10];

	//finalNum[0] = fir(nums[0],0,0,0,0);
	//finalNum[1] = fir(nums[1],nums[0],0,0,0);
	//finalNum[2] = fir(nums[2],nums[1],nums[0],0,0);
	//finalNum[3] = fir(nums[3],nums[2],nums[1],nums[0],0);
	//finalNum[4] = fir(nums[4],nums[3],nums[2],nums[1],nums[0]);
	//finalNum[5] = fir(nums[5],nums[4],nums[3],nums[2],nums[1]);
	//finalNum[6] = fir(nums[6],nums[5],nums[4],nums[3],nums[2]);
	//finalNum[7] = fir(nums[7],nums[6],nums[5],nums[4],nums[3]);
	//finalNum[8] = fir(nums[8],nums[7],nums[6],nums[5],nums[4]);
	//finalNum[9] = fir(nums[9],nums[8],nums[7],nums[6],nums[5]);

	//printf("Resultado : [%d,%d,%d,%d,%d,%d,%d,%d,%d,%d] \n", finalNum[0],finalNum[1],finalNum[2],finalNum[3],finalNum[4],finalNum[5],finalNum[6],finalNum[7],finalNum[8],finalNum[9]);

	int finalNum[10];

	printf("Resultado : [%d,%d,%d,%d,%d,%d,%d,%d,%d,%d] \n"
	,fir(nums[0],0,0,0,0)
	,fir(nums[1],nums[0],0,0,0)
	,fir(nums[2],nums[1],nums[0],0,0)
	,fir(nums[3],nums[2],nums[1],nums[0],0)
	,fir(nums[4],nums[3],nums[2],nums[1],nums[0])
	,fir(nums[5],nums[4],nums[3],nums[2],nums[1])
	,fir(nums[6],nums[5],nums[4],nums[3],nums[2])
	,fir(nums[7],nums[6],nums[5],nums[4],nums[3])
	,fir(nums[8],nums[7],nums[6],nums[5],nums[4])
	,fir(nums[9],nums[8],nums[7],nums[6],nums[5]));
}

extern int add(int a, int b, int c, int d, int e);
static void add_cmd(void)
{
	int a = 1;
	int b = 2;
	int c = 1;
	int d = 1;
	int e = 1;

	printf("Adding %d + %d is = %d \r\n", a, b, add(a,b,c,d,e));

}

/*-----------------------------------------------------------------------*/
/* Console service / Main                                                */
/*-----------------------------------------------------------------------*/

static void console_service(void)
{
	char *str;
	char *token;

	str = readstr();
	if(str == NULL) return;
	token = get_token(&str);
	if(strcmp(token, "help") == 0)
		help();
	else if(strcmp(token, "reboot") == 0)
		reboot_cmd();
	else if(strcmp(token, "helloc") == 0)
		printf("HelloC");
	else if(strcmp(token, "fir") == 0)
		fir_cmd();
	prompt();

}

int main(void)
{
#ifdef CONFIG_CPU_HAS_INTERRUPT
	irq_setmask(0);
	irq_setie(1);
#endif
	uart_init();
	help();
	prompt();
	while(1) {
		console_service();
	}
	return 0;
}
