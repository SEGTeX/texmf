\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cwpmdpi}[]

% Pass options (including journal short name) to base mdpi class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{mdpi}}
\ProcessOptions*
\LoadClass{mdpi}

% ------------------------------------------------------------
% Fix Header Height Warning & Link Color Hooks
% ------------------------------------------------------------
\setlength{\headheight}{20.0pt}
\addtolength{\topmargin}{-8.0pt}

\providecommand{\@urlcolor}{blue}
\providecommand{\@linkcolor}{blue}
\providecommand{\@citecolor}{blue}

% ------------------------------------------------------------
% Paths & Graphics Search
% ------------------------------------------------------------
\graphicspath{{/Users/psava/Library/texmf/tex/latex/cwp/}}

% ------------------------------------------------------------
% Safe Defaults (Prevents \begin{document} crashes)
% ------------------------------------------------------------
\gdef\@Title{}
\gdef\@title{}
\gdef\@Author{}
\gdef\@author{}
\gdef\@address{}
\gdef\@Address{}
\gdef\@abstract{}
\gdef\@keyword{}

% ------------------------------------------------------------
% Metadata Overrides & Hooking MDPI's Internal Layout Engine
% ------------------------------------------------------------
\gdef\Title#1{\gdef\@Title{#1}\gdef\@title{#1}}
\gdef\Author#1{\gdef\@Author{#1}\gdef\@author{#1}}
\gdef\Address#1{\gdef\@address{#1}\gdef\@Address{#1}}
\gdef\Abstract#1{\gdef\@abstract{#1}}

\gdef\title#1{\Title{#1}}
\gdef\author#1{\Author{#1}}
\gdef\address#1{\Address{#1}}
\gdef\affil#1{\Address{#1}}
\gdef\journal#1{\gdef\@journal{#1}\gdef\@journalfull{#1}}
\gdef\Journal#1{\journal{#1}}

% Defaults for MDPI numeric sequence engine
\gdef\@doiabbr{journal}
\gdef\@pubvolume{1}
\gdef\@issuenum{1}
\gdef\@articlenumber{1}
\expandafter\gdef\csname @article-number\endcsname{1}

\providecommand{\doiabbr}[1]{\gdef\@doiabbr{#1}}
\providecommand{\pubvolume}[1]{\gdef\@pubvolume{#1}}
\providecommand{\issuenum}[1]{\gdef\@issuenum{#1}}
\providecommand{\articlenumber}[1]{%
  \gdef\@articlenumber{#1}%
  \expandafter\gdef\csname @article-number\endcsname{#1}%
}

\providecommand{\@datepublished}{\today}
\providecommand{\@datereceived}{\today}
\providecommand{\@daterevised}{\today}
\providecommand{\@dateaccepted}{\today}

% ------------------------------------------------------------
% Force MDPI Header Layout Construction
% ------------------------------------------------------------
% Re-executes MDPI's internal \@maketitle routine after mdpi.tex 
% populates all title, author, address, and abstract macros.
% Defer the full MDPI header to the body. The stock class prints
% title/abstract via \AfterEndPreamble, before the Madagascar body sets the
% front-matter macros; neutralize those so nothing prints empty, and re-run the
% real routines from \makemdpiheader once \Title/\Author/\address/\abstract/
% \keyword are populated.
\let\cwp@maketitle\maketitle
\let\cwp@maketitlen\maketitlen
\@ifundefined{abstractkeywords}{\let\cwp@abstractkeywords\relax}%
  {\let\cwp@abstractkeywords\abstractkeywords}
\renewcommand{\maketitle}{}
\renewcommand{\maketitlen}{}
\@ifundefined{abstractkeywords}{}{\renewcommand{\abstractkeywords}{}}
\newcommand{\makemdpiheader}{%
  \begingroup
  \cwp@maketitle
  \cwp@maketitlen
  \cwp@abstractkeywords
  \endgroup
}

% ------------------------------------------------------------
% Pathing and Figures
% ------------------------------------------------------------
\newcommand{\@path}{.}
\newcommand{\inputdir}[1]{\renewcommand{\@path}{#1}}
\providecommand{\figdir}{Fig}
\providecommand{\fig@file}[1]{\@path/\figdir/#1}

\newcommand{\plot}[3]{%
  \begin{figure*}
    \centering
    \includegraphics[#2]{\fig@file{#1}}
    \caption{#3}
    \label{fig:\@path-#1}
    \label{fig:#1}
\end{figure*}}

\newcommand{\sideplot}[3]{%
  \begin{figure*}
    \makebox{%
      \begin{minipage}{0.4\textwidth}
        \caption{#3}
        \label{fig:\@path-#1}
        \label{fig:#1}
      \end{minipage}
      \hfill
      \begin{minipage}{0.6\textwidth}
        \centering
        \includegraphics[#2]{\fig@file{#1}}
    \end{minipage}}
\end{figure*}}

% ------------------------------------------------------------
% Subfigure / Multiplot support
% ------------------------------------------------------------
\def\next@item#1,#2?{#1}
\def\rest@item#1,#2?{#2}
\newcounter{sub@fig}

\newcommand{\multiplot}[4]{
  \begin{figure}
    \centering
    \setcounter{sub@fig}{0}
    \edef\list@i{#2}
    \loop
    \edef\item@i{\expandafter\next@item\list@i,\empty?}
    \edef\list@i{\expandafter\rest@item\list@i,\empty?}
    \ifx\item@i\empty
    \else
    \stepcounter{sub@fig}
    \subfigure[]{\includegraphics[#3]{\fig@file{\item@i}}%
      \label{fig:\item@i}
      \label{fig:\@path-\item@i}
    }
    \ifthenelse{\value{sub@fig} = #1}{\\ \setcounter{sub@fig}{0}}{}
    \repeat
    \caption{#4}
    \label{fig:#2}
    \label{fig:\@path-#2}
  \end{figure}
}

\newcommand{\sidemultiplot}[4]{
  \begin{figure}
    \centering
    \setcounter{sub@fig}{0}
    \edef\list@i{#2}
    \loop
    \edef\item@i{\expandafter\next@item\list@i,\empty?}
    \edef\list@i{\expandafter\rest@item\list@i,\empty?}
    \ifx\item@i\empty
    \else
    \stepcounter{sub@fig}
    \subfigure[]{\includegraphics[#3]{\fig@file{\item@i}}%
      \label{fig:\item@i}
      \label{fig:\@path-\item@i}
    }
    \ifthenelse{\value{sub@fig} = #1}{\\ \setcounter{sub@fig}{0}}{}
    \repeat
    \caption{#4}
    \label{fig:#2}
    \label{fig:\@path-#2}
  \end{figure}
}