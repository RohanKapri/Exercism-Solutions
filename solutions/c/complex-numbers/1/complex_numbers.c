// Dedicated to Shree DR.MDD

#include "complex_numbers.h"
#include <stdlib.h>
#include <math.h>
#include <stdio.h>

complex_t c_add(complex_t u, complex_t v)
{
   complex_t res;
   res.real = u.real + v.real;
   res.imag = u.imag + v.imag;
   return res;
}

complex_t c_sub(complex_t u, complex_t v)
{
   complex_t res;
   res.real = u.real - v.real;
   res.imag = u.imag - v.imag;
   return res;
}

complex_t c_mul(complex_t u, complex_t v)
{
   complex_t res;
   res.real = u.real * v.real - u.imag * v.imag;
   res.imag = u.imag * v.real + u.real * v.imag;
   return res;
}

complex_t c_div(complex_t u, complex_t v)
{
   complex_t res;
   res.real = (u.real * v.real + u.imag * v.imag) / (v.real * v.real + v.imag * v.imag);
   res.imag = (u.imag * v.real - u.real * v.imag) / (v.real * v.real + v.imag * v.imag);
   return res;
}

double c_abs(complex_t u)
{
   return sqrt(u.real * u.real + u.imag * u.imag);
}

complex_t c_conjugate(complex_t u)
{
   complex_t res;
   res.real = u.real;
   res.imag = -u.imag;
   return res;
}

double c_real(complex_t u)
{
   return u.real;
}

double c_imag(complex_t u)
{
   return u.imag;
}

complex_t c_exp(complex_t u)
{
   complex_t res;
   res.real = exp(u.real) * cos(u.imag);
   res.imag = exp(u.real) * sin(u.imag);
   return res;
}
