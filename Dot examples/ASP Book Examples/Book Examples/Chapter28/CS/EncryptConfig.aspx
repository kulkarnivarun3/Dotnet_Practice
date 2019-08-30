<%@ Page Language="C#" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        if (!Page.IsPostBack)
            BindSections();
    }

    protected void grdSections_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int rowIndex = Int32.Parse((string)e.CommandArgument);
        string sectionName = (string)grdSections.DataKeys[rowIndex].Value;
        if (e.CommandName == "Protect")
            ProtectSection(sectionName);
        if (e.CommandName == "UnProtect")
            UnProtectSection(sectionName);
        BindSections();
    }

    private void ProtectSection(string sectionName)
    {
        Configuration config = WebConfigurationManager.OpenWebConfiguration(Request.ApplicationPath);
        ConfigurationSection section = config.GetSection(sectionName);
        section.SectionInformation.ProtectSection("RsaProtectedConfigurationProvider");
        config.Save(ConfigurationSaveMode.Modified);
    }

    private void UnProtectSection(string sectionName)
    {
        Configuration config = WebConfigurationManager.OpenWebConfiguration(Request.ApplicationPath);
        ConfigurationSection section = config.GetSection(sectionName);
        section.SectionInformation.UnprotectSection();
        config.Save(ConfigurationSaveMode.Modified);
    }

    private void BindSections()
    {
        Configuration config = WebConfigurationManager.OpenWebConfiguration(Request.ApplicationPath);
        List<SectionInformation> colSections = new List<SectionInformation>();
        foreach (ConfigurationSection section in config.SectionGroups["system.web"].Sections)
            colSections.Add(section.SectionInformation);
        grdSections.DataSource = colSections;
        grdSections.DataBind();
    }
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Encrypt Config</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdSections"
        DataKeyNames="SectionName"
        AutoGenerateColumns="false"
        OnRowCommand="grdSections_RowCommand"
        Runat="server" >
        <Columns>
        <asp:ButtonField ButtonType="Link" Text="Protect" CommandName="Protect" />
        <asp:ButtonField ButtonType="Link" Text="UnProtect" CommandName="UnProtect" />
        <asp:CheckBoxField DataField="IsProtected" HeaderText="Protected" />
        <asp:BoundField DataField="SectionName" HeaderText="Section" />
        </Columns>
    </asp:GridView>    
    
    </div>
    </form>
</body>
</html>
