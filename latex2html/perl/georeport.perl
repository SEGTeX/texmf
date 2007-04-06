package seg;

sub checkAbs {
    my $html = shift;
    local ($_, $in, $abs);
    open (HTML, $html) or return '';
    print "Checking abstract...\n";
    while (<HTML>) {
	last if ($in && /\<\/DIV\>/);
	if (/^\<DIV/) {
	    $in = /^\<DIV CLASS=\"ABSTRACT\"\>/; 
	} elsif ($in) {
	    s/\<P\>//g;
	    s/(SRC\=\")/join('',$1,$paper,"\/paper_html\/")/eg;
	    s/(HREF\=\")/join('',$1,$paper,"\/paper_html\/")/eg;
	    $abs .= $_ if (/\S/);  
	}
    }
    close (html);
    $abs;
}

sub checkIntro {
    my $html = shift;
    local ($_,$in, $abs);
    open (HTML, $html) or return ''; 
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
	    s/(SRC\=\"([^h]))/join('',$1,$paper,"\/paper_html\/",$2)/eg;
	    s/(HREF\=\")/join('',$1,$paper,"\/paper_html\/")/eg;
	    $abs .= $_ if (/\S/);
	}
    }
    $abs =~ s/<[^\\>]+>\s$/ /;
    close (html);
    $abs .= ' ...' if ($abs);
}

sub checkToc {
    my $html = shift;
    local ($_, $in, $abs);
    open (html, $html . 'node1.html') or return ''; 
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
    &checkAbs         ($paper . '/paper_html/index.html') or 
	&checkIntro   ($paper . '/paper_html/node1.html') or
	    &checkToc ($paper . '/paper_html/');   
}

package main;

sub do_cmd_maintitle {
    my $rest = shift;
    $rest =~ s/$next_pair_rx//o unless ($rest =~ s/$next_pair_pr_rx//o);
    $TITLE = $2;
    $t_title = $2;
    $FILEPDF = $FILE . '.pdf';
    $FILEPDF =~ s/toc/paper/;
    $rest;
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
	$paper = '../' . $paper;
	my $html = $paper . '/paper_html/index.html';
	my $pdf  = $paper . '/paper.pdf';
	my $pdfsize = `du -h $pdf`;
	$pdfsize =~ s/^(\S+).*[\n]?/$1/;

	my $abs = seg::getAbs ($paper);

        $author = "<BR>" . join($author,"<B>","<\/B>");
	$abs = join($abs,"<BR><SMALL>","<\/SMALL>") if $abs;
	join (" ",
	      join('',"<A HREF=\"",$html,"\">",$title,"</A>"),
	      join('',"[<A HREF=\"",$pdf,"\">pdf ", $pdfsize,"</A>]"),
	      $author, $abs,"<BR>",$_);
    } else {
	print "title $title?\n";
	$_;
    }
}

1;                              # This must be the last line
