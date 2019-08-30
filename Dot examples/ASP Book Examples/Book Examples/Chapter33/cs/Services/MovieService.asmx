<%@ WebService Language="C#" Class="MovieService" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using System.Web.Script.Services;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[ScriptService]
public class MovieService  : System.Web.Services.WebService 
{
    [WebMethod]
    public List<Movie> SelectAll() 
    {
        MyDatabaseDataContext db = new MyDatabaseDataContext();
        return db.Movies.ToList();
    }

    [WebMethod]
    public int Insert(Movie movieToAdd)
    {
        MyDatabaseDataContext db = new MyDatabaseDataContext();
        db.Movies.InsertOnSubmit(movieToAdd);
        db.SubmitChanges();
        return movieToAdd.Id;
    }

   
}

