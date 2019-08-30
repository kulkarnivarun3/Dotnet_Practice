using System;
using System.Configuration;
using System.Web.Configuration;

/// <summary>
/// Summary description for ValidationSection
/// </summary>
public class ValidationSection : ConfigurationSection
{





    [ConfigurationProperty("", IsDefaultCollection=true)]
    public ValidationTypeCollection ValidationTypes
    {
        get 
        {
            return (ValidationTypeCollection)this[""]; 
        }
    
    }


	public ValidationSection()
	{
	}
}


public class ValidationTypeCollection : ConfigurationElementCollection
{



    public string Get(string typeName)
    {
        ValidationType match = (ValidationType)this.BaseGet(typeName);
        if (match == null)
            throw new Exception(String.Format("Could not find validation type {0} in web configuration file", typeName));

        return match.Expression;
    }




    protected override ConfigurationElement CreateNewElement()
    {
        return new ValidationType();
    }

    protected override object GetElementKey(ConfigurationElement element)
    {
        return ((ValidationType)element).Name;
    }
    
    public ValidationTypeCollection()
    {
    }
}


public class ValidationType : ConfigurationElement
{
    [ConfigurationProperty("name", IsRequired=true)]
    public string Name
    {
        get { return this["name"].ToString(); }
        set { this["name"] = value; }
    }

    [ConfigurationProperty("expression", IsRequired = true)]
    public string Expression
    {
        get { return this["expression"].ToString(); }
        set { this["expression"] = value; }
    }

}