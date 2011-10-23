#!/usr/bin/env perl

use strict;
use warnings;
use Digest::SHA1 qw(sha1 sha1_hex);

my $pass = $ARGV[0];
my $digest = sha1_hex($pass);
print $digest . "\n";
