/// <summary>
/// Represents an employee of Acme.com
/// </summary>
public class Employee
{
    private string _firstName;
    private string _lastName;

    /// <summary>
    /// The employee first name
    /// </summary>
    public string FirstName
    {
        get { return _firstName; }
    }

    /// <summary>
    /// The employee last name
    /// </summary>
    public string LastName
    {
        get { return _lastName; }
    }


    /// <summary>
    /// Returns an employee from the database
    /// </summary>
    /// <param name="id">The unique employee identifier</param>
    /// <returns>An instance of the Employee class</returns>
    public static Employee getEmployee(int id)
    {
        return null;
    }

    /// <summary>
    /// Initializes an employee
    /// </summary>
    /// <param name="firstName">First Name</param>
    /// <param name="lastName">Last Name</param>
    public Employee(string firstName, string lastName)
    {
        _firstName = firstName;
        _lastName = lastName;
    }

}
