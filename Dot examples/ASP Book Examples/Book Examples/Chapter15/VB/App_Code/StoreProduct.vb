Public Class StoreProduct

    Public Sub SaveProduct(ByVal name As String)
        SaveProduct(name, 0, String.Empty)
    End Sub

    Public Sub SaveProduct(ByVal name As String, ByVal price As Decimal)
        SaveProduct(name, price, String.Empty)
    End Sub

    Public Sub SaveProduct(ByVal name As String, ByVal price As Decimal, ByVal description As String)
        ' Save name, price, description to database
    End Sub

End Class
