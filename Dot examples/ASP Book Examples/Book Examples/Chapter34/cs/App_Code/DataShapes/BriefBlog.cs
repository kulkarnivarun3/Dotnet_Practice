using System;

/// <summary>
/// Summary description for BriefBlog
/// </summary>
public class BriefBlog
{
    public int Id { get; set; }

    public string Title { get; set; }

    public string AuthorUserName { get; set; }

    public string IntroductionText { get; set; }

    public DateTime DateCreated { get; set; }

    public string FirstName { get; set; }

    public string LastName { get; set; }

    public int CommentCount { get; set; }

    public bool IsPinned { get; set; }

    public byte[] Version { get; set; }
    
	public BriefBlog()
	{
	}
}
