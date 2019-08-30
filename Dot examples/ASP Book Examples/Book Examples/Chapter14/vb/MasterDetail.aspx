<%@ Page Language="vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Master/Detail</title>
    <style type="text/css">

        .categoryContainer div
        {
            width: 100px;
            font-size:small;
            border: 1px solid black;
            float:left;
            padding:3px;
            margin:3px;
        }
        
        .categoryContainer a
        {
            text-decoration:none;
        }
        
        .categoryContainer div:hover
        {
            background-color:#eeeeee;
        }
        
        #selected
        {
            background-color:silver;
        }
    
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        
        <asp:ListView 
            ID="lstMovieCategories"
            DataSourceId="srcMovieCategory"
            DataKeyNames="Id"
            runat="server">
            <LayoutTemplate>
                <div class="categoryContainer">
                <asp:PlaceHolder
                    id="itemPlaceholder"
                    Runat="server" />
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <div>
                <asp:LinkButton
                    id="lnkSelect"
                    Text='<%# Eval("Name") %>'
                    CommandName="Select"
                    Runat="server" />
                </div>
            </ItemTemplate>
            <SelectedItemTemplate>
                <div id="selected">
                <%# Eval("Name") %>
                </div>
            </SelectedItemTemplate>
        </asp:ListView>
    
        <br style="clear:both" /><br />
        
        <asp:ListView 
            ID="lstMovies"
            DataSourceId="srcMovies"
            runat="server">
            <LayoutTemplate>
                <ol>
                <asp:PlaceHolder 
                    id="itemPlaceholder"
                    runat="server" />
                </ol>
            </LayoutTemplate>
            <ItemTemplate>
                <li><%# Eval("Title") %></li>
            </ItemTemplate>
        </asp:ListView>
    
        <asp:SqlDataSource
            id="srcMovieCategory"
            SelectCommand="SELECT Id, Name FROM MovieCategory"
            ConnectionString='<%$ ConnectionStrings:con %>'
            Runat="server" />

        <asp:SqlDataSource
            id="srcMovies"
            SelectCommand="SELECT Title FROM Movie
                WHERE CategoryId=@CategoryId"
            ConnectionString='<%$ ConnectionStrings:con %>'
            Runat="server">
            <SelectParameters>
                <asp:ControlParameter
                    Name="CategoryId" 
                    ControlID="lstMovieCategories" />
            </SelectParameters>
        </asp:SqlDataSource>    
    </div>
    </form>
</body>
</html>
