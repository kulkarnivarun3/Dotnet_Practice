// Performs AJAX call back to server
function AjaxValidatorEvaluateIsValid(val)
{
    var value = ValidatorGetValue(val.controltovalidate);
    WebForm_DoCallback(val.id, value, AjaxValidatorResult, val, AjaxValidatorError, true); 
    return true;
}

// Called when result is returned from server
function AjaxValidatorResult(returnValue, context)
{
    if (returnValue == 'True')
        context.isvalid = true;
    else
        context.isvalid = false;
    ValidatorUpdateDisplay(context);
}

// If there is an error, show it
function AjaxValidatorError(message)
{
    alert('Error: ' + message);
}