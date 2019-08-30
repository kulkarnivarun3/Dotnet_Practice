function AjaxDivView_Result(result, controlID)
{
    var control = document.getElementById(controlID);
    control.innerHTML = result;
}

function AjaxDivView_Error(error)
{
    alert( error );
}