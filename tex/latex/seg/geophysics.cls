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
                                % \texttt{geophysics.cls} package conforms to the \LaTeX2e\ standard.

\RequirePackage{ifthen}
\newcommand{\@type}{}
\DeclareOption{manuscript}{\renewcommand{\@type}{manuscript}}
\DeclareOption{paper}{\renewcommand{\@type}{paper}}
\DeclareOption{book}{\renewcommand{\@type}{book}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{paper}
\ProcessOptions*
\LoadClass[11pt]{article}
\renewcommand{\vector}[1]{\ensuremath{\mathbf{\MakeLowercase{#1}}}}
\providecommand{\tensor}[1]{\ensuremath{\mathbf{\MakeUppercase{#1}}}}
\newcommand{\@path}{.}
\newcommand{\inputdir}[1]{\renewcommand{\@path}{#1}}
\providecommand{\figdir}{.}
\providecommand{\fig@file}[1]{\@path/\figdir/#1}
\RequirePackage{graphicx}
\DeclareGraphicsExtensions{.pdf,.eps,.ps}
\newcounter{@plots}
\setcounter{@plots}{0}
\ifthenelse{\equal{\@type}{manuscript}}
{\newcommand{\plot}[4][X]{
    \stepcounter{@plots}
    \AtEndDocument{
      \begin{figure}[p]
        \centering
        \includegraphics[#3]{\fig@file{#2}}
        \caption[#4]{}
        \label{fig:#2}
      \end{figure}\clearpage
    }}
  \long\def\@makecaption#1#2{%
    \vskip\abovecaptionskip
    \sbox\@tempboxa{#1.}%
    \ifdim \wd\@tempboxa >\hsize
    #1.\par
    \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
    \fi
    \vskip\belowcaptionskip}}
{\newcommand{\plot}[4][htbp]{%
    \begin{figure*}[#1]
      \centering
      \includegraphics[#3]{\fig@file{#2}}
      \caption{#4}
      \label{fig:#2}
    \end{figure*}
  }}
\ifthenelse{\equal{\@type}{manuscript}}
{\newcommand{\sideplot}[4][X]{\plot[#1]{#2}{#3}{#4}}}
{\newcommand{\sideplot}[4][htbp]{%
    \begin{figure*}[#1]
      \makebox{%
        \begin{minipage}{0.4\textwidth}
          \caption{#4}
          \label{fig:#2}
        \end{minipage}
        \hfill
        \begin{minipage}{0.6\textwidth}
          \flushright
          \includegraphics[#3]{\fig@file{#2.pdf}}
        \end{minipage}}
    \end{figure*}
  }}
\newcounter{@tabls}
\setcounter{@tabls}{0}
\ifthenelse{\equal{\@type}{manuscript}}{
  \providecommand{\tabl}[4][X]{
    \stepcounter{@tabls}
    \AtEndDocument{
      \begin{table}[p]
        #4
        \caption[#3]{}
        \label{tbl:#2}
      \end{table}\clearpage
    }
  }
}{
  \providecommand{\tabl}[4][htbp]{
    \begin{table}[#1]
      #4
      \caption{#3}
      \label{tbl:#2}
    \end{table}
  }
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
}
\RequirePackage{natbib}
\bibpunct[,]{(}{)}{;}{a}{,}{,}
\DeclareRobustCommand{\refname}{REFERENCES}
\ifthenelse{\equal{\@type}{manuscript}}
{\renewcommand\bibsection{\newpage\section{\refname}}}
{\renewcommand\bibsection{\section{\refname}}}
\newcommand{\shortcite}[1]{\citeyearpar{#1}}
\RequirePackage{mathptmx}
\ifthenelse{\equal{\@type}{manuscript}}{
  \renewcommand{\baselinestretch}{2.0}
}{
  \renewcommand{\baselinestretch}{1.0}
}
\setlength{\textheight}{9in}
\setlength{\textwidth}{6in}
\setlength{\parskip}{1.5ex plus0.1ex minus0.1ex} % should be a *rubber* length
\setlength{\oddsidemargin}{.26in}
\setlength{\evensidemargin}{.26in}
\setlength{\topmargin}{-.51in}
\setlength{\textfloatsep}{30pt plus 3pt minus 6pt}
\setlength{\headsep}{0.5in}
\let\seg@large\large
\let\seg@Large\Large
\renewcommand{\Large}{\protect\seg@large}
\let\seg@section\section
\let\seg@subsection\subsection
\let\seg@subsubsection\subsubsection
\newcommand{\segsection}[2][]{\seg@section*{\MakeUppercase{#2}}}
\def\section{\@ifstar{\segsection}{\segsection}}
\def\subsection{\@ifstar{\seg@subsection*}{\seg@subsection*}}%
\def\subsubsection{\@ifstar{\seg@subsubsection*}{\seg@subsubsection*}}
\newcommand{\seg@title}{}
\newenvironment{geo@title}{%
\vspace{.3in}\begin{minipage}{\textwidth}%
\bfseries\seg@Large\centering}{\end{minipage}\vspace{.2in}}
\renewcommand{\title}[1]{%
\renewcommand{\seg@title}{%
\noindent\begin{geo@title}\setlength{\parindent}{0em}\par%
{\smallskip #1}\end{geo@title}}}
\providecommand{\seg@address}{}
\providecommand{\address}[1]{\renewcommand{\seg@address}{\emph{#1}}}
\providecommand{\seg@email}{.}
\providecommand{\email}[1]{\renewcommand{\seg@email}{#1}}
\providecommand{\seg@author}{}
\renewcommand{\author}[1]{%
  \renewcommand{\seg@author}{%
    \seg@title
      \begin{centering}
        \ifthenelse{\equal{\@type}{manuscript}}{%
          \textbf{#1} \\
          \seg@address\ \\
          (\today) \\
        }{\textit{#1}\ifthenelse{\equal{\seg@email}{.}}{}{%
            \footnote{\textbf{e-mail: }\seg@email}} \\ \
        }
      \end{centering}
    }}
\renewcommand{\maketitle}{\seg@author}
\ifthenelse{\equal{\@type}{manuscript}}{
  \renewenvironment{abstract}{\section{ABSTRACT}}{\newpage}
}
{
  \newsavebox{\seg@abstract}
  \setlength{\fboxsep}{10pt}
  \renewenvironment{abstract}{
    \begin{lrbox}{\seg@abstract}\begin{minipage}{0.95\textwidth}%
        \centerline{\textbf{ABSTRACT}}\medskip}{%
        \medskip\end{minipage}\end{lrbox}%
    \noindent\fbox{\usebox{\seg@abstract}}
  }
}
\newcommand{\seg@rhead}{}
\newcommand{\righthead}[1]{\renewcommand{\seg@rhead}{#1}}
\newcommand{\seg@lhead}{}
\newcommand{\lefthead}[1]{\renewcommand{\seg@lhead}{#1}}
\newcommand{\seg@foot}{}
\newcommand{\footer}[1]{\renewcommand{\seg@foot}{#1}}
\newcommand{\seg@head}{}
\newcommand{\header}[1]{\renewcommand{\seg@head}{#1}}
\ifthenelse{\equal{\@type}{manuscript}}
{\pagestyle{plain}\thispagestyle{plain}}
{\newcommand{\ps@seg}{%
\renewcommand{\@oddhead}{%
\makebox[2.5in][l]{\textit{\seg@lhead}}\hfill\thepage\hfill%
\makebox[2.5in][r]{\textit{\seg@rhead}}}%
\renewcommand{\@evenhead}{\@oddhead}%
\renewcommand{\@oddfoot}{\hfill\textit{\seg@foot}\hfill}%
\renewcommand{\@evenfoot}{\@oddfoot}}
\newcommand{\ps@segone}{%
\renewcommand{\@oddhead}{}%
\renewcommand{\@evenhead}{}%
\renewcommand{\@oddfoot}{\hfill\textit{\seg@foot}\hfill}%
\renewcommand{\@evenfoot}{\@oddfoot}}
\pagestyle{seg}\thispagestyle{segone}}
\newcounter{@append}
\ifthenelse{\equal{\@type}{manuscript}}{%
  \AtEndDocument{\setcounter{@append}{0}}}{}
\providecommand{\append@name}{A}
\providecommand{\appendname}[1]{\renewcommand{\append@name}{#1}}
\renewcommand{\appendix}{%
  \ifthenelse{\equal{\append@name}{A}}{%
    \renewcommand{\append@name}{\Alph{@append}}}{}
  \setcounter{equation}{0}%
  \renewcommand{\theequation}{\mbox{\append@name-\arabic{equation}}}%
  \ifthenelse{\equal{\@type}{manuscript}}{%
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
\providecommand{\append}[1]{\appendix\section{Appendix \append@name \\ #1}}
\RequirePackage{verbatim}
\RequirePackage{moreverb}
\endinput
%%
%% End of file `geophysics.cls'.
