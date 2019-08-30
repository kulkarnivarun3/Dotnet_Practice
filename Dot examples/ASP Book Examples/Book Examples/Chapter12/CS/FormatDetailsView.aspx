<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .movies td,.movies th
        {
            padding:10px;
        }
        .movies
        {
            border:double 4px black;
        }
        .header
        {
            letter-spacing:8px;
            font:bold 16px Arial,Sans-Serif;
            background-color:silver;
        }
        .fieldHeader
        {
            font-weight:bold;
        }
        .alternating
        {
            background-color:#eeeeee;
        }
        .command
        {
            background-color:silver;
        }
        .command a
        {
            color:black;
            background-color:#eeeeee;
            font:14px Arials,Sans-Serif;          
            text-decoration:none;
            padding:3px;
            border:solid 1px black;
        }
        .command a:hover
        {
            background-color:yellow;
        }
        .pager td
        {
            padding:2px;
        }
    </style>
    <title>Format DetailsView</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DetailsView
        id="dtlMovies"
        DataSourceID="srcMovies"
        AutoGenerateInsertButton="true"
        AllowPaging="true"
        GridLines="None"
        HeaderText="Movies"
        CssClass="movies"
        HeaderStyle-CssClass="header"
        FieldHeaderStyle-CssClass="fieldHeader"
        AlternatingRowStyle-CssClass="alternating"
        CommandRowStyle-CssClass="command"
        PagerStyle-CssClass="pager"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Title,Director,InTheaters FROM Movies"
        InsertCommand="INSERT Movies (Title,Director,InTheaters)
            VALUES (@Title,@Director,@InTheaters)"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
