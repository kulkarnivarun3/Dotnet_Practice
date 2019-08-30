using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace AspNetUnleashed
{
    public class ImageHandler : IHttpHandler
    {
        const string connectionStringName = "Images";

        public void ProcessRequest(HttpContext context)
        {
            // Don't buffer response
            context.Response.Buffer = false;

            // Get file name
            string fileName = VirtualPathUtility.GetFileName(context.Request.Path);

            // Get image from database
            string conString = WebConfigurationManager.ConnectionStrings[connectionStringName].ConnectionString;
            SqlConnection con = new SqlConnection(conString);
            SqlCommand cmd = new SqlCommand("SELECT Image FROM Images WHERE FileName=@FileName", con);
            cmd.Parameters.AddWithValue("@fileName", fileName);
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

        public bool IsReusable
        {
            get { return true; }
        }
    }
}