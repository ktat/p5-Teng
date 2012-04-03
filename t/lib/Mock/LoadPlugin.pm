package Mock::LoadPlugin;
use strict;
use parent qw/Teng/;

__PACKAGE__->load_plugin('ArgsTest');
__PACKAGE__->load_plugin('ArgsTest',
			 {
			  alias => {test_class => 'args_test_class', test_args => 'args_test_args'},
			  opt1 => 'a',
			  opt2 => 'b'
			 });

sub setup_test_db {
    my $teng = shift;

    my $dbd = $teng->{driver_name};
    if ($dbd eq 'SQLite') {
        $teng->do(q{
            CREATE TABLE mock_inflate (
                id   INT,
                name TEXT,
                foo  TEXT
            )
        });
    } elsif ($dbd eq 'mysql') {
        $teng->do(
            q{DROP TABLE IF EXISTS mock_inflate}
        );
        $teng->do(q{
            CREATE TABLE mock_inflate (
                id        INT auto_increment,
                name      TEXT,
                foo       TEXT,
                PRIMARY KEY  (id)
            ) ENGINE=InnoDB
        });
    } else {
        die 'unknown DBD';
    }
}

1;

