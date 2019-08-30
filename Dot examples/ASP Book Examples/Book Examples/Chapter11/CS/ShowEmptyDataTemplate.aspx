<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        grdMovies.Visible = true;
    }

    protected void dtlMovie_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        txtTitle.Text = (string)e.Values["Title"];
        grdMovies.DataBind();
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Empty Data Template</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:TextBox
        id="txtTitle"
        Runat="server" />
    <asp:Button
        id="btnSubmit"
        Text="Search"
        OnClick="btnSubmit_Click"
        Runat="server" />
    <hr />
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        Visible="false"
        Runat="server">
        <EmptyDataTemplate>
        <p>
        No matching movies were found. If you would like
        to add a new movie, enter it in the form below.
        </p>
        <asp:DetailsView
            id="dtlMovie"
            DataSourceID="srcMovies"
            DefaultMode="Insert"
            AutoGenerateInsertButton="true"
            AutoGenerateRows="false"
            Runat="server" OnItemInserted="dtlMovie_ItemInserted">
            <Fields>
            <asp:BoundField
                HeaderText="Title:" 
                DataField="Title" />
            <asp:BoundField
                HeaderText="Director:" 
                DataField="Director" />
            </Fields>
        </asp:DetailsView>    
        
        </EmptyDataTemplate>
    </asp:GridView>    
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Title,Director FROM Movies
            WHERE Title LIKE @Title+'%'"
        InsertCommand="INSERT Movies (Title, Director)
            VALUES (@Title, @Director)"
        Runat="server">
        <SelectParameters>
        <asp:ControlParameter
            Name="Title"
            ControlID="txtTitle"
            PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
