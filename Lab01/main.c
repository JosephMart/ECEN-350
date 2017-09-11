#include <stdio.h>

extern long long int test ( long long int b);

int main ( void ){

long long int a = test (24) ;  // Replace Y with any number you like

printf ("Result is = %d\n", a);

return 0;

}
