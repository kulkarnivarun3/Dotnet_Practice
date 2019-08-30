<%@ Control Language="C#" ClassName="CodeCloud" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">

    private int maxValue;


    void Page_Load()
    {
        IEnumerable<CloudItem> cloud = EntryTag.SelectTagCloud();
        
        // get maximum value
        if (cloud.Count() > 0)
            maxValue = cloud.Max( c => c.Count );
        
        // bind to ListView
        lstCloud.DataSource = cloud;
        lstCloud.DataBind();
    }
    
    
    string GetSize(int count)
    {
        int percent = (int)Math.Floor( decimal.Divide(count, maxValue ) * 100 );
        double em;
        if (percent < 20)
            percent = 20;
        
        switch (percent)
        {
            case 25:
                em = .8;
                break;
            case 50:
                em = 1.2;
                break;
            case 75:
                em = 1.6;
                break;
            case 100:
                em = 2.0;
                break;
            default:
                em = .8;
                break;
        }
        
        return String.Format("font-size: {0}em", em);
    }

    string GetUrl(string tagName)
    {
        return Page.ResolveUrl(String.Format("~/CodeSamples/EntriesByTag.aspx?tag={0}", tagName));
    }



</script>


<asp:ListView   
    id="lstCloud"
    Runat="server">
    <LayoutTemplate>
        <div class="codeCloud">
        <asp:PlaceHolder
            id="itemPlaceholder"
            runat="server" />
        </div>
    </LayoutTemplate>
    <ItemTemplate>
        <a style="<%# GetSize( (int)Eval("Count") ) %>" href="<%# GetUrl( (string)Eval("Name") )  %>"><%# Eval("Name") %></a>
    </ItemTemplate>    
</asp:ListView>

