Imports System
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.ComponentModel

Namespace myControls

    <DefaultProperty("Title")> _
    Public Class MovieView
        Inherits WebControl

        Private _title As String = "Movie Title"
        Private _description As String = "Movie Description"

        <Category("Movie")> _
        <Description("Movie Title")> _
        Public Property Title() As String
            Get
                Return _title
            End Get
            Set(ByVal Value As String)
                _title = Value
            End Set
        End Property

        <Category("Movie")> _
        <Description("Movie Description")> _
        Public Property Description() As String
            Get
                Return _description
            End Get
            Set(ByVal Value As String)
                _description = Value
            End Set
        End Property


        Protected Overrides Sub RenderContents(ByVal writer As HtmlTextWriter)
            writer.RenderBeginTag(HtmlTextWriterTag.H1)
            writer.Write(_title)
            writer.RenderEndTag()

            writer.Write(_description)
        End Sub

        Protected Overrides ReadOnly Property TagKey() As HtmlTextWriterTag
            Get
                Return HtmlTextWriterTag.Div
            End Get
        End Property
    End Class
End Namespace
