#!/usr/bin/env perl

use lib::abs 'lib';
use Dancer::Test;
use Image::Size 'imgsize';
use MyApp;
use Test::More tests => 8;


my @t = (
	{
		n => 'no.1',
		u => '/multiple/1',
		t => 'image/jpeg',
		s => 1285,
		g => '100x25',
	},
	{
		n => 'no.2',
		u => '/multiple/2',
		t => 'image/png',
		s => 860,
		g => '100x4',
	},
);

#
# main
#
for ( @t ) {
	# status
	response_status_is [ GET => $_->{u} ] => 200,
		$_->{n} . ' status';

	# type
	response_headers_include [ GET => $_->{u} ] => ['Content-Type' => $_->{t}],
		$_->{n} . ' type';

	# size
	my $x = do { local $/ = length (dancer_response(GET => $_->{u})->content) };
	ok $x > $_->{s} - 10 && $x < $_->{s} + 10,
		$_->{n} . ' size' or warn $x;

	# geometry
	is sprintf( '%dx%d', imgsize \dancer_response(GET => $_->{u})->content ) =>
		$_->{g}, $_->{n} . ' geometry';
}

