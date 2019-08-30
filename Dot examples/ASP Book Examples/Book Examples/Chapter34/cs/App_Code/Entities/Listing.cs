using System;
using System.Linq;
using System.Data.Linq.Mapping;
using System.Collections.Generic;

public partial class Listing: EntityBase<Listing>
{
    

    public static IEnumerable<Entry> SelectByChapterId(int chapterId)
    {
        return Table
            .Where( l => l.ChapterId == chapterId )
            .OrderBy( l => l.OrderNumber )
            .Join(Entry.Table, l => l.EntryId, e => e.Id, (l, e) => e);
            
            
    }

    protected override void Validate()
    {
    }

}
