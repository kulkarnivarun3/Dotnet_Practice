function copyToClipboard(e, id) 
{
    if (e.preventDefault)
        e.preventDefault();
    e.returnValue = false;
    if (window.clipboardData)            
        window.clipboardData.setData('Text', document.getElementById(id).innerText);
    else
        alert('Sorry, your browser does not support copying to the clipboard!');
}