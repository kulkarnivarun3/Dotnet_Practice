/// <reference name="MicrosoftAjax.js"/>

Type.registerNamespace("myControls");

myControls.HelpBehavior = function(element) 
{
    myControls.HelpBehavior.initializeBase(this, [element]);

    // Initialize fields
    this._text = "Help Text...";
    this._helpBox = null;

}

myControls.HelpBehavior.prototype = 
{
    initialize: function() 
    {
        myControls.HelpBehavior.callBaseMethod(this, 'initialize');
        
        // Initialize help box
        this._initializeHelpBox();
       
        // Wire-up delegates
        $addHandlers
            (
                this.get_element(), 
                {
                    focus: this._onFocus, 
                    blur: this._onBlur
                },
                this
            );
    },
    
    _initializeHelpBox: function()
    {
        // Create div element for help box
        this._helpBox = document.createElement("DIV");
        
        // Hard code a bunch of inline styles
        this._helpBox.style.display = "none";
        this._helpBox.style.position = "absolute";
        this._helpBox.style.width = "100px";
        this._helpBox.style.backgroundColor = "lightyellow";
        this._helpBox.style.border = "solid 1px black";
        this._helpBox.style.padding = "4px";
        this._helpBox.style.fontSize = "small";
        this._helpBox.innerHTML = this._text;
        
        // Position box right below input element
        var bounds = Sys.UI.DomElement.getBounds(this.get_element());
        Sys.UI.DomElement.setLocation(this._helpBox, bounds.x, bounds.y + bounds.height);
        
        // Append box to body
        document.body.appendChild(this._helpBox);           
    },
    
    dispose: function() 
    {        
        $clearHandlers(this.get_element());
        myControls.HelpBehavior.callBaseMethod(this, 'dispose');
    },
    
    _onFocus: function()
    {
        this._helpBox.style.display = "";
    },
    
    _onBlur: function()
    {
        this._helpBox.style.display = "none";
    },
    
    get_text: function()
    {
        return this._text;
    },
    
    set_text: function(value)
    {
        this._text = value;
    }
    
    
}
myControls.HelpBehavior.registerClass('myControls.HelpBehavior', Sys.UI.Behavior);

if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
