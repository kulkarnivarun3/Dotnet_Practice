<%@ WebHandler Language="C#" Class="FileHandlerLarge" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;

public class FileHandlerLarge : IHttpHandler {

    const string conString = @"Server=.\SQLExpress;Integrated Security=True;
        AttachDbFileName=|DataDirectory|FilesDB.mdf;User Instance=True";
    
    public void ProcessRequest (HttpContext context) {
        context.Response.Buffer = false;
        context.Response.ContentType = "application/msword";
        
        SqlConnection con = new SqlConnection(conString);
        SqlCommand cmd = new SqlCommand("SELECT FileBytes FROM Files WHERE Id=@Id", con);
        cmd.Parameters.AddWithValue("@Id", context.Request["Id"]);
        using (con)
        {
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.SequentialAccess);
            if (reader.Read())
            {
                int bufferSize = 8040;
                byte[] chunk = new byte[bufferSize];
                long retCount;
                long startIndex = 0;

                retCount = reader.GetBytes(0, startIndex, chunk, 0, bufferSize);

                
                while (retCount == bufferSize)
                {
                    context.Response.BinaryWrite(chunk);

                    startIndex += bufferSize;
                    retCount = reader.GetBytes(0, startIndex, chunk, 0, bufferSize);
                }

                byte[] actualChunk = new Byte[retCount - 1];
                Buffer.BlockCopy(chunk, 0, actualChunk, 0, (int)retCount - 1);
                context.Response.BinaryWrite(actualChunk);
                               
            }
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}