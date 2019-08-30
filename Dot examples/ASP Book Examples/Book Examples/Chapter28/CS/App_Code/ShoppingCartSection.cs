using System;
using System.Configuration;

namespace AspNetUnleashed
{
    public class ShoppingCartSection : ConfigurationSection
    {
        [ConfigurationProperty("maximumItems", DefaultValue = 100, IsRequired = true)]
        public int MaximumItems
        {
            get { return (int)this["maximumItems"]; }
            set { this["maximumItems"] = value; }
        }

        [ConfigurationProperty("defaultProvider")]
        public string DefaultProvider
        {
            get { return (string)this["defaultProvider"]; }
            set { this["defaultProvider"] = value; }
        }

        [ConfigurationProperty("providers", IsDefaultCollection = false)]
        public ProviderSettingsCollection Providers
        {
            get { return (ProviderSettingsCollection)this["providers"]; }
        }

        public ShoppingCartSection(int maximumItems, string defaultProvider)
        {
            this.MaximumItems = maximumItems;
            this.DefaultProvider = defaultProvider;
        }

        public ShoppingCartSection()
        {
        }
    }
}