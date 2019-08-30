<%@ Page Language="C#" %>
<%@ Reference Control="~/ASPSurvey.ascx" %>
<%@ Reference Control="~/ASPNetSurvey.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    private Control _survey = null;
    
    void Page_Load()
    {
        switch (ddlLanguage.SelectedIndex)
        {
            case 1:
                _survey = Page.LoadControl("ASPSurvey.ascx");
                break;
            case 2:
                _survey = Page.LoadControl("ASPNetSurvey.ascx");
                break;
        }
        
        if (_survey != null)
            PlaceHolder1.Controls.Add(_survey);
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        switch (ddlLanguage.SelectedIndex)
        {
            case 1:
                ASPSurvey aspResults = (ASPSurvey)_survey;
                ltlResults.Text = "<h1>ASP Survey</h1>";
                ltlResults.Text += "<br />Know slow? " + aspResults.KnowSlow.ToString();
                ltlResults.Text += "<br />Know outdated? " + aspResults.KnowOutdated.ToString();
                break;
            case 2:
                ASPNetSurvey aspNetResults = (ASPNetSurvey)_survey;
                ltlResults.Text = "<h1>ASP.NET Survey</h1>";
                ltlResults.Text += "<br />Know fast? " + aspNetResults.KnowFast.ToString();
                ltlResults.Text += "<br />Know newest? " + aspNetResults.KnowNewest.ToString();
                break;
        }
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        html
        {
            font:14px Arial,Sans-Serif;
        }
    </style>
    <title>Web Survey</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblLanguage"
        Text="What language do you use to develop Web applications?"
        Runat="server" />
    <br />
    <asp:DropDownList
        id="ddlLanguage"
        ToolTip="Web application language (reloads form)"
        AutoPostBack="true"
        Runat="server">
        <asp:ListItem Text="Select Language" />
        <asp:ListItem Text="ASP Classic"  />
        <asp:ListItem Text="ASP.NET" />
    </asp:DropDownList>        
    
    <br /><br />
    
    <asp:PlaceHolder
        id="PlaceHolder1"
        Runat="server" />
    
    <asp:Button
        id="btnSubmit"
        Text="Submit"
        OnClick="btnSubmit_Click"
        Runat="server" />

    <hr />
    
    <asp:Literal
        id="ltlResults"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
