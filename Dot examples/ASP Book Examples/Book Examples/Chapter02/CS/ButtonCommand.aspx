<%@ Page Language="C#" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    private List<String> groceries = new List<String>();

    void Page_Load()
    {
        groceries.Add("Milk");
        groceries.Add("Steak");
        groceries.Add("Fish");
    }

    protected void Sort_Command(object sender, CommandEventArgs e)
    {
        if (e.CommandName == "Sort")
        {
            switch (e.CommandArgument.ToString())
            {
                case "ASC":
                    groceries.Sort(SortASC);
                    break;
                case "DESC":
                    groceries.Sort(SortDESC);
                    break;                   
            }
        }
    }

    void Page_PreRender()
    {
        bltGroceries.DataSource = groceries;
        bltGroceries.DataBind();
    }

    int SortASC(string x, string y)
    {
        return String.Compare(x, y);
    }

    int SortDESC(string x, string y)
    {
        return String.Compare(x, y) * -1;
    }

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Button Command</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Button
        id="btnSortAsc"
        Text="Sort ASC"
        CommandName="Sort"
        CommandArgument="ASC"
        OnCommand="Sort_Command" 
        Runat="server" />
    
    <asp:Button
        id="btnSortDESC"
        Text="Sort DESC"
        CommandName="Sort"
        CommandArgument="DESC"
        OnCommand="Sort_Command" 
        Runat="server" />
    
    <br /><br />
    
    <asp:BulletedList
        id="bltGroceries"
        Runat="server" />

    
    
    </div>
    </form>
</body>
</html>
