package MyWord::API::Alc;

use strict;
use warnings;
use URI;
use Web::Scraper;

sub scrape {
    my ($class, $word) = @_;
    my $scraper = scraper {
	process "span.midashi", title => 'TEXT';
	process ".wordclass", wordclass => 'TEXT';
	process "ul > li > div", body => 'TEXT';
    };

    my $res = $scraper->scrape(
	URI->new("http://eow.alc.co.jp/${word}/UTF-8/?ref=sa"));
    return $res;
}

1;
