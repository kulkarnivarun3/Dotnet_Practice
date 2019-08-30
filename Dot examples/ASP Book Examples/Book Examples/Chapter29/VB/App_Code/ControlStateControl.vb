Imports System
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace myControls

    Public Class ControlStateControl
        Inherits WebControl

        Private _controlStateText As String

        Public Property ViewStateText() As String
            Get
                If IsNothing(ViewState("ViewStateText")) Then
                    Return String.Empty
                Else
                    Return CType(ViewState("ViewStateText"), String)
                End If
            End Get
            Set(ByVal Value As String)
                ViewState("ViewStateText") = Value
            End Set
        End Property

        Public Property ControlStateText() As String
            Get
                Return _controlStateText
            End Get
            Set(ByVal Value As String)
                _controlStateText = Value
            End Set
        End Property

        Protected Overrides Sub OnInit(ByVal e As EventArgs)
            Page.RegisterRequiresControlState(Me)
            MyBase.OnInit(e)
        End Sub

        Protected Overrides Function SaveControlState() As Object
            Return _controlStateText
        End Function

        Protected Overrides Sub LoadControlState(ByVal savedState As Object)
            _controlStateText = CType(savedState, String)
        End Sub

        Protected Overrides Sub RenderContents(ByVal writer As HtmlTextWriter)
            writer.Write("ViewStateText: " + ViewStateText)
            writer.WriteBreak()
            writer.Write("ControlStateText: " + ControlStateText)
            writer.WriteBreak()
        End Sub

    End Class
End Namespace

