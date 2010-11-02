package MooseX::ChainedAccessors::Accessor;
use strict;
use warnings;

use base 'Moose::Meta::Method::Accessor';

our $VERSION = '0.01';

sub _inline_post_body {
return 'return $_[0] if (scalar(@_) >= 2);' . "\n";
}

1;

__END__


=head1 NAME

MooseX::ChainedAccessors::Accessor - Accessor class for chained accessors with Moose

=head1 SYNOPSIS

    package Test;
    use Moose;
    
    has => 'debug' => (
        traits => [ 'Chained' ],
        is => 'rw',
        isa => 'Bool',
    );
    
    sub complex_method
    {
        my $self = shift;
        
        #...
        
        print "helper message" if $self->debug;
        
        #...
    }
    
    
    1;

Which allows for:

    my $test = Test->new();
    $test->debug(1)->complex_method();
    
=head1 DESCRIPTION

MooseX::ChainedAccessors is a Moose Trait which allows for method chaining 
on accessors by returning $self on write/set operations. 

=head1 AUTHORS

David McLaughlin E<lt>david@dmclaughlin.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2009 David McLaughlin

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.


