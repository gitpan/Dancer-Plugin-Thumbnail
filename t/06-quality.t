#!/usr/bin/env perl

use lib::abs 'lib';
use Dancer::Test;
use Image::Size 'imgsize';
use MyApp;
use Test::More tests => 3;


my $x;

$x = do {
	local $/;
	length ( dancer_response( GET => '/quality/50/100/25' )->content );
};
# 1012
ok $x > 1000 && $x < 1030, 'low';

$x = do {
	local $/;
	length ( dancer_response( GET => '/quality/50/100/70' )->content );
};
# 1329
ok $x > 1310 && $x < 1340, 'medium';

$x = do {
	local $/;
	length ( dancer_response( GET => '/quality/50/100/95' )->content );
};
# 2275
ok $x > 2260 && $x < 2290, 'high';

