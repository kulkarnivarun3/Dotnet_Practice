<%@ Control Language="vb" ClassName="CodeCloud" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">
 
    Private maxValue As Integer
 
 
    Private Sub Page_Load()
        Dim cloud As IEnumerable(Of CloudItem) = EntryTag.SelectTagCloud()
 
        ' get maximum value
        If cloud.Count() > 0 Then
            maxValue = cloud.Max(Function(c) c.Count)
        End If
 
        ' bind to ListView
        lstCloud.DataSource = cloud
        lstCloud.DataBind()
    End Sub
 
 
    Private Function GetSize(ByVal count As Integer) As String
        Dim percent As Integer = CType(Math.Floor(Decimal.Divide(count, maxValue) * 100), Integer)
        Dim em As Double
        If percent < 20 Then
            percent = 20
        End If
 
        Select Case percent
            Case 25
                em = 0.8
            Case 50
                em = 1.2
            Case 75
                em = 1.6
            Case 100
                em = 2.0
            Case Else
                em = 0.8
        End Select
 
        Return String.Format("font-size: {0}em", em)
    End Function
 
    Private Function GetUrl(ByVal tagName As String) As String
        Return Page.ResolveUrl(String.Format("~/CodeSamples/EntriesByTag.aspx?tag={0}", tagName))
    End Function



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
        <a style='<%# GetSize( Eval("Count") ) %>' href='<%# GetUrl( Eval("Name") )  %>'><%# Eval("Name") %></a>
    </ItemTemplate>    
</asp:ListView>

