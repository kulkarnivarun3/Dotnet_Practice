<%@ WebHandler Language="C#" Class="FileHandler" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;

public class FileHandler : IHttpHandler {

    const string conString = @"Server=.\SQLExpress;Integrated Security=True;
        AttachDbFileName=|DataDirectory|FilesDB.mdf;User Instance=True";
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/msword";
        
        SqlConnection con = new SqlConnection(conString);
        SqlCommand cmd = new SqlCommand("SELECT FileBytes FROM Files WHERE Id=@Id", con);
        cmd.Parameters.AddWithValue("@Id", context.Request["Id"]);
        using (con)
        {
            con.Open();
            byte[] file = (byte[])cmd.ExecuteScalar();
            context.Response.BinaryWrite(file);
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}