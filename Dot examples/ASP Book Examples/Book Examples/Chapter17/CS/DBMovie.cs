using System;
using System.Text;
using Microsoft.SqlServer.Server;
using System.Data.SqlTypes;
using System.Runtime.InteropServices;
using System.IO;

[SqlUserDefinedType(Format.UserDefined, MaxByteSize = 512, IsByteOrdered = true)]
public class DBMovie : INullable, IBinarySerialize
{
    private bool _isNull;
    private string _title;
    private string _director;
    private decimal _boxOfficeTotals;

    public bool IsNull
    {
        get { return _isNull; }
    }

    public static DBMovie Null
    {
        get
        {
            DBMovie movie = new DBMovie();
            movie._isNull = true;
            return movie;
        }
    }

    public string Title
    {
        get { return _title; }
        set { _title = value; }
    }


    public string Director
    {
        get { return _director; }
        set { _director = value; }
    }

    [SqlFacet(Precision = 38, Scale = 2)]
    public decimal BoxOfficeTotals
    {
        get { return _boxOfficeTotals; }
        set { _boxOfficeTotals = value; }
    }


    [SqlMethod(OnNullCall = false)]
    public static DBMovie Parse(SqlString s)
    {
        if (s.IsNull)
            return Null;

        DBMovie movie = new DBMovie();
        string[] parts = s.Value.Split(new char[] { ',' });
        movie.Title = parts[0];
        movie.Director = parts[1];
        movie.BoxOfficeTotals = decimal.Parse(parts[2]);
        return movie;
    }

    public override string ToString()
    {
        if (this.IsNull)
            return "NULL";

        StringBuilder builder = new StringBuilder();
        builder.Append(_title);
        builder.Append(",");
        builder.Append(_director);
        builder.Append(",");
        builder.Append(_boxOfficeTotals.ToString());
        return builder.ToString();
    }

    public void Write(BinaryWriter w)
    {
        w.Write(_title);
        w.Write(_director);
        w.Write(_boxOfficeTotals);
    }

    public void Read(BinaryReader r)
    {
        _title = r.ReadString();
        _director = r.ReadString();
        _boxOfficeTotals = r.ReadDecimal();
    }

    public DBMovie()
    {
    }
}
