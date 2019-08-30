using System;
using System.Text;
using System.Web;
using System.IO;
using System.Globalization;

/// <summary>
/// Summary description for TraceWriter
/// </summary>
public class TraceWriter : TextWriter
{
    public override void Write(string value)
    {
        HttpContext.Current.Trace.Warn(value);
    }

    public override void Write(char[] buffer, int index, int count)
    {
        HttpContext.Current.Trace.Warn("Linq", new string(buffer, index, count));
    }

    public override Encoding Encoding
    {
        get { return Encoding.Unicode; }
    }
    
    public TraceWriter():base(CultureInfo.CurrentCulture)
    {
    }
}
