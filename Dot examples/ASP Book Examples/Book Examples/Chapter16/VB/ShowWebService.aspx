    <%@ Page Language="VB" %>
    <html xmlns="http://www.w3.org/1999/xhtml" >
    <head id="Head1" runat="server">
        <style type="text/css">
            html
            {
                background-color:silver;
            }
            .serverTime
            {
                background-color:white;
                font:16px Georgia,Serif;
            }
            .serverTime td
            {
                padding:40px;
            }
        </style>
        <title>Show Web Service</title>
    </head>
    <body>
        <form id="form1" runat="server">
        <div>
        
        <asp:FormView
            id="frmServerTime"
            DataSourceID="srcServerTime"
            CssClass="serverTime"
            Runat="server">
            <ItemTemplate>
            The remote server date and time is: <%# Container.DataItem %>        
            </ItemTemplate>
        </asp:FormView>    
        
        <asp:ObjectDataSource
            id="srcServerTime"
            TypeName="LocalServices.TimeService"
            SelectMethod="GetServerTime"
            Runat="server" />
            
        </div>
        </form>
    </body>
    </html>
