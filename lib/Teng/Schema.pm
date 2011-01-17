package Teng::Schema;
use strict;
use warnings;
use Teng::Row;
use Class::Accessor::Lite
    rw => [ qw(
        tables
    ) ]
;

sub new {
    my ($class, %args) = @_;
    bless {
        tables => {},
        %args,
    }, $class;
}

sub set_default_instance {
    my ($class, $instance) = @_;
    no strict 'refs';
    no warnings 'once';
    ${"$class\::DEFAULT_INSTANCE"} = $instance;
}

sub instance {
    my $class = shift;
    no strict 'refs';
    no warnings 'once';
    ${"$class\::DEFAULT_INSTANCE"};
}

sub add_table {
    my ($self, $table) = @_;
    $self->tables->{$table->name} = $table;
}

sub get_table {
    my ($self, $name) = @_;
    return unless $name;
    $self->tables->{$name};
}

sub get_row_class {
    my ($self, $table_name) = @_;

    my $table = $self->get_table($table_name);
    if ($table) {
        return $table->row_class;
    } else {
        return 'Teng::Row';
    }
}

sub camelize {
    my $s = shift;
    join('', map{ ucfirst $_ } split(/(?<=[A-Za-z])_(?=[A-Za-z])|\b/, $s));
}

1;

__END__

=head1 NAME

Teng::Schema - Schema API for Teng

=head1 METHODS

=over 4

=item $schema->add_table($table);

add Teng::Schema::Table's object.

=item my $table = $schema->get_table($table_name);

get Teng::Schema::Table's object.

=item my $row_class = $schema->get_row_class($table_name);

get your table row class or Teng::Row class.

=back

=cut
