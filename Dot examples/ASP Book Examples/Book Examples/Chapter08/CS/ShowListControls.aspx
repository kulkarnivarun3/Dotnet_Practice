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
    <title>Show List Controls</title>
</head>
<body>
    <form id="form1" runat="server">

    <div class="floater">
    <h3>BulletedList</h3>
    <asp:BulletedList
        id="BulletedList1"
        DataSourceId="srcMovies"
        DataTextField="Title"
        Runat="server" />
    </div>

    <div class="floater">
    <h3>CheckBoxList</h3>
    <asp:CheckBoxList
        id="CheckBoxList1"
        DataSourceId="srcMovies"
        DataTextField="Title"
        Runat="server" />
    </div>

    <div class="floater">
    <h3>DropDownList</h3>
    <asp:DropDownList
        id="DropDownList1"
        DataSourceId="srcMovies"
        DataTextField="Title"
        Runat="server" />
    </div>

    <div class="floater">
    <h3>ListBox</h3>
    <asp:ListBox
        id="ListBox1"
        DataSourceId="srcMovies"
        DataTextField="Title"
        Runat="server" />
    </div>

    <div class="floater">
    <h3>RadioButtonList</h3>
    <asp:RadioButtonList
        id="RadioButtonList1"
        DataSourceId="srcMovies"
        DataTextField="Title"
        Runat="server" />
    </div>
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="Data Source=.\SQLExpress;
            AttachDbFilename=|DataDirectory|MyDatabase.mdf;
            Integrated Security=True;User Instance=True"
        SelectCommand="SELECT Title FROM Movies"
        Runat="server" />
    
    </form>
</body>
</html>
