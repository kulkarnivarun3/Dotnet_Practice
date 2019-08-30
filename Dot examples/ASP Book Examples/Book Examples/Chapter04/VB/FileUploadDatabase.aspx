<%@ Page Language="VB" %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub btnAdd_Click(ByVal sender As Object, ByVal e As EventArgs)
        If upFile.HasFile Then
            If CheckFileType(upFile.FileName) Then
                srcFiles.Insert()
            End If
        End If
    End Sub

    Function CheckFileType(ByVal fileName As String) As Boolean
        Return Path.GetExtension(fileName).ToLower() = ".doc"
    End Function
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .fileList li
        {
            margin-bottom:5px;
        }
    </style>
    <title>FileUpload Database</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:Label
        id="lblFile"
        Text="Word Document:"
        AssociatedControlID="upFile"
        Runat="server" />

    <asp:FileUpload
        id="upFile"
        Runat="server" />

    <asp:Button
        id="btnAdd"
        Text="Add Document"
        OnClick="btnAdd_Click" 
        Runat="server" />
    
    <hr />

    <asp:Repeater
        id="rptFiles"
        DataSourceID="srcFiles"
        Runat="server">
        <HeaderTemplate>
        <ul class="fileList">
        </HeaderTemplate>
        <ItemTemplate>
        <li>
        <asp:HyperLink
            id="lnkFile"
            Text='<%#Eval("FileName")%>'
            NavigateUrl='<%#Eval("Id", "~/FileHandler.ashx?id={0}")%>'
            Runat="server" />
        </li>
        </ItemTemplate>
        <FooterTemplate>
        </ul>
        </FooterTemplate>    
    </asp:Repeater>

    <asp:SqlDataSource
        id="srcFiles"
        ConnectionString="Server=.\SQLExpress;Integrated Security=True;
            AttachDbFileName=|DataDirectory|FilesDB.mdf;User Instance=True"
        SelectCommand="SELECT Id,FileName FROM Files"
        InsertCommand="INSERT Files (FileName,FileBytes) VALUES (@FileName,@FileBytes)"
        Runat="server">
        <InsertParameters>
            <asp:ControlParameter Name="FileName" ControlID="upFile" PropertyName="FileName" />
            <asp:ControlParameter Name="FileBytes" ControlID="upFile" PropertyName="FileBytes" />
        </InsertParameters>
    </asp:SqlDataSource>
            
    </div>
    </form>
</body>
</html>
