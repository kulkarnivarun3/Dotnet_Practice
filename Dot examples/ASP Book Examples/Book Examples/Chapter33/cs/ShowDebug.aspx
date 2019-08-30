    <%@ Page Language="C#" %>
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title>Untitled Page</title>
        <style type="text/css">
            #TraceConsole
            {
                display:none;
            }
        </style>
        <!--[if IE]>
        <link rel="Stylesheet" type="text/css" href="TraceConsole.css" />               
        <![endif]-->

        <script type="text/javascript">
        
          function pageLoad() 
          {
            Sys.Debug.trace("Starting trace");
            Sys.Debug.traceDump( Sys.UI.DomEvent );
          }
        
        </script>
    </head>
    <body>
        <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server" />
        
            <textarea id="TraceConsole"></textarea>
        </div>
        </form>
    </body>
    </html>
