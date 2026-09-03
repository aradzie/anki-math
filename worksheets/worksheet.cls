%% worksheet.cls
%% Shared look-and-feel for worksheet documents.
%%
%% Content files should do:
%%   \documentclass{worksheet}
%%   \title{...}                  % required
%%   \subtitle{...}               % optional
%%   \worksheetrunninghead{...}   % optional, used in the page header
%%   \begin{document}
%%   \maketitle
%%   ...
%%   \end{document}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{worksheet}[2026/09/03 Shared worksheet document class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[11pt]{article}

% ---------- Fonts & typography ----------
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{microtype}
\RequirePackage{amsmath,amssymb,amsfonts,mathtools}
\RequirePackage{enumitem}

\setlength{\parindent}{0pt}
\setlength{\parskip}{4pt}
\setlist[enumerate]{leftmargin=*,label=\textbf{\arabic*.},itemsep=0pt,parsep=0pt,topsep=4pt}

% ---------- Page geometry ----------
\RequirePackage[a4paper,margin=1in]{geometry}

% ---------- Headers ----------
\RequirePackage{fancyhdr}
\setlength{\headheight}{14pt}

\newcommand{\worksheetrunninghead}[1]{\gdef\@worksheetrunninghead{#1}}
\gdef\@worksheetrunninghead{}

\AtBeginDocument{%
  \pagestyle{fancy}%
  \fancyhf{}%
  \lhead{\ifx\@worksheetrunninghead\@empty\@title\else\@worksheetrunninghead\fi}%
  \rhead{\ifshowsolutions Worked solutions\else Worksheet\fi}%
  \cfoot{\thepage}%
}

% ---------- Title block ----------
\date{}
\newcommand{\subtitle}[1]{\gdef\@subtitle{#1}}
\gdef\@subtitle{}

\renewcommand{\maketitle}{%
  \begin{center}
    {\LARGE\bfseries\@title\par}\vspace{4pt}
    \ifx\@subtitle\@empty\else
      {\large\@subtitle\par}\vspace{4pt}
    \fi
  \end{center}
  \vspace{2pt}
}

% ---------- Worksheet / solution toggle ----------
\newif\ifshowsolutions
\newif\ifsolutions
\ifdefined\solutions
  \showsolutionstrue
  \solutionstrue
\else
  \ifdefined\SOLUTIONS
    \showsolutionstrue
    \solutionstrue
  \else
    \showsolutionsfalse
    \solutionsfalse
  \fi
\fi

\RequirePackage{xcolor}
\definecolor{rulegray}{gray}{0.78}
\definecolor{answerblue}{RGB}{0,0,128}

\newcommand{\worklines}[1]{%
  \par\vspace{#1}%
  {\color{rulegray}\noindent\rule{\linewidth}{0.25pt}}\par
}

% \sol{<blank height>}{<solution>}
% Solutions build: prints the solution. Practice build: leaves vertical space.
\newcommand{\sol}[2]{%
  \ifshowsolutions
    \par\smallskip\noindent{\color{answerblue}\small\textbf{Solution.} #2}\par\medskip
  \else
    \worklines{#1}%
  \fi
}

\newcommand{\exercise}[3]{%
  \item #1%
  \sol{#2}{#3}%
}
