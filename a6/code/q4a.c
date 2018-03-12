#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int* a;

void baz(int m, int p){
  a[p] += m;
}

void main(int argc, int** argv){
  a = malloc (10 * sizeof(int));
  int t = 1;
  int u = 2;
  baz(3, 4);
  baz(t, u);

  for(int i = 0; i < 10; i++){
    printf("%d\n", a[i]);
  }
}
