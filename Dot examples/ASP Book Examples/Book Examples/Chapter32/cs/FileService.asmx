<%@ WebService Language="C#" Class="FileService" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.IO;
using System.Linq;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.Web.Script.Services.ScriptService]
public class FileService  : System.Web.Services.WebService {

    [WebMethod]
    public string[] GetSuggestions(string prefixText, int count)
    {
        DirectoryInfo dir = new DirectoryInfo("c:\\windows");
        return dir
            .GetFiles()
            .Where( f => f.Name.StartsWith(prefixText) )
            .Select( f => f.Name )
            .ToArray();
    }
    
}

