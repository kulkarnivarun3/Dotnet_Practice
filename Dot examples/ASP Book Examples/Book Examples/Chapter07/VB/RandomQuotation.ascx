<%@ Control Language="vb" ClassName="RandomQuotation" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">

    Sub Page_Load()
        Dim quotes As New List(Of String)()
        quotes.Add("All paid jobs absorb and degrade the mind -- Aristotle")
        quotes.Add("No evil can happen to a good man, either in life or after death -- Plato")
        quotes.Add("The only good is knowledge and the only evil is ignorance -- Plato")
        Dim rnd As New Random()
        lblQuote.Text = quotes(rnd.Next(quotes.Count))
    End Sub
</script>

<asp:ScriptManager ID="sm1" runat="server" />
<asp:Timer ID="Timer1" Interval="5000" runat="server" />

<asp:UpdatePanel ID="up1" runat="server">
<Triggers>
    <asp:AsyncPostBackTrigger ControlID="Timer1" />
</Triggers>
<ContentTemplate>
    <div class="quote">
    <asp:Label
        id="lblQuote"
        Runat="server" />
    </div>
</ContentTemplate>    
</asp:UpdatePanel>