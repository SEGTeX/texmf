\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cwpreport}[2006/03/20 v0.1 CWP report]

\LoadClass{othercwp01}

% ------------------------------------------------------------
\RequirePackage{graphicx}

\newcommand{\@path}{.}
\newcommand{\inputdir}[1]{\renewcommand{\@path}{#1}}
\providecommand{\figdir}{Fig}
\providecommand{\fig@file}[1]{\@path/\figdir/#1}

% ------------------------------------------------------------
\newcommand{\plot}[3]{%
\begin{figure*}
\centering
\includegraphics[#2]{\fig@file{#1}}
\caption{#3}
\label{fig:#1}
\end{figure*}}

% ------------------------------------------------------------
\newcommand{\sideplot}[3]{%
\begin{figure*}
\makebox{%
  \begin{minipage}{0.4\textwidth}
    \caption{#3}
    \label{fig:#1}
  \end{minipage}
  \hfill
  \begin{minipage}{0.6\textwidth}
    \centering
    \includegraphics[#2]{\fig@file{#1}}
  \end{minipage}}
\end{figure*}}

% ------------------------------------------------------------
\newlength{\box@width}
\setlength{\box@width}{\textwidth}
\addtolength{\box@width}{-20pt} 
\setlength{\fboxsep}{10pt}

\newcommand{\boxit}[1]{\noindent\fbox{\parbox{\box@width}{#1}}}

\RequirePackage{subfigure}
\RequirePackage{ifthen}

\def\next@item#1,#2?{#1}
\def\rest@item#1,#2?{#2}
\newcounter{sub@fig}
\newcommand{\multiplot}[4]{
  \begin{figure*}
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
      \label{fig:\item@i}}
    \ifthenelse{\value{sub@fig} = #1}{\\ \setcounter{sub@fig}{0}}{}
    \repeat
    \caption{#4}
    \label{fig:#2}
  \end{figure*}
}

