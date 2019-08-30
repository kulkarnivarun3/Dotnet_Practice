<%@ Page Language="VB" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
 
    Private Sub Page_Load()
        If Not Page.IsPostBack Then
            BindSections()
        End If
    End Sub
 
    Protected Sub grdSections_RowCommand(ByVal sender As Object, ByVal e As GridViewCommandEventArgs)
        Dim rowIndex As Integer = Int32.Parse(CType(e.CommandArgument, String))
        Dim sectionName As String = CType(grdSections.DataKeys(rowIndex).Value, String)
        If e.CommandName = "Protect" Then
            ProtectSection(sectionName)
        End If
        If e.CommandName = "UnProtect" Then
            UnProtectSection(sectionName)
        End If
        BindSections()
    End Sub
 
    Private Sub ProtectSection(ByVal sectionName As String)
        Dim config As Configuration = WebConfigurationManager.OpenWebConfiguration(Request.ApplicationPath)
        Dim section As ConfigurationSection = config.GetSection(sectionName)
        section.SectionInformation.ProtectSection("RsaProtectedConfigurationProvider")
        config.Save(ConfigurationSaveMode.Modified)
    End Sub
 
    Private Sub UnProtectSection(ByVal sectionName As String)
        Dim config As Configuration = WebConfigurationManager.OpenWebConfiguration(Request.ApplicationPath)
        Dim section As ConfigurationSection = config.GetSection(sectionName)
        section.SectionInformation.UnprotectSection()
        config.Save(ConfigurationSaveMode.Modified)
    End Sub
 
    Private Sub BindSections()
        Dim config As Configuration = WebConfigurationManager.OpenWebConfiguration(Request.ApplicationPath)
        Dim colSections As New List(Of SectionInformation)()
        For Each section As ConfigurationSection In config.SectionGroups("system.web").Sections
            colSections.Add(section.SectionInformation)
        Next
        grdSections.DataSource = colSections
        grdSections.DataBind()
    End Sub
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
