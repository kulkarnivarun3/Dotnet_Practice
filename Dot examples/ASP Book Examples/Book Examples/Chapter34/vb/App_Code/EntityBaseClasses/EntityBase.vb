Imports System
Imports System.Web
Imports System.Web.Caching
Imports System.Configuration
Imports System.Web.Configuration
Imports System.Linq
Imports System.Data.Linq
Imports System.Data.Linq.Mapping
Imports System.Collections.Generic
Imports System.Linq.Expressions
Imports System.Reflection

''' <summary>
''' Provides the base class for all entities. Adds Select, Insert, Update, Get and
''' Delete methods to entities including support for data source paging, sorting, and caching
''' </summary>
Public MustInherit Class EntityBase


    Private _ValidationErrors As ValidationErrorCollection


    Public Property ValidationErrors() As ValidationErrorCollection
        Get
            If _ValidationErrors Is Nothing Then
                _ValidationErrors = New ValidationErrorCollection()
            End If
            Return _ValidationErrors
        End Get
        set 
            If _ValidationErrors Is Nothing Then
                _ValidationErrors = New ValidationErrorCollection()
            End If
            _ValidationErrors = Value
        End Set
    End Property

    Public ReadOnly Property IsValid() As Boolean
        Get
            Return ValidationErrors.Count = 0
        End Get
    End Property


    Protected Sub PerformValidation()
        Validate()
        If Not IsValid Then
            Throw New ValidationException(Me.ToString() + " failed validation", Me)
        End If
    End Sub

    Protected MustOverride Sub Validate()

end class



Public MustInherit Class EntityBase(Of T As {EntityBase(Of T), New})
    Inherits EntityBase



#Region "Select Methods"

    ''' <summary>
    ''' Returns unsorted list of entity
    ''' </summary>
    Public Shared Function [Select]() As IQueryable(Of T)
        Return Table
    End Function

    ''' <summary>
    ''' Returns cached unsorted list of entity
    ''' </summary>
    Public Shared Function SelectCached() As IEnumerable(Of T)
        Dim key As String = GetCacheKey("SelectCached")
        Dim results As List(Of T) = CType(HttpContext.Current.Cache(key), List(Of T))
        If results Is Nothing Then
            results = [Select]().ToList()
            AddCache(key, results)
            HttpContext.Current.Trace.Warn("Retrieving " & GetType(T).ToString() & " records from database")
        End If
        Return results
    End Function


    ''' <summary>
    ''' Returns sorted list of entity
    ''' </summary>
    ''' <param name="orderBy">Name of property to order by</param>
    Public Shared Function [Select](ByVal orderBy As String) As IEnumerable(Of T)
        If String.IsNullOrEmpty(orderBy) Then
            Return [Select]()
        End If
        Return SelectDynamicSort(orderBy)
    End Function


    ''' <summary>
    ''' Returns unsorted list of paged entities
    ''' </summary>
    ''' <param name="startRowIndex">The starting database row</param>
    ''' <param name="maximumRows">The number of rows to return</param>
    Public Shared Function [Select](ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As IEnumerable(Of T)
        If startRowIndex = -1 Then
            Dim result = New List(Of T)
            result.Add(New T())
            Return result
        End If
        Return [Select]().Skip(startRowIndex).Take(maximumRows)
    End Function

    ''' <summary>
    ''' Returns sorted list of paged entities
    ''' </summary>
    ''' <param name="startRowIndex">The starting database row</param>
    ''' <param name="maximumRows">The number of rows to return</param>
    ''' <param name="orderBy">The property to order by</param>
    Public Shared Function [Select](ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal orderBy As String) As IEnumerable(Of T)
        If startRowIndex = -1 Then
            Dim result = New List(Of T)
            result.Add(New T())
            Return result
        End If

        If String.IsNullOrEmpty(orderBy) Then
            Return [Select](startRowIndex, maximumRows)
        End If

        Return SelectDynamicSort(orderBy).Skip(startRowIndex).Take(maximumRows)
    End Function



#End Region



#Region "Sort Methods"

    ''' <summary>
    ''' Takes an expression like AuthorName DESC and breaks it
    ''' into AuthorName and DESC
    ''' </summary>
    ''' <param name="orderBy">The full order by expression</param>
    ''' <param name="orderByColumn">The name of the order by column</param>
    ''' <param name="orderByDirection">The direction of the sort (asc or desc)</param>
    Private Shared Sub ParseOrderBy(ByVal orderBy As String, ByRef orderByColumn As String, ByRef orderByDirection As String)
        Dim orderByParts As String() = orderBy.Split(" ")
        orderByColumn = orderByParts(0)
        If orderByParts.Length > 1 Then
            orderByDirection = orderByParts(1).ToLower()
        End If
    End Sub


    ''' <summary>
    ''' Used to perform typed and dynamic order by.
    ''' </summary>
    ''' <param name="orderBy">The full order by expression, e.g. AuthorName DESC</param>
    Private Shared Function SelectDynamicSort(ByVal orderBy As String) As IEnumerable(Of T)
        ' Parse order by            
        Dim orderByColumn As String = String.Empty
        Dim orderByDirection As String = "asc"
        ParseOrderBy(orderBy, orderByColumn, orderByDirection)

        ' Get sort results
        Dim prop As PropertyInfo = GetType(T).GetProperty(orderByColumn)
        Select Type.GetTypeCode(prop.PropertyType)
            Case TypeCode.Boolean
                Return GetDynamicSortResults(Of Boolean)(orderByColumn, orderByDirection)
            Case TypeCode.Byte
                Return GetDynamicSortResults(Of Byte)(orderByColumn, orderByDirection)
            Case TypeCode.Char
                Return GetDynamicSortResults(Of Char)(orderByColumn, orderByDirection)
            Case TypeCode.DateTime
                Return GetDynamicSortResults(Of DateTime)(orderByColumn, orderByDirection)
            Case TypeCode.Decimal
                Return GetDynamicSortResults(Of Decimal)(orderByColumn, orderByDirection)
            Case TypeCode.Double
                Return GetDynamicSortResults(Of Double)(orderByColumn, orderByDirection)
            Case TypeCode.Int16
                Return GetDynamicSortResults(Of Int16)(orderByColumn, orderByDirection)
            Case TypeCode.Int32
                Return GetDynamicSortResults(Of Int32)(orderByColumn, orderByDirection)
            Case TypeCode.Int64
                Return GetDynamicSortResults(Of Int64)(orderByColumn, orderByDirection)
            Case TypeCode.Single
                Return GetDynamicSortResults(Of Single)(orderByColumn, orderByDirection)
            Case TypeCode.String
                Return GetDynamicSortResults(Of String)(orderByColumn, orderByDirection)
            Case Else
                Throw New Exception("Cannot sort column " & orderByColumn & " because of its type")
        End Select
    End Function


    ''' <summary>
    ''' Dynamically builds a Linq expression that sorts by a particular column
    ''' </summary>
    ''' <typeparam name="S">The return type of the Lambda</typeparam>
    ''' <param name="orderByColumn">The name of the order by column</param>
    ''' <param name="orderByDirection">The direction of the order by sort</param>
    Private Shared Function GetDynamicSortResults(Of S)(ByVal orderByColumn As String, ByVal orderByDirection As String) As IEnumerable(Of T)
        Dim sortParameterExpression As ParameterExpression = Expression.Parameter(GetType(T), "e")
        Dim propInfo As PropertyInfo = GetType(T).GetProperty(orderByColumn)
        Dim sortPropertyExpression As MemberExpression = Expression.MakeMemberAccess(sortParameterExpression, propInfo)

        Dim sortExpression = Expression.Lambda(Of Func(Of T, S))(sortPropertyExpression, sortParameterExpression)

        If orderByDirection = "asc" Then
            Return Table.OrderBy(sortExpression)
        Else
            Return Table.OrderByDescending(sortExpression)
        End If
    End Function


