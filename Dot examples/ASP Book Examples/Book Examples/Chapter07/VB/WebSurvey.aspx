<%@ Page Language="VB" %>
<%@ Reference Control="~/ASPSurvey.ascx" %>
<%@ Reference Control="~/ASPNetSurvey.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Private _survey As Control = Nothing
 
    Private Sub Page_Load()
        Select Case ddlLanguage.SelectedIndex
            Case 1
                _survey = Page.LoadControl("ASPSurvey.ascx")
            Case 2
                _survey = Page.LoadControl("ASPNetSurvey.ascx")
        End Select
 
        If Not IsNothing(_survey) Then
            PlaceHolder1.Controls.Add(_survey)
        End If
    End Sub
 
    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)
        Select Case ddlLanguage.SelectedIndex
            Case 1
                Dim aspResults As ASPSurvey = CType(_survey, ASPSurvey)
                ltlResults.Text = "<h1>ASP Survey</h1>"
                ltlResults.Text += "<br />Know slow? " + aspResults.KnowSlow.ToString()
                ltlResults.Text += "<br />Know outdated? " + aspResults.KnowOutdated.ToString()
            Case 2
                Dim aspNetResults As ASPNetSurvey = CType(_survey, ASPNetSurvey)
                ltlResults.Text = "<h1>ASP.NET Survey</h1>"
                ltlResults.Text += "<br />Know fast? " + aspNetResults.KnowFast.ToString()
                ltlResults.Text += "<br />Know newest? " + aspNetResults.KnowNewest.ToString()
        End Select
    End Sub

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
