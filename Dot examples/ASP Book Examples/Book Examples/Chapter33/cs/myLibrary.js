/// <reference name="MicrosoftAjax.js"/>

function sayMessage()
{
    alert("Hello World!");
}
if(typeof(Sys) !== "undefined") Sys.Application.notifyScriptLoaded();
