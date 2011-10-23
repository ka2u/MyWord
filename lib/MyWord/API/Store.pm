package MyWord::API::Store;

use strict;
use warnings;
use MyWord::API::Alc;
use MyWord::API::Oxford;

sub store {
    my ($class, $word, $c) = @_;
    my ($alc, $oxford);
    eval {
	$alc = MyWord::API::Alc->scrape($word);
	$oxford = MyWord::API::Oxford->scrape($word);
    };
    if ($@) {
	return undef;
    } else {
	my $res = $c->db->insert('words' => {
	    word     => $word,
	    japanese => $alc->{body},
	    english  => $oxford->{body},
	});
	return $res;
    }
}

sub form {
    my ($class, $row) = @_;

    my $english = $row->get_column('english');
    # if there is number, add new line
    my @english = split /[^0-1]([2345789])[^0-1]/, $english;
    my $data = {
	word => $row->get_column('word'),
	japanese => $row->get_column('japanese'),
	english => [@english],
    };
    return $data;
}

sub is_there {
    my ($class, $word, $c) = @_;

    my $itr = $c->db->search('words', {word => $word});
    return $itr;
}

sub delete {
    my ($class, $word, $c) = @_;

    $c->db->delete('words', { word => $word });
}

1;
