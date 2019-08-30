Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace myControls
    Public Class FullyRenderedWebControl
        Inherits WebControl

        Private _Text As String

        Public Property Text() As String
            Get
                Return _Text
            End Get
            Set(ByVal Value As String)
                _Text = value
            End Set
        End Property

        Protected Overrides Sub RenderContents(ByVal writer As HtmlTextWriter)
            writer.Write(_Text)
        End Sub

    End Class
End Namespace
