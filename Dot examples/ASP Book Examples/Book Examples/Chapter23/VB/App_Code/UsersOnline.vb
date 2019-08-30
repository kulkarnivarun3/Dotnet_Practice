Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace myControls

    ''' <summary>
    ''' Displays Number of Users Online
    ''' </summary>
    Public Class UsersOnline
        Inherits WebControl

        Protected Overrides Sub RenderContents(ByVal writer As HtmlTextWriter)
            writer.Write(Membership.GetNumberOfUsersOnline())
        End Sub

    End Class
end namespace