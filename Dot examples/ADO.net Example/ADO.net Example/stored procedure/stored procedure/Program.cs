using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace stored_procedure
{
    class Program
    {
        static void Main(string[] args)
        {
            string path = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);
            string source = @"Data Source=.\SQLEXPRESS;AttachDbFilename=" + path + "\\master.mdf;Integrated Security=True; Connect Timeout = 30; User Instance = True";
           // string source =@"Data Source=.\SQLEXPRESS;AttachDbFilename=G:\ADO.net Example\stored procedure\stored procedure\bin\Debug\master.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True";
            SqlConnection conn = new SqlConnection(source);
            conn.Open();
           
            //update stored procedure
            SqlCommand cmd = new SqlCommand("updatercord", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@rns
            cmd.Parameters.AddWithValue("@name", "amg");
            int rowsReturned = cmd.ExecuteNonQuery();
            Console.WriteLine("{0} rows returned.", rowsReturned);
            Console.Read();

            //INSERT PROCEDURE
            cmd.CommandText="insertRecord";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@rno", 1);
            cmd.Parameters.AddWithValue("@name", "Riya");
            
            rowsReturned = cmd.ExecuteNonQuery();
            Console.WriteLine("{0} rows returned.", rowsReturned);
            Console.Read();
            conn.Close();
        }
    }
}



