#!/usr/bin/env perl

use lib::abs 'lib';
use Dancer::Test;
use Image::Size 'imgsize';
use MyApp;
use Test::More tests => 4;


my $x;

$x = do {
	local $/;
	length ( dancer_response( GET => '/multiple/1' )->content );
};
# 1285
ok $x > 1270 && $x < 1300, 'size (1)';

is sprintf(
	'%dx%d', imgsize \dancer_response( GET => '/multiple/1' )->content
) => '100x25',
	'geometry (1)'
;

$x = do {
	local $/;
	length ( dancer_response( GET => '/multiple/2' )->content );
};
# 869
ok $x > 850 && $x < 880, 'size (2)';

is sprintf(
	'%dx%d', imgsize \dancer_response( GET => '/multiple/2' )->content
) => '100x4',
	'geometry (2)'
;

