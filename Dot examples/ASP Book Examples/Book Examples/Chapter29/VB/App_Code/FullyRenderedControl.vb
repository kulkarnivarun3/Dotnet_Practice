Imports System.Web.UI

Namespace myControls
    Public Class FullyRenderedControl
        Inherits Control

        Private _Text As String

        Public Property Text() As String
            Get
                Return _Text
            End Get
            Set(ByVal Value As String)
                _Text = value
            End Set
        End Property

        Protected Overrides Sub Render(ByVal writer As HtmlTextWriter)
            writer.Write(_Text)
        End Sub

    End Class
End Namespace

