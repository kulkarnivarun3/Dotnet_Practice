Imports System
Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace myControls
    Public Class CustomLinkButton
        Inherits WebControl
        Implements IPostBackEventHandler

        Public Event Click As EventHandler

        Private _Text As String

        Public Property Text() As String
            Get
                Return _Text
            End Get
            Set(ByVal Value As String)
                _Text = value
            End Set
        End Property

        Protected Overrides Sub AddAttributesToRender(ByVal writer As HtmlTextWriter)
            Dim eRef As String = Page.ClientScript.GetPostBackClientHyperlink(Me, String.Empty)
            writer.AddAttribute(HtmlTextWriterAttribute.Href, eRef)
            MyBase.AddAttributesToRender(writer)
        End Sub

        Protected Overrides ReadOnly Property TagKey() As HtmlTextWriterTag
            Get
                Return HtmlTextWriterTag.A
            End Get
        End Property

        Protected Overrides Sub RenderContents(ByVal writer As HtmlTextWriter)
            writer.Write(_Text)
        End Sub

        Public Sub RaisePostBackEvent(ByVal eventArgument As String) Implements IPostBackEventHandler.RaisePostBackEvent
            RaiseEvent Click(Me, EventArgs.Empty)
        End Sub
    End Class
End Namespace
