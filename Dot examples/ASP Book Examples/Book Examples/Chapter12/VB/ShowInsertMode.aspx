<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        html
        {
            background-color:silver;
            font:14px Arial,Sans-Serif;
        }
        td,th
        {
            padding:10px;
        }
        #divDisplay
        {
            border:solid 1px black;
            width:400px;
            padding:15px;
            background-color:#eeeeee;
        }
        #divInsert
        {
            display:none;
            border:solid 1px black;
            width:400px;
            position:absolute;
            top:30px;
            left:100px;
            padding:10px;
            background-color:white;
        }
        
    </style>
    <script type="text/javascript">
        function showInsert()
        {
            var divInsert = document.getElementById('divInsert');
            divInsert.style.display = 'block';
        }
    </script>
    <title>Show Insert Mode</title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="divDisplay">
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        Runat="server" />
    <br />    
    <a href="JavaScript:showInsert();">Insert Movie</a>
    </div>

    <div id="divInsert">
    <h1>Insert Movie</h1>
    <asp:DetailsView
        id="dtlMovies"
        DataSourceID="srcMovies"
        AutoGenerateInsertButton="true"
        AutoGenerateRows="false"
        DefaultMode="Insert"
        Runat="server">
        <Fields>
        <asp:BoundField
            DataField="Title"
            HeaderText="Title:" />
        <asp:BoundField
            DataField="Director"
            HeaderText="Director:" />
        <asp:CheckBoxField
            DataField="InTheaters"
            HeaderText="In Theaters:" />
        </Fields>
    </asp:DetailsView>    
    </div>    
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Title,Director,InTheaters FROM Movies"
        InsertCommand="INSERT Movies (Title,Director,InTheaters)
            VALUES (@Title,@Director,@InTheaters)"
        Runat="server" />
    
    </form>
</body>
</html>
