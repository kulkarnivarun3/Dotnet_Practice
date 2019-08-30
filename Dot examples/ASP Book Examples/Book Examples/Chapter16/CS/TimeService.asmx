<%@ WebService Language="C#" Class="TimeService" %>
using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class TimeService  : System.Web.Services.WebService {

    [WebMethod]
    public DateTime GetServerTime() {
        return DateTime.Now;
    }
    
}

