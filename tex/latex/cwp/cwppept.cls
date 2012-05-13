\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pept}[]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{svjour3}}
\ProcessOptions*
\LoadClass{svjour3}

\RequirePackage{natbib}
\RequirePackage{graphicx}
\RequirePackage{ifthen}

% ------------------------------------------------------------

\newcommand{\@path}{.}
\newcommand{\inputdir}[1]{\renewcommand{\@path}{#1}}
\providecommand{\figdir}{Fig}
\providecommand{\fig@file}[1]{\@path/\figdir/#1}

% ------------------------------------------------------------
\newcommand{\plot}[4][htbp]{%
  \begin{figure*}[#1]
    \centering
    \includegraphics[#3]{\fig@file{#2}}
    \caption{#4}
    \label{fig:\@path-#2}
    \label{fig:#2}
\end{figure*}}

% ------------------------------------------------------------
\newcommand{\sideplot}[4][htbp]{%
  \begin{figure*}[#1]
    \makebox{%
      \begin{minipage}{0.4\textwidth}
	\caption{#4}
	\label{fig:#2}
      \end{minipage}
      \hfill
      \begin{minipage}{0.6\textwidth}
	\centering
	\includegraphics[#3]{\fig@file{#2}}
    \end{minipage}}
\end{figure*}}

\newlength{\box@width}
\setlength{\box@width}{\textwidth}
\addtolength{\box@width}{-20pt} 
\setlength{\fboxsep}{10pt}

\newcommand{\boxit}[1]{\noindent\fbox{\parbox{\box@width}{#1}}}

% ------------------------------------------------------------
\RequirePackage{subfigure}
\def\next@item#1,#2?{#1}
\def\rest@item#1,#2?{#2}
\newcounter{sub@fig}

\newcommand{\multiplot}[5][htbp]{
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
      \label{fig:\item@i}
      \label{fig:\@path-\item@i}
    }
    \ifthenelse{\value{sub@fig} = #2}{\\ \setcounter{sub@fig}{0}}{}
    \repeat
    \caption{#5}
    \label{fig:#3}
    \label{fig:\@path-#3}
  \end{figure*}
}
