#!/usr/bin/env perl

use lib::abs 'lib';
use Dancer::Test;
use Image::Size 'imgsize';
use MyApp;
use Test::More tests => 16;


my @t = (
	{
		n => 'auto',
		u => '/format/50/100/auto',
		t => 'image/jpeg',
		s => 1393,
		g => '50x38',
	},
	{
		n => 'jpeg',
		u => '/format/50/100/jpeg',
		t => 'image/jpeg',
		s => 1393,
		g => '50x38',
	},
	{
		n => 'png',
		u => '/format/50/100/png',
		t => 'image/png',
		s => 4411,
		g => '50x38',
	},
	{
		n => 'gif',
		u => '/format/50/100/gif',
		t => 'image/gif',
		s => 2775,
		g => '50x38',
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

