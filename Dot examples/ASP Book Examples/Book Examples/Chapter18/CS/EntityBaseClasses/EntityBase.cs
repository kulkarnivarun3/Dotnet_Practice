using System;
using System.Web;
using System.Web.Caching;
using System.Configuration;
using System.Web.Configuration;
using System.Linq;
using System.Data.Linq;
using System.Data.Linq.Mapping;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Reflection;

/// <summary>
/// Provides the base class for all entities. Adds Select, Insert, Update, Get and
/// Delete methods to entities including support for data source paging, sorting, and caching
/// </summary>
public abstract class EntityBase
{

    private ValidationErrorCollection _ValidationErrors;


    public ValidationErrorCollection ValidationErrors
    {
        get 
        { 
            if (_ValidationErrors == null)
                _ValidationErrors = new ValidationErrorCollection();
            return _ValidationErrors; 
        }
        set 
        { 
            if (_ValidationErrors == null)
                _ValidationErrors = new ValidationErrorCollection();
            _ValidationErrors = value; 
        }
    }

    public bool IsValid 
    { 
        get
        {
            return (ValidationErrors.Count == 0);
        } 
    }


    protected void PerformValidation()
    {
        Validate();
        if (!IsValid)
            throw new ValidationException(this.ToString() + " failed validation", this);
    }


    protected abstract void Validate();
}


public abstract class EntityBase<T>:EntityBase where T: EntityBase<T>, new()
{


#region Select Methods

    /// <summary>
    /// Returns unsorted list of entity
    /// </summary>
    public  static IQueryable<T> Select()
    {
        return Table;
    }

    /// <summary>
    /// Returns cached unsorted list of entity
    /// </summary>
    public  static IEnumerable<T> SelectCached()
    {
        string key = GetCacheKey("SelectCached");
        List<T> results = (List<T>)HttpContext.Current.Cache[key];
        if (results == null)
        {
            results = Select().ToList();
            AddCache(key, results);
            HttpContext.Current.Trace.Warn("Retrieving " + typeof(T) + " records from database");
        }
        return results;
    }


    /// <summary>
    /// Returns sorted list of entity
    /// </summary>
    /// <param name="orderBy">Name of property to order by</param>
    public  static IEnumerable<T> Select(string orderBy)
    {
        if (String.IsNullOrEmpty(orderBy))
            return Select();

        return SelectDynamicSort(orderBy);
    }


    /// <summary>
    /// Returns unsorted list of paged entities
    /// </summary>
    /// <param name="startRowIndex">The starting database row</param>
    /// <param name="maximumRows">The number of rows to return</param>
    public  static IEnumerable<T> Select(int startRowIndex, int maximumRows)
    {
        if (startRowIndex == -1)
            return new List<T>() { new T() };

        return Select().Skip(startRowIndex).Take(maximumRows);
    }

    /// <summary>
    /// Returns sorted list of paged entities
    /// </summary>
    /// <param name="startRowIndex">The starting database row</param>
    /// <param name="maximumRows">The number of rows to return</param>
    /// <param name="orderBy">The property to order by</param>
    public  static IEnumerable<T> Select(int startRowIndex, int maximumRows, string orderBy)
    {
        if (startRowIndex == -1)
            return new List<T>() { new T() };

        if (String.IsNullOrEmpty(orderBy))
            return Select(startRowIndex, maximumRows);

        return SelectDynamicSort(orderBy).Skip(startRowIndex).Take(maximumRows);
    }



#endregion


#region Sort Methods

    /// <summary>
    /// Takes an expression like AuthorName DESC and breaks it
    /// into AuthorName and DESC
    /// </summary>
    /// <param name="orderBy">The full order by expression</param>
    /// <param name="orderByColumn">The name of the order by column</param>
    /// <param name="orderByDirection">The direction of the sort (asc or desc)</param>
    private static void ParseOrderBy(string orderBy, ref string orderByColumn, ref string orderByDirection)
    {
        string[] orderByParts = orderBy.Split(' ');
        orderByColumn = orderByParts[0];
        if (orderByParts.Length > 1)
            orderByDirection = orderByParts[1].ToLower();
    }


