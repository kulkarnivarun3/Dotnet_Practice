<%@ Page Language="VB" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Const conString As String = "Server=.\SQLExpress;Integrated Security=True;AttachDbFileName=|DataDirectory|FilesDB.mdf;User Instance=True"

    Sub btnAdd_Click(ByVal s As Object, ByVal e As EventArgs)
        If upFile.HasFile Then
            If CheckFileType(upFile.FileName) Then
                AddFile(upFile.FileName, upFile.FileContent)
                rptFiles.DataBind()
            End If
        End If
    End Sub
    
    Function CheckFileType(ByVal fileName As String) As Boolean
        Return Path.GetExtension(fileName).ToLower() = ".doc"
    End Function
    
    Sub AddFile(ByVal fileName As String, ByVal upload As Stream)
        Dim con As New SqlConnection(conString)

        Dim cmd As New SqlCommand("INSERT Files (FileName) Values (@FileName);SELECT @Identity = SCOPE_IDENTITY()", con)

        cmd.Parameters.AddWithValue("@FileName", fileName)
        Dim idParm As SqlParameter = cmd.Parameters.Add("@Identity", SqlDbType.Int)
        idParm.Direction = ParameterDirection.Output

        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            Dim newFileId As Integer = CType(idParm.Value, Integer)
            StoreFile(newFileId, upload, con)
        End Using
    End Sub
    
    Sub StoreFile(ByVal fileId As Integer, ByVal upload As Stream, ByVal connection As SqlConnection)
        Dim bufferLen As Integer = 8040
        Dim br As New BinaryReader(upload)
        Dim chunk As Byte() = br.ReadBytes(bufferLen)

        Dim cmd As New SqlCommand("UPDATE Files SET FileBytes=@Buffer WHERE Id=@FileId", connection)
        cmd.Parameters.AddWithValue("@FileId", fileId)
        cmd.Parameters.Add("@Buffer", SqlDbType.VarBinary, bufferLen).Value = chunk
        cmd.ExecuteNonQuery()
                
        
        Dim cmdAppend As New SqlCommand("UPDATE Files SET FileBytes .WRITE(@Buffer, NULL, 0) WHERE Id=@FileId", connection)
        cmdAppend.Parameters.AddWithValue("@FileId", fileId)
        cmdAppend.Parameters.Add("@Buffer", SqlDbType.VarBinary, bufferLen)
        chunk = br.ReadBytes(bufferLen)
        
        While chunk.Length > 0
            cmdAppend.Parameters("@Buffer").Value = chunk
            cmdAppend.ExecuteNonQuery()
            chunk = br.ReadBytes(bufferLen)
        End While

        br.Close()
    End Sub
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>FileUpload Large</title>
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
            NavigateUrl='<%#Eval("Id", "~/FileHandlerLarge.ashx?id={0}")%>'
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
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
