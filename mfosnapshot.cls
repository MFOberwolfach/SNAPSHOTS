% TODO:
% - UTF-8
% - pdfLaTeX, XeLaTeX, LuaLaTeX
% - BibTeX/BibLaTeX
% - Sprache auswählen
% - Paketauswahl
% - Autoren mehrspaltig
% - vspace letzte Seite
% - Abstand zum Footer letze Seite
% - Seitenzahl vertikal optisch mittig
% - Absatzeinrückung wie Fußnote
% - single word -> no new line (tex stack exchange) (trading word)
% - 2 Literaturverzeichnisse


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mfosnapshot}[2014/02/06 Document class for "Snapshots from Oberwolfach"]
\LoadClass[10pt,twoside]{scrartcl}  

\RequirePackage{iftex}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tools
\RequirePackage{calc}
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
\setitemize[1]{noitemsep,leftmargin=1.5em,labelsep=*,label={$\bullet$}}
\setitemize[2]{noitemsep,leftmargin=1.5em,labelsep=*,label={$\circ$}}
\setitemize[3]{noitemsep,leftmargin=1.5em,labelsep=*,label={$*$}}
\setitemize[4]{noitemsep,leftmargin=1.5em,labelsep=*,label={--}}
%
\setenumerate[1]{noitemsep,leftmargin=1.5em,labelsep=*,label=\sf\arabic*.}
\setenumerate[2]{noitemsep,leftmargin=1.5em,labelsep=*,label=\sf\alph*)}
\setenumerate[3]{noitemsep,align=left,leftmargin=1.5em,labelsep=*,label=\sf\roman*.}
\setenumerate[4]{noitemsep,leftmargin=1.5em,labelsep=*,label=\sf\Alph*.}

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
\renewcommand*{\titlepagestyle}{scrheadings}
\clearscrheadfoot
\cfoot{\pagemark}
\newcommand{\arial}{\sf}%{\fontspec[Extension=.ttf, ItalicFont=Arial Italic]{Arial}}


