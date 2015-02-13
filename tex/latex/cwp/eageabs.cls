%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This is file 'eageabs.cls' %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Made by: Bobby Hak, Tristan van Leeuwen
%% modified by Paul Sava (CWP)
%%
%% This class has been tested with:
%%     teTeX version 0.4 and
%%     MikTeX version 
%%
%% It is based on the standard LaTeX2e "article" class and some
%% standard packages:
%%    times    - for the font Times New Roman, 11pt
%%    fancyhdr - for defining headnote and footnote
%%    graphicx - for including logo
%%
%% All packages should be availble in any normal distribution of LaTeX,
%% or can be downloaded from the CTAN homepage:
%%    www.ctan.org
%%
\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\ProvidesClass{eageabs}[2009/05/01 v1.0 EAGE Abstract Class]
%%
%% Pass all options directly to 'article'
%%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
%%
%% prefered fontsize, papersize, and type
%%
\LoadClass[twoside,11pt,a4paper]{article}
%%
%% prefered fonts: Times New Roman becomes the standard font (text)
%%
\RequirePackage{times}
%%
%% needed to define running footer and line
%% including logo, Figures is eps format
%%
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
%%
%% Page size formats
%%
\setlength{\oddsidemargin}{0.0in} % left boundary
\setlength{\evensidemargin}{0.0in} % left boundary
\setlength{\hoffset}{0.0in}
%
\setlength{\voffset}{-0.25in}
\setlength{\topmargin}{-0.6in}
\setlength{\headsep}{0.04in}
\setlength{\headheight}{0.85in}
%
\setlength{\textwidth}{6.3in}
\setlength{\textheight}{9.66in}
\setlength{\marginparsep}{0.0in}
\setlength{\marginparwidth}{0.0in}
\setlength{\marginparpush}{0.0in}
\setlength{\footskip}{0.0in}\addtolength{\footskip}{2\baselineskip}
%%
%% set header and footer
%%
\pagestyle{fancy} % load package
\fancyhf{} % clear styles
\fancyhead[RO,RE]{\includegraphics[height=0.76in,width=2.34in]{eagelogo}} % input logo top right, even and odd side
\renewcommand{\headrulewidth}{0pt} % no line in header
%
\fancyfoot[CO,CE]{\fontsize{10}{10}\selectfont{77\textsuperscript{th} EAGE Conference \& Exhibition 2015 \\ Madrid, Spain, 1 -- 4 June 2015}} % footnote
\renewcommand{\footrulewidth}{0.5pt} % add line in footnote
% \renewcommand{\footrule}{%
%   \vskip-\footruleskip\vskip-\footrulewidth 
%   \hrule width\headwidth height\footrulewidth\vskip\footruleskip}
\pagenumbering{gobble} % define page numbering
%%
%% section headers
%%
\renewcommand{\section}{\@startsection{section}{1}{0pt}{-1.5ex plus -1ex minus -.2ex}{.1ex plus .2ex}{\fontsize{11}{11}\selectfont\bf}} % redefine section command
\setcounter{secnumdepth}{0} % no numbering of sections


% ------------------------------------------------------------
% ------------------------------------------------------------
% ------------------------------------------------------------
% ------------------------------------------------------------

% ------------------------------------------------------------
\RequirePackage{graphicx}
\RequirePackage{ifthen}

\newcommand{\@path}{.}
\newcommand{\inputdir}[1]{\renewcommand{\@path}{#1}}

\providecommand{\figdir}{Fig}
\providecommand{\fig@file}[1]{\@path/\figdir/#1}

% ------------------------------------------------------------
\newcommand{\plot}[4][htbp]{%
  \begin{figure*}
    \centering
    \includegraphics[#3]{\fig@file{#2}}
    \caption{#4}
    \label{fig:\@path-#2}
    \label{fig:#2}
\end{figure*}}

% ------------------------------------------------------------
\newcommand{\sideplot}[4][htbp]{%
  \begin{figure*}
    \makebox{%
      \begin{minipage}{0.4\textwidth}
	\caption{#4}
	\label{fig:#2}
      \end{minipage}
      \hfill
      \begin{minipage}{0.6\textwidth}
	\centering
	\includegraphics[#3]{\fig@file{#2}}
    \end{minipage}
    }
\end{figure*}}

% ------------------------------------------------------------
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
  \begin{figure*}
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

\newcommand{\sidemultiplot}[5][htbp]{%
  \begin{figure*}
    \makebox{%
      \begin{minipage}{0.4\textwidth}
	\caption{#5}
      \end{minipage}
      \hfill
      \begin{minipage}{0.6\textwidth}
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
	  \label{fig:\@path-\item@i}
	  \label{fig:\item@i}}
	\ifthenelse{\value{sub@fig} = #2}{\\ \setcounter{sub@fig}{0}}{}
	\repeat
	\label{fig:\@path-#3}
	\label{fig:#3}
    \end{minipage}}
\end{figure*}}

% ------------------------------------------------------------
\newboolean{@manu}
\setboolean{@manu}{false}
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
\providecommand{\append}[2][\append@name]{%
  \appendix\section{Appendix \append@name}\section{#2}
  \begingroup
  \def\@currentlabel{\append@name}%
  \label{#1}%
  \endgroup
}

% ------------------------------------------------------------
\RequirePackage{natbib}
\gdef\bibfont{\fontsize{10}{11}\selectfont}
\setlength{\bibsep}{0pt} % no lines between bibitems
\setlength{\bibhang}{1em} % indentation of second line in bibitem
\bibpunct[,]{(}{)}{;}{a}{,}{,}
\DeclareRobustCommand{\refname}{REFERENCES}
{\renewcommand\bibsection{\newpage\section{\refname}}}
{\renewcommand\bibsection{        \section{\refname}}}
\newcommand{\shortcite}[1]{\citet{#1}}

