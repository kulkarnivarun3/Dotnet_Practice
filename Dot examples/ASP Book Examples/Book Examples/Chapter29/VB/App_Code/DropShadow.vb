Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace myControls
    Public Class DropShadow
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
            writer.AddStyleAttribute(HtmlTextWriterStyle.Filter, "dropShadow(color=#AAAAAA,offX=3,offY=3);width:500px")
            writer.RenderBeginTag(HtmlTextWriterTag.Div)
            writer.Write(_Text)
            writer.RenderEndTag()
        End Sub

    End Class
End Namespace
