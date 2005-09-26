%%
%% This is file `geophysics.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% geophysics.dtx  (with options: `class')
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
\ProvidesClass{geophysics}[2004/11/08 v2.0 Geophysics paper]
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
\newboolean{@manu}
\setboolean{@manu}{false}
\DeclareOption{manuscript}{\setboolean{@manu}{true}}
\DeclareOption{paper}{\setboolean{@manu}{false}}
\newboolean{@twoc}
\setboolean{@twoc}{false}
\DeclareOption{twocolumn}{\setboolean{@twoc}{true}}
\DeclareOption{onecolumn}{\setboolean{@twoc}{false}}
\newboolean{@shrt}
\setboolean{@shrt}{false}
\DeclareOption{short}{\setboolean{@shrt}{true}}
\DeclareOption{long}{\setboolean{@shrt}{false}}
\newboolean{@eflt}
\setboolean{@eflt}{false}
\DeclareOption{endfloat}{\setboolean{@eflt}{true}}
\DeclareOption{noendfloat}{\setboolean{@eflt}{false}}
\newboolean{@revd}
\setboolean{@revd}{false}
\DeclareOption{revised}{\setboolean{@revd}{true}}
\DeclareOption{new}{\setboolean{@revd}{false}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{paper,onecolumn,long,noendfloat,new}
\ProcessOptions*
\ifthenelse{\boolean{@twoc}}{%
  \LoadClass[9pt]{article}}{%
  \LoadClass[11pt]{article}}
\RequirePackage{seg}
\ifthenelse{\boolean{@eflt}}{
  \ifthenelse{\boolean{@manu}}{\RequirePackage{endfloat}}{}
}{
\newif\ifpdf
\ifx\pdfoutput\undefined \pdffalse
\else \pdfoutput=1 \pdftrue \fi
\ifpdf
\RequirePackage[pdftex]{graphicx}
\DeclareGraphicsExtensions{.pdf,.png}
\else
\usepackage{graphicx}
\DeclareGraphicsExtensions{.eps,.ps}
\fi
\ifthenelse{\boolean{@manu}}{
  \renewcommand{\inputdir}[1]{\AtEndDocument{\renewcommand{\@path}{#1}}}}{}
\providecommand{\figdir}{.}
\providecommand{\fig@file}[1]{\@path/\figdir/#1}
\newcounter{@plots}
\setcounter{@plots}{0}
\ifthenelse{\boolean{@manu}}
{\newcommand{\fullplot}[4][X]{
    \stepcounter{@plots}
    \AtEndDocument{
      \begin{figure}[p]
        \centering
        \includegraphics[#3]{\fig@file{#2}}
        \caption{#4}
        \label{fig:#2}
      \end{figure}\clearpage
    }}
  \def\plot{\@ifstar{\fullplot}{\fullplot}}
  \setlength\abovecaptionskip{50\p@}
}
{\newcommand{\fullplot}[4][htbp]{%
    \begin{figure*}[#1]
      \centering
      \includegraphics[#3]{\fig@file{#2}}
      \caption{#4}
      \label{fig:#2}
    \end{figure*}
  }}
\ifthenelse{\boolean{@manu}}
{\newcommand{\sideplot}[4][X]{\plot[#1]{#2}{#3}{#4}}}
{\newcommand{\sideplot}[4][htbp]{%
    \ifthenelse{\boolean{@twoc}}{%
      \begin{figure}[#1]
        \centering
        \includegraphics[#3]{\fig@file{#2}}
        \caption{#4}
        \label{fig:#2}
      \end{figure}
    }{%
      \begin{figure*}[#1]
        \makebox{%
          \begin{minipage}{0.4\textwidth}
            \caption{#4}
            \label{fig:#2}
          \end{minipage}
          \hfill
          \begin{minipage}{0.6\textwidth}
            \flushright
            \includegraphics[#3]{\fig@file{#2}}
          \end{minipage}}
      \end{figure*}
    }
  }
  \ifthenelse{\boolean{@twoc}}{%
    \def\plot{\@ifstar{\fullplot}{\sideplot}}}{%
    \def\plot{\@ifstar{\fullplot}{\fullplot}}}
}
\RequirePackage{subfigure}
\def\next@item#1,#2?{#1}
\def\rest@item#1,#2?{#2}
\newcounter{sub@fig}
\ifthenelse{\boolean{@manu}}
{\newcommand{\seg@multiplot}[5][X]{
    \stepcounter{@plots}
    \AtEndDocument{
      \begin{figure}[p]
        \centering
        \setcounter{sub@fig}{0}
        \edef\list@i{#3}
        \loop
        \edef\item@i{\expandafter\next@item\list@i,\empty?}
        \edef\list@i{\expandafter\rest@item\list@i,\empty?}
        \ifx\item@i\empty
        \else
        \stepcounter{sub@fig}
        \subfigure[]{\includegraphics[#4]{\fig@file{\item@i}}%
          \label{fig:\item@i}}
        \ifthenelse{\value{sub@fig} = #2}{\\ \setcounter{sub@fig}{0}}{}
        \repeat
        \caption{#5}
        \label{fig:#3}
      \end{figure}\clearpage
}}
\def\multiplot{\@ifstar{\seg@multiplot}{\seg@multiplot}}
}{%
  \newcommand{\seg@fullmultiplot}[5][htbp]{
    \begin{figure*}[#1]
      \centering
      \setcounter{sub@fig}{0}
      \edef\list@i{#3}
      \loop
      \edef\item@i{\expandafter\next@item\list@i,\empty?}
      \edef\list@i{\expandafter\rest@item\list@i,\empty?}
      \ifx\item@i\empty
      \else
      \stepcounter{sub@fig}
      \subfigure[]{\includegraphics[#4]{\fig@file{\item@i}}%
        \label{fig:\item@i}}
      \ifthenelse{\value{sub@fig} = #2}{\\ \setcounter{sub@fig}{0}}{}
      \repeat
      \caption{#5}
      \label{fig:#3}
    \end{figure*}
  }
  \newcommand{\seg@sidemultiplot}[5][htbp]{
    \begin{figure}[#1]
      \centering
      \setcounter{sub@fig}{0}
      \edef\list@i{#3}
      \loop
      \edef\item@i{\expandafter\next@item\list@i,\empty?}
      \edef\list@i{\expandafter\rest@item\list@i,\empty?}
      \ifx\item@i\empty
      \else
      \stepcounter{sub@fig}
      \subfigure[]{\includegraphics[#4]{\fig@file{\item@i}}%
        \label{fig:\item@i}}
      \ifthenelse{\value{sub@fig} = #2}{\\ \setcounter{sub@fig}{0}}{}
      \repeat
      \caption{#5}
      \label{fig:#3}
    \end{figure}
  }
  \ifthenelse{\boolean{@twoc}}{%
    \def\multiplot{\@ifstar{\seg@fullmultiplot}{\seg@sidemultiplot}}}{%
    \def\multiplot{\@ifstar{\seg@fullmultiplot}{\seg@fullmultiplot}}}
}
\newcounter{@tabls}
\setcounter{@tabls}{0}
\ifthenelse{\boolean{@manu}}{
  \providecommand{\tabl}[4][X]{
    \stepcounter{@tabls}
    \AtEndDocument{
      \begin{table}[p]
        #4
        \caption{#3}
        \label{tbl:#2}
      \end{table}\clearpage
    }
  }
}{
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
}
\renewcommand*{\l@figure}[2]{%
  \setlength{\@tempdima}{2.3em}%
  \noindent\hspace*{1.5em}#1\hfil\newline}
\let\l@table\l@figure
\renewcommand\listoffigures{%
  \section{\listfigurename
    \@mkboth{\MakeUppercase\listfigurename}%
    {\MakeUppercase\listfigurename}}%
  \@starttoc{lof}%
}
\renewcommand\listoftables{%
  \section{\listtablename
    \@mkboth{\MakeUppercase\listtablename}%
    {\MakeUppercase\listtablename}}%
  \@starttoc{lot}%
}
\AtEndDocument{
  \ifthenelse{\value{@tabls} > 0}{\newpage\listoftables}{}
  \ifthenelse{\value{@plots} > 0}{\newpage\listoffigures}{}
}}
\ifthenelse{\boolean{@revd}}{
  \RequirePackage{color}%
  \RequirePackage{ulem}%
  \normalem
}{}
\newcommand{\new}[1]{%
  \ifthenelse{\boolean{@revd}}{\textit{\textcolor{red}{#1}}}{#1}}
\newcommand{\old}[1]{\ifthenelse{\boolean{@revd}}{\textcolor{blue}{\sout{#1}}}{}}
\RequirePackage{natbib}
\bibpunct[,]{(}{)}{;}{a}{,}{,}
\DeclareRobustCommand{\refname}{REFERENCES}
\ifthenelse{\boolean{@manu}}
{\renewcommand\bibsection{\newpage\section{\refname}}}
{\renewcommand\bibsection{\section{\refname}}}
\newcommand{\shortcite}[1]{\citeyearpar{#1}}
\ifthenelse{\boolean{@manu}}{
  \renewcommand{\baselinestretch}{2.0}
}{
  \renewcommand{\baselinestretch}{1.0}
}
\ifthenelse{\boolean{@twoc}}{%
\setlength{\textheight}{9.375in}
\setlength{\textwidth}{7.5in}
\setlength{\oddsidemargin}{-0.5in}
\setlength{\evensidemargin}{-0.5in}
\setlength{\columnsep}{0.3125in}
\setlength{\parskip}{1ex plus0.1ex minus0.1ex} % should be a *rubber* length
\setlength{\topmargin}{-.71in}
\setlength{\textfloatsep}{30pt plus 3pt minus 6pt}
\setlength{\headsep}{0.2in}
}{%
\setlength{\textheight}{9in}
\setlength{\textwidth}{6in}
\setlength{\parskip}{1.5ex plus0.1ex minus0.1ex} % should be a *rubber* length
\setlength{\oddsidemargin}{.26in}
\setlength{\evensidemargin}{.26in}
\setlength{\topmargin}{-.51in}
\setlength{\textfloatsep}{30pt plus 3pt minus 6pt}
\setlength{\headsep}{0.5in}}
\let\seg@large\large
\let\seg@Large\Large
\renewcommand{\Large}{\protect\seg@large}
\let\seg@section\section
\let\seg@subsection\subsection
\let\seg@subsubsection\subsubsection
\newcommand{\segsection}{%
\@startsection {section}{1}{\z@}%
{-3.5ex \@plus -1ex \@minus -.2ex}%
{1ex \@plus .2ex}%
{\normalfont\Large\bfseries\MakeUppercase}}
\def\section{\@ifstar{\segsection*}{\segsection*}}
\def\subsection{\@ifstar{\seg@subsection*}{\seg@subsection*}}%
\def\subsubsection{\@ifstar{\seg@subsubsection*}{\seg@subsubsection*}}
\newcommand{\seg@title}{}
\newenvironment{geo@title}{%
  \begin{minipage}{\textwidth}%
    \bfseries\seg@Large\ifthenelse{\boolean{@twoc}}{\flushleft}{\centering}}
       {\end{minipage}\vspace{.2in}}%
\renewcommand{\title}[1]{%
  \renewcommand{\seg@title}{%
    \noindent\begin{geo@title}\setlength{\parindent}{0em}\par%
   {\smallskip #1}\end{geo@title}}}
\providecommand{\seg@address}{}
\providecommand{\address}[1]{\renewcommand{\seg@address}{#1}}
\providecommand{\seg@author}{}
\renewcommand{\author}[1]{%
  \renewcommand{\seg@author}{%
    \ifthenelse{\boolean{@twoc}}{%
      \seg@title \\
      \begin{flushleft}
\Large #1\footnote{\seg@address}
      \end{flushleft}\vspace{0.2in}
    }{%
      \seg@title
      \begin{center}
        \ifthenelse{\boolean{@manu}}{%
          \textbf{#1} \\
          \emph{\seg@address}\ \\
          (\today) \\
        }{\textit{#1}\ifthenelse{\equal{\seg@email}{.}}{}{%
            \footnote{\textbf{e-mail: }\seg@email}} \\ \
        }
      \end{center}
    }}}
\renewcommand{\maketitle}{\ifthenelse{\boolean{@shrt}}{%
    \ifthenelse{\boolean{@twoc}}{\twocolumn[\seg@author]}{\seg@author}}{}}
\ifthenelse{\boolean{@manu}}{
  \renewenvironment{abstract}{\seg@author
    \section{ABSTRACT}}{\newpage}
}
{
  \ifthenelse{\boolean{@twoc}}{\RequirePackage{multicol}}{}
  \newsavebox{\seg@abstract}
  \setlength{\fboxsep}{10pt}
  \renewenvironment{abstract}{
     \begin{lrbox}{\seg@abstract}\begin{minipage}{0.95\textwidth}%
        \centerline{\Large\textbf{ABSTRACT}}\medskip%
        \ifthenelse{\boolean{@twoc}}{\begin{multicols}{2}}{}}{%
    \ifthenelse{\boolean{@twoc}}{\end{multicols}}{\medskip}%
     \end{minipage}\end{lrbox}%
     \ifthenelse{\boolean{@shrt}}{}{%
       \ifthenelse{\boolean{@twoc}}{%
 \twocolumn[\vspace{1.8in}\seg@author%
   \noindent\fbox{\usebox{\seg@abstract}}\bigskip]}{%
 \vspace{0.3in}\seg@author\noindent\fbox{\usebox{\seg@abstract}}}}
  }
}
\ifthenelse{\boolean{@manu}}
{\pagestyle{plain}\thispagestyle{plain}}
{\newcommand{\ps@seg}{%
\ifthenelse{\boolean{@twoc}}{%
\renewcommand{\@oddhead}{%
\seg@foot\hfill\textbf{\seg@rhead}\hfill\textbf{\thepage}}
\renewcommand{\@evenhead}{%
\textbf{\thepage}\hfill\textbf{\seg@lhead}\hfill\seg@foot}
\renewcommand{\@oddfoot}{}
\renewcommand{\@evenfoot}{}}{%
\renewcommand{\@oddhead}{%
\makebox[2.5in][l]{\textit{\seg@lhead}}\hfill\thepage\hfill%
\makebox[2.5in][r]{\textit{\seg@rhead}}}%
\renewcommand{\@evenhead}{\@oddhead}%
\renewcommand{\@oddfoot}{\hfill\textit{\seg@foot}\hfill}%
\renewcommand{\@evenfoot}{\@oddfoot}}}
  % In general, there is a different page style on the first page.
\newcommand{\ps@segone}{%
\renewcommand{\@oddhead}{}%
\renewcommand{\@evenhead}{}%
\ifthenelse{\boolean{@twoc}}{%
  \renewcommand{\@oddfoot}{\hfill\textbf{\thepage}\hfill}
}{\renewcommand{\@oddfoot}{\hfill\textit{\seg@foot}\hfill}}%
\renewcommand{\@evenfoot}{\@oddfoot}}
\pagestyle{seg}\thispagestyle{segone}}
\newcounter{@append}
\ifthenelse{\boolean{@manu}}{%
  \AtEndDocument{\setcounter{@append}{0}}}{}
\providecommand{\append@name}{A}
\providecommand{\appendname}[1]{\renewcommand{\append@name}{#1}}
\renewcommand{\appendix}{%
  \ifthenelse{\equal{\append@name}{A}}{%
    \renewcommand{\append@name}{\Alph{@append}}}{}
  \setcounter{equation}{0}%
  \renewcommand{\theequation}{\mbox{\append@name-\arabic{equation}}}%
  \ifthenelse{\boolean{@manu}}{%
    \AtEndDocument{
      \setcounter{figure}{0}%
      \renewcommand{\thefigure}{\append@name-\arabic{figure}}%
      \stepcounter{@append}
    }
  }{%
    \setcounter{figure}{0}%
    \renewcommand{\thefigure}{\append@name-\arabic{figure}}%
  }
  \stepcounter{@append}
}
\providecommand{\append}[1]{%
\appendix\section{Appendix \append@name}\section{#1}}
\RequirePackage{verbatim}
\RequirePackage{moreverb}
\endinput
%%
%% End of file `geophysics.cls'.
