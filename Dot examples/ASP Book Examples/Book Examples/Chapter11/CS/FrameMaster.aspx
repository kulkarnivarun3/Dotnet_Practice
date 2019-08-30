<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        html
        {
            background-color:silver;
        }
        .content
        {
            width:500px;
            margin:auto;
            background-color:white;
        }
        .column
        {
            padding:10px;
            float:left;
        }
        #FrameDetails
        {
            width:100%;
            height:400px;
        }
    </style>
    <title>Frame Master</title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="content">
    
    <div class="column">
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        AutoGenerateColumns="false"
        Runat="server">
        <Columns>
        <asp:HyperLinkField
            HeaderText="Movies"
            DataTextField="Title"
            DataNavigateUrlFields="Id"
            DataNavigateUrlFormatString="FrameDetails.aspx?id={0}"
            Target="FrameDetails" />
        </Columns>
    </asp:GridView>
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT * FROM Movies"
        Runat="server" />
    
    </div>
    <div class="column">
    
    <iframe name="FrameDetails" id="FrameDetails"></iframe>
    
    </div>
    
    <br style="clear:both" />    
    </div>
    </form>
</body>
</html>
