#!/usr/bin/env perl

use lib::abs 'lib';
use Dancer::Test;
use Image::Size 'imgsize';
use MyApp;
use Test::More tests => 4;


my $x;

$x = do {
	local $/;
	length ( dancer_response( GET => '/compression/50/100/0' )->content );
};
# 5806
ok $x > 5790 && $x < 5820, 'none';

$x = do {
	local $/;
	length ( dancer_response( GET => '/compression/50/100/1' )->content );
};
# 4477
ok $x > 4460 && $x < 4490, 'low';

$x = do {
	local $/;
	length ( dancer_response( GET => '/compression/50/100/5' )->content );
};
# 4412
ok $x > 4400 && $x < 4430, 'medium';

$x = do {
	local $/;
	length ( dancer_response( GET => '/compression/50/100/9' )->content );
};
# 4411
ok $x > 4400 && $x < 4430, 'high';

