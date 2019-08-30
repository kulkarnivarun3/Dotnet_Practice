
Public Interface IProduct

    ReadOnly Property Price() As Decimal

    Sub SaveProduct()

End Interface


Public Class MusicProduct
    Implements IProduct

    Public ReadOnly Property Price() As Decimal Implements IProduct.Price
        Get
            Return 12.99D
        End Get
    End Property

    Public Sub SaveProduct() Implements IProduct.SaveProduct
        ' Save Music Product
    End Sub

End Class


Public Class BookProduct
    Implements IProduct

    Public ReadOnly Property Price() As Decimal Implements IProduct.Price
        Get
            Return 23.99D
        End Get
    End Property

    Public Sub SaveProduct() Implements IProduct.SaveProduct
        ' Save Book Product
    End Sub

End Class

