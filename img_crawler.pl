use strict;
use LWP::Simple;
use LWP::UserAgent;

my $url = shift || die "Please provide initial source url!";
my $width = shift || die "Please provide Width of search!";
my $depth = shift || die "Please provide Depth of search!";

mkdir "web";
open(URLMAP, '>'."web\url.map") || die "Can't open web/url.map!";

my @urls;
my @depths;
my @indices;
push @urls, $url;
push @depths, 0;
push @indices, 0;

my %setOfUrls;
$setOfUrls{$url} = 0;

my $d = 0;
my $urlCount = 1;
while($d <= $depth){
	$url = shift @urls;
	$d = shift @depths;
	my $index = shift @indices;
	
	my $html = get($url);
	
	getstore($url, 'web/' . $urlCount . '_' . $d . '_' . $index . '.html');
	print URLMAP $urlCount.'_'.$d.'_'.$index."\t".$url."\n";
	print STDERR 'Getting '. $urlCount.'_'.$d.'_'.$index.': '.$url."\n";
	
	my $count = 0;
	while ($html =~ s/(http(s)?:\/\/[a-zA-Z0-9.\\\/-]+)//i && $count < $width) {
		if(!exists($setOfUrls{$1})){
			$setOfUrls{$1} = $d;
			push @urls, $1;
			push @depths, $d+1;
			push @indices, $count++;
		}
	}
	
	++$urlCount;
	#print "---------------------\n";
	#for(my $i = 0; $i < $#urls; ++$i){
	#	print $depths[$i] . ' ' . $indices[$i] . ' ' . $urls[$i] . "\n";
	#}
	#print "----------------------\n";
}

close URLMAP;
