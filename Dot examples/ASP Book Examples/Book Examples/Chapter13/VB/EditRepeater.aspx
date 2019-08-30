<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
     
    ' The name of the primary key column
    Dim DataKeyName As String = "Id"
 
    ''' <summary>
    ''' Stores the primary keys in ViewState
    ''' </summary>
    ReadOnly Property Keys() As Hashtable
        Get
            If IsNothing(ViewState("Keys")) Then
                ViewState("Keys") = New Hashtable()
            End If
            Return CType(ViewState("Keys"), Hashtable)
        End Get
    End Property
 
    ''' <summary>
    ''' Build the primary key collection
    ''' </summary>
    Protected Sub rptMovies_ItemDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs)
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            Keys.Add(e.Item.ItemIndex, DataBinder.Eval(e.Item.DataItem, "Id"))
        End If
    End Sub
 
    ''' <summary>
    ''' Clear the primary keys when Repeater is rebound
    ''' to its data source
    ''' </summary>
    Protected Sub rptMovies_DataBinding(ByVal sender As Object, ByVal e As EventArgs)
        Keys.Clear()
    End Sub
 
    ''' <summary>
    ''' When you click the Update,Insert, or Delete
    ''' button, this method executes
    ''' </summary>
    Protected Sub rptMovies_ItemCommand(ByVal source As Object, ByVal e As RepeaterCommandEventArgs)
        Select Case e.CommandName
            Case "Update"
                UpdateMovie(e)
                Exit Sub
            Case "Insert"
                InsertMovie(e)
                Exit Sub
            Case "Delete"
                DeleteMovie(e)
                Exit Sub
        End Select
    End Sub
 
    ''' <summary>
    ''' Update a movie record
    ''' </summary>
    Private Sub UpdateMovie(ByVal e As RepeaterCommandEventArgs)
        ' Get the form fields
        Dim txtTitle As TextBox = CType(e.Item.FindControl("txtTitle"), TextBox)
        Dim txtDirector As TextBox = CType(e.Item.FindControl("txtDirector"), TextBox)
        Dim chkInTheaters As CheckBox = CType(e.Item.FindControl("chkInTheaters"), CheckBox)
 
        ' Set the DataSource parameters
        srcMovies.UpdateParameters("Id").DefaultValue = Keys(e.Item.ItemIndex).ToString()
        srcMovies.UpdateParameters("Title").DefaultValue = txtTitle.Text
        srcMovies.UpdateParameters("Director").DefaultValue = txtDirector.Text
        srcMovies.UpdateParameters("InTheaters").DefaultValue = chkInTheaters.Checked.ToString()
 
        ' Fire the UpdateCommand
        srcMovies.Update()
    End Sub
 
    ''' <summary>
    ''' Insert a movie record
    ''' </summary>
    Private Sub InsertMovie(ByVal e As RepeaterCommandEventArgs)
        ' Get the form fields
        Dim txtTitle As TextBox = CType(e.Item.FindControl("txtTitle"), TextBox)
        Dim txtDirector As TextBox = CType(e.Item.FindControl("txtDirector"), TextBox)
        Dim chkInTheaters As CheckBox = CType(e.Item.FindControl("chkInTheaters"), CheckBox)
 
        ' Set the DataSource parameters
        srcMovies.InsertParameters("Title").DefaultValue = txtTitle.Text
        srcMovies.InsertParameters("Director").DefaultValue = txtDirector.Text
        srcMovies.InsertParameters("InTheaters").DefaultValue = chkInTheaters.Checked.ToString()
 
        ' Fire the InsertCommand
        srcMovies.Insert()
    End Sub
 
    ''' <summary>
    ''' Delete a movie record
    ''' </summary>
    Private Sub DeleteMovie(ByVal e As RepeaterCommandEventArgs)
        ' Set the DataSource parameters
        srcMovies.DeleteParameters("Id").DefaultValue = Keys(e.Item.ItemIndex).ToString()
 
        ' Fire the DeleteCommand
        srcMovies.Delete()
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
    html
    {
        background-color:silver;
    }
    .content
    {
        width:600px;
        height:400px;
        padding:10px;
        border:solid 1px black;
        background-color:white;
    }
    .movies td
    {
        text-align:center;
    }
    a
    {
        color:blue;
    }
    </style>
    <title>Edit Repeater</title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="content">

    <asp:Repeater
        id="rptMovies"
        DataSourceID="srcMovies"
        Runat="server" OnItemCommand="rptMovies_ItemCommand" OnItemDataBound="rptMovies_ItemDataBound" OnDataBinding="rptMovies_DataBinding">
        <HeaderTemplate>
        <table class="movies">
        <tr>
            <th>Title</th>
            <th>Director</th>
            <th>In Theaters</th>
        </tr>
        </HeaderTemplate>
        <ItemTemplate>
        <tr>
            <td>
            <asp:TextBox
                id="txtTitle"
                Text='<%#Eval("Title")%>'
                Runat="server" />
            </td>
            <td>
            <asp:TextBox
                id="txtDirector"
                Text='<%#Eval("Director")%>'
                Runat="server" />
            </td>
            <td>
            <asp:CheckBox
                id="chkInTheaters"
                Checked='<%#Eval("InTheaters")%>'
                Runat="server" />
            </td>
            <td>
            <asp:LinkButton
                id="lnkUpdate"
                CommandName="Update"
                Text="Update"
                Runat="server" />
            &nbsp;|&nbsp;
            <asp:LinkButton
                id="lnkDelete"
                CommandName="Delete"
                Text="Delete"
                OnClientClick="return confirm('Are you sure?');"
                Runat="server" />
            </td>
        </tr>    
        </ItemTemplate>
        <FooterTemplate>
        <tr>
            <td>
            <asp:TextBox
                id="txtTitle"
                Runat="server" />
            </td>
            <td>
            <asp:TextBox
                id="txtDirector"
                Runat="server" />
            </td>
            <td>
            <asp:CheckBox
                id="chkInTheaters"
                Runat="server" />
            </td>
            <td>
            <asp:LinkButton
                id="lnkInsert"
                CommandName="Insert"
                Text="Insert"
                Runat="server" />
            </td>
        </tr>    
        </table>
        </FooterTemplate>
    </asp:Repeater>    
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director,InTheaters 
            FROM Movies"
        UpdateCommand="UPDATE Movies SET Title=@Title,
            Director=@Director,InTheaters=@InTheaters
            WHERE Id=@Id"
        InsertCommand="INSERT Movies (Title,Director,InTheaters)
            VALUES (@Title,@Director,@InTheaters)"    
        DeleteCommand="DELETE Movies WHERE Id=@Id"
        Runat="server">
        <UpdateParameters>
            <asp:Parameter Name="Id" />
            <asp:Parameter Name="Title" />
            <asp:Parameter Name="Director" />
            <asp:Parameter Name="InTheaters" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Title" />
            <asp:Parameter Name="Director" />
            <asp:Parameter Name="InTheaters" />
        </InsertParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
    </asp:SqlDataSource>    
    
    </div>
    </form>
</body>
</html>
