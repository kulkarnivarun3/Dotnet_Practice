<%@ Page Language="vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Insert ListView</title>
    <style type="text/css">
    
    .comment
    {
        margin:10px;
        padding: 10px;
        border-left:solid 1px gray;
        border-bottom:solid 1px gray;
    }
    
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:ListView 
            ID="lstFeedback"
            DataSourceId="srcFeedback"
            InsertItemPosition="FirstItem"
            runat="server">
            <LayoutTemplate>
                <asp:Placeholder 
                    id="itemPlaceholder"
                    runat="server" />
            </LayoutTemplate>
            <ItemTemplate>
                <div class="comment">
                <%# Eval("Comment") %>
                </div>
            </ItemTemplate>
            <InsertItemTemplate>
                <div>
                Please enter any comments
                about our website here:
                <br />
                <asp:Label
                    id="lblComments"
                    Text="Comments:"
                    AssociatedControlID="txtComment"
                    Runat="server" />
                <br />                    
                <asp:TextBox
                    id="txtComment"
                    Text='<%# Bind("Comment") %>'
                    TextMode="MultiLine"
                    Columns="40"
                    Rows="3"
                    Runat="server" />
                <br />
                <asp:Button
                    id="lnkInsert"
                    Text="Add Comment"
                    CommandName="Insert"
                    Runat="server" />
                </div>
            </InsertItemTemplate>
        </asp:ListView>
    
        <asp:SqlDataSource
            id="srcFeedback"
            SelectCommand="SELECT Id, Comment FROM Feedback"
            InsertCommand="INSERT Feedback (Comment) VALUES (@Comment)"
            ConnectionString='<%$ ConnectionStrings:con %>'
            Runat="server" />
    
    </div>
    </form>
</body>
</html>
