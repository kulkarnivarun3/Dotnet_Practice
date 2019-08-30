Imports System
Imports System.Collections
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.ComponentModel

Namespace myControls
    <ParseChildren(True, "Items")> _
    Public Class ItemRotator
        Inherits CompositeControl
        Private _items As ArrayList = New ArrayList()

        <Browsable(False)> _
        Public ReadOnly Property Items() As ArrayList
            Get
                Return _items
            End Get
        End Property

        Protected Overrides Sub CreateChildControls()
            Dim rnd As Random = New Random()
            Dim index As Integer = rnd.Next(_items.Count)
            Dim item As Control = CType(_items(index), Control)
            Me.Controls.Add(item)
        End Sub
    End Class

    Public Class Item
        Inherits Control

    End Class
End Namespace

