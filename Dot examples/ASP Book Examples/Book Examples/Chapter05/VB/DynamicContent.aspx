<%@ Page Language="VB" MasterPageFile="~/Dynamic1.master" %>
<script runat="server">
 
    Protected  Sub Page_PreInit(ByVal sender As Object, ByVal e As EventArgs)
        If Not Request("master") Is Nothing Then
            Select Case Request("master")
                Case "Dynamic1"
                    Profile.MasterPageFile = "Dynamic1.master"
                Case "Dynamic2"
                    Profile.MasterPageFile = "Dynamic2.master"
            End Select
        End If
 
        MasterPageFile = Profile.MasterPageFile
    End Sub
</script>

<asp:Content 
    ID="Content1" 
    ContentPlaceHolderID="ContentPlaceHolder1" 
    Runat="Server">

    Select a Master Page:
    <ul class="selectMaster">
        <li>
        <a href="DynamicContent.aspx?master=Dynamic1">Dynamic Master 1</a>
        </li>
        <li>
        <a href="DynamicContent.aspx?master=Dynamic2">Dynamic Master 2</a>
        </li>
    </ul>        
           
</asp:Content>

