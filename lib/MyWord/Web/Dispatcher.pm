package MyWord::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::Lite;
use MyWord::API::Store;
use MyWord::API::Auth;

any '/' => sub {
    my ($c) = @_;
    $c->render('index.tt');
};

any '/account' => sub {
    my ($c) = @_;
    $c->render('login.tt');
};

post '/account/login' => sub {
    my ($c) = @_;
    my $id = $c->req->param('id');
    my $pass = $c->req->param('password');
    my $res = MyWord::API::Auth->login($id, $pass, $c);
    if (defined $res) {
	$c->session->set(login => $res);
	$c->redirect('/input');
    } else {
	$c->render('login.tt', {mess => "login failed."});
    }
};

any '/account/logout' => sub {
    my ($c) = @_;
    $c->session->expire();
    $c->redirect('/account');
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
    my $page = $c->req->param('page');
    my ($pager, @datas) = wordlist($c, $page);
    $c->render('view.tt' => { words => \@datas, pager => $pager });
};

any '/delete' => sub {
    my ($c) = @_;
    my $word = $c->req->param('word');
    MyWord::API::Store->delete($word, $c);
    my ($pager, @datas) = wordlist($c);
    $c->render('view.tt' => { words => \@datas, pager => $pager });
};

sub wordlist {
    my ($c, $page) = @_;
    $page = $page || 1;
    my $num = 10;
    my ($rows, $pager) = $c->db->search_with_pager(
	'words' => {}, {page => $page, rows => $num});
    my @datas;
    foreach my $row (@{$rows}) {
	push @datas, MyWord::API::Store->form($row);
    }
    return ($pager, @datas);
}


1;
