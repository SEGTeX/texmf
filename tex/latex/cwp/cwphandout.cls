\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{handout}[2003/09/01 v0.1 handouts for class]

\RequirePackage{ifthen}
\RequirePackage{times}

\newboolean{@web}
\DeclareOption{web}{\setboolean{@web}{true}}
\DeclareOption{noweb}{\setboolean{@web}{false}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{noweb}
\ProcessOptions*

\LoadClass{article}

\ifthenelse{\boolean{@web}}{%
\RequirePackage[pdftex,tight]{web}
\setlength{\textwidth}{4.6in}
\hypersetup{pdfpagescrop=53 436 421 704}
\def\web@chapter{Chapter}
%
% Routines for typesetting toc entries - copied from web.sty and hacked
%
\def\webtableofcontents{\begingroup
%
% Sample line from .aux
%   \contentsline {section}{\numberline {1}Introduction}{4}{section.1}
%   \contentsline {section}{\numberline {}References}{56}{section*.1}
%                                   #1                 #2   #3
\parindent20pt
\def\par{\endgraf\leftskip=0pt}%
%\def\contentsname{Table of Contents}
\def\numberline##1{\llap{##1\enspace}}%
\def\contentsline##1##2##3##4{\csname web@##1\endcsname{##2}{##3}{##4}}%
\def\web@parse##1##2##3\\{\def\web@title{##3}\def\numberline{##2}}%
\def\web@chapter##1##2##3{\web@parse##1\\\par\mbox{}\textbf{%
  \ifx\numberline\empty
    \hyperlink{##3}{\web@title}%
  \else
    \llap{\hyperlink{##3}{\numberline.}\space}\web@title
  \fi}%
  \endgraf
  }
\def\web@section##1##2##3{\web@parse##1\\\par\penalty-50 \hspace{20pt}\mbox{}%
    \textbf{\llap{\hbox to20pt{\hyperlink{##3}{\numberline.}\space\hfil}}\web@title}\endgraf}%
\def\web@subsection##1##2##3{\web@parse##1\\\def\numberline{\strut$\bullet$}%
   \leftskip40pt\noindent\unskip\mbox{}\penalty-50\hyperlink{##3}{\ \numberline}~\web@title\ }%
\@starttoc{toc}
\leftskip40pt
\par\endgroup}
}{}

\newcommand{\newslide}{\ifthenelse{\boolean{@web}}{\clearpage}{}}

\ifthenelse{\boolean{@web}}{}{%
\setlength{\textheight}{9.5in}
\setlength{\textwidth}{6.5in}
\setlength{\parskip}{1.5ex plus0.1ex minus0.1ex} % should be a *rubber* length
\setlength{\oddsidemargin}{.01in}
\setlength{\evensidemargin}{.01in}
\setlength{\topmargin}{-0.51in}
\setlength{\textfloatsep}{30pt plus 3pt minus 6pt}
\setlength{\headsep}{0in}}

\newcommand{\@name}{Paul Sava}
\renewcommand{\author}[1]{\renewcommand{\@name}{#1}}

\newcommand{\@hdate}{\today}
\renewcommand{\date}[1]{\renewcommand{\@hdate}{#1}}

\newcommand{\@cname}{Class Name}
\renewcommand{\title}[2]{%
\hspace{-1.00in}
\vspace{-0.50in}
\includegraphics[width=0.50in]{CSMlogo}
\hspace{+0.20in}
\begin{minipage}{\textwidth}
  \vspace{-1.00in}
  \begin{center}
  {\small \textbf{#1} \hfill \textbf{#2} \\
  \textbf{\@name} \hfill \@hdate } \\ 
  \hrulefill
  \end{center}
  \end{minipage}
  }

% to make section headings smaller
\renewcommand{\Large}{\protect\normalsize\centering}%
\renewcommand{\large}{\protect\normalsize}

\let\sep@section\section
\let\sep@subsection\subsection
\let\sep@subsubsection\subsubsection
\newcommand{\sepsection}[1]{\sep@section*{#1}}
\renewcommand{\section}[2][]{\sepsection{\MakeUppercase{#2}}}%
\def\subsection{\sep@subsection*}%
\def\subsubsection{\sep@subsubsection*}

\RequirePackage{natbib}
\DeclareRobustCommand{\refname}{REFERENCES}
\DeclareRobustCommand{\bibname}{\protect\large~REFERENCES}
\renewcommand{\bibsection}{\section{\refname}}

\RequirePackage{graphicx}

\newcommand{\@path}{.}
\newcommand{\inputdir}[1]{\renewcommand{\@path}{#1}}
\providecommand{\figdir}{Fig}
\providecommand{\fig@file}[1]{\@path/\figdir/#1}

\newcommand{\plot}[4][htbp]{%
  \begin{figure*}[#1]
    \centering
    \includegraphics[#3]{\fig@file{#2}}
    \caption{#4}
    \label{fig:\@path-#2}
    \label{fig:#2}
\end{figure*}}

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

% simple figure
\newcommand{\figplot}[4][htbp]{
  \begin{figure}[#1]
    \centering
    \includegraphics[#3]{\fig@file{#2}}
    \label{fig:#2}
  \end{figure}
}

\newcommand{\shortcite}[1]{\citet{#1}}
