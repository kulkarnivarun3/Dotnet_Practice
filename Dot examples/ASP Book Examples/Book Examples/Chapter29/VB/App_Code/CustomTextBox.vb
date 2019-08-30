Imports System
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Collections.Specialized

Namespace myControls
    Public Class CustomTextBox
        Inherits WebControl
        Implements IPostBackDataHandler

        Public Event TextChanged As EventHandler

        Public Property Text() As String
            Get
                If ViewState("Text") Is Nothing Then
                    Return String.Empty
                Else
                    Return CType(ViewState("Text"), String)
                End If
            End Get
            Set(ByVal Value As String)
                ViewState("Text") = value
            End Set
        End Property

        Protected Overrides Sub AddAttributesToRender(ByVal writer As HtmlTextWriter)
            writer.AddAttribute(HtmlTextWriterAttribute.Type, "text")
            writer.AddAttribute(HtmlTextWriterAttribute.Value, Text)
            writer.AddAttribute(HtmlTextWriterAttribute.Name, Me.UniqueID)
            MyBase.AddAttributesToRender(writer)
        End Sub

        Protected Overrides ReadOnly Property TagKey() As HtmlTextWriterTag
            Get
                Return HtmlTextWriterTag.Input
            End Get
        End Property

        Public Function LoadPostData(ByVal postDataKey As String, ByVal postCollection As NameValueCollection) As Boolean Implements IPostBackDataHandler.LoadPostData
            If postCollection(postDataKey) <> Text Then
                Text = postCollection(postDataKey)
                Return True
            End If
            Return False
        End Function

        Public Sub RaisePostDataChangedEvent() Implements IPostBackDataHandler.RaisePostDataChangedEvent
            RaiseEvent TextChanged(Me, EventArgs.Empty)
        End Sub
    End Class
End Namespace

