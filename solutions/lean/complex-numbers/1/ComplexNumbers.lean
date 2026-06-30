namespace ComplexNumbers

structure ComplexNumber where
  real : Float
  imag : Float
  deriving Repr

/- define how a complex number should be constructed out of a literal number -/
instance {n : Nat} : OfNat ComplexNumber n where
  ofNat :=
    ⟨Float.ofNat n, 0⟩

@[inline] def real (z : ComplexNumber) : Float :=
  z.real

@[inline] def imaginary (z : ComplexNumber) : Float :=
  z.imag

@[inline] def mul (z1 : ComplexNumber) (z2 : ComplexNumber) : ComplexNumber :=
  if z1.imag == 0 then
    if z2.imag == 0 then
      ⟨z1.real * z2.real, 0⟩
    else
      ⟨z1.real * z2.real, z1.real * z2.imag⟩
  else if z2.imag == 0 then
    ⟨z1.real * z2.real, z1.imag * z2.real⟩
  else
    ⟨z1.real * z2.real - z1.imag * z2.imag,
     z1.imag * z2.real + z1.real * z2.imag⟩

@[inline] def div (z1 : ComplexNumber) (z2 : ComplexNumber) : ComplexNumber :=
  if z2.imag == 0 then
    ⟨z1.real / z2.real, z1.imag / z2.real⟩
  else
    let denom := z2.real * z2.real + z2.imag * z2.imag
    ⟨(z1.real * z2.real + z1.imag * z2.imag) / denom,
     (z1.imag * z2.real - z1.real * z2.imag) / denom⟩

@[inline] def sub (z1 : ComplexNumber) (z2 : ComplexNumber) : ComplexNumber :=
  ⟨z1.real - z2.real, z1.imag - z2.imag⟩

@[inline] def add (z1 : ComplexNumber) (z2 : ComplexNumber) : ComplexNumber :=
  ⟨z1.real + z2.real, z1.imag + z2.imag⟩

@[inline] def abs (z : ComplexNumber) : Float :=
  if z.imag == 0 then
    Float.abs z.real
  else if z.real == 0 then
    Float.abs z.imag
  else
    Float.sqrt (z.real * z.real + z.imag * z.imag)

@[inline] def conjugate (z : ComplexNumber) : ComplexNumber :=
  ⟨z.real, -z.imag⟩

@[inline] def exp (z : ComplexNumber) : ComplexNumber :=
  if z.imag == 0 then
    ⟨Float.exp z.real, 0⟩
  else
    let e := Float.exp z.real
    ⟨e * Float.cos z.imag, e * Float.sin z.imag⟩

end ComplexNumbers