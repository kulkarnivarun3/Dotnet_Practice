using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.SqlServer.Server;

public class RandomRows
{
    [SqlProcedure]
    public static void GetRandomRow()
    {
        // Dump all records from Movies into a DataTable
        SqlDataAdapter dad = new SqlDataAdapter("SELECT Id,Title FROM Movies", "context connection=true");
        DataTable dtblMovies = new DataTable();
        dad.Fill(dtblMovies);

        // Grab a random row
        Random rnd = new Random();
        DataRow ranRow = dtblMovies.Rows[rnd.Next(dtblMovies.Rows.Count)];

        // Build a SqlDataRecord that represents the row
        SqlDataRecord result = new SqlDataRecord(new SqlMetaData("Id", SqlDbType.Int), new SqlMetaData("Title", SqlDbType.NVarChar, 100));
        result.SetSqlInt32(0, (int)ranRow["Id"]);
        result.SetSqlString(1, (string)ranRow["Title"]);

        // Send result
        SqlContext.Pipe.Send(result);
    }

    [SqlProcedure]
    public static void GetRandomRows(int rowsToReturn)
    {
        // Dump all records from Movies into a DataTable
        SqlDataAdapter dad = new SqlDataAdapter("SELECT Id,Title FROM Movies", "context connection=true");
        DataTable dtblMovies = new DataTable();
        dad.Fill(dtblMovies);

        // Send start record
        SqlDataRecord result = new SqlDataRecord(new SqlMetaData("Id", SqlDbType.Int), new SqlMetaData("Title", SqlDbType.NVarChar, 100));
        SqlContext.Pipe.SendResultsStart(result);

        Random rnd = new Random();
        for (int i = 0; i < rowsToReturn; i++)
        {
            // Grab a random row
            DataRow ranRow = dtblMovies.Rows[rnd.Next(dtblMovies.Rows.Count)];

            // Set the record
            result.SetSqlInt32(0, (int)ranRow["Id"]);
            result.SetSqlString(1, (string)ranRow["Title"]);

            // Send record
            SqlContext.Pipe.SendResultsRow(result);
        }

        // Send end record
        SqlContext.Pipe.SendResultsEnd();
    }




}
