<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .floater
        {
            float:left;
            border:solid 1px black;
            padding:5px;
            margin:5px;
        }
    </style>
    <title>Show Tabular Databound Controls</title>
</head>
<body>
    <form id="form1" runat="server">

    <div class="floater">
    <h3>GridView</h3>
    <asp:GridView
        id="GridView1"
        DataSourceId="srcMovies"
        Runat="server" />
    </div>

    

    <div class="floater">
    <h3>DataList</h3>
    <asp:DataList
        id="DataList1"
        DataSourceId="srcMovies"
        RepeatColumns="2"
        Runat="server">
        <ItemTemplate>
        <%#Eval("Title")%> 
        <i>directed by</i>
        <%#Eval("Director")%>
        </ItemTemplate>
    </asp:DataList>    
    </div>


    <div class="floater">
    <h3>DetailsView</h3>
    <asp:DetailsView
        id="DetailsView1"
        DataSourceId="srcMovies"
        AllowPaging="true"
        Runat="server" />
    </div>

    <div class="floater">
    <h3>FormView</h3>
    <asp:FormView
        id="FormView1"
        DataSourceId="srcMovies"
        AllowPaging="true"
        Runat="server">
        <ItemTemplate>
        <%#Eval("Title")%> 
        <i>directed by</i>
        <%#Eval("Director")%>
        </ItemTemplate>
    </asp:FormView>    
    </div>
<br style="clear:both" />


    <div class="floater">
    <h3>Repeater</h3>
    <asp:Repeater
        id="Repeater1"
        DataSourceId="srcMovies"
        Runat="server">
        <ItemTemplate>
        <%#Eval("Title")%> 
        <i>directed by</i>
        <%#Eval("Director")%>
        </ItemTemplate>
    </asp:Repeater>    
    </div>

    <div class="floater">
    <h3>ListView</h3>
    <asp:ListView
        id="ListView1"
        DataSourceId="srcMovies"
        Runat="server">
        <LayoutTemplate>
        <div id="itemPlaceholder" runat="server">
        </div>
        <asp:DataPager ID="pager1" PageSize="3" runat="server">
        <Fields>
            <asp:NumericPagerField />
        </Fields>
        </asp:DataPager>
        </LayoutTemplate>
        <ItemTemplate>
        <%#Eval("Title")%> 
        <i>directed by</i>
        <%#Eval("Director")%>
        </ItemTemplate>
    </asp:ListView>    
    </div>

    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="Data Source=.\SQLExpress;
            AttachDbFilename=|DataDirectory|MyDatabase.mdf;
            Integrated Security=True;User Instance=True"
        SelectCommand="SELECT TOP 5 Title,Director FROM Movies"
        Runat="server" />
    
    </form>
</body>
</html>
