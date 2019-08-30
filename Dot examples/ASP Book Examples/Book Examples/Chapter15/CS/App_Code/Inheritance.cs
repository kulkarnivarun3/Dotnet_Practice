
public class BaseProduct
{
    private decimal _price;

    public decimal Price
    {
        get { return _price; }
        set { _price = value; }
    }

}

public class ComputerProduct : BaseProduct
{
    private string _processor;

    public string Processor
    {
        get { return _processor; }
        set { _processor = value; }
    }

}

public class TelevisionProduct : BaseProduct
{

    private bool _isHDTV;

    public bool IsHDTV
    {
        get { return _isHDTV; }
        set { _isHDTV = value; }
    }

}