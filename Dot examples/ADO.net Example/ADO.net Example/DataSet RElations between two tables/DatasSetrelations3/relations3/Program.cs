using System;
using System.Xml;
using System.Data;

class Exercise
{
    static void Main()
    {
        DataSet dsEmployment = new DataSet("Employment");
        DataTable dtEmployees = new DataTable("Employees");

        DataColumn[] dcEmployees = new DataColumn[4];

        dcEmployees[0] = new DataColumn("EmployeeID",
                    System.Type.GetType("System.Int32"));
        dtEmployees.Columns.Add(dcEmployees[0]);
        dcEmployees[1] = new DataColumn("FirstName",
                     System.Type.GetType("System.String"));
        dtEmployees.Columns.Add(dcEmployees[1]);
        dcEmployees[2] = new DataColumn("LastName",
                     System.Type.GetType("System.String"));
        dtEmployees.Columns.Add(dcEmployees[2]);
        dcEmployees[3] = new DataColumn("Department",
                     System.Type.GetType("System.String"));
        dtEmployees.Columns.Add(dcEmployees[3]);

        DataRow drEmplRecord = dtEmployees.NewRow();
        drEmplRecord["EmployeeID"] = "1";
        drEmplRecord["FirstName"] = "Peter";
        drEmplRecord["LastName"] = "Larsen";
        drEmplRecord["Department"] = "Accounting";
        dtEmployees.Rows.Add(drEmplRecord);

        drEmplRecord = dtEmployees.NewRow();
        drEmplRecord["EmployeeID"] = "2";
        drEmplRecord["FirstName"] = "Paulin";
        drEmplRecord["LastName"] = "Banack";
        drEmplRecord["Department"] = "IT/IM";
        dtEmployees.Rows.Add(drEmplRecord);

        drEmplRecord = dtEmployees.NewRow();
        drEmplRecord["EmployeeID"] = "3";
        drEmplRecord["FirstName"] = "Helene";
        drEmplRecord["LastName"] = "Casson";
        drEmplRecord["Department"] = "Accounting";
        dtEmployees.Rows.Add(drEmplRecord);

        drEmplRecord = dtEmployees.NewRow();
        drEmplRecord["EmployeeID"] = "4";
        drEmplRecord["FirstName"] = "Anselme";
        drEmplRecord["LastName"] = "Thomas";
        drEmplRecord["Department"] = "Public Relations";
        dtEmployees.Rows.Add(drEmplRecord);

        drEmplRecord = dtEmployees.NewRow();
        drEmplRecord["EmployeeID"] = "5";
        drEmplRecord["FirstName"] = "Bertha";
        drEmplRecord["LastName"] = "Colson";
        drEmplRecord["Department"] = "Corporate";
        dtEmployees.Rows.Add(drEmplRecord);

        DataTable dtEmplStatus = new DataTable("EmploymentStatus");

        DataColumn[] dcEmployment = new DataColumn[2];

        dcEmployment[0] = new DataColumn("EmplStatusID",
                     System.Type.GetType("System.Int32"));
        dtEmplStatus.Columns.Add(dcEmployment[0]);
        dcEmployment[1] = new DataColumn("EmplStatus",
                     System.Type.GetType("System.String"));
        dtEmplStatus.Columns.Add(dcEmployment[1]);

        DataRow drEmployment = dtEmplStatus.NewRow();
        drEmployment["EmplStatusID"] = "1";
        drEmployment["EmplStatus"] = "Full Time";
        dtEmplStatus.Rows.Add(drEmployment);

        drEmployment = dtEmplStatus.NewRow();
        drEmployment["EmplStatusID"] = "2";
        drEmployment["EmplStatus"] = "Part Time";
        dtEmplStatus.Rows.Add(drEmployment);

        drEmployment = dtEmplStatus.NewRow();
        drEmployment["EmplStatusID"] = "3";
        drEmployment["EmplStatus"] = "Contractor";
        dtEmplStatus.Rows.Add(drEmployment);

        drEmployment = dtEmplStatus.NewRow();
        drEmployment["EmplStatusID"] = "4";
        drEmployment["EmplStatus"] = "Intern";
        dtEmplStatus.Rows.Add(drEmployment);

        dsEmployment.Tables.Add(dtEmplStatus);
        dsEmployment.Tables.Add(dtEmployees);

        Console.WriteLine("===+=============+===============+=================");
        Console.WriteLine("ID | First Name\t | Last Name\t | Department");
        Console.WriteLine("---+-------------+---------------+-----------------");
        foreach (DataRow row in dsEmployment.Tables["Employees"].Rows)
            Console.WriteLine(" {0} | {1}\t | {2}\t | {3}",
                              row["EmployeeID"], row["FirstName"],
                              row["LastName"], row["Department"]);
        Console.WriteLine("===+=============+===============+=================\n");

        Console.WriteLine("===+===================");
        Console.WriteLine("ID | Employment Status");
        Console.WriteLine("---+-------------------");
        foreach (DataRow row in dsEmployment.Tables["EmploymentStatus"].Rows)
            Console.WriteLine(" {0} | {1}",
                     row["EmplStatusID"], row["EmplStatus"]);
        Console.WriteLine("===+===================");
        Console.WriteLine();
        Console.Read();
    }
}