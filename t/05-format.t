#!/usr/bin/env perl

use lib::abs 'lib';
use Dancer::Test;
use Image::Size 'imgsize';
use MyApp;
use Test::More tests => 8;


my $x;

response_headers_include
	[ GET => '/format/50/100/auto' ] => [ 'Content-Type' => 'image/jpeg' ],
	'type (auto)'
;

$x = do {
	local $/;
	length ( dancer_response( GET => '/format/50/100/auto' )->content );
};
# 1393
ok $x > 1380 && $x < 1410, 'size (auto)';

response_headers_include
	[ GET => '/format/50/100/jpeg' ] => [ 'Content-Type' => 'image/jpeg' ],
	'type (jpeg)'
;

$x = do {
	local $/;
	length ( dancer_response( GET => '/format/50/100/jpeg' )->content );
};
# 1393
ok $x > 1380 && $x < 1410, 'size (jpeg)';

response_headers_include
	[ GET => '/format/50/100/png' ] => [ 'Content-Type' => 'image/png' ],
	'type (png)'
;

$x = do {
	local $/;
	length ( dancer_response( GET => '/format/50/100/png' )->content );
};
# 4411
ok $x > 4400 && $x < 4430, 'size (png)';

response_headers_include
	[ GET => '/format/50/100/gif' ] => [ 'Content-Type' => 'image/gif' ],
	'type (gif)'
;

$x = do {
	local $/;
	length ( dancer_response( GET => '/format/50/100/gif' )->content );
};
# 2775
ok $x > 2760 && $x < 2790, 'size (gif)';

