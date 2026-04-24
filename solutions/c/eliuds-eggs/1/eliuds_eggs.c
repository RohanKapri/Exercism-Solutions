// Dedicated to Shree DR.MDD

#include "eliuds_eggs.h"
#include "eliuds_eggs.h"

int egg_count(int number){
  int total = 0;
  while (number > 0) {
    if((number % 2) == 1) total++;
    number /= 2;
  }
  return total;
}
