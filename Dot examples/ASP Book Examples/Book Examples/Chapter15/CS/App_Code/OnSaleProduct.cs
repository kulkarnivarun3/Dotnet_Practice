public class ProductBase
{
    private decimal _price;

    public virtual decimal Price
    {
        get { return _price; }
        set { _price = value; }
    }

}


public class OnSaleProduct : ProductBase
{

    override public decimal Price
    {
        get { return base.Price / 2; }
        set { base.Price = value; }
    }

}
