<%@ Page Language="VB" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Show Animation Composite</title>
    <style type="text/css">
    
    #pnl
    {
        display:none;
        position:absolute;
        width:1px;
        height:1px;
        left:200px;
        top:200px;
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

        <asp:Button
            id="btn"
            Text="Play"
            OnClientClick="return false;"
            Runat="server" />

        <asp:Panel 
            ID="pnl" 
            runat="server">
            <h3>I feel so animated!</h3>
        </asp:Panel>

        <ajax:AnimationExtender 
            ID="ae1" 
            TargetControlID="btn"
            runat="server">
            <Animations>
            <OnClick>
              <Sequence AnimationTarget="pnl">
                <EnableAction
                    AnimationTarget="btn"
                    Enabled="false" />
                <StyleAction 
                    Attribute="display" 
                    Value="block"/>
                <Parallel>
                <FadeIn 
                    Duration="1" 
                    Fps="20" />
                <Scale
                    Duration="1"
                    Fps="20"
                    ScaleFactor="30.0" 
                    Center="true" />       
                </Parallel>
              </Sequence>  
            </OnClick>
            </Animations>
        </ajax:AnimationExtender>

    </div>
    </form>
</body>
</html>
