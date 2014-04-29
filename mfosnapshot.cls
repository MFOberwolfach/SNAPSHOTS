\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mfosnapshot}[2014/04/24 Document class for "Snapshots from Oberwolfach"]
\LoadClass[10pt,twoside]{scrartcl}  

\RequirePackage{iftex}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tools
\RequirePackage{calc}
\RequirePackage{etoolbox}
\appto{\abstract}{\relscale{1.3}\noindent\ignorespaces} 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% page layout
\RequirePackage[a5paper,top=12mm,bottom=22mm,outer=16mm,inner=12mm,foot=12.25mm,footnotesep=14pt]{geometry}
\RequirePackage{multicol}
\setlength{\columnsep}{2em}
\setlength\parindent{1.275em}

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
% references
\usepackage[backend=biber]{biblatex}
\usepackage{filecontents}
\newenvironment{bibfilecontents}{%
  \csname filecontents\endcsname{\jobname.bib}%
}%
{\csname endfilecontents\endcsname%
 \addbibresource{\jobname.bib}%
}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% language specific settings

% patch old KOMA script \newcaptionname and \renewcaptionname
\let\@orig@newcaptionname\newcaptionname%
\def\@my@newcaptionname#1#2#3{\@orig@newcaptionname{#3}{#1}{#2}}%
\def\newcaptionname#1#2#3{\forcsvlist{\@my@newcaptionname{#2}{#3}}{#1}}%
\let\@orig@renewcaptionname\renewcaptionname%
\def\@my@renewcaptionname#1#2#3{\@orig@renewcaptionname{#3}{#1}{#2}}%
\def\renewcaptionname#1#2#3{\forcsvlist{\@my@renewcaptionname{#2}{#3}}{#1}}%

% define captions
\AtBeginDocument{%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@bibliography}{References}%
	\newcaptionname{german,ngerman}{\snapshot@l@bibliography}{Referenzen}%
	%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@furtherreading}{Further reading}%
	\newcaptionname{german,ngerman}{\snapshot@l@furtherreading}{Weiterf\"uhrende Literatur}%
	%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@header}{Snapshots of modern mathematics\\from Oberwolfach}%
	\newcaptionname{german,ngerman}{\snapshot@l@header}{Schnappsch\"usse moderner Mathematik\\aus Oberwolfach}%
	%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@creditstext}{\emph{Snapshots of modern mathematics from Oberwolfach} is a mathematics communication project of the Mathematisches Forschungsinstitut Oberwolfach (MFO) and IMAGINARY -- open mathematics. It is a part of the project Oberwolfach meets IMAGINARY funded by the Klaus Tschira Foundation and the Oberwolfach Foundation. The snapshots are written by participants of the scientific program of the institute. They are reviewed by the organizers of the scientific program and edited by a team of editors. All snapshots can be found on \href{http://www.imaginary.org}{\nolinkurl{www.imaginary.org}}.}%
	\newcaptionname{german,ngerman}{\snapshot@l@creditstext}{\textbf{Bitte auf Deutsch \"ubersetzen}\emph{Snapshots of modern mathematics from Oberwolfach} is a mathematics communication project of the Mathematisches Forschungsinstitut Oberwolfach (MFO) and IMAGINARY -- open mathematics. It is a part of the project Oberwolfach meets IMAGINARY funded by the Klaus Tschira Foundation and the Oberwolfach Foundation. The snapshots are written by participants of the scientific program of the institute. They are refereed (???) by the organizers of the scientific program and edited by a team of editors. All snapshots can be found on \href{http://www.imaginary.org}{\nolinkurl{www.imaginary.org}}.}%
	%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@organizer}{Responsible Organizer}%
	\newcaptionname{german,ngerman}{\snapshot@l@organizer}{Verantwortlicher Organisator}%
	%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@classification}{Mathematical subject classification}%
	\newcaptionname{german,ngerman}{\snapshot@l@classification}{\textbf{\"Ubersetzen!}Mathe-Klassifikation}%
	%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@license}{License}%
	\newcaptionname{german,ngerman}{\snapshot@l@license}{Lizenz}%
	%
	\newcaptionname{english,USenglish,UKenglish,german,ngerman}{\snapshot@l@doi}{DOI}%
	%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@junioreditor}{Junior Editor}%
	\newcaptionname{german,ngerman}{\snapshot@l@junioreditor}{Junioreditor}%
	%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@senioreditor}{Senior Editor}%
	\newcaptionname{german,ngerman}{\snapshot@l@senioreditor}{Senioreditor}%
	%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@director}{Director}%
	\newcaptionname{german,ngerman}{\snapshot@l@director}{Direktor}%
	%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@logos@page}{1}%
	\newcaptionname{german,ngerman}{\snapshot@l@logos@page}{2}%
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


