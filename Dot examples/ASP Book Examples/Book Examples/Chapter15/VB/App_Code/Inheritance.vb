
Public Class BaseProduct

    Private _price As Decimal

    Public Property Price() As Decimal
        Get
            Return _price
        End Get
        Set(ByVal Value As Decimal)
            _price = Value
        End Set
    End Property

End Class

Public Class ComputerProduct
    Inherits BaseProduct

    Private _processor As String

    Public Property Processor() As String
        Get
            Return _processor
        End Get
        Set(ByVal Value As String)
            _processor = value
        End Set
    End Property

End Class

Public Class TelevisionProduct
    Inherits BaseProduct

    Private _isHDTV As Boolean

    Public Property IsHDTV() As Boolean
        Get
            Return _isHDTV
        End Get
        Set(ByVal Value As Boolean)
            _isHDTV = value
        End Set
    End Property

End Class

