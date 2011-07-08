#!/usr/bin/env perl

use lib::abs 'lib';
use Dancer::Test;
use Image::Size 'imgsize';
use MyApp;
use Test::More tests => 5;


my $x;

$x = do {
	local $/;
	length ( dancer_response( GET => '/resize/50/100' )->content );
};
# 1393
ok $x > 1380 && $x < 1410, 'size';

is sprintf(
	'%dx%d', imgsize \dancer_response( GET => '/resize/50/100' )->content
) => '50x38',
	'default scale'
;

is sprintf(
	'%dx%d', imgsize \dancer_response( GET => '/resize/50/100/min' )->content
) => '133x100',
	'min scale'
;

response_status_is
	[ GET => '/resize/50/100/none' ] => 500,
	'invalid scale'
;

is sprintf(
	'%dx%d', imgsize \dancer_response( GET => '/sresize/50/100' )->content
) => '50x38',
	'shortcut';

