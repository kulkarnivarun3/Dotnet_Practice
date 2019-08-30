<%@ Control Language="C#" ClassName="UserView" %>

<asp:HyperLink    
    id="lnkProfile"
    Text='<%# String.Format("{0} ({1} {2})", Eval("AuthorUserName"), Eval("FirstName"), Eval("LastName")) %>'
    NavigateUrl='<%# Eval("AuthorUserName", "~/Profile.aspx?userName={0}") %>'
    Runat="server" />
