public class AutomaticProperties
{
    // Automatic Properties

    public int Id { get; set; }

    public string Description { get; set; }


    // Normal Property

    private decimal _Price;

    public decimal Price
    {
        get { return _Price; }
        set { _Price = value; }
    }
}