    /// <summary>
    /// Used to perform typed and dynamic order by.
    /// </summary>
    /// <param name="orderBy">The full order by expression, e.g. AuthorName DESC</param>
    private static IEnumerable<T> SelectDynamicSort(string orderBy)
    {
        // Parse order by            
        string orderByColumn = String.Empty;
        string orderByDirection = "asc";
        ParseOrderBy(orderBy, ref orderByColumn, ref orderByDirection);

        // Get sort results
        PropertyInfo prop = typeof(T).GetProperty(orderByColumn);
        switch (Type.GetTypeCode(prop.PropertyType))
        {
            case TypeCode.Boolean:
                return GetDynamicSortResults<bool>(orderByColumn, orderByDirection);
            case TypeCode.Byte:
                return GetDynamicSortResults<byte>(orderByColumn, orderByDirection);
            case TypeCode.Char:
                return GetDynamicSortResults<char>(orderByColumn, orderByDirection);
            case TypeCode.DateTime:
                return GetDynamicSortResults<DateTime>(orderByColumn, orderByDirection);
            case TypeCode.Decimal:
                return GetDynamicSortResults<Decimal>(orderByColumn, orderByDirection);
            case TypeCode.Double:
                return GetDynamicSortResults<double>(orderByColumn, orderByDirection);
            case TypeCode.Int16:
                return GetDynamicSortResults<Int16>(orderByColumn, orderByDirection);
            case TypeCode.Int32:
                return GetDynamicSortResults<Int32>(orderByColumn, orderByDirection);
            case TypeCode.Int64:
                return GetDynamicSortResults<Int64>(orderByColumn, orderByDirection);
            case TypeCode.Single:
                return GetDynamicSortResults<Single>(orderByColumn, orderByDirection);
            case TypeCode.String:
                return GetDynamicSortResults<String>(orderByColumn, orderByDirection);
            default:
                throw new Exception("Cannot sort column " + orderByColumn + " because of its type");
        }
    }


    /// <summary>
    /// Dynamically builds a Linq expression that sorts by a particular column
    /// </summary>
    /// <typeparam name="S">The return type of the Lambda</typeparam>
    /// <param name="orderByColumn">The name of the order by column</param>
    /// <param name="orderByDirection">The direction of the order by sort</param>
    private static IEnumerable<T> GetDynamicSortResults<S>(string orderByColumn, string orderByDirection)
    {
        ParameterExpression sortParameterExpression = Expression.Parameter(typeof(T), "e");
        PropertyInfo propInfo = typeof(T).GetProperty(orderByColumn);
        MemberExpression sortPropertyExpression = Expression.MakeMemberAccess(sortParameterExpression, propInfo);

        Expression<Func<T, S>> sortExpression = Expression.Lambda<Func<T, S>>(sortPropertyExpression, sortParameterExpression);

        if (orderByDirection == "asc")
            return Table.OrderBy(sortExpression);
        else
            return Table.OrderByDescending(sortExpression);
    }


#endregion



#region Select Count Methods


    /// <summary>
    /// Returns count of the records in a database
    /// </summary>
    public static int SelectCount()
    {
        return Table.Count();
    }

    /// <summary>
    /// Returns count of the records in a database 
    /// </summary>
    /// <param name="orderBy">The order by </param>
    public static int SelectCount(string orderBy)
    {
        return SelectCount();
    }



    /// <summary>
    /// Returns count of the records in a database, caching the
    /// result.
    /// </summary>
    public static int SelectCountCached()
    {
        string key = GetCacheKey("Count");
        int? count = (int?)HttpContext.Current.Cache[key];
        if (count == null)
        {
            count = SelectCount();
            AddCache(key, count);
        }
        return count.Value;
    }


    /// <summary>
    /// Returns count of records in database
    /// </summary>
    /// <param name="orderBy">The orderby parameter is ignored, but 
    /// required by ObjectDataSource control</param>
    public  static int SelectCountCached(string orderBy)
    {
        return SelectCountCached();
    }


#endregion

   
#region Get Methods   


    public static T Get(int? id)
    {
        if (id == null)
            return new T();
        
        return Table.Single(GetDynamicGet(id.Value));    
    }


