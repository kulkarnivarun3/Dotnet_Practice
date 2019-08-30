<%@ Control Language="C#" ClassName="SharedMovies" %>
<%@ OutputCache Duration="600" VaryByParam="none" Shared="true" %>

User Control Time:
<%= DateTime.Now.ToString() %>

<asp:GridView
    id="grdMovies"
    DataSourceID="srcMovies"
    Runat="server" />
    
<asp:SqlDataSource
    id="srcMovies"
    ConnectionString="<%$ ConnectionStrings:Movies %>"
    SelectCommand="SELECT Title,Director FROM Movies"
    Runat="server" />    
