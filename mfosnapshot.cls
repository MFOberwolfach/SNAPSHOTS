\documentclass[10pt,a5paper,DIV=21]{scrartcl}

\AtBeginDocument{%
  \IfFileExists{iftex.sty}{%
    \RequirePackage{iftex}%
    \RequirePDFTeX%
  }{%
    \PackageWarning{snapshot}{%
      Please install the iftex package\MessageBreak
    }%
  }%
}

%\usepackage[top=12mm,bottom=26mm,outer=28mm,inner=14mm,foot=14mm]{geometry}
\usepackage[top=10mm,bottom=18mm,outer=12mm,inner=12mm,foot=9.5mm]{geometry}
\usepackage{calc}
\deffootnote[1.5em]{0em}{1em}{\thefootnotemark\quad}
\renewcommand{\footnoterule}{%
  \kern -2.4pt
  \hrule width \textwidth height 0.4pt
  \kern 2pt
}

\usepackage[T1]{fontenc}
\usepackage{textcomp}
\usepackage{helvet}

\usepackage{microtype,ellipsis}

\usepackage[ngerman]{babel}
%\usepackage{polyglossia}
%\setotherlanguage{russian} % the name of the original Russian version at the end of this book is written using Cyrillic letters


\usepackage{amsmath,amssymb,nicefrac,amscd}
\usepackage{graphicx,float}
\usepackage{pdfpages}

\usepackage{enumitem}
\setitemize[1]{noitemsep,nosep,leftmargin=0.99em,label={--}}

\usepackage{transparent}
\usepackage{csquotes}
\usepackage{siunitx}
\sisetup{per-mode=fraction,fraction-function=\nicefrac}
\DeclareSIUnit[number-unit-product=\,]\uhr{Uhr}
\DeclareSIUnit[number-unit-product=\,]\zoll{Zoll}

\usepackage{hyperref}

\usepackage{todonotes}
