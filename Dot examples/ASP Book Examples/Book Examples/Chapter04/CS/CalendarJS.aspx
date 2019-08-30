<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void calEventDate_SelectionChanged(object sender, EventArgs e)
    {
        txtEventDate.Text = calEventDate.SelectedDate.ToString("d");
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        lblResult.Text = "You picked: " + txtEventDate.Text;
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <script type="text/javascript">
        
        function displayCalendar()
        {
            var datePicker = document.getElementById('datePicker');
            datePicker.style.display = 'block';
        }
    
    </script>
    <style type="text/css">
        #datePicker
        {
            display:none;
            position:absolute;
            border:solid 2px black;
            background-color:white;
        }
        .content
        {
            width:400px;
            background-color:white;
            margin:auto;
            padding:10px;
        }
        html
        {
            background-color:silver;
        }
    </style>
    <title>Calendar with JavaScript</title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="content">
    
    <asp:Label
        id="lblEventDate"
        Text="Event Date:"
        AssociatedControlID="txtEventDate"
        Runat="server" />
    <asp:TextBox
        id="txtEventDate"
        Runat="server" />
    <img src="Calendar.gif" onclick="displayCalendar()" />
    
    <div id="datePicker">
    <asp:Calendar
        id="calEventDate"
        OnSelectionChanged="calEventDate_SelectionChanged" 
        Runat="server" />
    </div>

    <br />
    <asp:Button
        id="btnSubmit"
        Text="Submit"
        Runat="server" OnClick="btnSubmit_Click" />

    <hr />

    <asp:Label
        id="lblResult"
        Runat="server" />
        
    </div>
    </form>
</body>
</html>
