<%@ Page Language="vb" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"  %>
<%@ Import Namespace="System.Linq" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
    <System.Web.Services.WebMethod> _
    public shared function GetSuggestions(prefixText as string, count as integer) as string()
        Dim db = new MyDatabaseDataContext()
        return db.Movies _
            .Where( function(m) m.Title.StartsWith(prefixText) ) _
            .OrderBy( function(m) m.Title ) _
            .Select( function(m) m.Title) _
            .Take(count) _
            .ToArray()
    End function

    protected sub btnSubmit_Click(sender as object,e as EventArgs)
        lblSelectedMovieTitle.Text = txtMovieTitle.Text
    end sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>AutoComplete Page Method</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:ScriptManager ID="sm1" runat="server" />
    
    <asp:Label
        id="lblMovieTitle"
        Text="Movie:"
        AssociatedControlID="txtMovieTitle"
        Runat="server" />
    <asp:TextBox
        id="txtMovieTitle"
        AutoComplete="off"
        Runat="server" />
    <ajax:AutoCompleteExtender
        id="ace1"
        TargetControlID="txtMovieTitle"
        ServiceMethod="GetSuggestions"
        MinimumPrefixLength="1"
        runat="server" />    
    <asp:Button
        id="btnSubmit"
        Text="Submit"
        OnClick="btnSubmit_Click" 
        Runat="server" />
    
    <br /><br />
    
    <asp:Label
        id="lblSelectedMovieTitle"
        runat="server" />
    
    </div>
    </form>
</body>
</html>
