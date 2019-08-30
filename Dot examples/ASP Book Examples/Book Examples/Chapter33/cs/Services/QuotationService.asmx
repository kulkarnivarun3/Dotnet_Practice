<%@ WebService Language="C#" Class="QuotationService" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Web.Script.Services;
using System.Collections.Generic;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[ScriptService]
public class QuotationService  : System.Web.Services.WebService 
{

    [WebMethod]
    public string GetQuote() 
    {
        List<string> quotes = new List<string>();
        quotes.Add("The fool who is silent passes for wise.");
        quotes.Add("The early bird catches the worm.");
        quotes.Add("If wishes were true, shepherds would be kings.");
        Random rnd = new Random();
        return quotes[rnd.Next(quotes.Count)];
    }
    
}

