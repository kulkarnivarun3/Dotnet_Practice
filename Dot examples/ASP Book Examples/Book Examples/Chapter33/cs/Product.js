/// <reference name="MicrosoftAjax.js"/>

// Define Computer
var Computer = function() 
{
    this._price = 500.00;
};

Computer.prototype = 
{
    get_name: function()
    {
        return "Computer";
    },
    
    get_price: function()
    {
        return this._price;
    }
};

Computer.registerClass("Computer");

// Define Laptop
var Laptop = function() 
{
    Laptop.initializeBase(this);
};

Laptop.prototype = 
{
    // Overrides base method
    get_name: function()
    {
        return "Laptop";
    },
    
    // Override and extend base method
    get_price: function()
    {
        return Laptop.callBaseMethod(this, "get_price") * 2;
    }
};

Laptop.registerClass("Laptop", Computer); 

if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
