package main;

sub do_cmd_href {
    my $rest = shift;
    $rest =~ s/$next_pair_rx//o unless ($rest =~ s/$next_pair_pr_rx//o);
    $url = $2;
    $rest =~ s/$next_pair_rx//o unless ($rest =~ s/$next_pair_pr_rx//o);
    $text = $2;
    "<a href=\"$url\">$text<\/a>" . $rest;
}

1;                              # This must be the last line
