Imports System
Imports System.Numerics

Public Module DiffieHellman
    Public Function PrivateKey(ByVal primeP As BigInteger) As BigInteger
        Dim rand As New Random()
        Return rand.Next(CInt(primeP))
    End Function

    Public Function PublicKey(ByVal primeP As BigInteger, ByVal primeG As BigInteger, ByVal privateKey As BigInteger) As BigInteger
        Return BigInteger.ModPow(primeG, privateKey, primeP)
    End Function

    Public Function Secret(ByVal primeP As BigInteger, ByVal publicKey As BigInteger, ByVal privateKey As BigInteger) As BigInteger
        Return BigInteger.ModPow(publicKey, privateKey, primeP)
    End Function
End Module