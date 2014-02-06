\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mfosnapshot}[2014/02/06 Document class for "Snapshots from Oberwolfach"]
\LoadClass[10pt,a5paper,DIV=21]{scrartcl}  

% \AtBeginDocument{%
%   \IfFileExists{iftex.sty}{%
%     \RequirePackage{iftex}%
%     \RequirePDFTeX%
%   }{%
%     \PackageWarning{snapshot}{%
%       Please install the iftex package\MessageBreak
%     }%
%   }%
% }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tools
\RequirePackage{etoolbox}
\appto{\abstract}{\relscale{1.3}\noindent\ignorespaces} 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% page layout
\RequirePackage[top=10mm,bottom=18mm,outer=12mm,inner=12mm,foot=9.5mm]{geometry}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% footnotes
\renewcommand{\thefootnote}{\fnsymbol{footnote}}
\deffootnote[1em]{0em}{1em}{\rlap\thefootnotemark\hspace{1em}}
\deffootnotemark{\textsuperscript{\thefootnotemark}}
\setfootnoterule{\textwidth}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fonts
\RequirePackage[T1]{fontenc}
\RequirePackage{textcomp}
\RequirePackage{helvet}
\RequirePackage{microtype,ellipsis}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hyphenation
\RequirePackage[ngerman]{babel}



\RequirePackage{amsmath,amssymb,nicefrac,amscd}
\RequirePackage{graphicx,float}
\RequirePackage{pdfpages}

\RequirePackage{enumitem}
\setitemize[1]{noitemsep,nosep,leftmargin=0.99em,label={--}}

\RequirePackage{csquotes}
\RequirePackage{siunitx}
\sisetup{per-mode=fraction,fraction-function=\nicefrac}

\RequirePackage{hyperref}

\RequirePackage{todonotes}

%\setdefaultlanguage{german}
\RequirePackage[math]{blindtext}
\RequirePackage{lipsum}
\RequirePackage{xcolor}
\RequirePackage{type1cm}
\RequirePackage{relsize}

\RequirePackage{scrpage2}
\pagestyle{scrheadings}
\clearscrheadfoot
\cfoot{\pagemark}
\newcommand{\arial}{\sf}%{\fontspec[Extension=.ttf, ItalicFont=Arial Italic]{Arial}}

\setkomafont{pagenumber}{\arial\relscale{0.9}}
\setkomafont{section}{\arial\relscale{1.1}\SetTracking{encoding=*}{100}\lsstyle\underline }
\setkomafont{subsection}{\arial\relscale{0.9}\SetTracking{encoding=*}{100}\lsstyle}
\setkomafont{subsubsection}{\arial\relscale{0.9}\SetTracking{encoding=*}{100}\lsstyle}
\setkomafont{paragraph}{\arial\relscale{0.9}\SetTracking{encoding=*}{100}\lsstyle}
\setkomafont{subparagraph}{\arial\relscale{0.9}\SetTracking{encoding=*}{100}\lsstyle}
\setkomafont{captionlabel}{\arial\relscale{0.9}\SetTracking{encoding=*}{100}\lsstyle}

\setkomafont{title}{\color{black!75!white}\arial\relscale{1.5}\SetTracking{encoding=*}{100}\lsstyle}




\newcommand{\@snapshotid}{xx}%
\newcommand{\@snapshotyear}{xxxx}%
\newcommand*{\snapshotid}[2]{%
	\gdef\@snapshotid{#1}%
	\gdef\@snapshotyear{#1}%
}%

\renewcommand*\maketitle{%
	\par
	\begingroup
		\renewcommand*\thefootnote{\@fnsymbol\c@footnote}%
		\let\@oldmakefnmark\@makefnmark
		\renewcommand*{\@makefnmark}{\rlap\@oldmakefnmark}
		\newpage
		\global\@topnum\z@
		\@maketitle
		\thispagestyle{\titlepagestyle}\@thanks
	\endgroup
	\setcounter{footnote}{0}%
	\let\thanks\relax
	\let\maketitle\relax
	\let\@maketitle\relax
	\global\let\@thanks\@empty
	\global\let\@author\@empty
	\global\let\@date\@empty
	\global\let\@title\@empty
	\global\let\@subtitle\@empty
	\global\let\@extratitle\@empty
	\global\let\@titlehead\@empty
	\global\let\@subject\@empty
	\global\let\@publishers\@empty
	\global\let\@uppertitleback\@empty
	\global\let\@lowertitleback\@empty
	\global\let\@dedication\@empty
	\global\let\author\relax
	\global\let\title\relax
	\global\let\extratitle\relax
	\global\let\titlehead\relax
	\global\let\subject\relax
	\global\let\publishers\relax
	\global\let\uppertitleback\relax
	\global\let\lowertitleback\relax
	\global\let\dedication\relax
	\global\let\date\relax
	\global\let\and\relax
}%
\renewcommand*{\@maketitle}{%
  \clearpage
  \let\footnote\thanks
  \setparsizes{\z@}{\z@}{\z@\@plus 1fil}\par@updaterelative
  \noindent
  \parbox[t]{0.5\linewidth}{\arial\relscale{0.75}\SetTracking{encoding=*}{100}\lsstyle Schnappsch\"usse moderner Mathematik\\aus Oberwolfach}%
  \parbox[t]{0.5\linewidth}{\raggedleft\mbox{\textnumero\,\@snapshotid/\@snapshotyear}}
  \vskip 4em%
  \begin{center}%
    \parbox[t]{0.75\linewidth}{\centering\titlefont \@title \par}%
    \vskip 1.5em
	{\titlefont\rule{2em}{0.075em}}
    %{\ifx\@subtitle\@empty\else\usekomafont{subtitle}\@subtitle\par\fi}%
    \vskip 1em
    {%
      \lineskip .5em%
      \SetTracking{encoding=*}{100}\lsstyle%
      \begin{tabular}[t]{c}
        \@author
      \end{tabular}\par
    }%
    \vskip 1em%
%    {\Large \@date \par}%
    \vskip \z@ \@plus 1em
%    {\Large \@publishers \par}
  \end{center}%
  \par
}%

\AtBeginDocument{\maketitle}%
\AtEndDocument{%
	\null\nopagebreak\vfill\nopagebreak
	\begin{minipage}{\linewidth}
		\noindent\begin{minipage}[b]{0.5\linewidth}
		\raggedright
		\arial
		\SetTracking{encoding=*}{100}\lsstyle
		\footnotesize
		Classification: Algebraic Geometry

		Licence: by-nc-nd
		\bigskip

		Imaginary -- open mathematics\\
		Mathematisches Forschungsinstitut\\
		Oberwolfach gGmbH\\
		Schwarzwaldstr. 9--11\\
		D-77709 Oberwolfach-Walke, Germany
		\end{minipage}%
		\hspace{1ex}
		\begin{minipage}[b]{0.45\linewidth}%
		\raggedright
		\arial
		\SetTracking{encoding=*}{100}\lsstyle
		\footnotesize
		MFO workshop title:\\
		\textit{Classical and Quantum Mechanical Models of Many-Particle Systems}
		\\[\medskipamount]

		MFO Workshop Date:\\
		1 Dec -- 7 Dec 2013
		\\[\medskipamount]

		Responsible Workshop Organizer:\\
		Anton Arnold, Wien
		Eric Carlen, Piscataway
		Laurent Desvillettes, Cachan
		\end{minipage}
	\end{minipage}%
}