﻿using System.Data;
using System.Data.SqlClient;
using System;

namespace all_op_in_dataset
{
    class Program
    {

        static void Main(string[] args)
        {

            SqlConnection cn = new SqlConnection();
            DataSet Ds = new DataSet();
            SqlDataAdapter da;
            SqlCommandBuilder cmdBuilder;

            //Set the connection string of the SqlConnection object to connect
            //to the SQL Server database in which you created the sample
            //table.
            try
            {
                string path = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);

                
       
                cn.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename="+ path + "\\master.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True";
                cn.Open();

                //Initialize the SqlDataAdapter object by specifying a Select command 
                //that retrieves data from the sample table.
                da = new SqlDataAdapter("select id,name from Employee", cn);

                //Initialize the SqlCommandBuilder object to automatically generate and initialize
                //the UpdateCommand, InsertCommand, and DeleteCommand properties of the SqlDataAdapter.
                cmdBuilder = new SqlCommandBuilder(da);

                //Populate the DataSet by running the Fill method of the SqlDataAdapter.
                da.Fill(Ds, "Employee");

                //Display the Update, Insert, and Delete commands that were automatically generated
                //by the SqlCommandBuilder object.
                Console.WriteLine("Update command Generated by the Command Builder : ");
                Console.WriteLine("==================================================");
                Console.WriteLine(cmdBuilder.GetUpdateCommand().CommandText);
                Console.WriteLine("         ");

                Console.WriteLine("Insert command Generated by the Command Builder : ");
                Console.WriteLine("==================================================");
                Console.WriteLine(cmdBuilder.GetInsertCommand().CommandText);
                Console.WriteLine("         ");

                Console.WriteLine("Delete command Generated by the Command Builder : ");
                Console.WriteLine("==================================================");
                Console.WriteLine(cmdBuilder.GetDeleteCommand().CommandText);
                Console.WriteLine("         ");
                
                //Write out the value in the CustName field before updating the data using the DataSet.
                Console.WriteLine("Name before Update : " + Ds.Tables["Employee"].Rows[1]["name"]);

                //Modify the value of the CustName field.
                Ds.Tables["Employee"].Rows[1]["name"] = "Atul";
               
                int i = da.Update(Ds, "Employee");

                Console.WriteLine("Name After Update : " + Ds.Tables["Employee"].Rows[0]["name"]);
                Console.WriteLine("Name updated successfully, Upd val : " + i);

                //Close the database connection.
                cn.Close();
            }
            catch (Exception e)
            {
                Console.WriteLine("Error : " + e.Message.ToString());
            }
            //Pause
            Console.ReadLine();
        }
    }
}