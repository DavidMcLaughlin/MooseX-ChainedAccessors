use strict;
use warnings;
use inc::Module::Install;

name 'MooseX-ChainedAccessors';
all_from 'lib/MooseX/ChainedAccessors/Accessor.pm';
requires 'Moose';

license 'Perl';

WriteAll();