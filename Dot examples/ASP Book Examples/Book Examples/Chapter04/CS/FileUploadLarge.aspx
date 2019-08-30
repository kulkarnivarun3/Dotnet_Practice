<%@ Page Language="C#" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    const string conString = @"Server=.\SQLExpress;Integrated Security=True;
        AttachDbFileName=|DataDirectory|FilesDB.mdf;User Instance=True";


    void btnAdd_Click(Object s, EventArgs e)
    {
        if (upFile.HasFile)
        {
            if (CheckFileType(upFile.FileName))
            {
                AddFile(upFile.FileName, upFile.FileContent);
                rptFiles.DataBind();
            }            
        }
    }
    
    bool CheckFileType(string fileName)
    {
        return Path.GetExtension(fileName).ToLower() == ".doc";
    }   
    
    void AddFile(string fileName, Stream upload)
    {
        SqlConnection con = new SqlConnection(conString);

        SqlCommand cmd = new SqlCommand("INSERT Files (FileName) Values (@FileName);" +
          "SELECT @Identity = SCOPE_IDENTITY()", con);

        cmd.Parameters.AddWithValue("@FileName", fileName);
        SqlParameter idParm = cmd.Parameters.Add("@Identity", SqlDbType.Int);
        idParm.Direction = ParameterDirection.Output;

        using (con)
        {
            con.Open();
            cmd.ExecuteNonQuery();
            int newFileId = (int)idParm.Value;
            StoreFile(newFileId, upload, con);
        }
    }
    
    void StoreFile(int fileId, Stream upload, SqlConnection connection)
    {
        int bufferLen = 8040;
        BinaryReader br = new BinaryReader(upload);
        byte[] chunk = br.ReadBytes(bufferLen);

        SqlCommand cmd = new SqlCommand("UPDATE Files SET FileBytes=@Buffer WHERE Id=@FileId", connection);
        cmd.Parameters.AddWithValue("@FileId", fileId);
        cmd.Parameters.Add("@Buffer", SqlDbType.VarBinary, bufferLen).Value = chunk;
        cmd.ExecuteNonQuery();
                
        
        SqlCommand cmdAppend = new SqlCommand("UPDATE Files SET FileBytes .WRITE(@Buffer, NULL, 0) WHERE Id=@FileId", connection);
        cmdAppend.Parameters.AddWithValue("@FileId", fileId);
        cmdAppend.Parameters.Add("@Buffer", SqlDbType.VarBinary, bufferLen);
        chunk = br.ReadBytes(bufferLen);
        
        while (chunk.Length > 0)
        {
            cmdAppend.Parameters["@Buffer"].Value = chunk;
            cmdAppend.ExecuteNonQuery();
            chunk = br.ReadBytes(bufferLen);
        }

        br.Close();
    }
    
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
