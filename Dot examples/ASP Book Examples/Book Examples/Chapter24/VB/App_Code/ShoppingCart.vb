Imports System
Imports System.Collections.Generic
Imports System.Web.Profile

Namespace AspNetUnleashed
    Public Class ShoppingCart

        Private _items As New List(Of CartItem)()

        Public ReadOnly Property Items() As List(Of CartItem)
            Get
                Return _items
            End Get
        End Property
    End Class

    Public Class CartItem
        Private _name As String
        Private _price As Decimal
        Private _description As String

        Public Property Name() As String
            Get
                Return _name
            End Get
            Set(ByVal Value As String)
                _name = value
            End Set
        End Property

        Public Property Price() As Decimal
            Get
                Return _price
            End Get
            Set(ByVal Value As Decimal)
                _price = value
            End Set
        End Property

        Public Property Description() As String
            Get
                Return _description
            End Get
            Set(ByVal Value As String)
                _description = value
            End Set
        End Property

        Public Sub New()
        End Sub

        Public Sub New(ByVal name As String, ByVal price As Decimal, ByVal description As String)
            _name = name
            _price = price
            _description = description
        End Sub
    End Class
End Namespace

