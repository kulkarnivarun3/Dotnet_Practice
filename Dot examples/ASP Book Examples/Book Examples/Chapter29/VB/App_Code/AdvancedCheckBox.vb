Imports System
Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace myControls
    Public Class AdvancedCheckBox
        Inherits WebControl

        Private _Text As String
        Private _PostBackUrl As String

        Public Property Text() As String
            Get
                Return _Text
            End Get
            Set(ByVal Value As String)
                _Text = Value
            End Set
        End Property

        Public Property PostBackUrl() As String
            Get
                Return _PostBackUrl
            End Get
            Set(ByVal Value As String)
                _PostBackUrl = Value
            End Set
        End Property

        Protected Overrides Sub AddAttributesToRender(ByVal writer As HtmlTextWriter)
            Dim options As PostBackOptions = New PostBackOptions(Me)
            options.ActionUrl = _PostBackUrl
            Dim eRef As String = Page.ClientScript.GetPostBackEventReference(options)
            writer.AddAttribute(HtmlTextWriterAttribute.Onclick, eRef)
            writer.AddAttribute(HtmlTextWriterAttribute.Name, Me.UniqueID)
            writer.AddAttribute(HtmlTextWriterAttribute.Type, "checkbox")
            MyBase.AddAttributesToRender(writer)
        End Sub

        Protected Overrides Sub RenderContents(ByVal writer As HtmlTextWriter)
            If Not String.IsNullOrEmpty(_Text) Then
                writer.AddAttribute(HtmlTextWriterAttribute.For, Me.ClientID)
                writer.RenderBeginTag(HtmlTextWriterTag.Label)
                writer.Write(_Text)
                writer.RenderEndTag()
            End If
        End Sub

        Protected Overrides ReadOnly Property TagKey() As HtmlTextWriterTag
            Get
                Return HtmlTextWriterTag.Input
            End Get
        End Property
    End Class
End Namespace

