\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{BScThesis}[2019/04/10 Style for my Bachelor Thesis in Theoretical physics, adapted by the original work of Nils Fischer]

\newif\if@print
\DeclareOption{print}{\@printtrue}
\DeclareOption{digital}{\@printfalse}

\ExecuteOptions{digital}
\ProcessOptions\relax


% General
\LoadClassWithOptions{scrreprt}

% Geometry
\RequirePackage[onehalfspacing]{setspace}
\RequirePackage[a4paper,width=150mm,top=30mm,bottom=30mm]{geometry}

% Links
\RequirePackage{color,xcolor}
\RequirePackage{hyperref}
\if@print % switch link coloring off for printing
	\hypersetup{colorlinks=false}
\else
	\hypersetup{colorlinks=true}
\fi
\AtBeginDocument{
	\hypersetup{ % set pdf metadata
	    pdfauthor={\@author},
		pdftitle={\@title}
	}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Maths and stuff
\RequirePackage{amsmath,amssymb, commath, mathtools}
\RequirePackage{physics, xfrac}

%Fonts
\RequirePackage{fontspec,xunicode}
\setmainfont{Palatino}
\setsansfont{Optima}
\setmonofont[Scale=MatchLowercase]{Menlo}

%Titles
\RequirePackage{titlesec}
\titleformat{\paragraph}[block]{\center\bfseries}{\thetitle}{}{}

%Units
\RequirePackage[separate-uncertainty]{siunitx}

%Tables
\RequirePackage{array} % for math mode in tables
\RequirePackage{booktabs} % for hline rules

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Page Layout
\renewcommand{\chaptermark}[1]{
    \markboth{\mbox{\@chapapp}\ \thechapter.\ \ #1}{}%
}
\renewcommand{\sectionmark}[1]{
    \markright{\thesection\ \ #1}{}
}

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\if@twoside
	\fancyhead[LE]{
	    \footnotesize\nouppercase{\leftmark}
	}
	\fancyhead[RO]{
		footnotesizw\nouppercase{\rightmark}
	}
	\fancyfoot[C]{
		\thepage
	}
\else
	\fancyhead[L]{
	    \footnotesize\nouppercase{\leftmark}
	}
	\fancyfoot[C]{
		\thepage
	}
\fi
\renewcommand{\headrulewidth}{0.2pt}
\renewcommand{\footrulewidth}{0pt}
\fancypagestyle{plain}{
	\fancyhead{}
	\renewcommand{\headrulewidth}{0pt}
}

% Type optimization
\RequirePackage{microtype}

% Bibliography
\RequirePackage[
	style=numeric-comp,
	backend=biber,
	maxnames=10,
	maxcitenames=2,
	isbn=false,
	date=year,
	url=false,
	doi=false
]{biblatex}
\DeclareFieldFormat*{title}{``#1"}
\DeclareFieldFormat*{date}{(#1)}
\renewbibmacro{in:}{\iffieldundef{journaltitle}{\addspace}{\adddot\addspace In: }}
\renewbibmacro*{issue+date}{\iffieldundef{issue}
    {\usebibmacro{date}}
    {\printfield{issue}%
     \setunit*{\addspace}%
     \usebibmacro{date}}%
     \newunit}
\renewbibmacro*{publisher+location+date}{%
  \printlist{publisher}%
  \iflistundef{location}{}{\setunit*{\space}}%
  \printlist{location}%
  \setunit*{\addspace}%
  \usebibmacro{date}%
  \newunit}
\usepackage{xpatch}
\xpatchbibdriver{thesis}
  {\printfield{type}%
   \newunit
   \usebibmacro{institution+location+date}}
  {\printfield{type}%
   \setunit*{\addspace}%
   \usebibmacro{date}}
  {}{}
\AtEveryBibitem{%
    \clearfield{pages}%
}

% Appendix
\RequirePackage[toc,page]{appendix}

\endinput