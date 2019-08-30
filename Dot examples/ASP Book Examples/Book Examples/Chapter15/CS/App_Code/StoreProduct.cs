using System;

public class StoreProduct
{
    public void SaveProduct(string name)
    {
        SaveProduct(name, 0, String.Empty);
    }

    public void SaveProduct(string name, decimal price)
    {
        SaveProduct(name, price, String.Empty);
    }

    public void SaveProduct(string name, decimal price, string description)
    {
        // Save name, price, description to database
    }

}
