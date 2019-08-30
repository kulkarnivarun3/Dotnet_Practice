using System;
using System.Data.OleDb;

public class DataReader
{
    public static int Main(string[] args)
    {
        string path = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);
      // string source = @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=G:\ADO.net Example\oledb access connectivity\oledb\bin\Debug\Register.mdb";
       string source = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="+path+"\\Register.mdb";
        //Application.StartupPath for windows form applications
        //Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\amg\Desktop\oledb\Register.mdb
        string select = "SELECT name, city FROM reg1";
        
        OleDbConnection conn = new OleDbConnection(source);

        try
        {
            conn.Open();

            OleDbCommand cmd = new OleDbCommand(select, conn);

            OleDbDataReader aReader = cmd.ExecuteReader();

            while (aReader.Read())
                Console.WriteLine("{0}  {1} ", aReader[0], aReader[1]);

            Console.Read();
            aReader.Close();
            conn.Close();
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            Console.Read();
        }

        return 0;
    }
}
