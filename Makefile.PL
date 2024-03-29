use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'MyWord',
    AUTHOR        => 'Kazuhiro Shibuya <stevenlabs@gmail.com>',
    VERSION_FROM  => 'lib/MyWord.pm',
    PREREQ_PM     => {
        'Amon2'                           => '3.12',
        'Text::Xslate'                    => '1.4001',
        'Text::Xslate::Bridge::TT2Like'   => '0.00008',
    	'Test::More'                      => '0.98',
        'HTML::FillInForm::Lite'          => '1.09',
        'String::CamelCase'               => '0.02',
        'DBD::SQLite'                     => '1.33',
        'Log::Minimal'                    => '0.06',
        'Plack::Session'                  => '0.14',
        'Plack::Middleware::ReverseProxy' => '0.09',
        'Amon2::DBI'                      => '0.06',
        'Time::Piece'                     => '1.20',
        'Test::WWW::Mechanize::PSGI'      => '0',
        'JSON'                            => '2.50',
        'Plack::Middleware::Session'      => '0',
	    'Teng'                            => '0.12',
        'Web::Scraper'                    => '0.35',
        'URI'                             => '1.59',
        'Digest::SHA1'                    => '2.13',
    },
    MIN_PERL_VERSION => '5.008001',
    (-d 'xt' and $ENV{AUTOMATED_TESTING} || $ENV{RELEASE_TESTING}) ? (
        test => {
            TESTS => 't/*.t xt/*.t',
        },
    ) : (),
);
