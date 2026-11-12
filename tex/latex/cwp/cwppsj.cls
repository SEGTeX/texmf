\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cwppsj}[]

% Planetary Science Journal: AASTeX v7 (aastex701.cls, texmf/tex/latex/aastex)
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{aastex701}}
\ProcessOptions*
\LoadClass{aastex701}

% AASTeX 7.0.1 (May 2025) swaps the internals of the array package for its own copies of array
% v2.5 at \begin{document}. Array v2.6 (TeX Live 2025-2026) numbers the column classes
% differently, so the swapped \@mkpream meets the new \@testpach and the first p{} preamble
% fails with "Extra \or". With a newer array, keep its own internals.
\@ifpackagelater{array}{2024/01/01}{\def\switch@array{}}{}

\RequirePackage{graphicx}

% ------------------------------------------------------------
\newcommand{\@path}{.}
\newcommand{\inputdir}[1]{\renewcommand{\@path}{#1}}
\providecommand{\figdir}{Fig}
\providecommand{\fig@file}[1]{\@path/\figdir/#1}

% ------------------------------------------------------------
\newcommand{\plot}[3]{%
  \begin{figure}[htbp]
    \centering
    \includegraphics[#2]{\fig@file{#1}}
    \caption{#3}
    \label{fig:\@path-#1}
    \label{fig:#1}
\end{figure}}

% ------------------------------------------------------------
\newcommand{\sideplot}[3]{%
  \begin{figure}[htbp]
    \makebox[\textwidth]{%
      \begin{minipage}[c]{0.4\textwidth}
        \caption{#3}
        \label{fig:\@path-#1}
        \label{fig:#1}
      \end{minipage}
      \hfill
      \begin{minipage}[c]{0.55\textwidth}
        \centering
        \includegraphics[#2]{\fig@file{#1}}
    \end{minipage}}
\end{figure}}

% ------------------------------------------------------------
% Shared backmatter.tex uses the MDPI command \acknowledgments{text}; AASTeX v7 wants the
% environment. Route the command form to the environment, keep the environment working.
\let\cwp@aasack\acknowledgments
\def\cwp@ackcmd#1{\begin{acknowledgments}#1\end{acknowledgments}}
\def\acknowledgments{\ifx\@currenvir\xacknowledgments\expandafter\cwp@aasack\else\expandafter\cwp@ackcmd\fi}
