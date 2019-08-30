using System;
using System.Windows.Forms;
using System.Data;
using System.Data.SqlClient;

namespace WindowsForms_database_connection
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string connetionString = null;
            SqlConnection sqlCnn;
            SqlCommand sqlCmd;
            string sql = null;

            string path = Application.StartupPath;
                //for console application use: System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);
            
            connetionString= @"Data Source=.\SQLEXPRESS;AttachDbFilename="+path+"\\master.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True";
           
            sql = "Select * from stud";

            sqlCnn = new SqlConnection(connetionString);
            try
            {
                sqlCnn.Open();
                sqlCmd = new SqlCommand(sql, sqlCnn);
                SqlDataReader sqlReader = sqlCmd.ExecuteReader();
                while (sqlReader.Read())
                {
                    MessageBox.Show(string.Format("Name={0}\t rno= {1}", sqlReader[0],sqlReader[1]));
                }
                
                //to Get table informaion
               /* DataTable schemaTable = sqlReader.GetSchemaTable();
                                foreach (DataRow row in schemaTable.Rows)
                {
                    foreach (DataColumn column in schemaTable.Columns)
                    {
                        MessageBox.Show(string.Format("{0} = {1}", column.ColumnName, row[column]));
                    }
                }*/
                sqlReader.Close();
                sqlCmd.Dispose();
                sqlCnn.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Can not open connection ! "+ex);
            }
        }
    }
}
 

