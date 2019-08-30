<%@ WebHandler Language="C#" Class="AdHandler" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;

public class AdHandler : IHttpHandler {

    const string conString = @"Server=.\SQLExpress;Integrated Security=True;
            AttachDbFileName=|DataDirectory|AdListDB.mdf;User Instance=True";
    
    public void ProcessRequest (HttpContext context) 
    {
        int AdId = Int32.Parse(context.Request["Id"]);

        SqlConnection con = new SqlConnection(conString);
        string navigateUrl = String.Empty;
        using (con)
        {
            con.Open();
            UpdateTransferStats(AdId, con);
            navigateUrl = GetNavigateUrl(AdId, con);
        }

        if (!String.IsNullOrEmpty(navigateUrl))
            context.Response.Redirect(navigateUrl);
    }

    void UpdateTransferStats(int advertisementId, SqlConnection con)
    {
        string cmdText = "INSERT AdStats (AdId, EntryDate, Type) VALUES " +
            "(@AdId, GetDate(), 1)";
        SqlCommand cmd = new SqlCommand(cmdText, con);
        cmd.Parameters.AddWithValue("@AdId", advertisementId);
        cmd.ExecuteNonQuery();
    }

    string GetNavigateUrl(int advertisementId, SqlConnection con)
    {
        string cmdText = "SELECT NavigateUrl FROM AdList WHERE Id=@AdId";
        SqlCommand cmd = new SqlCommand(cmdText, con);
        cmd.Parameters.AddWithValue("@AdId", advertisementId);
        return cmd.ExecuteScalar().ToString();
    }
    
    
    public bool IsReusable 
    {
        get 
        {
            return false;
        }
    }

}