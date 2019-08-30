/// <reference name="MicrosoftAjax.js"/>

Type.registerNamespace("MyNamespace");

MyNamespace.MyClass = function()
{
  this._message = "Fantastic!";
};

MyNamespace.MyClass.prototype =
{
    sayMessage: function()
    {
        alert(this._message);
    }
};

MyNamespace.MyClass.registerClass("MyNamespace.MyClass");

if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
