/// <reference name="MicrosoftAjax.js"/>

Type.registerNamespace("myControls");

myControls.ClientControl = function(element) 
{
    myControls.ClientControl.initializeBase(this, [element]);
}

myControls.ClientControl.prototype = 
{
    initialize: function() 
    {
        myControls.ClientControl.callBaseMethod(this, 'initialize');    
        // Add custom initialization here
    },
    
    dispose: function() 
    {        
        //Add custom dispose actions here
        myControls.ClientControl.callBaseMethod(this, 'dispose');
    }
}
myControls.ClientControl.registerClass('myControls.ClientControl', Sys.UI.Control);

if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
