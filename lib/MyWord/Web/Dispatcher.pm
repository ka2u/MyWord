package MyWord::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::Lite;
use MyWord::API::Store;

any '/' => sub {
    my ($c) = @_;
    $c->render('index.tt');
};

post '/account/logout' => sub {
    my ($c) = @_;
    $c->session->expire();
    $c->redirect('/');
};

any '/input' => sub {
    my ($c) = @_;
    $c->render('input.tt');
};

post '/input/store' => sub {
    my ($c) = @_;
    my $word = $c->req->param('word');
    my $itr = MyWord::API::Store->is_there($word, $c);
    my $data = undef;
    if (my $row = $itr->next) {
	$data = MyWord::API::Store->form($row);
    } else {
	my $res = MyWord::API::Store->store($word, $c);
	if (defined $res) {
	    $data = MyWord::API::Store->form($res);
	}
    }

    $c->render('input.tt', {res => $data});
};

any '/view' => sub {
    my ($c) = @_;
    my $page = 1;
    my $num = 10;
    my ($rows, $pager) = $c->db->search_with_pager(
	'words' => {}, {page => $page, rows => $num});
    my @datas;
    foreach my $row (@{$rows}) {
	push @datas, MyWord::API::Store->form($row);
    }
    $c->render('view.tt' => { words => \@datas });
};


1;
