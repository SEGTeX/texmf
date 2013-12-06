require ("$LATEX2HTMLDIR/styles/natbib.perl");

package seg;

$fignum = 0;
$tabnum = 0;
$append = '';
$figdir = '.';
$path = '.';
$left = '';
$right = '';

sub figure {
    my ($figname,$size,$scale) = @_;
    my $fig = join('/','..',$path,$figdir,$figname);
    my $type = $main::IMAGE_TYPE;
    print "Translating plot $fig... with size \"$size\" \n";
    my $out = join ('', "<IMG SRC = \"$fig.$type\" border=\"0\"");
    foreach $dimension ("width","height") {	
        if ($size =~ /$dimension=(\d*\.?\d*)in/) {
            $out .= sprintf (" %s=%d",$dimension,$1*75);
        } elsif ($size =~ /$dimension=(\d*\.?\d*)cm/) {
            $out .= sprintf (" %s=%d",$dimension,$1*30);
        } elsif ($size =~ /$dimension=(\d*\.?\d*)mm/) {
            $out .= sprintf (" %s=%d",$dimension,$1*3);
	} elsif ($size =~ /$dimension=(\d*\.?\d*)pt/) {
            $out .= sprintf (" %s=%d",$dimension,$1);  
        } elsif ($size =~ /$dimension=(\d*\.?\d*)/) {
	    if ($1) {
		$dim = $1;
	    } else {
		$dim = 1;
	    }
	    if ($3 == 'height') {
		$out .= sprintf (" %s=%d",$dimension,$scale*$dim*9*75);
	    } else {
		$out .= sprintf (" %s=%d",$dimension,$scale*$dim*6*75);
	    }
	}
    }
    $out .= " ALT = \"$figname\">\n";
}

sub caption {
    my ($figname,$caption) = @_;
    my $fig = join('/','..',$path,$figdir,$figname);
    my $dash = '';
    my $type = $main::IMAGE_TYPE;
    $dash = '-' if ($append ne '');	
    join ('',"<STRONG>",
	  "<A HREF = \"$fig.$type\">$figname<\/A>",
	  "<BR>Figure ",$append,$dash,$fignum,".<\/STRONG> ",$caption);
}

sub multicaption {
    my ($figname,$caption) = @_;
    my @names = split(',',$figname);
    my @figs;
    my $type = $main::IMAGE_TYPE;
    foreach $name (@names) {	
	my $fig = join('/','..',$path,$figdir,$name);
	push(@figs,"<A HREF = \"$fig.$type\">$name<\/A>");
    }
    my $dash = '';
    $dash = '-' if ($append ne '');	
    join ('',"<STRONG>",join(',',@figs),
	  "<BR>Figure ",$append,$dash,$fignum,".<\/STRONG> ",$caption);
}

