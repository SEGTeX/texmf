require ("$LATEX2HTMLDIR/styles/natbib.perl");

package seg;

$fignum = 0;
$append = '';
$imgdir = '../Img/';

sub figure {
    my ($figname,$size) = @_;
    print "Translating plot $figname...\n";
    my $out = join ('', "<TD><IMG SRC = \"",$imgdir,$figname,".png\"");
    foreach $dimension ("width","height") {
        if ($size =~ /$dimension=(\d*\.?\d*)in/) {
            $out .= sprintf (" %s=%d",$dimension,$1*75);
        } elsif ($size =~ /$dimension=(\d*\.?\d*)cm/) {
            $out .= sprintf (" %s=%d",$dimension,$1*30);
        }
    }
    $out .= " ALT = \"$figname\"><\/TD>";
}

sub caption {
    my ($figname,$caption) = @_;
    join ('',"<STRONG>","<A HREF = \"",$imgdir,$figname,".png\">$figname<\/A>",
          "<BR>Figure ",$append,$fignum,"<\/STRONG> ",$caption);
}

package main;

&process_commands_in_tex (<<_RAW_ARG_CMDS_);
_RAW_ARG_CMDS_

&ignore_commands( <<_IGNORED_CMDS_);
bibAnnoteFile # {}
footer # {}
_IGNORED_CMDS_

sub do_cmd_APPENDIX {
    my $rest = shift;
    $rest =~ s/$next_pair_rx//o unless ($rest =~ s/$next_pair_pr_rx//o);
    my $append = $2;
    $seg::append = $append . '-';
    $seg::fignum = 0;
    &extract_pure_text("liberal");
    $rest;
}

sub do_cmd_plot {
    local ($_) = @_;
    &get_next_optional_argument;
    $seg::fignum++;
    my ($figname, $size, $caption);
    foreach $arg ($figname, $size, $caption) {
        s/$next_pair_pr_rx//o;
        $arg = $2;
    }
    my $label = 'fig:' . $figname;
    join ("\n","<P><CENTER>",
          &anchor_label($label,$CURRENT_FILE,''),
          "<TABLE BORDER>",
          &seg::figure  ($figname,$size),"<\/TABLE>",
          &seg::caption ($figname,$caption),"<BR><\/CENTER><\/P>", $_);
}

sub do_cmd_sideplot {
    local ($_) = @_;
    &get_next_optional_argument;
    $seg::fignum++;
    my ($figname, $size, $caption);
    foreach $arg ($figname, $size, $caption) {
        s/$next_pair_pr_rx//o;
        $arg = $2;
    }
    my $label = 'fig:' . $figname;
    join ("\n","<P><CENTER>",
          &anchor_label($label,$CURRENT_FILE,''),
          "<TABLE BORDER=0>","<TR>",
          "<TD WIDTH=\"40\%\">",
          &seg::caption ($figname,$caption),"<\TD>",
          &seg::figure  ($figname,$size),
          "<\/TABLE><\/CENTER><\/P>", $_);
}

sub do_cmd_lefthead {
    my $rest = shift;
    $rest =~ s/$next_pair_rx//o unless ($rest =~ s/$next_pair_pr_rx//o);
    local ($_) = $2;
    &extract_pure_text("liberal");
    $TITLE = join (": ",$_,$TITLE);
    $rest;
}

sub do_cmd_righthead {
    my $rest = shift;
    $rest =~ s/$next_pair_rx//o unless ($rest =~ s/$next_pair_pr_rx//o);
    local ($_) = $2;
    &extract_pure_text("liberal");
    $TITLE .= $_;
    $rest;
}



1;                              # This must be the last line
