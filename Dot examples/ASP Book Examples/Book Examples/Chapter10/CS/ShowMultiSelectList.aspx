<%@ Page Language="C#" %>
<%@ Register TagPrefix="custom" Namespace="MyControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        foreach (ListItem item in MultiSelectList1.Items)
            if (item.Selected)
                lblSelected.Text += String.Format("<li>{0} ({1})",item.Text,item.Value);
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show MultiSelectList</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <b>Movies:</b>        
    <asp:RequiredFieldValidator
        id="val"
        ControlToValidate="MultiSelectList1"
        Text="Required"
        Runat="server" />        

    <custom:MultiSelectList
        id="MultiSelectList1"
        DataSourceID="srcMovies"
        DataTextField="Title"
        DataValueField="Id"
        Runat="server" />
            
    <asp:SqlDataSource
        id="srcMovies"
        SelectCommand="SELECT Id, Title FROM Movies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        Runat="server" />
    
    <p>
    <asp:Button
        id="btnSubmit"
        Text="Submit"
        Runat="server" OnClick="btnSubmit_Click" />
    </p>
    
    <hr />

    <asp:Label
        id="lblSelected"
        EnableViewState="false"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
