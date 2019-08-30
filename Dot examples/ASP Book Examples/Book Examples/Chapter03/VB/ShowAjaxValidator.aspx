<%@ Page Language="VB" %>
<%@ Register TagPrefix="custom" Namespace="myControls" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
 
    ''' <summary>
    ''' Validation function that is called on both the client and server
    ''' </summary>
    Protected Sub AjaxValidator1_ServerValidate(ByVal source As Object, ByVal args As ServerValidateEventArgs)
        If UserNameExists(args.Value) Then
            args.IsValid = False
        Else
            args.IsValid = True
        End If
    End Sub
 
    ''' <summary>
    ''' Returns true when user name already exists
    ''' in Users database table
    ''' </summary>
    Private Function UserNameExists(ByVal userName As String) As Boolean
        Dim conString As String =  WebConfigurationManager.ConnectionStrings("UsersDB").ConnectionString 
        Dim con As New SqlConnection(conString)
        Dim cmd As New SqlCommand("SELECT COUNT(*) FROM Users WHERE UserName=@UserName", con)
        cmd.Parameters.AddWithValue("@UserName", userName)
        Dim result As Boolean =  False 
        Using con
            con.Open()
            Dim count As Integer = CType(cmd.ExecuteScalar(), Integer)
            If count > 0 Then
                result = True
            End If
        End Using
        Return result
    End Function
 
    ''' <summary>
    ''' Insert new user name to Users database table
    ''' </summary>
    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim conString As String = WebConfigurationManager.ConnectionStrings("UsersDB").ConnectionString
        Dim con As New SqlConnection(conString)
        Dim cmd As New SqlCommand("INSERT Users (UserName,FavoriteColor) VALUES (@UserName,@FavoriteColor)", con)
        cmd.Parameters.AddWithValue("@UserName", txtUserName.Text)
        cmd.Parameters.AddWithValue("@FavoriteColor", txtFavoriteColor.Text)
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
        End Using
        txtUserName.Text = String.Empty
        txtFavoriteColor.Text = String.Empty
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show AjaxValidator</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblUserName"
        Text="User Name:"
        AssociatedControlID="txtUserName"
        Runat="server" />
    <asp:TextBox
        id="txtUserName"
        Runat="server" />
    <custom:AjaxValidator
        id="AjaxValidator1"
        ControlToValidate="txtUserName"
        Text="User name already taken!"
        OnServerValidate="AjaxValidator1_ServerValidate" 
        Runat="server" />

    <br /><br />
    <asp:Label
        id="lblFavoriteColor"
        Text="Favorite Color:"
        AssociatedControlID="txtFavoriteColor"
        Runat="server" />
    <asp:TextBox
        id="txtFavoriteColor"
        Runat="server" />
    
    <br /><br />
    <asp:Button
        id="btnSubmit"
        Text="Submit"
        Runat="server" OnClick="btnSubmit_Click" />
    
    </div>
    </form>
</body>
</html>
