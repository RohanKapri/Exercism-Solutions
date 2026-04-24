// Dedicated to Shree DR.MDD

#include "triangle.h"

#include "triangle.h"

static bool validate_sides(triangle_t shape)
{
    bool res = false;
    if (shape.a + shape.b > shape.c &&
        shape.b + shape.c > shape.a &&
        shape.c + shape.a > shape.b)
    {
        res = true;
    }
    return res;
}

bool is_equilateral(triangle_t shape)
{
    bool res = false;
    if (shape.a == shape.b && shape.b == shape.c)
    {
        if (shape.a == 0)
        {
            res = false;
        }
        else
        {
            res = true;
        }
    }
    return res;
}

bool is_isosceles(triangle_t shape)
{
    bool res = false;
    if ((is_equilateral(shape) ||
         !is_scalene(shape)) &&
        validate_sides(shape))
    {
        res = true;
    }
    return res;
}

bool is_scalene(triangle_t shape)
{
    bool res = false;
    if (shape.a != shape.b &&
        shape.b != shape.c &&
        shape.c != shape.a &&
        validate_sides(shape))
    {
        res = true;
    }
    return res;
}