\newcommand{\snapshot@id}{\ClassWarningNoLine{mfosnapshot}{No snapshot id given}xx}%
\newcommand{\snapshot@year}{xxxx}%
\AtBeginDocument{\newcaptionname{english,USenglish,UKenglish,german,ngerman}{\snapshot@doi}{\ClassWarningNoLine{mfosnapshot}{Unable to compute DOI}--}}%
\gdef\snapshot@doiurlprefix{http://dx.doi.org/}%
\newcommand*{\snapshotid}[2]{%
	\gdef\snapshot@id{#1}%
	\gdef\snapshot@year{#2}%
	\AtBeginDocument{%
		\renewcaptionname{english,USenglish,UKenglish}{\snapshot@doi}{10.14760/SNAP-#2-\ifnum#1>99\else\ifnum#1>9 0\else00\fi\fi\number#1-EN}%
		\renewcaptionname{german,ngerman}{\snapshot@doi}{10.14760/SNAP-#2-\ifnum#1>99\else\ifnum#1>9 0\else00\fi\fi\number#1-DE}%
	}%
}%

\newcommand{\mailtoref}[1]{\href{mailto://#1}{\nolinkurl{#1}}}
\newcommand{\httpref}[1]{\href{http://#1}{\nolinkurl{#1}}}
\newcommand{\ftpref}[1]{\href{ftp://#1}{\nolinkurl{#1}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% author info
\newcounter{ctrmaxmfosnapshotauthorinfo}
\setcounter{ctrmaxmfosnapshotauthorinfo}{0}
\newcommand*{\authorinfo}[1]{%
	\expandafter\newcommand\csname snapshot@authorinfo\the\value{ctrmaxmfosnapshotauthorinfo} \endcsname{#1}%
	\stepcounter{ctrmaxmfosnapshotauthorinfo}%
}

\newcommand{\@authorinfo}{%
	\bgroup
		\newcounter{ctrauthorinfo}%
		\setcounter{ctrauthorinfo}{0}%
		\whiledo {\value{ctrauthorinfo} < \value{ctrmaxmfosnapshotauthorinfo}}%
		{%
			\bgroup%
				\def\authorname##1{\emph{##1}}%
				\renewcommand\UrlFont{\em}%
				\textit{%
				\bgroup%
					%
					\DeclareRobustCommand\\{\let \reserved@e \relax\let \reserved@f \relax\@ifstar{}{}\let \reserved@e \vadjust \let \reserved@f \nobreak \@xnewline}%
					%
					\csname snapshot@authorinfo\the\value{ctrauthorinfo} \endcsname}\strut%
				\egroup%
			\egroup
			\stepcounter{ctrauthorinfo}%
			\vskip\medskipamount%
		}%
	\egroup
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% license info
% use \license{CC-BY-NC-SA-3.0} (default), \license{CC-BY-NC-ND-3.0} or \licence{CC-BY-SA-3.0}
\csdef{snapshot@license@CC-BY-NC-SA-3.0}{\href{http://creativecommons.org/licenses/by-nc-sa/3.0/}{Creative Commons BY-NC-SA 3.0}}
\csdef{snapshot@license@CC-BY-NC-ND-3.0}{\href{http://creativecommons.org/licenses/by-nc-nd/3.0/}{Creative Commons BY-NC-ND 3.0}}
\csdef{snapshot@license@CC-BY-SA-3.0}{\href{http://creativecommons.org/licenses/by-sa/3.0/}{Creative Commons BY-SA 3.0}}
\newcommand{\snapshot@license}{\csname snapshot@license@CC-BY-NC-SA-3.0\endcsname}
\newcommand{\license}[1]{%
	\expandafter\ifcsdef\expandafter{snapshot@license@#1}{%
		\renewcommand{\snapshot@license}{\csname snapshot@license@#1\endcsname}%
	}{\ClassError{mfosnapshot}{Unknown license name}{Please use one of CC-BY-NC-SA-3.0, CC-BY-NC-ND-3.0 or CC-BY-SA-3.0}}%	
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\snapshot@organizer}{\ClassWarningNoLine{mfosnapshot}{No responsible organizer given}--}%
\newcommand*{\organizer}[1]{\gdef\snapshot@organizer{#1}}%

\newcommand{\snapshot@classification}{\ClassWarningNoLine{mfosnapshot}{No mathematical subject classification given}--}%
\newcommand*{\classification}[1]{\gdef\snapshot@classification{#1}}%

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
  \parbox[t]{0.5\linewidth}{\arial\relscale{0.9}\SetTracking{encoding=*}{100}\lsstyle \snapshot@l@header}%
  \parbox[t]{0.5\linewidth}{\raggedleft\mbox{\textnumero\,\snapshot@id/\snapshot@year}}
  \vskip 4em%
  \begin{center}%
    \parbox[t]{0.75\linewidth}{\centering\titlefont \@title}\\[2em]

	\rule[0.5ex]{1cm}{0.526pt}\\[1.5em]%
    {%
      \relscale{1.2}
      \lineskip .5em%
      \arial
      \SetTracking{encoding=*}{100}\lsstyle%
      \def\@AndBullet{\unskip\,~$\bullet$~\,\ignorespaces\let\and\@AndNewLine}%
      \def\@AndNewLine{\unskip\\\let\and\@AndBullet}%
      \let\and\@AndBullet%
      \@author\par%
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
	\printbibliography[notkeyword=furtherreading,heading=bibliography,title={\snapshot@l@bibliography}]%
	\printbibliography[keyword=furtherreading,heading=bibliography,title={\snapshot@l@furtherreading}]%
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
			\textit{\snapshot@l@organizer}\\*
			\snapshot@organizer\\[\medskipamount]
			%
			\textit{\snapshot@l@classification}\\*
			\snapshot@classification\\[\medskipamount]
			%
			\textit{\snapshot@l@license}\\*
			\snapshot@license\\[\medskipamount]
			%
			\textit{\snapshot@l@doi}\\*
			\href{\snapshot@doiurlprefix\snapshot@doi}{\snapshot@doi}%
		\end{multicols}%
		\vskip 0.3cm%
		\par\hfill\rule[0.5ex]{1cm}{0.526pt}\hfill\null%
		\vskip 0.25cm
		\raggedright\arial\normalfont\snapshot@l@creditstext%
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
				\textit{\snapshot@l@junioreditor}\\
				\snapshot@junioreditor\\
				\snapshot@junioreditoremail\\[\medskipamount]
				%
				\textit{\snapshot@l@senioreditor}\\
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
				\textit{\snapshot@l@director}\\
				Prof.\;Dr.\;Gerhard Huisken%
			}\columnbreak\par%
		\end{multicols*}
		\vskip 0.75cm
		\noindent%
		\IfFileExists{./logos.pdf}{%
			\raisebox{-.34725559716718504883\height}[.65274440283281495117\height][-.34725559716718504883\height]{\includegraphics[width=\linewidth]{logos.pdf}}%
		}{%
			\includegraphics[draft,width=\linewidth,height=.05531029634083325809\linewidth,page=\snapshot@l@logos@page]{logos.pdf}%
		}%
	}}}%
	\clearpage%
	\noindent\null\vfill%
	\noindent\usebox{\snapshot@credits}%
}
