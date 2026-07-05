Public Module Atbash
    Private Function Switcheroo (arg As String, mode As boolean) As string
      Dim test = LCase(arg)
      Dim result as String = ""
      Dim counter as short = 0
        For Each c As Char in test
          Select Case c
            Case "a"
              result &= "z"
            Case "b"
              result &= "y"
            Case "c"
              result &= "x"
            Case "d"
              result &= "w"
            Case "e"
              result &= "v"
            Case "f"
              result &= "u"
            Case "g"
              result &= "t"
            Case "h"
              result &= "s"
            Case "i"
              result &= "r"
            Case "j"
              result &= "q"
            Case "k"
              result &= "p"
            Case "l"
              result &= "o"
            Case "m"
              result &= "n"
            Case "n"
              result &= "m"
            Case "o"
              result &= "l"
            Case "p"
              result &= "k"
            Case "q"
              result &= "j"
            Case "r"
              result &= "i"
            Case "s"
              result &= "h"
            Case "t"
              result &= "g"
            Case "u"
              result &= "f"
            Case "v"
              result &= "e"
            Case "w"
              result &= "d"
            Case "x"
              result &= "c"
            Case "y"
              result &= "b"
            Case "z"
              result &= "a"
            Case " "
              'if mode = 1 then
                continue for
              'end if
            Case ","
                continue for
            Case "."
                continue for
            Case Else
              result &= c
          End Select
          if mode = 0 then
            counter += 1
            if counter = 5 then
              result &= " "
              counter = 0
            End If
          end if
        Next
        return result.Trim()
    End Function
    Public Function Encode(arg As String) As String
        'Throw New NotImplementedException("You need to implement this function")\
        return Switcheroo(arg, false)
    End Function

    Public Function Decode(arg As String) As String
        'Throw New NotImplementedException("You need to implement this function")
        return Switcheroo(arg, true)
    End Function
End Module