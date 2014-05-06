\NeedsTeXFormat{LaTeX2e}
\listfiles
\ProvidesClass{snapshotmfo}[2014/05/06 Document class for "Snapshots of modern mathematics from Oberwolfach"]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output warning if obsolute features are used
\IfFileExists{nag.sty}{\RequirePackage[l2tabu]{nag}}{}
%
\LoadClass[10pt,twoside]{scrartcl} 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% require pdflatex compiler if possible 
\IfFileExists{iftex.sty}{\RequirePackage{iftex}\RequirePDFTeX}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% misc (internal)
\def\snapshot@defaultcontent{will be filled out by editors}

\newcommand{\snapshot@define@spaces}{% define text mode spaces like in amsmath
	\DeclareRobustCommand{\tmspace}[3]{%
	  \ifmmode\mskip##1##2\else\kern##1##3\fi\relax}
	\renewcommand{\,}{\tmspace+\thinmuskip{.1667em}}
	\let\thinspace\,
	\renewcommand{\!}{\tmspace-\thinmuskip{.1667em}}
	\let\negthinspace\!
	\renewcommand{\:}{\tmspace+\medmuskip{.2222em}}
	\let\medspace\:
	\providecommand{\negmedspace}{\tmspace-\medmuskip{.2222em}}
	\renewcommand{\;}{\tmspace+\thickmuskip{.2777em}}
	\let\thickspace\;
	\providecommand{\negthickspace}{\tmspace-\thickmuskip{.2777em}}
	\providecommand{\mspace}[1]{\mskip##1\relax}
}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tools
\RequirePackage{etoolbox,ifthen}
\appto{\abstract}{\relscale{1.3}\noindent\ignorespaces} 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% page layout
\RequirePackage[a5paper,top=12mm,bottom=22mm,outer=16mm,inner=12mm,foot=12.25mm,footnotesep=14pt]{geometry}
\RequirePackage{multicol}
\setlength{\columnsep}{2em}
\setlength\parindent{1.275em}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% footnotes
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
% fonts & symbols
\RequirePackage[T1]{fontenc}
\RequirePackage{type1cm}
\RequirePackage[scaled=0.82304487406237511878]{helvet}
\RequirePackage{textcomp}
\RequirePackage{relsize}
\RequirePackage{ellipsis}
\RequirePackage[tracking=true]{microtype}
\DeclareMicrotypeSet*[tracking]{letterspacedHelvetica}{family=phv}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% references (via BibTeX)
\let\snapshot@bibliography\bibliography
\def\bibliography{\bibliographystyle{amsplain}\snapshot@bibliography}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% language specific settings

% patch old KOMA script \newcaptionname and \renewcaptionname
\let\@orig@newcaptionname\newcaptionname%
\def\@my@newcaptionname#1#2#3{\@orig@newcaptionname{#3}{#1}{#2}}%
\def\newcaptionname#1#2#3{\forcsvlist{\@my@newcaptionname{#2}{#3}}{#1}}%
\let\@orig@renewcaptionname\renewcaptionname%
\def\@my@renewcaptionname#1#2#3{\@orig@renewcaptionname{#3}{#1}{#2}}%
\def\renewcaptionname#1#2#3{\forcsvlist{\@my@renewcaptionname{#2}{#3}}{#1}}%

\def\newcscaptionname#1#2#3{%
	\begingroup%
		\def\newcscaptionname@tmp{\newcaptionname{#1}}%
		\expandafter\newcscaptionname@tmp\csname #2\endcsname{#3}%
	\endgroup%
}
\def\renewcscaptionname#1#2#3{%
	\begingroup%
		\def\renewcscaptionname@tmp{\newcaptionname{#1}}%
		\expandafter\renewcscaptionname@tmp\csname #2\endcsname{#3}%
	\endgroup%
}

% define captions
\AtBeginDocument{%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@header}{Snapshots of modern mathematics\\from Oberwolfach}%
	\newcaptionname{german,ngerman}{\snapshot@l@header}{Schnappsch\"usse moderner Mathematik\\aus Oberwolfach}%
	%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@creditstext}{\emph{Snapshots of modern mathematics from Oberwolfach} are written by participants in the scientific program of the Mathematisches Forschungsinstitut Oberwolfach (MFO). The snapshot project is designed to promote the understanding and appreciation of modern mathematics and mathematical research in the general public world-wide. It is part of the mathematics communication project 'Oberwolfach meets IMAGINARY' funded by the Klaus Tschira Foundation and the Oberwolfach Foundation. All snapshots can be found on \href{http://www.imaginary.org}{\nolinkurl{www.imaginary.org}}.}%
	\newcaptionname{german,ngerman}{\snapshot@l@creditstext}{\emph{Schnappsch\"usse moderner Mathematik aus Oberwolfach} werden von Teilnehmerinnen und Teilnehmern des wissenschaftlichen Programms des Mathematischen Forschungsinstituts Oberwolfach (MFO) geschrieben. Das Schnappschuss-Projekt hat zum Ziel, Verst\"andnis und Wertsch\"atzung f\"ur moderne Mathematik und mathematische Forschung in der allgemeinen Bev\"olkerung weltweit zu f\"ordern. Es ist Teil des Mathematikkommunikation-Projektes 'Oberwolfach trifft IMAGINARY', welches von der Klaus Tschira Stiftung und der Oberwolfach Stiftung gef\"ordert wird. Alle Schnappsch\"usse k\"onnen unter \href{http://www.imaginary.org}{\nolinkurl{www.imaginary.org}} abgerufen werden.}%
	%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@organizer}{Communicated by}%
	\newcaptionname{german,ngerman}{\snapshot@l@organizer}{Vorgeschlagen von}%
	%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@label@l@categorization@math}{Mathematical subjects}%
	\newcaptionname{german,ngerman}{\snapshot@label@l@categorization@math}{Mathematische Gebiete}%
	%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@label@l@categorization@connect}{Connections to other fields}%
	\newcaptionname{german,ngerman}{\snapshot@label@l@categorization@connect}{Verbindungen zu anderen Gebieten}%
	%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@license}{License}%
	\newcaptionname{german,ngerman}{\snapshot@l@license}{Lizenz}%
	%
	\newcaptionname{english,USenglish,UKenglish,german,ngerman}{\snapshot@l@doi}{DOI}%
	%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@junioreditor}{Junior Editor}%
	\newcaptionname{german,ngerman}{\snapshot@l@junioreditor}{Editor/in}%
	%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@senioreditor}{Senior Editor}%
	\newcaptionname{german,ngerman}{\snapshot@l@senioreditor}{Chefeditorin}%
	%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@director}{Director}%
	\newcaptionname{german,ngerman}{\snapshot@l@director}{Direktor}%
	%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@epslogo}{\snapshot@includemps{\snapshot@logo@en}{1}{1}}%
	\newcaptionname{german,ngerman}{\snapshot@l@epslogo}{\snapshot@includemps{\snapshot@logo@de}{1}{1}}%
	%
	% categorization: math
	\newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@math@algebra and number theory}{Algebra and Number Theory}
	\newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@math@analysis}{Analysis}
	\newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@math@discrete mathematics and foundations}{Discrete Mathematics and Foundations}
	\newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@math@geometry and topology}{Geometry and Topology}
	\newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@math@numerics and scientific computing}{Numerics and Scientific Computing}
	\newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@math@probability theory and statistics}{Probability Theory and Statistics}
	\newcscaptionname{german,ngerman}{snaphot@l@categorization@math@algebra and number theory}{Algebra und Zahlentheorie}
	\newcscaptionname{german,ngerman}{snaphot@l@categorization@math@analysis}{Analysis}
	\newcscaptionname{german,ngerman}{snaphot@l@categorization@math@discrete mathematics and foundations}{Diskrete Mathematik und Grundlagen}
	\newcscaptionname{german,ngerman}{snaphot@l@categorization@math@geometry and topology}{Geometrie und Topologie}
	\newcscaptionname{german,ngerman}{snaphot@l@categorization@math@numerics and scientific computing}{Numerik und Wissenschaftliches Rechnen}
	\newcscaptionname{german,ngerman}{snaphot@l@categorization@math@probability theory and statistics}{Wahrscheinlichkeitstheorie und Statistik}
	%
	% categorization: connection to other fields
	\newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@connect@chemistry and earth science}{Chemistry and Earth Science}
	\newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@connect@computer science}{Computer Science}
	\newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@connect@engineering and technology}{Engineering and Technology}
	\newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@connect@finance}{Finance}
	\newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@connect@humanities and social sciences}{Humanities and Social Sciences}
	\newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@connect@life science}{Life Science}
	\newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@connect@physics}{Physics}
	\newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@connect@reflections on mathematics}{Reflections on Mathematics}
	\newcscaptionname{german,ngerman}{snaphot@l@categorization@connect@chemistry and earth science}{Chemie und Geowissenschaften}
	\newcscaptionname{german,ngerman}{snaphot@l@categorization@connect@computer science}{Informatik}
	\newcscaptionname{german,ngerman}{snaphot@l@categorization@connect@engineering and technology}{Ingenieurwissenschaften und Technik}
	\newcscaptionname{german,ngerman}{snaphot@l@categorization@connect@finance}{Finanzwissenschaften}
	\newcscaptionname{german,ngerman}{snaphot@l@categorization@connect@humanities and social sciences}{Geistes- und Sozialwissenschaften}
	\newcscaptionname{german,ngerman}{snaphot@l@categorization@connect@life science}{Lebenswissenschaften}
	\newcscaptionname{german,ngerman}{snaphot@l@categorization@connect@physics}{Physik}
	\newcscaptionname{german,ngerman}{snaphot@l@categorization@connect@reflections on mathematics}{Betrachtungen über Mathematik}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% graphics inclusion and basic color management
\RequirePackage{graphicx,color}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% formatting of lists
\RequirePackage{enumitem}
\setitemize[1]{noitemsep,leftmargin=1.5em,labelsep=*,label={$\bullet$}}
\setitemize[2]{noitemsep,leftmargin=1.5em,labelsep=*,label={$\circ$}}
\setitemize[3]{noitemsep,leftmargin=1.5em,labelsep=*,label={$*$}}
\setitemize[4]{noitemsep,leftmargin=1.5em,labelsep=*,label={--}}
%
\setenumerate[1]{noitemsep,leftmargin=1.5em,labelsep=*,label=\sffamily\arabic*.}
\setenumerate[2]{noitemsep,leftmargin=1.5em,labelsep=*,label=\sffamily\alph*)}
\setenumerate[3]{noitemsep,align=left,leftmargin=1.5em,labelsep=*,label=\sffamily\roman*.}
\setenumerate[4]{noitemsep,leftmargin=1.5em,labelsep=*,label=\sffamily\Alph*.}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hyperlinks
\RequirePackage[hidelinks]{hyperref}
\newcommand{\mailtoref}[1]{\href{mailto://#1}{\nolinkurl{#1}}}
\newcommand{\httpref}[1]{\href{http://#1}{\nolinkurl{#1}}}
\newcommand{\ftpref}[1]{\href{ftp://#1}{\nolinkurl{#1}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% page header/footer
\RequirePackage{scrpage2}
\pagestyle{scrheadings}
\renewcommand*{\titlepagestyle}{scrheadings}
\clearscrheadfoot
\cfoot{\pagemark}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% font settings

% \underline command which always adds an invisible depth of the letter 'g' 
\newcommand{\snapshot@gunderline}[1]{\ifmmode \@@underline {#1\protect\vphantom{g}}\else $\@@underline {\hbox {#1\protect\vphantom{g}}}\m@th $\relax \fi}

\setkomafont{pagenumber}{\normalfont\sffamily\relscale{1.1}}
\setkomafont{section}{\normalfont\sffamily\relscale{1.32}\lsstyle\snapshot@gunderline}

\setkomafont{subsection}{\normalfont\sffamily\relscale{1.1}\lsstyle}
\setkomafont{subsubsection}{\normalfont\sffamily\relscale{1.1}\lsstyle}
\setkomafont{paragraph}{\normalfont\sffamily\relscale{1.1}\lsstyle}
\setkomafont{subparagraph}{\normalfont\sffamily\relscale{1.1}\lsstyle}
\setkomafont{captionlabel}{\normalfont\sffamily\relscale{1.1}\lsstyle}

\setkomafont{title}{\renewcommand{\baselinestretch}{0.8}\color[gray]{0.25}\sffamily\relscale{1.8}\lsstyle}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% snapshot id and DOI computation
\newcommand{\snapshot@id}{\ClassWarningNoLine{snapshotmfo}{No snapshot id given}xx}%
\newcommand{\snapshot@year}{xxxx}%
\AtBeginDocument{\newcaptionname{english,USenglish,UKenglish,german,ngerman}{\snapshot@doi}{\ClassWarningNoLine{snapshotmfo}{Unable to compute DOI}\snapshot@defaultcontent}}%
\gdef\snapshot@doiurlprefix{http://dx.doi.org/}%
\newcommand*{\snapshotid}[2]{%
	\begingroup%
		\@tempcnta=#1%
		\global\edef\snapshot@id{\the\@tempcnta}%
	\endgroup%
	\gdef\snapshot@year{#2}%
	\AtBeginDocument{%
		\renewcaptionname{english,USenglish,UKenglish}{\snapshot@doi}{10.14760/SNAP-#2-\ifnum#1>99\else\ifnum#1>9 0\else00\fi\fi\number#1-EN}%
		\renewcaptionname{german,ngerman}{\snapshot@doi}{10.14760/SNAP-#2-\ifnum#1>99\else\ifnum#1>9 0\else00\fi\fi\number#1-DE}%
	}%
}%

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
\newcommand{\snapshot@license}{\ClassWarningNoLine{snapshotmfo}{No license information given}\snapshot@defaultcontent}
\newcommand{\license}[1]{%
	\expandafter\ifcsdef\expandafter{snapshot@license@#1}{%
		\renewcommand{\snapshot@license}{\csname snapshot@license@#1\endcsname}%
	}{\ClassError{snapshotmfo}{Unknown license name}{Please use one of CC-BY-NC-SA-3.0, CC-BY-NC-ND-3.0 or CC-BY-SA-3.0}}%	
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% categorization: math
\gdef\snapshot@categorization@math{\ClassWarningNoLine{snapshotmfo}{No mathematical subject given}\snapshot@defaultcontent}
\newcommand*{\categorizationmath}[1]{%
	\gdef\snapshot@categorization@math{\begingroup\def\and{\def\and{,\space}}}%
	\begingroup%
		\listadd\snapshot@categorization@math@subjects{algebra and number theory}%
		\listadd\snapshot@categorization@math@subjects{analysis}%
		\listadd\snapshot@categorization@math@subjects{discrete mathematics and foundations}%
		\listadd\snapshot@categorization@math@subjects{geometry and topology}%
		\listadd\snapshot@categorization@math@subjects{numerics and scientific computing}%
		\listadd\snapshot@categorization@math@subjects{probability theory and statistics}%
		\def\snapshot@add@categorization@math##1{%
			\xifinlist{##1}{\snapshot@categorization@math@subjects}%
			{%
				\gappto\snapshot@categorization@math{\and \expandafter\csname snaphot@l@categorization@math@##1\endcsname}%
			}{%
				\ClassError{snapshotmfo}{Unknown category "##1" in \@backslashchar categorizationmath}{possibilities: \snapshot@categorization@math@subjects}%
			}%
		}%
		\forcsvlist{\snapshot@add@categorization@math}{#1}%
	\endgroup%
	\gappto\snapshot@categorization@math{\endgroup}%
}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% categorization: connection to other fields
\gdef\snapshot@categorization@connect{\ClassWarningNoLine{snapshotmfo}{No connection to other fields given}\snapshot@defaultcontent}
\newcommand*{\categorizationconnect}[1]{%
	\gdef\snapshot@categorization@connect{\begingroup\def\and{\def\and{,\space}}}%
	\begingroup%
		\listadd\snapshot@categorization@connect@subjects{chemistry and earth science}%
		\listadd\snapshot@categorization@connect@subjects{computer science}%
		\listadd\snapshot@categorization@connect@subjects{engineering and technology}%
		\listadd\snapshot@categorization@connect@subjects{finance}%
		\listadd\snapshot@categorization@connect@subjects{humanities and social sciences}%
		\listadd\snapshot@categorization@connect@subjects{life science}%
		\listadd\snapshot@categorization@connect@subjects{physics}%
		\listadd\snapshot@categorization@connect@subjects{reflections on mathematics}%
		\def\snapshot@add@categorization@connect##1{%
			\xifinlist{##1}{\snapshot@categorization@connect@subjects}%
			{%
				\gappto\snapshot@categorization@connect{\and \expandafter\csname snaphot@l@categorization@connect@##1\endcsname}%
			}{%
				\ClassError{snapshotmfo}{Unknown category "##1" in \@backslashchar categorizationconnect}{possibilities: \snapshot@categorization@connect@subjects}%
			}%
		}%
		\forcsvlist{\snapshot@add@categorization@connect}{#1}%
	\endgroup%
	\gappto\snapshot@categorization@connect{\endgroup}%
}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% organizer
\newcommand{\snapshot@organizer}{\ClassWarningNoLine{snapshotmfo}{No responsible organizer given}\snapshot@defaultcontent}%
\newcommand*{\organizer}[1]{\gdef\snapshot@organizer{#1}}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% junior editor
\newcommand{\snapshot@junioreditor}{\ClassWarningNoLine{snapshotmfo}{No junior editor given}\snapshot@defaultcontent}%
\newcommand{\snapshot@junioreditoremail}{--}%
\newcommand*{\junioreditor}[2]{%
	\gdef\snapshot@junioreditor{#1}%
	\gdef\snapshot@junioreditoremail{\mailtoref{#2}}%
}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% senior editor
\newcommand{\snapshot@senioreditor}{\ClassWarningNoLine{snapshotmfo}{No senior editor given}\snapshot@defaultcontent}%
\newcommand{\snapshot@senioreditoremail}{--}%
\newcommand*{\senioreditor}[2]{%
	\gdef\snapshot@senioreditor{#1}%
	\gdef\snapshot@senioreditoremail{\mailtoref{#2}}%
}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% director
\newcommand{\snapshot@director}{\ClassWarningNoLine{snapshotmfo}{No director given}\snapshot@defaultcontent}%
\newcommand*{\director}[1]{%
	\gdef\snapshot@director{#1}%
}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% define title
\renewcommand*\maketitle{%
	\par
	\begingroup
		\snapshot@define@spaces%
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
  \parbox[t]{0.5\linewidth}{\sffamily\relscale{0.9}\snapshot@l@header}%
  \parbox[t]{0.5\linewidth}{\raggedleft\mbox{\textnumero\,\snapshot@id/\snapshot@year}}
  \vskip 4em%
  \begin{center}%
    \parbox[t]{0.75\linewidth}{\centering\titlefont \@title}\\[2em]

	\rule[0.5ex]{1cm}{0.526pt}\\[1.5em]%
    {%
      \relscale{1.2}
      \lineskip .5em%
      \sffamily
      \lsstyle%
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
\AtBeginDocument{\maketitle}% automatically typeset title 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% define last page (credits, footer, ...)
\AtEndDocument{%
	\patchcmd{\footnoterule}{\vskip \z@ \@plus .05fil}{}{}{}%
	\raggedbottom%
	\newsavebox{\snapshot@credits}%
	\sbox{\snapshot@credits}{\hbox{\parbox[t]{\linewidth}{%
		\snapshot@define@spaces%
		\raggedcolumns
		\renewcommand\UrlFont{}%
		\relscale{0.9}%
		\widowpenalties 1 10000%
		\medskipamount2ex%
		\multicolsep=0pt%
		\begin{multicols}{2}%
			\renewcommand{\baselinestretch}{0.8}
			\sffamily%
			\raggedright%
			\@authorinfo%
			%
			\textit{\snapshot@l@organizer}\\*
			\snapshot@organizer\\[\medskipamount]
			%
			\textit{\snapshot@label@l@categorization@math}\\*
			\snapshot@categorization@math\\[\medskipamount]
			%
			\textit{\snapshot@label@l@categorization@connect}\\*
			\snapshot@categorization@connect\\[\medskipamount]
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
		\raggedright\normalfont\snapshot@l@creditstext%
		%\vskip-\baselineskip%
		\vskip 0.25cm%
		\par\hfill\rule[0.5ex]{1cm}{0.526pt}\hfill\null%
		\vskip 0.4cm%
	    %{\ifx\@subtitle\@empty\else\usekomafont{subtitle}\@subtitle\par\fi}%
    	%
		\begin{multicols}{2}%
			\renewcommand{\baselinestretch}{0.8}%
	    	\sffamily
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
				\snapshot@director%
			}\columnbreak\par%
		\end{multicols}%
		\vskip 0.75cm
		\noindent%
		\def\testtest{\snapshot@logo@de}%
		\raisebox{-.34725559716718504883\height}[.65274440283281495117\height][-.34725559716718504883\height]{%
			\resizebox*{\linewidth}{!}{\snapshot@l@epslogo}%
		}%
	}}}%
	\clearpage%
	\noindent\null\vfill%
	\noindent\usebox{\snapshot@credits}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% inline inclusion of purified EPS files
% such as created by METAPOST (*.mps) or
% purifyeps

\newcommand*{\snapshot@savemps}[1]{%
  \begingroup
  \@sanitize % verbatim catcodes
  \catcode`\ =10 % except space
  \catcode`\^^A=14 % new comment char
  % keep lines:
  \@makeother\^^J% Line feed as character
  \endlinechar=`\^^J % end lines with line feed
  \snapshot@savemps@{#1}%
}
\newcommand*{\snapshot@savemps@}[2]{%
  \endgroup
  \def#1{#2}%
  % catch odd new line
  \futurelet\@let@token\snapshot@savemps@gobbleLF
}
\newcommand*{\snapshot@savemps@gobbleLF}{%
  \ifx\@let@token\snapshot@includemps@J
    \expandafter\@gobble
  \fi
}
\begingroup
  \lccode`\9=`\^^J %
\lowercase{\endgroup
  \let\snapshot@includemps@J=9%
}
\newcommand*{\snapshot@includemps}[3]{%
  \begingroup
    \def\input##1\relax{\scantokens\expandafter{##1}}%
    \convertMPtoPDF{#1}{#2}{#3}%
  \endgroup
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% purified EPS logos
% workflow to inline page x of file.pdf:
%  1. pdftops -eps -f x -l x file.pdf - | purifyeps > file.eps
%  2. copy the content of file.eps into one of the macros below

\snapshot@savemps\snapshot@logo@en{
%!PS-Adobe-3.0 EPSF-3.0
%%BoundingBox: 0 0 520 44 
%%HiResBoundingBox: 0.44351 0.65492 519.953 43.47346 
%%Creator: MetaPost 1.803
%%CreationDate: 2014.04.30:1855
%%Pages: 1
%%BeginProlog
%%EndProlog
%%Page: 1 1
 0.0941 0.0941 0.0941 setrgbcolor
newpath 487.05899 18.5352 moveto
487.629 18.5352 lineto
487.629 19.0273 lineto
487.05899 19.0273 lineto
487.05899 20.1328 lineto
486.52301 20.1328 lineto
486.52301 19.0273 lineto
486.219 19.0273 lineto
486.219 18.5352 lineto
486.52301 18.5352 lineto
486.52301 16.1875 lineto
487.05899 16.1875 lineto
 closepath fill
newpath 467.43799 18.5352 moveto
467.97299 18.5352 lineto
467.97299 19.0273 lineto
467.43799 19.0273 lineto
467.43799 20.1328 lineto
466.867 20.1328 lineto
466.867 19.0273 lineto
466.56201 19.0273 lineto
466.56201 18.5352 lineto
466.867 18.5352 lineto
466.867 16.1875 lineto
467.43799 16.1875 lineto
 closepath fill
newpath 495.742 18.6289 moveto
495.59 18.9531 495.305 19.125 494.961 19.125 curveto
494.48401 19.125 494.125 18.7812 494.125 18.2852 curveto
494.125 17.9023 494.35199 17.75 494.66 17.5781 curveto
495.211 17.293 lineto
495.324 17.1992 495.39801 17.1211 495.39801 16.9688 curveto
495.39801 16.7227 495.211 16.5898 494.98001 16.5898 curveto
494.715 16.5898 494.56201 16.7227 494.469 16.9492 curveto
493.97299 16.7227 lineto
494.14499 16.3242 494.56201 16.0742 494.98001 16.0742 curveto
495.496 16.0742 495.97299 16.4727 495.97299 17.0273 curveto
495.97299 17.4648 495.64801 17.6914 495.305 17.8438 curveto
494.961 17.97661 494.64099 18.1094 494.64099 18.3398 curveto
494.64099 18.5117 494.793 18.6289 494.926 18.6289 curveto
495.094 18.6289 495.23001 18.5352 495.305 18.39839 curveto
 closepath fill
newpath 493.211 18.4961 moveto
493.094 18.6836 492.715 19.125 492.06601 19.125 curveto
491.19101 19.125 490.504 18.4727 490.504 17.5781 curveto
490.504 16.7227 491.19101 16.0742 492.02701 16.0742 curveto
492.66 16.0742 493.004 16.418 493.172 16.66411 curveto
492.793 16.9492 lineto
492.621 16.7578 492.445 16.5898 492.047 16.5898 curveto
491.43799 16.5898 491.039 17.0273 491.039 17.6172 curveto
491.039 18.1289 491.457 18.6289 492.008 18.6289 curveto
492.332 18.6289 492.59799 18.4727 492.80899 18.2227 curveto
 closepath fill
newpath 489.078 20.7422 moveto
488.84799 20.7422 488.695 20.5508 488.695 20.3398 curveto
488.695 20.1328 488.84799 19.9805 489.078 19.9805 curveto
489.26999 19.9805 489.457 20.1328 489.457 20.3398 curveto
489.457 20.5508 489.26999 20.7422 489.078 20.7422 curveto
 closepath fill
newpath 489.324 19.0273 moveto
488.793 19.0273 lineto
488.793 16.1875 lineto
489.324 16.1875 lineto
 closepath fill
newpath 484.906 19.0273 moveto
484.35199 19.0273 lineto
484.35199 18.5703 lineto
484.121 18.91411 483.781 19.125 483.363 19.125 curveto
483.457 18.6289 lineto
484.047 18.6289 484.39099 18.168 484.39099 17.6172 curveto
484.39099 17.0469 484.047 16.5898 483.457 16.5898 curveto
483.457 16.5898 lineto
482.867 16.5898 482.543 17.082 482.543 17.6172 curveto
482.543 18.1289 482.887 18.6289 483.457 18.6289 curveto
483.363 19.125 lineto
482.52301 19.125 482.012 18.418 482.012 17.6328 curveto
482.012 16.7969 482.504 16.0742 483.363 16.0742 curveto
483.781 16.0742 484.121 16.3047 484.35199 16.625 curveto
484.35199 16.1875 lineto
484.906 16.1875 lineto
 closepath fill
newpath 477.47699 19.0273 moveto
476.922 19.0273 lineto
476.922 16.1875 lineto
477.47699 16.1875 lineto
477.47699 17.5781 lineto
477.47699 18.0352 477.51599 18.6289 478.10501 18.6289 curveto
478.60199 18.6289 478.621 18.0742 478.621 17.6914 curveto
478.621 16.1875 lineto
479.172 16.1875 lineto
479.172 17.5781 lineto
479.172 18.0352 479.23001 18.6289 479.801 18.6289 curveto
480.293 18.6289 480.35199 18.168 480.35199 17.78911 curveto
480.35199 16.1875 lineto
480.883 16.1875 lineto
480.883 17.8828 lineto
480.883 18.5352 480.695 19.125 479.953 19.125 curveto
479.59 19.125 479.246 18.9336 479.05899 18.6289 curveto
478.867 18.9531 478.60199 19.125 478.238 19.125 curveto
477.914 19.125 477.64801 18.9336 477.47699 18.668 curveto
 closepath fill
newpath 475.60901 17.5 moveto
475.60901 17.5977 lineto
475.60901 18.457 475.172 19.125 474.258 19.125 curveto
473.34 19.125 472.883 18.457 472.883 17.5781 curveto
472.883 16.7422 473.40201 16.0742 474.27701 16.0742 curveto
474.828 16.0742 475.344 16.3594 475.60901 16.8555 curveto
475.15201 17.1211 lineto
474.94101 16.7773 474.715 16.5898 474.27701 16.5898 curveto
473.762 16.5898 473.44101 17.0273 473.418 17.5 curveto
473.453 17.9414 lineto
473.51599 18.3398 473.84 18.64839 474.258 18.64839 curveto
474.715 18.64839 475 18.3789 475.05899 17.9414 curveto
473.453 17.9414 lineto
473.418 17.5 lineto
 closepath fill
newpath 469.207 20.7578 moveto
469.207 16.1875 lineto
469.762 16.1875 lineto
469.762 17.4844 lineto
469.762 18.0156 469.762 18.6289 470.469 18.6289 curveto
471.039 18.6289 471.09799 18.2852 471.09799 17.8047 curveto
471.09799 16.1875 lineto
471.64801 16.1875 lineto
471.64801 17.8828 lineto
471.64801 18.58589 471.43799 19.125 470.621 19.125 curveto
470.297 19.125 469.949 18.9727 469.762 18.64839 curveto
469.762 20.7578 lineto
 closepath fill
newpath 465.34 19.0273 moveto
464.80899 19.0273 lineto
464.80899 18.5703 lineto
464.789 18.5703 lineto
464.55899 18.91411 464.219 19.125 463.801 19.125 curveto
463.89499 18.6289 lineto
464.48401 18.6289 464.828 18.168 464.828 17.6172 curveto
464.828 17.0469 464.48401 16.5898 463.89499 16.5898 curveto
463.89499 16.5898 lineto
463.305 16.5898 462.98001 17.082 462.98001 17.6172 curveto
462.98001 18.1289 463.324 18.6289 463.89499 18.6289 curveto
463.801 19.125 lineto
462.961 19.125 462.449 18.418 462.449 17.6328 curveto
462.449 16.7969 462.94101 16.0742 463.801 16.0742 curveto
464.219 16.0742 464.55899 16.3047 464.789 16.625 curveto
464.80899 16.625 lineto
464.80899 16.1875 lineto
465.34 16.1875 lineto
 closepath fill
newpath 457.91 19.0273 moveto
457.34 19.0273 lineto
457.34 16.1875 lineto
457.91 16.1875 lineto
457.91 17.5781 lineto
457.91 18.0352 457.949 18.6289 458.543 18.6289 curveto
459.05899 18.6289 459.074 18.0742 459.074 17.6914 curveto
459.074 16.1875 lineto
459.629 16.1875 lineto
459.629 17.5781 lineto
459.629 18.0352 459.668 18.6289 460.258 18.6289 curveto
460.73001 18.6289 460.789 18.168 460.789 17.78911 curveto
460.789 16.1875 lineto
461.32 16.1875 lineto
461.32 17.8828 lineto
461.32 18.5352 461.133 19.125 460.39099 19.125 curveto
460.02701 19.125 459.68399 18.9336 459.492 18.6289 curveto
459.324 18.9531 459.05899 19.125 458.676 19.125 curveto
458.34799 19.125 458.06299 18.9336 457.91 18.668 curveto
 closepath fill
newpath 451.39801 19.0273 moveto
450.844 19.0273 lineto
450.844 16.1875 lineto
451.39801 16.1875 lineto
451.39801 17.4844 lineto
451.39801 18.0156 451.39801 18.6289 452.10199 18.6289 curveto
452.676 18.6289 452.75 18.2852 452.75 17.8047 curveto
452.75 16.1875 lineto
453.26599 16.1875 lineto
453.26599 17.8828 lineto
453.26599 18.58589 453.094 19.125 452.27301 19.125 curveto
451.93399 19.125 451.59 18.9727 451.418 18.64839 curveto
451.39801 18.64839 lineto
 closepath fill
newpath 449.758 17.5 moveto
449.758 17.5977 lineto
449.758 18.457 449.34 19.125 448.426 19.125 curveto
447.512 19.125 447.039 18.457 447.039 17.5781 curveto
447.039 16.7422 447.57 16.0742 448.426 16.0742 curveto
448.996 16.0742 449.492 16.3594 449.758 16.8555 curveto
449.301 17.1211 lineto
449.094 16.7773 448.863 16.5898 448.426 16.5898 curveto
447.914 16.5898 447.59 17.0273 447.59 17.5 curveto
447.60901 17.9414 lineto
447.68399 18.3398 448.008 18.64839 448.426 18.64839 curveto
448.863 18.64839 449.14801 18.3789 449.207 17.9414 curveto
447.60901 17.9414 lineto
447.59 17.5 lineto
 closepath fill
newpath 443.762 19.0273 moveto
443.207 19.0273 lineto
443.207 14.5352 lineto
443.762 14.5352 lineto
443.762 16.625 lineto
443.781 16.625 lineto
443.988 16.3047 444.332 16.0742 444.75 16.0742 curveto
445.625 16.0742 446.10199 16.7969 446.10199 17.6328 curveto
446.10199 18.418 445.586 19.125 444.76999 19.125 curveto
444.637 18.6289 lineto
445.22699 18.6289 445.57 18.168 445.57 17.6172 curveto
445.57 17.0469 445.22699 16.5898 444.637 16.5898 curveto
444.637 16.5898 lineto
444.047 16.5898 443.72299 17.082 443.72299 17.6172 curveto
443.72299 18.1289 444.06601 18.6289 444.637 18.6289 curveto
444.76999 19.125 lineto
444.332 19.125 443.988 18.91411 443.781 18.5703 curveto
443.762 18.5703 lineto
 closepath fill
newpath 440.711 19.125 moveto
440.711 18.6094 lineto
441.262 18.6094 441.703 18.14839 441.703 17.5977 curveto
441.703 17.0664 441.262 16.625 440.711 16.625 curveto
440.18 16.625 439.762 17.0664 439.762 17.5977 curveto
439.762 18.14839 440.18 18.6094 440.711 18.6094 curveto
440.711 18.6094 lineto
440.711 19.125 lineto
439.875 19.125 439.19101 18.457 439.19101 17.5977 curveto
439.19101 16.7422 439.875 16.0742 440.711 16.0742 curveto
441.57 16.0742 442.254 16.7422 442.254 17.5977 curveto
442.254 18.457 441.57 19.125 440.711 19.125 curveto
 closepath fill
newpath 495.72299 24.1133 moveto
497.555 24.1133 lineto
492.047 35.9219 lineto
486.543 24.1133 lineto
488.371 24.1133 lineto
489.555 26.8008 lineto
494.52301 26.8008 lineto
493.879 28.2852 lineto
490.219 28.2852 lineto
492.047 32.418 lineto
493.879 28.2852 lineto
494.52301 26.8008 lineto
 closepath fill
newpath 446.98001 24.1133 moveto
448.80899 24.1133 lineto
443.305 35.9219 lineto
437.797 24.1133 lineto
439.629 24.1133 lineto
440.805 26.8008 lineto
445.77701 26.8008 lineto
445.129 28.2852 lineto
441.47299 28.2852 lineto
443.305 32.418 lineto
445.129 28.2852 lineto
445.77701 26.8008 lineto
 closepath fill
newpath 519.953 35.5039 moveto
518.22302 35.5039 lineto
515.28497 30.8008 lineto
512.297 35.5039 lineto
510.469 35.5039 lineto
514.43 29.0625 lineto
514.43 24.1133 lineto
516.09003 24.1133 lineto
516.09003 29.2539 lineto
 closepath fill
newpath 418.76599 35.5039 moveto
417.10901 35.5039 lineto
417.10901 24.1133 lineto
418.76599 24.1133 lineto
 closepath fill
newpath 468.18 35.5039 moveto
466.508 35.5039 lineto
466.508 24.1133 lineto
468.18 24.1133 lineto
 closepath fill
newpath 508.77301 24.1133 moveto
505.344 29.1406 lineto
506.94101 29.5586 507.801 30.668 507.801 32.2656 curveto
507.801 33.4258 507.285 34.4375 506.35501 34.9727 curveto
505.613 35.4297 505.004 35.5039 502.867 35.5039 curveto
500.887 35.5039 lineto
500.887 24.1133 lineto
502.543 24.1133 lineto
502.543 28.9883 lineto
502.543 30.4961 lineto
502.543 34.0195 lineto
503.93799 34.0195 lineto
504.719 34.0195 505.19101 33.9023 505.51599 33.6172 curveto
505.879 33.293 506.10501 32.7422 506.10501 32.1875 curveto
506.10501 31.5039 505.746 30.9336 505.117 30.668 curveto
504.793 30.5312 504.35199 30.4961 503.324 30.4961 curveto
502.543 30.4961 lineto
502.543 28.9883 lineto
503.418 28.9883 lineto
506.676 24.1133 lineto
 closepath fill
newpath 483.26599 35.5039 moveto
481.60901 35.5039 lineto
481.60901 27.75 lineto
473.074 35.7305 lineto
473.074 24.1133 lineto
474.73401 24.1133 lineto
474.73401 31.8828 lineto
483.26599 23.8828 lineto
 closepath fill
newpath 457.453 29.9023 moveto
457.453 28.418 lineto
460.48401 28.418 lineto
460.16 26.5117 458.828 25.332 456.80899 25.332 curveto
454.371 25.332 452.73001 27.3125 452.73001 29.96089 curveto
452.73001 32.3789 454.426 34.2656 456.844 34.2656 curveto
458.31201 34.2656 459.379 33.6523 460.465 32.2461 curveto
461.81601 33.293 lineto
460.543 35.0078 458.887 35.8477 456.80899 35.8477 curveto
455.47699 35.8477 454.34799 35.4297 453.285 34.64839 curveto
451.742 33.5039 450.906 31.8086 450.906 29.8242 curveto
450.906 28.1523 451.531 26.5898 452.676 25.4453 curveto
453.797 24.3047 455.039 23.75 456.80899 23.75 curveto
458.504 23.75 459.781 24.3242 460.824 25.4648 curveto
461.836 26.5352 462.336 27.8086 462.504 29.9023 curveto
 closepath fill
newpath 432.844 36.0352 moveto
429.18799 27.582 lineto
425.492 36.0352 lineto
422.613 24.1133 lineto
424.445 24.1133 lineto
426.02301 31.1406 lineto
429.18799 23.6367 lineto
432.35199 31.1406 lineto
433.91 24.1133 lineto
435.742 24.1133 lineto
 closepath fill
 0 1.82886 dtransform truncate idtransform setlinewidth pop [] 0 setdash
 0 setlinecap 0 setlinejoin 10 setmiterlimit
newpath 8.67188 31.5898 moveto
21.3398 31.5898 lineto stroke
newpath 15.0078 20.6172 moveto
8.67188 31.5898 lineto stroke
newpath 21.3438 31.5898 moveto
15.0078 20.6172 lineto stroke
 1 1 1 setrgbcolor 0 2.55962 dtransform truncate idtransform setlinewidth pop
newpath 15.7383 31.5898 moveto
21.3438 31.5898 lineto
25.3789 31.5898 28.6562 28.3125 28.6562 24.27339 curveto stroke
newpath 11.4727 26.7383 moveto
8.67188 31.5898 lineto
6.65625 35.08589 7.85156 39.5625 11.3477 41.5781 curveto stroke
newpath 17.8086 25.4688 moveto
15.0078 20.6172 lineto
12.9844 17.1211 8.51172 15.9219 5.01172 17.9375 curveto stroke
 0.0941 0.0941 0.0941 setrgbcolor 0 1.82886
 dtransform truncate idtransform setlinewidth pop
newpath 15.0078 31.5898 moveto
21.3438 31.5898 lineto
25.3789 31.5898 28.6562 28.3125 28.6562 24.27339 curveto
28.6562 20.2383 25.3789 16.96089 21.3438 16.96089 curveto
8.67188 16.96089 lineto stroke
newpath 11.8398 26.10161 moveto
8.67188 31.5898 lineto
6.65234 35.08589 7.85156 39.5586 11.3477 41.5781 curveto
14.8438 43.5977 19.3203 42.39839 21.3438 38.9023 curveto
27.6719 27.9297 lineto stroke
newpath 18.1758 26.10161 moveto
15.0078 20.6172 lineto
12.9844 17.1211 8.51172 15.9219 5.01172 17.9375 curveto
1.51563 19.957 0.32031 24.4336 2.33984 27.9297 curveto
8.67188 38.9023 lineto stroke
newpath 36.4961 40.0352 moveto
36.47661 40.0352 lineto
35.78911 36.1289 lineto
35.0273 36.1289 lineto
36.2344 42.293 lineto
38.2656 37.6367 lineto
40.2969 42.293 lineto
41.5039 36.1289 lineto
40.7461 36.1289 lineto
40.0508 40.0352 lineto
40.0352 40.0352 lineto
38.2656 36.0039 lineto
 closepath fill
newpath 45.7227 36.1289 moveto
45.0195 36.1289 lineto
45.0195 36.7031 lineto
45.0039 36.7031 lineto
44.7188 36.2852 44.2813 36.0039 43.7539 36.0039 curveto
43.8633 36.6328 lineto
44.6328 36.6328 45.0586 37.2422 45.0586 37.9648 curveto
45.0586 37.9648 lineto
45.0586 38.6797 44.625 39.2812 43.8633 39.2812 curveto
43.1328 39.2812 42.7031 38.64839 42.7031 37.9648 curveto
42.7031 37.27339 43.1172 36.6328 43.8633 36.6328 curveto
43.7539 36.0039 lineto
42.6328 36.0039 42 36.9375 42 37.9922 curveto
42 38.9922 42.66411 39.9102 43.7305 39.9102 curveto
44.2695 39.9102 44.71089 39.625 45.0039 39.1875 curveto
45.0195 39.1875 lineto
45.0195 39.8008 lineto
45.7227 39.8008 lineto
 closepath fill
newpath 47.6367 36.1289 moveto
46.9297 36.1289 lineto
46.9297 39.1406 lineto
46.5469 39.1406 lineto
46.5469 39.7969 lineto
46.9297 39.7969 lineto
46.9297 41.1992 lineto
47.6367 41.1992 lineto
47.6367 39.7969 lineto
48.3281 39.7969 lineto
48.3281 39.1406 lineto
47.6367 39.1406 lineto
 closepath fill
newpath 49.6055 42.9375 moveto
49.6055 39.3047 lineto
49.6211 39.3047 lineto
49.8398 39.6953 50.2773 39.9102 50.7227 39.9102 curveto
51.7617 39.9102 52.02339 39.21089 52.02339 38.3203 curveto
52.02339 36.1289 lineto
51.3203 36.1289 lineto
51.3203 38.2344 lineto
51.3203 38.8594 51.2344 39.2812 50.5117 39.2812 curveto
49.6055 39.2812 49.6055 38.4844 49.6055 37.8164 curveto
49.6055 36.1289 lineto
48.89839 36.1289 lineto
48.89839 42.9375 lineto
 closepath fill
newpath 53.6172 37.8477 moveto
53.6563 38.3828 lineto
55.7148 38.3828 lineto
55.625 38.9297 55.2617 39.2969 54.6992 39.2969 curveto
54.1523 39.2969 53.7422 38.9062 53.6563 38.3828 curveto
53.6172 37.8477 lineto
53.625 37.2188 54.0508 36.6289 54.7227 36.6289 curveto
55.2617 36.6289 55.5547 36.9062 55.8203 37.3438 curveto
56.418 37.0078 lineto
56.0742 36.3711 55.4297 36.0039 54.7148 36.0039 curveto
53.5938 36.0039 52.91411 36.85161 52.91411 37.9336 curveto
52.91411 39.0625 53.5156 39.9102 54.6992 39.9102 curveto
55.8711 39.9102 56.418 39.0469 56.418 37.957 curveto
56.418 37.8477 lineto
 closepath fill
newpath 57.89839 39.33589 moveto
57.91411 39.33589 lineto
58.1172 39.6562 58.4844 39.9102 58.8867 39.9102 curveto
59.3633 39.9102 59.71089 39.668 59.9414 39.2578 curveto
60.1719 39.64839 60.6133 39.9102 61.0742 39.9102 curveto
62.03911 39.9102 62.28911 39.1562 62.28911 38.3281 curveto
62.28911 36.1289 lineto
61.582 36.1289 lineto
61.582 38.21089 lineto
61.582 38.6797 61.5195 39.2812 60.9023 39.2812 curveto
60.1523 39.2812 60.0938 38.5 60.0938 37.9336 curveto
60.0938 36.1289 lineto
59.3906 36.1289 lineto
59.3906 38.0742 lineto
59.3906 38.5547 59.3633 39.2812 58.7148 39.2812 curveto
57.96089 39.2812 57.89839 38.5078 57.89839 37.9336 curveto
57.89839 36.1289 lineto
57.1953 36.1289 lineto
57.1953 39.8008 lineto
57.89839 39.8008 lineto
 closepath fill
newpath 66.8672 36.1289 moveto
66.1602 36.1289 lineto
66.1602 36.7031 lineto
66.1445 36.7031 lineto
65.8633 36.2852 65.4258 36.0039 64.9023 36.0039 curveto
65.0117 36.6328 lineto
65.7773 36.6328 66.1992 37.2422 66.1992 37.9648 curveto
66.1992 37.9648 lineto
66.1992 38.6797 65.7695 39.2812 65.0117 39.2812 curveto
64.2812 39.2812 63.85161 38.64839 63.85161 37.9648 curveto
63.85161 37.27339 64.2656 36.6328 65.0117 36.6328 curveto
64.9023 36.0039 lineto
63.7773 36.0039 63.1445 36.9375 63.1445 37.9922 curveto
63.1445 38.9922 63.8125 39.9102 64.8789 39.9102 curveto
65.418 39.9102 65.8555 39.625 66.1445 39.1875 curveto
66.1602 39.1875 lineto
66.1602 39.8008 lineto
66.8672 39.8008 lineto
 closepath fill
newpath 68.78911 36.1289 moveto
68.08589 36.1289 lineto
68.08589 39.1406 lineto
67.6992 39.1406 lineto
67.6992 39.7969 lineto
68.08589 39.7969 lineto
68.08589 41.1992 lineto
68.78911 41.1992 lineto
68.78911 39.7969 lineto
69.4805 39.7969 lineto
69.4805 39.1406 lineto
68.78911 39.1406 lineto
 closepath fill
newpath 70.918 36.1289 moveto
70.2148 36.1289 lineto
70.2148 39.7969 lineto
70.918 39.7969 lineto
 closepath fill
newpath 71.0586 41.4805 moveto
71.0586 41.21089 70.832 40.9961 70.5664 40.9961 curveto
70.3008 40.9961 70.082 41.21089 70.082 41.4805 curveto
70.082 41.7539 70.3008 41.9727 70.5664 41.9727 curveto
70.832 41.9727 71.0586 41.7539 71.0586 41.4805 curveto
 closepath fill
newpath 73.7188 38.96089 moveto
73.6328 39.1406 73.4531 39.2812 73.25 39.2812 curveto
73.0547 39.2812 72.8672 39.125 72.8672 38.9219 curveto
72.8672 38.60161 73.28911 38.46089 73.7188 38.2656 curveto
74.1523 38.0664 74.5664 37.8008 74.5664 37.2188 curveto
74.5664 36.5195 73.9844 36.0039 73.3047 36.0039 curveto
72.77339 36.0039 72.2305 36.3086 72.0352 36.8281 curveto
72.6406 37.10161 lineto
72.78911 36.8281 72.9688 36.6328 73.3047 36.6328 curveto
73.60161 36.6328 73.8594 36.83589 73.8594 37.14839 curveto
73.8594 37.3438 73.7656 37.4375 73.60161 37.5508 curveto
72.91411 37.918 lineto
72.5078 38.1406 72.207 38.3438 72.207 38.8438 curveto
72.207 39.4375 72.6953 39.9102 73.28911 39.9102 curveto
73.7344 39.9102 74.0977 39.668 74.293 39.2656 curveto
 closepath fill
newpath 78.14839 38.7578 moveto
77.8672 39.0781 77.52339 39.25 77.10161 39.25 curveto
76.4102 39.25 75.8789 38.6406 75.8789 37.9648 curveto
75.8789 37.21089 76.4023 36.66411 77.1445 36.66411 curveto
77.5547 36.66411 77.8828 36.85161 78.14839 37.14839 curveto
78.14839 36.2461 lineto
77.8281 36.0742 77.5078 36.0039 77.1406 36.0039 curveto
76.0586 36.0039 75.168 36.83589 75.168 37.9336 curveto
75.168 39.0703 76.0508 39.9102 77.1797 39.9102 curveto
77.5078 39.9102 77.8672 39.832 78.14839 39.668 curveto
 closepath fill
newpath 79.8125 42.9375 moveto
79.8125 39.3047 lineto
79.8281 39.3047 lineto
80.0469 39.6953 80.4883 39.9102 80.9336 39.9102 curveto
81.9688 39.9102 82.2344 39.21089 82.2344 38.3203 curveto
82.2344 36.1289 lineto
81.52739 36.1289 lineto
81.52739 38.2344 lineto
81.52739 38.8594 81.4414 39.2812 80.7227 39.2812 curveto
79.8125 39.2812 79.8125 38.4844 79.8125 37.8164 curveto
79.8125 36.1289 lineto
79.1094 36.1289 lineto
79.1094 42.9375 lineto
 closepath fill
newpath 83.8281 37.8477 moveto
83.8672 38.3828 lineto
85.918 38.3828 lineto
85.832 38.9297 85.4727 39.2969 84.9102 39.2969 curveto
84.3594 39.2969 83.9531 38.9062 83.8672 38.3828 curveto
83.8281 37.8477 lineto
83.83589 37.2188 84.2578 36.6289 84.9336 36.6289 curveto
85.4727 36.6289 85.7617 36.9062 86.02739 37.3438 curveto
86.6289 37.0078 lineto
86.2773 36.3711 85.6367 36.0039 84.9219 36.0039 curveto
83.8047 36.0039 83.1211 36.85161 83.1211 37.9336 curveto
83.1211 39.0625 83.72661 39.9102 84.9102 39.9102 curveto
86.0742 39.9102 86.6289 39.0469 86.6289 37.957 curveto
86.6289 37.8477 lineto
 closepath fill
newpath 88.89839 38.96089 moveto
88.8125 39.1406 88.6328 39.2812 88.4297 39.2812 curveto
88.2344 39.2812 88.0469 39.125 88.0469 38.9219 curveto
88.0469 38.60161 88.4688 38.46089 88.89839 38.2656 curveto
89.3281 38.0664 89.7461 37.8008 89.7461 37.2188 curveto
89.7461 36.5195 89.16411 36.0039 88.4844 36.0039 curveto
87.9492 36.0039 87.4102 36.3086 87.2148 36.8281 curveto
87.8164 37.10161 lineto
87.9688 36.8281 88.14839 36.6328 88.4844 36.6328 curveto
88.7812 36.6328 89.03911 36.83589 89.03911 37.14839 curveto
89.03911 37.3438 88.9453 37.4375 88.7812 37.5508 curveto
88.0938 37.918 lineto
87.6836 38.1406 87.3867 38.3438 87.3867 38.8438 curveto
87.3867 39.4375 87.8711 39.9102 88.4688 39.9102 curveto
88.91411 39.9102 89.27339 39.668 89.4727 39.2656 curveto
 closepath fill
newpath 36.2188 31.5547 moveto
36.2188 29.8906 lineto
38.27339 29.8906 lineto
38.27339 29.2188 lineto
36.2188 29.2188 lineto
36.2188 26.3203 lineto
35.4844 26.3203 lineto
35.4844 32.2305 lineto
38.3438 32.2305 lineto
38.3438 31.5547 lineto
 closepath fill
newpath 42.91411 28.1445 moveto
42.91411 27.03911 42.0547 26.1914 40.957 26.1914 curveto
40.957 26.8672 lineto
41.6523 26.8672 42.21089 27.4531 42.21089 28.1445 curveto
42.21089 28.8398 41.6523 29.4219 40.957 29.4219 curveto
40.2578 29.4219 39.6992 28.8398 39.6992 28.1445 curveto
39.6992 28.1445 lineto
39.6992 27.4531 40.2578 26.8672 40.957 26.8672 curveto
40.957 26.1914 lineto
39.8555 26.1914 38.9961 27.03911 38.9961 28.1445 curveto
38.9961 29.2461 39.8555 30.0977 40.957 30.0977 curveto
42.0547 30.0977 42.91411 29.2461 42.91411 28.1445 curveto
 closepath fill
newpath 44.5 29.3906 moveto
44.52339 29.3906 lineto
44.6992 29.8203 45.0586 30.0977 45.5273 30.0977 curveto
45.7305 30.0977 45.9336 30.02339 46.1094 29.918 curveto
45.7852 29.2695 lineto
45.6602 29.3828 45.5195 29.4219 45.3555 29.4219 curveto
44.5898 29.4219 44.5 28.7148 44.5 28.1211 curveto
44.5 26.3203 lineto
43.793 26.3203 lineto
43.793 29.9844 lineto
44.5 29.9844 lineto
 closepath fill
newpath 48.16411 29.1445 moveto
48.0781 29.3281 47.8945 29.4688 47.6875 29.4688 curveto
47.4922 29.4688 47.3047 29.3125 47.3047 29.1055 curveto
47.3047 28.7852 47.72661 28.6445 48.16411 28.4492 curveto
48.5938 28.2539 49.0078 27.9883 49.0078 27.4062 curveto
49.0078 26.71089 48.4297 26.1875 47.7422 26.1875 curveto
47.21089 26.1875 46.6719 26.5 46.47661 27.0156 curveto
47.0781 27.28911 lineto
47.22661 27.0156 47.4062 26.8203 47.7422 26.8203 curveto
48.0469 26.8203 48.3047 27.02339 48.3047 27.33589 curveto
48.3047 27.5352 48.21089 27.6289 48.0469 27.7344 curveto
47.35161 28.1055 lineto
46.9453 28.3242 46.64839 28.5273 46.64839 29.0312 curveto
46.64839 29.625 47.1328 30.0977 47.72661 30.0977 curveto
48.1797 30.0977 48.53911 29.85161 48.7344 29.4531 curveto
 closepath fill
newpath 52.58589 28.9414 moveto
52.3008 29.2656 51.957 29.4375 51.5312 29.4375 curveto
50.8398 29.4375 50.3086 28.8242 50.3086 28.1523 curveto
50.3086 27.39839 50.832 26.85161 51.5781 26.85161 curveto
51.9844 26.85161 52.3164 27.03911 52.58589 27.33589 curveto
52.58589 26.4375 lineto
52.2617 26.2617 51.9375 26.1914 51.5703 26.1914 curveto
50.4883 26.1914 49.6055 27.02339 49.6055 28.1211 curveto
49.6055 29.2539 50.4805 30.0977 51.6094 30.0977 curveto
51.9375 30.0977 52.3008 30.0156 52.58589 29.85161 curveto
 closepath fill
newpath 54.2461 33.1211 moveto
54.2461 29.4922 lineto
54.2617 29.4922 lineto
54.4805 29.8867 54.918 30.0977 55.3633 30.0977 curveto
56.4023 30.0977 56.668 29.39839 56.668 28.5039 curveto
56.668 26.3203 lineto
55.9648 26.3203 lineto
55.9648 28.418 lineto
55.9648 29.043 55.8789 29.4688 55.1523 29.4688 curveto
54.2461 29.4688 54.2461 28.668 54.2461 28.0039 curveto
54.2461 26.3203 lineto
53.53911 26.3203 lineto
53.53911 33.1211 lineto
 closepath fill
newpath 58.5078 29.9844 moveto
58.5078 27.957 lineto
58.5078 27.3672 58.6602 26.85161 59.3555 26.85161 curveto
60.0547 26.85161 60.207 27.3672 60.207 27.957 curveto
60.207 29.9844 lineto
60.9102 29.9844 lineto
60.9102 27.8789 lineto
60.9102 26.875 60.4414 26.1875 59.3555 26.1875 curveto
58.27339 26.1875 57.8047 26.875 57.8047 27.8789 curveto
57.8047 29.9844 lineto
 closepath fill
newpath 62.75 29.4922 moveto
62.7656 29.4922 lineto
62.9883 29.8867 63.4297 30.0977 63.875 30.0977 curveto
64.9102 30.0977 65.1758 29.39839 65.1758 28.5039 curveto
65.1758 26.3203 lineto
64.4688 26.3203 lineto
64.4688 28.418 lineto
64.4688 29.043 64.3828 29.4688 63.66411 29.4688 curveto
62.75 29.4688 62.75 28.668 62.75 28.0039 curveto
62.75 26.3203 lineto
62.0469 26.3203 lineto
62.0469 29.9844 lineto
62.75 29.9844 lineto
 closepath fill
newpath 69.7773 26.3867 moveto
69.7773 25.125 69.41411 24.2148 67.9922 24.2148 curveto
66.9688 24.2148 66.2344 24.8438 66.21489 25.8789 curveto
66.9219 25.8789 lineto
66.9219 25.2188 67.375 24.8438 68.02339 24.8438 curveto
68.8906 24.8438 69.0703 25.4375 69.0703 26.1914 curveto
69.0703 26.8906 lineto
69.0547 26.8906 lineto
68.77339 26.47661 68.3281 26.1914 67.8125 26.1914 curveto
67.9219 26.8203 lineto
68.6875 26.8203 69.1094 27.4297 69.1094 28.1523 curveto
69.1094 28.1523 lineto
69.1094 28.8633 68.6797 29.4688 67.9219 29.4688 curveto
67.1914 29.4688 66.7578 28.832 66.7578 28.1523 curveto
66.7578 27.46089 67.1719 26.8203 67.9219 26.8203 curveto
67.8125 26.1914 lineto
66.6797 26.1914 66.0508 27.125 66.0508 28.1758 curveto
66.0508 29.1758 66.7188 30.0977 67.7812 30.0977 curveto
68.3281 30.0977 68.7656 29.8125 69.0547 29.3594 curveto
69.0703 29.3594 lineto
69.0703 29.9844 lineto
69.7773 29.9844 lineto
 closepath fill
newpath 72.3633 29.1445 moveto
72.2773 29.3281 72.0977 29.4688 71.8945 29.4688 curveto
71.6992 29.4688 71.5117 29.3125 71.5117 29.1055 curveto
71.5117 28.7852 71.9336 28.6445 72.3633 28.4492 curveto
72.7969 28.2539 73.21089 27.9883 73.21089 27.4062 curveto
73.21089 26.71089 72.6328 26.1875 71.9492 26.1875 curveto
71.418 26.1875 70.875 26.5 70.6758 27.0156 curveto
71.2852 27.28911 lineto
71.4336 27.0156 71.6133 26.8203 71.9492 26.8203 curveto
72.2461 26.8203 72.5078 27.02339 72.5078 27.33589 curveto
72.5078 27.5352 72.4102 27.6289 72.2461 27.7344 curveto
71.5586 28.1055 lineto
71.1523 28.3242 70.8477 28.5273 70.8477 29.0312 curveto
70.8477 29.625 71.3398 30.0977 71.9336 30.0977 curveto
72.3828 30.0977 72.7422 29.85161 72.9375 29.4531 curveto
 closepath fill
newpath 74.957 26.3203 moveto
74.2539 26.3203 lineto
74.2539 29.9844 lineto
74.957 29.9844 lineto
 closepath fill
newpath 75.0898 31.66411 moveto
75.0898 31.39839 74.8711 31.1875 74.6055 31.1875 curveto
74.3398 31.1875 74.1211 31.39839 74.1211 31.66411 curveto
74.1211 31.9375 74.3398 32.1562 74.6055 32.1562 curveto
74.8711 32.1562 75.0898 31.9375 75.0898 31.66411 curveto
 closepath fill
newpath 76.9883 29.4922 moveto
77.0078 29.4922 lineto
77.22661 29.8867 77.66411 30.0977 78.1094 30.0977 curveto
79.14839 30.0977 79.41411 29.39839 79.41411 28.5039 curveto
79.41411 26.3203 lineto
78.707 26.3203 lineto
78.707 28.418 lineto
78.707 29.043 78.6211 29.4688 77.89839 29.4688 curveto
76.9883 29.4688 76.9883 28.668 76.9883 28.0039 curveto
76.9883 26.3203 lineto
76.2852 26.3203 lineto
76.2852 29.9844 lineto
76.9883 29.9844 lineto
 closepath fill
newpath 82.0547 29.1445 moveto
81.9688 29.3281 81.78911 29.4688 81.582 29.4688 curveto
81.3867 29.4688 81.1992 29.3125 81.1992 29.1055 curveto
81.1992 28.7852 81.6211 28.6445 82.0547 28.4492 curveto
82.4844 28.2539 82.9023 27.9883 82.9023 27.4062 curveto
82.9023 26.71089 82.3203 26.1875 81.6367 26.1875 curveto
81.1055 26.1875 80.5664 26.5 80.3711 27.0156 curveto
80.9727 27.28911 lineto
81.1211 27.0156 81.3008 26.8203 81.6367 26.8203 curveto
81.9336 26.8203 82.1953 27.02339 82.1953 27.33589 curveto
82.1953 27.5352 82.10161 27.6289 81.9336 27.7344 curveto
81.2461 28.1055 lineto
80.8398 28.3242 80.543 28.5273 80.543 29.0312 curveto
80.543 29.625 81.0273 30.0977 81.6211 30.0977 curveto
82.0703 30.0977 82.4297 29.85161 82.6289 29.4531 curveto
 closepath fill
newpath 84.5938 26.3203 moveto
83.8906 26.3203 lineto
83.8906 29.3281 lineto
83.5078 29.3281 lineto
83.5078 29.9844 lineto
83.8906 29.9844 lineto
83.8906 31.3906 lineto
84.5938 31.3906 lineto
84.5938 29.9844 lineto
85.2852 29.9844 lineto
85.2852 29.3281 lineto
84.5938 29.3281 lineto
 closepath fill
newpath 86.7305 26.3203 moveto
86.0195 26.3203 lineto
86.0195 29.9844 lineto
86.7305 29.9844 lineto
 closepath fill
newpath 86.8633 31.66411 moveto
86.8633 31.39839 86.6406 31.1875 86.3789 31.1875 curveto
86.1055 31.1875 85.8867 31.39839 85.8867 31.66411 curveto
85.8867 31.9375 86.1055 32.1562 86.3789 32.1562 curveto
86.6406 32.1562 86.8633 31.9375 86.8633 31.66411 curveto
 closepath fill
newpath 88.8594 26.3203 moveto
88.1562 26.3203 lineto
88.1562 29.3281 lineto
87.7695 29.3281 lineto
87.7695 29.9844 lineto
88.1562 29.9844 lineto
88.1562 31.3906 lineto
88.8594 31.3906 lineto
88.8594 29.9844 lineto
89.5469 29.9844 lineto
89.5469 29.3281 lineto
88.8594 29.3281 lineto
 closepath fill
newpath 90.8047 29.9844 moveto
90.8047 27.957 lineto
90.8047 27.3672 90.9531 26.85161 91.6523 26.85161 curveto
92.3477 26.85161 92.4961 27.3672 92.4961 27.957 curveto
92.4961 29.9844 lineto
93.2031 29.9844 lineto
93.2031 27.8789 lineto
93.2031 26.875 92.7344 26.1875 91.6523 26.1875 curveto
90.5703 26.1875 90.0977 26.875 90.0977 27.8789 curveto
90.0977 29.9844 lineto
 closepath fill
newpath 95.14839 26.3203 moveto
94.4453 26.3203 lineto
94.4453 29.3281 lineto
94.0586 29.3281 lineto
94.0586 29.9844 lineto
94.4453 29.9844 lineto
94.4453 31.3906 lineto
95.14839 31.3906 lineto
95.14839 29.9844 lineto
95.8398 29.9844 lineto
95.8398 29.3281 lineto
95.14839 29.3281 lineto
 closepath fill
newpath 41.2695 19.46089 moveto
41.2695 17.7031 39.8789 16.3789 38.1719 16.3789 curveto
38.1719 17.0664 lineto
39.4492 17.0664 40.5352 18.1094 40.5352 19.46089 curveto
40.5352 19.46089 lineto
40.5352 20.7617 39.5586 21.85161 38.1719 21.85161 curveto
36.7852 21.85161 35.8125 20.7617 35.8125 19.46089 curveto
35.8125 18.1094 36.8945 17.0664 38.1719 17.0664 curveto
38.1719 16.3789 lineto
36.46089 16.3789 35.0742 17.7031 35.0742 19.46089 curveto
35.0742 21.1523 36.47661 22.543 38.1719 22.543 curveto
39.8633 22.543 41.2695 21.1523 41.2695 19.46089 curveto
 closepath fill
newpath 42.0469 23.3125 moveto
42.75 23.3125 lineto
42.75 19.5625 lineto
42.7656 19.5625 lineto
43.0547 20 43.4961 20.2812 44.0469 20.2812 curveto
45.1055 20.2812 45.7695 19.3672 45.7695 18.3633 curveto
45.7695 17.3125 45.1445 16.3789 44.0117 16.3789 curveto
43.8711 17.0078 lineto
44.6406 17.0078 45.0664 17.6172 45.0664 18.33589 curveto
45.0664 18.33589 lineto
45.0664 19.0547 44.6328 19.6562 43.8711 19.6562 curveto
43.1406 19.6562 42.71089 19.02339 42.71089 18.33589 curveto
42.71089 17.64839 43.1289 17.0078 43.8711 17.0078 curveto
44.0117 16.3789 lineto
43.4961 16.3789 43.0469 16.6602 42.7656 17.0742 curveto
42.75 17.0742 lineto
42.75 16.5039 lineto
42.0469 16.5039 lineto
 closepath fill
newpath 47.0703 18.2188 moveto
47.1094 18.7539 lineto
49.16411 18.7539 lineto
49.0781 19.3047 48.7188 19.6719 48.1563 19.6719 curveto
47.60161 19.6719 47.1953 19.2812 47.1094 18.7539 curveto
47.0703 18.2188 lineto
47.0781 17.5938 47.5 17.0039 48.1797 17.0039 curveto
48.7188 17.0039 49.0078 17.2812 49.2773 17.7188 curveto
49.8711 17.3828 lineto
49.5273 16.7461 48.8828 16.3789 48.1719 16.3789 curveto
47.0469 16.3789 46.3672 17.22661 46.3672 18.3047 curveto
46.3672 19.4375 46.9688 20.2812 48.1563 20.2812 curveto
49.3242 20.2812 49.8711 19.4219 49.8711 18.332 curveto
49.8711 18.2188 lineto
 closepath fill
newpath 51.41411 19.5781 moveto
51.4375 19.5781 lineto
51.6094 20.0078 51.9727 20.2852 52.4414 20.2852 curveto
52.64839 20.2852 52.85161 20.21089 53.02339 20.10161 curveto
52.7031 19.46089 lineto
52.5781 19.5703 52.4336 19.6094 52.2656 19.6094 curveto
51.5078 19.6094 51.41411 18.9023 51.41411 18.3047 curveto
51.41411 16.5039 lineto
50.707 16.5039 lineto
50.707 20.1719 lineto
51.41411 20.1719 lineto
 closepath fill
newpath 55.1758 17.83589 moveto
56.2617 20.3789 lineto
57.33589 17.83589 lineto
58.39839 20.1719 lineto
59.1992 20.1719 lineto
57.33589 16.3789 lineto
56.2617 18.83589 lineto
55.1758 16.3789 lineto
53.3125 20.1719 lineto
54.1133 20.1719 lineto
 closepath fill
newpath 63.3438 18.332 moveto
63.3438 17.22661 62.47661 16.3789 61.3789 16.3789 curveto
60.2852 16.3789 59.418 17.22661 59.418 18.332 curveto
59.418 19.4375 60.2852 20.2812 61.3789 20.2812 curveto
61.3789 19.6094 lineto
60.6836 19.6094 60.1289 19.0312 60.1289 18.332 curveto
60.1289 18.332 lineto
60.1289 17.6406 60.6836 17.0508 61.3789 17.0508 curveto
62.0781 17.0508 62.6328 17.6406 62.6328 18.332 curveto
62.6328 19.0312 62.0781 19.6094 61.3789 19.6094 curveto
61.3789 20.2812 lineto
62.47661 20.2812 63.3438 19.4375 63.3438 18.332 curveto
 closepath fill
newpath 64.21089 16.5039 moveto
64.918 16.5039 lineto
64.918 23.3086 lineto
64.21089 23.3086 lineto
 closepath fill
newpath 67.9375 22.5938 moveto
67.793 22.6602 67.6133 22.7461 67.46489 22.7461 curveto
66.96089 22.7461 66.96089 22.1094 66.96089 21.7461 curveto
66.96089 20.1719 lineto
67.9375 20.1719 lineto
67.9375 19.5156 lineto
66.96089 19.5156 lineto
66.96089 16.5039 lineto
66.2539 16.5039 lineto
66.2539 19.5156 lineto
65.9336 19.5156 lineto
65.9336 20.1719 lineto
66.2539 20.1719 lineto
66.2539 21.9648 lineto
66.2539 22.7617 66.5312 23.4062 67.4414 23.4062 curveto
67.6133 23.4062 67.7773 23.3711 67.9375 23.3086 curveto
 closepath fill
newpath 71.9102 16.5039 moveto
71.2031 16.5039 lineto
71.2031 17.0742 lineto
71.1914 17.0742 lineto
70.9062 16.6602 70.4648 16.3789 69.9414 16.3789 curveto
70.0508 17.0078 lineto
70.8203 17.0078 71.2461 17.6172 71.2461 18.33589 curveto
71.2461 18.33589 lineto
71.2461 19.0547 70.8086 19.6562 70.0508 19.6562 curveto
69.3203 19.6562 68.8906 19.02339 68.8906 18.33589 curveto
68.8906 17.64839 69.3047 17.0078 70.0508 17.0078 curveto
69.9414 16.3789 lineto
68.8203 16.3789 68.1875 17.3125 68.1875 18.3633 curveto
68.1875 19.3672 68.85161 20.2812 69.918 20.2812 curveto
70.457 20.2812 70.89839 20 71.1914 19.5625 curveto
71.2031 19.5625 lineto
71.2031 20.1719 lineto
71.9102 20.1719 lineto
 closepath fill
newpath 75.7227 19.1328 moveto
75.4375 19.4531 75.0898 19.625 74.668 19.625 curveto
73.97661 19.625 73.4453 19.0156 73.4453 18.33589 curveto
73.4453 17.58589 73.9688 17.0352 74.7148 17.0352 curveto
75.1211 17.0352 75.4531 17.22661 75.7227 17.52339 curveto
75.7227 16.6211 lineto
75.39839 16.4492 75.0781 16.3789 74.707 16.3789 curveto
73.625 16.3789 72.7422 17.207 72.7422 18.3047 curveto
72.7422 19.4453 73.6172 20.2812 74.75 20.2812 curveto
75.0781 20.2812 75.4375 20.2031 75.7227 20.03911 curveto
 closepath fill
newpath 77.3828 23.3086 moveto
77.3828 19.6797 lineto
77.39839 19.6797 lineto
77.6172 20.0703 78.0547 20.2852 78.5039 20.2852 curveto
79.53911 20.2852 79.8047 19.58589 79.8047 18.6953 curveto
79.8047 16.5039 lineto
79.10161 16.5039 lineto
79.10161 18.6055 lineto
79.10161 19.2344 79.0156 19.6562 78.293 19.6562 curveto
77.3828 19.6562 77.3828 18.8555 77.3828 18.1875 curveto
77.3828 16.5039 lineto
76.6758 16.5039 lineto
76.6758 23.3086 lineto
 closepath fill
 0 0 0 setrgbcolor
newpath 183.574 21.9219 moveto
183.574 21.625 183.691 21.3867 183.922 21.1953 curveto
184.152 21.0078 184.543 20.91411 185.098 20.91411 curveto
185.391 20.91411 185.633 20.9453 185.824 21.0039 curveto
186.02 21.0664 186.172 21.1523 186.281 21.2617 curveto
186.402 21.3672 186.484 21.5195 186.555 21.707 curveto
186.617 21.89839 186.648 22.1875 186.648 22.5742 curveto
186.648 25.5 lineto
185.836 25.5 lineto
185.836 25.043 lineto
185.586 24.668 lineto
185.727 24.5039 185.797 24.2539 185.797 23.91411 curveto
185.797 23.5898 185.727 23.3477 185.578 23.1836 curveto
185.434 23.0195 185.258 22.9375 185.043 22.9375 curveto
184.848 22.9375 184.684 23.0156 184.551 23.1758 curveto
184.414 23.3398 184.348 23.5898 184.348 23.9375 curveto
184.348 24.2656 184.414 24.5117 184.551 24.6719 curveto
184.551 24.6719 lineto
184.684 24.832 184.855 24.91411 185.062 24.91411 curveto
185.273 24.91411 185.449 24.832 185.586 24.668 curveto
185.836 25.043 lineto
185.574 25.3945 185.242 25.5742 184.84 25.5742 curveto
184.449 25.5742 184.121 25.4297 183.859 25.1406 curveto
183.598 24.85161 183.465 24.4336 183.465 23.8867 curveto
183.465 23.4531 183.566 23.08589 183.766 22.7969 curveto
184.02 22.4219 184.367 22.2344 184.805 22.2344 curveto
185.199 22.2344 185.523 22.41411 185.781 22.7695 curveto
185.781 22.293 lineto
185.781 22.0977 185.773 21.9648 185.742 21.8906 curveto
185.703 21.793 185.645 21.7188 185.57 21.6758 curveto
185.457 21.6055 185.289 21.5742 185.062 21.5742 curveto
184.887 21.5742 184.758 21.6055 184.676 21.66411 curveto
184.617 21.707 184.578 21.7852 184.562 21.9023 curveto
183.578 22.02339 lineto
183.574 21.9805 183.574 21.9453 183.574 21.9219 curveto
 closepath fill
newpath 189.18 22.9219 moveto
189.086 22.8477 188.973 22.8125 188.84 22.8125 curveto
188.641 22.8125 188.477 22.8828 188.34 23.02339 curveto
188.207 23.168 188.141 23.3672 188.133 23.6211 curveto
188.148 24.14839 lineto
188.148 24.3828 188.207 24.5703 188.328 24.707 curveto
188.453 24.8438 188.609 24.91411 188.797 24.91411 curveto
188.973 24.91411 189.121 24.8477 189.246 24.7188 curveto
189.367 24.58589 189.434 24.39839 189.438 24.14839 curveto
188.148 24.14839 lineto
188.133 23.6211 lineto
190.297 23.6211 lineto
190.309 24.2812 190.176 24.77339 189.895 25.0938 curveto
189.617 25.41411 189.23 25.5742 188.746 25.5742 curveto
188.312 25.5742 187.957 25.418 187.672 25.1133 curveto
187.391 24.8086 187.25 24.3867 187.25 23.8438 curveto
187.25 23.3945 187.355 23.0195 187.57 22.7227 curveto
187.844 22.3477 188.266 22.168 188.828 22.168 curveto
189.188 22.168 189.488 22.25 189.73 22.41411 curveto
189.961 22.5781 190.141 22.8164 190.25 23.1328 curveto
189.391 23.2773 lineto
189.34 23.1133 189.273 22.9961 189.18 22.9219 curveto
 closepath fill
newpath 190.938 22.2344 moveto
191.797 22.2344 lineto
191.797 23.8242 lineto
191.797 24.1367 191.82 24.3594 191.867 24.4961 curveto
191.914 24.6289 191.988 24.7344 192.098 24.8047 curveto
192.203 24.8789 192.324 24.91411 192.457 24.91411 curveto
192.566 24.91411 192.652 24.8906 192.719 24.8438 curveto
192.781 24.8008 192.828 24.7305 192.859 24.6406 curveto
192.891 24.5469 192.906 24.3438 192.906 24.0273 curveto
192.906 22.2344 lineto
193.773 22.2344 lineto
193.773 23.8047 lineto
193.773 24.1133 193.793 24.33589 193.84 24.4805 curveto
193.891 24.6211 193.969 24.7305 194.074 24.8008 curveto
194.18 24.875 194.293 24.91411 194.414 24.91411 curveto
194.582 24.91411 194.703 24.85161 194.781 24.7305 curveto
194.844 24.6328 194.871 24.4258 194.871 24.10161 curveto
194.871 22.2344 lineto
195.734 22.2344 lineto
195.734 24.3242 lineto
195.734 24.6328 195.703 24.8594 195.645 25 curveto
195.562 25.1875 195.441 25.3281 195.273 25.4258 curveto
195.109 25.52339 194.906 25.5742 194.668 25.5742 curveto
194.477 25.5742 194.301 25.5312 194.133 25.4453 curveto
193.969 25.3594 193.816 25.22661 193.668 25.0547 curveto
193.574 25.22661 193.449 25.3594 193.289 25.4453 curveto
193.137 25.5312 192.957 25.5742 192.746 25.5742 curveto
192.355 25.5742 192.016 25.39839 191.73 25.0547 curveto
191.73 25.5 lineto
190.938 25.5 lineto
 closepath fill
newpath 198.277 22.9219 moveto
198.184 22.8477 198.07 22.8125 197.934 22.8125 curveto
197.738 22.8125 197.57 22.8828 197.434 23.02339 curveto
197.301 23.168 197.23 23.3672 197.227 23.6211 curveto
197.246 24.14839 lineto
197.242 24.3828 197.301 24.5703 197.422 24.707 curveto
197.547 24.8438 197.703 24.91411 197.891 24.91411 curveto
198.07 24.91411 198.219 24.8477 198.34 24.7188 curveto
198.465 24.58589 198.527 24.39839 198.535 24.14839 curveto
197.246 24.14839 lineto
197.227 23.6211 lineto
199.391 23.6211 lineto
199.402 24.2812 199.27 24.77339 198.988 25.0938 curveto
198.707 25.41411 198.324 25.5742 197.836 25.5742 curveto
197.41 25.5742 197.047 25.418 196.766 25.1133 curveto
196.484 24.8086 196.34 24.3867 196.34 23.8438 curveto
196.34 23.3945 196.449 23.0195 196.664 22.7227 curveto
196.937 22.3477 197.355 22.168 197.926 22.168 curveto
198.285 22.168 198.582 22.25 198.82 22.41411 curveto
199.059 22.5781 199.234 22.8164 199.344 23.1328 curveto
198.484 23.2773 lineto
198.438 23.1133 198.367 22.9961 198.277 22.9219 curveto
 closepath fill
newpath 200.961 26.7422 moveto
200.094 26.7422 lineto
200.094 25.9414 lineto
200.961 25.9414 lineto
 closepath fill
newpath 200.961 25.5 moveto
200.094 25.5 lineto
200.094 22.2422 lineto
200.961 22.2422 lineto
 closepath fill
newpath 204.809 24.2656 moveto
204.809 24.5195 204.797 24.71089 204.762 24.8438 curveto
204.73 24.9805 204.672 25.10161 204.59 25.207 curveto
204.512 25.3164 204.391 25.4023 204.234 25.4688 curveto
204.078 25.53911 203.902 25.5742 203.715 25.5742 curveto
203.281 25.5742 202.922 25.3906 202.637 25.0195 curveto
202.637 25.5 lineto
201.836 25.5 lineto
201.836 22.2344 lineto
202.699 22.2344 lineto
202.699 23.7148 lineto
202.699 24.0781 202.723 24.3281 202.766 24.4648 curveto
202.809 24.60161 202.891 24.707 203.012 24.78911 curveto
203.129 24.8711 203.262 24.91411 203.41 24.91411 curveto
203.527 24.91411 203.629 24.8828 203.711 24.8281 curveto
203.793 24.7695 203.855 24.6914 203.891 24.58589 curveto
203.926 24.4844 203.945 24.2539 203.945 23.9023 curveto
203.945 22.2344 lineto
204.809 22.2344 lineto
 closepath fill
newpath 208.652 24.2656 moveto
208.652 24.5195 208.637 24.71089 208.605 24.8438 curveto
208.574 24.9805 208.516 25.10161 208.434 25.207 curveto
208.355 25.3164 208.234 25.4023 208.078 25.4688 curveto
207.922 25.53911 207.746 25.5742 207.555 25.5742 curveto
207.125 25.5742 206.766 25.3906 206.48 25.0195 curveto
206.48 25.5 lineto
205.68 25.5 lineto
205.68 22.2344 lineto
206.543 22.2344 lineto
206.543 23.7148 lineto
206.543 24.0781 206.566 24.3281 206.609 24.4648 curveto
206.652 24.60161 206.734 24.707 206.852 24.78911 curveto
206.973 24.8711 207.105 24.91411 207.254 24.91411 curveto
207.371 24.91411 207.473 24.8828 207.555 24.8281 curveto
207.637 24.7695 207.699 24.6914 207.734 24.58589 curveto
207.77 24.4844 207.789 24.2539 207.789 23.9023 curveto
207.789 22.2344 lineto
208.652 22.2344 lineto
 closepath fill
newpath 212.477 22.2344 moveto
212.477 25.5 lineto
211.613 25.5 lineto
211.613 24.125 lineto
211.613 23.6562 211.594 23.3633 211.551 23.2461 curveto
211.508 23.125 211.426 23.0273 211.309 22.9453 curveto
211.195 22.8633 211.062 22.8242 210.914 22.8242 curveto
210.785 22.8242 210.68 22.8555 210.594 22.91411 curveto
210.512 22.9727 210.453 23.0547 210.422 23.1602 curveto
210.391 23.2617 210.375 23.543 210.375 24 curveto
210.375 25.5 lineto
209.508 25.5 lineto
209.508 23.4375 lineto
209.508 23.1289 209.551 22.8906 209.629 22.7148 curveto
209.707 22.543 209.832 22.4062 210.008 22.3086 curveto
210.18 22.2148 210.375 22.168 210.594 22.168 curveto
210.809 22.168 211.016 22.2148 211.207 22.3125 curveto
211.402 22.418 211.559 22.5508 211.676 22.72661 curveto
211.676 22.2344 lineto
 closepath fill
newpath 210.703 26.8203 moveto
209.965 26.8203 lineto
209.965 26.082 lineto
210.703 26.082 lineto
 closepath fill
newpath 212.027 26.8203 moveto
211.285 26.8203 lineto
211.285 26.082 lineto
212.027 26.082 lineto
 closepath fill
newpath 214.277 25.5 moveto
214.277 26.6562 lineto
213.414 26.14839 lineto
213.414 25.5 lineto
213.016 25.5 lineto
213.016 24.8125 lineto
213.414 24.8125 lineto
213.414 23.3906 lineto
213.414 23.08589 213.422 22.8828 213.441 22.7812 curveto
213.465 22.6406 213.504 22.5312 213.562 22.4453 curveto
213.621 22.3633 213.711 22.2969 213.836 22.2461 curveto
213.961 22.1875 214.102 22.168 214.258 22.168 curveto
214.512 22.168 214.738 22.21089 214.937 22.293 curveto
214.867 22.9648 lineto
214.715 22.9102 214.598 22.8828 214.52 22.8828 curveto
214.461 22.8828 214.414 22.8945 214.375 22.9219 curveto
214.332 22.9531 214.309 22.9883 214.297 23.0352 curveto
214.285 23.0781 214.277 23.2305 214.277 23.5 curveto
214.277 24.8125 lineto
214.867 24.8125 lineto
214.867 25.5 lineto
 closepath fill
newpath 218.031 22.2344 moveto
218.031 22.9961 lineto
216.695 22.9961 lineto
216.641 22.9961 216.488 22.9922 216.25 22.97661 curveto
216.687 23.4531 lineto
217.938 24.8906 lineto
217.938 25.5 lineto
215.238 25.5 lineto
215.238 24.7852 lineto
216.395 24.78911 lineto
216.559 24.793 216.687 24.7969 216.793 24.8008 curveto
216.691 24.707 216.543 24.543 216.34 24.3164 curveto
215.121 22.9102 lineto
215.121 22.2344 lineto
 closepath fill
newpath 219.477 26.7422 moveto
218.613 26.7422 lineto
218.613 25.9414 lineto
219.477 25.9414 lineto
 closepath fill
newpath 219.477 25.5 moveto
218.613 25.5 lineto
218.613 22.2422 lineto
219.477 22.2422 lineto
 closepath fill
newpath 220.277 21.9219 moveto
220.277 21.625 220.398 21.3867 220.629 21.1953 curveto
220.855 21.0078 221.25 20.91411 221.805 20.91411 curveto
222.098 20.91411 222.34 20.9453 222.527 21.0039 curveto
222.723 21.0664 222.871 21.1523 222.988 21.2617 curveto
223.102 21.3672 223.191 21.5195 223.254 21.707 curveto
223.316 21.89839 223.352 22.1875 223.352 22.5742 curveto
223.352 25.5 lineto
222.543 25.5 lineto
222.543 25.043 lineto
222.297 24.668 lineto
222.434 24.5039 222.504 24.2539 222.504 23.91411 curveto
222.504 23.5898 222.43 23.3477 222.285 23.1836 curveto
222.141 23.0195 221.961 22.9375 221.75 22.9375 curveto
221.555 22.9375 221.391 23.0156 221.258 23.1758 curveto
221.121 23.3398 221.055 23.5898 221.055 23.9375 curveto
221.055 24.2656 221.121 24.5117 221.258 24.6719 curveto
221.258 24.6719 lineto
221.391 24.832 221.559 24.91411 221.766 24.91411 curveto
221.98 24.91411 222.156 24.832 222.297 24.668 curveto
222.543 25.043 lineto
222.281 25.3945 221.949 25.5742 221.547 25.5742 curveto
221.156 25.5742 220.828 25.4297 220.562 25.1406 curveto
220.297 24.85161 220.168 24.4336 220.168 23.8867 curveto
220.168 23.4531 220.27 23.08589 220.473 22.7969 curveto
220.727 22.4219 221.074 22.2344 221.512 22.2344 curveto
221.906 22.2344 222.23 22.41411 222.488 22.7695 curveto
222.488 22.293 lineto
222.488 22.0977 222.477 21.9648 222.449 21.8906 curveto
222.41 21.793 222.352 21.7188 222.277 21.6758 curveto
222.164 21.6055 221.996 21.5742 221.77 21.5742 curveto
221.594 21.5742 221.465 21.6055 221.383 21.66411 curveto
221.324 21.707 221.285 21.7852 221.27 21.9023 curveto
220.281 22.02339 lineto
220.277 21.9805 220.277 21.9453 220.277 21.9219 curveto
 closepath fill
newpath 225.887 22.9219 moveto
225.793 22.8477 225.68 22.8125 225.547 22.8125 curveto
225.348 22.8125 225.18 22.8828 225.047 23.02339 curveto
224.914 23.168 224.848 23.3672 224.84 23.6211 curveto
224.855 24.14839 lineto
224.852 24.3828 224.914 24.5703 225.035 24.707 curveto
225.16 24.8438 225.312 24.91411 225.5 24.91411 curveto
225.68 24.91411 225.828 24.8477 225.949 24.7188 curveto
226.074 24.58589 226.137 24.39839 226.145 24.14839 curveto
224.855 24.14839 lineto
224.84 23.6211 lineto
227 23.6211 lineto
227.012 24.2812 226.879 24.77339 226.598 25.0938 curveto
226.316 25.41411 225.938 25.5742 225.449 25.5742 curveto
225.02 25.5742 224.656 25.418 224.375 25.1133 curveto
224.094 24.8086 223.953 24.3867 223.953 23.8438 curveto
223.953 23.3945 224.062 23.0195 224.273 22.7227 curveto
224.551 22.3477 224.969 22.168 225.535 22.168 curveto
225.895 22.168 226.191 22.25 226.43 22.41411 curveto
226.668 22.5781 226.844 22.8164 226.953 23.1328 curveto
226.094 23.2773 lineto
226.047 23.1133 225.977 22.9961 225.887 22.9219 curveto
 closepath fill
newpath 232.598 23.8945 moveto
232.598 23.3242 lineto
232.461 23.2148 232.297 23.125 232.105 23.0508 curveto
231.91 22.97661 231.719 22.9414 231.527 22.9414 curveto
231.145 22.9414 230.832 23.0742 230.598 23.3398 curveto
230.359 23.6055 230.238 24.0078 230.238 24.543 curveto
230.238 25.0352 230.355 25.4102 230.59 25.6602 curveto
230.824 25.918 231.141 26.043 231.539 26.043 curveto
231.801 26.043 232.023 25.97661 232.195 25.8477 curveto
232.367 25.7188 232.492 25.5469 232.555 25.3242 curveto
233.457 25.4922 lineto
233.367 25.9062 233.164 26.2305 232.852 26.4688 curveto
232.531 26.7031 232.102 26.8203 231.539 26.8203 curveto
231.109 26.8203 230.75 26.7461 230.461 26.5938 curveto
230.082 26.4023 229.793 26.1211 229.598 25.7578 curveto
229.402 25.3906 229.305 24.9727 229.305 24.5039 curveto
229.305 24.0742 229.391 23.6719 229.566 23.3086 curveto
229.742 22.9375 230.004 22.6562 230.355 22.46089 curveto
230.707 22.2578 231.117 22.16411 231.586 22.16411 curveto
231.957 22.16411 232.324 22.2305 232.688 22.375 curveto
233.047 22.5117 233.324 22.6719 233.516 22.8594 curveto
233.516 24.6523 lineto
231.555 24.6523 lineto
231.555 23.8945 lineto
 closepath fill
newpath 234.281 22.2344 moveto
235.145 22.2344 lineto
235.145 23.8242 lineto
235.145 24.1367 235.168 24.3594 235.215 24.4961 curveto
235.258 24.6289 235.336 24.7344 235.441 24.8047 curveto
235.547 24.8789 235.668 24.91411 235.801 24.91411 curveto
235.914 24.91411 236 24.8906 236.066 24.8438 curveto
236.133 24.8008 236.18 24.7305 236.207 24.6406 curveto
236.242 24.5469 236.258 24.3438 236.258 24.0273 curveto
236.258 22.2344 lineto
237.117 22.2344 lineto
237.117 23.8047 lineto
237.117 24.1133 237.141 24.33589 237.191 24.4805 curveto
237.238 24.6211 237.312 24.7305 237.418 24.8008 curveto
237.527 24.875 237.641 24.91411 237.762 24.91411 curveto
237.926 24.91411 238.047 24.85161 238.129 24.7305 curveto
238.188 24.6328 238.219 24.4258 238.219 24.10161 curveto
238.219 22.2344 lineto
239.082 22.2344 lineto
239.082 24.3242 lineto
239.082 24.6328 239.051 24.8594 238.992 25 curveto
238.91 25.1875 238.785 25.3281 238.621 25.4258 curveto
238.453 25.52339 238.25 25.5742 238.012 25.5742 curveto
237.824 25.5742 237.648 25.5312 237.48 25.4453 curveto
237.316 25.3594 237.16 25.22661 237.016 25.0547 curveto
236.918 25.22661 236.793 25.3594 236.641 25.4453 curveto
236.488 25.5312 236.305 25.5742 236.098 25.5742 curveto
235.703 25.5742 235.363 25.39839 235.078 25.0547 curveto
235.078 25.5 lineto
234.281 25.5 lineto
 closepath fill
newpath 240.707 22.2344 moveto
240.707 22.7148 lineto
240.84 22.5352 240.996 22.3945 241.176 22.3008 curveto
241.355 22.21089 241.539 22.168 241.727 22.168 curveto
242.105 22.168 242.426 22.3125 242.691 22.6172 curveto
242.957 22.918 243.09 23.3477 243.09 23.9023 curveto
243.09 24.4414 242.957 24.8555 242.699 25.1406 curveto
242.441 25.4297 242.109 25.5742 241.715 25.5742 curveto
241.348 25.5742 241.035 25.4219 240.77 25.1172 curveto
240.969 24.6719 lineto
241.105 24.832 241.277 24.91411 241.484 24.91411 curveto
241.695 24.91411 241.867 24.832 242.004 24.66411 curveto
242.137 24.5 242.207 24.2344 242.207 23.8594 curveto
242.207 23.5117 242.137 23.2539 242.004 23.0898 curveto
241.871 22.9297 241.707 22.8477 241.516 22.8477 curveto
241.27 22.8477 241.07 22.96089 240.922 23.1914 curveto
240.816 23.35161 240.762 23.60161 240.762 23.9414 curveto
240.762 24.2695 240.832 24.5117 240.969 24.6719 curveto
240.77 25.1172 lineto
240.77 26.7422 lineto
239.906 26.7422 lineto
239.906 22.2344 lineto
 closepath fill
newpath 244.703 22.2344 moveto
244.703 24.207 lineto
246.484 24.207 lineto
246.484 22.2344 lineto
247.395 22.2344 lineto
247.395 26.7422 lineto
246.484 26.7422 lineto
246.484 24.9688 lineto
244.703 24.9688 lineto
244.703 26.7422 lineto
243.793 26.7422 lineto
243.793 22.2344 lineto
 closepath fill
newpath 182.953 30.2461 moveto
182.953 31.6055 lineto
183.688 32.3594 lineto
184.926 30.2461 lineto
186.105 30.2461 lineto
184.316 32.9961 lineto
186.012 34.75 lineto
184.785 34.75 lineto
182.953 32.75 lineto
182.953 34.75 lineto
182.039 34.75 lineto
182.039 30.2461 lineto
 closepath fill
newpath 187.43 34.75 moveto
186.57 34.75 lineto
186.57 30.2461 lineto
187.43 30.2461 lineto
 closepath fill
newpath 189.168 32.832 moveto
189.254 32.8906 189.375 32.9219 189.531 32.9219 curveto
189.754 32.9219 189.906 32.8867 189.992 32.8164 curveto
190.074 32.7461 190.117 32.625 190.117 32.46089 curveto
190.117 32.375 lineto
189.957 32.3086 189.68 32.2383 189.273 32.16411 curveto
188.977 32.1055 188.746 32.03911 188.59 31.96089 curveto
188.43 31.8828 188.309 31.77339 188.219 31.6289 curveto
188.129 31.4844 188.086 31.3203 188.086 31.1367 curveto
188.086 30.8594 188.184 30.6289 188.379 30.4453 curveto
188.57 30.2656 188.836 30.1719 189.172 30.1719 curveto
189.359 30.1719 189.539 30.21089 189.707 30.2812 curveto
189.875 30.3477 190.035 30.46089 190.184 30.6055 curveto
189.875 30.9336 lineto
189.734 30.832 189.582 30.7812 189.43 30.7812 curveto
189.289 30.7812 189.176 30.8242 189.086 30.91411 curveto
188.996 31 188.949 31.1055 188.949 31.22661 curveto
188.949 31.35161 189.004 31.4492 189.117 31.5312 curveto
189.191 31.5781 189.348 31.6289 189.586 31.6797 curveto
189.828 31.7344 190.008 31.7773 190.117 31.8125 curveto
190.117 31.6406 lineto
190.117 31.4336 190.105 31.293 190.078 31.2188 curveto
190.051 31.1094 189.98 31.0117 189.875 30.9336 curveto
190.184 30.6055 lineto
190.191 30.58589 190.199 30.5547 190.215 30.5039 curveto
190.242 30.3906 190.277 30.3047 190.297 30.2461 curveto
191.152 30.2461 lineto
191.074 30.4023 191.023 30.5469 190.996 30.6836 curveto
190.969 30.8203 190.953 31.0312 190.953 31.3203 curveto
190.965 32.3242 lineto
190.965 32.6992 190.926 32.957 190.848 33.0977 curveto
190.773 33.2383 190.641 33.3555 190.453 33.4453 curveto
190.262 33.5352 189.977 33.582 189.586 33.582 curveto
189.164 33.582 188.848 33.5039 188.629 33.3555 curveto
188.414 33.2031 188.266 32.9688 188.176 32.6523 curveto
188.957 32.5117 lineto
189.012 32.66411 189.082 32.7695 189.168 32.832 curveto
 closepath fill
newpath 194.766 30.2461 moveto
194.766 33.5117 lineto
193.902 33.5117 lineto
193.902 32.1328 lineto
193.902 31.66411 193.875 31.3711 193.832 31.2539 curveto
193.789 31.1328 193.711 31.0312 193.594 30.9531 curveto
193.477 30.8711 193.344 30.832 193.199 30.832 curveto
193.07 30.832 192.961 30.8594 192.879 30.9219 curveto
192.797 30.9805 192.738 31.0625 192.707 31.168 curveto
192.672 31.2695 192.66 31.5508 192.66 32.0078 curveto
192.66 33.5117 lineto
191.797 33.5117 lineto
191.797 31.4453 lineto
191.797 31.1367 191.836 30.89839 191.91 30.7227 curveto
191.992 30.5508 192.117 30.41411 192.289 30.3203 curveto
192.465 30.2227 192.66 30.1719 192.879 30.1719 curveto
193.094 30.1719 193.297 30.2227 193.492 30.3242 curveto
193.687 30.4258 193.84 30.5625 193.965 30.7344 curveto
193.965 30.2461 lineto
 closepath fill
newpath 195.863 30.4453 moveto
196.121 30.2656 196.473 30.1719 196.914 30.1719 curveto
197.41 30.1719 197.777 30.2812 198.027 30.4961 curveto
198.277 30.71089 198.402 30.9688 198.402 31.2656 curveto
198.402 31.53911 198.312 31.7539 198.133 31.9102 curveto
197.949 32.0586 197.625 32.1875 197.168 32.293 curveto
196.707 32.39839 196.438 32.47661 196.359 32.5352 curveto
196.305 32.5781 196.273 32.6289 196.273 32.6914 curveto
196.273 32.7617 196.309 32.8203 196.371 32.8672 curveto
196.469 32.9297 196.633 32.96089 196.859 32.96089 curveto
197.039 32.96089 197.18 32.9258 197.277 32.8594 curveto
197.375 32.793 197.445 32.6953 197.473 32.5703 curveto
198.293 32.7188 lineto
198.211 33.0039 198.059 33.2188 197.844 33.3633 curveto
197.625 33.5117 197.293 33.582 196.844 33.582 curveto
196.375 33.582 196.031 33.4844 195.809 33.293 curveto
195.586 33.10161 195.473 32.8633 195.473 32.582 curveto
195.473 32.2656 195.602 32.02339 195.859 31.8477 curveto
196.047 31.7188 196.488 31.5781 197.184 31.4258 curveto
197.332 31.3906 197.43 31.3555 197.473 31.3125 curveto
197.512 31.2695 197.535 31.2148 197.535 31.14839 curveto
197.535 31.0547 197.496 30.97661 197.418 30.918 curveto
197.305 30.83589 197.137 30.7969 196.914 30.7969 curveto
196.715 30.7969 196.555 30.8398 196.445 30.9258 curveto
196.332 31.0156 196.254 31.1406 196.219 31.3086 curveto
195.355 31.1758 lineto
195.434 30.8672 195.602 30.625 195.863 30.4453 curveto
 closepath fill
newpath 202.836 30.2461 moveto
202.836 33.9844 lineto
204.168 33.9844 lineto
204.168 34.75 lineto
200.586 34.75 lineto
200.586 33.9844 lineto
201.926 33.9844 lineto
201.926 30.2461 lineto
 closepath fill
newpath 204.484 30.4453 moveto
204.742 30.2656 205.094 30.1719 205.543 30.1719 curveto
206.031 30.1719 206.402 30.2812 206.652 30.4961 curveto
206.898 30.71089 207.023 30.9688 207.023 31.2656 curveto
207.023 31.53911 206.934 31.7539 206.754 31.9102 curveto
206.574 32.0586 206.254 32.1875 205.793 32.293 curveto
205.332 32.39839 205.062 32.47661 204.984 32.5352 curveto
204.926 32.5781 204.898 32.6289 204.898 32.6914 curveto
204.898 32.7617 204.93 32.8203 205 32.8672 curveto
205.094 32.9297 205.258 32.96089 205.488 32.96089 curveto
205.668 32.96089 205.805 32.9258 205.902 32.8594 curveto
206 32.793 206.066 32.6953 206.102 32.5703 curveto
206.914 32.7188 lineto
206.832 33.0039 206.684 33.2188 206.465 33.3633 curveto
206.25 33.5117 205.918 33.582 205.469 33.582 curveto
205.004 33.582 204.652 33.4844 204.43 33.293 curveto
204.207 33.10161 204.098 32.8633 204.098 32.582 curveto
204.098 32.2656 204.227 32.02339 204.484 31.8477 curveto
204.668 31.7188 205.109 31.5781 205.809 31.4258 curveto
205.961 31.3906 206.055 31.3555 206.098 31.3125 curveto
206.141 31.2695 206.16 31.2148 206.16 31.14839 curveto
206.16 31.0547 206.121 30.97661 206.047 30.918 curveto
205.934 30.83589 205.766 30.7969 205.543 30.7969 curveto
205.34 30.7969 205.18 30.8398 205.066 30.9258 curveto
204.957 31.0156 204.883 31.1406 204.84 31.3086 curveto
203.977 31.1758 lineto
204.055 30.8672 204.227 30.625 204.484 30.4453 curveto
 closepath fill
newpath 210.121 33.3242 moveto
209.887 33.4961 209.57 33.582 209.176 33.582 curveto
208.684 33.582 208.301 33.4336 208.016 33.1289 curveto
207.73 32.832 207.59 32.41411 207.59 31.875 curveto
207.59 31.3438 207.73 30.9258 208.016 30.625 curveto
208.297 30.3242 208.68 30.1719 209.16 30.1719 curveto
209.578 30.1719 209.914 30.2695 210.164 30.4727 curveto
210.414 30.668 210.582 30.9648 210.668 31.35161 curveto
209.82 31.4961 lineto
209.777 31.2695 209.707 31.1094 209.602 31.0156 curveto
209.496 30.9219 209.363 30.875 209.199 30.875 curveto
208.977 30.875 208.801 30.957 208.676 31.1172 curveto
208.543 31.2773 208.477 31.5469 208.477 31.9375 curveto
208.477 32.2852 208.539 32.5312 208.668 32.6797 curveto
208.801 32.8281 208.969 32.9023 209.184 32.9023 curveto
209.344 32.9023 209.48 32.8594 209.582 32.77339 curveto
209.684 32.6875 209.746 32.5586 209.777 32.3906 curveto
210.625 32.543 lineto
210.523 32.8945 210.355 33.1523 210.121 33.3242 curveto
 closepath fill
newpath 211.277 34.75 moveto
211.277 30.2461 lineto
212.141 30.2461 lineto
212.141 31.8789 lineto
212.141 32.1562 212.164 32.3633 212.219 32.5 curveto
212.27 32.6406 212.352 32.7461 212.465 32.8164 curveto
212.578 32.8867 212.711 32.9219 212.848 32.9219 curveto
212.973 32.9219 213.082 32.8945 213.164 32.8398 curveto
213.246 32.7852 213.305 32.71089 213.336 32.6211 curveto
213.367 32.5273 213.387 32.3125 213.387 31.9688 curveto
213.387 30.2461 lineto
214.25 30.2461 lineto
214.25 32.1602 lineto
214.25 32.4531 214.234 32.668 214.203 32.8047 curveto
214.176 32.9453 214.117 33.0742 214.039 33.1875 curveto
213.957 33.3008 213.836 33.39839 213.676 33.4727 curveto
213.52 33.543 213.34 33.582 213.141 33.582 curveto
212.754 33.582 212.418 33.418 212.141 33.0938 curveto
212.141 34.75 lineto
 closepath fill
newpath 215.984 34.75 moveto
215.125 34.75 lineto
215.125 33.9531 lineto
215.984 33.9531 lineto
 closepath fill
newpath 215.984 33.5117 moveto
215.125 33.5117 lineto
215.125 30.2461 lineto
215.984 30.2461 lineto
 closepath fill
newpath 217.699 31.2539 moveto
217.699 31.8086 217.723 32.1719 217.77 32.3477 curveto
217.82 32.5195 217.887 32.6406 217.969 32.707 curveto
218.055 32.77339 218.156 32.8047 218.277 32.8047 curveto
218.402 32.8047 218.535 32.7617 218.68 32.66411 curveto
218.949 33.418 lineto
218.766 33.5273 218.578 33.582 218.379 33.582 curveto
218.242 33.582 218.117 33.5469 218.008 33.47661 curveto
217.898 33.4062 217.773 33.2617 217.637 33.043 curveto
217.637 33.5117 lineto
216.836 33.5117 lineto
216.836 30.2461 lineto
217.699 30.2461 lineto
 closepath fill
newpath 220.172 32.832 moveto
220.258 32.8906 220.379 32.9219 220.531 32.9219 curveto
220.762 32.9219 220.918 32.8867 221 32.8164 curveto
221.082 32.7461 221.121 32.625 221.121 32.46089 curveto
221.121 32.375 lineto
220.965 32.3086 220.687 32.2383 220.281 32.16411 curveto
219.98 32.1055 219.754 32.03911 219.594 31.96089 curveto
219.438 31.8828 219.312 31.77339 219.227 31.6289 curveto
219.137 31.4844 219.094 31.3203 219.094 31.1367 curveto
219.094 30.8594 219.187 30.6289 219.383 30.4453 curveto
219.574 30.2656 219.84 30.1719 220.176 30.1719 curveto
220.367 30.1719 220.551 30.21089 220.719 30.2812 curveto
220.887 30.3477 221.043 30.46089 221.191 30.6055 curveto
220.883 30.9336 lineto
220.738 30.832 220.594 30.7812 220.438 30.7812 curveto
220.293 30.7812 220.18 30.8242 220.09 30.91411 curveto
220 31 219.953 31.1055 219.953 31.22661 curveto
219.953 31.35161 220.012 31.4492 220.125 31.5312 curveto
220.195 31.5781 220.355 31.6289 220.598 31.6797 curveto
220.836 31.7344 221.012 31.7773 221.121 31.8125 curveto
221.121 31.6406 lineto
221.121 31.4336 221.109 31.293 221.09 31.2188 curveto
221.055 31.1094 220.988 31.0117 220.883 30.9336 curveto
221.191 30.6055 lineto
221.195 30.58589 221.207 30.5547 221.219 30.5039 curveto
221.254 30.3906 221.281 30.3047 221.305 30.2461 curveto
222.156 30.2461 lineto
222.082 30.4023 222.027 30.5469 222 30.6836 curveto
221.973 30.8203 221.961 31.0312 221.961 31.3203 curveto
221.969 32.3242 lineto
221.969 32.6992 221.93 32.957 221.855 33.0977 curveto
221.777 33.2383 221.645 33.3555 221.457 33.4453 curveto
221.27 33.5352 220.98 33.582 220.598 33.582 curveto
220.172 33.582 219.852 33.5039 219.637 33.3555 curveto
219.422 33.2031 219.27 32.9688 219.18 32.6523 curveto
219.965 32.5117 lineto
220.016 32.66411 220.086 32.7695 220.172 32.832 curveto
 closepath fill
newpath 224.891 30.5625 moveto
225.195 30.2969 225.633 30.168 226.203 30.168 curveto
226.594 30.168 226.918 30.2227 227.184 30.332 curveto
227.441 30.4414 227.645 30.6094 227.789 30.832 curveto
227.934 31.0586 228.004 31.3008 228.004 31.5586 curveto
228.004 31.8438 227.945 32.082 227.824 32.27339 curveto
227.703 32.4688 227.539 32.6211 227.328 32.7344 curveto
227.113 32.8438 226.789 32.9531 226.348 33.0547 curveto
225.906 33.1602 225.625 33.2617 225.512 33.3555 curveto
225.422 33.4336 225.375 33.52339 225.375 33.6328 curveto
225.375 33.7461 225.426 33.8438 225.52 33.91411 curveto
225.668 34.0195 225.875 34.0742 226.141 34.0742 curveto
226.398 34.0742 226.59 34.02339 226.719 33.9258 curveto
226.844 33.8203 226.93 33.6523 226.969 33.4219 curveto
227.875 33.46089 lineto
227.863 33.8789 227.711 34.207 227.426 34.457 curveto
227.141 34.7031 226.715 34.8281 226.148 34.8281 curveto
225.805 34.8281 225.508 34.7773 225.266 34.6719 curveto
225.02 34.5664 224.832 34.41411 224.703 34.2148 curveto
224.57 34.0156 224.508 33.8008 224.508 33.5703 curveto
224.508 33.21089 224.645 32.9102 224.922 32.66411 curveto
225.117 32.4883 225.461 32.3398 225.945 32.2188 curveto
226.324 32.125 226.57 32.0586 226.676 32.02339 curveto
226.828 31.9648 226.938 31.9023 227 31.8281 curveto
227.066 31.7539 227.094 31.6602 227.094 31.5547 curveto
227.094 31.3906 227.02 31.2461 226.871 31.1211 curveto
226.727 30.9961 226.504 30.9336 226.211 30.9336 curveto
225.934 30.9336 225.715 31.0039 225.555 31.1445 curveto
225.391 31.2812 225.281 31.5 225.23 31.7969 curveto
224.348 31.71089 lineto
224.402 31.207 224.586 30.8242 224.891 30.5625 curveto
 closepath fill
newpath 229.672 33.5117 moveto
229.672 34.6602 lineto
228.805 34.1602 lineto
228.805 33.5117 lineto
228.406 33.5117 lineto
228.406 32.8203 lineto
228.805 32.8203 lineto
228.805 31.39839 lineto
228.805 31.0938 228.816 30.8906 228.832 30.78911 curveto
228.855 30.64839 228.898 30.53911 228.953 30.4531 curveto
229.012 30.3711 229.105 30.3047 229.23 30.2539 curveto
229.355 30.1992 229.492 30.1719 229.648 30.1719 curveto
229.902 30.1719 230.129 30.2148 230.332 30.3008 curveto
230.258 30.9727 lineto
230.105 30.918 229.992 30.8906 229.91 30.8906 curveto
229.855 30.8906 229.805 30.9023 229.766 30.9336 curveto
229.727 30.96089 229.699 30.9961 229.687 31.03911 curveto
229.676 31.08589 229.672 31.2422 229.672 31.5039 curveto
229.672 32.8203 lineto
230.262 32.8203 lineto
230.262 33.5117 lineto
 closepath fill
newpath 231.723 34.75 moveto
230.859 34.75 lineto
230.859 33.9531 lineto
231.723 33.9531 lineto
 closepath fill
newpath 231.723 33.5117 moveto
230.859 33.5117 lineto
230.859 30.2461 lineto
231.723 30.2461 lineto
 closepath fill
newpath 232.23 32.8281 moveto
232.711 32.8281 lineto
232.711 30.2461 lineto
233.574 30.2461 lineto
233.574 32.8281 lineto
234.219 32.8281 lineto
234.219 33.5117 lineto
233.574 33.5117 lineto
233.574 33.7383 lineto
233.574 33.9023 233.602 34.0195 233.656 34.0781 curveto
233.707 34.1367 233.797 34.16411 233.922 34.16411 curveto
234.051 34.16411 234.184 34.1445 234.32 34.1172 curveto
234.437 34.7188 lineto
234.199 34.78911 233.961 34.8281 233.715 34.8281 curveto
233.477 34.8281 233.277 34.7852 233.121 34.6992 curveto
232.965 34.6172 232.855 34.5039 232.797 34.3711 curveto
232.738 34.2344 232.711 34.0312 232.711 33.7578 curveto
232.711 33.5117 lineto
232.23 33.5117 lineto
 closepath fill
newpath 235.613 33.5117 moveto
235.613 34.6602 lineto
234.742 34.1602 lineto
234.742 33.5117 lineto
234.348 33.5117 lineto
234.348 32.8203 lineto
234.742 32.8203 lineto
234.742 31.39839 lineto
234.742 31.0938 234.75 30.8906 234.77 30.78911 curveto
234.793 30.64839 234.832 30.53911 234.891 30.4531 curveto
234.949 30.3711 235.043 30.3047 235.164 30.2539 curveto
235.289 30.1992 235.43 30.1719 235.586 30.1719 curveto
235.84 30.1719 236.07 30.2148 236.273 30.3008 curveto
236.199 30.9727 lineto
236.043 30.918 235.926 30.8906 235.848 30.8906 curveto
235.789 30.8906 235.746 30.9023 235.703 30.9336 curveto
235.664 30.96089 235.637 30.9961 235.625 31.03911 curveto
235.617 31.08589 235.613 31.2422 235.613 31.5039 curveto
235.613 32.8203 lineto
236.203 32.8203 lineto
236.203 33.5117 lineto
 closepath fill
newpath 239.75 30.2461 moveto
239.75 33.5117 lineto
238.883 33.5117 lineto
238.883 32.1328 lineto
238.883 31.66411 238.863 31.3711 238.82 31.2539 curveto
238.777 31.1328 238.695 31.0312 238.578 30.9531 curveto
238.461 30.8711 238.332 30.832 238.184 30.832 curveto
238.055 30.832 237.949 30.8594 237.863 30.9219 curveto
237.781 30.9805 237.723 31.0625 237.691 31.168 curveto
237.66 31.2695 237.645 31.5508 237.645 32.0078 curveto
237.645 33.5117 lineto
236.781 33.5117 lineto
236.781 31.4453 lineto
236.781 31.1367 236.82 30.89839 236.898 30.7227 curveto
236.977 30.5508 237.102 30.41411 237.277 30.3203 curveto
237.449 30.2227 237.645 30.1719 237.863 30.1719 curveto
238.078 30.1719 238.285 30.2227 238.477 30.3242 curveto
238.672 30.4258 238.828 30.5625 238.945 30.7344 curveto
238.945 30.2461 lineto
 closepath fill
newpath 243.613 32.27339 moveto
243.613 32.52339 243.59 32.7188 243.559 32.8555 curveto
243.531 32.9883 243.473 33.1094 243.391 33.2148 curveto
243.309 33.3203 243.191 33.4102 243.035 33.47661 curveto
242.875 33.5469 242.703 33.582 242.512 33.582 curveto
242.082 33.582 241.723 33.39839 241.438 33.0273 curveto
241.438 33.5117 lineto
240.637 33.5117 lineto
240.637 30.2461 lineto
241.5 30.2461 lineto
241.5 31.7227 lineto
241.5 32.0898 241.52 32.33589 241.566 32.4727 curveto
241.609 32.6094 241.691 32.7148 241.809 32.7969 curveto
241.926 32.8789 242.062 32.9219 242.211 32.9219 curveto
242.328 32.9219 242.426 32.8945 242.512 32.83589 curveto
242.594 32.7773 242.652 32.6992 242.691 32.5938 curveto
242.727 32.4922 242.746 32.2617 242.746 31.9102 curveto
242.746 30.2461 lineto
243.613 30.2461 lineto
 closepath fill
newpath 244.402 29.9297 moveto
244.402 29.6367 244.52 29.3945 244.75 29.2031 curveto
244.98 29.0156 245.375 28.9219 245.926 28.9219 curveto
246.219 28.9219 246.461 28.9531 246.652 29.0117 curveto
246.844 29.0742 246.996 29.1602 247.109 29.2695 curveto
247.223 29.375 247.312 29.5273 247.383 29.7188 curveto
247.445 29.9062 247.473 30.1992 247.473 30.582 curveto
247.473 33.5117 lineto
246.664 33.5117 lineto
246.664 33.0508 lineto
246.418 32.6758 lineto
246.555 32.5117 246.625 32.2617 246.625 31.9219 curveto
246.625 31.60161 246.551 31.3555 246.406 31.1914 curveto
246.262 31.0273 246.086 30.9453 245.875 30.9453 curveto
245.676 30.9453 245.512 31.02339 245.379 31.1875 curveto
245.242 31.3438 245.176 31.5977 245.176 31.9453 curveto
245.176 32.27339 245.242 32.5195 245.379 32.6797 curveto
245.379 32.6797 lineto
245.512 32.8398 245.684 32.9219 245.887 32.9219 curveto
246.102 32.9219 246.277 32.8398 246.418 32.6758 curveto
246.664 33.0508 lineto
246.402 33.4023 246.07 33.582 245.668 33.582 curveto
245.277 33.582 244.949 33.4375 244.688 33.14839 curveto
244.426 32.8594 244.293 32.4414 244.293 31.8945 curveto
244.293 31.46089 244.395 31.0938 244.594 30.8008 curveto
244.848 30.4336 245.195 30.2461 245.633 30.2461 curveto
246.027 30.2461 246.352 30.4219 246.609 30.7773 curveto
246.609 30.3008 lineto
246.609 30.1055 246.598 29.9727 246.57 29.89839 curveto
246.531 29.8047 246.473 29.72661 246.398 29.6836 curveto
246.285 29.6133 246.117 29.582 245.891 29.582 curveto
245.715 29.582 245.586 29.6133 245.504 29.6758 curveto
245.445 29.7188 245.41 29.7969 245.391 29.91411 curveto
244.406 30.0273 lineto
244.406 29.9883 244.402 29.957 244.402 29.9297 curveto
 closepath fill
newpath 285.82 15.3398 moveto
285.82 16.6836 lineto
286.547 17.4297 lineto
287.77301 15.3398 lineto
288.93799 15.3398 lineto
287.168 18.0586 lineto
288.84799 19.7969 lineto
287.637 19.7969 lineto
285.82 17.8164 lineto
285.82 19.7969 lineto
284.918 19.7969 lineto
284.918 15.3398 lineto
 closepath fill
newpath 291.68 15.3398 moveto
291.68 19.043 lineto
293 19.043 lineto
293 19.7969 lineto
289.461 19.7969 lineto
289.461 19.043 lineto
290.781 19.043 lineto
290.781 15.3398 lineto
 closepath fill
newpath 294.27301 15.6484 moveto
294.574 15.3906 295.008 15.2578 295.57 15.2578 curveto
295.957 15.2578 296.27701 15.3125 296.539 15.4219 curveto
296.797 15.5312 297 15.6953 297.14099 15.918 curveto
297.281 16.1406 297.35199 16.3789 297.35199 16.6367 curveto
297.35199 16.918 297.297 17.1523 297.18 17.3438 curveto
297.05899 17.5352 296.89099 17.6875 296.68399 17.7969 curveto
296.47299 17.9062 296.14801 18.0156 295.711 18.1172 curveto
295.27301 18.2227 295 18.3242 294.887 18.418 curveto
294.797 18.4961 294.75 18.58589 294.75 18.6914 curveto
294.75 18.8047 294.801 18.89839 294.89499 18.9688 curveto
295.043 19.0742 295.246 19.1289 295.508 19.1289 curveto
295.762 19.1289 295.949 19.0781 296.078 18.97661 curveto
296.203 18.8789 296.285 18.71089 296.324 18.4844 curveto
297.22699 18.52339 lineto
297.215 18.9336 297.06201 19.2617 296.77701 19.5039 curveto
296.496 19.75 296.074 19.8711 295.51599 19.8711 curveto
295.176 19.8711 294.883 19.8203 294.64099 19.7188 curveto
294.39801 19.6133 294.215 19.4648 294.086 19.2656 curveto
293.957 19.0703 293.89099 18.8555 293.89099 18.6289 curveto
293.89099 18.27339 294.02701 17.97661 294.301 17.7305 curveto
294.496 17.5547 294.836 17.4062 295.31601 17.28911 curveto
295.69101 17.1953 295.93 17.1328 296.035 17.0938 curveto
296.19101 17.03911 296.301 16.97661 296.35901 16.9023 curveto
296.422 16.8281 296.453 16.7383 296.453 16.6328 curveto
296.453 16.4688 296.379 16.3242 296.23401 16.2031 curveto
296.086 16.082 295.867 16.0195 295.578 16.0195 curveto
295.305 16.0195 295.09 16.0898 294.926 16.22661 curveto
294.76599 16.3633 294.656 16.5781 294.60501 16.8711 curveto
293.73001 16.78911 lineto
293.789 16.28911 293.969 15.9102 294.27301 15.6484 curveto
 closepath fill
 0.8706 0.8667 0.8706 setrgbcolor
newpath 269.504 22.1836 moveto
282.578 22.1836 lineto
282.578 35.1875 lineto
269.504 35.1875 lineto
 closepath fill
 0 0 0 setrgbcolor
newpath 262.77301 15.6992 moveto
268.89099 21.77339 lineto
268.81201 21.8906 268.76999 22.0312 268.76999 22.1836 curveto
268.76999 22.60161 269.09799 22.9375 269.504 22.9375 curveto
269.656 22.9375 269.801 22.8867 269.918 22.8047 curveto
272.574 25.4375 lineto
269.953 28.0703 lineto
269.828 27.9727 269.672 27.91411 269.504 27.91411 curveto
269.10199 27.91411 268.77301 28.2539 268.77301 28.66411 curveto
268.77301 28.832 268.824 28.9883 268.914 29.1133 curveto
262.738 35.3242 lineto
268.789 35.3242 lineto
268.85199 35.6719 269.14801 35.9375 269.508 35.9375 curveto
269.867 35.9375 270.168 35.6719 270.23401 35.3242 curveto
275.27301 35.3242 lineto
275.332 35.6719 275.633 35.9414 275.992 35.9414 curveto
276.35501 35.9414 276.65201 35.6719 276.715 35.3242 curveto
281.863 35.3242 lineto
281.922 35.6719 282.22299 35.9375 282.582 35.9375 curveto
282.988 35.9375 283.31601 35.60161 283.31601 35.1875 curveto
283.31601 34.8164 283.055 34.5117 282.711 34.4492 curveto
282.445 34.4492 lineto
282.332 34.4727 282.238 34.5156 282.156 34.5781 curveto
276.613 29.0742 lineto
276.68799 28.957 276.72699 28.8203 276.72699 28.6719 curveto
276.72699 28.2578 276.39801 27.9219 275.996 27.9219 curveto
275.844 27.9219 275.703 27.9688 275.586 28.0508 curveto
272.953 25.4336 lineto
272.76599 25.625 lineto
275.39499 28.2383 lineto
275.31201 28.3633 275.262 28.5117 275.262 28.6719 curveto
275.262 29.08589 275.59 29.4219 275.996 29.4219 curveto
276.16 29.4219 276.31201 29.3672 276.43399 29.27339 curveto
281.965 34.77339 lineto
281.918 34.8594 281.875 34.9531 281.863 35.0547 curveto
276.715 35.0547 lineto
276.65201 34.7031 276.35501 34.4375 275.992 34.4375 curveto
275.633 34.4375 275.336 34.7031 275.27301 35.0547 curveto
270.23401 35.0547 lineto
270.168 34.7031 269.871 34.4375 269.508 34.4375 curveto
269.14801 34.4375 268.84799 34.7031 268.789 35.0547 curveto
263.387 35.0547 lineto
269.10901 29.2969 lineto
269.22299 29.3711 269.35901 29.41411 269.504 29.41411 curveto
269.91 29.41411 270.238 29.082 270.238 28.66411 curveto
270.238 28.52339 270.199 28.3867 270.129 28.27339 curveto
272.76599 25.625 lineto
272.953 25.4336 lineto
275.578 22.8008 lineto
275.699 22.8828 275.84 22.9336 275.996 22.9336 curveto
276.40201 22.9336 276.73001 22.5938 276.73001 22.1797 curveto
276.73001 22.02339 276.68399 21.8828 276.60501 21.7617 curveto
282.445 15.8984 lineto
282.445 21.4414 lineto
282.10501 21.5078 281.844 21.8125 281.844 22.1758 curveto
281.844 22.5469 282.10501 22.85161 282.445 22.918 curveto
282.445 27.9336 lineto
282.10901 28 281.84799 28.3047 281.84799 28.668 curveto
281.84799 29.0312 282.10901 29.33589 282.445 29.4062 curveto
282.445 34.4492 lineto
282.711 34.4492 lineto
282.711 29.4062 lineto
283.055 29.3477 283.32 29.03911 283.32 28.668 curveto
283.32 28.2969 283.055 27.9883 282.711 27.9297 curveto
282.711 22.9219 lineto
283.055 22.8555 283.31201 22.5508 283.31201 22.1758 curveto
283.31201 21.8086 283.055 21.5039 282.711 21.4375 curveto
282.711 15.25 lineto
276.422 21.5664 lineto
276.301 21.4805 276.156 21.4297 275.996 21.4297 curveto
275.59 21.4297 275.262 21.7656 275.262 22.1797 curveto
275.262 22.3398 275.31201 22.4844 275.39099 22.6055 curveto
272.762 25.2461 lineto
270.10901 22.6094 lineto
270.19101 22.4883 270.238 22.3398 270.238 22.1836 curveto
270.238 21.7695 269.906 21.4336 269.504 21.4336 curveto
269.34 21.4336 269.19101 21.4844 269.07 21.5781 curveto
263.15201 15.6992 lineto
 closepath fill
 0.2118 0.2118 0.2118 setrgbcolor 0.42944
 0 dtransform exch truncate exch idtransform pop setlinewidth
newpath 255.535 43.2031 moveto
255.535 7.5664 lineto stroke
 0.302 0.302 0.302 setrgbcolor
newpath 98.6914 13.4023 moveto
98.6914 10.1992 lineto
100.578 10.1992 lineto
100.578 10.5898 lineto
99.1289 10.5898 lineto
99.1289 13.4023 lineto
 closepath fill
newpath 103.605 11.332 moveto
101.91 11.332 lineto
101.92601 11.6328 lineto
103.223 11.6328 lineto
103.223 11.8008 103.172 11.9414 103.06601 12.0547 curveto
102.94899 12.1758 102.793 12.2383 102.598 12.2383 curveto
102.598 12.2383 lineto
102.41 12.2383 102.254 12.1758 102.129 12.0586 curveto
102.012 11.9453 101.94101 11.8047 101.92601 11.6328 curveto
101.91 11.332 lineto
101.91 11.0586 101.988 10.8438 102.141 10.7031 curveto
102.27301 10.5742 102.445 10.5039 102.652 10.5039 curveto
102.891 10.5039 103.086 10.5781 103.246 10.7109 curveto
103.422 10.4141 lineto
103.359 10.3477 103.262 10.293 103.125 10.2461 curveto
102.961 10.1836 102.777 10.1562 102.57 10.1562 curveto
102.277 10.1562 102.027 10.2539 101.81601 10.4531 curveto
101.59 10.6758 101.48 10.9727 101.48 11.3438 curveto
101.48 11.7305 101.598 12.043 101.828 12.2734 curveto
102.039 12.4805 102.289 12.5859 102.57399 12.5859 curveto
102.91 12.5859 103.172 12.4922 103.359 12.3047 curveto
103.543 12.125 103.637 11.8828 103.637 11.5859 curveto
103.637 11.4961 103.625 11.4102 103.605 11.332 curveto
 closepath fill
newpath 105.203 13.4297 moveto
105.277 13.4297 105.336 13.4023 105.387 13.3516 curveto
105.44101 13.3047 105.461 13.2422 105.461 13.1719 curveto
105.461 13.1016 105.44101 13.0391 105.387 12.9883 curveto
105.336 12.9414 105.277 12.9141 105.203 12.9141 curveto
105.133 12.9141 105.07399 12.9414 105.02301 12.9883 curveto
104.973 13.0391 104.94899 13.1016 104.94899 13.1719 curveto
104.94899 13.2422 104.973 13.3047 105.02301 13.3555 curveto
105.07 13.4023 105.133 13.4297 105.203 13.4297 curveto
 closepath fill
newpath 104.97699 10.1992 moveto
104.97699 12.1914 lineto
104.65599 12.1914 lineto
104.65599 12.543 lineto
105.39801 12.543 lineto
105.39801 10.1992 lineto
 closepath fill
newpath 107.113 10.3711 moveto
106.965 10.1562 lineto
106.758 10.1562 lineto
106.758 13.5 lineto
107.172 13.5 lineto
107.172 12.3711 lineto
107.35199 12.1719 lineto
107.262 12.1289 107.203 12.0898 107.172 12.0547 curveto
107.172 12.0547 lineto
107.172 10.7031 lineto
107.172 10.6758 107.22699 10.6367 107.328 10.5859 curveto
107.43399 10.5352 107.512 10.5039 107.56601 10.5039 curveto
107.848 10.5039 108.05101 10.5781 108.172 10.707 curveto
108.293 10.8438 108.355 11.0742 108.355 11.3945 curveto
108.355 11.6602 108.285 11.8672 108.141 12.0156 curveto
108 12.1641 107.80899 12.2383 107.56601 12.2383 curveto
107.516 12.2383 107.44101 12.2148 107.35199 12.1719 curveto
107.172 12.3711 lineto
107.211 12.4219 107.285 12.4727 107.395 12.5195 curveto
107.504 12.5664 107.609 12.5859 107.715 12.5859 curveto
108.035 12.5859 108.297 12.4766 108.496 12.2539 curveto
108.695 12.0352 108.793 11.7539 108.793 11.4141 curveto
108.793 11.0273 108.69101 10.7148 108.492 10.4961 curveto
108.293 10.2656 108.02301 10.1562 107.68399 10.1562 curveto
107.57 10.1562 107.461 10.1758 107.355 10.2148 curveto
107.25 10.2578 107.168 10.3086 107.113 10.3711 curveto
 closepath fill
newpath 111.39801 10.1992 moveto
111.39801 11.5625 lineto
111.39801 11.8125 111.363 11.9883 111.285 12.0859 curveto
111.211 12.1875 111.086 12.2383 110.91 12.2383 curveto
110.81601 12.2383 110.715 12.207 110.613 12.1523 curveto
110.508 12.0938 110.43 12.0234 110.375 11.9414 curveto
110.375 10.1992 lineto
109.957 10.1992 lineto
109.957 12.543 lineto
110.242 12.543 lineto
110.375 12.2422 lineto
110.508 12.4727 110.734 12.5859 111.043 12.5859 curveto
111.55899 12.5859 111.812 12.2734 111.812 11.6523 curveto
111.812 10.1992 lineto
 closepath fill
newpath 113.539 13.4297 moveto
113.609 13.4297 113.672 13.4023 113.71901 13.3516 curveto
113.77 13.3047 113.797 13.2422 113.797 13.1719 curveto
113.797 13.1016 113.77 13.0391 113.71901 12.9883 curveto
113.672 12.9414 113.609 12.9141 113.539 12.9141 curveto
113.46901 12.9141 113.41 12.9414 113.359 12.9883 curveto
113.30899 13.0391 113.28099 13.1016 113.28099 13.1719 curveto
113.28099 13.2422 113.30899 13.3047 113.359 13.3555 curveto
113.40599 13.4023 113.46901 13.4297 113.539 13.4297 curveto
 closepath fill
newpath 113.313 10.1992 moveto
113.313 12.1914 lineto
112.992 12.1914 lineto
112.992 12.543 lineto
113.72699 12.543 lineto
113.72699 10.1992 lineto
 closepath fill
newpath 115.53099 10.5742 moveto
116.832 10.5742 lineto
116.832 10.1992 lineto
114.883 10.1992 lineto
114.883 10.3086 lineto
116.211 12.1719 lineto
114.902 12.1719 lineto
114.902 12.543 lineto
116.81601 12.543 lineto
116.81601 12.4258 lineto
 closepath fill
newpath 121.82399 10.1992 moveto
121.60199 10.875 lineto
120.41 10.875 lineto
120.52301 11.1992 lineto
121.48 11.1992 lineto
121.02301 12.6094 lineto
120.52301 11.1992 lineto
120.41 10.875 lineto
120.172 10.1992 lineto
119.68399 10.1992 lineto
120.988 13.4492 lineto
121.10199 13.4492 lineto
122.30899 10.1992 lineto
 closepath fill
newpath 123.164 10.3398 moveto
123.30899 10.7344 lineto
123.543 10.582 123.72699 10.5039 123.867 10.5039 curveto
124.125 10.5039 124.258 10.6172 124.258 10.8281 curveto
124.258 10.9883 124.129 11.1172 123.883 11.2305 curveto
123.69101 11.3164 123.562 11.3828 123.496 11.4297 curveto
123.43 11.4727 123.375 11.5273 123.32399 11.582 curveto
123.27301 11.6406 123.238 11.7031 123.215 11.7656 curveto
123.19101 11.832 123.18 11.9023 123.18 11.9766 curveto
123.18 12.168 123.25 12.3164 123.387 12.4258 curveto
123.527 12.5312 123.711 12.5859 123.938 12.5859 curveto
124.105 12.5859 124.32 12.5312 124.586 12.4258 curveto
124.465 12.0391 lineto
124.30101 12.1719 124.133 12.2383 123.965 12.2383 curveto
123.867 12.2383 123.785 12.2148 123.715 12.168 curveto
123.64801 12.1211 123.617 12.0625 123.617 11.9922 curveto
123.617 11.8398 123.69899 11.7266 123.871 11.6484 curveto
124.168 11.5117 lineto
124.35199 11.4297 124.48 11.3359 124.56601 11.2305 curveto
124.64801 11.1211 124.688 10.9883 124.688 10.8281 curveto
124.688 10.6211 124.621 10.4531 124.46901 10.332 curveto
124.32399 10.2148 124.117 10.1562 123.855 10.1562 curveto
123.613 10.1562 123.379 10.2148 123.164 10.3398 curveto
 closepath fill
newpath 125.68 10.3398 moveto
125.828 10.7344 lineto
126.05899 10.582 126.246 10.5039 126.387 10.5039 curveto
126.645 10.5039 126.77 10.6172 126.77 10.8281 curveto
126.77 10.9883 126.64801 11.1172 126.39801 11.2305 curveto
126.211 11.3164 126.082 11.3828 126.016 11.4297 curveto
125.94899 11.4727 125.891 11.5273 125.84401 11.582 curveto
125.793 11.6406 125.758 11.7031 125.73 11.7656 curveto
125.707 11.832 125.695 11.9023 125.695 11.9766 curveto
125.695 12.168 125.766 12.3164 125.90599 12.4258 curveto
126.047 12.5312 126.23 12.5859 126.453 12.5859 curveto
126.625 12.5859 126.84 12.5312 127.098 12.4258 curveto
126.98 12.0391 lineto
126.81601 12.1719 126.652 12.2383 126.484 12.2383 curveto
126.387 12.2383 126.305 12.2148 126.234 12.168 curveto
126.168 12.1211 126.133 12.0625 126.133 11.9922 curveto
126.133 11.8398 126.21901 11.7266 126.391 11.6484 curveto
126.688 11.5117 lineto
126.867 11.4297 127 11.3359 127.086 11.2305 curveto
127.168 11.1211 127.207 10.9883 127.207 10.8281 curveto
127.207 10.6211 127.137 10.4531 126.988 10.332 curveto
126.84 10.2148 126.637 10.1562 126.375 10.1562 curveto
126.129 10.1562 125.89801 10.2148 125.68 10.3398 curveto
 closepath fill
newpath 128.195 11.3789 moveto
128.195 11.7383 128.297 12.0312 128.488 12.2539 curveto
128.68 12.4766 128.941 12.5859 129.258 12.5859 curveto
129.258 12.25 lineto
129.07 12.25 128.918 12.1719 128.805 12.0156 curveto
128.688 11.8594 128.637 11.6484 128.637 11.3789 curveto
128.637 11.3789 lineto
128.637 10.7891 128.844 10.4961 129.258 10.4961 curveto
129.453 10.4961 129.605 10.5781 129.715 10.7344 curveto
129.824 10.8906 129.879 11.1055 129.879 11.3789 curveto
129.879 11.957 129.672 12.25 129.258 12.25 curveto
129.258 12.5859 lineto
129.594 12.5859 129.855 12.4805 130.039 12.2656 curveto
130.223 12.0547 130.316 11.7578 130.316 11.3789 curveto
130.316 10.9961 130.223 10.7031 130.031 10.4805 curveto
129.844 10.2656 129.586 10.1562 129.258 10.1562 curveto
128.926 10.1562 128.664 10.2656 128.477 10.4844 curveto
128.289 10.707 128.195 11 128.195 11.3789 curveto
 closepath fill
newpath 133.227 12.3516 moveto
133.02 12.0586 lineto
132.977 12.1016 132.902 12.1445 132.797 12.1797 curveto
132.684 12.2188 132.582 12.2383 132.477 12.2383 curveto
132.254 12.2383 132.07 12.1562 131.938 12 curveto
131.805 11.8438 131.738 11.625 131.738 11.3516 curveto
131.738 11.0742 131.809 10.8672 131.941 10.7188 curveto
132.078 10.5781 132.266 10.5039 132.512 10.5039 curveto
132.695 10.5039 132.887 10.5781 133.074 10.7227 curveto
133.238 10.3711 lineto
133.016 10.2266 132.738 10.1562 132.406 10.1562 curveto
132.086 10.1562 131.824 10.2617 131.613 10.4766 curveto
131.406 10.6953 131.305 10.9844 131.305 11.3516 curveto
131.305 11.7227 131.41 12.0234 131.629 12.2461 curveto
131.844 12.4727 132.141 12.5859 132.516 12.5859 curveto
132.641 12.5859 132.766 12.5625 132.914 12.5117 curveto
133.055 12.457 133.156 12.4062 133.227 12.3516 curveto
 closepath fill
newpath 134.805 13.4297 moveto
134.879 13.4297 134.937 13.4023 134.988 13.3516 curveto
135.039 13.3047 135.062 13.2422 135.062 13.1719 curveto
135.062 13.1016 135.039 13.0391 134.988 12.9883 curveto
134.937 12.9414 134.879 12.9141 134.805 12.9141 curveto
134.738 12.9141 134.676 12.9414 134.625 12.9883 curveto
134.574 13.0391 134.551 13.1016 134.551 13.1719 curveto
134.551 13.2422 134.574 13.3047 134.625 13.3555 curveto
134.676 13.4023 134.734 13.4297 134.805 13.4297 curveto
 closepath fill
newpath 134.578 10.1992 moveto
134.578 12.1914 lineto
134.258 12.1914 lineto
134.258 12.543 lineto
134.992 12.543 lineto
134.992 10.1992 lineto
 closepath fill
newpath 137.684 10.4688 moveto
137.516 10.2578 137.262 10.1562 136.922 10.1562 curveto
136.734 10.1562 136.578 10.2227 136.437 10.3555 curveto
136.309 10.4922 136.234 10.6562 136.234 10.8555 curveto
136.234 11.0938 136.344 11.293 136.551 11.457 curveto
136.758 11.6211 137.023 11.7031 137.348 11.7031 curveto
137.434 11.7031 137.531 11.6836 137.645 11.6484 curveto
137.645 11.3516 lineto
137.512 11.3828 137.422 11.3945 137.367 11.3945 curveto
137.156 11.3945 136.988 11.3438 136.855 11.2344 curveto
136.723 11.1211 136.656 10.9961 136.656 10.8516 curveto
136.656 10.6094 136.801 10.4844 137.086 10.4844 curveto
137.297 10.4844 137.48 10.582 137.645 10.7852 curveto
137.645 11.3516 lineto
137.645 11.6484 lineto
137.645 12.0273 137.473 12.2148 137.137 12.2148 curveto
136.879 12.2148 136.676 12.1445 136.535 12.0039 curveto
136.359 12.3516 lineto
136.437 12.418 136.551 12.4727 136.684 12.5156 curveto
136.828 12.5625 136.961 12.5859 137.09 12.5859 curveto
137.426 12.5859 137.676 12.5078 137.828 12.3555 curveto
137.98 12.1992 138.059 11.957 138.059 11.6172 curveto
138.059 10.7773 lineto
138.059 10.5742 138.117 10.4336 138.242 10.3711 curveto
138.242 10.1562 lineto
138.074 10.1562 137.945 10.1797 137.863 10.2305 curveto
137.777 10.2773 137.719 10.3555 137.684 10.4688 curveto
 closepath fill
newpath 139.566 12.2148 moveto
139.289 12.2148 lineto
139.289 12.543 lineto
139.566 12.543 lineto
139.566 13.0312 lineto
139.98 13.1914 lineto
139.98 12.543 lineto
140.625 12.543 lineto
140.625 12.2148 lineto
139.98 12.2148 lineto
139.98 11.0547 lineto
139.98 10.8555 140.016 10.7109 140.078 10.6289 curveto
140.148 10.5469 140.254 10.5039 140.398 10.5039 curveto
140.508 10.5039 140.617 10.5352 140.73 10.5859 curveto
140.793 10.2188 lineto
140.621 10.1758 140.434 10.1562 140.227 10.1562 curveto
140.039 10.1562 139.887 10.2227 139.754 10.3594 curveto
139.629 10.5 139.566 10.6719 139.566 10.8828 curveto
 closepath fill
newpath 142.324 13.4297 moveto
142.395 13.4297 142.457 13.4023 142.508 13.3516 curveto
142.559 13.3047 142.582 13.2422 142.582 13.1719 curveto
142.582 13.1016 142.559 13.0391 142.508 12.9883 curveto
142.457 12.9414 142.395 12.9141 142.324 12.9141 curveto
142.254 12.9141 142.195 12.9414 142.145 12.9883 curveto
142.094 13.0391 142.066 13.1016 142.066 13.1719 curveto
142.066 13.2422 142.094 13.3047 142.145 13.3555 curveto
142.191 13.4023 142.25 13.4297 142.324 13.4297 curveto
 closepath fill
newpath 142.098 10.1992 moveto
142.098 12.1914 lineto
141.777 12.1914 lineto
141.777 12.543 lineto
142.512 12.543 lineto
142.512 10.1992 lineto
 closepath fill
newpath 143.727 11.3789 moveto
143.727 11.7383 143.82 12.0312 144.016 12.2539 curveto
144.211 12.4766 144.469 12.5859 144.785 12.5859 curveto
144.785 12.25 lineto
144.598 12.25 144.445 12.1719 144.332 12.0156 curveto
144.219 11.8594 144.156 11.6484 144.156 11.3789 curveto
144.156 11.3789 lineto
144.156 10.7891 144.371 10.4961 144.785 10.4961 curveto
144.98 10.4961 145.129 10.5781 145.238 10.7344 curveto
145.352 10.8906 145.406 11.1055 145.406 11.3789 curveto
145.406 11.957 145.199 12.25 144.785 12.25 curveto
144.785 12.5859 lineto
145.121 12.5859 145.379 12.4805 145.566 12.2656 curveto
145.75 12.0547 145.844 11.7578 145.844 11.3789 curveto
145.844 10.9961 145.746 10.7031 145.559 10.4805 curveto
145.367 10.2656 145.109 10.1562 144.785 10.1562 curveto
144.449 10.1562 144.191 10.2656 144.004 10.4844 curveto
143.816 10.707 143.727 11 143.727 11.3789 curveto
 closepath fill
newpath 148.426 10.1992 moveto
148.426 11.5625 lineto
148.426 11.8125 148.387 11.9883 148.312 12.0859 curveto
148.238 12.1875 148.113 12.2383 147.937 12.2383 curveto
147.84 12.2383 147.738 12.207 147.641 12.1523 curveto
147.531 12.0938 147.453 12.0234 147.402 11.9414 curveto
147.402 10.1992 lineto
146.984 10.1992 lineto
146.984 12.543 lineto
147.266 12.543 lineto
147.402 12.2422 lineto
147.535 12.4727 147.762 12.5859 148.07 12.5859 curveto
148.586 12.5859 148.84 12.2734 148.84 11.6523 curveto
148.84 10.1992 lineto
 closepath fill
 0.0941 0.0941 0.0941 setrgbcolor
newpath 147.855 18.1953 moveto
148.301 17.8281 148.746 17.25 150.344 18.7461 curveto
151.941 20.2383 151.125 19.6094 151.992 17.6445 curveto
152.859 15.6797 153.406 16.7617 153.461 17.1445 curveto
153.594 18.1055 153.301 19.9883 153.102 20.75 curveto
152.93 21.3906 151.828 21.71089 151.391 21.3906 curveto
150.973 21.0898 149.871 19.8477 149.137 19.6094 curveto
148.406 19.375 148.988 20.082 148.805 21.2578 curveto
148.621 22.4414 148.187 22.97661 147.727 22.7773 curveto
147.414 22.6445 146.734 21.9453 146.414 22.1289 curveto
145.793 22.4727 145.363 23.9727 142.328 22.3047 curveto
138.789 20.3711 141.961 24.7695 141.961 24.7695 curveto
141.961 24.7695 144.32 27.9922 142.902 30.3242 curveto
141.488 32.6562 138.449 27.6523 138.449 27.6523 curveto
138.449 27.6523 136.852 24.4805 136.145 21.1289 curveto
135.438 17.77339 133.992 18.1523 133.453 18.875 curveto
132.867 19.64839 133.027 22.7031 130.934 21.418 curveto
128.84 20.1328 128.863 17.5664 127.605 20.4727 curveto
126.348 23.3828 125.027 21.5117 124.85199 21.207 curveto
124.617 20.7773 124.742 19.8398 124.383 19.6367 curveto
123.98 19.4062 123.48 20.2305 123.18 20.3438 curveto
122.85199 20.4648 120.734 18.4883 119.77301 16.6523 curveto
118.391 14.0117 116.164 20.3633 116.379 20.7617 curveto
116.57 21.1094 121.984 28.6055 122.496 29.6953 curveto
123.027 30.8281 123.805 31.16411 124.19899 31.2148 curveto
124.59 31.2695 129.598 32.1055 133.215 35.9297 curveto
136.828 39.7539 136.273 40.6992 134.547 41.668 curveto
134.445 40.4844 lineto
134.852 40.0156 134.883 38.91411 134.012 38.043 curveto
133.137 37.16411 130.258 34.22661 128.457 33.4883 curveto
126.746 32.7852 120.879 29.9883 126.73 35.3398 curveto
126.73 35.3398 lineto
131.668 39.8555 131.527 39.7344 131.926 39.8945 curveto
132.398 40.0781 134.113 40.8672 134.445 40.4844 curveto
134.547 41.668 lineto
132.82 42.6367 127.891 37.8125 127.65599 37.6367 curveto
127.488 37.5039 123.414 32.918 123.125 32.3438 curveto
122.836 31.7656 116.129 32.1328 116.129 32.1328 curveto
115.35199 31.75 116.215 31.4336 116.215 31.4336 curveto
116.215 31.4336 119.223 30.9961 121.10199 31.0469 curveto
122.97699 31.0977 121.738 30.0039 121.52 29.7383 curveto
120.062 28.0156 117.32399 23.332 116.34 22.35161 curveto
115.367 21.3789 113.496 22.4648 113.387 22.4844 curveto
113.277 22.5039 110.48 22.9219 111.047 20.78911 curveto
111.613 18.6523 113.313 19.60161 114.133 19.39839 curveto
113.211 20.08589 lineto
113.039 20.0117 112.543 20.4375 112.562 20.6562 curveto
112.598 21.0938 113.047 20.6445 113.57 20.6562 curveto
114.09401 20.6719 113.39801 20.16411 113.211 20.08589 curveto
113.211 20.08589 lineto
114.133 19.39839 lineto
114.383 19.33589 114.742 18.89839 114.879 18.6758 curveto
115.293 18.0156 115.492 16.9648 115.92601 16.3164 curveto
116.56601 15.3672 118.992 13.0078 120.871 16.41411 curveto
122.82 19.9531 124.05899 18.6289 124.16 16.6992 curveto
124.262 14.7695 124.883 15.4922 125.57399 15.8008 curveto
126.27 16.1055 125.68 17.4414 125.754 19.1953 curveto
125.832 20.9414 127.27 18.418 127.168 17.72661 curveto
127.06601 17.0312 128.145 17.1602 129.102 17.5469 curveto
130.051 17.9297 129.305 18.5273 130.613 19.7344 curveto
131.926 20.9414 131.992 18.10161 132.34 17.4414 curveto
132.613 16.9102 133.984 15.8008 134.68 17.28911 curveto
135.371 18.7812 136.461 18.46089 136.227 16.9375 curveto
137.168 17.1367 lineto
136.684 18.9102 137.945 20.4023 137.945 20.4023 curveto
137.945 20.4023 138.477 21.1211 138.816 21.0898 curveto
137.969 21.4531 lineto
137.555 20.9922 137.199 20.6328 137.531 21.9219 curveto
137.867 23.207 137.75 22.66411 137.957 23.1445 curveto
138.156 23.6133 139.059 26 139.125 26.1836 curveto
139.164 26.2969 139.953 27.8438 140.766 29.0156 curveto
140.766 29.0156 142.934 30.9336 142.059 27.4727 curveto
141.473 25.1523 140.812 24.89839 139.75 23.2305 curveto
139.75 23.2305 lineto
139.543 22.9102 139.184 23.6562 138.453 22.72661 curveto
138.152 22.3398 138.344 21.8672 137.969 21.4531 curveto
138.816 21.0898 lineto
139.234 21.0508 140.074 20.91411 139.793 19.8867 curveto
139.793 19.8867 lineto
139.512 18.8594 139.094 17.1562 138.621 16.7188 curveto
138.207 16.33589 137.656 15.3633 137.168 17.1367 curveto
136.227 16.9375 lineto
135.984 15.418 137.293 14.8242 137.719 14.8398 curveto
138.117 14.8633 140.414 16.125 140.438 18.668 curveto
140.469 21.207 142.285 21.1914 142.59 21.2344 curveto
142.895 21.27339 145.234 21.6523 145.027 20.9727 curveto
144.816 20.293 143.77 18.3281 144.973 18.35161 curveto
146.176 18.3789 145.68 19.4258 146.805 20.6055 curveto
147.934 21.7812 147.406 18.5586 147.855 18.1953 curveto
 closepath fill
newpath 133.355 28.9375 moveto
133.195 27.2344 134.242 27.7852 134.242 27.7852 curveto
136.195 28.78911 134.652 29.7227 134.652 29.7227 curveto
134.652 29.7227 133.516 30.6406 133.355 28.9375 curveto
 closepath fill
newpath 161.832 13.7148 moveto
161.73 13.9883 161.527 14.3555 160.715 13.3555 curveto
159.465 11.8242 159.637 12.7891 159.52 13.793 curveto
159.5 13.9609 159.621 14.418 158.762 15.1445 curveto
158.316 15.5234 156.234 16.10161 156.703 16.5781 curveto
157.902 17.793 157.59 17.6758 158.023 18.2148 curveto
158.461 18.7539 160.082 20.35161 160.008 22.6133 curveto
159.93 24.875 156.664 24.6719 156.664 24.6719 curveto
154.527 24.2852 155.426 22.332 156.973 22.46089 curveto
158.41 22.582 158.219 21.3711 158.109 20.9805 curveto
158.109 20.9805 lineto
158.102 20.9531 158.094 20.9297 158.09 20.9102 curveto
158.109 20.9805 lineto
158.109 20.9805 lineto
158.109 20.97661 157.93 20.5117 157.574 19.9492 curveto
157.098 19.1953 156.508 18.1094 155.941 17.5625 curveto
155.629 17.2617 153.98 16.21089 155.168 15.6211 curveto
157.152 14.6367 158.641 12.5586 157.871 11.4023 curveto
157.102 10.2422 151.031 7.94531 149.773 7.39063 curveto
148.551 6.85547 146.145 6.69922 146.195 3.5625 curveto
146.246 0.42188 149.594 0.44922 151.055 0.83203 curveto
150.836 1.72266 lineto
148.418 1.38672 147.098 2.78516 147.121 3.63672 curveto
147.148 4.48438 147.941 5.59375 150.582 6.90625 curveto
156.523 9.84766 157.047 10.0742 157.047 10.0742 curveto
157.473 10.2422 158.391 10.7891 157.852 9.88281 curveto
157.852 9.88281 lineto
157.852 9.88281 155.488 5.32422 155.223 4.92188 curveto
154.902 4.42969 153.254 2.0586 150.836 1.72266 curveto
151.055 0.83203 lineto
153.617 1.5039 154.687 2.5 155.66 3.61328 curveto
156.691 4.78516 158.742 9.44531 158.797 9.4961 curveto
158.848 9.55078 159.52 12.25 160.699 12.5586 curveto
161.883 12.8672 161.973 13.3125 161.832 13.7148 curveto
 closepath fill
newpath 155.703 27.957 moveto
155.102 28.207 153.309 27.2773 153.844 25.72661 curveto
154.395 24.14839 158.469 26.8164 155.703 27.957 curveto
 closepath fill
newpath 101.65599 41.6211 moveto
100.93399 41.6211 lineto
100.109 39.543 lineto
99.3594 41.6211 lineto
98.5977 41.6211 lineto
98.5977 41.52339 lineto
98.66411 41.5 98.707 41.4844 98.7383 41.4688 curveto
98.7617 41.4531 98.7852 41.4336 98.8008 41.4062 curveto
98.8164 41.3867 98.8281 41.35161 98.83589 41.3008 curveto
98.8438 41.2578 98.8477 41.1914 98.8477 41.08589 curveto
98.8477 39.2383 lineto
98.8477 39.1328 98.8438 39.0547 98.832 39.0039 curveto
98.8242 38.9531 98.8047 38.91411 98.77339 38.8867 curveto
98.7461 38.8594 98.6875 38.832 98.5977 38.8125 curveto
98.5977 38.707 lineto
99.375 38.707 lineto
99.375 38.8125 lineto
99.3125 38.8281 99.2656 38.8438 99.2344 38.8633 curveto
99.207 38.8789 99.1836 38.9023 99.168 38.9258 curveto
99.1523 38.9531 99.1445 38.9883 99.1367 39.0312 curveto
99.1289 39.0742 99.125 39.1445 99.125 39.2383 curveto
99.125 40.02339 lineto
99.125 40.2617 99.125 40.4961 99.1172 40.72661 curveto
99.1094 40.9531 99.1055 41.1094 99.0977 41.1953 curveto
99.1328 41.1953 lineto
99.918 39.0469 lineto
100.164 39.0469 lineto
101.012 41.16411 lineto
101.047 41.16411 lineto
101.039 41.082 101.03099 40.9297 101.02301 40.71089 curveto
101.02 40.4922 101.016 40.27339 101.016 40.0586 curveto
101.016 39.2383 lineto
101.016 39.125 101.008 39.043 100.996 38.9922 curveto
100.988 38.9414 100.965 38.9062 100.93399 38.8789 curveto
100.902 38.8555 100.848 38.832 100.766 38.8125 curveto
100.766 38.707 lineto
101.65599 38.707 lineto
101.65599 38.8125 lineto
101.59 38.8281 101.543 38.8438 101.52 38.8633 curveto
101.484 38.8789 101.465 38.9023 101.44899 38.9258 curveto
101.438 38.9531 101.422 38.9883 101.414 39.0312 curveto
101.41 39.0742 101.40599 39.1445 101.40599 39.2383 curveto
101.40599 41.08589 lineto
101.40599 41.1914 101.41 41.2578 101.418 41.3086 curveto
101.42601 41.3555 101.44101 41.3906 101.453 41.4102 curveto
101.47699 41.4375 101.492 41.4531 101.52301 41.4727 curveto
101.547 41.4844 101.598 41.5 101.65599 41.52339 curveto
 closepath fill
newpath 103.703 39.207 moveto
103.609 39.1094 103.516 39.03911 103.422 38.9961 curveto
103.328 38.9531 103.22699 38.9297 103.109 38.9297 curveto
102.96901 38.9297 102.859 38.96089 102.77301 39.0273 curveto
102.688 39.0938 102.621 39.1836 102.586 39.2969 curveto
102.547 39.4102 102.527 39.5508 102.527 39.7188 curveto
102.527 39.7578 lineto
103.875 39.7578 lineto
103.871 39.9531 103.85199 40.1094 103.81601 40.2305 curveto
103.785 40.35161 103.738 40.4492 103.67601 40.5312 curveto
103.617 40.6094 103.535 40.6719 103.43399 40.7148 curveto
103.332 40.7617 103.211 40.7852 103.06601 40.7852 curveto
103.047 40.6172 lineto
103.145 40.6172 103.223 40.5898 103.28099 40.53911 curveto
103.34 40.4844 103.387 40.4102 103.414 40.3125 curveto
103.445 40.2148 103.465 40.0898 103.473 39.9375 curveto
102.539 39.9375 lineto
102.555 40.1523 102.605 40.3203 102.695 40.4414 curveto
102.78099 40.5586 102.89801 40.6172 103.047 40.6172 curveto
103.06601 40.7852 lineto
102.883 40.7852 102.723 40.7422 102.582 40.6523 curveto
102.438 40.5625 102.332 40.4375 102.254 40.2773 curveto
102.18 40.1133 102.141 39.9258 102.141 39.7148 curveto
102.141 39.3711 102.215 39.1133 102.363 38.9375 curveto
102.516 38.7578 102.734 38.6719 103.027 38.6719 curveto
103.141 38.6719 103.238 38.6875 103.328 38.7188 curveto
103.422 38.75 103.504 38.78911 103.582 38.8438 curveto
103.65599 38.89839 103.742 38.9727 103.832 39.0703 curveto
 closepath fill
newpath 104.859 40.7695 moveto
104.73 40.7695 lineto
104.23 40.7461 lineto
104.23 40.6328 lineto
104.293 40.625 104.34401 40.6094 104.379 40.5938 curveto
104.41 40.5781 104.438 40.5508 104.457 40.5195 curveto
104.473 40.4844 104.484 40.4414 104.484 40.3828 curveto
104.488 40.3281 104.488 40.2539 104.488 40.16411 curveto
104.488 39.2344 lineto
104.488 39.1328 104.484 39.0625 104.47699 39.0117 curveto
104.46901 38.9648 104.457 38.9297 104.438 38.9102 curveto
104.422 38.8867 104.402 38.8672 104.379 38.8555 curveto
104.355 38.8438 104.31601 38.8281 104.262 38.8125 curveto
104.262 38.707 lineto
105.098 38.707 lineto
105.098 38.8125 lineto
105.047 38.8242 105.008 38.8398 104.98 38.85161 curveto
104.953 38.8672 104.93399 38.8789 104.918 38.8945 curveto
104.90599 38.9102 104.895 38.9297 104.883 38.9531 curveto
104.875 38.97661 104.867 39.0117 104.863 39.0547 curveto
104.859 39.0977 104.855 39.1602 104.855 39.2383 curveto
104.855 40.03911 lineto
104.855 40.1055 104.871 40.16411 104.89801 40.2148 curveto
104.92601 40.2695 104.965 40.3242 105.02 40.3711 curveto
105.07 40.4219 105.125 40.46089 105.17601 40.4883 curveto
105.22699 40.5117 105.28099 40.5273 105.34 40.5273 curveto
105.379 40.5273 105.418 40.52339 105.44899 40.5117 curveto
105.488 40.5039 105.516 40.4961 105.535 40.4805 curveto
105.56601 40.4648 105.582 40.4414 105.613 40.4102 curveto
105.637 40.3789 105.652 40.3398 105.664 40.293 curveto
105.68399 40.2461 105.695 40.1797 105.69899 40.10161 curveto
105.707 40.0195 105.715 39.918 105.715 39.78911 curveto
105.715 39.2305 lineto
105.715 39.1328 105.703 39.0625 105.695 39.0156 curveto
105.69101 38.9688 105.67601 38.9297 105.65599 38.9102 curveto
105.645 38.8867 105.621 38.8672 105.60199 38.8555 curveto
105.57 38.8438 105.53099 38.8281 105.48 38.8125 curveto
105.48 38.707 lineto
106.32 38.707 lineto
106.32 38.8125 lineto
106.254 38.8281 106.211 38.8438 106.18399 38.8594 curveto
106.15599 38.8789 106.137 38.89839 106.121 38.918 curveto
106.109 38.9414 106.098 38.97661 106.09 39.0156 curveto
106.082 39.0547 106.082 39.1328 106.082 39.2383 curveto
106.082 40.0195 lineto
106.082 40.0938 106.09401 40.1562 106.117 40.2148 curveto
106.145 40.2695 106.188 40.3242 106.242 40.375 curveto
106.30101 40.4297 106.355 40.4688 106.402 40.4922 curveto
106.453 40.5156 106.508 40.5273 106.562 40.5273 curveto
106.617 40.5273 106.66 40.5195 106.695 40.5078 curveto
106.72699 40.4961 106.754 40.4805 106.777 40.46089 curveto
106.805 40.4414 106.82399 40.418 106.84401 40.3906 curveto
106.863 40.3633 106.879 40.3281 106.895 40.2812 curveto
106.90599 40.2344 106.918 40.168 106.922 40.0898 curveto
106.93 40.0117 106.93399 39.91411 106.93399 39.78911 curveto
106.93399 39.2305 lineto
106.93399 39.1328 106.93 39.0625 106.918 39.0156 curveto
106.91 38.9688 106.89801 38.9297 106.879 38.9102 curveto
106.863 38.8867 106.84401 38.8672 106.82 38.8555 curveto
106.797 38.8438 106.754 38.8281 106.69899 38.8125 curveto
106.69899 38.707 lineto
107.539 38.707 lineto
107.539 38.8125 lineto
107.47699 38.8281 107.43 38.8438 107.402 38.8594 curveto
107.375 38.8789 107.355 38.89839 107.34 38.918 curveto
107.328 38.9414 107.31601 38.97661 107.312 39.0156 curveto
107.305 39.0547 107.30101 39.1328 107.30101 39.2383 curveto
107.30101 40.0469 lineto
107.30101 40.1914 107.289 40.3086 107.266 40.3945 curveto
107.246 40.4844 107.211 40.5547 107.164 40.6133 curveto
107.113 40.668 107.05899 40.71089 106.988 40.7422 curveto
106.918 40.7695 106.836 40.7812 106.742 40.7812 curveto
106.66 40.7812 106.586 40.7695 106.52 40.7422 curveto
106.44899 40.71089 106.379 40.6719 106.31601 40.6211 curveto
106.246 40.5703 106.16 40.4922 106.055 40.3828 curveto
106.02 40.5195 105.957 40.6172 105.867 40.6836 curveto
105.78099 40.75 105.66 40.7812 105.52 40.7812 curveto
105.473 40.7812 105.42601 40.7773 105.379 40.7656 curveto
105.336 40.7539 105.285 40.7344 105.238 40.707 curveto
105.18399 40.6836 105.129 40.64839 105.07399 40.6055 curveto
105.02 40.5625 104.94899 40.4961 104.867 40.4102 curveto
104.836 40.418 lineto
 closepath fill
newpath 108.44101 41.7656 moveto
108.31601 41.7656 lineto
107.797 41.7461 lineto
107.797 41.6328 lineto
107.871 41.6172 107.922 41.6094 107.94899 41.5938 curveto
107.97699 41.5781 108 41.5664 108.016 41.53911 curveto
108.03099 41.52339 108.043 41.4883 108.055 41.4531 curveto
108.062 41.41411 108.06601 41.3672 108.07 41.3164 curveto
108.07399 41.2578 108.07399 41.16411 108.07399 41.0273 curveto
108.07399 38.707 lineto
108.223 38.6719 lineto
108.371 38.8008 lineto
108.473 38.7539 108.57 38.7188 108.664 38.6992 curveto
108.758 38.6797 108.855 38.6719 108.961 38.6719 curveto
109.152 38.6719 109.31601 38.71089 109.44899 38.793 curveto
109.59 38.875 109.695 38.9961 109.766 39.1562 curveto
109.836 39.3164 109.871 39.5156 109.871 39.7461 curveto
109.871 39.9727 109.84 40.1602 109.78099 40.3164 curveto
109.723 40.4727 109.641 40.58589 109.53099 40.66411 curveto
109.418 40.7422 109.285 40.7812 109.133 40.7812 curveto
109.05101 40.7812 108.973 40.7695 108.902 40.7461 curveto
108.832 40.7188 108.766 40.6836 108.69899 40.6367 curveto
108.633 40.5898 108.547 40.5156 108.44899 40.4102 curveto
108.605 40.3711 lineto
108.66 40.4258 108.715 40.4648 108.77301 40.4883 curveto
108.832 40.5117 108.89801 40.5273 108.98 40.5273 curveto
109.145 40.5273 109.27 40.4531 109.34401 40.3125 curveto
109.43 40.1719 109.46901 39.96089 109.46901 39.6758 curveto
109.46901 39.39839 109.422 39.1914 109.332 39.0508 curveto
109.246 38.9102 109.117 38.8398 108.94899 38.8398 curveto
108.875 38.8398 108.81601 38.8477 108.758 38.8594 curveto
108.703 38.875 108.652 38.89839 108.609 38.9336 curveto
108.562 38.9688 108.53099 39.0078 108.504 39.0508 curveto
108.484 39.0938 108.465 39.14839 108.457 39.2148 curveto
108.445 39.2773 108.44101 39.3672 108.44101 39.47661 curveto
108.44101 40.03911 lineto
108.44101 40.1055 108.453 40.16411 108.48 40.2148 curveto
108.508 40.2695 108.547 40.3203 108.605 40.3711 curveto
108.44899 40.4102 lineto
108.44101 40.41411 lineto
 closepath fill
newpath 111.875 39.207 moveto
111.785 39.1094 111.69101 39.03911 111.598 38.9961 curveto
111.504 38.9531 111.39801 38.9297 111.285 38.9297 curveto
111.145 38.9297 111.03099 38.96089 110.945 39.0273 curveto
110.859 39.0938 110.797 39.1836 110.762 39.2969 curveto
110.723 39.4102 110.703 39.5508 110.703 39.7188 curveto
110.703 39.7578 lineto
112.05101 39.7578 lineto
112.047 39.9531 112.027 40.1094 111.992 40.2305 curveto
111.961 40.35161 111.914 40.4492 111.85199 40.5312 curveto
111.793 40.6094 111.711 40.6719 111.609 40.7148 curveto
111.508 40.7617 111.387 40.7852 111.242 40.7852 curveto
111.223 40.6172 lineto
111.31601 40.6172 111.39801 40.5898 111.457 40.53911 curveto
111.516 40.4844 111.562 40.4102 111.59 40.3125 curveto
111.621 40.2148 111.641 40.0898 111.64801 39.9375 curveto
110.715 39.9375 lineto
110.73 40.1523 110.78099 40.3203 110.871 40.4414 curveto
110.957 40.5586 111.07399 40.6172 111.223 40.6172 curveto
111.242 40.7852 lineto
111.05899 40.7852 110.89801 40.7422 110.754 40.6523 curveto
110.613 40.5625 110.504 40.4375 110.43 40.2773 curveto
110.355 40.1133 110.31601 39.9258 110.31601 39.7148 curveto
110.31601 39.3711 110.391 39.1133 110.539 38.9375 curveto
110.69101 38.7578 110.91 38.6719 111.203 38.6719 curveto
111.312 38.6719 111.414 38.6875 111.504 38.7188 curveto
111.59401 38.75 111.68 38.78911 111.754 38.8438 curveto
111.832 38.89839 111.914 38.9727 112.008 39.0703 curveto
 closepath fill
newpath 113.039 40.7695 moveto
112.90599 40.7695 lineto
112.40599 40.7461 lineto
112.40599 40.6328 lineto
112.46901 40.625 112.52 40.6094 112.55101 40.5938 curveto
112.586 40.5781 112.613 40.5508 112.629 40.5195 curveto
112.64801 40.4844 112.65599 40.4414 112.66 40.3828 curveto
112.664 40.3281 112.664 40.2539 112.664 40.16411 curveto
112.664 39.2344 lineto
112.664 39.1328 112.66 39.0625 112.652 39.0117 curveto
112.645 38.9648 112.629 38.9297 112.613 38.9102 curveto
112.598 38.8867 112.578 38.8672 112.55101 38.8555 curveto
112.53099 38.8438 112.492 38.8281 112.438 38.8125 curveto
112.438 38.707 lineto
113.297 38.707 lineto
113.297 38.8125 lineto
113.23 38.8242 113.168 38.8398 113.133 38.8633 curveto
113.098 38.8867 113.07399 38.9219 113.055 38.9727 curveto
113.039 39.02339 113.035 39.1094 113.035 39.2383 curveto
113.035 39.9883 lineto
113.035 40.0547 113.043 40.1172 113.05899 40.16411 curveto
113.078 40.2148 113.113 40.2695 113.16 40.3242 curveto
113.203 40.3828 113.25 40.4258 113.30101 40.4531 curveto
113.355 40.4844 113.40599 40.5 113.457 40.5 curveto
113.527 40.5 113.578 40.4844 113.617 40.4492 curveto
113.65599 40.41411 113.69101 40.3555 113.72699 40.2812 curveto
113.96901 40.2812 lineto
113.96901 40.77339 lineto
113.902 40.7812 113.82399 40.7852 113.742 40.7852 curveto
113.645 40.7852 113.555 40.7695 113.48 40.7383 curveto
113.402 40.71089 113.328 40.668 113.258 40.6133 curveto
113.195 40.5586 113.121 40.4844 113.039 40.3867 curveto
113.012 40.3945 lineto
 closepath fill
newpath 116.64801 38.793 moveto
116.793 38.8711 116.91 38.9961 116.988 39.1562 curveto
117.06601 39.3203 117.105 39.5195 117.105 39.7539 curveto
117.105 40.08589 117.027 40.3398 116.871 40.5195 curveto
116.711 40.6953 116.48 40.7852 116.172 40.7852 curveto
116.164 40.6172 lineto
116.266 40.6172 116.359 40.582 116.438 40.5195 curveto
116.52 40.4531 116.582 40.35161 116.629 40.2148 curveto
116.672 40.0742 116.703 39.9023 116.703 39.6914 curveto
116.703 39.582 116.688 39.4727 116.668 39.3711 curveto
116.652 39.2656 116.625 39.1758 116.578 39.0977 curveto
116.535 39.0195 116.484 38.957 116.414 38.9102 curveto
116.348 38.8633 116.266 38.8398 116.172 38.8398 curveto
115.996 38.8398 115.863 38.918 115.77301 39.0781 curveto
115.68 39.2344 115.633 39.46089 115.633 39.7539 curveto
115.633 40.0273 115.67601 40.2422 115.77 40.3906 curveto
115.77 40.3906 lineto
115.859 40.53911 115.992 40.6172 116.164 40.6172 curveto
116.172 40.7852 lineto
115.992 40.7852 115.828 40.7461 115.688 40.66411 curveto
115.543 40.58589 115.43399 40.4648 115.35199 40.3047 curveto
115.27 40.1406 115.22699 39.9414 115.22699 39.707 curveto
115.22699 39.3672 115.305 39.1094 115.461 38.9336 curveto
115.617 38.7578 115.84401 38.6719 116.141 38.6719 curveto
116.336 38.6719 116.508 38.71089 116.64801 38.793 curveto
 closepath fill
newpath 118.633 40.7461 moveto
118.125 40.7461 lineto
118.125 40.9727 lineto
118.125 41.082 118.129 41.168 118.137 41.2383 curveto
118.145 41.3086 118.16 41.3594 118.18 41.4062 curveto
118.19899 41.4531 118.223 41.4883 118.25 41.5195 curveto
118.277 41.5469 118.305 41.5664 118.34 41.5742 curveto
118.371 41.5898 118.41 41.5977 118.457 41.5977 curveto
118.52 41.5977 118.57399 41.5781 118.609 41.5469 curveto
118.645 41.5117 118.67601 41.4453 118.703 41.3633 curveto
118.914 41.3633 lineto
118.914 41.7539 lineto
118.836 41.7695 118.742 41.7773 118.629 41.7773 curveto
118.5 41.7773 118.391 41.7617 118.297 41.7344 curveto
118.19899 41.707 118.113 41.6562 118.027 41.5898 curveto
117.945 41.52339 117.883 41.4414 117.84 41.3398 curveto
117.793 41.2422 117.766 41.1172 117.754 40.96089 curveto
117.75 40.89839 117.742 40.8438 117.73 40.8086 curveto
117.723 40.77339 117.711 40.7461 117.69899 40.72661 curveto
117.688 40.707 117.672 40.6953 117.65599 40.6836 curveto
117.641 40.6719 117.625 40.668 117.605 40.6602 curveto
117.586 40.6562 117.55101 40.64839 117.496 40.6406 curveto
117.496 40.5312 lineto
117.758 40.5312 lineto
117.758 39.2383 lineto
117.758 39.1406 117.754 39.0703 117.746 39.02339 curveto
117.738 38.9805 117.72699 38.9453 117.711 38.918 curveto
117.69899 38.8945 117.67601 38.875 117.64801 38.8594 curveto
117.621 38.8438 117.578 38.8281 117.516 38.8125 curveto
117.516 38.707 lineto
118.387 38.707 lineto
118.387 38.8125 lineto
118.32399 38.8242 118.277 38.8398 118.25 38.8555 curveto
118.21901 38.8711 118.195 38.8906 118.18 38.91411 curveto
118.16 38.9414 118.145 38.97661 118.137 39.02339 curveto
118.129 39.0742 118.125 39.1445 118.125 39.2383 curveto
118.125 40.5312 lineto
118.633 40.5312 lineto
 closepath fill
newpath 119.973 40.6445 moveto
120.043 40.6562 120.10199 40.6758 120.145 40.707 curveto
120.19101 40.7344 120.223 40.7695 120.25 40.8164 curveto
120.27301 40.8594 120.293 40.918 120.305 40.9844 curveto
120.32 41.0508 120.336 41.1523 120.35199 41.2812 curveto
120.66 41.2812 lineto
120.66 40.7539 lineto
121.348 40.7539 lineto
121.348 40.5352 lineto
120.66 40.5352 lineto
120.66 39.58589 lineto
120.66 39.4492 120.664 39.33589 120.672 39.2578 curveto
120.68399 39.1758 120.711 39.1094 120.742 39.0625 curveto
120.766 39.0195 120.805 38.9844 120.84401 38.9648 curveto
120.883 38.9453 120.93399 38.9336 121 38.9336 curveto
121.055 38.9336 121.109 38.9453 121.16 38.9688 curveto
121.211 38.9922 121.254 39.0273 121.30899 39.0703 curveto
121.40599 38.957 lineto
121.305 38.8594 121.207 38.7852 121.117 38.7422 curveto
121.027 38.6992 120.93 38.6758 120.836 38.6758 curveto
120.64801 38.6758 120.512 38.7305 120.422 38.8398 curveto
120.332 38.9492 120.289 39.1211 120.289 39.35161 curveto
120.289 40.5352 lineto
119.973 40.5352 lineto
 closepath fill
newpath 122.15599 40.418 moveto
122.164 40.41411 lineto
122.277 40.5273 122.363 40.6055 122.43 40.6523 curveto
122.492 40.6953 122.55899 40.7305 122.621 40.7539 curveto
122.68399 40.77339 122.754 40.7852 122.82399 40.7852 curveto
122.902 40.7852 122.973 40.7773 123.035 40.7578 curveto
123.09401 40.7383 123.14801 40.71089 123.195 40.6758 curveto
123.242 40.6367 123.28099 40.5898 123.30899 40.5352 curveto
123.34 40.4805 123.359 40.41411 123.375 40.3398 curveto
123.387 40.2617 123.395 40.168 123.395 40.0508 curveto
123.395 39.2422 lineto
123.395 39.1211 123.39801 39.0352 123.41 38.9922 curveto
123.422 38.9453 123.44101 38.9102 123.46901 38.8867 curveto
123.496 38.8633 123.55101 38.8398 123.637 38.8164 curveto
123.637 38.71089 lineto
122.797 38.71089 lineto
122.797 38.8164 lineto
122.85199 38.832 122.891 38.8477 122.914 38.8594 curveto
122.938 38.8711 122.961 38.8906 122.97699 38.91411 curveto
122.992 38.9375 123.004 38.9727 123.016 39.0195 curveto
123.02301 39.0664 123.027 39.1406 123.027 39.2344 curveto
123.027 39.7969 lineto
123.027 39.9844 123.02 40.1289 123 40.2305 curveto
122.98 40.332 122.94101 40.4062 122.887 40.4531 curveto
122.828 40.5039 122.75 40.5312 122.64801 40.5312 curveto
122.59401 40.5312 122.543 40.5195 122.496 40.5 curveto
122.44899 40.4805 122.39801 40.4453 122.34 40.3945 curveto
122.277 40.3438 122.234 40.28911 122.203 40.2344 curveto
122.172 40.1797 122.15599 40.125 122.15599 40.0625 curveto
122.15599 39.2422 lineto
122.15599 39.14839 122.16 39.0781 122.164 39.0352 curveto
122.168 38.9961 122.18 38.96089 122.19101 38.9336 curveto
122.207 38.9062 122.22699 38.8828 122.258 38.8633 curveto
122.289 38.8477 122.332 38.832 122.395 38.8164 curveto
122.395 38.71089 lineto
121.547 38.71089 lineto
121.547 38.8164 lineto
121.609 38.832 121.65599 38.8477 121.68399 38.8633 curveto
121.711 38.8789 121.73 38.89839 121.746 38.9258 curveto
121.762 38.9492 121.77 38.9844 121.777 39.0273 curveto
121.785 39.0742 121.789 39.1445 121.789 39.2422 curveto
121.789 41.0312 lineto
121.789 41.168 121.789 41.2695 121.785 41.3203 curveto
121.785 41.3711 121.777 41.418 121.77 41.457 curveto
121.758 41.4922 121.746 41.5273 121.73 41.5508 curveto
121.715 41.5703 121.69101 41.58589 121.664 41.60161 curveto
121.637 41.6094 121.586 41.6211 121.512 41.6367 curveto
121.512 41.75 lineto
122.027 41.7695 lineto
122.15599 41.7695 lineto
 closepath fill
newpath 125.707 39.0742 moveto
125.617 38.9805 125.535 38.9023 125.457 38.85161 curveto
125.383 38.793 125.297 38.7539 125.207 38.7227 curveto
125.117 38.6914 125.012 38.6758 124.90599 38.6758 curveto
124.605 38.6758 124.387 38.7656 124.238 38.9414 curveto
124.086 39.1172 124.012 39.375 124.012 39.7188 curveto
124.012 39.9297 124.05101 40.1172 124.125 40.2812 curveto
124.203 40.4414 124.313 40.5664 124.457 40.6562 curveto
124.59401 40.7461 124.758 40.78911 124.94101 40.78911 curveto
124.922 40.6211 lineto
124.77 40.6211 124.66 40.5625 124.56601 40.4453 curveto
124.48 40.3281 124.42601 40.1602 124.418 39.9414 curveto
125.348 39.9414 lineto
125.34 40.0938 125.32 40.2188 125.293 40.3164 curveto
125.262 40.41411 125.21901 40.4883 125.15599 40.543 curveto
125.098 40.5938 125.02 40.6211 124.922 40.6211 curveto
124.94101 40.78911 lineto
125.086 40.78911 125.211 40.7656 125.312 40.7227 curveto
125.414 40.6758 125.492 40.6133 125.555 40.5352 curveto
125.613 40.4531 125.66 40.3555 125.695 40.2344 curveto
125.72699 40.1133 125.746 39.957 125.75 39.7656 curveto
124.402 39.7656 lineto
124.402 39.72661 lineto
124.402 39.5586 124.422 39.41411 124.461 39.3008 curveto
124.5 39.1875 124.55899 39.0977 124.645 39.0312 curveto
124.73 38.9648 124.84401 38.9336 124.984 38.9336 curveto
125.10199 38.9336 125.207 38.957 125.30101 39 curveto
125.391 39.043 125.484 39.1133 125.578 39.21089 curveto
 closepath fill
 0.0196 0.0196 0.0196 setrgbcolor
newpath 318.15201 25.4805 moveto
318.15201 22.2344 lineto
319.656 22.2344 lineto
320 22.2344 320.254 22.3086 320.414 22.4648 curveto
320.578 22.6172 320.68799 22.918 320.738 23.3672 curveto
320.965 23.3672 lineto
320.965 20.5703 lineto
320.738 20.5703 lineto
320.73401 20.8906 320.695 21.125 320.617 21.2773 curveto
320.535 21.4258 320.422 21.53911 320.285 21.6133 curveto
320.14099 21.6875 319.93399 21.72661 319.656 21.72661 curveto
318.15201 21.72661 lineto
318.15201 19.1328 lineto
318.15201 18.71089 318.176 18.4336 318.23401 18.3008 curveto
318.27301 18.2031 318.35901 18.1133 318.488 18.043 curveto
318.664 17.9414 318.85501 17.8906 319.047 17.8906 curveto
319.344 17.8906 lineto
319.344 17.66411 lineto
315.797 17.66411 lineto
315.797 17.8906 lineto
316.09 17.8906 lineto
316.43799 17.8906 316.68399 17.9883 316.836 18.1914 curveto
316.93799 18.3242 316.98401 18.6328 316.98401 19.1328 curveto
316.98401 24.4727 lineto
316.98401 24.8906 316.957 25.168 316.906 25.3008 curveto
316.863 25.4023 316.781 25.4883 316.656 25.5625 curveto
316.48001 25.6602 316.289 25.707 316.09 25.707 curveto
315.797 25.707 lineto
315.797 25.9336 lineto
321.949 25.9336 lineto
322.031 24.1172 lineto
321.81601 24.1172 lineto
321.711 24.5039 321.59 24.78911 321.449 24.9688 curveto
321.30899 25.1523 321.137 25.2812 320.93 25.3633 curveto
320.72699 25.4453 320.41 25.4805 319.97299 25.4805 curveto
 closepath fill
newpath 327.35501 26.1289 moveto
328.43399 26.1289 329.363 25.7188 330.14801 24.9023 curveto
330.93399 24.0898 331.328 23.0703 331.328 21.8477 curveto
331.328 20.5977 330.93 19.5508 330.14099 18.7227 curveto
329.34799 17.8906 328.387 17.47661 327.262 17.47661 curveto
327.246 17.9102 lineto
328.02701 17.9102 328.668 18.21089 329.172 18.8203 curveto
329.68 19.4297 329.93 20.3828 329.93 21.6836 curveto
329.93 23.10161 329.656 24.1523 329.09799 24.85161 curveto
328.65201 25.4023 328.031 25.6758 327.242 25.6758 curveto
327.242 25.6758 lineto
326.504 25.6758 325.91 25.4023 325.465 24.8555 curveto
324.91 24.1758 324.629 23.1758 324.629 21.8555 curveto
324.629 20.5078 324.918 19.4688 325.496 18.7422 curveto
325.93399 18.1875 326.51999 17.9102 327.246 17.9102 curveto
327.262 17.47661 lineto
326.125 17.47661 325.168 17.8789 324.39099 18.6953 curveto
323.617 19.5039 323.23001 20.5469 323.23001 21.832 curveto
323.23001 23.14839 323.68 24.2148 324.574 25.043 curveto
325.34799 25.7656 326.27701 26.1289 327.35501 26.1289 curveto
 closepath fill
newpath 338.01599 25.707 moveto
338.01599 25.9336 lineto
340.94101 25.9336 lineto
340.94101 25.707 lineto
340.633 25.707 lineto
340.30899 25.707 340.05899 25.5703 339.883 25.3008 curveto
339.801 25.1758 339.754 24.8789 339.754 24.4219 curveto
339.754 21.0703 lineto
339.754 20.2422 339.672 19.5977 339.508 19.1406 curveto
339.344 18.6836 339.01999 18.293 338.535 17.96089 curveto
338.055 17.6328 337.40201 17.4688 336.57 17.4688 curveto
335.672 17.4688 334.98001 17.6289 334.51599 17.9414 curveto
334.047 18.2539 333.719 18.6719 333.52301 19.207 curveto
333.39499 19.5664 333.328 20.2422 333.328 21.2422 curveto
333.328 24.4688 lineto
333.328 24.9805 333.258 25.3086 333.117 25.4727 curveto
332.97699 25.6289 332.75 25.707 332.43799 25.707 curveto
332.125 25.707 lineto
332.125 25.9336 lineto
335.703 25.9336 lineto
335.703 25.707 lineto
335.383 25.707 lineto
335.039 25.707 334.797 25.60161 334.64801 25.3867 curveto
334.547 25.2383 334.496 24.9336 334.496 24.4688 curveto
334.496 20.8672 lineto
334.496 20.5469 334.52701 20.1797 334.586 19.7656 curveto
334.64499 19.35161 334.754 19.0273 334.906 18.7969 curveto
335.05899 18.5664 335.281 18.375 335.57 18.2227 curveto
335.867 18.0703 336.22299 17.9961 336.64499 17.9961 curveto
337.18799 17.9961 337.668 18.1133 338.094 18.3477 curveto
338.52301 18.58589 338.81201 18.8867 338.969 19.2578 curveto
339.125 19.625 339.207 20.2461 339.207 21.125 curveto
339.207 24.4688 lineto
339.207 24.9844 339.14801 25.3086 339.035 25.4414 curveto
338.875 25.6172 338.637 25.707 338.328 25.707 curveto
 closepath fill
newpath 341.41 25.9336 moveto
343.66 25.9336 lineto
348.711 19.7344 lineto
348.711 24.5 lineto
348.711 25.0117 348.65201 25.3242 348.539 25.4492 curveto
348.39099 25.6211 348.15201 25.707 347.824 25.707 curveto
347.539 25.707 lineto
347.539 25.9336 lineto
350.414 25.9336 lineto
350.414 25.707 lineto
350.125 25.707 lineto
349.77301 25.707 349.52701 25.60161 349.379 25.3945 curveto
349.289 25.2617 349.246 24.9648 349.246 24.5 curveto
349.246 17.5312 lineto
349.02701 17.5312 lineto
343.578 24.1914 lineto
343.578 19.10161 lineto
343.578 18.5898 343.633 18.27339 343.742 18.14839 curveto
343.89499 17.97661 344.133 17.8906 344.453 17.8906 curveto
344.746 17.8906 lineto
344.746 17.66411 lineto
341.867 17.66411 lineto
341.867 17.8906 lineto
342.156 17.8906 lineto
342.508 17.8906 342.758 17.9961 342.90201 18.21089 curveto
342.992 18.3398 343.039 18.6367 343.039 19.10161 curveto
343.039 24.85161 lineto
342.797 25.1289 342.617 25.3125 342.492 25.4023 curveto
342.371 25.4922 342.18399 25.5781 341.949 25.6523 curveto
341.828 25.6914 341.64801 25.707 341.41 25.707 curveto
 closepath fill
newpath 351.05899 17.66411 moveto
351.05899 17.8906 lineto
351.367 17.8906 lineto
351.719 17.8906 351.965 18.0039 352.113 18.22661 curveto
352.199 18.3672 352.246 18.668 352.246 19.1328 curveto
352.246 24.4727 lineto
352.246 24.9844 352.19101 25.3125 352.074 25.4414 curveto
351.918 25.6172 351.68399 25.707 351.367 25.707 curveto
351.05899 25.707 lineto
351.05899 25.9336 lineto
354.422 25.9336 lineto
355.66 25.9336 356.60199 25.793 357.242 25.5117 curveto
357.887 25.2344 358.406 24.7656 358.793 24.1133 curveto
359.19101 23.457 359.387 22.7031 359.387 21.8438 curveto
359.387 20.6953 359.039 19.7305 358.336 18.96089 curveto
357.551 18.0938 356.35501 17.66411 354.75 17.66411 curveto
354.715 18.0938 lineto
355.66 18.0938 356.44101 18.4219 357.06201 19.0898 curveto
357.68399 19.7539 357.992 20.64839 357.992 21.7812 curveto
357.992 22.9297 357.68399 23.8242 357.06201 24.4844 curveto
356.44101 25.1445 355.64499 25.4727 354.668 25.4727 curveto
354.297 25.4727 353.883 25.41411 353.418 25.293 curveto
353.418 18.2617 lineto
353.93399 18.14839 354.367 18.0938 354.715 18.0938 curveto
354.75 17.66411 lineto
 closepath fill
newpath 365.324 20.4336 moveto
365.15201 20.8867 lineto
363.754 24.2305 lineto
362.31299 20.8867 lineto
365.15201 20.8867 lineto
365.324 20.4336 lineto
362.125 20.4336 lineto
361.56299 19.1289 lineto
361.422 18.8086 361.35501 18.5703 361.35501 18.41411 curveto
361.35501 18.2852 361.414 18.1719 361.531 18.0781 curveto
361.65201 17.9844 361.91 17.9219 362.31299 17.8906 curveto
362.31299 17.66411 lineto
359.711 17.66411 lineto
359.711 17.8906 lineto
360.055 17.9531 360.27701 18.0312 360.379 18.1289 curveto
360.586 18.3281 360.81601 18.72661 361.07 19.3203 curveto
363.97699 26.1289 lineto
364.19101 26.1289 lineto
367.07 19.2461 lineto
367.301 18.6953 367.508 18.33589 367.699 18.1719 curveto
367.887 18.0039 368.14801 17.9102 368.488 17.8906 curveto
368.488 17.66411 lineto
365.22699 17.66411 lineto
365.22699 17.8906 lineto
365.555 17.9062 365.77701 17.96089 365.89499 18.0586 curveto
366.008 18.1523 366.06601 18.2617 366.06601 18.3945 curveto
366.06601 18.582 365.98401 18.8594 365.82 19.2461 curveto
 closepath fill
newpath 374.47299 25.9336 moveto
374.56299 23.9961 lineto
374.332 23.9961 lineto
374.289 24.3398 374.22299 24.5781 374.14801 24.72661 curveto
374.01999 24.9648 373.85199 25.1367 373.64099 25.25 curveto
373.43399 25.3594 373.16 25.41411 372.81601 25.41411 curveto
371.65201 25.41411 lineto
371.65201 19.10161 lineto
371.65201 18.5898 371.711 18.27339 371.81601 18.14839 curveto
371.97299 17.97661 372.211 17.8906 372.531 17.8906 curveto
372.81601 17.8906 lineto
372.81601 17.66411 lineto
369.31201 17.66411 lineto
369.31201 17.8906 lineto
369.60199 17.8906 lineto
369.957 17.8906 370.203 17.9961 370.35199 18.21089 curveto
370.43799 18.3398 370.48401 18.6367 370.48401 19.10161 curveto
370.48401 25.41411 lineto
369.488 25.41411 lineto
369.10199 25.41411 368.828 25.3867 368.668 25.332 curveto
368.457 25.2539 368.27301 25.1055 368.125 24.8828 curveto
367.97299 24.66411 367.883 24.3672 367.85501 23.9961 curveto
367.625 23.9961 lineto
367.72299 25.9336 lineto
 closepath fill
newpath 378.72699 17.8906 moveto
378.72699 17.66411 lineto
375.18399 17.66411 lineto
375.18399 17.8906 lineto
375.47699 17.8906 lineto
375.81601 17.8906 376.06601 17.9883 376.219 18.1914 curveto
376.31601 18.3242 376.367 18.6328 376.367 19.1328 curveto
376.367 24.4688 lineto
376.367 24.8906 376.34 25.168 376.289 25.3008 curveto
376.246 25.4023 376.16 25.4883 376.039 25.5625 curveto
375.85901 25.6602 375.672 25.707 375.47699 25.707 curveto
375.18399 25.707 lineto
375.18399 25.9297 lineto
378.72699 25.9297 lineto
378.72699 25.707 lineto
378.43 25.707 lineto
378.09 25.707 377.844 25.6094 377.68799 25.4102 curveto
377.59 25.2812 377.531 24.9648 377.531 24.4688 curveto
377.531 19.1328 lineto
377.531 18.71089 377.56201 18.4336 377.613 18.3008 curveto
377.65201 18.2031 377.746 18.1133 377.871 18.043 curveto
378.051 17.9414 378.23401 17.8906 378.43 17.8906 curveto
 closepath fill
newpath 383.84799 26.1289 moveto
384.922 26.1289 385.85199 25.7188 386.64099 24.9023 curveto
387.422 24.0898 387.81601 23.0703 387.81601 21.8477 curveto
387.81601 20.5977 387.418 19.5508 386.625 18.7227 curveto
385.836 17.8906 384.875 17.47661 383.75 17.47661 curveto
383.738 17.9102 lineto
384.51599 17.9102 385.15201 18.21089 385.664 18.8203 curveto
386.168 19.4297 386.422 20.3828 386.422 21.6836 curveto
386.422 23.10161 386.14499 24.1523 385.586 24.85161 curveto
385.14099 25.4023 384.51599 25.6758 383.73001 25.6758 curveto
383.73001 25.6758 lineto
382.992 25.6758 382.40201 25.4023 381.953 24.8555 curveto
381.39499 24.1758 381.113 23.1758 381.113 21.8555 curveto
381.113 20.5078 381.40201 19.4688 381.98401 18.7422 curveto
382.426 18.1875 383.012 17.9102 383.738 17.9102 curveto
383.75 17.47661 lineto
382.613 17.47661 381.65201 17.8789 380.883 18.6953 curveto
380.10501 19.5039 379.72299 20.5469 379.72299 21.832 curveto
379.72299 23.14839 380.168 24.2148 381.06299 25.043 curveto
381.84 25.7656 382.76599 26.1289 383.84799 26.1289 curveto
 closepath fill
newpath 388.383 25.9336 moveto
390.629 25.9336 lineto
395.68 19.7344 lineto
395.68 24.5 lineto
395.68 25.0117 395.625 25.3242 395.508 25.4492 curveto
395.35901 25.6211 395.125 25.707 394.797 25.707 curveto
394.512 25.707 lineto
394.512 25.9336 lineto
397.39099 25.9336 lineto
397.39099 25.707 lineto
397.09799 25.707 lineto
396.746 25.707 396.496 25.60161 396.35199 25.3945 curveto
396.262 25.2617 396.215 24.9648 396.215 24.5 curveto
396.215 17.5312 lineto
395.996 17.5312 lineto
390.547 24.1914 lineto
390.547 19.10161 lineto
390.547 18.5898 390.60199 18.27339 390.711 18.14839 curveto
390.867 17.97661 391.10501 17.8906 391.426 17.8906 curveto
391.719 17.8906 lineto
391.719 17.66411 lineto
388.84 17.66411 lineto
388.84 17.8906 lineto
389.125 17.8906 lineto
389.48401 17.8906 389.73001 17.9961 389.879 18.21089 curveto
389.969 18.3398 390.012 18.6367 390.012 19.10161 curveto
390.012 24.85161 lineto
389.77301 25.1289 389.594 25.3125 389.469 25.4023 curveto
389.344 25.4922 389.156 25.5781 388.918 25.6523 curveto
388.805 25.6914 388.621 25.707 388.383 25.707 curveto
 closepath fill
newpath 319.871 35.7148 moveto
320.945 35.7148 321.828 35.332 322.52701 34.5547 curveto
323.164 33.85161 323.48401 33.0156 323.48401 32.0508 curveto
323.48401 31.082 323.14801 30.2383 322.47299 29.5156 curveto
321.801 28.7852 320.93399 28.4258 319.871 28.4258 curveto
319.871 29.27339 lineto
320.367 29.27339 320.82 29.3867 321.23401 29.625 curveto
321.64801 29.8594 321.97299 30.1992 322.219 30.6328 curveto
322.457 31.0664 322.582 31.5312 322.582 32.0312 curveto
322.582 32.8086 322.31201 33.4727 321.781 34.0195 curveto
321.246 34.5703 320.60901 34.8398 319.871 34.8398 curveto
319.871 34.8398 lineto
319.129 34.8398 318.492 34.5703 317.961 34.0195 curveto
317.426 33.4727 317.16 32.8086 317.16 32.0312 curveto
317.16 31.5312 317.281 31.0664 317.52301 30.6328 curveto
317.76999 30.1992 318.094 29.8594 318.508 29.625 curveto
318.922 29.3867 319.375 29.27339 319.871 29.27339 curveto
319.871 28.4258 lineto
318.80899 28.4258 317.94101 28.7852 317.26599 29.5156 curveto
316.594 30.2383 316.25 31.082 316.25 32.0508 curveto
316.25 33.0117 316.574 33.8438 317.211 34.5508 curveto
317.914 35.3281 318.801 35.7148 319.871 35.7148 curveto
 closepath fill
newpath 325.195 28.60161 moveto
325.195 38.2148 lineto
326.086 38.2148 lineto
326.086 34.3477 lineto
326.461 34.8047 326.879 35.14839 327.34 35.375 curveto
327.805 35.60161 328.31299 35.7148 328.863 35.7148 curveto
329.84 35.7148 330.68 35.3594 331.371 34.64839 curveto
332.06601 33.9336 332.418 33.0703 332.418 32.0547 curveto
332.418 31.0547 332.06601 30.1992 331.35901 29.4883 curveto
330.66 28.7773 329.82 28.4258 328.84 28.4258 curveto
328.27301 28.4258 327.758 28.543 327.301 28.7852 curveto
326.844 29.0273 326.43799 29.3906 326.086 29.8789 curveto
326.81201 30.0938 lineto
327.34 29.5547 327.996 29.2812 328.762 29.2812 curveto
328.762 29.2812 lineto
329.262 29.2812 329.715 29.4062 330.137 29.6523 curveto
330.555 29.8945 330.89099 30.2383 331.137 30.6836 curveto
331.383 31.1211 331.512 31.5898 331.512 32.082 curveto
331.512 32.5742 331.383 33.043 331.133 33.4883 curveto
330.883 33.9375 330.547 34.2852 330.129 34.5352 curveto
329.707 34.7852 329.254 34.9062 328.77701 34.9062 curveto
328.289 34.9062 327.828 34.7852 327.387 34.5352 curveto
326.945 34.2852 326.613 33.9453 326.375 33.5273 curveto
326.14099 33.1055 326.02701 32.6328 326.02701 32.1094 curveto
326.02701 31.3086 326.285 30.6328 326.81201 30.0938 curveto
326.086 29.8789 lineto
326.086 28.60161 lineto
 closepath fill
newpath 339.879 30.9062 moveto
340.629 30.5078 lineto
340.383 30.02339 340.09799 29.6289 339.76999 29.332 curveto
339.449 29.0352 339.086 28.8125 338.68399 28.6562 curveto
338.27701 28.5 337.82 28.4258 337.31201 28.4258 curveto
336.18399 28.4258 335.293 28.793 334.66 29.5352 curveto
334.01999 30.2812 333.699 31.1172 333.699 32.0508 curveto
333.699 32.9297 333.97299 33.7148 334.512 34.4062 curveto
335.195 35.2773 336.113 35.7148 337.262 35.7148 curveto
338.44101 35.7148 339.39099 35.2656 340.09799 34.3711 curveto
340.594 33.7344 340.85199 32.9453 340.85901 32 curveto
334.621 32 lineto
334.707 32.7695 lineto
339.879 32.7695 lineto
339.758 33.2461 339.59 33.625 339.35501 33.91411 curveto
339.125 34.1953 338.828 34.4258 338.453 34.5977 curveto
338.078 34.77339 337.68399 34.8633 337.27301 34.8633 curveto
336.59799 34.8633 336.008 34.6406 335.51599 34.207 curveto
335.164 33.8867 334.89099 33.4062 334.707 32.7695 curveto
334.621 32 lineto
334.637 31.1953 334.89099 30.5352 335.39099 30.0156 curveto
335.887 29.5039 336.504 29.2422 337.23401 29.2422 curveto
337.59 29.2422 337.93 29.3047 338.26599 29.4297 curveto
338.60199 29.5547 338.883 29.7188 339.113 29.9219 curveto
339.35199 30.1211 339.60501 30.4492 339.879 30.9062 curveto
 closepath fill
newpath 342.18399 35.53911 moveto
343.09799 35.53911 lineto
343.09799 34.52339 lineto
343.363 34.9258 343.65201 35.2227 343.957 35.418 curveto
344.258 35.6172 344.574 35.7148 344.90201 35.7148 curveto
345.14499 35.7148 345.41 35.6367 345.68799 35.4805 curveto
345.22699 34.7305 lineto
345.035 34.8086 344.879 34.8477 344.754 34.8477 curveto
344.457 34.8477 344.172 34.7305 343.89499 34.4844 curveto
343.617 34.2383 343.406 33.8594 343.262 33.3438 curveto
343.14801 32.9492 343.09799 32.1523 343.09799 30.9492 curveto
343.09799 28.60161 lineto
342.18399 28.60161 lineto
 closepath fill
newpath 346.031 35.53911 moveto
346.949 35.53911 lineto
349.078 30.5039 lineto
351.289 35.53911 lineto
351.449 35.53911 lineto
353.676 30.5039 lineto
355.844 35.53911 lineto
356.76999 35.53911 lineto
353.758 28.60161 lineto
353.59 28.60161 lineto
351.379 33.5625 lineto
349.16 28.60161 lineto
348.996 28.60161 lineto
 closepath fill
newpath 361.09799 35.7148 moveto
362.164 35.7148 363.055 35.332 363.754 34.5547 curveto
364.39099 33.85161 364.711 33.0156 364.711 32.0508 curveto
364.711 31.082 364.375 30.2383 363.699 29.5156 curveto
363.02701 28.7852 362.16 28.4258 361.09799 28.4258 curveto
361.094 29.27339 lineto
361.59 29.27339 362.043 29.3867 362.457 29.625 curveto
362.871 29.8594 363.199 30.1992 363.44101 30.6328 curveto
363.68399 31.0664 363.80899 31.5312 363.80899 32.0312 curveto
363.80899 32.8086 363.539 33.4727 363.004 34.0195 curveto
362.465 34.5703 361.832 34.8398 361.094 34.8398 curveto
361.094 34.8398 lineto
360.35199 34.8398 359.715 34.5703 359.18399 34.0195 curveto
358.65201 33.4727 358.383 32.8086 358.383 32.0312 curveto
358.383 31.5312 358.504 31.0664 358.746 30.6328 curveto
358.992 30.1992 359.32 29.8594 359.73401 29.625 curveto
360.14801 29.3867 360.60199 29.27339 361.094 29.27339 curveto
361.09799 28.4258 lineto
360.035 28.4258 359.168 28.7852 358.492 29.5156 curveto
357.81601 30.2383 357.47699 31.082 357.47699 32.0508 curveto
357.47699 33.0117 357.793 33.8438 358.43399 34.5508 curveto
359.14099 35.3281 360.02301 35.7148 361.09799 35.7148 curveto
 closepath fill
newpath 366.22699 28.60161 moveto
367.121 28.60161 lineto
367.121 38.2148 lineto
366.22699 38.2148 lineto
 closepath fill
newpath 371.828 38.2148 moveto
371.828 37.33589 lineto
371.504 37.4805 371.22299 37.5508 370.988 37.5508 curveto
370.81299 37.5508 370.672 37.5156 370.555 37.4453 curveto
370.44101 37.375 370.371 37.293 370.34 37.1992 curveto
370.305 37.1094 370.297 36.8672 370.297 36.4727 curveto
370.297 35.53911 lineto
371.742 35.53911 lineto
371.742 34.7656 lineto
370.293 34.7656 lineto
370.289 28.60161 lineto
369.39499 28.60161 lineto
369.39499 34.7656 lineto
368.48001 34.7656 lineto
368.48001 35.53911 lineto
369.39499 35.53911 lineto
369.39499 36.6211 lineto
369.39499 37.1172 369.43799 37.47661 369.531 37.6875 curveto
369.621 37.89839 369.77301 38.0703 370 38.1992 curveto
370.215 38.3281 370.48401 38.3945 370.793 38.3945 curveto
371.082 38.3945 371.426 38.33589 371.828 38.2148 curveto
 closepath fill
newpath 379.98001 35.53911 moveto
379.98001 28.60161 lineto
379.10199 28.60161 lineto
379.10199 29.7969 lineto
378.72699 29.3398 378.30899 28.9961 377.844 28.7656 curveto
377.375 28.53911 376.863 28.4258 376.31601 28.4258 curveto
375.336 28.4258 374.5 28.7812 373.801 29.4922 curveto
373.10501 30.2031 372.762 31.0703 372.762 32.0898 curveto
372.762 33.08589 373.10901 33.9414 373.80899 34.6523 curveto
374.512 35.3594 375.35501 35.7148 376.34 35.7148 curveto
376.91 35.7148 377.43 35.5938 377.89099 35.35161 curveto
378.34799 35.1133 378.754 34.7461 379.10199 34.2656 curveto
378.367 34.0508 lineto
377.84 34.58589 377.18799 34.8555 376.414 34.8555 curveto
376.414 34.8555 lineto
375.918 34.8555 375.461 34.7344 375.043 34.4922 curveto
374.621 34.2461 374.289 33.89839 374.039 33.457 curveto
373.793 33.0156 373.664 32.5547 373.664 32.0586 curveto
373.664 31.5742 373.793 31.1055 374.043 30.66411 curveto
374.293 30.2148 374.629 29.8672 375.051 29.6172 curveto
375.47299 29.3711 375.926 29.2461 376.406 29.2461 curveto
376.89499 29.2461 377.35501 29.3672 377.797 29.6133 curveto
378.23401 29.8594 378.57 30.1992 378.805 30.6172 curveto
379.039 31.03911 379.16 31.5078 379.16 32.0352 curveto
379.16 32.83589 378.89499 33.5117 378.367 34.0508 curveto
379.10199 34.2656 lineto
379.10199 35.53911 lineto
 closepath fill
newpath 388.719 34.0977 moveto
388.012 33.6523 lineto
387.39801 34.4688 386.56601 34.875 385.508 34.875 curveto
384.66 34.875 383.961 34.60161 383.406 34.0586 curveto
382.84799 33.5156 382.56601 32.8555 382.56601 32.0781 curveto
382.56601 31.5742 382.699 31.0977 382.953 30.6562 curveto
383.211 30.21089 383.56201 29.8594 384.008 29.6133 curveto
384.457 29.3672 384.957 29.2422 385.51999 29.2422 curveto
386.535 29.2422 387.367 29.6523 388.012 30.4648 curveto
388.719 30 lineto
388.383 29.4961 387.93799 29.1094 387.383 28.83589 curveto
386.828 28.5625 386.18799 28.4258 385.47699 28.4258 curveto
384.379 28.4258 383.469 28.77339 382.746 29.4688 curveto
382.02301 30.168 381.656 31.0156 381.656 32.0117 curveto
381.656 32.6836 381.836 33.3047 382.172 33.8828 curveto
382.508 34.46089 382.97299 34.9102 383.56201 35.2305 curveto
384.15201 35.5508 384.80899 35.7148 385.547 35.7148 curveto
386.004 35.7148 386.445 35.6445 386.871 35.5039 curveto
387.301 35.3633 387.664 35.1836 387.961 34.957 curveto
388.258 34.7305 388.508 34.4453 388.719 34.0977 curveto
 closepath fill
newpath 390.43399 38.2148 moveto
391.324 38.2148 lineto
391.324 34.293 lineto
391.68399 34.7695 392.082 35.125 392.51599 35.3594 curveto
392.949 35.5977 393.418 35.7148 393.926 35.7148 curveto
394.445 35.7148 394.90201 35.582 395.301 35.3203 curveto
395.703 35.0586 396 34.7031 396.19101 34.2617 curveto
396.383 33.8125 396.48001 33.1172 396.48001 32.1719 curveto
396.48001 28.60161 lineto
395.582 28.60161 lineto
395.582 31.9102 lineto
395.582 32.707 395.551 33.2383 395.492 33.5117 curveto
395.379 33.9727 395.18 34.3164 394.887 34.5469 curveto
394.59799 34.7773 394.219 34.8945 393.746 34.8945 curveto
393.203 34.8945 392.719 34.7148 392.293 34.3594 curveto
391.863 34 391.586 33.5625 391.449 33.0312 curveto
391.363 32.6914 391.324 32.0625 391.324 31.14839 curveto
391.324 28.60161 lineto
390.43399 28.60161 lineto
 closepath fill
showpage
%%EOF
}

\snapshot@savemps\snapshot@logo@de{
%!PS-Adobe-3.0 EPSF-3.0
%%BoundingBox: 0 0 520 44 
%%HiResBoundingBox: 0.44351 0.477 519.953 43.47346 
%%Creator: MetaPost 1.803
%%CreationDate: 2014.04.30:1907
%%Pages: 1
%%BeginProlog
%%EndProlog
%%Page: 1 1
 0.0941 0.0941 0.0941 setrgbcolor
newpath 487.05899 18.5352 moveto
487.629 18.5352 lineto
487.629 19.0273 lineto
487.05899 19.0273 lineto
487.05899 20.1328 lineto
486.52301 20.1328 lineto
486.52301 19.0273 lineto
486.219 19.0273 lineto
486.219 18.5352 lineto
486.52301 18.5352 lineto
486.52301 16.1875 lineto
487.05899 16.1875 lineto
 closepath fill
newpath 467.43799 18.5352 moveto
467.97299 18.5352 lineto
467.97299 19.0273 lineto
467.43799 19.0273 lineto
467.43799 20.1328 lineto
466.867 20.1328 lineto
466.867 19.0273 lineto
466.56201 19.0273 lineto
466.56201 18.5352 lineto
466.867 18.5352 lineto
466.867 16.1875 lineto
467.43799 16.1875 lineto
 closepath fill
newpath 495.742 18.6289 moveto
495.59 18.9531 495.305 19.125 494.961 19.125 curveto
494.48401 19.125 494.125 18.7812 494.125 18.2852 curveto
494.125 17.9023 494.35199 17.75 494.66 17.5781 curveto
495.211 17.293 lineto
495.324 17.1992 495.39801 17.1211 495.39801 16.9688 curveto
495.39801 16.7227 495.211 16.5898 494.98001 16.5898 curveto
494.715 16.5898 494.56201 16.7227 494.469 16.9492 curveto
493.97299 16.7227 lineto
494.14499 16.3242 494.56201 16.0742 494.98001 16.0742 curveto
495.496 16.0742 495.97299 16.4727 495.97299 17.0273 curveto
495.97299 17.4648 495.64801 17.6914 495.305 17.8438 curveto
494.961 17.97661 494.64099 18.1094 494.64099 18.3398 curveto
494.64099 18.5117 494.793 18.6289 494.926 18.6289 curveto
495.094 18.6289 495.23001 18.5352 495.305 18.39839 curveto
 closepath fill
newpath 493.211 18.4961 moveto
493.094 18.6836 492.715 19.125 492.06601 19.125 curveto
491.19101 19.125 490.504 18.4727 490.504 17.5781 curveto
490.504 16.7227 491.19101 16.0742 492.02701 16.0742 curveto
492.66 16.0742 493.004 16.418 493.172 16.66411 curveto
492.793 16.9492 lineto
492.621 16.7578 492.445 16.5898 492.047 16.5898 curveto
491.43799 16.5898 491.039 17.0273 491.039 17.6172 curveto
491.039 18.1289 491.457 18.6289 492.008 18.6289 curveto
492.332 18.6289 492.59799 18.4727 492.80899 18.2227 curveto
 closepath fill
newpath 489.078 20.7422 moveto
488.84799 20.7422 488.695 20.5508 488.695 20.3398 curveto
488.695 20.1328 488.84799 19.9805 489.078 19.9805 curveto
489.26999 19.9805 489.457 20.1328 489.457 20.3398 curveto
489.457 20.5508 489.26999 20.7422 489.078 20.7422 curveto
 closepath fill
newpath 489.324 19.0273 moveto
488.793 19.0273 lineto
488.793 16.1875 lineto
489.324 16.1875 lineto
 closepath fill
newpath 484.906 19.0273 moveto
484.35199 19.0273 lineto
484.35199 18.5703 lineto
484.121 18.91411 483.781 19.125 483.363 19.125 curveto
483.457 18.6289 lineto
484.047 18.6289 484.39099 18.168 484.39099 17.6172 curveto
484.39099 17.0469 484.047 16.5898 483.457 16.5898 curveto
483.457 16.5898 lineto
482.867 16.5898 482.543 17.082 482.543 17.6172 curveto
482.543 18.1289 482.887 18.6289 483.457 18.6289 curveto
483.363 19.125 lineto
482.52301 19.125 482.012 18.418 482.012 17.6328 curveto
482.012 16.7969 482.504 16.0742 483.363 16.0742 curveto
483.781 16.0742 484.121 16.3047 484.35199 16.625 curveto
484.35199 16.1875 lineto
484.906 16.1875 lineto
 closepath fill
newpath 477.47699 19.0273 moveto
476.922 19.0273 lineto
476.922 16.1875 lineto
477.47699 16.1875 lineto
477.47699 17.5781 lineto
477.47699 18.0352 477.51599 18.6289 478.10501 18.6289 curveto
478.60199 18.6289 478.621 18.0742 478.621 17.6914 curveto
478.621 16.1875 lineto
479.172 16.1875 lineto
479.172 17.5781 lineto
479.172 18.0352 479.23001 18.6289 479.801 18.6289 curveto
480.293 18.6289 480.35199 18.168 480.35199 17.78911 curveto
480.35199 16.1875 lineto
480.883 16.1875 lineto
480.883 17.8828 lineto
480.883 18.5352 480.695 19.125 479.953 19.125 curveto
479.59 19.125 479.246 18.9336 479.05899 18.6289 curveto
478.867 18.9531 478.60199 19.125 478.238 19.125 curveto
477.914 19.125 477.64801 18.9336 477.47699 18.668 curveto
 closepath fill
newpath 475.60901 17.5 moveto
475.60901 17.5977 lineto
475.60901 18.457 475.172 19.125 474.258 19.125 curveto
473.34 19.125 472.883 18.457 472.883 17.5781 curveto
472.883 16.7422 473.40201 16.0742 474.27701 16.0742 curveto
474.828 16.0742 475.344 16.3594 475.60901 16.8555 curveto
475.15201 17.1211 lineto
474.94101 16.7773 474.715 16.5898 474.27701 16.5898 curveto
473.762 16.5898 473.44101 17.0273 473.418 17.5 curveto
473.453 17.9414 lineto
473.51599 18.3398 473.84 18.64839 474.258 18.64839 curveto
474.715 18.64839 475 18.3789 475.05899 17.9414 curveto
473.453 17.9414 lineto
473.418 17.5 lineto
 closepath fill
newpath 469.207 20.7578 moveto
469.207 16.1875 lineto
469.762 16.1875 lineto
469.762 17.4844 lineto
469.762 18.0156 469.762 18.6289 470.469 18.6289 curveto
471.039 18.6289 471.09799 18.2852 471.09799 17.8047 curveto
471.09799 16.1875 lineto
471.64801 16.1875 lineto
471.64801 17.8828 lineto
471.64801 18.58589 471.43799 19.125 470.621 19.125 curveto
470.297 19.125 469.949 18.9727 469.762 18.64839 curveto
469.762 20.7578 lineto
 closepath fill
newpath 465.34 19.0273 moveto
464.80899 19.0273 lineto
464.80899 18.5703 lineto
464.789 18.5703 lineto
464.55899 18.91411 464.219 19.125 463.801 19.125 curveto
463.89499 18.6289 lineto
464.48401 18.6289 464.828 18.168 464.828 17.6172 curveto
464.828 17.0469 464.48401 16.5898 463.89499 16.5898 curveto
463.89499 16.5898 lineto
463.305 16.5898 462.98001 17.082 462.98001 17.6172 curveto
462.98001 18.1289 463.324 18.6289 463.89499 18.6289 curveto
463.801 19.125 lineto
462.961 19.125 462.449 18.418 462.449 17.6328 curveto
462.449 16.7969 462.94101 16.0742 463.801 16.0742 curveto
464.219 16.0742 464.55899 16.3047 464.789 16.625 curveto
464.80899 16.625 lineto
464.80899 16.1875 lineto
465.34 16.1875 lineto
 closepath fill
newpath 457.91 19.0273 moveto
457.34 19.0273 lineto
457.34 16.1875 lineto
457.91 16.1875 lineto
457.91 17.5781 lineto
457.91 18.0352 457.949 18.6289 458.543 18.6289 curveto
459.05899 18.6289 459.074 18.0742 459.074 17.6914 curveto
459.074 16.1875 lineto
459.629 16.1875 lineto
459.629 17.5781 lineto
459.629 18.0352 459.668 18.6289 460.258 18.6289 curveto
460.73001 18.6289 460.789 18.168 460.789 17.78911 curveto
460.789 16.1875 lineto
461.32 16.1875 lineto
461.32 17.8828 lineto
461.32 18.5352 461.133 19.125 460.39099 19.125 curveto
460.02701 19.125 459.68399 18.9336 459.492 18.6289 curveto
459.324 18.9531 459.05899 19.125 458.676 19.125 curveto
458.34799 19.125 458.06299 18.9336 457.91 18.668 curveto
 closepath fill
newpath 451.39801 19.0273 moveto
450.844 19.0273 lineto
450.844 16.1875 lineto
451.39801 16.1875 lineto
451.39801 17.4844 lineto
451.39801 18.0156 451.39801 18.6289 452.10199 18.6289 curveto
452.676 18.6289 452.75 18.2852 452.75 17.8047 curveto
452.75 16.1875 lineto
453.26599 16.1875 lineto
453.26599 17.8828 lineto
453.26599 18.58589 453.094 19.125 452.27301 19.125 curveto
451.93399 19.125 451.59 18.9727 451.418 18.64839 curveto
451.39801 18.64839 lineto
 closepath fill
newpath 449.758 17.5 moveto
449.758 17.5977 lineto
449.758 18.457 449.34 19.125 448.426 19.125 curveto
447.512 19.125 447.039 18.457 447.039 17.5781 curveto
447.039 16.7422 447.57 16.0742 448.426 16.0742 curveto
448.996 16.0742 449.492 16.3594 449.758 16.8555 curveto
449.301 17.1211 lineto
449.094 16.7773 448.863 16.5898 448.426 16.5898 curveto
447.914 16.5898 447.59 17.0273 447.59 17.5 curveto
447.60901 17.9414 lineto
447.68399 18.3398 448.008 18.64839 448.426 18.64839 curveto
448.863 18.64839 449.14801 18.3789 449.207 17.9414 curveto
447.60901 17.9414 lineto
447.59 17.5 lineto
 closepath fill
newpath 443.762 19.0273 moveto
443.207 19.0273 lineto
443.207 14.5352 lineto
443.762 14.5352 lineto
443.762 16.625 lineto
443.781 16.625 lineto
443.988 16.3047 444.332 16.0742 444.75 16.0742 curveto
445.625 16.0742 446.10199 16.7969 446.10199 17.6328 curveto
446.10199 18.418 445.586 19.125 444.76999 19.125 curveto
444.637 18.6289 lineto
445.22699 18.6289 445.57 18.168 445.57 17.6172 curveto
445.57 17.0469 445.22699 16.5898 444.637 16.5898 curveto
444.637 16.5898 lineto
444.047 16.5898 443.72299 17.082 443.72299 17.6172 curveto
443.72299 18.1289 444.06601 18.6289 444.637 18.6289 curveto
444.76999 19.125 lineto
444.332 19.125 443.988 18.91411 443.781 18.5703 curveto
443.762 18.5703 lineto
 closepath fill
newpath 440.711 19.125 moveto
440.711 18.6094 lineto
441.262 18.6094 441.703 18.14839 441.703 17.5977 curveto
441.703 17.0664 441.262 16.625 440.711 16.625 curveto
440.18 16.625 439.762 17.0664 439.762 17.5977 curveto
439.762 18.14839 440.18 18.6094 440.711 18.6094 curveto
440.711 18.6094 lineto
440.711 19.125 lineto
439.875 19.125 439.19101 18.457 439.19101 17.5977 curveto
439.19101 16.7422 439.875 16.0742 440.711 16.0742 curveto
441.57 16.0742 442.254 16.7422 442.254 17.5977 curveto
442.254 18.457 441.57 19.125 440.711 19.125 curveto
 closepath fill
newpath 495.72299 24.1133 moveto
497.555 24.1133 lineto
492.047 35.9219 lineto
486.543 24.1133 lineto
488.371 24.1133 lineto
489.555 26.8008 lineto
494.52301 26.8008 lineto
493.879 28.2852 lineto
490.219 28.2852 lineto
492.047 32.418 lineto
493.879 28.2852 lineto
494.52301 26.8008 lineto
 closepath fill
newpath 446.98001 24.1133 moveto
448.80899 24.1133 lineto
443.305 35.9219 lineto
437.797 24.1133 lineto
439.629 24.1133 lineto
440.805 26.8008 lineto
445.77701 26.8008 lineto
445.129 28.2852 lineto
441.47299 28.2852 lineto
443.305 32.418 lineto
445.129 28.2852 lineto
445.77701 26.8008 lineto
 closepath fill
newpath 519.953 35.5039 moveto
518.22302 35.5039 lineto
515.28497 30.8008 lineto
512.297 35.5039 lineto
510.469 35.5039 lineto
514.43 29.0625 lineto
514.43 24.1133 lineto
516.09003 24.1133 lineto
516.09003 29.2539 lineto
 closepath fill
newpath 418.76599 35.5039 moveto
417.10901 35.5039 lineto
417.10901 24.1133 lineto
418.76599 24.1133 lineto
 closepath fill
newpath 468.18 35.5039 moveto
466.508 35.5039 lineto
466.508 24.1133 lineto
468.18 24.1133 lineto
 closepath fill
newpath 508.77301 24.1133 moveto
505.344 29.1406 lineto
506.94101 29.5586 507.801 30.668 507.801 32.2656 curveto
507.801 33.4258 507.285 34.4375 506.35501 34.9727 curveto
505.613 35.4297 505.004 35.5039 502.867 35.5039 curveto
500.887 35.5039 lineto
500.887 24.1133 lineto
502.543 24.1133 lineto
502.543 28.9883 lineto
502.543 30.4961 lineto
502.543 34.0195 lineto
503.93799 34.0195 lineto
504.719 34.0195 505.19101 33.9023 505.51599 33.6172 curveto
505.879 33.293 506.10501 32.7422 506.10501 32.1875 curveto
506.10501 31.5039 505.746 30.9336 505.117 30.668 curveto
504.793 30.5312 504.35199 30.4961 503.324 30.4961 curveto
502.543 30.4961 lineto
502.543 28.9883 lineto
503.418 28.9883 lineto
506.676 24.1133 lineto
 closepath fill
newpath 483.26599 35.5039 moveto
481.60901 35.5039 lineto
481.60901 27.75 lineto
473.074 35.7305 lineto
473.074 24.1133 lineto
474.73401 24.1133 lineto
474.73401 31.8828 lineto
483.26599 23.8828 lineto
 closepath fill
newpath 457.453 29.9023 moveto
457.453 28.418 lineto
460.48401 28.418 lineto
460.16 26.5117 458.828 25.332 456.80899 25.332 curveto
454.371 25.332 452.73001 27.3125 452.73001 29.96089 curveto
452.73001 32.3789 454.426 34.2656 456.844 34.2656 curveto
458.31201 34.2656 459.379 33.6523 460.465 32.2461 curveto
461.81601 33.293 lineto
460.543 35.0078 458.887 35.8477 456.80899 35.8477 curveto
455.47699 35.8477 454.34799 35.4297 453.285 34.64839 curveto
451.742 33.5039 450.906 31.8086 450.906 29.8242 curveto
450.906 28.1523 451.531 26.5898 452.676 25.4453 curveto
453.797 24.3047 455.039 23.75 456.80899 23.75 curveto
458.504 23.75 459.781 24.3242 460.824 25.4648 curveto
461.836 26.5352 462.336 27.8086 462.504 29.9023 curveto
 closepath fill
newpath 432.844 36.0352 moveto
429.18799 27.582 lineto
425.492 36.0352 lineto
422.613 24.1133 lineto
424.445 24.1133 lineto
426.02301 31.1406 lineto
429.18799 23.6367 lineto
432.35199 31.1406 lineto
433.91 24.1133 lineto
435.742 24.1133 lineto
 closepath fill
 0 1.82886 dtransform truncate idtransform setlinewidth pop [] 0 setdash
 0 setlinecap 0 setlinejoin 10 setmiterlimit
newpath 8.67188 31.5898 moveto
21.3398 31.5898 lineto stroke
newpath 15.0078 20.6172 moveto
8.67188 31.5898 lineto stroke
newpath 21.3438 31.5898 moveto
15.0078 20.6172 lineto stroke
 1 1 1 setrgbcolor 0 2.55962 dtransform truncate idtransform setlinewidth pop
newpath 15.7383 31.5898 moveto
21.3438 31.5898 lineto
25.3789 31.5898 28.6562 28.3125 28.6562 24.27339 curveto stroke
newpath 11.4727 26.7383 moveto
8.67188 31.5898 lineto
6.65625 35.08589 7.85156 39.5625 11.3477 41.5781 curveto stroke
newpath 17.8086 25.4688 moveto
15.0078 20.6172 lineto
12.9844 17.1211 8.51172 15.9219 5.01172 17.9375 curveto stroke
 0.0941 0.0941 0.0941 setrgbcolor 0 1.82886
 dtransform truncate idtransform setlinewidth pop
newpath 15.0078 31.5898 moveto
21.3438 31.5898 lineto
25.3789 31.5898 28.6562 28.3125 28.6562 24.27339 curveto
28.6562 20.2383 25.3789 16.96089 21.3438 16.96089 curveto
8.67188 16.96089 lineto stroke
newpath 11.8398 26.10161 moveto
8.67188 31.5898 lineto
6.65234 35.08589 7.85156 39.5586 11.3477 41.5781 curveto
14.8438 43.5977 19.3203 42.39839 21.3438 38.9023 curveto
27.6719 27.9297 lineto stroke
newpath 18.1758 26.10161 moveto
15.0078 20.6172 lineto
12.9844 17.1211 8.51172 15.9219 5.01172 17.9375 curveto
1.51563 19.957 0.32031 24.4336 2.33984 27.9297 curveto
8.67188 38.9023 lineto stroke
newpath 36.4961 40.0352 moveto
36.47661 40.0352 lineto
35.78911 36.1289 lineto
35.0273 36.1289 lineto
36.2344 42.293 lineto
38.2656 37.6367 lineto
40.2969 42.293 lineto
41.5039 36.1289 lineto
40.7461 36.1289 lineto
40.0508 40.0352 lineto
40.0352 40.0352 lineto
38.2656 36.0039 lineto
 closepath fill
newpath 45.7227 36.1289 moveto
45.0195 36.1289 lineto
45.0195 36.7031 lineto
45.0039 36.7031 lineto
44.7188 36.2852 44.2813 36.0039 43.7539 36.0039 curveto
43.8633 36.6328 lineto
44.6328 36.6328 45.0586 37.2422 45.0586 37.9648 curveto
45.0586 37.9648 lineto
45.0586 38.6797 44.625 39.2812 43.8633 39.2812 curveto
43.1328 39.2812 42.7031 38.64839 42.7031 37.9648 curveto
42.7031 37.27339 43.1172 36.6328 43.8633 36.6328 curveto
43.7539 36.0039 lineto
42.6328 36.0039 42 36.9375 42 37.9922 curveto
42 38.9922 42.66411 39.9102 43.7305 39.9102 curveto
44.2695 39.9102 44.71089 39.625 45.0039 39.1875 curveto
45.0195 39.1875 lineto
45.0195 39.8008 lineto
45.7227 39.8008 lineto
 closepath fill
newpath 47.6367 36.1289 moveto
46.9297 36.1289 lineto
46.9297 39.1406 lineto
46.5469 39.1406 lineto
46.5469 39.7969 lineto
46.9297 39.7969 lineto
46.9297 41.1992 lineto
47.6367 41.1992 lineto
47.6367 39.7969 lineto
48.3281 39.7969 lineto
48.3281 39.1406 lineto
47.6367 39.1406 lineto
 closepath fill
newpath 49.6055 42.9375 moveto
49.6055 39.3047 lineto
49.6211 39.3047 lineto
49.8398 39.6953 50.2773 39.9102 50.7227 39.9102 curveto
51.7617 39.9102 52.02339 39.21089 52.02339 38.3203 curveto
52.02339 36.1289 lineto
51.3203 36.1289 lineto
51.3203 38.2344 lineto
51.3203 38.8594 51.2344 39.2812 50.5117 39.2812 curveto
49.6055 39.2812 49.6055 38.4844 49.6055 37.8164 curveto
49.6055 36.1289 lineto
48.89839 36.1289 lineto
48.89839 42.9375 lineto
 closepath fill
newpath 53.6172 37.8477 moveto
53.6563 38.3828 lineto
55.7148 38.3828 lineto
55.625 38.9297 55.2617 39.2969 54.6992 39.2969 curveto
54.1523 39.2969 53.7422 38.9062 53.6563 38.3828 curveto
53.6172 37.8477 lineto
53.625 37.2188 54.0508 36.6289 54.7227 36.6289 curveto
55.2617 36.6289 55.5547 36.9062 55.8203 37.3438 curveto
56.418 37.0078 lineto
56.0742 36.3711 55.4297 36.0039 54.7148 36.0039 curveto
53.5938 36.0039 52.91411 36.85161 52.91411 37.9336 curveto
52.91411 39.0625 53.5156 39.9102 54.6992 39.9102 curveto
55.8711 39.9102 56.418 39.0469 56.418 37.957 curveto
56.418 37.8477 lineto
 closepath fill
newpath 57.89839 39.33589 moveto
57.91411 39.33589 lineto
58.1172 39.6562 58.4844 39.9102 58.8867 39.9102 curveto
59.3633 39.9102 59.71089 39.668 59.9414 39.2578 curveto
60.1719 39.64839 60.6133 39.9102 61.0742 39.9102 curveto
62.03911 39.9102 62.28911 39.1562 62.28911 38.3281 curveto
62.28911 36.1289 lineto
61.582 36.1289 lineto
61.582 38.21089 lineto
61.582 38.6797 61.5195 39.2812 60.9023 39.2812 curveto
60.1523 39.2812 60.0938 38.5 60.0938 37.9336 curveto
60.0938 36.1289 lineto
59.3906 36.1289 lineto
59.3906 38.0742 lineto
59.3906 38.5547 59.3633 39.2812 58.7148 39.2812 curveto
57.96089 39.2812 57.89839 38.5078 57.89839 37.9336 curveto
57.89839 36.1289 lineto
57.1953 36.1289 lineto
57.1953 39.8008 lineto
57.89839 39.8008 lineto
 closepath fill
newpath 66.8672 36.1289 moveto
66.1602 36.1289 lineto
66.1602 36.7031 lineto
66.1445 36.7031 lineto
65.8633 36.2852 65.4258 36.0039 64.9023 36.0039 curveto
65.0117 36.6328 lineto
65.7773 36.6328 66.1992 37.2422 66.1992 37.9648 curveto
66.1992 37.9648 lineto
66.1992 38.6797 65.7695 39.2812 65.0117 39.2812 curveto
64.2812 39.2812 63.85161 38.64839 63.85161 37.9648 curveto
63.85161 37.27339 64.2656 36.6328 65.0117 36.6328 curveto
64.9023 36.0039 lineto
63.7773 36.0039 63.1445 36.9375 63.1445 37.9922 curveto
63.1445 38.9922 63.8125 39.9102 64.8789 39.9102 curveto
65.418 39.9102 65.8555 39.625 66.1445 39.1875 curveto
66.1602 39.1875 lineto
66.1602 39.8008 lineto
66.8672 39.8008 lineto
 closepath fill
newpath 68.78911 36.1289 moveto
68.08589 36.1289 lineto
68.08589 39.1406 lineto
67.6992 39.1406 lineto
67.6992 39.7969 lineto
68.08589 39.7969 lineto
68.08589 41.1992 lineto
68.78911 41.1992 lineto
68.78911 39.7969 lineto
69.4805 39.7969 lineto
69.4805 39.1406 lineto
68.78911 39.1406 lineto
 closepath fill
newpath 70.918 36.1289 moveto
70.2148 36.1289 lineto
70.2148 39.7969 lineto
70.918 39.7969 lineto
 closepath fill
newpath 71.0586 41.4805 moveto
71.0586 41.21089 70.832 40.9961 70.5664 40.9961 curveto
70.3008 40.9961 70.082 41.21089 70.082 41.4805 curveto
70.082 41.7539 70.3008 41.9727 70.5664 41.9727 curveto
70.832 41.9727 71.0586 41.7539 71.0586 41.4805 curveto
 closepath fill
newpath 73.7188 38.96089 moveto
73.6328 39.1406 73.4531 39.2812 73.25 39.2812 curveto
73.0547 39.2812 72.8672 39.125 72.8672 38.9219 curveto
72.8672 38.60161 73.28911 38.46089 73.7188 38.2656 curveto
74.1523 38.0664 74.5664 37.8008 74.5664 37.2188 curveto
74.5664 36.5195 73.9844 36.0039 73.3047 36.0039 curveto
72.77339 36.0039 72.2305 36.3086 72.0352 36.8281 curveto
72.6406 37.10161 lineto
72.78911 36.8281 72.9688 36.6328 73.3047 36.6328 curveto
73.60161 36.6328 73.8594 36.83589 73.8594 37.14839 curveto
73.8594 37.3438 73.7656 37.4375 73.60161 37.5508 curveto
72.91411 37.918 lineto
72.5078 38.1406 72.207 38.3438 72.207 38.8438 curveto
72.207 39.4375 72.6953 39.9102 73.28911 39.9102 curveto
73.7344 39.9102 74.0977 39.668 74.293 39.2656 curveto
 closepath fill
newpath 78.14839 38.7578 moveto
77.8672 39.0781 77.52339 39.25 77.10161 39.25 curveto
76.4102 39.25 75.8789 38.6406 75.8789 37.9648 curveto
75.8789 37.21089 76.4023 36.66411 77.1445 36.66411 curveto
77.5547 36.66411 77.8828 36.85161 78.14839 37.14839 curveto
78.14839 36.2461 lineto
77.8281 36.0742 77.5078 36.0039 77.1406 36.0039 curveto
76.0586 36.0039 75.168 36.83589 75.168 37.9336 curveto
75.168 39.0703 76.0508 39.9102 77.1797 39.9102 curveto
77.5078 39.9102 77.8672 39.832 78.14839 39.668 curveto
 closepath fill
newpath 79.8125 42.9375 moveto
79.8125 39.3047 lineto
79.8281 39.3047 lineto
80.0469 39.6953 80.4883 39.9102 80.9336 39.9102 curveto
81.9688 39.9102 82.2344 39.21089 82.2344 38.3203 curveto
82.2344 36.1289 lineto
81.52739 36.1289 lineto
81.52739 38.2344 lineto
81.52739 38.8594 81.4414 39.2812 80.7227 39.2812 curveto
79.8125 39.2812 79.8125 38.4844 79.8125 37.8164 curveto
79.8125 36.1289 lineto
79.1094 36.1289 lineto
79.1094 42.9375 lineto
 closepath fill
newpath 83.8281 37.8477 moveto
83.8672 38.3828 lineto
85.918 38.3828 lineto
85.832 38.9297 85.4727 39.2969 84.9102 39.2969 curveto
84.3594 39.2969 83.9531 38.9062 83.8672 38.3828 curveto
83.8281 37.8477 lineto
83.83589 37.2188 84.2578 36.6289 84.9336 36.6289 curveto
85.4727 36.6289 85.7617 36.9062 86.02739 37.3438 curveto
86.6289 37.0078 lineto
86.2773 36.3711 85.6367 36.0039 84.9219 36.0039 curveto
83.8047 36.0039 83.1211 36.85161 83.1211 37.9336 curveto
83.1211 39.0625 83.72661 39.9102 84.9102 39.9102 curveto
86.0742 39.9102 86.6289 39.0469 86.6289 37.957 curveto
86.6289 37.8477 lineto
 closepath fill
newpath 88.89839 38.96089 moveto
88.8125 39.1406 88.6328 39.2812 88.4297 39.2812 curveto
88.2344 39.2812 88.0469 39.125 88.0469 38.9219 curveto
88.0469 38.60161 88.4688 38.46089 88.89839 38.2656 curveto
89.3281 38.0664 89.7461 37.8008 89.7461 37.2188 curveto
89.7461 36.5195 89.16411 36.0039 88.4844 36.0039 curveto
87.9492 36.0039 87.4102 36.3086 87.2148 36.8281 curveto
87.8164 37.10161 lineto
87.9688 36.8281 88.14839 36.6328 88.4844 36.6328 curveto
88.7812 36.6328 89.03911 36.83589 89.03911 37.14839 curveto
89.03911 37.3438 88.9453 37.4375 88.7812 37.5508 curveto
88.0938 37.918 lineto
87.6836 38.1406 87.3867 38.3438 87.3867 38.8438 curveto
87.3867 39.4375 87.8711 39.9102 88.4688 39.9102 curveto
88.91411 39.9102 89.27339 39.668 89.4727 39.2656 curveto
 closepath fill
newpath 36.2188 31.5547 moveto
36.2188 29.8906 lineto
38.27339 29.8906 lineto
38.27339 29.2188 lineto
36.2188 29.2188 lineto
36.2188 26.3203 lineto
35.4844 26.3203 lineto
35.4844 32.2305 lineto
38.3438 32.2305 lineto
38.3438 31.5547 lineto
 closepath fill
newpath 42.91411 28.1445 moveto
42.91411 27.03911 42.0547 26.1914 40.957 26.1914 curveto
40.957 26.8672 lineto
41.6523 26.8672 42.21089 27.4531 42.21089 28.1445 curveto
42.21089 28.8398 41.6523 29.4219 40.957 29.4219 curveto
40.2578 29.4219 39.6992 28.8398 39.6992 28.1445 curveto
39.6992 28.1445 lineto
39.6992 27.4531 40.2578 26.8672 40.957 26.8672 curveto
40.957 26.1914 lineto
39.8555 26.1914 38.9961 27.03911 38.9961 28.1445 curveto
38.9961 29.2461 39.8555 30.0977 40.957 30.0977 curveto
42.0547 30.0977 42.91411 29.2461 42.91411 28.1445 curveto
 closepath fill
newpath 44.5 29.3906 moveto
44.52339 29.3906 lineto
44.6992 29.8203 45.0586 30.0977 45.5273 30.0977 curveto
45.7305 30.0977 45.9336 30.02339 46.1094 29.918 curveto
45.7852 29.2695 lineto
45.6602 29.3828 45.5195 29.4219 45.3555 29.4219 curveto
44.5898 29.4219 44.5 28.7148 44.5 28.1211 curveto
44.5 26.3203 lineto
43.793 26.3203 lineto
43.793 29.9844 lineto
44.5 29.9844 lineto
 closepath fill
newpath 48.16411 29.1445 moveto
48.0781 29.3281 47.8945 29.4688 47.6875 29.4688 curveto
47.4922 29.4688 47.3047 29.3125 47.3047 29.1055 curveto
47.3047 28.7852 47.72661 28.6445 48.16411 28.4492 curveto
48.5938 28.2539 49.0078 27.9883 49.0078 27.4062 curveto
49.0078 26.71089 48.4297 26.1875 47.7422 26.1875 curveto
47.21089 26.1875 46.6719 26.5 46.47661 27.0156 curveto
47.0781 27.28911 lineto
47.22661 27.0156 47.4062 26.8203 47.7422 26.8203 curveto
48.0469 26.8203 48.3047 27.02339 48.3047 27.33589 curveto
48.3047 27.5352 48.21089 27.6289 48.0469 27.7344 curveto
47.35161 28.1055 lineto
46.9453 28.3242 46.64839 28.5273 46.64839 29.0312 curveto
46.64839 29.625 47.1328 30.0977 47.72661 30.0977 curveto
48.1797 30.0977 48.53911 29.85161 48.7344 29.4531 curveto
 closepath fill
newpath 52.58589 28.9414 moveto
52.3008 29.2656 51.957 29.4375 51.5312 29.4375 curveto
50.8398 29.4375 50.3086 28.8242 50.3086 28.1523 curveto
50.3086 27.39839 50.832 26.85161 51.5781 26.85161 curveto
51.9844 26.85161 52.3164 27.03911 52.58589 27.33589 curveto
52.58589 26.4375 lineto
52.2617 26.2617 51.9375 26.1914 51.5703 26.1914 curveto
50.4883 26.1914 49.6055 27.02339 49.6055 28.1211 curveto
49.6055 29.2539 50.4805 30.0977 51.6094 30.0977 curveto
51.9375 30.0977 52.3008 30.0156 52.58589 29.85161 curveto
 closepath fill
newpath 54.2461 33.1211 moveto
54.2461 29.4922 lineto
54.2617 29.4922 lineto
54.4805 29.8867 54.918 30.0977 55.3633 30.0977 curveto
56.4023 30.0977 56.668 29.39839 56.668 28.5039 curveto
56.668 26.3203 lineto
55.9648 26.3203 lineto
55.9648 28.418 lineto
55.9648 29.043 55.8789 29.4688 55.1523 29.4688 curveto
54.2461 29.4688 54.2461 28.668 54.2461 28.0039 curveto
54.2461 26.3203 lineto
53.53911 26.3203 lineto
53.53911 33.1211 lineto
 closepath fill
newpath 58.5078 29.9844 moveto
58.5078 27.957 lineto
58.5078 27.3672 58.6602 26.85161 59.3555 26.85161 curveto
60.0547 26.85161 60.207 27.3672 60.207 27.957 curveto
60.207 29.9844 lineto
60.9102 29.9844 lineto
60.9102 27.8789 lineto
60.9102 26.875 60.4414 26.1875 59.3555 26.1875 curveto
58.27339 26.1875 57.8047 26.875 57.8047 27.8789 curveto
57.8047 29.9844 lineto
 closepath fill
newpath 62.75 29.4922 moveto
62.7656 29.4922 lineto
62.9883 29.8867 63.4297 30.0977 63.875 30.0977 curveto
64.9102 30.0977 65.1758 29.39839 65.1758 28.5039 curveto
65.1758 26.3203 lineto
64.4688 26.3203 lineto
64.4688 28.418 lineto
64.4688 29.043 64.3828 29.4688 63.66411 29.4688 curveto
62.75 29.4688 62.75 28.668 62.75 28.0039 curveto
62.75 26.3203 lineto
62.0469 26.3203 lineto
62.0469 29.9844 lineto
62.75 29.9844 lineto
 closepath fill
newpath 69.7773 26.3867 moveto
69.7773 25.125 69.41411 24.2148 67.9922 24.2148 curveto
66.9688 24.2148 66.2344 24.8438 66.21489 25.8789 curveto
66.9219 25.8789 lineto
66.9219 25.2188 67.375 24.8438 68.02339 24.8438 curveto
68.8906 24.8438 69.0703 25.4375 69.0703 26.1914 curveto
69.0703 26.8906 lineto
69.0547 26.8906 lineto
68.77339 26.47661 68.3281 26.1914 67.8125 26.1914 curveto
67.9219 26.8203 lineto
68.6875 26.8203 69.1094 27.4297 69.1094 28.1523 curveto
69.1094 28.1523 lineto
69.1094 28.8633 68.6797 29.4688 67.9219 29.4688 curveto
67.1914 29.4688 66.7578 28.832 66.7578 28.1523 curveto
66.7578 27.46089 67.1719 26.8203 67.9219 26.8203 curveto
67.8125 26.1914 lineto
66.6797 26.1914 66.0508 27.125 66.0508 28.1758 curveto
66.0508 29.1758 66.7188 30.0977 67.7812 30.0977 curveto
68.3281 30.0977 68.7656 29.8125 69.0547 29.3594 curveto
69.0703 29.3594 lineto
69.0703 29.9844 lineto
69.7773 29.9844 lineto
 closepath fill
newpath 72.3633 29.1445 moveto
72.2773 29.3281 72.0977 29.4688 71.8945 29.4688 curveto
71.6992 29.4688 71.5117 29.3125 71.5117 29.1055 curveto
71.5117 28.7852 71.9336 28.6445 72.3633 28.4492 curveto
72.7969 28.2539 73.21089 27.9883 73.21089 27.4062 curveto
73.21089 26.71089 72.6328 26.1875 71.9492 26.1875 curveto
71.418 26.1875 70.875 26.5 70.6758 27.0156 curveto
71.2852 27.28911 lineto
71.4336 27.0156 71.6133 26.8203 71.9492 26.8203 curveto
72.2461 26.8203 72.5078 27.02339 72.5078 27.33589 curveto
72.5078 27.5352 72.4102 27.6289 72.2461 27.7344 curveto
71.5586 28.1055 lineto
71.1523 28.3242 70.8477 28.5273 70.8477 29.0312 curveto
70.8477 29.625 71.3398 30.0977 71.9336 30.0977 curveto
72.3828 30.0977 72.7422 29.85161 72.9375 29.4531 curveto
 closepath fill
newpath 74.957 26.3203 moveto
74.2539 26.3203 lineto
74.2539 29.9844 lineto
74.957 29.9844 lineto
 closepath fill
newpath 75.0898 31.66411 moveto
75.0898 31.39839 74.8711 31.1875 74.6055 31.1875 curveto
74.3398 31.1875 74.1211 31.39839 74.1211 31.66411 curveto
74.1211 31.9375 74.3398 32.1562 74.6055 32.1562 curveto
74.8711 32.1562 75.0898 31.9375 75.0898 31.66411 curveto
 closepath fill
newpath 76.9883 29.4922 moveto
77.0078 29.4922 lineto
77.22661 29.8867 77.66411 30.0977 78.1094 30.0977 curveto
79.14839 30.0977 79.41411 29.39839 79.41411 28.5039 curveto
79.41411 26.3203 lineto
78.707 26.3203 lineto
78.707 28.418 lineto
78.707 29.043 78.6211 29.4688 77.89839 29.4688 curveto
76.9883 29.4688 76.9883 28.668 76.9883 28.0039 curveto
76.9883 26.3203 lineto
76.2852 26.3203 lineto
76.2852 29.9844 lineto
76.9883 29.9844 lineto
 closepath fill
newpath 82.0547 29.1445 moveto
81.9688 29.3281 81.78911 29.4688 81.582 29.4688 curveto
81.3867 29.4688 81.1992 29.3125 81.1992 29.1055 curveto
81.1992 28.7852 81.6211 28.6445 82.0547 28.4492 curveto
82.4844 28.2539 82.9023 27.9883 82.9023 27.4062 curveto
82.9023 26.71089 82.3203 26.1875 81.6367 26.1875 curveto
81.1055 26.1875 80.5664 26.5 80.3711 27.0156 curveto
80.9727 27.28911 lineto
81.1211 27.0156 81.3008 26.8203 81.6367 26.8203 curveto
81.9336 26.8203 82.1953 27.02339 82.1953 27.33589 curveto
82.1953 27.5352 82.10161 27.6289 81.9336 27.7344 curveto
81.2461 28.1055 lineto
80.8398 28.3242 80.543 28.5273 80.543 29.0312 curveto
80.543 29.625 81.0273 30.0977 81.6211 30.0977 curveto
82.0703 30.0977 82.4297 29.85161 82.6289 29.4531 curveto
 closepath fill
newpath 84.5938 26.3203 moveto
83.8906 26.3203 lineto
83.8906 29.3281 lineto
83.5078 29.3281 lineto
83.5078 29.9844 lineto
83.8906 29.9844 lineto
83.8906 31.3906 lineto
84.5938 31.3906 lineto
84.5938 29.9844 lineto
85.2852 29.9844 lineto
85.2852 29.3281 lineto
84.5938 29.3281 lineto
 closepath fill
newpath 86.7305 26.3203 moveto
86.0195 26.3203 lineto
86.0195 29.9844 lineto
86.7305 29.9844 lineto
 closepath fill
newpath 86.8633 31.66411 moveto
86.8633 31.39839 86.6406 31.1875 86.3789 31.1875 curveto
86.1055 31.1875 85.8867 31.39839 85.8867 31.66411 curveto
85.8867 31.9375 86.1055 32.1562 86.3789 32.1562 curveto
86.6406 32.1562 86.8633 31.9375 86.8633 31.66411 curveto
 closepath fill
newpath 88.8594 26.3203 moveto
88.1562 26.3203 lineto
88.1562 29.3281 lineto
87.7695 29.3281 lineto
87.7695 29.9844 lineto
88.1562 29.9844 lineto
88.1562 31.3906 lineto
88.8594 31.3906 lineto
88.8594 29.9844 lineto
89.5469 29.9844 lineto
89.5469 29.3281 lineto
88.8594 29.3281 lineto
 closepath fill
newpath 90.8047 29.9844 moveto
90.8047 27.957 lineto
90.8047 27.3672 90.9531 26.85161 91.6523 26.85161 curveto
92.3477 26.85161 92.4961 27.3672 92.4961 27.957 curveto
92.4961 29.9844 lineto
93.2031 29.9844 lineto
93.2031 27.8789 lineto
93.2031 26.875 92.7344 26.1875 91.6523 26.1875 curveto
90.5703 26.1875 90.0977 26.875 90.0977 27.8789 curveto
90.0977 29.9844 lineto
 closepath fill
newpath 95.14839 26.3203 moveto
94.4453 26.3203 lineto
94.4453 29.3281 lineto
94.0586 29.3281 lineto
94.0586 29.9844 lineto
94.4453 29.9844 lineto
94.4453 31.3906 lineto
95.14839 31.3906 lineto
95.14839 29.9844 lineto
95.8398 29.9844 lineto
95.8398 29.3281 lineto
95.14839 29.3281 lineto
 closepath fill
newpath 41.2695 19.46089 moveto
41.2695 17.7031 39.8789 16.3789 38.1719 16.3789 curveto
38.1719 17.0664 lineto
39.4492 17.0664 40.5352 18.1094 40.5352 19.46089 curveto
40.5352 19.46089 lineto
40.5352 20.7617 39.5586 21.85161 38.1719 21.85161 curveto
36.7852 21.85161 35.8125 20.7617 35.8125 19.46089 curveto
35.8125 18.1094 36.8945 17.0664 38.1719 17.0664 curveto
38.1719 16.3789 lineto
36.46089 16.3789 35.0742 17.7031 35.0742 19.46089 curveto
35.0742 21.1523 36.47661 22.543 38.1719 22.543 curveto
39.8633 22.543 41.2695 21.1523 41.2695 19.46089 curveto
 closepath fill
newpath 42.0469 23.3125 moveto
42.75 23.3125 lineto
42.75 19.5625 lineto
42.7656 19.5625 lineto
43.0547 20 43.4961 20.2812 44.0469 20.2812 curveto
45.1055 20.2812 45.7695 19.3672 45.7695 18.3633 curveto
45.7695 17.3125 45.1445 16.3789 44.0117 16.3789 curveto
43.8711 17.0078 lineto
44.6406 17.0078 45.0664 17.6172 45.0664 18.33589 curveto
45.0664 18.33589 lineto
45.0664 19.0547 44.6328 19.6562 43.8711 19.6562 curveto
43.1406 19.6562 42.71089 19.02339 42.71089 18.33589 curveto
42.71089 17.64839 43.1289 17.0078 43.8711 17.0078 curveto
44.0117 16.3789 lineto
43.4961 16.3789 43.0469 16.6602 42.7656 17.0742 curveto
42.75 17.0742 lineto
42.75 16.5039 lineto
42.0469 16.5039 lineto
 closepath fill
newpath 47.0703 18.2188 moveto
47.1094 18.7539 lineto
49.16411 18.7539 lineto
49.0781 19.3047 48.7188 19.6719 48.1563 19.6719 curveto
47.60161 19.6719 47.1953 19.2812 47.1094 18.7539 curveto
47.0703 18.2188 lineto
47.0781 17.5938 47.5 17.0039 48.1797 17.0039 curveto
48.7188 17.0039 49.0078 17.2812 49.2773 17.7188 curveto
49.8711 17.3828 lineto
49.5273 16.7461 48.8828 16.3789 48.1719 16.3789 curveto
47.0469 16.3789 46.3672 17.22661 46.3672 18.3047 curveto
46.3672 19.4375 46.9688 20.2812 48.1563 20.2812 curveto
49.3242 20.2812 49.8711 19.4219 49.8711 18.332 curveto
49.8711 18.2188 lineto
 closepath fill
newpath 51.41411 19.5781 moveto
51.4375 19.5781 lineto
51.6094 20.0078 51.9727 20.2852 52.4414 20.2852 curveto
52.64839 20.2852 52.85161 20.21089 53.02339 20.10161 curveto
52.7031 19.46089 lineto
52.5781 19.5703 52.4336 19.6094 52.2656 19.6094 curveto
51.5078 19.6094 51.41411 18.9023 51.41411 18.3047 curveto
51.41411 16.5039 lineto
50.707 16.5039 lineto
50.707 20.1719 lineto
51.41411 20.1719 lineto
 closepath fill
newpath 55.1758 17.83589 moveto
56.2617 20.3789 lineto
57.33589 17.83589 lineto
58.39839 20.1719 lineto
59.1992 20.1719 lineto
57.33589 16.3789 lineto
56.2617 18.83589 lineto
55.1758 16.3789 lineto
53.3125 20.1719 lineto
54.1133 20.1719 lineto
 closepath fill
newpath 63.3438 18.332 moveto
63.3438 17.22661 62.47661 16.3789 61.3789 16.3789 curveto
60.2852 16.3789 59.418 17.22661 59.418 18.332 curveto
59.418 19.4375 60.2852 20.2812 61.3789 20.2812 curveto
61.3789 19.6094 lineto
60.6836 19.6094 60.1289 19.0312 60.1289 18.332 curveto
60.1289 18.332 lineto
60.1289 17.6406 60.6836 17.0508 61.3789 17.0508 curveto
62.0781 17.0508 62.6328 17.6406 62.6328 18.332 curveto
62.6328 19.0312 62.0781 19.6094 61.3789 19.6094 curveto
61.3789 20.2812 lineto
62.47661 20.2812 63.3438 19.4375 63.3438 18.332 curveto
 closepath fill
newpath 64.21089 16.5039 moveto
64.918 16.5039 lineto
64.918 23.3086 lineto
64.21089 23.3086 lineto
 closepath fill
newpath 67.9375 22.5938 moveto
67.793 22.6602 67.6133 22.7461 67.46489 22.7461 curveto
66.96089 22.7461 66.96089 22.1094 66.96089 21.7461 curveto
66.96089 20.1719 lineto
67.9375 20.1719 lineto
67.9375 19.5156 lineto
66.96089 19.5156 lineto
66.96089 16.5039 lineto
66.2539 16.5039 lineto
66.2539 19.5156 lineto
65.9336 19.5156 lineto
65.9336 20.1719 lineto
66.2539 20.1719 lineto
66.2539 21.9648 lineto
66.2539 22.7617 66.5312 23.4062 67.4414 23.4062 curveto
67.6133 23.4062 67.7773 23.3711 67.9375 23.3086 curveto
 closepath fill
newpath 71.9102 16.5039 moveto
71.2031 16.5039 lineto
71.2031 17.0742 lineto
71.1914 17.0742 lineto
70.9062 16.6602 70.4648 16.3789 69.9414 16.3789 curveto
70.0508 17.0078 lineto
70.8203 17.0078 71.2461 17.6172 71.2461 18.33589 curveto
71.2461 18.33589 lineto
71.2461 19.0547 70.8086 19.6562 70.0508 19.6562 curveto
69.3203 19.6562 68.8906 19.02339 68.8906 18.33589 curveto
68.8906 17.64839 69.3047 17.0078 70.0508 17.0078 curveto
69.9414 16.3789 lineto
68.8203 16.3789 68.1875 17.3125 68.1875 18.3633 curveto
68.1875 19.3672 68.85161 20.2812 69.918 20.2812 curveto
70.457 20.2812 70.89839 20 71.1914 19.5625 curveto
71.2031 19.5625 lineto
71.2031 20.1719 lineto
71.9102 20.1719 lineto
 closepath fill
newpath 75.7227 19.1328 moveto
75.4375 19.4531 75.0898 19.625 74.668 19.625 curveto
73.97661 19.625 73.4453 19.0156 73.4453 18.33589 curveto
73.4453 17.58589 73.9688 17.0352 74.7148 17.0352 curveto
75.1211 17.0352 75.4531 17.22661 75.7227 17.52339 curveto
75.7227 16.6211 lineto
75.39839 16.4492 75.0781 16.3789 74.707 16.3789 curveto
73.625 16.3789 72.7422 17.207 72.7422 18.3047 curveto
72.7422 19.4453 73.6172 20.2812 74.75 20.2812 curveto
75.0781 20.2812 75.4375 20.2031 75.7227 20.03911 curveto
 closepath fill
newpath 77.3828 23.3086 moveto
77.3828 19.6797 lineto
77.39839 19.6797 lineto
77.6172 20.0703 78.0547 20.2852 78.5039 20.2852 curveto
79.53911 20.2852 79.8047 19.58589 79.8047 18.6953 curveto
79.8047 16.5039 lineto
79.10161 16.5039 lineto
79.10161 18.6055 lineto
79.10161 19.2344 79.0156 19.6562 78.293 19.6562 curveto
77.3828 19.6562 77.3828 18.8555 77.3828 18.1875 curveto
77.3828 16.5039 lineto
76.6758 16.5039 lineto
76.6758 23.3086 lineto
 closepath fill
 0 0 0 setrgbcolor
newpath 183.574 21.9219 moveto
183.574 21.625 183.691 21.3867 183.922 21.1953 curveto
184.152 21.0078 184.543 20.91411 185.098 20.91411 curveto
185.391 20.91411 185.633 20.9453 185.824 21.0039 curveto
186.02 21.0664 186.172 21.1523 186.281 21.2617 curveto
186.402 21.3672 186.484 21.5195 186.555 21.707 curveto
186.617 21.89839 186.648 22.1875 186.648 22.5742 curveto
186.648 25.5 lineto
185.836 25.5 lineto
185.836 25.043 lineto
185.586 24.668 lineto
185.727 24.5039 185.797 24.2539 185.797 23.91411 curveto
185.797 23.5898 185.727 23.3477 185.578 23.1836 curveto
185.434 23.0195 185.258 22.9375 185.043 22.9375 curveto
184.848 22.9375 184.684 23.0156 184.551 23.1758 curveto
184.414 23.3398 184.348 23.5898 184.348 23.9375 curveto
184.348 24.2656 184.414 24.5117 184.551 24.6719 curveto
184.551 24.6719 lineto
184.684 24.832 184.855 24.91411 185.062 24.91411 curveto
185.273 24.91411 185.449 24.832 185.586 24.668 curveto
185.836 25.043 lineto
185.574 25.3945 185.242 25.5742 184.84 25.5742 curveto
184.449 25.5742 184.121 25.4297 183.859 25.1406 curveto
183.598 24.85161 183.465 24.4336 183.465 23.8867 curveto
183.465 23.4531 183.566 23.08589 183.766 22.7969 curveto
184.02 22.4219 184.367 22.2344 184.805 22.2344 curveto
185.199 22.2344 185.523 22.41411 185.781 22.7695 curveto
185.781 22.293 lineto
185.781 22.0977 185.773 21.9648 185.742 21.8906 curveto
185.703 21.793 185.645 21.7188 185.57 21.6758 curveto
185.457 21.6055 185.289 21.5742 185.062 21.5742 curveto
184.887 21.5742 184.758 21.6055 184.676 21.66411 curveto
184.617 21.707 184.578 21.7852 184.562 21.9023 curveto
183.578 22.02339 lineto
183.574 21.9805 183.574 21.9453 183.574 21.9219 curveto
 closepath fill
newpath 189.18 22.9219 moveto
189.086 22.8477 188.973 22.8125 188.84 22.8125 curveto
188.641 22.8125 188.477 22.8828 188.34 23.02339 curveto
188.207 23.168 188.141 23.3672 188.133 23.6211 curveto
188.148 24.14839 lineto
188.148 24.3828 188.207 24.5703 188.328 24.707 curveto
188.453 24.8438 188.609 24.91411 188.797 24.91411 curveto
188.973 24.91411 189.121 24.8477 189.246 24.7188 curveto
189.367 24.58589 189.434 24.39839 189.438 24.14839 curveto
188.148 24.14839 lineto
188.133 23.6211 lineto
190.297 23.6211 lineto
190.309 24.2812 190.176 24.77339 189.895 25.0938 curveto
189.617 25.41411 189.23 25.5742 188.746 25.5742 curveto
188.312 25.5742 187.957 25.418 187.672 25.1133 curveto
187.391 24.8086 187.25 24.3867 187.25 23.8438 curveto
187.25 23.3945 187.355 23.0195 187.57 22.7227 curveto
187.844 22.3477 188.266 22.168 188.828 22.168 curveto
189.188 22.168 189.488 22.25 189.73 22.41411 curveto
189.961 22.5781 190.141 22.8164 190.25 23.1328 curveto
189.391 23.2773 lineto
189.34 23.1133 189.273 22.9961 189.18 22.9219 curveto
 closepath fill
newpath 190.938 22.2344 moveto
191.797 22.2344 lineto
191.797 23.8242 lineto
191.797 24.1367 191.82 24.3594 191.867 24.4961 curveto
191.914 24.6289 191.988 24.7344 192.098 24.8047 curveto
192.203 24.8789 192.324 24.91411 192.457 24.91411 curveto
192.566 24.91411 192.652 24.8906 192.719 24.8438 curveto
192.781 24.8008 192.828 24.7305 192.859 24.6406 curveto
192.891 24.5469 192.906 24.3438 192.906 24.0273 curveto
192.906 22.2344 lineto
193.773 22.2344 lineto
193.773 23.8047 lineto
193.773 24.1133 193.793 24.33589 193.84 24.4805 curveto
193.891 24.6211 193.969 24.7305 194.074 24.8008 curveto
194.18 24.875 194.293 24.91411 194.414 24.91411 curveto
194.582 24.91411 194.703 24.85161 194.781 24.7305 curveto
194.844 24.6328 194.871 24.4258 194.871 24.10161 curveto
194.871 22.2344 lineto
195.734 22.2344 lineto
195.734 24.3242 lineto
195.734 24.6328 195.703 24.8594 195.645 25 curveto
195.562 25.1875 195.441 25.3281 195.273 25.4258 curveto
195.109 25.52339 194.906 25.5742 194.668 25.5742 curveto
194.477 25.5742 194.301 25.5312 194.133 25.4453 curveto
193.969 25.3594 193.816 25.22661 193.668 25.0547 curveto
193.574 25.22661 193.449 25.3594 193.289 25.4453 curveto
193.137 25.5312 192.957 25.5742 192.746 25.5742 curveto
192.355 25.5742 192.016 25.39839 191.73 25.0547 curveto
191.73 25.5 lineto
190.938 25.5 lineto
 closepath fill
newpath 198.277 22.9219 moveto
198.184 22.8477 198.07 22.8125 197.934 22.8125 curveto
197.738 22.8125 197.57 22.8828 197.434 23.02339 curveto
197.301 23.168 197.23 23.3672 197.227 23.6211 curveto
197.246 24.14839 lineto
197.242 24.3828 197.301 24.5703 197.422 24.707 curveto
197.547 24.8438 197.703 24.91411 197.891 24.91411 curveto
198.07 24.91411 198.219 24.8477 198.34 24.7188 curveto
198.465 24.58589 198.527 24.39839 198.535 24.14839 curveto
197.246 24.14839 lineto
197.227 23.6211 lineto
199.391 23.6211 lineto
199.402 24.2812 199.27 24.77339 198.988 25.0938 curveto
198.707 25.41411 198.324 25.5742 197.836 25.5742 curveto
197.41 25.5742 197.047 25.418 196.766 25.1133 curveto
196.484 24.8086 196.34 24.3867 196.34 23.8438 curveto
196.34 23.3945 196.449 23.0195 196.664 22.7227 curveto
196.937 22.3477 197.355 22.168 197.926 22.168 curveto
198.285 22.168 198.582 22.25 198.82 22.41411 curveto
199.059 22.5781 199.234 22.8164 199.344 23.1328 curveto
198.484 23.2773 lineto
198.438 23.1133 198.367 22.9961 198.277 22.9219 curveto
 closepath fill
newpath 200.961 26.7422 moveto
200.094 26.7422 lineto
200.094 25.9414 lineto
200.961 25.9414 lineto
 closepath fill
newpath 200.961 25.5 moveto
200.094 25.5 lineto
200.094 22.2422 lineto
200.961 22.2422 lineto
 closepath fill
newpath 204.809 24.2656 moveto
204.809 24.5195 204.797 24.71089 204.762 24.8438 curveto
204.73 24.9805 204.672 25.10161 204.59 25.207 curveto
204.512 25.3164 204.391 25.4023 204.234 25.4688 curveto
204.078 25.53911 203.902 25.5742 203.715 25.5742 curveto
203.281 25.5742 202.922 25.3906 202.637 25.0195 curveto
202.637 25.5 lineto
201.836 25.5 lineto
201.836 22.2344 lineto
202.699 22.2344 lineto
202.699 23.7148 lineto
202.699 24.0781 202.723 24.3281 202.766 24.4648 curveto
202.809 24.60161 202.891 24.707 203.012 24.78911 curveto
203.129 24.8711 203.262 24.91411 203.41 24.91411 curveto
203.527 24.91411 203.629 24.8828 203.711 24.8281 curveto
203.793 24.7695 203.855 24.6914 203.891 24.58589 curveto
203.926 24.4844 203.945 24.2539 203.945 23.9023 curveto
203.945 22.2344 lineto
204.809 22.2344 lineto
 closepath fill
newpath 208.652 24.2656 moveto
208.652 24.5195 208.637 24.71089 208.605 24.8438 curveto
208.574 24.9805 208.516 25.10161 208.434 25.207 curveto
208.355 25.3164 208.234 25.4023 208.078 25.4688 curveto
207.922 25.53911 207.746 25.5742 207.555 25.5742 curveto
207.125 25.5742 206.766 25.3906 206.48 25.0195 curveto
206.48 25.5 lineto
205.68 25.5 lineto
205.68 22.2344 lineto
206.543 22.2344 lineto
206.543 23.7148 lineto
206.543 24.0781 206.566 24.3281 206.609 24.4648 curveto
206.652 24.60161 206.734 24.707 206.852 24.78911 curveto
206.973 24.8711 207.105 24.91411 207.254 24.91411 curveto
207.371 24.91411 207.473 24.8828 207.555 24.8281 curveto
207.637 24.7695 207.699 24.6914 207.734 24.58589 curveto
207.77 24.4844 207.789 24.2539 207.789 23.9023 curveto
207.789 22.2344 lineto
208.652 22.2344 lineto
 closepath fill
newpath 212.477 22.2344 moveto
212.477 25.5 lineto
211.613 25.5 lineto
211.613 24.125 lineto
211.613 23.6562 211.594 23.3633 211.551 23.2461 curveto
211.508 23.125 211.426 23.0273 211.309 22.9453 curveto
211.195 22.8633 211.062 22.8242 210.914 22.8242 curveto
210.785 22.8242 210.68 22.8555 210.594 22.91411 curveto
210.512 22.9727 210.453 23.0547 210.422 23.1602 curveto
210.391 23.2617 210.375 23.543 210.375 24 curveto
210.375 25.5 lineto
209.508 25.5 lineto
209.508 23.4375 lineto
209.508 23.1289 209.551 22.8906 209.629 22.7148 curveto
209.707 22.543 209.832 22.4062 210.008 22.3086 curveto
210.18 22.2148 210.375 22.168 210.594 22.168 curveto
210.809 22.168 211.016 22.2148 211.207 22.3125 curveto
211.402 22.418 211.559 22.5508 211.676 22.72661 curveto
211.676 22.2344 lineto
 closepath fill
newpath 210.703 26.8203 moveto
209.965 26.8203 lineto
209.965 26.082 lineto
210.703 26.082 lineto
 closepath fill
newpath 212.027 26.8203 moveto
211.285 26.8203 lineto
211.285 26.082 lineto
212.027 26.082 lineto
 closepath fill
newpath 214.277 25.5 moveto
214.277 26.6562 lineto
213.414 26.14839 lineto
213.414 25.5 lineto
213.016 25.5 lineto
213.016 24.8125 lineto
213.414 24.8125 lineto
213.414 23.3906 lineto
213.414 23.08589 213.422 22.8828 213.441 22.7812 curveto
213.465 22.6406 213.504 22.5312 213.562 22.4453 curveto
213.621 22.3633 213.711 22.2969 213.836 22.2461 curveto
213.961 22.1875 214.102 22.168 214.258 22.168 curveto
214.512 22.168 214.738 22.21089 214.937 22.293 curveto
214.867 22.9648 lineto
214.715 22.9102 214.598 22.8828 214.52 22.8828 curveto
214.461 22.8828 214.414 22.8945 214.375 22.9219 curveto
214.332 22.9531 214.309 22.9883 214.297 23.0352 curveto
214.285 23.0781 214.277 23.2305 214.277 23.5 curveto
214.277 24.8125 lineto
214.867 24.8125 lineto
214.867 25.5 lineto
 closepath fill
newpath 218.031 22.2344 moveto
218.031 22.9961 lineto
216.695 22.9961 lineto
216.641 22.9961 216.488 22.9922 216.25 22.97661 curveto
216.687 23.4531 lineto
217.938 24.8906 lineto
217.938 25.5 lineto
215.238 25.5 lineto
215.238 24.7852 lineto
216.395 24.78911 lineto
216.559 24.793 216.687 24.7969 216.793 24.8008 curveto
216.691 24.707 216.543 24.543 216.34 24.3164 curveto
215.121 22.9102 lineto
215.121 22.2344 lineto
 closepath fill
newpath 219.477 26.7422 moveto
218.613 26.7422 lineto
218.613 25.9414 lineto
219.477 25.9414 lineto
 closepath fill
newpath 219.477 25.5 moveto
218.613 25.5 lineto
218.613 22.2422 lineto
219.477 22.2422 lineto
 closepath fill
newpath 220.277 21.9219 moveto
220.277 21.625 220.398 21.3867 220.629 21.1953 curveto
220.855 21.0078 221.25 20.91411 221.805 20.91411 curveto
222.098 20.91411 222.34 20.9453 222.527 21.0039 curveto
222.723 21.0664 222.871 21.1523 222.988 21.2617 curveto
223.102 21.3672 223.191 21.5195 223.254 21.707 curveto
223.316 21.89839 223.352 22.1875 223.352 22.5742 curveto
223.352 25.5 lineto
222.543 25.5 lineto
222.543 25.043 lineto
222.297 24.668 lineto
222.434 24.5039 222.504 24.2539 222.504 23.91411 curveto
222.504 23.5898 222.43 23.3477 222.285 23.1836 curveto
222.141 23.0195 221.961 22.9375 221.75 22.9375 curveto
221.555 22.9375 221.391 23.0156 221.258 23.1758 curveto
221.121 23.3398 221.055 23.5898 221.055 23.9375 curveto
221.055 24.2656 221.121 24.5117 221.258 24.6719 curveto
221.258 24.6719 lineto
221.391 24.832 221.559 24.91411 221.766 24.91411 curveto
221.98 24.91411 222.156 24.832 222.297 24.668 curveto
222.543 25.043 lineto
222.281 25.3945 221.949 25.5742 221.547 25.5742 curveto
221.156 25.5742 220.828 25.4297 220.562 25.1406 curveto
220.297 24.85161 220.168 24.4336 220.168 23.8867 curveto
220.168 23.4531 220.27 23.08589 220.473 22.7969 curveto
220.727 22.4219 221.074 22.2344 221.512 22.2344 curveto
221.906 22.2344 222.23 22.41411 222.488 22.7695 curveto
222.488 22.293 lineto
222.488 22.0977 222.477 21.9648 222.449 21.8906 curveto
222.41 21.793 222.352 21.7188 222.277 21.6758 curveto
222.164 21.6055 221.996 21.5742 221.77 21.5742 curveto
221.594 21.5742 221.465 21.6055 221.383 21.66411 curveto
221.324 21.707 221.285 21.7852 221.27 21.9023 curveto
220.281 22.02339 lineto
220.277 21.9805 220.277 21.9453 220.277 21.9219 curveto
 closepath fill
newpath 225.887 22.9219 moveto
225.793 22.8477 225.68 22.8125 225.547 22.8125 curveto
225.348 22.8125 225.18 22.8828 225.047 23.02339 curveto
224.914 23.168 224.848 23.3672 224.84 23.6211 curveto
224.855 24.14839 lineto
224.852 24.3828 224.914 24.5703 225.035 24.707 curveto
225.16 24.8438 225.312 24.91411 225.5 24.91411 curveto
225.68 24.91411 225.828 24.8477 225.949 24.7188 curveto
226.074 24.58589 226.137 24.39839 226.145 24.14839 curveto
224.855 24.14839 lineto
224.84 23.6211 lineto
227 23.6211 lineto
227.012 24.2812 226.879 24.77339 226.598 25.0938 curveto
226.316 25.41411 225.938 25.5742 225.449 25.5742 curveto
225.02 25.5742 224.656 25.418 224.375 25.1133 curveto
224.094 24.8086 223.953 24.3867 223.953 23.8438 curveto
223.953 23.3945 224.062 23.0195 224.273 22.7227 curveto
224.551 22.3477 224.969 22.168 225.535 22.168 curveto
225.895 22.168 226.191 22.25 226.43 22.41411 curveto
226.668 22.5781 226.844 22.8164 226.953 23.1328 curveto
226.094 23.2773 lineto
226.047 23.1133 225.977 22.9961 225.887 22.9219 curveto
 closepath fill
newpath 232.598 23.8945 moveto
232.598 23.3242 lineto
232.461 23.2148 232.297 23.125 232.105 23.0508 curveto
231.91 22.97661 231.719 22.9414 231.527 22.9414 curveto
231.145 22.9414 230.832 23.0742 230.598 23.3398 curveto
230.359 23.6055 230.238 24.0078 230.238 24.543 curveto
230.238 25.0352 230.355 25.4102 230.59 25.6602 curveto
230.824 25.918 231.141 26.043 231.539 26.043 curveto
231.801 26.043 232.023 25.97661 232.195 25.8477 curveto
232.367 25.7188 232.492 25.5469 232.555 25.3242 curveto
233.457 25.4922 lineto
233.367 25.9062 233.164 26.2305 232.852 26.4688 curveto
232.531 26.7031 232.102 26.8203 231.539 26.8203 curveto
231.109 26.8203 230.75 26.7461 230.461 26.5938 curveto
230.082 26.4023 229.793 26.1211 229.598 25.7578 curveto
229.402 25.3906 229.305 24.9727 229.305 24.5039 curveto
229.305 24.0742 229.391 23.6719 229.566 23.3086 curveto
229.742 22.9375 230.004 22.6562 230.355 22.46089 curveto
230.707 22.2578 231.117 22.16411 231.586 22.16411 curveto
231.957 22.16411 232.324 22.2305 232.688 22.375 curveto
233.047 22.5117 233.324 22.6719 233.516 22.8594 curveto
233.516 24.6523 lineto
231.555 24.6523 lineto
231.555 23.8945 lineto
 closepath fill
newpath 234.281 22.2344 moveto
235.145 22.2344 lineto
235.145 23.8242 lineto
235.145 24.1367 235.168 24.3594 235.215 24.4961 curveto
235.258 24.6289 235.336 24.7344 235.441 24.8047 curveto
235.547 24.8789 235.668 24.91411 235.801 24.91411 curveto
235.914 24.91411 236 24.8906 236.066 24.8438 curveto
236.133 24.8008 236.18 24.7305 236.207 24.6406 curveto
236.242 24.5469 236.258 24.3438 236.258 24.0273 curveto
236.258 22.2344 lineto
237.117 22.2344 lineto
237.117 23.8047 lineto
237.117 24.1133 237.141 24.33589 237.191 24.4805 curveto
237.238 24.6211 237.312 24.7305 237.418 24.8008 curveto
237.527 24.875 237.641 24.91411 237.762 24.91411 curveto
237.926 24.91411 238.047 24.85161 238.129 24.7305 curveto
238.188 24.6328 238.219 24.4258 238.219 24.10161 curveto
238.219 22.2344 lineto
239.082 22.2344 lineto
239.082 24.3242 lineto
239.082 24.6328 239.051 24.8594 238.992 25 curveto
238.91 25.1875 238.785 25.3281 238.621 25.4258 curveto
238.453 25.52339 238.25 25.5742 238.012 25.5742 curveto
237.824 25.5742 237.648 25.5312 237.48 25.4453 curveto
237.316 25.3594 237.16 25.22661 237.016 25.0547 curveto
236.918 25.22661 236.793 25.3594 236.641 25.4453 curveto
236.488 25.5312 236.305 25.5742 236.098 25.5742 curveto
235.703 25.5742 235.363 25.39839 235.078 25.0547 curveto
235.078 25.5 lineto
234.281 25.5 lineto
 closepath fill
newpath 240.707 22.2344 moveto
240.707 22.7148 lineto
240.84 22.5352 240.996 22.3945 241.176 22.3008 curveto
241.355 22.21089 241.539 22.168 241.727 22.168 curveto
242.105 22.168 242.426 22.3125 242.691 22.6172 curveto
242.957 22.918 243.09 23.3477 243.09 23.9023 curveto
243.09 24.4414 242.957 24.8555 242.699 25.1406 curveto
242.441 25.4297 242.109 25.5742 241.715 25.5742 curveto
241.348 25.5742 241.035 25.4219 240.77 25.1172 curveto
240.969 24.6719 lineto
241.105 24.832 241.277 24.91411 241.484 24.91411 curveto
241.695 24.91411 241.867 24.832 242.004 24.66411 curveto
242.137 24.5 242.207 24.2344 242.207 23.8594 curveto
242.207 23.5117 242.137 23.2539 242.004 23.0898 curveto
241.871 22.9297 241.707 22.8477 241.516 22.8477 curveto
241.27 22.8477 241.07 22.96089 240.922 23.1914 curveto
240.816 23.35161 240.762 23.60161 240.762 23.9414 curveto
240.762 24.2695 240.832 24.5117 240.969 24.6719 curveto
240.77 25.1172 lineto
240.77 26.7422 lineto
239.906 26.7422 lineto
239.906 22.2344 lineto
 closepath fill
newpath 244.703 22.2344 moveto
244.703 24.207 lineto
246.484 24.207 lineto
246.484 22.2344 lineto
247.395 22.2344 lineto
247.395 26.7422 lineto
246.484 26.7422 lineto
246.484 24.9688 lineto
244.703 24.9688 lineto
244.703 26.7422 lineto
243.793 26.7422 lineto
243.793 22.2344 lineto
 closepath fill
newpath 182.953 30.2461 moveto
182.953 31.6055 lineto
183.688 32.3594 lineto
184.926 30.2461 lineto
186.105 30.2461 lineto
184.316 32.9961 lineto
186.012 34.75 lineto
184.785 34.75 lineto
182.953 32.75 lineto
182.953 34.75 lineto
182.039 34.75 lineto
182.039 30.2461 lineto
 closepath fill
newpath 187.43 34.75 moveto
186.57 34.75 lineto
186.57 30.2461 lineto
187.43 30.2461 lineto
 closepath fill
newpath 189.168 32.832 moveto
189.254 32.8906 189.375 32.9219 189.531 32.9219 curveto
189.754 32.9219 189.906 32.8867 189.992 32.8164 curveto
190.074 32.7461 190.117 32.625 190.117 32.46089 curveto
190.117 32.375 lineto
189.957 32.3086 189.68 32.2383 189.273 32.16411 curveto
188.977 32.1055 188.746 32.03911 188.59 31.96089 curveto
188.43 31.8828 188.309 31.77339 188.219 31.6289 curveto
188.129 31.4844 188.086 31.3203 188.086 31.1367 curveto
188.086 30.8594 188.184 30.6289 188.379 30.4453 curveto
188.57 30.2656 188.836 30.1719 189.172 30.1719 curveto
189.359 30.1719 189.539 30.21089 189.707 30.2812 curveto
189.875 30.3477 190.035 30.46089 190.184 30.6055 curveto
189.875 30.9336 lineto
189.734 30.832 189.582 30.7812 189.43 30.7812 curveto
189.289 30.7812 189.176 30.8242 189.086 30.91411 curveto
188.996 31 188.949 31.1055 188.949 31.22661 curveto
188.949 31.35161 189.004 31.4492 189.117 31.5312 curveto
189.191 31.5781 189.348 31.6289 189.586 31.6797 curveto
189.828 31.7344 190.008 31.7773 190.117 31.8125 curveto
190.117 31.6406 lineto
190.117 31.4336 190.105 31.293 190.078 31.2188 curveto
190.051 31.1094 189.98 31.0117 189.875 30.9336 curveto
190.184 30.6055 lineto
190.191 30.58589 190.199 30.5547 190.215 30.5039 curveto
190.242 30.3906 190.277 30.3047 190.297 30.2461 curveto
191.152 30.2461 lineto
191.074 30.4023 191.023 30.5469 190.996 30.6836 curveto
190.969 30.8203 190.953 31.0312 190.953 31.3203 curveto
190.965 32.3242 lineto
190.965 32.6992 190.926 32.957 190.848 33.0977 curveto
190.773 33.2383 190.641 33.3555 190.453 33.4453 curveto
190.262 33.5352 189.977 33.582 189.586 33.582 curveto
189.164 33.582 188.848 33.5039 188.629 33.3555 curveto
188.414 33.2031 188.266 32.9688 188.176 32.6523 curveto
188.957 32.5117 lineto
189.012 32.66411 189.082 32.7695 189.168 32.832 curveto
 closepath fill
newpath 194.766 30.2461 moveto
194.766 33.5117 lineto
193.902 33.5117 lineto
193.902 32.1328 lineto
193.902 31.66411 193.875 31.3711 193.832 31.2539 curveto
193.789 31.1328 193.711 31.0312 193.594 30.9531 curveto
193.477 30.8711 193.344 30.832 193.199 30.832 curveto
193.07 30.832 192.961 30.8594 192.879 30.9219 curveto
192.797 30.9805 192.738 31.0625 192.707 31.168 curveto
192.672 31.2695 192.66 31.5508 192.66 32.0078 curveto
192.66 33.5117 lineto
191.797 33.5117 lineto
191.797 31.4453 lineto
191.797 31.1367 191.836 30.89839 191.91 30.7227 curveto
191.992 30.5508 192.117 30.41411 192.289 30.3203 curveto
192.465 30.2227 192.66 30.1719 192.879 30.1719 curveto
193.094 30.1719 193.297 30.2227 193.492 30.3242 curveto
193.687 30.4258 193.84 30.5625 193.965 30.7344 curveto
193.965 30.2461 lineto
 closepath fill
newpath 195.863 30.4453 moveto
196.121 30.2656 196.473 30.1719 196.914 30.1719 curveto
197.41 30.1719 197.777 30.2812 198.027 30.4961 curveto
198.277 30.71089 198.402 30.9688 198.402 31.2656 curveto
198.402 31.53911 198.312 31.7539 198.133 31.9102 curveto
197.949 32.0586 197.625 32.1875 197.168 32.293 curveto
196.707 32.39839 196.438 32.47661 196.359 32.5352 curveto
196.305 32.5781 196.273 32.6289 196.273 32.6914 curveto
196.273 32.7617 196.309 32.8203 196.371 32.8672 curveto
196.469 32.9297 196.633 32.96089 196.859 32.96089 curveto
197.039 32.96089 197.18 32.9258 197.277 32.8594 curveto
197.375 32.793 197.445 32.6953 197.473 32.5703 curveto
198.293 32.7188 lineto
198.211 33.0039 198.059 33.2188 197.844 33.3633 curveto
197.625 33.5117 197.293 33.582 196.844 33.582 curveto
196.375 33.582 196.031 33.4844 195.809 33.293 curveto
195.586 33.10161 195.473 32.8633 195.473 32.582 curveto
195.473 32.2656 195.602 32.02339 195.859 31.8477 curveto
196.047 31.7188 196.488 31.5781 197.184 31.4258 curveto
197.332 31.3906 197.43 31.3555 197.473 31.3125 curveto
197.512 31.2695 197.535 31.2148 197.535 31.14839 curveto
197.535 31.0547 197.496 30.97661 197.418 30.918 curveto
197.305 30.83589 197.137 30.7969 196.914 30.7969 curveto
196.715 30.7969 196.555 30.8398 196.445 30.9258 curveto
196.332 31.0156 196.254 31.1406 196.219 31.3086 curveto
195.355 31.1758 lineto
195.434 30.8672 195.602 30.625 195.863 30.4453 curveto
 closepath fill
newpath 202.836 30.2461 moveto
202.836 33.9844 lineto
204.168 33.9844 lineto
204.168 34.75 lineto
200.586 34.75 lineto
200.586 33.9844 lineto
201.926 33.9844 lineto
201.926 30.2461 lineto
 closepath fill
newpath 204.484 30.4453 moveto
204.742 30.2656 205.094 30.1719 205.543 30.1719 curveto
206.031 30.1719 206.402 30.2812 206.652 30.4961 curveto
206.898 30.71089 207.023 30.9688 207.023 31.2656 curveto
207.023 31.53911 206.934 31.7539 206.754 31.9102 curveto
206.574 32.0586 206.254 32.1875 205.793 32.293 curveto
205.332 32.39839 205.062 32.47661 204.984 32.5352 curveto
204.926 32.5781 204.898 32.6289 204.898 32.6914 curveto
204.898 32.7617 204.93 32.8203 205 32.8672 curveto
205.094 32.9297 205.258 32.96089 205.488 32.96089 curveto
205.668 32.96089 205.805 32.9258 205.902 32.8594 curveto
206 32.793 206.066 32.6953 206.102 32.5703 curveto
206.914 32.7188 lineto
206.832 33.0039 206.684 33.2188 206.465 33.3633 curveto
206.25 33.5117 205.918 33.582 205.469 33.582 curveto
205.004 33.582 204.652 33.4844 204.43 33.293 curveto
204.207 33.10161 204.098 32.8633 204.098 32.582 curveto
204.098 32.2656 204.227 32.02339 204.484 31.8477 curveto
204.668 31.7188 205.109 31.5781 205.809 31.4258 curveto
205.961 31.3906 206.055 31.3555 206.098 31.3125 curveto
206.141 31.2695 206.16 31.2148 206.16 31.14839 curveto
206.16 31.0547 206.121 30.97661 206.047 30.918 curveto
205.934 30.83589 205.766 30.7969 205.543 30.7969 curveto
205.34 30.7969 205.18 30.8398 205.066 30.9258 curveto
204.957 31.0156 204.883 31.1406 204.84 31.3086 curveto
203.977 31.1758 lineto
204.055 30.8672 204.227 30.625 204.484 30.4453 curveto
 closepath fill
newpath 210.121 33.3242 moveto
209.887 33.4961 209.57 33.582 209.176 33.582 curveto
208.684 33.582 208.301 33.4336 208.016 33.1289 curveto
207.73 32.832 207.59 32.41411 207.59 31.875 curveto
207.59 31.3438 207.73 30.9258 208.016 30.625 curveto
208.297 30.3242 208.68 30.1719 209.16 30.1719 curveto
209.578 30.1719 209.914 30.2695 210.164 30.4727 curveto
210.414 30.668 210.582 30.9648 210.668 31.35161 curveto
209.82 31.4961 lineto
209.777 31.2695 209.707 31.1094 209.602 31.0156 curveto
209.496 30.9219 209.363 30.875 209.199 30.875 curveto
208.977 30.875 208.801 30.957 208.676 31.1172 curveto
208.543 31.2773 208.477 31.5469 208.477 31.9375 curveto
208.477 32.2852 208.539 32.5312 208.668 32.6797 curveto
208.801 32.8281 208.969 32.9023 209.184 32.9023 curveto
209.344 32.9023 209.48 32.8594 209.582 32.77339 curveto
209.684 32.6875 209.746 32.5586 209.777 32.3906 curveto
210.625 32.543 lineto
210.523 32.8945 210.355 33.1523 210.121 33.3242 curveto
 closepath fill
newpath 211.277 34.75 moveto
211.277 30.2461 lineto
212.141 30.2461 lineto
212.141 31.8789 lineto
212.141 32.1562 212.164 32.3633 212.219 32.5 curveto
212.27 32.6406 212.352 32.7461 212.465 32.8164 curveto
212.578 32.8867 212.711 32.9219 212.848 32.9219 curveto
212.973 32.9219 213.082 32.8945 213.164 32.8398 curveto
213.246 32.7852 213.305 32.71089 213.336 32.6211 curveto
213.367 32.5273 213.387 32.3125 213.387 31.9688 curveto
213.387 30.2461 lineto
214.25 30.2461 lineto
214.25 32.1602 lineto
214.25 32.4531 214.234 32.668 214.203 32.8047 curveto
214.176 32.9453 214.117 33.0742 214.039 33.1875 curveto
213.957 33.3008 213.836 33.39839 213.676 33.4727 curveto
213.52 33.543 213.34 33.582 213.141 33.582 curveto
212.754 33.582 212.418 33.418 212.141 33.0938 curveto
212.141 34.75 lineto
 closepath fill
newpath 215.984 34.75 moveto
215.125 34.75 lineto
215.125 33.9531 lineto
215.984 33.9531 lineto
 closepath fill
newpath 215.984 33.5117 moveto
215.125 33.5117 lineto
215.125 30.2461 lineto
215.984 30.2461 lineto
 closepath fill
newpath 217.699 31.2539 moveto
217.699 31.8086 217.723 32.1719 217.77 32.3477 curveto
217.82 32.5195 217.887 32.6406 217.969 32.707 curveto
218.055 32.77339 218.156 32.8047 218.277 32.8047 curveto
218.402 32.8047 218.535 32.7617 218.68 32.66411 curveto
218.949 33.418 lineto
218.766 33.5273 218.578 33.582 218.379 33.582 curveto
218.242 33.582 218.117 33.5469 218.008 33.47661 curveto
217.898 33.4062 217.773 33.2617 217.637 33.043 curveto
217.637 33.5117 lineto
216.836 33.5117 lineto
216.836 30.2461 lineto
217.699 30.2461 lineto
 closepath fill
newpath 220.172 32.832 moveto
220.258 32.8906 220.379 32.9219 220.531 32.9219 curveto
220.762 32.9219 220.918 32.8867 221 32.8164 curveto
221.082 32.7461 221.121 32.625 221.121 32.46089 curveto
221.121 32.375 lineto
220.965 32.3086 220.687 32.2383 220.281 32.16411 curveto
219.98 32.1055 219.754 32.03911 219.594 31.96089 curveto
219.438 31.8828 219.312 31.77339 219.227 31.6289 curveto
219.137 31.4844 219.094 31.3203 219.094 31.1367 curveto
219.094 30.8594 219.187 30.6289 219.383 30.4453 curveto
219.574 30.2656 219.84 30.1719 220.176 30.1719 curveto
220.367 30.1719 220.551 30.21089 220.719 30.2812 curveto
220.887 30.3477 221.043 30.46089 221.191 30.6055 curveto
220.883 30.9336 lineto
220.738 30.832 220.594 30.7812 220.438 30.7812 curveto
220.293 30.7812 220.18 30.8242 220.09 30.91411 curveto
220 31 219.953 31.1055 219.953 31.22661 curveto
219.953 31.35161 220.012 31.4492 220.125 31.5312 curveto
220.195 31.5781 220.355 31.6289 220.598 31.6797 curveto
220.836 31.7344 221.012 31.7773 221.121 31.8125 curveto
221.121 31.6406 lineto
221.121 31.4336 221.109 31.293 221.09 31.2188 curveto
221.055 31.1094 220.988 31.0117 220.883 30.9336 curveto
221.191 30.6055 lineto
221.195 30.58589 221.207 30.5547 221.219 30.5039 curveto
221.254 30.3906 221.281 30.3047 221.305 30.2461 curveto
222.156 30.2461 lineto
222.082 30.4023 222.027 30.5469 222 30.6836 curveto
221.973 30.8203 221.961 31.0312 221.961 31.3203 curveto
221.969 32.3242 lineto
221.969 32.6992 221.93 32.957 221.855 33.0977 curveto
221.777 33.2383 221.645 33.3555 221.457 33.4453 curveto
221.27 33.5352 220.98 33.582 220.598 33.582 curveto
220.172 33.582 219.852 33.5039 219.637 33.3555 curveto
219.422 33.2031 219.27 32.9688 219.18 32.6523 curveto
219.965 32.5117 lineto
220.016 32.66411 220.086 32.7695 220.172 32.832 curveto
 closepath fill
newpath 224.891 30.5625 moveto
225.195 30.2969 225.633 30.168 226.203 30.168 curveto
226.594 30.168 226.918 30.2227 227.184 30.332 curveto
227.441 30.4414 227.645 30.6094 227.789 30.832 curveto
227.934 31.0586 228.004 31.3008 228.004 31.5586 curveto
228.004 31.8438 227.945 32.082 227.824 32.27339 curveto
227.703 32.4688 227.539 32.6211 227.328 32.7344 curveto
227.113 32.8438 226.789 32.9531 226.348 33.0547 curveto
225.906 33.1602 225.625 33.2617 225.512 33.3555 curveto
225.422 33.4336 225.375 33.52339 225.375 33.6328 curveto
225.375 33.7461 225.426 33.8438 225.52 33.91411 curveto
225.668 34.0195 225.875 34.0742 226.141 34.0742 curveto
226.398 34.0742 226.59 34.02339 226.719 33.9258 curveto
226.844 33.8203 226.93 33.6523 226.969 33.4219 curveto
227.875 33.46089 lineto
227.863 33.8789 227.711 34.207 227.426 34.457 curveto
227.141 34.7031 226.715 34.8281 226.148 34.8281 curveto
225.805 34.8281 225.508 34.7773 225.266 34.6719 curveto
225.02 34.5664 224.832 34.41411 224.703 34.2148 curveto
224.57 34.0156 224.508 33.8008 224.508 33.5703 curveto
224.508 33.21089 224.645 32.9102 224.922 32.66411 curveto
225.117 32.4883 225.461 32.3398 225.945 32.2188 curveto
226.324 32.125 226.57 32.0586 226.676 32.02339 curveto
226.828 31.9648 226.938 31.9023 227 31.8281 curveto
227.066 31.7539 227.094 31.6602 227.094 31.5547 curveto
227.094 31.3906 227.02 31.2461 226.871 31.1211 curveto
226.727 30.9961 226.504 30.9336 226.211 30.9336 curveto
225.934 30.9336 225.715 31.0039 225.555 31.1445 curveto
225.391 31.2812 225.281 31.5 225.23 31.7969 curveto
224.348 31.71089 lineto
224.402 31.207 224.586 30.8242 224.891 30.5625 curveto
 closepath fill
newpath 229.672 33.5117 moveto
229.672 34.6602 lineto
228.805 34.1602 lineto
228.805 33.5117 lineto
228.406 33.5117 lineto
228.406 32.8203 lineto
228.805 32.8203 lineto
228.805 31.39839 lineto
228.805 31.0938 228.816 30.8906 228.832 30.78911 curveto
228.855 30.64839 228.898 30.53911 228.953 30.4531 curveto
229.012 30.3711 229.105 30.3047 229.23 30.2539 curveto
229.355 30.1992 229.492 30.1719 229.648 30.1719 curveto
229.902 30.1719 230.129 30.2148 230.332 30.3008 curveto
230.258 30.9727 lineto
230.105 30.918 229.992 30.8906 229.91 30.8906 curveto
229.855 30.8906 229.805 30.9023 229.766 30.9336 curveto
229.727 30.96089 229.699 30.9961 229.687 31.03911 curveto
229.676 31.08589 229.672 31.2422 229.672 31.5039 curveto
229.672 32.8203 lineto
230.262 32.8203 lineto
230.262 33.5117 lineto
 closepath fill
newpath 231.723 34.75 moveto
230.859 34.75 lineto
230.859 33.9531 lineto
231.723 33.9531 lineto
 closepath fill
newpath 231.723 33.5117 moveto
230.859 33.5117 lineto
230.859 30.2461 lineto
231.723 30.2461 lineto
 closepath fill
newpath 232.23 32.8281 moveto
232.711 32.8281 lineto
232.711 30.2461 lineto
233.574 30.2461 lineto
233.574 32.8281 lineto
234.219 32.8281 lineto
234.219 33.5117 lineto
233.574 33.5117 lineto
233.574 33.7383 lineto
233.574 33.9023 233.602 34.0195 233.656 34.0781 curveto
233.707 34.1367 233.797 34.16411 233.922 34.16411 curveto
234.051 34.16411 234.184 34.1445 234.32 34.1172 curveto
234.437 34.7188 lineto
234.199 34.78911 233.961 34.8281 233.715 34.8281 curveto
233.477 34.8281 233.277 34.7852 233.121 34.6992 curveto
232.965 34.6172 232.855 34.5039 232.797 34.3711 curveto
232.738 34.2344 232.711 34.0312 232.711 33.7578 curveto
232.711 33.5117 lineto
232.23 33.5117 lineto
 closepath fill
newpath 235.613 33.5117 moveto
235.613 34.6602 lineto
234.742 34.1602 lineto
234.742 33.5117 lineto
234.348 33.5117 lineto
234.348 32.8203 lineto
234.742 32.8203 lineto
234.742 31.39839 lineto
234.742 31.0938 234.75 30.8906 234.77 30.78911 curveto
234.793 30.64839 234.832 30.53911 234.891 30.4531 curveto
234.949 30.3711 235.043 30.3047 235.164 30.2539 curveto
235.289 30.1992 235.43 30.1719 235.586 30.1719 curveto
235.84 30.1719 236.07 30.2148 236.273 30.3008 curveto
236.199 30.9727 lineto
236.043 30.918 235.926 30.8906 235.848 30.8906 curveto
235.789 30.8906 235.746 30.9023 235.703 30.9336 curveto
235.664 30.96089 235.637 30.9961 235.625 31.03911 curveto
235.617 31.08589 235.613 31.2422 235.613 31.5039 curveto
235.613 32.8203 lineto
236.203 32.8203 lineto
236.203 33.5117 lineto
 closepath fill
newpath 239.75 30.2461 moveto
239.75 33.5117 lineto
238.883 33.5117 lineto
238.883 32.1328 lineto
238.883 31.66411 238.863 31.3711 238.82 31.2539 curveto
238.777 31.1328 238.695 31.0312 238.578 30.9531 curveto
238.461 30.8711 238.332 30.832 238.184 30.832 curveto
238.055 30.832 237.949 30.8594 237.863 30.9219 curveto
237.781 30.9805 237.723 31.0625 237.691 31.168 curveto
237.66 31.2695 237.645 31.5508 237.645 32.0078 curveto
237.645 33.5117 lineto
236.781 33.5117 lineto
236.781 31.4453 lineto
236.781 31.1367 236.82 30.89839 236.898 30.7227 curveto
236.977 30.5508 237.102 30.41411 237.277 30.3203 curveto
237.449 30.2227 237.645 30.1719 237.863 30.1719 curveto
238.078 30.1719 238.285 30.2227 238.477 30.3242 curveto
238.672 30.4258 238.828 30.5625 238.945 30.7344 curveto
238.945 30.2461 lineto
 closepath fill
newpath 243.613 32.27339 moveto
243.613 32.52339 243.59 32.7188 243.559 32.8555 curveto
243.531 32.9883 243.473 33.1094 243.391 33.2148 curveto
243.309 33.3203 243.191 33.4102 243.035 33.47661 curveto
242.875 33.5469 242.703 33.582 242.512 33.582 curveto
242.082 33.582 241.723 33.39839 241.438 33.0273 curveto
241.438 33.5117 lineto
240.637 33.5117 lineto
240.637 30.2461 lineto
241.5 30.2461 lineto
241.5 31.7227 lineto
241.5 32.0898 241.52 32.33589 241.566 32.4727 curveto
241.609 32.6094 241.691 32.7148 241.809 32.7969 curveto
241.926 32.8789 242.062 32.9219 242.211 32.9219 curveto
242.328 32.9219 242.426 32.8945 242.512 32.83589 curveto
242.594 32.7773 242.652 32.6992 242.691 32.5938 curveto
242.727 32.4922 242.746 32.2617 242.746 31.9102 curveto
242.746 30.2461 lineto
243.613 30.2461 lineto
 closepath fill
newpath 244.402 29.9297 moveto
244.402 29.6367 244.52 29.3945 244.75 29.2031 curveto
244.98 29.0156 245.375 28.9219 245.926 28.9219 curveto
246.219 28.9219 246.461 28.9531 246.652 29.0117 curveto
246.844 29.0742 246.996 29.1602 247.109 29.2695 curveto
247.223 29.375 247.312 29.5273 247.383 29.7188 curveto
247.445 29.9062 247.473 30.1992 247.473 30.582 curveto
247.473 33.5117 lineto
246.664 33.5117 lineto
246.664 33.0508 lineto
246.418 32.6758 lineto
246.555 32.5117 246.625 32.2617 246.625 31.9219 curveto
246.625 31.60161 246.551 31.3555 246.406 31.1914 curveto
246.262 31.0273 246.086 30.9453 245.875 30.9453 curveto
245.676 30.9453 245.512 31.02339 245.379 31.1875 curveto
245.242 31.3438 245.176 31.5977 245.176 31.9453 curveto
245.176 32.27339 245.242 32.5195 245.379 32.6797 curveto
245.379 32.6797 lineto
245.512 32.8398 245.684 32.9219 245.887 32.9219 curveto
246.102 32.9219 246.277 32.8398 246.418 32.6758 curveto
246.664 33.0508 lineto
246.402 33.4023 246.07 33.582 245.668 33.582 curveto
245.277 33.582 244.949 33.4375 244.688 33.14839 curveto
244.426 32.8594 244.293 32.4414 244.293 31.8945 curveto
244.293 31.46089 244.395 31.0938 244.594 30.8008 curveto
244.848 30.4336 245.195 30.2461 245.633 30.2461 curveto
246.027 30.2461 246.352 30.4219 246.609 30.7773 curveto
246.609 30.3008 lineto
246.609 30.1055 246.598 29.9727 246.57 29.89839 curveto
246.531 29.8047 246.473 29.72661 246.398 29.6836 curveto
246.285 29.6133 246.117 29.582 245.891 29.582 curveto
245.715 29.582 245.586 29.6133 245.504 29.6758 curveto
245.445 29.7188 245.41 29.7969 245.391 29.91411 curveto
244.406 30.0273 lineto
244.406 29.9883 244.402 29.957 244.402 29.9297 curveto
 closepath fill
newpath 285.82 15.3398 moveto
285.82 16.6836 lineto
286.547 17.4297 lineto
287.77301 15.3398 lineto
288.93799 15.3398 lineto
287.168 18.0586 lineto
288.84799 19.7969 lineto
287.637 19.7969 lineto
285.82 17.8164 lineto
285.82 19.7969 lineto
284.918 19.7969 lineto
284.918 15.3398 lineto
 closepath fill
newpath 291.68 15.3398 moveto
291.68 19.043 lineto
293 19.043 lineto
293 19.7969 lineto
289.461 19.7969 lineto
289.461 19.043 lineto
290.781 19.043 lineto
290.781 15.3398 lineto
 closepath fill
newpath 294.27301 15.6484 moveto
294.574 15.3906 295.008 15.2578 295.57 15.2578 curveto
295.957 15.2578 296.27701 15.3125 296.539 15.4219 curveto
296.797 15.5312 297 15.6953 297.14099 15.918 curveto
297.281 16.1406 297.35199 16.3789 297.35199 16.6367 curveto
297.35199 16.918 297.297 17.1523 297.18 17.3438 curveto
297.05899 17.5352 296.89099 17.6875 296.68399 17.7969 curveto
296.47299 17.9062 296.14801 18.0156 295.711 18.1172 curveto
295.27301 18.2227 295 18.3242 294.887 18.418 curveto
294.797 18.4961 294.75 18.58589 294.75 18.6914 curveto
294.75 18.8047 294.801 18.89839 294.89499 18.9688 curveto
295.043 19.0742 295.246 19.1289 295.508 19.1289 curveto
295.762 19.1289 295.949 19.0781 296.078 18.97661 curveto
296.203 18.8789 296.285 18.71089 296.324 18.4844 curveto
297.22699 18.52339 lineto
297.215 18.9336 297.06201 19.2617 296.77701 19.5039 curveto
296.496 19.75 296.074 19.8711 295.51599 19.8711 curveto
295.176 19.8711 294.883 19.8203 294.64099 19.7188 curveto
294.39801 19.6133 294.215 19.4648 294.086 19.2656 curveto
293.957 19.0703 293.89099 18.8555 293.89099 18.6289 curveto
293.89099 18.27339 294.02701 17.97661 294.301 17.7305 curveto
294.496 17.5547 294.836 17.4062 295.31601 17.28911 curveto
295.69101 17.1953 295.93 17.1328 296.035 17.0938 curveto
296.19101 17.03911 296.301 16.97661 296.35901 16.9023 curveto
296.422 16.8281 296.453 16.7383 296.453 16.6328 curveto
296.453 16.4688 296.379 16.3242 296.23401 16.2031 curveto
296.086 16.082 295.867 16.0195 295.578 16.0195 curveto
295.305 16.0195 295.09 16.0898 294.926 16.22661 curveto
294.76599 16.3633 294.656 16.5781 294.60501 16.8711 curveto
293.73001 16.78911 lineto
293.789 16.28911 293.969 15.9102 294.27301 15.6484 curveto
 closepath fill
 0.8706 0.8667 0.8706 setrgbcolor
newpath 269.504 22.1836 moveto
282.578 22.1836 lineto
282.578 35.1875 lineto
269.504 35.1875 lineto
 closepath fill
 0 0 0 setrgbcolor
newpath 262.77301 15.6992 moveto
268.89099 21.77339 lineto
268.81201 21.8906 268.76999 22.0312 268.76999 22.1836 curveto
268.76999 22.60161 269.09799 22.9375 269.504 22.9375 curveto
269.656 22.9375 269.801 22.8867 269.918 22.8047 curveto
272.574 25.4375 lineto
269.953 28.0703 lineto
269.828 27.9727 269.672 27.91411 269.504 27.91411 curveto
269.10199 27.91411 268.77301 28.2539 268.77301 28.66411 curveto
268.77301 28.832 268.824 28.9883 268.914 29.1133 curveto
262.738 35.3242 lineto
268.789 35.3242 lineto
268.85199 35.6719 269.14801 35.9375 269.508 35.9375 curveto
269.867 35.9375 270.168 35.6719 270.23401 35.3242 curveto
275.27301 35.3242 lineto
275.332 35.6719 275.633 35.9414 275.992 35.9414 curveto
276.35501 35.9414 276.65201 35.6719 276.715 35.3242 curveto
281.863 35.3242 lineto
281.922 35.6719 282.22299 35.9375 282.582 35.9375 curveto
282.988 35.9375 283.31601 35.60161 283.31601 35.1875 curveto
283.31601 34.8164 283.055 34.5117 282.711 34.4492 curveto
282.445 34.4492 lineto
282.332 34.4727 282.238 34.5156 282.156 34.5781 curveto
276.613 29.0742 lineto
276.68799 28.957 276.72699 28.8203 276.72699 28.6719 curveto
276.72699 28.2578 276.39801 27.9219 275.996 27.9219 curveto
275.844 27.9219 275.703 27.9688 275.586 28.0508 curveto
272.953 25.4336 lineto
272.76599 25.625 lineto
275.39499 28.2383 lineto
275.31201 28.3633 275.262 28.5117 275.262 28.6719 curveto
275.262 29.08589 275.59 29.4219 275.996 29.4219 curveto
276.16 29.4219 276.31201 29.3672 276.43399 29.27339 curveto
281.965 34.77339 lineto
281.918 34.8594 281.875 34.9531 281.863 35.0547 curveto
276.715 35.0547 lineto
276.65201 34.7031 276.35501 34.4375 275.992 34.4375 curveto
275.633 34.4375 275.336 34.7031 275.27301 35.0547 curveto
270.23401 35.0547 lineto
270.168 34.7031 269.871 34.4375 269.508 34.4375 curveto
269.14801 34.4375 268.84799 34.7031 268.789 35.0547 curveto
263.387 35.0547 lineto
269.10901 29.2969 lineto
269.22299 29.3711 269.35901 29.41411 269.504 29.41411 curveto
269.91 29.41411 270.238 29.082 270.238 28.66411 curveto
270.238 28.52339 270.199 28.3867 270.129 28.27339 curveto
272.76599 25.625 lineto
272.953 25.4336 lineto
275.578 22.8008 lineto
275.699 22.8828 275.84 22.9336 275.996 22.9336 curveto
276.40201 22.9336 276.73001 22.5938 276.73001 22.1797 curveto
276.73001 22.02339 276.68399 21.8828 276.60501 21.7617 curveto
282.445 15.8984 lineto
282.445 21.4414 lineto
282.10501 21.5078 281.844 21.8125 281.844 22.1758 curveto
281.844 22.5469 282.10501 22.85161 282.445 22.918 curveto
282.445 27.9336 lineto
282.10901 28 281.84799 28.3047 281.84799 28.668 curveto
281.84799 29.0312 282.10901 29.33589 282.445 29.4062 curveto
282.445 34.4492 lineto
282.711 34.4492 lineto
282.711 29.4062 lineto
283.055 29.3477 283.32 29.03911 283.32 28.668 curveto
283.32 28.2969 283.055 27.9883 282.711 27.9297 curveto
282.711 22.9219 lineto
283.055 22.8555 283.31201 22.5508 283.31201 22.1758 curveto
283.31201 21.8086 283.055 21.5039 282.711 21.4375 curveto
282.711 15.25 lineto
276.422 21.5664 lineto
276.301 21.4805 276.156 21.4297 275.996 21.4297 curveto
275.59 21.4297 275.262 21.7656 275.262 22.1797 curveto
275.262 22.3398 275.31201 22.4844 275.39099 22.6055 curveto
272.762 25.2461 lineto
270.10901 22.6094 lineto
270.19101 22.4883 270.238 22.3398 270.238 22.1836 curveto
270.238 21.7695 269.906 21.4336 269.504 21.4336 curveto
269.34 21.4336 269.19101 21.4844 269.07 21.5781 curveto
263.15201 15.6992 lineto
 closepath fill
newpath 255.535 43.2031 moveto
255.535 7.5664 lineto
 closepath fill
 0.2118 0.2118 0.2118 setrgbcolor 0.42944
 0 dtransform exch truncate exch idtransform pop setlinewidth
newpath 255.535 43.2031 moveto
255.535 7.5664 lineto stroke
 0.302 0.302 0.302 setrgbcolor
newpath 102.738 10.1172 moveto
102.738 10.5078 lineto
101.297 10.5078 lineto
101.297 13.3125 lineto
100.859 13.3125 lineto
100.859 10.1172 lineto
 closepath fill
newpath 105.488 11.5 moveto
105.488 11.7969 105.402 12.0352 105.215 12.2148 curveto
105.02301 12.4023 104.766 12.4961 104.43 12.4961 curveto
104.14801 12.4961 103.89801 12.3945 103.688 12.1875 curveto
103.453 11.9531 103.336 11.6445 103.336 11.2617 curveto
103.336 10.8906 103.453 10.5898 103.68 10.3711 curveto
103.887 10.1719 104.133 10.0742 104.42601 10.0742 curveto
104.629 10.0742 104.81601 10.1016 104.98 10.1641 curveto
105.113 10.2109 105.211 10.2656 105.277 10.332 curveto
105.10199 10.6289 lineto
104.94101 10.4961 104.746 10.4219 104.508 10.4219 curveto
104.30101 10.4219 104.129 10.4844 104 10.6172 curveto
103.848 10.7578 103.77301 10.9727 103.77301 11.2461 curveto
103.785 11.5469 lineto
103.80101 11.7148 103.867 11.8555 103.988 11.9688 curveto
104.113 12.0898 104.266 12.1484 104.44899 12.1484 curveto
104.64801 12.1484 104.805 12.0898 104.918 11.9648 curveto
104.918 11.9648 lineto
105.02301 11.8555 105.078 11.7148 105.078 11.5469 curveto
103.785 11.5469 lineto
103.77301 11.2461 lineto
105.457 11.2461 lineto
105.48 11.3242 105.488 11.4102 105.488 11.5 curveto
 closepath fill
newpath 106.57399 13.2617 moveto
106.527 13.2148 106.504 13.1523 106.504 13.082 curveto
106.504 13.0117 106.527 12.9492 106.578 12.8984 curveto
106.629 12.8477 106.688 12.8242 106.758 12.8242 curveto
106.828 12.8242 106.891 12.8477 106.938 12.8984 curveto
106.988 12.9492 107.016 13.0117 107.016 13.082 curveto
107.016 13.1523 106.988 13.2109 106.938 13.2617 curveto
106.891 13.3125 106.828 13.3359 106.758 13.3359 curveto
106.688 13.3359 106.625 13.3125 106.57399 13.2617 curveto
 closepath fill
newpath 106.945 10.1172 moveto
106.945 12.4531 lineto
106.211 12.4531 lineto
106.211 12.1055 lineto
106.53099 12.1055 lineto
106.53099 10.1172 lineto
 closepath fill
newpath 108.60199 10.1367 moveto
108.707 10.0938 108.81601 10.0742 108.92601 10.0742 curveto
109.27 10.0742 109.535 10.1836 109.738 10.4102 curveto
109.938 10.6289 110.035 10.9414 110.035 11.332 curveto
110.035 11.668 109.938 11.9453 109.738 12.168 curveto
109.535 12.3867 109.28099 12.4961 108.957 12.4961 curveto
108.855 12.4961 108.746 12.4766 108.641 12.4297 curveto
108.53099 12.3828 108.457 12.3359 108.418 12.2812 curveto
108.598 12.082 lineto
108.688 12.1289 108.758 12.1484 108.80899 12.1484 curveto
109.047 12.1484 109.242 12.0742 109.383 11.9258 curveto
109.53099 11.7773 109.60199 11.5742 109.60199 11.3086 curveto
109.60199 10.9922 109.535 10.7578 109.414 10.625 curveto
109.293 10.4922 109.09 10.4219 108.80899 10.4219 curveto
108.754 10.4219 108.67601 10.4531 108.57399 10.5 curveto
108.46901 10.5547 108.418 10.5938 108.418 10.6211 curveto
108.418 11.9648 lineto
108.445 12 108.504 12.0391 108.598 12.082 curveto
108.598 12.082 lineto
108.418 12.2812 lineto
108.418 13.4102 lineto
108.004 13.4102 lineto
108.004 10.0742 lineto
108.211 10.0742 lineto
108.355 10.2891 lineto
108.41 10.2266 108.492 10.1758 108.60199 10.1367 curveto
 closepath fill
newpath 112.746 10.1172 moveto
112.746 11.5625 lineto
112.746 12.1875 112.488 12.4961 111.98 12.4961 curveto
111.668 12.4961 111.44899 12.3828 111.30899 12.1523 curveto
111.18 12.4531 lineto
110.895 12.4531 lineto
110.895 10.1172 lineto
111.30899 10.1172 lineto
111.30899 11.8555 lineto
111.367 11.9375 111.445 12.0078 111.547 12.0625 curveto
111.652 12.1211 111.75 12.1484 111.84401 12.1484 curveto
112.02 12.1484 112.145 12.0977 112.21901 12 curveto
112.297 11.8984 112.332 11.7266 112.332 11.4766 curveto
112.332 10.1172 lineto
 closepath fill
newpath 113.984 13.2617 moveto
113.938 13.2148 113.91 13.1523 113.91 13.082 curveto
113.91 13.0117 113.938 12.9492 113.988 12.8984 curveto
114.039 12.8477 114.098 12.8242 114.168 12.8242 curveto
114.238 12.8242 114.30101 12.8477 114.348 12.8984 curveto
114.39801 12.9492 114.42601 13.0117 114.42601 13.082 curveto
114.42601 13.1523 114.39801 13.2109 114.348 13.2617 curveto
114.30101 13.3125 114.238 13.3359 114.168 13.3359 curveto
114.09401 13.3359 114.035 13.3125 113.984 13.2617 curveto
 closepath fill
newpath 114.355 10.1172 moveto
114.355 12.4531 lineto
113.621 12.4531 lineto
113.621 12.1055 lineto
113.94101 12.1055 lineto
113.94101 10.1172 lineto
 closepath fill
newpath 117.137 12.3359 moveto
117.137 12.4531 lineto
115.23 12.4531 lineto
115.23 12.082 lineto
116.535 12.082 lineto
115.207 10.2266 lineto
115.207 10.1172 lineto
117.15599 10.1172 lineto
117.15599 10.4922 lineto
115.855 10.4922 lineto
 closepath fill
newpath 118.922 11.6055 moveto
117.988 11.6055 lineto
117.988 11.2227 lineto
118.922 11.2227 lineto
 closepath fill
newpath 121.414 13.3672 moveto
120.93399 13.3672 120.555 13.2148 120.277 12.9062 curveto
119.996 12.5977 119.859 12.1992 119.859 11.7031 curveto
119.859 11.2109 119.984 10.8125 120.242 10.5078 curveto
120.496 10.2109 120.84401 10.0625 121.285 10.0625 curveto
121.484 10.0625 121.68399 10.0938 121.895 10.1523 curveto
122.10199 10.2109 122.262 10.293 122.379 10.3906 curveto
122.379 11.7852 lineto
121.5 11.7852 lineto
121.5 11.4141 lineto
121.945 11.4141 lineto
121.945 10.6641 lineto
121.797 10.5234 121.609 10.4531 121.379 10.4531 curveto
121.047 10.4531 120.793 10.5703 120.598 10.793 curveto
120.41 11.0195 120.31601 11.3164 120.31601 11.6875 curveto
120.31601 12.0742 120.414 12.3867 120.605 12.6211 curveto
120.797 12.8555 121.06601 12.9727 121.39801 12.9727 curveto
121.609 12.9727 121.82399 12.8945 122.047 12.7305 curveto
122.22699 13.0898 lineto
122.016 13.2734 121.746 13.3672 121.414 13.3672 curveto
 closepath fill
newpath 125.402 11.5 moveto
125.402 11.7969 125.312 12.0352 125.129 12.2148 curveto
124.94101 12.4023 124.67601 12.4961 124.34401 12.4961 curveto
124.05899 12.4961 123.80899 12.3945 123.60199 12.1875 curveto
123.367 11.9531 123.25 11.6445 123.25 11.2617 curveto
123.25 10.8906 123.363 10.5898 123.59 10.3711 curveto
123.797 10.1719 124.043 10.0742 124.34 10.0742 curveto
124.547 10.0742 124.72699 10.1016 124.891 10.1641 curveto
125.027 10.2109 125.125 10.2656 125.188 10.332 curveto
125.012 10.6289 lineto
124.85199 10.4961 124.66 10.4219 124.422 10.4219 curveto
124.211 10.4219 124.043 10.4844 123.91 10.6172 curveto
123.758 10.7578 123.68399 10.9727 123.68399 11.2461 curveto
123.695 11.5469 lineto
123.711 11.7148 123.777 11.8555 123.89801 11.9688 curveto
124.02301 12.0898 124.17601 12.1484 124.363 12.1484 curveto
124.55899 12.1484 124.715 12.0898 124.836 11.9648 curveto
124.836 11.9648 lineto
124.938 11.8555 124.992 11.7148 124.992 11.5469 curveto
123.695 11.5469 lineto
123.68399 11.2461 lineto
125.371 11.2461 lineto
125.391 11.3242 125.402 11.4102 125.402 11.5 curveto
 closepath fill
newpath 129.359 10.1172 moveto
129.359 11.6797 lineto
129.359 11.9375 129.297 12.1406 129.164 12.2852 curveto
129.031 12.4258 128.844 12.4961 128.598 12.4961 curveto
128.469 12.4961 128.34 12.4688 128.207 12.4102 curveto
128.082 12.3477 127.996 12.2734 127.94899 12.1875 curveto
127.81601 12.3945 127.582 12.4961 127.246 12.4961 curveto
127.008 12.4961 126.80899 12.3945 126.64801 12.1836 curveto
126.512 12.4531 lineto
126.242 12.4531 lineto
126.242 10.1172 lineto
126.652 10.1172 lineto
126.652 11.8438 lineto
126.695 11.918 126.762 11.9883 126.855 12.0547 curveto
126.94899 12.1172 127.035 12.1484 127.117 12.1484 curveto
127.262 12.1484 127.375 12.1172 127.465 12.0508 curveto
127.547 11.9844 127.59 11.8945 127.59 11.7773 curveto
127.59 10.1172 lineto
128.008 10.1172 lineto
128.008 11.8477 lineto
128.039 11.9258 128.098 11.9961 128.184 12.0547 curveto
128.273 12.1172 128.367 12.1484 128.469 12.1484 curveto
128.789 12.1484 128.945 11.9648 128.945 11.5977 curveto
128.945 10.1172 lineto
 closepath fill
newpath 132.348 11.5 moveto
132.348 11.7969 132.262 12.0352 132.074 12.2148 curveto
131.887 12.4023 131.625 12.4961 131.293 12.4961 curveto
131.008 12.4961 130.758 12.3945 130.551 12.1875 curveto
130.316 11.9531 130.199 11.6445 130.199 11.2617 curveto
130.199 10.8906 130.312 10.5898 130.539 10.3711 curveto
130.746 10.1719 130.996 10.0742 131.289 10.0742 curveto
131.492 10.0742 131.676 10.1016 131.844 10.1641 curveto
131.973 10.2109 132.07 10.2656 132.141 10.332 curveto
131.961 10.6289 lineto
131.801 10.4961 131.605 10.4219 131.367 10.4219 curveto
131.16 10.4219 130.988 10.4844 130.859 10.6172 curveto
130.711 10.7578 130.637 10.9727 130.637 11.2461 curveto
130.645 11.5469 lineto
130.66 11.7148 130.727 11.8555 130.848 11.9688 curveto
130.973 12.0898 131.129 12.1484 131.312 12.1484 curveto
131.508 12.1484 131.664 12.0898 131.781 11.9648 curveto
131.781 11.9648 lineto
131.887 11.8555 131.938 11.7148 131.938 11.5469 curveto
130.645 11.5469 lineto
130.637 11.2461 lineto
132.316 11.2461 lineto
132.344 11.3242 132.348 11.4102 132.348 11.5 curveto
 closepath fill
newpath 133.437 13.2617 moveto
133.387 13.2148 133.363 13.1523 133.363 13.082 curveto
133.363 13.0117 133.387 12.9492 133.437 12.8984 curveto
133.488 12.8477 133.547 12.8242 133.617 12.8242 curveto
133.688 12.8242 133.75 12.8477 133.801 12.8984 curveto
133.848 12.9492 133.875 13.0117 133.875 13.082 curveto
133.875 13.1523 133.848 13.2109 133.801 13.2617 curveto
133.75 13.3125 133.688 13.3359 133.617 13.3359 curveto
133.547 13.3359 133.484 13.3125 133.437 13.2617 curveto
 closepath fill
newpath 133.805 10.1172 moveto
133.805 12.4531 lineto
133.07 12.4531 lineto
133.07 12.1055 lineto
133.391 12.1055 lineto
133.391 10.1172 lineto
 closepath fill
newpath 136.719 10.1172 moveto
136.719 11.5625 lineto
136.719 12.1875 136.465 12.4961 135.945 12.4961 curveto
135.641 12.4961 135.414 12.3828 135.277 12.1523 curveto
135.148 12.4531 lineto
134.863 12.4531 lineto
134.863 10.1172 lineto
135.277 10.1172 lineto
135.277 11.8555 lineto
135.332 11.9375 135.41 12.0078 135.516 12.0625 curveto
135.617 12.1211 135.719 12.1484 135.812 12.1484 curveto
135.988 12.1484 136.113 12.0977 136.188 12 curveto
136.266 11.8984 136.305 11.7266 136.305 11.4766 curveto
136.305 10.1172 lineto
 closepath fill
newpath 138.246 10.0742 moveto
138.508 10.0742 138.711 10.1328 138.859 10.25 curveto
139.008 10.3711 139.078 10.5352 139.078 10.7461 curveto
139.078 10.9062 139.035 11.0391 138.953 11.1445 curveto
138.871 11.25 138.742 11.3438 138.559 11.4297 curveto
138.262 11.5625 lineto
138.094 11.6406 138.008 11.7539 138.008 11.9023 curveto
138.008 11.9727 138.039 12.0312 138.109 12.0781 curveto
138.176 12.125 138.258 12.1484 138.355 12.1484 curveto
138.523 12.1484 138.688 12.082 138.852 11.9531 curveto
138.969 12.3359 lineto
138.711 12.4453 138.496 12.4961 138.328 12.4961 curveto
138.102 12.4961 137.918 12.4453 137.781 12.3359 curveto
137.641 12.2305 137.57 12.0781 137.57 11.8867 curveto
137.57 11.8125 137.586 11.7461 137.605 11.6797 curveto
137.633 11.6172 137.668 11.5547 137.715 11.4961 curveto
137.766 11.4375 137.824 11.3867 137.891 11.3438 curveto
137.953 11.2969 138.082 11.2305 138.273 11.1445 curveto
138.52 11.0352 138.645 10.9023 138.645 10.7461 curveto
138.645 10.5352 138.516 10.4219 138.258 10.4219 curveto
138.117 10.4219 137.934 10.4961 137.703 10.6523 curveto
137.559 10.2578 lineto
137.773 10.1328 138.004 10.0742 138.246 10.0742 curveto
 closepath fill
newpath 141.367 12.4219 moveto
141.23 12.4727 141.098 12.4961 140.977 12.4961 curveto
140.602 12.4961 140.309 12.3828 140.09 12.1602 curveto
139.871 11.9336 139.77 11.6367 139.77 11.2656 curveto
139.77 10.8984 139.867 10.6094 140.074 10.3945 curveto
140.289 10.1797 140.551 10.0742 140.867 10.0742 curveto
141.195 10.0742 141.473 10.1445 141.695 10.2891 curveto
141.531 10.6367 lineto
141.34 10.4961 141.152 10.4219 140.969 10.4219 curveto
140.73 10.4219 140.539 10.4961 140.406 10.6367 curveto
140.27 10.7852 140.199 10.9922 140.199 11.2656 curveto
140.199 11.5391 140.27 11.7539 140.398 11.9141 curveto
140.535 12.0703 140.715 12.1484 140.938 12.1484 curveto
141.039 12.1484 141.145 12.1289 141.25 12.0938 curveto
141.359 12.0547 141.434 12.0156 141.477 11.9727 curveto
141.68 12.2656 lineto
141.613 12.3164 141.512 12.3711 141.367 12.4219 curveto
 closepath fill
newpath 144.387 10.1172 moveto
144.387 11.5859 lineto
144.387 11.8672 144.316 12.0898 144.176 12.2539 curveto
144.031 12.418 143.844 12.4961 143.594 12.4961 curveto
143.465 12.4961 143.336 12.4688 143.215 12.4102 curveto
143.09 12.3555 143 12.2812 142.945 12.1992 curveto
142.945 13.4102 lineto
142.531 13.4102 lineto
142.531 10.1172 lineto
142.945 10.1172 lineto
142.945 11.8555 lineto
143 11.9336 143.078 12.0039 143.18 12.0625 curveto
143.277 12.1211 143.379 12.1484 143.484 12.1484 curveto
143.637 12.1484 143.754 12.0977 143.844 12 curveto
143.93 11.8984 143.973 11.7617 143.973 11.5859 curveto
143.973 10.1172 lineto
 closepath fill
newpath 146.875 10.1445 moveto
146.957 10.0977 147.082 10.0742 147.25 10.0742 curveto
147.25 10.2812 lineto
147.129 10.3516 147.066 10.4922 147.066 10.6953 curveto
147.066 11.5312 lineto
147.066 11.8672 146.992 12.1133 146.836 12.2656 curveto
146.684 12.4219 146.441 12.4961 146.102 12.4961 curveto
145.977 12.4961 145.844 12.4766 145.703 12.4297 curveto
145.566 12.3828 145.457 12.3281 145.379 12.2656 curveto
145.551 11.918 lineto
145.691 12.0586 145.891 12.1289 146.148 12.1289 curveto
146.484 12.1289 146.656 11.9375 146.656 11.5625 curveto
146.656 11.2656 lineto
146.656 10.7031 lineto
146.492 10.5 146.309 10.3984 146.098 10.3984 curveto
145.812 10.3984 145.668 10.5195 145.668 10.7617 curveto
145.668 10.9102 145.734 11.0391 145.867 11.1484 curveto
146 11.2578 146.172 11.3086 146.379 11.3086 curveto
146.434 11.3086 146.523 11.2969 146.656 11.2656 curveto
146.656 11.5625 lineto
146.543 11.5977 146.445 11.6172 146.359 11.6172 curveto
146.035 11.6172 145.773 11.5352 145.566 11.3711 curveto
145.359 11.2109 145.254 11.0039 145.254 10.7695 curveto
145.254 10.5742 145.32 10.4102 145.457 10.2734 curveto
145.594 10.1406 145.75 10.0742 145.934 10.0742 curveto
146.273 10.0742 146.527 10.1758 146.691 10.3828 curveto
146.73 10.2734 146.789 10.1953 146.875 10.1445 curveto
 closepath fill
newpath 149.504 13.3438 moveto
149.363 13.3906 149.234 13.4102 149.113 13.4102 curveto
148.875 13.4102 148.68 13.3242 148.531 13.1562 curveto
148.387 12.9844 148.312 12.7539 148.312 12.4531 curveto
147.973 12.4531 lineto
147.973 12.1055 lineto
148.312 12.1055 lineto
148.312 10.1172 lineto
148.727 10.1172 lineto
148.727 12.1055 lineto
149.203 12.1055 lineto
149.203 12.4531 lineto
148.727 12.4531 lineto
148.723 12.4961 148.715 12.5391 148.715 12.5781 curveto
148.715 12.7227 148.758 12.8438 148.84 12.9414 curveto
148.922 13.0352 149.027 13.082 149.152 13.082 curveto
149.227 13.082 149.301 13.0703 149.387 13.0391 curveto
 closepath fill
newpath 150.324 10.7969 moveto
150.324 10.5898 150.387 10.418 150.516 10.2773 curveto
150.645 10.1406 150.797 10.0742 150.984 10.0742 curveto
151.187 10.0742 151.375 10.0938 151.547 10.1367 curveto
151.492 10.5039 lineto
151.371 10.4531 151.262 10.4219 151.16 10.4219 curveto
151.008 10.4219 150.906 10.4609 150.836 10.5469 curveto
150.773 10.6289 150.738 10.7695 150.738 10.9688 curveto
150.738 12.1289 lineto
151.379 12.1289 lineto
151.379 12.4531 lineto
150.738 12.4531 lineto
150.738 13.1016 lineto
150.324 12.9414 lineto
150.324 12.4531 lineto
150.055 12.4531 lineto
150.055 12.1289 lineto
150.324 12.1289 lineto
 closepath fill
 0.0941 0.0941 0.0941 setrgbcolor
newpath 147.793 18.0898 moveto
148.242 17.7227 148.691 17.1445 150.293 18.64839 curveto
151.898 20.1445 151.082 19.5156 151.949 17.53911 curveto
152.82 15.5703 153.367 16.6562 153.426 17.03911 curveto
153.559 18.0039 153.262 19.8945 153.062 20.6602 curveto
152.891 21.3047 151.785 21.6211 151.344 21.3008 curveto
150.926 21 149.82 19.75 149.082 19.5156 curveto
148.348 19.2773 148.93 19.9883 148.746 21.168 curveto
148.562 22.35161 148.129 22.8945 147.66 22.6953 curveto
147.348 22.5547 146.668 21.8594 146.348 22.043 curveto
145.723 22.3867 145.293 23.8945 142.242 22.2227 curveto
138.688 20.2773 141.875 24.6953 141.875 24.6953 curveto
141.875 24.6953 144.238 27.9336 142.82 30.2773 curveto
141.402 32.6172 138.348 27.5898 138.348 27.5898 curveto
138.348 27.5898 136.746 24.4062 136.031 21.03911 curveto
135.32 17.6719 133.871 18.0508 133.328 18.7773 curveto
132.738 19.5547 132.902 22.6211 130.797 21.3281 curveto
128.695 20.03911 128.719 17.46089 127.453 20.3828 curveto
126.19101 23.3008 124.867 21.4258 124.69101 21.1172 curveto
124.457 20.6875 124.578 19.7461 124.21901 19.53911 curveto
123.81601 19.3125 123.312 20.1367 123.012 20.25 curveto
122.68399 20.3711 120.555 18.3828 119.59 16.543 curveto
118.19899 13.8906 115.965 20.27339 116.18399 20.668 curveto
116.371 21.0195 121.812 28.5508 122.32399 29.6406 curveto
122.859 30.7812 123.641 31.1172 124.035 31.1719 curveto
124.43 31.2227 129.457 32.0664 133.086 35.9062 curveto
136.719 39.7461 136.164 40.6914 134.43 41.668 curveto
134.324 40.47661 lineto
134.734 40.0078 134.766 38.9023 133.891 38.02339 curveto
133.012 37.14839 130.121 34.1992 128.309 33.4531 curveto
126.59 32.7461 120.707 29.9375 126.578 35.3125 curveto
126.578 35.3125 lineto
131.535 39.8477 131.398 39.72661 131.797 39.8828 curveto
132.27 40.0742 133.992 40.8633 134.324 40.47661 curveto
134.43 41.668 lineto
132.695 42.6406 127.742 37.793 127.508 37.6133 curveto
127.34 37.4844 123.246 32.8789 122.957 32.3008 curveto
122.668 31.7227 115.93 32.0898 115.93 32.0898 curveto
115.152 31.707 116.016 31.3867 116.016 31.3867 curveto
116.016 31.3867 119.039 30.9492 120.922 31 curveto
122.80899 31.0547 121.562 29.9492 121.34401 29.6836 curveto
119.883 27.957 117.125 23.2539 116.145 22.2695 curveto
115.164 21.28911 113.285 22.3828 113.172 22.4023 curveto
113.06601 22.418 110.258 22.8398 110.82399 20.6953 curveto
111.395 18.5508 113.098 19.5039 113.92601 19.3047 curveto
113 19.9922 lineto
112.828 19.918 112.328 20.3438 112.348 20.5664 curveto
112.383 21.0039 112.836 20.5547 113.359 20.5664 curveto
113.887 20.5781 113.188 20.0703 113 19.9922 curveto
113.92601 19.3047 lineto
114.17601 19.2383 114.535 18.7969 114.67601 18.5781 curveto
115.09401 17.9102 115.289 16.8594 115.72699 16.207 curveto
116.371 15.2539 118.805 12.8828 120.69101 16.3047 curveto
122.64801 19.8594 123.891 18.5273 123.996 16.5898 curveto
124.098 14.6562 124.71901 15.375 125.418 15.6875 curveto
126.113 15.9961 125.52301 17.33589 125.598 19.0977 curveto
125.67601 20.85161 127.121 18.3164 127.02 17.6211 curveto
126.914 16.9258 128 17.0547 128.957 17.4414 curveto
129.91 17.8281 129.164 18.4219 130.48 19.6367 curveto
131.797 20.85161 131.859 18.0039 132.207 17.33589 curveto
132.48 16.8047 133.863 15.6875 134.559 17.1836 curveto
135.258 18.6836 136.352 18.3555 136.109 16.8281 curveto
137.062 17.0273 lineto
136.574 18.8125 137.84 20.3086 137.84 20.3086 curveto
137.84 20.3086 138.375 21.0312 138.715 21 curveto
137.867 21.3672 lineto
137.449 20.9023 137.09 20.53911 137.43 21.832 curveto
137.762 23.125 137.645 22.582 137.852 23.0625 curveto
138.055 23.5312 138.957 25.9258 139.027 26.1211 curveto
139.066 26.22661 139.859 27.7852 140.672 28.957 curveto
140.672 28.957 142.852 30.8867 141.973 27.4102 curveto
141.383 25.082 140.723 24.8242 139.652 23.1523 curveto
139.652 23.1523 lineto
139.449 22.8281 139.086 23.5781 138.352 22.6445 curveto
138.047 22.2578 138.238 21.7812 137.867 21.3672 curveto
138.715 21 lineto
139.137 20.957 139.98 20.8242 139.699 19.793 curveto
139.699 19.793 lineto
139.414 18.7578 138.996 17.0508 138.52 16.6094 curveto
138.102 16.2227 137.547 15.2461 137.062 17.0273 curveto
136.109 16.8281 lineto
135.871 15.3047 137.188 14.707 137.613 14.7266 curveto
138.016 14.7461 140.32 16.0156 140.352 18.5703 curveto
140.375 21.1172 142.199 21.10161 142.504 21.1445 curveto
142.812 21.1875 145.164 21.5664 144.953 20.8828 curveto
144.742 20.1992 143.691 18.2227 144.902 18.2539 curveto
146.109 18.27339 145.609 19.332 146.738 20.5156 curveto
147.871 21.6953 147.344 18.46089 147.793 18.0898 curveto
 closepath fill
newpath 133.234 28.8789 moveto
133.07 27.1719 134.125 27.72661 134.125 27.72661 curveto
136.082 28.7344 134.531 29.668 134.531 29.668 curveto
134.531 29.668 133.395 30.5938 133.234 28.8789 curveto
 closepath fill
newpath 161.832 13.5938 moveto
161.73 13.8672 161.527 14.2344 160.711 13.2305 curveto
159.457 11.6914 159.625 12.6641 159.504 13.668 curveto
159.488 13.8398 159.613 14.3008 158.75 15.0273 curveto
158.301 15.4102 156.211 15.9922 156.68 16.4688 curveto
157.883 17.6875 157.57 17.5703 158.008 18.1133 curveto
158.449 18.6562 160.078 20.2578 160 22.5312 curveto
159.922 24.8008 156.641 24.5938 156.641 24.5938 curveto
154.496 24.207 155.402 22.2461 156.949 22.375 curveto
158.395 22.4961 158.203 21.2812 158.094 20.8906 curveto
158.094 20.8906 lineto
158.086 20.8633 158.078 20.83589 158.074 20.8203 curveto
158.094 20.8906 lineto
158.094 20.8906 lineto
158.094 20.8867 157.914 20.418 157.555 19.8555 curveto
157.078 19.0977 156.484 18.0078 155.918 17.457 curveto
155.609 17.1562 153.945 16.0977 155.141 15.5039 curveto
157.129 14.5195 158.629 12.4336 157.855 11.2695 curveto
157.078 10.1055 150.984 7.79688 149.719 7.24219 curveto
148.492 6.69922 146.078 6.54297 146.129 3.39453 curveto
146.18 0.24219 149.539 0.26953 151.008 0.65625 curveto
150.785 1.55078 lineto
148.363 1.21484 147.031 2.61719 147.059 3.47266 curveto
147.082 4.32422 147.875 5.4375 150.535 6.7539 curveto
156.5 9.71094 157.023 9.9375 157.023 9.9375 curveto
157.453 10.1055 158.375 10.6562 157.832 9.7461 curveto
157.832 9.7461 lineto
157.832 9.7461 155.453 5.16797 155.195 4.76172 curveto
154.871 4.26953 153.215 1.88281 150.785 1.55078 curveto
151.008 0.65625 lineto
153.582 1.32813 154.656 2.33203 155.637 3.44531 curveto
156.672 4.625 158.73 9.30469 158.781 9.35938 curveto
158.836 9.41016 159.504 12.1211 160.695 12.4336 curveto
161.883 12.7422 161.973 13.1914 161.832 13.5938 curveto
 closepath fill
newpath 155.68 27.8945 moveto
155.078 28.1445 153.27 27.2148 153.809 25.6602 curveto
154.359 24.0742 158.457 26.75 155.68 27.8945 curveto
 closepath fill
newpath 104.18399 41.3086 moveto
103.457 41.3086 lineto
102.629 39.2188 lineto
101.879 41.3086 lineto
101.109 41.3086 lineto
101.109 41.1992 lineto
101.17601 41.1797 101.223 41.16411 101.25 41.1523 curveto
101.277 41.1367 101.297 41.1133 101.31601 41.0898 curveto
101.332 41.0703 101.34401 41.0312 101.348 40.9844 curveto
101.359 40.9414 101.359 40.8672 101.359 40.7695 curveto
101.359 38.91411 lineto
101.359 38.8086 101.359 38.7305 101.348 38.6797 curveto
101.336 38.6289 101.31601 38.5898 101.285 38.5625 curveto
101.258 38.5312 101.19899 38.5078 101.109 38.4844 curveto
101.109 38.3789 lineto
101.895 38.3789 lineto
101.895 38.4844 lineto
101.82399 38.5 101.777 38.5195 101.75 38.5352 curveto
101.723 38.5547 101.69899 38.5742 101.688 38.60161 curveto
101.668 38.625 101.65599 38.6602 101.652 38.707 curveto
101.64801 38.75 101.645 38.8203 101.645 38.91411 curveto
101.645 39.6992 lineto
101.645 39.9414 101.641 40.1758 101.637 40.4062 curveto
101.625 40.6328 101.617 40.793 101.609 40.8789 curveto
101.64801 40.8789 lineto
102.44101 38.7188 lineto
102.688 38.7188 lineto
103.535 40.8438 lineto
103.57 40.8438 lineto
103.562 40.7617 103.555 40.6133 103.55101 40.3906 curveto
103.543 40.1719 103.539 39.9531 103.539 39.7344 curveto
103.539 38.91411 lineto
103.539 38.8008 103.535 38.7148 103.52301 38.668 curveto
103.512 38.6172 103.488 38.5781 103.457 38.5547 curveto
103.42601 38.5273 103.371 38.5039 103.289 38.4844 curveto
103.289 38.3789 lineto
104.18399 38.3789 lineto
104.18399 38.4844 lineto
104.117 38.5 104.07 38.5195 104.039 38.5352 curveto
104.012 38.5547 103.988 38.5742 103.973 38.60161 curveto
103.957 38.625 103.94899 38.6602 103.94101 38.707 curveto
103.938 38.75 103.93399 38.8203 103.93399 38.91411 curveto
103.93399 40.7695 lineto
103.93399 40.8672 103.938 40.9414 103.945 40.9883 curveto
103.953 41.0352 103.965 41.0703 103.98 41.0938 curveto
103.996 41.1172 104.02 41.1367 104.047 41.1523 curveto
104.07399 41.168 104.121 41.1875 104.18399 41.1992 curveto
 closepath fill
newpath 104.867 40.8555 moveto
105.262 40.8555 lineto
105.262 41.27339 lineto
104.867 41.27339 lineto
 closepath fill
newpath 104.64801 38.3789 moveto
105.488 38.3789 lineto
105.488 38.4844 lineto
105.418 38.5039 105.363 38.5273 105.332 38.5508 curveto
105.30101 38.5742 105.28099 38.6133 105.27301 38.6602 curveto
105.254 38.707 105.25 38.793 105.25 38.91411 curveto
105.25 40.4492 lineto
105.121 40.4492 lineto
104.621 40.4297 lineto
104.621 40.3164 lineto
104.68399 40.3047 104.734 40.28911 104.77 40.27339 curveto
104.805 40.2578 104.828 40.2305 104.848 40.1992 curveto
104.863 40.16411 104.875 40.1211 104.875 40.0664 curveto
104.879 40.0078 104.883 39.9336 104.883 39.8438 curveto
104.883 38.9102 lineto
104.883 38.8086 104.875 38.7344 104.867 38.6875 curveto
104.859 38.6406 104.848 38.6055 104.828 38.582 curveto
104.812 38.5625 104.793 38.543 104.77 38.5312 curveto
104.746 38.5156 104.707 38.5 104.64801 38.4844 curveto
 closepath fill
newpath 105.742 40.21089 moveto
106.062 40.21089 lineto
106.062 39.02339 lineto
106.062 38.78911 106.109 38.6172 106.19899 38.5078 curveto
106.289 38.39839 106.42601 38.3438 106.609 38.3438 curveto
106.707 38.3438 106.80101 38.3672 106.891 38.4102 curveto
106.98 38.457 107.078 38.5273 107.18 38.625 curveto
107.082 38.7422 lineto
107.035 38.6992 106.984 38.66411 106.93399 38.6406 curveto
106.883 38.6172 106.832 38.6055 106.77301 38.6055 curveto
106.711 38.6055 106.66 38.6133 106.621 38.6328 curveto
106.578 38.6562 106.543 38.6875 106.512 38.7344 curveto
106.48 38.7812 106.461 38.8438 106.44899 38.9258 curveto
106.438 39.0078 106.43399 39.1211 106.43399 39.2578 curveto
106.43399 40.21089 lineto
107.125 40.21089 lineto
107.125 40.4297 lineto
106.43399 40.4297 lineto
106.43399 40.957 lineto
106.125 40.957 lineto
106.109 40.8281 106.098 40.7305 106.082 40.6602 curveto
106.06601 40.5938 106.047 40.5352 106.02301 40.4922 curveto
105.996 40.4453 105.961 40.4102 105.918 40.3828 curveto
105.875 40.35161 105.81601 40.332 105.742 40.3203 curveto
 closepath fill
newpath 109.25 40.4297 moveto
108.492 40.4297 lineto
108.391 40.4531 108.289 40.4648 108.18399 40.4648 curveto
108.18 40.3008 lineto
108.262 40.3008 108.332 40.2812 108.395 40.2422 curveto
108.453 40.2031 108.504 40.1445 108.539 40.0586 curveto
108.57399 39.9727 108.59 39.8672 108.59 39.7422 curveto
108.59 39.6719 108.586 39.6055 108.57 39.543 curveto
108.555 39.4805 108.53099 39.4219 108.5 39.375 curveto
108.465 39.3242 108.42601 39.28911 108.371 39.2578 curveto
108.32 39.2305 108.258 39.2188 108.188 39.2188 curveto
108.05101 39.2188 107.945 39.2656 107.871 39.3633 curveto
107.797 39.46089 107.762 39.5977 107.762 39.7773 curveto
107.762 39.9453 107.797 40.0781 107.871 40.168 curveto
107.871 40.168 lineto
107.94101 40.2578 108.043 40.3008 108.18 40.3008 curveto
108.18399 40.4648 lineto
108.07 40.4648 107.965 40.4492 107.863 40.4219 curveto
107.766 40.3906 107.68 40.3477 107.609 40.28911 curveto
107.535 40.2305 107.48 40.1562 107.44101 40.0625 curveto
107.39801 39.9727 107.379 39.8672 107.379 39.7422 curveto
107.379 39.6133 107.40599 39.4922 107.457 39.3906 curveto
107.512 39.28911 107.59 39.207 107.695 39.14839 curveto
107.578 39.0586 107.496 38.9844 107.453 38.91411 curveto
107.40599 38.8477 107.383 38.77339 107.383 38.6914 curveto
107.383 38.6172 107.402 38.5547 107.44101 38.5039 curveto
107.48 38.4492 107.53099 38.4102 107.60199 38.3828 curveto
107.488 38.3281 107.40599 38.2617 107.34401 38.1914 curveto
107.285 38.1172 107.254 38.0352 107.254 37.9414 curveto
107.254 37.8438 107.277 37.7617 107.32399 37.6914 curveto
107.371 37.6289 107.438 37.5703 107.52 37.5312 curveto
107.605 37.4883 107.707 37.46089 107.828 37.4453 curveto
107.945 37.4297 108.078 37.418 108.223 37.418 curveto
108.21901 37.5898 lineto
108.008 37.5898 107.85199 37.6172 107.75 37.6797 curveto
107.64801 37.7383 107.598 37.83589 107.598 37.9648 curveto
107.598 38.043 107.617 38.1133 107.652 38.1719 curveto
107.688 38.2344 107.742 38.28911 107.81601 38.3438 curveto
107.90599 38.33589 108.008 38.332 108.121 38.332 curveto
108.121 38.332 lineto
108.44101 38.332 lineto
108.52301 38.332 108.59 38.3242 108.645 38.3047 curveto
108.695 38.28911 108.734 38.2617 108.762 38.2344 curveto
108.789 38.2031 108.80899 38.168 108.82 38.1328 curveto
108.828 38.0938 108.832 38.0547 108.832 38.0156 curveto
108.832 37.9297 108.80899 37.8555 108.762 37.78911 curveto
108.711 37.72661 108.645 37.6758 108.55101 37.6445 curveto
108.457 37.6055 108.348 37.5898 108.21901 37.5898 curveto
108.223 37.418 lineto
108.418 37.418 108.586 37.4453 108.734 37.5039 curveto
108.879 37.5664 108.992 37.64839 109.07 37.7539 curveto
109.145 37.8555 109.18399 37.9805 109.18399 38.1133 curveto
109.18399 38.2188 109.164 38.3125 109.121 38.3906 curveto
109.082 38.4688 109.016 38.5352 108.918 38.582 curveto
108.82 38.6289 108.69899 38.6523 108.547 38.6523 curveto
108.03099 38.6523 lineto
107.93399 38.6523 107.863 38.6562 107.81601 38.668 curveto
107.766 38.6797 107.734 38.6992 107.711 38.72661 curveto
107.69101 38.7539 107.68 38.793 107.68 38.8477 curveto
107.68 38.9258 107.734 39.0078 107.84401 39.0898 curveto
107.93 39.0625 108.03099 39.0469 108.152 39.0469 curveto
108.414 39.0469 108.617 39.1094 108.762 39.2344 curveto
108.90599 39.3633 108.97699 39.543 108.97699 39.77339 curveto
108.97699 39.8633 108.965 39.9453 108.94101 40.02339 curveto
108.914 40.0977 108.879 40.1602 108.832 40.2031 curveto
108.855 40.22661 lineto
109.25 40.21089 lineto
 closepath fill
newpath 110.043 41.4453 moveto
109.914 41.4453 lineto
109.39801 41.4297 lineto
109.39801 41.3164 lineto
109.46901 41.3008 109.52 41.28911 109.543 41.2773 curveto
109.57399 41.2656 109.598 41.2461 109.613 41.2305 curveto
109.633 41.2031 109.645 41.1719 109.652 41.1367 curveto
109.66 41.0977 109.664 41.0508 109.672 40.9961 curveto
109.672 40.9414 109.672 40.8477 109.672 40.71089 curveto
109.672 38.91411 lineto
109.672 38.8398 109.672 38.7773 109.664 38.72661 curveto
109.65599 38.6797 109.652 38.6406 109.641 38.6133 curveto
109.629 38.58589 109.609 38.5625 109.578 38.543 curveto
109.55101 38.52339 109.5 38.5039 109.43399 38.4844 curveto
109.43399 38.3789 lineto
110.28099 38.3789 lineto
110.28099 38.4844 lineto
110.211 38.5039 110.15599 38.5273 110.125 38.5508 curveto
110.09401 38.5742 110.07 38.6133 110.05899 38.6602 curveto
110.047 38.707 110.043 38.793 110.043 38.91411 curveto
 closepath fill
newpath 110.879 40.8555 moveto
111.27301 40.8555 lineto
111.27301 41.27339 lineto
110.879 41.27339 lineto
 closepath fill
newpath 110.66 38.3789 moveto
111.504 38.3789 lineto
111.504 38.4844 lineto
111.43 38.5039 111.375 38.5273 111.34401 38.5508 curveto
111.312 38.5742 111.289 38.6133 111.28099 38.6602 curveto
111.27 38.707 111.262 38.793 111.262 38.91411 curveto
111.262 40.4492 lineto
111.133 40.4492 lineto
110.633 40.4297 lineto
110.633 40.3164 lineto
110.695 40.3047 110.746 40.28911 110.78099 40.27339 curveto
110.81601 40.2578 110.84401 40.2305 110.859 40.1992 curveto
110.875 40.16411 110.887 40.1211 110.891 40.0664 curveto
110.895 40.0078 110.895 39.9336 110.895 39.8438 curveto
110.895 38.9102 lineto
110.895 38.8086 110.891 38.7344 110.879 38.6875 curveto
110.871 38.6406 110.859 38.6055 110.84 38.582 curveto
110.82399 38.5625 110.805 38.543 110.78099 38.5312 curveto
110.758 38.5156 110.71901 38.5 110.66 38.4844 curveto
 closepath fill
newpath 113.46901 38.8828 moveto
113.371 38.7852 113.28099 38.7148 113.188 38.668 curveto
113.09 38.625 112.988 38.6055 112.871 38.6055 curveto
112.73 38.6055 112.617 38.6367 112.53099 38.7031 curveto
112.445 38.7695 112.383 38.8594 112.34401 38.9727 curveto
112.305 39.08589 112.289 39.2305 112.289 39.39839 curveto
112.289 39.4375 lineto
113.641 39.4375 lineto
113.637 39.6289 113.617 39.78911 113.586 39.9102 curveto
113.55101 40.0312 113.5 40.1289 113.445 40.21089 curveto
113.379 40.28911 113.297 40.35161 113.19899 40.39839 curveto
113.09401 40.4414 112.973 40.4648 112.828 40.4648 curveto
112.805 40.2969 lineto
112.90599 40.2969 112.98 40.2695 113.043 40.2188 curveto
113.10199 40.16411 113.152 40.0898 113.17601 39.9922 curveto
113.207 39.8945 113.23 39.7695 113.238 39.6133 curveto
112.297 39.6133 lineto
112.312 39.832 112.367 40 112.453 40.1172 curveto
112.539 40.2383 112.66 40.2969 112.805 40.2969 curveto
112.828 40.4648 lineto
112.645 40.4648 112.48 40.4219 112.34 40.332 curveto
112.195 40.2422 112.086 40.1172 112.012 39.957 curveto
111.93399 39.793 111.89801 39.6055 111.89801 39.3906 curveto
111.89801 39.0469 111.973 38.7852 112.121 38.6094 curveto
112.27301 38.4336 112.496 38.3438 112.789 38.3438 curveto
112.89801 38.3438 113 38.3594 113.09 38.3906 curveto
113.188 38.4219 113.27 38.4648 113.348 38.5195 curveto
113.418 38.5742 113.508 38.64839 113.598 38.7461 curveto
 closepath fill
newpath 115.473 40.3672 moveto
115.391 40.4023 115.312 40.4258 115.238 40.4414 curveto
115.16 40.457 115.07399 40.4648 114.98 40.4648 curveto
114.805 40.4648 114.645 40.4258 114.504 40.3438 curveto
114.363 40.2656 114.25 40.1445 114.168 39.9805 curveto
114.086 39.8164 114.043 39.6172 114.043 39.3828 curveto
114.043 39.0469 114.109 38.78911 114.234 38.6133 curveto
114.363 38.4336 114.543 38.3438 114.777 38.3438 curveto
114.863 38.3438 114.945 38.3594 115.02 38.3867 curveto
115.09401 38.418 115.164 38.4531 115.23 38.5039 curveto
115.297 38.5508 115.375 38.6211 115.465 38.7188 curveto
115.32399 38.7695 lineto
115.28099 38.72661 115.242 38.6953 115.203 38.668 curveto
115.16 38.64839 115.121 38.6289 115.078 38.6172 curveto
115.039 38.6094 114.988 38.60161 114.922 38.60161 curveto
114.762 38.60161 114.645 38.6719 114.56601 38.8164 curveto
114.488 38.96089 114.44899 39.168 114.44899 39.4414 curveto
114.44899 39.7148 114.496 39.9258 114.59 40.0742 curveto
114.688 40.2188 114.828 40.293 115.008 40.293 curveto
115.07399 40.293 115.133 40.2852 115.18 40.27339 curveto
115.23 40.2578 115.27301 40.2344 115.312 40.2031 curveto
115.355 40.1719 115.387 40.1328 115.41 40.08589 curveto
115.43399 40.043 115.44899 39.9844 115.461 39.918 curveto
115.46901 39.85161 115.473 39.7617 115.473 39.6523 curveto
115.473 39.1719 lineto
115.473 39.10161 115.46901 39.043 115.461 39 curveto
115.44899 38.9531 115.43399 38.91411 115.414 38.8789 curveto
115.395 38.8477 115.367 38.8086 115.32399 38.7695 curveto
115.465 38.7188 lineto
115.496 38.71089 lineto
115.473 38.3594 lineto
115.60199 38.3594 lineto
116.105 38.3789 lineto
116.105 38.4922 lineto
116.03099 38.5078 115.97699 38.52339 115.945 38.543 curveto
115.914 38.5586 115.891 38.582 115.875 38.6133 curveto
115.863 38.6406 115.855 38.6758 115.848 38.72661 curveto
115.84401 38.77339 115.84401 38.85161 115.84401 38.9648 curveto
115.84401 41.4453 lineto
115.715 41.4453 lineto
115.19899 41.4297 lineto
115.19899 41.3164 lineto
115.27 41.3008 115.32 41.28911 115.348 41.2773 curveto
115.375 41.2656 115.39801 41.2461 115.414 41.2305 curveto
115.43 41.2031 115.445 41.1719 115.453 41.1367 curveto
115.461 41.0977 115.46901 41.0508 115.46901 40.9961 curveto
115.473 40.9414 115.473 40.8477 115.473 40.71089 curveto
 closepath fill
newpath 118.879 40.3672 moveto
118.797 40.4023 118.71901 40.4258 118.641 40.4414 curveto
118.56601 40.457 118.47699 40.4648 118.383 40.4648 curveto
118.207 40.4648 118.05101 40.4258 117.91 40.3438 curveto
117.77 40.2656 117.65599 40.1445 117.57399 39.9805 curveto
117.492 39.8164 117.44899 39.6172 117.44899 39.3828 curveto
117.44899 39.0469 117.512 38.78911 117.641 38.6133 curveto
117.77 38.4336 117.94899 38.3438 118.18399 38.3438 curveto
118.27 38.3438 118.348 38.3594 118.42601 38.3867 curveto
118.5 38.418 118.57 38.4531 118.637 38.5039 curveto
118.703 38.5508 118.78099 38.6211 118.871 38.7188 curveto
118.73 38.7695 lineto
118.688 38.72661 118.64801 38.6953 118.609 38.668 curveto
118.56601 38.64839 118.527 38.6289 118.484 38.6172 curveto
118.445 38.6094 118.391 38.60161 118.328 38.60161 curveto
118.168 38.60161 118.05101 38.6719 117.96901 38.8164 curveto
117.891 38.96089 117.85199 39.168 117.85199 39.4414 curveto
117.85199 39.7148 117.902 39.9258 117.996 40.0742 curveto
118.09401 40.2188 118.23 40.293 118.414 40.293 curveto
118.48 40.293 118.539 40.2852 118.586 40.27339 curveto
118.633 40.2578 118.68 40.2344 118.71901 40.2031 curveto
118.758 40.1719 118.793 40.1328 118.81601 40.08589 curveto
118.84 40.043 118.855 39.9844 118.863 39.918 curveto
118.875 39.85161 118.879 39.7617 118.879 39.6523 curveto
118.879 39.1719 lineto
118.879 39.10161 118.875 39.043 118.863 39 curveto
118.855 38.9531 118.84 38.91411 118.82 38.8789 curveto
118.80101 38.8477 118.77 38.8086 118.73 38.7695 curveto
118.871 38.7188 lineto
118.902 38.71089 lineto
118.879 38.3594 lineto
119.008 38.3594 lineto
119.512 38.3789 lineto
119.512 38.4922 lineto
119.43399 38.5078 119.383 38.52339 119.35199 38.543 curveto
119.32 38.5586 119.297 38.582 119.28099 38.6133 curveto
119.27 38.6406 119.258 38.6758 119.254 38.72661 curveto
119.25 38.77339 119.25 38.85161 119.25 38.9648 curveto
119.25 41.4453 lineto
119.121 41.4453 lineto
118.60199 41.4297 lineto
118.60199 41.3164 lineto
118.67601 41.3008 118.72699 41.28911 118.754 41.2773 curveto
118.78099 41.2656 118.805 41.2461 118.82 41.2305 curveto
118.836 41.2031 118.85199 41.1719 118.859 41.1367 curveto
118.867 41.0977 118.875 41.0508 118.875 40.9961 curveto
118.879 40.9414 118.879 40.8477 118.879 40.71089 curveto
 closepath fill
newpath 121.453 38.8828 moveto
121.363 38.7852 121.266 38.7148 121.172 38.668 curveto
121.082 38.625 120.973 38.6055 120.85199 38.6055 curveto
120.715 38.6055 120.60199 38.6367 120.516 38.7031 curveto
120.43 38.7695 120.367 38.8594 120.328 38.9727 curveto
120.293 39.08589 120.27301 39.2305 120.27301 39.39839 curveto
120.27301 39.4375 lineto
121.629 39.4375 lineto
121.625 39.6289 121.605 39.78911 121.57 39.9102 curveto
121.539 40.0312 121.492 40.1289 121.43 40.21089 curveto
121.367 40.28911 121.289 40.35161 121.188 40.39839 curveto
121.086 40.4414 120.961 40.4648 120.812 40.4648 curveto
120.797 40.2969 lineto
120.891 40.2969 120.96901 40.2695 121.03099 40.2188 curveto
121.086 40.16411 121.133 40.0898 121.168 39.9922 curveto
121.195 39.8945 121.211 39.7695 121.223 39.6133 curveto
120.285 39.6133 lineto
120.30101 39.832 120.35199 40 120.44101 40.1172 curveto
120.527 40.2383 120.645 40.2969 120.797 40.2969 curveto
120.812 40.4648 lineto
120.629 40.4648 120.465 40.4219 120.32399 40.332 curveto
120.18399 40.2422 120.07399 40.1172 119.996 39.957 curveto
119.922 39.793 119.883 39.6055 119.883 39.3906 curveto
119.883 39.0469 119.957 38.7852 120.109 38.6094 curveto
120.258 38.4336 120.48 38.3438 120.78099 38.3438 curveto
120.883 38.3438 120.988 38.3594 121.082 38.3906 curveto
121.168 38.4219 121.254 38.4648 121.332 38.5195 curveto
121.41 38.5742 121.492 38.64839 121.586 38.7461 curveto
 closepath fill
newpath 122.617 40.4492 moveto
122.484 40.4492 lineto
121.984 40.4258 lineto
121.984 40.3164 lineto
122.047 40.3047 122.098 40.28911 122.133 40.27339 curveto
122.168 40.2578 122.195 40.2305 122.211 40.1992 curveto
122.22699 40.16411 122.238 40.1211 122.242 40.0664 curveto
122.242 40.0078 122.246 39.9336 122.246 39.8438 curveto
122.246 38.9102 lineto
122.246 38.8086 122.242 38.7344 122.23 38.6875 curveto
122.223 38.6406 122.211 38.6055 122.195 38.582 curveto
122.17601 38.5625 122.15599 38.543 122.133 38.5312 curveto
122.109 38.5156 122.07 38.5 122.016 38.4844 curveto
122.016 38.3789 lineto
122.879 38.3789 lineto
122.879 38.4844 lineto
122.805 38.4961 122.754 38.5156 122.715 38.53911 curveto
122.68 38.5625 122.652 38.5977 122.637 38.64839 curveto
122.621 38.6953 122.613 38.7852 122.613 38.91411 curveto
122.613 39.66411 lineto
122.613 39.7344 122.621 39.793 122.641 39.8438 curveto
122.66 39.8945 122.69101 39.9453 122.738 40.0039 curveto
122.785 40.0625 122.836 40.1055 122.887 40.1328 curveto
122.93399 40.16411 122.988 40.1797 123.039 40.1797 curveto
123.105 40.1797 123.16 40.16411 123.195 40.1289 curveto
123.234 40.0938 123.27 40.0352 123.305 39.96089 curveto
123.547 39.96089 lineto
123.547 40.4531 lineto
123.48 40.46089 123.40599 40.4648 123.32399 40.4648 curveto
123.223 40.4648 123.137 40.4492 123.05899 40.4219 curveto
122.98 40.3906 122.91 40.3477 122.84 40.293 curveto
122.77301 40.2383 122.703 40.1602 122.621 40.0664 curveto
122.59401 40.0742 lineto
 closepath fill
 0.0196 0.0196 0.0196 setrgbcolor
newpath 318.15201 25.4805 moveto
318.15201 22.2344 lineto
319.656 22.2344 lineto
320 22.2344 320.254 22.3086 320.414 22.4648 curveto
320.578 22.6172 320.68799 22.918 320.738 23.3672 curveto
320.965 23.3672 lineto
320.965 20.5703 lineto
320.738 20.5703 lineto
320.73401 20.8906 320.695 21.125 320.617 21.2773 curveto
320.535 21.4258 320.422 21.53911 320.285 21.6133 curveto
320.14099 21.6875 319.93399 21.72661 319.656 21.72661 curveto
318.15201 21.72661 lineto
318.15201 19.1328 lineto
318.15201 18.71089 318.176 18.4336 318.23401 18.3008 curveto
318.27301 18.2031 318.35901 18.1133 318.488 18.043 curveto
318.664 17.9414 318.85501 17.8906 319.047 17.8906 curveto
319.344 17.8906 lineto
319.344 17.66411 lineto
315.797 17.66411 lineto
315.797 17.8906 lineto
316.09 17.8906 lineto
316.43799 17.8906 316.68399 17.9883 316.836 18.1914 curveto
316.93799 18.3242 316.98401 18.6328 316.98401 19.1328 curveto
316.98401 24.4727 lineto
316.98401 24.8906 316.957 25.168 316.906 25.3008 curveto
316.863 25.4023 316.781 25.4883 316.656 25.5625 curveto
316.48001 25.6602 316.289 25.707 316.09 25.707 curveto
315.797 25.707 lineto
315.797 25.9336 lineto
321.949 25.9336 lineto
322.031 24.1172 lineto
321.81601 24.1172 lineto
321.711 24.5039 321.59 24.78911 321.449 24.9688 curveto
321.30899 25.1523 321.137 25.2812 320.93 25.3633 curveto
320.72699 25.4453 320.41 25.4805 319.97299 25.4805 curveto
 closepath fill
newpath 327.35501 26.1289 moveto
328.43399 26.1289 329.363 25.7188 330.14801 24.9023 curveto
330.93399 24.0898 331.328 23.0703 331.328 21.8477 curveto
331.328 20.5977 330.93 19.5508 330.14099 18.7227 curveto
329.34799 17.8906 328.387 17.47661 327.262 17.47661 curveto
327.246 17.9102 lineto
328.02701 17.9102 328.668 18.21089 329.172 18.8203 curveto
329.68 19.4297 329.93 20.3828 329.93 21.6836 curveto
329.93 23.10161 329.656 24.1523 329.09799 24.85161 curveto
328.65201 25.4023 328.031 25.6758 327.242 25.6758 curveto
327.242 25.6758 lineto
326.504 25.6758 325.91 25.4023 325.465 24.8555 curveto
324.91 24.1758 324.629 23.1758 324.629 21.8555 curveto
324.629 20.5078 324.918 19.4688 325.496 18.7422 curveto
325.93399 18.1875 326.51999 17.9102 327.246 17.9102 curveto
327.262 17.47661 lineto
326.125 17.47661 325.168 17.8789 324.39099 18.6953 curveto
323.617 19.5039 323.23001 20.5469 323.23001 21.832 curveto
323.23001 23.14839 323.68 24.2148 324.574 25.043 curveto
325.34799 25.7656 326.27701 26.1289 327.35501 26.1289 curveto
 closepath fill
newpath 338.01599 25.707 moveto
338.01599 25.9336 lineto
340.94101 25.9336 lineto
340.94101 25.707 lineto
340.633 25.707 lineto
340.30899 25.707 340.05899 25.5703 339.883 25.3008 curveto
339.801 25.1758 339.754 24.8789 339.754 24.4219 curveto
339.754 21.0703 lineto
339.754 20.2422 339.672 19.5977 339.508 19.1406 curveto
339.344 18.6836 339.01999 18.293 338.535 17.96089 curveto
338.055 17.6328 337.40201 17.4688 336.57 17.4688 curveto
335.672 17.4688 334.98001 17.6289 334.51599 17.9414 curveto
334.047 18.2539 333.719 18.6719 333.52301 19.207 curveto
333.39499 19.5664 333.328 20.2422 333.328 21.2422 curveto
333.328 24.4688 lineto
333.328 24.9805 333.258 25.3086 333.117 25.4727 curveto
332.97699 25.6289 332.75 25.707 332.43799 25.707 curveto
332.125 25.707 lineto
332.125 25.9336 lineto
335.703 25.9336 lineto
335.703 25.707 lineto
335.383 25.707 lineto
335.039 25.707 334.797 25.60161 334.64801 25.3867 curveto
334.547 25.2383 334.496 24.9336 334.496 24.4688 curveto
334.496 20.8672 lineto
334.496 20.5469 334.52701 20.1797 334.586 19.7656 curveto
334.64499 19.35161 334.754 19.0273 334.906 18.7969 curveto
335.05899 18.5664 335.281 18.375 335.57 18.2227 curveto
335.867 18.0703 336.22299 17.9961 336.64499 17.9961 curveto
337.18799 17.9961 337.668 18.1133 338.094 18.3477 curveto
338.52301 18.58589 338.81201 18.8867 338.969 19.2578 curveto
339.125 19.625 339.207 20.2461 339.207 21.125 curveto
339.207 24.4688 lineto
339.207 24.9844 339.14801 25.3086 339.035 25.4414 curveto
338.875 25.6172 338.637 25.707 338.328 25.707 curveto
 closepath fill
newpath 341.41 25.9336 moveto
343.66 25.9336 lineto
348.711 19.7344 lineto
348.711 24.5 lineto
348.711 25.0117 348.65201 25.3242 348.539 25.4492 curveto
348.39099 25.6211 348.15201 25.707 347.824 25.707 curveto
347.539 25.707 lineto
347.539 25.9336 lineto
350.414 25.9336 lineto
350.414 25.707 lineto
350.125 25.707 lineto
349.77301 25.707 349.52701 25.60161 349.379 25.3945 curveto
349.289 25.2617 349.246 24.9648 349.246 24.5 curveto
349.246 17.5312 lineto
349.02701 17.5312 lineto
343.578 24.1914 lineto
343.578 19.10161 lineto
343.578 18.5898 343.633 18.27339 343.742 18.14839 curveto
343.89499 17.97661 344.133 17.8906 344.453 17.8906 curveto
344.746 17.8906 lineto
344.746 17.66411 lineto
341.867 17.66411 lineto
341.867 17.8906 lineto
342.156 17.8906 lineto
342.508 17.8906 342.758 17.9961 342.90201 18.21089 curveto
342.992 18.3398 343.039 18.6367 343.039 19.10161 curveto
343.039 24.85161 lineto
342.797 25.1289 342.617 25.3125 342.492 25.4023 curveto
342.371 25.4922 342.18399 25.5781 341.949 25.6523 curveto
341.828 25.6914 341.64801 25.707 341.41 25.707 curveto
 closepath fill
newpath 351.05899 17.66411 moveto
351.05899 17.8906 lineto
351.367 17.8906 lineto
351.719 17.8906 351.965 18.0039 352.113 18.22661 curveto
352.199 18.3672 352.246 18.668 352.246 19.1328 curveto
352.246 24.4727 lineto
352.246 24.9844 352.19101 25.3125 352.074 25.4414 curveto
351.918 25.6172 351.68399 25.707 351.367 25.707 curveto
351.05899 25.707 lineto
351.05899 25.9336 lineto
354.422 25.9336 lineto
355.66 25.9336 356.60199 25.793 357.242 25.5117 curveto
357.887 25.2344 358.406 24.7656 358.793 24.1133 curveto
359.19101 23.457 359.387 22.7031 359.387 21.8438 curveto
359.387 20.6953 359.039 19.7305 358.336 18.96089 curveto
357.551 18.0938 356.35501 17.66411 354.75 17.66411 curveto
354.715 18.0938 lineto
355.66 18.0938 356.44101 18.4219 357.06201 19.0898 curveto
357.68399 19.7539 357.992 20.64839 357.992 21.7812 curveto
357.992 22.9297 357.68399 23.8242 357.06201 24.4844 curveto
356.44101 25.1445 355.64499 25.4727 354.668 25.4727 curveto
354.297 25.4727 353.883 25.41411 353.418 25.293 curveto
353.418 18.2617 lineto
353.93399 18.14839 354.367 18.0938 354.715 18.0938 curveto
354.75 17.66411 lineto
 closepath fill
newpath 365.324 20.4336 moveto
365.15201 20.8867 lineto
363.754 24.2305 lineto
362.31299 20.8867 lineto
365.15201 20.8867 lineto
365.324 20.4336 lineto
362.125 20.4336 lineto
361.56299 19.1289 lineto
361.422 18.8086 361.35501 18.5703 361.35501 18.41411 curveto
361.35501 18.2852 361.414 18.1719 361.531 18.0781 curveto
361.65201 17.9844 361.91 17.9219 362.31299 17.8906 curveto
362.31299 17.66411 lineto
359.711 17.66411 lineto
359.711 17.8906 lineto
360.055 17.9531 360.27701 18.0312 360.379 18.1289 curveto
360.586 18.3281 360.81601 18.72661 361.07 19.3203 curveto
363.97699 26.1289 lineto
364.19101 26.1289 lineto
367.07 19.2461 lineto
367.301 18.6953 367.508 18.33589 367.699 18.1719 curveto
367.887 18.0039 368.14801 17.9102 368.488 17.8906 curveto
368.488 17.66411 lineto
365.22699 17.66411 lineto
365.22699 17.8906 lineto
365.555 17.9062 365.77701 17.96089 365.89499 18.0586 curveto
366.008 18.1523 366.06601 18.2617 366.06601 18.3945 curveto
366.06601 18.582 365.98401 18.8594 365.82 19.2461 curveto
 closepath fill
newpath 374.47299 25.9336 moveto
374.56299 23.9961 lineto
374.332 23.9961 lineto
374.289 24.3398 374.22299 24.5781 374.14801 24.72661 curveto
374.01999 24.9648 373.85199 25.1367 373.64099 25.25 curveto
373.43399 25.3594 373.16 25.41411 372.81601 25.41411 curveto
371.65201 25.41411 lineto
371.65201 19.10161 lineto
371.65201 18.5898 371.711 18.27339 371.81601 18.14839 curveto
371.97299 17.97661 372.211 17.8906 372.531 17.8906 curveto
372.81601 17.8906 lineto
372.81601 17.66411 lineto
369.31201 17.66411 lineto
369.31201 17.8906 lineto
369.60199 17.8906 lineto
369.957 17.8906 370.203 17.9961 370.35199 18.21089 curveto
370.43799 18.3398 370.48401 18.6367 370.48401 19.10161 curveto
370.48401 25.41411 lineto
369.488 25.41411 lineto
369.10199 25.41411 368.828 25.3867 368.668 25.332 curveto
368.457 25.2539 368.27301 25.1055 368.125 24.8828 curveto
367.97299 24.66411 367.883 24.3672 367.85501 23.9961 curveto
367.625 23.9961 lineto
367.72299 25.9336 lineto
 closepath fill
newpath 378.72699 17.8906 moveto
378.72699 17.66411 lineto
375.18399 17.66411 lineto
375.18399 17.8906 lineto
375.47699 17.8906 lineto
375.81601 17.8906 376.06601 17.9883 376.219 18.1914 curveto
376.31601 18.3242 376.367 18.6328 376.367 19.1328 curveto
376.367 24.4688 lineto
376.367 24.8906 376.34 25.168 376.289 25.3008 curveto
376.246 25.4023 376.16 25.4883 376.039 25.5625 curveto
375.85901 25.6602 375.672 25.707 375.47699 25.707 curveto
375.18399 25.707 lineto
375.18399 25.9297 lineto
378.72699 25.9297 lineto
378.72699 25.707 lineto
378.43 25.707 lineto
378.09 25.707 377.844 25.6094 377.68799 25.4102 curveto
377.59 25.2812 377.531 24.9648 377.531 24.4688 curveto
377.531 19.1328 lineto
377.531 18.71089 377.56201 18.4336 377.613 18.3008 curveto
377.65201 18.2031 377.746 18.1133 377.871 18.043 curveto
378.051 17.9414 378.23401 17.8906 378.43 17.8906 curveto
 closepath fill
newpath 383.84799 26.1289 moveto
384.922 26.1289 385.85199 25.7188 386.64099 24.9023 curveto
387.422 24.0898 387.81601 23.0703 387.81601 21.8477 curveto
387.81601 20.5977 387.418 19.5508 386.625 18.7227 curveto
385.836 17.8906 384.875 17.47661 383.75 17.47661 curveto
383.738 17.9102 lineto
384.51599 17.9102 385.15201 18.21089 385.664 18.8203 curveto
386.168 19.4297 386.422 20.3828 386.422 21.6836 curveto
386.422 23.10161 386.14499 24.1523 385.586 24.85161 curveto
385.14099 25.4023 384.51599 25.6758 383.73001 25.6758 curveto
383.73001 25.6758 lineto
382.992 25.6758 382.40201 25.4023 381.953 24.8555 curveto
381.39499 24.1758 381.113 23.1758 381.113 21.8555 curveto
381.113 20.5078 381.40201 19.4688 381.98401 18.7422 curveto
382.426 18.1875 383.012 17.9102 383.738 17.9102 curveto
383.75 17.47661 lineto
382.613 17.47661 381.65201 17.8789 380.883 18.6953 curveto
380.10501 19.5039 379.72299 20.5469 379.72299 21.832 curveto
379.72299 23.14839 380.168 24.2148 381.06299 25.043 curveto
381.84 25.7656 382.76599 26.1289 383.84799 26.1289 curveto
 closepath fill
newpath 388.383 25.9336 moveto
390.629 25.9336 lineto
395.68 19.7344 lineto
395.68 24.5 lineto
395.68 25.0117 395.625 25.3242 395.508 25.4492 curveto
395.35901 25.6211 395.125 25.707 394.797 25.707 curveto
394.512 25.707 lineto
394.512 25.9336 lineto
397.39099 25.9336 lineto
397.39099 25.707 lineto
397.09799 25.707 lineto
396.746 25.707 396.496 25.60161 396.35199 25.3945 curveto
396.262 25.2617 396.215 24.9648 396.215 24.5 curveto
396.215 17.5312 lineto
395.996 17.5312 lineto
390.547 24.1914 lineto
390.547 19.10161 lineto
390.547 18.5898 390.60199 18.27339 390.711 18.14839 curveto
390.867 17.97661 391.10501 17.8906 391.426 17.8906 curveto
391.719 17.8906 lineto
391.719 17.66411 lineto
388.84 17.66411 lineto
388.84 17.8906 lineto
389.125 17.8906 lineto
389.48401 17.8906 389.73001 17.9961 389.879 18.21089 curveto
389.969 18.3398 390.012 18.6367 390.012 19.10161 curveto
390.012 24.85161 lineto
389.77301 25.1289 389.594 25.3125 389.469 25.4023 curveto
389.344 25.4922 389.156 25.5781 388.918 25.6523 curveto
388.805 25.6914 388.621 25.707 388.383 25.707 curveto
 closepath fill
newpath 319.871 35.7148 moveto
320.945 35.7148 321.828 35.332 322.52701 34.5547 curveto
323.164 33.85161 323.48401 33.0156 323.48401 32.0508 curveto
323.48401 31.082 323.14801 30.2383 322.47299 29.5156 curveto
321.801 28.7852 320.93399 28.4258 319.871 28.4258 curveto
319.871 29.27339 lineto
320.367 29.27339 320.82 29.3867 321.23401 29.625 curveto
321.64801 29.8594 321.97299 30.1992 322.219 30.6328 curveto
322.457 31.0664 322.582 31.5312 322.582 32.0312 curveto
322.582 32.8086 322.31201 33.4727 321.781 34.0195 curveto
321.246 34.5703 320.60901 34.8398 319.871 34.8398 curveto
319.871 34.8398 lineto
319.129 34.8398 318.492 34.5703 317.961 34.0195 curveto
317.426 33.4727 317.16 32.8086 317.16 32.0312 curveto
317.16 31.5312 317.281 31.0664 317.52301 30.6328 curveto
317.76999 30.1992 318.094 29.8594 318.508 29.625 curveto
318.922 29.3867 319.375 29.27339 319.871 29.27339 curveto
319.871 28.4258 lineto
318.80899 28.4258 317.94101 28.7852 317.26599 29.5156 curveto
316.594 30.2383 316.25 31.082 316.25 32.0508 curveto
316.25 33.0117 316.574 33.8438 317.211 34.5508 curveto
317.914 35.3281 318.801 35.7148 319.871 35.7148 curveto
 closepath fill
newpath 325.195 28.60161 moveto
325.195 38.2148 lineto
326.086 38.2148 lineto
326.086 34.3477 lineto
326.461 34.8047 326.879 35.14839 327.34 35.375 curveto
327.805 35.60161 328.31299 35.7148 328.863 35.7148 curveto
329.84 35.7148 330.68 35.3594 331.371 34.64839 curveto
332.06601 33.9336 332.418 33.0703 332.418 32.0547 curveto
332.418 31.0547 332.06601 30.1992 331.35901 29.4883 curveto
330.66 28.7773 329.82 28.4258 328.84 28.4258 curveto
328.27301 28.4258 327.758 28.543 327.301 28.7852 curveto
326.844 29.0273 326.43799 29.3906 326.086 29.8789 curveto
326.81201 30.0938 lineto
327.34 29.5547 327.996 29.2812 328.762 29.2812 curveto
328.762 29.2812 lineto
329.262 29.2812 329.715 29.4062 330.137 29.6523 curveto
330.555 29.8945 330.89099 30.2383 331.137 30.6836 curveto
331.383 31.1211 331.512 31.5898 331.512 32.082 curveto
331.512 32.5742 331.383 33.043 331.133 33.4883 curveto
330.883 33.9375 330.547 34.2852 330.129 34.5352 curveto
329.707 34.7852 329.254 34.9062 328.77701 34.9062 curveto
328.289 34.9062 327.828 34.7852 327.387 34.5352 curveto
326.945 34.2852 326.613 33.9453 326.375 33.5273 curveto
326.14099 33.1055 326.02701 32.6328 326.02701 32.1094 curveto
326.02701 31.3086 326.285 30.6328 326.81201 30.0938 curveto
326.086 29.8789 lineto
326.086 28.60161 lineto
 closepath fill
newpath 339.879 30.9062 moveto
340.629 30.5078 lineto
340.383 30.02339 340.09799 29.6289 339.76999 29.332 curveto
339.449 29.0352 339.086 28.8125 338.68399 28.6562 curveto
338.27701 28.5 337.82 28.4258 337.31201 28.4258 curveto
336.18399 28.4258 335.293 28.793 334.66 29.5352 curveto
334.01999 30.2812 333.699 31.1172 333.699 32.0508 curveto
333.699 32.9297 333.97299 33.7148 334.512 34.4062 curveto
335.195 35.2773 336.113 35.7148 337.262 35.7148 curveto
338.44101 35.7148 339.39099 35.2656 340.09799 34.3711 curveto
340.594 33.7344 340.85199 32.9453 340.85901 32 curveto
334.621 32 lineto
334.707 32.7695 lineto
339.879 32.7695 lineto
339.758 33.2461 339.59 33.625 339.35501 33.91411 curveto
339.125 34.1953 338.828 34.4258 338.453 34.5977 curveto
338.078 34.77339 337.68399 34.8633 337.27301 34.8633 curveto
336.59799 34.8633 336.008 34.6406 335.51599 34.207 curveto
335.164 33.8867 334.89099 33.4062 334.707 32.7695 curveto
334.621 32 lineto
334.637 31.1953 334.89099 30.5352 335.39099 30.0156 curveto
335.887 29.5039 336.504 29.2422 337.23401 29.2422 curveto
337.59 29.2422 337.93 29.3047 338.26599 29.4297 curveto
338.60199 29.5547 338.883 29.7188 339.113 29.9219 curveto
339.35199 30.1211 339.60501 30.4492 339.879 30.9062 curveto
 closepath fill
newpath 342.18399 35.53911 moveto
343.09799 35.53911 lineto
343.09799 34.52339 lineto
343.363 34.9258 343.65201 35.2227 343.957 35.418 curveto
344.258 35.6172 344.574 35.7148 344.90201 35.7148 curveto
345.14499 35.7148 345.41 35.6367 345.68799 35.4805 curveto
345.22699 34.7305 lineto
345.035 34.8086 344.879 34.8477 344.754 34.8477 curveto
344.457 34.8477 344.172 34.7305 343.89499 34.4844 curveto
343.617 34.2383 343.406 33.8594 343.262 33.3438 curveto
343.14801 32.9492 343.09799 32.1523 343.09799 30.9492 curveto
343.09799 28.60161 lineto
342.18399 28.60161 lineto
 closepath fill
newpath 346.031 35.53911 moveto
346.949 35.53911 lineto
349.078 30.5039 lineto
351.289 35.53911 lineto
351.449 35.53911 lineto
353.676 30.5039 lineto
355.844 35.53911 lineto
356.76999 35.53911 lineto
353.758 28.60161 lineto
353.59 28.60161 lineto
351.379 33.5625 lineto
349.16 28.60161 lineto
348.996 28.60161 lineto
 closepath fill
newpath 361.09799 35.7148 moveto
362.164 35.7148 363.055 35.332 363.754 34.5547 curveto
364.39099 33.85161 364.711 33.0156 364.711 32.0508 curveto
364.711 31.082 364.375 30.2383 363.699 29.5156 curveto
363.02701 28.7852 362.16 28.4258 361.09799 28.4258 curveto
361.094 29.27339 lineto
361.59 29.27339 362.043 29.3867 362.457 29.625 curveto
362.871 29.8594 363.199 30.1992 363.44101 30.6328 curveto
363.68399 31.0664 363.80899 31.5312 363.80899 32.0312 curveto
363.80899 32.8086 363.539 33.4727 363.004 34.0195 curveto
362.465 34.5703 361.832 34.8398 361.094 34.8398 curveto
361.094 34.8398 lineto
360.35199 34.8398 359.715 34.5703 359.18399 34.0195 curveto
358.65201 33.4727 358.383 32.8086 358.383 32.0312 curveto
358.383 31.5312 358.504 31.0664 358.746 30.6328 curveto
358.992 30.1992 359.32 29.8594 359.73401 29.625 curveto
360.14801 29.3867 360.60199 29.27339 361.094 29.27339 curveto
361.09799 28.4258 lineto
360.035 28.4258 359.168 28.7852 358.492 29.5156 curveto
357.81601 30.2383 357.47699 31.082 357.47699 32.0508 curveto
357.47699 33.0117 357.793 33.8438 358.43399 34.5508 curveto
359.14099 35.3281 360.02301 35.7148 361.09799 35.7148 curveto
 closepath fill
newpath 366.22699 28.60161 moveto
367.121 28.60161 lineto
367.121 38.2148 lineto
366.22699 38.2148 lineto
 closepath fill
newpath 371.828 38.2148 moveto
371.828 37.33589 lineto
371.504 37.4805 371.22299 37.5508 370.988 37.5508 curveto
370.81299 37.5508 370.672 37.5156 370.555 37.4453 curveto
370.44101 37.375 370.371 37.293 370.34 37.1992 curveto
370.305 37.1094 370.297 36.8672 370.297 36.4727 curveto
370.297 35.53911 lineto
371.742 35.53911 lineto
371.742 34.7656 lineto
370.293 34.7656 lineto
370.289 28.60161 lineto
369.39499 28.60161 lineto
369.39499 34.7656 lineto
368.48001 34.7656 lineto
368.48001 35.53911 lineto
369.39499 35.53911 lineto
369.39499 36.6211 lineto
369.39499 37.1172 369.43799 37.47661 369.531 37.6875 curveto
369.621 37.89839 369.77301 38.0703 370 38.1992 curveto
370.215 38.3281 370.48401 38.3945 370.793 38.3945 curveto
371.082 38.3945 371.426 38.33589 371.828 38.2148 curveto
 closepath fill
newpath 379.98001 35.53911 moveto
379.98001 28.60161 lineto
379.10199 28.60161 lineto
379.10199 29.7969 lineto
378.72699 29.3398 378.30899 28.9961 377.844 28.7656 curveto
377.375 28.53911 376.863 28.4258 376.31601 28.4258 curveto
375.336 28.4258 374.5 28.7812 373.801 29.4922 curveto
373.10501 30.2031 372.762 31.0703 372.762 32.0898 curveto
372.762 33.08589 373.10901 33.9414 373.80899 34.6523 curveto
374.512 35.3594 375.35501 35.7148 376.34 35.7148 curveto
376.91 35.7148 377.43 35.5938 377.89099 35.35161 curveto
378.34799 35.1133 378.754 34.7461 379.10199 34.2656 curveto
378.367 34.0508 lineto
377.84 34.58589 377.18799 34.8555 376.414 34.8555 curveto
376.414 34.8555 lineto
375.918 34.8555 375.461 34.7344 375.043 34.4922 curveto
374.621 34.2461 374.289 33.89839 374.039 33.457 curveto
373.793 33.0156 373.664 32.5547 373.664 32.0586 curveto
373.664 31.5742 373.793 31.1055 374.043 30.66411 curveto
374.293 30.2148 374.629 29.8672 375.051 29.6172 curveto
375.47299 29.3711 375.926 29.2461 376.406 29.2461 curveto
376.89499 29.2461 377.35501 29.3672 377.797 29.6133 curveto
378.23401 29.8594 378.57 30.1992 378.805 30.6172 curveto
379.039 31.03911 379.16 31.5078 379.16 32.0352 curveto
379.16 32.83589 378.89499 33.5117 378.367 34.0508 curveto
379.10199 34.2656 lineto
379.10199 35.53911 lineto
 closepath fill
newpath 388.719 34.0977 moveto
388.012 33.6523 lineto
387.39801 34.4688 386.56601 34.875 385.508 34.875 curveto
384.66 34.875 383.961 34.60161 383.406 34.0586 curveto
382.84799 33.5156 382.56601 32.8555 382.56601 32.0781 curveto
382.56601 31.5742 382.699 31.0977 382.953 30.6562 curveto
383.211 30.21089 383.56201 29.8594 384.008 29.6133 curveto
384.457 29.3672 384.957 29.2422 385.51999 29.2422 curveto
386.535 29.2422 387.367 29.6523 388.012 30.4648 curveto
388.719 30 lineto
388.383 29.4961 387.93799 29.1094 387.383 28.83589 curveto
386.828 28.5625 386.18799 28.4258 385.47699 28.4258 curveto
384.379 28.4258 383.469 28.77339 382.746 29.4688 curveto
382.02301 30.168 381.656 31.0156 381.656 32.0117 curveto
381.656 32.6836 381.836 33.3047 382.172 33.8828 curveto
382.508 34.46089 382.97299 34.9102 383.56201 35.2305 curveto
384.15201 35.5508 384.80899 35.7148 385.547 35.7148 curveto
386.004 35.7148 386.445 35.6445 386.871 35.5039 curveto
387.301 35.3633 387.664 35.1836 387.961 34.957 curveto
388.258 34.7305 388.508 34.4453 388.719 34.0977 curveto
 closepath fill
newpath 390.43399 38.2148 moveto
391.324 38.2148 lineto
391.324 34.293 lineto
391.68399 34.7695 392.082 35.125 392.51599 35.3594 curveto
392.949 35.5977 393.418 35.7148 393.926 35.7148 curveto
394.445 35.7148 394.90201 35.582 395.301 35.3203 curveto
395.703 35.0586 396 34.7031 396.19101 34.2617 curveto
396.383 33.8125 396.48001 33.1172 396.48001 32.1719 curveto
396.48001 28.60161 lineto
395.582 28.60161 lineto
395.582 31.9102 lineto
395.582 32.707 395.551 33.2383 395.492 33.5117 curveto
395.379 33.9727 395.18 34.3164 394.887 34.5469 curveto
394.59799 34.7773 394.219 34.8945 393.746 34.8945 curveto
393.203 34.8945 392.719 34.7148 392.293 34.3594 curveto
391.863 34 391.586 33.5625 391.449 33.0312 curveto
391.363 32.6914 391.324 32.0625 391.324 31.14839 curveto
391.324 28.60161 lineto
390.43399 28.60161 lineto
 closepath fill
showpage
%%EOF
}
