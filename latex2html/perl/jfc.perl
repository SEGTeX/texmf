package jfc;

$RSF = '../..';
$listings::language='c';
$repos = 'http://svn.sourceforge.net/viewcvs.cgi/rsf/trunk';

package main;

&ignore_commands( <<_IGNORED_CMDS_);
sx # {}
_IGNORED_CMDS_

sub do_env_exer {
    local ($text) = @_;
    "<H2 align=left>EXERCISES:<\/H2>\n" . &list_helper($text,'OL');
}

sub do_cmd_bx {
    local ($_) = @_;
    s/$next_pair_pr_rx//o; 
    join ('','<B>',$2,'</B>',$_);
}

sub do_cmd_bxbx {
    local ($_) = @_;
    s/$next_pair_pr_rx//o;
    my $word = $2;
    s/$next_pair_pr_rx//o;
    join ('','<B>',$word,'</B>',$_);
}

sub do_cmd_opdex {
    local ($_) = @_;
    my ($prog, $comment, $first, $last, $dir);
    foreach $arg ($prog, $comment, $first, $last, $dir) {
        s/$next_pair_pr_rx//o;
        $arg = $2;
    }
    $prog = join('/',$dir,$prog.'.c');
    my $file = join('/','../..',$jfc::RSF,$prog);
    $code = &listings::list($file,$first,$last);
    
    join(' ',
	 &anchor_label("lst:".$prog,$CURRENT_FILE,''),
	 "<CENTER>",
	 $code,
	 "<A HREF=\"$jfc::repos/$prog?view=markup\"><FONT SIZE=\"-2\">$prog</FONT></A></CENTER>\n",
	 $_);
}

sub do_cmd_moddex {
    &do_cmd_opdex;
}

sub do_cmd_boxit {
    my $text = shift;
    $text =~ s/$next_pair_pr_rx//o;
    local ($_) = $2;
    &extract_pure_text("liberal");
    join ("\n","<P>","<TABLE BORDER=\"1\">","<TD>",$_,
	  "<\/TD>","<\/TABLE>","<\/P>\n",$text); 
}

sub do_cmd_vpageref {
    &do_cmd_pageref;
}


1;                              # This must be the last line
