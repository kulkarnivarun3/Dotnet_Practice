/// <reference name="MicrosoftAjax.js"/>

function addNumbers(firstNumber, secondNumber)
{
/// <summary>Adds 2 numbers</summary>
/// <param name="firstNumber" type="Number">The first number</param>
/// <param name="secondNumber" type="Number">The second number</param>
/// <returns type="Number">The sum of numbers</returns>

    return firstNumber + secondNumber;
}

if(typeof(Sys) !== "undefined") Sys.Application.notifyScriptLoaded();
