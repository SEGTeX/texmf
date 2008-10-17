package listings;

use IPC::Open2;
use Symbol;

$language = 'html';
$enscript = `which enscript`  || $ENV{"RSF_ENSCRIPT"};
chomp($enscript);

sub list {
    my $file = shift;
    my $firstline = shift;
    my $lastline = shift;
    if (-f $file) {
	print "Listing file $file... [$firstline...$lastline]\n";
    } else {
	print "No file $file found\n";
    }
    $rest = $_;
    open (FILE,$file);

    my $WTR = gensym();  # get a reference to a typeglob
    my $RDR = gensym();  # and another one

    print "$enscript --color --language=html --output=- --pretty-print=" . $language . "\n";

    open2 ($RDR,$WTR,
	   "$enscript --color --language=html --output=- --pretty-print=" . $language);
    while (<FILE>) {
	if ($. >= $firstline && $. <= $lastline) {
	    print $WTR $_;
	}
    }
    close (FILE);
    close ($WTR);
    my $code = '';
    while (<$RDR>) {
	$code .= $_ if (/^<PRE>$/ .. /<\/PRE>$/);
    }
    $code =~ s/<PRE>/<div><table><tr><td><pre class="code">/;
    $code =~ s/<\/PRE>/<\/pre><\/table><\/div>/;
    close(FILE);
    close ($WTR);
    close ($RDR);
    $code;
}

package main;

sub do_cmd_lstset {
    my $rest = shift;
    $rest = ~ s/$next_pair_pr_rx//o unless ($rest =~ s/$next_pair_pr_rx//o);
    my $options = $2;
    print "in lstset with options $options \n";

    if ($options =~ /language=([^\,\}]+)/) {
	$listings::language=lc($1);
	$listings::language =~ s/c\+\+/cpp/;
    }
    print "got $listings::language \n";
    $rest;
}

sub do_cmd_lstinputlisting {
    local ($_) = @_;
    my ($options,$file) = &get_next_optional_argument;
    s/$next_pair_pr_rx//o;
    $rest = $_;
    $file = $2;
    $file = '../' . $file unless $file =~ /^[\/]/;
    my $firstline=1;
    if ($options =~ /firstline=(\d+)/) {
	$firstline = $1;
    }
    my $lastline=9999;
    if ($options =~ /lastline=(\d+)/) {
	$lastline = $1;
    }
    $code = &listings::list($file,$firstline,$lastline);
    $code . $rest;
}

1;                              # This must be the last line
