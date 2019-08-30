<%@ Page Language="C#" MasterPageFile="~/Dynamic1.master" %>
<script runat="server">

    protected void Page_PreInit(object sender, EventArgs e)
    {
        if (Request["master"] != null)
        {
            switch (Request["master"])
            {
                case "Dynamic1":
                    Profile.MasterPageFile = "Dynamic1.master";
                    break;
                case "Dynamic2":
                    Profile.MasterPageFile = "Dynamic2.master";
                    break;
            }
        }
        
        MasterPageFile = Profile.MasterPageFile;
    }
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

