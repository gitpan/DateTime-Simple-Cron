
use Test::More no_plan => 1;

use DateTime;
use DateTime::Format::Strptime;

BEGIN { use_ok('DateTime::Cron::Simple'); }

my $dt_format = DateTime::Format::Strptime->new(
                   pattern => '%FT%T',

);

{
my $c = DateTime::Cron::Simple->new('* * * * *');
isa_ok($c, 'DateTime::Cron::Simple');
ok($c->validate_time(), '"* * * * *" always validates');
}

# the following contains data to be tested
# in the format:
#     $cron_entry => [ 
#          $dt_iso8601 => $ok,
#          ...
#     ],

my @data = (
   '*/2 * * * *' => [
        '2006-09-29T13:00:00' => 1,
        '2006-09-29T13:01:00' => 0,
   ],
   '0 0 1 1 *' => [
        '2006-01-01T00:00:00' => 1,
        '2006-02-01T00:00:00' => 0,
   ],
   '1,2,3 0 1 1 *' => [
        '2006-01-01T00:01:00' => 1,
        '2006-01-01T00:02:00' => 1,
        '2006-01-01T00:03:00' => 1,
        '2006-01-01T00:04:00' => 0,
        '2006-01-01T00:54:00' => 0,
   ],
   '0 10-19 * * *' => [
        '2006-01-01T10:00:00' => 1,
        '2006-01-01T15:00:00' => 1,
        '2006-01-01T19:00:00' => 1,
        '2006-01-01T20:00:00' => 0,
        '2006-01-01T00:00:00' => 0,
   ],
);



while (@data) {
    my $cron = shift @data;
    my $c = DateTime::Cron::Simple->new($cron);
    my $tests = shift @data;
    while (@$tests) {
        my $s = shift @$tests;
        my $ok = shift @$tests;
        my $dt = $dt_format->parse_datetime($s);
#        diag("dt: $dt\n");
        if ($ok) {
            ok($c->validate_time($dt), "'$s' matches '$cron'");
        } else {
            ok(!$c->validate_time($dt), "'$s' does not match '$cron'");
        }
    }
}

