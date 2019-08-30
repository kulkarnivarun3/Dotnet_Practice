<%@ Application Language="VB" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<script runat="server">
    Private _conString As String
    Private _con As SqlConnection
    Private _cmdSelect As SqlCommand
    Private _cmdInsert As SqlCommand
 
    Public Overrides  Sub Init()
        ' initialize connection
        _conString = WebConfigurationManager.ConnectionStrings("Log").ConnectionString
        _con = New SqlConnection(_conString)
 
        ' initialize select command
        _cmdSelect = New SqlCommand("SELECT COUNT(*) FROM Log WHERE Path=@Path", _con)
        _cmdSelect.Parameters.Add("@Path", SqlDbType.NVarChar, 500)
 
        ' initialize insert command
        _cmdInsert = New SqlCommand("INSERT Log (Path) VALUES (@Path)", _con)
        _cmdInsert.Parameters.Add("@Path", SqlDbType.NVarChar, 500)
    End Sub
 
    Public ReadOnly Property NumberOfRequests() As Integer
    	Get 
            Dim result As Integer =  0 
            _cmdSelect.Parameters("@Path").Value = Request.AppRelativeCurrentExecutionFilePath
            Try
                _con.Open()
                result = CType(_cmdSelect.ExecuteScalar(), Integer)
            Finally
                _con.Close()
            End Try
            Return result
    	End Get
    End Property
 
    Private  Sub Application_BeginRequest(ByVal sender As Object, ByVal e As EventArgs)
        ' Record new request
        _cmdInsert.Parameters("@Path").Value = Request.AppRelativeCurrentExecutionFilePath
        Try
            _con.Open()
            _cmdInsert.ExecuteNonQuery()
        Finally
            _con.Close()
        End Try
    End Sub
</script>
