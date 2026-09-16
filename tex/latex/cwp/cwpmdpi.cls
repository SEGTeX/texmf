\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cwpmdpi}[]

\RequirePackage{graphicx}
\RequirePackage{ifthen}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{mdpi}}
\ProcessOptions*
\LoadClass{mdpi}

% ------------------------------------------------------------
% Fix Header Height Warning
% ------------------------------------------------------------
\setlength{\headheight}{20.0pt}
\addtolength{\topmargin}{-8.0pt}

% ------------------------------------------------------------
% Paths & Graphics Search
% ------------------------------------------------------------
\graphicspath{{/Users/psava/Library/texmf/tex/latex/cwp/}}

% ------------------------------------------------------------
% MDPI Title, Author, & Address Metadata Aliases
% ------------------------------------------------------------
\gdef\title#1{\gdef\@Title{#1}\Title{#1}}
\gdef\author#1{\gdef\@Author{#1}\Author{#1}}
\gdef\address#1{\gdef\@address{#1}\Address{#1}}
\gdef\affil#1{\gdef\@address{#1}\Address{#1}}

% Safe defaults for basic title/author info
\providecommand{\@Title}{}
\providecommand{\@Author}{}
\providecommand{\@address}{}
\providecommand{\Address}[1]{\gdef\@address{#1}}

% ------------------------------------------------------------
% Strict Numeric & Metadata Defaults for MDPI Engine
% ------------------------------------------------------------
\gdef\@doiabbr{journal}
\gdef\@pubvolume{1}
\gdef\@issuenum{1}
\gdef\@journal{journal}

% Define both non-hyphenated and hyphenated variants for compatibility
\gdef\@articlenumber{1}
\expandafter\gdef\csname @article-number\endcsname{1}

\providecommand{\doiabbr}[1]{\gdef\@doiabbr{#1}}
\providecommand{\pubvolume}[1]{\gdef\@pubvolume{#1}}
\providecommand{\issuenum}[1]{\gdef\@issuenum{#1}}

% Update both internal macros when \articlenumber is called
\providecommand{\articlenumber}[1]{%
  \gdef\@articlenumber{#1}%
  \expandafter\gdef\csname @article-number\endcsname{#1}%
}

% Date default initializations
\providecommand{\@datepublished}{\today}
\providecommand{\@datereceived}{\today}
\providecommand{\@daterevised}{\today}
\providecommand{\@dateaccepted}{\today}

\providecommand{\datepublished}[1]{\gdef\@datepublished{#1}}
\providecommand{\datereceived}[1]{\gdef\@datereceived{#1}}
\providecommand{\daterevised}[1]{\gdef\@daterevised{#1}}
\providecommand{\dateaccepted}[1]{\gdef\@dateaccepted{#1}}

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