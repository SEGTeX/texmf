package seg;

sub checkAbs {
    my $html = shift;
    local ($_, $in, $abs);
    open (HTML, '../' . $html) or return '';
    print "Checking abstract in $html...\n";
    while (<HTML>) {
	if ($in && /^(.*)\<\/DIV\>/) {
	    $abs .= $1;
	    last;
	}
	if (/\<H3\>Abstract\:\<\/H3\>/) {
	    $_ = <HTML>;
	    $in = /^\<DIV/; 
	} elsif ($in) {
	    s/\<P\>//g;
	    s/(SRC\=\")([^h])/join('',$1,$paper,"_html\/",$2)/eg;
	    s/(HREF\=\")/join('',$1,$paper,"_html\/")/eg;
	    $abs .= $_ if (/\S/);  
	}
    }
    close (html);
    $abs;
}

sub checkIntro {
    my $html = shift;
    local ($_,$in, $abs);
    open (HTML, '../' . $html) or return '';
    print "Checking introduction...\n";
    my @lines = <HTML>;
    foreach (@lines) {
	if ($in > 10) {
	    last unless (/\s+(ALT|SRC|HREF)=/);
	}
	if (/^\<\/H1\>/ ) {
	    $in = 1;  
	} elsif ($in) {
	    $in++;
	    s/\<P\>//g;
	    s/(SRC\=\")([^h])/join('',$1,$paper,"_html\/",$2)/eg;
	    s/(HREF\=\")/join('',$1,$paper,"_html\/")/eg;
	    s/\<[\/]?UL\>//;
	    s/\<[\/]?OL\>//;
	    s/\<[\/]?LI\>//;
	    $abs .= $_ if (/\S/);
	}
    }
    $abs =~ s/<[^\\\/>]+>\s*$/ /;
    close (html);
    $abs .= ' ...' if ($abs);
}

sub checkToc {
    my $html = shift;
    local ($_, $in, $abs);
    open (html, join('../',$html,'node1.html')) or return ''; 
    while (<html>) {
	$in-- if (/^\<\!--End of Table of Child-Links/);
	if ($in) {
	    s/HREF=\"/HREF=\"$html/;
	    $abs .= $_;
	}
	$in++ if (/^\<A NAME=\"CHILD_LINKS/);
    }
    close (html);
    $abs;
}

sub getAbs {
    local $paper = shift;
    &checkAbs         ($paper . '_html/index.html') or 
	&checkIntro   ($paper . '_html/node1.html') or
	&checkToc     ($paper . '_html/');   
}

package main;

&ignore_commands( <<_IGNORED_CMDS_);
cleardoublepage
_IGNORED_CMDS_

sub do_cmd_maintitle {
    my $rest = shift;
    $rest =~ s/$next_pair_rx//o unless ($rest =~ s/$next_pair_pr_rx//o);
    $TITLE = $2;
    $t_title = $2;
    $FILEPDF = 'book.pdf';
    $rest;
}

sub do_cmd_geosectionstar {
    my $text = shift;
    $text =~  s/$next_pair_pr_rx//o;
    my $section = $2;
    if ($section) {
	join ('',"<H2 align=center>",$section,"<\/H2>\n",$text);
    } else {
	$text;
    }
}

sub do_cmd_TOCentry {
    local ($_) = @_;
    my ($author,$title) =  &get_next_optional_argument;
    s/$next_pair_pr_rx//o; 
    $title = $2;
    s/$next_pair_pr_rx//o;

    $paper = $2;
    if ($author) {
	$paper =~ s/^[^\#]+\#([^\#]+)(\.start)\#.*$/$1/;
	$paper .= '/paper' unless ($paper =~ s/-/\//);
	my $html = $paper . '_html/index.html';
	my $pdf  = $paper . '.pdf';
	my $pdfsize = `du -h ../$pdf`;
	$pdfsize =~ s/^(\S+).*[\n]?/$1/;

	$author =~ s/\\\s+//;

	my $abs = '';
	$abs = seg::getAbs ($paper) if $author;

        $author = "<BR>" . join($author,"<B>","<\/B>");
	$abs = join($abs,"<BR><SMALL>","</SMALL>") if $abs;
	join (" ",
	      join('',"<A HREF=\"",$html,"\">",$title,"</A>"),
	      join('',"[<A HREF=\"",$pdf,"\">pdf ", $pdfsize,"</A>]"),
	      $author,$abs,"<BR>",$_);
    } else {
	print "title $title?\n";
	$_;
    }
}

1;                              # This must be the last line
