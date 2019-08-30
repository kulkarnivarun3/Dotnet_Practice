<%@ Control Language="vb" ClassName="EntryView" %>
<%@ Register TagPrefix="user" TagName="EntryTagView" Src="~/UserControls/EntryTagView.ascx" %>
<script runat="server">

</script>



<div class="entryRow">

    <%--<%# Eval("Rating") %>--%>
    <h3>
        <asp:HyperLink
            id="lnkEntry"
            Text='<%# Eval("Title") %>'
            NavigateUrl='<%# Eval( "Id", "~/CodeSamples/Entry.aspx?entryId={0}") %>'
            Runat="server" />
    </h3>
    <p>
        <asp:Literal
            id="ltlIntroductionText"
            Text='<%# Eval("IntroductionText") %>'
            Mode="Encode"
            Runat="server" />
    </p>
    <div class="metaInfo">
        Posted: <%# Eval("AuthorUserName") %> ( <%# Eval("FirstName") %> <%# Eval("LastName") %> ) 
        <user:EntryTagView
            id="EntryTagView1"
            EntryId='<%# Eval("Id") %>'
            Runat="server" />
    </div>

</div>
