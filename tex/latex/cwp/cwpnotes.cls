\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cwpslides}[2007/4/15 v0.1 CWP slides]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ExecuteOptions{notes}
\ExecuteOptions{notesonly}

\ProcessOptions*

\LoadClass[hyperref={bookmarks=false}]{beamer}
\setbeamertemplate{navigation symbols}{}

%\usetheme[hideothersubsections]{}
%\useoutertheme[height=0pt,right]{sidebar}
%\setbeamertemplate{frametitle}[default][left]

% ------------------------------------------------------------
% fonts
\usefonttheme{structurebold}
\setbeamerfont{title}        {size=\LARGE}
\setbeamerfont{subtitle}     {size=\Large}
\setbeamerfont{section}      {size=\Large}
\setbeamerfont{outline}      {size=\Large}
\setbeamerfont{frametitle}   {size=\LARGE}
\setbeamerfont{framesubtitle}{size=\large}
\setbeamerfont{author}       {size=\Large,     series=\bfseries}
\setbeamerfont{institute}    {size=\normalsize,series=\bfseries}
\setbeamerfont{date}         {size=\normalsize,series=\bfseries}

%\setbeamersize{
%  text margin  left=0.05in,
%  text margin right=0.05in
%}

% ------------------------------------------------------------
\newcommand{\red}  [1]{\textcolor{red}  {#1}}
\newcommand{\blue} [1]{\textcolor{blue} {#1}}
\definecolor{darkgreen}{rgb}{0,0.5,0}
\newcommand{\green}[1]{\textcolor{darkgreen}{#1}}

% ------------------------------------------------------------
\RequirePackage{ifthen}
\DeclareGraphicsExtensions{.pdf,.png}

% path to figures
\newcommand{\@path}{.}
\newcommand{\inputdir}[1]{\renewcommand{\@path}{#1}}
\providecommand{\figdir}{Fig}
\providecommand{\fig@file}[1]{\@path/\figdir/#1}

% plot command
\newcommand{\plot}[3]{
  \begin{center}
    \begin{overpic}[#2] {\@path/\figdir/#1}
      \begin{picture}(1,1) #3 \end{picture}
    \end{overpic}
  \end{center}
}

% sideplot command
\newcommand{\sideplot}[4][htbp]{
  \begin{figure}[#1]
    \makebox{
      \begin{minipage}{0.4\textwidth}
	#4
      \end{minipage}
      \hfill
      \begin{minipage}{0.6\textwidth}
	\centering
	\includegraphics[#3]{\fig@file{#2}}
    \end{minipage}}
\end{figure}}

% multiplot
\RequirePackage{subfigure}

\def\next@item#1,#2?{#1}
\def\rest@item#1,#2?{#2}
\newcounter{sub@fig}
\newcommand{\multiplot}[5][htbp]{
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
      \label{fig:\item@i}
      \label{fig:\@path-\item@i}
    }
    \ifthenelse{\value{sub@fig} = #2}{\\ \setcounter{sub@fig}{0}}{}
    \repeat
%    \caption{#5}
    \label{fig:#3}
    \label{fig:\@path-#3}
  \end{figure}
}

% ------------------------------------------------------------
% generate title page
\newcommand{\cwpcover}{
  \begin{frame}
    \titlepage
  \end{frame}
}

% generate outline slides
\newcommand{\cwpoutline}{
  \AtBeginSection[]{
    \begin{frame}<beamer> \frametitle{outline}             
      \tableofcontents[currentsection] % highlight current section
    \end{frame}
  }
}

% add note to slides
\def\cwpnote#1{ 
\note{
  \begin{multicols}{2} 
    \tiny{ #1 }
  \end{multicols}
}}

% ------------------------------------------------------------
