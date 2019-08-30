<%@ Page Language="C#" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    /// <summary>
    /// Represents an employee
    /// </summary>
    public class Employee
    {
        public string _firstName;
        public string _lastName;
        public bool _retired;

        public string FirstName
        {
            get { return _firstName; }
        }

        public string LastName
        {
            get { return _lastName; }
        }

        public bool Retired
        {
            get { return _retired; }
        }
        
        public Employee(string firstName, string lastName, bool retired)
        {
            _firstName = firstName;
            _lastName = lastName;
            _retired = retired;
        }
    }
    
    /// <summary>
    /// Load employees into DetailsView
    /// </summary>
    void Page_Load()
    {
        // Create employees collection with one employee
        Employee newEmployee = new Employee("Steve", "Walther", false);
        List<Employee> employees = new List<Employee>();
        employees.Add(newEmployee);
        
        // Bind employees to DetailsView
        dtlMovies.DataSource = employees;
        dtlMovies.DataBind();
    }
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Employee</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DetailsView
        id="dtlMovies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
