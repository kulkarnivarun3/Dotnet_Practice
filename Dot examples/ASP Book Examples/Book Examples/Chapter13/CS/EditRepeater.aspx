<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<script runat="server">
    
    // The name of the primary key column
    string DataKeyName = "Id";

    /// <summary>
    /// Stores the primary keys in ViewState
    /// </summary>
    Hashtable Keys
    {
        get 
        { 
            if (ViewState["Keys"] == null)
                ViewState["Keys"] = new Hashtable();
            return (Hashtable)ViewState["Keys"];    
        }
    }

    /// <summary>
    /// Build the primary key collection
    /// </summary>
    protected void rptMovies_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Keys.Add(e.Item.ItemIndex, DataBinder.Eval(e.Item.DataItem, "Id"));
        }
    }

    /// <summary>
    /// Clear the primary keys when Repeater is rebound
    /// to its data source
    /// </summary>
    protected void rptMovies_DataBinding(object sender, EventArgs e)
    {
        Keys.Clear();
    }

    /// <summary>
    /// When you click the Update,Insert, or Delete
    /// button, this method executes
    /// </summary>
    protected void rptMovies_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Update":
                UpdateMovie(e);
                break;
            case "Insert":
                InsertMovie(e);
                break;    
            case "Delete":
                DeleteMovie(e);
                break;    
        }
    }
    
    /// <summary>
    /// Update a movie record
    /// </summary>
    void UpdateMovie(RepeaterCommandEventArgs e)
    {    
        // Get the form fields
        TextBox txtTitle = (TextBox)e.Item.FindControl("txtTitle");
        TextBox txtDirector = (TextBox)e.Item.FindControl("txtDirector");
        CheckBox chkInTheaters = (CheckBox)e.Item.FindControl("chkInTheaters");

        // Set the DataSource parameters
        srcMovies.UpdateParameters["Id"].DefaultValue = Keys[e.Item.ItemIndex].ToString();
        srcMovies.UpdateParameters["Title"].DefaultValue = txtTitle.Text;
        srcMovies.UpdateParameters["Director"].DefaultValue = txtDirector.Text;
        srcMovies.UpdateParameters["InTheaters"].DefaultValue = chkInTheaters.Checked.ToString();
        
        // Fire the UpdateCommand
        srcMovies.Update();
    }

    /// <summary>
    /// Insert a movie record
    /// </summary>
    void InsertMovie(RepeaterCommandEventArgs e)
    {
        // Get the form fields
        TextBox txtTitle = (TextBox)e.Item.FindControl("txtTitle");
        TextBox txtDirector = (TextBox)e.Item.FindControl("txtDirector");
        CheckBox chkInTheaters = (CheckBox)e.Item.FindControl("chkInTheaters");

        // Set the DataSource parameters
        srcMovies.InsertParameters["Title"].DefaultValue = txtTitle.Text;
        srcMovies.InsertParameters["Director"].DefaultValue = txtDirector.Text;
        srcMovies.InsertParameters["InTheaters"].DefaultValue = chkInTheaters.Checked.ToString();

        // Fire the InsertCommand
        srcMovies.Insert();
    }
    
    /// <summary>
    /// Delete a movie record
    /// </summary>
    void DeleteMovie(RepeaterCommandEventArgs e)
    {
        // Set the DataSource parameters
        srcMovies.DeleteParameters["Id"].DefaultValue = Keys[e.Item.ItemIndex].ToString();

        // Fire the DeleteCommand
        srcMovies.Delete();

    }
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
    html
    {
        background-color:silver;
    }
    .content
    {
        width:600px;
        height:400px;
        padding:10px;
        border:solid 1px black;
        background-color:white;
    }
    .movies td
    {
        text-align:center;
    }
    a
    {
        color:blue;
    }
    </style>
    <title>Edit Repeater</title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="content">

    <asp:Repeater
        id="rptMovies"
        DataSourceID="srcMovies"
        Runat="server" OnItemCommand="rptMovies_ItemCommand" OnItemDataBound="rptMovies_ItemDataBound" OnDataBinding="rptMovies_DataBinding">
        <HeaderTemplate>
        <table class="movies">
        <tr>
            <th>Title</th>
            <th>Director</th>
            <th>In Theaters</th>
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
            <td>
            <asp:CheckBox
                id="chkInTheaters"
                Checked='<%#Eval("InTheaters")%>'
                Runat="server" />
            </td>
            <td>
            <asp:LinkButton
                id="lnkUpdate"
                CommandName="Update"
                Text="Update"
                Runat="server" />
            &nbsp;|&nbsp;
            <asp:LinkButton
                id="lnkDelete"
                CommandName="Delete"
                Text="Delete"
                OnClientClick="return confirm('Are you sure?');"
                Runat="server" />
            </td>
        </tr>    
        </ItemTemplate>
        <FooterTemplate>
        <tr>
            <td>
            <asp:TextBox
                id="txtTitle"
                Runat="server" />
            </td>
            <td>
            <asp:TextBox
                id="txtDirector"
                Runat="server" />
            </td>
            <td>
            <asp:CheckBox
                id="chkInTheaters"
                Runat="server" />
            </td>
            <td>
            <asp:LinkButton
                id="lnkInsert"
                CommandName="Insert"
                Text="Insert"
                Runat="server" />
            </td>
        </tr>    
        </table>
        </FooterTemplate>
    </asp:Repeater>    
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director,InTheaters 
            FROM Movies"
        UpdateCommand="UPDATE Movies SET Title=@Title,
            Director=@Director,InTheaters=@InTheaters
            WHERE Id=@Id"
        InsertCommand="INSERT Movies (Title,Director,InTheaters)
            VALUES (@Title,@Director,@InTheaters)"    
        DeleteCommand="DELETE Movies WHERE Id=@Id"
        Runat="server">
        <UpdateParameters>
            <asp:Parameter Name="Id" />
            <asp:Parameter Name="Title" />
            <asp:Parameter Name="Director" />
            <asp:Parameter Name="InTheaters" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Title" />
            <asp:Parameter Name="Director" />
            <asp:Parameter Name="InTheaters" />
        </InsertParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
    </asp:SqlDataSource>    
    
    </div>
    </form>
</body>
</html>
