%%
%% This is file `eage.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% eage.dtx  (with options: `class')
%% 
%% This is an automatically generated file. Do not edit it directly!
%% 
%%    Copyright (C) 2004 by Sergey Fomel
%% 
%%     This work may be distributed and/or modified under the
%%     conditions of the LaTeX Project Public License, either version 1.3
%%     of this license or (at your option) any later version.
%%     The latest version of this license is in
%%       http://www.latex-project.org/lppl.txt
%%     and version 1.3 or later is part of all distributions of LaTeX
%%     version 2003/12/01 or later.
%% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eage}[2005/04/03 v1.0 SEG expanded abstract]
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{geophysics}}
\ProcessOptions*
\LoadClass[12pt,a4paper]{geophysics}
\setlength{\oddsidemargin}{-0.25cm}
\setlength{\evensidemargin}{-0.25cm}
\setlength{\textwidth}{16.5cm}
\setlength{\textheight}{19.2cm}
\setlength{\parindent}{0em}
\setlength{\headheight}{0cm}
\setlength{\headsep}{0cm}
\setlength{\parskip}{1.5ex plus0.1ex minus0.1ex}
\setlength{\topmargin}{-1cm}
\renewcommand{\title}[1]{}
\renewcommand{\author}[1]{%
  \clearpage\setlength\textheight{25cm}\onecolumn}
\renewenvironment{abstract}{\section{ABSTRACT}}{}
\newcommand{\ps@eage}{%
\setlength{\headheight}{4.6cm}%
\renewcommand{\@oddhead}{}%
\renewcommand{\@evenhead}{}%
\renewcommand{\@oddfoot}{}%
\renewcommand{\@evenfoot}{}}
\thispagestyle{eage}
\pagestyle{empty}
\endinput
%%
%% End of file `eage.cls'.
