package Moose::Meta::Attribute::Custom::Trait::Chained;
use strict;
use warnings;

our $VERSION = '0.01';

sub register_implementation { 'MooseX::Traits::Attribute::Chained' }

1;