#End Region



#Region "Select Count Methods"


    ''' <summary>
    ''' Returns count of the records in a database
    ''' </summary>
    Public Shared Function SelectCount() As Integer
        Return Table.Count()
    End Function

    ''' <summary>
    ''' Returns count of the records in a database 
    ''' </summary>
    ''' <param name="orderBy">The order by </param>
    Public Shared Function SelectCount(ByVal orderBy As String) As Integer
        Return SelectCount()
    End Function



    ''' <summary>
    ''' Returns count of the records in a database, caching the
    ''' result.
    ''' </summary>
    Public Shared Function SelectCountCached() As Integer
        Dim key As String = GetCacheKey("Count")
        Dim count As Nullable(Of Integer) = CType(HttpContext.Current.Cache(key), Nullable(Of Integer))
        If count Is Nothing Then
            count = SelectCount()
            AddCache(key, count)
        End If
        Return count.Value
    End Function


    ''' <summary>
    ''' Returns count of records in database
    ''' </summary>
    ''' <param name="orderBy">The orderby parameter is ignored, but 
    ''' required by ObjectDataSource control</param>
    Public Shared Function SelectCountCached(ByVal orderBy As String) As Integer
        Return SelectCountCached()
    End Function


#End Region


#Region "Get Methods"


    Public Shared Function [Get](ByVal id As Nullable(Of Integer)) As T
        If IsNothing(Id) Then
            Return New T()
        End If
        Return Table.Single(GetDynamicGet(id.Value))
    End Function


    Private Shared Function GetDynamicGet(ByVal id As Integer) As Expression(Of Func(Of T, Boolean))
        Dim e As ParameterExpression = Expression.Parameter(GetType(T), "e")
        Dim identityColumnName As String = GetIdentityColumnName()
        Dim propInfo As PropertyInfo = GetType(T).GetProperty(identityColumnName)
        Dim m As MemberExpression = Expression.MakeMemberAccess(e, propInfo)
        Dim c As ConstantExpression = Expression.Constant(id, GetType(Integer))
        Dim b As BinaryExpression = Expression.Equal(m, c)
        Dim lambda = Expression.Lambda(Of Func(Of T, Boolean))(b, e)
        Return lambda
    End Function


   Private Shared Function GetIdentityColumnName() As String
        Return Context.Mapping.GetMetaType(GetType(T)).DBGeneratedIdentityMember.Name
   End Function



