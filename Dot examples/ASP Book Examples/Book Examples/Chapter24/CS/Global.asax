<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {
        Application["SessionCount"] = 0;
    }

    void Session_Start(object sender, EventArgs e) 
    {
        Application.Lock();
        int count = (int)Application["SessionCount"];
        Application["SessionCount"] = count + 1;
        Application.UnLock();
    }

    void Session_End(object sender, EventArgs e) 
    {
        Application.Lock();
        int count = (int)Application["SessionCount"];
        Application["SessionCount"] = count - 1;
        Application.UnLock();
    }

    //public void Profile_OnMigrateAnonymous(object sender, ProfileMigrateEventArgs args)
    //{
    //    // Get anonymous profile
    //    ProfileCommon anonProfile = Profile.GetProfile(args.AnonymousID);

    //    // Copy anonymous properties to authenticated
    //    foreach (SettingsProperty prop in ProfileBase.Properties)
    //        Profile[prop.Name] = anonProfile[prop.Name];

    //    // Kill the anonymous profile
    //    ProfileManager.DeleteProfile(args.AnonymousID);
    //    AnonymousIdentificationModule.ClearAnonymousIdentifier();
    //}

    //public void Profile_ProfileAutoSaving(object s, ProfileAutoSaveEventArgs e)
    //{
    //    if (Profile.ShoppingCart.HasChanged)
    //        e.ContinueWithProfileAutoSave = true;
    //    else
    //        e.ContinueWithProfileAutoSave = false;
    //}
       
</script>
