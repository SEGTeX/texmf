\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{geophysics}[2003/04/22 v0.1 Geophysics paper]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Author: Sergey Fomel sergey@sep.stanford.edu
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions*

\LoadClass[11pt]{article}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% SEG-style vectors and tensors
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\providecommand{\sv}[1]{\ensuremath{\mathbf{#1}}}
\newcommand{\under@tilde}[1]{\mathord{\vtop{\ialign{##\crcr
        $\hfil\displaystyle{#1}\hfil$\crcr\noalign{\kern1.5pt\nointerlineskip}
        $\hfil\tilde{}\hfil$\crcr\noalign{\kern1.5pt}}}}}
\providecommand{\st}[1]{\ensuremath{\under@tilde{\sv{#1}}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Figures and Tables
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\providecommand{\@pathname}{.}
\providecommand{\inputdir}[1]{\renewcommand{\@pathname}{#1}}
\providecommand{\figdir}{.}
\providecommand{\fig@file}[1]{\@pathname/\figdir/#1}

\RequirePackage{graphicx}    % for \plot 
\providecommand{\plot}[4][X]{%
\AtEndDocument{%
\begin{figure}[p]
\centering
\includegraphics[#3]{\fig@file{#2}}
\caption[#4]{}
\label{fig:#2}
\end{figure}\clearpage}}

\AtEndDocument{%
\newpage
%\protect\ifthenelse{\value{table} > 0}{\listoftables}{}%
%\protect\ifthenelse{\value{figure} > 0}{\listoffigures}{}%
%\listoftables
\listoffigures
\setcounter{figure}{0}%
\renewcommand{\thefigure}{\arabic{figure}}}%

% copied from article.cls and hacked
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1.}%
  \ifdim \wd\@tempboxa >\hsize
    #1.\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

% copied from article.cls and hacked
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
    \clearpage
    }

% to suppress page numbers from lof
\renewcommand*{\l@figure}[2]{%
  \setlength{\@tempdima}{2.3em}%
  \noindent\hspace*{1.5em}#1\hfil\newline}
\let\l@table\l@figure

\providecommand{\tabl}[1]{%
\AtEndDocument{%
\begin{table}[p]
#1
\end{table}\clearpage}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  References
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{natbib}        % for \cite
\bibpunct[,]{(}{)}{;}{a}{,}{,} % default
\DeclareRobustCommand{\refname}{REFERENCES}
\renewcommand\bibsection{\newpage\section{\refname}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Fonts
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{times}       % postscript fonts
\RequirePackage{mathptm}     % postscript math fonts

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Paper layout
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\baselinestretch}{2.0} % double spacing
\pagestyle{plain}
\thispagestyle{plain}
\setlength{\textheight}{9in}
\setlength{\textwidth}{6in}
\setlength{\parskip}{1.5ex plus0.1ex minus0.1ex} % should be a *rubber* length
\setlength{\oddsidemargin}{.26in}
\setlength{\evensidemargin}{.26in}
\setlength{\topmargin}{-.51in}
\setlength{\textfloatsep}{30pt plus 3pt minus 6pt}
\setlength{\headsep}{0.5in}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Section headings
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\let\seg@large\large
\let\seg@Large\Large
\renewcommand{\Large}{\protect\seg@large}
\let\seg@section\section
\let\seg@subsection\subsection
\let\seg@subsubsection\subsubsection
\newcommand{\segsection}[1]{\seg@section*{#1}}
\renewcommand{\section}[2][]{\segsection{\MakeUppercase{#2}}}%
\def\subsection{\seg@subsection*}%
\def\subsubsection{\seg@subsubsection*}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Title and Author
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\seg@title}{}
\newenvironment{geo@title}{%
\vspace{.3in}\begin{minipage}{\textwidth}%
\bfseries\seg@Large\centering}
{\end{minipage}\vspace{.2in}}
\renewcommand{\title}[1]{%
\renewcommand{\seg@title}{%
\noindent\begin{geo@title}\setlength{\parindent}{0em}\par%
{\smallskip #1}\end{geo@title}}}

\providecommand{\seg@address}{}
\providecommand{\address}[1]{\renewcommand{\seg@address}{\emph{#1}}}
\providecommand{\seg@author}{}
\renewcommand{\author}[1]{%
\renewcommand{\seg@author}{%
  \seg@title
\begin{centering}
  \textbf{#1} \\
  \seg@address \\
  (\today) \\
\end{centering}}}

\renewcommand{\maketitle}{\seg@author}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% abstract is an environment, ABS is a command
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\providecommand{\ABS}[1]{%
\section{ABSTRACT} 
#1
\newpage}
\renewenvironment{abstract}{%
%\begin{minipage}{\textwidth}
\section{ABSTRACT}}
{%\end{minipage}
\newpage}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Appendix - needs cleaning
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcounter{@append}
\providecommand{\append@name}{A}
\providecommand{\appendname}[1]{\renewcommand{\append@name}{#1}}
\renewcommand{\appendix}{%
\ifthenelse{\equal{\append@name}{A}}{%
\renewcommand{\append@name}{\Alph{@append}}}{}
\setcounter{equation}{0}\setcounter{figure}{0}%%
\renewcommand{\theequation}{\mbox{\append@name-\arabic{equation}}}%
\renewcommand{\thefigure}{\append@name-\arabic{figure}}\stepcounter{@append}}
\providecommand{\APPENDIX}[1]{\appendname{#1}\appendix\section{APPENDIX\ #1}}
