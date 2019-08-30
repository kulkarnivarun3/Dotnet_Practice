using System;
using System.Collections.Generic;

public class Quote
{
    private List<string> _quotes = new List<string>();

    public string GetQuote()
    {
        Random rnd = new Random();
        return _quotes[rnd.Next(_quotes.Count)];
    }

    public Quote()
    {
        _quotes.Add("All paid jobs absorb and degrade the mind -- Aristotle");
        _quotes.Add("No evil can happen to a good man, either in life or after death -- Plato");
        _quotes.Add("The only good is knowledge and the only evil is ignorance -- Plato");
    }
}
