package MooseX::ChainedAccessors::Accessor;
use strict;
use warnings;

use base 'Moose::Meta::Method::Accessor';

sub _generate_accessor_method_inline {
    my $self        = $_[0];
    my $attr        = $self->associated_attribute;
    my $attr_name   = $attr->name;
    my $inv         = '$_[0]';
    my $slot_access = $self->_inline_access($inv, $attr_name);
    my $value_name  = $self->_value_needs_copy ? '$val' : '$_[1]';

    $self->_eval_code('sub { ' . "\n"
    . $self->_inline_pre_body(@_) . "\n"
    . 'if (scalar(@_) >= 2) {' . "\n"
        . $self->_inline_copy_value . "\n"
        . $self->_inline_check_required . "\n"
        . $self->_inline_check_coercion($value_name) . "\n"
        . $self->_inline_check_constraint($value_name) . "\n"
        . $self->_inline_store($inv, $value_name) . "\n"
        . $self->_inline_trigger($inv, $value_name) . "\n"
        . 'return $_[0]; ' . "\n"
    . ' }' . "\n"
    . $self->_inline_check_lazy($inv) . "\n"
    . $self->_inline_post_body(@_) . "\n"
    . 'return ' . $self->_inline_auto_deref($self->_inline_get($inv)) . "\n"
    . ' }');
}

sub _generate_writer_method_inline {
    my $self        = $_[0];
    my $attr        = $self->associated_attribute;
    my $attr_name   = $attr->name;
    my $inv         = '$_[0]';
    my $slot_access = $self->_inline_get($inv, $attr_name);
    my $value_name  = $self->_value_needs_copy ? '$val' : '$_[1]';

    $self->_eval_code('sub { '
    . $self->_inline_pre_body(@_)
    . $self->_inline_copy_value
    . $self->_inline_check_required
    . $self->_inline_check_coercion($value_name)
    . $self->_inline_check_constraint($value_name)
    . $self->_inline_store($inv, $value_name)
    . $self->_inline_post_body(@_)
    . $self->_inline_trigger($inv, $value_name)
    . 'return $_[0]; ' . "\n"
    . ' }');
}

1;

__END__


=head1 NAME

MooseX::ChainedAccessors - Accessor class for chained accessors with Moose

=head1 SYNOPSIS

    has => 'debug' => (
        traits => [ 'Chained' ],
        is => 'rw',
        isa => 'Bool',
    );
    
=head1 DESCRIPTION

Returns $self on write operations via accessors.

=head1 AUTHORS

David McLaughlin E<lt>david@dmclaughlin.comE<gt>

=head1 COPYRIGHT AND LICENSE

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.


