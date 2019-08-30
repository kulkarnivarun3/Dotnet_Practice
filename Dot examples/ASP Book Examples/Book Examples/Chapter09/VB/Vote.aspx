<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Private  Sub Page_Load()
        If Request.Cookies("VoterId") Is Nothing Then
            Dim identifier As String =  Guid.NewGuid().ToString() 
            Dim voteCookie As HttpCookie =  New HttpCookie("VoterId",identifier) 
            voteCookie.Expires = DateTime.MaxValue
            Response.AppendCookie(voteCookie)
        End If
    End Sub
   
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Vote</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:FormView
        id="frmVote"
        DataSourceID="srcVote"
        DefaultMode="Insert"
        Runat="server">
        <InsertItemTemplate>
        <asp:Label
            id="lblFavoriteColor"
            AssociatedControlID="rdlFavoriteColor"
            Runat="server" />
        <asp:RadioButtonList
            id="rdlFavoriteColor"
            SelectedValue='<%#Bind("Color")%>'
            Runat="server">
            <asp:ListItem Value="Red" Text="Red" Selected="True" />    
            <asp:ListItem Value="Blue" Text="Blue" />    
            <asp:ListItem Value="Green" Text="Green" />    
        </asp:RadioButtonList>  
        <br />
        <asp:Button
            id="btnSubmit"
            Text="Submit"
            CommandName="Insert"
            Runat="server" />  
        </InsertItemTemplate>
    </asp:FormView>

    <hr />
    
    <asp:GridView
        id="grdVote"
        DataSourceID="srcVote"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcVote"    
        SelectCommand="SELECT * FROM Vote 
            ORDER BY Id DESC"
        InsertCommand="INSERT Vote (VoterId,Color)
            VALUES (@VoterId,@Color)"
        ConnectionString="<%$ ConnectionStrings:Vote %>"
        Runat="server">
        <InsertParameters>
            <asp:CookieParameter Name="VoterId" 
                CookieName="VoterId" />
        </InsertParameters>
    </asp:SqlDataSource>    
        
    </div>
    </form>
</body>
</html>
