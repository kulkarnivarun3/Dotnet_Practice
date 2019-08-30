<%@ Page Language="vb" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"  %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
    <System.Web.Services.WebMethod()> _
    Public Shared Function GetSuggestions(ByVal prefixText As String, ByVal count As Integer) As String()
        Dim db As New MyDatabaseDataContext()
        Dim movies As List(Of Movie) = db.Movies _
                .Where(Function(m) m.Title.StartsWith(prefixText)) _
                .OrderBy(Function(m) m.Title) _
                .Take(count) _
                .ToList()
        Return movies _
            .Select(Function(m) AutoCompleteExtender.CreateAutoCompleteItem(m.Title, m.Id.ToString())) _
            .ToArray()
    End Function

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)
        lblSelectedMovieTitle.Text = txtMovieTitle.Text
        lblSelectedMovieId.Text = ace1Value.Value
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>AutoComplete Page Method</title>
    <script type="text/javascript">

    function ace1_itemSelected(sender, e)
    {
        var ace1Value = $get('<%= ace1Value.ClientID %>');
        ace1Value.value = e.get_value();
    }

    </script>

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
        OnClientItemSelected="ace1_itemSelected"
        FirstRowSelected="true"
        runat="server" />
    <asp:HiddenField
        id="ace1Value"
        Runat="server" />        
    <asp:Button
        id="btnSubmit"
        Text="Submit"
        OnClick="btnSubmit_Click" 
        Runat="server" />
    
    <br /><br />
    
    Title:
    <asp:Label
        id="lblSelectedMovieTitle"
        runat="server" />

    <br /><br />

    Primary Key:
    <asp:Label
        id="lblSelectedMovieId"
        runat="server" />

    
    </div>
    </form>
</body>
</html>
