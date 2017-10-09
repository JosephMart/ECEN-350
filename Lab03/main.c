/* main.c simple program to test assembler program */

#include <stdio.h>

extern long long int array();

int main(void)
{
    long long int a = array();
    return 0;
}
