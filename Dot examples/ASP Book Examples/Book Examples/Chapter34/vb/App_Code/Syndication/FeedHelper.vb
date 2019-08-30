Imports System
Imports System.Web.Configuration
Imports System.ServiceModel.Syndication


''' <summary>
''' Summary description for FeedHelper
''' </summary>
Public Class FeedHelper

    Public Shared Function GetFeed() As SyndicationFeed

        Dim config As BlogSection = CType(WebConfigurationManager.GetSection("blog"), BlogSection)
        Dim feed As SyndicationFeed = New SyndicationFeed(config.Title, config.Description, New Uri(config.Url), Blog.SelectFeed())
        feed.BaseUri = New Uri(config.Url)
        Return feed
    End Function

End Class

