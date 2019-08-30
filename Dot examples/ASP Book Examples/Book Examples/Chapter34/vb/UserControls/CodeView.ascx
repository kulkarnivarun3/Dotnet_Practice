<%@ Control Language="vb" ClassName="CodeView" %>

<script runat="server">

 
    sub Page_Load()
        ' Copy to clipboard
        Page.ClientScript.RegisterClientScriptInclude(Me.GetType(), "clipboard", Page.ResolveUrl("~/ClientScripts/CopyToClipboard.js"))
        lnkClipboard.Attributes.Add("onclick", String.Format("copyToClipboard(event, '{0}');", GetCodeClientId()))
    end sub
 
 
    function GetCodeClientId() as string
        Return String.Format("{0}{1}Code",Me.ClientID,Me.ClientIDSeparator)
    end function

    
    
</script>




<div class="codeContainer">
    <div class="codeTitleBar">
        <div class="codeLinks">
        <a
            id="lnkClipboard"
            href="javascript:void(0);" 
            class="codeCopy" 
            Runat="server">Copy Code</a>
        <asp:HyperLink
            id="lnkTryIt"
            Text="Try It"
            NavigateUrl='<%# String.Format("~/virtual/codesample/{0}/{1}", Eval("Id"), Eval("FileName")) %>'
            Visible='<%# Eval("EnableTryIt") %>'
            Target="_blank"
            Runat="server" />            
        </div>
    <%# Eval("FileName") %>
    (<%# Eval("CodeSampleLanguage.Name") %>)
    </div>
    <div id="<%# GetCodeClientId() %>" class="code"><asp:Literal ID="ltlCode" Text='<%# Eval("Code") %>' Mode="Encode" runat="server" /></div>
</div>


