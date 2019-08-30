Imports System
Imports System.Collections
Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace myControls

    <ControlBuilder(GetType(ServerTabsBuilder))> _
    <ParseChildren(False)> _
    Public Class ServerTabs
        Inherits WebControl
        Implements IPostBackEventHandler

        Public Property SelectedTabIndex() As Integer
            Get
                If ViewState("SelectedTabIndex") Is Nothing Then
                    Return 0
                Else
                    Return CType(ViewState("SelectedTabIndex"), Integer)
                End If
            End Get
            Set(ByVal Value As Integer)
                ViewState("SelectedTabIndex") = Value
            End Set
        End Property

        Protected Overrides Sub RenderContents(ByVal writer As HtmlTextWriter)
            Dim i As Integer
            For i = 0 To Me.Controls.Count - 1 Step i + 1
                Dim tab As ServerTab = CType(Me.Controls(i), ServerTab)
                Dim eRef As String = Page.ClientScript.GetPostBackClientHyperlink(Me, i.ToString())

                If SelectedTabIndex = i Then
                    writer.AddAttribute(HtmlTextWriterAttribute.Class, "tab selectedTab")
                Else
                    writer.AddAttribute(HtmlTextWriterAttribute.Class, "tab")
                End If
                writer.RenderBeginTag(HtmlTextWriterTag.Div)
                writer.AddAttribute(HtmlTextWriterAttribute.Href, eRef)
                writer.RenderBeginTag(HtmlTextWriterTag.A)
                writer.Write(tab.Text)
                writer.RenderEndTag() ' A
                writer.RenderEndTag() ' Tab Div
            Next
            writer.Write("<br style='clear:both' />")

            writer.AddAttribute(HtmlTextWriterAttribute.Class, "tabContents")
            writer.RenderBeginTag(HtmlTextWriterTag.Div)
            Me.Controls(SelectedTabIndex).RenderControl(writer)
            writer.RenderEndTag() ' Tab Contents DIV  
        End Sub

        Protected Overrides Sub AddParsedSubObject(ByVal obj As Object)
            If TypeOf obj Is ServerTab Then
                MyBase.AddParsedSubObject(obj)
            End If
        End Sub

        Protected Overrides ReadOnly Property TagKey() As HtmlTextWriterTag
            Get
                Return HtmlTextWriterTag.Div
            End Get
        End Property

        Public Sub RaisePostBackEvent(ByVal eventArgument As String) Implements IPostBackEventHandler.RaisePostBackEvent
            SelectedTabIndex = Int32.Parse(eventArgument)
        End Sub
    End Class

    Public Class ServerTabsBuilder
        Inherits ControlBuilder

        Public Overrides Function GetChildControlType(ByVal tagName As String, ByVal attribs As IDictionary) As Type
            If String.Compare(tagName, "tab", True) = 0 Then
                Return GetType(ServerTab)
            Else
                Return Nothing
            End If
        End Function
    End Class

    Public Class ServerTab
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
    End Class
End Namespace
