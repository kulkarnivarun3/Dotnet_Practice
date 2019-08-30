<%@ Page Language="VB" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show Drag Panel Extender</title>
    <style type="text/css">
    
    .pnlAdd
    {
        display: none;
        border: solid 1px black;
        background-color: #eeeeee;
    }
    
    .pnlDrag
    {
        background-color: #cccccc;
        color: White;
        cursor:move;
        padding: 3px;
    }
    
    .pnlContents
    {
        padding: 5px;    
    }
    
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:ScriptManager id="sm1" Runat="server" />
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        Runat="server" />
    
    <asp:Panel ID="pnlAdd" CssClass="pnlAdd" runat="server">
        <asp:Panel ID="pnlDrag" CssClass="pnlDrag" runat="server">
        Add New Movie        
        </asp:Panel>
        <div class="pnlContents">
        <asp:FormView 
            ID="frmMovie" 
            DataSourceID="srcMovies"
            DefaultMode="Insert"
            runat="server">
        <InsertItemTemplate>
        
        <asp:Label
            id="lblTitle"
            AssociatedControlID="txtTitle"
            Text="Title:"
            Runat="server" />
        <asp:TextBox
            id="txtTitle"
            Text='<%# Bind("Title") %>'
            Runat="server" />
        
        <br /><br />
        
        <asp:Label
            id="lblDirector"
            AssociatedControlID="txtDirector"
            Text="Director:"
            Runat="server" />
        <asp:TextBox
            id="txtDirector"
            Text='<%# Bind("Director") %>'
            Runat="server" />
       
        <br /><br />
        
        <asp:Button
            id="btnCancel"
            Text="Cancel"
            CommandName="Cancel"
            Runat="server" />
        <asp:Button
            id="btnInsert"
            Text="Insert"
            CommandName="Insert"
            Runat="server" />
        
        </InsertItemTemplate>
        </asp:FormView>
        </div>
    </asp:Panel>
    <ajax:DragPanelExtender
        id="dpe1"
        TargetControlID="pnlAdd"
        DragHandleID="pnlDrag"
        Runat="server" />    
    
    <br /><br />
    
    <a 
        href="javascript:void(0)" 
        onclick="$get('pnlAdd').style.display='block';">Add Movie</a>    
    
    
    <asp:ObjectDataSource
        id="srcMovies"
        TypeName="Movie"
        SelectMethod="Select"
        InsertMethod="Insert"
        Runat="server" />
    
    
    
    </div>
    </form>
</body>
</html>
