
Public Class ProductBase

    Private _price As Decimal

    Public Overridable Property Price() As Decimal
        Get
            Return _price
        End Get
        Set(ByVal Value As Decimal)
            _price = value
        End Set
    End Property

End Class


Public Class OnSaleProduct
    Inherits ProductBase

    Public Overrides Property Price() As Decimal
        Get
            Return MyBase.Price / 2
        End Get
        Set(ByVal Value As Decimal)
            MyBase.Price = value
        End Set
    End Property

End Class

