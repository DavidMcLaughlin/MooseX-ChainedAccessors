#!/usr/bin/perl
use strict;
use warnings;

use Test::More tests => 5; # tmp

use_ok('Moose::Meta::Attribute::Custom::Trait::Chained');
use_ok('MooseX::ChainedAccessors::Accessor');
use_ok('MooseX::Traits::Attribute::Chained');

{
    package SimpleChained;
    use Moose;
    
    has 'regular_attr' => (
        is => 'rw',
        isa => 'Str',
        default => sub { 'hello'; },
    );
    
    has 'chained_attr' => (
        traits => ['Chained'],
        is => 'rw',
        isa => 'Bool',    
        lazy => 1,
        default => sub { 0; },
    );
    
    has 'writer_attr' => (
        traits => ['Chained'],
        is => 'rw',
        isa => 'Str',
        reader => 'get_writer_attr',
        writer => 'set_writer_attr',
    );
}


my $simple = SimpleChained->new();
is($simple->chained_attr(1)->regular_attr, 'hello', 'chained accessor attribute');
is($simple->chained_attr(0)->set_writer_attr('world')->regular_attr, 'hello', 'chained writer attribute');


