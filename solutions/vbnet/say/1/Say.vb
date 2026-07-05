Public Module Say
    Private ReadOnly zeroThrough19 As IList(Of String) = New String() {"zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"}
    Private ReadOnly tens As IList(Of String) = New String() {Nothing, Nothing, "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"}
    Private ReadOnly translators As IEnumerable(Of (maximum As Long, translator As Func(Of Long, String))) = New(Long, Func(Of Long, String))() _
    {
        (20, Function(number) zeroThrough19(CInt(number))),
        (100, MakeTranslator(10, Function(number) tens(CInt(number)), "", "-"c)),
        (1000, MakeTranslator(100, AddressOf Translate, " hundred")),
        (1000000, MakeTranslator(1000, AddressOf Translate, " thousand")),
        (1000000000, MakeTranslator(1000000, AddressOf Translate, " million")),
        (1000000000000, MakeTranslator(1000000000, AddressOf Translate, " billion"))
    }

    Private Function Translate(number As Long) As String
        Return translators.First(Function(translator) translator.maximum > number).translator(number)
    End Function

    Private Function MakeTranslator(divisor As Integer, mostSignificantDigitsHandler As Func(Of Long, String), unit As String, Optional separator As Char = " "c) As Func(Of Long, String)
        Return Function(number) mostSignificantDigitsHandler(number \ divisor) & unit & If(number Mod divisor > 0, separator & Translate(number Mod divisor), "")
    End Function

    Public Function InEnglish(number As Long) As String
        If number >= 0 AndAlso number < translators.Last().maximum Then
            Return Translate(number)
        Else
            Throw New ArgumentOutOfRangeException()
        End If
    End Function
End Module