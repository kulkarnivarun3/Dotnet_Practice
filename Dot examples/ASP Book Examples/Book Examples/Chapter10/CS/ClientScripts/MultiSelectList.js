function multiSelectList_add(baseName)
{
    var unselectedList = document.getElementById(baseName + 'unselected');
    var selectedList = document.getElementById(baseName + 'selected');
    
    // Copy selected items
    var selectedItems = Array.clone(unselectedList.options);
    
    for (var i=0;i < selectedItems.length;i++)
    {
        if (selectedItems[i].selected)
        {
            var item = unselectedList.removeChild(selectedItems[i]);
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
    var selectedItems = Array.clone(selectedList.options);
    
    for (var i=0;i < selectedItems.length;i++)
    {
        if (selectedItems[i].selected)
        {
            var item = selectedList.removeChild(selectedItems[i]);
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



Array.clone = function(arrItems)
{
  var results = [];
  for (var i=0;i < arrItems.length; i++)
    results.push(arrItems[i]);
  return results;
};