    private static Expression<Func<T, bool>> GetDynamicGet(int id)
    {
        ParameterExpression e = Expression.Parameter(typeof(T), "e");
        string identityColumnName = GetIdentityColumnName();
        PropertyInfo propInfo = typeof(T).GetProperty(identityColumnName);
        MemberExpression m = Expression.MakeMemberAccess(e, propInfo);
        ConstantExpression c = Expression.Constant(id, typeof(int));
        BinaryExpression b = Expression.Equal(m, c);
        Expression<Func<T, bool>> lambda = Expression.Lambda<Func<T, bool>>(b, e);
        return lambda;
    }
   
   
   private static string GetIdentityColumnName()
   {
        return Context.Mapping.GetMetaType(typeof(T)).DBGeneratedIdentityMember.Name;
   }
   
   

#endregion


#region Save Methods

   public virtual void Save(T newEntity)
   {
       T oldEntity = (T)this;
       string identityColumnName = GetIdentityColumnName();
       if ((int)oldEntity.GetType().GetProperty(identityColumnName).GetValue(oldEntity, null) == 0)
           newEntity.Insert();
       else
           oldEntity.Update(newEntity);
   }


    public static T Save(T oldEntity, T newEntity)
    {
        oldEntity.Save(newEntity);
        return newEntity;
    }

#endregion


#region Insert Methods


    public virtual void Insert()
    {
        this.PerformValidation();
        Table.InsertOnSubmit((T)this);
        Context.SubmitChanges();
        ClearCache();

        if (this == null)
            throw new Exception(String.Format("Could not insert {0}", typeof(T)));
    }

    public static T Insert(T entityToInsert)
    {
        entityToInsert.Insert();
        return entityToInsert;
    }



#endregion


#region Update Methods

    public virtual void Update(T newEntity)
    {
        T oldEntity = (T)this;
        newEntity.PerformValidation();
        Table.Attach(newEntity, oldEntity);
        Context.SubmitChanges();
        ClearCache();

        if (oldEntity == null)
            throw new Exception(String.Format("Could not update {0}", typeof(T)));

        oldEntity.ValidationErrors = newEntity.ValidationErrors;
        newEntity = oldEntity;
    }


    public static T Update(T oldEntity, T newEntity)
    {
        oldEntity.Update(newEntity);
        return oldEntity;
    }



    
#endregion



#region Delete Methods


    public virtual void Delete()
    {
        T entityToDelete = (T)this;
        Table.Attach(entityToDelete);
        Table.DeleteOnSubmit(entityToDelete);
        Context.SubmitChanges();
        ClearCache();
    }


    public static T Delete(T entityToDelete)
    {
        entityToDelete.Delete();
        return entityToDelete;
    }

    
#endregion    
    


#region Cache Methods


    protected static void AddCache(string key, object value)
    {
        EnsurePrimaryCacheKey();
        string primaryKey = GetPrimaryCacheKey();
        HttpContext context = HttpContext.Current;
        CacheDependency keyDepend = new CacheDependency(null, new string[] { primaryKey });
        context.Cache.Insert(key, value, keyDepend);

    }


    private static void EnsurePrimaryCacheKey()
    {
        string primaryKey = GetPrimaryCacheKey();
        HttpContext context = HttpContext.Current;
        if (context.Cache[primaryKey] == null)
            context.Cache.Insert(primaryKey, DateTime.Now.ToString());
    }



    private static string GetPrimaryCacheKey()
    {
        return String.Format("{0}_Cache", typeof(T));
    }


    public  static string GetCacheKey(string key)
    {
        return String.Format("{0}_{1}", GetPrimaryCacheKey(), key);
    }


    public static void ClearCache()
    {
        HttpContext.Current.Cache.Remove(GetPrimaryCacheKey());
    }



#endregion




    public static Table<T> Table
    {
        get
        {
            return Context.GetTable<T>();
        }
    }



    protected static DataContext Context
    {
        get
        {
            DataContext context = (DataContext)HttpContext.Current.Items["DataContext"];
            if (context == null)
            {
                ConnectionStringSettings conSettings = WebConfigurationManager.ConnectionStrings["con"];
                if (conSettings == null)
                    throw new Exception("Missing connection string named 'con' in web configuration.");
                context = new DataContext(conSettings.ConnectionString);
                HttpContext.Current.Items["DataContext"] = context;
                context.Log = new TraceWriter();
            }   
            return context; 
        }
    }


    


}
