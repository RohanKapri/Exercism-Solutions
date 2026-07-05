Public Class Binary
	Private _number As String

	Public Sub New(binary As String)
		_number = binary
	End Sub
	Public Function ToDecimal() As Integer
		If Not isBinary(_number) Then Return 0
		Return Convert.ToInt32(_number, 2)
	End Function
	Private Function isBinary(text As String) As Boolean
		Return text.Replace("1", "").Replace("0", "") = String.Empty
	End Function
End Class