#End Region


#Region "Save Methods"

   Public Overridable Sub Save(ByVal newEntity As T)
       Dim oldEntity As T = DirectCast(Me, T)
       Dim identityColumnName As String = GetIdentityColumnName()
       If oldEntity.GetType().GetProperty(identityColumnName).GetValue(oldEntity, Nothing) = 0 Then
           newEntity.Insert()
       Else
           oldEntity.Update(newEntity)
        End If
   End Sub


    Public Shared Function Save(ByVal oldEntity As T, ByVal newEntity As T) As T
        oldEntity.Save(newEntity)
        Return newEntity
    End Function

#End Region


#Region "Insert Methods"


    Public Overridable Sub Insert()
        Me.PerformValidation()
        Table.InsertOnSubmit(DirectCast(Me, T))
        Context.SubmitChanges()
        ClearCache()
        If (IsNothing(Me)) Then
            Throw New Exception(String.Format("Could not insert {0}", GetType(T)))
        End If
    End Sub

    Public Shared Function Insert(ByVal entityToInsert As T) As T
        entityToInsert.Insert()
        Return entityToInsert
    End Function



#End Region


#Region "Update Methods"

    Public Overridable Sub Update(ByVal newEntity As T)
        Dim oldEntity As T = DirectCast(Me, T)
        newEntity.PerformValidation()
        Table.Attach(newEntity, oldEntity)
        Context.SubmitChanges()
        ClearCache()

        If IsNothing(oldEntity) Then
            Throw New Exception(String.Format("Could not update {0}", GetType(T)))
        End If

        oldEntity.ValidationErrors = newEntity.ValidationErrors
        newEntity = oldEntity
    End Sub


    Public Shared Function Update(ByVal oldEntity As T, ByVal newEntity As T) As T
        oldEntity.Update(newEntity)
        Return oldEntity
    End Function



#End Region



#Region "Delete Methods"


    Public Overridable Sub Delete()
        Dim entityToDelete As T = DirectCast(Me, T)
        Table.Attach(entityToDelete)
        Table.DeleteOnSubmit(entityToDelete)
        Context.SubmitChanges()
        ClearCache()
    End Sub


    Public Shared Function Delete(ByVal entityToDelete As T) As T
        entityToDelete.Delete()
        Return entityToDelete
    End Function


#End Region



#Region "Cache Methods"


    Protected Shared Sub AddCache(ByVal key As String, ByVal value As Object)
        EnsurePrimaryCacheKey()
        Dim primaryKey As String = GetPrimaryCacheKey()
        Dim context As HttpContext = HttpContext.Current
        Dim keyDepend As New CacheDependency(Nothing, New String() {primaryKey})
        context.Cache.Insert(key, value, keyDepend)
    End Sub


    Private Shared Sub EnsurePrimaryCacheKey()
        Dim primaryKey As String = GetPrimaryCacheKey()
        Dim context As HttpContext = HttpContext.Current
        If IsNothing(context.Cache(primaryKey)) Then
            context.Cache.Insert(primaryKey, DateTime.Now.ToString())
        End If
    End Sub



    Private Shared Function GetPrimaryCacheKey() As String
        Return String.Format("{0}_Cache", GetType(T))
    End Function


    Public Shared Function GetCacheKey(ByVal key As String) As String
        Return String.Format("{0}_{1}", GetPrimaryCacheKey(), key)
    End Function


    Public Shared Sub ClearCache()
        HttpContext.Current.Cache.Remove(GetPrimaryCacheKey())
    End Sub



#End Region




    Public Shared ReadOnly Property Table() As Table(Of T)
        Get
            Return Context.GetTable(Of T)()
        End Get
    End Property



    Protected Shared ReadOnly Property Context() As DataContext
        Get
            Dim myContext As DataContext = DirectCast(HttpContext.Current.Items("DataContext"), DataContext)
            If IsNothing(myContext) Then
                Dim conSettings As ConnectionStringSettings = WebConfigurationManager.ConnectionStrings("con")
                If IsNothing(conSettings) Then
                    Throw New Exception("Missing connection string named 'con' in web configuration.")
                End If
                myContext = New DataContext(conSettings.ConnectionString)
                HttpContext.Current.Items("DataContext") = myContext
                myContext.Log = New TraceWriter()
            End If
            Return myContext
        End Get
    End Property





End Class

