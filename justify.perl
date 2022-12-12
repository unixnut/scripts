#! /usr/bin/perl --
# justify (PERL script) -- Wrap and justify text to a certain number of columns (default 72)
#
# Written 24 May 2021
#
# Text::Autoformat::break_at (the default behaviour for autoformat()'s `break`
# option) is broken, so use 'break_wrap' to avoid breaking at hyphens.

# Text::Autoformat doesn't handle UTF-8, so convert to multibyte characters
# on input/output by honouring $LANG etc. (see https://perldoc.perl.org/open).
use open ':locale';
use Getopt::Long;

use Text::Autoformat qw(autoformat break_at break_wrap break_TeX);


# *** DEFINITIONS ***
# paragraph mode
$/ = "";
my $width = 72;
my $indent = 0;


# *** MAINLINE ***
GetOptions ("width|w=i" => \$width,
            "indent|i=i" => \$indent,
           )
or die("Error in command line arguments\n");


while (<>)
{
  $_ = autoformat($_, { break => break_TeX, justify => 'full',
                        left => $indent, right => $width + $indent });
  if (eof)
  {
    chomp;
  }
  print;
}
