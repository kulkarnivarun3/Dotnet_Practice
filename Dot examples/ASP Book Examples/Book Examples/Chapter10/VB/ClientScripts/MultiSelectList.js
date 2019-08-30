function multiSelectList_add(baseName)
{
    var unselectedList = document.getElementById(baseName + 'unselected');
    var selectedList = document.getElementById(baseName + 'selected');
    
    // Copy selected items
    for (var i=0;i < unselectedList.options.length;i++)
    {
        if (unselectedList.options[i].selected)
        {
            var item = unselectedList.removeChild(unselectedList.options[i]);
            selectedList.appendChild(item);
        }
    }
    
    // Prevent post
    return false;
}

function multiSelectList_remove(baseName)
{
    var unselectedList = document.getElementById(baseName + 'unselected');
    var selectedList = document.getElementById(baseName + 'selected');
    
    // Copy unselected items
    for (var i=0;i < selectedList.options.length;i++)
    {
        if (selectedList.options[i].selected)
        {
            var item = selectedList.removeChild(selectedList.options[i]);
            unselectedList.appendChild(item);
        }
    }

    // Prevent post
    return false;
}


// This function executes when the page
// is submitted. It stuffs all of the
// selected items into a hidden field
function multiSelectList_submit(baseName)
{

    var hidden = document.getElementById(baseName + 'hidden');

    var selectedList = document.getElementById(baseName + 'selected');
    
    var values = new Array();
    for (var i=0;i<selectedList.options.length;i++)
        values.push(selectedList.options[i].value);
    
    hidden.value = values.join(',');

}