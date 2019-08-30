using System;
using System.Text.RegularExpressions;
using System.Web.Configuration;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;
using Superexpert.Controls;

/// <summary>
/// Summary description for ValidationUtility
/// </summary>
public class ValidationUtility
{
        public static bool SatisfiesRequired(object value)
        {
            if (value == null)
                return false;
                
            if (value.ToString().Trim().Length == 0)
                return false; 
                
            return true;    
        }

        public static bool SatisfiesType(object input, string typeName)
        {
            if (input == null)
                return false;
            return SatisfiesType(input.ToString(), typeName);    
        }        

        public static bool SatisfiesType(string input, string typeName)
        {
            ValidationSection config = (ValidationSection)WebConfigurationManager.GetSection("validation");
            if (config == null)
                throw new Exception("Missing validation section in web.config");
            string expression = config.ValidationTypes.Get(typeName);
            return SatisifiesExpression(input, expression);
        }


        public static bool SatisifiesExpression(string input, string expression)
        {
            if (String.IsNullOrEmpty(input))
                return true;
            return Regex.IsMatch(input, expression);
        }


        public static bool IsInRole(string roleName)
        {
            return HttpContext.Current.User.IsInRole(roleName);
        }
        
        public static bool IsUserName(string userName)
        {
            return (String.Compare(HttpContext.Current.User.Identity.Name, userName) == 0);
        }



        public static void ShowValidationErrors(Page page, Exception exception)
        {
            ValidationException valException = exception.GetBaseException() as ValidationException;
            if (valException != null)
                ShowValidationErrors(page, valException.Entity.ValidationErrors);
            
            else
                throw exception;
        }       
        
        
        public static void ShowValidationErrors(Page page, ValidationErrorCollection errors)
        {
        
            // Build map from property name to validator
            Dictionary<string, EntityValidator> validatorMap = new Dictionary<string, EntityValidator>();
            foreach (IValidator validator in page.Validators)
            {
                if (validator is EntityValidator)
                {
                    EntityValidator entityValidator = (EntityValidator)validator;
                    if (validatorMap.ContainsKey(entityValidator.PropertyName))
                        throw new Exception("Duplicate EntityValidator Property Name: " + entityValidator.PropertyName);
                    validatorMap.Add(entityValidator.PropertyName, (EntityValidator)validator);
                }
            }


            // Show validation errors
            foreach (string propertyName in errors.Keys)
            {
                ValidationError error = errors[propertyName];
                EntityValidator validator = null;
                if (validatorMap.ContainsKey(propertyName))
                {
                    validator = validatorMap[propertyName];
                }
                else
                {
                    validator = new EntityValidator();
                    page.Validators.Add(validator);
                }
                validator.IsValid = false;
                validator.ErrorMessage = error.ErrorMessage;
                validator.Text = error.Text;
            }
        
        
        }


}
