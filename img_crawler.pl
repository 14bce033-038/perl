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
my @images;
push @urls, $url;
push @depths, 0;
push @indices, 0;

my %setOfUrls;
$setOfUrls{$url} = 0;

my $d = 0;
my $urlCount = 1;
my $origUrl = $url;
while($d <= $depth){
	$url = shift @urls;
	$d = shift @depths;
	my $index = shift @indices;
	
	my $html = get($url);
	
	while ($html =~ s/((http(s)?:\/\/)[a-zA-Z0-9.\-\=\_\\\/\?&]+(.jpg|.png|.gif))//i){
		my $ext = substr $1, -4;
		my $pre = substr $1, 0, 4;
		my $name = substr $1, rindex($1, '/')+1;
		#print STDERR $1 . " " . $ext . " " . $pre . "\n";
		if($pre != "http"){
			getstore($origUrl. '/' . $1, 'web/images/' . $name); 
		}else{
			print STDERR $1 . "\n";
			getstore($1, 'web/images/' . $name) || die "ERRORE::";
		}
	}
	
	getstore($url, 'web/' . $urlCount . '_' . $d . '_' . $index . '.html');
	print URLMAP $urlCount.'_'.$d.'_'.$index."\t".$url."\n";
	print STDERR 'Getting '. $urlCount.'_'.$d.'_'.$index.': '.$url."\n";
	
	my $count = 0;
	while ($html =~ s/((http(s)?:\/\/)[a-zA-Z0-9.\-\=\_\\\/\?&]+)//i && $count < $width) {
		if(!exists($setOfUrls{$1})){
			$setOfUrls{$1} = $d;
			push @urls, $1;
			push @depths, $d+1;
			push @indices, $count++;
		}
	}
	
	while ($html =~ s/(href="[a-zA-Z0-9.\-\=\_\\\/\?&]+)//i && $count < $width) {
		my $newUrl = $origUrl.'/'. substr $1, 6;
		print STDERR "NEWURL -> " . $newUrl . "\n";
		if(!exists($setOfUrls{$newUrl})){
			$setOfUrls{$newUrl} = $d;
			push @urls, $newUrl;
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
