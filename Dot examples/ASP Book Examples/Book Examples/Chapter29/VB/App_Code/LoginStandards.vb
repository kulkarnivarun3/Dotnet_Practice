Imports System
Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace myControls
    Public Class LoginStandards
        Inherits CompositeControl

        Private txtUserName As TextBox
        Private txtPassword As TextBox

        Public Property UserName() As String
            Get
                EnsureChildControls()
                Return txtUserName.Text
            End Get
            Set(ByVal Value As String)
                EnsureChildControls()
                txtUserName.Text = Value
            End Set
        End Property

        Public Property Password() As String
            Get
                EnsureChildControls()
                Return txtPassword.Text
            End Get
            Set(ByVal Value As String)
                EnsureChildControls()
                txtPassword.Text = Value
            End Set
        End Property

        Protected Overrides Sub CreateChildControls()
            txtUserName = New TextBox()
            txtUserName.ID = "txtUserName"
            Me.Controls.Add(txtUserName)

            txtPassword = New TextBox()
            txtPassword.ID = "txtPassword"
            txtPassword.TextMode = TextBoxMode.Password
            Me.Controls.Add(txtPassword)
        End Sub

        Protected Overrides Sub RenderContents(ByVal writer As HtmlTextWriter)
            writer.AddStyleAttribute("float", "left")
            writer.RenderBeginTag(HtmlTextWriterTag.Div)
            writer.AddStyleAttribute(HtmlTextWriterStyle.Padding, "3px")
            writer.RenderBeginTag(HtmlTextWriterTag.Div)
            writer.AddAttribute(HtmlTextWriterAttribute.For, txtUserName.ClientID)
            writer.RenderBeginTag(HtmlTextWriterTag.Label)
            writer.Write("User Name:")
            writer.RenderEndTag()
            writer.RenderEndTag()

            writer.AddStyleAttribute(HtmlTextWriterStyle.Padding, "3px")
            writer.RenderBeginTag(HtmlTextWriterTag.Div)
            writer.AddAttribute(HtmlTextWriterAttribute.For, txtPassword.ClientID)
            writer.RenderBeginTag(HtmlTextWriterTag.Label)
            writer.Write("Password:")
            writer.RenderEndTag()
            writer.RenderEndTag()
            writer.RenderEndTag()

            writer.AddStyleAttribute("float", "left")
            writer.RenderBeginTag(HtmlTextWriterTag.Div)
            writer.AddStyleAttribute(HtmlTextWriterStyle.Padding, "3px")
            writer.RenderBeginTag(HtmlTextWriterTag.Div)
            txtUserName.RenderControl(writer)
            writer.RenderEndTag()

            writer.AddStyleAttribute(HtmlTextWriterStyle.Padding, "3px")
            writer.RenderBeginTag(HtmlTextWriterTag.Div)
            txtPassword.RenderControl(writer)
            writer.RenderEndTag()
            writer.RenderEndTag()

            writer.Write("<br style='clear:left' />")
        End Sub

        Protected Overrides ReadOnly Property TagKey() As HtmlTextWriterTag
            Get
                Return HtmlTextWriterTag.Div
            End Get
        End Property

    End Class
End Namespace
