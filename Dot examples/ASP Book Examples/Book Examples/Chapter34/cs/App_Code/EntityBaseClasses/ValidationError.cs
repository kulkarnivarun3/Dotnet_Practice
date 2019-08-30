using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;

/// <summary>
/// Summary description for ValidationError
/// </summary>
public class ValidationError
{

    public string Text { get; set; }
    
    public string ErrorMessage { get; set; }

	public ValidationError(string errorMessage)
	{
        ErrorMessage = errorMessage;
	    Text = errorMessage;
	}
	
	public ValidationError(string errorMessage, string text)
	{
	    ErrorMessage = errorMessage;
	    Text = text;
	}
}
