<%@ Application Language="VB" %>

<script runat="server">
        
    Private Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        Application("SessionCount") = 0
    End Sub
 
    Private Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        Application.Lock()
        Dim count As Integer = CType(Application("SessionCount"), Integer)
        Application("SessionCount") = count + 1
        Application.UnLock()
    End Sub
 
    Private Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        Application.Lock()
        Dim count As Integer = CType(Application("SessionCount"), Integer)
        Application("SessionCount") = count - 1
        Application.UnLock()
    End Sub
    
    'Public Sub Profile_OnMigrateAnonymous(ByVal sender As Object, ByVal args As ProfileMigrateEventArgs)
    '    ' Get anonymous profile
    '    Dim anonProfile As ProfileCommon = Profile.GetProfile(args.AnonymousID)
 
    '    ' Copy anonymous properties to authenticated
    '    For Each prop As SettingsProperty In ProfileBase.Properties
    '        Profile(prop.Name) = anonProfile(prop.Name)
    '    Next
 
    '    ' Kill the anonymous profile
    '    ProfileManager.DeleteProfile(args.AnonymousID)
    '    AnonymousIdentificationModule.ClearAnonymousIdentifier()
    'End Sub

 
    'Public Sub Profile_ProfileAutoSaving(ByVal s As Object, ByVal e As ProfileAutoSaveEventArgs)
    '    If Profile.ShoppingCart.HasChanged Then
    '        e.ContinueWithProfileAutoSave = True
    '    Else
    '        e.ContinueWithProfileAutoSave = False
    '    End If
    'End Sub
    
</script>
