public abstract class BaseEmployee
{
    public abstract decimal Salary
    {
        get;
    }
   

    public string Company
    {
        get { return "Acme Software"; }
    }
}

public class SalesEmployee : BaseEmployee
{
    public override decimal Salary
    {
        get { return 67000.23m; }
    }

}