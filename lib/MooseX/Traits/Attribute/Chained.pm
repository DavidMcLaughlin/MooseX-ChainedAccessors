package MooseX::Traits::Attribute::Chained;
use Moose::Role;
use MooseX::ChainedAccessors::Accessor;

our $VERSION = '0.01';

sub accessor_metaclass { 'MooseX::ChainedAccessors::Accessor' }

no Moose::Role;
1;


__END__

=head1 NAME

MooseX::Traits::Attribute::Chained - Create method chaining attributes

=head1 SYNOPSIS

    has => 'debug' => (
        traits => [ 'Chained' ],
        is => 'rw',
        isa => 'Bool',
    );
    
=head1 DESCRIPTION

Modifies the Accessor Metaclass to use MooseX::ChainedAccessors::Accessor

=head1 AUTHORS

David McLaughlin E<lt>david@dmclaughlin.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2009 David McLaughlin

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.



