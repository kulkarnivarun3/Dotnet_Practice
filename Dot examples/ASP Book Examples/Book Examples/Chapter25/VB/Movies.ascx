<%@ Control Language="VB" ClassName="Movies" %>
<%@ OutputCache Duration="600" VaryByParam="none" %>

User Control Time:
<%= DateTime.Now.ToString("T") %>

<asp:GridView
    id="grdMovies"
    DataSourceID="srcMovies"
    Runat="server" />
    
<asp:SqlDataSource
    id="srcMovies"
    ConnectionString="<%$ ConnectionStrings:Movies %>"
    SelectCommand="SELECT Title,Director FROM Movies"
    Runat="server" />    