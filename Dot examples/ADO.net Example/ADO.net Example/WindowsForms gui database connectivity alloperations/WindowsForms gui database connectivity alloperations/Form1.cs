using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;


namespace WindowsForms_gui_database_connectivity_alloperations
{
    public partial class Form1 : Form
    {
        
        public string query;
        public string connection = null;
        

        public Form1()
        {
            InitializeComponent();
            string path = Application.StartupPath;
            connection = @"Data Source=.\SQLEXPRESS;AttachDbFilename=" + path + "\\master.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True";
        }

               
        public void Myquerydata(string query)
        {
            SqlConnection con = new SqlConnection(connection);
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Can not open connection ! \n" + ex);
            }

        }
        public void MyShowquerydata(string query)
        {
            SqlConnection con = new SqlConnection(connection);
            try
            {
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(query, con);
                DataTable t = new DataTable();
                sda.Fill(t);
                dataGridView1.DataSource = t;
                con.Close();

            }
            catch (Exception ex)
            {
                MessageBox.Show("Can not open connection ! \n" + ex);
            }
            
        }
        private void Add_Click(object sender, EventArgs e)
        {
            textBox1Rno.Clear();
            textBox2Name.Clear();
        }

        private void Save_Click(object sender, EventArgs e)
        {
            try
            {
                query = "INSERT INTO stud (rno,name) VALUES(" + textBox1Rno.Text + ",'" + textBox2Name.Text + "')";
                Myquerydata(query);
                MessageBox.Show("Hurriyyy....!!! Data Save/Inserted Successfully..!!!");
                textBox1Rno.Clear();
                textBox2Name.Clear();
                MyShowquerydata("Select * from stud");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void BtnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        
        private void BtnUpdate_Click(object sender, EventArgs e)
        {
             try
            {
                query = "update stud set name='" + textBox2Name.Text + "' where rno = " + textBox1Rno.Text + "";
                Myquerydata(query);
                MessageBox.Show("Hurriyyy....!!! Data Updated Successfully..!!!");
                textBox1Rno.Clear();
                textBox2Name.Clear();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }

        private void BtnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                query = "delete from stud where rno=" + textBox1Rno.Text + "";
                Myquerydata(query);
                MessageBox.Show("Hurriyyy....!!! Data Deleted Successfully..!!!");
                textBox1Rno.Clear();
                textBox2Name.Clear();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }

        private void showData_Click(object sender, EventArgs e)
        {
            MyShowquerydata("Select * from stud");
                        
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'masterDataSet.stud' table. You can move, or remove it, as needed.
            this.studTableAdapter.Fill(this.masterDataSet.stud);
            // TODO: This line of code loads data into the 'masterDataSet.stud' table. You can move, or remove it, as needed.
            this.studTableAdapter.Fill(this.masterDataSet.stud);

        }

        

        

        
    }
}
