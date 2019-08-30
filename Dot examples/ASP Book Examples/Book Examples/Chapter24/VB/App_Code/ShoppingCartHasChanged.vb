Imports System
Imports System.Collections.Generic
Imports System.Web.Profile

Namespace AspNetUnleashed
    Public Class ShoppingCartHasChanged
        Private _hasChanged As Boolean = False
        Private _items As New List(Of CartItem)()

        Public Property HasChanged() As Boolean
            Get
                Return _hasChanged
            End Get
            Set(ByVal Value As Boolean)
                _hasChanged = value
            End Set
        End Property

        Public ReadOnly Property Items() As List(Of CartItem)
            Get
                Return _items
            End Get
        End Property
    End Class
End Namespace
