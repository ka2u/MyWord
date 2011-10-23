package MyWord::API::Auth;

use strict;
use warnings;
use Digest::SHA1 qw(sha1_hex);

sub login {
    my ($class, $id, $pass, $c) = @_;

    my $digest = sha1_hex($pass);
    my $row = $c->db->single('user', { id => $id });
    if ($row->get_column('password') == $digest) {
	return 1;
    } else {
	return undef;
    }
}

1;
