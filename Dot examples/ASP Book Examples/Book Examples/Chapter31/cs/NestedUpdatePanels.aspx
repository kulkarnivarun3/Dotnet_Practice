<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Nested UpdatePanels</title>
    <style type="text/css">
        fieldset
        {
            padding: 10px;
        }
        .comment
        {
            padding: 10px;
            border: dotted 2px black;
            margin: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:ScriptManager
        id="sm1"
        Runat="server" />
    
    Page Time: <%= DateTime.Now.ToString("T") %>
    <br />
    
    <asp:DropDownList
        id="ddlMovie"
        DataSourceID="srcMovies"
        DataValueField="Id"
        DataTextField="Title"
        AutoPostBack="true"
        Runat="server" />
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString='<%$ ConnectionStrings:con %>'
        SelectCommand="SELECT Id, Title FROM Movie"
        Runat="server" />
  
    <br /><br />
    
    <asp:UpdatePanel ID="upOuter" UpdateMode="Conditional" runat="server">
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="ddlMovie" />
    </Triggers>
    <ContentTemplate>
    
    Outer UpdatePanel Time: <%= DateTime.Now.ToString("T") %>
    <br />
    
    <asp:FormView
        id="frmMovie"
        DataSourceID="srcMovie"
        Runat="server">
        <ItemTemplate>
        <fieldset>
        <legend>Movie</legend>
        Title: <%# Eval("Title") %>
        <br />
        Director: <%# Eval("Director") %>

        <asp:UpdatePanel ID="upInner" runat="server">
        <ContentTemplate>        
        <asp:ListView
            id="lstMovieComments"
            DataSourceID="srcMovieComments"
            InsertItemPosition="FirstItem"
            Runat="server">
            <LayoutTemplate>
                <fieldset>
                <legend>Comments</legend>
                Inner UpdatePanel Time: <%= DateTime.Now.ToString("T") %>
                <div id="itemContainer" runat="server">
                </div>
            </fieldset>          
            </LayoutTemplate>
            <ItemTemplate>
                <div class="comment">
                <%# Eval("Comment") %>
                </div>
            </ItemTemplate>
            <InsertItemTemplate>
            <asp:Label
                id="lblComment"
                Text="Comment:"
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
                id="btnInsert"
                Text="Add Comment"
                CommandName="Insert"
                Runat="server" />    
            </InsertItemTemplate>
        </asp:ListView>
        </ContentTemplate>
        </asp:UpdatePanel>
        <asp:SqlDataSource
            id="srcMovieComments"
            ConnectionString='<%$ ConnectionStrings:con %>'
            SelectCommand="SELECT Id, Comment 
                FROM MovieComment
                WHERE MovieId=@MovieId"
            InsertCommand="INSERT MovieComment (Comment,MovieId)
                VALUES (@Comment,@MovieId)"
            Runat="server">
            <SelectParameters>
                <asp:ControlParameter Name="MovieId" ControlID="ddlMovie" />
            </SelectParameters>    
            <InsertParameters>
                <asp:ControlParameter Name="MovieId" ControlID="ddlMovie" />
            </InsertParameters>    
        </asp:SqlDataSource>     
        </fieldset>        
        </ItemTemplate>
    </asp:FormView>   
    </ContentTemplate> 
    </asp:UpdatePanel>
    <asp:SqlDataSource
        id="srcMovie"
        ConnectionString='<%$ ConnectionStrings:con %>'
        SelectCommand="SELECT Id, Title, Director 
            FROM Movie
            WHERE Id=@Id"
        Runat="server">
        <SelectParameters>
            <asp:ControlParameter Name="Id" ControlID="ddlMovie" />
        </SelectParameters>    
    </asp:SqlDataSource>     
    
    </div>
    </form>
</body>
</html>
