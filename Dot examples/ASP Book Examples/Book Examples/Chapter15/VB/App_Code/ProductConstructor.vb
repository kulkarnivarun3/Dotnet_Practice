
Public Class ProductConstructor

    Public Sub New(ByVal name As String)
        Me.New(name, 0, String.Empty)
    End Sub

    Public Sub New(ByVal name As String, ByVal price As Decimal)
        Me.New(name, price, String.Empty)
    End Sub

    Public Sub New(ByVal name As String, ByVal price As Decimal, ByVal description As String)
        ' Use name, price, and description
    End Sub

End Class

