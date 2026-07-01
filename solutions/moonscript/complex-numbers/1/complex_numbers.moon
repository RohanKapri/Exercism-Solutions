class ComplexNumber
  new: (a, b) =>
    @a = a
    @b = b

  real: => @a
  imaginary: => @b
  conjugate: => ComplexNumber(@a, -@b)

  abs2: => @a * @a + @b * @b
  abs: => @\abs2! ^ 0.5

  exp: =>
    e = math.exp(@a)
    c = math.cos(@b)
    s = math.sin(@b)
    ComplexNumber(c * e, s * e)

  __eq: (other) =>
    math.abs(@a - other.a) < 1e-6 and math.abs(@b - other.b) < 1e-6

  __add: (other) => ComplexNumber(@a + other.a, @b + other.b)
  __sub: (other) => ComplexNumber(@a - other.a, @b - other.b)
  __mul: (other) =>
    a = @a * other.a - @b * other.b
    b = @a * other.b + @b * other.a
    ComplexNumber(a, b)
  __div: (other) =>
    n2 = other\abs2!
    tmp = @ * other\conjugate!
    tmp.a /= n2
    tmp.b /= n2
    tmp

  -- Also implement metamethods for the arithmetic operations

make_z = (z) ->
  if type(z) == "number"
    ComplexNumber(z, 0)
  elseif type(z) == "table"
    assert z.__class == ComplexNumber, "not a complex number!"
    z
  else
    error "neither a complex number nor a real number"

-- For arithmetic operations between real and complex numbers
add = (a, b) -> make_z(a) + make_z(b)
sub = (a, b) -> make_z(a) - make_z(b)
mul = (a, b) -> make_z(a) * make_z(b)
div = (a, b) -> make_z(a) / make_z(b)

{ :ComplexNumber, :add, :sub, :mul, :div }