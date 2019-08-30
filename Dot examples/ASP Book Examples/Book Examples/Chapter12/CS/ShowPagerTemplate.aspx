<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    protected void dtlMovies_DataBound(object sender, EventArgs e)
    {
        DropDownList ddlPager = (DropDownList)dtlMovies.BottomPagerRow.Cells[0].FindControl("ddlPager");
        for (int i = 0; i < dtlMovies.PageCount; i++)
        {
            ListItem item = new ListItem( String.Format("Record {0}",i+1), i.ToString());
            if (dtlMovies.PageIndex == i)
                item.Selected = true;
            ddlPager.Items.Add(item);
        }
    }

    protected void btnPage_Click(object sender, EventArgs e)
    {
        DropDownList ddlPager = (DropDownList)dtlMovies.BottomPagerRow.Cells[0].FindControl("ddlPager");
        dtlMovies.PageIndex = Int32.Parse(ddlPager.SelectedValue); 
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Pager Template</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DetailsView
        id="dtlMovies"
        DataSourceID="srcMovies"
        AllowPaging="true"
        OnDataBound="dtlMovies_DataBound"
        Runat="server">
        <PagerTemplate>
            <asp:DropDownList
                id="ddlPager"
                Runat="server" />
            <asp:Button
                id="btnPage"
                Text="Select"
                Runat="server" OnClick="btnPage_Click" />
        </PagerTemplate>
    </asp:DetailsView>    
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director,InTheaters FROM Movies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
