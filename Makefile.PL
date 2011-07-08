use inc::Module::Install;

name     'Dancer-Plugin-Thumbnail';
all_from 'lib/Dancer/Plugin/Thumbnail.pm';
author   q{Oleg A. Mamontov <oleg@mamontov.net>};
license  'perl';

perl_version '5.010';

requires 'Dancer';
requires 'File::Spec';
requires 'GD';
requires 'JSON::Any';
requires 'List::Util';
requires 'Object::Signature';
requires 'POSIX';

test_requires 'lib::abs';
test_requires 'Image::Size';
test_requires 'Test::More';

auto_install;

WriteAll;
