Imports System
Imports System.Collections.Generic
Imports System.Web.Profile

Namespace AspNetUnleashed

    <Serializable()> _
    Public Class BinaryShoppingCart
        Private _items As New List(Of BinaryCartItem)()

        Public ReadOnly Property Items() As List(Of BinaryCartItem)
            Get
                Return _items
            End Get
        End Property
    End Class

    <Serializable()> _
    Public Class BinaryCartItem
        Private _name As String
        Private _price As Decimal
        Private _description As String

        Public Property Name() As String
            Get
                Return _name
            End Get
            Set(ByVal Value As String)
                _name = Value
            End Set
        End Property

        Public Property Price() As Decimal
            Get
                Return _price
            End Get
            Set(ByVal Value As Decimal)
                _price = Value
            End Set
        End Property

        Public Property Description() As String
            Get
                Return _description
            End Get
            Set(ByVal Value As String)
                _description = Value
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
