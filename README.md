Open Source Development Lab
Perl

Web Crawler
14BCE033 [Bonny Haveliwala]
14BCE038 [Bhavin Jobanputra]

Abstract:

Web crawlers are very common on the internet. In fact, it is one of the reasons why google is so successful in searching queries on the internet. 
Basically a web crawler crawls the web directories such as websites to collect data for specific usage. Google’s web crawler, known as ‘Spider’, looks for the terms which defines that web site uniquely or most appropriately so that whenever a query is fired by someone, it can show relevant results accurately. 
Inspired by such thing, we designed a web crawler in perl which upon giving a source url and depth and width of the search space, it downloads all the web pages as well as all the images from those web pages. 
Crawling would be essentially what Google, Yahoo, MSN, etc. do, looking for ANY information. Scraping is generally targeted at certain websites, for specific data, e.g. for price comparison, so are coded quite differently.
Perl is a scripting language which is very efficient in terms of string processing. 

Project Flow:

Here, to design this, we’ve used Perl Strawberry. Following is the algorithm.

1) Input : SourceURL, Width and Depth of search space.
2) Fetch the SourceURL & insert it into SetofURL.
3) While Depth is greater than 0
Take the first URL from the SetofURL. Let it be, CurrentURL.
Extract & store all the images from the CurrentURL.
For i = 1 up to Width
Extract all the URLs from the CurrentURL and insert them to the SetofURL.
Store the CurrentURL to a file.
Decrease Depth by 1
4) Exit.

Functions and Features of Perl Used:
Along with that, we’ve used build-in library ‘LWP:Simple’ to interact with web and REGEX to extract further URLs from the page.
Methods Used:
1) get(URL) : Fetches the URL into memory or variable.
2) getstore(URL, path) : Stores the URL to the specified path.
3) substr String, initIdx, count : Substrings the provided String from starting the index initIdx and length of count.
4) s/REGEX/REPLACEMENT : substitutes the REPLACEMENT wherever the REGEX is matched.
5) Print : prints to the output.
6) Shift : pops the first element of array. 

Conclusion:

By doing this project, we could learn and understand the basic concepts of Perl. Before this project, we did not have any prior knowledge of Perl. This project helped us in learning, implementing and using the basic features and few of the advanced features such as LWP library of Perl programming language. We learnt the basic features such as loops, control statements and various in-built functions available in Perl. 
