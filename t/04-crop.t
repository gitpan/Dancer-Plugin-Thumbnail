#!/usr/bin/env perl

use lib::abs 'lib';
use Dancer::Test;
use Image::Size 'imgsize';
use MyApp;
use Test::More tests => 6;


my $x;

$x = do {
	local $/;
	length ( dancer_response( GET => '/crop/50/100' )->content );
};
# 1451
ok $x > 1440 && $x < 1470, 'size';

is sprintf(
	'%dx%d', imgsize \dancer_response( GET => '/crop/50/100' )->content
) => '50x100',
	'geometry'
;

$x = do {
	local $/;
	length ( dancer_response( GET => '/crop/50/100/rb' )->content );
};
# 1667
ok $x > 1650 && $x < 1680, 'anchors size';

is sprintf(
	'%dx%d', imgsize \dancer_response( GET => '/crop/50/100/rb' )->content
) => '50x100',
	'anchors geometry'
;

response_status_is
	[ GET => '/resize/50/100/none' ] => 500,
	'invalid anchors'
;

is sprintf(
	'%dx%d', imgsize \dancer_response( GET => '/scrop/50/100' )->content
) => '50x100',
	'shortcut';

