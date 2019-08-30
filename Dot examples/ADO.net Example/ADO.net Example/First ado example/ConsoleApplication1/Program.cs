using System;
//using System.Data.SqlClient;
using System.Data.OleDb;

namespace ConsoleApplication1
{
   
public class ExecuteNonQueryExample
{
   public static void Main(string[] args)
   {
       /*/
       //string source = @"Data Source=.\SQLEXPRESS;AttachDbFilename=G:\ADO.net Example\First ado example\master.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True";
      // string source =@"Data Source=CSDCLASS1\SQLEXPRESS;Initial Catalog=master;Integrated Security=True";
     
     // string select = "UPDATE stud set Name = 'Bob' WHERE Name = 'aaaa'";
       string select = "select count(*) from stud";
      SqlConnection  conn = new SqlConnection(source);
      conn.Open();
      SqlCommand cmd = new SqlCommand(select, conn);
      //int rowsReturned = cmd.ExecuteNonQuery();
      object o=cmd.ExecuteScalar();
      //Console.WriteLine("{0} rows returned.", rowsReturned);
      Console.WriteLine(o);
      Console.Read();
      conn.Close();*/
       
       // FOR ACCESS DATABASE
       string source = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=G:\ADO.net Example\First ado example\mca5.accdb";
       string select = "select count(*) from stud";
       OleDbConnection conn = new OleDbConnection(source);
       conn.Open();
       OleDbCommand cmd = new OleDbCommand(select, conn);
      
       object o = cmd.ExecuteScalar();
       
       Console.WriteLine(o);
       Console.Read();
       conn.Close();

   }
} 
}
