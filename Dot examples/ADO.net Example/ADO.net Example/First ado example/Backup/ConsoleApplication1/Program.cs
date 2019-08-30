using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
 using System.Data.SqlClient;

namespace ConsoleApplication1
{
   
public class ExecuteNonQueryExample
{
   public static void Main(string[] args)
   {
       string source = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Documents and Settings\Administrator\My Documents\master.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True";
      string select = "UPDATE stud set Name = 'Bob' WHERE Name = 'Bill'";
      SqlConnection  conn = new SqlConnection(source);
      conn.Open();
      SqlCommand cmd = new SqlCommand(select, conn);
      int rowsReturned = cmd.ExecuteNonQuery();
      Console.WriteLine("{0} rows returned.", rowsReturned);
      Console.Read();
      conn.Close();
   }
} 
}
