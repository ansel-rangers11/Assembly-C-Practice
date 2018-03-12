#include <stdlib.h>
#include <stdio.h>
#include <string.h>


int x[8] = {1, 2, 3, 0xffffffff, 0xfffffffe, 0, 184, 340057058};
int y[8];

int bar(int a){
  int m = 0;
  while (a != 0){
    if ((a & 0x80000000) != 0)
      m++;
    a = a << 1;
  }
  return m;
}

void main(int argc, int** argv){
  int a = 8;
  while(a > 0){
    a--;
    y[a] = bar(x[a]);
  }

  for(int i = 0; i < 8; i++){
    printf("%d\n", x[a]);
  }

  for(int i = 0; i < 8; i++){
    printf("%d\n", y[a]);
  }
}
