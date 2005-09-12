%%
%% This is file `georeport.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% georeport.dtx  (with options: `class')
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
\ProvidesClass{georeport}[2004/11/23 v1.0 SEP-style report]
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
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions*
\LoadClass[11pt]{report}
\RequirePackage{ifthen}
\RequirePackage{seg}
\RequirePackage{chapterbib}
\newlength{\toc@width}%
\setlength{\toc@width}{\textwidth}%
\addtolength{\toc@width}{-6em}%
\newcommand{\TOCentry}[3][.]{
  \noindent\hspace*{4em}{\begin{minipage}[b]{\toc@width}
      \setlength{\parindent}{-5em}%
      \ifthenelse{\equal{#1}{.}}{}{\textit {#1}, }%
      #2\dotfill\
    \end{minipage}\hfill#3}\par}
\newcommand{\REPORT}{}
\newcommand{\GROUP}{}
\newcommand{\GEOcopyr}[2]{%
\author{Copyright \copyright\ #1}
\author{by #2}
\vfill \ \newpage}
\newcommand{\geo@head}{}
\newcommand{\geo@header}{}
\newcommand{\header}[1]{\renewcommand{\geo@head}{#1}}
\newcommand{\GEOheader}[1]{\renewcommand{\geo@header}{#1}}
\newcommand{\paper@name}{}
\newcommand{\GEOpaper}[1]{%
  \setcounter{equation}{0}\setcounter{figure}{0}%
  \setcounter{table}{0}\setcounter{footnote}{0}%
  \renewcommand{\theequation}{\arabic{equation}}%
  \renewcommand{\thefigure}{\arabic{figure}}%
  \renewcommand{\thetable}{\arabic{table}}%
  \header{, pages \pageref{#1.start}--\pageref{#1.end}}%
  \renewcommand{\paper@name}{#1}
}
\endinput
%%
%% End of file `georeport.cls'.
