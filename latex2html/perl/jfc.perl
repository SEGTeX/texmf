package jfc;

$RSF = '../..';
$listings::language='c';
$repos = $ENV{"RSF_REPOSITORY"};

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
    my $rest = shift;
    my ($prog, $comment, $first, $last, $dir);
    foreach $arg ($prog, $comment, $first, $last, $dir) {
        $rest =~ s/$next_pair_pr_rx//o;
        $arg = $2;
    }
    my $fullprog = join('/',$dir,$prog.'.c');
    my $file = join('/','../..',$jfc::RSF,$fullprog);
    my $code = &listings::list($file,$first,$last);
    
    join(' ',
	 &anchor_label("lst:".$prog,$CURRENT_FILE,''),
	 "<CENTER><A HREF=\"$jfc::repos/$fullprog?view=markup\"><FONT SIZE=\"-1\">$fullprog</FONT></A>\n",
	 $code,
	 "</CENTER>",
	 $rest);
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

sub do_cmd_reference {
    local ($_) = @_;
    s/$next_pair_pr_rx//o; 
    join ('','<UL><LI>',$2,'</LI></UL>',"\n",$_);
}

sub do_cmd_todo {
    local($_) = @_;
    s/$next_pair_pr_rx//o; 
    print STDERR "**************\n$_\n------------------\n";
    print STDERR "**************\n$2\n------------------\n";
}

1;                              # This must be the last line
