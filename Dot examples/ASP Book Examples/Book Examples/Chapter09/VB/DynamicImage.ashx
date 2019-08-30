<%@ WebHandler Language="VB" Class="DynamicImage" %>
 
Imports System.Data
Imports System.Web
Imports System.Web.Configuration
Imports System.Web.UI
Imports System.Web.UI.WebControls
 
''' <summary>
''' Displays an image corresponding to the Id passed
''' in a query string field
''' </summary>
Public Class DynamicImage
	 Implements IHttpHandler
 
    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        ' Get the Id of the image to display
        Dim imageId As String = context.Request.QueryString("Id")
 
        ' Use SqlDataSource to grab image bytes
        Dim src As SqlDataSource = New SqlDataSource()
        src.ConnectionString = WebConfigurationManager.ConnectionStrings("Images").ConnectionString
        src.SelectCommand = "SELECT Image FROM Images WHERE Id=" + imageId
 
        ' Return a DataView
        Dim view As DataView = CType(src.Select(DataSourceSelectArguments.Empty), DataView)
        context.Response.BinaryWrite(CType(view(0)("Image"), Byte()))
 
        ' Return a DataReader
        'src.DataSourceMode = SqlDataSourceMode.DataReader
        'Dim reader As IDataReader = CType(src.Select(DataSourceSelectArguments.Empty), IDataReader)
        'reader.Read()
        'context.Response.BinaryWrite(CType(reader("Image"), Byte()))
        'reader.Close()
 
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property
 
End Class
