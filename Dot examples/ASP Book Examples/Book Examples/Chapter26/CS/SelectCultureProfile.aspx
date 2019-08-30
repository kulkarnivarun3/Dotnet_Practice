<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    protected override void InitializeCulture()
    {
        Culture = Profile.UserCulture;
        UICulture = Profile.UserUICulture;
    }
    
    
    protected void btnSelect_Click(object sender, EventArgs e)
    {
        Profile.UserCulture = ddlCulture.SelectedValue;
        Profile.UserUICulture = ddlCulture.SelectedValue;
        Response.Redirect(Request.Path);
    }

    void Page_PreRender()
    {
        lblDate.Text = DateTime.Now.ToString("D");
        lblPrice.Text = (512.33m).ToString("c");
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Select Culture Profile</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:Label
        id="lblCulture"
        Text="Culture:"
        AssociatedControlID="ddlCulture"
        Runat="server" />
        
    <asp:DropDownList
        id="ddlCulture"
        DataTextField="DisplayName"
        DataValueField="Name"
        DataSourceID="srcCultures"
        Runat="server" />    

    <asp:Button
        id="btnSelect"
        Text="Select"
        Runat="server" OnClick="btnSelect_Click" />
        
        
    <asp:ObjectDataSource
        id="srcCultures"
        TypeName="System.Globalization.CultureInfo"
        SelectMethod="GetCultures"
        Runat="server">
        <SelectParameters>
            <asp:Parameter Name="types" DefaultValue="SpecificCultures" />
        </SelectParameters>
    </asp:ObjectDataSource>        

    <hr />
    
    Today's date is:
    <br />
    <asp:Label
        id="lblDate"
        Runat="server" />
    
    <br /><br />
    
    The price of the product is:
    <br />
    <asp:Label
        id="lblPrice"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
