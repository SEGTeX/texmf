\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cwp08}[2008/03/29 v1.0 LaTeX2e document class]

%  Journals use two-sided printing.
%
\@twosidetrue
\@twocolumntrue
\@mparswitchtrue
\def\ds@draft{\overfullrule 5pt}
\def\ds@twocolumn{\@twocolumntrue}
\def\ds@onecolumn{\@twocolumnfalse}

\ExecuteOptions{letter,twoside,final}
\ProcessOptions


%  ****************************************
%  *               FONTS                  *
%  ****************************************
\lineskip 1pt
\normallineskip 1pt
\renewcommand\baselinestretch{1}

\renewcommand\normalsize{\@setfontsize\normalsize\@ixpt{12}%
  \abovedisplayskip 4pt plus 1pt minus 1pt
  \belowdisplayskip \abovedisplayskip
  \abovedisplayshortskip 4pt plus 1pt
  \belowdisplayshortskip \abovedisplayshortskip
  \let\@listi\@listI}
\newcommand\small{\@setfontsize\small\@viiipt{10}%
  \abovedisplayskip 4pt plus 1pt minus 1pt
  \belowdisplayskip \abovedisplayskip
  \abovedisplayshortskip 4pt plus 1pt
  \belowdisplayshortskip \abovedisplayshortskip
  \def\@listi{\leftmargin\leftmargini
    \topsep 2pt plus 1pt minus 1pt
    \parsep \z@
    \itemsep 2pt}}
\newcommand\footnotesize{\@setfontsize\footnotesize\@viiipt{10}%
  \abovedisplayskip 4pt plus 1pt minus 1pt
  \belowdisplayskip \abovedisplayskip
  \abovedisplayshortskip 4pt plus 1pt
  \belowdisplayshortskip \abovedisplayshortskip
  \renewcommand\@listi{\leftmargin\leftmargini
    \topsep 2pt plus 1pt minus 1pt
    \parsep \z@
    \itemsep 2pt}}
\newcommand\scriptsize{\@setfontsize\scriptsize\@vipt{8}}
\newcommand\tiny{\@setfontsize\tiny\@vpt{6}}

\newcommand\large{\@setfontsize\large\@xpt{12}}
\newcommand\Large{\@setfontsize\Large\@xiipt{14}}
\newcommand\LARGE{\@setfontsize\LARGE\@xivpt{17}}
\newcommand\huge{\@setfontsize\huge\@xviipt{20}}
\newcommand\Huge{\@setfontsize\Huge\@xxpt{25}}

\if@twocolumn
\renewcommand\normalsize{\@setfontsize\normalsize\@ixpt{11}%
  \abovedisplayskip 6pt plus 2pt minus 2pt
  \belowdisplayskip \abovedisplayskip
  \abovedisplayshortskip 6pt plus 2pt
  \belowdisplayshortskip \abovedisplayshortskip
  \let\@listi\@listI}
\renewcommand\large{\@setfontsize\large\@xpt{11}}
\fi

\normalsize
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}

%  ****************************************
%  *            PAGE LAYOUT               *
%  ****************************************
\setlength{\paperwidth}{8.5in}
\setlength{\paperheight}{11.0in}

\setlength{\textheight}{8.75in}
\setlength{\textwidth}{6.5in}


% SIDE MARGINS:
\setlength{\oddsidemargin}{+.015625in}
\setlength{\evensidemargin}{+.015625in}

\setlength\marginparwidth{4pc}
\setlength\marginparsep{0.5pc}

% VERTICAL SPACING:
\setlength{\headheight}{14pt}
\setlength{\headsep}   {15pt}
\setlength{\topskip}   {9pt}
\setlength{\footskip}  {26pt}

% DIMENSION OF TEXT:
\setlength{\topmargin}{-0.25in}

\setlength\columnsep{2pc}
\setlength\columnseprule{0pt}

% FOOTNOTES:
\setlength\footnotesep{6pt}
\setlength\skip{\footins 19.5pt plus 12pt minus 1pt}

% FLOATS:
\setlength\floatsep{ 12pt plus 5.5pt minus 1pt}
\setlength\textfloatsep{ 12pt plus 7.5pt}
\setlength\intextsep{ 12pt plus 5.5pt minus 2pt}
\setlength\dblfloatsep{ 12pt plus 5.5pt minus 2pt }
\setlength\dbltextfloatsep{ 15pt plus 4.5pt minus 3pt}

