%%
%% This is file `stanford-thesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% stanford-thesis.dtx  (with options: `class')
%% 
%% This is an automatically generated file. Do not edit it directly!
%% 
%%    Copyright (C) 2007 by Sergey Fomel
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
\ProvidesClass{stanford-thesis}[2007/12/13 v1.0 Stanford-style PhD thesis]
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
\RequirePackage{ifthen}
\newboolean{@report}
\DeclareOption{oneside}{\setboolean{@report}{false}}
\DeclareOption{twoside}{\setboolean{@report}{false}%
\PassOptionsToClass{twoside}{report}}
\DeclareOption{report}{\setboolean{@report}{true}%
\PassOptionsToClass{twoside}{report}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ExecuteOptions{oneside}
\ProcessOptions*
\LoadClass{report}
\RequirePackage{seg}
\newlength{\toc@width}%
\setlength{\toc@width}{\textwidth}%
\addtolength{\toc@width}{-6em}%
\newcommand{\TOCentry}[3][.]{%
\ifthenelse{\boolean{@report}}{% emulate SEP report
  \noindent\hspace*{4em}{\begin{minipage}[b]{\toc@width}
      \setlength{\parindent}{-5em}%
      \ifthenelse{\equal{#1}{.}}{}{\textit {#1}, }%
      #2\dotfill\
    \end{minipage}\hfill#3}\par}{}}
\newcommand{\REPORT}{}
\newcommand{\GROUP}{}
\RequirePackage{suthesis-2e}%
\ifthenelse{\boolean{@report}}{%Thesis in SEPreport style
  \renewcommand{\thesiscopyrightpage}{%
    \null\vfill
    \begin{center}
      \large
      \copyright\ Copyright \@copyrightyear\ by \@author\\
      All Rights Reserved
      \vfill
      Printed as  Stanford Exploration Project No. \REPORT\\
      by permission of the author
      \vfill
      Copying for all internal purposes of the sponsors \\
      of the Stanford Exploration Project is permitted
    \end{center}
    \vfill
    \newpage}
}{%%%   Margin control.  Official rules say 1.5in on binding edge and 1in
  %%     on other three edges.  Registrar likes to add a little cushion.
  %%   You can move the whole page around to fix a weird printer by
  %%     adjusting only the margins.  Or adjust everything to make
  %%     ``safer'' margins.
  \addtolength{\oddsidemargin}{0.07in}
  \addtolength{\evensidemargin}{0.07in}  %% has no effect for onesided printing.
  %% Recalculate textwidth.  Remove twice as much from \textwidth to
  %%  slim both margins equally.
  \addtolength{\textwidth}{-0.14in}
}
\newcommand{\geo@header}{}
\newcommand{\GEOheader}[1]{\renewcommand{\geo@header}{#1}%
\let\title\chapter}
\newcommand{\paper@dir}{.}
\newcommand{\paper@tag}{self}
\newcommand{\GEOpaper}[2]{%
  \cleardoublepage
  \label{\paper@tag.end}%
  \thispagestyle{segtwo}%
  \label{#2.start}
  \renewcommand{\paper@dir}{#1}
  \renewcommand{\paper@tag}{#2}
}
\RequirePackage{ifpdf}
\ifpdf
\RequirePackage[pdftex]{graphicx}
\DeclareGraphicsExtensions{.pdf,.png}
\else
\usepackage{graphicx}
\DeclareGraphicsExtensions{.eps,.ps}
\fi
\providecommand{\figdir}{.}
\providecommand{\setfigdir}[1]{\renewcommand{\figdir}{#1}}
\providecommand{\fig@file}[1]{\paper@dir/\@path/\figdir/#1}
\newcommand{\plotdir}{\figdir}
\newcommand{\plot@file}[1]{\plotdir/#1}
\newcommand{\plotbox}[2]{%
  \begin{figure*}[htbp]
    \centering
    \includegraphics[#2]{\plot@file{#1}}
\end{figure*}}
\newcommand{\fullplot}[4][htbp]{%
  \begin{figure*}[#1]
    \centering
    \setlength{\fboxsep}{0.5ex}
    \includegraphics[#3]{\fig@file{#2}}
    \caption[#4]{#4 \fbox{\paper@dir/\@path\ #2}}
    \label{fig:#2}
  \end{figure*}
}
\newcommand{\sideplot}[4][htbp]{%
    \begin{figure*}[#1]
      \makebox{%
        \begin{minipage}{0.4\textwidth}
  \setlength{\fboxsep}{0.5ex}
          \caption[#4]{#4 \fbox{\paper@dir/\@path\ #2}}
          \label{fig:#2}
        \end{minipage}
        \hfill
        \begin{minipage}{0.6\textwidth}
          \flushright
          \includegraphics[#3]{\fig@file{#2}}
        \end{minipage}}
    \end{figure*}
}
\def\plot{\@ifstar{\fullplot}{\fullplot}}
\RequirePackage{subfigure}
\def\next@item#1,#2?{#1}
\def\rest@item#1,#2?{#2}
\newcounter{sub@fig}
\newcommand{\seg@fullmultiplot}[5][htbp]{
  \begin{figure*}[#1]
    \centering
    \setlength{\fboxsep}{0.5ex}
    \setcounter{sub@fig}{0}
    \edef\list@i{#3}
    \loop
    \edef\item@i{\expandafter\next@item\list@i,\empty?}
    \edef\list@i{\expandafter\rest@item\list@i,\empty?}
    \ifx\item@i\empty
    \else
    \stepcounter{sub@fig}
    \subfigure[]{\includegraphics[#4]{\fig@file{\item@i}}%
      \label{fig:\@path-\item@i}
      \label{fig:\item@i}}
    \ifthenelse{\value{sub@fig} = #2}{\\ \setcounter{sub@fig}{0}}{}
    \repeat
    \caption[#5]{#5 \fbox{\paper@dir/\@path\ #3}}
    \label{fig:\@path-#3}
    \label{fig:#3}
  \end{figure*}
}
\newcommand{\seg@sidemultiplot}[5][htbp]{
  \begin{figure}[#1]
    \centering
    \setlength{\fboxsep}{0.5ex}
    \setcounter{sub@fig}{0}
    \edef\list@i{#3}
    \loop
    \edef\item@i{\expandafter\next@item\list@i,\empty?}
    \edef\list@i{\expandafter\rest@item\list@i,\empty?}
    \ifx\item@i\empty
    \else
    \stepcounter{sub@fig}
    \subfigure[]{\includegraphics[#4]{\fig@file{\item@i}}%
      \label{fig:\@path-\item@i}
      \label{fig:\item@i}}
    \ifthenelse{\value{sub@fig} = #2}{\\ \setcounter{sub@fig}{0}}{}
    \repeat
    \caption[#5]{#5 \fbox{\paper@dir/\@path\ #3}}
    \label{fig:\@path-#3}
    \label{fig:#3}
  \end{figure}
}
\def\multiplot{\@ifstar{\seg@fullmultiplot}{\seg@fullmultiplot}}
\providecommand{\seg@sidetabl}[4][htbp]{
  \begin{table}[#1]
    #4
    \caption{#3}
    \label{tbl:#2}
  \end{table}
}
\providecommand{\seg@fulltabl}[4][htbp]{
  \begin{table*}[#1]
    #4
    \caption{#3}
    \label{tbl:#2}
  \end{table*}
}
\def\tabl{\@ifstar{\seg@fulltabl}{\seg@sidetabl}}
\newcommand{\new}[1]{#1}
\newcommand{\old}[1]{}
\def\first@char#1#2\end{#1}
\def\geo@input#1{\ifthenelse{\equal{\paper@dir}{.}\or\equal{\expandafter\first@char#1\end}{.}}{\@iinput{#1}}{\@iinput{\paper@dir/#1}}}
\def\input{\@ifnextchar\bgroup\geo@input\@@input}
\setlength{\textheight}{9in}
\setlength{\textwidth}{6in}
\setlength{\parskip}{1.5ex plus0.1ex minus0.1ex} % should be a *rubber* length
\setlength{\oddsidemargin}{.26in}
\setlength{\evensidemargin}{.26in}
\setlength{\topmargin}{-.51in}
\setlength{\textfloatsep}{30pt plus 3pt minus 6pt}
\setlength{\headsep}{0.5in}
\newsavebox{\seg@abstract}
\setlength{\fboxsep}{10pt}
\renewenvironment{abstract}{\vspace{0.3in}\seg@author
  \begin{lrbox}{\seg@abstract}\begin{minipage}{0.95\columnwidth}%
      \centerline{\Large\textbf{ABSTRACT}}\medskip}
       {\medskip\end{minipage}\end{lrbox}%
  \ifthenelse{\boolean{@shrt}}{}{\noindent\fbox{\usebox{\seg@abstract}}}}
\newenvironment{bios}{%
  \begin{list}{}{%
      \setlength{\leftmargin}{1cm}\setlength{\rightmargin}{1cm}%
      \setlength{\listparindent}{0cm}\setlength{\topsep}{0cm}%
      \setlength{\baselineskip}{0.5cm}\setlength{\partopsep}{0cm}%
      \setlength{\parsep}{0cm}\setlength{\parindent}{0cm}%
      \setlength{\itemsep}{1.5cm plus0.5cm minus0.5cm}%
    }
  }{\end{list}}
\newcommand{\bioplot}[2]{%
  \begin{figure*}[htbp]
    \setlength{\fboxsep}{0.5ex}
    \makebox{\parbox{0.71\textwidth}{#2}
      \hfill
      \begin{minipage}{0.29\textwidth}
        \protect\centering
        \fbox{\includegraphics[height=1.6in]{#1}}
      \end{minipage}}
  \end{figure*}}
\newcommand{\ps@georeport}{%
\renewcommand{\@oddhead}{%
\seg@foot\hfill\textit{\seg@rhead}\hfill\thepage}
\renewcommand{\@evenhead}{%
\thepage\hfill\textit{\seg@lhead}\hfill\seg@foot}
\renewcommand{\@oddfoot}{}\renewcommand{\@evenfoot}{}}
\pagestyle{georeport}
\ifthenelse{\boolean{@report}}{% emulate SEP report
  \newcommand{\ps@segtwo}{%
    \renewcommand{\@oddfoot}{\hfill\thepage\hfill}%
    \renewcommand{\@evenfoot}{\@oddfoot}
    \renewcommand{\@oddhead}{%
      \footnotesize\textit{\geo@header\seg@head}\hfill\normalsize}%
    \renewcommand{\@evenhead}{\@oddhead}}}{
  \newcommand{\ps@segtwo}{%
    \renewcommand{\@oddfoot}{\hfill\textit{\seg@foot}\hfill}%
    \renewcommand{\@evenfoot}{\@oddfoot}}}
\let\seg@large\large
\let\seg@Large\Large
\renewcommand{\Large}{\protect\seg@large}
\let\seg@section\section
\let\seg@subsection\subsection
\let\seg@subsubsection\subsubsection
\newcommand{\geosection}{%
\@startsection {section}{1}{\z@}%
{-3.5ex \@plus -1ex \@minus -.2ex}%
{1ex \@plus .2ex}%
{\centering\normalfont\Large\bfseries}}
\newcommand{\segsection}{%
\@startsection {section}{1}{\z@}%
{-3.5ex \@plus -1ex \@minus -.2ex}%
{1ex \@plus .2ex}%
{\centering\normalfont\Large\bfseries\MakeUppercase}}
\newcommand{\segsubsubsection}{%
\@startsection{subsubsection}{3}{\z@}%
{-3.25ex\@plus -1ex \@minus -.2ex}%
{1.5ex \@plus .2ex}%
{\normalfont\normalsize\itshape}}
\newcommand{\seg@subsubsubsection}[2][]{%
\underline{#2}.--}
\def\section{\@ifstar{\segsection*}{\segsection*}}
\def\subsection{\@ifstar{\seg@subsection*}{\seg@subsection*}}%
\def\subsubsection{\@ifstar{\seg@subsubsection*}{\seg@subsubsection*}}
\providecommand{\append@name}{A}
\providecommand{\append}[1]{%
  % call \appendix only once
  \ifthenelse{\equal{\append@name}{A}}{%
    \appendix\renewcommand{\append@name}{B}}{}
  \chapter{#1}}
\RequirePackage{natbib}
\bibpunct[,]{(}{)}{;}{a}{,}{,}
\RequirePackage{listings}
\renewcommand{\lst@inputpath}{./\paper@dir/}
\endinput
%%
%% End of file `stanford-thesis.cls'.
