<%@ Page Language="VB" %>
<%@ Register TagPrefix="custom" Namespace="AspNetUnleashed" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    Sub TreeView1_SelectedNodeChanged(sender As object, e As EventArgs)
        lblSelected.Text = TreeView1.SelectedValue
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show TreeView</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:TreeView
        id="TreeView1"
        DataSourceID="srcDiscuss"
        OnSelectedNodeChanged="TreeView1_SelectedNodeChanged"
        ImageSet="News"
        Runat="server">
        <DataBindings>
            <asp:TreeNodeBinding 
                TextField="Subject" 
                ValueField="MessageId" />
        </DataBindings>
    </asp:TreeView>    
     
    <custom:SqlHierarchicalDataSource
        id="srcDiscuss"
        ConnectionString='<%$ ConnectionStrings:Discuss %>'
        DataKeyName="MessageId"
        DataParentKeyName="ParentId"
        SelectCommand="SELECT MessageId,ParentId,Subject FROM Discuss"
        Runat="server" />
    
    <hr />
    
    You selected message number:
    <asp:Label
        id="lblSelected"
        Runat="server" />    
    
    </div>
    </form>
</body>
</html>