\setlength\@fptop{     0pt plus 0fil}
\setlength\@fpsep{    12pt plus 0fil}
\setlength\@fpbot{     0pt plus 3fil}
\setlength\@dblfptop{  0pt plus 0fil}
\setlength\@dblfpsep{ 12pt plus 0fil}
\setlength\@dblfpbot{  0pt plus 3fil}
\setlength\marginparpush{ 5pt }

%  ****************************************
%  *           PARAGRAPHING               *
%  ****************************************
\setlength\parskip{ \z@ plus .1pt }
\setlength\parindent{ 18pt }
\setlength\partopsep{ 0pt plus 1pt }
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\@beginparpenalty -\@lowpenalty
\@endparpenalty -\@lowpenalty
\@itempenalty -\@lowpenalty
\clubpenalty=0
\widowpenalty=10000

%  ****************************************
%  *       SECTION NUMBERS                *
%  ****************************************
\newcounter {section}
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\renewcommand\thesection       {               \arabic{section}}
\renewcommand\thesubsection    {\thesection.   \arabic{subsection}}
\renewcommand\thesubsubsection {\thesubsection.\arabic{subsubsection}}

%  ****************************************
%  *               SECTIONS               *
%  ****************************************
\def\@startsection#1#2#3#4#5#6{\if@noskipsec \leavevmode \fi
  \par \@tempskipa #4\relax
  \@afterindenttrue
  \ifdim \@tempskipa <\z@ \@tempskipa -\@tempskipa \@afterindentfalse\fi
  \if@nobreak
  \everypar{} \ifnum#2=2 \vskip 0pt plus1pt\fi % was 6pt
  \else
  \addpenalty{\@secpenalty}\addvspace{\@tempskipa}
  \fi \@ifstar
      {\@ssect{#3}{#4}{#5}{#6}}{\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}}

\def\GJ@hangraggedright{\rightskip=\@flushglue \let\\=\@centercr \parindent=0pt}

\def\section{\@startsection{section}{1}{\z@}
 {-24pt plus -12pt minus -1pt}{6pt}
 {\GJ@hangraggedright\reset@font\normalsize\bf}}
\def\subsection{\@startsection{subsection}{2}{\z@}
 {-18pt plus -9pt minus -1pt}{6pt}
 {\GJ@hangraggedright\reset@font\normalsize\bf}}
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}
 {-18pt plus -9pt minus -1pt}{6pt}
 {\GJ@hangraggedright\reset@font\normalsize\it}}

\setcounter{secnumdepth}{4}
%
\newif\if@levelone
%

