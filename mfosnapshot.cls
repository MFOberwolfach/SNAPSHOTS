% TODO:
% - UTF-8
% - pdfLaTeX, XeLaTeX, LuaLaTeX
% - BibTeX/BibLaTeX
% - Listen, Tabellen
% - Paketauswahl
% - neuer \author-Befehl

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mfosnapshot}[2014/02/06 Document class for "Snapshots from Oberwolfach"]
\LoadClass[10pt,twoside]{scrartcl}  

\RequirePackage{iftex}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tools
\RequirePackage{etoolbox}
\appto{\abstract}{\relscale{1.3}\noindent\ignorespaces} 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% page layout
\RequirePackage[a5paper,top=12mm,bottom=22mm,outer=16mm,inner=12mm,foot=11mm,footnotesep=14pt]{geometry}
\RequirePackage{multicol}
\setlength{\columnsep}{2em}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% footnotes
%\def\@fnsymbol#1{\ifcase#1\or{*}\or{**}\or{***}\else\@ctrerr\fi}
\def\@fnsymbol#1{\ensuremath{\ifcase#1%
	\or *\or \ddagger\or \mathsection\or \|%
	\or **\or \ddagger\ddagger\or \mathsection\mathsection%
	\else%
		*^{\the#1}
	\fi}}
\renewcommand{\thefootnote}{\fnsymbol{footnote}}
\deffootnote[1.5em]{0em}{1.5em}{\rlap{\textsuperscript{\thefootnotemark}}\hspace{1.5em}}
\deffootnotemark{\textsuperscript{\thefootnotemark}}
\setfootnoterule[0.526pt]{\textwidth}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fonts
\RequirePackage[T1]{fontenc}
\RequirePackage{textcomp}
\RequirePackage[scaled=0.82304487406237511878]{helvet}
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

\RequirePackage[hidelinks]{hyperref}

\RequirePackage{todonotes}

%\setdefaultlanguage{german}
\RequirePackage{xcolor}
\RequirePackage{type1cm}
\RequirePackage{relsize}

\RequirePackage{scrpage2}
\pagestyle{scrheadings}
\clearscrheadfoot
\cfoot{\pagemark}
\newcommand{\arial}{\sf}%{\fontspec[Extension=.ttf, ItalicFont=Arial Italic]{Arial}}

\setkomafont{pagenumber}{\arial\relscale{1.1}}
\setkomafont{section}{\arial\relscale{1.32}\SetTracking{encoding=*}{100}\lsstyle\underline }
\appto{\thesection}{\protect\vphantom{g}} % spacing of underline 

\setkomafont{subsection}{\arial\relscale{1.1}\SetTracking{encoding=*}{100}\lsstyle}
\setkomafont{subsubsection}{\arial\relscale{1.1}\SetTracking{encoding=*}{100}\lsstyle}
\setkomafont{paragraph}{\arial\relscale{1.1}\SetTracking{encoding=*}{100}\lsstyle}
\setkomafont{subparagraph}{\arial\relscale{1.1}\SetTracking{encoding=*}{100}\lsstyle}
\setkomafont{captionlabel}{\arial\relscale{1.1}\SetTracking{encoding=*}{100}\lsstyle}

