using System;
using System.Collections.Generic;


public class ValidationErrorCollection : Dictionary<string, ValidationError>
{


    public void Add(string propertyName, string errorMessage)
    {
        this[propertyName] = new ValidationError(errorMessage); 
    }


    public void Add(string propertyName, string errorMessage, string text)
    {
        this[propertyName] = new ValidationError(errorMessage, text);
    }


    /// <summary>
    /// If a property does not already have a validation error associated with it,
    /// adds a new new valiation error
    /// </summary>
    public void AddIfNotAlready(string propertyName, string errorMessage)
    {
        if (!this.ContainsKey(propertyName))
            Add(propertyName, errorMessage);
    }

    /// <summary>
    /// If a property does not already have a validation error associated with it,
    /// adds a new new valiation error
    /// </summary>
    public void AddIfNotAlready(string propertyName, string errorMessage, string text)
    {
        if (!this.ContainsKey(propertyName))
            Add(propertyName, errorMessage, text);
    }


    public ValidationErrorCollection(): base()
    {
    }


}
