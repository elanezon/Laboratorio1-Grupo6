#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include<conio.h>

void removeChar(char * str, char charToRemmove){
    int i, j;
    int len = strlen(str);
    for(i=0; i<len; i++)
    {
        if(str[i] == charToRemmove)
        {
            for(j=i; j<len; j++)
            {
                str[j] = str[j+1];
            }
            len--;
            i--;
        }
    }
}

int main() {
    int num;
    char string[30];
    int nums[10];  

    // Input
    int i,j;

    printf("Enter the string:\n");
    scanf("%s", &string);

    removeChar(string, '[');
    removeChar(string, ']');
    removeChar(string, ',');

    i = 0;
    j = 0;
    while(i<strlen(string)){
        if (string[i] == '-'){
            nums[j] = string[i+1] - '0';
            nums[j] = nums[j] * -1;
            i += 2;
            j += 1;
        }
        else {
            nums[j] = string[i] - '0';
            i += 1;
            j += 1;
        }
    }

    for (i=0; i<sizeof(nums) / sizeof(nums[0]); i++) {
        printf("%d\n", nums[i]);
    }

    printf("\n");

    return 0;
}