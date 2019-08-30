function AjaxFormView_ItemInserted(error, controlID)
{
    if (error == '')
    {
        alert('Item Inserted!');
        var ajaxFormView = document.getElementById(controlID);
        var inputs = ajaxFormView.getElementsByTagName('input');
        for (var i=0;i < inputs.length;i++)
            inputs[i].value = inputs[i].defaultValue;
    }
    else
        alert( 'Error: ' + error ); 
}


function AjaxFormView_ItemUpdated(error, controlID)
{
    if (error == '')
        alert('Item Updated!');
    else
        alert( 'Error: ' + error ); 
}



function AjaxFormView_Error(error)
{
    alert( error );
}