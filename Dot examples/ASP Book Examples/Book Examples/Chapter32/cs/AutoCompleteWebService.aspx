<%@ Page Language="C#" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        lblSelectedFileName.Text = txtFileName.Text;
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show AutoComplete Web Service</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:ScriptManager ID="sm1" runat="server" />
    
    <asp:Label
        id="lblFileName"
        Text="File Name:"
        AssociatedControlID="txtFileName"
        Runat="server" />
    <asp:TextBox
        id="txtFileName"
        AutoComplete="off"
        Runat="server" />
    <ajax:AutoCompleteExtender
        id="ace1"
        TargetControlID="txtFileName"
        ServiceMethod="GetSuggestions"
        ServicePath="~/FileService.asmx"
        MinimumPrefixLength="1"
        runat="server" />    
    <asp:Button
        id="btnSubmit"
        Text="Submit"
        OnClick="btnSubmit_Click" 
        Runat="server"/>
    
    <br /><br />
    
    <asp:Label
        id="lblSelectedFileName"
        runat="server" />

    
    </div>
    </form>
</body>
</html>
