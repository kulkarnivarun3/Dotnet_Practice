Imports System
Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace myControls
    Public Class Pager
        Inherits WebControl
        Implements IPostBackEventHandler

        Private _controlToPage As String

        Public Property ControlToPage() As String
            Get
                Return _controlToPage
            End Get
            Set(ByVal Value As String)
                _controlToPage = value
            End Set
        End Property

        Protected Overrides Sub RenderContents(ByVal writer As HtmlTextWriter)
            Dim grid As GridView = GetControlToPage()

            Dim i As Integer
            For i = 0 To grid.PageCount - 1 Step i + 1
                Dim eRef As String = Page.ClientScript.GetPostBackClientHyperlink(Me, i.ToString())
                writer.Write("[")
                If i = grid.PageIndex Then
                    writer.AddStyleAttribute(HtmlTextWriterStyle.FontWeight, "bold")
                End If
                writer.AddAttribute(HtmlTextWriterAttribute.Href, eRef)
                writer.RenderBeginTag(HtmlTextWriterTag.A)
                writer.Write("{0}", i + 1)
                writer.RenderEndTag()
                writer.Write("] ")
            Next
        End Sub

        Private Function GetControlToPage() As GridView
            If String.IsNullOrEmpty(_controlToPage) Then
                Throw New Exception("Must set ControlToPage property")
            End If
            Return CType(Page.FindControl(_controlToPage), GridView)
        End Function

        Public Sub RaisePostBackEvent(ByVal eventArgument As String) Implements IPostBackEventHandler.RaisePostBackEvent
            Dim grid As GridView = GetControlToPage()
            grid.PageIndex = Int32.Parse(eventArgument)
        End Sub
    End Class
End Namespace
