<%@ Application Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<script runat="server">

    private string _conString;
    private SqlConnection _con;
    private SqlCommand _cmdSelect;
    private SqlCommand _cmdInsert;
    
    public override void Init()
    {
        // initialize connection
        _conString = WebConfigurationManager.ConnectionStrings["Log"].ConnectionString;
        _con = new SqlConnection(_conString);
        
        // initialize select command
        _cmdSelect = new SqlCommand("SELECT COUNT(*) FROM Log WHERE Path=@Path", _con);
        _cmdSelect.Parameters.Add("@Path", SqlDbType.NVarChar, 500);
        
        // initialize insert command
        _cmdInsert = new SqlCommand("INSERT Log (Path) VALUES (@Path)", _con);
        _cmdInsert.Parameters.Add("@Path", SqlDbType.NVarChar, 500);
    } 
    
    public int NumberOfRequests
    {
        get 
        {
            int result = 0;
            _cmdSelect.Parameters["@Path"].Value = Request.AppRelativeCurrentExecutionFilePath;
            try
            {
                _con.Open();
                result = (int)_cmdSelect.ExecuteScalar();
            }
            finally
            {
                _con.Close();
            }
            return result;
        }
    }
    
    void Application_BeginRequest(object sender, EventArgs e) 
    {
        // Record new request
        _cmdInsert.Parameters["@Path"].Value = Request.AppRelativeCurrentExecutionFilePath;
        try
        {
            _con.Open();
            _cmdInsert.ExecuteNonQuery();
        }
        finally
        {
            _con.Close();
        }
    }
</script>