sub buttons {
    my $figname = shift;
    my @names = split(',',$figname);
    my $out = '';
    my $type = $main::IMAGE_TYPE;
    my @figs;
    foreach $name (@names) {
	push(@figs,join('/','..',$path,$figdir,$name));
    }
    foreach $fig (@figs) {
	$out .= join(''," <a href=\"$fig.pdf\">", 
		     "<img src=\"$main::ICONSERVER/pdf.$type\" border=\"0\"",
		     " alt=\"[pdf]\" width=\"32\" height=\"32\"></a>");
    }
#    if ($path ne '.') {
#	$out .= join(''," <a href=\"../$path.tgz\">", 
#		     "<img src=\"$main::ICONSERVER/tgz.$type\" border=\"0\"", 
#		     " alt=\"[tgz]\" width=\"32\" height=\"32\"></a>");
#    }
    foreach $fig (@figs) {
	$out .= join(''," <a href=\"$fig.$type\">", 
		     "<img src=\"$main::ICONSERVER/viewmag.$type\" ",
		     "border=\"0\"",
		     " alt=\"[$type]\" width=\"32\" height=\"32\"></a>");
    }
    if ($path eq 'Math') {
	foreach $name (@names) {
	    my $math = join('/','..',$path,$name . '.ma');
	    if (-f $math) {
		$out .= join(''," <a href=\"$math\">", 
			     "<img src=\"$main::ICONSERVER/mathematica.$type\"",
			     " border=\"0\"", 
			     " alt=\"[mathematica]\"",
			     "width=\"32\" height=\"32\"></a>");
	    }
	}
    } elsif ($path eq 'Matlab') {
	foreach $name (@names) {
	    my $matl = join('/','..',$path,$name . '.ml');
	    if (-f $matl) {
		$out .= join(''," <a href=\"$matl\">", 
			     "<img src=\"$main::ICONSERVER/matlab.$type\"",
			     " border=\"0\"", 
			     " alt=\"[matlab]\"",
			     "width=\"34\" height=\"32\"></a>");
	    }
	}
      } elsif ($path eq 'Gnuplot') {
	foreach $name (@names) {
	  my $gnuplot = join('/','..',$path,$name . '.gp');
	  if (-f $gnuplot) {
	    $out .= join(''," <a href=\"$gnuplot\">", 
			 "<img src=\"$main::ICONSERVER/gnuplot.$type\"",
			 " border=\"0\"", 
			 " alt=\"[gnuplot]\"",
			 "width=\"32\" height=\"32\"></a>");
	  }
	}
     } elsif ($path eq 'Tikz') {
	foreach $name (@names) {
	  my $tikz = join('/','..',$path,$name . '.tex');
	  if (-f $tikz) {
	    $out .= join(''," <a href=\"$tikz\">", 
			 "<img src=\"$main::ICONSERVER/tex.$type\"",
			 " border=\"0\"", 
			 " alt=\"[tikz]\"",
			 "width=\"56\" height=\"32\"></a>");
	  }
	}
      } elsif ($path eq 'Sage') {
	foreach $name (@names) {
	    my $sage = join('/','..',$path,$name . '.sage');
	    if (-f $sage) {
		$out .= join(''," <a href=\"$sage\">", 
			     "<img src=\"$main::ICONSERVER/sage.$type\"",
			     " border=\"0\"", 
			     " alt=\"[sage]\"",
			     "width=\"38\" height=\"32\"></a>");
	    }
	}
    } elsif ($path eq 'Pylab') {
	foreach $name (@names) {
	    my $pytl = join('/','..',$path,$name . '.py');
	    if (-f $pytl) {
		$out .= join(''," <a href=\"$pytl\">", 
			     "<img src=\"$main::ICONSERVER/pylab.$type\"",
			     " border=\"0\"", 
			     " alt=\"[pylab]\"",
			     "width=\"34\" height=\"32\"></a>");
	    }
	}
    } elsif ($path eq 'XFig') {
	foreach $name (@names) {
	    my $xfig = join('/','..',$path,$name . '.fig');
	    if (-f $xfig) {
		$out .= join(''," <a href=\"$xfig\">", 
			     "<img src=\"$main::ICONSERVER/xfig.$type\"",
			     " border=\"0\"", 
			     " alt=\"[xfig]\" width=\"32\" height=\"32\"></a>");
	    }
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
bibAnnoteFile # {}
footer # {}
shortpaper
pdfbookmark # [] # {} # {}
ms # {}
_IGNORED_CMDS_

sub do_cmd_inputdir {
    my $rest = shift;
    $rest =~ s/$next_pair_pr_rx//o;
    $seg::path = $2;
    $latex_body .= &revert_to_raw_tex("\\inputdir{$2}\n");
    $rest;
}

sub do_cmd_setfigdir {
    my $rest = shift;
    $rest =~ s/$next_pair_pr_rx//o;
    $seg::figdir = $2;
    $latex_body .= &revert_to_raw_tex("\\setfigdir{$2}\n");
    $rest;
}

sub do_cmd_old {
    my $rest = shift;
    $rest =~ s/$next_pair_pr_rx//o;
    $rest;
}

sub do_cmd_append {
    my $rest = shift;
    $rest =~ s/$next_pair_pr_rx//o;
    my $section = $2;
    $latex_body .= &revert_to_raw_tex("\\append{$2}\n");
    if ($seg::append eq '') {
	$seg::append = 'A';
    } else {
	$seg::append++;
    }
    $seg::fignum = 0;
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
          &seg::figure  ($figname,$size,1),"<TR><TH>",
          &seg::caption ($figname,$caption),"<TR><TH>",
	  &seg::buttons ($figname),
	  "<\/TABLE>",
	  "<BR><\/CENTER><\/P>", $_);
}

sub do_cmd_multiplot {
    local ($_) = @_;
    &get_next_optional_argument;
    $seg::fignum++;
    my ($nfig, $figname, $size, $caption);
    foreach $arg ($nfig, $figname, $size, $caption) {
        s/$next_pair_pr_rx//o;
        $arg = $2;
    }
    my $label = 'fig:' . $figname;
    my $figs = '';
    my @figs = split(',',$figname);
    foreach $fig (@figs) {	
	$figs .= join("\n",		      
		      &anchor_label('fig:' . $fig,$CURRENT_FILE,''),
		      &seg::figure($fig,$size,1));
    }
    join ("\n","<P><CENTER>",
          &anchor_label($label,$CURRENT_FILE,''),
          "<TABLE BORDER=0>","<TR><TH>",$figs,"<TR><TH>",
          &seg::multicaption ($figname,$caption),"<TR><TH>",
	  &seg::buttons ($figname),
	  "<\/TABLE>",
	  "<BR><\/CENTER><\/P>", $_);
}

sub do_cmd_tabl {
    local ($_) = @_;
    &get_next_optional_argument;
    $seg::tabnum++;
    my ($tabname, $caption, $body);
    foreach $arg ($tabname, $caption, $body) {
	s/$next_pair_pr_rx//o;
	$arg = $2;
    }
    my $label = 'tbl:' . $tabname;
    my $dash = '';
    $dash = '-' if ($seg::append ne '');
    $caption = join ('',"<CENTER>",$body,"<BR>\n<STRONG>",
		     &anchor_label($label,$CURRENT_FILE,''),
		     "Table ",$seg::append,$dash,$seg::tabnum,
		     ". ",$caption,"<\/STRONG><\/CENTER>");
    $caption .= $_;
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
          &seg::figure  ($figname,$size,0.5),"<TR><TH WIDTH=\"40\%\">",
	  &seg::buttons ($figname),
          "<\/TABLE><\/CENTER><\/P>", $_);
}

sub do_cmd_lefthead {
    my $rest = shift;
    $rest =~ s/$next_pair_rx//o unless ($rest =~ s/$next_pair_pr_rx//o);
    $seg::left = $2;
    &extract_pure_text("liberal");
    $TITLE = join (": ",$seg::left,$seg::right) unless ($seg::right eq '');
    $rest;
}

sub do_cmd_published {
    my $rest = shift;
    $rest =~ s/$next_pair_rx//o unless ($rest =~ s/$next_pair_pr_rx//o);
    $published = $2;
    &extract_pure_text("liberal");
    join ("\n","<h3>Published as $published</h3>",$rest);
}

sub do_cmd_righthead {
    my $rest = shift;
    $rest =~ s/$next_pair_rx//o unless ($rest =~ s/$next_pair_pr_rx//o);
    $seg::right = $2;
    &extract_pure_text("liberal");
    $TITLE = join (": ",$seg::left,$seg::right) unless ($seg::left eq '');
    $rest;
}

1;                              # This must be the last line