% \underline command which always adds an invisible depth of the letter 'g' 
\newcommand{\gunderline}[1]{\ifmmode \@@underline {#1\protect\vphantom{g}}\else $\@@underline {\hbox {#1\protect\vphantom{g}}}\m@th $\relax \fi}

\setkomafont{pagenumber}{\arial\relscale{1.1}}
\setkomafont{section}{\arial\relscale{1.32}\SetTracking{encoding=*}{100}\lsstyle\gunderline }

\setkomafont{subsection}{\arial\relscale{1.1}\SetTracking{encoding=*}{100}\lsstyle}
\setkomafont{subsubsection}{\arial\relscale{1.1}\SetTracking{encoding=*}{100}\lsstyle}
\setkomafont{paragraph}{\arial\relscale{1.1}\SetTracking{encoding=*}{100}\lsstyle}
\setkomafont{subparagraph}{\arial\relscale{1.1}\SetTracking{encoding=*}{100}\lsstyle}
\setkomafont{captionlabel}{\arial\relscale{1.1}\SetTracking{encoding=*}{100}\lsstyle}

\setkomafont{title}{\renewcommand{\baselinestretch}{0.8}\color{black!75!white}\arial\relscale{1.8}\SetTracking{encoding=*}{100}\lsstyle}


\newcommand{\snapshop@id}{xx}%
\newcommand{\snapshop@year}{xxxx}%
\newcommand*{\snapshotid}[2]{%
	\gdef\snapshop@id{#1}%
	\gdef\snapshop@year{#2}%
}%

\newcommand{\mailtoref}[1]{\href{mailto://#1}{\nolinkurl{#1}}}
\newcommand{\httpref}[1]{\href{http://#1}{\nolinkurl{#1}}}
\newcommand{\ftpref}[1]{\href{ftp://#1}{\nolinkurl{#1}}}

\newcounter{ctrmaxmfosnapshopauthorinfo}
\setcounter{ctrmaxmfosnapshopauthorinfo}{0}
\newcommand*{\authorinfo}[1]{%
	\expandafter\newcommand\csname snapshop@authorinfo\the\value{ctrmaxmfosnapshopauthorinfo} \endcsname{#1}%
	\stepcounter{ctrmaxmfosnapshopauthorinfo}%
}

\newcommand{\@authorinfo}{%
	\bgroup
		\newcounter{ctrauthorinfo}%
		\setcounter{ctrauthorinfo}{0}%
		\whiledo {\value{ctrauthorinfo} < \value{ctrmaxmfosnapshopauthorinfo}}%
		{%
			\bgroup%
				\def\authorname##1{\emph{##1}}%
				\renewcommand\UrlFont{\em}%
				\textit{%
				\bgroup%
					%
					\DeclareRobustCommand\\{\let \reserved@e \relax\let \reserved@f \relax\@ifstar{}{}\let \reserved@e \vadjust \let \reserved@f \nobreak \@xnewline}%
					%
					\csname snapshop@authorinfo\the\value{ctrauthorinfo} \endcsname}\strut%
				\egroup%
			\egroup
			\stepcounter{ctrauthorinfo}%
			\vskip\medskipamount%
		}%
	\egroup
}

\newcommand{\snapshot@organizer}{\ClassWarningNoLine{mfosnapshot}{No responsible organizer given}--}%
\newcommand*{\organizer}[1]{\gdef\snapshot@organizer{#1}}%

\newcommand{\snapshot@classification}{\ClassWarningNoLine{mfosnapshot}{No mathematical subject classification given}--}%
\newcommand*{\classification}[1]{\gdef\snapshot@classification{#1}}%

\newcommand{\snapshot@doi}{\ClassWarningNoLine{mfosnapshot}{No DOI given}--}%
\newcommand{\snapshot@doiurl}{}%
\newcommand*{\doi}[1]{%
	\gdef\snapshot@doi{#1}%
	\gdef\snapshot@doiurl{http://dx.doi.org/#1}%
}%

\newcommand{\snapshot@junioreditor}{\ClassWarningNoLine{mfosnapshot}{No junior editor given}--}%
\newcommand{\snapshot@junioreditoremail}{--}%
\newcommand*{\junioreditor}[2]{%
	\gdef\snapshot@junioreditor{#1}%
	\gdef\snapshot@junioreditoremail{\mailtoref{#2}}%
}%

\newcommand{\snapshot@senioreditor}{\ClassWarningNoLine{mfosnapshot}{No senior editor given}--}%
\newcommand{\snapshot@senioreditoremail}{--}%
\newcommand*{\senioreditor}[2]{%
	\gdef\snapshot@senioreditor{#1}%
	\gdef\snapshot@senioreditoremail{\mailtoref{#2}}%
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
  \parbox[t]{0.5\linewidth}{\raggedleft\mbox{\textnumero\,\snapshop@id/\snapshop@year}}
  \vskip 4em%
  \begin{center}%
    \parbox[t]{0.75\linewidth}{\centering\titlefont \@title}\\[2em]

	\rule[0.5ex]{1cm}{0.526pt}\\[1.5em]%
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
	\par%
	\patchcmd{\footnoterule}{\vskip \z@ \@plus .05fil}{}{}{}%
	\raggedbottom%
	\newsavebox{\snapshot@credits}%
	\sbox{\snapshot@credits}{\hbox{\parbox[t]{\linewidth}{%
		\raggedcolumns
		\renewcommand\UrlFont{}%
		\relscale{0.9}%
		\widowpenalties 1 10000
		\medskipamount2ex
		\multicolsep=0pt
		\begin{multicols}{2}%
			\renewcommand{\baselinestretch}{0.8}
			\arial%
			\SetTracking{encoding=*}{100}\lsstyle%
			\raggedright%
			\@authorinfo%
			%
			\textit{Responsible Organizer}\\*
			\snapshot@organizer\\[\medskipamount]
			%
			\textit{Mathematical subject classification}\\*
			\snapshot@classification\\[\medskipamount]
			%
			\textit{License}\\*
			\href{http://creativecommons.org/licenses/by-nc-nd/2.0/}{Creative Commons BY-NC-ND 2.0}\\[\medskipamount]
			%
			\textit{DOI}\\*
			\href{\snapshot@doiurl}{\snapshot@doi}%
		\end{multicols}%
		\vskip 0.3cm%
		\par\hfill\rule[0.5ex]{1cm}{0.526pt}\hfill\null%
		\vskip 0.25cm
		\raggedright\arial\normalfont\emph{Snapshots of modern mathematics from Oberwolfach} is a mathematics communication project of the Mathematisches Forschungsinstitut Oberwolfach (MFO) and IMAGINARY -- open mathematics. It is a part of the project Oberwolfach meets IMAGINARY funded by the Klaus Tschira Foundation and the Oberwolfach Foundation. The snapshots are written by participants of the scientific program of the institute. They are refereed (???) by the organizers of the scientific program and edited by a team of editors. All snapshots can be found on \href{http://www.imaginary.org}{\nolinkurl{www.imaginary.org}}.%
		%\vskip-\baselineskip%
		\vskip 0.25cm%
		\par\hfill\rule[0.5ex]{1cm}{0.526pt}\hfill\null%
		\vskip 0.4cm%
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
				\snapshot@junioreditor\\
				\snapshot@junioreditoremail\\[\medskipamount]
				%
				\textit{Senior Editor}\\
				\snapshot@senioreditor\\
				\snapshot@senioreditoremail%
			}\columnbreak\par%
			\parbox{\linewidth}{%
				\raggedright
				Mathematisches Forschungsinstitut\\
				Oberwolfach gGmbH\\
				Schwarzwaldstr. 9\,--1\!1\\
				77709 Oberwolfach\\
				Germany\\[\medskipamount]
				%
				\textit{Director}\\
				Prof.\;Dr.\;Gerhard Huisken%
			}\columnbreak\par%
		\end{multicols*}
		\vskip 0.75cm
		\noindent%
		\IfFileExists{./footer.pdf}{%
			\includegraphics[width=\linewidth]{footer.pdf}%
		}{%
			\includegraphics[draft,width=\linewidth,height=.07772507495642290920\linewidth]{footer.pdf}%
		}%
	}}}%
	\newlength{\snapshot@creditstotalheight}%
	\settototalheight{\snapshot@creditstotalheight}{\usebox{\snapshot@credits}}%
	\vfill%
	\noindent\usebox{\snapshot@credits}%
}

% Disable single lines at the start of a paragraph (Schusterjungen)
\clubpenalty = 10000
%
% Disable single lines at the end of a paragraph (Hurenkinder)
\widowpenalty = 10000 \displaywidowpenalty = 10000