\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
  \def\@svsec{}%
  \else
  \refstepcounter{#1}
  \ifnum #2=\@ne \global\@levelonetrue % if level=1 ie. section
  \ifGJ@appendix \edef\@svsec{}%
  \else \edef\@svsec{\csname the#1\endcsname\hskip 1em}%
  \fi
  \else \edef\@svsec{\csname the#1\endcsname\hskip 1em}%
  \fi
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
  \begingroup #6\relax
  \ifnum #2=\@ne
  \ifGJ@appendix
  \@hangfrom{\hskip #3\relax\@svsec}{\interlinepenalty \@M
    APPENDIX \csname the#1\endcsname:\hskip 0.5em\uppercase{#8}\par}%
  \else
  \@hangfrom{\hskip #3\relax\@svsec}{\interlinepenalty \@M
    \uppercase{#8}\par}%
  \fi
  \else
  \@hangfrom{\hskip #3\relax\@svsec}{\interlinepenalty \@M #8\par}%
  \fi
  \endgroup
  \csname #1mark\endcsname{#7}%
  \addcontentsline{toc}{#1}{\ifnum #2>\c@secnumdepth \else %ajw
    \protect\numberline{\csname the#1\endcsname}\fi #7}%ajw
  \else
  \def\@svsechd{#6\hskip #3\@svsec \ifnum #2=\@ne\uppercase{#8}\else #8\fi
    \csname #1mark\endcsname{#7}
    \addcontentsline{toc}{#1}{\ifnum #2>\c@secnumdepth \else %ajw
      \protect\numberline{\csname the#1\endcsname}\fi#7}%ajw
  }\fi
  \@xsect{#5}}

% from latex.tex
\def\@ssect#1#2#3#4#5{%
  \@tempskipa #3\relax
  \ifdim \@tempskipa>\z@
  \begingroup #4\@hangfrom{\hskip #1}{%
    \interlinepenalty \@M
    \if@levelone
    \uppercase{#5}\global\@levelonefalse
    \else{#5}
    \fi\par}%
  \endgroup
  \else
  \def\@svsechd{#4\hskip #1\relax
    \if@levelone
    \uppercase{#5}\global\@levelonefalse
    \else{#5}
    \fi}
  \fi
  \@xsect{#3}%
}

\newif\ifGJ@appendix
\def\appendix{\par
  \GJ@appendixtrue
  \setcounter{section}{0}
  \renewcommand\thesection{\Alph{section}}
  \renewcommand\thesubsection{\thesection\arabic{subsection}}
  \setcounter{equation}{0}
  \@newctr{equation}[section]
  \renewcommand\theequation{\hbox{\normalsize\Alph{section}\arabic{equation}}}
  \setcounter{figure}{0}
  \renewcommand\thefigure{A\@arabic\c@figure}
  \setcounter{table}{0}
  \renewcommand\thetable{A\@arabic\c@table}
}

%  ****************************************
%  *               SKIPS                  *
%  ****************************************
\newskip\@indentskip
\newskip\smallindent
\newskip\@footindent
\newskip\@leftskip
\@indentskip=18pt
\smallindent=1.5em
\@footindent=\smallindent
\@leftskip=\z@

%  ****************************************
%  *                LISTS                 *
%  ****************************************
\setlength\leftmargini{   \z@ }
\setlength\leftmarginii{  1.25pc }
\setlength\leftmarginiii{ 1.25pc }
\setlength\leftmarginiv{  1.25pc }
\setlength\leftmarginv{  1pc }
\setlength\leftmarginvi{  1pc }
\setlength\leftmargin{\leftmargini}
\setlength\labelsep{ 0.5em}
\labelwidth\leftmargini\advance\labelwidth-\labelsep
%
% label macros for Range-Left and Range-Right labels
\def\makeRLlabel#1{\rlap{#1}\hss}
\def\makeRRlabel#1{\hss\llap{#1}}
\def\makenewlabel#1{#1}
%
\def\@listI{\leftmargin\leftmargini
  \parsep \z@
  \topsep 6pt plus 1pt minus 1pt
  \itemsep \z@ plus .1pt
}
\let\@listi\@listI
\@listi
\def\@listii{\leftmargin\leftmarginii
  \labelwidth\leftmarginii\advance\labelwidth-\labelsep
  \topsep 6pt plus 1pt minus 1pt
  \parsep \z@
  \itemsep \z@ plus .1pt
}
\def\@listiii{\leftmargin\leftmarginiii
  \labelwidth\leftmarginiii\advance\labelwidth-\labelsep
  \topsep 6pt plus 1pt minus 1pt
  \parsep \z@
  \partopsep \z@
  \itemsep \topsep
}
\def\@listiv{\leftmargin\leftmarginiv
  \labelwidth\leftmarginiv\advance\labelwidth-\labelsep
}
\def\@listv{\leftmargin\leftmarginv
  \labelwidth\leftmarginv\advance\labelwidth-\labelsep
}
\def\@listvi{\leftmargin\leftmarginvi
  \labelwidth\leftmarginvi\advance\labelwidth-\labelsep
}

%
% ITEMIZE
\def\itemize{%
  \ifnum \@itemdepth >3 \@toodeep
  \else \advance\@itemdepth \@ne
  \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
  \list{\csname\@itemitem\endcsname}%
       {\let\makelabel\makeRRlabel}%
       \leftmargin 3.5em\labelsep 0.5em\itemindent 2.0em\labelwidth 0.5em%
       \fi}
\def\labelitemi{$\bullet$}
\def\labelitemii{--}
\def\labelitemiii{$\cdot$}
\def\labelitemiv{*}

%
% ENUMERATE
%  -- enumerate with optional argument to set left margin...
\def\enumerate{
  \ifnum \@enumdepth >3 \@toodeep 
  \else \advance\@enumdepth \@ne
  \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
  \fi
  \@ifnextchar [{\@enumeratetwo}{\@enumerateone}%
}
  
\def\@enumeratetwo[#1]{%
  \list{\csname label\@enumctr\endcsname}%
       {\settowidth\labelwidth{[#1]}
	 \leftmargin\z@
	 \usecounter{\@enumctr}
	 \let\makelabel\makenewlabel}
}
\def\@enumerateone{%
  \list{\csname label\@enumctr\endcsname}%
       {\usecounter{\@enumctr}\itemindent=1em
	 \let\makelabel\makenewlabel}
}

\renewcommand\theenumi{  {\rm \arabic{enumi}  .}}
\renewcommand\theenumii{ {\rm  (\alph{enumii} )}}
\renewcommand\theenumiii{{\rm (\roman{enumiii})}}
\renewcommand\theenumiv{ {\rm   \Alph{enumiv} .}}

\newcommand\labelenumi{  \theenumi}
\newcommand\labelenumii{ \theenumii}
\newcommand\labelenumiii{\theenumiii}
\newcommand\labelenumiv{ \theenumiv}

\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
%
% DESCRIPTION
\newcommand\descriptionlabel[1]{\bfseries #1}
\def\description{\list{}{\labelwidth\z@
    \leftmargin \z@
    \itemindent 1em
}}
\let\enddescription\endlist

%  ****************************************
%  *         OTHER ENVIRONMENTS           *
%  ****************************************
% TITLEPAGE
\def\titlepage{\@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
  \else \newpage \fi \thispagestyle{empty}\c@page\z@}
\def\endtitlepage{\if@restonecol\twocolumn \else \newpage \fi}

% ARRAY AND TABULAR
%
\setlength\arraycolsep{   5pt }
\setlength\tabcolsep{     6pt }
\setlength\arrayrulewidth{ .5pt }
\setlength\doublerulesep{ 1.5pt }

\def\tabular{\def\@halignto{}
\def\hline{\noalign{\ifnum0=`}\fi
  \vskip 3pt
  \hrule \@height \arrayrulewidth
  \vskip 3pt
  \futurelet \@tempa\@xhline}
\def\fullhline{\noalign{\ifnum0=`}\fi
  \vskip 3pt
  \hrule \@height \arrayrulewidth
  \vskip 3pt
  \futurelet \@tempa\@xhline}
\def\@xhline{\ifx\@tempa\hline
  \vskip -6pt
  \vskip \doublerulesep
  \fi
  \ifnum0=`{\fi}}
\def\@arrayrule{\@addtopreamble{\hskip -.5\arrayrulewidth
    \hskip .5\arrayrulewidth}}
\@tabular
}

% MINIPAGE
\skip\@mpfootins = \skip\footins

%  ****************************************
%  *         TITLE AND ABSTRACT           *
%  ****************************************
\def\maketitle{\par
 \begingroup
 \if@twocolumn
 \twocolumn[\vspace*{17pt}\@maketitle]
 \else
 \newpage
 \global\@topnum\z@
 \@maketitle
 \fi
 \thispagestyle{titlepage}
 \endgroup

 \let\maketitle\relax
 \let\@maketitle\relax
 \gdef\@author{}
 \gdef\@title{}
 \let\thanks\relax
}

\def\and{\end{author@tabular}\vskip 3pt\par
 \begin{author@tabular}[t]{@{}l@{}}}
\def\@maketitle{\newpage
  \vspace*{7pt}
	  {\raggedright \sloppy
	    {\reset@font\huge \bf \@title \par}
	    \vskip 23pt
		   {\reset@font\LARGE
		     \begin{author@tabular}[t]{@{}l@{}}\@author
		     \end{author@tabular}\par}
		   \vskip 22pt
	  }
	  \par\noindent
	      {\reset@font\small \@date \par}
	      \vskip 22pt
}

%  abstract/summary
\def\summary{\if@twocolumn
  \start@GJbox\@summary
  \else
  \@summary
  \fi}
\def\endsummary{\if@twocolumn
  \endlist\finish@GJbox
  \else
  \endlist
  \fi}
\def\abstract{\if@twocolumn
  \start@GJbox\@summary
  \else
  \@summary
  \fi}
\def\endabstract{\if@twocolumn
  \endlist\finish@GJbox
  \else
  \endlist
  \fi}
\def\left@zm{10.5pc}
\def\@summary{\list{}{%
    \labelwidth\z@ \labelsep\z@
    \leftmargin\left@zm \rightmargin\z@
    \parsep 0pt plus 1pt}\item[]\reset@font
  \normalsize{\bf ABSTRACT}\\\reset@font\large}

% keywords
\newif\ifGJ@keywords
\def\keywords{\if@twocolumn
  \start@GJbox\@keywords
  \else
  \@keywords
  \fi
}
\def\@keywords{\list{}{%
    \labelwidth\z@ \labelsep\z@
    \leftmargin\left@zm \rightmargin\z@
    \parsep 0pt plus 1pt}\item[]\reset@font\large{\bf Key words: }}
\def\endkeywords{\if@twocolumn
  \endlist\addvspace{37pt plus 0.5\baselineskip}\finish@GJbox
  \else
  \endlist
  \fi
  \@thanks
  \gdef\@thanks{}
  \GJ@keywordstrue
}
\def\nokeywords{\ifGJ@keywords\else
  \if@twocolumn \start@GJbox\addvspace{37pt}\finish@GJbox \fi
  \@thanks
  \gdef\@thanks{}\fi
}

% author
\def\author@tabular{\def\@halignto{}\@authortable}
\let\endauthor@tabular=\endtabular
%
\def\author@tabcrone{\vspace{2pt}{\ifnum0=`}\fi%
  \@xtabularcr[-7pt]\reset@font\small\it
  \let\\=\author@tabcrtwo\ignorespaces}
%
\def\author@tabcrtwo{{\ifnum0=`}\fi\@xtabularcr[-7pt]\reset@font\small\it
  \let\\=\author@tabcrtwo\ignorespaces}
%
\def\@authortable{\leavevmode \hbox \bgroup 
  $\let\@acol\@tabacol
  \let\@classz\@tabclassz 
  \let\@classiv\@tabclassiv
  \let\\=\author@tabcrone
  \ignorespaces \@tabarray}

\def\start@GJbox{\@next\@currbox\@freelist{}{}%
 \global\setbox\@currbox
 \vbox\bgroup
  \hsize \textwidth
  \@parboxrestore
}
\def\finish@GJbox{\par\vskip -\dbltextfloatsep
  \egroup
  \global\count\@currbox\tw@
  \global\@dbltopnum\@ne
  \global\@dbltoproom\maxdimen\@addtodblcol
  \global\vsize\@colht
  \global\@colroom\@colht
}

%  ****************************************
%  *            PAGE STYLES               *
%  ****************************************
%
\mark{{}{}}
\gdef\@author{\mbox{}}
\def\author{\@ifnextchar [{\@authortwo}{\@authorone}}
\def\@authortwo[#1]#2{\gdef\@author{#2}\gdef\@shortauthor{#1}}
\def\@authorone#1{\gdef\@author{#1}\gdef\@shortauthor{#1}}
\gdef\@shortauthor{}

\gdef\@title{\mbox{}}
\def\title{\@ifnextchar [{\@titletwo}{\@titleone}}
\def\@titletwo[#1]#2{\gdef\@title{#2}\gdef\@shorttitle{#1}}
\def\@titleone#1{\gdef\@title{#1}\gdef\@shorttitle{#1}}
\gdef\@shorttitle{}

\gdef\@journal{CWP-000}
\def\journal#1{\gdef\@journal{#1}}

\def\@ddell{}
\def\ps@headings{\let\@mkboth\markboth
  
\def\@oddhead{\Large\hfill{\it\@shorttitle}\hspace{1.5em}\rm\@ddell\thepage}
\def\@oddfoot{}
\def\@evenhead{\Large\@ddell\thepage\hspace{1.5em}\it\@shortauthor\hfill}
\def\@evenfoot{}

\def\sectionmark##1{\markboth{##1}{}}
\def\subsectionmark##1{\markright{##1}}}
\def\ps@myheadings{\let\@mkboth\@gobbletwo
  
\def\@oddhead{\Large\hfill\it\rightmark\hspace{1.5em}\rm\@ddell\thepage}
\def\@oddfoot{}
\def\@evenhead{\Large\@ddell\thepage\hspace{1.5em}\it\leftmark\hfill}
\def\@evenfoot{}

\def\sectionmark##1{}
\def\subsectionmark##1{}}
\def\ps@titlepage{\let\@mkboth\@gobbletwo
\def\@oddhead{\footnotesize\@journal\hfill}
  
\def\@oddfoot{}
\def\@evenhead{\footnotesize\@journal\hfill}

\def\@evenfoot{}
\def\sectionmark##1{}
\def\subsectionmark##1{}}

\def\ps@plate{\let\@mkboth\@gobbletwo
  \def\@oddhead{\footnotesize\pl@te\hfill}\def\@oddfoot{}
  \def\@evenhead{\footnotesize\pl@te\hfill}\def\@evenfoot{}
}

%  ****************************************
%  *             BIBLIOGRAPHY             *
%  ****************************************
\newcounter{dummy}
\def\thebibliography#1{\section*{REFERENCES}
 \addcontentsline{toc}{section}{REFERENCES}
 \list{}{\usecounter{dummy}%
         \labelwidth\z@
         \leftmargin 1.5em
         \itemsep \z@
         \itemindent-\leftmargin}
 \reset@font\small
 \parindent\z@
 \parskip\z@ plus .1pt\relax
 \def\newblock{\hskip .11em plus .33em minus .07em}
 \sloppy\clubpenalty4000\widowpenalty4000
 \sfcode`\.=1000\relax
}
\let\endthebibliography=\endlist
\def\@biblabel#1{\hspace*{\labelsep}[#1]}

%  ****************************************
%  *             FOOTNOTES                *
%  ****************************************
%
\def\footnoterule{\kern-3\p@ \hrule width 12pc height \z@ \kern 3\p@}

\renewcommand{\thefootnote}{\mbox{{$\fnsymbol{footnote}$}}}

\def\@fnsymbol#1{\ifcase#1\or \mbox{$\star$}\or \dagger\or \ddagger\or
  \S \or \P \or \|\or **\or \dagger\dagger
  \or \ddagger\ddagger\or \S\S\or \P\P\or \|\|\else ***
  \fi\relax}

\long\def\@makefntext#1{\parindent 1em\noindent
  $^{\@thefnmark}$#1}

%  ****************************************
%  *         FIGURES AND TABLES           *
%  ****************************************
\newif\ifst@rredfloat
\newcounter{table}
\def\thetable{\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{1}
\def\fstyle@table{\reset@font\small\rm}
\def\ext@table{lot}
\def\fnum@table{Table \thetable}
\def\table{\let\@makecaption=\GJ@maketablecaption%
  \@float{table}\fstyle@table}
\let\endtable\end@float
\@namedef{table*}{\st@rredfloattrue\let\@makecaption=\GJ@maketablecaption%
  \@dblfloat{table}\centering\fstyle@table}
\@namedef{endtable*}{\end@dblfloat\st@rredfloatfalse}

\newcounter{figure}
\def\thefigure{\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{2}
\def\fstyle@figure{\reset@font\small\rm}
\def\ext@figure{lof}
\def\fnum@figure{Figure \thefigure}
\def\figure{\let\@makecaption=\GJ@makefigurecaption%
  \@float{figure}\fstyle@figure}
\let\endfigure\end@float
\@namedef{figure*}{\st@rredfloattrue\let\@makecaption=\GJ@makefigurecaption%
  \@dblfloat{figure}\centering\fstyle@figure}
\@namedef{endfigure*}{\end@dblfloat\st@rredfloatfalse}

\long\def\GJ@makefigurecaption#1#2{\vskip 6pt
 \setbox\@tempboxa\hbox{\reset@font\small{\bf #1.} #2}
 \ifdim \wd\@tempboxa >\hsize
  \reset@font\small{\bf #1.} #2\par
 \else
   \ifst@rredfloat
     \hbox to\hsize{\hfill\box\@tempboxa\hfill}
   \else
     \hbox to\hsize{\box\@tempboxa\hfill}
   \fi
 \fi
 \vskip 6pt
}

\long\def\GJ@maketablecaption#1#2{\vskip 6pt
 \setbox\@tempboxa\hbox{\reset@font\small{\bf #1.} #2}
 \ifdim \wd\@tempboxa >\hsize
   \reset@font\small{\bf #1.} #2\par
 \else
   \hbox to\hsize{\box\@tempboxa\hfill}
 \fi
 \vskip 6pt
}

\def\caption{\@ifstar{\GJ@caption\@captype}%
 {\refstepcounter\@captype \@dblarg{\@caption\@captype}}%
}
\long\def\GJ@caption#1#2{%\par
 \begingroup
  \@parboxrestore
  \reset@font\normalsize
  \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #2}\par
 \endgroup}


%  ****************************************
%  *            MISCELLANEOUS             *
%  ****************************************
% DATE
\def\today{}

%  ****************************************
%  *           INITIALIZATION             *
%  ****************************************
%
\flushbottom
\ps@headings

\pagenumbering{arabic}
\if@twocolumn
 \twocolumn
 \sloppy
\else
 \onecolumn
\fi
\frenchspacing


