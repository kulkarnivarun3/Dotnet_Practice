using System;
using System.Collections.Generic;
using System.Data.SqlClient;

public class GenericMethods
{
    public static List<T> GetListFromCommand<T>(SqlCommand command)
    where T : ICreatable, new()
    {
        List<T> results = new List<T>();
        using (command.Connection)
        {
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                T newThing = new T();
                newThing.Create(reader);
                results.Add(newThing);
            }
        }
        return results;
    }
}

public interface ICreatable
{
    void Create(SqlDataReader reader);
}
