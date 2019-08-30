<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub btnSubmit_Click(sender As Object, e As EventArgs)
        bltResults.DataSource = Calendar1.SelectedDates
        bltResults.DataBind()
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Calendar SelectionMode</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Calendar
        id="Calendar1"
        SelectionMode="DayWeekMonth"
        runat="server" />
    
    <br /><br />
    
    <asp:Button
        id="btnSubmit"
        Text="Submit"
        OnClick="btnSubmit_Click" 
        Runat="server" />
        
    <hr />
    
    <asp:BulletedList
        id="bltResults"
        DataTextFormatString="{0:d}"
        Runat="server" />
        
    </div>
    </form>
</body>
</html>
