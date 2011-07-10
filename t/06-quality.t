#!/usr/bin/env perl

use lib::abs 'lib';
use Dancer::Test;
use Image::Size 'imgsize';
use MyApp;
use Test::More tests => 12;


my @t = (
	{
		n => 'low',
		u => '/quality/50/100/25',
		t => 'image/jpeg',
		s => 1012,
		g => '50x38',
	},
	{
		n => 'medium',
		u => '/quality/50/100/70',
		t => 'image/jpeg',
		s => 1329,
		g => '50x38',
	},
	{
		n => 'high',
		u => '/quality/50/100/95',
		t => 'image/jpeg',
		s => 2275,
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

