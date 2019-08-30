<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        html
        {
            background-color:silver;
        }
        .content
        {
            background-color:white;
            padding:10px;
            border:solid 1px black;
            margin:auto;
            width:400px;
            text-align:center;
        }
        .box
        {
            float:right;
            padding:10px;
            border-left:solid 1px black;
        }
        .clear
        {
            clear:both;
        }
    </style>
    <title>AdRotator XML</title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="content">
    
    <asp:AdRotator
        id="AdRotator1"
        AdvertisementFile="~/App_Data/AdList.xml"
        KeywordFilter="banner"
        CssClass="banner"
        Runat="server" />

    <br />

    <div class="box">
        <asp:AdRotator
            id="AdRotator2"
            AdvertisementFile="~/App_Data/AdList.xml"
            KeywordFilter="box"
            Runat="server" />
        <br /><br />
        <asp:AdRotator
            id="AdRotator3"
            AdvertisementFile="~/App_Data/AdList.xml"
            KeywordFilter="box"
            Runat="server" />
    </div>


    <br />Here is the body text in the page.
    <br />Here is the body text in the page.
    <br />Here is the body text in the page.
    <br />Here is the body text in the page.

    <br class="clear" />    
    </div>
    </form>
</body>
</html>
