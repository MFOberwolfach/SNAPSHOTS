%% snapshotmfo.cls
%% Copyright 2014 Mathematisches Forschungsinstitut Oberwolfach, www.mfo.de
%%  developed within the project IMAGINARY, www.imaginary.org
%%  supported by the Klaus Tschira Stiftung
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
% 
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is Christian Stussak
% (Mathematisches Forschungsinstitut Oberwolfach).
%
% This work consists of the file snapshotmfo.cls.
%
% The following authors contributed to this work (alphabetical order):
%   Carla Cederbaum (concept)
%   Konrad Renner (design)
%   Christian Stussak (programming)
%
% with additional support by
%   Sophia Jahns (testing)
%   Christoph Knoth (design)
%   Andreas Daniel Matt (concept)
%   Lea Renner (testing)
%
%%
\NeedsTeXFormat{LaTeX2e}
\listfiles
\ProvidesClass{snapshotmfo}[2014/07/31 Document class for "Snapshots of modern mathematics from Oberwolfach"]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output warning if obsolute features are used
\IfFileExists{nag.sty}{\RequirePackage[l2tabu]{nag}}{}
%
\LoadClass[10pt,twoside]{scrartcl} 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% require pdflatex compiler if possible 
\IfFileExists{iftex.sty}{\RequirePackage{iftex}\RequirePDFTeX}{}
\RequirePackage{ifpdf}
\ifpdf\else\ClassError{snapshotmfo}{The snapshotmfo document class only works with pdflatex}{Use pdflatex to compile your document}\fi

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
\RequirePackage{etoolbox,ifthen,environ,trimspaces}
\@ifpackagelater{etoolbox}{2009/08/06}{}{\ClassError{snapshotmfo}{etoolbox v1.8 (2009/08/06) or later required}{Please update your TeX distribution to meet the requirements.}\stop}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% formatting of abstract and setting it 'subject' PDF meta data
\let\snapshot@abstract\abstract
\let\snapshot@endabstract\endabstract
\let\abstract\undefined
\let\endabstract\undefined
\NewEnviron{abstract}{%
	\snapshot@abstract\relscale{1.3}\noindent\ignorespaces\BODY\snapshot@endabstract% add special formatting and print \BODY
	\def\par{ } % collaps paragraphs for meta data inclusion
	\hypersetup{pdfsubject={\BODY}}% copy abstract into meta data
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% page layout
\RequirePackage[a5paper,top=12mm,bottom=22mm,outer=16mm,inner=12mm,foot=12.25mm,footnotesep=14pt]{geometry}
\RequirePackage{multicol}
\setlength{\columnsep}{2em}
\setlength\parindent{1.275em}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% footnotes
%\def\thefootnote{\framebox{\arabic{footnote}}}
\newcommand\snapshot@footnotemark{%
	\setlength{\fboxsep}{0.1em}%
	\setlength{\fboxrule}{0.04em}%
	\textsuperscript{\framebox{\raisebox{0pt}[1.05\height][0.025\height]{\thefootnotemark}}}%
}
\deffootnote[1.5em]{0em}{1.5em}{\rlap{\snapshot@footnotemark}\hspace{1.5em}}
\deffootnotemark{\snapshot@footnotemark}
\@ifclasslater{scrartcl}{2010/06/17}{%
\setfootnoterule[0.526pt]{\textwidth}
}{%
	\renewcommand{\footnoterule}{%
	  \kern -3pt
	  \hrule width \textwidth height 0.526pt
	  \kern 2.474pt
	}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fonts & symbols
\RequirePackage{fix-cm}
\RequirePackage[T1]{fontenc}%
\RequirePackage{textcomp}
\RequirePackage{lmodern}
\RequirePackage[scaled=0.82304487406237511878]{helvet}
\RequirePackage{relsize}
\AtBeginDocument{\RequirePackage{ellipsis}}% delayed loading for compatibility with babel
\RequirePackage[tracking=true]{microtype}
\DeclareMicrotypeSet*[tracking]{letterspacedHelvetica}{family=phv}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% references (via BibTeX, babelbib and isodate)
\usepackage[fixlanguage,languagenames]{babelbib}

\let\snapshot@bibliography\bibliography
\def\bibliography{\gdef\snapshot@bib@printed{\relax}\bibliographystyle{babamspl}\snapshot@bibliography}

\usepackage[german,ngerman,english,USenglish,UKenglish]{isodate}
\setbibliographyfont{urldate}{\printdate}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% language specific settings

% patch old KOMA script \newcaptionname and \renewcaptionname
\let\@orig@newcaptionname\newcaptionname%
\def\newcaptionname#1#2#3{\def\do##1{\@orig@newcaptionname{##1}{#2}{#3}}\docsvlist{#1}}%
\let\@orig@renewcaptionname\renewcaptionname%
\def\renewcaptionname#1#2#3{\def\do##1{\@orig@renewcaptionname{##1}{#2}{#3}}\docsvlist{#1}}%

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
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@creditstext}{\emph{Snapshots of modern mathematics from Oberwolfach} are written by participants in the scientific program of the Mathematisches Forschungsinstitut Oberwolfach (MFO). The snapshot project is designed to promote the understanding and appreciation \\of modern mathematics and mathematical research in the general public worldwide. \\It is part of the mathematics communication project ``Oberwolfach meets IMAGINARY'' funded by the Klaus Tschira Foundation and the Oberwolfach Foundation. All snapshots can be found on \href{http://www.imaginary.org}{\nolinkurl{www.imaginary.org}} and on \href{http://www.mfo.de/snapshots}{\nolinkurl{www.mfo.de/snapshots}}.}%
	\newcaptionname{german,ngerman}{\snapshot@l@creditstext}{\emph{Schnappsch\"usse moderner Mathematik aus Oberwolfach} werden von Teilnehmerinnen und Teilnehmern des wissenschaftlichen Programms des Mathematischen Forschungs-\\instituts Oberwolfach (MFO) geschrieben. Das Schnappschuss-Projekt hat zum Ziel, Verst\"andnis und Wertsch\"atzung f\"ur moderne Mathematik und mathematische Forschung in der allgemeinen Bev\"olkerung weltweit zu f\"ordern. Es ist Teil des Mathe-\\matikkommunikation-Projekts \glqq Oberwolfach trifft IMAGINARY\grqq, welches von der Klaus Tschira Stiftung und der Oberwolfach Stiftung gef\"ordert wird. Alle Schnapp-\\sch\"usse k\"onnen unter \href{http://www.imaginary.org}{\nolinkurl{www.imaginary.org}} sowie unter \href{http://www.mfo.de/snapshots}{\nolinkurl{www.mfo.de/snapshots}} abgerufen werden.}%
	%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@translator@german}{Translated from German by}%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@translator@english}{Translated from English by\ClassWarningNoLine{snapshotmfo}{Translated by: from English to English}}%
	\newcaptionname{german,ngerman}{\snapshot@l@translator@english}{\"Ubersetzt aus dem Englischen von}%
	\newcaptionname{german,ngerman}{\snapshot@l@translator@german}{\"Ubersetzt aus dem Deutschen von\ClassWarningNoLine{snapshotmfo}{Translated by: from German to German}}%
	\let\snapshot@l@translator@ngerman\snapshot@l@translator@german%
	\let\snapshot@l@translator@USenglish\snapshot@l@translator@english%
	\let\snapshot@l@translator@UKenglish\snapshot@l@translator@english%
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
	\newcaptionname{german,ngerman}{\snapshot@l@senioreditor}{Chefeditor/in}%
	%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@director}{Director}%
	\newcaptionname{german,ngerman}{\snapshot@l@director}{Direktor/in}%
	%
	\newcaptionname{english,USenglish,UKenglish}{\snapshot@l@mfoaddress}{Mathematisches Forschungsinstitut\\Oberwolfach gGmbH\\Schwarzwaldstr. 9\,--1\!1\\77709 Oberwolfach\\Germany}%
	\newcaptionname{german,ngerman}{\snapshot@l@mfoaddress}{Mathematisches Forschungsinstitut\\Oberwolfach gGmbH\\Schwarzwaldstr. 9\,--1\!1\\77709 Oberwolfach\\Deutschland}%
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
	% section name for image credits
	\newcscaptionname{english,USenglish,UKenglish}{snaphot@l@image credits}{Image credits}
	\newcscaptionname{german,ngerman}{snaphot@l@image credits}{Bildquellen}	
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

\setdescription{font=\normalfont\sffamily\relscale{1.1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hyperlinks
\RequirePackage{hyperref}
\@ifpackagelater{hyperref}{2011/02/05}{\hypersetup{hidelinks}}{\hypersetup{colorlinks=false,pdfborder={0 0 0}}}

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

\renewcommand\UrlFont{}%

\setkomafont{pagenumber}{\normalfont\sffamily\relscale{1.1}}
\setkomafont{section}{\normalfont\sffamily\relscale{1.32}}

\setkomafont{subsection}{\normalfont\sffamily\relscale{1.1}}
\setkomafont{subsubsection}{\normalfont\sffamily\relscale{1.1}}
\setkomafont{paragraph}{\normalfont\sffamily\relscale{1.1}}
\setkomafont{subparagraph}{\normalfont\sffamily\relscale{1.1}}
\setkomafont{captionlabel}{\normalfont\sffamily\relscale{1.1}}

\setkomafont{title}{\renewcommand{\baselinestretch}{0.8}\color[gray]{0.25}\sffamily\relscale{1.8}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% environment for image credits
\newenvironment{imagecredits}{%
	% assure that image credits are printed before the bibliography
	\ifdefined\snapshot@bib@printed\ClassError{snapshotmfo}{\noexpand\bibliography must not be used before imagecredits environment}{Change the order of image credits and the bibliography}\fi%
	% print the image credits
	\section*{\csname snaphot@l@image credits\endcsname}\begin{description}}{\end{description}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% snapshot id and DOI computation
\newcommand{\snapshot@id}{\ClassWarningNoLine{snapshotmfo}{No snapshot id given}xx}%
\newcommand{\snapshot@year}{xxxx}%
\AtBeginDocument{\newcaptionname{english,USenglish,UKenglish,german,ngerman}{\snapshot@doi}{\ClassWarningNoLine{snapshotmfo}{Unable to compute DOI}\snapshot@defaultcontent}}%
\gdef\snapshot@doiurlprefix{http://dx.doi.org/}%
\gdef\snapshot@doilink{\snapshot@doi}%
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
	\gdef\snapshot@doilink{\href{\snapshot@doiurlprefix\snapshot@doi}{\snapshot@doi}}%
	\AtEndDocument{%
		\def\snapshot@doi@warning{\ClassWarningNoLine{snapshotmfo}{DOI changed. Rerun to get PDF meta data right}}%
		\ifthenelse{\isundefined{\snapshot@doi@meta}}{\snapshot@doi@warning}{\ifthenelse{\NOT\equal{\snapshot@doi}{\snapshot@doi@meta}}{\snapshot@doi@warning}{}}
		\immediate\write\@auxout{\noexpand\gdef\noexpand\snapshot@doi@meta{\snapshot@doi}}%
	}
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
	\ifblank{#1}{%
		\ClassError{snapshotmfo}{Mathematical subject must not be blank}{}%
	}{%
		\gdef\snapshot@categorization@math{\space}%
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
					\gappto\snapshot@categorization@math{,\space\expandafter\csname snaphot@l@categorization@math@##1\endcsname}%
				}{%
					\ClassError{snapshotmfo}{Unknown category "##1" in \@backslashchar categorizationmath}{possibilities: \snapshot@categorization@math@subjects}%
				}%
			}%
			\def\do##1{\snapshot@add@categorization@math{##1}}%
			\docsvlist{#1}%
		\endgroup%
		\patchcmd{\snapshot@categorization@math}{\space,\space}{}{}{}% remove leading ,
		\AtEndDocument{%
			\def\snapshot@categorization@math@warning{\ClassWarningNoLine{snapshotmfo}{Mathematical categorization changed. Rerun to get PDF meta data right}}%
			\ifthenelse{\isundefined{\snapshot@categorization@math@meta}}{\snapshot@categorization@math@warning}{\ifthenelse{\NOT\equal{\snapshot@categorization@math}{\snapshot@categorization@math@meta}}{\snapshot@categorization@math@warning}{}}
			\immediate\write\@auxout{\noexpand\gdef\noexpand\snapshot@categorization@math@meta{\snapshot@categorization@math}}%
		}
	}%
}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% categorization: connection to other fields
\newif\if@snapshot@show@categorization@connect\@snapshot@show@categorization@connecttrue
\gdef\snapshot@categorization@connect{\ClassWarningNoLine{snapshotmfo}{No connection to other fields given}\snapshot@defaultcontent}
\newcommand*{\categorizationconnect}[1]{%
	\ifblank{#1}{%
		\@snapshot@show@categorization@connectfalse% disable display of this field
	}{%
		\gdef\snapshot@categorization@connect{\space}%
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
					\gappto\snapshot@categorization@connect{,\space\expandafter\csname snaphot@l@categorization@connect@##1\endcsname}%
				}{%
					\ClassError{snapshotmfo}{Unknown category "##1" in \@backslashchar categorizationconnect}{possibilities: \snapshot@categorization@connect@subjects}%
				}%
			}%
			\def\do##1{\snapshot@add@categorization@connect{##1}}%
			\docsvlist{#1}%
		\endgroup%
		\patchcmd{\snapshot@categorization@connect}{\space,\space}{}{}{}% remove leading ,
		\AtEndDocument{%
			\def\snapshot@categorization@connect@warning{\ClassWarningNoLine{snapshotmfo}{Connection to other fields changed. Rerun to get PDF meta data right}}%
			\ifthenelse{\isundefined{\snapshot@categorization@connect@meta}}{\snapshot@categorization@connect@warning}{\ifthenelse{\NOT\equal{\snapshot@categorization@connect}{\snapshot@categorization@connect@meta}}{\snapshot@categorization@connect@warning}{}}
			\immediate\write\@auxout{\noexpand\gdef\noexpand\snapshot@categorization@connect@meta{\snapshot@categorization@connect}}%
		}
	}%
}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% translator
\newcommand*{\translator}[2]{%
	\gdef\snapshot@l@translator{\expandafter\csname snapshot@l@translator@#1\endcsname}%
	\gdef\snapshot@translator{#2}%
}%

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
% PDF meta data
\AtBeginDocument{%
	\bgroup%
		\def\thanks#1{}%
		\def\and{\iffalse{\fi}, \noexpand\trim@spaces{\iffalse}\fi}%
		\protected@edef\@metaauthor{\noexpand\trim@spaces{\@author}}%
		\hypersetup{pdfauthor={\@metaauthor},pdftitle={\@title}}%
		\def\ClassWarningNoLine#1#2{}%
		\def\snapshot@pdfinfo{%
				Volume={\snapshot@year},%
				Issue={\snapshot@id},%
				SeniorEditor={\snapshot@senioreditor},%
				JuniorEditor={\snapshot@junioreditor},%
				Director={\snapshot@director}%
		}%
		\ifthenelse{\isundefined{\snapshot@doi@meta}}{}{\appto{\snapshot@pdfinfo}{,DOI={\snapshot@doi@meta}}}%
		\ifthenelse{\isundefined{\snapshot@categorization@math@meta}}{}{\appto{\snapshot@pdfinfo}{,MathematicalSubjects={\snapshot@categorization@math@meta}}}%
		\ifthenelse{\isundefined{\snapshot@categorization@connect@meta}}{}{\appto{\snapshot@pdfinfo}{,ConnectedFields={\snapshot@categorization@connect@meta}}}%
		\edef\snapshot@pdfinfo{pdfinfo={\snapshot@pdfinfo}}%
		\expandafter\hypersetup\expandafter{\snapshot@pdfinfo}%
	\egroup%
}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% define title
\renewcommand*\maketitle{%
	\par
	\begingroup
		\snapshot@define@spaces%
		\newpage
		\global\@topnum\z@
		\@maketitle
		\thispagestyle{\titlepagestyle}\@thanks
	\endgroup
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
      \relscale{1.2}%
      \lineskip .5em%
      \sffamily%
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
			\ifdef{\snapshot@l@translator}{%
				\textit{\snapshot@l@translator}\\*
				\snapshot@translator\\[\medskipamount]
			}{}%
			%
			\textit{\snapshot@label@l@categorization@math}\\*
			\snapshot@categorization@math\\[\medskipamount]
			%
			\if@snapshot@show@categorization@connect
				\textit{\snapshot@label@l@categorization@connect}\\*
				\snapshot@categorization@connect\\[\medskipamount]
			\fi
			%
			\textit{\snapshot@l@license}\\*
			\snapshot@license\\[\medskipamount]
			%
			\textit{\snapshot@l@doi}\\*
			\snapshot@doilink%
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
				\snapshot@l@mfoaddress\\[\medskipamount]
				%
				\textit{\snapshot@l@director}\\
				\snapshot@director%
			}\par%
		\end{multicols}%
		\vskip 0.75cm
		\noindent%
		\def\testtest{\snapshot@logo@de}%
		\raisebox{-.34725559716718504883\height}[.65274440283281495117\height][-.34725559716718504883\height]{%
			\resizebox*{\linewidth}{!}{\snapshot@l@epslogo}%
		}%
	}}}%
	\clearpage%
	\thispagestyle{empty}%
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
% consider shrinking the input pdf using to an appropriate level,
% e.g. using ghostscript via shrinkpdf
% http://www.alfredklomp.com/programming/shrinkpdf

\snapshot@savemps\snapshot@logo@en{
%!PS-Adobe-3.0 EPSF-3.0
%%BoundingBox: 0 0 525 44 
%%HiResBoundingBox: 0.08498 0.71169 524.82 43.22661 
%%Creator: MetaPost 1.803
%%CreationDate: 2014.09.12:1519
%%Pages: 1
%%BeginProlog
%%EndProlog
%%Page: 1 1
 0.137 0.122 0.125 setrgbcolor
newpath 491.953 19.9883 moveto
492.52701 19.9883 lineto
492.52701 20.4805 lineto
491.953 20.4805 lineto
491.953 21.58589 lineto
491.422 21.58589 lineto
491.422 20.4805 lineto
491.117 20.4805 lineto
491.117 19.9883 lineto
491.422 19.9883 lineto
491.422 17.6445 lineto
491.953 17.6445 lineto
 closepath fill
newpath 472.35501 19.9883 moveto
472.887 19.9883 lineto
472.887 20.4805 lineto
472.35501 20.4805 lineto
472.35501 21.58589 lineto
471.785 21.58589 lineto
471.785 20.4805 lineto
471.48001 20.4805 lineto
471.48001 19.9883 lineto
471.785 19.9883 lineto
471.785 17.6445 lineto
472.35501 17.6445 lineto
 closepath fill
newpath 500.633 20.082 moveto
500.48001 20.4062 500.195 20.5781 499.85199 20.5781 curveto
499.375 20.5781 499.01599 20.2344 499.01599 19.7383 curveto
499.01599 19.3594 499.242 19.207 499.547 19.0352 curveto
500.10199 18.75 lineto
500.215 18.6562 500.289 18.5781 500.289 18.4258 curveto
500.289 18.1797 500.10199 18.0469 499.871 18.0469 curveto
499.60501 18.0469 499.453 18.1797 499.35501 18.4062 curveto
498.863 18.1797 lineto
499.035 17.7812 499.453 17.5312 499.871 17.5312 curveto
500.387 17.5312 500.85901 17.9336 500.85901 18.4844 curveto
500.85901 18.9219 500.535 19.14839 500.195 19.3008 curveto
499.85199 19.4336 499.52701 19.5664 499.52701 19.7969 curveto
499.52701 19.9688 499.68 20.082 499.81201 20.082 curveto
499.98401 20.082 500.117 19.9883 500.195 19.8555 curveto
 closepath fill
newpath 498.10199 19.9492 moveto
497.988 20.1406 497.60501 20.5781 496.961 20.5781 curveto
496.086 20.5781 495.39801 19.9297 495.39801 19.0352 curveto
495.39801 18.1797 496.086 17.5312 496.922 17.5312 curveto
497.551 17.5312 497.89099 17.875 498.06201 18.1211 curveto
497.68399 18.4062 lineto
497.512 18.2188 497.34 18.0469 496.94101 18.0469 curveto
496.332 18.0469 495.93399 18.4844 495.93399 19.0742 curveto
495.93399 19.58589 496.35199 20.082 496.90201 20.082 curveto
497.22699 20.082 497.492 19.9297 497.703 19.6836 curveto
 closepath fill
newpath 493.97299 22.1953 moveto
493.742 22.1953 493.59 22.0039 493.59 21.793 curveto
493.59 21.58589 493.742 21.4336 493.97299 21.4336 curveto
494.16 21.4336 494.35199 21.58589 494.35199 21.793 curveto
494.35199 22.0039 494.16 22.1953 493.97299 22.1953 curveto
 closepath fill
newpath 494.219 20.4805 moveto
493.68799 20.4805 lineto
493.68799 17.6445 lineto
494.219 17.6445 lineto
 closepath fill
newpath 489.805 20.4805 moveto
489.254 20.4805 lineto
489.254 20.02339 lineto
489.02301 20.3672 488.68399 20.5781 488.262 20.5781 curveto
488.35901 20.082 lineto
488.949 20.082 489.293 19.625 489.293 19.0742 curveto
489.293 18.5039 488.949 18.0469 488.35901 18.0469 curveto
488.35901 18.0469 lineto
487.76999 18.0469 487.445 18.53911 487.445 19.0742 curveto
487.445 19.58589 487.789 20.082 488.35901 20.082 curveto
488.262 20.5781 lineto
487.426 20.5781 486.91 19.8711 486.91 19.0938 curveto
486.91 18.2539 487.406 17.5312 488.262 17.5312 curveto
488.68399 17.5312 489.02301 17.7617 489.254 18.08589 curveto
489.254 17.6445 lineto
489.805 17.6445 lineto
 closepath fill
newpath 482.383 20.4805 moveto
481.832 20.4805 lineto
481.832 17.6445 lineto
482.383 17.6445 lineto
482.383 19.0352 lineto
482.383 19.4922 482.422 20.082 483.012 20.082 curveto
483.508 20.082 483.52301 19.5312 483.52301 19.14839 curveto
483.52301 17.6445 lineto
484.078 17.6445 lineto
484.078 19.0352 lineto
484.078 19.4922 484.133 20.082 484.703 20.082 curveto
485.199 20.082 485.258 19.625 485.258 19.2461 curveto
485.258 17.6445 lineto
485.789 17.6445 lineto
485.789 19.3398 lineto
485.789 19.9883 485.59799 20.5781 484.85501 20.5781 curveto
484.496 20.5781 484.15201 20.3867 483.965 20.082 curveto
483.77301 20.4062 483.508 20.5781 483.14499 20.5781 curveto
482.82 20.5781 482.555 20.3867 482.383 20.1211 curveto
 closepath fill
newpath 480.51999 18.96089 moveto
480.51999 19.0547 lineto
480.51999 19.9102 480.082 20.5781 479.168 20.5781 curveto
478.254 20.5781 477.797 19.9102 477.797 19.0352 curveto
477.797 18.1992 478.31201 17.5312 479.18799 17.5312 curveto
479.738 17.5312 480.254 17.8164 480.51999 18.3125 curveto
480.06201 18.5781 lineto
479.85199 18.2344 479.625 18.0469 479.18799 18.0469 curveto
478.672 18.0469 478.34799 18.4844 478.328 18.96089 curveto
478.367 19.39839 lineto
478.426 19.7969 478.746 20.10161 479.168 20.10161 curveto
479.625 20.10161 479.91 19.83589 479.965 19.39839 curveto
478.367 19.39839 lineto
478.328 18.96089 lineto
 closepath fill
newpath 474.125 22.2148 moveto
474.125 17.6445 lineto
474.676 17.6445 lineto
474.676 18.9414 lineto
474.676 19.4727 474.676 20.082 475.379 20.082 curveto
475.949 20.082 476.008 19.7383 476.008 19.2656 curveto
476.008 17.6445 lineto
476.55899 17.6445 lineto
476.55899 19.3398 lineto
476.55899 20.043 476.35199 20.5781 475.531 20.5781 curveto
475.211 20.5781 474.867 20.4258 474.676 20.10161 curveto
474.676 22.2148 lineto
 closepath fill
newpath 470.262 20.4805 moveto
469.73001 20.4805 lineto
469.73001 20.02339 lineto
469.711 20.02339 lineto
469.48001 20.3672 469.14099 20.5781 468.719 20.5781 curveto
468.81601 20.082 lineto
469.406 20.082 469.746 19.625 469.746 19.0742 curveto
469.746 18.5039 469.406 18.0469 468.81601 18.0469 curveto
468.81601 18.0469 lineto
468.22699 18.0469 467.90201 18.53911 467.90201 19.0742 curveto
467.90201 19.58589 468.242 20.082 468.81601 20.082 curveto
468.719 20.5781 lineto
467.883 20.5781 467.367 19.8711 467.367 19.0938 curveto
467.367 18.2539 467.863 17.5312 468.719 17.5312 curveto
469.14099 17.5312 469.48001 17.7617 469.711 18.08589 curveto
469.73001 18.08589 lineto
469.73001 17.6445 lineto
470.262 17.6445 lineto
 closepath fill
newpath 462.84 20.4805 moveto
462.26999 20.4805 lineto
462.26999 17.6445 lineto
462.84 17.6445 lineto
462.84 19.0352 lineto
462.84 19.4922 462.879 20.082 463.469 20.082 curveto
463.98001 20.082 464 19.5312 464 19.14839 curveto
464 17.6445 lineto
464.555 17.6445 lineto
464.555 19.0352 lineto
464.555 19.4922 464.59 20.082 465.18 20.082 curveto
465.656 20.082 465.715 19.625 465.715 19.2461 curveto
465.715 17.6445 lineto
466.246 17.6445 lineto
466.246 19.3398 lineto
466.246 19.9883 466.055 20.5781 465.31201 20.5781 curveto
464.953 20.5781 464.60901 20.3867 464.418 20.082 curveto
464.246 20.4062 463.98001 20.5781 463.60199 20.5781 curveto
463.27701 20.5781 462.992 20.3867 462.84 20.1211 curveto
 closepath fill
newpath 456.332 20.4805 moveto
455.781 20.4805 lineto
455.781 17.6445 lineto
456.332 17.6445 lineto
456.332 18.9414 lineto
456.332 19.4727 456.332 20.082 457.035 20.082 curveto
457.60501 20.082 457.68399 19.7383 457.68399 19.2656 curveto
457.68399 17.6445 lineto
458.195 17.6445 lineto
458.195 19.3398 lineto
458.195 20.043 458.02301 20.5781 457.207 20.5781 curveto
456.863 20.5781 456.52301 20.4258 456.35199 20.10161 curveto
456.332 20.10161 lineto
 closepath fill
newpath 454.695 18.96089 moveto
454.695 19.0547 lineto
454.695 19.9102 454.27701 20.5781 453.363 20.5781 curveto
452.449 20.5781 451.97299 19.9102 451.97299 19.0352 curveto
451.97299 18.1992 452.508 17.5312 453.363 17.5312 curveto
453.93399 17.5312 454.43 17.8164 454.695 18.3125 curveto
454.238 18.5781 lineto
454.02701 18.2344 453.801 18.0469 453.363 18.0469 curveto
452.85199 18.0469 452.52701 18.4844 452.52701 18.96089 curveto
452.547 19.39839 lineto
452.621 19.7969 452.945 20.10161 453.363 20.10161 curveto
453.801 20.10161 454.086 19.83589 454.14499 19.39839 curveto
452.547 19.39839 lineto
452.52701 18.96089 lineto
 closepath fill
newpath 448.699 20.4805 moveto
448.14801 20.4805 lineto
448.14801 15.9922 lineto
448.699 15.9922 lineto
448.699 18.08589 lineto
448.719 18.08589 lineto
448.93 17.7617 449.27301 17.5312 449.69101 17.5312 curveto
450.56601 17.5312 451.043 18.2539 451.043 19.0938 curveto
451.043 19.8711 450.52701 20.5781 449.711 20.5781 curveto
449.578 20.082 lineto
450.168 20.082 450.508 19.625 450.508 19.0742 curveto
450.508 18.5039 450.168 18.0469 449.578 18.0469 curveto
449.578 18.0469 lineto
448.988 18.0469 448.664 18.53911 448.664 19.0742 curveto
448.664 19.58589 449.008 20.082 449.578 20.082 curveto
449.711 20.5781 lineto
449.27301 20.5781 448.93 20.3672 448.719 20.02339 curveto
448.699 20.02339 lineto
 closepath fill
newpath 445.656 20.5781 moveto
445.656 20.0625 lineto
446.207 20.0625 446.64499 19.6055 446.64499 19.0547 curveto
446.64499 18.52339 446.207 18.08589 445.656 18.08589 curveto
445.125 18.08589 444.703 18.52339 444.703 19.0547 curveto
444.703 19.6055 445.125 20.0625 445.656 20.0625 curveto
445.656 20.0625 lineto
445.656 20.5781 lineto
444.82 20.5781 444.133 19.9102 444.133 19.0547 curveto
444.133 18.1992 444.82 17.5312 445.656 17.5312 curveto
446.512 17.5312 447.199 18.1992 447.199 19.0547 curveto
447.199 19.9102 446.512 20.5781 445.656 20.5781 curveto
 closepath fill
newpath 500.613 25.5625 moveto
502.44101 25.5625 lineto
496.94101 37.3594 lineto
491.44101 25.5625 lineto
493.26999 25.5625 lineto
494.449 28.2461 lineto
499.414 28.2461 lineto
498.76599 29.7305 lineto
495.113 29.7305 lineto
496.94101 33.8594 lineto
498.76599 29.7305 lineto
499.414 28.2461 lineto
 closepath fill
newpath 451.918 25.5625 moveto
453.742 25.5625 lineto
448.242 37.3594 lineto
442.746 25.5625 lineto
444.57 25.5625 lineto
445.75 28.2461 lineto
450.719 28.2461 lineto
450.07 29.7305 lineto
446.418 29.7305 lineto
448.242 33.8594 lineto
450.07 29.7305 lineto
450.719 28.2461 lineto
 closepath fill
newpath 524.82 36.9414 moveto
523.086 36.9414 lineto
520.156 32.2422 lineto
517.16803 36.9414 lineto
515.344 36.9414 lineto
519.30103 30.5117 lineto
519.30103 25.5625 lineto
520.95697 25.5625 lineto
520.95697 30.6992 lineto
 closepath fill
newpath 423.73401 36.9414 moveto
422.078 36.9414 lineto
422.078 25.5625 lineto
423.73401 25.5625 lineto
 closepath fill
newpath 473.09799 36.9414 moveto
471.422 36.9414 lineto
471.422 25.5625 lineto
473.09799 25.5625 lineto
 closepath fill
newpath 513.64801 25.5625 moveto
510.22299 30.58589 lineto
511.82 31.0039 512.68 32.1094 512.68 33.707 curveto
512.68 34.8672 512.164 35.875 511.23001 36.4102 curveto
510.488 36.8672 509.883 36.9414 507.75 36.9414 curveto
505.76999 36.9414 lineto
505.76999 25.5625 lineto
507.426 25.5625 lineto
507.426 30.4336 lineto
507.426 31.9375 lineto
507.426 35.457 lineto
508.81601 35.457 lineto
509.594 35.457 510.07 35.3438 510.39499 35.0586 curveto
510.758 34.7344 510.98401 34.1836 510.98401 33.6328 curveto
510.98401 32.9453 510.621 32.375 509.996 32.1094 curveto
509.672 31.97661 509.23401 31.9375 508.207 31.9375 curveto
507.426 31.9375 lineto
507.426 30.4336 lineto
508.301 30.4336 lineto
511.555 25.5625 lineto
 closepath fill
newpath 488.168 36.9414 moveto
486.512 36.9414 lineto
486.512 29.1953 lineto
477.988 37.168 lineto
477.988 25.5625 lineto
479.64499 25.5625 lineto
479.64499 33.3281 lineto
488.168 25.33589 lineto
 closepath fill
newpath 462.383 31.3477 moveto
462.383 29.8633 lineto
465.41 29.8633 lineto
465.086 27.96089 463.754 26.7812 461.73401 26.7812 curveto
459.301 26.7812 457.664 28.7578 457.664 31.4023 curveto
457.664 33.8203 459.35501 35.707 461.77301 35.707 curveto
463.238 35.707 464.305 35.0977 465.39099 33.6875 curveto
466.742 34.7344 lineto
465.465 36.4453 463.80899 37.2852 461.73401 37.2852 curveto
460.40201 37.2852 459.281 36.8672 458.215 36.08589 curveto
456.676 34.9453 455.836 33.25 455.836 31.2695 curveto
455.836 29.5977 456.465 28.0352 457.60501 26.8945 curveto
458.73001 25.7539 459.969 25.2031 461.73401 25.2031 curveto
463.43 25.2031 464.703 25.77339 465.75 26.91411 curveto
466.762 27.9805 467.254 29.2539 467.426 31.3477 curveto
 closepath fill
newpath 437.797 37.47661 moveto
434.14499 29.0273 lineto
430.453 37.47661 lineto
427.578 25.5625 lineto
429.406 25.5625 lineto
430.98401 32.58589 lineto
434.14499 25.08589 lineto
437.301 32.58589 lineto
438.863 25.5625 lineto
440.69101 25.5625 lineto
 closepath fill
 0 1.874 dtransform truncate idtransform setlinewidth pop [] 0 setdash
 0 setlinecap 0 setlinejoin 10 setmiterlimit
newpath 8.51953 15.7227 moveto
21.5 15.7227 lineto
25.6367 15.7227 28.9961 19.082 28.9961 23.2188 curveto
28.9961 27.3555 25.6367 30.7148 21.5 30.7148 curveto
8.51953 30.7148 lineto
21.5 30.7148 lineto stroke
newpath 27.9922 26.9688 moveto
21.5 38.21089 lineto
19.4297 41.793 14.8438 43.02339 11.2617 40.9531 curveto
7.67969 38.8867 6.44922 34.2969 8.51563 30.7148 curveto
8.51563 30.7148 lineto
11.7617 25.0938 lineto
15.0078 19.4727 lineto
8.51563 30.7148 lineto stroke
newpath 8.51953 38.21089 moveto
2.02734 26.9688 lineto
-0.04297 23.3867 1.1875 18.7969 4.76953 16.7305 curveto
8.35156 14.6602 12.9414 15.8906 15.0078 19.4727 curveto
18.2539 25.0938 lineto
15.0078 19.4727 lineto
21.5 30.7148 lineto stroke
newpath 41.1797 36.3203 moveto
40.4531 36.3203 lineto
40.4531 41.0195 lineto
38.9375 37.8242 lineto
38.5078 37.8242 lineto
37.0039 41.0195 lineto
37.0039 36.3203 lineto
36.3281 36.3203 lineto
36.3281 41.77339 lineto
37.3125 41.77339 lineto
38.7656 38.7344 lineto
40.1719 41.77339 lineto
41.1797 41.77339 lineto
 closepath fill
newpath 45.7656 36.3203 moveto
45.082 36.3203 lineto
45.082 36.7578 lineto
45.0195 36.7148 44.9375 36.6562 44.832 36.582 curveto
44.52339 36.9883 lineto
44.7227 37.082 44.9102 37.1953 45.082 37.3281 curveto
45.082 37.3281 lineto
45.082 38.4648 lineto
44.8711 38.4531 44.625 38.4375 44.3398 38.4102 curveto
44.0547 38.3867 43.832 38.35161 43.66411 38.3047 curveto
43.4688 38.25 43.3047 38.1602 43.1836 38.043 curveto
43.0625 37.9258 43 37.7617 43 37.5547 curveto
43 37.3203 43.0742 37.1445 43.2148 37.0273 curveto
43.3555 36.9062 43.5703 36.8477 43.8633 36.8477 curveto
44.10161 36.8477 44.3242 36.8945 44.52339 36.9883 curveto
44.832 36.582 lineto
44.7305 36.5078 44.6289 36.4492 44.5312 36.4062 curveto
44.418 36.35161 44.2852 36.3008 44.1367 36.2656 curveto
43.9883 36.22661 43.8125 36.207 43.6133 36.207 curveto
43.2461 36.207 42.9336 36.332 42.6758 36.5742 curveto
42.418 36.8164 42.293 37.1289 42.293 37.5078 curveto
42.293 37.8164 42.3594 38.0664 42.4922 38.2578 curveto
42.625 38.4492 42.8125 38.60161 43.0586 38.71089 curveto
43.3086 38.8203 43.6094 38.8945 43.957 38.9336 curveto
44.3047 38.9727 44.6797 39.0039 45.082 39.02339 curveto
45.082 39.1289 lineto
45.082 39.2852 45.0547 39.41411 45 39.5156 curveto
44.9453 39.6172 44.8633 39.6992 44.7617 39.7578 curveto
44.66411 39.8125 44.5469 39.85161 44.4102 39.8711 curveto
44.27339 39.8906 44.1328 39.9023 43.9844 39.9023 curveto
43.8008 39.9023 43.60161 39.8789 43.3789 39.832 curveto
43.1562 39.7812 42.9258 39.7148 42.6914 39.6211 curveto
42.6523 39.6211 lineto
42.6523 40.3203 lineto
42.78911 40.3594 42.9844 40.39839 43.2344 40.4414 curveto
43.4883 40.4844 43.7383 40.5078 43.9883 40.5078 curveto
44.27339 40.5078 44.52339 40.4844 44.7383 40.4375 curveto
44.9531 40.3906 45.1367 40.3086 45.293 40.1953 curveto
45.4453 40.082 45.5625 39.9375 45.6445 39.7578 curveto
45.7227 39.582 45.7656 39.3594 45.7656 39.0977 curveto
 closepath fill
newpath 49.21089 36.3594 moveto
49.082 36.3242 48.9414 36.2969 48.78911 36.27339 curveto
48.6367 36.2539 48.5 36.2422 48.3828 36.2422 curveto
47.9648 36.2422 47.64839 36.35161 47.4297 36.5781 curveto
47.21089 36.8008 47.1055 37.1602 47.1055 37.6562 curveto
47.1055 39.832 lineto
46.6406 39.832 lineto
46.6406 40.4102 lineto
47.1055 40.4102 lineto
47.1055 41.58589 lineto
47.793 41.58589 lineto
47.793 40.4102 lineto
49.21089 40.4102 lineto
49.21089 39.832 lineto
47.793 39.832 lineto
47.793 37.9688 lineto
47.793 37.7539 47.7969 37.58589 47.8086 37.4648 curveto
47.8164 37.3438 47.85161 37.2305 47.9102 37.1289 curveto
47.9648 37.0273 48.03911 36.957 48.1328 36.9102 curveto
48.2227 36.8672 48.3672 36.8438 48.5625 36.8438 curveto
48.6719 36.8438 48.78911 36.8594 48.91411 36.8945 curveto
49.0352 36.9258 49.1211 36.9531 49.1758 36.97661 curveto
49.21089 36.97661 lineto
 closepath fill
newpath 53.46089 36.3203 moveto
52.77339 36.3203 lineto
52.77339 38.64839 lineto
52.77339 38.83589 52.7617 39.0117 52.7422 39.1758 curveto
52.7188 39.3438 52.6797 39.4727 52.6211 39.5664 curveto
52.5586 39.668 52.4688 39.7422 52.3555 39.793 curveto
52.2422 39.8438 52.0938 39.8672 51.9102 39.8672 curveto
51.7227 39.8672 51.5273 39.8203 51.3203 39.72661 curveto
51.1172 39.6367 50.918 39.5195 50.7305 39.375 curveto
50.7305 36.3203 lineto
50.043 36.3203 lineto
50.043 42.0156 lineto
50.7305 42.0156 lineto
50.7305 39.957 lineto
50.9453 40.1328 51.168 40.27339 51.39839 40.3711 curveto
51.6289 40.4727 51.8633 40.52339 52.1055 40.52339 curveto
52.5469 40.52339 52.8828 40.3906 53.1133 40.125 curveto
53.3438 39.8594 53.46089 39.47661 53.46089 38.9727 curveto
 closepath fill
newpath 58.21089 38.293 moveto
55.1953 38.293 lineto
55.1953 38.8203 lineto
57.53911 38.8203 lineto
57.5352 39.1836 57.4453 39.46089 57.2656 39.6602 curveto
57.08589 39.8555 56.8125 39.957 56.4492 39.957 curveto
56.0781 39.957 55.7852 39.8477 55.5664 39.6289 curveto
55.3477 39.41411 55.22661 39.1445 55.1953 38.8203 curveto
55.1953 38.293 lineto
55.1953 38.043 55.2344 37.8242 55.3086 37.6367 curveto
55.3867 37.4492 55.4883 37.2969 55.6211 37.1797 curveto
55.7461 37.0625 55.89839 36.9727 56.0742 36.91411 curveto
56.2461 36.8555 56.4414 36.8281 56.64839 36.8281 curveto
56.9258 36.8281 57.207 36.8828 57.4883 36.9922 curveto
57.7695 37.1055 57.9727 37.2148 58.0938 37.3203 curveto
58.1289 37.3203 lineto
58.1289 36.5703 lineto
57.8945 36.4727 57.6602 36.3906 57.418 36.3242 curveto
57.1758 36.2578 56.9219 36.22661 56.6562 36.22661 curveto
55.9805 36.22661 55.4492 36.4102 55.0703 36.7773 curveto
54.6875 37.1445 54.4961 37.66411 54.4961 38.3438 curveto
54.4961 39.0117 54.6797 39.53911 55.043 39.9336 curveto
55.4102 40.3281 55.8906 40.52339 56.4844 40.52339 curveto
57.0352 40.52339 57.46089 40.3633 57.7617 40.03911 curveto
58.0586 39.7188 58.21089 39.2617 58.21089 38.668 curveto
 closepath fill
newpath 65.2188 36.3203 moveto
64.5273 36.3203 lineto
64.5273 38.64839 lineto
64.5273 38.8242 64.5195 38.9961 64.5078 39.1562 curveto
64.4883 39.3203 64.457 39.4531 64.4062 39.5508 curveto
64.3477 39.6562 64.2695 39.7344 64.16411 39.78911 curveto
64.0586 39.8398 63.9062 39.8672 63.71089 39.8672 curveto
63.5156 39.8672 63.3242 39.8203 63.1328 39.7227 curveto
62.9375 39.625 62.7461 39.5039 62.5547 39.3555 curveto
62.5586 39.3008 62.5664 39.2344 62.5703 39.1602 curveto
62.5781 39.08589 62.5781 39.0117 62.5781 38.9375 curveto
62.5781 36.3203 lineto
61.8906 36.3203 lineto
61.8906 38.64839 lineto
61.8906 38.8281 61.8828 39 61.8672 39.16411 curveto
61.85161 39.3242 61.8164 39.457 61.7656 39.5547 curveto
61.71089 39.6602 61.6289 39.7344 61.52339 39.78911 curveto
61.418 39.8398 61.2695 39.8672 61.0703 39.8672 curveto
60.8828 39.8672 60.6953 39.8203 60.5039 39.72661 curveto
60.3164 39.6367 60.1289 39.5195 59.9414 39.375 curveto
59.9414 36.3203 lineto
59.2539 36.3203 lineto
59.2539 40.4102 lineto
59.9414 40.4102 lineto
59.9414 39.957 lineto
60.1523 40.1328 60.3672 40.27339 60.582 40.3711 curveto
60.7969 40.4727 61.02339 40.52339 61.2656 40.52339 curveto
61.543 40.52339 61.7773 40.4648 61.9727 40.3477 curveto
62.168 40.2305 62.3125 40.0664 62.4062 39.8594 curveto
62.6836 40.0938 62.9375 40.2617 63.168 40.3672 curveto
63.39839 40.4727 63.6406 40.52339 63.9023 40.52339 curveto
64.35161 40.52339 64.6836 40.3867 64.89839 40.1133 curveto
65.1094 39.8438 65.2188 39.46089 65.2188 38.9727 curveto
 closepath fill
newpath 69.7188 36.3203 moveto
69.0352 36.3203 lineto
69.0352 36.7578 lineto
68.9727 36.7148 68.8906 36.6562 68.78911 36.582 curveto
68.47661 36.9883 lineto
68.6758 37.082 68.8633 37.1953 69.0352 37.3281 curveto
69.0352 37.3281 lineto
69.0352 38.4648 lineto
68.8242 38.4531 68.5781 38.4375 68.293 38.4102 curveto
68.0078 38.3867 67.7852 38.35161 67.6172 38.3047 curveto
67.4219 38.25 67.2617 38.1602 67.1406 38.043 curveto
67.0156 37.9258 66.957 37.7617 66.957 37.5547 curveto
66.957 37.3203 67.0273 37.1445 67.168 37.0273 curveto
67.3086 36.9062 67.5273 36.8477 67.8164 36.8477 curveto
68.0547 36.8477 68.2773 36.8945 68.47661 36.9883 curveto
68.78911 36.582 lineto
68.6836 36.5078 68.582 36.4492 68.4844 36.4062 curveto
68.3711 36.35161 68.2383 36.3008 68.0898 36.2656 curveto
67.9414 36.22661 67.7656 36.207 67.5664 36.207 curveto
67.1992 36.207 66.8867 36.332 66.6289 36.5742 curveto
66.375 36.8164 66.2461 37.1289 66.2461 37.5078 curveto
66.2461 37.8164 66.3125 38.0664 66.4453 38.2578 curveto
66.5781 38.4492 66.7695 38.60161 67.0156 38.71089 curveto
67.2656 38.8203 67.5625 38.8945 67.9102 38.9336 curveto
68.2617 38.9727 68.6367 39.0039 69.0352 39.02339 curveto
69.0352 39.1289 lineto
69.0352 39.2852 69.0078 39.41411 68.9531 39.5156 curveto
68.89839 39.6172 68.8203 39.6992 68.7148 39.7578 curveto
68.6172 39.8125 68.5 39.85161 68.3633 39.8711 curveto
68.22661 39.8906 68.08589 39.9023 67.9375 39.9023 curveto
67.7578 39.9023 67.5547 39.8789 67.332 39.832 curveto
67.1094 39.7812 66.8828 39.7148 66.6445 39.6211 curveto
66.6094 39.6211 lineto
66.6094 40.3203 lineto
66.7422 40.3594 66.9336 40.39839 67.1914 40.4414 curveto
67.4453 40.4844 67.6953 40.5078 67.9414 40.5078 curveto
68.22661 40.5078 68.47661 40.4844 68.6914 40.4375 curveto
68.9062 40.3906 69.0898 40.3086 69.2461 40.1953 curveto
69.4023 40.082 69.5195 39.9375 69.5977 39.7578 curveto
69.6797 39.582 69.7188 39.3594 69.7188 39.0977 curveto
 closepath fill
newpath 73.168 36.3594 moveto
73.03911 36.3242 72.89839 36.2969 72.7422 36.27339 curveto
72.5898 36.2539 72.457 36.2422 72.33589 36.2422 curveto
71.918 36.2422 71.60161 36.35161 71.3828 36.5781 curveto
71.168 36.8008 71.0586 37.1602 71.0586 37.6562 curveto
71.0586 39.832 lineto
70.5938 39.832 lineto
70.5938 40.4102 lineto
71.0586 40.4102 lineto
71.0586 41.58589 lineto
71.7461 41.58589 lineto
71.7461 40.4102 lineto
73.168 40.4102 lineto
73.168 39.832 lineto
71.7461 39.832 lineto
71.7461 37.9688 lineto
71.7461 37.7539 71.75 37.58589 71.7617 37.4648 curveto
71.7695 37.3438 71.8047 37.2305 71.8633 37.1289 curveto
71.918 37.0273 71.9922 36.957 72.08589 36.9102 curveto
72.1797 36.8672 72.3242 36.8438 72.5156 36.8438 curveto
72.6289 36.8438 72.7461 36.8594 72.8672 36.8945 curveto
72.9883 36.9258 73.0742 36.9531 73.1289 36.97661 curveto
73.168 36.97661 lineto
 closepath fill
newpath 74.6914 36.3203 moveto
74.0039 36.3203 lineto
74.0039 40.4102 lineto
74.6914 40.4102 lineto
 closepath fill
newpath 74.7383 41.0938 moveto
73.96089 41.0938 lineto
73.96089 41.8086 lineto
74.7383 41.8086 lineto
 closepath fill
newpath 78.9727 37.5 moveto
78.9727 37.1289 78.8203 36.8203 78.5117 36.582 curveto
78.2031 36.3438 77.7812 36.2227 77.2461 36.2227 curveto
76.9453 36.2227 76.668 36.2578 76.41411 36.332 curveto
76.1602 36.4023 75.9492 36.4805 75.7812 36.5664 curveto
75.7812 37.3398 lineto
75.8164 37.3398 lineto
76.0352 37.1758 76.27339 37.0469 76.53911 36.9492 curveto
76.8047 36.85161 77.0625 36.8047 77.3047 36.8047 curveto
77.6094 36.8047 77.8438 36.85161 78.0156 36.9492 curveto
78.1875 37.0469 78.27339 37.2031 78.27339 37.4102 curveto
78.27339 37.5742 78.22661 37.6953 78.1328 37.7773 curveto
78.03911 37.8594 77.8633 37.9336 77.5977 37.9883 curveto
77.5 38.0117 77.3711 38.03911 77.2148 38.0664 curveto
77.0586 38.0977 76.91411 38.1289 76.7852 38.1602 curveto
76.4258 38.2578 76.1719 38.39839 76.02339 38.582 curveto
75.8711 38.7656 75.7969 38.9922 75.7969 39.2617 curveto
75.7969 39.4297 75.832 39.58589 75.9023 39.7344 curveto
75.9727 39.8867 76.0781 40.0195 76.2188 40.1367 curveto
76.3555 40.25 76.5312 40.3398 76.7422 40.4062 curveto
76.9492 40.47661 77.1875 40.5078 77.4492 40.5078 curveto
77.6914 40.5078 77.9375 40.47661 78.1914 40.418 curveto
78.4414 40.3594 78.64839 40.2852 78.8125 40.1992 curveto
78.8125 39.4648 lineto
78.7773 39.4648 lineto
78.60161 39.5938 78.3867 39.7031 78.1367 39.793 curveto
77.8867 39.8828 77.6406 39.9258 77.39839 39.9258 curveto
77.1445 39.9258 76.9336 39.8789 76.7617 39.7812 curveto
76.58589 39.6875 76.5 39.543 76.5 39.35161 curveto
76.5 39.1836 76.5508 39.0586 76.6562 38.9727 curveto
76.7617 38.8867 76.9258 38.8164 77.1562 38.7617 curveto
77.2812 38.7344 77.4258 38.7031 77.582 38.6758 curveto
77.7383 38.6445 77.8711 38.6172 77.97661 38.5938 curveto
78.293 38.5195 78.543 38.3945 78.7148 38.2188 curveto
78.8867 38.0352 78.9727 37.7969 78.9727 37.5 curveto
 closepath fill
newpath 82.9805 36.5781 moveto
82.7539 36.4688 82.5352 36.3828 82.3281 36.3203 curveto
82.125 36.2617 81.9023 36.2305 81.6719 36.2305 curveto
81.375 36.2305 81.1055 36.27339 80.8594 36.3594 curveto
80.6133 36.4453 80.4023 36.5781 80.22661 36.7539 curveto
80.0469 36.9297 79.9102 37.1523 79.8125 37.418 curveto
79.7148 37.6875 79.668 38 79.668 38.3594 curveto
79.668 39.0273 79.85161 39.5508 80.2188 39.9336 curveto
80.58589 40.3164 81.0703 40.5039 81.6719 40.5039 curveto
81.9062 40.5039 82.1367 40.4727 82.3633 40.4062 curveto
82.58589 40.3398 82.793 40.2617 82.9805 40.16411 curveto
82.9805 39.39839 lineto
82.9453 39.39839 lineto
82.7344 39.5625 82.5195 39.6875 82.2969 39.7773 curveto
82.0742 39.8633 81.8555 39.9062 81.6445 39.9062 curveto
81.2539 39.9062 80.9453 39.7773 80.7188 39.5156 curveto
80.4922 39.2539 80.3789 38.8672 80.3789 38.3594 curveto
80.3789 37.8672 80.4883 37.4883 80.71089 37.2227 curveto
80.9336 36.957 81.2422 36.8281 81.6445 36.8281 curveto
81.7812 36.8281 81.9219 36.8438 82.0664 36.8828 curveto
82.21089 36.918 82.3398 36.9648 82.457 37.02339 curveto
82.5547 37.0742 82.64839 37.1289 82.7383 37.1875 curveto
82.8242 37.2461 82.8945 37.293 82.9453 37.33589 curveto
82.9805 37.33589 lineto
 closepath fill
newpath 87.2812 36.3203 moveto
86.5938 36.3203 lineto
86.5938 38.64839 lineto
86.5938 38.83589 86.582 39.0117 86.5625 39.1758 curveto
86.53911 39.3438 86.5 39.4727 86.4414 39.5664 curveto
86.3789 39.668 86.293 39.7422 86.1758 39.793 curveto
86.0625 39.8438 85.91411 39.8672 85.7305 39.8672 curveto
85.543 39.8672 85.3477 39.8203 85.1406 39.72661 curveto
84.9375 39.6367 84.7383 39.5195 84.5508 39.375 curveto
84.5508 36.3203 lineto
83.8633 36.3203 lineto
83.8633 42.0156 lineto
84.5508 42.0156 lineto
84.5508 39.957 lineto
84.7656 40.1328 84.9883 40.27339 85.2188 40.3711 curveto
85.4492 40.4727 85.6836 40.52339 85.9258 40.52339 curveto
86.3672 40.52339 86.7031 40.3906 86.9336 40.125 curveto
87.168 39.8594 87.2812 39.47661 87.2812 38.9727 curveto
 closepath fill
newpath 92.0312 38.293 moveto
89.0195 38.293 lineto
89.0195 38.8203 lineto
91.3594 38.8203 lineto
91.3594 39.1836 91.2656 39.46089 91.08589 39.6602 curveto
90.9062 39.8555 90.6367 39.957 90.2695 39.957 curveto
89.9023 39.957 89.6055 39.8477 89.3906 39.6289 curveto
89.1719 39.41411 89.0469 39.1445 89.0195 38.8203 curveto
89.0195 38.293 lineto
89.0195 38.043 89.0547 37.8242 89.1328 37.6367 curveto
89.207 37.4492 89.3086 37.2969 89.4414 37.1797 curveto
89.5703 37.0625 89.7188 36.9727 89.8945 36.91411 curveto
90.0664 36.8555 90.2617 36.8281 90.4688 36.8281 curveto
90.75 36.8281 91.0273 36.8828 91.3086 36.9922 curveto
91.5938 37.1055 91.793 37.2148 91.91411 37.3203 curveto
91.9492 37.3203 lineto
91.9492 36.5703 lineto
91.7188 36.4727 91.4805 36.3906 91.2383 36.3242 curveto
90.9961 36.2578 90.7422 36.22661 90.47661 36.22661 curveto
89.8008 36.22661 89.2695 36.4102 88.8906 36.7773 curveto
88.5078 37.1445 88.3203 37.66411 88.3203 38.3438 curveto
88.3203 39.0117 88.5 39.53911 88.8672 39.9336 curveto
89.2305 40.3281 89.71089 40.52339 90.3047 40.52339 curveto
90.8555 40.52339 91.2812 40.3633 91.582 40.03911 curveto
91.8789 39.7188 92.0312 39.2617 92.0312 38.668 curveto
 closepath fill
newpath 95.9922 37.5 moveto
95.9922 37.1289 95.8398 36.8203 95.5312 36.582 curveto
95.2227 36.3438 94.8008 36.2227 94.2656 36.2227 curveto
93.9648 36.2227 93.6875 36.2578 93.4336 36.332 curveto
93.1797 36.4023 92.9688 36.4805 92.7969 36.5664 curveto
92.7969 37.3398 lineto
92.83589 37.3398 lineto
93.0508 37.1758 93.293 37.0469 93.5586 36.9492 curveto
93.8242 36.85161 94.082 36.8047 94.3242 36.8047 curveto
94.625 36.8047 94.8633 36.85161 95.0352 36.9492 curveto
95.207 37.0469 95.28911 37.2031 95.28911 37.4102 curveto
95.28911 37.5742 95.2422 37.6953 95.1523 37.7773 curveto
95.0586 37.8594 94.8828 37.9336 94.6172 37.9883 curveto
94.5195 38.0117 94.3906 38.03911 94.2344 38.0664 curveto
94.0781 38.0977 93.9336 38.1289 93.8047 38.1602 curveto
93.4453 38.2578 93.1914 38.39839 93.03911 38.582 curveto
92.8906 38.7656 92.8164 38.9922 92.8164 39.2617 curveto
92.8164 39.4297 92.85161 39.58589 92.9219 39.7344 curveto
92.9883 39.8867 93.0938 40.0195 93.2383 40.1367 curveto
93.375 40.25 93.5469 40.3398 93.7578 40.4062 curveto
93.9688 40.47661 94.207 40.5078 94.4688 40.5078 curveto
94.71089 40.5078 94.957 40.47661 95.207 40.418 curveto
95.457 40.3594 95.66411 40.2852 95.832 40.1992 curveto
95.832 39.4648 lineto
95.793 39.4648 lineto
95.6172 39.5938 95.4062 39.7031 95.1562 39.793 curveto
94.9062 39.8828 94.6562 39.9258 94.41411 39.9258 curveto
94.16411 39.9258 93.9531 39.8789 93.7812 39.7812 curveto
93.6055 39.6875 93.5195 39.543 93.5195 39.35161 curveto
93.5195 39.1836 93.5703 39.0586 93.6758 38.9727 curveto
93.7812 38.8867 93.9453 38.8164 94.1758 38.7617 curveto
94.3008 38.7344 94.4414 38.7031 94.60161 38.6758 curveto
94.7578 38.6445 94.8906 38.6172 94.9922 38.5938 curveto
95.3125 38.5195 95.5586 38.3945 95.7344 38.2188 curveto
95.9062 38.0352 95.9922 37.7969 95.9922 37.5 curveto
 closepath fill
newpath 39.8047 30.9414 moveto
37.0508 30.9414 lineto
37.0508 29.4062 lineto
39.418 29.4062 lineto
39.418 28.7617 lineto
37.0508 28.7617 lineto
37.0508 26.1367 lineto
36.3281 26.1367 lineto
36.3281 31.58589 lineto
39.8047 31.58589 lineto
 closepath fill
newpath 43.8828 28.1797 moveto
43.8828 27.5156 43.71089 26.9883 43.3711 26.60161 curveto
43.0312 26.2188 42.5703 26.02339 42 26.02339 curveto
41.4219 26.02339 40.96089 26.2188 40.6211 26.60161 curveto
40.2812 26.9883 40.1094 27.5156 40.1094 28.1797 curveto
40.1094 28.8438 40.2812 29.3711 40.6211 29.7578 curveto
40.96089 30.1445 41.4219 30.3398 42 30.3398 curveto
42 29.7461 lineto
41.625 29.7461 41.33589 29.6172 41.1289 29.3594 curveto
40.9219 29.10161 40.8203 28.71089 40.8203 28.1797 curveto
40.8203 27.668 40.9219 27.2773 41.1328 27.0156 curveto
41.3398 26.75 41.6289 26.6172 42 26.6172 curveto
42.3633 26.6172 42.6523 26.7461 42.8594 27.0117 curveto
43.0703 27.27339 43.1719 27.66411 43.1719 28.1797 curveto
43.1719 28.1797 lineto
43.1719 28.71089 43.0703 29.10161 42.8633 29.3594 curveto
42.6562 29.6172 42.3672 29.7461 42 29.7461 curveto
42 30.3398 lineto
42.5703 30.3398 43.0312 30.1445 43.3711 29.7578 curveto
43.71089 29.3711 43.8828 28.8438 43.8828 28.1797 curveto
 closepath fill
newpath 47.5 29.47661 moveto
47.46089 29.47661 lineto
47.3594 29.5 47.2617 29.5195 47.16411 29.5273 curveto
47.0703 29.53911 46.9531 29.5469 46.8242 29.5469 curveto
46.6094 29.5469 46.4062 29.5 46.207 29.4062 curveto
46.0078 29.3086 45.8203 29.1875 45.6367 29.03911 curveto
45.6367 26.1367 lineto
44.9492 26.1367 lineto
44.9492 30.22661 lineto
45.6367 30.22661 lineto
45.6367 29.6211 lineto
45.9102 29.8398 46.1523 29.9961 46.3594 30.0898 curveto
46.5703 30.1797 46.7812 30.22661 47 30.22661 curveto
47.1172 30.22661 47.2031 30.2227 47.2578 30.2148 curveto
47.3125 30.21089 47.3906 30.1992 47.5 30.1797 curveto
 closepath fill
newpath 51.0664 27.3164 moveto
51.0664 26.9414 50.91411 26.6367 50.6055 26.39839 curveto
50.2969 26.1562 49.875 26.03911 49.3398 26.03911 curveto
49.03911 26.03911 48.7617 26.0742 48.5078 26.14839 curveto
48.2539 26.2188 48.043 26.2969 47.8711 26.3828 curveto
47.8711 27.1562 lineto
47.9102 27.1562 lineto
48.125 26.9922 48.3672 26.8633 48.6328 26.7656 curveto
48.89839 26.668 49.1562 26.6211 49.39839 26.6211 curveto
49.7031 26.6211 49.9375 26.668 50.1094 26.7656 curveto
50.2812 26.8633 50.3633 27.0195 50.3633 27.22661 curveto
50.3633 27.3906 50.3203 27.5117 50.22661 27.5938 curveto
50.1328 27.6758 49.9531 27.7461 49.6914 27.8047 curveto
49.5938 27.8281 49.4688 27.8555 49.3086 27.8828 curveto
49.1523 27.91411 49.0078 27.9453 48.8789 27.97661 curveto
48.5195 28.0742 48.2656 28.2148 48.1172 28.39839 curveto
47.9648 28.582 47.8906 28.8086 47.8906 29.0781 curveto
47.8906 29.2461 47.9258 29.4023 47.9961 29.5508 curveto
48.0664 29.7031 48.1719 29.83589 48.3125 29.9531 curveto
48.4492 30.0664 48.6211 30.1562 48.832 30.2227 curveto
49.043 30.28911 49.2812 30.3242 49.543 30.3242 curveto
49.7852 30.3242 50.0312 30.293 50.2812 30.2344 curveto
50.5312 30.1758 50.7422 30.10161 50.9062 30.0156 curveto
50.9062 29.2812 lineto
50.8711 29.2812 lineto
50.6953 29.4102 50.4805 29.5195 50.2305 29.6094 curveto
49.97661 29.6992 49.7305 29.7422 49.4922 29.7422 curveto
49.2383 29.7422 49.0273 29.6953 48.85161 29.5977 curveto
48.6797 29.5 48.5938 29.3594 48.5938 29.168 curveto
48.5938 29 48.6445 28.8711 48.75 28.7852 curveto
48.85161 28.7031 49.0195 28.6328 49.25 28.5781 curveto
49.375 28.5508 49.5195 28.5195 49.6758 28.4922 curveto
49.832 28.46089 49.9648 28.4336 50.0703 28.4102 curveto
50.3867 28.33589 50.6367 28.21089 50.8086 28.0312 curveto
50.9805 27.85161 51.0664 27.6133 51.0664 27.3164 curveto
 closepath fill
newpath 55.0742 26.3945 moveto
54.8477 26.2852 54.6289 26.1992 54.4219 26.1367 curveto
54.2148 26.0781 53.9961 26.0469 53.7656 26.0469 curveto
53.4688 26.0469 53.1992 26.0898 52.9531 26.1758 curveto
52.707 26.2617 52.4961 26.3945 52.3203 26.5703 curveto
52.1406 26.7461 52.0039 26.9688 51.9062 27.2344 curveto
51.8086 27.5039 51.7578 27.8164 51.7578 28.1758 curveto
51.7578 28.8438 51.9453 29.3672 52.3086 29.75 curveto
52.6758 30.1328 53.1602 30.3203 53.7656 30.3203 curveto
54 30.3203 54.2305 30.28911 54.457 30.2227 curveto
54.6797 30.1562 54.8867 30.0742 55.0742 29.9805 curveto
55.0742 29.2148 lineto
55.03911 29.2148 lineto
54.8281 29.3789 54.6133 29.5039 54.3906 29.5938 curveto
54.16411 29.6797 53.9492 29.7227 53.7344 29.7227 curveto
53.3438 29.7227 53.0352 29.5938 52.8125 29.332 curveto
52.58589 29.0703 52.4727 28.6836 52.4727 28.1758 curveto
52.4727 27.6836 52.582 27.3047 52.8047 27.03911 curveto
53.0273 26.77339 53.33589 26.6445 53.7344 26.6445 curveto
53.875 26.6445 54.0156 26.6602 54.1602 26.6992 curveto
54.3047 26.7344 54.4336 26.7812 54.5469 26.8398 curveto
54.64839 26.8906 54.7422 26.9453 54.832 27.0039 curveto
54.918 27.0625 54.9883 27.1094 55.03911 27.1523 curveto
55.0742 27.1523 lineto
 closepath fill
newpath 59.375 26.1367 moveto
58.6875 26.1367 lineto
58.6875 28.4648 lineto
58.6875 28.6523 58.6758 28.8281 58.6562 28.9922 curveto
58.6328 29.1602 58.5938 29.28911 58.5352 29.3828 curveto
58.4727 29.4844 58.3828 29.5586 58.2695 29.6094 curveto
58.1562 29.6602 58.0078 29.6836 57.8242 29.6836 curveto
57.6367 29.6836 57.4414 29.6367 57.2344 29.543 curveto
57.0312 29.4531 56.832 29.332 56.6445 29.1914 curveto
56.6445 26.1367 lineto
55.957 26.1367 lineto
55.957 31.832 lineto
56.6445 31.832 lineto
56.6445 29.77339 lineto
56.8594 29.9492 57.082 30.0898 57.3125 30.1875 curveto
57.53911 30.28911 57.7773 30.3398 58.0195 30.3398 curveto
58.46089 30.3398 58.7969 30.207 59.0273 29.9414 curveto
59.2578 29.6758 59.375 29.293 59.375 28.78911 curveto
 closepath fill
newpath 64.0898 26.1367 moveto
63.4023 26.1367 lineto
63.4023 26.5938 lineto
63.168 26.4102 62.9492 26.2695 62.7344 26.1719 curveto
62.52339 26.0742 62.28911 26.02339 62.0312 26.02339 curveto
61.60161 26.02339 61.2695 26.1562 61.0312 26.418 curveto
60.78911 26.6797 60.6719 27.0664 60.6719 27.5742 curveto
60.6719 30.22661 lineto
61.3594 30.22661 lineto
61.3594 27.89839 lineto
61.3594 27.6914 61.3672 27.5117 61.3906 27.3672 curveto
61.4062 27.2188 61.4492 27.0938 61.5117 26.9883 curveto
61.5781 26.8789 61.66411 26.8008 61.7695 26.7539 curveto
61.875 26.7031 62.0273 26.6797 62.22661 26.6797 curveto
62.4062 26.6797 62.5977 26.72661 62.8086 26.8203 curveto
63.02339 26.9102 63.2188 27.0312 63.4023 27.1719 curveto
63.4023 30.22661 lineto
64.0898 30.22661 lineto
 closepath fill
newpath 68.8633 26.1367 moveto
68.1719 26.1367 lineto
68.1719 28.4648 lineto
68.1719 28.6523 68.16411 28.8281 68.1406 28.9922 curveto
68.1172 29.1602 68.0781 29.28911 68.0195 29.3828 curveto
67.957 29.4844 67.8711 29.5586 67.7578 29.6094 curveto
67.6406 29.6602 67.4922 29.6836 67.3086 29.6836 curveto
67.1211 29.6836 66.9258 29.6367 66.7188 29.543 curveto
66.5156 29.4531 66.3203 29.332 66.1328 29.1914 curveto
66.1328 26.1367 lineto
65.4453 26.1367 lineto
65.4453 30.22661 lineto
66.1328 30.22661 lineto
66.1328 29.77339 lineto
66.3477 29.9492 66.5703 30.0898 66.7969 30.1875 curveto
67.0273 30.28911 67.2617 30.3398 67.5039 30.3398 curveto
67.9453 30.3398 68.2812 30.207 68.5156 29.9414 curveto
68.7461 29.6758 68.8633 29.293 68.8633 28.78911 curveto
 closepath fill
newpath 73.5039 26.60161 moveto
73.5039 25.9102 73.3438 25.4023 73.0312 25.0781 curveto
72.7148 24.7539 72.2305 24.5898 71.5781 24.5898 curveto
71.3594 24.5898 71.14839 24.6055 70.9414 24.6367 curveto
70.7344 24.66411 70.5312 24.71089 70.332 24.7656 curveto
70.332 25.4688 lineto
70.3711 25.4688 lineto
70.4805 25.4258 70.6602 25.3672 70.9023 25.3047 curveto
71.14839 25.2383 71.3906 25.207 71.6367 25.207 curveto
71.8711 25.207 72.0625 25.2344 72.2188 25.293 curveto
72.3711 25.3477 72.4922 25.4258 72.5781 25.5273 curveto
72.6602 25.6211 72.7227 25.7344 72.7617 25.8711 curveto
72.7969 26.0039 72.8164 26.1562 72.8164 26.3203 curveto
72.8164 26.6953 lineto
72.6094 26.5273 72.4102 26.4062 72.2188 26.3242 curveto
72.0312 26.2383 71.78911 26.1992 71.4961 26.1992 curveto
71.0078 26.1992 70.6211 26.375 70.33589 26.72661 curveto
70.0469 27.082 69.9062 27.5781 69.9062 28.2188 curveto
69.9062 28.5703 69.9531 28.875 70.0547 29.1289 curveto
70.1523 29.3828 70.2852 29.6055 70.457 29.78911 curveto
70.6172 29.9648 70.8086 30.0977 71.0352 30.1953 curveto
71.2617 30.28911 71.4883 30.3398 71.7148 30.3398 curveto
71.9492 30.3398 72.14839 30.3164 72.3086 30.2695 curveto
72.4688 30.2188 72.6367 30.14839 72.8164 30.0508 curveto
72.8164 29.4883 lineto
72.6328 29.5742 72.46089 29.6328 72.3047 29.668 curveto
72.14839 29.7031 71.9883 29.7188 71.83589 29.7188 curveto
71.457 29.7188 71.1562 29.5938 70.9414 29.3398 curveto
70.7227 29.08589 70.6133 28.7188 70.6133 28.2344 curveto
70.6133 27.7773 70.6953 27.4297 70.8555 27.1914 curveto
71.0195 26.957 71.2852 26.83589 71.6562 26.83589 curveto
71.8594 26.83589 72.0586 26.875 72.2617 26.9531 curveto
72.46089 27.0312 72.6445 27.1328 72.8164 27.2617 curveto
72.8164 27.2617 lineto
72.8164 29.4883 lineto
72.8164 30.0508 lineto
72.8594 30.22661 lineto
73.5039 30.22661 lineto
 closepath fill
newpath 77.7773 27.3164 moveto
77.7773 26.9414 77.625 26.6367 77.3164 26.39839 curveto
77.0039 26.1562 76.58589 26.03911 76.0508 26.03911 curveto
75.7461 26.03911 75.4688 26.0742 75.2188 26.14839 curveto
74.9648 26.2188 74.7539 26.2969 74.582 26.3828 curveto
74.582 27.1562 lineto
74.6172 27.1562 lineto
74.83589 26.9922 75.0781 26.8633 75.3438 26.7656 curveto
75.6094 26.668 75.8633 26.6211 76.1094 26.6211 curveto
76.4102 26.6211 76.64839 26.668 76.8203 26.7656 curveto
76.9883 26.8633 77.0742 27.0195 77.0742 27.22661 curveto
77.0742 27.3906 77.0273 27.5117 76.9336 27.5938 curveto
76.8438 27.6758 76.66411 27.7461 76.4023 27.8047 curveto
76.3047 27.8281 76.1758 27.8555 76.0195 27.8828 curveto
75.8594 27.91411 75.7188 27.9453 75.5898 27.97661 curveto
75.2305 28.0742 74.97661 28.2148 74.8242 28.39839 curveto
74.6758 28.582 74.60161 28.8086 74.60161 29.0781 curveto
74.60161 29.2461 74.6367 29.4023 74.707 29.5508 curveto
74.77339 29.7031 74.8789 29.83589 75.02339 29.9531 curveto
75.1602 30.0664 75.332 30.1562 75.543 30.2227 curveto
75.7539 30.28911 75.9883 30.3242 76.25 30.3242 curveto
76.4961 30.3242 76.7422 30.293 76.9922 30.2344 curveto
77.2422 30.1758 77.4492 30.10161 77.6172 30.0156 curveto
77.6172 29.2812 lineto
77.5781 29.2812 lineto
77.4023 29.4102 77.1914 29.5195 76.9414 29.6094 curveto
76.6875 29.6992 76.4414 29.7422 76.1992 29.7422 curveto
75.9492 29.7422 75.7344 29.6953 75.5625 29.5977 curveto
75.3906 29.5 75.3047 29.3594 75.3047 29.168 curveto
75.3047 29 75.3555 28.8711 75.46089 28.7852 curveto
75.5625 28.7031 75.7305 28.6328 75.957 28.5781 curveto
76.08589 28.5508 76.22661 28.5195 76.3828 28.4922 curveto
76.543 28.46089 76.6719 28.4336 76.7773 28.4102 curveto
77.0977 28.33589 77.3438 28.21089 77.5195 28.0312 curveto
77.6914 27.85161 77.7773 27.6133 77.7773 27.3164 curveto
 closepath fill
newpath 79.457 26.1367 moveto
78.7695 26.1367 lineto
78.7695 30.22661 lineto
79.457 30.22661 lineto
 closepath fill
newpath 79.5 30.9102 moveto
78.72661 30.9102 lineto
78.72661 31.625 lineto
79.5 31.625 lineto
 closepath fill
newpath 84.2383 26.1367 moveto
83.5508 26.1367 lineto
83.5508 28.4648 lineto
83.5508 28.6523 83.53911 28.8281 83.5156 28.9922 curveto
83.4922 29.1602 83.4531 29.28911 83.3945 29.3828 curveto
83.33589 29.4844 83.2461 29.5586 83.1328 29.6094 curveto
83.0156 29.6602 82.8672 29.6836 82.6836 29.6836 curveto
82.4961 29.6836 82.3008 29.6367 82.0977 29.543 curveto
81.8906 29.4531 81.6953 29.332 81.5078 29.1914 curveto
81.5078 26.1367 lineto
80.8203 26.1367 lineto
80.8203 30.22661 lineto
81.5078 30.22661 lineto
81.5078 29.77339 lineto
81.7227 29.9492 81.9453 30.0898 82.1719 30.1875 curveto
82.4023 30.28911 82.6367 30.3398 82.8789 30.3398 curveto
83.3203 30.3398 83.6562 30.207 83.8906 29.9414 curveto
84.1211 29.6758 84.2383 29.293 84.2383 28.78911 curveto
 closepath fill
newpath 88.4844 27.3164 moveto
88.4844 26.9414 88.3281 26.6367 88.0195 26.39839 curveto
87.71089 26.1562 87.28911 26.03911 86.7539 26.03911 curveto
86.4531 26.03911 86.1758 26.0742 85.9219 26.14839 curveto
85.668 26.2188 85.46089 26.2969 85.2852 26.3828 curveto
85.2852 27.1562 lineto
85.3242 27.1562 lineto
85.543 26.9922 85.7812 26.8633 86.0469 26.7656 curveto
86.3164 26.668 86.5703 26.6211 86.8125 26.6211 curveto
87.1172 26.6211 87.35161 26.668 87.52339 26.7656 curveto
87.6953 26.8633 87.7812 27.0195 87.7812 27.22661 curveto
87.7812 27.3906 87.7344 27.5117 87.6406 27.5938 curveto
87.5469 27.6758 87.3711 27.7461 87.1055 27.8047 curveto
87.0078 27.8281 86.8828 27.8555 86.7227 27.8828 curveto
86.5664 27.91411 86.4219 27.9453 86.293 27.97661 curveto
85.9336 28.0742 85.6797 28.2148 85.5312 28.39839 curveto
85.3828 28.582 85.3047 28.8086 85.3047 29.0781 curveto
85.3047 29.2461 85.3398 29.4023 85.4102 29.5508 curveto
85.4805 29.7031 85.58589 29.83589 85.72661 29.9531 curveto
85.8633 30.0664 86.03911 30.1562 86.2461 30.2227 curveto
86.46089 30.28911 86.6953 30.3242 86.957 30.3242 curveto
87.1992 30.3242 87.4453 30.293 87.6992 30.2344 curveto
87.9492 30.1758 88.1562 30.10161 88.3203 30.0156 curveto
88.3203 29.2812 lineto
88.2852 29.2812 lineto
88.1094 29.4102 87.8945 29.5195 87.6445 29.6094 curveto
87.3945 29.6992 87.14839 29.7422 86.9062 29.7422 curveto
86.6523 29.7422 86.4414 29.6953 86.2695 29.5977 curveto
86.0938 29.5 86.0078 29.3594 86.0078 29.168 curveto
86.0078 29 86.0625 28.8711 86.16411 28.7852 curveto
86.2695 28.7031 86.4336 28.6328 86.66411 28.5781 curveto
86.78911 28.5508 86.9336 28.5195 87.0898 28.4922 curveto
87.2461 28.46089 87.3789 28.4336 87.4844 28.4102 curveto
87.8008 28.33589 88.0469 28.21089 88.2227 28.0312 curveto
88.3945 27.85161 88.4844 27.6133 88.4844 27.3164 curveto
 closepath fill
newpath 91.5898 26.1758 moveto
91.46089 26.1406 91.3203 26.1133 91.168 26.0898 curveto
91.0156 26.0703 90.8789 26.0586 90.7578 26.0586 curveto
90.3398 26.0586 90.02339 26.168 89.8086 26.3945 curveto
89.5898 26.6172 89.4805 26.97661 89.4805 27.4727 curveto
89.4805 29.64839 lineto
89.0156 29.64839 lineto
89.0156 30.22661 lineto
89.4805 30.22661 lineto
89.4805 31.4023 lineto
90.168 31.4023 lineto
90.168 30.22661 lineto
91.5898 30.22661 lineto
91.5898 29.64839 lineto
90.168 29.64839 lineto
90.168 27.7852 lineto
90.168 27.5703 90.1758 27.4023 90.1836 27.2812 curveto
90.1953 27.1602 90.22661 27.0469 90.2852 26.9453 curveto
90.3398 26.8438 90.41411 26.77339 90.5078 26.72661 curveto
90.60161 26.6836 90.7461 26.6602 90.9375 26.6602 curveto
91.0508 26.6602 91.168 26.6758 91.28911 26.71089 curveto
91.4102 26.7422 91.5 26.7695 91.5547 26.793 curveto
91.5898 26.793 lineto
 closepath fill
newpath 93.1172 26.1367 moveto
92.4297 26.1367 lineto
92.4297 30.22661 lineto
93.1172 30.22661 lineto
 closepath fill
newpath 93.1602 30.9102 moveto
92.3828 30.9102 lineto
92.3828 31.625 lineto
93.1602 31.625 lineto
 closepath fill
newpath 96.60161 26.1758 moveto
96.4727 26.1406 96.332 26.1133 96.1758 26.0898 curveto
96.0273 26.0703 95.8906 26.0586 95.7695 26.0586 curveto
95.35161 26.0586 95.0352 26.168 94.8164 26.3945 curveto
94.60161 26.6172 94.4922 26.97661 94.4922 27.4727 curveto
94.4922 29.64839 lineto
94.0273 29.64839 lineto
94.0273 30.22661 lineto
94.4922 30.22661 lineto
94.4922 31.4023 lineto
95.1797 31.4023 lineto
95.1797 30.22661 lineto
96.60161 30.22661 lineto
96.60161 29.64839 lineto
95.1797 29.64839 lineto
95.1797 27.7852 lineto
95.1797 27.5703 95.1836 27.4023 95.1953 27.2812 curveto
95.2031 27.1602 95.2383 27.0469 95.2969 26.9453 curveto
95.35161 26.8438 95.4258 26.77339 95.5195 26.72661 curveto
95.6133 26.6836 95.7578 26.6602 95.9492 26.6602 curveto
96.0586 26.6602 96.1797 26.6758 96.3008 26.71089 curveto
96.4219 26.7422 96.5078 26.7695 96.5625 26.793 curveto
96.60161 26.793 lineto
 closepath fill
newpath 100.82 26.1367 moveto
100.133 26.1367 lineto
100.133 26.5938 lineto
99.9023 26.4102 99.6797 26.2695 99.4648 26.1719 curveto
99.2539 26.0742 99.0195 26.02339 98.7617 26.02339 curveto
98.332 26.02339 98 26.1562 97.7617 26.418 curveto
97.5195 26.6797 97.4023 27.0664 97.4023 27.5742 curveto
97.4023 30.22661 lineto
98.0898 30.22661 lineto
98.0898 27.89839 lineto
98.0898 27.6914 98.0977 27.5117 98.1172 27.3672 curveto
98.1367 27.2188 98.1797 27.0938 98.2422 26.9883 curveto
98.3086 26.8789 98.3945 26.8008 98.5 26.7539 curveto
98.6055 26.7031 98.7578 26.6797 98.957 26.6797 curveto
99.1367 26.6797 99.332 26.72661 99.53911 26.8203 curveto
99.75 26.9102 99.9492 27.0312 100.133 27.1719 curveto
100.133 30.22661 lineto
100.82 30.22661 lineto
 closepath fill
newpath 104.297 26.1758 moveto
104.168 26.1406 104.027 26.1133 103.875 26.0898 curveto
103.723 26.0703 103.586 26.0586 103.465 26.0586 curveto
103.05101 26.0586 102.73 26.168 102.516 26.3945 curveto
102.297 26.6172 102.188 26.97661 102.188 27.4727 curveto
102.188 29.64839 lineto
101.723 29.64839 lineto
101.723 30.22661 lineto
102.188 30.22661 lineto
102.188 31.4023 lineto
102.879 31.4023 lineto
102.879 30.22661 lineto
104.297 30.22661 lineto
104.297 29.64839 lineto
102.879 29.64839 lineto
102.879 27.7852 lineto
102.879 27.5703 102.883 27.4023 102.891 27.2812 curveto
102.902 27.1602 102.93399 27.0469 102.992 26.9453 curveto
103.047 26.8438 103.121 26.77339 103.215 26.72661 curveto
103.30899 26.6836 103.453 26.6602 103.645 26.6602 curveto
103.758 26.6602 103.875 26.6758 103.996 26.71089 curveto
104.117 26.7422 104.207 26.7695 104.262 26.793 curveto
104.297 26.793 lineto
 closepath fill
newpath 40.3906 20.2148 moveto
40.6094 19.9727 40.7812 19.6719 40.89839 19.3203 curveto
41.0195 18.9648 41.0781 18.5625 41.0781 18.1133 curveto
41.0781 17.66411 41.0156 17.2656 40.8945 16.9102 curveto
40.77339 16.5547 40.6055 16.2578 40.3906 16.02339 curveto
40.16411 15.7734 39.89839 15.5898 39.5938 15.4648 curveto
39.2852 15.3398 38.9375 15.2773 38.543 15.2773 curveto
38.5469 15.9023 lineto
39.0898 15.9023 39.5195 16.0938 39.8438 16.4727 curveto
40.16411 16.85161 40.3242 17.39839 40.3242 18.1133 curveto
40.3242 18.1133 lineto
40.3242 18.8242 40.16411 19.3672 39.8477 19.7539 curveto
39.5312 20.1367 39.0977 20.3281 38.5469 20.3281 curveto
37.9922 20.3281 37.5586 20.1367 37.2422 19.7539 curveto
36.9258 19.3672 36.7695 18.8242 36.7695 18.1133 curveto
36.7695 17.39839 36.9297 16.85161 37.2539 16.4727 curveto
37.5742 16.0938 38.0078 15.9023 38.5469 15.9023 curveto
38.543 15.2773 lineto
38.1602 15.2773 37.8125 15.3398 37.5 15.4688 curveto
37.1875 15.5938 36.918 15.7812 36.6992 16.02339 curveto
36.4805 16.2617 36.3125 16.5586 36.1914 16.9102 curveto
36.0742 17.2617 36.0156 17.66411 36.0156 18.1133 curveto
36.0156 18.5586 36.0742 18.957 36.1914 19.3086 curveto
36.3086 19.66411 36.4805 19.9648 36.7031 20.2148 curveto
36.918 20.4531 37.1836 20.6367 37.5039 20.7656 curveto
37.8203 20.8906 38.168 20.9531 38.543 20.9531 curveto
38.9336 20.9531 39.2852 20.8906 39.5977 20.7617 curveto
39.9062 20.6367 40.1719 20.4531 40.3906 20.2148 curveto
 closepath fill
newpath 45.7695 17.4648 moveto
45.7695 17.125 45.7188 16.8164 45.625 16.543 curveto
45.5273 16.27339 45.39839 16.043 45.2344 15.8555 curveto
45.0586 15.6641 44.8711 15.5195 44.66411 15.4219 curveto
44.457 15.3281 44.22661 15.2773 43.97661 15.2773 curveto
43.7461 15.2773 43.543 15.3047 43.3711 15.3594 curveto
43.1992 15.4141 43.0273 15.4883 42.8594 15.582 curveto
42.8594 16.1289 lineto
43.0547 16.043 43.2227 15.9805 43.3633 15.9492 curveto
43.5039 15.9141 43.6602 15.8984 43.8398 15.8984 curveto
44.2188 15.8984 44.5195 16.02339 44.7344 16.27339 curveto
44.9492 16.52339 45.0586 16.91411 45.0586 17.4492 curveto
45.0586 17.4492 lineto
45.0586 17.9375 44.97661 18.3047 44.8164 18.5586 curveto
44.6562 18.8125 44.39839 18.9375 44.03911 18.9375 curveto
43.8398 18.9375 43.6367 18.8945 43.4297 18.8086 curveto
43.2227 18.7227 43.0352 18.6094 42.8594 18.4727 curveto
42.8594 16.1289 lineto
42.8594 15.582 lineto
42.8164 15.3906 lineto
42.1719 15.3906 lineto
42.1719 21.08589 lineto
42.8594 21.08589 lineto
42.8594 19.0508 lineto
43.0508 19.21089 43.2578 19.3398 43.4727 19.4414 curveto
43.6914 19.543 43.9336 19.5938 44.207 19.5938 curveto
44.6875 19.5938 45.0703 19.4062 45.3477 19.0352 curveto
45.6289 18.66411 45.7695 18.1445 45.7695 17.4648 curveto
 closepath fill
newpath 50.2617 17.3633 moveto
47.25 17.3633 lineto
47.25 17.8906 lineto
49.5938 17.8906 lineto
49.5898 18.2539 49.5 18.5312 49.3203 18.7305 curveto
49.1406 18.9258 48.8672 19.0273 48.5039 19.0273 curveto
48.1328 19.0273 47.8398 18.918 47.6211 18.6992 curveto
47.4062 18.4844 47.2812 18.2148 47.25 17.8906 curveto
47.25 17.3633 lineto
47.25 17.1133 47.28911 16.8945 47.3633 16.707 curveto
47.4414 16.5195 47.543 16.3672 47.6758 16.25 curveto
47.8008 16.1328 47.9531 16.043 48.1289 15.9844 curveto
48.3008 15.9258 48.4922 15.8984 48.7031 15.8984 curveto
48.9805 15.8984 49.2617 15.9531 49.543 16.0625 curveto
49.8242 16.1758 50.0273 16.2852 50.14839 16.3906 curveto
50.1836 16.3906 lineto
50.1836 15.6406 lineto
49.9492 15.543 49.7148 15.4609 49.4727 15.3945 curveto
49.2305 15.3281 48.97661 15.2969 48.71089 15.2969 curveto
48.0312 15.2969 47.5039 15.4805 47.125 15.8477 curveto
46.7422 16.2148 46.5508 16.7344 46.5508 17.41411 curveto
46.5508 18.082 46.7344 18.6094 47.0977 19.0039 curveto
47.4648 19.39839 47.9453 19.5938 48.53911 19.5938 curveto
49.0898 19.5938 49.5156 19.4336 49.8164 19.1094 curveto
50.1133 18.78911 50.2617 18.332 50.2617 17.7383 curveto
 closepath fill
newpath 53.8555 18.7305 moveto
53.8203 18.7305 lineto
53.7188 18.7539 53.6172 18.77339 53.52339 18.7812 curveto
53.4258 18.793 53.3125 18.8008 53.1797 18.8008 curveto
52.9688 18.8008 52.7617 18.75 52.5664 18.6602 curveto
52.3672 18.5664 52.1758 18.4414 51.9922 18.293 curveto
51.9922 15.3906 lineto
51.3047 15.3906 lineto
51.3047 19.4805 lineto
51.9922 19.4805 lineto
51.9922 18.875 lineto
52.2656 19.0938 52.5078 19.25 52.7188 19.3438 curveto
52.9258 19.4336 53.1367 19.4805 53.3555 19.4805 curveto
53.47661 19.4805 53.5625 19.47661 53.6133 19.4688 curveto
53.668 19.4648 53.75 19.4531 53.8555 19.4336 curveto
 closepath fill
newpath 59.64839 19.4805 moveto
58.582 15.3906 lineto
57.9453 15.3906 lineto
56.8945 18.543 lineto
55.85161 15.3906 lineto
55.2188 15.3906 lineto
54.1445 19.4805 lineto
54.8594 19.4805 lineto
55.6094 16.3125 lineto
56.6328 19.4805 lineto
57.1992 19.4805 lineto
58.2461 16.3125 lineto
58.957 19.4805 lineto
 closepath fill
newpath 64.1211 17.4336 moveto
64.1211 16.7695 63.9531 16.2422 63.6094 15.8555 curveto
63.2695 15.4727 62.8125 15.2773 62.2383 15.2773 curveto
61.6602 15.2773 61.1992 15.4727 60.8594 15.8555 curveto
60.5195 16.2422 60.35161 16.7695 60.35161 17.4336 curveto
60.35161 18.10161 60.5195 18.6289 60.8594 19.0117 curveto
61.1992 19.39839 61.6602 19.5938 62.2383 19.5938 curveto
62.2383 19 lineto
61.8633 19 61.5742 18.8711 61.3672 18.6133 curveto
61.16411 18.3555 61.0586 17.9648 61.0586 17.4336 curveto
61.0586 16.9219 61.16411 16.5312 61.3711 16.2695 curveto
61.5781 16.0039 61.8672 15.8711 62.2383 15.8711 curveto
62.6055 15.8711 62.8906 16.0039 63.10161 16.2656 curveto
63.3086 16.5273 63.41411 16.918 63.41411 17.4336 curveto
63.41411 17.4336 lineto
63.41411 17.9648 63.3086 18.3555 63.10161 18.6133 curveto
62.8945 18.8711 62.6055 19 62.2383 19 curveto
62.2383 19.5938 lineto
62.8125 19.5938 63.2695 19.39839 63.6094 19.0117 curveto
63.9531 18.6289 64.1211 18.10161 64.1211 17.4336 curveto
 closepath fill
newpath 65.1953 15.3906 moveto
65.8828 15.3906 lineto
65.8828 21.08589 lineto
65.1953 21.08589 lineto
 closepath fill
newpath 69.4453 20.4219 moveto
69.4062 20.4219 lineto
69.332 20.4414 69.2344 20.4648 69.1094 20.4883 curveto
68.9883 20.5117 68.8828 20.52339 68.78911 20.52339 curveto
68.4922 20.52339 68.2812 20.457 68.14839 20.3281 curveto
68.0156 20.1953 67.9492 19.96089 67.9492 19.6172 curveto
67.9492 19.4805 lineto
69.1875 19.4805 lineto
69.1875 18.9023 lineto
67.9688 18.9023 lineto
67.9688 15.3906 lineto
67.2812 15.3906 lineto
67.2812 18.9023 lineto
66.8164 18.9023 lineto
66.8164 19.4805 lineto
67.2812 19.4805 lineto
67.2812 19.6133 lineto
67.2812 20.10161 67.4023 20.4727 67.6445 20.7344 curveto
67.8867 20.9922 68.2344 21.125 68.6914 21.125 curveto
68.8438 21.125 68.9805 21.1133 69.1055 21.10161 curveto
69.2305 21.08589 69.3438 21.0703 69.4453 21.0508 curveto
 closepath fill
newpath 73.0586 15.3906 moveto
72.3711 15.3906 lineto
72.3711 15.8281 lineto
72.3125 15.7852 72.2305 15.7266 72.125 15.6523 curveto
71.8164 16.0586 lineto
72.0156 16.1523 72.2031 16.2656 72.3711 16.39839 curveto
72.3711 16.39839 lineto
72.3711 17.5352 lineto
72.1602 17.52339 71.91411 17.5078 71.6328 17.4805 curveto
71.3477 17.457 71.1211 17.4219 70.957 17.375 curveto
70.7578 17.3203 70.5977 17.2305 70.47661 17.1133 curveto
70.3555 16.9961 70.293 16.832 70.293 16.625 curveto
70.293 16.3906 70.3633 16.2148 70.5078 16.0977 curveto
70.64839 15.9766 70.8633 15.918 71.1523 15.918 curveto
71.3945 15.918 71.6172 15.9648 71.8164 16.0586 curveto
72.125 15.6523 lineto
72.02339 15.5781 71.9219 15.5195 71.8242 15.4766 curveto
71.71089 15.4219 71.5781 15.3711 71.4297 15.3359 curveto
71.2773 15.2969 71.1055 15.2773 70.9062 15.2773 curveto
70.5352 15.2773 70.2227 15.4023 69.9688 15.6445 curveto
69.71089 15.8867 69.58589 16.1992 69.58589 16.5781 curveto
69.58589 16.8867 69.64839 17.1367 69.7812 17.3281 curveto
69.91411 17.5195 70.1055 17.6719 70.35161 17.7812 curveto
70.60161 17.8906 70.89839 17.9648 71.25 18.0039 curveto
71.5977 18.043 71.9727 18.0742 72.3711 18.0938 curveto
72.3711 18.1992 lineto
72.3711 18.3555 72.3438 18.4844 72.28911 18.58589 curveto
72.2344 18.6875 72.1562 18.7695 72.0547 18.8281 curveto
71.957 18.8828 71.8398 18.9219 71.7031 18.9414 curveto
71.5664 18.96089 71.4219 18.9727 71.27339 18.9727 curveto
71.0938 18.9727 70.8906 18.9492 70.6719 18.9023 curveto
70.4492 18.85161 70.2188 18.7812 69.9805 18.6953 curveto
69.9453 18.6953 lineto
69.9453 19.3906 lineto
70.082 19.4297 70.27339 19.4688 70.5273 19.5117 curveto
70.7812 19.5547 71.0312 19.5781 71.2773 19.5781 curveto
71.5664 19.5781 71.8164 19.5547 72.0312 19.5078 curveto
72.2422 19.46089 72.4297 19.3789 72.58589 19.2656 curveto
72.7383 19.1523 72.8555 19.0078 72.9375 18.8281 curveto
73.0156 18.6523 73.0586 18.4297 73.0586 18.16411 curveto
 closepath fill
newpath 77.4062 15.6484 moveto
77.1758 15.5391 76.957 15.4531 76.75 15.3906 curveto
76.5469 15.332 76.3281 15.3008 76.0938 15.3008 curveto
75.8008 15.3008 75.5273 15.3438 75.2812 15.4297 curveto
75.0352 15.5156 74.8242 15.6484 74.64839 15.8242 curveto
74.4688 16 74.332 16.2227 74.2344 16.4883 curveto
74.1367 16.7578 74.0898 17.0703 74.0898 17.4297 curveto
74.0898 18.0977 74.27339 18.6211 74.6406 19.0039 curveto
75.0078 19.3867 75.4922 19.5742 76.0938 19.5742 curveto
76.3281 19.5742 76.5586 19.543 76.7852 19.47661 curveto
77.0117 19.4102 77.2188 19.332 77.4062 19.2344 curveto
77.4062 18.4688 lineto
77.3672 18.4688 lineto
77.1562 18.6328 76.9414 18.7578 76.7188 18.8477 curveto
76.4961 18.9336 76.2773 18.97661 76.0664 18.97661 curveto
75.6758 18.97661 75.3672 18.8477 75.1406 18.58589 curveto
74.91411 18.3242 74.8008 17.9375 74.8008 17.4297 curveto
74.8008 16.9375 74.91411 16.5586 75.1328 16.293 curveto
75.3555 16.0273 75.66411 15.8984 76.0664 15.8984 curveto
76.2031 15.8984 76.3438 15.9141 76.4883 15.9531 curveto
76.6328 15.9883 76.7656 16.0352 76.8789 16.0938 curveto
76.97661 16.1445 77.0703 16.1992 77.1602 16.2578 curveto
77.2461 16.3164 77.3164 16.3633 77.3672 16.4062 curveto
77.4062 16.4062 lineto
 closepath fill
newpath 81.707 15.3906 moveto
81.0156 15.3906 lineto
81.0156 17.7188 lineto
81.0156 17.9062 81.0078 18.082 80.9844 18.25 curveto
80.96089 18.41411 80.9219 18.543 80.8633 18.6367 curveto
80.8008 18.7383 80.7148 18.8125 80.5977 18.8633 curveto
80.4844 18.91411 80.33589 18.9375 80.1523 18.9375 curveto
79.9648 18.9375 79.7695 18.8906 79.5625 18.7969 curveto
79.3594 18.707 79.16411 18.5898 78.97661 18.4453 curveto
78.97661 15.3906 lineto
78.2852 15.3906 lineto
78.2852 21.08589 lineto
78.97661 21.08589 lineto
78.97661 19.0273 lineto
79.1875 19.2031 79.4102 19.3438 79.6406 19.4414 curveto
79.8711 19.543 80.1055 19.5938 80.3477 19.5938 curveto
80.78911 19.5938 81.125 19.46089 81.3555 19.1953 curveto
81.5898 18.9297 81.707 18.5469 81.707 18.043 curveto
 closepath fill
 0.02 0.024 0.024 setrgbcolor
newpath 321.176 25.6562 moveto
321.176 22.3047 lineto
322.72699 22.3047 lineto
323.082 22.3047 323.344 22.3828 323.508 22.5352 curveto
323.676 22.6953 323.789 23.0078 323.84 23.4727 curveto
324.074 23.4727 lineto
324.074 20.582 lineto
323.84 20.582 lineto
323.84 20.91411 323.797 21.1562 323.715 21.3164 curveto
323.629 21.4688 323.51599 21.58589 323.371 21.6602 curveto
323.22699 21.7383 323.012 21.7773 322.72699 21.7773 curveto
321.176 21.7773 lineto
321.176 19.10161 lineto
321.176 18.668 321.199 18.3828 321.254 18.2461 curveto
321.297 18.1367 321.387 18.0508 321.51999 17.9727 curveto
321.703 17.875 321.89801 17.8203 322.09799 17.8203 curveto
322.406 17.8203 lineto
322.406 17.5898 lineto
318.742 17.5898 lineto
318.742 17.8203 lineto
319.047 17.8203 lineto
319.40201 17.8203 319.65201 17.9219 319.81201 18.1328 curveto
319.914 18.2656 319.965 18.58589 319.965 19.10161 curveto
319.965 24.6094 lineto
319.965 25.043 319.93799 25.332 319.883 25.4688 curveto
319.84 25.5742 319.758 25.6602 319.625 25.7383 curveto
319.445 25.8398 319.254 25.8867 319.047 25.8867 curveto
318.742 25.8867 lineto
318.742 26.1211 lineto
325.094 26.1211 lineto
325.176 24.2461 lineto
324.953 24.2461 lineto
324.84799 24.6445 324.719 24.9375 324.574 25.125 curveto
324.43 25.3125 324.25 25.4453 324.039 25.5312 curveto
323.828 25.6172 323.5 25.6562 323.055 25.6562 curveto
 closepath fill
newpath 330.672 26.3164 moveto
331.781 26.3164 332.742 25.8945 333.555 25.0547 curveto
334.367 24.2148 334.76999 23.16411 334.76999 21.9062 curveto
334.76999 20.6094 334.363 19.5312 333.547 18.6797 curveto
332.72699 17.8203 331.73401 17.3945 330.574 17.3945 curveto
330.56201 17.8438 lineto
331.35901 17.8438 332.02301 18.1523 332.547 18.7773 curveto
333.06601 19.4062 333.328 20.3906 333.328 21.7344 curveto
333.328 23.1953 333.043 24.2812 332.469 25.0039 curveto
332.008 25.5742 331.367 25.8555 330.55899 25.8555 curveto
330.55899 25.8555 lineto
329.789 25.8555 329.176 25.5742 328.719 25.0078 curveto
328.14499 24.3047 327.85501 23.2695 327.85501 21.91411 curveto
327.85501 20.5195 328.156 19.4492 328.75 18.6953 curveto
329.203 18.1289 329.80899 17.8438 330.56201 17.8438 curveto
330.574 17.3945 lineto
329.39801 17.3945 328.41 17.8086 327.60901 18.64839 curveto
326.81201 19.4805 326.414 20.5625 326.414 21.8906 curveto
326.414 23.2422 326.879 24.3438 327.797 25.2031 curveto
328.59799 25.9492 329.55899 26.3164 330.672 26.3164 curveto
 closepath fill
newpath 341.676 25.8867 moveto
341.676 26.1211 lineto
344.69101 26.1211 lineto
344.69101 25.8867 lineto
344.371 25.8867 lineto
344.035 25.8867 343.781 25.7461 343.59799 25.4688 curveto
343.512 25.33589 343.465 25.0352 343.465 24.5625 curveto
343.465 21.10161 lineto
343.465 20.2461 343.383 19.582 343.211 19.1094 curveto
343.043 18.6367 342.707 18.2344 342.211 17.8945 curveto
341.715 17.5586 341.039 17.3867 340.18 17.3867 curveto
339.25 17.3867 338.543 17.5508 338.06201 17.875 curveto
337.578 18.1953 337.23401 18.6289 337.035 19.1758 curveto
336.90201 19.5508 336.836 20.2461 336.836 21.2773 curveto
336.836 24.6094 lineto
336.836 25.1367 336.762 25.47661 336.617 25.6445 curveto
336.47299 25.8086 336.238 25.8867 335.914 25.8867 curveto
335.594 25.8867 lineto
335.594 26.1211 lineto
339.281 26.1211 lineto
339.281 25.8867 lineto
338.953 25.8867 lineto
338.60199 25.8867 338.35199 25.7773 338.199 25.5547 curveto
338.094 25.4023 338.039 25.0898 338.039 24.6094 curveto
338.039 20.8945 lineto
338.039 20.5625 338.07 20.1797 338.133 19.7539 curveto
338.19101 19.3281 338.305 18.9922 338.465 18.7539 curveto
338.621 18.5156 338.85199 18.3203 339.15201 18.16411 curveto
339.453 18.0078 339.82 17.9297 340.258 17.9297 curveto
340.81601 17.9297 341.31201 18.0508 341.754 18.293 curveto
342.195 18.5352 342.496 18.8477 342.656 19.2305 curveto
342.82 19.6094 342.90201 20.25 342.90201 21.1562 curveto
342.90201 24.6094 lineto
342.90201 25.1445 342.84 25.47661 342.72699 25.6133 curveto
342.55899 25.7969 342.31601 25.8867 341.996 25.8867 curveto
 closepath fill
newpath 345.176 26.1211 moveto
347.492 26.1211 lineto
352.711 19.7227 lineto
352.711 24.6445 lineto
352.711 25.168 352.64801 25.4922 352.535 25.6211 curveto
352.379 25.8008 352.133 25.8867 351.797 25.8867 curveto
351.5 25.8867 lineto
351.5 26.1211 lineto
354.469 26.1211 lineto
354.469 25.8867 lineto
354.172 25.8867 lineto
353.80899 25.8867 353.555 25.7773 353.40201 25.5625 curveto
353.30899 25.4297 353.262 25.1211 353.262 24.6445 curveto
353.262 17.4531 lineto
353.035 17.4531 lineto
347.41 24.3203 lineto
347.41 19.0703 lineto
347.41 18.543 347.469 18.2148 347.582 18.08589 curveto
347.738 17.9102 347.98401 17.8203 348.31601 17.8203 curveto
348.617 17.8203 lineto
348.617 17.5898 lineto
345.64801 17.5898 lineto
345.64801 17.8203 lineto
345.945 17.8203 lineto
346.30899 17.8203 346.57 17.9297 346.719 18.14839 curveto
346.80899 18.2852 346.85901 18.5898 346.85901 19.0703 curveto
346.85901 25.0039 lineto
346.60901 25.28911 346.422 25.4805 346.297 25.5742 curveto
346.168 25.66411 345.97699 25.7539 345.73001 25.832 curveto
345.60901 25.8711 345.422 25.8867 345.176 25.8867 curveto
 closepath fill
newpath 355.129 17.5898 moveto
355.129 17.8203 lineto
355.449 17.8203 lineto
355.81201 17.8203 356.06601 17.9375 356.219 18.168 curveto
356.31201 18.3086 356.35501 18.6172 356.35501 19.10161 curveto
356.35501 24.6094 lineto
356.35501 25.1445 356.301 25.47661 356.18 25.6133 curveto
356.01999 25.7969 355.77301 25.8867 355.449 25.8867 curveto
355.129 25.8867 lineto
355.129 26.1211 lineto
358.60501 26.1211 lineto
359.879 26.1211 360.85199 25.97661 361.512 25.6875 curveto
362.18 25.39839 362.711 24.91411 363.117 24.2383 curveto
363.52301 23.5625 363.72299 22.7852 363.72299 21.89839 curveto
363.72299 20.7148 363.363 19.7188 362.64499 18.9219 curveto
361.836 18.0312 360.59799 17.5898 358.945 17.5898 curveto
358.906 18.0273 lineto
359.879 18.0273 360.68799 18.3711 361.328 19.0547 curveto
361.97299 19.7383 362.289 20.668 362.289 21.83589 curveto
362.289 23.0156 361.97299 23.9453 361.328 24.625 curveto
360.68799 25.3047 359.863 25.6445 358.85501 25.6445 curveto
358.47699 25.6445 358.051 25.58589 357.56601 25.46089 curveto
357.56601 18.207 lineto
358.09799 18.0898 358.547 18.0273 358.906 18.0273 curveto
358.945 17.5898 lineto
 closepath fill
newpath 369.85501 20.4453 moveto
369.68 20.9102 lineto
368.23001 24.3594 lineto
366.746 20.9102 lineto
369.68 20.9102 lineto
369.85501 20.4453 lineto
366.555 20.4453 lineto
365.97299 19.0977 lineto
365.828 18.7656 365.758 18.5195 365.758 18.3594 curveto
365.758 18.22661 365.82 18.1133 365.94101 18.0156 curveto
366.06601 17.91411 366.336 17.85161 366.746 17.8203 curveto
366.746 17.5898 lineto
364.05899 17.5898 lineto
364.05899 17.8203 lineto
364.414 17.8828 364.64499 17.9648 364.75 18.0703 curveto
364.965 18.2695 365.203 18.6797 365.465 19.2969 curveto
368.465 26.3203 lineto
368.68399 26.3203 lineto
371.65201 19.2188 lineto
371.89499 18.6523 372.10901 18.2812 372.305 18.1094 curveto
372.5 17.9375 372.76999 17.8438 373.121 17.8203 curveto
373.121 17.5898 lineto
369.758 17.5898 lineto
369.758 17.8203 lineto
370.094 17.8398 370.324 17.8945 370.445 17.9922 curveto
370.56201 18.0898 370.621 18.207 370.621 18.3438 curveto
370.621 18.5312 370.539 18.8203 370.371 19.2188 curveto
 closepath fill
newpath 379.293 26.1211 moveto
379.387 24.1211 lineto
379.14801 24.1211 lineto
379.10199 24.4727 379.039 24.7227 378.961 24.875 curveto
378.832 25.1172 378.656 25.2969 378.43799 25.41411 curveto
378.22299 25.5273 377.94101 25.58589 377.586 25.58589 curveto
376.387 25.58589 lineto
376.387 19.0703 lineto
376.387 18.543 376.44101 18.2148 376.555 18.08589 curveto
376.715 17.9102 376.961 17.8203 377.293 17.8203 curveto
377.586 17.8203 lineto
377.586 17.5898 lineto
373.969 17.5898 lineto
373.969 17.8203 lineto
374.26999 17.8203 lineto
374.633 17.8203 374.887 17.9297 375.039 18.14839 curveto
375.133 18.2852 375.176 18.5898 375.176 19.0703 curveto
375.176 25.58589 lineto
374.15201 25.58589 lineto
373.754 25.58589 373.469 25.5547 373.305 25.5 curveto
373.086 25.418 372.89801 25.2656 372.742 25.0352 curveto
372.59 24.8125 372.496 24.5039 372.465 24.1211 curveto
372.22699 24.1211 lineto
372.328 26.1211 lineto
 closepath fill
newpath 383.68399 17.8203 moveto
383.68399 17.5898 lineto
380.031 17.5898 lineto
380.031 17.8203 lineto
380.332 17.8203 lineto
380.68399 17.8203 380.94101 17.9219 381.09799 18.1328 curveto
381.199 18.2656 381.25 18.58589 381.25 19.10161 curveto
381.25 24.6094 lineto
381.25 25.043 381.22299 25.332 381.168 25.4688 curveto
381.129 25.5742 381.039 25.66411 380.91 25.7383 curveto
380.72699 25.8398 380.535 25.8867 380.332 25.8867 curveto
380.031 25.8867 lineto
380.031 26.1211 lineto
383.68399 26.1211 lineto
383.68399 25.8867 lineto
383.379 25.8867 lineto
383.02701 25.8867 382.77301 25.7852 382.613 25.582 curveto
382.508 25.4453 382.457 25.1211 382.457 24.6094 curveto
382.457 19.10161 lineto
382.457 18.668 382.48401 18.3828 382.539 18.2461 curveto
382.578 18.1367 382.672 18.0508 382.801 17.9727 curveto
382.98401 17.875 383.176 17.8203 383.379 17.8203 curveto
 closepath fill
newpath 388.97299 26.3164 moveto
390.078 26.3164 391.039 25.8945 391.85199 25.0547 curveto
392.66 24.2148 393.06601 23.16411 393.06601 21.9062 curveto
393.06601 20.6094 392.656 19.5312 391.84 18.6797 curveto
391.01999 17.8203 390.031 17.3945 388.867 17.3945 curveto
388.85501 17.8438 lineto
389.66 17.8438 390.32 18.1523 390.844 18.7773 curveto
391.367 19.4062 391.629 20.3906 391.629 21.7344 curveto
391.629 23.1953 391.34 24.2812 390.762 25.0039 curveto
390.301 25.5742 389.66 25.8555 388.85199 25.8555 curveto
388.85199 25.8555 lineto
388.086 25.8555 387.47699 25.5742 387.01599 25.0078 curveto
386.43799 24.3047 386.14801 23.2695 386.14801 21.91411 curveto
386.14801 20.5195 386.449 19.4492 387.047 18.6953 curveto
387.5 18.1289 388.10501 17.8438 388.85501 17.8438 curveto
388.867 17.3945 lineto
387.695 17.3945 386.707 17.8086 385.91 18.64839 curveto
385.10901 19.4805 384.711 20.5625 384.711 21.8906 curveto
384.711 23.2422 385.172 24.3438 386.09799 25.2031 curveto
386.89499 25.9492 387.85199 26.3164 388.97299 26.3164 curveto
 closepath fill
newpath 393.65201 26.1211 moveto
395.969 26.1211 lineto
401.18399 19.7227 lineto
401.18399 24.6445 lineto
401.18399 25.168 401.125 25.4922 401.004 25.6211 curveto
400.85199 25.8008 400.60501 25.8867 400.26999 25.8867 curveto
399.97699 25.8867 lineto
399.97699 26.1211 lineto
402.945 26.1211 lineto
402.945 25.8867 lineto
402.64099 25.8867 lineto
402.281 25.8867 402.02301 25.7773 401.879 25.5625 curveto
401.781 25.4297 401.73401 25.1211 401.73401 24.6445 curveto
401.73401 17.4531 lineto
401.508 17.4531 lineto
395.883 24.3203 lineto
395.883 19.0703 lineto
395.883 18.543 395.94101 18.2148 396.055 18.08589 curveto
396.215 17.9102 396.461 17.8203 396.789 17.8203 curveto
397.094 17.8203 lineto
397.094 17.5898 lineto
394.121 17.5898 lineto
394.121 17.8203 lineto
394.422 17.8203 lineto
394.785 17.8203 395.039 17.9297 395.19101 18.14839 curveto
395.285 18.2852 395.328 18.5898 395.328 19.0703 curveto
395.328 25.0039 lineto
395.086 25.28911 394.89499 25.4805 394.76999 25.5742 curveto
394.64099 25.66411 394.453 25.7539 394.203 25.832 curveto
394.086 25.8711 393.89801 25.8867 393.65201 25.8867 curveto
 closepath fill
newpath 322.949 36.2148 moveto
324.055 36.2148 324.969 35.8164 325.68799 35.0156 curveto
326.34799 34.28911 326.676 33.4297 326.676 32.4336 curveto
326.676 31.4297 326.332 30.5625 325.633 29.8125 curveto
324.93799 29.0664 324.043 28.6914 322.949 28.6914 curveto
322.945 29.5664 lineto
323.457 29.5664 323.926 29.6875 324.35199 29.9297 curveto
324.781 30.1719 325.117 30.5195 325.367 30.9688 curveto
325.617 31.41411 325.746 31.8945 325.746 32.41411 curveto
325.746 33.2188 325.469 33.89839 324.918 34.4648 curveto
324.363 35.0312 323.707 35.3125 322.945 35.3125 curveto
322.945 35.3125 lineto
322.18 35.3125 321.52301 35.0312 320.97299 34.4648 curveto
320.422 33.89839 320.14801 33.2188 320.14801 32.41411 curveto
320.14801 31.8945 320.27301 31.41411 320.52301 30.9688 curveto
320.77701 30.5195 321.113 30.1719 321.543 29.9297 curveto
321.969 29.6875 322.43799 29.5664 322.945 29.5664 curveto
322.949 28.6914 lineto
321.85199 28.6914 320.957 29.0664 320.258 29.8125 curveto
319.56201 30.5625 319.215 31.4297 319.215 32.4336 curveto
319.215 33.4258 319.543 34.2812 320.199 35.0117 curveto
320.93 35.8125 321.844 36.2148 322.949 36.2148 curveto
 closepath fill
newpath 328.44101 28.875 moveto
328.44101 38.793 lineto
329.35901 38.793 lineto
329.35901 34.8008 lineto
329.75 35.27339 330.18 35.6289 330.656 35.8594 curveto
331.137 36.0977 331.656 36.2148 332.22699 36.2148 curveto
333.238 36.2148 334.10199 35.8477 334.81601 35.1094 curveto
335.531 34.3789 335.89499 33.4883 335.89499 32.4375 curveto
335.89499 31.4023 335.531 30.52339 334.805 29.78911 curveto
334.082 29.0547 333.215 28.6914 332.199 28.6914 curveto
331.617 28.6914 331.09 28.8164 330.617 29.0664 curveto
330.14499 29.3164 329.72299 29.6914 329.35901 30.1914 curveto
330.113 30.41411 lineto
330.656 29.8555 331.328 29.5781 332.121 29.5781 curveto
332.121 29.5781 lineto
332.637 29.5781 333.10501 29.7031 333.539 29.957 curveto
333.97299 30.207 334.32 30.5586 334.574 31.0195 curveto
334.832 31.4727 334.957 31.957 334.957 32.4648 curveto
334.957 32.9727 334.828 33.457 334.57 33.918 curveto
334.31201 34.3789 333.969 34.7344 333.531 34.9961 curveto
333.09799 35.2539 332.629 35.3789 332.137 35.3789 curveto
331.633 35.3789 331.156 35.2539 330.703 34.9961 curveto
330.25 34.7344 329.90201 34.3906 329.66 33.957 curveto
329.418 33.52339 329.297 33.0352 329.297 32.4922 curveto
329.297 31.66411 329.57 30.9688 330.113 30.41411 curveto
329.35901 30.1914 lineto
329.35901 28.875 lineto
 closepath fill
newpath 343.594 31.25 moveto
344.367 30.8398 lineto
344.113 30.3438 343.82 29.9375 343.48401 29.6289 curveto
343.156 29.3242 342.77701 29.0898 342.35901 28.9297 curveto
341.945 28.7695 341.47299 28.6914 340.945 28.6914 curveto
339.781 28.6914 338.867 29.0742 338.211 29.8398 curveto
337.551 30.60161 337.219 31.4688 337.219 32.4336 curveto
337.219 33.3398 337.5 34.14839 338.05899 34.8594 curveto
338.76599 35.7656 339.711 36.2148 340.89499 36.2148 curveto
342.113 36.2148 343.09 35.7539 343.82 34.8242 curveto
344.332 34.1719 344.59799 33.3555 344.60901 32.3789 curveto
338.168 32.3789 lineto
338.258 33.1758 lineto
343.594 33.1758 lineto
343.469 33.668 343.293 34.0586 343.05899 34.35161 curveto
342.82 34.6445 342.512 34.8867 342.125 35.0625 curveto
341.738 35.2422 341.332 35.332 340.91 35.332 curveto
340.207 35.332 339.60199 35.1055 339.09799 34.6562 curveto
338.73001 34.3281 338.449 33.832 338.258 33.1758 curveto
338.168 32.3789 lineto
338.18399 31.5469 338.449 30.8672 338.965 30.33589 curveto
339.47699 29.8047 340.10901 29.53911 340.867 29.53911 curveto
341.23401 29.53911 341.586 29.60161 341.93399 29.72661 curveto
342.27701 29.8555 342.57 30.0273 342.80899 30.2305 curveto
343.055 30.4414 343.31201 30.7812 343.594 31.25 curveto
 closepath fill
newpath 345.97299 36.0312 moveto
346.914 36.0312 lineto
346.914 34.9844 lineto
347.195 35.39839 347.488 35.7031 347.805 35.9062 curveto
348.113 36.1133 348.43799 36.2148 348.77701 36.2148 curveto
349.031 36.2148 349.305 36.1328 349.594 35.9688 curveto
349.113 35.1953 lineto
348.918 35.2773 348.758 35.3203 348.625 35.3203 curveto
348.32 35.3203 348.02301 35.1953 347.73401 34.9414 curveto
347.449 34.6875 347.23401 34.3008 347.086 33.7656 curveto
346.97299 33.3594 346.914 32.5352 346.914 31.293 curveto
346.914 28.875 lineto
345.97299 28.875 lineto
 closepath fill
newpath 349.945 36.0312 moveto
350.89499 36.0312 lineto
353.086 30.83589 lineto
355.367 36.0312 lineto
355.535 36.0312 lineto
357.836 30.83589 lineto
360.07 36.0312 lineto
361.02701 36.0312 lineto
357.922 28.875 lineto
357.746 28.875 lineto
355.461 33.9961 lineto
353.176 28.875 lineto
353.004 28.875 lineto
 closepath fill
newpath 365.492 36.2148 moveto
366.59799 36.2148 367.512 35.8164 368.23001 35.0156 curveto
368.89099 34.28911 369.219 33.4297 369.219 32.4336 curveto
369.219 31.4297 368.875 30.5625 368.176 29.8125 curveto
367.48001 29.0664 366.586 28.6914 365.492 28.6914 curveto
365.488 29.5664 lineto
366 29.5664 366.469 29.6875 366.89499 29.9297 curveto
367.324 30.1719 367.66 30.5195 367.91 30.9688 curveto
368.16 31.41411 368.289 31.8945 368.289 32.41411 curveto
368.289 33.2188 368.012 33.89839 367.461 34.4648 curveto
366.906 35.0312 366.25 35.3125 365.488 35.3125 curveto
365.488 35.3125 lineto
364.72299 35.3125 364.06601 35.0312 363.51599 34.4648 curveto
362.965 33.89839 362.69101 33.2188 362.69101 32.41411 curveto
362.69101 31.8945 362.81601 31.41411 363.06601 30.9688 curveto
363.32 30.5195 363.656 30.1719 364.086 29.9297 curveto
364.512 29.6875 364.98001 29.5664 365.488 29.5664 curveto
365.492 28.6914 lineto
364.39499 28.6914 363.496 29.0664 362.801 29.8125 curveto
362.10501 30.5625 361.758 31.4297 361.758 32.4336 curveto
361.758 33.4258 362.086 34.2812 362.742 35.0117 curveto
363.47299 35.8125 364.387 36.2148 365.492 36.2148 curveto
 closepath fill
newpath 370.785 28.875 moveto
371.707 28.875 lineto
371.707 38.793 lineto
370.785 38.793 lineto
 closepath fill
newpath 376.56601 38.793 moveto
376.56601 37.8906 lineto
376.23001 38.0352 375.94101 38.1094 375.699 38.1094 curveto
375.51999 38.1094 375.371 38.0703 375.25 38 curveto
375.133 37.9297 375.06201 37.8438 375.02701 37.75 curveto
374.996 37.6523 374.98001 37.4023 374.98001 36.9961 curveto
374.98001 36.0312 lineto
376.47699 36.0312 lineto
376.47699 35.2344 lineto
374.98001 35.2344 lineto
374.97699 28.875 lineto
374.055 28.875 lineto
374.055 35.2344 lineto
373.113 35.2344 lineto
373.113 36.0312 lineto
374.055 36.0312 lineto
374.055 37.14839 lineto
374.055 37.6602 374.10199 38.0273 374.195 38.2461 curveto
374.293 38.4648 374.449 38.6406 374.676 38.7773 curveto
374.90201 38.9102 375.176 38.97661 375.496 38.97661 curveto
375.797 38.97661 376.14801 38.918 376.56601 38.793 curveto
 closepath fill
newpath 384.97699 36.0312 moveto
384.97699 28.875 lineto
384.074 28.875 lineto
384.074 30.1055 lineto
383.68399 29.6367 383.254 29.2812 382.77301 29.043 curveto
382.289 28.8086 381.76599 28.6914 381.199 28.6914 curveto
380.18799 28.6914 379.32 29.0586 378.60199 29.793 curveto
377.887 30.5273 377.52701 31.4219 377.52701 32.4727 curveto
377.52701 33.5039 377.89099 34.3828 378.613 35.1133 curveto
379.336 35.8477 380.207 36.2148 381.22299 36.2148 curveto
381.81201 36.2148 382.344 36.08589 382.82 35.8398 curveto
383.293 35.5898 383.711 35.2148 384.074 34.7148 curveto
383.31201 34.4922 lineto
382.76599 35.0469 382.09799 35.3281 381.301 35.3281 curveto
381.301 35.3281 lineto
380.785 35.3281 380.31601 35.1992 379.883 34.9492 curveto
379.449 34.6992 379.10199 34.3438 378.844 33.8867 curveto
378.59 33.4336 378.461 32.9531 378.461 32.4414 curveto
378.461 31.9414 378.59 31.457 378.84799 30.9961 curveto
379.10501 30.5352 379.453 30.1797 379.89099 29.9219 curveto
380.328 29.668 380.797 29.5352 381.293 29.5352 curveto
381.797 29.5352 382.27301 29.66411 382.72699 29.918 curveto
383.176 30.1719 383.51999 30.5195 383.76599 30.9531 curveto
384.008 31.3867 384.133 31.8711 384.133 32.41411 curveto
384.133 33.2461 383.85501 33.9375 383.31201 34.4922 curveto
384.074 34.7148 lineto
384.074 36.0312 lineto
 closepath fill
newpath 393.996 34.543 moveto
393.26599 34.0898 lineto
392.637 34.9258 391.77301 35.3477 390.68399 35.3477 curveto
389.80899 35.3477 389.09 35.0664 388.512 34.5039 curveto
387.93799 33.9414 387.64801 33.2617 387.64801 32.46089 curveto
387.64801 31.9414 387.781 31.4492 388.047 30.9922 curveto
388.31201 30.5312 388.676 30.1719 389.137 29.918 curveto
389.59799 29.66411 390.117 29.53911 390.69101 29.53911 curveto
391.742 29.53911 392.60199 29.957 393.26599 30.793 curveto
393.996 30.3164 lineto
393.65201 29.8008 393.19101 29.4023 392.617 29.1172 curveto
392.043 28.832 391.383 28.6914 390.64801 28.6914 curveto
389.51999 28.6914 388.578 29.0508 387.832 29.7695 curveto
387.09 30.4844 386.715 31.3594 386.715 32.3906 curveto
386.715 33.08589 386.89099 33.72661 387.238 34.3242 curveto
387.586 34.918 388.06201 35.3828 388.676 35.7148 curveto
389.285 36.0469 389.965 36.2148 390.719 36.2148 curveto
391.19101 36.2148 391.65201 36.1406 392.094 35.9961 curveto
392.531 35.85161 392.906 35.66411 393.215 35.4297 curveto
393.51999 35.1992 393.781 34.9023 393.996 34.543 curveto
 closepath fill
newpath 395.76599 38.793 moveto
396.68399 38.793 lineto
396.68399 34.7461 lineto
397.05899 35.2383 397.469 35.6055 397.914 35.8477 curveto
398.363 36.0898 398.84799 36.2148 399.367 36.2148 curveto
399.906 36.2148 400.379 36.0781 400.789 35.8047 curveto
401.207 35.5352 401.512 35.1719 401.711 34.71089 curveto
401.906 34.2539 402.008 33.5352 402.008 32.5547 curveto
402.008 28.875 lineto
401.082 28.875 lineto
401.082 32.28911 lineto
401.082 33.1094 401.051 33.6602 400.988 33.9414 curveto
400.871 34.41411 400.664 34.7695 400.363 35.0078 curveto
400.06201 35.2461 399.672 35.3672 399.18399 35.3672 curveto
398.629 35.3672 398.129 35.1797 397.68799 34.8164 curveto
397.246 34.4453 396.957 33.9883 396.81601 33.4453 curveto
396.72699 33.0938 396.68399 32.4453 396.68399 31.5 curveto
396.68399 28.875 lineto
395.76599 28.875 lineto
 closepath fill
 0.137 0.122 0.125 setrgbcolor
newpath 186.656 21.9648 moveto
186.656 21.6719 186.77 21.4336 187.004 21.2422 curveto
187.234 21.0547 187.625 20.96089 188.176 20.96089 curveto
188.469 20.96089 188.711 20.9922 188.902 21.0508 curveto
189.094 21.1133 189.246 21.1992 189.363 21.3086 curveto
189.477 21.41411 189.566 21.5664 189.629 21.7539 curveto
189.691 21.9453 189.723 22.2344 189.723 22.6172 curveto
189.723 25.543 lineto
188.918 25.543 lineto
188.918 25.08589 lineto
188.668 24.71089 lineto
188.809 24.5469 188.879 24.2969 188.879 23.96089 curveto
188.879 23.6367 188.805 23.3906 188.66 23.22661 curveto
188.516 23.0625 188.336 22.9805 188.125 22.9805 curveto
187.93 22.9805 187.766 23.0586 187.629 23.2227 curveto
187.496 23.3828 187.43 23.6367 187.43 23.9805 curveto
187.43 24.3086 187.496 24.5547 187.629 24.7148 curveto
187.629 24.7148 lineto
187.766 24.875 187.934 24.957 188.141 24.957 curveto
188.352 24.957 188.527 24.875 188.668 24.71089 curveto
188.918 25.08589 lineto
188.656 25.4375 188.32 25.6172 187.922 25.6172 curveto
187.527 25.6172 187.203 25.4727 186.938 25.1836 curveto
186.676 24.8945 186.547 24.47661 186.547 23.9297 curveto
186.547 23.4961 186.645 23.1328 186.844 22.8398 curveto
187.102 22.4688 187.449 22.2812 187.887 22.2812 curveto
188.277 22.2812 188.605 22.46089 188.863 22.8125 curveto
188.863 22.33589 lineto
188.863 22.1445 188.848 22.0117 188.82 21.9375 curveto
188.781 21.8398 188.727 21.7656 188.648 21.7227 curveto
188.535 21.6523 188.367 21.6211 188.145 21.6211 curveto
187.969 21.6211 187.84 21.6523 187.758 21.7148 curveto
187.695 21.7539 187.66 21.83589 187.645 21.9492 curveto
186.656 22.0703 lineto
186.656 22.0273 186.656 21.9922 186.656 21.9648 curveto
 closepath fill
newpath 192.258 22.9648 moveto
192.164 22.8906 192.051 22.8555 191.914 22.8555 curveto
191.719 22.8555 191.551 22.9258 191.418 23.0664 curveto
191.285 23.21089 191.215 23.4102 191.211 23.66411 curveto
191.227 24.1914 lineto
191.223 24.4258 191.285 24.6133 191.406 24.75 curveto
191.527 24.8867 191.684 24.957 191.871 24.957 curveto
192.051 24.957 192.199 24.8906 192.32 24.7617 curveto
192.441 24.6328 192.508 24.4414 192.516 24.1914 curveto
191.227 24.1914 lineto
191.211 23.66411 lineto
193.371 23.66411 lineto
193.383 24.3242 193.25 24.8164 192.969 25.1367 curveto
192.688 25.457 192.305 25.6172 191.82 25.6172 curveto
191.391 25.6172 191.031 25.4648 190.75 25.1562 curveto
190.469 24.85161 190.324 24.4297 190.324 23.8906 curveto
190.324 23.4375 190.434 23.0625 190.648 22.7656 curveto
190.922 22.3945 191.34 22.21089 191.906 22.21089 curveto
192.266 22.21089 192.562 22.293 192.801 22.457 curveto
193.039 22.6211 193.215 22.8594 193.324 23.1758 curveto
192.465 23.3203 lineto
192.418 23.1562 192.348 23.03911 192.258 22.9648 curveto
 closepath fill
newpath 194.008 22.2812 moveto
194.871 22.2812 lineto
194.871 23.8672 lineto
194.871 24.1797 194.895 24.4023 194.941 24.53911 curveto
194.984 24.6719 195.062 24.7773 195.168 24.8477 curveto
195.273 24.9219 195.395 24.957 195.527 24.957 curveto
195.637 24.957 195.727 24.9336 195.789 24.8906 curveto
195.855 24.8438 195.902 24.77339 195.934 24.6836 curveto
195.965 24.5898 195.98 24.3867 195.98 24.0703 curveto
195.98 22.2812 lineto
196.844 22.2812 lineto
196.844 23.8477 lineto
196.844 24.1562 196.863 24.3789 196.91 24.52339 curveto
196.961 24.66411 197.035 24.77339 197.141 24.8477 curveto
197.25 24.918 197.363 24.957 197.484 24.957 curveto
197.648 24.957 197.77 24.8945 197.852 24.77339 curveto
197.91 24.6758 197.941 24.4688 197.941 24.1445 curveto
197.941 22.2812 lineto
198.805 22.2812 lineto
198.805 24.3672 lineto
198.805 24.6758 198.773 24.9023 198.715 25.043 curveto
198.633 25.2305 198.508 25.3711 198.344 25.4688 curveto
198.176 25.5664 197.973 25.6172 197.734 25.6172 curveto
197.547 25.6172 197.367 25.5742 197.203 25.4883 curveto
197.039 25.4023 196.883 25.2695 196.738 25.0977 curveto
196.641 25.2695 196.516 25.4023 196.363 25.4883 curveto
196.211 25.5742 196.027 25.6172 195.82 25.6172 curveto
195.426 25.6172 195.09 25.4414 194.805 25.0977 curveto
194.805 25.543 lineto
194.008 25.543 lineto
 closepath fill
newpath 201.34 22.9648 moveto
201.25 22.8906 201.137 22.8555 201 22.8555 curveto
200.801 22.8555 200.637 22.9258 200.504 23.0664 curveto
200.371 23.21089 200.301 23.4102 200.293 23.66411 curveto
200.309 24.1914 lineto
200.309 24.4258 200.367 24.6133 200.492 24.75 curveto
200.613 24.8867 200.77 24.957 200.957 24.957 curveto
201.133 24.957 201.281 24.8906 201.406 24.7617 curveto
201.527 24.6328 201.594 24.4414 201.598 24.1914 curveto
200.309 24.1914 lineto
200.293 23.66411 lineto
202.453 23.66411 lineto
202.469 24.3242 202.332 24.8164 202.055 25.1367 curveto
201.773 25.457 201.391 25.6172 200.906 25.6172 curveto
200.473 25.6172 200.117 25.4648 199.836 25.1562 curveto
199.551 24.85161 199.41 24.4297 199.41 23.8906 curveto
199.41 23.4375 199.52 23.0625 199.734 22.7656 curveto
200.004 22.3945 200.426 22.21089 200.992 22.21089 curveto
201.348 22.21089 201.648 22.293 201.887 22.457 curveto
202.125 22.6211 202.297 22.8594 202.41 23.1758 curveto
201.551 23.3203 lineto
201.504 23.1562 201.434 23.03911 201.34 22.9648 curveto
 closepath fill
newpath 204.02 26.7812 moveto
203.156 26.7812 lineto
203.156 25.9844 lineto
204.02 25.9844 lineto
 closepath fill
newpath 204.02 25.543 moveto
203.156 25.543 lineto
203.156 22.2852 lineto
204.02 22.2852 lineto
 closepath fill
newpath 207.867 24.3086 moveto
207.867 24.5625 207.852 24.7539 207.82 24.8906 curveto
207.789 25.02339 207.734 25.1445 207.652 25.25 curveto
207.57 25.3594 207.453 25.4453 207.297 25.5156 curveto
207.137 25.582 206.965 25.6172 206.773 25.6172 curveto
206.344 25.6172 205.984 25.4336 205.699 25.0625 curveto
205.699 25.543 lineto
204.898 25.543 lineto
204.898 22.2812 lineto
205.762 22.2812 lineto
205.762 23.7578 lineto
205.762 24.1211 205.781 24.3711 205.828 24.5078 curveto
205.871 24.6445 205.953 24.7539 206.07 24.83589 curveto
206.188 24.91411 206.324 24.957 206.473 24.957 curveto
206.59 24.957 206.688 24.9258 206.773 24.8711 curveto
206.855 24.8125 206.914 24.7344 206.949 24.6289 curveto
206.988 24.5273 207.008 24.2969 207.008 23.9453 curveto
207.008 22.2812 lineto
207.867 22.2812 lineto
 closepath fill
newpath 211.707 24.3086 moveto
211.707 24.5625 211.691 24.7539 211.66 24.8906 curveto
211.629 25.02339 211.574 25.1445 211.492 25.25 curveto
211.41 25.3594 211.293 25.4453 211.137 25.5156 curveto
210.977 25.582 210.805 25.6172 210.613 25.6172 curveto
210.18 25.6172 209.824 25.4336 209.539 25.0625 curveto
209.539 25.543 lineto
208.738 25.543 lineto
208.738 22.2812 lineto
209.602 22.2812 lineto
209.602 23.7578 lineto
209.602 24.1211 209.621 24.3711 209.664 24.5078 curveto
209.711 24.6445 209.789 24.7539 209.91 24.83589 curveto
210.027 24.91411 210.164 24.957 210.312 24.957 curveto
210.43 24.957 210.527 24.9258 210.609 24.8711 curveto
210.695 24.8125 210.754 24.7344 210.789 24.6289 curveto
210.828 24.5273 210.848 24.2969 210.848 23.9453 curveto
210.848 22.2812 lineto
211.707 22.2812 lineto
 closepath fill
newpath 215.527 22.2812 moveto
215.527 25.543 lineto
214.668 25.543 lineto
214.668 24.168 lineto
214.668 23.6992 214.645 23.4062 214.602 23.28911 curveto
214.559 23.168 214.48 23.0703 214.363 22.9883 curveto
214.246 22.9062 214.113 22.8672 213.969 22.8672 curveto
213.84 22.8672 213.73 22.89839 213.648 22.957 curveto
213.562 23.0156 213.508 23.0977 213.477 23.2031 curveto
213.441 23.3047 213.426 23.58589 213.426 24.043 curveto
213.426 25.543 lineto
212.566 25.543 lineto
212.566 23.4805 lineto
212.566 23.1719 212.605 22.9336 212.68 22.7578 curveto
212.758 22.58589 212.887 22.4492 213.059 22.3555 curveto
213.234 22.2578 213.43 22.21089 213.648 22.21089 curveto
213.863 22.21089 214.066 22.2578 214.262 22.3594 curveto
214.453 22.46089 214.609 22.5977 214.727 22.7695 curveto
214.727 22.2812 lineto
 closepath fill
newpath 213.758 26.8594 moveto
213.016 26.8594 lineto
213.016 26.1211 lineto
213.758 26.1211 lineto
 closepath fill
newpath 215.078 26.8594 moveto
214.336 26.8594 lineto
214.336 26.1211 lineto
215.078 26.1211 lineto
 closepath fill
newpath 217.328 25.543 moveto
217.328 26.6953 lineto
216.465 26.1914 lineto
216.465 25.543 lineto
216.066 25.543 lineto
216.066 24.8555 lineto
216.465 24.8555 lineto
216.465 23.4336 lineto
216.465 23.1289 216.473 22.9258 216.488 22.8242 curveto
216.512 22.6836 216.555 22.5742 216.613 22.4883 curveto
216.672 22.4062 216.762 22.3398 216.887 22.28911 curveto
217.012 22.2344 217.152 22.21089 217.309 22.21089 curveto
217.559 22.21089 217.789 22.2539 217.988 22.3398 curveto
217.914 23.0078 lineto
217.762 22.9531 217.648 22.9258 217.566 22.9258 curveto
217.512 22.9258 217.461 22.9375 217.422 22.9688 curveto
217.383 22.9961 217.355 23.0312 217.344 23.0781 curveto
217.336 23.1211 217.328 23.27339 217.328 23.543 curveto
217.328 24.8555 lineto
217.918 24.8555 lineto
217.918 25.543 lineto
 closepath fill
newpath 221.078 22.2812 moveto
221.078 23.03911 lineto
219.742 23.03911 lineto
219.688 23.03911 219.539 23.0352 219.297 23.0195 curveto
219.738 23.4961 lineto
220.984 24.9336 lineto
220.984 25.543 lineto
218.289 25.543 lineto
218.289 24.8281 lineto
219.441 24.83589 lineto
219.602 24.83589 219.734 24.8398 219.836 24.8477 curveto
219.738 24.75 219.59 24.58589 219.391 24.3594 curveto
218.168 22.957 lineto
218.168 22.2812 lineto
 closepath fill
newpath 222.52 26.7812 moveto
221.66 26.7812 lineto
221.66 25.9844 lineto
222.52 25.9844 lineto
 closepath fill
newpath 222.52 25.543 moveto
221.66 25.543 lineto
221.66 22.2852 lineto
222.52 22.2852 lineto
 closepath fill
newpath 223.32 21.9648 moveto
223.32 21.6719 223.438 21.4336 223.668 21.2422 curveto
223.898 21.0547 224.293 20.96089 224.844 20.96089 curveto
225.137 20.96089 225.379 20.9922 225.57 21.0508 curveto
225.762 21.1133 225.914 21.1992 226.027 21.3086 curveto
226.145 21.41411 226.234 21.5664 226.297 21.7539 curveto
226.359 21.9453 226.391 22.2344 226.391 22.6172 curveto
226.391 25.543 lineto
225.586 25.543 lineto
225.586 25.08589 lineto
225.336 24.71089 lineto
225.473 24.5469 225.543 24.2969 225.543 23.96089 curveto
225.543 23.6367 225.473 23.3906 225.324 23.22661 curveto
225.18 23.0625 225.004 22.9805 224.793 22.9805 curveto
224.598 22.9805 224.43 23.0586 224.297 23.2227 curveto
224.16 23.3828 224.098 23.6367 224.098 23.9805 curveto
224.098 24.3086 224.16 24.5547 224.297 24.7148 curveto
224.297 24.7148 lineto
224.43 24.875 224.602 24.957 224.809 24.957 curveto
225.02 24.957 225.195 24.875 225.336 24.71089 curveto
225.586 25.08589 lineto
225.32 25.4375 224.988 25.6172 224.586 25.6172 curveto
224.195 25.6172 223.867 25.4727 223.605 25.1836 curveto
223.344 24.8945 223.211 24.47661 223.211 23.9297 curveto
223.211 23.4961 223.312 23.1328 223.512 22.8398 curveto
223.77 22.4688 224.113 22.2812 224.555 22.2812 curveto
224.945 22.2812 225.27 22.46089 225.527 22.8125 curveto
225.527 22.33589 lineto
225.527 22.1445 225.516 22.0117 225.488 21.9375 curveto
225.449 21.8398 225.395 21.7656 225.316 21.7227 curveto
225.203 21.6523 225.035 21.6211 224.809 21.6211 curveto
224.633 21.6211 224.508 21.6523 224.426 21.7148 curveto
224.363 21.7539 224.328 21.83589 224.309 21.9492 curveto
223.324 22.0703 lineto
223.324 22.0273 223.32 21.9922 223.32 21.9648 curveto
 closepath fill
newpath 228.922 22.9648 moveto
228.832 22.8906 228.719 22.8555 228.582 22.8555 curveto
228.383 22.8555 228.219 22.9258 228.086 23.0664 curveto
227.953 23.21089 227.883 23.4102 227.879 23.66411 curveto
227.891 24.1914 lineto
227.891 24.4258 227.949 24.6133 228.074 24.75 curveto
228.195 24.8867 228.352 24.957 228.539 24.957 curveto
228.715 24.957 228.863 24.8906 228.988 24.7617 curveto
229.109 24.6328 229.176 24.4414 229.18 24.1914 curveto
227.891 24.1914 lineto
227.879 23.66411 lineto
230.035 23.66411 lineto
230.051 24.3242 229.914 24.8164 229.637 25.1367 curveto
229.355 25.457 228.973 25.6172 228.488 25.6172 curveto
228.055 25.6172 227.699 25.4648 227.414 25.1562 curveto
227.133 24.85161 226.992 24.4297 226.992 23.8906 curveto
226.992 23.4375 227.102 23.0625 227.316 22.7656 curveto
227.586 22.3945 228.008 22.21089 228.574 22.21089 curveto
228.93 22.21089 229.23 22.293 229.469 22.457 curveto
229.707 22.6211 229.883 22.8594 229.992 23.1758 curveto
229.133 23.3203 lineto
229.086 23.1562 229.016 23.03911 228.922 22.9648 curveto
 closepath fill
newpath 235.625 23.9375 moveto
235.625 23.3672 lineto
235.488 23.2617 235.324 23.168 235.133 23.0938 curveto
234.941 23.0195 234.75 22.9844 234.562 22.9844 curveto
234.176 22.9844 233.867 23.1172 233.629 23.3828 curveto
233.391 23.64839 233.273 24.0508 233.273 24.58589 curveto
233.273 25.082 233.391 25.4531 233.625 25.707 curveto
233.859 25.957 234.176 26.082 234.57 26.082 curveto
234.832 26.082 235.051 26.0195 235.227 25.8906 curveto
235.398 25.7617 235.52 25.5898 235.582 25.3672 curveto
236.484 25.5352 lineto
236.395 25.9492 236.195 26.27339 235.879 26.5078 curveto
235.566 26.7422 235.129 26.8594 234.57 26.8594 curveto
234.141 26.8594 233.781 26.7852 233.492 26.6367 curveto
233.113 26.4414 232.828 26.1602 232.633 25.7969 curveto
232.434 25.4336 232.336 25.0156 232.336 24.5469 curveto
232.336 24.1172 232.426 23.7188 232.602 23.35161 curveto
232.777 22.9805 233.039 22.6992 233.391 22.5039 curveto
233.738 22.3047 234.148 22.207 234.617 22.207 curveto
234.988 22.207 235.355 22.2773 235.719 22.418 curveto
236.078 22.5586 236.355 22.7188 236.543 22.9023 curveto
236.543 24.6953 lineto
234.586 24.6953 lineto
234.586 23.9375 lineto
 closepath fill
newpath 237.312 22.2812 moveto
238.176 22.2812 lineto
238.176 23.8672 lineto
238.176 24.1797 238.195 24.4023 238.242 24.53911 curveto
238.289 24.6719 238.363 24.7773 238.473 24.8477 curveto
238.578 24.9219 238.699 24.957 238.832 24.957 curveto
238.941 24.957 239.027 24.9336 239.094 24.8906 curveto
239.156 24.8438 239.203 24.77339 239.234 24.6836 curveto
239.266 24.5898 239.281 24.3867 239.281 24.0703 curveto
239.281 22.2812 lineto
240.145 22.2812 lineto
240.145 23.8477 lineto
240.145 24.1562 240.168 24.3789 240.215 24.52339 curveto
240.262 24.66411 240.34 24.77339 240.445 24.8477 curveto
240.551 24.918 240.664 24.957 240.785 24.957 curveto
240.949 24.957 241.074 24.8945 241.152 24.77339 curveto
241.215 24.6758 241.242 24.4688 241.242 24.1445 curveto
241.242 22.2812 lineto
242.105 22.2812 lineto
242.105 24.3672 lineto
242.105 24.6758 242.074 24.9023 242.016 25.043 curveto
241.934 25.2305 241.812 25.3711 241.645 25.4688 curveto
241.48 25.5664 241.277 25.6172 241.035 25.6172 curveto
240.848 25.6172 240.672 25.5742 240.508 25.4883 curveto
240.34 25.4023 240.188 25.2695 240.043 25.0977 curveto
239.945 25.2695 239.82 25.4023 239.664 25.4883 curveto
239.512 25.5742 239.332 25.6172 239.121 25.6172 curveto
238.73 25.6172 238.391 25.4414 238.105 25.0977 curveto
238.105 25.543 lineto
237.312 25.543 lineto
 closepath fill
newpath 243.73 22.2812 moveto
243.73 22.7617 lineto
243.859 22.582 244.016 22.4414 244.195 22.3477 curveto
244.379 22.2578 244.562 22.21089 244.746 22.21089 curveto
245.125 22.21089 245.449 22.3594 245.715 22.6602 curveto
245.977 22.96089 246.109 23.3906 246.109 23.9453 curveto
246.109 24.4844 245.98 24.89839 245.723 25.1836 curveto
245.461 25.4727 245.133 25.6172 244.734 25.6172 curveto
244.371 25.6172 244.055 25.4648 243.789 25.1602 curveto
243.988 24.7148 lineto
244.129 24.875 244.301 24.957 244.504 24.957 curveto
244.715 24.957 244.891 24.875 245.023 24.71089 curveto
245.16 24.543 245.227 24.2773 245.227 23.9023 curveto
245.227 23.5547 245.16 23.2969 245.023 23.1367 curveto
244.891 22.9727 244.73 22.8906 244.539 22.8906 curveto
244.293 22.8906 244.094 23.0078 243.945 23.2344 curveto
243.84 23.3945 243.785 23.6445 243.785 23.9844 curveto
243.785 24.3125 243.852 24.5547 243.988 24.7148 curveto
243.789 25.1602 lineto
243.789 26.7812 lineto
242.93 26.7812 lineto
242.93 22.2812 lineto
 closepath fill
newpath 247.723 22.2812 moveto
247.723 24.25 lineto
249.504 24.25 lineto
249.504 22.2812 lineto
250.41 22.2812 lineto
250.41 26.7812 lineto
249.504 26.7812 lineto
249.504 25.0117 lineto
247.723 25.0117 lineto
247.723 26.7812 lineto
246.812 26.7812 lineto
246.812 22.2812 lineto
 closepath fill
newpath 186.031 30.2812 moveto
186.031 31.6406 lineto
186.77 32.3945 lineto
188.008 30.2812 lineto
189.18 30.2812 lineto
187.395 33.0312 lineto
189.09 34.7812 lineto
187.867 34.7812 lineto
186.031 32.7852 lineto
186.031 34.7812 lineto
185.121 34.7812 lineto
185.121 30.2812 lineto
 closepath fill
newpath 190.508 34.7812 moveto
189.645 34.7812 lineto
189.645 30.2812 lineto
190.508 30.2812 lineto
 closepath fill
newpath 192.242 32.8672 moveto
192.328 32.9258 192.449 32.957 192.602 32.957 curveto
192.828 32.957 192.984 32.9219 193.066 32.85161 curveto
193.148 32.7812 193.188 32.6602 193.188 32.4961 curveto
193.188 32.4102 lineto
193.035 32.3438 192.754 32.27339 192.352 32.1992 curveto
192.051 32.1406 191.824 32.0742 191.664 31.9961 curveto
191.508 31.918 191.383 31.8086 191.297 31.66411 curveto
191.207 31.5195 191.164 31.3555 191.164 31.1719 curveto
191.164 30.8945 191.262 30.66411 191.453 30.4805 curveto
191.648 30.3008 191.91 30.21089 192.246 30.21089 curveto
192.438 30.21089 192.617 30.2461 192.785 30.3164 curveto
192.953 30.3867 193.109 30.4961 193.258 30.6406 curveto
192.949 30.9688 lineto
192.809 30.8672 192.66 30.8164 192.504 30.8164 curveto
192.367 30.8164 192.25 30.8594 192.16 30.9492 curveto
192.07 31.0352 192.027 31.1406 192.027 31.2617 curveto
192.027 31.3867 192.082 31.4844 192.195 31.5664 curveto
192.27 31.6133 192.426 31.66411 192.664 31.7148 curveto
192.902 31.7695 193.078 31.8125 193.188 31.8477 curveto
193.188 31.6758 lineto
193.188 31.4688 193.18 31.332 193.156 31.2578 curveto
193.121 31.1445 193.055 31.0469 192.949 30.9688 curveto
193.258 30.6406 lineto
193.262 30.6211 193.273 30.5898 193.285 30.53911 curveto
193.32 30.4258 193.348 30.3398 193.371 30.2812 curveto
194.223 30.2812 lineto
194.148 30.4375 194.098 30.58589 194.066 30.7188 curveto
194.039 30.8555 194.027 31.0664 194.027 31.3555 curveto
194.035 32.3594 lineto
194.035 32.7344 193.996 32.9922 193.922 33.1328 curveto
193.844 33.27339 193.711 33.3906 193.523 33.4805 curveto
193.336 33.5703 193.051 33.6172 192.664 33.6172 curveto
192.242 33.6172 191.922 33.53911 191.707 33.3906 curveto
191.492 33.2383 191.34 33.0039 191.254 32.6875 curveto
192.035 32.5469 lineto
192.09 32.6992 192.156 32.8047 192.242 32.8672 curveto
 closepath fill
newpath 197.832 30.2812 moveto
197.832 33.543 lineto
196.973 33.543 lineto
196.973 32.168 lineto
196.973 31.7031 196.949 31.4062 196.906 31.28911 curveto
196.863 31.168 196.781 31.0664 196.668 30.9883 curveto
196.551 30.9062 196.418 30.8672 196.27 30.8672 curveto
196.141 30.8672 196.035 30.8945 195.949 30.957 curveto
195.867 31.0156 195.809 31.0977 195.777 31.2031 curveto
195.746 31.3047 195.73 31.58589 195.73 32.043 curveto
195.73 33.543 lineto
194.867 33.543 lineto
194.867 31.4805 lineto
194.867 31.1719 194.906 30.9336 194.984 30.7578 curveto
195.062 30.58589 195.188 30.4492 195.363 30.3555 curveto
195.535 30.2578 195.73 30.21089 195.949 30.21089 curveto
196.164 30.21089 196.371 30.2617 196.562 30.3594 curveto
196.758 30.46089 196.914 30.5977 197.031 30.7695 curveto
197.031 30.2812 lineto
 closepath fill
newpath 198.93 30.4805 moveto
199.188 30.3008 199.539 30.21089 199.984 30.21089 curveto
200.473 30.21089 200.844 30.3164 201.094 30.5312 curveto
201.344 30.7461 201.469 31.0039 201.469 31.3008 curveto
201.469 31.5781 201.379 31.78911 201.195 31.9453 curveto
201.016 32.0938 200.695 32.2227 200.234 32.3281 curveto
199.773 32.4336 199.508 32.5117 199.43 32.5703 curveto
199.371 32.6133 199.344 32.66411 199.344 32.72661 curveto
199.344 32.7969 199.375 32.8555 199.441 32.9023 curveto
199.539 32.9648 199.703 32.9961 199.93 32.9961 curveto
200.109 32.9961 200.246 32.96089 200.344 32.8945 curveto
200.441 32.8281 200.508 32.7305 200.543 32.6055 curveto
201.355 32.7539 lineto
201.273 33.03911 201.125 33.2539 200.906 33.39839 curveto
200.691 33.543 200.359 33.6172 199.914 33.6172 curveto
199.445 33.6172 199.098 33.5195 198.875 33.3281 curveto
198.652 33.1367 198.543 32.89839 198.543 32.6172 curveto
198.543 32.3008 198.672 32.0586 198.93 31.8828 curveto
199.113 31.7539 199.555 31.6133 200.25 31.46089 curveto
200.402 31.4258 200.496 31.3906 200.539 31.3477 curveto
200.582 31.3047 200.602 31.25 200.602 31.1836 curveto
200.602 31.0898 200.562 31.0117 200.488 30.957 curveto
200.375 30.8711 200.207 30.832 199.984 30.832 curveto
199.781 30.832 199.625 30.875 199.512 30.9648 curveto
199.398 31.0508 199.324 31.1758 199.289 31.3438 curveto
198.422 31.2148 lineto
198.504 30.9023 198.672 30.6602 198.93 30.4805 curveto
 closepath fill
newpath 205.895 30.2812 moveto
205.895 34.0195 lineto
207.227 34.0195 lineto
207.227 34.7812 lineto
203.652 34.7812 lineto
203.652 34.0195 lineto
204.988 34.0195 lineto
204.988 30.2812 lineto
 closepath fill
newpath 207.547 30.4805 moveto
207.805 30.3008 208.156 30.21089 208.602 30.21089 curveto
209.09 30.21089 209.457 30.3164 209.707 30.5312 curveto
209.957 30.7461 210.082 31.0039 210.082 31.3008 curveto
210.082 31.5781 209.992 31.78911 209.812 31.9453 curveto
209.629 32.0938 209.309 32.2227 208.848 32.3281 curveto
208.391 32.4336 208.121 32.5117 208.043 32.5703 curveto
207.984 32.6133 207.957 32.66411 207.957 32.72661 curveto
207.957 32.7969 207.988 32.8555 208.055 32.9023 curveto
208.152 32.9648 208.316 32.9961 208.543 32.9961 curveto
208.723 32.9961 208.863 32.96089 208.961 32.8945 curveto
209.059 32.8281 209.121 32.7305 209.156 32.6055 curveto
209.973 32.7539 lineto
209.891 33.03911 209.738 33.2539 209.523 33.39839 curveto
209.305 33.543 208.977 33.6172 208.527 33.6172 curveto
208.059 33.6172 207.715 33.5195 207.492 33.3281 curveto
207.27 33.1367 207.156 32.89839 207.156 32.6172 curveto
207.156 32.3008 207.285 32.0586 207.543 31.8828 curveto
207.73 31.7539 208.172 31.6133 208.867 31.46089 curveto
209.016 31.4258 209.113 31.3906 209.156 31.3477 curveto
209.195 31.3047 209.215 31.25 209.215 31.1836 curveto
209.215 31.0898 209.18 31.0117 209.102 30.957 curveto
208.988 30.8711 208.82 30.832 208.602 30.832 curveto
208.398 30.832 208.238 30.875 208.129 30.9648 curveto
208.016 31.0508 207.941 31.1758 207.902 31.3438 curveto
207.035 31.2148 lineto
207.117 30.9023 207.285 30.6602 207.547 30.4805 curveto
 closepath fill
newpath 213.176 33.3594 moveto
212.941 33.5312 212.625 33.6172 212.227 33.6172 curveto
211.742 33.6172 211.355 33.4648 211.074 33.16411 curveto
210.789 32.8672 210.645 32.4492 210.645 31.9102 curveto
210.645 31.3789 210.789 30.96089 211.07 30.6602 curveto
211.355 30.3594 211.734 30.21089 212.211 30.21089 curveto
212.633 30.21089 212.965 30.3086 213.215 30.5078 curveto
213.465 30.707 213.633 31 213.723 31.3867 curveto
212.875 31.5312 lineto
212.832 31.3047 212.758 31.1445 212.652 31.0508 curveto
212.551 30.957 212.414 30.9102 212.254 30.9102 curveto
212.031 30.9102 211.859 30.9922 211.727 31.1523 curveto
211.598 31.3125 211.531 31.58589 211.531 31.9727 curveto
211.531 32.3203 211.598 32.5664 211.727 32.7148 curveto
211.852 32.8633 212.023 32.9375 212.238 32.9375 curveto
212.402 32.9375 212.531 32.8945 212.633 32.8086 curveto
212.734 32.7227 212.801 32.5938 212.828 32.4258 curveto
213.68 32.5781 lineto
213.578 32.9297 213.406 33.1875 213.176 33.3594 curveto
 closepath fill
newpath 214.328 34.7812 moveto
214.328 30.2812 lineto
215.191 30.2812 lineto
215.191 31.91411 lineto
215.191 32.1914 215.219 32.39839 215.27 32.5352 curveto
215.32 32.6758 215.406 32.7812 215.516 32.85161 curveto
215.629 32.9219 215.758 32.957 215.902 32.957 curveto
216.027 32.957 216.129 32.9297 216.215 32.875 curveto
216.297 32.8203 216.352 32.7461 216.387 32.6562 curveto
216.418 32.5625 216.434 32.3477 216.434 32.0039 curveto
216.434 30.2812 lineto
217.297 30.2812 lineto
217.297 32.1953 lineto
217.297 32.4883 217.281 32.7031 217.254 32.8438 curveto
217.223 32.9805 217.168 33.1094 217.086 33.2227 curveto
217.008 33.3398 216.887 33.4336 216.727 33.5078 curveto
216.566 33.582 216.387 33.6172 216.188 33.6172 curveto
215.805 33.6172 215.469 33.4531 215.191 33.1289 curveto
215.191 34.7812 lineto
 closepath fill
newpath 219.035 34.7812 moveto
218.172 34.7812 lineto
218.172 33.9844 lineto
219.035 33.9844 lineto
 closepath fill
newpath 219.035 33.543 moveto
218.172 33.543 lineto
218.172 30.2812 lineto
219.035 30.2812 lineto
 closepath fill
newpath 220.742 31.28911 moveto
220.742 31.8438 220.77 32.207 220.816 32.3828 curveto
220.863 32.5547 220.93 32.6758 221.016 32.7422 curveto
221.098 32.8086 221.199 32.8438 221.32 32.8438 curveto
221.445 32.8438 221.582 32.7969 221.727 32.7031 curveto
221.992 33.4531 lineto
221.812 33.5625 221.621 33.6172 221.426 33.6172 curveto
221.285 33.6172 221.16 33.582 221.055 33.5117 curveto
220.941 33.4414 220.82 33.2969 220.684 33.0781 curveto
220.684 33.543 lineto
219.883 33.543 lineto
219.883 30.2812 lineto
220.742 30.2812 lineto
 closepath fill
newpath 223.219 32.8672 moveto
223.305 32.9258 223.422 32.957 223.578 32.957 curveto
223.805 32.957 223.957 32.9219 224.039 32.85161 curveto
224.121 32.7812 224.164 32.6602 224.164 32.4961 curveto
224.164 32.4102 lineto
224.008 32.3438 223.73 32.27339 223.324 32.1992 curveto
223.027 32.1406 222.797 32.0742 222.641 31.9961 curveto
222.48 31.918 222.355 31.8086 222.27 31.66411 curveto
222.184 31.5195 222.137 31.3555 222.137 31.1719 curveto
222.137 30.8945 222.234 30.66411 222.426 30.4805 curveto
222.621 30.3008 222.887 30.21089 223.223 30.21089 curveto
223.41 30.21089 223.59 30.2461 223.758 30.3164 curveto
223.926 30.3867 224.082 30.4961 224.23 30.6406 curveto
223.926 30.9688 lineto
223.781 30.8672 223.633 30.8164 223.48 30.8164 curveto
223.34 30.8164 223.227 30.8594 223.137 30.9492 curveto
223.047 31.0352 223 31.1406 223 31.2617 curveto
223 31.3867 223.055 31.4844 223.168 31.5664 curveto
223.242 31.6133 223.398 31.66411 223.637 31.7148 curveto
223.879 31.7695 224.055 31.8125 224.164 31.8477 curveto
224.164 31.6758 lineto
224.164 31.4688 224.152 31.332 224.129 31.2578 curveto
224.098 31.1445 224.027 31.0469 223.926 30.9688 curveto
224.23 30.6406 lineto
224.238 30.6211 224.246 30.5898 224.262 30.53911 curveto
224.293 30.4258 224.32 30.3398 224.344 30.2812 curveto
225.199 30.2812 lineto
225.121 30.4375 225.07 30.58589 225.043 30.7188 curveto
225.016 30.8555 225 31.0664 225 31.3555 curveto
225.012 32.3594 lineto
225.012 32.7344 224.973 32.9922 224.895 33.1328 curveto
224.816 33.27339 224.688 33.3906 224.496 33.4805 curveto
224.309 33.5703 224.023 33.6172 223.637 33.6172 curveto
223.215 33.6172 222.895 33.53911 222.68 33.3906 curveto
222.465 33.2383 222.312 33.0039 222.227 32.6875 curveto
223.008 32.5469 lineto
223.062 32.6992 223.133 32.8047 223.219 32.8672 curveto
 closepath fill
newpath 227.93 30.5977 moveto
228.234 30.33589 228.672 30.2031 229.238 30.2031 curveto
229.629 30.2031 229.957 30.2578 230.219 30.3672 curveto
230.48 30.47661 230.684 30.6445 230.824 30.8672 curveto
230.969 31.0938 231.039 31.33589 231.039 31.5938 curveto
231.039 31.8789 230.98 32.1172 230.863 32.3086 curveto
230.742 32.5039 230.574 32.6562 230.363 32.7695 curveto
230.152 32.8789 229.824 32.9883 229.383 33.0938 curveto
228.941 33.1953 228.664 33.2969 228.551 33.3906 curveto
228.461 33.4688 228.414 33.5586 228.414 33.66411 curveto
228.414 33.7812 228.461 33.875 228.559 33.9453 curveto
228.707 34.0547 228.914 34.1055 229.18 34.1055 curveto
229.434 34.1055 229.625 34.0586 229.754 33.957 curveto
229.883 33.8555 229.965 33.6875 230.004 33.457 curveto
230.91 33.4961 lineto
230.898 33.9102 230.746 34.2383 230.465 34.4883 curveto
230.176 34.7344 229.754 34.8594 229.188 34.8594 curveto
228.844 34.8594 228.547 34.8086 228.301 34.7031 curveto
228.059 34.5977 227.871 34.4453 227.738 34.2461 curveto
227.609 34.0469 227.547 33.832 227.547 33.6055 curveto
227.547 33.2461 227.684 32.9453 227.961 32.6992 curveto
228.156 32.52339 228.496 32.375 228.984 32.2539 curveto
229.363 32.1602 229.605 32.0938 229.711 32.0586 curveto
229.867 32.0039 229.977 31.9375 230.039 31.8633 curveto
230.102 31.78911 230.133 31.6953 230.133 31.5898 curveto
230.133 31.4258 230.059 31.2812 229.91 31.1562 curveto
229.762 31.0312 229.539 30.9688 229.246 30.9688 curveto
228.973 30.9688 228.754 31.03911 228.59 31.1797 curveto
228.43 31.3164 228.32 31.5352 228.266 31.832 curveto
227.383 31.7461 lineto
227.441 31.2422 227.625 30.8594 227.93 30.5977 curveto
 closepath fill
newpath 232.703 33.543 moveto
232.703 34.6914 lineto
231.84 34.1914 lineto
231.84 33.543 lineto
231.441 33.543 lineto
231.441 32.8555 lineto
231.84 32.8555 lineto
231.84 31.4336 lineto
231.84 31.1289 231.848 30.9258 231.867 30.8281 curveto
231.891 30.6836 231.93 30.5742 231.988 30.4883 curveto
232.047 30.4062 232.137 30.3398 232.262 30.28911 curveto
232.387 30.2344 232.527 30.21089 232.684 30.21089 curveto
232.938 30.21089 233.164 30.2539 233.363 30.3398 curveto
233.289 31.0078 lineto
233.141 30.9531 233.023 30.9258 232.945 30.9258 curveto
232.887 30.9258 232.84 30.9375 232.797 30.9688 curveto
232.758 30.9961 232.73 31.0312 232.723 31.0781 curveto
232.711 31.1211 232.703 31.2773 232.703 31.53911 curveto
232.703 32.8555 lineto
233.293 32.8555 lineto
233.293 33.543 lineto
 closepath fill
newpath 234.754 34.7812 moveto
233.895 34.7812 lineto
233.895 33.9844 lineto
234.754 33.9844 lineto
 closepath fill
newpath 234.754 33.543 moveto
233.895 33.543 lineto
233.895 30.2812 lineto
234.754 30.2812 lineto
 closepath fill
newpath 235.262 32.8633 moveto
235.738 32.8633 lineto
235.738 30.2812 lineto
236.602 30.2812 lineto
236.602 32.8633 lineto
237.246 32.8633 lineto
237.246 33.543 lineto
236.602 33.543 lineto
236.602 33.77339 lineto
236.602 33.9375 236.629 34.0508 236.684 34.1094 curveto
236.738 34.168 236.828 34.1953 236.953 34.1953 curveto
237.078 34.1953 237.211 34.1797 237.348 34.14839 curveto
237.465 34.75 lineto
237.23 34.8203 236.988 34.8594 236.742 34.8594 curveto
236.504 34.8594 236.305 34.8164 236.148 34.7305 curveto
235.992 34.64839 235.887 34.5352 235.828 34.4023 curveto
235.77 34.2656 235.738 34.0625 235.738 33.78911 curveto
235.738 33.543 lineto
235.262 33.543 lineto
 closepath fill
newpath 238.637 33.543 moveto
238.637 34.6914 lineto
237.773 34.1914 lineto
237.773 33.543 lineto
237.375 33.543 lineto
237.375 32.8555 lineto
237.773 32.8555 lineto
237.773 31.4336 lineto
237.773 31.1289 237.781 30.9258 237.801 30.8281 curveto
237.82 30.6836 237.863 30.5742 237.922 30.4883 curveto
237.98 30.4062 238.07 30.3398 238.195 30.28911 curveto
238.32 30.2344 238.461 30.21089 238.617 30.21089 curveto
238.867 30.21089 239.098 30.2539 239.297 30.3398 curveto
239.223 31.0078 lineto
239.07 30.9531 238.957 30.9258 238.875 30.9258 curveto
238.82 30.9258 238.77 30.9375 238.73 30.9688 curveto
238.691 30.9961 238.664 31.0312 238.652 31.0781 curveto
238.645 31.1211 238.637 31.2773 238.637 31.53911 curveto
238.637 32.8555 lineto
239.227 32.8555 lineto
239.227 33.543 lineto
 closepath fill
newpath 242.77 30.2812 moveto
242.77 33.543 lineto
241.91 33.543 lineto
241.91 32.168 lineto
241.91 31.7031 241.887 31.4062 241.844 31.28911 curveto
241.801 31.168 241.723 31.0664 241.605 30.9883 curveto
241.488 30.9062 241.355 30.8672 241.211 30.8672 curveto
241.078 30.8672 240.973 30.8945 240.891 30.957 curveto
240.805 31.0156 240.746 31.0977 240.715 31.2031 curveto
240.684 31.3047 240.668 31.58589 240.668 32.043 curveto
240.668 33.543 lineto
239.809 33.543 lineto
239.809 31.4805 lineto
239.809 31.1719 239.844 30.9336 239.922 30.7578 curveto
240 30.58589 240.129 30.4492 240.301 30.3555 curveto
240.477 30.2578 240.672 30.21089 240.891 30.21089 curveto
241.105 30.21089 241.309 30.2617 241.504 30.3594 curveto
241.695 30.46089 241.852 30.5977 241.973 30.7695 curveto
241.973 30.2812 lineto
 closepath fill
newpath 246.629 32.3086 moveto
246.629 32.5586 246.613 32.7539 246.582 32.8906 curveto
246.551 33.02339 246.492 33.1445 246.414 33.25 curveto
246.332 33.3555 246.215 33.4453 246.055 33.5117 curveto
245.898 33.582 245.723 33.6172 245.531 33.6172 curveto
245.102 33.6172 244.742 33.4336 244.461 33.0625 curveto
244.461 33.543 lineto
243.656 33.543 lineto
243.656 30.2812 lineto
244.52 30.2812 lineto
244.52 31.7578 lineto
244.52 32.125 244.543 32.3711 244.586 32.5078 curveto
244.629 32.6445 244.711 32.7539 244.828 32.832 curveto
244.949 32.91411 245.086 32.957 245.234 32.957 curveto
245.348 32.957 245.449 32.9297 245.531 32.8711 curveto
245.613 32.8125 245.676 32.7344 245.711 32.6289 curveto
245.746 32.5273 245.766 32.2969 245.766 31.9453 curveto
245.766 30.2812 lineto
246.629 30.2812 lineto
 closepath fill
newpath 247.422 29.9648 moveto
247.422 29.6719 247.535 29.4336 247.77 29.2422 curveto
248 29.0547 248.391 28.96089 248.945 28.96089 curveto
249.234 28.96089 249.477 28.9922 249.668 29.0508 curveto
249.859 29.1133 250.012 29.1992 250.129 29.3086 curveto
250.242 29.41411 250.332 29.5664 250.395 29.7539 curveto
250.457 29.9453 250.488 30.2344 250.488 30.6172 curveto
250.488 33.543 lineto
249.684 33.543 lineto
249.684 33.08589 lineto
249.434 32.71089 lineto
249.574 32.5469 249.645 32.2969 249.645 31.96089 curveto
249.645 31.6367 249.57 31.3906 249.426 31.22661 curveto
249.281 31.0625 249.102 30.9805 248.891 30.9805 curveto
248.695 30.9805 248.527 31.0586 248.395 31.2227 curveto
248.262 31.3828 248.195 31.6328 248.195 31.9805 curveto
248.195 32.3086 248.262 32.5547 248.395 32.7148 curveto
248.395 32.7148 lineto
248.527 32.875 248.699 32.957 248.906 32.957 curveto
249.121 32.957 249.297 32.875 249.434 32.71089 curveto
249.684 33.08589 lineto
249.422 33.4375 249.09 33.6172 248.688 33.6172 curveto
248.297 33.6172 247.969 33.4727 247.703 33.1836 curveto
247.441 32.8945 247.309 32.47661 247.309 31.9297 curveto
247.309 31.4961 247.41 31.1328 247.613 30.8398 curveto
247.867 30.4688 248.215 30.2812 248.652 30.2812 curveto
249.047 30.2812 249.371 30.46089 249.629 30.8125 curveto
249.629 30.33589 lineto
249.629 30.1445 249.613 30.0117 249.59 29.9375 curveto
249.551 29.8398 249.492 29.7656 249.414 29.7227 curveto
249.305 29.6523 249.133 29.6211 248.91 29.6211 curveto
248.734 29.6211 248.605 29.6523 248.523 29.71089 curveto
248.465 29.7539 248.426 29.83589 248.41 29.9492 curveto
247.426 30.0664 lineto
247.422 30.0273 247.422 29.9922 247.422 29.9648 curveto
 closepath fill
newpath 288.797 15.3906 moveto
288.797 16.7344 lineto
289.52301 17.4805 lineto
290.746 15.3906 lineto
291.91 15.3906 lineto
290.14499 18.1094 lineto
291.82 19.8438 lineto
290.60901 19.8438 lineto
288.797 17.8672 lineto
288.797 19.8438 lineto
287.89499 19.8438 lineto
287.89499 15.3906 lineto
 closepath fill
newpath 294.65201 15.3906 moveto
294.65201 19.0898 lineto
295.97299 19.0898 lineto
295.97299 19.8438 lineto
292.43 19.8438 lineto
292.43 19.0898 lineto
293.754 19.0898 lineto
293.754 15.3906 lineto
 closepath fill
newpath 297.238 15.6992 moveto
297.539 15.4414 297.97299 15.3086 298.535 15.3086 curveto
298.922 15.3086 299.246 15.3633 299.504 15.4727 curveto
299.76599 15.582 299.965 15.7461 300.10501 15.9688 curveto
300.246 16.1914 300.32 16.4297 300.32 16.6875 curveto
300.32 16.9688 300.262 17.2031 300.14099 17.3945 curveto
300.02301 17.58589 299.85901 17.7383 299.64801 17.8477 curveto
299.43799 17.96089 299.117 18.0664 298.68 18.168 curveto
298.242 18.27339 297.965 18.3711 297.85199 18.4688 curveto
297.762 18.543 297.719 18.6328 297.719 18.7383 curveto
297.719 18.85161 297.76599 18.9453 297.85901 19.0156 curveto
298.008 19.1211 298.215 19.1758 298.47299 19.1758 curveto
298.73001 19.1758 298.918 19.125 299.047 19.02339 curveto
299.172 18.9219 299.254 18.7617 299.293 18.5312 curveto
300.19101 18.5703 lineto
300.176 18.9805 300.02701 19.3086 299.746 19.5508 curveto
299.465 19.7969 299.043 19.918 298.48401 19.918 curveto
298.14099 19.918 297.84799 19.8672 297.60501 19.7656 curveto
297.363 19.6602 297.18 19.5117 297.051 19.3125 curveto
296.922 19.1172 296.85901 18.9023 296.85901 18.6758 curveto
296.85901 18.3242 296.996 18.0273 297.26999 17.7812 curveto
297.461 17.6055 297.801 17.46089 298.285 17.3398 curveto
298.66 17.2461 298.89801 17.1836 299.004 17.1445 curveto
299.156 17.0898 299.26599 17.0273 299.328 16.9531 curveto
299.39099 16.8789 299.422 16.78911 299.422 16.6836 curveto
299.422 16.5195 299.34799 16.375 299.199 16.2539 curveto
299.051 16.1328 298.836 16.0703 298.547 16.0703 curveto
298.26999 16.0703 298.055 16.1406 297.89499 16.2773 curveto
297.73001 16.41411 297.625 16.6289 297.57 16.9219 curveto
296.695 16.8398 lineto
296.758 16.3398 296.93799 15.9609 297.238 15.6992 curveto
 closepath fill
 0.651 0.663 0.667 setrgbcolor
newpath 272.496 22.2305 moveto
285.55899 22.2305 lineto
285.55899 35.2188 lineto
272.496 35.2188 lineto
 closepath fill
 0.137 0.122 0.125 setrgbcolor
newpath 265.77301 15.75 moveto
271.883 21.8203 lineto
271.80899 21.9375 271.76599 22.0781 271.76599 22.2305 curveto
271.76599 22.6445 272.094 22.9805 272.496 22.9805 curveto
272.65201 22.9805 272.797 22.9297 272.914 22.8477 curveto
275.56201 25.4805 lineto
272.945 28.1094 lineto
272.82 28.0117 272.668 27.957 272.5 27.957 curveto
272.094 27.957 271.76599 28.28911 271.76599 28.707 curveto
271.76599 28.8711 271.82 29.0273 271.91 29.1523 curveto
265.738 35.3555 lineto
271.781 35.3555 lineto
271.844 35.7031 272.14499 35.9688 272.504 35.9688 curveto
272.863 35.9688 273.16 35.7031 273.22299 35.3555 curveto
278.258 35.3555 lineto
278.32 35.707 278.621 35.9727 278.98001 35.9727 curveto
279.34 35.9727 279.64099 35.707 279.699 35.3555 curveto
284.84 35.3555 lineto
284.90201 35.7031 285.203 35.9688 285.56201 35.9688 curveto
285.965 35.9688 286.293 35.6328 286.293 35.2188 curveto
286.293 34.8477 286.035 34.543 285.69101 34.4805 curveto
285.69101 29.4492 lineto
286.035 29.3867 286.297 29.0781 286.297 28.707 curveto
286.297 28.33589 286.035 28.0312 285.69101 27.9688 curveto
285.69101 22.9648 lineto
286.031 22.89839 286.289 22.5938 286.289 22.2227 curveto
286.289 21.8555 286.031 21.5508 285.69101 21.4844 curveto
285.69101 15.3008 lineto
279.406 21.6133 lineto
279.289 21.5273 279.14099 21.47661 278.98401 21.47661 curveto
278.578 21.47661 278.25 21.8125 278.25 22.22661 curveto
278.25 22.3828 278.297 22.5312 278.379 22.6523 curveto
275.754 25.28911 lineto
275.94101 25.47661 lineto
275.754 25.668 lineto
278.383 28.2812 lineto
278.297 28.4023 278.246 28.5508 278.246 28.71089 curveto
278.246 29.125 278.574 29.46089 278.98001 29.46089 curveto
279.14499 29.46089 279.297 29.4062 279.422 29.3125 curveto
284.949 34.8047 lineto
284.89499 34.8906 284.85901 34.9844 284.84 35.08589 curveto
279.699 35.08589 lineto
279.64099 34.7344 279.34 34.4688 278.98001 34.4688 curveto
278.621 34.4688 278.32 34.7344 278.258 35.08589 curveto
273.22299 35.08589 lineto
273.164 34.7344 272.863 34.4688 272.504 34.4688 curveto
272.14099 34.4688 271.844 34.7344 271.781 35.08589 curveto
266.387 35.08589 lineto
272.10501 29.33589 lineto
272.219 29.4102 272.35501 29.457 272.5 29.457 curveto
272.90201 29.457 273.23001 29.1211 273.23001 28.707 curveto
273.23001 28.5625 273.19101 28.4258 273.125 28.3125 curveto
275.754 25.668 lineto
275.94101 25.47661 lineto
278.56601 22.8438 lineto
278.68399 22.9258 278.828 22.97661 278.98401 22.97661 curveto
279.387 22.97661 279.715 22.6406 279.715 22.22661 curveto
279.715 22.0742 279.672 21.9297 279.594 21.8086 curveto
285.422 15.9492 lineto
285.422 21.4883 lineto
285.082 21.5547 284.824 21.8594 284.824 22.2227 curveto
284.824 22.5898 285.082 22.8945 285.422 22.96089 curveto
285.422 27.9727 lineto
285.086 28.03911 284.832 28.3438 284.832 28.707 curveto
284.832 29.0742 285.086 29.375 285.422 29.4453 curveto
285.422 34.4805 lineto
285.31601 34.5039 285.219 34.5469 285.133 34.6094 curveto
279.60199 29.1133 lineto
279.672 28.9961 279.715 28.8594 279.715 28.71089 curveto
279.715 28.2969 279.387 27.96089 278.98001 27.96089 curveto
278.828 27.96089 278.68799 28.0078 278.57 28.0898 curveto
275.94101 25.47661 lineto
275.754 25.28911 lineto
273.10199 22.6562 lineto
273.18399 22.5312 273.23001 22.3867 273.23001 22.2305 curveto
273.23001 21.8164 272.90201 21.4805 272.496 21.4805 curveto
272.336 21.4805 272.18399 21.5312 272.06201 21.625 curveto
266.15201 15.75 lineto
 closepath fill
newpath 258.328 7.625 moveto
258.754 7.625 lineto
258.754 43.22661 lineto
258.328 43.22661 lineto
 closepath fill
 0.337 0.345 0.361 setrgbcolor
newpath 105.402 13.4492 moveto
105.402 10.2461 lineto
107.285 10.2461 lineto
107.285 10.6406 lineto
105.84 10.6406 lineto
105.84 13.4492 lineto
 closepath fill
newpath 110.30899 11.375 moveto
108.621 11.375 lineto
108.633 11.6797 lineto
109.93 11.6797 lineto
109.93 11.8438 109.879 11.9844 109.77301 12.0977 curveto
109.65599 12.2188 109.5 12.2812 109.30101 12.2812 curveto
109.30101 12.2812 lineto
109.117 12.2812 108.961 12.2227 108.836 12.1016 curveto
108.71901 11.9883 108.64801 11.8477 108.633 11.6797 curveto
108.621 11.375 lineto
108.621 11.1016 108.69899 10.8945 108.848 10.7461 curveto
108.98 10.6172 109.14801 10.5508 109.359 10.5508 curveto
109.598 10.5508 109.793 10.6211 109.953 10.7617 curveto
110.129 10.4609 lineto
110.062 10.3984 109.965 10.3398 109.832 10.2969 curveto
109.668 10.2344 109.48 10.2031 109.277 10.2031 curveto
108.984 10.2031 108.734 10.3008 108.527 10.5039 curveto
108.30101 10.7227 108.18399 11.0195 108.18399 11.3906 curveto
108.18399 11.7773 108.305 12.0859 108.535 12.3203 curveto
108.746 12.5273 108.996 12.6328 109.28099 12.6328 curveto
109.617 12.6328 109.879 12.5391 110.06601 12.3477 curveto
110.25 12.168 110.34401 11.9297 110.34401 11.6289 curveto
110.34401 11.5391 110.332 11.4531 110.30899 11.375 curveto
 closepath fill
newpath 111.91 13.4727 moveto
111.98 13.4727 112.043 13.4492 112.09401 13.3984 curveto
112.145 13.3477 112.168 13.2852 112.168 13.2148 curveto
112.168 13.1445 112.145 13.0859 112.09401 13.0352 curveto
112.043 12.9844 111.98 12.9609 111.91 12.9609 curveto
111.84 12.9609 111.78099 12.9844 111.73 13.0352 curveto
111.68 13.0859 111.652 13.1445 111.652 13.2148 curveto
111.652 13.2891 111.68 13.3477 111.73 13.3984 curveto
111.777 13.4492 111.84 13.4727 111.91 13.4727 curveto
 closepath fill
newpath 111.68399 10.2461 moveto
111.68399 12.2383 lineto
111.363 12.2383 lineto
111.363 12.5859 lineto
112.098 12.5859 lineto
112.098 10.2461 lineto
 closepath fill
newpath 113.812 10.4141 moveto
113.668 10.2031 lineto
113.461 10.2031 lineto
113.461 13.5469 lineto
113.875 13.5469 lineto
113.875 12.4141 lineto
114.055 12.2148 lineto
113.961 12.1719 113.902 12.1328 113.875 12.0977 curveto
113.875 12.0977 lineto
113.875 10.7461 lineto
113.875 10.7227 113.92601 10.6875 114.03099 10.6328 curveto
114.133 10.582 114.211 10.5508 114.266 10.5508 curveto
114.55101 10.5508 114.75 10.6211 114.871 10.7578 curveto
114.996 10.8906 115.05899 11.1172 115.05899 11.4375 curveto
115.05899 11.7031 114.984 11.9102 114.84401 12.0586 curveto
114.69899 12.207 114.508 12.2812 114.266 12.2812 curveto
114.215 12.2812 114.145 12.2617 114.055 12.2148 curveto
113.875 12.4141 lineto
113.914 12.4688 113.988 12.5195 114.098 12.5625 curveto
114.203 12.6094 114.312 12.6328 114.418 12.6328 curveto
114.738 12.6328 114.996 12.5195 115.195 12.2969 curveto
115.395 12.0781 115.492 11.7969 115.492 11.4609 curveto
115.492 11.0703 115.395 10.7617 115.195 10.5391 curveto
114.996 10.3164 114.72699 10.2031 114.383 10.2031 curveto
114.27301 10.2031 114.164 10.2227 114.05899 10.2656 curveto
113.94899 10.3086 113.867 10.3555 113.812 10.4141 curveto
 closepath fill
newpath 118.098 10.2461 moveto
118.098 11.6094 lineto
118.098 11.8555 118.05899 12.0312 117.984 12.1328 curveto
117.90599 12.2305 117.78099 12.2812 117.605 12.2812 curveto
117.512 12.2812 117.414 12.2539 117.30899 12.1953 curveto
117.207 12.1406 117.129 12.0703 117.07 11.9844 curveto
117.07 10.2461 lineto
116.65599 10.2461 lineto
116.65599 12.5859 lineto
116.94101 12.5859 lineto
117.07 12.2852 lineto
117.207 12.5156 117.43399 12.6328 117.742 12.6328 curveto
118.254 12.6328 118.512 12.3203 118.512 11.6953 curveto
118.512 10.2461 lineto
 closepath fill
newpath 120.23 13.4727 moveto
120.305 13.4727 120.363 13.4492 120.414 13.3984 curveto
120.465 13.3477 120.488 13.2852 120.488 13.2148 curveto
120.488 13.1445 120.465 13.0859 120.414 13.0352 curveto
120.363 12.9844 120.305 12.9609 120.23 12.9609 curveto
120.16 12.9609 120.10199 12.9844 120.05101 13.0352 curveto
120.004 13.0859 119.97699 13.1445 119.97699 13.2148 curveto
119.97699 13.2891 120 13.3477 120.05101 13.3984 curveto
120.10199 13.4492 120.16 13.4727 120.23 13.4727 curveto
 closepath fill
newpath 120.004 10.2461 moveto
120.004 12.2383 lineto
119.68399 12.2383 lineto
119.68399 12.5859 lineto
120.422 12.5859 lineto
120.422 10.2461 lineto
 closepath fill
newpath 122.22699 10.6172 moveto
123.52301 10.6172 lineto
123.52301 10.2461 lineto
121.57399 10.2461 lineto
121.57399 10.3555 lineto
122.90599 12.2148 lineto
121.598 12.2148 lineto
121.598 12.5859 lineto
123.512 12.5859 lineto
123.512 12.4688 lineto
 closepath fill
newpath 128.512 10.2461 moveto
128.289 10.9219 lineto
127.098 10.9219 lineto
127.215 11.2422 lineto
128.164 11.2422 lineto
127.711 12.6523 lineto
127.215 11.2422 lineto
127.098 10.9219 lineto
126.863 10.2461 lineto
126.371 10.2461 lineto
127.672 13.4922 lineto
127.789 13.4922 lineto
128.996 10.2461 lineto
 closepath fill
newpath 129.848 10.3867 moveto
129.996 10.7812 lineto
130.227 10.6289 130.414 10.5508 130.555 10.5508 curveto
130.812 10.5508 130.938 10.6602 130.938 10.8789 curveto
130.938 11.0312 130.816 11.1641 130.566 11.2734 curveto
130.379 11.3633 130.25 11.4258 130.184 11.4727 curveto
130.117 11.5195 130.059 11.5703 130.012 11.6289 curveto
129.961 11.6836 129.926 11.7461 129.898 11.8125 curveto
129.879 11.875 129.863 11.9453 129.863 12.0195 curveto
129.863 12.2109 129.934 12.3594 130.074 12.4688 curveto
130.215 12.5781 130.398 12.6328 130.621 12.6328 curveto
130.793 12.6328 131.008 12.5781 131.266 12.4688 curveto
131.148 12.0859 lineto
130.984 12.2148 130.82 12.2812 130.652 12.2812 curveto
130.555 12.2812 130.473 12.2578 130.402 12.2109 curveto
130.336 12.1641 130.301 12.1055 130.301 12.0352 curveto
130.301 11.8867 130.387 11.7695 130.559 11.6953 curveto
130.855 11.5586 lineto
131.035 11.4766 131.168 11.3789 131.254 11.2734 curveto
131.336 11.168 131.379 11.0352 131.379 10.875 curveto
131.379 10.6641 131.305 10.5 131.156 10.3828 curveto
131.008 10.2617 130.805 10.2031 130.543 10.2031 curveto
130.297 10.2031 130.066 10.2656 129.848 10.3867 curveto
 closepath fill
newpath 132.363 10.3867 moveto
132.508 10.7812 lineto
132.742 10.6289 132.93 10.5508 133.07 10.5508 curveto
133.324 10.5508 133.453 10.6602 133.453 10.8789 curveto
133.453 11.0312 133.328 11.1641 133.082 11.2734 curveto
132.891 11.3633 132.762 11.4258 132.695 11.4727 curveto
132.629 11.5195 132.574 11.5703 132.523 11.6289 curveto
132.477 11.6836 132.438 11.7461 132.414 11.8125 curveto
132.391 11.875 132.379 11.9453 132.379 12.0195 curveto
132.379 12.2109 132.449 12.3594 132.59 12.4688 curveto
132.727 12.5781 132.91 12.6328 133.137 12.6328 curveto
133.309 12.6328 133.523 12.5781 133.781 12.4688 curveto
133.664 12.0859 lineto
133.5 12.2148 133.332 12.2812 133.168 12.2812 curveto
133.066 12.2812 132.984 12.2578 132.918 12.2109 curveto
132.848 12.1641 132.816 12.1055 132.816 12.0352 curveto
132.816 11.8867 132.898 11.7695 133.07 11.6953 curveto
133.367 11.5586 lineto
133.551 11.4766 133.684 11.3789 133.766 11.2734 curveto
133.848 11.168 133.891 11.0352 133.891 10.875 curveto
133.891 10.6641 133.816 10.5 133.672 10.3828 curveto
133.523 10.2617 133.316 10.2031 133.059 10.2031 curveto
132.812 10.2031 132.578 10.2656 132.363 10.3867 curveto
 closepath fill
newpath 134.879 11.4219 moveto
134.879 11.7852 134.973 12.0742 135.168 12.2969 curveto
135.363 12.5195 135.617 12.6289 135.938 12.6289 curveto
135.938 12.293 lineto
135.746 12.293 135.598 12.2148 135.484 12.0586 curveto
135.371 11.9062 135.312 11.6953 135.312 11.4219 curveto
135.312 11.4219 lineto
135.312 10.8359 135.523 10.543 135.938 10.543 curveto
136.129 10.543 136.281 10.6211 136.395 10.7773 curveto
136.504 10.9336 136.559 11.1523 136.559 11.4219 curveto
136.559 12.0039 136.352 12.293 135.938 12.293 curveto
135.938 12.6289 lineto
136.273 12.6289 136.531 12.5234 136.719 12.3086 curveto
136.902 12.0977 136.996 11.8008 136.996 11.4219 curveto
136.996 11.0469 136.898 10.7461 136.711 10.5312 curveto
136.52 10.3125 136.262 10.2031 135.938 10.2031 curveto
135.602 10.2031 135.344 10.3125 135.156 10.5352 curveto
134.969 10.7539 134.879 11.0508 134.879 11.4219 curveto
 closepath fill
newpath 139.898 12.3984 moveto
139.695 12.1055 lineto
139.652 12.1484 139.578 12.1875 139.469 12.2227 curveto
139.363 12.2617 139.258 12.2812 139.152 12.2812 curveto
138.93 12.2812 138.75 12.2031 138.617 12.043 curveto
138.484 11.8867 138.418 11.668 138.418 11.3945 curveto
138.418 11.1211 138.484 10.9102 138.621 10.7695 curveto
138.758 10.625 138.945 10.5547 139.184 10.5547 curveto
139.371 10.5547 139.559 10.625 139.746 10.7695 curveto
139.91 10.4219 lineto
139.691 10.2773 139.414 10.2031 139.086 10.2031 curveto
138.766 10.2031 138.504 10.3086 138.293 10.5273 curveto
138.086 10.7383 137.98 11.0273 137.98 11.3945 curveto
137.98 11.7656 138.09 12.0664 138.305 12.293 curveto
138.52 12.5195 138.816 12.6328 139.191 12.6328 curveto
139.312 12.6328 139.445 12.6055 139.59 12.5547 curveto
139.73 12.5039 139.832 12.4531 139.898 12.3984 curveto
 closepath fill
newpath 141.48 13.4727 moveto
141.551 13.4727 141.613 13.4492 141.664 13.3984 curveto
141.715 13.3477 141.738 13.2852 141.738 13.2148 curveto
141.738 13.1445 141.715 13.0859 141.664 13.0352 curveto
141.613 12.9844 141.551 12.9609 141.48 12.9609 curveto
141.41 12.9609 141.352 12.9844 141.301 13.0352 curveto
141.25 13.0859 141.227 13.1445 141.227 13.2148 curveto
141.227 13.2891 141.25 13.3477 141.301 13.3984 curveto
141.348 13.4492 141.41 13.4727 141.48 13.4727 curveto
 closepath fill
newpath 141.254 10.2461 moveto
141.254 12.2383 lineto
140.934 12.2383 lineto
140.934 12.5859 lineto
141.668 12.5859 lineto
141.668 10.2461 lineto
 closepath fill
newpath 144.352 10.5156 moveto
144.188 10.3086 143.934 10.2031 143.59 10.2031 curveto
143.406 10.2031 143.246 10.2695 143.113 10.4023 curveto
142.98 10.5352 142.91 10.7031 142.91 10.9023 curveto
142.91 11.1367 143.016 11.3398 143.223 11.5039 curveto
143.43 11.668 143.695 11.75 144.016 11.75 curveto
144.105 11.75 144.203 11.7305 144.312 11.6914 curveto
144.312 11.3984 lineto
144.184 11.4258 144.09 11.4414 144.039 11.4414 curveto
143.828 11.4414 143.656 11.3867 143.523 11.2773 curveto
143.395 11.1719 143.324 11.043 143.324 10.8984 curveto
143.324 10.6523 143.469 10.5312 143.758 10.5312 curveto
143.965 10.5312 144.152 10.6328 144.312 10.832 curveto
144.312 11.3984 lineto
144.312 11.6914 lineto
144.312 12.0703 144.145 12.2578 143.809 12.2578 curveto
143.547 12.2578 143.348 12.1914 143.207 12.0508 curveto
143.035 12.3984 lineto
143.109 12.4609 143.219 12.5156 143.359 12.5625 curveto
143.496 12.6094 143.633 12.6328 143.758 12.6328 curveto
144.098 12.6328 144.344 12.5547 144.496 12.3984 curveto
144.652 12.2461 144.73 12 144.73 11.6641 curveto
144.73 10.8242 lineto
144.73 10.6172 144.789 10.4805 144.91 10.4141 curveto
144.91 10.207 lineto
144.742 10.207 144.617 10.2305 144.535 10.2773 curveto
144.449 10.3242 144.391 10.4062 144.352 10.5156 curveto
 closepath fill
newpath 146.234 12.2578 moveto
145.961 12.2578 lineto
145.961 12.5859 lineto
146.234 12.5859 lineto
146.234 13.0781 lineto
146.648 13.2344 lineto
146.648 12.5859 lineto
147.289 12.5859 lineto
147.289 12.2578 lineto
146.648 12.2578 lineto
146.648 11.0977 lineto
146.648 10.9023 146.68 10.7617 146.746 10.6758 curveto
146.812 10.5938 146.922 10.5547 147.066 10.5547 curveto
147.176 10.5547 147.285 10.5781 147.398 10.6328 curveto
147.461 10.2695 lineto
147.285 10.2266 147.098 10.2031 146.895 10.2031 curveto
146.711 10.2031 146.551 10.2734 146.422 10.4102 curveto
146.297 10.5469 146.234 10.7227 146.234 10.9297 curveto
 closepath fill
newpath 148.988 13.4727 moveto
149.062 13.4727 149.121 13.4492 149.172 13.3984 curveto
149.223 13.3477 149.246 13.2852 149.246 13.2148 curveto
149.246 13.1445 149.223 13.0859 149.172 13.0352 curveto
149.121 12.9844 149.062 12.9609 148.988 12.9609 curveto
148.922 12.9609 148.859 12.9844 148.809 13.0352 curveto
148.758 13.0859 148.734 13.1445 148.734 13.2148 curveto
148.734 13.2891 148.758 13.3477 148.809 13.3984 curveto
148.859 13.4492 148.918 13.4727 148.988 13.4727 curveto
 closepath fill
newpath 148.762 10.2461 moveto
148.762 12.2383 lineto
148.441 12.2383 lineto
148.441 12.5859 lineto
149.18 12.5859 lineto
149.18 10.2461 lineto
 closepath fill
newpath 150.387 11.4219 moveto
150.387 11.7852 150.484 12.0742 150.68 12.2969 curveto
150.871 12.5195 151.129 12.6289 151.445 12.6289 curveto
151.445 12.293 lineto
151.258 12.293 151.105 12.2148 150.992 12.0586 curveto
150.879 11.9062 150.824 11.6953 150.824 11.4219 curveto
150.824 11.4219 lineto
150.824 10.8359 151.031 10.543 151.445 10.543 curveto
151.641 10.543 151.793 10.6211 151.902 10.7773 curveto
152.012 10.9336 152.066 11.1523 152.066 11.4219 curveto
152.066 12.0039 151.859 12.293 151.445 12.293 curveto
151.445 12.6289 lineto
151.781 12.6289 152.043 12.5234 152.227 12.3086 curveto
152.41 12.0977 152.504 11.8008 152.504 11.4219 curveto
152.504 11.0469 152.41 10.7461 152.223 10.5312 curveto
152.031 10.3125 151.773 10.2031 151.445 10.2031 curveto
151.113 10.2031 150.852 10.3125 150.668 10.5352 curveto
150.48 10.7539 150.387 11.0508 150.387 11.4219 curveto
 closepath fill
newpath 155.086 10.2461 moveto
155.086 11.6094 lineto
155.086 11.8555 155.047 12.0312 154.973 12.1328 curveto
154.898 12.2305 154.773 12.2812 154.594 12.2812 curveto
154.5 12.2812 154.402 12.2539 154.297 12.1953 curveto
154.195 12.1406 154.113 12.0703 154.059 11.9844 curveto
154.059 10.2461 lineto
153.645 10.2461 lineto
153.645 12.5859 lineto
153.93 12.5859 lineto
154.059 12.2852 lineto
154.195 12.5156 154.422 12.6328 154.73 12.6328 curveto
155.242 12.6328 155.5 12.3203 155.5 11.6953 curveto
155.5 10.2461 lineto
 closepath fill
 0.137 0.122 0.125 setrgbcolor
newpath 154.516 18.2344 moveto
154.961 17.8672 155.402 17.293 157 18.7852 curveto
158.598 20.2773 157.785 19.64839 158.648 17.6836 curveto
159.512 15.7227 160.062 16.8047 160.113 17.1875 curveto
160.25 18.1445 159.957 20.0273 159.754 20.78911 curveto
159.586 21.4297 158.488 21.7461 158.047 21.4258 curveto
157.633 21.125 156.531 19.8828 155.797 19.64839 curveto
155.062 19.4102 155.645 20.1172 155.461 21.2969 curveto
155.277 22.4727 154.848 23.0078 154.387 22.8086 curveto
154.074 22.6758 153.395 21.9805 153.074 22.1602 curveto
152.457 22.5078 152.027 24.0078 148.992 22.3438 curveto
145.461 20.4062 148.629 24.8008 148.629 24.8008 curveto
148.629 24.8008 150.98 28.02339 149.57 30.35161 curveto
148.156 32.6797 145.121 27.6797 145.121 27.6797 curveto
145.121 27.6797 143.523 24.5156 142.816 21.16411 curveto
142.109 17.8164 140.668 18.1953 140.125 18.9102 curveto
139.539 19.6875 139.703 22.7344 137.609 21.4531 curveto
135.516 20.1719 135.543 17.6055 134.285 20.5117 curveto
133.031 23.41411 131.711 21.5508 131.539 21.2422 curveto
131.301 20.8164 131.422 19.875 131.066 19.6719 curveto
130.668 19.4453 130.168 20.2695 129.863 20.3789 curveto
129.539 20.5 127.42601 18.52339 126.465 16.6953 curveto
125.078 14.0547 122.859 20.4023 123.07399 20.7969 curveto
123.262 21.1445 128.672 28.6367 129.184 29.7227 curveto
129.715 30.85161 130.492 31.1875 130.883 31.2422 curveto
131.277 31.293 136.273 32.1328 139.887 35.9531 curveto
143.496 39.77339 142.949 40.7148 141.223 41.6836 curveto
141.121 40.5 lineto
141.523 40.0312 141.559 38.9336 140.684 38.0586 curveto
139.809 37.1836 136.938 34.2539 135.137 33.5117 curveto
133.426 32.8086 127.57 30.0195 133.414 35.3633 curveto
133.414 35.3633 lineto
138.348 39.8711 138.207 39.75 138.602 39.9102 curveto
139.074 40.0977 140.789 40.8828 141.121 40.5 curveto
141.223 41.6836 lineto
139.492 42.6523 134.57 37.8281 134.34 37.6523 curveto
134.172 37.5273 130.098 32.9414 129.812 32.3672 curveto
129.523 31.78911 122.82399 32.1562 122.82399 32.1562 curveto
122.047 31.7773 122.90599 31.457 122.90599 31.457 curveto
122.90599 31.457 125.914 31.02339 127.789 31.0703 curveto
129.664 31.125 128.426 30.0273 128.203 29.7656 curveto
126.754 28.043 124.012 23.3672 123.035 22.3906 curveto
122.05899 21.41411 120.188 22.5 120.082 22.5195 curveto
119.973 22.5352 117.18 22.957 117.742 20.8242 curveto
118.30899 18.6914 120.008 19.6367 120.828 19.4336 curveto
119.90599 20.125 lineto
119.73 20.0508 119.242 20.4727 119.262 20.6953 curveto
119.297 21.1289 119.746 20.6797 120.262 20.6953 curveto
120.785 20.707 120.09401 20.1992 119.90599 20.125 curveto
120.828 19.4336 lineto
121.078 19.375 121.43399 18.9336 121.57 18.7188 curveto
121.988 18.0547 122.18399 17.0078 122.621 16.3594 curveto
123.258 15.4102 125.68399 13.0508 127.55899 16.457 curveto
129.504 19.9883 130.742 18.66411 130.844 16.7383 curveto
130.949 14.8125 131.566 15.5312 132.258 15.8398 curveto
132.953 16.14839 132.359 17.4844 132.438 19.2305 curveto
132.516 20.97661 133.953 18.46089 133.852 17.7656 curveto
133.746 17.0742 134.828 17.1992 135.777 17.58589 curveto
136.727 17.9727 135.984 18.5625 137.293 19.7695 curveto
138.602 20.97661 138.668 18.1445 139.012 17.4844 curveto
139.285 16.9531 140.656 15.8398 141.352 17.3281 curveto
142.047 18.8203 143.133 18.4961 142.895 16.97661 curveto
143.84 17.1758 lineto
143.355 18.9492 144.613 20.4375 144.613 20.4375 curveto
144.613 20.4375 145.148 21.1562 145.488 21.125 curveto
144.641 21.4922 lineto
144.223 21.0273 143.867 20.668 144.203 21.9531 curveto
144.535 23.2383 144.418 22.6953 144.625 23.1758 curveto
144.828 23.6445 145.727 26.0273 145.797 26.2188 curveto
145.836 26.3281 146.625 27.8711 147.43 29.043 curveto
147.43 29.043 149.598 30.957 148.723 27.5039 curveto
148.137 25.1836 147.48 24.9297 146.418 23.2656 curveto
146.418 23.2656 lineto
146.215 22.9453 145.855 23.6875 145.125 22.7617 curveto
144.82 22.375 145.012 21.9023 144.641 21.4922 curveto
145.488 21.125 lineto
145.906 21.08589 146.746 20.9531 146.465 19.9258 curveto
146.465 19.9258 lineto
146.18 18.89839 145.766 17.1992 145.293 16.7617 curveto
144.875 16.375 144.324 15.4023 143.84 17.1758 curveto
142.895 16.97661 lineto
142.66 15.4609 143.965 14.8633 144.387 14.8828 curveto
144.785 14.9062 147.082 16.168 147.109 18.7031 curveto
147.137 21.2422 148.949 21.22661 149.254 21.2695 curveto
149.562 21.3086 151.898 21.6875 151.688 21.0078 curveto
151.48 20.3281 150.434 18.3672 151.637 18.3906 curveto
152.84 18.418 152.344 19.4648 153.469 20.6406 curveto
154.594 21.8203 154.07 18.60161 154.516 18.2344 curveto
 closepath fill
newpath 140.031 28.9648 moveto
139.871 27.2617 140.918 27.8164 140.918 27.8164 curveto
142.867 28.8203 141.328 29.75 141.328 29.75 curveto
141.328 29.75 140.191 30.668 140.031 28.9648 curveto
 closepath fill
newpath 168.477 13.7578 moveto
168.379 14.0312 168.176 14.3984 167.363 13.3984 curveto
166.113 11.8672 166.281 12.832 166.164 13.8359 curveto
166.145 14.0078 166.27 14.4648 165.414 15.1836 curveto
164.965 15.5625 162.887 16.1445 163.355 16.6172 curveto
164.551 17.832 164.238 17.7148 164.676 18.2539 curveto
165.113 18.793 166.73 20.3867 166.652 22.64839 curveto
166.578 24.9062 163.312 24.7031 163.312 24.7031 curveto
161.184 24.3164 162.082 22.3633 163.621 22.4922 curveto
165.059 22.6133 164.871 21.4062 164.762 21.0195 curveto
164.762 21.0156 lineto
164.754 20.9883 164.746 20.9648 164.738 20.9453 curveto
164.762 21.0156 lineto
164.762 21.0195 lineto
164.758 21.0156 164.582 20.5469 164.227 19.9844 curveto
163.746 19.2344 163.16 18.1523 162.594 17.60161 curveto
162.285 17.3047 160.633 16.25 161.824 15.6602 curveto
163.801 14.6797 165.293 12.6016 164.52 11.4453 curveto
163.754 10.293 157.688 7.99219 156.43 7.4414 curveto
155.211 6.90234 152.809 6.7461 152.859 3.61328 curveto
152.91 0.48047 156.254 0.5039 157.715 0.89063 curveto
157.492 1.77734 lineto
155.078 1.44531 153.758 2.84375 153.781 3.6914 curveto
153.809 4.53516 154.598 5.64453 157.242 6.95703 curveto
163.172 9.89844 163.695 10.1211 163.695 10.1211 curveto
164.125 10.293 165.039 10.8359 164.504 9.92969 curveto
164.504 9.92969 lineto
164.504 9.92969 162.137 5.3789 161.879 4.97266 curveto
161.559 4.48438 159.906 2.11328 157.492 1.77734 curveto
157.715 0.89063 lineto
160.273 1.5586 161.34 2.5586 162.312 3.66406 curveto
163.344 4.83984 165.395 9.4961 165.445 9.54688 curveto
165.496 9.59766 166.164 12.293 167.348 12.6016 curveto
168.527 12.9102 168.621 13.3594 168.477 13.7578 curveto
 closepath fill
newpath 162.355 27.9844 moveto
161.758 28.2344 159.961 27.3047 160.5 25.7617 curveto
161.047 24.1836 165.121 26.8438 162.355 27.9844 curveto
 closepath fill
newpath 108.363 41.6406 moveto
107.645 41.6406 lineto
106.81601 39.5586 lineto
106.07 41.6406 lineto
105.30899 41.6406 lineto
105.30899 41.5352 lineto
105.371 41.5156 105.418 41.5 105.445 41.4844 curveto
105.473 41.4688 105.496 41.4492 105.512 41.4219 curveto
105.527 41.39839 105.539 41.3633 105.547 41.3203 curveto
105.555 41.27339 105.555 41.2031 105.555 41.1055 curveto
105.555 39.2578 lineto
105.555 39.1523 105.55101 39.0742 105.543 39.02339 curveto
105.535 38.9727 105.516 38.9297 105.484 38.9023 curveto
105.453 38.875 105.395 38.85161 105.30899 38.8281 curveto
105.30899 38.7227 lineto
106.086 38.7227 lineto
106.086 38.8281 lineto
106.02 38.8438 105.973 38.8633 105.945 38.8789 curveto
105.914 38.89839 105.895 38.918 105.879 38.9453 curveto
105.863 38.9688 105.85199 39.0039 105.848 39.0469 curveto
105.84 39.0938 105.836 39.1602 105.836 39.2578 curveto
105.836 40.03911 lineto
105.836 40.2812 105.836 40.5156 105.828 40.7422 curveto
105.82 40.9688 105.812 41.125 105.805 41.2148 curveto
105.84401 41.2148 lineto
106.629 39.0625 lineto
106.875 39.0625 lineto
107.71901 41.1797 lineto
107.758 41.1797 lineto
107.746 41.0977 107.738 40.9492 107.734 40.72661 curveto
107.73 40.5078 107.723 40.28911 107.723 40.0742 curveto
107.723 39.2578 lineto
107.723 39.1406 107.71901 39.0586 107.707 39.0117 curveto
107.695 38.96089 107.67601 38.9219 107.645 38.89839 curveto
107.613 38.8711 107.555 38.8477 107.473 38.8281 curveto
107.473 38.7227 lineto
108.363 38.7227 lineto
108.363 38.8281 lineto
108.30101 38.8438 108.254 38.8633 108.223 38.8789 curveto
108.195 38.89839 108.172 38.918 108.15599 38.9453 curveto
108.145 38.9688 108.133 39.0039 108.125 39.0469 curveto
108.117 39.0938 108.113 39.1602 108.113 39.2578 curveto
108.113 41.1055 lineto
108.113 41.2031 108.121 41.2773 108.129 41.3242 curveto
108.137 41.3711 108.14801 41.4062 108.164 41.4297 curveto
108.18 41.4531 108.203 41.4727 108.23 41.4883 curveto
108.258 41.5039 108.30101 41.5195 108.363 41.5352 curveto
 closepath fill
newpath 110.40599 39.22661 moveto
110.312 39.125 110.223 39.0547 110.129 39.0117 curveto
110.035 38.9688 109.93 38.9453 109.812 38.9453 curveto
109.67601 38.9453 109.562 38.9805 109.47699 39.043 curveto
109.391 39.1094 109.328 39.1992 109.289 39.3125 curveto
109.254 39.4297 109.234 39.5703 109.234 39.7383 curveto
109.234 39.7773 lineto
110.578 39.7773 lineto
110.578 39.9688 110.55899 40.125 110.52301 40.2461 curveto
110.488 40.3672 110.44101 40.4688 110.383 40.5469 curveto
110.32 40.625 110.242 40.6875 110.141 40.7344 curveto
110.039 40.7773 109.914 40.8008 109.77301 40.8008 curveto
109.754 40.6328 lineto
109.848 40.6328 109.92601 40.6055 109.984 40.5547 curveto
110.047 40.5039 110.09 40.4258 110.121 40.332 curveto
110.14801 40.2344 110.172 40.1055 110.18 39.9531 curveto
109.246 39.9531 lineto
109.262 40.1719 109.312 40.3398 109.39801 40.457 curveto
109.488 40.5742 109.605 40.6328 109.754 40.6328 curveto
109.77301 40.8008 lineto
109.59 40.8008 109.42601 40.7578 109.285 40.668 curveto
109.145 40.582 109.035 40.4531 108.961 40.293 curveto
108.883 40.1328 108.84401 39.9453 108.84401 39.7305 curveto
108.84401 39.3906 108.922 39.1289 109.07 38.9531 curveto
109.21901 38.7773 109.44101 38.6914 109.734 38.6914 curveto
109.84401 38.6914 109.945 38.7031 110.035 38.7344 curveto
110.129 38.7656 110.211 38.8086 110.285 38.8633 curveto
110.363 38.918 110.445 38.9922 110.539 39.08589 curveto
 closepath fill
newpath 111.562 40.7852 moveto
111.43399 40.7852 lineto
110.93399 40.7656 lineto
110.93399 40.6523 lineto
111 40.6406 111.047 40.625 111.086 40.6094 curveto
111.117 40.5938 111.145 40.5703 111.16 40.5352 curveto
111.18 40.5 111.188 40.457 111.19101 40.4023 curveto
111.19101 40.3477 111.195 40.27339 111.195 40.1797 curveto
111.195 39.25 lineto
111.195 39.1523 111.19101 39.0781 111.18399 39.0312 curveto
111.17601 38.9844 111.16 38.9492 111.145 38.9258 curveto
111.129 38.9023 111.105 38.8867 111.086 38.8711 curveto
111.05899 38.8594 111.02 38.8438 110.965 38.8281 curveto
110.965 38.7227 lineto
111.805 38.7227 lineto
111.805 38.8281 lineto
111.754 38.8438 111.711 38.8555 111.688 38.8711 curveto
111.66 38.8828 111.637 38.89839 111.625 38.9102 curveto
111.609 38.9258 111.598 38.9453 111.59 38.9727 curveto
111.578 38.9961 111.57399 39.0273 111.57 39.0703 curveto
111.562 39.1133 111.562 39.1758 111.562 39.2578 curveto
111.562 40.0586 lineto
111.562 40.1211 111.578 40.1797 111.605 40.2344 curveto
111.629 40.28911 111.672 40.3398 111.723 40.3906 curveto
111.777 40.4375 111.828 40.47661 111.883 40.5039 curveto
111.93399 40.5312 111.988 40.543 112.047 40.543 curveto
112.086 40.543 112.121 40.53911 112.15599 40.5312 curveto
112.188 40.52339 112.21901 40.5117 112.242 40.4961 curveto
112.266 40.4805 112.289 40.457 112.312 40.4258 curveto
112.34 40.39839 112.355 40.3594 112.371 40.3086 curveto
112.387 40.2617 112.39801 40.1992 112.402 40.1172 curveto
112.41 40.03911 112.414 39.9336 112.414 39.8086 curveto
112.414 39.25 lineto
112.414 39.1523 112.41 39.0781 112.402 39.0312 curveto
112.391 38.9844 112.379 38.9492 112.363 38.9258 curveto
112.348 38.9023 112.328 38.8867 112.30101 38.8711 curveto
112.277 38.8594 112.238 38.8438 112.18399 38.8281 curveto
112.18399 38.7227 lineto
113.02 38.7227 lineto
113.02 38.8281 lineto
112.957 38.8438 112.91 38.8633 112.883 38.8789 curveto
112.855 38.8945 112.84 38.91411 112.82399 38.9375 curveto
112.812 38.96089 112.80101 38.9922 112.793 39.0312 curveto
112.785 39.0742 112.78099 39.14839 112.78099 39.2578 curveto
112.78099 40.0352 lineto
112.78099 40.1094 112.797 40.1758 112.82 40.2305 curveto
112.848 40.2852 112.887 40.3398 112.945 40.3945 curveto
113.004 40.4492 113.055 40.4844 113.105 40.5078 curveto
113.15599 40.5312 113.207 40.543 113.266 40.543 curveto
113.32 40.543 113.363 40.5352 113.395 40.5273 curveto
113.42601 40.5156 113.457 40.5 113.48 40.47661 curveto
113.504 40.457 113.527 40.4336 113.547 40.4102 curveto
113.56601 40.3828 113.582 40.3438 113.59401 40.2969 curveto
113.609 40.25 113.617 40.1875 113.625 40.1094 curveto
113.633 40.0312 113.633 39.9297 113.633 39.8086 curveto
113.633 39.25 lineto
113.633 39.1523 113.629 39.0781 113.621 39.0312 curveto
113.609 38.9844 113.598 38.9492 113.582 38.9258 curveto
113.56601 38.9023 113.547 38.8867 113.52 38.8711 curveto
113.496 38.8594 113.457 38.8438 113.402 38.8281 curveto
113.402 38.7227 lineto
114.242 38.7227 lineto
114.242 38.8281 lineto
114.17601 38.8438 114.133 38.8633 114.105 38.8789 curveto
114.078 38.8945 114.05899 38.91411 114.043 38.9375 curveto
114.03099 38.96089 114.02 38.9922 114.012 39.0312 curveto
114.004 39.0742 114.004 39.14839 114.004 39.2578 curveto
114.004 40.0625 lineto
114.004 40.21089 113.992 40.3242 113.96901 40.41411 curveto
113.945 40.5 113.91 40.5703 113.863 40.6289 curveto
113.81601 40.6875 113.758 40.7305 113.688 40.7578 curveto
113.621 40.7852 113.539 40.7969 113.44101 40.7969 curveto
113.363 40.7969 113.289 40.7852 113.21901 40.7578 curveto
113.14801 40.7305 113.082 40.6914 113.016 40.6406 curveto
112.94899 40.5898 112.863 40.5078 112.758 40.39839 curveto
112.723 40.5352 112.66 40.6367 112.57 40.6992 curveto
112.48 40.7656 112.363 40.7969 112.223 40.7969 curveto
112.17601 40.7969 112.129 40.793 112.086 40.7812 curveto
112.039 40.7695 111.992 40.75 111.94101 40.72661 curveto
111.891 40.6992 111.836 40.66411 111.78099 40.6211 curveto
111.72699 40.5781 111.65599 40.5117 111.57 40.4258 curveto
111.539 40.4336 lineto
 closepath fill
newpath 115.145 41.7812 moveto
115.016 41.7812 lineto
114.5 41.7578 lineto
114.5 41.64839 lineto
114.57 41.6367 114.621 41.6211 114.64801 41.6094 curveto
114.67601 41.5938 114.69899 41.5781 114.715 41.5586 curveto
114.73 41.5352 114.746 41.5078 114.754 41.4688 curveto
114.766 41.4297 114.77 41.3867 114.77301 41.332 curveto
114.77301 41.2773 114.77301 41.1797 114.77301 41.043 curveto
114.77301 38.7227 lineto
114.922 38.6914 lineto
115.07 38.8203 lineto
115.17601 38.7695 115.27301 38.7383 115.363 38.7188 curveto
115.461 38.6992 115.55899 38.6914 115.664 38.6914 curveto
115.85199 38.6914 116.016 38.7305 116.152 38.8125 curveto
116.289 38.8945 116.395 39.0156 116.465 39.1758 curveto
116.535 39.33589 116.56601 39.5312 116.56601 39.7656 curveto
116.56601 39.9883 116.539 40.1797 116.48 40.332 curveto
116.422 40.4883 116.34 40.6055 116.23 40.6836 curveto
116.121 40.7617 115.988 40.7969 115.836 40.7969 curveto
115.754 40.7969 115.67601 40.7852 115.605 40.7617 curveto
115.535 40.7383 115.465 40.6992 115.39801 40.6523 curveto
115.336 40.6094 115.25 40.5312 115.152 40.4258 curveto
115.305 40.3906 lineto
115.363 40.4414 115.418 40.4805 115.47699 40.5078 curveto
115.53099 40.5312 115.60199 40.543 115.68399 40.543 curveto
115.84401 40.543 115.965 40.4727 116.047 40.332 curveto
116.129 40.1875 116.168 39.97661 116.168 39.6953 curveto
116.168 39.41411 116.121 39.207 116.035 39.0664 curveto
115.945 38.9258 115.81601 38.8594 115.645 38.8594 curveto
115.578 38.8594 115.516 38.8633 115.461 38.8789 curveto
115.40599 38.8906 115.355 38.918 115.312 38.9531 curveto
115.266 38.9883 115.23 39.0273 115.207 39.0703 curveto
115.18399 39.1133 115.168 39.16411 115.15599 39.2305 curveto
115.14801 39.293 115.145 39.3828 115.145 39.4922 curveto
115.145 40.0586 lineto
115.145 40.125 115.15599 40.1797 115.18399 40.2344 curveto
115.211 40.2852 115.25 40.33589 115.305 40.3906 curveto
115.152 40.4258 lineto
115.145 40.4297 lineto
 closepath fill
newpath 118.57399 39.22661 moveto
118.48 39.125 118.391 39.0547 118.297 39.0117 curveto
118.203 38.9688 118.098 38.9453 117.98 38.9453 curveto
117.84401 38.9453 117.73 38.9805 117.645 39.043 curveto
117.55899 39.1094 117.496 39.1992 117.461 39.3125 curveto
117.422 39.4297 117.402 39.5703 117.402 39.7383 curveto
117.402 39.7773 lineto
118.746 39.7773 lineto
118.742 39.9688 118.723 40.125 118.69101 40.2461 curveto
118.65599 40.3672 118.609 40.4688 118.55101 40.5469 curveto
118.488 40.625 118.41 40.6875 118.30899 40.7344 curveto
118.207 40.7773 118.086 40.8008 117.94101 40.8008 curveto
117.922 40.6328 lineto
118.016 40.6328 118.09401 40.6055 118.152 40.5547 curveto
118.215 40.5039 118.258 40.4258 118.289 40.332 curveto
118.31601 40.2344 118.34 40.1055 118.348 39.9531 curveto
117.41 39.9531 lineto
117.43 40.1719 117.48 40.3398 117.56601 40.457 curveto
117.65599 40.5742 117.77301 40.6328 117.922 40.6328 curveto
117.94101 40.8008 lineto
117.758 40.8008 117.59401 40.7578 117.453 40.668 curveto
117.312 40.582 117.203 40.4531 117.129 40.293 curveto
117.05101 40.1328 117.012 39.9453 117.012 39.7305 curveto
117.012 39.3906 117.09 39.1289 117.238 38.9531 curveto
117.387 38.7773 117.609 38.6914 117.902 38.6914 curveto
118.012 38.6914 118.109 38.7031 118.203 38.7344 curveto
118.293 38.7656 118.379 38.8086 118.453 38.8633 curveto
118.53099 38.918 118.613 38.9922 118.703 39.08589 curveto
 closepath fill
newpath 119.73 40.7852 moveto
119.60199 40.7852 lineto
119.10199 40.7617 lineto
119.10199 40.6523 lineto
119.164 40.6406 119.215 40.625 119.25 40.6094 curveto
119.285 40.5938 119.312 40.5703 119.328 40.5352 curveto
119.34401 40.5 119.355 40.457 119.359 40.4023 curveto
119.359 40.3477 119.363 40.27339 119.363 40.1797 curveto
119.363 39.25 lineto
119.363 39.1523 119.359 39.0781 119.35199 39.0312 curveto
119.34 38.9844 119.328 38.9492 119.312 38.9258 curveto
119.297 38.9023 119.27301 38.8867 119.25 38.8711 curveto
119.22699 38.8594 119.188 38.8438 119.133 38.8281 curveto
119.133 38.7227 lineto
119.996 38.7227 lineto
119.996 38.8281 lineto
119.922 38.8398 119.867 38.8594 119.832 38.8828 curveto
119.797 38.9023 119.77 38.9414 119.754 38.9883 curveto
119.738 39.03911 119.73 39.1289 119.73 39.2578 curveto
119.73 40.0039 lineto
119.73 40.0742 119.738 40.1328 119.758 40.1797 curveto
119.77301 40.2305 119.80899 40.2852 119.855 40.3438 curveto
119.89801 40.39839 119.94899 40.4414 120 40.4727 curveto
120.05101 40.5039 120.10199 40.5195 120.152 40.5195 curveto
120.21901 40.5195 120.27301 40.5 120.312 40.4648 curveto
120.348 40.4297 120.387 40.375 120.422 40.2969 curveto
120.66 40.2969 lineto
120.66 40.78911 lineto
120.59401 40.7969 120.52 40.8008 120.438 40.8008 curveto
120.34 40.8008 120.25 40.7852 120.172 40.7578 curveto
120.09401 40.72661 120.02301 40.6836 119.957 40.6289 curveto
119.891 40.5742 119.81601 40.5 119.738 40.4023 curveto
119.711 40.4102 lineto
 closepath fill
newpath 123.34401 38.8086 moveto
123.488 38.8906 123.598 39.0117 123.67601 39.1719 curveto
123.754 39.33589 123.797 39.5352 123.797 39.77339 curveto
123.797 40.10161 123.715 40.3594 123.55899 40.5352 curveto
123.402 40.7148 123.172 40.8008 122.867 40.8008 curveto
122.859 40.6328 lineto
122.961 40.6328 123.05101 40.60161 123.133 40.5352 curveto
123.211 40.4688 123.27301 40.3711 123.32 40.2305 curveto
123.367 40.0938 123.391 39.918 123.391 39.71089 curveto
123.391 39.5977 123.383 39.4883 123.363 39.3867 curveto
123.34401 39.2852 123.312 39.1914 123.27301 39.1133 curveto
123.23 39.0352 123.17601 38.9727 123.109 38.9258 curveto
123.043 38.8828 122.961 38.8594 122.863 38.8594 curveto
122.69101 38.8594 122.55899 38.9375 122.465 39.0938 curveto
122.371 39.25 122.32399 39.47661 122.32399 39.7695 curveto
122.32399 40.0469 122.371 40.2578 122.465 40.4102 curveto
122.465 40.4102 lineto
122.555 40.5586 122.688 40.6328 122.859 40.6328 curveto
122.867 40.8008 lineto
122.688 40.8008 122.52301 40.7617 122.379 40.6836 curveto
122.238 40.60161 122.129 40.4844 122.047 40.3203 curveto
121.961 40.1602 121.922 39.96089 121.922 39.7227 curveto
121.922 39.3828 122 39.125 122.15599 38.9492 curveto
122.312 38.7773 122.539 38.6914 122.836 38.6914 curveto
123.03099 38.6914 123.19899 38.7305 123.34401 38.8086 curveto
 closepath fill
newpath 125.32399 40.7656 moveto
124.812 40.7656 lineto
124.812 40.9883 lineto
124.812 41.0977 124.81601 41.1836 124.828 41.2539 curveto
124.836 41.3203 124.85199 41.3789 124.871 41.4219 curveto
124.891 41.4688 124.91 41.5039 124.938 41.5312 curveto
124.965 41.5586 124.996 41.5781 125.027 41.5938 curveto
125.062 41.6055 125.098 41.6094 125.145 41.6094 curveto
125.211 41.6094 125.262 41.5938 125.30101 41.5586 curveto
125.336 41.52339 125.367 41.4648 125.395 41.3789 curveto
125.605 41.3789 lineto
125.605 41.7656 lineto
125.527 41.7812 125.43399 41.78911 125.32 41.78911 curveto
125.19101 41.78911 125.078 41.7773 124.984 41.75 curveto
124.891 41.7188 124.80101 41.6719 124.71901 41.6055 curveto
124.637 41.5352 124.57 41.4531 124.527 41.3555 curveto
124.484 41.2617 124.457 41.1328 124.445 40.97661 curveto
124.438 40.91411 124.43 40.8633 124.422 40.8242 curveto
124.41 40.78911 124.402 40.7617 124.391 40.7422 curveto
124.379 40.72661 124.363 40.71089 124.348 40.6992 curveto
124.328 40.6914 124.312 40.6836 124.297 40.6797 curveto
124.277 40.6719 124.242 40.668 124.188 40.6602 curveto
124.188 40.5508 lineto
124.445 40.5508 lineto
124.445 39.2578 lineto
124.445 39.1602 124.44101 39.08589 124.438 39.043 curveto
124.43 38.9961 124.418 38.96089 124.402 38.9375 curveto
124.387 38.91411 124.367 38.8945 124.34 38.875 curveto
124.312 38.8633 124.27 38.8438 124.203 38.8281 curveto
124.203 38.7227 lineto
125.078 38.7227 lineto
125.078 38.8281 lineto
125.016 38.8438 124.96901 38.8555 124.938 38.8711 curveto
124.91 38.8867 124.887 38.9062 124.867 38.9297 curveto
124.85199 38.957 124.836 38.9922 124.828 39.043 curveto
124.81601 39.0898 124.812 39.1602 124.812 39.2578 curveto
124.812 40.5508 lineto
125.32399 40.5508 lineto
 closepath fill
newpath 126.66 40.66411 moveto
126.734 40.6719 126.789 40.6953 126.836 40.7227 curveto
126.879 40.75 126.914 40.78911 126.938 40.832 curveto
126.965 40.8789 126.984 40.9336 126.996 41 curveto
127.012 41.0703 127.027 41.168 127.043 41.2969 curveto
127.34401 41.2969 lineto
127.34401 40.7695 lineto
128.035 40.7695 lineto
128.035 40.5547 lineto
127.34401 40.5547 lineto
127.34401 39.60161 lineto
127.34401 39.4648 127.35199 39.3555 127.363 39.27339 curveto
127.375 39.1914 127.395 39.1289 127.42601 39.082 curveto
127.457 39.0352 127.492 39 127.53099 38.9805 curveto
127.57399 38.96089 127.625 38.9531 127.688 38.9531 curveto
127.742 38.9531 127.797 38.9648 127.848 38.9883 curveto
127.89801 39.0117 127.945 39.043 127.996 39.0898 curveto
128.09 38.9727 lineto
127.988 38.875 127.895 38.8047 127.805 38.7617 curveto
127.711 38.7148 127.621 38.6953 127.52301 38.6953 curveto
127.34 38.6953 127.203 38.7461 127.113 38.8555 curveto
127.02301 38.9648 126.97699 39.1367 126.97699 39.3672 curveto
126.97699 40.5547 lineto
126.66 40.5547 lineto
 closepath fill
newpath 128.844 40.4336 moveto
128.852 40.4336 lineto
128.961 40.543 129.051 40.6211 129.113 40.668 curveto
129.18 40.7148 129.242 40.7461 129.309 40.7695 curveto
129.371 40.793 129.438 40.8047 129.512 40.8047 curveto
129.59 40.8047 129.66 40.793 129.719 40.7773 curveto
129.781 40.7578 129.836 40.7305 129.883 40.6914 curveto
129.926 40.6523 129.965 40.6055 129.996 40.5547 curveto
130.023 40.4961 130.047 40.4336 130.059 40.3555 curveto
130.074 40.2812 130.082 40.1836 130.082 40.0664 curveto
130.082 39.2617 lineto
130.082 39.1367 130.086 39.0547 130.098 39.0078 curveto
130.105 38.9648 130.129 38.9297 130.152 38.9023 curveto
130.184 38.8789 130.238 38.8555 130.32 38.832 curveto
130.32 38.72661 lineto
129.48 38.72661 lineto
129.48 38.832 lineto
129.535 38.8477 129.578 38.8633 129.602 38.8789 curveto
129.625 38.8906 129.645 38.9062 129.66 38.9297 curveto
129.68 38.9531 129.691 38.9883 129.699 39.0352 curveto
129.711 39.08589 129.715 39.1562 129.715 39.2539 curveto
129.715 39.8125 lineto
129.715 40.0039 129.703 40.14839 129.684 40.2461 curveto
129.664 40.3477 129.629 40.4219 129.57 40.4727 curveto
129.516 40.52339 129.438 40.5469 129.336 40.5469 curveto
129.277 40.5469 129.227 40.5352 129.184 40.5156 curveto
129.137 40.4961 129.086 40.46089 129.023 40.4102 curveto
128.965 40.3594 128.922 40.3086 128.887 40.2539 curveto
128.855 40.1992 128.844 40.1406 128.844 40.0781 curveto
128.844 39.2617 lineto
128.844 39.16411 128.844 39.0977 128.852 39.0547 curveto
128.855 39.0117 128.863 38.97661 128.879 38.9531 curveto
128.895 38.9219 128.914 38.89839 128.945 38.8828 curveto
128.973 38.8633 129.02 38.8477 129.078 38.832 curveto
129.078 38.72661 lineto
128.234 38.72661 lineto
128.234 38.832 lineto
128.297 38.8477 128.34 38.8672 128.367 38.8828 curveto
128.395 38.89839 128.414 38.918 128.43 38.9414 curveto
128.445 38.9648 128.457 39 128.465 39.0469 curveto
128.473 39.0898 128.477 39.16411 128.477 39.2617 curveto
128.477 41.0508 lineto
128.477 41.1875 128.473 41.2812 128.473 41.33589 curveto
128.469 41.3906 128.465 41.4336 128.453 41.4727 curveto
128.445 41.5117 128.434 41.53911 128.414 41.5625 curveto
128.398 41.582 128.379 41.60161 128.352 41.6133 curveto
128.32 41.625 128.273 41.6406 128.199 41.6523 curveto
128.199 41.7617 lineto
128.715 41.7852 lineto
128.844 41.7852 lineto
 closepath fill
newpath 132.391 39.0898 moveto
132.301 38.9961 132.215 38.9219 132.141 38.8672 curveto
132.062 38.8125 131.98 38.7695 131.887 38.7383 curveto
131.797 38.71089 131.695 38.6953 131.586 38.6953 curveto
131.293 38.6953 131.07 38.7812 130.922 38.957 curveto
130.773 39.1328 130.699 39.3945 130.699 39.7344 curveto
130.699 39.9492 130.734 40.1367 130.812 40.2969 curveto
130.891 40.46089 130.996 40.58589 131.137 40.6719 curveto
131.277 40.7617 131.441 40.8047 131.625 40.8047 curveto
131.605 40.6367 lineto
131.457 40.6367 131.34 40.5781 131.254 40.46089 curveto
131.164 40.3438 131.113 40.1758 131.098 39.957 curveto
132.031 39.957 lineto
132.023 40.1133 132.004 40.2383 131.973 40.33589 curveto
131.941 40.4336 131.898 40.5078 131.84 40.5586 curveto
131.777 40.6094 131.699 40.6367 131.605 40.6367 curveto
131.625 40.8047 lineto
131.77 40.8047 131.891 40.7812 131.992 40.7383 curveto
132.094 40.6914 132.176 40.6289 132.234 40.5508 curveto
132.297 40.4727 132.344 40.3711 132.375 40.2539 curveto
132.41 40.1328 132.43 39.9727 132.434 39.7812 curveto
131.086 39.7812 lineto
131.086 39.7422 lineto
131.086 39.5742 131.105 39.4336 131.145 39.3164 curveto
131.18 39.2031 131.242 39.1133 131.328 39.0469 curveto
131.414 38.9844 131.527 38.9531 131.664 38.9531 curveto
131.781 38.9531 131.887 38.9727 131.98 39.0156 curveto
132.074 39.0625 132.168 39.1328 132.262 39.2305 curveto
 closepath fill
showpage
%%EOF
}

\snapshot@savemps\snapshot@logo@de{
%!PS-Adobe-3.0 EPSF-3.0
%%BoundingBox: 0 0 525 44 
%%HiResBoundingBox: 0.08498 0.53389 524.82 43.22661 
%%Creator: MetaPost 1.803
%%CreationDate: 2014.09.12:1519
%%Pages: 1
%%BeginProlog
%%EndProlog
%%Page: 1 1
 0.137 0.122 0.125 setrgbcolor
newpath 491.953 19.9883 moveto
492.52701 19.9883 lineto
492.52701 20.4805 lineto
491.953 20.4805 lineto
491.953 21.58589 lineto
491.422 21.58589 lineto
491.422 20.4805 lineto
491.117 20.4805 lineto
491.117 19.9883 lineto
491.422 19.9883 lineto
491.422 17.6445 lineto
491.953 17.6445 lineto
 closepath fill
newpath 472.35501 19.9883 moveto
472.887 19.9883 lineto
472.887 20.4805 lineto
472.35501 20.4805 lineto
472.35501 21.58589 lineto
471.785 21.58589 lineto
471.785 20.4805 lineto
471.48001 20.4805 lineto
471.48001 19.9883 lineto
471.785 19.9883 lineto
471.785 17.6445 lineto
472.35501 17.6445 lineto
 closepath fill
newpath 500.633 20.082 moveto
500.48001 20.4062 500.195 20.5781 499.85199 20.5781 curveto
499.375 20.5781 499.01599 20.2344 499.01599 19.7383 curveto
499.01599 19.3594 499.242 19.207 499.547 19.0352 curveto
500.10199 18.75 lineto
500.215 18.6562 500.289 18.5781 500.289 18.4258 curveto
500.289 18.1797 500.10199 18.0469 499.871 18.0469 curveto
499.60501 18.0469 499.453 18.1797 499.35501 18.4062 curveto
498.863 18.1797 lineto
499.035 17.7812 499.453 17.5312 499.871 17.5312 curveto
500.387 17.5312 500.85901 17.9336 500.85901 18.4844 curveto
500.85901 18.9219 500.535 19.14839 500.195 19.3008 curveto
499.85199 19.4336 499.52701 19.5664 499.52701 19.7969 curveto
499.52701 19.9688 499.68 20.082 499.81201 20.082 curveto
499.98401 20.082 500.117 19.9883 500.195 19.8555 curveto
 closepath fill
newpath 498.10199 19.9492 moveto
497.988 20.1406 497.60501 20.5781 496.961 20.5781 curveto
496.086 20.5781 495.39801 19.9297 495.39801 19.0352 curveto
495.39801 18.1797 496.086 17.5312 496.922 17.5312 curveto
497.551 17.5312 497.89099 17.875 498.06201 18.1211 curveto
497.68399 18.4062 lineto
497.512 18.2188 497.34 18.0469 496.94101 18.0469 curveto
496.332 18.0469 495.93399 18.4844 495.93399 19.0742 curveto
495.93399 19.58589 496.35199 20.082 496.90201 20.082 curveto
497.22699 20.082 497.492 19.9297 497.703 19.6836 curveto
 closepath fill
newpath 493.97299 22.1953 moveto
493.742 22.1953 493.59 22.0039 493.59 21.793 curveto
493.59 21.58589 493.742 21.4336 493.97299 21.4336 curveto
494.16 21.4336 494.35199 21.58589 494.35199 21.793 curveto
494.35199 22.0039 494.16 22.1953 493.97299 22.1953 curveto
 closepath fill
newpath 494.219 20.4805 moveto
493.68799 20.4805 lineto
493.68799 17.6445 lineto
494.219 17.6445 lineto
 closepath fill
newpath 489.805 20.4805 moveto
489.254 20.4805 lineto
489.254 20.02339 lineto
489.02301 20.3672 488.68399 20.5781 488.262 20.5781 curveto
488.35901 20.082 lineto
488.949 20.082 489.293 19.625 489.293 19.0742 curveto
489.293 18.5039 488.949 18.0469 488.35901 18.0469 curveto
488.35901 18.0469 lineto
487.76999 18.0469 487.445 18.53911 487.445 19.0742 curveto
487.445 19.58589 487.789 20.082 488.35901 20.082 curveto
488.262 20.5781 lineto
487.426 20.5781 486.91 19.8711 486.91 19.0938 curveto
486.91 18.2539 487.406 17.5312 488.262 17.5312 curveto
488.68399 17.5312 489.02301 17.7617 489.254 18.08589 curveto
489.254 17.6445 lineto
489.805 17.6445 lineto
 closepath fill
newpath 482.383 20.4805 moveto
481.832 20.4805 lineto
481.832 17.6445 lineto
482.383 17.6445 lineto
482.383 19.0352 lineto
482.383 19.4922 482.422 20.082 483.012 20.082 curveto
483.508 20.082 483.52301 19.5312 483.52301 19.14839 curveto
483.52301 17.6445 lineto
484.078 17.6445 lineto
484.078 19.0352 lineto
484.078 19.4922 484.133 20.082 484.703 20.082 curveto
485.199 20.082 485.258 19.625 485.258 19.2461 curveto
485.258 17.6445 lineto
485.789 17.6445 lineto
485.789 19.3398 lineto
485.789 19.9883 485.59799 20.5781 484.85501 20.5781 curveto
484.496 20.5781 484.15201 20.3867 483.965 20.082 curveto
483.77301 20.4062 483.508 20.5781 483.14499 20.5781 curveto
482.82 20.5781 482.555 20.3867 482.383 20.1211 curveto
 closepath fill
newpath 480.51999 18.96089 moveto
480.51999 19.0547 lineto
480.51999 19.9102 480.082 20.5781 479.168 20.5781 curveto
478.254 20.5781 477.797 19.9102 477.797 19.0352 curveto
477.797 18.1992 478.31201 17.5312 479.18799 17.5312 curveto
479.738 17.5312 480.254 17.8164 480.51999 18.3125 curveto
480.06201 18.5781 lineto
479.85199 18.2344 479.625 18.0469 479.18799 18.0469 curveto
478.672 18.0469 478.34799 18.4844 478.328 18.96089 curveto
478.367 19.39839 lineto
478.426 19.7969 478.746 20.10161 479.168 20.10161 curveto
479.625 20.10161 479.91 19.83589 479.965 19.39839 curveto
478.367 19.39839 lineto
478.328 18.96089 lineto
 closepath fill
newpath 474.125 22.2148 moveto
474.125 17.6445 lineto
474.676 17.6445 lineto
474.676 18.9414 lineto
474.676 19.4727 474.676 20.082 475.379 20.082 curveto
475.949 20.082 476.008 19.7383 476.008 19.2656 curveto
476.008 17.6445 lineto
476.55899 17.6445 lineto
476.55899 19.3398 lineto
476.55899 20.043 476.35199 20.5781 475.531 20.5781 curveto
475.211 20.5781 474.867 20.4258 474.676 20.10161 curveto
474.676 22.2148 lineto
 closepath fill
newpath 470.262 20.4805 moveto
469.73001 20.4805 lineto
469.73001 20.02339 lineto
469.711 20.02339 lineto
469.48001 20.3672 469.14099 20.5781 468.719 20.5781 curveto
468.81601 20.082 lineto
469.406 20.082 469.746 19.625 469.746 19.0742 curveto
469.746 18.5039 469.406 18.0469 468.81601 18.0469 curveto
468.81601 18.0469 lineto
468.22699 18.0469 467.90201 18.53911 467.90201 19.0742 curveto
467.90201 19.58589 468.242 20.082 468.81601 20.082 curveto
468.719 20.5781 lineto
467.883 20.5781 467.367 19.8711 467.367 19.0938 curveto
467.367 18.2539 467.863 17.5312 468.719 17.5312 curveto
469.14099 17.5312 469.48001 17.7617 469.711 18.08589 curveto
469.73001 18.08589 lineto
469.73001 17.6445 lineto
470.262 17.6445 lineto
 closepath fill
newpath 462.84 20.4805 moveto
462.26999 20.4805 lineto
462.26999 17.6445 lineto
462.84 17.6445 lineto
462.84 19.0352 lineto
462.84 19.4922 462.879 20.082 463.469 20.082 curveto
463.98001 20.082 464 19.5312 464 19.14839 curveto
464 17.6445 lineto
464.555 17.6445 lineto
464.555 19.0352 lineto
464.555 19.4922 464.59 20.082 465.18 20.082 curveto
465.656 20.082 465.715 19.625 465.715 19.2461 curveto
465.715 17.6445 lineto
466.246 17.6445 lineto
466.246 19.3398 lineto
466.246 19.9883 466.055 20.5781 465.31201 20.5781 curveto
464.953 20.5781 464.60901 20.3867 464.418 20.082 curveto
464.246 20.4062 463.98001 20.5781 463.60199 20.5781 curveto
463.27701 20.5781 462.992 20.3867 462.84 20.1211 curveto
 closepath fill
newpath 456.332 20.4805 moveto
455.781 20.4805 lineto
455.781 17.6445 lineto
456.332 17.6445 lineto
456.332 18.9414 lineto
456.332 19.4727 456.332 20.082 457.035 20.082 curveto
457.60501 20.082 457.68399 19.7383 457.68399 19.2656 curveto
457.68399 17.6445 lineto
458.195 17.6445 lineto
458.195 19.3398 lineto
458.195 20.043 458.02301 20.5781 457.207 20.5781 curveto
456.863 20.5781 456.52301 20.4258 456.35199 20.10161 curveto
456.332 20.10161 lineto
 closepath fill
newpath 454.695 18.96089 moveto
454.695 19.0547 lineto
454.695 19.9102 454.27701 20.5781 453.363 20.5781 curveto
452.449 20.5781 451.97299 19.9102 451.97299 19.0352 curveto
451.97299 18.1992 452.508 17.5312 453.363 17.5312 curveto
453.93399 17.5312 454.43 17.8164 454.695 18.3125 curveto
454.238 18.5781 lineto
454.02701 18.2344 453.801 18.0469 453.363 18.0469 curveto
452.85199 18.0469 452.52701 18.4844 452.52701 18.96089 curveto
452.547 19.39839 lineto
452.621 19.7969 452.945 20.10161 453.363 20.10161 curveto
453.801 20.10161 454.086 19.83589 454.14499 19.39839 curveto
452.547 19.39839 lineto
452.52701 18.96089 lineto
 closepath fill
newpath 448.699 20.4805 moveto
448.14801 20.4805 lineto
448.14801 15.9922 lineto
448.699 15.9922 lineto
448.699 18.08589 lineto
448.719 18.08589 lineto
448.93 17.7617 449.27301 17.5312 449.69101 17.5312 curveto
450.56601 17.5312 451.043 18.2539 451.043 19.0938 curveto
451.043 19.8711 450.52701 20.5781 449.711 20.5781 curveto
449.578 20.082 lineto
450.168 20.082 450.508 19.625 450.508 19.0742 curveto
450.508 18.5039 450.168 18.0469 449.578 18.0469 curveto
449.578 18.0469 lineto
448.988 18.0469 448.664 18.53911 448.664 19.0742 curveto
448.664 19.58589 449.008 20.082 449.578 20.082 curveto
449.711 20.5781 lineto
449.27301 20.5781 448.93 20.3672 448.719 20.02339 curveto
448.699 20.02339 lineto
 closepath fill
newpath 445.656 20.5781 moveto
445.656 20.0625 lineto
446.207 20.0625 446.64499 19.6055 446.64499 19.0547 curveto
446.64499 18.52339 446.207 18.08589 445.656 18.08589 curveto
445.125 18.08589 444.703 18.52339 444.703 19.0547 curveto
444.703 19.6055 445.125 20.0625 445.656 20.0625 curveto
445.656 20.0625 lineto
445.656 20.5781 lineto
444.82 20.5781 444.133 19.9102 444.133 19.0547 curveto
444.133 18.1992 444.82 17.5312 445.656 17.5312 curveto
446.512 17.5312 447.199 18.1992 447.199 19.0547 curveto
447.199 19.9102 446.512 20.5781 445.656 20.5781 curveto
 closepath fill
newpath 500.613 25.5625 moveto
502.44101 25.5625 lineto
496.94101 37.3594 lineto
491.44101 25.5625 lineto
493.26999 25.5625 lineto
494.449 28.2461 lineto
499.414 28.2461 lineto
498.76599 29.7305 lineto
495.113 29.7305 lineto
496.94101 33.8594 lineto
498.76599 29.7305 lineto
499.414 28.2461 lineto
 closepath fill
newpath 451.918 25.5625 moveto
453.742 25.5625 lineto
448.242 37.3594 lineto
442.746 25.5625 lineto
444.57 25.5625 lineto
445.75 28.2461 lineto
450.719 28.2461 lineto
450.07 29.7305 lineto
446.418 29.7305 lineto
448.242 33.8594 lineto
450.07 29.7305 lineto
450.719 28.2461 lineto
 closepath fill
newpath 524.82 36.9414 moveto
523.086 36.9414 lineto
520.156 32.2422 lineto
517.16803 36.9414 lineto
515.344 36.9414 lineto
519.30103 30.5117 lineto
519.30103 25.5625 lineto
520.95697 25.5625 lineto
520.95697 30.6992 lineto
 closepath fill
newpath 423.73401 36.9414 moveto
422.078 36.9414 lineto
422.078 25.5625 lineto
423.73401 25.5625 lineto
 closepath fill
newpath 473.09799 36.9414 moveto
471.422 36.9414 lineto
471.422 25.5625 lineto
473.09799 25.5625 lineto
 closepath fill
newpath 513.64801 25.5625 moveto
510.22299 30.58589 lineto
511.82 31.0039 512.68 32.1094 512.68 33.707 curveto
512.68 34.8672 512.164 35.875 511.23001 36.4102 curveto
510.488 36.8672 509.883 36.9414 507.75 36.9414 curveto
505.76999 36.9414 lineto
505.76999 25.5625 lineto
507.426 25.5625 lineto
507.426 30.4336 lineto
507.426 31.9375 lineto
507.426 35.457 lineto
508.81601 35.457 lineto
509.594 35.457 510.07 35.3438 510.39499 35.0586 curveto
510.758 34.7344 510.98401 34.1836 510.98401 33.6328 curveto
510.98401 32.9453 510.621 32.375 509.996 32.1094 curveto
509.672 31.97661 509.23401 31.9375 508.207 31.9375 curveto
507.426 31.9375 lineto
507.426 30.4336 lineto
508.301 30.4336 lineto
511.555 25.5625 lineto
 closepath fill
newpath 488.168 36.9414 moveto
486.512 36.9414 lineto
486.512 29.1953 lineto
477.988 37.168 lineto
477.988 25.5625 lineto
479.64499 25.5625 lineto
479.64499 33.3281 lineto
488.168 25.33589 lineto
 closepath fill
newpath 462.383 31.3477 moveto
462.383 29.8633 lineto
465.41 29.8633 lineto
465.086 27.96089 463.754 26.7812 461.73401 26.7812 curveto
459.301 26.7812 457.664 28.7578 457.664 31.4023 curveto
457.664 33.8203 459.35501 35.707 461.77301 35.707 curveto
463.238 35.707 464.305 35.0977 465.39099 33.6875 curveto
466.742 34.7344 lineto
465.465 36.4453 463.80899 37.2852 461.73401 37.2852 curveto
460.40201 37.2852 459.281 36.8672 458.215 36.08589 curveto
456.676 34.9453 455.836 33.25 455.836 31.2695 curveto
455.836 29.5977 456.465 28.0352 457.60501 26.8945 curveto
458.73001 25.7539 459.969 25.2031 461.73401 25.2031 curveto
463.43 25.2031 464.703 25.77339 465.75 26.91411 curveto
466.762 27.9805 467.254 29.2539 467.426 31.3477 curveto
 closepath fill
newpath 437.797 37.47661 moveto
434.14499 29.0273 lineto
430.453 37.47661 lineto
427.578 25.5625 lineto
429.406 25.5625 lineto
430.98401 32.58589 lineto
434.14499 25.08589 lineto
437.301 32.58589 lineto
438.863 25.5625 lineto
440.69101 25.5625 lineto
 closepath fill
 0 1.874 dtransform truncate idtransform setlinewidth pop [] 0 setdash
 0 setlinecap 0 setlinejoin 10 setmiterlimit
newpath 8.51953 15.7227 moveto
21.5 15.7227 lineto
25.6367 15.7227 28.9961 19.082 28.9961 23.2188 curveto
28.9961 27.3555 25.6367 30.7148 21.5 30.7148 curveto
8.51953 30.7148 lineto
21.5 30.7148 lineto stroke
newpath 27.9922 26.9688 moveto
21.5 38.21089 lineto
19.4297 41.793 14.8438 43.02339 11.2617 40.9531 curveto
7.67969 38.8867 6.44922 34.2969 8.51563 30.7148 curveto
8.51563 30.7148 lineto
11.7617 25.0938 lineto
15.0078 19.4727 lineto
8.51563 30.7148 lineto stroke
newpath 8.51953 38.21089 moveto
2.02734 26.9688 lineto
-0.04297 23.3867 1.1875 18.7969 4.76953 16.7305 curveto
8.35156 14.6602 12.9414 15.8906 15.0078 19.4727 curveto
18.2539 25.0938 lineto
15.0078 19.4727 lineto
21.5 30.7148 lineto stroke
newpath 41.1797 36.3203 moveto
40.4531 36.3203 lineto
40.4531 41.0195 lineto
38.9375 37.8242 lineto
38.5078 37.8242 lineto
37.0039 41.0195 lineto
37.0039 36.3203 lineto
36.3281 36.3203 lineto
36.3281 41.77339 lineto
37.3125 41.77339 lineto
38.7656 38.7344 lineto
40.1719 41.77339 lineto
41.1797 41.77339 lineto
 closepath fill
newpath 45.7656 36.3203 moveto
45.082 36.3203 lineto
45.082 36.7578 lineto
45.0195 36.7148 44.9375 36.6562 44.832 36.582 curveto
44.52339 36.9883 lineto
44.7227 37.082 44.9102 37.1953 45.082 37.3281 curveto
45.082 37.3281 lineto
45.082 38.4648 lineto
44.8711 38.4531 44.625 38.4375 44.3398 38.4102 curveto
44.0547 38.3867 43.832 38.35161 43.66411 38.3047 curveto
43.4688 38.25 43.3047 38.1602 43.1836 38.043 curveto
43.0625 37.9258 43 37.7617 43 37.5547 curveto
43 37.3203 43.0742 37.1445 43.2148 37.0273 curveto
43.3555 36.9062 43.5703 36.8477 43.8633 36.8477 curveto
44.10161 36.8477 44.3242 36.8945 44.52339 36.9883 curveto
44.832 36.582 lineto
44.7305 36.5078 44.6289 36.4492 44.5312 36.4062 curveto
44.418 36.35161 44.2852 36.3008 44.1367 36.2656 curveto
43.9883 36.22661 43.8125 36.207 43.6133 36.207 curveto
43.2461 36.207 42.9336 36.332 42.6758 36.5742 curveto
42.418 36.8164 42.293 37.1289 42.293 37.5078 curveto
42.293 37.8164 42.3594 38.0664 42.4922 38.2578 curveto
42.625 38.4492 42.8125 38.60161 43.0586 38.71089 curveto
43.3086 38.8203 43.6094 38.8945 43.957 38.9336 curveto
44.3047 38.9727 44.6797 39.0039 45.082 39.02339 curveto
45.082 39.1289 lineto
45.082 39.2852 45.0547 39.41411 45 39.5156 curveto
44.9453 39.6172 44.8633 39.6992 44.7617 39.7578 curveto
44.66411 39.8125 44.5469 39.85161 44.4102 39.8711 curveto
44.27339 39.8906 44.1328 39.9023 43.9844 39.9023 curveto
43.8008 39.9023 43.60161 39.8789 43.3789 39.832 curveto
43.1562 39.7812 42.9258 39.7148 42.6914 39.6211 curveto
42.6523 39.6211 lineto
42.6523 40.3203 lineto
42.78911 40.3594 42.9844 40.39839 43.2344 40.4414 curveto
43.4883 40.4844 43.7383 40.5078 43.9883 40.5078 curveto
44.27339 40.5078 44.52339 40.4844 44.7383 40.4375 curveto
44.9531 40.3906 45.1367 40.3086 45.293 40.1953 curveto
45.4453 40.082 45.5625 39.9375 45.6445 39.7578 curveto
45.7227 39.582 45.7656 39.3594 45.7656 39.0977 curveto
 closepath fill
newpath 49.21089 36.3594 moveto
49.082 36.3242 48.9414 36.2969 48.78911 36.27339 curveto
48.6367 36.2539 48.5 36.2422 48.3828 36.2422 curveto
47.9648 36.2422 47.64839 36.35161 47.4297 36.5781 curveto
47.21089 36.8008 47.1055 37.1602 47.1055 37.6562 curveto
47.1055 39.832 lineto
46.6406 39.832 lineto
46.6406 40.4102 lineto
47.1055 40.4102 lineto
47.1055 41.58589 lineto
47.793 41.58589 lineto
47.793 40.4102 lineto
49.21089 40.4102 lineto
49.21089 39.832 lineto
47.793 39.832 lineto
47.793 37.9688 lineto
47.793 37.7539 47.7969 37.58589 47.8086 37.4648 curveto
47.8164 37.3438 47.85161 37.2305 47.9102 37.1289 curveto
47.9648 37.0273 48.03911 36.957 48.1328 36.9102 curveto
48.2227 36.8672 48.3672 36.8438 48.5625 36.8438 curveto
48.6719 36.8438 48.78911 36.8594 48.91411 36.8945 curveto
49.0352 36.9258 49.1211 36.9531 49.1758 36.97661 curveto
49.21089 36.97661 lineto
 closepath fill
newpath 53.46089 36.3203 moveto
52.77339 36.3203 lineto
52.77339 38.64839 lineto
52.77339 38.83589 52.7617 39.0117 52.7422 39.1758 curveto
52.7188 39.3438 52.6797 39.4727 52.6211 39.5664 curveto
52.5586 39.668 52.4688 39.7422 52.3555 39.793 curveto
52.2422 39.8438 52.0938 39.8672 51.9102 39.8672 curveto
51.7227 39.8672 51.5273 39.8203 51.3203 39.72661 curveto
51.1172 39.6367 50.918 39.5195 50.7305 39.375 curveto
50.7305 36.3203 lineto
50.043 36.3203 lineto
50.043 42.0156 lineto
50.7305 42.0156 lineto
50.7305 39.957 lineto
50.9453 40.1328 51.168 40.27339 51.39839 40.3711 curveto
51.6289 40.4727 51.8633 40.52339 52.1055 40.52339 curveto
52.5469 40.52339 52.8828 40.3906 53.1133 40.125 curveto
53.3438 39.8594 53.46089 39.47661 53.46089 38.9727 curveto
 closepath fill
newpath 58.21089 38.293 moveto
55.1953 38.293 lineto
55.1953 38.8203 lineto
57.53911 38.8203 lineto
57.5352 39.1836 57.4453 39.46089 57.2656 39.6602 curveto
57.08589 39.8555 56.8125 39.957 56.4492 39.957 curveto
56.0781 39.957 55.7852 39.8477 55.5664 39.6289 curveto
55.3477 39.41411 55.22661 39.1445 55.1953 38.8203 curveto
55.1953 38.293 lineto
55.1953 38.043 55.2344 37.8242 55.3086 37.6367 curveto
55.3867 37.4492 55.4883 37.2969 55.6211 37.1797 curveto
55.7461 37.0625 55.89839 36.9727 56.0742 36.91411 curveto
56.2461 36.8555 56.4414 36.8281 56.64839 36.8281 curveto
56.9258 36.8281 57.207 36.8828 57.4883 36.9922 curveto
57.7695 37.1055 57.9727 37.2148 58.0938 37.3203 curveto
58.1289 37.3203 lineto
58.1289 36.5703 lineto
57.8945 36.4727 57.6602 36.3906 57.418 36.3242 curveto
57.1758 36.2578 56.9219 36.22661 56.6562 36.22661 curveto
55.9805 36.22661 55.4492 36.4102 55.0703 36.7773 curveto
54.6875 37.1445 54.4961 37.66411 54.4961 38.3438 curveto
54.4961 39.0117 54.6797 39.53911 55.043 39.9336 curveto
55.4102 40.3281 55.8906 40.52339 56.4844 40.52339 curveto
57.0352 40.52339 57.46089 40.3633 57.7617 40.03911 curveto
58.0586 39.7188 58.21089 39.2617 58.21089 38.668 curveto
 closepath fill
newpath 65.2188 36.3203 moveto
64.5273 36.3203 lineto
64.5273 38.64839 lineto
64.5273 38.8242 64.5195 38.9961 64.5078 39.1562 curveto
64.4883 39.3203 64.457 39.4531 64.4062 39.5508 curveto
64.3477 39.6562 64.2695 39.7344 64.16411 39.78911 curveto
64.0586 39.8398 63.9062 39.8672 63.71089 39.8672 curveto
63.5156 39.8672 63.3242 39.8203 63.1328 39.7227 curveto
62.9375 39.625 62.7461 39.5039 62.5547 39.3555 curveto
62.5586 39.3008 62.5664 39.2344 62.5703 39.1602 curveto
62.5781 39.08589 62.5781 39.0117 62.5781 38.9375 curveto
62.5781 36.3203 lineto
61.8906 36.3203 lineto
61.8906 38.64839 lineto
61.8906 38.8281 61.8828 39 61.8672 39.16411 curveto
61.85161 39.3242 61.8164 39.457 61.7656 39.5547 curveto
61.71089 39.6602 61.6289 39.7344 61.52339 39.78911 curveto
61.418 39.8398 61.2695 39.8672 61.0703 39.8672 curveto
60.8828 39.8672 60.6953 39.8203 60.5039 39.72661 curveto
60.3164 39.6367 60.1289 39.5195 59.9414 39.375 curveto
59.9414 36.3203 lineto
59.2539 36.3203 lineto
59.2539 40.4102 lineto
59.9414 40.4102 lineto
59.9414 39.957 lineto
60.1523 40.1328 60.3672 40.27339 60.582 40.3711 curveto
60.7969 40.4727 61.02339 40.52339 61.2656 40.52339 curveto
61.543 40.52339 61.7773 40.4648 61.9727 40.3477 curveto
62.168 40.2305 62.3125 40.0664 62.4062 39.8594 curveto
62.6836 40.0938 62.9375 40.2617 63.168 40.3672 curveto
63.39839 40.4727 63.6406 40.52339 63.9023 40.52339 curveto
64.35161 40.52339 64.6836 40.3867 64.89839 40.1133 curveto
65.1094 39.8438 65.2188 39.46089 65.2188 38.9727 curveto
 closepath fill
newpath 69.7188 36.3203 moveto
69.0352 36.3203 lineto
69.0352 36.7578 lineto
68.9727 36.7148 68.8906 36.6562 68.78911 36.582 curveto
68.47661 36.9883 lineto
68.6758 37.082 68.8633 37.1953 69.0352 37.3281 curveto
69.0352 37.3281 lineto
69.0352 38.4648 lineto
68.8242 38.4531 68.5781 38.4375 68.293 38.4102 curveto
68.0078 38.3867 67.7852 38.35161 67.6172 38.3047 curveto
67.4219 38.25 67.2617 38.1602 67.1406 38.043 curveto
67.0156 37.9258 66.957 37.7617 66.957 37.5547 curveto
66.957 37.3203 67.0273 37.1445 67.168 37.0273 curveto
67.3086 36.9062 67.5273 36.8477 67.8164 36.8477 curveto
68.0547 36.8477 68.2773 36.8945 68.47661 36.9883 curveto
68.78911 36.582 lineto
68.6836 36.5078 68.582 36.4492 68.4844 36.4062 curveto
68.3711 36.35161 68.2383 36.3008 68.0898 36.2656 curveto
67.9414 36.22661 67.7656 36.207 67.5664 36.207 curveto
67.1992 36.207 66.8867 36.332 66.6289 36.5742 curveto
66.375 36.8164 66.2461 37.1289 66.2461 37.5078 curveto
66.2461 37.8164 66.3125 38.0664 66.4453 38.2578 curveto
66.5781 38.4492 66.7695 38.60161 67.0156 38.71089 curveto
67.2656 38.8203 67.5625 38.8945 67.9102 38.9336 curveto
68.2617 38.9727 68.6367 39.0039 69.0352 39.02339 curveto
69.0352 39.1289 lineto
69.0352 39.2852 69.0078 39.41411 68.9531 39.5156 curveto
68.89839 39.6172 68.8203 39.6992 68.7148 39.7578 curveto
68.6172 39.8125 68.5 39.85161 68.3633 39.8711 curveto
68.22661 39.8906 68.08589 39.9023 67.9375 39.9023 curveto
67.7578 39.9023 67.5547 39.8789 67.332 39.832 curveto
67.1094 39.7812 66.8828 39.7148 66.6445 39.6211 curveto
66.6094 39.6211 lineto
66.6094 40.3203 lineto
66.7422 40.3594 66.9336 40.39839 67.1914 40.4414 curveto
67.4453 40.4844 67.6953 40.5078 67.9414 40.5078 curveto
68.22661 40.5078 68.47661 40.4844 68.6914 40.4375 curveto
68.9062 40.3906 69.0898 40.3086 69.2461 40.1953 curveto
69.4023 40.082 69.5195 39.9375 69.5977 39.7578 curveto
69.6797 39.582 69.7188 39.3594 69.7188 39.0977 curveto
 closepath fill
newpath 73.168 36.3594 moveto
73.03911 36.3242 72.89839 36.2969 72.7422 36.27339 curveto
72.5898 36.2539 72.457 36.2422 72.33589 36.2422 curveto
71.918 36.2422 71.60161 36.35161 71.3828 36.5781 curveto
71.168 36.8008 71.0586 37.1602 71.0586 37.6562 curveto
71.0586 39.832 lineto
70.5938 39.832 lineto
70.5938 40.4102 lineto
71.0586 40.4102 lineto
71.0586 41.58589 lineto
71.7461 41.58589 lineto
71.7461 40.4102 lineto
73.168 40.4102 lineto
73.168 39.832 lineto
71.7461 39.832 lineto
71.7461 37.9688 lineto
71.7461 37.7539 71.75 37.58589 71.7617 37.4648 curveto
71.7695 37.3438 71.8047 37.2305 71.8633 37.1289 curveto
71.918 37.0273 71.9922 36.957 72.08589 36.9102 curveto
72.1797 36.8672 72.3242 36.8438 72.5156 36.8438 curveto
72.6289 36.8438 72.7461 36.8594 72.8672 36.8945 curveto
72.9883 36.9258 73.0742 36.9531 73.1289 36.97661 curveto
73.168 36.97661 lineto
 closepath fill
newpath 74.6914 36.3203 moveto
74.0039 36.3203 lineto
74.0039 40.4102 lineto
74.6914 40.4102 lineto
 closepath fill
newpath 74.7383 41.0938 moveto
73.96089 41.0938 lineto
73.96089 41.8086 lineto
74.7383 41.8086 lineto
 closepath fill
newpath 78.9727 37.5 moveto
78.9727 37.1289 78.8203 36.8203 78.5117 36.582 curveto
78.2031 36.3438 77.7812 36.2227 77.2461 36.2227 curveto
76.9453 36.2227 76.668 36.2578 76.41411 36.332 curveto
76.1602 36.4023 75.9492 36.4805 75.7812 36.5664 curveto
75.7812 37.3398 lineto
75.8164 37.3398 lineto
76.0352 37.1758 76.27339 37.0469 76.53911 36.9492 curveto
76.8047 36.85161 77.0625 36.8047 77.3047 36.8047 curveto
77.6094 36.8047 77.8438 36.85161 78.0156 36.9492 curveto
78.1875 37.0469 78.27339 37.2031 78.27339 37.4102 curveto
78.27339 37.5742 78.22661 37.6953 78.1328 37.7773 curveto
78.03911 37.8594 77.8633 37.9336 77.5977 37.9883 curveto
77.5 38.0117 77.3711 38.03911 77.2148 38.0664 curveto
77.0586 38.0977 76.91411 38.1289 76.7852 38.1602 curveto
76.4258 38.2578 76.1719 38.39839 76.02339 38.582 curveto
75.8711 38.7656 75.7969 38.9922 75.7969 39.2617 curveto
75.7969 39.4297 75.832 39.58589 75.9023 39.7344 curveto
75.9727 39.8867 76.0781 40.0195 76.2188 40.1367 curveto
76.3555 40.25 76.5312 40.3398 76.7422 40.4062 curveto
76.9492 40.47661 77.1875 40.5078 77.4492 40.5078 curveto
77.6914 40.5078 77.9375 40.47661 78.1914 40.418 curveto
78.4414 40.3594 78.64839 40.2852 78.8125 40.1992 curveto
78.8125 39.4648 lineto
78.7773 39.4648 lineto
78.60161 39.5938 78.3867 39.7031 78.1367 39.793 curveto
77.8867 39.8828 77.6406 39.9258 77.39839 39.9258 curveto
77.1445 39.9258 76.9336 39.8789 76.7617 39.7812 curveto
76.58589 39.6875 76.5 39.543 76.5 39.35161 curveto
76.5 39.1836 76.5508 39.0586 76.6562 38.9727 curveto
76.7617 38.8867 76.9258 38.8164 77.1562 38.7617 curveto
77.2812 38.7344 77.4258 38.7031 77.582 38.6758 curveto
77.7383 38.6445 77.8711 38.6172 77.97661 38.5938 curveto
78.293 38.5195 78.543 38.3945 78.7148 38.2188 curveto
78.8867 38.0352 78.9727 37.7969 78.9727 37.5 curveto
 closepath fill
newpath 82.9805 36.5781 moveto
82.7539 36.4688 82.5352 36.3828 82.3281 36.3203 curveto
82.125 36.2617 81.9023 36.2305 81.6719 36.2305 curveto
81.375 36.2305 81.1055 36.27339 80.8594 36.3594 curveto
80.6133 36.4453 80.4023 36.5781 80.22661 36.7539 curveto
80.0469 36.9297 79.9102 37.1523 79.8125 37.418 curveto
79.7148 37.6875 79.668 38 79.668 38.3594 curveto
79.668 39.0273 79.85161 39.5508 80.2188 39.9336 curveto
80.58589 40.3164 81.0703 40.5039 81.6719 40.5039 curveto
81.9062 40.5039 82.1367 40.4727 82.3633 40.4062 curveto
82.58589 40.3398 82.793 40.2617 82.9805 40.16411 curveto
82.9805 39.39839 lineto
82.9453 39.39839 lineto
82.7344 39.5625 82.5195 39.6875 82.2969 39.7773 curveto
82.0742 39.8633 81.8555 39.9062 81.6445 39.9062 curveto
81.2539 39.9062 80.9453 39.7773 80.7188 39.5156 curveto
80.4922 39.2539 80.3789 38.8672 80.3789 38.3594 curveto
80.3789 37.8672 80.4883 37.4883 80.71089 37.2227 curveto
80.9336 36.957 81.2422 36.8281 81.6445 36.8281 curveto
81.7812 36.8281 81.9219 36.8438 82.0664 36.8828 curveto
82.21089 36.918 82.3398 36.9648 82.457 37.02339 curveto
82.5547 37.0742 82.64839 37.1289 82.7383 37.1875 curveto
82.8242 37.2461 82.8945 37.293 82.9453 37.33589 curveto
82.9805 37.33589 lineto
 closepath fill
newpath 87.2812 36.3203 moveto
86.5938 36.3203 lineto
86.5938 38.64839 lineto
86.5938 38.83589 86.582 39.0117 86.5625 39.1758 curveto
86.53911 39.3438 86.5 39.4727 86.4414 39.5664 curveto
86.3789 39.668 86.293 39.7422 86.1758 39.793 curveto
86.0625 39.8438 85.91411 39.8672 85.7305 39.8672 curveto
85.543 39.8672 85.3477 39.8203 85.1406 39.72661 curveto
84.9375 39.6367 84.7383 39.5195 84.5508 39.375 curveto
84.5508 36.3203 lineto
83.8633 36.3203 lineto
83.8633 42.0156 lineto
84.5508 42.0156 lineto
84.5508 39.957 lineto
84.7656 40.1328 84.9883 40.27339 85.2188 40.3711 curveto
85.4492 40.4727 85.6836 40.52339 85.9258 40.52339 curveto
86.3672 40.52339 86.7031 40.3906 86.9336 40.125 curveto
87.168 39.8594 87.2812 39.47661 87.2812 38.9727 curveto
 closepath fill
newpath 92.0312 38.293 moveto
89.0195 38.293 lineto
89.0195 38.8203 lineto
91.3594 38.8203 lineto
91.3594 39.1836 91.2656 39.46089 91.08589 39.6602 curveto
90.9062 39.8555 90.6367 39.957 90.2695 39.957 curveto
89.9023 39.957 89.6055 39.8477 89.3906 39.6289 curveto
89.1719 39.41411 89.0469 39.1445 89.0195 38.8203 curveto
89.0195 38.293 lineto
89.0195 38.043 89.0547 37.8242 89.1328 37.6367 curveto
89.207 37.4492 89.3086 37.2969 89.4414 37.1797 curveto
89.5703 37.0625 89.7188 36.9727 89.8945 36.91411 curveto
90.0664 36.8555 90.2617 36.8281 90.4688 36.8281 curveto
90.75 36.8281 91.0273 36.8828 91.3086 36.9922 curveto
91.5938 37.1055 91.793 37.2148 91.91411 37.3203 curveto
91.9492 37.3203 lineto
91.9492 36.5703 lineto
91.7188 36.4727 91.4805 36.3906 91.2383 36.3242 curveto
90.9961 36.2578 90.7422 36.22661 90.47661 36.22661 curveto
89.8008 36.22661 89.2695 36.4102 88.8906 36.7773 curveto
88.5078 37.1445 88.3203 37.66411 88.3203 38.3438 curveto
88.3203 39.0117 88.5 39.53911 88.8672 39.9336 curveto
89.2305 40.3281 89.71089 40.52339 90.3047 40.52339 curveto
90.8555 40.52339 91.2812 40.3633 91.582 40.03911 curveto
91.8789 39.7188 92.0312 39.2617 92.0312 38.668 curveto
 closepath fill
newpath 95.9922 37.5 moveto
95.9922 37.1289 95.8398 36.8203 95.5312 36.582 curveto
95.2227 36.3438 94.8008 36.2227 94.2656 36.2227 curveto
93.9648 36.2227 93.6875 36.2578 93.4336 36.332 curveto
93.1797 36.4023 92.9688 36.4805 92.7969 36.5664 curveto
92.7969 37.3398 lineto
92.83589 37.3398 lineto
93.0508 37.1758 93.293 37.0469 93.5586 36.9492 curveto
93.8242 36.85161 94.082 36.8047 94.3242 36.8047 curveto
94.625 36.8047 94.8633 36.85161 95.0352 36.9492 curveto
95.207 37.0469 95.28911 37.2031 95.28911 37.4102 curveto
95.28911 37.5742 95.2422 37.6953 95.1523 37.7773 curveto
95.0586 37.8594 94.8828 37.9336 94.6172 37.9883 curveto
94.5195 38.0117 94.3906 38.03911 94.2344 38.0664 curveto
94.0781 38.0977 93.9336 38.1289 93.8047 38.1602 curveto
93.4453 38.2578 93.1914 38.39839 93.03911 38.582 curveto
92.8906 38.7656 92.8164 38.9922 92.8164 39.2617 curveto
92.8164 39.4297 92.85161 39.58589 92.9219 39.7344 curveto
92.9883 39.8867 93.0938 40.0195 93.2383 40.1367 curveto
93.375 40.25 93.5469 40.3398 93.7578 40.4062 curveto
93.9688 40.47661 94.207 40.5078 94.4688 40.5078 curveto
94.71089 40.5078 94.957 40.47661 95.207 40.418 curveto
95.457 40.3594 95.66411 40.2852 95.832 40.1992 curveto
95.832 39.4648 lineto
95.793 39.4648 lineto
95.6172 39.5938 95.4062 39.7031 95.1562 39.793 curveto
94.9062 39.8828 94.6562 39.9258 94.41411 39.9258 curveto
94.16411 39.9258 93.9531 39.8789 93.7812 39.7812 curveto
93.6055 39.6875 93.5195 39.543 93.5195 39.35161 curveto
93.5195 39.1836 93.5703 39.0586 93.6758 38.9727 curveto
93.7812 38.8867 93.9453 38.8164 94.1758 38.7617 curveto
94.3008 38.7344 94.4414 38.7031 94.60161 38.6758 curveto
94.7578 38.6445 94.8906 38.6172 94.9922 38.5938 curveto
95.3125 38.5195 95.5586 38.3945 95.7344 38.2188 curveto
95.9062 38.0352 95.9922 37.7969 95.9922 37.5 curveto
 closepath fill
newpath 39.8047 30.9414 moveto
37.0508 30.9414 lineto
37.0508 29.4062 lineto
39.418 29.4062 lineto
39.418 28.7617 lineto
37.0508 28.7617 lineto
37.0508 26.1367 lineto
36.3281 26.1367 lineto
36.3281 31.58589 lineto
39.8047 31.58589 lineto
 closepath fill
newpath 43.8828 28.1797 moveto
43.8828 27.5156 43.71089 26.9883 43.3711 26.60161 curveto
43.0312 26.2188 42.5703 26.02339 42 26.02339 curveto
41.4219 26.02339 40.96089 26.2188 40.6211 26.60161 curveto
40.2812 26.9883 40.1094 27.5156 40.1094 28.1797 curveto
40.1094 28.8438 40.2812 29.3711 40.6211 29.7578 curveto
40.96089 30.1445 41.4219 30.3398 42 30.3398 curveto
42 29.7461 lineto
41.625 29.7461 41.33589 29.6172 41.1289 29.3594 curveto
40.9219 29.10161 40.8203 28.71089 40.8203 28.1797 curveto
40.8203 27.668 40.9219 27.2773 41.1328 27.0156 curveto
41.3398 26.75 41.6289 26.6172 42 26.6172 curveto
42.3633 26.6172 42.6523 26.7461 42.8594 27.0117 curveto
43.0703 27.27339 43.1719 27.66411 43.1719 28.1797 curveto
43.1719 28.1797 lineto
43.1719 28.71089 43.0703 29.10161 42.8633 29.3594 curveto
42.6562 29.6172 42.3672 29.7461 42 29.7461 curveto
42 30.3398 lineto
42.5703 30.3398 43.0312 30.1445 43.3711 29.7578 curveto
43.71089 29.3711 43.8828 28.8438 43.8828 28.1797 curveto
 closepath fill
newpath 47.5 29.47661 moveto
47.46089 29.47661 lineto
47.3594 29.5 47.2617 29.5195 47.16411 29.5273 curveto
47.0703 29.53911 46.9531 29.5469 46.8242 29.5469 curveto
46.6094 29.5469 46.4062 29.5 46.207 29.4062 curveto
46.0078 29.3086 45.8203 29.1875 45.6367 29.03911 curveto
45.6367 26.1367 lineto
44.9492 26.1367 lineto
44.9492 30.22661 lineto
45.6367 30.22661 lineto
45.6367 29.6211 lineto
45.9102 29.8398 46.1523 29.9961 46.3594 30.0898 curveto
46.5703 30.1797 46.7812 30.22661 47 30.22661 curveto
47.1172 30.22661 47.2031 30.2227 47.2578 30.2148 curveto
47.3125 30.21089 47.3906 30.1992 47.5 30.1797 curveto
 closepath fill
newpath 51.0664 27.3164 moveto
51.0664 26.9414 50.91411 26.6367 50.6055 26.39839 curveto
50.2969 26.1562 49.875 26.03911 49.3398 26.03911 curveto
49.03911 26.03911 48.7617 26.0742 48.5078 26.14839 curveto
48.2539 26.2188 48.043 26.2969 47.8711 26.3828 curveto
47.8711 27.1562 lineto
47.9102 27.1562 lineto
48.125 26.9922 48.3672 26.8633 48.6328 26.7656 curveto
48.89839 26.668 49.1562 26.6211 49.39839 26.6211 curveto
49.7031 26.6211 49.9375 26.668 50.1094 26.7656 curveto
50.2812 26.8633 50.3633 27.0195 50.3633 27.22661 curveto
50.3633 27.3906 50.3203 27.5117 50.22661 27.5938 curveto
50.1328 27.6758 49.9531 27.7461 49.6914 27.8047 curveto
49.5938 27.8281 49.4688 27.8555 49.3086 27.8828 curveto
49.1523 27.91411 49.0078 27.9453 48.8789 27.97661 curveto
48.5195 28.0742 48.2656 28.2148 48.1172 28.39839 curveto
47.9648 28.582 47.8906 28.8086 47.8906 29.0781 curveto
47.8906 29.2461 47.9258 29.4023 47.9961 29.5508 curveto
48.0664 29.7031 48.1719 29.83589 48.3125 29.9531 curveto
48.4492 30.0664 48.6211 30.1562 48.832 30.2227 curveto
49.043 30.28911 49.2812 30.3242 49.543 30.3242 curveto
49.7852 30.3242 50.0312 30.293 50.2812 30.2344 curveto
50.5312 30.1758 50.7422 30.10161 50.9062 30.0156 curveto
50.9062 29.2812 lineto
50.8711 29.2812 lineto
50.6953 29.4102 50.4805 29.5195 50.2305 29.6094 curveto
49.97661 29.6992 49.7305 29.7422 49.4922 29.7422 curveto
49.2383 29.7422 49.0273 29.6953 48.85161 29.5977 curveto
48.6797 29.5 48.5938 29.3594 48.5938 29.168 curveto
48.5938 29 48.6445 28.8711 48.75 28.7852 curveto
48.85161 28.7031 49.0195 28.6328 49.25 28.5781 curveto
49.375 28.5508 49.5195 28.5195 49.6758 28.4922 curveto
49.832 28.46089 49.9648 28.4336 50.0703 28.4102 curveto
50.3867 28.33589 50.6367 28.21089 50.8086 28.0312 curveto
50.9805 27.85161 51.0664 27.6133 51.0664 27.3164 curveto
 closepath fill
newpath 55.0742 26.3945 moveto
54.8477 26.2852 54.6289 26.1992 54.4219 26.1367 curveto
54.2148 26.0781 53.9961 26.0469 53.7656 26.0469 curveto
53.4688 26.0469 53.1992 26.0898 52.9531 26.1758 curveto
52.707 26.2617 52.4961 26.3945 52.3203 26.5703 curveto
52.1406 26.7461 52.0039 26.9688 51.9062 27.2344 curveto
51.8086 27.5039 51.7578 27.8164 51.7578 28.1758 curveto
51.7578 28.8438 51.9453 29.3672 52.3086 29.75 curveto
52.6758 30.1328 53.1602 30.3203 53.7656 30.3203 curveto
54 30.3203 54.2305 30.28911 54.457 30.2227 curveto
54.6797 30.1562 54.8867 30.0742 55.0742 29.9805 curveto
55.0742 29.2148 lineto
55.03911 29.2148 lineto
54.8281 29.3789 54.6133 29.5039 54.3906 29.5938 curveto
54.16411 29.6797 53.9492 29.7227 53.7344 29.7227 curveto
53.3438 29.7227 53.0352 29.5938 52.8125 29.332 curveto
52.58589 29.0703 52.4727 28.6836 52.4727 28.1758 curveto
52.4727 27.6836 52.582 27.3047 52.8047 27.03911 curveto
53.0273 26.77339 53.33589 26.6445 53.7344 26.6445 curveto
53.875 26.6445 54.0156 26.6602 54.1602 26.6992 curveto
54.3047 26.7344 54.4336 26.7812 54.5469 26.8398 curveto
54.64839 26.8906 54.7422 26.9453 54.832 27.0039 curveto
54.918 27.0625 54.9883 27.1094 55.03911 27.1523 curveto
55.0742 27.1523 lineto
 closepath fill
newpath 59.375 26.1367 moveto
58.6875 26.1367 lineto
58.6875 28.4648 lineto
58.6875 28.6523 58.6758 28.8281 58.6562 28.9922 curveto
58.6328 29.1602 58.5938 29.28911 58.5352 29.3828 curveto
58.4727 29.4844 58.3828 29.5586 58.2695 29.6094 curveto
58.1562 29.6602 58.0078 29.6836 57.8242 29.6836 curveto
57.6367 29.6836 57.4414 29.6367 57.2344 29.543 curveto
57.0312 29.4531 56.832 29.332 56.6445 29.1914 curveto
56.6445 26.1367 lineto
55.957 26.1367 lineto
55.957 31.832 lineto
56.6445 31.832 lineto
56.6445 29.77339 lineto
56.8594 29.9492 57.082 30.0898 57.3125 30.1875 curveto
57.53911 30.28911 57.7773 30.3398 58.0195 30.3398 curveto
58.46089 30.3398 58.7969 30.207 59.0273 29.9414 curveto
59.2578 29.6758 59.375 29.293 59.375 28.78911 curveto
 closepath fill
newpath 64.0898 26.1367 moveto
63.4023 26.1367 lineto
63.4023 26.5938 lineto
63.168 26.4102 62.9492 26.2695 62.7344 26.1719 curveto
62.52339 26.0742 62.28911 26.02339 62.0312 26.02339 curveto
61.60161 26.02339 61.2695 26.1562 61.0312 26.418 curveto
60.78911 26.6797 60.6719 27.0664 60.6719 27.5742 curveto
60.6719 30.22661 lineto
61.3594 30.22661 lineto
61.3594 27.89839 lineto
61.3594 27.6914 61.3672 27.5117 61.3906 27.3672 curveto
61.4062 27.2188 61.4492 27.0938 61.5117 26.9883 curveto
61.5781 26.8789 61.66411 26.8008 61.7695 26.7539 curveto
61.875 26.7031 62.0273 26.6797 62.22661 26.6797 curveto
62.4062 26.6797 62.5977 26.72661 62.8086 26.8203 curveto
63.02339 26.9102 63.2188 27.0312 63.4023 27.1719 curveto
63.4023 30.22661 lineto
64.0898 30.22661 lineto
 closepath fill
newpath 68.8633 26.1367 moveto
68.1719 26.1367 lineto
68.1719 28.4648 lineto
68.1719 28.6523 68.16411 28.8281 68.1406 28.9922 curveto
68.1172 29.1602 68.0781 29.28911 68.0195 29.3828 curveto
67.957 29.4844 67.8711 29.5586 67.7578 29.6094 curveto
67.6406 29.6602 67.4922 29.6836 67.3086 29.6836 curveto
67.1211 29.6836 66.9258 29.6367 66.7188 29.543 curveto
66.5156 29.4531 66.3203 29.332 66.1328 29.1914 curveto
66.1328 26.1367 lineto
65.4453 26.1367 lineto
65.4453 30.22661 lineto
66.1328 30.22661 lineto
66.1328 29.77339 lineto
66.3477 29.9492 66.5703 30.0898 66.7969 30.1875 curveto
67.0273 30.28911 67.2617 30.3398 67.5039 30.3398 curveto
67.9453 30.3398 68.2812 30.207 68.5156 29.9414 curveto
68.7461 29.6758 68.8633 29.293 68.8633 28.78911 curveto
 closepath fill
newpath 73.5039 26.60161 moveto
73.5039 25.9102 73.3438 25.4023 73.0312 25.0781 curveto
72.7148 24.7539 72.2305 24.5898 71.5781 24.5898 curveto
71.3594 24.5898 71.14839 24.6055 70.9414 24.6367 curveto
70.7344 24.66411 70.5312 24.71089 70.332 24.7656 curveto
70.332 25.4688 lineto
70.3711 25.4688 lineto
70.4805 25.4258 70.6602 25.3672 70.9023 25.3047 curveto
71.14839 25.2383 71.3906 25.207 71.6367 25.207 curveto
71.8711 25.207 72.0625 25.2344 72.2188 25.293 curveto
72.3711 25.3477 72.4922 25.4258 72.5781 25.5273 curveto
72.6602 25.6211 72.7227 25.7344 72.7617 25.8711 curveto
72.7969 26.0039 72.8164 26.1562 72.8164 26.3203 curveto
72.8164 26.6953 lineto
72.6094 26.5273 72.4102 26.4062 72.2188 26.3242 curveto
72.0312 26.2383 71.78911 26.1992 71.4961 26.1992 curveto
71.0078 26.1992 70.6211 26.375 70.33589 26.72661 curveto
70.0469 27.082 69.9062 27.5781 69.9062 28.2188 curveto
69.9062 28.5703 69.9531 28.875 70.0547 29.1289 curveto
70.1523 29.3828 70.2852 29.6055 70.457 29.78911 curveto
70.6172 29.9648 70.8086 30.0977 71.0352 30.1953 curveto
71.2617 30.28911 71.4883 30.3398 71.7148 30.3398 curveto
71.9492 30.3398 72.14839 30.3164 72.3086 30.2695 curveto
72.4688 30.2188 72.6367 30.14839 72.8164 30.0508 curveto
72.8164 29.4883 lineto
72.6328 29.5742 72.46089 29.6328 72.3047 29.668 curveto
72.14839 29.7031 71.9883 29.7188 71.83589 29.7188 curveto
71.457 29.7188 71.1562 29.5938 70.9414 29.3398 curveto
70.7227 29.08589 70.6133 28.7188 70.6133 28.2344 curveto
70.6133 27.7773 70.6953 27.4297 70.8555 27.1914 curveto
71.0195 26.957 71.2852 26.83589 71.6562 26.83589 curveto
71.8594 26.83589 72.0586 26.875 72.2617 26.9531 curveto
72.46089 27.0312 72.6445 27.1328 72.8164 27.2617 curveto
72.8164 27.2617 lineto
72.8164 29.4883 lineto
72.8164 30.0508 lineto
72.8594 30.22661 lineto
73.5039 30.22661 lineto
 closepath fill
newpath 77.7773 27.3164 moveto
77.7773 26.9414 77.625 26.6367 77.3164 26.39839 curveto
77.0039 26.1562 76.58589 26.03911 76.0508 26.03911 curveto
75.7461 26.03911 75.4688 26.0742 75.2188 26.14839 curveto
74.9648 26.2188 74.7539 26.2969 74.582 26.3828 curveto
74.582 27.1562 lineto
74.6172 27.1562 lineto
74.83589 26.9922 75.0781 26.8633 75.3438 26.7656 curveto
75.6094 26.668 75.8633 26.6211 76.1094 26.6211 curveto
76.4102 26.6211 76.64839 26.668 76.8203 26.7656 curveto
76.9883 26.8633 77.0742 27.0195 77.0742 27.22661 curveto
77.0742 27.3906 77.0273 27.5117 76.9336 27.5938 curveto
76.8438 27.6758 76.66411 27.7461 76.4023 27.8047 curveto
76.3047 27.8281 76.1758 27.8555 76.0195 27.8828 curveto
75.8594 27.91411 75.7188 27.9453 75.5898 27.97661 curveto
75.2305 28.0742 74.97661 28.2148 74.8242 28.39839 curveto
74.6758 28.582 74.60161 28.8086 74.60161 29.0781 curveto
74.60161 29.2461 74.6367 29.4023 74.707 29.5508 curveto
74.77339 29.7031 74.8789 29.83589 75.02339 29.9531 curveto
75.1602 30.0664 75.332 30.1562 75.543 30.2227 curveto
75.7539 30.28911 75.9883 30.3242 76.25 30.3242 curveto
76.4961 30.3242 76.7422 30.293 76.9922 30.2344 curveto
77.2422 30.1758 77.4492 30.10161 77.6172 30.0156 curveto
77.6172 29.2812 lineto
77.5781 29.2812 lineto
77.4023 29.4102 77.1914 29.5195 76.9414 29.6094 curveto
76.6875 29.6992 76.4414 29.7422 76.1992 29.7422 curveto
75.9492 29.7422 75.7344 29.6953 75.5625 29.5977 curveto
75.3906 29.5 75.3047 29.3594 75.3047 29.168 curveto
75.3047 29 75.3555 28.8711 75.46089 28.7852 curveto
75.5625 28.7031 75.7305 28.6328 75.957 28.5781 curveto
76.08589 28.5508 76.22661 28.5195 76.3828 28.4922 curveto
76.543 28.46089 76.6719 28.4336 76.7773 28.4102 curveto
77.0977 28.33589 77.3438 28.21089 77.5195 28.0312 curveto
77.6914 27.85161 77.7773 27.6133 77.7773 27.3164 curveto
 closepath fill
newpath 79.457 26.1367 moveto
78.7695 26.1367 lineto
78.7695 30.22661 lineto
79.457 30.22661 lineto
 closepath fill
newpath 79.5 30.9102 moveto
78.72661 30.9102 lineto
78.72661 31.625 lineto
79.5 31.625 lineto
 closepath fill
newpath 84.2383 26.1367 moveto
83.5508 26.1367 lineto
83.5508 28.4648 lineto
83.5508 28.6523 83.53911 28.8281 83.5156 28.9922 curveto
83.4922 29.1602 83.4531 29.28911 83.3945 29.3828 curveto
83.33589 29.4844 83.2461 29.5586 83.1328 29.6094 curveto
83.0156 29.6602 82.8672 29.6836 82.6836 29.6836 curveto
82.4961 29.6836 82.3008 29.6367 82.0977 29.543 curveto
81.8906 29.4531 81.6953 29.332 81.5078 29.1914 curveto
81.5078 26.1367 lineto
80.8203 26.1367 lineto
80.8203 30.22661 lineto
81.5078 30.22661 lineto
81.5078 29.77339 lineto
81.7227 29.9492 81.9453 30.0898 82.1719 30.1875 curveto
82.4023 30.28911 82.6367 30.3398 82.8789 30.3398 curveto
83.3203 30.3398 83.6562 30.207 83.8906 29.9414 curveto
84.1211 29.6758 84.2383 29.293 84.2383 28.78911 curveto
 closepath fill
newpath 88.4844 27.3164 moveto
88.4844 26.9414 88.3281 26.6367 88.0195 26.39839 curveto
87.71089 26.1562 87.28911 26.03911 86.7539 26.03911 curveto
86.4531 26.03911 86.1758 26.0742 85.9219 26.14839 curveto
85.668 26.2188 85.46089 26.2969 85.2852 26.3828 curveto
85.2852 27.1562 lineto
85.3242 27.1562 lineto
85.543 26.9922 85.7812 26.8633 86.0469 26.7656 curveto
86.3164 26.668 86.5703 26.6211 86.8125 26.6211 curveto
87.1172 26.6211 87.35161 26.668 87.52339 26.7656 curveto
87.6953 26.8633 87.7812 27.0195 87.7812 27.22661 curveto
87.7812 27.3906 87.7344 27.5117 87.6406 27.5938 curveto
87.5469 27.6758 87.3711 27.7461 87.1055 27.8047 curveto
87.0078 27.8281 86.8828 27.8555 86.7227 27.8828 curveto
86.5664 27.91411 86.4219 27.9453 86.293 27.97661 curveto
85.9336 28.0742 85.6797 28.2148 85.5312 28.39839 curveto
85.3828 28.582 85.3047 28.8086 85.3047 29.0781 curveto
85.3047 29.2461 85.3398 29.4023 85.4102 29.5508 curveto
85.4805 29.7031 85.58589 29.83589 85.72661 29.9531 curveto
85.8633 30.0664 86.03911 30.1562 86.2461 30.2227 curveto
86.46089 30.28911 86.6953 30.3242 86.957 30.3242 curveto
87.1992 30.3242 87.4453 30.293 87.6992 30.2344 curveto
87.9492 30.1758 88.1562 30.10161 88.3203 30.0156 curveto
88.3203 29.2812 lineto
88.2852 29.2812 lineto
88.1094 29.4102 87.8945 29.5195 87.6445 29.6094 curveto
87.3945 29.6992 87.14839 29.7422 86.9062 29.7422 curveto
86.6523 29.7422 86.4414 29.6953 86.2695 29.5977 curveto
86.0938 29.5 86.0078 29.3594 86.0078 29.168 curveto
86.0078 29 86.0625 28.8711 86.16411 28.7852 curveto
86.2695 28.7031 86.4336 28.6328 86.66411 28.5781 curveto
86.78911 28.5508 86.9336 28.5195 87.0898 28.4922 curveto
87.2461 28.46089 87.3789 28.4336 87.4844 28.4102 curveto
87.8008 28.33589 88.0469 28.21089 88.2227 28.0312 curveto
88.3945 27.85161 88.4844 27.6133 88.4844 27.3164 curveto
 closepath fill
newpath 91.5898 26.1758 moveto
91.46089 26.1406 91.3203 26.1133 91.168 26.0898 curveto
91.0156 26.0703 90.8789 26.0586 90.7578 26.0586 curveto
90.3398 26.0586 90.02339 26.168 89.8086 26.3945 curveto
89.5898 26.6172 89.4805 26.97661 89.4805 27.4727 curveto
89.4805 29.64839 lineto
89.0156 29.64839 lineto
89.0156 30.22661 lineto
89.4805 30.22661 lineto
89.4805 31.4023 lineto
90.168 31.4023 lineto
90.168 30.22661 lineto
91.5898 30.22661 lineto
91.5898 29.64839 lineto
90.168 29.64839 lineto
90.168 27.7852 lineto
90.168 27.5703 90.1758 27.4023 90.1836 27.2812 curveto
90.1953 27.1602 90.22661 27.0469 90.2852 26.9453 curveto
90.3398 26.8438 90.41411 26.77339 90.5078 26.72661 curveto
90.60161 26.6836 90.7461 26.6602 90.9375 26.6602 curveto
91.0508 26.6602 91.168 26.6758 91.28911 26.71089 curveto
91.4102 26.7422 91.5 26.7695 91.5547 26.793 curveto
91.5898 26.793 lineto
 closepath fill
newpath 93.1172 26.1367 moveto
92.4297 26.1367 lineto
92.4297 30.22661 lineto
93.1172 30.22661 lineto
 closepath fill
newpath 93.1602 30.9102 moveto
92.3828 30.9102 lineto
92.3828 31.625 lineto
93.1602 31.625 lineto
 closepath fill
newpath 96.60161 26.1758 moveto
96.4727 26.1406 96.332 26.1133 96.1758 26.0898 curveto
96.0273 26.0703 95.8906 26.0586 95.7695 26.0586 curveto
95.35161 26.0586 95.0352 26.168 94.8164 26.3945 curveto
94.60161 26.6172 94.4922 26.97661 94.4922 27.4727 curveto
94.4922 29.64839 lineto
94.0273 29.64839 lineto
94.0273 30.22661 lineto
94.4922 30.22661 lineto
94.4922 31.4023 lineto
95.1797 31.4023 lineto
95.1797 30.22661 lineto
96.60161 30.22661 lineto
96.60161 29.64839 lineto
95.1797 29.64839 lineto
95.1797 27.7852 lineto
95.1797 27.5703 95.1836 27.4023 95.1953 27.2812 curveto
95.2031 27.1602 95.2383 27.0469 95.2969 26.9453 curveto
95.35161 26.8438 95.4258 26.77339 95.5195 26.72661 curveto
95.6133 26.6836 95.7578 26.6602 95.9492 26.6602 curveto
96.0586 26.6602 96.1797 26.6758 96.3008 26.71089 curveto
96.4219 26.7422 96.5078 26.7695 96.5625 26.793 curveto
96.60161 26.793 lineto
 closepath fill
newpath 100.82 26.1367 moveto
100.133 26.1367 lineto
100.133 26.5938 lineto
99.9023 26.4102 99.6797 26.2695 99.4648 26.1719 curveto
99.2539 26.0742 99.0195 26.02339 98.7617 26.02339 curveto
98.332 26.02339 98 26.1562 97.7617 26.418 curveto
97.5195 26.6797 97.4023 27.0664 97.4023 27.5742 curveto
97.4023 30.22661 lineto
98.0898 30.22661 lineto
98.0898 27.89839 lineto
98.0898 27.6914 98.0977 27.5117 98.1172 27.3672 curveto
98.1367 27.2188 98.1797 27.0938 98.2422 26.9883 curveto
98.3086 26.8789 98.3945 26.8008 98.5 26.7539 curveto
98.6055 26.7031 98.7578 26.6797 98.957 26.6797 curveto
99.1367 26.6797 99.332 26.72661 99.53911 26.8203 curveto
99.75 26.9102 99.9492 27.0312 100.133 27.1719 curveto
100.133 30.22661 lineto
100.82 30.22661 lineto
 closepath fill
newpath 104.297 26.1758 moveto
104.168 26.1406 104.027 26.1133 103.875 26.0898 curveto
103.723 26.0703 103.586 26.0586 103.465 26.0586 curveto
103.05101 26.0586 102.73 26.168 102.516 26.3945 curveto
102.297 26.6172 102.188 26.97661 102.188 27.4727 curveto
102.188 29.64839 lineto
101.723 29.64839 lineto
101.723 30.22661 lineto
102.188 30.22661 lineto
102.188 31.4023 lineto
102.879 31.4023 lineto
102.879 30.22661 lineto
104.297 30.22661 lineto
104.297 29.64839 lineto
102.879 29.64839 lineto
102.879 27.7852 lineto
102.879 27.5703 102.883 27.4023 102.891 27.2812 curveto
102.902 27.1602 102.93399 27.0469 102.992 26.9453 curveto
103.047 26.8438 103.121 26.77339 103.215 26.72661 curveto
103.30899 26.6836 103.453 26.6602 103.645 26.6602 curveto
103.758 26.6602 103.875 26.6758 103.996 26.71089 curveto
104.117 26.7422 104.207 26.7695 104.262 26.793 curveto
104.297 26.793 lineto
 closepath fill
newpath 40.3906 20.2148 moveto
40.6094 19.9727 40.7812 19.6719 40.89839 19.3203 curveto
41.0195 18.9648 41.0781 18.5625 41.0781 18.1133 curveto
41.0781 17.66411 41.0156 17.2656 40.8945 16.9102 curveto
40.77339 16.5547 40.6055 16.2578 40.3906 16.02339 curveto
40.16411 15.7734 39.89839 15.5898 39.5938 15.4648 curveto
39.2852 15.3398 38.9375 15.2773 38.543 15.2773 curveto
38.5469 15.9023 lineto
39.0898 15.9023 39.5195 16.0938 39.8438 16.4727 curveto
40.16411 16.85161 40.3242 17.39839 40.3242 18.1133 curveto
40.3242 18.1133 lineto
40.3242 18.8242 40.16411 19.3672 39.8477 19.7539 curveto
39.5312 20.1367 39.0977 20.3281 38.5469 20.3281 curveto
37.9922 20.3281 37.5586 20.1367 37.2422 19.7539 curveto
36.9258 19.3672 36.7695 18.8242 36.7695 18.1133 curveto
36.7695 17.39839 36.9297 16.85161 37.2539 16.4727 curveto
37.5742 16.0938 38.0078 15.9023 38.5469 15.9023 curveto
38.543 15.2773 lineto
38.1602 15.2773 37.8125 15.3398 37.5 15.4688 curveto
37.1875 15.5938 36.918 15.7812 36.6992 16.02339 curveto
36.4805 16.2617 36.3125 16.5586 36.1914 16.9102 curveto
36.0742 17.2617 36.0156 17.66411 36.0156 18.1133 curveto
36.0156 18.5586 36.0742 18.957 36.1914 19.3086 curveto
36.3086 19.66411 36.4805 19.9648 36.7031 20.2148 curveto
36.918 20.4531 37.1836 20.6367 37.5039 20.7656 curveto
37.8203 20.8906 38.168 20.9531 38.543 20.9531 curveto
38.9336 20.9531 39.2852 20.8906 39.5977 20.7617 curveto
39.9062 20.6367 40.1719 20.4531 40.3906 20.2148 curveto
 closepath fill
newpath 45.7695 17.4648 moveto
45.7695 17.125 45.7188 16.8164 45.625 16.543 curveto
45.5273 16.27339 45.39839 16.043 45.2344 15.8555 curveto
45.0586 15.6641 44.8711 15.5195 44.66411 15.4219 curveto
44.457 15.3281 44.22661 15.2773 43.97661 15.2773 curveto
43.7461 15.2773 43.543 15.3047 43.3711 15.3594 curveto
43.1992 15.4141 43.0273 15.4883 42.8594 15.582 curveto
42.8594 16.1289 lineto
43.0547 16.043 43.2227 15.9805 43.3633 15.9492 curveto
43.5039 15.9141 43.6602 15.8984 43.8398 15.8984 curveto
44.2188 15.8984 44.5195 16.02339 44.7344 16.27339 curveto
44.9492 16.52339 45.0586 16.91411 45.0586 17.4492 curveto
45.0586 17.4492 lineto
45.0586 17.9375 44.97661 18.3047 44.8164 18.5586 curveto
44.6562 18.8125 44.39839 18.9375 44.03911 18.9375 curveto
43.8398 18.9375 43.6367 18.8945 43.4297 18.8086 curveto
43.2227 18.7227 43.0352 18.6094 42.8594 18.4727 curveto
42.8594 16.1289 lineto
42.8594 15.582 lineto
42.8164 15.3906 lineto
42.1719 15.3906 lineto
42.1719 21.08589 lineto
42.8594 21.08589 lineto
42.8594 19.0508 lineto
43.0508 19.21089 43.2578 19.3398 43.4727 19.4414 curveto
43.6914 19.543 43.9336 19.5938 44.207 19.5938 curveto
44.6875 19.5938 45.0703 19.4062 45.3477 19.0352 curveto
45.6289 18.66411 45.7695 18.1445 45.7695 17.4648 curveto
 closepath fill
newpath 50.2617 17.3633 moveto
47.25 17.3633 lineto
47.25 17.8906 lineto
49.5938 17.8906 lineto
49.5898 18.2539 49.5 18.5312 49.3203 18.7305 curveto
49.1406 18.9258 48.8672 19.0273 48.5039 19.0273 curveto
48.1328 19.0273 47.8398 18.918 47.6211 18.6992 curveto
47.4062 18.4844 47.2812 18.2148 47.25 17.8906 curveto
47.25 17.3633 lineto
47.25 17.1133 47.28911 16.8945 47.3633 16.707 curveto
47.4414 16.5195 47.543 16.3672 47.6758 16.25 curveto
47.8008 16.1328 47.9531 16.043 48.1289 15.9844 curveto
48.3008 15.9258 48.4922 15.8984 48.7031 15.8984 curveto
48.9805 15.8984 49.2617 15.9531 49.543 16.0625 curveto
49.8242 16.1758 50.0273 16.2852 50.14839 16.3906 curveto
50.1836 16.3906 lineto
50.1836 15.6406 lineto
49.9492 15.543 49.7148 15.4609 49.4727 15.3945 curveto
49.2305 15.3281 48.97661 15.2969 48.71089 15.2969 curveto
48.0312 15.2969 47.5039 15.4805 47.125 15.8477 curveto
46.7422 16.2148 46.5508 16.7344 46.5508 17.41411 curveto
46.5508 18.082 46.7344 18.6094 47.0977 19.0039 curveto
47.4648 19.39839 47.9453 19.5938 48.53911 19.5938 curveto
49.0898 19.5938 49.5156 19.4336 49.8164 19.1094 curveto
50.1133 18.78911 50.2617 18.332 50.2617 17.7383 curveto
 closepath fill
newpath 53.8555 18.7305 moveto
53.8203 18.7305 lineto
53.7188 18.7539 53.6172 18.77339 53.52339 18.7812 curveto
53.4258 18.793 53.3125 18.8008 53.1797 18.8008 curveto
52.9688 18.8008 52.7617 18.75 52.5664 18.6602 curveto
52.3672 18.5664 52.1758 18.4414 51.9922 18.293 curveto
51.9922 15.3906 lineto
51.3047 15.3906 lineto
51.3047 19.4805 lineto
51.9922 19.4805 lineto
51.9922 18.875 lineto
52.2656 19.0938 52.5078 19.25 52.7188 19.3438 curveto
52.9258 19.4336 53.1367 19.4805 53.3555 19.4805 curveto
53.47661 19.4805 53.5625 19.47661 53.6133 19.4688 curveto
53.668 19.4648 53.75 19.4531 53.8555 19.4336 curveto
 closepath fill
newpath 59.64839 19.4805 moveto
58.582 15.3906 lineto
57.9453 15.3906 lineto
56.8945 18.543 lineto
55.85161 15.3906 lineto
55.2188 15.3906 lineto
54.1445 19.4805 lineto
54.8594 19.4805 lineto
55.6094 16.3125 lineto
56.6328 19.4805 lineto
57.1992 19.4805 lineto
58.2461 16.3125 lineto
58.957 19.4805 lineto
 closepath fill
newpath 64.1211 17.4336 moveto
64.1211 16.7695 63.9531 16.2422 63.6094 15.8555 curveto
63.2695 15.4727 62.8125 15.2773 62.2383 15.2773 curveto
61.6602 15.2773 61.1992 15.4727 60.8594 15.8555 curveto
60.5195 16.2422 60.35161 16.7695 60.35161 17.4336 curveto
60.35161 18.10161 60.5195 18.6289 60.8594 19.0117 curveto
61.1992 19.39839 61.6602 19.5938 62.2383 19.5938 curveto
62.2383 19 lineto
61.8633 19 61.5742 18.8711 61.3672 18.6133 curveto
61.16411 18.3555 61.0586 17.9648 61.0586 17.4336 curveto
61.0586 16.9219 61.16411 16.5312 61.3711 16.2695 curveto
61.5781 16.0039 61.8672 15.8711 62.2383 15.8711 curveto
62.6055 15.8711 62.8906 16.0039 63.10161 16.2656 curveto
63.3086 16.5273 63.41411 16.918 63.41411 17.4336 curveto
63.41411 17.4336 lineto
63.41411 17.9648 63.3086 18.3555 63.10161 18.6133 curveto
62.8945 18.8711 62.6055 19 62.2383 19 curveto
62.2383 19.5938 lineto
62.8125 19.5938 63.2695 19.39839 63.6094 19.0117 curveto
63.9531 18.6289 64.1211 18.10161 64.1211 17.4336 curveto
 closepath fill
newpath 65.1953 15.3906 moveto
65.8828 15.3906 lineto
65.8828 21.08589 lineto
65.1953 21.08589 lineto
 closepath fill
newpath 69.4453 20.4219 moveto
69.4062 20.4219 lineto
69.332 20.4414 69.2344 20.4648 69.1094 20.4883 curveto
68.9883 20.5117 68.8828 20.52339 68.78911 20.52339 curveto
68.4922 20.52339 68.2812 20.457 68.14839 20.3281 curveto
68.0156 20.1953 67.9492 19.96089 67.9492 19.6172 curveto
67.9492 19.4805 lineto
69.1875 19.4805 lineto
69.1875 18.9023 lineto
67.9688 18.9023 lineto
67.9688 15.3906 lineto
67.2812 15.3906 lineto
67.2812 18.9023 lineto
66.8164 18.9023 lineto
66.8164 19.4805 lineto
67.2812 19.4805 lineto
67.2812 19.6133 lineto
67.2812 20.10161 67.4023 20.4727 67.6445 20.7344 curveto
67.8867 20.9922 68.2344 21.125 68.6914 21.125 curveto
68.8438 21.125 68.9805 21.1133 69.1055 21.10161 curveto
69.2305 21.08589 69.3438 21.0703 69.4453 21.0508 curveto
 closepath fill
newpath 73.0586 15.3906 moveto
72.3711 15.3906 lineto
72.3711 15.8281 lineto
72.3125 15.7852 72.2305 15.7266 72.125 15.6523 curveto
71.8164 16.0586 lineto
72.0156 16.1523 72.2031 16.2656 72.3711 16.39839 curveto
72.3711 16.39839 lineto
72.3711 17.5352 lineto
72.1602 17.52339 71.91411 17.5078 71.6328 17.4805 curveto
71.3477 17.457 71.1211 17.4219 70.957 17.375 curveto
70.7578 17.3203 70.5977 17.2305 70.47661 17.1133 curveto
70.3555 16.9961 70.293 16.832 70.293 16.625 curveto
70.293 16.3906 70.3633 16.2148 70.5078 16.0977 curveto
70.64839 15.9766 70.8633 15.918 71.1523 15.918 curveto
71.3945 15.918 71.6172 15.9648 71.8164 16.0586 curveto
72.125 15.6523 lineto
72.02339 15.5781 71.9219 15.5195 71.8242 15.4766 curveto
71.71089 15.4219 71.5781 15.3711 71.4297 15.3359 curveto
71.2773 15.2969 71.1055 15.2773 70.9062 15.2773 curveto
70.5352 15.2773 70.2227 15.4023 69.9688 15.6445 curveto
69.71089 15.8867 69.58589 16.1992 69.58589 16.5781 curveto
69.58589 16.8867 69.64839 17.1367 69.7812 17.3281 curveto
69.91411 17.5195 70.1055 17.6719 70.35161 17.7812 curveto
70.60161 17.8906 70.89839 17.9648 71.25 18.0039 curveto
71.5977 18.043 71.9727 18.0742 72.3711 18.0938 curveto
72.3711 18.1992 lineto
72.3711 18.3555 72.3438 18.4844 72.28911 18.58589 curveto
72.2344 18.6875 72.1562 18.7695 72.0547 18.8281 curveto
71.957 18.8828 71.8398 18.9219 71.7031 18.9414 curveto
71.5664 18.96089 71.4219 18.9727 71.27339 18.9727 curveto
71.0938 18.9727 70.8906 18.9492 70.6719 18.9023 curveto
70.4492 18.85161 70.2188 18.7812 69.9805 18.6953 curveto
69.9453 18.6953 lineto
69.9453 19.3906 lineto
70.082 19.4297 70.27339 19.4688 70.5273 19.5117 curveto
70.7812 19.5547 71.0312 19.5781 71.2773 19.5781 curveto
71.5664 19.5781 71.8164 19.5547 72.0312 19.5078 curveto
72.2422 19.46089 72.4297 19.3789 72.58589 19.2656 curveto
72.7383 19.1523 72.8555 19.0078 72.9375 18.8281 curveto
73.0156 18.6523 73.0586 18.4297 73.0586 18.16411 curveto
 closepath fill
newpath 77.4062 15.6484 moveto
77.1758 15.5391 76.957 15.4531 76.75 15.3906 curveto
76.5469 15.332 76.3281 15.3008 76.0938 15.3008 curveto
75.8008 15.3008 75.5273 15.3438 75.2812 15.4297 curveto
75.0352 15.5156 74.8242 15.6484 74.64839 15.8242 curveto
74.4688 16 74.332 16.2227 74.2344 16.4883 curveto
74.1367 16.7578 74.0898 17.0703 74.0898 17.4297 curveto
74.0898 18.0977 74.27339 18.6211 74.6406 19.0039 curveto
75.0078 19.3867 75.4922 19.5742 76.0938 19.5742 curveto
76.3281 19.5742 76.5586 19.543 76.7852 19.47661 curveto
77.0117 19.4102 77.2188 19.332 77.4062 19.2344 curveto
77.4062 18.4688 lineto
77.3672 18.4688 lineto
77.1562 18.6328 76.9414 18.7578 76.7188 18.8477 curveto
76.4961 18.9336 76.2773 18.97661 76.0664 18.97661 curveto
75.6758 18.97661 75.3672 18.8477 75.1406 18.58589 curveto
74.91411 18.3242 74.8008 17.9375 74.8008 17.4297 curveto
74.8008 16.9375 74.91411 16.5586 75.1328 16.293 curveto
75.3555 16.0273 75.66411 15.8984 76.0664 15.8984 curveto
76.2031 15.8984 76.3438 15.9141 76.4883 15.9531 curveto
76.6328 15.9883 76.7656 16.0352 76.8789 16.0938 curveto
76.97661 16.1445 77.0703 16.1992 77.1602 16.2578 curveto
77.2461 16.3164 77.3164 16.3633 77.3672 16.4062 curveto
77.4062 16.4062 lineto
 closepath fill
newpath 81.707 15.3906 moveto
81.0156 15.3906 lineto
81.0156 17.7188 lineto
81.0156 17.9062 81.0078 18.082 80.9844 18.25 curveto
80.96089 18.41411 80.9219 18.543 80.8633 18.6367 curveto
80.8008 18.7383 80.7148 18.8125 80.5977 18.8633 curveto
80.4844 18.91411 80.33589 18.9375 80.1523 18.9375 curveto
79.9648 18.9375 79.7695 18.8906 79.5625 18.7969 curveto
79.3594 18.707 79.16411 18.5898 78.97661 18.4453 curveto
78.97661 15.3906 lineto
78.2852 15.3906 lineto
78.2852 21.08589 lineto
78.97661 21.08589 lineto
78.97661 19.0273 lineto
79.1875 19.2031 79.4102 19.3438 79.6406 19.4414 curveto
79.8711 19.543 80.1055 19.5938 80.3477 19.5938 curveto
80.78911 19.5938 81.125 19.46089 81.3555 19.1953 curveto
81.5898 18.9297 81.707 18.5469 81.707 18.043 curveto
 closepath fill
 0.02 0.024 0.024 setrgbcolor
newpath 321.176 25.6562 moveto
321.176 22.3047 lineto
322.72699 22.3047 lineto
323.082 22.3047 323.344 22.3828 323.508 22.5352 curveto
323.676 22.6953 323.789 23.0078 323.84 23.4727 curveto
324.074 23.4727 lineto
324.074 20.582 lineto
323.84 20.582 lineto
323.84 20.91411 323.797 21.1562 323.715 21.3164 curveto
323.629 21.4688 323.51599 21.58589 323.371 21.6602 curveto
323.22699 21.7383 323.012 21.7773 322.72699 21.7773 curveto
321.176 21.7773 lineto
321.176 19.10161 lineto
321.176 18.668 321.199 18.3828 321.254 18.2461 curveto
321.297 18.1367 321.387 18.0508 321.51999 17.9727 curveto
321.703 17.875 321.89801 17.8203 322.09799 17.8203 curveto
322.406 17.8203 lineto
322.406 17.5898 lineto
318.742 17.5898 lineto
318.742 17.8203 lineto
319.047 17.8203 lineto
319.40201 17.8203 319.65201 17.9219 319.81201 18.1328 curveto
319.914 18.2656 319.965 18.58589 319.965 19.10161 curveto
319.965 24.6094 lineto
319.965 25.043 319.93799 25.332 319.883 25.4688 curveto
319.84 25.5742 319.758 25.6602 319.625 25.7383 curveto
319.445 25.8398 319.254 25.8867 319.047 25.8867 curveto
318.742 25.8867 lineto
318.742 26.1211 lineto
325.094 26.1211 lineto
325.176 24.2461 lineto
324.953 24.2461 lineto
324.84799 24.6445 324.719 24.9375 324.574 25.125 curveto
324.43 25.3125 324.25 25.4453 324.039 25.5312 curveto
323.828 25.6172 323.5 25.6562 323.055 25.6562 curveto
 closepath fill
newpath 330.672 26.3164 moveto
331.781 26.3164 332.742 25.8945 333.555 25.0547 curveto
334.367 24.2148 334.76999 23.16411 334.76999 21.9062 curveto
334.76999 20.6094 334.363 19.5312 333.547 18.6797 curveto
332.72699 17.8203 331.73401 17.3945 330.574 17.3945 curveto
330.56201 17.8438 lineto
331.35901 17.8438 332.02301 18.1523 332.547 18.7773 curveto
333.06601 19.4062 333.328 20.3906 333.328 21.7344 curveto
333.328 23.1953 333.043 24.2812 332.469 25.0039 curveto
332.008 25.5742 331.367 25.8555 330.55899 25.8555 curveto
330.55899 25.8555 lineto
329.789 25.8555 329.176 25.5742 328.719 25.0078 curveto
328.14499 24.3047 327.85501 23.2695 327.85501 21.91411 curveto
327.85501 20.5195 328.156 19.4492 328.75 18.6953 curveto
329.203 18.1289 329.80899 17.8438 330.56201 17.8438 curveto
330.574 17.3945 lineto
329.39801 17.3945 328.41 17.8086 327.60901 18.64839 curveto
326.81201 19.4805 326.414 20.5625 326.414 21.8906 curveto
326.414 23.2422 326.879 24.3438 327.797 25.2031 curveto
328.59799 25.9492 329.55899 26.3164 330.672 26.3164 curveto
 closepath fill
newpath 341.676 25.8867 moveto
341.676 26.1211 lineto
344.69101 26.1211 lineto
344.69101 25.8867 lineto
344.371 25.8867 lineto
344.035 25.8867 343.781 25.7461 343.59799 25.4688 curveto
343.512 25.33589 343.465 25.0352 343.465 24.5625 curveto
343.465 21.10161 lineto
343.465 20.2461 343.383 19.582 343.211 19.1094 curveto
343.043 18.6367 342.707 18.2344 342.211 17.8945 curveto
341.715 17.5586 341.039 17.3867 340.18 17.3867 curveto
339.25 17.3867 338.543 17.5508 338.06201 17.875 curveto
337.578 18.1953 337.23401 18.6289 337.035 19.1758 curveto
336.90201 19.5508 336.836 20.2461 336.836 21.2773 curveto
336.836 24.6094 lineto
336.836 25.1367 336.762 25.47661 336.617 25.6445 curveto
336.47299 25.8086 336.238 25.8867 335.914 25.8867 curveto
335.594 25.8867 lineto
335.594 26.1211 lineto
339.281 26.1211 lineto
339.281 25.8867 lineto
338.953 25.8867 lineto
338.60199 25.8867 338.35199 25.7773 338.199 25.5547 curveto
338.094 25.4023 338.039 25.0898 338.039 24.6094 curveto
338.039 20.8945 lineto
338.039 20.5625 338.07 20.1797 338.133 19.7539 curveto
338.19101 19.3281 338.305 18.9922 338.465 18.7539 curveto
338.621 18.5156 338.85199 18.3203 339.15201 18.16411 curveto
339.453 18.0078 339.82 17.9297 340.258 17.9297 curveto
340.81601 17.9297 341.31201 18.0508 341.754 18.293 curveto
342.195 18.5352 342.496 18.8477 342.656 19.2305 curveto
342.82 19.6094 342.90201 20.25 342.90201 21.1562 curveto
342.90201 24.6094 lineto
342.90201 25.1445 342.84 25.47661 342.72699 25.6133 curveto
342.55899 25.7969 342.31601 25.8867 341.996 25.8867 curveto
 closepath fill
newpath 345.176 26.1211 moveto
347.492 26.1211 lineto
352.711 19.7227 lineto
352.711 24.6445 lineto
352.711 25.168 352.64801 25.4922 352.535 25.6211 curveto
352.379 25.8008 352.133 25.8867 351.797 25.8867 curveto
351.5 25.8867 lineto
351.5 26.1211 lineto
354.469 26.1211 lineto
354.469 25.8867 lineto
354.172 25.8867 lineto
353.80899 25.8867 353.555 25.7773 353.40201 25.5625 curveto
353.30899 25.4297 353.262 25.1211 353.262 24.6445 curveto
353.262 17.4531 lineto
353.035 17.4531 lineto
347.41 24.3203 lineto
347.41 19.0703 lineto
347.41 18.543 347.469 18.2148 347.582 18.08589 curveto
347.738 17.9102 347.98401 17.8203 348.31601 17.8203 curveto
348.617 17.8203 lineto
348.617 17.5898 lineto
345.64801 17.5898 lineto
345.64801 17.8203 lineto
345.945 17.8203 lineto
346.30899 17.8203 346.57 17.9297 346.719 18.14839 curveto
346.80899 18.2852 346.85901 18.5898 346.85901 19.0703 curveto
346.85901 25.0039 lineto
346.60901 25.28911 346.422 25.4805 346.297 25.5742 curveto
346.168 25.66411 345.97699 25.7539 345.73001 25.832 curveto
345.60901 25.8711 345.422 25.8867 345.176 25.8867 curveto
 closepath fill
newpath 355.129 17.5898 moveto
355.129 17.8203 lineto
355.449 17.8203 lineto
355.81201 17.8203 356.06601 17.9375 356.219 18.168 curveto
356.31201 18.3086 356.35501 18.6172 356.35501 19.10161 curveto
356.35501 24.6094 lineto
356.35501 25.1445 356.301 25.47661 356.18 25.6133 curveto
356.01999 25.7969 355.77301 25.8867 355.449 25.8867 curveto
355.129 25.8867 lineto
355.129 26.1211 lineto
358.60501 26.1211 lineto
359.879 26.1211 360.85199 25.97661 361.512 25.6875 curveto
362.18 25.39839 362.711 24.91411 363.117 24.2383 curveto
363.52301 23.5625 363.72299 22.7852 363.72299 21.89839 curveto
363.72299 20.7148 363.363 19.7188 362.64499 18.9219 curveto
361.836 18.0312 360.59799 17.5898 358.945 17.5898 curveto
358.906 18.0273 lineto
359.879 18.0273 360.68799 18.3711 361.328 19.0547 curveto
361.97299 19.7383 362.289 20.668 362.289 21.83589 curveto
362.289 23.0156 361.97299 23.9453 361.328 24.625 curveto
360.68799 25.3047 359.863 25.6445 358.85501 25.6445 curveto
358.47699 25.6445 358.051 25.58589 357.56601 25.46089 curveto
357.56601 18.207 lineto
358.09799 18.0898 358.547 18.0273 358.906 18.0273 curveto
358.945 17.5898 lineto
 closepath fill
newpath 369.85501 20.4453 moveto
369.68 20.9102 lineto
368.23001 24.3594 lineto
366.746 20.9102 lineto
369.68 20.9102 lineto
369.85501 20.4453 lineto
366.555 20.4453 lineto
365.97299 19.0977 lineto
365.828 18.7656 365.758 18.5195 365.758 18.3594 curveto
365.758 18.22661 365.82 18.1133 365.94101 18.0156 curveto
366.06601 17.91411 366.336 17.85161 366.746 17.8203 curveto
366.746 17.5898 lineto
364.05899 17.5898 lineto
364.05899 17.8203 lineto
364.414 17.8828 364.64499 17.9648 364.75 18.0703 curveto
364.965 18.2695 365.203 18.6797 365.465 19.2969 curveto
368.465 26.3203 lineto
368.68399 26.3203 lineto
371.65201 19.2188 lineto
371.89499 18.6523 372.10901 18.2812 372.305 18.1094 curveto
372.5 17.9375 372.76999 17.8438 373.121 17.8203 curveto
373.121 17.5898 lineto
369.758 17.5898 lineto
369.758 17.8203 lineto
370.094 17.8398 370.324 17.8945 370.445 17.9922 curveto
370.56201 18.0898 370.621 18.207 370.621 18.3438 curveto
370.621 18.5312 370.539 18.8203 370.371 19.2188 curveto
 closepath fill
newpath 379.293 26.1211 moveto
379.387 24.1211 lineto
379.14801 24.1211 lineto
379.10199 24.4727 379.039 24.7227 378.961 24.875 curveto
378.832 25.1172 378.656 25.2969 378.43799 25.41411 curveto
378.22299 25.5273 377.94101 25.58589 377.586 25.58589 curveto
376.387 25.58589 lineto
376.387 19.0703 lineto
376.387 18.543 376.44101 18.2148 376.555 18.08589 curveto
376.715 17.9102 376.961 17.8203 377.293 17.8203 curveto
377.586 17.8203 lineto
377.586 17.5898 lineto
373.969 17.5898 lineto
373.969 17.8203 lineto
374.26999 17.8203 lineto
374.633 17.8203 374.887 17.9297 375.039 18.14839 curveto
375.133 18.2852 375.176 18.5898 375.176 19.0703 curveto
375.176 25.58589 lineto
374.15201 25.58589 lineto
373.754 25.58589 373.469 25.5547 373.305 25.5 curveto
373.086 25.418 372.89801 25.2656 372.742 25.0352 curveto
372.59 24.8125 372.496 24.5039 372.465 24.1211 curveto
372.22699 24.1211 lineto
372.328 26.1211 lineto
 closepath fill
newpath 383.68399 17.8203 moveto
383.68399 17.5898 lineto
380.031 17.5898 lineto
380.031 17.8203 lineto
380.332 17.8203 lineto
380.68399 17.8203 380.94101 17.9219 381.09799 18.1328 curveto
381.199 18.2656 381.25 18.58589 381.25 19.10161 curveto
381.25 24.6094 lineto
381.25 25.043 381.22299 25.332 381.168 25.4688 curveto
381.129 25.5742 381.039 25.66411 380.91 25.7383 curveto
380.72699 25.8398 380.535 25.8867 380.332 25.8867 curveto
380.031 25.8867 lineto
380.031 26.1211 lineto
383.68399 26.1211 lineto
383.68399 25.8867 lineto
383.379 25.8867 lineto
383.02701 25.8867 382.77301 25.7852 382.613 25.582 curveto
382.508 25.4453 382.457 25.1211 382.457 24.6094 curveto
382.457 19.10161 lineto
382.457 18.668 382.48401 18.3828 382.539 18.2461 curveto
382.578 18.1367 382.672 18.0508 382.801 17.9727 curveto
382.98401 17.875 383.176 17.8203 383.379 17.8203 curveto
 closepath fill
newpath 388.97299 26.3164 moveto
390.078 26.3164 391.039 25.8945 391.85199 25.0547 curveto
392.66 24.2148 393.06601 23.16411 393.06601 21.9062 curveto
393.06601 20.6094 392.656 19.5312 391.84 18.6797 curveto
391.01999 17.8203 390.031 17.3945 388.867 17.3945 curveto
388.85501 17.8438 lineto
389.66 17.8438 390.32 18.1523 390.844 18.7773 curveto
391.367 19.4062 391.629 20.3906 391.629 21.7344 curveto
391.629 23.1953 391.34 24.2812 390.762 25.0039 curveto
390.301 25.5742 389.66 25.8555 388.85199 25.8555 curveto
388.85199 25.8555 lineto
388.086 25.8555 387.47699 25.5742 387.01599 25.0078 curveto
386.43799 24.3047 386.14801 23.2695 386.14801 21.91411 curveto
386.14801 20.5195 386.449 19.4492 387.047 18.6953 curveto
387.5 18.1289 388.10501 17.8438 388.85501 17.8438 curveto
388.867 17.3945 lineto
387.695 17.3945 386.707 17.8086 385.91 18.64839 curveto
385.10901 19.4805 384.711 20.5625 384.711 21.8906 curveto
384.711 23.2422 385.172 24.3438 386.09799 25.2031 curveto
386.89499 25.9492 387.85199 26.3164 388.97299 26.3164 curveto
 closepath fill
newpath 393.65201 26.1211 moveto
395.969 26.1211 lineto
401.18399 19.7227 lineto
401.18399 24.6445 lineto
401.18399 25.168 401.125 25.4922 401.004 25.6211 curveto
400.85199 25.8008 400.60501 25.8867 400.26999 25.8867 curveto
399.97699 25.8867 lineto
399.97699 26.1211 lineto
402.945 26.1211 lineto
402.945 25.8867 lineto
402.64099 25.8867 lineto
402.281 25.8867 402.02301 25.7773 401.879 25.5625 curveto
401.781 25.4297 401.73401 25.1211 401.73401 24.6445 curveto
401.73401 17.4531 lineto
401.508 17.4531 lineto
395.883 24.3203 lineto
395.883 19.0703 lineto
395.883 18.543 395.94101 18.2148 396.055 18.08589 curveto
396.215 17.9102 396.461 17.8203 396.789 17.8203 curveto
397.094 17.8203 lineto
397.094 17.5898 lineto
394.121 17.5898 lineto
394.121 17.8203 lineto
394.422 17.8203 lineto
394.785 17.8203 395.039 17.9297 395.19101 18.14839 curveto
395.285 18.2852 395.328 18.5898 395.328 19.0703 curveto
395.328 25.0039 lineto
395.086 25.28911 394.89499 25.4805 394.76999 25.5742 curveto
394.64099 25.66411 394.453 25.7539 394.203 25.832 curveto
394.086 25.8711 393.89801 25.8867 393.65201 25.8867 curveto
 closepath fill
newpath 322.949 36.2148 moveto
324.055 36.2148 324.969 35.8164 325.68799 35.0156 curveto
326.34799 34.28911 326.676 33.4297 326.676 32.4336 curveto
326.676 31.4297 326.332 30.5625 325.633 29.8125 curveto
324.93799 29.0664 324.043 28.6914 322.949 28.6914 curveto
322.945 29.5664 lineto
323.457 29.5664 323.926 29.6875 324.35199 29.9297 curveto
324.781 30.1719 325.117 30.5195 325.367 30.9688 curveto
325.617 31.41411 325.746 31.8945 325.746 32.41411 curveto
325.746 33.2188 325.469 33.89839 324.918 34.4648 curveto
324.363 35.0312 323.707 35.3125 322.945 35.3125 curveto
322.945 35.3125 lineto
322.18 35.3125 321.52301 35.0312 320.97299 34.4648 curveto
320.422 33.89839 320.14801 33.2188 320.14801 32.41411 curveto
320.14801 31.8945 320.27301 31.41411 320.52301 30.9688 curveto
320.77701 30.5195 321.113 30.1719 321.543 29.9297 curveto
321.969 29.6875 322.43799 29.5664 322.945 29.5664 curveto
322.949 28.6914 lineto
321.85199 28.6914 320.957 29.0664 320.258 29.8125 curveto
319.56201 30.5625 319.215 31.4297 319.215 32.4336 curveto
319.215 33.4258 319.543 34.2812 320.199 35.0117 curveto
320.93 35.8125 321.844 36.2148 322.949 36.2148 curveto
 closepath fill
newpath 328.44101 28.875 moveto
328.44101 38.793 lineto
329.35901 38.793 lineto
329.35901 34.8008 lineto
329.75 35.27339 330.18 35.6289 330.656 35.8594 curveto
331.137 36.0977 331.656 36.2148 332.22699 36.2148 curveto
333.238 36.2148 334.10199 35.8477 334.81601 35.1094 curveto
335.531 34.3789 335.89499 33.4883 335.89499 32.4375 curveto
335.89499 31.4023 335.531 30.52339 334.805 29.78911 curveto
334.082 29.0547 333.215 28.6914 332.199 28.6914 curveto
331.617 28.6914 331.09 28.8164 330.617 29.0664 curveto
330.14499 29.3164 329.72299 29.6914 329.35901 30.1914 curveto
330.113 30.41411 lineto
330.656 29.8555 331.328 29.5781 332.121 29.5781 curveto
332.121 29.5781 lineto
332.637 29.5781 333.10501 29.7031 333.539 29.957 curveto
333.97299 30.207 334.32 30.5586 334.574 31.0195 curveto
334.832 31.4727 334.957 31.957 334.957 32.4648 curveto
334.957 32.9727 334.828 33.457 334.57 33.918 curveto
334.31201 34.3789 333.969 34.7344 333.531 34.9961 curveto
333.09799 35.2539 332.629 35.3789 332.137 35.3789 curveto
331.633 35.3789 331.156 35.2539 330.703 34.9961 curveto
330.25 34.7344 329.90201 34.3906 329.66 33.957 curveto
329.418 33.52339 329.297 33.0352 329.297 32.4922 curveto
329.297 31.66411 329.57 30.9688 330.113 30.41411 curveto
329.35901 30.1914 lineto
329.35901 28.875 lineto
 closepath fill
newpath 343.594 31.25 moveto
344.367 30.8398 lineto
344.113 30.3438 343.82 29.9375 343.48401 29.6289 curveto
343.156 29.3242 342.77701 29.0898 342.35901 28.9297 curveto
341.945 28.7695 341.47299 28.6914 340.945 28.6914 curveto
339.781 28.6914 338.867 29.0742 338.211 29.8398 curveto
337.551 30.60161 337.219 31.4688 337.219 32.4336 curveto
337.219 33.3398 337.5 34.14839 338.05899 34.8594 curveto
338.76599 35.7656 339.711 36.2148 340.89499 36.2148 curveto
342.113 36.2148 343.09 35.7539 343.82 34.8242 curveto
344.332 34.1719 344.59799 33.3555 344.60901 32.3789 curveto
338.168 32.3789 lineto
338.258 33.1758 lineto
343.594 33.1758 lineto
343.469 33.668 343.293 34.0586 343.05899 34.35161 curveto
342.82 34.6445 342.512 34.8867 342.125 35.0625 curveto
341.738 35.2422 341.332 35.332 340.91 35.332 curveto
340.207 35.332 339.60199 35.1055 339.09799 34.6562 curveto
338.73001 34.3281 338.449 33.832 338.258 33.1758 curveto
338.168 32.3789 lineto
338.18399 31.5469 338.449 30.8672 338.965 30.33589 curveto
339.47699 29.8047 340.10901 29.53911 340.867 29.53911 curveto
341.23401 29.53911 341.586 29.60161 341.93399 29.72661 curveto
342.27701 29.8555 342.57 30.0273 342.80899 30.2305 curveto
343.055 30.4414 343.31201 30.7812 343.594 31.25 curveto
 closepath fill
newpath 345.97299 36.0312 moveto
346.914 36.0312 lineto
346.914 34.9844 lineto
347.195 35.39839 347.488 35.7031 347.805 35.9062 curveto
348.113 36.1133 348.43799 36.2148 348.77701 36.2148 curveto
349.031 36.2148 349.305 36.1328 349.594 35.9688 curveto
349.113 35.1953 lineto
348.918 35.2773 348.758 35.3203 348.625 35.3203 curveto
348.32 35.3203 348.02301 35.1953 347.73401 34.9414 curveto
347.449 34.6875 347.23401 34.3008 347.086 33.7656 curveto
346.97299 33.3594 346.914 32.5352 346.914 31.293 curveto
346.914 28.875 lineto
345.97299 28.875 lineto
 closepath fill
newpath 349.945 36.0312 moveto
350.89499 36.0312 lineto
353.086 30.83589 lineto
355.367 36.0312 lineto
355.535 36.0312 lineto
357.836 30.83589 lineto
360.07 36.0312 lineto
361.02701 36.0312 lineto
357.922 28.875 lineto
357.746 28.875 lineto
355.461 33.9961 lineto
353.176 28.875 lineto
353.004 28.875 lineto
 closepath fill
newpath 365.492 36.2148 moveto
366.59799 36.2148 367.512 35.8164 368.23001 35.0156 curveto
368.89099 34.28911 369.219 33.4297 369.219 32.4336 curveto
369.219 31.4297 368.875 30.5625 368.176 29.8125 curveto
367.48001 29.0664 366.586 28.6914 365.492 28.6914 curveto
365.488 29.5664 lineto
366 29.5664 366.469 29.6875 366.89499 29.9297 curveto
367.324 30.1719 367.66 30.5195 367.91 30.9688 curveto
368.16 31.41411 368.289 31.8945 368.289 32.41411 curveto
368.289 33.2188 368.012 33.89839 367.461 34.4648 curveto
366.906 35.0312 366.25 35.3125 365.488 35.3125 curveto
365.488 35.3125 lineto
364.72299 35.3125 364.06601 35.0312 363.51599 34.4648 curveto
362.965 33.89839 362.69101 33.2188 362.69101 32.41411 curveto
362.69101 31.8945 362.81601 31.41411 363.06601 30.9688 curveto
363.32 30.5195 363.656 30.1719 364.086 29.9297 curveto
364.512 29.6875 364.98001 29.5664 365.488 29.5664 curveto
365.492 28.6914 lineto
364.39499 28.6914 363.496 29.0664 362.801 29.8125 curveto
362.10501 30.5625 361.758 31.4297 361.758 32.4336 curveto
361.758 33.4258 362.086 34.2812 362.742 35.0117 curveto
363.47299 35.8125 364.387 36.2148 365.492 36.2148 curveto
 closepath fill
newpath 370.785 28.875 moveto
371.707 28.875 lineto
371.707 38.793 lineto
370.785 38.793 lineto
 closepath fill
newpath 376.56601 38.793 moveto
376.56601 37.8906 lineto
376.23001 38.0352 375.94101 38.1094 375.699 38.1094 curveto
375.51999 38.1094 375.371 38.0703 375.25 38 curveto
375.133 37.9297 375.06201 37.8438 375.02701 37.75 curveto
374.996 37.6523 374.98001 37.4023 374.98001 36.9961 curveto
374.98001 36.0312 lineto
376.47699 36.0312 lineto
376.47699 35.2344 lineto
374.98001 35.2344 lineto
374.97699 28.875 lineto
374.055 28.875 lineto
374.055 35.2344 lineto
373.113 35.2344 lineto
373.113 36.0312 lineto
374.055 36.0312 lineto
374.055 37.14839 lineto
374.055 37.6602 374.10199 38.0273 374.195 38.2461 curveto
374.293 38.4648 374.449 38.6406 374.676 38.7773 curveto
374.90201 38.9102 375.176 38.97661 375.496 38.97661 curveto
375.797 38.97661 376.14801 38.918 376.56601 38.793 curveto
 closepath fill
newpath 384.97699 36.0312 moveto
384.97699 28.875 lineto
384.074 28.875 lineto
384.074 30.1055 lineto
383.68399 29.6367 383.254 29.2812 382.77301 29.043 curveto
382.289 28.8086 381.76599 28.6914 381.199 28.6914 curveto
380.18799 28.6914 379.32 29.0586 378.60199 29.793 curveto
377.887 30.5273 377.52701 31.4219 377.52701 32.4727 curveto
377.52701 33.5039 377.89099 34.3828 378.613 35.1133 curveto
379.336 35.8477 380.207 36.2148 381.22299 36.2148 curveto
381.81201 36.2148 382.344 36.08589 382.82 35.8398 curveto
383.293 35.5898 383.711 35.2148 384.074 34.7148 curveto
383.31201 34.4922 lineto
382.76599 35.0469 382.09799 35.3281 381.301 35.3281 curveto
381.301 35.3281 lineto
380.785 35.3281 380.31601 35.1992 379.883 34.9492 curveto
379.449 34.6992 379.10199 34.3438 378.844 33.8867 curveto
378.59 33.4336 378.461 32.9531 378.461 32.4414 curveto
378.461 31.9414 378.59 31.457 378.84799 30.9961 curveto
379.10501 30.5352 379.453 30.1797 379.89099 29.9219 curveto
380.328 29.668 380.797 29.5352 381.293 29.5352 curveto
381.797 29.5352 382.27301 29.66411 382.72699 29.918 curveto
383.176 30.1719 383.51999 30.5195 383.76599 30.9531 curveto
384.008 31.3867 384.133 31.8711 384.133 32.41411 curveto
384.133 33.2461 383.85501 33.9375 383.31201 34.4922 curveto
384.074 34.7148 lineto
384.074 36.0312 lineto
 closepath fill
newpath 393.996 34.543 moveto
393.26599 34.0898 lineto
392.637 34.9258 391.77301 35.3477 390.68399 35.3477 curveto
389.80899 35.3477 389.09 35.0664 388.512 34.5039 curveto
387.93799 33.9414 387.64801 33.2617 387.64801 32.46089 curveto
387.64801 31.9414 387.781 31.4492 388.047 30.9922 curveto
388.31201 30.5312 388.676 30.1719 389.137 29.918 curveto
389.59799 29.66411 390.117 29.53911 390.69101 29.53911 curveto
391.742 29.53911 392.60199 29.957 393.26599 30.793 curveto
393.996 30.3164 lineto
393.65201 29.8008 393.19101 29.4023 392.617 29.1172 curveto
392.043 28.832 391.383 28.6914 390.64801 28.6914 curveto
389.51999 28.6914 388.578 29.0508 387.832 29.7695 curveto
387.09 30.4844 386.715 31.3594 386.715 32.3906 curveto
386.715 33.08589 386.89099 33.72661 387.238 34.3242 curveto
387.586 34.918 388.06201 35.3828 388.676 35.7148 curveto
389.285 36.0469 389.965 36.2148 390.719 36.2148 curveto
391.19101 36.2148 391.65201 36.1406 392.094 35.9961 curveto
392.531 35.85161 392.906 35.66411 393.215 35.4297 curveto
393.51999 35.1992 393.781 34.9023 393.996 34.543 curveto
 closepath fill
newpath 395.76599 38.793 moveto
396.68399 38.793 lineto
396.68399 34.7461 lineto
397.05899 35.2383 397.469 35.6055 397.914 35.8477 curveto
398.363 36.0898 398.84799 36.2148 399.367 36.2148 curveto
399.906 36.2148 400.379 36.0781 400.789 35.8047 curveto
401.207 35.5352 401.512 35.1719 401.711 34.71089 curveto
401.906 34.2539 402.008 33.5352 402.008 32.5547 curveto
402.008 28.875 lineto
401.082 28.875 lineto
401.082 32.28911 lineto
401.082 33.1094 401.051 33.6602 400.988 33.9414 curveto
400.871 34.41411 400.664 34.7695 400.363 35.0078 curveto
400.06201 35.2461 399.672 35.3672 399.18399 35.3672 curveto
398.629 35.3672 398.129 35.1797 397.68799 34.8164 curveto
397.246 34.4453 396.957 33.9883 396.81601 33.4453 curveto
396.72699 33.0938 396.68399 32.4453 396.68399 31.5 curveto
396.68399 28.875 lineto
395.76599 28.875 lineto
 closepath fill
 0.137 0.122 0.125 setrgbcolor
newpath 186.656 21.9648 moveto
186.656 21.6719 186.77 21.4336 187.004 21.2422 curveto
187.234 21.0547 187.625 20.96089 188.176 20.96089 curveto
188.469 20.96089 188.711 20.9922 188.902 21.0508 curveto
189.094 21.1133 189.246 21.1992 189.363 21.3086 curveto
189.477 21.41411 189.566 21.5664 189.629 21.7539 curveto
189.691 21.9453 189.723 22.2344 189.723 22.6172 curveto
189.723 25.543 lineto
188.918 25.543 lineto
188.918 25.08589 lineto
188.668 24.71089 lineto
188.809 24.5469 188.879 24.2969 188.879 23.96089 curveto
188.879 23.6367 188.805 23.3906 188.66 23.22661 curveto
188.516 23.0625 188.336 22.9805 188.125 22.9805 curveto
187.93 22.9805 187.766 23.0586 187.629 23.2227 curveto
187.496 23.3828 187.43 23.6367 187.43 23.9805 curveto
187.43 24.3086 187.496 24.5547 187.629 24.7148 curveto
187.629 24.7148 lineto
187.766 24.875 187.934 24.957 188.141 24.957 curveto
188.352 24.957 188.527 24.875 188.668 24.71089 curveto
188.918 25.08589 lineto
188.656 25.4375 188.32 25.6172 187.922 25.6172 curveto
187.527 25.6172 187.203 25.4727 186.938 25.1836 curveto
186.676 24.8945 186.547 24.47661 186.547 23.9297 curveto
186.547 23.4961 186.645 23.1328 186.844 22.8398 curveto
187.102 22.4688 187.449 22.2812 187.887 22.2812 curveto
188.277 22.2812 188.605 22.46089 188.863 22.8125 curveto
188.863 22.33589 lineto
188.863 22.1445 188.848 22.0117 188.82 21.9375 curveto
188.781 21.8398 188.727 21.7656 188.648 21.7227 curveto
188.535 21.6523 188.367 21.6211 188.145 21.6211 curveto
187.969 21.6211 187.84 21.6523 187.758 21.7148 curveto
187.695 21.7539 187.66 21.83589 187.645 21.9492 curveto
186.656 22.0703 lineto
186.656 22.0273 186.656 21.9922 186.656 21.9648 curveto
 closepath fill
newpath 192.258 22.9648 moveto
192.164 22.8906 192.051 22.8555 191.914 22.8555 curveto
191.719 22.8555 191.551 22.9258 191.418 23.0664 curveto
191.285 23.21089 191.215 23.4102 191.211 23.66411 curveto
191.227 24.1914 lineto
191.223 24.4258 191.285 24.6133 191.406 24.75 curveto
191.527 24.8867 191.684 24.957 191.871 24.957 curveto
192.051 24.957 192.199 24.8906 192.32 24.7617 curveto
192.441 24.6328 192.508 24.4414 192.516 24.1914 curveto
191.227 24.1914 lineto
191.211 23.66411 lineto
193.371 23.66411 lineto
193.383 24.3242 193.25 24.8164 192.969 25.1367 curveto
192.688 25.457 192.305 25.6172 191.82 25.6172 curveto
191.391 25.6172 191.031 25.4648 190.75 25.1562 curveto
190.469 24.85161 190.324 24.4297 190.324 23.8906 curveto
190.324 23.4375 190.434 23.0625 190.648 22.7656 curveto
190.922 22.3945 191.34 22.21089 191.906 22.21089 curveto
192.266 22.21089 192.562 22.293 192.801 22.457 curveto
193.039 22.6211 193.215 22.8594 193.324 23.1758 curveto
192.465 23.3203 lineto
192.418 23.1562 192.348 23.03911 192.258 22.9648 curveto
 closepath fill
newpath 194.008 22.2812 moveto
194.871 22.2812 lineto
194.871 23.8672 lineto
194.871 24.1797 194.895 24.4023 194.941 24.53911 curveto
194.984 24.6719 195.062 24.7773 195.168 24.8477 curveto
195.273 24.9219 195.395 24.957 195.527 24.957 curveto
195.637 24.957 195.727 24.9336 195.789 24.8906 curveto
195.855 24.8438 195.902 24.77339 195.934 24.6836 curveto
195.965 24.5898 195.98 24.3867 195.98 24.0703 curveto
195.98 22.2812 lineto
196.844 22.2812 lineto
196.844 23.8477 lineto
196.844 24.1562 196.863 24.3789 196.91 24.52339 curveto
196.961 24.66411 197.035 24.77339 197.141 24.8477 curveto
197.25 24.918 197.363 24.957 197.484 24.957 curveto
197.648 24.957 197.77 24.8945 197.852 24.77339 curveto
197.91 24.6758 197.941 24.4688 197.941 24.1445 curveto
197.941 22.2812 lineto
198.805 22.2812 lineto
198.805 24.3672 lineto
198.805 24.6758 198.773 24.9023 198.715 25.043 curveto
198.633 25.2305 198.508 25.3711 198.344 25.4688 curveto
198.176 25.5664 197.973 25.6172 197.734 25.6172 curveto
197.547 25.6172 197.367 25.5742 197.203 25.4883 curveto
197.039 25.4023 196.883 25.2695 196.738 25.0977 curveto
196.641 25.2695 196.516 25.4023 196.363 25.4883 curveto
196.211 25.5742 196.027 25.6172 195.82 25.6172 curveto
195.426 25.6172 195.09 25.4414 194.805 25.0977 curveto
194.805 25.543 lineto
194.008 25.543 lineto
 closepath fill
newpath 201.34 22.9648 moveto
201.25 22.8906 201.137 22.8555 201 22.8555 curveto
200.801 22.8555 200.637 22.9258 200.504 23.0664 curveto
200.371 23.21089 200.301 23.4102 200.293 23.66411 curveto
200.309 24.1914 lineto
200.309 24.4258 200.367 24.6133 200.492 24.75 curveto
200.613 24.8867 200.77 24.957 200.957 24.957 curveto
201.133 24.957 201.281 24.8906 201.406 24.7617 curveto
201.527 24.6328 201.594 24.4414 201.598 24.1914 curveto
200.309 24.1914 lineto
200.293 23.66411 lineto
202.453 23.66411 lineto
202.469 24.3242 202.332 24.8164 202.055 25.1367 curveto
201.773 25.457 201.391 25.6172 200.906 25.6172 curveto
200.473 25.6172 200.117 25.4648 199.836 25.1562 curveto
199.551 24.85161 199.41 24.4297 199.41 23.8906 curveto
199.41 23.4375 199.52 23.0625 199.734 22.7656 curveto
200.004 22.3945 200.426 22.21089 200.992 22.21089 curveto
201.348 22.21089 201.648 22.293 201.887 22.457 curveto
202.125 22.6211 202.297 22.8594 202.41 23.1758 curveto
201.551 23.3203 lineto
201.504 23.1562 201.434 23.03911 201.34 22.9648 curveto
 closepath fill
newpath 204.02 26.7812 moveto
203.156 26.7812 lineto
203.156 25.9844 lineto
204.02 25.9844 lineto
 closepath fill
newpath 204.02 25.543 moveto
203.156 25.543 lineto
203.156 22.2852 lineto
204.02 22.2852 lineto
 closepath fill
newpath 207.867 24.3086 moveto
207.867 24.5625 207.852 24.7539 207.82 24.8906 curveto
207.789 25.02339 207.734 25.1445 207.652 25.25 curveto
207.57 25.3594 207.453 25.4453 207.297 25.5156 curveto
207.137 25.582 206.965 25.6172 206.773 25.6172 curveto
206.344 25.6172 205.984 25.4336 205.699 25.0625 curveto
205.699 25.543 lineto
204.898 25.543 lineto
204.898 22.2812 lineto
205.762 22.2812 lineto
205.762 23.7578 lineto
205.762 24.1211 205.781 24.3711 205.828 24.5078 curveto
205.871 24.6445 205.953 24.7539 206.07 24.83589 curveto
206.188 24.91411 206.324 24.957 206.473 24.957 curveto
206.59 24.957 206.688 24.9258 206.773 24.8711 curveto
206.855 24.8125 206.914 24.7344 206.949 24.6289 curveto
206.988 24.5273 207.008 24.2969 207.008 23.9453 curveto
207.008 22.2812 lineto
207.867 22.2812 lineto
 closepath fill
newpath 211.707 24.3086 moveto
211.707 24.5625 211.691 24.7539 211.66 24.8906 curveto
211.629 25.02339 211.574 25.1445 211.492 25.25 curveto
211.41 25.3594 211.293 25.4453 211.137 25.5156 curveto
210.977 25.582 210.805 25.6172 210.613 25.6172 curveto
210.18 25.6172 209.824 25.4336 209.539 25.0625 curveto
209.539 25.543 lineto
208.738 25.543 lineto
208.738 22.2812 lineto
209.602 22.2812 lineto
209.602 23.7578 lineto
209.602 24.1211 209.621 24.3711 209.664 24.5078 curveto
209.711 24.6445 209.789 24.7539 209.91 24.83589 curveto
210.027 24.91411 210.164 24.957 210.312 24.957 curveto
210.43 24.957 210.527 24.9258 210.609 24.8711 curveto
210.695 24.8125 210.754 24.7344 210.789 24.6289 curveto
210.828 24.5273 210.848 24.2969 210.848 23.9453 curveto
210.848 22.2812 lineto
211.707 22.2812 lineto
 closepath fill
newpath 215.527 22.2812 moveto
215.527 25.543 lineto
214.668 25.543 lineto
214.668 24.168 lineto
214.668 23.6992 214.645 23.4062 214.602 23.28911 curveto
214.559 23.168 214.48 23.0703 214.363 22.9883 curveto
214.246 22.9062 214.113 22.8672 213.969 22.8672 curveto
213.84 22.8672 213.73 22.89839 213.648 22.957 curveto
213.562 23.0156 213.508 23.0977 213.477 23.2031 curveto
213.441 23.3047 213.426 23.58589 213.426 24.043 curveto
213.426 25.543 lineto
212.566 25.543 lineto
212.566 23.4805 lineto
212.566 23.1719 212.605 22.9336 212.68 22.7578 curveto
212.758 22.58589 212.887 22.4492 213.059 22.3555 curveto
213.234 22.2578 213.43 22.21089 213.648 22.21089 curveto
213.863 22.21089 214.066 22.2578 214.262 22.3594 curveto
214.453 22.46089 214.609 22.5977 214.727 22.7695 curveto
214.727 22.2812 lineto
 closepath fill
newpath 213.758 26.8594 moveto
213.016 26.8594 lineto
213.016 26.1211 lineto
213.758 26.1211 lineto
 closepath fill
newpath 215.078 26.8594 moveto
214.336 26.8594 lineto
214.336 26.1211 lineto
215.078 26.1211 lineto
 closepath fill
newpath 217.328 25.543 moveto
217.328 26.6953 lineto
216.465 26.1914 lineto
216.465 25.543 lineto
216.066 25.543 lineto
216.066 24.8555 lineto
216.465 24.8555 lineto
216.465 23.4336 lineto
216.465 23.1289 216.473 22.9258 216.488 22.8242 curveto
216.512 22.6836 216.555 22.5742 216.613 22.4883 curveto
216.672 22.4062 216.762 22.3398 216.887 22.28911 curveto
217.012 22.2344 217.152 22.21089 217.309 22.21089 curveto
217.559 22.21089 217.789 22.2539 217.988 22.3398 curveto
217.914 23.0078 lineto
217.762 22.9531 217.648 22.9258 217.566 22.9258 curveto
217.512 22.9258 217.461 22.9375 217.422 22.9688 curveto
217.383 22.9961 217.355 23.0312 217.344 23.0781 curveto
217.336 23.1211 217.328 23.27339 217.328 23.543 curveto
217.328 24.8555 lineto
217.918 24.8555 lineto
217.918 25.543 lineto
 closepath fill
newpath 221.078 22.2812 moveto
221.078 23.03911 lineto
219.742 23.03911 lineto
219.688 23.03911 219.539 23.0352 219.297 23.0195 curveto
219.738 23.4961 lineto
220.984 24.9336 lineto
220.984 25.543 lineto
218.289 25.543 lineto
218.289 24.8281 lineto
219.441 24.83589 lineto
219.602 24.83589 219.734 24.8398 219.836 24.8477 curveto
219.738 24.75 219.59 24.58589 219.391 24.3594 curveto
218.168 22.957 lineto
218.168 22.2812 lineto
 closepath fill
newpath 222.52 26.7812 moveto
221.66 26.7812 lineto
221.66 25.9844 lineto
222.52 25.9844 lineto
 closepath fill
newpath 222.52 25.543 moveto
221.66 25.543 lineto
221.66 22.2852 lineto
222.52 22.2852 lineto
 closepath fill
newpath 223.32 21.9648 moveto
223.32 21.6719 223.438 21.4336 223.668 21.2422 curveto
223.898 21.0547 224.293 20.96089 224.844 20.96089 curveto
225.137 20.96089 225.379 20.9922 225.57 21.0508 curveto
225.762 21.1133 225.914 21.1992 226.027 21.3086 curveto
226.145 21.41411 226.234 21.5664 226.297 21.7539 curveto
226.359 21.9453 226.391 22.2344 226.391 22.6172 curveto
226.391 25.543 lineto
225.586 25.543 lineto
225.586 25.08589 lineto
225.336 24.71089 lineto
225.473 24.5469 225.543 24.2969 225.543 23.96089 curveto
225.543 23.6367 225.473 23.3906 225.324 23.22661 curveto
225.18 23.0625 225.004 22.9805 224.793 22.9805 curveto
224.598 22.9805 224.43 23.0586 224.297 23.2227 curveto
224.16 23.3828 224.098 23.6367 224.098 23.9805 curveto
224.098 24.3086 224.16 24.5547 224.297 24.7148 curveto
224.297 24.7148 lineto
224.43 24.875 224.602 24.957 224.809 24.957 curveto
225.02 24.957 225.195 24.875 225.336 24.71089 curveto
225.586 25.08589 lineto
225.32 25.4375 224.988 25.6172 224.586 25.6172 curveto
224.195 25.6172 223.867 25.4727 223.605 25.1836 curveto
223.344 24.8945 223.211 24.47661 223.211 23.9297 curveto
223.211 23.4961 223.312 23.1328 223.512 22.8398 curveto
223.77 22.4688 224.113 22.2812 224.555 22.2812 curveto
224.945 22.2812 225.27 22.46089 225.527 22.8125 curveto
225.527 22.33589 lineto
225.527 22.1445 225.516 22.0117 225.488 21.9375 curveto
225.449 21.8398 225.395 21.7656 225.316 21.7227 curveto
225.203 21.6523 225.035 21.6211 224.809 21.6211 curveto
224.633 21.6211 224.508 21.6523 224.426 21.7148 curveto
224.363 21.7539 224.328 21.83589 224.309 21.9492 curveto
223.324 22.0703 lineto
223.324 22.0273 223.32 21.9922 223.32 21.9648 curveto
 closepath fill
newpath 228.922 22.9648 moveto
228.832 22.8906 228.719 22.8555 228.582 22.8555 curveto
228.383 22.8555 228.219 22.9258 228.086 23.0664 curveto
227.953 23.21089 227.883 23.4102 227.879 23.66411 curveto
227.891 24.1914 lineto
227.891 24.4258 227.949 24.6133 228.074 24.75 curveto
228.195 24.8867 228.352 24.957 228.539 24.957 curveto
228.715 24.957 228.863 24.8906 228.988 24.7617 curveto
229.109 24.6328 229.176 24.4414 229.18 24.1914 curveto
227.891 24.1914 lineto
227.879 23.66411 lineto
230.035 23.66411 lineto
230.051 24.3242 229.914 24.8164 229.637 25.1367 curveto
229.355 25.457 228.973 25.6172 228.488 25.6172 curveto
228.055 25.6172 227.699 25.4648 227.414 25.1562 curveto
227.133 24.85161 226.992 24.4297 226.992 23.8906 curveto
226.992 23.4375 227.102 23.0625 227.316 22.7656 curveto
227.586 22.3945 228.008 22.21089 228.574 22.21089 curveto
228.93 22.21089 229.23 22.293 229.469 22.457 curveto
229.707 22.6211 229.883 22.8594 229.992 23.1758 curveto
229.133 23.3203 lineto
229.086 23.1562 229.016 23.03911 228.922 22.9648 curveto
 closepath fill
newpath 235.625 23.9375 moveto
235.625 23.3672 lineto
235.488 23.2617 235.324 23.168 235.133 23.0938 curveto
234.941 23.0195 234.75 22.9844 234.562 22.9844 curveto
234.176 22.9844 233.867 23.1172 233.629 23.3828 curveto
233.391 23.64839 233.273 24.0508 233.273 24.58589 curveto
233.273 25.082 233.391 25.4531 233.625 25.707 curveto
233.859 25.957 234.176 26.082 234.57 26.082 curveto
234.832 26.082 235.051 26.0195 235.227 25.8906 curveto
235.398 25.7617 235.52 25.5898 235.582 25.3672 curveto
236.484 25.5352 lineto
236.395 25.9492 236.195 26.27339 235.879 26.5078 curveto
235.566 26.7422 235.129 26.8594 234.57 26.8594 curveto
234.141 26.8594 233.781 26.7852 233.492 26.6367 curveto
233.113 26.4414 232.828 26.1602 232.633 25.7969 curveto
232.434 25.4336 232.336 25.0156 232.336 24.5469 curveto
232.336 24.1172 232.426 23.7188 232.602 23.35161 curveto
232.777 22.9805 233.039 22.6992 233.391 22.5039 curveto
233.738 22.3047 234.148 22.207 234.617 22.207 curveto
234.988 22.207 235.355 22.2773 235.719 22.418 curveto
236.078 22.5586 236.355 22.7188 236.543 22.9023 curveto
236.543 24.6953 lineto
234.586 24.6953 lineto
234.586 23.9375 lineto
 closepath fill
newpath 237.312 22.2812 moveto
238.176 22.2812 lineto
238.176 23.8672 lineto
238.176 24.1797 238.195 24.4023 238.242 24.53911 curveto
238.289 24.6719 238.363 24.7773 238.473 24.8477 curveto
238.578 24.9219 238.699 24.957 238.832 24.957 curveto
238.941 24.957 239.027 24.9336 239.094 24.8906 curveto
239.156 24.8438 239.203 24.77339 239.234 24.6836 curveto
239.266 24.5898 239.281 24.3867 239.281 24.0703 curveto
239.281 22.2812 lineto
240.145 22.2812 lineto
240.145 23.8477 lineto
240.145 24.1562 240.168 24.3789 240.215 24.52339 curveto
240.262 24.66411 240.34 24.77339 240.445 24.8477 curveto
240.551 24.918 240.664 24.957 240.785 24.957 curveto
240.949 24.957 241.074 24.8945 241.152 24.77339 curveto
241.215 24.6758 241.242 24.4688 241.242 24.1445 curveto
241.242 22.2812 lineto
242.105 22.2812 lineto
242.105 24.3672 lineto
242.105 24.6758 242.074 24.9023 242.016 25.043 curveto
241.934 25.2305 241.812 25.3711 241.645 25.4688 curveto
241.48 25.5664 241.277 25.6172 241.035 25.6172 curveto
240.848 25.6172 240.672 25.5742 240.508 25.4883 curveto
240.34 25.4023 240.188 25.2695 240.043 25.0977 curveto
239.945 25.2695 239.82 25.4023 239.664 25.4883 curveto
239.512 25.5742 239.332 25.6172 239.121 25.6172 curveto
238.73 25.6172 238.391 25.4414 238.105 25.0977 curveto
238.105 25.543 lineto
237.312 25.543 lineto
 closepath fill
newpath 243.73 22.2812 moveto
243.73 22.7617 lineto
243.859 22.582 244.016 22.4414 244.195 22.3477 curveto
244.379 22.2578 244.562 22.21089 244.746 22.21089 curveto
245.125 22.21089 245.449 22.3594 245.715 22.6602 curveto
245.977 22.96089 246.109 23.3906 246.109 23.9453 curveto
246.109 24.4844 245.98 24.89839 245.723 25.1836 curveto
245.461 25.4727 245.133 25.6172 244.734 25.6172 curveto
244.371 25.6172 244.055 25.4648 243.789 25.1602 curveto
243.988 24.7148 lineto
244.129 24.875 244.301 24.957 244.504 24.957 curveto
244.715 24.957 244.891 24.875 245.023 24.71089 curveto
245.16 24.543 245.227 24.2773 245.227 23.9023 curveto
245.227 23.5547 245.16 23.2969 245.023 23.1367 curveto
244.891 22.9727 244.73 22.8906 244.539 22.8906 curveto
244.293 22.8906 244.094 23.0078 243.945 23.2344 curveto
243.84 23.3945 243.785 23.6445 243.785 23.9844 curveto
243.785 24.3125 243.852 24.5547 243.988 24.7148 curveto
243.789 25.1602 lineto
243.789 26.7812 lineto
242.93 26.7812 lineto
242.93 22.2812 lineto
 closepath fill
newpath 247.723 22.2812 moveto
247.723 24.25 lineto
249.504 24.25 lineto
249.504 22.2812 lineto
250.41 22.2812 lineto
250.41 26.7812 lineto
249.504 26.7812 lineto
249.504 25.0117 lineto
247.723 25.0117 lineto
247.723 26.7812 lineto
246.812 26.7812 lineto
246.812 22.2812 lineto
 closepath fill
newpath 186.031 30.2812 moveto
186.031 31.6406 lineto
186.77 32.3945 lineto
188.008 30.2812 lineto
189.18 30.2812 lineto
187.395 33.0312 lineto
189.09 34.7812 lineto
187.867 34.7812 lineto
186.031 32.7852 lineto
186.031 34.7812 lineto
185.121 34.7812 lineto
185.121 30.2812 lineto
 closepath fill
newpath 190.508 34.7812 moveto
189.645 34.7812 lineto
189.645 30.2812 lineto
190.508 30.2812 lineto
 closepath fill
newpath 192.242 32.8672 moveto
192.328 32.9258 192.449 32.957 192.602 32.957 curveto
192.828 32.957 192.984 32.9219 193.066 32.85161 curveto
193.148 32.7812 193.188 32.6602 193.188 32.4961 curveto
193.188 32.4102 lineto
193.035 32.3438 192.754 32.27339 192.352 32.1992 curveto
192.051 32.1406 191.824 32.0742 191.664 31.9961 curveto
191.508 31.918 191.383 31.8086 191.297 31.66411 curveto
191.207 31.5195 191.164 31.3555 191.164 31.1719 curveto
191.164 30.8945 191.262 30.66411 191.453 30.4805 curveto
191.648 30.3008 191.91 30.21089 192.246 30.21089 curveto
192.438 30.21089 192.617 30.2461 192.785 30.3164 curveto
192.953 30.3867 193.109 30.4961 193.258 30.6406 curveto
192.949 30.9688 lineto
192.809 30.8672 192.66 30.8164 192.504 30.8164 curveto
192.367 30.8164 192.25 30.8594 192.16 30.9492 curveto
192.07 31.0352 192.027 31.1406 192.027 31.2617 curveto
192.027 31.3867 192.082 31.4844 192.195 31.5664 curveto
192.27 31.6133 192.426 31.66411 192.664 31.7148 curveto
192.902 31.7695 193.078 31.8125 193.188 31.8477 curveto
193.188 31.6758 lineto
193.188 31.4688 193.18 31.332 193.156 31.2578 curveto
193.121 31.1445 193.055 31.0469 192.949 30.9688 curveto
193.258 30.6406 lineto
193.262 30.6211 193.273 30.5898 193.285 30.53911 curveto
193.32 30.4258 193.348 30.3398 193.371 30.2812 curveto
194.223 30.2812 lineto
194.148 30.4375 194.098 30.58589 194.066 30.7188 curveto
194.039 30.8555 194.027 31.0664 194.027 31.3555 curveto
194.035 32.3594 lineto
194.035 32.7344 193.996 32.9922 193.922 33.1328 curveto
193.844 33.27339 193.711 33.3906 193.523 33.4805 curveto
193.336 33.5703 193.051 33.6172 192.664 33.6172 curveto
192.242 33.6172 191.922 33.53911 191.707 33.3906 curveto
191.492 33.2383 191.34 33.0039 191.254 32.6875 curveto
192.035 32.5469 lineto
192.09 32.6992 192.156 32.8047 192.242 32.8672 curveto
 closepath fill
newpath 197.832 30.2812 moveto
197.832 33.543 lineto
196.973 33.543 lineto
196.973 32.168 lineto
196.973 31.7031 196.949 31.4062 196.906 31.28911 curveto
196.863 31.168 196.781 31.0664 196.668 30.9883 curveto
196.551 30.9062 196.418 30.8672 196.27 30.8672 curveto
196.141 30.8672 196.035 30.8945 195.949 30.957 curveto
195.867 31.0156 195.809 31.0977 195.777 31.2031 curveto
195.746 31.3047 195.73 31.58589 195.73 32.043 curveto
195.73 33.543 lineto
194.867 33.543 lineto
194.867 31.4805 lineto
194.867 31.1719 194.906 30.9336 194.984 30.7578 curveto
195.062 30.58589 195.188 30.4492 195.363 30.3555 curveto
195.535 30.2578 195.73 30.21089 195.949 30.21089 curveto
196.164 30.21089 196.371 30.2617 196.562 30.3594 curveto
196.758 30.46089 196.914 30.5977 197.031 30.7695 curveto
197.031 30.2812 lineto
 closepath fill
newpath 198.93 30.4805 moveto
199.188 30.3008 199.539 30.21089 199.984 30.21089 curveto
200.473 30.21089 200.844 30.3164 201.094 30.5312 curveto
201.344 30.7461 201.469 31.0039 201.469 31.3008 curveto
201.469 31.5781 201.379 31.78911 201.195 31.9453 curveto
201.016 32.0938 200.695 32.2227 200.234 32.3281 curveto
199.773 32.4336 199.508 32.5117 199.43 32.5703 curveto
199.371 32.6133 199.344 32.66411 199.344 32.72661 curveto
199.344 32.7969 199.375 32.8555 199.441 32.9023 curveto
199.539 32.9648 199.703 32.9961 199.93 32.9961 curveto
200.109 32.9961 200.246 32.96089 200.344 32.8945 curveto
200.441 32.8281 200.508 32.7305 200.543 32.6055 curveto
201.355 32.7539 lineto
201.273 33.03911 201.125 33.2539 200.906 33.39839 curveto
200.691 33.543 200.359 33.6172 199.914 33.6172 curveto
199.445 33.6172 199.098 33.5195 198.875 33.3281 curveto
198.652 33.1367 198.543 32.89839 198.543 32.6172 curveto
198.543 32.3008 198.672 32.0586 198.93 31.8828 curveto
199.113 31.7539 199.555 31.6133 200.25 31.46089 curveto
200.402 31.4258 200.496 31.3906 200.539 31.3477 curveto
200.582 31.3047 200.602 31.25 200.602 31.1836 curveto
200.602 31.0898 200.562 31.0117 200.488 30.957 curveto
200.375 30.8711 200.207 30.832 199.984 30.832 curveto
199.781 30.832 199.625 30.875 199.512 30.9648 curveto
199.398 31.0508 199.324 31.1758 199.289 31.3438 curveto
198.422 31.2148 lineto
198.504 30.9023 198.672 30.6602 198.93 30.4805 curveto
 closepath fill
newpath 205.895 30.2812 moveto
205.895 34.0195 lineto
207.227 34.0195 lineto
207.227 34.7812 lineto
203.652 34.7812 lineto
203.652 34.0195 lineto
204.988 34.0195 lineto
204.988 30.2812 lineto
 closepath fill
newpath 207.547 30.4805 moveto
207.805 30.3008 208.156 30.21089 208.602 30.21089 curveto
209.09 30.21089 209.457 30.3164 209.707 30.5312 curveto
209.957 30.7461 210.082 31.0039 210.082 31.3008 curveto
210.082 31.5781 209.992 31.78911 209.812 31.9453 curveto
209.629 32.0938 209.309 32.2227 208.848 32.3281 curveto
208.391 32.4336 208.121 32.5117 208.043 32.5703 curveto
207.984 32.6133 207.957 32.66411 207.957 32.72661 curveto
207.957 32.7969 207.988 32.8555 208.055 32.9023 curveto
208.152 32.9648 208.316 32.9961 208.543 32.9961 curveto
208.723 32.9961 208.863 32.96089 208.961 32.8945 curveto
209.059 32.8281 209.121 32.7305 209.156 32.6055 curveto
209.973 32.7539 lineto
209.891 33.03911 209.738 33.2539 209.523 33.39839 curveto
209.305 33.543 208.977 33.6172 208.527 33.6172 curveto
208.059 33.6172 207.715 33.5195 207.492 33.3281 curveto
207.27 33.1367 207.156 32.89839 207.156 32.6172 curveto
207.156 32.3008 207.285 32.0586 207.543 31.8828 curveto
207.73 31.7539 208.172 31.6133 208.867 31.46089 curveto
209.016 31.4258 209.113 31.3906 209.156 31.3477 curveto
209.195 31.3047 209.215 31.25 209.215 31.1836 curveto
209.215 31.0898 209.18 31.0117 209.102 30.957 curveto
208.988 30.8711 208.82 30.832 208.602 30.832 curveto
208.398 30.832 208.238 30.875 208.129 30.9648 curveto
208.016 31.0508 207.941 31.1758 207.902 31.3438 curveto
207.035 31.2148 lineto
207.117 30.9023 207.285 30.6602 207.547 30.4805 curveto
 closepath fill
newpath 213.176 33.3594 moveto
212.941 33.5312 212.625 33.6172 212.227 33.6172 curveto
211.742 33.6172 211.355 33.4648 211.074 33.16411 curveto
210.789 32.8672 210.645 32.4492 210.645 31.9102 curveto
210.645 31.3789 210.789 30.96089 211.07 30.6602 curveto
211.355 30.3594 211.734 30.21089 212.211 30.21089 curveto
212.633 30.21089 212.965 30.3086 213.215 30.5078 curveto
213.465 30.707 213.633 31 213.723 31.3867 curveto
212.875 31.5312 lineto
212.832 31.3047 212.758 31.1445 212.652 31.0508 curveto
212.551 30.957 212.414 30.9102 212.254 30.9102 curveto
212.031 30.9102 211.859 30.9922 211.727 31.1523 curveto
211.598 31.3125 211.531 31.58589 211.531 31.9727 curveto
211.531 32.3203 211.598 32.5664 211.727 32.7148 curveto
211.852 32.8633 212.023 32.9375 212.238 32.9375 curveto
212.402 32.9375 212.531 32.8945 212.633 32.8086 curveto
212.734 32.7227 212.801 32.5938 212.828 32.4258 curveto
213.68 32.5781 lineto
213.578 32.9297 213.406 33.1875 213.176 33.3594 curveto
 closepath fill
newpath 214.328 34.7812 moveto
214.328 30.2812 lineto
215.191 30.2812 lineto
215.191 31.91411 lineto
215.191 32.1914 215.219 32.39839 215.27 32.5352 curveto
215.32 32.6758 215.406 32.7812 215.516 32.85161 curveto
215.629 32.9219 215.758 32.957 215.902 32.957 curveto
216.027 32.957 216.129 32.9297 216.215 32.875 curveto
216.297 32.8203 216.352 32.7461 216.387 32.6562 curveto
216.418 32.5625 216.434 32.3477 216.434 32.0039 curveto
216.434 30.2812 lineto
217.297 30.2812 lineto
217.297 32.1953 lineto
217.297 32.4883 217.281 32.7031 217.254 32.8438 curveto
217.223 32.9805 217.168 33.1094 217.086 33.2227 curveto
217.008 33.3398 216.887 33.4336 216.727 33.5078 curveto
216.566 33.582 216.387 33.6172 216.188 33.6172 curveto
215.805 33.6172 215.469 33.4531 215.191 33.1289 curveto
215.191 34.7812 lineto
 closepath fill
newpath 219.035 34.7812 moveto
218.172 34.7812 lineto
218.172 33.9844 lineto
219.035 33.9844 lineto
 closepath fill
newpath 219.035 33.543 moveto
218.172 33.543 lineto
218.172 30.2812 lineto
219.035 30.2812 lineto
 closepath fill
newpath 220.742 31.28911 moveto
220.742 31.8438 220.77 32.207 220.816 32.3828 curveto
220.863 32.5547 220.93 32.6758 221.016 32.7422 curveto
221.098 32.8086 221.199 32.8438 221.32 32.8438 curveto
221.445 32.8438 221.582 32.7969 221.727 32.7031 curveto
221.992 33.4531 lineto
221.812 33.5625 221.621 33.6172 221.426 33.6172 curveto
221.285 33.6172 221.16 33.582 221.055 33.5117 curveto
220.941 33.4414 220.82 33.2969 220.684 33.0781 curveto
220.684 33.543 lineto
219.883 33.543 lineto
219.883 30.2812 lineto
220.742 30.2812 lineto
 closepath fill
newpath 223.219 32.8672 moveto
223.305 32.9258 223.422 32.957 223.578 32.957 curveto
223.805 32.957 223.957 32.9219 224.039 32.85161 curveto
224.121 32.7812 224.164 32.6602 224.164 32.4961 curveto
224.164 32.4102 lineto
224.008 32.3438 223.73 32.27339 223.324 32.1992 curveto
223.027 32.1406 222.797 32.0742 222.641 31.9961 curveto
222.48 31.918 222.355 31.8086 222.27 31.66411 curveto
222.184 31.5195 222.137 31.3555 222.137 31.1719 curveto
222.137 30.8945 222.234 30.66411 222.426 30.4805 curveto
222.621 30.3008 222.887 30.21089 223.223 30.21089 curveto
223.41 30.21089 223.59 30.2461 223.758 30.3164 curveto
223.926 30.3867 224.082 30.4961 224.23 30.6406 curveto
223.926 30.9688 lineto
223.781 30.8672 223.633 30.8164 223.48 30.8164 curveto
223.34 30.8164 223.227 30.8594 223.137 30.9492 curveto
223.047 31.0352 223 31.1406 223 31.2617 curveto
223 31.3867 223.055 31.4844 223.168 31.5664 curveto
223.242 31.6133 223.398 31.66411 223.637 31.7148 curveto
223.879 31.7695 224.055 31.8125 224.164 31.8477 curveto
224.164 31.6758 lineto
224.164 31.4688 224.152 31.332 224.129 31.2578 curveto
224.098 31.1445 224.027 31.0469 223.926 30.9688 curveto
224.23 30.6406 lineto
224.238 30.6211 224.246 30.5898 224.262 30.53911 curveto
224.293 30.4258 224.32 30.3398 224.344 30.2812 curveto
225.199 30.2812 lineto
225.121 30.4375 225.07 30.58589 225.043 30.7188 curveto
225.016 30.8555 225 31.0664 225 31.3555 curveto
225.012 32.3594 lineto
225.012 32.7344 224.973 32.9922 224.895 33.1328 curveto
224.816 33.27339 224.688 33.3906 224.496 33.4805 curveto
224.309 33.5703 224.023 33.6172 223.637 33.6172 curveto
223.215 33.6172 222.895 33.53911 222.68 33.3906 curveto
222.465 33.2383 222.312 33.0039 222.227 32.6875 curveto
223.008 32.5469 lineto
223.062 32.6992 223.133 32.8047 223.219 32.8672 curveto
 closepath fill
newpath 227.93 30.5977 moveto
228.234 30.33589 228.672 30.2031 229.238 30.2031 curveto
229.629 30.2031 229.957 30.2578 230.219 30.3672 curveto
230.48 30.47661 230.684 30.6445 230.824 30.8672 curveto
230.969 31.0938 231.039 31.33589 231.039 31.5938 curveto
231.039 31.8789 230.98 32.1172 230.863 32.3086 curveto
230.742 32.5039 230.574 32.6562 230.363 32.7695 curveto
230.152 32.8789 229.824 32.9883 229.383 33.0938 curveto
228.941 33.1953 228.664 33.2969 228.551 33.3906 curveto
228.461 33.4688 228.414 33.5586 228.414 33.66411 curveto
228.414 33.7812 228.461 33.875 228.559 33.9453 curveto
228.707 34.0547 228.914 34.1055 229.18 34.1055 curveto
229.434 34.1055 229.625 34.0586 229.754 33.957 curveto
229.883 33.8555 229.965 33.6875 230.004 33.457 curveto
230.91 33.4961 lineto
230.898 33.9102 230.746 34.2383 230.465 34.4883 curveto
230.176 34.7344 229.754 34.8594 229.188 34.8594 curveto
228.844 34.8594 228.547 34.8086 228.301 34.7031 curveto
228.059 34.5977 227.871 34.4453 227.738 34.2461 curveto
227.609 34.0469 227.547 33.832 227.547 33.6055 curveto
227.547 33.2461 227.684 32.9453 227.961 32.6992 curveto
228.156 32.52339 228.496 32.375 228.984 32.2539 curveto
229.363 32.1602 229.605 32.0938 229.711 32.0586 curveto
229.867 32.0039 229.977 31.9375 230.039 31.8633 curveto
230.102 31.78911 230.133 31.6953 230.133 31.5898 curveto
230.133 31.4258 230.059 31.2812 229.91 31.1562 curveto
229.762 31.0312 229.539 30.9688 229.246 30.9688 curveto
228.973 30.9688 228.754 31.03911 228.59 31.1797 curveto
228.43 31.3164 228.32 31.5352 228.266 31.832 curveto
227.383 31.7461 lineto
227.441 31.2422 227.625 30.8594 227.93 30.5977 curveto
 closepath fill
newpath 232.703 33.543 moveto
232.703 34.6914 lineto
231.84 34.1914 lineto
231.84 33.543 lineto
231.441 33.543 lineto
231.441 32.8555 lineto
231.84 32.8555 lineto
231.84 31.4336 lineto
231.84 31.1289 231.848 30.9258 231.867 30.8281 curveto
231.891 30.6836 231.93 30.5742 231.988 30.4883 curveto
232.047 30.4062 232.137 30.3398 232.262 30.28911 curveto
232.387 30.2344 232.527 30.21089 232.684 30.21089 curveto
232.938 30.21089 233.164 30.2539 233.363 30.3398 curveto
233.289 31.0078 lineto
233.141 30.9531 233.023 30.9258 232.945 30.9258 curveto
232.887 30.9258 232.84 30.9375 232.797 30.9688 curveto
232.758 30.9961 232.73 31.0312 232.723 31.0781 curveto
232.711 31.1211 232.703 31.2773 232.703 31.53911 curveto
232.703 32.8555 lineto
233.293 32.8555 lineto
233.293 33.543 lineto
 closepath fill
newpath 234.754 34.7812 moveto
233.895 34.7812 lineto
233.895 33.9844 lineto
234.754 33.9844 lineto
 closepath fill
newpath 234.754 33.543 moveto
233.895 33.543 lineto
233.895 30.2812 lineto
234.754 30.2812 lineto
 closepath fill
newpath 235.262 32.8633 moveto
235.738 32.8633 lineto
235.738 30.2812 lineto
236.602 30.2812 lineto
236.602 32.8633 lineto
237.246 32.8633 lineto
237.246 33.543 lineto
236.602 33.543 lineto
236.602 33.77339 lineto
236.602 33.9375 236.629 34.0508 236.684 34.1094 curveto
236.738 34.168 236.828 34.1953 236.953 34.1953 curveto
237.078 34.1953 237.211 34.1797 237.348 34.14839 curveto
237.465 34.75 lineto
237.23 34.8203 236.988 34.8594 236.742 34.8594 curveto
236.504 34.8594 236.305 34.8164 236.148 34.7305 curveto
235.992 34.64839 235.887 34.5352 235.828 34.4023 curveto
235.77 34.2656 235.738 34.0625 235.738 33.78911 curveto
235.738 33.543 lineto
235.262 33.543 lineto
 closepath fill
newpath 238.637 33.543 moveto
238.637 34.6914 lineto
237.773 34.1914 lineto
237.773 33.543 lineto
237.375 33.543 lineto
237.375 32.8555 lineto
237.773 32.8555 lineto
237.773 31.4336 lineto
237.773 31.1289 237.781 30.9258 237.801 30.8281 curveto
237.82 30.6836 237.863 30.5742 237.922 30.4883 curveto
237.98 30.4062 238.07 30.3398 238.195 30.28911 curveto
238.32 30.2344 238.461 30.21089 238.617 30.21089 curveto
238.867 30.21089 239.098 30.2539 239.297 30.3398 curveto
239.223 31.0078 lineto
239.07 30.9531 238.957 30.9258 238.875 30.9258 curveto
238.82 30.9258 238.77 30.9375 238.73 30.9688 curveto
238.691 30.9961 238.664 31.0312 238.652 31.0781 curveto
238.645 31.1211 238.637 31.2773 238.637 31.53911 curveto
238.637 32.8555 lineto
239.227 32.8555 lineto
239.227 33.543 lineto
 closepath fill
newpath 242.77 30.2812 moveto
242.77 33.543 lineto
241.91 33.543 lineto
241.91 32.168 lineto
241.91 31.7031 241.887 31.4062 241.844 31.28911 curveto
241.801 31.168 241.723 31.0664 241.605 30.9883 curveto
241.488 30.9062 241.355 30.8672 241.211 30.8672 curveto
241.078 30.8672 240.973 30.8945 240.891 30.957 curveto
240.805 31.0156 240.746 31.0977 240.715 31.2031 curveto
240.684 31.3047 240.668 31.58589 240.668 32.043 curveto
240.668 33.543 lineto
239.809 33.543 lineto
239.809 31.4805 lineto
239.809 31.1719 239.844 30.9336 239.922 30.7578 curveto
240 30.58589 240.129 30.4492 240.301 30.3555 curveto
240.477 30.2578 240.672 30.21089 240.891 30.21089 curveto
241.105 30.21089 241.309 30.2617 241.504 30.3594 curveto
241.695 30.46089 241.852 30.5977 241.973 30.7695 curveto
241.973 30.2812 lineto
 closepath fill
newpath 246.629 32.3086 moveto
246.629 32.5586 246.613 32.7539 246.582 32.8906 curveto
246.551 33.02339 246.492 33.1445 246.414 33.25 curveto
246.332 33.3555 246.215 33.4453 246.055 33.5117 curveto
245.898 33.582 245.723 33.6172 245.531 33.6172 curveto
245.102 33.6172 244.742 33.4336 244.461 33.0625 curveto
244.461 33.543 lineto
243.656 33.543 lineto
243.656 30.2812 lineto
244.52 30.2812 lineto
244.52 31.7578 lineto
244.52 32.125 244.543 32.3711 244.586 32.5078 curveto
244.629 32.6445 244.711 32.7539 244.828 32.832 curveto
244.949 32.91411 245.086 32.957 245.234 32.957 curveto
245.348 32.957 245.449 32.9297 245.531 32.8711 curveto
245.613 32.8125 245.676 32.7344 245.711 32.6289 curveto
245.746 32.5273 245.766 32.2969 245.766 31.9453 curveto
245.766 30.2812 lineto
246.629 30.2812 lineto
 closepath fill
newpath 247.422 29.9648 moveto
247.422 29.6719 247.535 29.4336 247.77 29.2422 curveto
248 29.0547 248.391 28.96089 248.945 28.96089 curveto
249.234 28.96089 249.477 28.9922 249.668 29.0508 curveto
249.859 29.1133 250.012 29.1992 250.129 29.3086 curveto
250.242 29.41411 250.332 29.5664 250.395 29.7539 curveto
250.457 29.9453 250.488 30.2344 250.488 30.6172 curveto
250.488 33.543 lineto
249.684 33.543 lineto
249.684 33.08589 lineto
249.434 32.71089 lineto
249.574 32.5469 249.645 32.2969 249.645 31.96089 curveto
249.645 31.6367 249.57 31.3906 249.426 31.22661 curveto
249.281 31.0625 249.102 30.9805 248.891 30.9805 curveto
248.695 30.9805 248.527 31.0586 248.395 31.2227 curveto
248.262 31.3828 248.195 31.6328 248.195 31.9805 curveto
248.195 32.3086 248.262 32.5547 248.395 32.7148 curveto
248.395 32.7148 lineto
248.527 32.875 248.699 32.957 248.906 32.957 curveto
249.121 32.957 249.297 32.875 249.434 32.71089 curveto
249.684 33.08589 lineto
249.422 33.4375 249.09 33.6172 248.688 33.6172 curveto
248.297 33.6172 247.969 33.4727 247.703 33.1836 curveto
247.441 32.8945 247.309 32.47661 247.309 31.9297 curveto
247.309 31.4961 247.41 31.1328 247.613 30.8398 curveto
247.867 30.4688 248.215 30.2812 248.652 30.2812 curveto
249.047 30.2812 249.371 30.46089 249.629 30.8125 curveto
249.629 30.33589 lineto
249.629 30.1445 249.613 30.0117 249.59 29.9375 curveto
249.551 29.8398 249.492 29.7656 249.414 29.7227 curveto
249.305 29.6523 249.133 29.6211 248.91 29.6211 curveto
248.734 29.6211 248.605 29.6523 248.523 29.71089 curveto
248.465 29.7539 248.426 29.83589 248.41 29.9492 curveto
247.426 30.0664 lineto
247.422 30.0273 247.422 29.9922 247.422 29.9648 curveto
 closepath fill
newpath 288.797 15.3906 moveto
288.797 16.7344 lineto
289.52301 17.4805 lineto
290.746 15.3906 lineto
291.91 15.3906 lineto
290.14499 18.1094 lineto
291.82 19.8438 lineto
290.60901 19.8438 lineto
288.797 17.8672 lineto
288.797 19.8438 lineto
287.89499 19.8438 lineto
287.89499 15.3906 lineto
 closepath fill
newpath 294.65201 15.3906 moveto
294.65201 19.0898 lineto
295.97299 19.0898 lineto
295.97299 19.8438 lineto
292.43 19.8438 lineto
292.43 19.0898 lineto
293.754 19.0898 lineto
293.754 15.3906 lineto
 closepath fill
newpath 297.238 15.6992 moveto
297.539 15.4414 297.97299 15.3086 298.535 15.3086 curveto
298.922 15.3086 299.246 15.3633 299.504 15.4727 curveto
299.76599 15.582 299.965 15.7461 300.10501 15.9688 curveto
300.246 16.1914 300.32 16.4297 300.32 16.6875 curveto
300.32 16.9688 300.262 17.2031 300.14099 17.3945 curveto
300.02301 17.58589 299.85901 17.7383 299.64801 17.8477 curveto
299.43799 17.96089 299.117 18.0664 298.68 18.168 curveto
298.242 18.27339 297.965 18.3711 297.85199 18.4688 curveto
297.762 18.543 297.719 18.6328 297.719 18.7383 curveto
297.719 18.85161 297.76599 18.9453 297.85901 19.0156 curveto
298.008 19.1211 298.215 19.1758 298.47299 19.1758 curveto
298.73001 19.1758 298.918 19.125 299.047 19.02339 curveto
299.172 18.9219 299.254 18.7617 299.293 18.5312 curveto
300.19101 18.5703 lineto
300.176 18.9805 300.02701 19.3086 299.746 19.5508 curveto
299.465 19.7969 299.043 19.918 298.48401 19.918 curveto
298.14099 19.918 297.84799 19.8672 297.60501 19.7656 curveto
297.363 19.6602 297.18 19.5117 297.051 19.3125 curveto
296.922 19.1172 296.85901 18.9023 296.85901 18.6758 curveto
296.85901 18.3242 296.996 18.0273 297.26999 17.7812 curveto
297.461 17.6055 297.801 17.46089 298.285 17.3398 curveto
298.66 17.2461 298.89801 17.1836 299.004 17.1445 curveto
299.156 17.0898 299.26599 17.0273 299.328 16.9531 curveto
299.39099 16.8789 299.422 16.78911 299.422 16.6836 curveto
299.422 16.5195 299.34799 16.375 299.199 16.2539 curveto
299.051 16.1328 298.836 16.0703 298.547 16.0703 curveto
298.26999 16.0703 298.055 16.1406 297.89499 16.2773 curveto
297.73001 16.41411 297.625 16.6289 297.57 16.9219 curveto
296.695 16.8398 lineto
296.758 16.3398 296.93799 15.9609 297.238 15.6992 curveto
 closepath fill
 0.651 0.663 0.667 setrgbcolor
newpath 272.496 22.2305 moveto
285.55899 22.2305 lineto
285.55899 35.2188 lineto
272.496 35.2188 lineto
 closepath fill
 0.137 0.122 0.125 setrgbcolor
newpath 265.77301 15.75 moveto
271.883 21.8203 lineto
271.80899 21.9375 271.76599 22.0781 271.76599 22.2305 curveto
271.76599 22.6445 272.094 22.9805 272.496 22.9805 curveto
272.65201 22.9805 272.797 22.9297 272.914 22.8477 curveto
275.56201 25.4805 lineto
272.945 28.1094 lineto
272.82 28.0117 272.668 27.957 272.5 27.957 curveto
272.094 27.957 271.76599 28.28911 271.76599 28.707 curveto
271.76599 28.8711 271.82 29.0273 271.91 29.1523 curveto
265.738 35.3555 lineto
271.781 35.3555 lineto
271.844 35.7031 272.14499 35.9688 272.504 35.9688 curveto
272.863 35.9688 273.16 35.7031 273.22299 35.3555 curveto
278.258 35.3555 lineto
278.32 35.707 278.621 35.9727 278.98001 35.9727 curveto
279.34 35.9727 279.64099 35.707 279.699 35.3555 curveto
284.84 35.3555 lineto
284.90201 35.7031 285.203 35.9688 285.56201 35.9688 curveto
285.965 35.9688 286.293 35.6328 286.293 35.2188 curveto
286.293 34.8477 286.035 34.543 285.69101 34.4805 curveto
285.69101 29.4492 lineto
286.035 29.3867 286.297 29.0781 286.297 28.707 curveto
286.297 28.33589 286.035 28.0312 285.69101 27.9688 curveto
285.69101 22.9648 lineto
286.031 22.89839 286.289 22.5938 286.289 22.2227 curveto
286.289 21.8555 286.031 21.5508 285.69101 21.4844 curveto
285.69101 15.3008 lineto
279.406 21.6133 lineto
279.289 21.5273 279.14099 21.47661 278.98401 21.47661 curveto
278.578 21.47661 278.25 21.8125 278.25 22.22661 curveto
278.25 22.3828 278.297 22.5312 278.379 22.6523 curveto
275.754 25.28911 lineto
275.94101 25.47661 lineto
275.754 25.668 lineto
278.383 28.2812 lineto
278.297 28.4023 278.246 28.5508 278.246 28.71089 curveto
278.246 29.125 278.574 29.46089 278.98001 29.46089 curveto
279.14499 29.46089 279.297 29.4062 279.422 29.3125 curveto
284.949 34.8047 lineto
284.89499 34.8906 284.85901 34.9844 284.84 35.08589 curveto
279.699 35.08589 lineto
279.64099 34.7344 279.34 34.4688 278.98001 34.4688 curveto
278.621 34.4688 278.32 34.7344 278.258 35.08589 curveto
273.22299 35.08589 lineto
273.164 34.7344 272.863 34.4688 272.504 34.4688 curveto
272.14099 34.4688 271.844 34.7344 271.781 35.08589 curveto
266.387 35.08589 lineto
272.10501 29.33589 lineto
272.219 29.4102 272.35501 29.457 272.5 29.457 curveto
272.90201 29.457 273.23001 29.1211 273.23001 28.707 curveto
273.23001 28.5625 273.19101 28.4258 273.125 28.3125 curveto
275.754 25.668 lineto
275.94101 25.47661 lineto
278.56601 22.8438 lineto
278.68399 22.9258 278.828 22.97661 278.98401 22.97661 curveto
279.387 22.97661 279.715 22.6406 279.715 22.22661 curveto
279.715 22.0742 279.672 21.9297 279.594 21.8086 curveto
285.422 15.9492 lineto
285.422 21.4883 lineto
285.082 21.5547 284.824 21.8594 284.824 22.2227 curveto
284.824 22.5898 285.082 22.8945 285.422 22.96089 curveto
285.422 27.9727 lineto
285.086 28.03911 284.832 28.3438 284.832 28.707 curveto
284.832 29.0742 285.086 29.375 285.422 29.4453 curveto
285.422 34.4805 lineto
285.31601 34.5039 285.219 34.5469 285.133 34.6094 curveto
279.60199 29.1133 lineto
279.672 28.9961 279.715 28.8594 279.715 28.71089 curveto
279.715 28.2969 279.387 27.96089 278.98001 27.96089 curveto
278.828 27.96089 278.68799 28.0078 278.57 28.0898 curveto
275.94101 25.47661 lineto
275.754 25.28911 lineto
273.10199 22.6562 lineto
273.18399 22.5312 273.23001 22.3867 273.23001 22.2305 curveto
273.23001 21.8164 272.90201 21.4805 272.496 21.4805 curveto
272.336 21.4805 272.18399 21.5312 272.06201 21.625 curveto
266.15201 15.75 lineto
 closepath fill
newpath 258.328 7.625 moveto
258.754 7.625 lineto
258.754 43.22661 lineto
258.328 43.22661 lineto
 closepath fill
 0.337 0.345 0.361 setrgbcolor
newpath 109.445 10.1641 moveto
109.445 10.5547 lineto
108.004 10.5547 lineto
108.004 13.3555 lineto
107.56601 13.3555 lineto
107.56601 10.1641 lineto
 closepath fill
newpath 112.195 11.543 moveto
112.195 11.8398 112.10199 12.082 111.922 12.2617 curveto
111.73 12.4492 111.46901 12.543 111.137 12.543 curveto
110.85199 12.543 110.605 12.4375 110.395 12.2305 curveto
110.16 11.9961 110.043 11.6914 110.043 11.3047 curveto
110.043 10.9336 110.15599 10.6406 110.387 10.418 curveto
110.59 10.2188 110.84 10.1211 111.133 10.1211 curveto
111.336 10.1211 111.52 10.1523 111.688 10.2109 curveto
111.82 10.2578 111.918 10.3164 111.98 10.3789 curveto
111.80899 10.6758 lineto
111.64801 10.5391 111.44899 10.4688 111.215 10.4688 curveto
111.008 10.4688 110.836 10.5352 110.703 10.6602 curveto
110.555 10.8086 110.48 11.0195 110.48 11.293 curveto
110.488 11.5898 lineto
110.508 11.7617 110.57399 11.9023 110.69101 12.0156 curveto
110.81601 12.1328 110.973 12.1953 111.15599 12.1953 curveto
111.355 12.1953 111.512 12.1328 111.625 12.0117 curveto
111.625 12.0117 lineto
111.73 11.8984 111.78099 11.7578 111.78099 11.5898 curveto
110.488 11.5898 lineto
110.48 11.293 lineto
112.16 11.293 lineto
112.18399 11.3672 112.195 11.4531 112.195 11.543 curveto
 closepath fill
newpath 113.277 13.3047 moveto
113.23 13.2578 113.203 13.1992 113.203 13.125 curveto
113.203 13.0547 113.23 12.9961 113.277 12.9453 curveto
113.328 12.8945 113.391 12.8672 113.461 12.8672 curveto
113.53099 12.8672 113.59 12.8945 113.641 12.9453 curveto
113.69101 12.9961 113.715 13.0547 113.715 13.125 curveto
113.715 13.1953 113.69101 13.2539 113.641 13.3047 curveto
113.59 13.3555 113.53099 13.3828 113.461 13.3828 curveto
113.387 13.3828 113.328 13.3555 113.277 13.3047 curveto
 closepath fill
newpath 113.645 10.1641 moveto
113.645 12.5 lineto
112.91 12.5 lineto
112.91 12.1484 lineto
113.23 12.1484 lineto
113.23 10.1641 lineto
 closepath fill
newpath 115.30101 10.1836 moveto
115.41 10.1406 115.516 10.1211 115.629 10.1211 curveto
115.96901 10.1211 116.238 10.2305 116.438 10.457 curveto
116.637 10.6797 116.734 10.9844 116.734 11.375 curveto
116.734 11.7109 116.637 11.9883 116.438 12.2109 curveto
116.238 12.4336 115.98 12.543 115.66 12.543 curveto
115.555 12.543 115.44899 12.5195 115.34 12.4727 curveto
115.234 12.4297 115.16 12.3789 115.121 12.3281 curveto
115.297 12.1289 lineto
115.391 12.1719 115.461 12.1953 115.512 12.1953 curveto
115.75 12.1953 115.94101 12.1211 116.086 11.9688 curveto
116.22699 11.8242 116.30101 11.6172 116.30101 11.3516 curveto
116.30101 11.0352 116.238 10.8086 116.117 10.6719 curveto
115.992 10.5391 115.793 10.4688 115.512 10.4688 curveto
115.457 10.4688 115.379 10.4961 115.27301 10.5508 curveto
115.172 10.6016 115.121 10.6406 115.121 10.6641 curveto
115.121 12.0117 lineto
115.14801 12.0469 115.207 12.0859 115.297 12.1289 curveto
115.297 12.1289 lineto
115.121 12.3281 lineto
115.121 13.4531 lineto
114.707 13.4531 lineto
114.707 10.1211 lineto
114.914 10.1211 lineto
115.05899 10.332 lineto
115.113 10.2734 115.195 10.2227 115.30101 10.1836 curveto
 closepath fill
newpath 119.445 10.1641 moveto
119.445 11.6094 lineto
119.445 12.2305 119.188 12.543 118.67601 12.543 curveto
118.367 12.543 118.145 12.4258 118.008 12.1992 curveto
117.879 12.5 lineto
117.59401 12.5 lineto
117.59401 10.1641 lineto
118.008 10.1641 lineto
118.008 11.8984 lineto
118.062 11.9805 118.141 12.0508 118.246 12.1094 curveto
118.348 12.1641 118.445 12.1953 118.543 12.1953 curveto
118.71901 12.1953 118.84401 12.1445 118.918 12.043 curveto
118.992 11.9453 119.03099 11.7695 119.03099 11.5234 curveto
119.03099 10.1641 lineto
 closepath fill
newpath 120.68 13.3047 moveto
120.633 13.2578 120.605 13.1992 120.605 13.125 curveto
120.605 13.0547 120.633 12.9961 120.68 12.9453 curveto
120.73 12.8945 120.793 12.8672 120.859 12.8672 curveto
120.93399 12.8672 120.992 12.8945 121.043 12.9453 curveto
121.09401 12.9961 121.117 13.0547 121.117 13.125 curveto
121.117 13.1953 121.09401 13.2539 121.043 13.3047 curveto
120.992 13.3555 120.93399 13.3828 120.859 13.3828 curveto
120.789 13.3828 120.73 13.3555 120.68 13.3047 curveto
 closepath fill
newpath 121.05101 10.1641 moveto
121.05101 12.5 lineto
120.312 12.5 lineto
120.312 12.1484 lineto
120.633 12.1484 lineto
120.633 10.1641 lineto
 closepath fill
newpath 123.832 12.3789 moveto
123.832 12.5 lineto
121.922 12.5 lineto
121.922 12.1289 lineto
123.22699 12.1289 lineto
121.902 10.2734 lineto
121.902 10.1641 lineto
123.84401 10.1641 lineto
123.84401 10.5352 lineto
122.55101 10.5352 lineto
 closepath fill
newpath 125.613 11.6484 moveto
124.68 11.6484 lineto
124.68 11.2695 lineto
125.613 11.2695 lineto
 closepath fill
newpath 128.102 13.4102 moveto
127.625 13.4102 127.246 13.2578 126.96901 12.9492 curveto
126.688 12.6445 126.547 12.2422 126.547 11.75 curveto
126.547 11.2539 126.67601 10.8555 126.93 10.5586 curveto
127.18399 10.2578 127.53099 10.1094 127.973 10.1094 curveto
128.172 10.1094 128.371 10.1406 128.578 10.1992 curveto
128.785 10.2617 128.949 10.3398 129.066 10.4375 curveto
129.066 11.8281 lineto
128.188 11.8281 lineto
128.188 11.4609 lineto
128.629 11.4609 lineto
128.629 10.7109 lineto
128.484 10.5742 128.297 10.5039 128.066 10.5039 curveto
127.738 10.5039 127.48 10.6133 127.289 10.8398 curveto
127.10199 11.0664 127.008 11.3633 127.008 11.7305 curveto
127.008 12.1211 127.10199 12.4297 127.297 12.668 curveto
127.488 12.9023 127.754 13.0195 128.086 13.0195 curveto
128.297 13.0195 128.512 12.9375 128.73 12.7734 curveto
128.914 13.1328 lineto
128.703 13.3203 128.434 13.4102 128.102 13.4102 curveto
 closepath fill
newpath 132.086 11.543 moveto
132.086 11.8398 131.992 12.082 131.812 12.2617 curveto
131.621 12.4492 131.363 12.543 131.027 12.543 curveto
130.742 12.543 130.496 12.4375 130.285 12.2305 curveto
130.051 11.9961 129.934 11.6914 129.934 11.3047 curveto
129.934 10.9336 130.051 10.6406 130.277 10.418 curveto
130.48 10.2188 130.73 10.1211 131.023 10.1211 curveto
131.227 10.1211 131.414 10.1523 131.578 10.2109 curveto
131.711 10.2578 131.809 10.3164 131.871 10.3789 curveto
131.699 10.6758 lineto
131.539 10.5391 131.344 10.4688 131.105 10.4688 curveto
130.898 10.4688 130.727 10.5352 130.594 10.6602 curveto
130.445 10.8086 130.371 11.0195 130.371 11.293 curveto
130.383 11.5898 lineto
130.398 11.7617 130.465 11.9023 130.586 12.0156 curveto
130.711 12.1328 130.863 12.1953 131.051 12.1953 curveto
131.246 12.1953 131.402 12.1328 131.516 12.0117 curveto
131.516 12.0117 lineto
131.621 11.8984 131.676 11.7578 131.676 11.5898 curveto
130.383 11.5898 lineto
130.371 11.293 lineto
132.055 11.293 lineto
132.074 11.3672 132.086 11.4531 132.086 11.543 curveto
 closepath fill
newpath 136.039 10.1641 moveto
136.039 11.7227 lineto
136.039 11.9844 135.973 12.1836 135.84 12.3281 curveto
135.711 12.4688 135.523 12.543 135.281 12.543 curveto
135.148 12.543 135.016 12.5117 134.891 12.4531 curveto
134.766 12.3945 134.68 12.3203 134.633 12.2305 curveto
134.496 12.4375 134.266 12.543 133.93 12.543 curveto
133.691 12.543 133.488 12.4375 133.332 12.2266 curveto
133.191 12.5 lineto
132.922 12.5 lineto
132.922 10.1641 lineto
133.336 10.1641 lineto
133.336 11.8867 lineto
133.379 11.9648 133.441 12.0352 133.535 12.0977 curveto
133.629 12.1602 133.719 12.1953 133.801 12.1953 curveto
133.945 12.1953 134.059 12.1602 134.145 12.0938 curveto
134.23 12.0273 134.273 11.9375 134.273 11.8242 curveto
134.273 10.1641 lineto
134.688 10.1641 lineto
134.688 11.8906 lineto
134.719 11.9688 134.781 12.0391 134.867 12.1016 curveto
134.953 12.1602 135.047 12.1953 135.148 12.1953 curveto
135.465 12.1953 135.625 12.0078 135.625 11.6406 curveto
135.625 10.1641 lineto
 closepath fill
newpath 139.027 11.543 moveto
139.027 11.8398 138.938 12.082 138.754 12.2617 curveto
138.562 12.4492 138.305 12.543 137.973 12.543 curveto
137.684 12.543 137.438 12.4375 137.227 12.2305 curveto
136.992 11.9961 136.879 11.6914 136.879 11.3047 curveto
136.879 10.9336 136.992 10.6406 137.219 10.418 curveto
137.426 10.2188 137.672 10.1211 137.965 10.1211 curveto
138.172 10.1211 138.355 10.1523 138.52 10.2109 curveto
138.652 10.2578 138.75 10.3164 138.812 10.3789 curveto
138.641 10.6758 lineto
138.48 10.5391 138.281 10.4688 138.047 10.4688 curveto
137.84 10.4688 137.668 10.5352 137.535 10.6602 curveto
137.387 10.8086 137.312 11.0195 137.312 11.293 curveto
137.324 11.5898 lineto
137.34 11.7617 137.406 11.9023 137.527 12.0156 curveto
137.652 12.1328 137.805 12.1953 137.988 12.1953 curveto
138.188 12.1953 138.344 12.1328 138.461 12.0117 curveto
138.461 12.0117 lineto
138.562 11.8984 138.613 11.7578 138.613 11.5898 curveto
137.324 11.5898 lineto
137.312 11.293 lineto
138.996 11.293 lineto
139.016 11.3672 139.027 11.4531 139.027 11.543 curveto
 closepath fill
newpath 140.109 13.3047 moveto
140.062 13.2578 140.035 13.1992 140.035 13.125 curveto
140.035 13.0547 140.062 12.9961 140.113 12.9453 curveto
140.16 12.8945 140.223 12.8672 140.293 12.8672 curveto
140.363 12.8672 140.426 12.8945 140.473 12.9453 curveto
140.523 12.9961 140.551 13.0547 140.551 13.125 curveto
140.551 13.1953 140.523 13.2539 140.473 13.3047 curveto
140.426 13.3555 140.363 13.3828 140.293 13.3828 curveto
140.219 13.3828 140.16 13.3555 140.109 13.3047 curveto
 closepath fill
newpath 140.48 10.1641 moveto
140.48 12.5 lineto
139.746 12.5 lineto
139.746 12.1484 lineto
140.066 12.1484 lineto
140.066 10.1641 lineto
 closepath fill
newpath 143.391 10.1641 moveto
143.391 11.6094 lineto
143.391 12.2305 143.133 12.543 142.621 12.543 curveto
142.312 12.543 142.09 12.4258 141.953 12.1992 curveto
141.82 12.5 lineto
141.539 12.5 lineto
141.539 10.1641 lineto
141.953 10.1641 lineto
141.953 11.8984 lineto
142.008 11.9805 142.086 12.0508 142.191 12.1094 curveto
142.293 12.1641 142.391 12.1953 142.488 12.1953 curveto
142.664 12.1953 142.789 12.1445 142.863 12.043 curveto
142.938 11.9453 142.977 11.7695 142.977 11.5234 curveto
142.977 10.1641 lineto
 closepath fill
newpath 144.918 10.1211 moveto
145.18 10.1211 145.383 10.1797 145.531 10.2969 curveto
145.676 10.418 145.75 10.582 145.75 10.7891 curveto
145.75 10.9492 145.707 11.082 145.625 11.1875 curveto
145.543 11.293 145.41 11.3906 145.23 11.4727 curveto
144.934 11.6055 lineto
144.762 11.6836 144.68 11.7969 144.68 11.9453 curveto
144.68 12.0195 144.711 12.0781 144.777 12.125 curveto
144.848 12.1719 144.93 12.1953 145.027 12.1953 curveto
145.195 12.1953 145.359 12.1289 145.523 11.9961 curveto
145.641 12.3789 lineto
145.383 12.4883 145.168 12.543 144.996 12.543 curveto
144.773 12.543 144.59 12.4883 144.449 12.3789 curveto
144.312 12.2734 144.242 12.125 144.242 11.9297 curveto
144.242 11.8555 144.254 11.7891 144.277 11.7227 curveto
144.301 11.6602 144.34 11.5977 144.387 11.5391 curveto
144.434 11.4844 144.492 11.4297 144.559 11.3867 curveto
144.625 11.3398 144.754 11.2773 144.941 11.1875 curveto
145.191 11.0781 145.312 10.9453 145.312 10.793 curveto
145.312 10.5781 145.188 10.4688 144.93 10.4688 curveto
144.789 10.4688 144.602 10.5469 144.371 10.6953 curveto
144.227 10.3047 lineto
144.441 10.1797 144.676 10.1211 144.918 10.1211 curveto
 closepath fill
newpath 148.035 12.4648 moveto
147.895 12.5156 147.766 12.543 147.645 12.543 curveto
147.27 12.543 146.973 12.4297 146.758 12.2031 curveto
146.543 11.9766 146.434 11.6797 146.434 11.3086 curveto
146.434 10.9453 146.539 10.6562 146.746 10.4414 curveto
146.953 10.2266 147.215 10.1211 147.535 10.1211 curveto
147.863 10.1211 148.137 10.1914 148.359 10.3359 curveto
148.199 10.6836 lineto
148.008 10.543 147.82 10.4688 147.637 10.4688 curveto
147.395 10.4688 147.207 10.543 147.074 10.6836 curveto
146.938 10.8281 146.871 11.0352 146.871 11.3086 curveto
146.871 11.582 146.938 11.8008 147.066 11.957 curveto
147.199 12.1133 147.379 12.1953 147.605 12.1953 curveto
147.707 12.1953 147.812 12.1758 147.918 12.1367 curveto
148.027 12.0977 148.102 12.0586 148.145 12.0156 curveto
148.348 12.3086 lineto
148.281 12.3633 148.176 12.4141 148.035 12.4648 curveto
 closepath fill
newpath 151.051 10.1641 moveto
151.051 11.6289 lineto
151.051 11.9141 150.98 12.1367 150.84 12.2969 curveto
150.699 12.4609 150.508 12.543 150.262 12.543 curveto
150.129 12.543 150.004 12.5156 149.879 12.457 curveto
149.758 12.3984 149.668 12.3281 149.613 12.2422 curveto
149.613 13.4531 lineto
149.199 13.4531 lineto
149.199 10.1641 lineto
149.613 10.1641 lineto
149.613 11.8984 lineto
149.664 11.9766 149.742 12.0469 149.844 12.1055 curveto
149.945 12.1641 150.047 12.1953 150.145 12.1953 curveto
150.301 12.1953 150.422 12.1445 150.508 12.043 curveto
150.594 11.9414 150.637 11.8047 150.637 11.6289 curveto
150.637 10.1641 lineto
 closepath fill
newpath 153.535 10.1953 moveto
153.621 10.1484 153.746 10.125 153.914 10.125 curveto
153.914 10.332 lineto
153.793 10.3984 153.73 10.5352 153.73 10.7383 curveto
153.73 11.5781 lineto
153.73 11.9141 153.656 12.1562 153.5 12.3086 curveto
153.348 12.4648 153.102 12.543 152.762 12.543 curveto
152.637 12.543 152.504 12.5195 152.367 12.4727 curveto
152.227 12.4258 152.117 12.3711 152.039 12.3086 curveto
152.215 11.9609 lineto
152.355 12.1016 152.555 12.1719 152.812 12.1719 curveto
153.148 12.1719 153.316 11.9844 153.316 11.6055 curveto
153.316 11.3086 lineto
153.316 10.7461 lineto
153.156 10.5469 152.973 10.4492 152.762 10.4492 curveto
152.477 10.4492 152.332 10.5703 152.332 10.8125 curveto
152.332 10.957 152.398 11.0859 152.531 11.1953 curveto
152.66 11.3008 152.836 11.3555 153.043 11.3555 curveto
153.094 11.3555 153.188 11.3398 153.316 11.3086 curveto
153.316 11.6055 lineto
153.207 11.6445 153.109 11.6602 153.02 11.6602 curveto
152.699 11.6602 152.438 11.5781 152.23 11.418 curveto
152.023 11.2539 151.918 11.0547 151.918 10.8164 curveto
151.918 10.6172 151.984 10.4531 152.121 10.3203 curveto
152.254 10.1875 152.414 10.1211 152.598 10.1211 curveto
152.938 10.1211 153.191 10.2227 153.355 10.4336 curveto
153.391 10.3242 153.453 10.2422 153.535 10.1953 curveto
 closepath fill
newpath 156.16 13.3906 moveto
156.023 13.4336 155.895 13.4531 155.773 13.4531 curveto
155.531 13.4531 155.34 13.3711 155.191 13.1992 curveto
155.047 13.0312 154.973 12.7969 154.973 12.5 curveto
154.633 12.5 lineto
154.633 12.1484 lineto
154.973 12.1484 lineto
154.973 10.1641 lineto
155.387 10.1641 lineto
155.387 12.1484 lineto
155.859 12.1484 lineto
155.859 12.5 lineto
155.387 12.5 lineto
155.379 12.5391 155.375 12.582 155.375 12.6211 curveto
155.375 12.7695 155.414 12.8906 155.496 12.9844 curveto
155.578 13.082 155.684 13.1289 155.812 13.1289 curveto
155.883 13.1289 155.961 13.1133 156.047 13.0859 curveto
 closepath fill
newpath 156.984 10.8477 moveto
156.984 10.6367 157.047 10.4648 157.176 10.3281 curveto
157.301 10.1914 157.457 10.1211 157.641 10.1211 curveto
157.848 10.1211 158.035 10.1445 158.207 10.1875 curveto
158.145 10.5508 lineto
158.031 10.4961 157.922 10.4688 157.816 10.4688 curveto
157.668 10.4688 157.562 10.5117 157.496 10.5938 curveto
157.43 10.6758 157.398 10.8164 157.398 11.0117 curveto
157.398 12.1719 lineto
158.039 12.1719 lineto
158.039 12.5 lineto
157.398 12.5 lineto
157.398 13.1445 lineto
156.984 12.9844 lineto
156.984 12.5 lineto
156.715 12.5 lineto
156.715 12.1719 lineto
156.984 12.1719 lineto
 closepath fill
 0.137 0.122 0.125 setrgbcolor
newpath 154.453 18.1328 moveto
154.902 17.7656 155.348 17.1875 156.949 18.6836 curveto
158.555 20.1836 157.738 19.5508 158.605 17.582 curveto
159.473 15.6094 160.023 16.6953 160.078 17.082 curveto
160.211 18.043 159.918 19.9297 159.719 20.6953 curveto
159.547 21.3398 158.445 21.6602 158.004 21.3398 curveto
157.586 21.0352 156.477 19.7852 155.742 19.5508 curveto
155.004 19.3125 155.59 20.02339 155.406 21.207 curveto
155.223 22.3906 154.785 22.9258 154.324 22.72661 curveto
154.012 22.5938 153.328 21.8945 153.008 22.0742 curveto
152.387 22.4258 151.953 23.9297 148.91 22.2578 curveto
145.359 20.3125 148.539 24.7305 148.539 24.7305 curveto
148.539 24.7305 150.906 27.96089 149.488 30.3008 curveto
148.066 32.6406 145.02 27.6211 145.02 27.6211 curveto
145.02 27.6211 143.414 24.4375 142.707 21.0742 curveto
141.996 17.71089 140.547 18.0938 140.004 18.8125 curveto
139.414 19.5898 139.578 22.6523 137.477 21.3633 curveto
135.371 20.0781 135.398 17.5 134.137 20.418 curveto
132.875 23.33589 131.551 21.46089 131.379 21.1562 curveto
131.137 20.7227 131.262 19.7812 130.906 19.5781 curveto
130.504 19.3477 130 20.1758 129.695 20.2852 curveto
129.367 20.4062 127.246 18.4258 126.28099 16.58589 curveto
124.891 13.9336 122.66 20.3086 122.879 20.707 curveto
123.06601 21.0547 128.5 28.5781 129.012 29.6719 curveto
129.547 30.8047 130.328 31.1406 130.723 31.1953 curveto
131.113 31.2461 136.137 32.0898 139.762 35.9258 curveto
143.391 39.7617 142.84 40.71089 141.102 41.6836 curveto
141 40.4922 lineto
141.406 40.02339 141.441 38.9219 140.562 38.043 curveto
139.688 37.16411 136.801 34.2188 134.988 33.47661 curveto
133.273 32.77339 127.391 29.9688 133.262 35.33589 curveto
133.262 35.33589 lineto
138.215 39.8633 138.074 39.7422 138.473 39.9023 curveto
138.949 40.0898 140.668 40.8789 141 40.4922 curveto
141.102 41.6836 lineto
139.367 42.6562 134.422 37.8086 134.191 37.6328 curveto
134.02 37.5078 129.934 32.9023 129.645 32.3242 curveto
129.355 31.7461 122.625 32.1133 122.625 32.1133 curveto
121.848 31.7344 122.711 31.41411 122.711 31.41411 curveto
122.711 31.41411 125.72699 30.97661 127.613 31.0273 curveto
129.496 31.0781 128.25 29.97661 128.027 29.7148 curveto
126.57 27.9844 123.82 23.2852 122.84 22.3047 curveto
121.859 21.3242 119.98 22.418 119.871 22.4336 curveto
119.762 22.4531 116.957 22.8711 117.52301 20.7305 curveto
118.09401 18.5898 119.797 19.53911 120.621 19.3398 curveto
119.695 20.0312 lineto
119.52 19.957 119.027 20.3789 119.047 20.60161 curveto
119.082 21.03911 119.53099 20.5898 120.05101 20.60161 curveto
120.578 20.6172 119.883 20.1055 119.695 20.0312 curveto
120.621 19.3398 lineto
120.871 19.2773 121.23 18.83589 121.367 18.6172 curveto
121.785 17.9531 121.984 16.89839 122.422 16.2461 curveto
123.062 15.293 125.496 12.9258 127.379 16.3477 curveto
129.336 19.8945 130.578 18.5625 130.684 16.6289 curveto
130.785 14.6953 131.402 15.418 132.102 15.7266 curveto
132.797 16.0352 132.203 17.3789 132.281 19.1328 curveto
132.359 20.8867 133.805 18.3594 133.699 17.6602 curveto
133.598 16.9648 134.68 17.0938 135.637 17.4805 curveto
136.59 17.8672 135.844 18.46089 137.156 19.6758 curveto
138.473 20.8867 138.539 18.03911 138.883 17.375 curveto
139.16 16.8438 140.535 15.7266 141.234 17.2227 curveto
141.93 18.7188 143.02 18.3945 142.785 16.8711 curveto
143.734 17.0703 lineto
143.246 18.8477 144.512 20.3438 144.512 20.3438 curveto
144.512 20.3438 145.047 21.0664 145.387 21.0352 curveto
144.535 21.4023 lineto
144.117 20.9375 143.762 20.5781 144.098 21.8672 curveto
144.434 23.1562 144.312 22.6133 144.523 23.0938 curveto
144.727 23.5664 145.629 25.96089 145.695 26.1523 curveto
145.734 26.2578 146.531 27.8125 147.34 28.9883 curveto
147.34 28.9883 149.516 30.9102 148.637 27.4414 curveto
148.051 25.1133 147.387 24.8555 146.324 23.1836 curveto
146.324 23.1836 lineto
146.117 22.8633 145.758 23.6094 145.023 22.6797 curveto
144.719 22.28911 144.91 21.8164 144.535 21.4023 curveto
145.387 21.0352 lineto
145.809 20.9961 146.652 20.8594 146.367 19.8281 curveto
146.367 19.8281 lineto
146.086 18.7969 145.664 17.0898 145.191 16.6523 curveto
144.773 16.2656 144.219 15.2891 143.734 17.0703 curveto
142.785 16.8711 lineto
142.547 15.3477 143.859 14.7461 144.281 14.7656 curveto
144.684 14.7852 146.988 16.0547 147.016 18.6055 curveto
147.043 21.1562 148.863 21.1406 149.172 21.1797 curveto
149.48 21.2227 151.824 21.60161 151.613 20.918 curveto
151.406 20.2344 150.352 18.2617 151.562 18.28911 curveto
152.773 18.3164 152.273 19.3672 153.402 20.5508 curveto
154.531 21.7344 154.008 18.5 154.453 18.1328 curveto
 closepath fill
newpath 139.906 28.9102 moveto
139.746 27.1992 140.797 27.7539 140.797 27.7539 curveto
142.758 28.7617 141.207 29.6953 141.207 29.6953 curveto
141.207 29.6953 140.066 30.6172 139.906 28.9102 curveto
 closepath fill
newpath 168.477 13.6367 moveto
168.379 13.9102 168.172 14.2812 167.355 13.2734 curveto
166.105 11.7383 166.273 12.707 166.156 13.7148 curveto
166.137 13.8867 166.258 14.3438 165.398 15.0703 curveto
164.953 15.4492 162.859 16.0312 163.332 16.5078 curveto
164.535 17.7305 164.223 17.6094 164.66 18.1523 curveto
165.098 18.6953 166.723 20.293 166.645 22.5625 curveto
166.57 24.83589 163.293 24.6289 163.293 24.6289 curveto
161.152 24.2383 162.055 22.2812 163.602 22.4102 curveto
165.047 22.5273 164.852 21.3164 164.746 20.9258 curveto
164.746 20.9258 lineto
164.738 20.89839 164.73 20.875 164.723 20.8555 curveto
164.746 20.9258 lineto
164.746 20.9258 lineto
164.742 20.9258 164.562 20.457 164.207 19.8906 curveto
163.727 19.1367 163.137 18.0469 162.566 17.4961 curveto
162.258 17.1992 160.598 16.1406 161.797 15.5469 curveto
163.781 14.5625 165.277 12.4766 164.504 11.3164 curveto
163.73 10.1523 157.645 7.84375 156.379 7.28906 curveto
155.152 6.7539 152.738 6.59375 152.789 3.44531 curveto
152.844 0.30078 156.199 0.32813 157.668 0.71094 curveto
157.445 1.60547 lineto
155.02 1.26953 153.695 2.67188 153.719 3.52344 curveto
153.746 4.375 154.539 5.48828 157.195 6.8086 curveto
163.152 9.75781 163.676 9.98438 163.676 9.98438 curveto
164.105 10.1562 165.027 10.7031 164.484 9.79297 curveto
164.484 9.79297 lineto
164.484 9.79297 162.109 5.21875 161.848 4.8125 curveto
161.527 4.32031 159.871 1.9414 157.445 1.60547 curveto
157.668 0.71094 lineto
160.238 1.38672 161.312 2.38672 162.285 3.5 curveto
163.32 4.67969 165.379 9.35547 165.434 9.40625 curveto
165.484 9.45703 166.156 12.168 167.344 12.4766 curveto
168.527 12.7852 168.621 13.2344 168.477 13.6367 curveto
 closepath fill
newpath 162.328 27.9258 moveto
161.727 28.1719 159.926 27.2422 160.465 25.6914 curveto
161.016 24.1055 165.105 26.7773 162.328 27.9258 curveto
 closepath fill
newpath 110.887 41.3242 moveto
110.164 41.3242 lineto
109.336 39.2344 lineto
108.586 41.3242 lineto
107.82 41.3242 lineto
107.82 41.2188 lineto
107.883 41.1992 107.93 41.1797 107.957 41.168 curveto
107.984 41.1523 108.008 41.1328 108.02301 41.1055 curveto
108.039 41.082 108.05101 41.0469 108.05899 41.0039 curveto
108.06601 40.957 108.07 40.8867 108.07 40.7852 curveto
108.07 38.9336 lineto
108.07 38.8281 108.062 38.7461 108.055 38.6953 curveto
108.047 38.6445 108.027 38.6055 107.996 38.5781 curveto
107.965 38.5508 107.90599 38.52339 107.82 38.5 curveto
107.82 38.39839 lineto
108.60199 38.39839 lineto
108.60199 38.5 lineto
108.535 38.5195 108.488 38.5352 108.457 38.5508 curveto
108.43 38.5703 108.40599 38.5898 108.391 38.6172 curveto
108.379 38.6445 108.367 38.6797 108.359 38.7227 curveto
108.35199 38.7656 108.35199 38.83589 108.35199 38.9336 curveto
108.35199 39.7148 lineto
108.35199 39.957 108.348 40.1953 108.34 40.4219 curveto
108.336 40.6523 108.328 40.8086 108.32 40.8945 curveto
108.355 40.8945 lineto
109.145 38.7344 lineto
109.391 38.7344 lineto
110.242 40.8594 lineto
110.277 40.8594 lineto
110.27 40.7812 110.262 40.6289 110.254 40.4102 curveto
110.246 40.1875 110.246 39.9688 110.246 39.7539 curveto
110.246 38.9336 lineto
110.246 38.8164 110.238 38.7344 110.22699 38.6836 curveto
110.215 38.6328 110.195 38.5938 110.164 38.5703 curveto
110.133 38.543 110.07399 38.52339 109.992 38.5 curveto
109.992 38.39839 lineto
110.887 38.39839 lineto
110.887 38.5 lineto
110.82 38.5195 110.77301 38.5352 110.746 38.5508 curveto
110.715 38.5703 110.695 38.5898 110.68 38.6172 curveto
110.664 38.6445 110.652 38.6797 110.64801 38.7227 curveto
110.641 38.7656 110.637 38.83589 110.637 38.9336 curveto
110.637 40.7852 lineto
110.637 40.8867 110.641 40.957 110.64801 41.0039 curveto
110.65599 41.0508 110.668 41.08589 110.68399 41.1094 curveto
110.703 41.1367 110.723 41.1562 110.754 41.1719 curveto
110.78099 41.1875 110.82399 41.2031 110.887 41.2188 curveto
 closepath fill
newpath 111.57399 40.8711 moveto
111.96901 40.8711 lineto
111.96901 41.2852 lineto
111.57399 41.2852 lineto
 closepath fill
newpath 111.355 38.39839 moveto
112.195 38.39839 lineto
112.195 38.5 lineto
112.121 38.5195 112.07 38.543 112.039 38.5664 curveto
112.008 38.5898 111.984 38.6289 111.973 38.6758 curveto
111.961 38.7227 111.957 38.8086 111.957 38.9336 curveto
111.957 40.4648 lineto
111.82399 40.4648 lineto
111.32399 40.4453 lineto
111.32399 40.332 lineto
111.391 40.3203 111.438 40.3047 111.473 40.28911 curveto
111.508 40.27339 111.535 40.25 111.555 40.2148 curveto
111.57 40.1797 111.578 40.1367 111.582 40.082 curveto
111.586 40.0273 111.586 39.9531 111.586 39.8594 curveto
111.586 38.9258 lineto
111.586 38.8242 111.582 38.7539 111.57399 38.7031 curveto
111.562 38.6602 111.55101 38.6211 111.535 38.60161 curveto
111.52 38.5781 111.496 38.5586 111.473 38.5469 curveto
111.44899 38.5352 111.41 38.5195 111.355 38.5 curveto
 closepath fill
newpath 112.445 40.2305 moveto
112.766 40.2305 lineto
112.766 39.03911 lineto
112.766 38.8047 112.80899 38.6367 112.89801 38.5273 curveto
112.988 38.418 113.125 38.3633 113.30899 38.3633 curveto
113.40599 38.3633 113.5 38.3828 113.59401 38.4297 curveto
113.68399 38.4727 113.777 38.543 113.879 38.6445 curveto
113.785 38.7578 lineto
113.734 38.7148 113.688 38.6797 113.637 38.6562 curveto
113.586 38.6328 113.53099 38.6211 113.47699 38.6211 curveto
113.41 38.6211 113.359 38.6328 113.32 38.6523 curveto
113.28099 38.6719 113.246 38.7031 113.215 38.75 curveto
113.18399 38.7969 113.16 38.8633 113.14801 38.9453 curveto
113.137 39.0273 113.133 39.1367 113.133 39.2773 curveto
113.133 40.2305 lineto
113.82399 40.2305 lineto
113.82399 40.4453 lineto
113.133 40.4453 lineto
113.133 40.97661 lineto
112.828 40.97661 lineto
112.812 40.8438 112.797 40.7461 112.78099 40.6797 curveto
112.77 40.6094 112.75 40.5547 112.723 40.5078 curveto
112.69899 40.4648 112.664 40.4258 112.621 40.39839 curveto
112.57399 40.3711 112.52 40.3477 112.445 40.3398 curveto
 closepath fill
newpath 115.94899 40.4453 moveto
115.19101 40.4453 lineto
115.09 40.4688 114.988 40.4805 114.887 40.4805 curveto
114.883 40.3203 lineto
114.961 40.3203 115.03099 40.3008 115.09401 40.2617 curveto
115.15599 40.2227 115.203 40.1602 115.238 40.0742 curveto
115.27301 39.9922 115.293 39.8867 115.293 39.7578 curveto
115.293 39.6914 115.285 39.625 115.27 39.5586 curveto
115.258 39.4961 115.23 39.4414 115.19899 39.3906 curveto
115.168 39.3438 115.125 39.3047 115.07399 39.2773 curveto
115.02301 39.25 114.961 39.2344 114.887 39.2344 curveto
114.75 39.2344 114.645 39.2812 114.57399 39.3789 curveto
114.5 39.47661 114.465 39.6172 114.465 39.793 curveto
114.465 39.9648 114.5 40.0938 114.57 40.1836 curveto
114.57 40.1836 lineto
114.641 40.27339 114.746 40.3203 114.883 40.3203 curveto
114.887 40.4805 lineto
114.77301 40.4805 114.664 40.4688 114.56601 40.4375 curveto
114.46901 40.4102 114.383 40.3633 114.30899 40.3047 curveto
114.238 40.2461 114.18399 40.1719 114.141 40.082 curveto
114.10199 39.9883 114.078 39.8828 114.078 39.7578 curveto
114.078 39.6289 114.105 39.5117 114.16 39.4102 curveto
114.215 39.3047 114.293 39.2227 114.395 39.16411 curveto
114.277 39.0781 114.19899 39 114.152 38.9297 curveto
114.105 38.8633 114.086 38.78911 114.086 38.707 curveto
114.086 38.6367 114.105 38.5742 114.141 38.5195 curveto
114.18 38.4688 114.234 38.4258 114.30101 38.4023 curveto
114.19101 38.3438 114.105 38.2812 114.047 38.207 curveto
113.984 38.1328 113.957 38.0508 113.957 37.96089 curveto
113.957 37.8594 113.98 37.7773 114.02301 37.71089 curveto
114.07 37.6445 114.137 37.5898 114.223 37.5508 curveto
114.30899 37.5117 114.41 37.4805 114.527 37.4648 curveto
114.64801 37.4453 114.78099 37.4375 114.92601 37.4375 curveto
114.922 37.6055 lineto
114.711 37.6055 114.555 37.6367 114.453 37.6992 curveto
114.348 37.7578 114.297 37.8555 114.297 37.9805 curveto
114.297 38.0586 114.31601 38.1289 114.35199 38.1914 curveto
114.391 38.25 114.445 38.3086 114.516 38.3633 curveto
114.605 38.35161 114.707 38.3477 114.82399 38.3477 curveto
114.82399 38.3477 lineto
115.145 38.3477 lineto
115.22699 38.3477 115.293 38.3398 115.34401 38.3242 curveto
115.395 38.3047 115.438 38.2812 115.465 38.25 curveto
115.492 38.2188 115.512 38.1875 115.52 38.14839 curveto
115.53099 38.1094 115.535 38.0742 115.535 38.0312 curveto
115.535 37.9453 115.512 37.8711 115.461 37.8047 curveto
115.414 37.7422 115.34401 37.6953 115.25 37.6602 curveto
115.16 37.625 115.05101 37.6055 114.922 37.6055 curveto
114.92601 37.4375 lineto
115.117 37.4375 115.289 37.4688 115.43399 37.5273 curveto
115.578 37.58589 115.69101 37.668 115.77 37.77339 curveto
115.848 37.875 115.887 37.9961 115.887 38.1289 curveto
115.887 38.2344 115.863 38.3281 115.82399 38.4102 curveto
115.78099 38.4883 115.715 38.5508 115.617 38.5977 curveto
115.52301 38.6445 115.39801 38.668 115.246 38.668 curveto
114.734 38.668 lineto
114.637 38.668 114.562 38.6758 114.516 38.6836 curveto
114.46901 38.6992 114.43399 38.7148 114.414 38.7422 curveto
114.391 38.7695 114.383 38.8086 114.383 38.8633 curveto
114.383 38.9453 114.438 39.0273 114.547 39.1094 curveto
114.633 39.0781 114.734 39.0625 114.85199 39.0625 curveto
115.117 39.0625 115.32 39.125 115.465 39.2539 curveto
115.605 39.3789 115.68 39.5586 115.68 39.793 curveto
115.68 39.8789 115.664 39.9648 115.641 40.03911 curveto
115.613 40.1172 115.578 40.1758 115.535 40.2188 curveto
115.555 40.2461 lineto
115.94899 40.2305 lineto
 closepath fill
newpath 116.738 41.4648 moveto
116.609 41.4648 lineto
116.09401 41.4414 lineto
116.09401 41.332 lineto
116.168 41.3203 116.21901 41.3047 116.246 41.293 curveto
116.27301 41.2812 116.297 41.2617 116.312 41.2422 curveto
116.328 41.2188 116.34401 41.1914 116.35199 41.1523 curveto
116.359 41.1133 116.367 41.0703 116.367 41.0156 curveto
116.371 40.96089 116.371 40.8633 116.371 40.72661 curveto
116.371 38.9336 lineto
116.371 38.8555 116.367 38.793 116.363 38.7461 curveto
116.359 38.6953 116.35199 38.6602 116.34 38.6328 curveto
116.32399 38.60161 116.305 38.5781 116.277 38.5586 curveto
116.25 38.53911 116.19899 38.5195 116.129 38.5 curveto
116.129 38.39839 lineto
116.98 38.39839 lineto
116.98 38.5 lineto
116.90599 38.5195 116.855 38.543 116.82399 38.5664 curveto
116.789 38.5898 116.77 38.6289 116.758 38.6758 curveto
116.746 38.7227 116.738 38.8086 116.738 38.9336 curveto
 closepath fill
newpath 117.578 40.8711 moveto
117.973 40.8711 lineto
117.973 41.2852 lineto
117.578 41.2852 lineto
 closepath fill
newpath 117.359 38.39839 moveto
118.19899 38.39839 lineto
118.19899 38.5 lineto
118.129 38.5195 118.07399 38.543 118.043 38.5664 curveto
118.012 38.5898 117.988 38.6289 117.97699 38.6758 curveto
117.965 38.7227 117.961 38.8086 117.961 38.9336 curveto
117.961 40.4648 lineto
117.828 40.4648 lineto
117.328 40.4453 lineto
117.328 40.332 lineto
117.395 40.3203 117.44101 40.3047 117.47699 40.28911 curveto
117.512 40.27339 117.539 40.25 117.55899 40.2148 curveto
117.57399 40.1797 117.586 40.1367 117.586 40.082 curveto
117.59 40.0273 117.59 39.9531 117.59 39.8594 curveto
117.59 38.9258 lineto
117.59 38.8242 117.586 38.7539 117.578 38.7031 curveto
117.56601 38.6602 117.555 38.6211 117.539 38.60161 curveto
117.52301 38.5781 117.504 38.5586 117.47699 38.5469 curveto
117.453 38.5352 117.414 38.5195 117.359 38.5 curveto
 closepath fill
newpath 120.16 38.9023 moveto
120.06601 38.8008 119.97699 38.7305 119.883 38.6875 curveto
119.789 38.6445 119.68399 38.6211 119.56601 38.6211 curveto
119.42601 38.6211 119.312 38.6523 119.22699 38.7188 curveto
119.141 38.7852 119.078 38.875 119.039 38.9883 curveto
119.004 39.1055 118.984 39.2461 118.984 39.41411 curveto
118.984 39.4531 lineto
120.336 39.4531 lineto
120.332 39.64839 120.312 39.8047 120.277 39.9258 curveto
120.242 40.0469 120.195 40.14839 120.137 40.22661 curveto
120.07399 40.3047 119.996 40.3672 119.895 40.41411 curveto
119.793 40.46089 119.668 40.4805 119.52301 40.4805 curveto
119.504 40.3125 lineto
119.60199 40.3125 119.68 40.2852 119.738 40.2344 curveto
119.80101 40.1836 119.84401 40.1055 119.875 40.0078 curveto
119.902 39.9102 119.922 39.7852 119.93399 39.6328 curveto
118.996 39.6328 lineto
119.012 39.8477 119.062 40.0195 119.152 40.1367 curveto
119.238 40.2539 119.355 40.3125 119.504 40.3125 curveto
119.52301 40.4805 lineto
119.34 40.4805 119.17601 40.4375 119.035 40.3477 curveto
118.895 40.2617 118.785 40.1328 118.711 39.9727 curveto
118.633 39.8086 118.59401 39.6211 118.59401 39.4102 curveto
118.59401 39.0625 118.668 38.8047 118.82 38.6289 curveto
118.96901 38.4492 119.19101 38.3633 119.484 38.3633 curveto
119.598 38.3633 119.695 38.3789 119.789 38.4102 curveto
119.879 38.4375 119.965 38.4805 120.039 38.5352 curveto
120.117 38.5898 120.19899 38.66411 120.293 38.7617 curveto
 closepath fill
newpath 122.168 40.3867 moveto
122.086 40.4219 122.008 40.4453 121.93 40.46089 curveto
121.85199 40.4727 121.766 40.4805 121.672 40.4805 curveto
121.496 40.4805 121.34 40.4414 121.195 40.3633 curveto
121.05899 40.2812 120.945 40.1602 120.863 39.9961 curveto
120.777 39.832 120.738 39.6328 120.738 39.39839 curveto
120.738 39.0625 120.80101 38.8086 120.93 38.6289 curveto
121.055 38.4492 121.238 38.3633 121.473 38.3633 curveto
121.55899 38.3633 121.637 38.375 121.711 38.4062 curveto
121.785 38.4336 121.859 38.4727 121.92601 38.5195 curveto
121.992 38.5664 122.07 38.6406 122.16 38.7344 curveto
122.02 38.7852 lineto
121.97699 38.7422 121.93399 38.71089 121.895 38.6875 curveto
121.855 38.66411 121.812 38.64839 121.77301 38.6367 curveto
121.73 38.625 121.68 38.6211 121.617 38.6211 curveto
121.457 38.6211 121.336 38.6914 121.258 38.832 curveto
121.18 38.97661 121.141 39.1836 121.141 39.46089 curveto
121.141 39.7344 121.188 39.9453 121.285 40.0898 curveto
121.379 40.2383 121.52 40.3086 121.703 40.3086 curveto
121.77 40.3086 121.828 40.3047 121.875 40.28911 curveto
121.922 40.27339 121.96901 40.25 122.008 40.2188 curveto
122.047 40.1914 122.078 40.1523 122.10199 40.1055 curveto
122.125 40.0586 122.145 40.0039 122.152 39.9336 curveto
122.16 39.8672 122.168 39.7812 122.168 39.668 curveto
122.168 39.1875 lineto
122.168 39.1172 122.16 39.0586 122.152 39.0156 curveto
122.145 38.9727 122.129 38.9336 122.109 38.89839 curveto
122.09 38.8633 122.05899 38.8242 122.02 38.7852 curveto
122.16 38.7344 lineto
122.19101 38.72661 lineto
122.164 38.375 lineto
122.293 38.375 lineto
122.80101 38.39839 lineto
122.80101 38.5078 lineto
122.723 38.52339 122.668 38.53911 122.637 38.5586 curveto
122.605 38.5781 122.586 38.5977 122.57 38.6289 curveto
122.555 38.6562 122.547 38.6953 122.543 38.7422 curveto
122.539 38.78911 122.535 38.8711 122.535 38.9805 curveto
122.535 41.4648 lineto
122.41 41.4648 lineto
121.891 41.4414 lineto
121.891 41.332 lineto
121.965 41.3203 122.016 41.3047 122.043 41.293 curveto
122.07 41.2812 122.09401 41.2617 122.109 41.2422 curveto
122.125 41.2188 122.137 41.1914 122.14801 41.1523 curveto
122.15599 41.1133 122.16 41.0703 122.164 41.0156 curveto
122.164 40.96089 122.168 40.8633 122.168 40.72661 curveto
 closepath fill
newpath 125.57 40.3867 moveto
125.488 40.4219 125.41 40.4453 125.332 40.46089 curveto
125.254 40.4727 125.168 40.4805 125.07399 40.4805 curveto
124.89801 40.4805 124.738 40.4414 124.598 40.3633 curveto
124.457 40.2812 124.348 40.1602 124.266 39.9961 curveto
124.18 39.832 124.141 39.6328 124.141 39.39839 curveto
124.141 39.0625 124.203 38.8086 124.328 38.6289 curveto
124.457 38.4492 124.641 38.3633 124.871 38.3633 curveto
124.957 38.3633 125.039 38.375 125.113 38.4062 curveto
125.188 38.4336 125.258 38.4727 125.32399 38.5195 curveto
125.395 38.5664 125.473 38.6406 125.562 38.7344 curveto
125.422 38.7852 lineto
125.379 38.7422 125.336 38.71089 125.297 38.6875 curveto
125.258 38.66411 125.215 38.64839 125.17601 38.6367 curveto
125.133 38.625 125.082 38.6211 125.02 38.6211 curveto
124.859 38.6211 124.738 38.6914 124.66 38.832 curveto
124.582 38.97661 124.543 39.1836 124.543 39.46089 curveto
124.543 39.7344 124.59 39.9453 124.688 40.0898 curveto
124.78099 40.2383 124.922 40.3086 125.105 40.3086 curveto
125.172 40.3086 125.23 40.3047 125.277 40.28911 curveto
125.32399 40.27339 125.367 40.25 125.41 40.2188 curveto
125.44899 40.1914 125.48 40.1523 125.504 40.1055 curveto
125.527 40.0586 125.543 40.0039 125.555 39.9336 curveto
125.562 39.8672 125.57 39.7812 125.57 39.668 curveto
125.57 39.1875 lineto
125.57 39.1172 125.562 39.0586 125.555 39.0156 curveto
125.543 38.9727 125.53099 38.9336 125.512 38.89839 curveto
125.492 38.8633 125.461 38.8242 125.422 38.7852 curveto
125.562 38.7344 lineto
125.59401 38.72661 lineto
125.56601 38.375 lineto
125.695 38.375 lineto
126.203 38.39839 lineto
126.203 38.5078 lineto
126.125 38.52339 126.07 38.53911 126.039 38.5586 curveto
126.008 38.5781 125.988 38.5977 125.973 38.6289 curveto
125.957 38.6562 125.94899 38.6953 125.945 38.7422 curveto
125.94101 38.78911 125.938 38.8711 125.938 38.9805 curveto
125.938 41.4648 lineto
125.812 41.4648 lineto
125.293 41.4414 lineto
125.293 41.332 lineto
125.367 41.3203 125.414 41.3047 125.445 41.293 curveto
125.473 41.2812 125.492 41.2617 125.512 41.2422 curveto
125.527 41.2188 125.539 41.1914 125.55101 41.1523 curveto
125.55899 41.1133 125.562 41.0703 125.56601 41.0156 curveto
125.56601 40.96089 125.57 40.8633 125.57 40.72661 curveto
 closepath fill
newpath 128.141 38.9023 moveto
128.047 38.8008 127.953 38.7305 127.859 38.6875 curveto
127.766 38.6445 127.66 38.6211 127.543 38.6211 curveto
127.40599 38.6211 127.293 38.6523 127.207 38.7188 curveto
127.121 38.7852 127.05899 38.875 127.02 38.9883 curveto
126.98 39.1055 126.965 39.2461 126.965 39.41411 curveto
126.965 39.4531 lineto
128.312 39.4531 lineto
128.309 39.64839 128.289 39.8047 128.258 39.9258 curveto
128.223 40.0469 128.176 40.14839 128.113 40.22661 curveto
128.055 40.3047 127.973 40.3672 127.871 40.41411 curveto
127.77 40.46089 127.64801 40.4805 127.504 40.4805 curveto
127.48 40.3125 lineto
127.578 40.3125 127.65599 40.2852 127.71901 40.2344 curveto
127.777 40.1836 127.82399 40.1055 127.85199 40.0078 curveto
127.883 39.9102 127.902 39.7852 127.91 39.6328 curveto
126.973 39.6328 lineto
126.988 39.8477 127.039 40.0195 127.129 40.1367 curveto
127.21901 40.2539 127.336 40.3125 127.48 40.3125 curveto
127.504 40.4805 lineto
127.31601 40.4805 127.15599 40.4375 127.016 40.3477 curveto
126.871 40.2617 126.766 40.1328 126.688 39.9727 curveto
126.609 39.8086 126.57 39.6211 126.57 39.4102 curveto
126.57 39.0625 126.64801 38.8047 126.797 38.6289 curveto
126.94899 38.4492 127.172 38.3633 127.465 38.3633 curveto
127.57399 38.3633 127.67601 38.3789 127.766 38.4102 curveto
127.859 38.4375 127.94101 38.4805 128.02 38.5352 curveto
128.094 38.5898 128.18 38.66411 128.27 38.7617 curveto
 closepath fill
newpath 129.301 40.4648 moveto
129.172 40.4648 lineto
128.668 40.4453 lineto
128.668 40.332 lineto
128.734 40.3203 128.781 40.3047 128.816 40.28911 curveto
128.852 40.27339 128.879 40.25 128.895 40.2148 curveto
128.914 40.1797 128.926 40.1367 128.926 40.082 curveto
128.93 40.0273 128.93 39.9531 128.93 39.8594 curveto
128.93 38.9258 lineto
128.93 38.8242 128.926 38.7539 128.918 38.7031 curveto
128.91 38.6602 128.895 38.6211 128.879 38.60161 curveto
128.863 38.5781 128.844 38.5586 128.816 38.5469 curveto
128.793 38.5352 128.758 38.5195 128.699 38.5 curveto
128.699 38.39839 lineto
129.566 38.39839 lineto
129.566 38.5 lineto
129.492 38.5156 129.438 38.5312 129.402 38.5547 curveto
129.363 38.5781 129.34 38.6133 129.324 38.66411 curveto
129.309 38.71089 129.301 38.8008 129.301 38.9336 curveto
129.301 39.6836 lineto
129.301 39.75 129.309 39.8086 129.324 39.8594 curveto
129.344 39.9102 129.379 39.9648 129.426 40.02339 curveto
129.473 40.0781 129.52 40.1211 129.57 40.1523 curveto
129.621 40.1836 129.672 40.1953 129.723 40.1953 curveto
129.789 40.1953 129.844 40.1797 129.883 40.1445 curveto
129.922 40.1094 129.957 40.0547 129.992 39.97661 curveto
130.234 39.97661 lineto
130.234 40.4688 lineto
130.168 40.47661 130.094 40.4805 130.008 40.4805 curveto
129.91 40.4805 129.82 40.4688 129.742 40.4375 curveto
129.664 40.4062 129.594 40.3633 129.527 40.3086 curveto
129.461 40.2539 129.387 40.1797 129.309 40.082 curveto
129.277 40.0898 lineto
 closepath fill
showpage
%%EOF
}
