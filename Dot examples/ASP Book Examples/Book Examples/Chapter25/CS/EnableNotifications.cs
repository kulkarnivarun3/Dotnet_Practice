using System;
using System.Collections.Generic;
using System.Text;
using System.Web.Caching;
using System.IO;
using System.Data.SqlClient;
using System.ServiceProcess;

namespace EnableNotifications
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length < 2)
            {
                showHelp();
            }
            else
            {

                string database = args[0];
                string tableName = args[1];

                // Create full connection string
                string conString = BuildConnectionString(database);

                // Enable database for notifications
                try
                {
                    if (!DatabaseEnabled(conString))
                        SqlCacheDependencyAdmin.EnableNotifications(conString);
                }
                catch (Exception ex)
                {
                    Console.WriteLine("ERROR: Could not connect to database.");
                    Console.WriteLine(ex.Message);
                    return;
                }

                // Enable table for notifications
                try
                {
                    SqlCacheDependencyAdmin.EnableTableForNotifications(conString, tableName);
                }
                catch (Exception ex)
                {
                    Console.WriteLine("ERROR: Could not enable table.");
                    Console.WriteLine(ex.Message);
                    return;
                }

                // Report success
                Console.WriteLine("Notifications enabled!");
            }
        }

        static void showHelp()
        {
            Console.WriteLine("Superexpert enable SQL cache notifications tool.");
            Console.WriteLine("This tool enables a SQL Express table for SQL cache notifications.");
            Console.WriteLine("Example:");
            Console.WriteLine("  EnableNotifications \"database name\" \"table name\"");
        }

        static string BuildConnectionString(string database)
        {
            string databasePath = Path.Combine(Environment.CurrentDirectory, database);

            SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();
            builder.AttachDBFilename = databasePath;
            builder.DataSource = @".\SQLExpress";
            builder.IntegratedSecurity = true;
            builder.UserInstance = true;

            return builder.ToString();
        }


        static bool DatabaseEnabled(string conString)
        {
            bool result = false;
            SqlConnection con = new SqlConnection(conString);
            SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM SysObjects WHERE name='AspNet_SqlCacheTablesForChangeNotification'", con);
            con.Open();
            int count = (int)cmd.ExecuteScalar();
            result = count > 0;
            con.Close();
            return result;
        }

    }
}
