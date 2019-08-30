<%@ Page Language="VB" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
 
    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim connectionString As String = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SELECT BoxOfficeTotals FROM Movies WHERE Title=@Title", con)
        cmd.Parameters.AddWithValue("@Title", txtTitle.Text)
        Using con
            con.Open()
            Dim result As Object = cmd.ExecuteScalar()
            If Not IsNothing(result) Then
                lblResult.Text = String.Format("{0:c}", result)
            Else
                lblResult.Text = "No match!"
            End If
        End Using
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Execute Scalar</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <h1>Box Office Totals</h1>
    
    <asp:Label
        id="lblTitle"
        Text="Movie Title:"
        AssociatedControlID="txtTitle"
        Runat="server" />
    
    <asp:TextBox
        id="txtTitle"
        Runat="server" />
    
    <asp:Button
        id="btnSearch"
        Text="Search"
        OnClick="btnSearch_Click"
        Runat="server" />
    
    <hr />
    
    <asp:Label
        id="lblResult"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
