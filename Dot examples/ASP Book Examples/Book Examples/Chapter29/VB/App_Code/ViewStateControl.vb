Imports System
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace myControls
    Public Class ViewStateControl
        Inherits WebControl

        Private _text As String

        Public Property Text() As String
            Get
                Return _text
            End Get
            Set(ByVal Value As String)
                _text = value
            End Set
        End Property

        Public Property ViewStateText() As String
            Get
                If IsNothing(ViewState("ViewStateText")) Then
                    Return String.Empty
                Else
                    Return CType(ViewState("ViewStateText"), String)
                End If
            End Get
            Set(ByVal Value As String)
                ViewState("ViewStateText") = value
            End Set
        End Property

        Protected Overrides Sub RenderContents(ByVal writer As HtmlTextWriter)
            writer.Write("Text: " & Text)
            writer.WriteBreak()
            writer.Write("ViewStateText: " & ViewStateText)
            writer.WriteBreak()
        End Sub

    End Class
End Namespace

