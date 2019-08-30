<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    private SqlDataAdapter dad;
    private DataTable dtblMovies;
    
    void Page_Load()
    {
        // Create connection
        string connectionString = WebConfigurationManager.ConnectionStrings["Movies"].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);

        // Create Select command
        dad = new SqlDataAdapter("SELECT Id,Title,Director FROM Movies", con);
        
        // Create Update, Insert, and Delete commands with SqlCommandBuilder
        SqlCommandBuilder builder = new SqlCommandBuilder(dad);
        
        // Add data to DataTable
        dtblMovies = new DataTable();
        dad.Fill(dtblMovies);
        
        // Bind data to Repeater
        rptMovies.DataSource = dtblMovies;
        rptMovies.DataBind();
    }

    protected void lnkUpdate_Click(object sender, EventArgs e)  
    {
        // Update DataTable with changes
        for (int i=0; i < rptMovies.Items.Count;i++)
        {
            RepeaterItem item = rptMovies.Items[i];
            TextBox txtTitle = (TextBox)item.FindControl("txtTitle");
            TextBox txtDirector = (TextBox)item.FindControl("txtDirector");
            if (dtblMovies.Rows[i]["Title"] != txtTitle.Text)
                dtblMovies.Rows[i]["Title"] = txtTitle.Text;
            if (dtblMovies.Rows[i]["Director"] != txtDirector.Text)
                dtblMovies.Rows[i]["Director"] = txtDirector.Text;
        }
        
        // Set batch size to maximum size
        dad.UpdateBatchSize = 0;
        
        // Perform update
        int numUpdated = dad.Update(dtblMovies);
        lblResults.Text = String.Format("Updated {0} rows", numUpdated);
    }
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
