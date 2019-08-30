<%@ Page Language="VB" ValidateRequest="false" %>
<%@ Import Namespace="System.Data" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
    
    Private schedule As New DataView()

    Sub Page_Load()
        If calSchedule.SelectedDate = DateTime.MinValue Then
            calSchedule.SelectedDate = calSchedule.TodaysDate
        End If
    End Sub

    Sub Page_PreRender()
        schedule = CType(srcCalendar.Select(DataSourceSelectArguments.Empty), DataView)
        schedule.Sort = "EntryDate"
    End Sub
    
    Sub calSchedule_DayRender(ByVal sender As Object, ByVal e As DayRenderEventArgs)
        If schedule.FindRows(e.Day.Date).Length > 0 Then
            e.Cell.BackColor = System.Drawing.Color.Yellow
        End If
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Calendar Database</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Calendar
        id="calSchedule"
        OnDayRender="calSchedule_DayRender"
        Runat="server" />
    
    <br />

    <asp:FormView
        id="frmSchedule"
        AllowPaging="True"
        DataKeyNames="EntryDate"
        DataSourceID="srcSchedule"
        Runat="server">
        <EmptyDataTemplate>
        <asp:LinkButton
            id="btnNew"
            Text="Add Entry"
            CommandName="New"
            Runat="server" />
        </EmptyDataTemplate>
        <ItemTemplate>
        <h1><%# Eval("EntryDate", "{0:D}") %></h1>
        <%# Eval("Entry") %>
        <br /><br />
        <asp:LinkButton
            Id="btnEdit"
            Text="Edit Entry"
            CommandName="Edit"
            Runat="server" />
        <asp:LinkButton
            Id="lnkDelete"
            Text="Delete Entry"
            CommandName="Delete"
            OnClientClick="return confirm('Delete entry?');"
            Runat="server" />
        </ItemTemplate>
        <EditItemTemplate>
        <asp:Label
            id="lblEntry"
            Text="Entry:"
            AssociatedControlID="txtEntry"
            Runat="server" />
        <br />    
        <asp:TextBox
            id="txtEntry"
            Text='<%#Bind("Entry") %>'
            TextMode="MultiLine"
            Columns="40"
            Rows="8"
            Runat="server" />
        <br />
        <asp:LinkButton
            id="btnUpdate"
            Text="Update"
            CommandName="Update"
            Runat="server" />
        </EditItemTemplate>
        <InsertItemTemplate>
        <asp:Label
            id="lblEntry"
            Text="Entry:"
            AssociatedControlID="txtEntry"
            Runat="server" />
        <br />    
        <asp:TextBox
            id="txtEntry"
            Text='<%#Bind("Entry") %>'
            TextMode="MultiLine"
            Columns="40"
            Rows="8"
            Runat="server" />
        <br />
        <asp:Button
            id="btnInsert"
            Text="Insert"
            CommandName="Insert"
            Runat="server" />
        </InsertItemTemplate>
    </asp:FormView>

    <asp:SqlDataSource
        id="srcSchedule"
        ConnectionString="Server=.\SQLExpress;Integrated Security=True;
            AttachDbFileName=|DataDirectory|ScheduleDB.mdf;User Instance=True"
        SelectCommand="SELECT EntryDate,Entry FROM Schedule WHERE EntryDate=@EntryDate"
        InsertCommand="INSERT Schedule (EntryDate,Entry) VALUES (@EntryDate,@Entry)"
        UpdateCommand="UPDATE Schedule SET Entry=@Entry WHERE EntryDate=@EntryDate"
        DELETECommand="DELETE Schedule WHERE EntryDate=@EntryDate"
        Runat="server">
        <SelectParameters>
        <asp:ControlParameter 
            Name="EntryDate"
            ControlID="calSchedule"
            PropertyName="SelectedDate" />
        </SelectParameters>
        <InsertParameters>
        <asp:ControlParameter 
            Name="EntryDate"
            ControlID="calSchedule"
            PropertyName="SelectedDate" />        
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource
        id="srcCalendar"
        ConnectionString="Server=.\SQLExpress;Integrated Security=True;
            AttachDbFileName=|DataDirectory|ScheduleDB.mdf;User Instance=True"
        SelectCommand="SELECT EntryDate FROM Schedule"
        Runat="server">
    </asp:SqlDataSource>

    </div>
    </form>
</body>
</html>
