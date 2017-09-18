/* main.c simple program to test assembler program */

#include <stdio.h>

extern long long int test(long long int a);

int main(void)
{
    long long int a = test(33);
    printf("Result of test(3) = %ld\n", a);
    return 0;
}
