using System;
using System.Data.SqlClient;

public class Movie : ICreatable
{
    public int Id { get; set; }

    public string Title { get; set; }

    public void Create(SqlDataReader reader)
    {
        Id = (int)reader["Id"];
        Title = (string)reader["Title"];
    }

}
