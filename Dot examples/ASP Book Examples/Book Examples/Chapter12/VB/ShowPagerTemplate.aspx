<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Protected Sub dtlMovies_DataBound(ByVal sender As Object, ByVal e As EventArgs)
        Dim ddlPager As DropDownList = CType(dtlMovies.BottomPagerRow.Cells(0).FindControl("ddlPager"), DropDownList)
        For i As Integer = 0 To dtlMovies.PageCount - 1
            Dim item As New ListItem(String.Format("Record {0}", i + 1), i.ToString())
            If dtlMovies.PageIndex = i Then
                item.Selected = True
            End If
            ddlPager.Items.Add(item)
        Next
    End Sub
 
    Protected Sub btnPage_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim ddlPager As DropDownList = CType(dtlMovies.BottomPagerRow.Cells(0).FindControl("ddlPager"), DropDownList)
        dtlMovies.PageIndex = Int32.Parse(ddlPager.SelectedValue)
    End Sub
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
