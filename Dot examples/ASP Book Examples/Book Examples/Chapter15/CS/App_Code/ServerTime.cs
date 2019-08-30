using System;

public class ServerTime
{
    public string CurrentTime
    {
        get 
        {
            return DateTime.Now.ToString();
        }
    }
}
