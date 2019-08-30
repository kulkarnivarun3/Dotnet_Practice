<%@ Page Language="VB" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Private dad As SqlDataAdapter
    Private dtblMovies As DataTable
 
    Sub Page_Load()
        ' Create connection
        Dim connectionString As String =  WebConfigurationManager.ConnectionStrings("Movies").ConnectionString 
        Dim con As New SqlConnection(connectionString) 
 
        ' Create Select command
        dad = New SqlDataAdapter("SELECT Id,Title,Director FROM Movies", con)
 
        ' Create Update, Insert, and Delete commands with SqlCommandBuilder
        Dim builder As New SqlCommandBuilder(dad) 
 
        ' Add data to DataTable
        dtblMovies = New DataTable()
        dad.Fill(dtblMovies)
 
        ' Bind data to Repeater
        rptMovies.DataSource = dtblMovies
        rptMovies.DataBind()
    End Sub
 
    Protected  Sub lnkUpdate_Click(ByVal sender As Object, ByVal e As EventArgs)
        ' Update DataTable with changes
        For  i as integer = 0 To rptMovies.Items.Count- 1  
            Dim item As RepeaterItem =  rptMovies.Items(i) 
            Dim txtTitle As TextBox = CType(item.FindControl("txtTitle"), TextBox)
            Dim txtDirector As TextBox = CType(item.FindControl("txtDirector"), TextBox)
            If dtblMovies.Rows(i)("Title") <> txtTitle.Text Then
                dtblMovies.Rows(i)("Title") = txtTitle.Text
            End If
            If dtblMovies.Rows(i)("Director") <> txtDirector.Text Then
                dtblMovies.Rows(i)("Director") = txtDirector.Text
            End If
        Next
 
        ' Set batch size to maximum size
        dad.UpdateBatchSize = 0
 
        ' Perform update
        Dim numUpdated As Integer = dad.Update(dtblMovies) 
        lblResults.Text = String.Format("Updated {0} rows", numUpdated)
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show DataAdapter Update</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:Repeater
        id="rptMovies"
        EnableViewState="false"
        Runat="server">
        <HeaderTemplate>
        <table>
        <tr>
            <th>Title</th><th>Director</th>
        </tr>
        </HeaderTemplate>
        <ItemTemplate>
        <tr>
        <td>
        <asp:TextBox
            id="txtTitle"
            Text='<%#Eval("Title")%>'
            Runat="server" />
        </td>
        <td>
        <asp:TextBox
            id="txtDirector"
            Text='<%#Eval("Director")%>'
            Runat="server" />
        </td>
        </tr>
        </ItemTemplate>    
        <FooterTemplate>
        </table>
        </FooterTemplate>
    </asp:Repeater>
    <br />
    
    <asp:LinkButton
        id="lnkUpdate"
        Text="Update Movies"
        Runat="server" OnClick="lnkUpdate_Click" />
    
    <br /><br />
    
    <asp:Label
        id="lblResults"
        EnableViewState="false"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
