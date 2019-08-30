using System;
using System.Text;
using System.Collections.Generic;
using System.Runtime.Serialization;




/// <summary>
/// Summary description for ValidationException
/// </summary>
public class ValidationException : Exception
{
    private EntityBase _Entity;
    
    public EntityBase Entity
    {
        get { return _Entity; }
    }


    public override string Message
    {
        get
        {
            StringBuilder builder = new StringBuilder();
            builder.AppendLine(base.Message);

            if (_Entity.ValidationErrors != null)
            {
                foreach (ValidationError error in _Entity.ValidationErrors.Values)
                    builder.AppendLine("  " + error.ErrorMessage);
            }
            return builder.ToString();    
        }
    }


    public ValidationException()
        :base()
    {}


    public ValidationException(string message)
        :base(message)
    {}



    public ValidationException(string message, EntityBase entity)
        : base(message)
    { 
        _Entity = entity;
    }



    public ValidationException(string message, Exception innerException)
        : base(message, innerException)
    { }



    public ValidationException(SerializationInfo info, StreamingContext context)
        : base(info, context)
    { }

}
