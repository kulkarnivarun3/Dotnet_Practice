Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace myControls
    Public Class Glow
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

        Protected Overrides ReadOnly Property TagKey() As HtmlTextWriterTag
            Get
                Return HtmlTextWriterTag.Div
            End Get
        End Property

        Protected Overrides Sub AddAttributesToRender(ByVal writer As HtmlTextWriter)
            writer.AddStyleAttribute(HtmlTextWriterStyle.Filter, "glow(Color=#ffd700,Strength=10)")
            MyBase.AddAttributesToRender(writer)
        End Sub

        Protected Overrides Sub RenderContents(ByVal writer As HtmlTextWriter)
            writer.Write(_Text)
        End Sub

        Public Sub New()
            Me.Width = Unit.Parse("500px")
        End Sub

    End Class
End Namespace

