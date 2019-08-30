using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace LocalDB1
{
    class Program
    {
        static String path = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);
        static SqlConnection con = new SqlConnection(@"Data Source=.\SQLEXPRESS;AttachDbFilename="+path+"\\master.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True");
        static SqlCommand cmd = new SqlCommand();
        static void Main(string[] args)
        {
                       
            
            con.Open();
            Console.WriteLine("Connection Opened !");
            //SqlCommand cmd = new SqlCommand("create database empdb", con);
            //cmd.ExecuteNonQuery();
            //Console.WriteLine("Database Created !");
            cmd.Connection = con;
            /*cmd.CommandText = @"create table employee (
                                                        srno int identity(1,1) primary key,
                                                        ename varchar(50),
                                                        emailid  varchar(50),
                                                       )";
            cmd.ExecuteNonQuery();
            Console.WriteLine("Table created !");*/

            int menu = -11;
            while (menu != 5)
            {
                Console.Clear();
                Console.WriteLine("1. View Records.");
                Console.WriteLine("2. Add Record.");
                Console.WriteLine("3. Update Record.");
                Console.WriteLine("4. Delete Record.");
                Console.WriteLine("5. Exit.");
                Console.Write("Enter choice: ");
                try
                {
                    menu = int.Parse(Console.ReadLine());
                    switch (menu)
                    {
                        case 1:
                            ReadRecords();
                            break;
                        case 2:
                            AddRecord();
                            break;
                        case 3:
                            UpdateRecord();
                            break;
                        case 4:
                            DeleteRecord();
                            break;
                        case 5:
                            Console.WriteLine("Thank You !");
                            break;
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                    Console.ReadLine();
                }
            }

            con.Close();
            Console.ReadLine();
        }

        static void ReadRecords()
        {
            cmd.CommandText = "select * from employee";
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.HasRows)
            {
                Console.WriteLine();
                while (rdr.Read())
                {
                    Console.Write("srno    : " + rdr[0]);
                    Console.Write("\tName  : " + rdr[1]);
                    Console.WriteLine("\temail  : " + rdr[2]);
                    Console.WriteLine();
                }
            }
            else
            {
                Console.WriteLine("No records !");
                Console.ReadLine();
            }
            rdr.Close();
            Console.ReadLine();
        }

        static void AddRecord()
        {
            string name, emailid;
            Console.Write("Enter Name    : ");
            name = Console.ReadLine();
            Console.Write("Enter EmailId : ");
            emailid = Console.ReadLine();
            cmd.Parameters.Clear();
            cmd.CommandText = "insert into employee (ename, emailid) values (@en,@em)";
            cmd.Parameters.AddWithValue("@en", name);
            cmd.Parameters.AddWithValue("@em", emailid);
            cmd.ExecuteNonQuery();
            Console.WriteLine("Record inserted !");
            Console.ReadLine();
        }

        static void UpdateRecord()
        {
            int id;
            Console.Write("Enter Employee Id to update: ");
            try
            {
                id = int.Parse(Console.ReadLine());
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Console.ReadLine();
                return;
            }
            string name = "na", emailid = "na";
            Console.Write("Enter Name    : ");
            name = Console.ReadLine();
            Console.Write("Enter EmailId : ");
            emailid = Console.ReadLine();
            cmd.Parameters.Clear();
            cmd.CommandText = "update employee set ename=@en, emailid=@em where srno=@id";
            cmd.Parameters.AddWithValue("@en", name);
            cmd.Parameters.AddWithValue("@em", emailid);
            cmd.Parameters.AddWithValue("@id", id);
            cmd.ExecuteNonQuery();
            Console.WriteLine("Record updated !");
            Console.ReadLine();
        }

        static void DeleteRecord()
        {
            int id;
            Console.Write("Enter Employee Id to delete: ");
            try
            {
                id = int.Parse(Console.ReadLine());
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Console.ReadLine();
                return;
            }
            cmd.Parameters.Clear();
            cmd.CommandText = "delete from employee where srno=@id";
            cmd.Parameters.AddWithValue("@id", id);
            cmd.ExecuteNonQuery();
            Console.WriteLine("Record deleted !");
            Console.ReadLine();
        }
    }
}
