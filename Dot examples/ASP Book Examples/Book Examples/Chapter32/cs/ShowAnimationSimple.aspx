<%@ Page Language="C#" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show Animation Simple</title>
    <style type="text/css">
    
    #pnl
    {
        position:absolute;
        padding:3px;
        background-color: #eeeeee;
        border:solid 1px black;
    }
    
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <asp:Panel 
            ID="pnl" 
            runat="server">
            <h3>I feel so animated!</h3>
        </asp:Panel>

        <ajax:AnimationExtender 
            ID="ae1" 
            TargetControlID="pnl"
            runat="server">
            <Animations>
            <OnLoad>
                <Sequence>
                <Move
                    Horizontal="300"
                    Vertical="300" 
                    Duration="1" 
                    Fps="20" />
                <FadeOut 
                    Duration="1" 
                    Fps="20" />   
                </Sequence>  
            </OnLoad>
            </Animations>
        </ajax:AnimationExtender>

    </div>
    </form>
</body>
</html>
