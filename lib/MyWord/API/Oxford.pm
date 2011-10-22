package MyWord::API::Oxford;

use strict;
use warnings;
use URI;
use Web::Scraper;

sub scrape {
    my ($class, $word) = @_;
    my $scraper = scraper {
	process "#pagetitle", title => 'TEXT';
	process ".partOfSpeech", wordclass => 'TEXT';
	process ".sense-entry", body => 'TEXT';
    };

    my $res = $scraper->scrape(
	URI->new("http://oxforddictionaries.com/definition/${word}"));
    return $res;
}

1;
