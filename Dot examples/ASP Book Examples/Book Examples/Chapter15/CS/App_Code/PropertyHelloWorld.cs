using System;

public class PropertyHelloWorld
{

    private string _message;

    public string Message
    {
        get
        {
            return _message;
        }
        set
        {
            if (value.Length > 5)
                throw new Exception("Message too long!");
            _message = value;
        }
    }

    public string SayMessage()
    {
        return _message;
    }

}
