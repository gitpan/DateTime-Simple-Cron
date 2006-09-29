
use Test::More no_plan => 1;

use DateTime;

BEGIN { use_ok('DateTime::Cron::Simple'); }

# these tests verify the behavior in case
# of bad entries like '*' or 'a b c d e'

my $c = DateTime::Cron::Simple->new('*');
isa_ok($c, 'DateTime::Cron::Simple');
ok(!$c->validate_time(), 'bad entry never validates');

