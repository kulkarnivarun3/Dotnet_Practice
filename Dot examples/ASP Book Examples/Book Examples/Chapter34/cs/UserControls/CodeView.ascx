<%@ Control Language="C#" ClassName="CodeView" %>

<script runat="server">

    string script = @"function copyToClipboard(e, id) 
        {
            if (e.preventDefault)
                e.preventDefault();
            e.returnValue = false;
            if (window.clipboardData)            
                window.clipboardData.setData('Text', document.getElementById(id).innerText);
            else
                alert('Sorry, your browser does not support copying to the clipboard!');
        }";



    void Page_Load()
    {
        // Copy to clipboard
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "clipboard", script, true); 
        lnkClipboard.Attributes.Add("onclick", String.Format("copyToClipboard(event, '{0}');", GetCodeClientId()));
    }
 

    string GetCodeClientId()
    {
        return String.Format("{0}{1}Code", this.ClientID, this.ClientIDSeparator);
    }
    
    
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


