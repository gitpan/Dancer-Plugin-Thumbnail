#!/usr/bin/env perl

use lib::abs 'lib';
use Dancer::Test;
use Image::Size 'imgsize';
use MyApp;
use Test::More tests => 16;


my @t = (
	{
		n => 'none',
		u => '/compression/50/100/0',
		t => 'image/png',
		s => 5806,
		g => '50x38',
	},
	{
		n => 'low',
		u => '/compression/50/100/1',
		t => 'image/png',
		s => 4477,
		g => '50x38',
	},
	{
		n => 'medium',
		u => '/compression/50/100/5',
		t => 'image/png',
		s => 4412,
		g => '50x38',
	},
	{
		n => 'high',
		u => '/compression/50/100/9',
		t => 'image/png',
		s => 4411,
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

