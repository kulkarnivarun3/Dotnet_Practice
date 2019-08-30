using System;

public class ProductConstructor
{
    public ProductConstructor(string name)
        : this(name, 0, String.Empty) { }

    public ProductConstructor(string name, decimal price)
        : this(name, price, String.Empty) { }

    public ProductConstructor(string name, decimal price, string description)
    {
        // Use name, price, and description
    }
}

