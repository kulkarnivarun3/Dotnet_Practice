Imports System
Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace myControls

    Public Class Login
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
                txtUserName.Text = value
            End Set
        End Property

        Public Property Password() As String
            Get
                EnsureChildControls()
                Return txtPassword.Text
            End Get
            Set(ByVal Value As String)
                EnsureChildControls()
                txtPassword.Text = value
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
            writer.RenderBeginTag(HtmlTextWriterTag.Tr)

            ' Render UserName Label    
            writer.RenderBeginTag(HtmlTextWriterTag.Td)
            writer.AddAttribute(HtmlTextWriterAttribute.For, txtUserName.ClientID)
            writer.RenderBeginTag(HtmlTextWriterTag.Label)
            writer.Write("User Name:")
            writer.RenderEndTag() ' Label
            writer.RenderEndTag() ' TD

            ' Render UserName TextBox
            writer.RenderBeginTag(HtmlTextWriterTag.Td)
            txtUserName.RenderControl(writer)
            writer.RenderEndTag() ' TD

            writer.RenderEndTag()
            writer.RenderBeginTag(HtmlTextWriterTag.Tr)

            ' Render Password Label    
            writer.RenderBeginTag(HtmlTextWriterTag.Td)
            writer.AddAttribute(HtmlTextWriterAttribute.For, txtPassword.ClientID)
            writer.RenderBeginTag(HtmlTextWriterTag.Label)
            writer.Write("Password:")
            writer.RenderEndTag() ' Label
            writer.RenderEndTag() ' TD

            ' Render Password TextBox
            writer.RenderBeginTag(HtmlTextWriterTag.Td)
            txtPassword.RenderControl(writer)
            writer.RenderEndTag() ' TD

            writer.RenderEndTag() ' TR
        End Sub

        Protected Overrides ReadOnly Property TagKey() As HtmlTextWriterTag
            Get
                Return HtmlTextWriterTag.Table
            End Get
        End Property

    End Class
End Namespace