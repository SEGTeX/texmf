require ("$LATEX2HTMLDIR/styles/natbib.perl");

package seg;

$fignum = 0;
$append = '';
$figdir = 'Fig';
$path = '.';
$left = '';
$right = '';

sub figure {
    my ($figname,$size) = @_;
    my $fig = join('/','..',$path,$figdir,$figname);
    print "Translating plot $fig... \n";
    my $out = join ('', "<IMG SRC = \"$fig.png\" border=\"0\"");
    foreach $dimension ("width","height") {
        if ($size =~ /$dimension=(\d*\.?\d*)in/) {
            $out .= sprintf (" %s=%d",$dimension,$1*75);
        } elsif ($size =~ /$dimension=(\d*\.?\d*)cm/) {
            $out .= sprintf (" %s=%d",$dimension,$1*30);
        }
    }
    $out .= " ALT = \"$figname\">\n";
}

sub caption {
    my ($figname,$caption) = @_;
    my $fig = join('/','..',$path,$figdir,$figname);
    join ('',"<STRONG>",
	  "<A HREF = \"$fig.png\">$figname<\/A>",
	  "<BR>Figure ",$append,'-',$fignum,"<\/STRONG> ",$caption);
}

sub buttons {
    my $figname = shift;
    my $fig = join('/','..',$path,$figdir,$figname);
    my $type = $main::IMAGE_TYPE;
    my $out = join(''," <a href=\"$fig.pdf\">", 
		   "<img src=\"$main::ICONSERVER/pdf.$type\" border=\"0\"",
		   " alt=\"[pdf]\" width=\"32\" height=\"32\"></a>");
    if ($path ne '.') {
	$out .= join(''," <a href=\"../$path.tgz\">", 
		     "<img src=\"$main::ICONSERVER/tgz.$type\" border=\"0\"", 
		     " alt=\"[tgz]\" width=\"32\" height=\"32\"></a>");
    }
    $out .= join(''," <a href=\"$fig.$type\">", 
		 "<img src=\"$main::ICONSERVER/viewmag.$type\" border=\"0\"",
		 " alt=\"[$type]\" width=\"32\" height=\"32\"></a>");
    if ($path eq 'Math') {
	my $math = join('/','..',$path,$figname . '.ma');
	if (-f $math) {
	    $out .= join(''," <a href=\"$math\">", 
			 "<img src=\"$main::ICONSERVER/mathematica.$type\"",
			 " border=\"0\"", 
			 " alt=\"[mathematica]\"",
			 "width=\"32\" height=\"32\"></a>");
	}
    } elsif ($path eq 'XFig') {
	my $xfig = join('/','..',$path,$figname . '.fig');
	if (-f $xfig) {
	    $out .= join(''," <a href=\"$xfig\">", 
			 "<img src=\"$main::ICONSERVER/xfig.$type\"",
			 " border=\"0\"", 
			 " alt=\"[xfig]\" width=\"32\" height=\"32\"></a>");
	}
    } elsif ($path ne '.') {
	$out .= join(''," <a href=\"../$path.html\">", 
		     "<img src=\"$main::ICONSERVER/configure.$type\"",
		     " border=\"0\"", 
		     " alt=\"[scons]\" width=\"32\" height=\"32\"></a>");
    } 
    $out;    
}

package main;

&process_commands_in_tex (<<_RAW_ARG_CMDS_);
_RAW_ARG_CMDS_

&ignore_commands( <<_IGNORED_CMDS_);
righthead # {}
bibAnnoteFile # {}
footer # {}
_IGNORED_CMDS_

sub do_cmd_inputdir {
    my $rest = shift;
    $rest =~ s/$next_pair_pr_rx//o;
    $seg::path = $2;
    $latex_body .= &revert_to_raw_tex("\\inputdir{$2}\n");
    $rest;
}

sub do_cmd_append {
    my $rest = shift;
    $rest =~ s/$next_pair_rx//o unless ($rest =~ s/$next_pair_pr_rx//o);
    my $section = $2;
    if ($seg::append eq '') {
	$seg::append = 'A';
    } else {
	$seg::append++;
    }
    $seg::fignum = 0;
    &extract_pure_text("liberal");
    join("\n",
	 '<H1>',"Appendix ",$seg::append,'</H1>',
	 '<H1>',$section,'</H1>') . $rest;
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
          "<TABLE BORDER=0>","<TR><TH>",
          &seg::figure  ($figname,$size),"<TR><TH>",
          &seg::caption ($figname,$caption),"<TR><TH>",
	  &seg::buttons ($figname),
	  "<\/TABLE>",
	  "<BR><\/CENTER><\/P>", $_);
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
          "<TH WIDTH=\"40\%\">",
          &seg::caption ($figname,$caption),"<TH rowspan=2>",
          &seg::figure  ($figname,$size),"<TR><TH WIDTH=\"40\%\">",
	  &seg::buttons ($figname),
          "<\/TABLE><\/CENTER><\/P>", $_);
}

sub do_cmd_lefthead {
    my $rest = shift;
    $rest =~ s/$next_pair_rx//o unless ($rest =~ s/$next_pair_pr_rx//o);
    $seg::left = $2;
    &extract_pure_text("liberal");
    $TITLE = join (": ",$seg::left,$seg:right) unless ($seg::right eq '');
    $rest;
}

sub do_cmd_righthead {
    my $rest = shift;
    $rest =~ s/$next_pair_rx//o unless ($rest =~ s/$next_pair_pr_rx//o);
    $seg::right = $2;
    &extract_pure_text("liberal");
    $TITLE = join (": ",$seg::left,$seg:right) unless ($seg::left eq '');
    $rest;
}

1;                              # This must be the last line
