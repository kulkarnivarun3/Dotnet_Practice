public interface IProduct
{
    decimal Price
    {
        get;
    }

    void SaveProduct();
}


public class MusicProduct : IProduct
{
    public decimal Price
    {
        get { return 12.99m; }
    }

    public void SaveProduct()
    {
        // Save Music Product
    }
}


public class BookProduct : IProduct
{
    public decimal Price
    {
        get { return 23.99m; }
    }

    public void SaveProduct()
    {
        // Save Book Product
    }
}