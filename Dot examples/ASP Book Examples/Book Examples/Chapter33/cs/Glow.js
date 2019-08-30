/// <reference name="MicrosoftAjax.js"/>

Type.registerNamespace("myControls");

myControls.Glow = function(element) 
{
    myControls.Glow.initializeBase(this, [element]);

    // initialize fields
    this._text = "Glow Control";
    this._backgroundColor = "yellow";
}

myControls.Glow.prototype = 
{
    initialize: function() 
    {
        myControls.Glow.callBaseMethod(this, 'initialize');
        
        // Wire-up delegates to element events
        $addHandlers
            (
                this.get_element(), 
                {
                    mouseover: this._onMouseOver, 
                    mouseout: this._onMouseOut
                }, 
                this
            );
    },
    
    dispose: function() 
    {        
        // Unwire delegates
        $clearHandlers(this.get_element());
        myControls.Glow.callBaseMethod(this, 'dispose');
    },
    
    _onMouseOver: function()
    {
        this.get_element().style.backgroundColor = this._backgroundColor;
    },
    
    _onMouseOut: function()
    {
        this.get_element().style.backgroundColor = "";        
    },
    
    get_text: function()
    {
        return this._text;
    },
    
    set_text: function(value)
    {
        this._text = value;
        this.get_element().innerHTML = value;
    }, 
    
    get_backgroundColor: function()
    {
        return this._backgroundColor;
    },
    
    set_backgroundColor: function(value)
    {
        this._backgroundColor = value;
    }    
}
myControls.Glow.registerClass('myControls.Glow', Sys.UI.Control);

if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
