using System;
using System.Data;
using System.Xml;
using System.Data.SqlClient;
using System.Data.OleDb;


public class MYDataAdapter
{
    
    public static void Main()
    {
        string path = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);

        // The following is the database connection string
        string source = @"Data Source=.\SQLEXPRESS;AttachDbFilename="+path+"\\master.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True";

        // Create & open the database connection
        SqlConnection conn = new SqlConnection(source);
        conn.Open();
        
        // Create a data adapter to fill the DataSet
        SqlDataAdapter da = new SqlDataAdapter("select RegionID,RegionDescription from Region", conn);
        SqlCommandBuilder cmdBuilder = new SqlCommandBuilder(da);
       
        // Create a DataSet
        DataSet ds = new DataSet();
                
        // Execute the Select Command to fill the dataset
        da.Fill(ds, "Region");

        DumpDataSet(ds, "Initial data selected from database");

        // Add a new row into the dataset
        DataRow r = ds.Tables["Region"].NewRow();

        r["RegionID"] = 999;
        r["RegionDescription"] = "North West";

        // Add the row into the DataTable
        ds.Tables["Region"].Rows.Add(r);

        DumpDataSet(ds, "New row pending inserting into database");

        // And use the data adapter to update the table
        da.Update(ds, "Region");

        DumpDataSet(ds, "New row updated and new RegionID assigned by database");

        // Capture the regionID for later...
        string regionID = r[0].ToString();

        // Now update something that's already there
        r["RegionDescription"] = "North West England";

        DumpDataSet(ds, string.Format("Changed RegionID {0} description", regionID));

        // And use the data adapter to update the table
        da.Update(ds, "Region");

        // And finally delete the row I added...
        
        //r.Delete();

       DumpDataSet(ds, string.Format("Deleted RegionID {0}", regionID));

        // And use the data adapter to update the table
        da.Update(ds, "Region");

        
        Console.Read();
    }

    
    private static void DumpDataSet(DataSet ds, string message)
    {
        Console.WriteLine(message);

        foreach (DataRow aRow in ds.Tables["Region"].Rows)
        {
            if (aRow.RowState == DataRowState.Deleted)
                Console.WriteLine("Row Deleted");
            else
                Console.WriteLine("  {0,-3} {1,-50} {2}", aRow[0], aRow[1], aRow.RowState);
        }
    }

    
   
}