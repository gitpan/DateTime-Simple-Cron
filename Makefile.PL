
use 5;
use ExtUtils::MakeMaker;

my $EUMM_VERSION = eval $ExtUtils::MakeMaker::VERSION;

WriteMakefile(
    NAME => 'DateTime::Simple::Cron',
    VERSION_FROM => 'lib/DateTime/Cron/Simple.pm',
    PREREQ_PM => {
        DateTime => 0,
        Set::Crontab => 0,

        Test::More => 0,
        DateTime::Format::Strptime => 0, # required for testing
    },

    ($EUMM_VERSION > 6.30_01 ? (
         LICENSE => 'perl',
    ) : ()),
    # recommends => {
    #      'Test::Pod' => 1.18,
    #      'Test::Pod::Coverage' => 1.04,
    # }
);