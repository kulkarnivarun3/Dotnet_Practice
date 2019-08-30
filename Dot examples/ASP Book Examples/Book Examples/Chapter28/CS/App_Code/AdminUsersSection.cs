using System;
using System.Configuration;

namespace AspNetUnleashed
{
    public class AdminUsersSection : ConfigurationSection
    {
        [ConfigurationProperty("", IsDefaultCollection = true)]
        public AdminUsersCollection Users
        {
            get { return (AdminUsersCollection)this[""]; }
        }

        public AdminUsersSection()
        {
        }
    }

    public class AdminUsersCollection : ConfigurationElementCollection
    {
        protected override ConfigurationElement CreateNewElement()
        {
            return new AdminUser();
        }

        protected override object GetElementKey(ConfigurationElement element)
        {
            return ((AdminUser)element).Name;
        }

        public AdminUsersCollection()
        {
            this.AddElementName = "user";
        }
    }

    public class AdminUser : ConfigurationElement
    {
        [ConfigurationProperty("name", IsRequired = true, IsKey = true)]
        public string Name
        {
            get { return (string)this["name"]; }
            set { this["name"] = value; }
        }

        [ConfigurationProperty("password", IsRequired = true)]
        public string Password
        {
            get { return (string)this["password"]; }
            set { this["password"] = value; }
        }
    }
}