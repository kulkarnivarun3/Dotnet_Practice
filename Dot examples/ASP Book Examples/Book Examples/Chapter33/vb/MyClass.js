/// <reference name="MicrosoftAjax.js"/>

var MyClass = function() 
{
    this._message = 'Hello World';
    this._animal = function() {alert("wow")};
};

MyClass.prototype = 
{
    get_message: function()
    {
        return this._message;
    },
    
    set_message: function(value)
    {
       this._message = value; 
    },

    sayMessage: function()
    {
        alert(this._message);
    },
    
    yellMessage: function()
    {
        alert(this._message + '!');
    }    
};

MyClass.registerClass('MyClass');

if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
