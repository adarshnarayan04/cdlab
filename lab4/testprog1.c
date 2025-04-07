#include <stdio.h>

int main()
{
  int a[100], i, j;
  a[0] = 10; a[1] = 20;
  for (i = 2; i < 100; i++) 
  { a[i] = a[i-1]*i + a[i-2]*(i-1);}  
  printf(" a[1] : %d \n", a[1]);
  return 0;
}