\setkomafont{title}{\renewcommand{\baselinestretch}{0.8}\color{black!75!white}\arial\relscale{1.8}\SetTracking{encoding=*}{100}\lsstyle}


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
  \parbox[t]{0.5\linewidth}{\arial\relscale{0.9}\SetTracking{encoding=*}{100}\lsstyle Schnappsch\"usse moderner Mathematik\\aus Oberwolfach}%
  \parbox[t]{0.5\linewidth}{\raggedleft\mbox{\textnumero\,\@snapshotid/\@snapshotyear}}
  \vskip 4em%
  \begin{center}%
    \parbox[t]{0.75\linewidth}{\centering\titlefont \@title}\\[2em]

	\textcolor{black!75!white}{\rule[0.5ex]{1cm}{0.75pt}}\\[1.5em]%
    {%
      \relscale{1.2}
      \lineskip .5em%
      \arial
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
	\null\nopagebreak\vfill\nopagebreak\noindent%
	\begin{minipage}{\linewidth}
		\renewcommand\UrlFont{}%
		\begin{multicols*}{2}
		\relscale{0.9}%
			\renewcommand{\baselinestretch}{0.8}
			\arial%
			\parbox{\linewidth}{%
				\raggedright
				Author 1 is professor for pure mathematics at Cambridge University in the UK.\\
				Contact: \href{mailto://author-1@xyz.de}{\nolinkurl{author-1@xyz.de}}\\[\medskipamount]
				%
				Author 2 is professor for pure mathematics at \mbox{Cambridge} University in the UK.\\
				Contact: \href{mailto://author-2@xyz.de}{\nolinkurl{author-2@xyz.de}}\\[\medskipamount]
				%
				Responsible Organizer\\
				Muster Mensch%
			}\columnbreak\par%
			\parbox{\linewidth}{%
				\raggedright
				Mathematical subject classification:\\
				Algebraic Geometry\\[\medskipamount]
				%
				License:\\
				\href{http://creativecommons.org/licenses/by-nc-nd/2.0/}{Creative Commons BY-NC-ND 2.0}\\[\medskipamount]
				%
				DOI: \href{http://dx.doi.org/10.14760/SNAP-2014-001}{10.14760/SNAP-2014-001}%
			}\columnbreak\par%
		\end{multicols*}
		\vskip\medskipamount%

		\hfil\textcolor{black!75!white}{\rule[0.5ex]{1cm}{0.75pt}}\hfil%

		\vskip\medskipamount
		\arial\normalfont\emph{Snapshots of modern mathematics from Oberwolfach} is a mathematics communication project of the Mathematisches Forschungsinstitut Oberwolfach (MFO) and IMAGINARY -- open mathematics. It is a part of the project Oberwolfach meets IMAGINARY funded by the Klaus Tschira Foundation and the Oberwolfach Foundation. The snapshots are written by participants of the scientific program of the institute. They are refereed (???) by the organizer(s) of the scientific program and edited by a team of editors. All snapshots can be found on \href{http://www.imaginary.org}{\nolinkurl{www.imaginary.org}}.
		\vskip-\baselineskip%
		\vskip\medskipamount%

		\hfil\textcolor{black!75!white}{\rule[0.5ex]{1cm}{0.75pt}}\hfil%

		\vskip\medskipamount%
			\SetTracking{encoding=*}{100}\lsstyle%
    	\arial
	    %{\ifx\@subtitle\@empty\else\usekomafont{subtitle}\@subtitle\par\fi}%
    	%
		\SetTracking{encoding=*}{100}\lsstyle
		\begin{multicols*}{2}
			\renewcommand{\baselinestretch}{0.8}
			\arial%
			\parbox{\linewidth}{%
				\raggedright
				\textit{Junior Editor}\\
				Lea Renner\\
				\href{mailto://junior-editors@mfo.de}{\nolinkurl{junior-editors@mfo.de}}\\[\medskipamount]
				%
				\textit{Senior Editor}\\
				Dr. Carla Cederbaum\\
				\href{cederbaum@mfo.de}{\nolinkurl{cederbaum@mfo.de}}%
			}\columnbreak\par%
			\parbox{\linewidth}{%
				\raggedright
				Mathematisches Forschungsinstitut\\
				Oberwolfach gGmbH\\
				Schwarzwaldstr. 9-11\\
				D-77709 Oberwolfach-Walke\\
				Germany\\[\medskipamount]
				%
				\textit{Director}\\
				Prof. Dr. Gerhard Huisken%
			}\columnbreak\par%
		\end{multicols*}
		\bigskip

		\noindent%
		\resizebox*{\linewidth}{0.07608695652173913043\linewidth}{%
			\IfFileExists{./footer.pdf}{%
				\includegraphics{footer.pdf}
			}{%
				\framebox{\qquad\qquad footer.pdf \qquad\qquad}
			}
		}
	\end{minipage}%
}