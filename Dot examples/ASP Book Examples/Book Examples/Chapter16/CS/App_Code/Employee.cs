using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;

public partial class Employee
{
    public static IEnumerable<Employee> Select()
    {
        EmployeesDataContext db = new EmployeesDataContext();
        return db.Employees.OrderBy( e=>e.LastName );
    }
}
