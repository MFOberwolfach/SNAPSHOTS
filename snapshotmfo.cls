%% snapshotmfo.cls
%% Copyright 2014 - 2023 Mathematisches Forschungsinstitut Oberwolfach, www.mfo.de
%%  developed within the project IMAGINARY, www.imaginary.org
%%  supported by the Klaus Tschira Stiftung
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   https://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is Helmut Kastenholz
% (Mathematisches Forschungsinstitut Oberwolfach).
%
% This work consists of the file snapshotmfo.cls.
%
% The following authors contributed to the initial version of this work (in alphabetical order):
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
\ProvidesClass{snapshotmfo}[2023/05/19 Document class for "Snapshots of modern mathematics from Oberwolfach"]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% snapshotmfo is based on the Koma-Script ‘article’ class
\LoadClass[10pt,twoside]{scrartcl}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% require pdflatex compiler if possible
\IfFileExists{iftex.sty}{\RequirePackage{iftex}\RequirePDFTeX}{}
\RequirePackage{ifpdf}
\ifpdf\else\ClassError{snapshotmfo}{The snapshotmfo document class only works with pdflatex}{Use pdflatex to compile your document}\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% misc (internal)
\def\snapshot@defaultcontent{will be filled out by the editors}

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
\RequirePackage{etoolbox,ifthen,environ,iflang}
\@ifpackagelater{etoolbox}{2009/08/06}{}{\ClassError{snapshotmfo}{etoolbox v1.8 (2009/08/06) or later required}{Please update your TeX distribution to meet the requirements.}\stop}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% formatting of abstract and setting it 'subject' PDF meta data
\let\snapshot@abstract\abstract
\let\snapshot@endabstract\endabstract
\let\abstract\undefined
\let\endabstract\undefined
\NewEnviron{abstract}[1][\BODY]{%
  \snapshot@abstract\relscale{1.3}\noindent\ignorespaces\BODY\snapshot@endabstract% add special formatting and print \BODY
  \hypersetup{pdfsubject={#1}}% copy abstract into meta data
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% page layout
\RequirePackage[a5paper,top=12mm,bottom=22mm,outer=16mm,inner=12mm,foot=12.25mm,footnotesep=14pt]{geometry}
\RequirePackage{multicol}
\setlength{\columnsep}{2em}
\setlength\parindent{1.275em}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% footnotes
\newcommand\snapshot@footnotemark{%
  \setlength{\fboxsep}{0.1em}%
  \setlength{\fboxrule}{0.04em}%
  \textsuperscript{\framebox{\raisebox{0pt}[1.05\height][0.025\height]{\thefootnotemark}}}%
}
\deffootnote[1.5em]{0em}{1.5em}{\rlap{\snapshot@footnotemark}\hspace{1.5em}}
\deffootnotemark{\hskip .1em\snapshot@footnotemark}
%\deffootnotemark{\snapshot@footnotemark}
\@ifclasslater{scrartcl}{2010/06/17}{%
\setfootnoterule[0.526pt]{\textwidth}
}{%
  \renewcommand{\footnoterule}{%
    \kern -3pt
    \hrule width \textwidth height 0.526pt
    \kern 2.474pt
  }
}
\newcommand\footnotewithoutspace[1]{\hskip -.1em\footnote{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fonts & symbols
\RequirePackage{fix-cm}
\RequirePackage[T1]{fontenc}%
\RequirePackage{textcomp}
\RequirePackage{lmodern}
\RequirePackage[scaled=0.82304487406237511878]{helvet}
\RequirePackage{relsize}
\RequirePackage[tracking=true]{microtype}
\DeclareMicrotypeSet*[tracking]{letterspacedHelvetica}{family=phv}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% references (via BibTeX, babelbib and isodate)
\usepackage[fixlanguage,languagenames]{babelbib}

\let\snapshot@bibliography\bibliography
\def\bibliography{\gdef\snapshot@bib@printed{\relax}\bibliographystyle{babamspl}\snapshot@bibliography}

\usepackage[german,ngerman,english,USenglish,UKenglish,french]{isodate}
\setbibliographyfont{urldate}{\printdate}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% language specific settings

\AtBeginDocument{%
  \IfLanguageName{USenglish}{}{%
    \IfLanguageName{UKenglish}{}{%
      \IfLanguageName{english}{}{%
        \IfLanguageName{ngerman}{}{%
          \IfLanguageName{german}{}{%
            \IfLanguageName{spanish}{}{%
              \IfLanguageName{french}{\frenchsetup{FrenchFootnotes=false,AutoSpaceFootnotes=false}}{%
                \ClassError{snapshotmfo}{Unsupported language \languagename}{Supported languages: USenglish, UKenglish, english, ngerman, german, spanish, french}%
              }%
            }%
          }%
        }%
      }%
    }%
  }%
  \def\snapshot@language@warning{\ClassWarningNoLine{snapshotmfo}{First compilation in this language. Rerun to get PDF meta data right}}%
  \ifthenelse{%
    \isundefined{\snapshot@language@meta}%
  }{%
    \snapshot@language@warning%
  }{%
    \IfLanguageName{%
      \snapshot@language@meta%
    }{%
    }{%
      \snapshot@language@warning%
    }%
  }%
  \immediate\write\@auxout{\noexpand\gdef\noexpand\snapshot@language@meta{\languagename}}%
}%

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
  \newcaptionname{spanish}{\snapshot@l@header}{Instantáneas de la actualidad matemática\\desde Oberwolfach}%
  \newcaptionname{french}{\snapshot@l@header}{Instantanés de recherche mathématique\\d'Oberwolfach}%
  %
  \newcaptionname{english,USenglish,UKenglish}{\snapshot@l@creditstext}{\emph{Snapshots of modern mathematics from Oberwolfach} provide exciting insights into current mathematical research. They are written by participants in the scientific program of the Mathematisches Forschungsinstitut Oberwolfach (MFO). The snapshot project is designed to promote the understanding and appreciation of modern mathematics and mathematical research in the interested public worldwide. \\All snapshots are published in cooperation with the IMAGINARY platform and \\can be found on \href{https://www.imaginary.org/snapshots}{\nolinkurl{www.imaginary.org/snapshots}} and on \href{https://www.mfo.de/snapshots}{\nolinkurl{www.mfo.de/snapshots}}.}%
  \newcaptionname{german,ngerman}{\snapshot@l@creditstext}{\emph{Schnappsch\"usse moderner Mathematik aus Oberwolfach} bieten spannende Einblicke \\in die aktuelle mathematische Forschung. Sie werden von Teilnehmerinnen und Teil-\\nehmern des wissenschaftlichen Programms des Mathematischen Forschungsinstituts Oberwolfach (MFO) geschrieben. Die Schnappsch\"usse haben zum Ziel, Verst\"andnis und Wertsch\"atzung f\"ur moderne Mathematik und mathematische Forschung in der interessierten \"Offentlichkeit weltweit zu f\"ordern. Alle Schnappsch\"usse werden in Ko-\\operation mit der IMAGINARY Onlineplattform ver\"offentlicht und k\"onnen unter \href{https://www.imaginary.org/snapshots}{\nolinkurl{www.imaginary.org/snapshots}} sowie \href{https://www.mfo.de/snapshots}{\nolinkurl{www.mfo.de/snapshots}} abgerufen werden.}%
  \newcaptionname{spanish}{\snapshot@l@creditstext}{Las \emph{Instantáneas de la actualidad matemática desde Oberwolfach} ofrecen una mirada a investigación matemática más reciente. Estos textos están escritos por los participantes en el programa científico del Instituto de Investigación Matemática de Oberwolfach (MFO). El proyecto de las instantáneas está concebido para promover el conocimiento y el aprecio por la matemática moderna y la investigación matemática entre todo el público interesado internacionalmente. \\Todas las instantáneas se publican en cooperación con la plataforma IMAGINARY y \\pueden encontrarse en \href{http://www.imaginary.org/es/snapshots}{\nolinkurl{www.imaginary.org/es/snapshots}} y en \href{http://www.mfo.de/snapshots}{\nolinkurl{www.mfo.de/snapshots}}.}%
	\newcaptionname{french}{\snapshot@l@creditstext}{Les \emph{Instantanés de recherche mathématique d'Oberwolfach} donnent un aperçu passionant de la recherche mathématique d'aujourd'hui. Ils ont été rédigés par des participants aux conférences de l'institut de recherche mathématique d'Oberwolfach (MFO). Ce projet d'instantanés est conçu pour promouvoir la compréhension et l'appréciation des mathématiques modernes et de la recherche en mathématique, et s'adresse au public intéressé du monde entier. Tous les instantanés sont publiés en collaboration avec la plateforme IMAGINARY et sont disponibles sur \href{http://www.imaginary.org/fr/snapshots}{\nolinkurl{www.imaginary.org/fr/snapshots}} et sur \href{http://www.mfo.de/snapshots}{\nolinkurl{www.mfo.de/snapshots}}.}%
  %
  \newcaptionname{english,USenglish,UKenglish}{\snapshot@l@translator@english}{Translated from English by\ClassWarningNoLine{snapshotmfo}{Translated by: from English to English}}%
  \newcaptionname{english,USenglish,UKenglish}{\snapshot@l@translator@german}{Translated from German by}%
  \newcaptionname{english,USenglish,UKenglish}{\snapshot@l@translator@spanish}{Translated from Spanish by}%
  \newcaptionname{english,USenglish,UKenglish}{\snapshot@l@translator@french}{Translated from French by}%
  \newcaptionname{german,ngerman}{\snapshot@l@translator@english}{\"Ubersetzt aus dem Englischen von}%
  \newcaptionname{german,ngerman}{\snapshot@l@translator@german}{\"Ubersetzt aus dem Deutschen von\ClassWarningNoLine{snapshotmfo}{Translated by: from German to German}}%
  \newcaptionname{german,ngerman}{\snapshot@l@translator@spanish}{\"Ubersetzt aus dem Spanischen von}%
  \newcaptionname{german,ngerman}{\snapshot@l@translator@french}{\"Ubersetzt aus dem Französischen von}%
  \newcaptionname{spanish}{\snapshot@l@translator@english}{Traducido del inglés por}%
  \newcaptionname{spanish}{\snapshot@l@translator@german}{Traducido del alemán por}%
  \newcaptionname{spanish}{\snapshot@l@translator@spanish}{Traducido del español por\ClassWarningNoLine{snapshotmfo}{Translated by: from Spanish to Spanish}}%
  \newcaptionname{spanish}{\snapshot@l@translator@french}{Traducido del francés por}%
  \newcaptionname{french}{\snapshot@l@translator@english}{Traduit de l'anglais par}%
  \newcaptionname{french}{\snapshot@l@translator@german}{Traduit de l'allemand par}%
  \newcaptionname{french}{\snapshot@l@translator@spanish}{Traduit de l'espagnol par}%
  \newcaptionname{french}{\snapshot@l@translator@french}{Traduit du français par\ClassWarningNoLine{snapshotmfo}{Translated by: from French to French}}%
  \let\snapshot@l@translator@ngerman\snapshot@l@translator@german%
  \let\snapshot@l@translator@USenglish\snapshot@l@translator@english%
  \let\snapshot@l@translator@UKenglish\snapshot@l@translator@english%
  %
  \newcaptionname{english,USenglish,UKenglish}{\snapshot@label@l@categorization@math}{Mathematical subjects}%
  \newcaptionname{german,ngerman}{\snapshot@label@l@categorization@math}{Mathematische Gebiete}%
  \newcaptionname{spanish}{\snapshot@label@l@categorization@math}{Tema matemático}%
  \newcaptionname{french}{\snapshot@label@l@categorization@math}{Sujets mathématiques}%
  %
  \newcaptionname{english,USenglish,UKenglish}{\snapshot@label@l@categorization@connect}{Connections to other fields}%
  \newcaptionname{german,ngerman}{\snapshot@label@l@categorization@connect}{Verbindungen zu anderen Gebieten}%
  \newcaptionname{spanish}{\snapshot@label@l@categorization@connect}{Conexiones con otras áreas}%
  \newcaptionname{french}{\snapshot@label@l@categorization@connect}{Liens avec d'autres domaines}%
  %
  \newcaptionname{english,USenglish,UKenglish}{\snapshot@l@license}{License}%
  \newcaptionname{german,ngerman}{\snapshot@l@license}{Lizenz}%
  \newcaptionname{spanish}{\snapshot@l@license}{Licencia}%
  \newcaptionname{french}{\snapshot@l@license}{Licence}%
  %
  \newcaptionname{english,USenglish,UKenglish,german,ngerman,spanish,french}{\snapshot@l@doi}{DOI}%
  %
  \newcaptionname{english,USenglish,UKenglish}{\snapshot@l@senioreditor}{Senior Editor}%
  \newcaptionname{german,ngerman}{\snapshot@l@senioreditor}{Chefeditor/in}%
  \newcaptionname{spanish}{\snapshot@l@senioreditor}{Editor/a en jefe}%
  \newcaptionname{french}{\snapshot@l@senioreditor}{Rédacteur principal}% gender-neutral singular of Senior Editor in french
  %
  \newcaptionname{english,USenglish,UKenglish}{\snapshot@l@director}{Director}%
  \newcaptionname{german,ngerman}{\snapshot@l@director}{Direktor/in}%
  \newcaptionname{spanish}{\snapshot@l@director}{Director/a}%
  \newcaptionname{french}{\snapshot@l@director}{Directeur}% gender-neutral singular of Director in french
  %
  \newcaptionname{english,USenglish,UKenglish}{\snapshot@l@mfoaddress}{Mathematisches Forschungsinstitut\\Oberwolfach gGmbH\\Schwarzwaldstr. 9\,--1\!1\\77709 Oberwolfach\\Germany}%
  \newcaptionname{german,ngerman}{\snapshot@l@mfoaddress}{Mathematisches Forschungsinstitut\\Oberwolfach gGmbH\\Schwarzwaldstr. 9\,--1\!1\\77709 Oberwolfach\\Deutschland}%
  \newcaptionname{spanish}{\snapshot@l@mfoaddress}{Mathematisches Forschungsinstitut\\Oberwolfach gGmbH\\Schwarzwaldstr. 9\,--1\!1\\77709 Oberwolfach\\Alemania}%
  \newcaptionname{french}{\snapshot@l@mfoaddress}{Mathematisches Forschungsinstitut\\Oberwolfach gGmbH\\Schwarzwaldstr. 9\,--1\!1\\77709 Oberwolfach\\Allemagne}%
  %
  \newcaptionname{english,USenglish,UKenglish,spanish,french}{\snapshot@l@epslogo}{\snapshot@includemps{\snapshot@logo@en}{1}{1}}%
  \newcaptionname{german,ngerman}{\snapshot@l@epslogo}{\snapshot@includemps{\snapshot@logo@de}{1}{1}}%
  %
  % categorization: math
  %
  % Control sequences evaluating to the categorizations are written to the aux file and used as pdf meta data on the next run of pdflatex.
  % As some tex installations on some operating systems write the aux file ISO-8859 encoded, but read it UTF-8 encoded, it is safer to avoid
  % umlauts in the categorization.
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
  \newcscaptionname{spanish}{snaphot@l@categorization@math@algebra and number theory}{\texorpdfstring{Álgebra y Teoría de números}{Algebra y Teoria de numeros}}
  \newcscaptionname{spanish}{snaphot@l@categorization@math@analysis}{\texorpdfstring{Análisis}{Analisis}}
  \newcscaptionname{spanish}{snaphot@l@categorization@math@discrete mathematics and foundations}{\texorpdfstring{Matemática discreta y Fundamentos}{Matematica discreta y Fundamentos}}
  \newcscaptionname{spanish}{snaphot@l@categorization@math@geometry and topology}{\texorpdfstring{Geometría y Topología}{Geometria y Topologia}}
  \newcscaptionname{spanish}{snaphot@l@categorization@math@numerics and scientific computing}{\texorpdfstring{Cálculo numérico y Computación científica}{Calculo numerico y Computacion cientifica}}
  \newcscaptionname{spanish}{snaphot@l@categorization@math@probability theory and statistics}{\texorpdfstring{Teoría de la probabilidad y Estadística}{Teoria de la probabilidad y Estadistica}}
  \newcscaptionname{french}{snaphot@l@categorization@math@algebra and number theory}{\texorpdfstring{Algèbre et théorie des nombres}{Algebre et theorie des nombres}}
  \newcscaptionname{french}{snaphot@l@categorization@math@analysis}{Analyse}
  \newcscaptionname{french}{snaphot@l@categorization@math@discrete mathematics and foundations}{\texorpdfstring{Mathématiques discrètes et fondements}{Mathematiques discretes et fondements}}
  \newcscaptionname{french}{snaphot@l@categorization@math@geometry and topology}{\texorpdfstring{Géométrie et topologie}{Geometrie et topologie}}
  \newcscaptionname{french}{snaphot@l@categorization@math@numerics and scientific computing}{\texorpdfstring{Calculs numérique et scientifique}{Calculs numerique et scientifique}}
  \newcscaptionname{french}{snaphot@l@categorization@math@probability theory and statistics}{\texorpdfstring{Théorie des probabilités et statistique}{Theorie des probabilites et statistique}}
  %
  % categorization: connection to other fields
  %
  % Control sequences evaluating to the categorizations are written to the aux file and used as pdf meta data on the next run of pdflatex.
  % As some tex installations on some operating systems write the aux file ISO-8859 encoded, but read it UTF-8 encoded, it is safer to avoid
  % umlauts in the categorization.
  \newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@connect@chemistry and earth science}{Chemistry and Earth Science}
  \newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@connect@computer science}{Computer Science}
  \newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@connect@engineering and technology}{Engineering and Technology}
  \newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@connect@finance}{Finance}
  \newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@connect@fine arts}{Fine Arts}
  \newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@connect@humanities and social sciences}{Humanities and Social Sciences}
  \newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@connect@life science}{Life Science}
  \newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@connect@physics}{Physics}
  \newcscaptionname{english,USenglish,UKenglish}{snaphot@l@categorization@connect@reflections on mathematics}{Reflections on Mathematics}
  \newcscaptionname{german,ngerman}{snaphot@l@categorization@connect@chemistry and earth science}{Chemie und Geowissenschaften}
  \newcscaptionname{german,ngerman}{snaphot@l@categorization@connect@computer science}{Informatik}
  \newcscaptionname{german,ngerman}{snaphot@l@categorization@connect@engineering and technology}{Ingenieurwissenschaften und Technik}
  \newcscaptionname{german,ngerman}{snaphot@l@categorization@connect@finance}{Finanzwissenschaften}
  \newcscaptionname{german,ngerman}{snaphot@l@categorization@connect@fine arts}{\texorpdfstring{Sch\"one K\"unste}{Schoene Kuenste}}
  \newcscaptionname{german,ngerman}{snaphot@l@categorization@connect@humanities and social sciences}{Geistes- und Sozialwissenschaften}
  \newcscaptionname{german,ngerman}{snaphot@l@categorization@connect@life science}{Lebenswissenschaften}
  \newcscaptionname{german,ngerman}{snaphot@l@categorization@connect@physics}{Physik}
  \newcscaptionname{german,ngerman}{snaphot@l@categorization@connect@reflections on mathematics}{Betrachtungen \texorpdfstring{\"uber}{ueber} Mathematik}
  \newcscaptionname{spanish}{snaphot@l@categorization@connect@chemistry and earth science}{\texorpdfstring{Química}{Quimica} y Ciencias de la Tierra}
  \newcscaptionname{spanish}{snaphot@l@categorization@connect@computer science}{\texorpdfstring{Informática}{Informatica}}
  \newcscaptionname{spanish}{snaphot@l@categorization@connect@engineering and technology}{\texorpdfstring{Ingeniería y Tecnología}{Ingenieria y Tecnologia}}
  \newcscaptionname{spanish}{snaphot@l@categorization@connect@finance}{Finanzas}
  \newcscaptionname{spanish}{snaphot@l@categorization@connect@fine arts}{Bellas artes}
  \newcscaptionname{spanish}{snaphot@l@categorization@connect@humanities and social sciences}{Humanidades y Ciencias sociales}
  \newcscaptionname{spanish}{snaphot@l@categorization@connect@life science}{Ciencias de la vida}
  \newcscaptionname{spanish}{snaphot@l@categorization@connect@physics}{\texorpdfstring{Física}{Fisica}}
  \newcscaptionname{spanish}{snaphot@l@categorization@connect@reflections on mathematics}{Reflexiones sobre las \texorpdfstring{matemáticas}{matematicas}}
  \newcscaptionname{french}{snaphot@l@categorization@connect@chemistry and earth science}{Chimie et sciences de la terre}
  \newcscaptionname{french}{snaphot@l@categorization@connect@computer science}{Informatique}
  \newcscaptionname{french}{snaphot@l@categorization@connect@engineering and technology}{\texorpdfstring{Ingénierie}{Ingenierie} et technologie}
  \newcscaptionname{french}{snaphot@l@categorization@connect@finance}{Finance}
  \newcscaptionname{french}{snaphot@l@categorization@connect@fine arts}{Beaux-arts}
  \newcscaptionname{french}{snaphot@l@categorization@connect@humanities and social sciences}{Sciences humaines et sociales}
  \newcscaptionname{french}{snaphot@l@categorization@connect@life science}{Sciences de la vie}
  \newcscaptionname{french}{snaphot@l@categorization@connect@physics}{Physique}
  \newcscaptionname{french}{snaphot@l@categorization@connect@reflections on mathematics}{\texorpdfstring{Réflexions sur les mathématiques}{Reflexions sur les mathematiques}}
  % section name for image credits
  \newcscaptionname{english,USenglish,UKenglish}{snaphot@l@image credits}{Image credits}
  \newcscaptionname{german,ngerman}{snaphot@l@image credits}{Bildquellen}
  \newcscaptionname{spanish}{snaphot@l@image credits}{Créditos de las imágenes}
  \newcscaptionname{french}{snaphot@l@image credits}{Crédits images}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% graphics inclusion and basic color management
\RequirePackage{graphicx,color}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% string manipulation
\RequirePackage{xstring}

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
\RequirePackage[unicode,breaklinks,bookmarksopen]{hyperref}[2020-10-19]
\catcode`\#=12
\newcommand{\patchpdfstringdef}{%
  \patchcmd\pdfstringdef%
    {\def \begin #1{\csname #1\endcsname }}%
    {\def \begin ##1{\csname ##1\endcsname }}%
    {}{}%
  \patchcmd\pdfstringdef%
    {\def \end #1{\csname end#1\endcsname }}%
    {\def \end ##1{\csname end##1\endcsname }}%
    {}{}%
}
\catcode`\#=6
\patchpdfstringdef

\@ifpackagelater{hyperref}{2011/02/05}{\hypersetup{hidelinks}}{\hypersetup{colorlinks=false,pdfborder={0 0 0}}}

\newcommand{\mailtoref}[1]{\href{mailto:#1}{\nolinkurl{#1}}}
\newcommand{\httpref}[1]{\href{https://#1}{\nolinkurl{#1}}}
\newcommand{\ftpref}[1]{\href{ftp://#1}{\nolinkurl{#1}}}

\RequirePackage[figure, figure*, table, table*]{hypcap}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% page header/footer
\RequirePackage{scrlayer-scrpage}
\pagestyle{scrheadings}
\renewcommand*{\titlepagestyle}{scrheadings}
\clearpairofpagestyles
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
\AtBeginDocument{\newcaptionname{english,USenglish,UKenglish,german,ngerman,spanish,french}{\snapshot@doi}{\ClassWarningNoLine{snapshotmfo}{Unable to compute DOI}\snapshot@defaultcontent}}%
\gdef\snapshot@doiurlprefix{https://doi.org/}%
\gdef\snapshot@doilink{\snapshot@doi}%
\newcommand*{\snapshotid}[2]{%
  \begingroup%
    \@tempcnta=#1%
    \global\edef\snapshot@id{\the\@tempcnta}%
  \endgroup%
  \gdef\snapshot@year{#2}%
  \AtBeginDocument{%
    \renewcaptionname{english,USenglish,UKenglish}{\snapshot@doi}{10.14760/SNAP-#2-\ifnum#1<100 0\ifnum#1<10 0\fi\fi\number#1-EN}%
    \renewcaptionname{german,ngerman}{\snapshot@doi}{10.14760/SNAP-#2-\ifnum#1<100 0\ifnum#1<10 0\fi\fi\number#1-DE}%
    \renewcaptionname{spanish}{\snapshot@doi}{10.14760/SNAP-#2-\ifnum#1<100 0\ifnum#1<10 0\fi\fi\number#1-ES}%
    \renewcaptionname{french}{\snapshot@doi}{10.14760/SNAP-#2-\ifnum#1<100 0\ifnum#1<10 0\fi\fi\number#1-FR}%
  }%
  \gdef\snapshot@doilink{\href{\snapshot@doiurlprefix\snapshot@doi}{\snapshot@doi}}%
  \AtEndDocument{%
    \def\snapshot@doi@warning{\ClassWarningNoLine{snapshotmfo}{DOI changed. Rerun to get PDF meta data right}}%
    \ifthenelse{\isundefined{\snapshot@doi@meta}}{\snapshot@doi@warning}{\ifthenelse{\NOT\equal{\snapshot@doi}{\snapshot@doi@meta}}{\snapshot@doi@warning}{}}
    \bgroup%
      \Hy@pdfstringtrue%
      \immediate\write\@auxout{\noexpand\gdef\noexpand\snapshot@doi@meta{\snapshot@doi}}%
    \egroup%
  }
}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% author info
\renewcommand\author[1]{%
  \gdef\@author{#1}%
  \let\@metaauthor\@author%
  % strip spaces before \and in \@metaauthor (slow)
  \newif\ifsnapshot@removespaces\snapshot@removespacestrue%
  \loop%
    \patchcmd\@metaauthor{ \and}{\and}{}{\snapshot@removespacesfalse}%
  \ifsnapshot@removespaces%
  \repeat%
}

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
      \egroup%
      \stepcounter{ctrauthorinfo}%
      \vskip\medskipamount%
    }%
  \egroup%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% license info
% use \license{CC-BY-SA-4.0} (recommended), \license{CC-BY-ND-4.0} or \licence{CC-BY-NC-SA-4.0}
\csdef{snapshot@license@CC-BY-SA-4.0}{\href{https://creativecommons.org/licenses/by-sa/4.0/}{Creative Commons BY-SA 4.0}}
\csdef{snapshot@license@CC-BY-ND-4.0}{\href{https://creativecommons.org/licenses/by-nd/4.0/}{Creative Commons BY-ND 4.0}}
\csdef{snapshot@license@CC-BY-NC-SA-4.0}{\href{https://creativecommons.org/licenses/by-nc-sa/4.0/}{Creative Commons BY-NC-SA 4.0}}
% keep the next three lines for compatibility with previous v1.x.x releases
\csdef{snapshot@license@CC-BY-NC-SA-3.0}{\href{https://creativecommons.org/licenses/by-nc-sa/3.0/}{Creative Commons BY-NC-SA 3.0}}
\csdef{snapshot@license@CC-BY-NC-ND-3.0}{\href{https://creativecommons.org/licenses/by-nc-nd/3.0/}{Creative Commons BY-NC-ND 3.0}}
\csdef{snapshot@license@CC-BY-SA-3.0}{\href{https://creativecommons.org/licenses/by-sa/3.0/}{Creative Commons BY-SA 3.0}}
\newcommand{\snapshot@license}{\ClassWarningNoLine{snapshotmfo}{No license information given}\snapshot@defaultcontent}
\newcommand{\license}[1]{%
  \expandafter\ifcsdef\expandafter{snapshot@license@#1}{%
    \renewcommand{\snapshot@license}{\csname snapshot@license@#1\endcsname}%
  }{\ClassError{snapshotmfo}{Unknown license name}{Please use one of CC-BY-SA-4.0, CC-BY-ND-4.0 or CC-BY-NC-SA-4.0. (CC-BY-NC-SA-3.0, CC-BY-NC-ND-3.0 and CC-BY-SA-3.0 still work, too.)}}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% categorization: math
\gdef\snapshot@categorization@math{\ClassWarningNoLine{snapshotmfo}{No mathematical subject given}\snapshot@defaultcontent}
\newcommand*{\categorizationmath}[1]{%
  \ifblank{#1}{%
    \ClassError{snapshotmfo}{Mathematical subject must not be blank}{}%
  }{%
    \gdef\snapshot@categorization@math{\space}%
    \gdef\snapshot@categorization@mathraw{\space}%
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
          \gappto\snapshot@categorization@mathraw{,\space ##1}%
        }{%
          \ClassError{snapshotmfo}{Unknown category "##1" in \@backslashchar categorizationmath}{possibilities: \snapshot@categorization@math@subjects}%
        }%
      }%
      \def\do##1{\snapshot@add@categorization@math{##1}}%
      \docsvlist{#1}%
    \endgroup%
    \patchcmd{\snapshot@categorization@math}{\space,\space}{}{}{}% remove leading ,
    \patchcmd{\snapshot@categorization@mathraw}{\space,\space}{}{}{}% remove leading ,
    \AtEndDocument{%
      \def\snapshot@categorization@math@warning{\ClassWarningNoLine{snapshotmfo}{Mathematical categorization changed. Rerun to get PDF meta data right}}%
      \ifthenelse{\isundefined{\snapshot@categorization@mathraw@meta}}{\snapshot@categorization@math@warning}{\ifthenelse{\NOT\equal{\snapshot@categorization@mathraw}{\snapshot@categorization@mathraw@meta}}{\snapshot@categorization@math@warning}{}}
      \bgroup%
        \Hy@pdfstringtrue%
        \immediate\write\@auxout{\noexpand\gdef\noexpand\snapshot@categorization@math@meta{\snapshot@categorization@math}}%
        \immediate\write\@auxout{\noexpand\gdef\noexpand\snapshot@categorization@mathraw@meta{\snapshot@categorization@mathraw}}%
      \egroup%
    }%
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
    \gdef\snapshot@categorization@connectraw{\space}%
    \begingroup%
      \listadd\snapshot@categorization@connect@subjects{chemistry and earth science}%
      \listadd\snapshot@categorization@connect@subjects{computer science}%
      \listadd\snapshot@categorization@connect@subjects{engineering and technology}%
      \listadd\snapshot@categorization@connect@subjects{finance}%
      \listadd\snapshot@categorization@connect@subjects{fine arts}%
      \listadd\snapshot@categorization@connect@subjects{humanities and social sciences}%
      \listadd\snapshot@categorization@connect@subjects{life science}%
      \listadd\snapshot@categorization@connect@subjects{physics}%
      \listadd\snapshot@categorization@connect@subjects{reflections on mathematics}%
      \def\snapshot@add@categorization@connect##1{%
        \xifinlist{##1}{\snapshot@categorization@connect@subjects}%
        {%
          \gappto\snapshot@categorization@connect{,\space\expandafter\csname snaphot@l@categorization@connect@##1\endcsname}%
          \gappto\snapshot@categorization@connectraw{,\space ##1}%
        }{%
          \ClassError{snapshotmfo}{Unknown category "##1" in \@backslashchar categorizationconnect}{possibilities: \snapshot@categorization@connect@subjects}%
        }%
      }%
      \def\do##1{\snapshot@add@categorization@connect{##1}}%
      \docsvlist{#1}%
    \endgroup%
    \patchcmd{\snapshot@categorization@connect}{\space,\space}{}{}{}% remove leading ,
    \patchcmd{\snapshot@categorization@connectraw}{\space,\space}{}{}{}% remove leading ,
    \AtEndDocument{%
      \def\snapshot@categorization@connect@warning{\ClassWarningNoLine{snapshotmfo}{Connection to other fields changed. Rerun to get PDF meta data right}}%
      \ifthenelse{\isundefined{\snapshot@categorization@connectraw@meta}}{\snapshot@categorization@connect@warning}{\ifthenelse{\NOT\equal{\snapshot@categorization@connectraw}{\snapshot@categorization@connectraw@meta}}{\snapshot@categorization@connect@warning}{}}
      \bgroup%
        \Hy@pdfstringtrue%
        \immediate\write\@auxout{\noexpand\gdef\noexpand\snapshot@categorization@connect@meta{\snapshot@categorization@connect}}%
        \immediate\write\@auxout{\noexpand\gdef\noexpand\snapshot@categorization@connectraw@meta{\snapshot@categorization@connectraw}}%
      \egroup%
    }%
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
\newcommand*{\junioreditor}[3][g]{%
  \newcaptionname{english,USenglish,UKenglish}{\snapshot@l@junioreditor}{%
    \IfSubStr{#1}{p}{%
      Junior Editors%
    }{% no p
      Junior Editor%
    }%
  }%
  \newcaptionname{german,ngerman}{\snapshot@l@junioreditor}{%
    \IfSubStr{#1}{p}{%
      \IfSubStr{#1}{f}{Editorinnen}{%
        \IfSubStr{#1}{m}{Editoren}{%
          Editor(inn)en%
        }%
      }%
    }{% no p
      \IfSubStr{#1}{f}{Editorin}{%
        \IfSubStr{#1}{m}{Editor}{%
          Editor/in%
        }%
      }%
    }%
  }%
  \newcaptionname{spanish}{\snapshot@l@junioreditor}{%
    \IfSubStr{#1}{p}{%
      \IfSubStr{#1}{f}{Editoras}{%
        Editores%
      }%
    }{% no p
      \IfSubStr{#1}{f}{Editora}{%
        Editor%
      }%
    }%
  }%
  \newcaptionname{french}{\snapshot@l@junioreditor}{%
    \IfSubStr{#1}{p}{%
      \IfSubStr{#1}{f}{Rédactrices juniors}{% plural female
        \IfSubStr{#1}{m}{Rédacteurs juniors}{% plural male
          Rédacteurs/rédactrices juniors% plural gender-neutral
        }%
      }%
    }{% no p
      \IfSubStr{#1}{f}{Rédactrice junior}{% singular female
        \IfSubStr{#1}{m}{Rédacteur junior}{% singular male
          Rédacteur/Rédactrice junior% singular gender-neutral
        }%
      }%
    }%
  }%
  \gdef\snapshot@junioreditor{#2}%
  \gdef\snapshot@junioreditoremail{\mailtoref{#3}}%
}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% senior editor
\newcommand{\snapshot@senioreditor}{\ClassWarningNoLine{snapshotmfo}{No senior editor given}\snapshot@defaultcontent}%
\newcommand{\snapshot@senioreditoremail}{--}%
\newcommand*{\senioreditor}[3][n]{%
  \ifthenelse{\equal{#1}{f}}{%
	  \renewcaptionname{german,ngerman}{\snapshot@l@senioreditor}{Chefeditorin}%
	  \renewcaptionname{spanish}{\snapshot@l@senioreditor}{Editora en jefe}%
	  \renewcaptionname{french}{\snapshot@l@senioreditor}{Rédactrice principale}% female singular
	}{}%
  \ifthenelse{\equal{#1}{m}}{%
	  \renewcaptionname{german,ngerman}{\snapshot@l@senioreditor}{Chefeditor}%
	  \renewcaptionname{spanish}{\snapshot@l@senioreditor}{Editor en jefe}%
	  \renewcaptionname{french}{\snapshot@l@senioreditor}{Rédacteur principal}% male singular
	}{}%
  \gdef\snapshot@senioreditor{#2}%
  \gdef\snapshot@senioreditoremail{\mailtoref{#3}}%
}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% director
\newcommand{\snapshot@director}{\ClassWarningNoLine{snapshotmfo}{No director given}\snapshot@defaultcontent}%
\newcommand*{\director}[2][n]{%
  \ifthenelse{\equal{#1}{f}}{%
	  \renewcaptionname{german,ngerman}{\snapshot@l@director}{Direktorin}%
	  \renewcaptionname{spanish}{\snapshot@l@director}{Directora}%
	  \renewcaptionname{french}{\snapshot@l@director}{Directrice}% female singular
	}{}%
  \ifthenelse{\equal{#1}{m}}{%
	  \renewcaptionname{german,ngerman}{\snapshot@l@director}{Direktor}%
	  \renewcaptionname{spanish}{\snapshot@l@director}{Director}%
	  \renewcaptionname{french}{\snapshot@l@director}{Directeur}% male singular
	}{}%
  \gdef\snapshot@director{#2}%
}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% force translation of autoref names
\AtBeginDocument{%
  \@ifpackagewith{babel}{ngerman}{%
    \def\equationautorefname{Gleichung}%
    \def\footnoteautorefname{Fu\ss note}%
    \def\itemautorefname{Punkt}%
    \def\figureautorefname{Abbildung}%
    \def\tableautorefname{Tabelle}%
    \def\partautorefname{Teil}%
    \def\appendixautorefname{Anhang}%
    \def\chapterautorefname{Kapitel}%
    \def\sectionautorefname{Abschnitt}%
    \def\subsectionautorefname{Unterabschnitt}%
    \def\subsubsectionautorefname{Unterunterabschnitt}%
    \def\paragraphautorefname{Absatz}%
    \def\subparagraphautorefname{Unterabsatz}%
    \def\FancyVerbLineautorefname{Zeile}%
    \def\theoremautorefname{Theorem}%
    \def\pageautorefname{Seite}%
  }{}%
}%
\AtBeginDocument{%
  \@ifpackagewith{babel}{spanish}{%
    \def\equationautorefname{Ecuación}%
    \def\footnoteautorefname{anotación}%
    \def\itemautorefname{articulo}%
    \def\figureautorefname{Figura}%
    \def\tableautorefname{Cuadro}%
    \def\partautorefname{parte}%
    \def\appendixautorefname{apéndice}%
    \def\chapterautorefname{capítulo}%
    \def\sectionautorefname{sección}%
    \def\subsectionautorefname{subsección}%
    \def\subsubsectionautorefname{subsubsección}%
    \def\paragraphautorefname{párrafo}%
    \def\subparagraphautorefname{subpárrafo}%
    \def\FancyVerbLineautorefname{línea}%
    \def\theoremautorefname{Teorema}%
    \def\pageautorefname{página}%
  }{}%
}%
\AtBeginDocument{%
  \@ifpackagewith{babel}{french}{%
    \def\equationautorefname{Équation}%
    \def\footnoteautorefname{note en bas de page}%
    \def\itemautorefname{item}%
    \def\figureautorefname{Figure}%
    \def\tableautorefname{Table}%
    \def\partautorefname{Partie}%
    \def\appendixautorefname{Annexe}%
    \def\chapterautorefname{Chapitre}%
    \def\sectionautorefname{Section}%
    \def\subsectionautorefname{Sous-section}%
    \def\subsubsectionautorefname{Sous-sous-section}%
    \def\paragraphautorefname{Paragraphe}%
    \def\subparagraphautorefname{Sous-paragraphe}%
    \def\FancyVerbLineautorefname{Ligne}%
    \def\theoremautorefname{Théorème}%
    \def\pageautorefname{page}%
  }{}%
}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PDF meta data
\AtBeginDocument{%
  \bgroup%
    \Hy@pdfstringtrue%
    \def\thanks#1{}%
    \def\and{, \ignorespaces}%
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
  \pdfbookmark{\@title}{snapshot}
}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% define title
\renewcommand*\maketitle{%
  \par
  \begingroup
    \snapshot@define@spaces%
    \newpage
    \global\@topnum\z@
%		\deffootnotemark{\hskip .1em\snapshot@footnotemark}
    \let\thanks\footnote%
    \@maketitle
    \thispagestyle{\titlepagestyle}
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
  % undefine snapshotmfo commands to be used in preamble only
  \global\let\authorinfo\relax
  \global\let\categorizationmath\relax
  \global\let\categorizationconnect\relax
  \global\let\license\relax
  \global\let\snapshotid\relax
  \global\let\translator\relax
  \global\let\junioreditor\relax
  \global\let\senioreditor\relax
  \global\let\director\relax
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
    \vskip \z@ \@plus 1em
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
    \raggedright\normalfont\snapshot@l@creditstext\\[\medskipamount]
    \normalfont{ISSN 2626\kern.11em-\kern-.02em1995}%
    \vskip 0.25cm%
    \par\hfill\rule[0.5ex]{1cm}{0.526pt}\hfill\null%
    \vskip 0.4cm%
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
% https://www.alfredklomp.com/programming/shrinkpdf

\snapshot@savemps\snapshot@logo@en{
%!PS-Adobe-3.0 EPSF-3.0
%%BoundingBox: 0 4 516 43
%%HiResBoundingBox: 0.48376 4.361 515.10199 42.47836
%%Creator: MetaPost 1.803
%%CreationDate: 2017.05.22:1446
%%Pages: 1
%%BeginProlog
%%EndProlog
%%Page: 1 1
 0 0 0 setrgbcolor 0 2.46121 dtransform truncate idtransform setlinewidth pop
 [] 0 setdash 0 setlinecap 0 setlinejoin 10 setmiterlimit
newpath 11.5586 6.78906 moveto
28.6133 6.78906 lineto
34.0469 6.78906 38.457 11.1992 38.457 16.6367 curveto
38.457 22.0703 34.0469 26.4805 28.6133 26.4805 curveto
20.08589 26.4805 lineto
11.5586 26.4805 lineto
28.6133 26.4805 lineto stroke
newpath 37.1367 21.5586 moveto
28.6133 36.3242 lineto
25.8945 41.0313 19.8711 42.6445 15.1641 39.9297 curveto
10.457 37.21089 8.84375 31.1875 11.5586 26.4805 curveto
11.5586 26.4805 lineto
15.8242 19.0938 lineto
20.08589 11.7109 lineto
11.5586 26.4805 lineto stroke
newpath 11.5586 36.3242 moveto
3.03516 21.5586 lineto
0.3164 16.85161 1.92969 10.8242 6.63672 8.10938 curveto
11.3438 5.39063 17.3672 7.00781 20.08589 11.7109 curveto
24.3477 19.0938 lineto
20.08589 11.7109 lineto
28.6133 26.4805 lineto stroke
newpath 54.457 33.83589 moveto
53.5078 33.83589 lineto
53.5078 40.0039 lineto
51.5156 35.8086 lineto
50.9492 35.8086 lineto
48.9727 40.0039 lineto
48.9727 33.83589 lineto
48.08589 33.83589 lineto
48.08589 40.9961 lineto
49.3828 40.9961 lineto
51.28911 37.0117 lineto
53.1367 40.9961 lineto
54.457 40.9961 lineto
 closepath fill
newpath 60.4805 33.83589 moveto
59.582 33.83589 lineto
59.582 34.4102 lineto
59.5039 34.3555 59.3945 34.2773 59.2578 34.1797 curveto
58.85161 34.7148 lineto
59.1133 34.8398 59.3594 34.9883 59.582 35.1602 curveto
59.582 35.1602 lineto
59.582 36.6563 lineto
59.3047 36.6367 58.9805 36.6133 58.6094 36.582 curveto
58.2344 36.5508 57.9414 36.5039 57.7227 36.4414 curveto
57.46089 36.3711 57.2539 36.2539 57.0938 36.0977 curveto
56.9336 35.9453 56.85161 35.7305 56.85161 35.457 curveto
56.85161 35.14839 56.9453 34.918 57.1328 34.7617 curveto
57.3164 34.6094 57.60161 34.5313 57.9805 34.5313 curveto
58.2969 34.5313 58.5898 34.5898 58.85161 34.7148 curveto
59.2578 34.1797 lineto
59.1211 34.082 58.9883 34.0078 58.8594 33.9492 curveto
58.71089 33.875 58.53911 33.8125 58.3438 33.7617 curveto
58.14839 33.7148 57.918 33.6875 57.6563 33.6875 curveto
57.1719 33.6875 56.7617 33.8477 56.4258 34.168 curveto
56.08589 34.4883 55.918 34.89839 55.918 35.3945 curveto
55.918 35.8008 56.0078 36.1328 56.1797 36.3828 curveto
56.3555 36.6328 56.6055 36.832 56.9297 36.97661 curveto
57.2578 37.1211 57.64839 37.2188 58.1055 37.2695 curveto
58.5664 37.3203 59.0547 37.3594 59.582 37.3867 curveto
59.582 37.52339 lineto
59.582 37.7305 59.5469 37.89839 59.4727 38.0352 curveto
59.4023 38.168 59.2969 38.27339 59.16411 38.35161 curveto
59.0352 38.4258 58.8828 38.47661 58.7031 38.5 curveto
58.52339 38.5273 58.33589 38.53911 58.1406 38.53911 curveto
57.9023 38.53911 57.6406 38.5078 57.3477 38.4453 curveto
57.0547 38.3828 56.7539 38.293 56.4453 38.1719 curveto
56.3945 38.1719 lineto
56.3945 39.0898 lineto
56.5703 39.1406 56.8281 39.1914 57.1602 39.25 curveto
57.4922 39.3086 57.8203 39.33589 58.1445 39.33589 curveto
58.52339 39.33589 58.85161 39.3047 59.1328 39.2422 curveto
59.41411 39.1797 59.6563 39.0742 59.8594 38.9219 curveto
60.0625 38.7773 60.2188 38.58589 60.3242 38.35161 curveto
60.4297 38.1172 60.4805 37.8281 60.4805 37.4805 curveto
 closepath fill
newpath 65.0078 33.8867 moveto
64.8398 33.8398 64.6563 33.8047 64.4531 33.77339 curveto
64.2539 33.7461 64.0742 33.7305 63.918 33.7305 curveto
63.3711 33.7305 62.9531 33.8789 62.668 34.1758 curveto
62.3828 34.4688 62.2422 34.9414 62.2422 35.5938 curveto
62.2422 38.4492 lineto
61.6289 38.4492 lineto
61.6289 39.207 lineto
62.2422 39.207 lineto
62.2422 40.75 lineto
63.1445 40.75 lineto
63.1445 39.207 lineto
65.0078 39.207 lineto
65.0078 38.4492 lineto
63.1445 38.4492 lineto
63.1445 36 lineto
63.1445 35.7188 63.1523 35.5 63.16411 35.3398 curveto
63.1758 35.1797 63.2227 35.0313 63.2969 34.8945 curveto
63.3672 34.7656 63.4648 34.6719 63.5898 34.6133 curveto
63.71089 34.5547 63.9023 34.52339 64.1523 34.52339 curveto
64.3008 34.52339 64.457 34.5469 64.6133 34.5898 curveto
64.7773 34.6328 64.8906 34.668 64.96089 34.6992 curveto
65.0078 34.6992 lineto
 closepath fill
newpath 70.5898 33.83589 moveto
69.6875 33.83589 lineto
69.6875 36.8945 lineto
69.6875 37.1406 69.6719 37.375 69.6445 37.5898 curveto
69.6133 37.8047 69.5625 37.97661 69.4844 38.0977 curveto
69.4063 38.2305 69.28911 38.332 69.1406 38.39839 curveto
68.9883 38.46089 68.793 38.4961 68.5508 38.4961 curveto
68.3047 38.4961 68.0469 38.4336 67.7773 38.3125 curveto
67.5078 38.1914 67.25 38.0352 67.0039 37.8477 curveto
67.0039 33.83589 lineto
66.10161 33.83589 lineto
66.10161 41.3164 lineto
67.0039 41.3164 lineto
67.0039 38.6094 lineto
67.2852 38.8438 67.5781 39.0273 67.8789 39.1602 curveto
68.1797 39.28911 68.4883 39.3555 68.8086 39.3555 curveto
69.3867 39.3555 69.8281 39.1797 70.1328 38.832 curveto
70.4375 38.4844 70.5898 37.9805 70.5898 37.3242 curveto
 closepath fill
newpath 76.8242 36.4297 moveto
72.8672 36.4297 lineto
72.8672 37.1211 lineto
75.9453 37.1211 lineto
75.9414 37.5938 75.8242 37.96089 75.58589 38.2227 curveto
75.35161 38.4805 74.9922 38.6094 74.5117 38.6094 curveto
74.0313 38.6094 73.6445 38.4688 73.3555 38.1836 curveto
73.0703 37.89839 72.9063 37.543 72.8672 37.1211 curveto
72.8672 36.4297 lineto
72.8672 36.0977 72.918 35.8125 73.0195 35.5664 curveto
73.1172 35.3203 73.2539 35.1211 73.4258 34.96089 curveto
73.5938 34.8086 73.78911 34.6914 74.0195 34.6172 curveto
74.25 34.53911 74.5039 34.5 74.7773 34.5 curveto
75.1445 34.5 75.5117 34.5742 75.8828 34.7188 curveto
76.25 34.8672 76.5156 35.0078 76.6719 35.14839 curveto
76.7188 35.14839 lineto
76.7188 34.16411 lineto
76.41411 34.0352 76.1055 33.9297 75.7852 33.8438 curveto
75.4688 33.7578 75.1367 33.71089 74.7852 33.71089 curveto
73.8945 33.71089 73.1992 33.9531 72.6992 34.4375 curveto
72.1992 34.918 71.9531 35.60161 71.9531 36.4922 curveto
71.9531 37.3711 72.1914 38.0664 72.668 38.582 curveto
73.14839 39.0977 73.7813 39.3555 74.5625 39.3555 curveto
75.2852 39.3555 75.8438 39.1445 76.2344 38.7227 curveto
76.6289 38.2969 76.8242 37.6992 76.8242 36.918 curveto
 closepath fill
newpath 86.0313 33.83589 moveto
85.1289 33.83589 lineto
85.1289 36.8945 lineto
85.1289 37.125 85.1172 37.3477 85.0977 37.5625 curveto
85.0742 37.7773 85.0313 37.9492 84.9648 38.0781 curveto
84.8906 38.2148 84.7852 38.3203 84.64839 38.3906 curveto
84.5078 38.46089 84.3086 38.4961 84.0508 38.4961 curveto
83.7969 38.4961 83.543 38.4336 83.28911 38.3047 curveto
83.03911 38.1797 82.7852 38.0195 82.5313 37.8242 curveto
82.53911 37.75 82.5469 37.66411 82.5547 37.5664 curveto
82.5625 37.4688 82.5664 37.3711 82.5664 37.27339 curveto
82.5664 33.83589 lineto
81.6602 33.83589 lineto
81.6602 36.8945 lineto
81.6602 37.1328 81.6523 37.3555 81.6289 37.5703 curveto
81.6094 37.7852 81.5664 37.9531 81.4961 38.082 curveto
81.4258 38.2188 81.3203 38.3242 81.1797 38.3906 curveto
81.043 38.46089 80.8438 38.4961 80.58589 38.4961 curveto
80.3398 38.4961 80.0898 38.4336 79.8438 38.3125 curveto
79.5938 38.1914 79.3477 38.0352 79.0977 37.8477 curveto
79.0977 33.83589 lineto
78.1953 33.83589 lineto
78.1953 39.207 lineto
79.0977 39.207 lineto
79.0977 38.6094 lineto
79.3828 38.8438 79.66411 39.0273 79.9414 39.1602 curveto
80.2227 39.28911 80.52339 39.3555 80.8398 39.3555 curveto
81.2031 39.3555 81.5156 39.2773 81.7695 39.125 curveto
82.02339 38.9727 82.2148 38.7578 82.3398 38.4844 curveto
82.7031 38.793 83.03911 39.0156 83.3398 39.1523 curveto
83.6406 39.28911 83.96089 39.3555 84.3047 39.3555 curveto
84.8945 39.3555 85.332 39.1758 85.6094 38.8203 curveto
85.8906 38.46089 86.0313 37.9648 86.0313 37.3242 curveto
 closepath fill
newpath 91.9453 33.83589 moveto
91.043 33.83589 lineto
91.043 34.4102 lineto
90.9648 34.3555 90.8555 34.2773 90.7188 34.1797 curveto
90.3125 34.7148 lineto
90.5781 34.8398 90.8203 34.9883 91.043 35.1602 curveto
91.043 35.1602 lineto
91.043 36.6563 lineto
90.7695 36.6367 90.4453 36.6133 90.0703 36.582 curveto
89.6992 36.5508 89.4023 36.5039 89.1836 36.4414 curveto
88.9258 36.3711 88.7148 36.2539 88.5547 36.0977 curveto
88.3945 35.9453 88.3125 35.7305 88.3125 35.457 curveto
88.3125 35.14839 88.4063 34.918 88.5938 34.7617 curveto
88.7773 34.6094 89.0625 34.5313 89.4453 34.5313 curveto
89.7617 34.5313 90.0508 34.5898 90.3125 34.7148 curveto
90.7188 34.1797 lineto
90.582 34.082 90.4531 34.0078 90.3242 33.9492 curveto
90.1719 33.875 90 33.8125 89.8047 33.7617 curveto
89.6094 33.7148 89.3789 33.6875 89.1172 33.6875 curveto
88.6328 33.6875 88.2227 33.8477 87.8867 34.168 curveto
87.5508 34.4883 87.3828 34.89839 87.3828 35.3945 curveto
87.3828 35.8008 87.4688 36.1328 87.6445 36.3828 curveto
87.8164 36.6328 88.0664 36.832 88.3906 36.97661 curveto
88.7188 37.1211 89.1094 37.2188 89.5703 37.2695 curveto
90.0273 37.3203 90.5195 37.3594 91.043 37.3867 curveto
91.043 37.52339 lineto
91.043 37.7305 91.0078 37.89839 90.9375 38.0352 curveto
90.8633 38.168 90.7617 38.27339 90.625 38.35161 curveto
90.4961 38.4258 90.3438 38.47661 90.16411 38.5 curveto
89.9844 38.5273 89.7969 38.53911 89.60161 38.53911 curveto
89.3633 38.53911 89.10161 38.5078 88.8086 38.4453 curveto
88.5156 38.3828 88.2148 38.293 87.9063 38.1719 curveto
87.8555 38.1719 lineto
87.8555 39.0898 lineto
88.0352 39.1406 88.28911 39.1914 88.6211 39.25 curveto
88.9531 39.3086 89.2852 39.33589 89.6055 39.33589 curveto
89.9844 39.33589 90.3164 39.3047 90.5938 39.2422 curveto
90.875 39.1797 91.1172 39.0742 91.3242 38.9219 curveto
91.52339 38.7773 91.6797 38.58589 91.7852 38.35161 curveto
91.8906 38.1172 91.9453 37.8281 91.9453 37.4805 curveto
 closepath fill
newpath 96.4727 33.8867 moveto
96.3008 33.8398 96.1172 33.8047 95.918 33.77339 curveto
95.7148 33.7461 95.53911 33.7305 95.3828 33.7305 curveto
94.832 33.7305 94.41411 33.8789 94.1328 34.1758 curveto
93.8477 34.4688 93.7031 34.9414 93.7031 35.5938 curveto
93.7031 38.4492 lineto
93.0938 38.4492 lineto
93.0938 39.207 lineto
93.7031 39.207 lineto
93.7031 40.75 lineto
94.6055 40.75 lineto
94.6055 39.207 lineto
96.4727 39.207 lineto
96.4727 38.4492 lineto
94.6055 38.4492 lineto
94.6055 36 lineto
94.6055 35.7188 94.6133 35.5 94.625 35.3398 curveto
94.6406 35.1797 94.6836 35.0313 94.7617 34.8945 curveto
94.832 34.7656 94.9258 34.6719 95.0508 34.6133 curveto
95.1758 34.5547 95.3633 34.52339 95.6172 34.52339 curveto
95.7656 34.52339 95.918 34.5469 96.0781 34.5898 curveto
96.2383 34.6328 96.35161 34.668 96.4219 34.6992 curveto
96.4727 34.6992 lineto
 closepath fill
newpath 98.47661 33.83589 moveto
97.5742 33.83589 lineto
97.5742 39.207 lineto
98.47661 39.207 lineto
 closepath fill
newpath 98.5352 40.1055 moveto
97.5156 40.1055 lineto
97.5156 41.043 lineto
98.5352 41.043 lineto
 closepath fill
newpath 104.10199 35.3867 moveto
104.10199 34.8945 103.89801 34.4922 103.492 34.1797 curveto
103.086 33.8633 102.53099 33.707 101.832 33.707 curveto
101.43399 33.707 101.07 33.7539 100.738 33.85161 curveto
100.40599 33.9453 100.129 34.0469 99.9023 34.1602 curveto
99.9023 35.1758 lineto
99.9531 35.1758 lineto
100.238 34.96089 100.555 34.78911 100.902 34.6602 curveto
101.254 34.5352 101.59 34.4727 101.90599 34.4727 curveto
102.305 34.4727 102.617 34.5352 102.84 34.66411 curveto
103.06601 34.793 103.17601 34.9961 103.17601 35.2695 curveto
103.17601 35.4805 103.117 35.6406 102.996 35.75 curveto
102.871 35.8594 102.641 35.9531 102.293 36.0313 curveto
102.164 36.0586 101.996 36.0938 101.789 36.1289 curveto
101.586 36.168 101.395 36.21089 101.22699 36.2539 curveto
100.754 36.3789 100.422 36.5625 100.223 36.8047 curveto
100.027 37.0469 99.9258 37.3438 99.9258 37.6992 curveto
99.9258 37.918 99.9727 38.1289 100.06601 38.3242 curveto
100.15599 38.5195 100.297 38.6914 100.48 38.8477 curveto
100.66 38.9961 100.887 39.1172 101.164 39.2031 curveto
101.44101 39.293 101.754 39.33589 102.098 39.33589 curveto
102.414 39.33589 102.742 39.2969 103.07 39.2188 curveto
103.39801 39.1406 103.672 39.0469 103.891 38.9336 curveto
103.891 37.9688 lineto
103.84 37.9688 lineto
103.609 38.1367 103.328 38.2813 103 38.39839 curveto
102.668 38.5156 102.348 38.5742 102.027 38.5742 curveto
101.69899 38.5742 101.418 38.5078 101.19101 38.3828 curveto
100.965 38.2578 100.85199 38.0664 100.85199 37.8164 curveto
100.85199 37.5977 100.918 37.4297 101.05899 37.3164 curveto
101.19101 37.207 101.41 37.1133 101.711 37.043 curveto
101.879 37.0039 102.063 36.9688 102.27 36.9297 curveto
102.47699 36.8906 102.64801 36.8555 102.789 36.8242 curveto
103.207 36.72661 103.53099 36.5625 103.758 36.3281 curveto
103.984 36.0898 104.10199 35.7773 104.10199 35.3867 curveto
 closepath fill
newpath 109.363 34.1758 moveto
109.063 34.0313 108.777 33.918 108.508 33.83589 curveto
108.234 33.7578 107.94899 33.7188 107.645 33.7188 curveto
107.254 33.7188 106.89801 33.77339 106.57399 33.8867 curveto
106.254 34 105.97699 34.1758 105.746 34.4063 curveto
105.512 34.6367 105.328 34.9258 105.19899 35.2813 curveto
105.07399 35.6328 105.008 36.043 105.008 36.5156 curveto
105.008 37.3945 105.25 38.082 105.73 38.582 curveto
106.215 39.082 106.85199 39.332 107.645 39.332 curveto
107.94899 39.332 108.254 39.28911 108.55101 39.2031 curveto
108.848 39.1172 109.117 39.0117 109.363 38.8867 curveto
109.363 37.8789 lineto
109.31601 37.8789 lineto
109.039 38.0938 108.758 38.2617 108.465 38.375 curveto
108.172 38.4922 107.883 38.5469 107.605 38.5469 curveto
107.09401 38.5469 106.688 38.375 106.391 38.0313 curveto
106.09401 37.6875 105.945 37.1836 105.945 36.5156 curveto
105.945 35.8672 106.09 35.3711 106.383 35.02339 curveto
106.672 34.6758 107.078 34.5 107.605 34.5 curveto
107.789 34.5 107.973 34.52339 108.164 34.5742 curveto
108.35199 34.6211 108.52 34.6836 108.672 34.7617 curveto
108.805 34.8281 108.92601 34.89839 109.043 34.9727 curveto
109.15599 35.0508 109.25 35.1133 109.31601 35.168 curveto
109.363 35.168 lineto
 closepath fill
newpath 115.012 33.83589 moveto
114.109 33.83589 lineto
114.109 36.8945 lineto
114.109 37.1406 114.09401 37.375 114.06601 37.5898 curveto
114.035 37.8047 113.984 37.97661 113.90599 38.0977 curveto
113.828 38.2305 113.711 38.332 113.563 38.39839 curveto
113.41 38.46089 113.215 38.4961 112.973 38.4961 curveto
112.72699 38.4961 112.46901 38.4336 112.19899 38.3125 curveto
111.93 38.1914 111.672 38.0352 111.42601 37.8477 curveto
111.42601 33.83589 lineto
110.52301 33.83589 lineto
110.52301 41.3164 lineto
111.42601 41.3164 lineto
111.42601 38.6094 lineto
111.707 38.8438 112 39.0273 112.30101 39.1602 curveto
112.60199 39.28911 112.91 39.3555 113.23 39.3555 curveto
113.80899 39.3555 114.25 39.1797 114.555 38.832 curveto
114.859 38.4844 115.012 37.9805 115.012 37.3242 curveto
 closepath fill
newpath 121.246 36.4297 moveto
117.289 36.4297 lineto
117.289 37.1211 lineto
120.367 37.1211 lineto
120.363 37.5938 120.246 37.96089 120.008 38.2227 curveto
119.77301 38.4805 119.414 38.6094 118.93399 38.6094 curveto
118.44899 38.6094 118.06601 38.4688 117.777 38.1836 curveto
117.492 37.89839 117.328 37.543 117.289 37.1211 curveto
117.289 36.4297 lineto
117.289 36.0977 117.34 35.8125 117.44101 35.5664 curveto
117.539 35.3203 117.67601 35.1211 117.848 34.96089 curveto
118.016 34.8086 118.215 34.6914 118.44101 34.6172 curveto
118.672 34.53911 118.92601 34.5 119.19899 34.5 curveto
119.56601 34.5 119.93399 34.5742 120.305 34.7188 curveto
120.672 34.8672 120.938 35.0078 121.09401 35.14839 curveto
121.141 35.14839 lineto
121.141 34.16411 lineto
120.836 34.0352 120.527 33.9297 120.211 33.8438 curveto
119.891 33.7578 119.55899 33.71089 119.211 33.71089 curveto
118.31601 33.71089 117.621 33.9531 117.121 34.4375 curveto
116.621 34.918 116.371 35.60161 116.371 36.4922 curveto
116.371 37.3711 116.613 38.0664 117.09 38.582 curveto
117.57 39.0977 118.19899 39.3555 118.984 39.3555 curveto
119.707 39.3555 120.266 39.1445 120.65599 38.7227 curveto
121.05101 38.2969 121.246 37.6992 121.246 36.918 curveto
 closepath fill
newpath 126.453 35.3867 moveto
126.453 34.8945 126.25 34.4922 125.84401 34.1797 curveto
125.438 33.8633 124.887 33.707 124.18399 33.707 curveto
123.785 33.707 123.422 33.7539 123.09 33.85161 curveto
122.758 33.9453 122.48 34.0469 122.258 34.1602 curveto
122.258 35.1758 lineto
122.305 35.1758 lineto
122.59 34.96089 122.90599 34.78911 123.258 34.6602 curveto
123.605 34.5352 123.94101 34.4727 124.262 34.4727 curveto
124.65599 34.4727 124.96901 34.5352 125.19101 34.66411 curveto
125.418 34.793 125.53099 34.9961 125.53099 35.2695 curveto
125.53099 35.4805 125.46901 35.6406 125.348 35.75 curveto
125.22699 35.8594 124.992 35.9531 124.645 36.0313 curveto
124.516 36.0586 124.35199 36.0938 124.145 36.1289 curveto
123.938 36.168 123.746 36.21089 123.578 36.2539 curveto
123.105 36.3789 122.77301 36.5625 122.57399 36.8047 curveto
122.379 37.0469 122.28099 37.3438 122.28099 37.6992 curveto
122.28099 37.918 122.32399 38.1289 122.418 38.3242 curveto
122.508 38.5195 122.64801 38.6914 122.832 38.8477 curveto
123.012 38.9961 123.242 39.1172 123.52 39.2031 curveto
123.797 39.293 124.105 39.33589 124.44899 39.33589 curveto
124.77 39.33589 125.09401 39.2969 125.422 39.2188 curveto
125.75 39.1406 126.02301 39.0469 126.242 38.9336 curveto
126.242 37.9688 lineto
126.19101 37.9688 lineto
125.961 38.1367 125.68399 38.2813 125.35199 38.39839 curveto
125.02301 38.5156 124.69899 38.5742 124.383 38.5742 curveto
124.05101 38.5742 123.77301 38.5078 123.543 38.3828 curveto
123.31601 38.2578 123.203 38.0664 123.203 37.8164 curveto
123.203 37.5977 123.27301 37.4297 123.41 37.3164 curveto
123.543 37.207 123.762 37.1133 124.063 37.043 curveto
124.23 37.0039 124.418 36.9688 124.625 36.9297 curveto
124.832 36.8906 125.004 36.8555 125.141 36.8242 curveto
125.563 36.72661 125.883 36.5625 126.109 36.3281 curveto
126.34 36.0898 126.453 35.7773 126.453 35.3867 curveto
 closepath fill
newpath 52.6563 26.7813 moveto
49.0352 26.7813 lineto
49.0352 24.7617 lineto
52.1445 24.7617 lineto
52.1445 23.918 lineto
49.0352 23.918 lineto
49.0352 20.4688 lineto
48.08589 20.4688 lineto
48.08589 27.6289 lineto
52.6563 27.6289 lineto
 closepath fill
newpath 58.0117 23.1523 moveto
58.0117 22.2773 57.7852 21.58589 57.33589 21.082 curveto
56.8867 20.5742 56.2852 20.3203 55.5352 20.3203 curveto
54.77339 20.3203 54.1719 20.5742 53.7227 21.082 curveto
53.2773 21.58589 53.0547 22.2773 53.0547 23.1523 curveto
53.0547 24.0273 53.2773 24.7188 53.7227 25.22661 curveto
54.1719 25.7344 54.77339 25.9883 55.5352 25.9883 curveto
55.5352 25.21089 lineto
55.043 25.21089 54.66411 25.043 54.3906 24.7031 curveto
54.1211 24.3633 53.9844 23.8477 53.9844 23.1523 curveto
53.9844 22.4805 54.1211 21.9688 54.3945 21.6211 curveto
54.668 21.27339 55.0469 21.10161 55.5352 21.10161 curveto
56.0156 21.10161 56.3906 21.27339 56.66411 21.6172 curveto
56.9414 21.96089 57.0781 22.4727 57.0781 23.1523 curveto
57.0781 23.1523 lineto
57.0781 23.8477 56.9414 24.3633 56.668 24.7031 curveto
56.3945 25.043 56.0195 25.21089 55.5352 25.21089 curveto
55.5352 25.9883 lineto
56.2852 25.9883 56.8867 25.7344 57.33589 25.22661 curveto
57.7852 24.7188 58.0117 24.0273 58.0117 23.1523 curveto
 closepath fill
newpath 62.7617 24.8555 moveto
62.7148 24.8555 lineto
62.5781 24.8867 62.4492 24.9102 62.3203 24.9258 curveto
62.1953 24.9375 62.043 24.9453 61.8711 24.9453 curveto
61.5938 24.9453 61.3242 24.8828 61.0625 24.7617 curveto
60.8047 24.6367 60.5547 24.47661 60.3125 24.2813 curveto
60.3125 20.4688 lineto
59.4102 20.4688 lineto
59.4102 25.8398 lineto
60.3125 25.8398 lineto
60.3125 25.0469 lineto
60.6719 25.33589 60.9883 25.53911 61.2617 25.6602 curveto
61.53911 25.7813 61.8164 25.8398 62.10161 25.8398 curveto
62.2578 25.8398 62.3711 25.83589 62.4453 25.8281 curveto
62.5156 25.8203 62.6211 25.8047 62.7617 25.7813 curveto
 closepath fill
newpath 67.4492 22.0195 moveto
67.4492 21.5273 67.2461 21.125 66.8398 20.8125 curveto
66.4336 20.4961 65.8789 20.3398 65.1797 20.3398 curveto
64.7813 20.3398 64.418 20.3867 64.08589 20.4805 curveto
63.7539 20.5781 63.47661 20.6797 63.25 20.793 curveto
63.25 21.8047 lineto
63.2969 21.8047 lineto
63.58589 21.5898 63.9023 21.4219 64.25 21.293 curveto
64.60161 21.168 64.9336 21.1055 65.2539 21.1055 curveto
65.6523 21.1055 65.9648 21.168 66.1875 21.2969 curveto
66.4102 21.4258 66.52339 21.625 66.52339 21.9023 curveto
66.52339 22.1133 66.4648 22.27339 66.3438 22.3828 curveto
66.2188 22.4922 65.9844 22.58589 65.6406 22.66411 curveto
65.5117 22.6914 65.3438 22.72661 65.1367 22.7617 curveto
64.9297 22.8008 64.7422 22.8438 64.5742 22.8867 curveto
64.10161 23.0117 63.7695 23.1992 63.5703 23.4375 curveto
63.375 23.6797 63.27339 23.97661 63.27339 24.332 curveto
63.27339 24.5508 63.3203 24.7617 63.4102 24.957 curveto
63.5039 25.1523 63.6406 25.3242 63.8281 25.4805 curveto
64.0078 25.6289 64.2344 25.75 64.5117 25.83589 curveto
64.78911 25.9258 65.10161 25.9688 65.4414 25.9688 curveto
65.7617 25.9688 66.0898 25.9297 66.418 25.85161 curveto
66.7461 25.77339 67.0195 25.6797 67.2344 25.5664 curveto
67.2344 24.60161 lineto
67.1875 24.60161 lineto
66.957 24.7695 66.6758 24.91411 66.3477 25.0313 curveto
66.0156 25.14839 65.6914 25.207 65.375 25.207 curveto
65.0469 25.207 64.7656 25.1406 64.53911 25.0156 curveto
64.3125 24.8906 64.1992 24.6992 64.1992 24.4492 curveto
64.1992 24.2305 64.2656 24.0625 64.4063 23.9492 curveto
64.53911 23.8398 64.7578 23.7461 65.0586 23.6758 curveto
65.22661 23.6367 65.4102 23.60161 65.6172 23.5625 curveto
65.8242 23.52339 65.9961 23.4883 66.1367 23.457 curveto
66.5547 23.3594 66.8789 23.1953 67.1055 22.96089 curveto
67.332 22.7227 67.4492 22.4102 67.4492 22.0195 curveto
 closepath fill
newpath 72.71089 20.8047 moveto
72.4102 20.66411 72.125 20.5508 71.85161 20.4688 curveto
71.582 20.3906 71.293 20.35161 70.9922 20.35161 curveto
70.60161 20.35161 70.2461 20.4063 69.9219 20.5195 curveto
69.5977 20.6367 69.3242 20.8047 69.0938 21.03911 curveto
68.8594 21.2695 68.6758 21.5586 68.5469 21.9102 curveto
68.4219 22.2656 68.3555 22.6758 68.3555 23.14839 curveto
68.3555 24.0273 68.5977 24.7148 69.0781 25.2148 curveto
69.5625 25.7148 70.1992 25.9648 70.9922 25.9648 curveto
71.2969 25.9648 71.60161 25.9219 71.89839 25.83589 curveto
72.1914 25.75 72.4648 25.6445 72.71089 25.5195 curveto
72.71089 24.5117 lineto
72.66411 24.5117 lineto
72.3867 24.72661 72.10161 24.8945 71.8086 25.0078 curveto
71.5156 25.125 71.2305 25.1797 70.9531 25.1797 curveto
70.4414 25.1797 70.0352 25.0078 69.7383 24.66411 curveto
69.4414 24.3203 69.293 23.8164 69.293 23.14839 curveto
69.293 22.5 69.4375 22.0039 69.72661 21.6563 curveto
70.0195 21.3086 70.4258 21.1367 70.9531 21.1367 curveto
71.1367 21.1367 71.3203 21.1563 71.5117 21.207 curveto
71.6992 21.2539 71.8672 21.3164 72.0195 21.3945 curveto
72.1523 21.46089 72.27339 21.5313 72.3906 21.6055 curveto
72.5039 21.6836 72.5977 21.7461 72.66411 21.8008 curveto
72.71089 21.8008 lineto
 closepath fill
newpath 78.3594 20.4688 moveto
77.457 20.4688 lineto
77.457 23.5273 lineto
77.457 23.77339 77.4414 24.0078 77.41411 24.2227 curveto
77.3828 24.4375 77.332 24.6094 77.2539 24.7305 curveto
77.1719 24.8633 77.0586 24.9648 76.9063 25.0313 curveto
76.7578 25.0938 76.5625 25.1289 76.3203 25.1289 curveto
76.0742 25.1289 75.8164 25.0664 75.5469 24.9453 curveto
75.2773 24.8242 75.0195 24.668 74.77339 24.4805 curveto
74.77339 20.4688 lineto
73.8711 20.4688 lineto
73.8711 27.9492 lineto
74.77339 27.9492 lineto
74.77339 25.2422 lineto
75.0547 25.47661 75.3477 25.6602 75.64839 25.793 curveto
75.9492 25.9219 76.2578 25.9883 76.5781 25.9883 curveto
77.1563 25.9883 77.5977 25.8125 77.9023 25.4648 curveto
78.207 25.1172 78.3594 24.6133 78.3594 23.957 curveto
 closepath fill
newpath 84.5508 20.4688 moveto
83.64839 20.4688 lineto
83.64839 21.0664 lineto
83.3438 20.8242 83.0508 20.6406 82.77339 20.5117 curveto
82.4922 20.3867 82.1875 20.3203 81.8477 20.3203 curveto
81.2852 20.3203 80.8477 20.4922 80.5313 20.83589 curveto
80.2188 21.1836 80.0625 21.6875 80.0625 22.3555 curveto
80.0625 25.8398 lineto
80.9648 25.8398 lineto
80.9648 22.7813 lineto
80.9648 22.5117 80.97661 22.2773 81.0039 22.082 curveto
81.0313 21.8906 81.082 21.7227 81.168 21.58589 curveto
81.2539 21.4453 81.3672 21.3398 81.5039 21.2773 curveto
81.6406 21.2148 81.8398 21.1797 82.1055 21.1797 curveto
82.3398 21.1797 82.5938 21.2422 82.8711 21.3633 curveto
83.14839 21.4844 83.4063 21.6406 83.64839 21.832 curveto
83.64839 25.8398 lineto
84.5508 25.8398 lineto
 closepath fill
newpath 90.8203 20.4688 moveto
89.91411 20.4688 lineto
89.91411 23.5273 lineto
89.91411 23.77339 89.9023 24.0078 89.8711 24.2227 curveto
89.8438 24.4375 89.78911 24.6094 89.7148 24.7305 curveto
89.6328 24.8633 89.5195 24.9648 89.3672 25.0313 curveto
89.2188 25.0938 89.02339 25.1289 88.7813 25.1289 curveto
88.5352 25.1289 88.2773 25.0664 88.0078 24.9453 curveto
87.7383 24.8242 87.4805 24.668 87.2344 24.4805 curveto
87.2344 20.4688 lineto
86.3281 20.4688 lineto
86.3281 25.8398 lineto
87.2344 25.8398 lineto
87.2344 25.2422 lineto
87.5156 25.47661 87.8086 25.6602 88.1094 25.793 curveto
88.4102 25.9219 88.7188 25.9883 89.0352 25.9883 curveto
89.6172 25.9883 90.0586 25.8125 90.3633 25.4648 curveto
90.668 25.1172 90.8203 24.6133 90.8203 23.957 curveto
 closepath fill
newpath 96.91411 21.082 moveto
96.91411 20.1719 96.707 19.5039 96.293 19.0781 curveto
95.8828 18.64839 95.2461 18.4375 94.3867 18.4375 curveto
94.10161 18.4375 93.8242 18.457 93.5508 18.4961 curveto
93.2813 18.5352 93.0156 18.5938 92.7539 18.668 curveto
92.7539 19.5898 lineto
92.8008 19.5898 lineto
92.9492 19.5313 93.1797 19.46089 93.5039 19.375 curveto
93.8242 19.293 94.1445 19.25 94.4648 19.25 curveto
94.7695 19.25 95.0273 19.2852 95.22661 19.3594 curveto
95.4297 19.4336 95.58589 19.5352 95.6992 19.668 curveto
95.8125 19.793 95.8906 19.9453 95.9375 20.1211 curveto
95.9883 20.2969 96.0117 20.4922 96.0117 20.71089 curveto
96.0117 21.1992 lineto
95.7383 20.9844 95.47661 20.8203 95.2305 20.71089 curveto
94.9805 20.6055 94.66411 20.5508 94.2813 20.5508 curveto
93.6406 20.5508 93.1328 20.7813 92.7539 21.2461 curveto
92.3789 21.71089 92.1914 22.3633 92.1914 23.207 curveto
92.1914 23.668 92.2539 24.0664 92.3828 24.39839 curveto
92.5156 24.7344 92.6914 25.02339 92.91411 25.2695 curveto
93.125 25.4961 93.3789 25.6719 93.6758 25.8008 curveto
93.9727 25.9258 94.2695 25.9883 94.5664 25.9883 curveto
94.875 25.9883 95.1367 25.957 95.3438 25.8945 curveto
95.5547 25.832 95.7773 25.7383 96.0117 25.6094 curveto
96.0117 24.875 lineto
95.7695 24.9844 95.5469 25.0586 95.3398 25.1055 curveto
95.1328 25.1523 94.9258 25.1758 94.7227 25.1758 curveto
94.22661 25.1758 93.83589 25.0117 93.5508 24.6758 curveto
93.2656 24.3438 93.1211 23.8594 93.1211 23.22661 curveto
93.1211 22.6211 93.22661 22.16411 93.4414 21.8555 curveto
93.6523 21.543 94.0039 21.3867 94.4922 21.3867 curveto
94.7539 21.3867 95.0195 21.4375 95.2813 21.53911 curveto
95.5469 21.6406 95.78911 21.7773 96.0117 21.9453 curveto
96.0117 21.9453 lineto
96.0117 24.875 lineto
96.0117 25.6094 lineto
96.0703 25.8398 lineto
96.91411 25.8398 lineto
 closepath fill
newpath 102.527 22.0195 moveto
102.527 21.5273 102.328 21.125 101.922 20.8125 curveto
101.516 20.4961 100.961 20.3398 100.262 20.3398 curveto
99.8633 20.3398 99.5 20.3867 99.168 20.4805 curveto
98.83589 20.5781 98.5586 20.6797 98.332 20.793 curveto
98.332 21.8047 lineto
98.3828 21.8047 lineto
98.66411 21.5898 98.9844 21.4219 99.332 21.293 curveto
99.6836 21.168 100.016 21.1055 100.336 21.1055 curveto
100.734 21.1055 101.047 21.168 101.27 21.2969 curveto
101.492 21.4258 101.605 21.625 101.605 21.9023 curveto
101.605 22.1133 101.547 22.27339 101.42601 22.3828 curveto
101.30101 22.4922 101.06601 22.58589 100.723 22.66411 curveto
100.59401 22.6914 100.42601 22.72661 100.21901 22.7617 curveto
100.012 22.8008 99.8242 22.8438 99.6563 22.8867 curveto
99.1836 23.0117 98.8477 23.1992 98.6523 23.4375 curveto
98.457 23.6797 98.3555 23.97661 98.3555 24.332 curveto
98.3555 24.5508 98.4023 24.7617 98.4922 24.957 curveto
98.58589 25.1523 98.7227 25.3242 98.9102 25.4805 curveto
99.0898 25.6289 99.3164 25.75 99.5938 25.83589 curveto
99.8711 25.9258 100.18399 25.9688 100.52301 25.9688 curveto
100.84401 25.9688 101.172 25.9297 101.5 25.85161 curveto
101.828 25.77339 102.10199 25.6797 102.31601 25.5664 curveto
102.31601 24.60161 lineto
102.27 24.60161 lineto
102.039 24.7695 101.758 24.91411 101.43 25.0313 curveto
101.098 25.14839 100.77301 25.207 100.457 25.207 curveto
100.129 25.207 99.8477 25.1406 99.6211 25.0156 curveto
99.3945 24.8906 99.2813 24.6992 99.2813 24.4492 curveto
99.2813 24.2305 99.3477 24.0625 99.4883 23.9492 curveto
99.6211 23.8398 99.8398 23.7461 100.141 23.6758 curveto
100.30899 23.6367 100.492 23.60161 100.69899 23.5625 curveto
100.90599 23.52339 101.078 23.4883 101.21901 23.457 curveto
101.637 23.3594 101.961 23.1953 102.188 22.96089 curveto
102.414 22.7227 102.527 22.4102 102.527 22.0195 curveto
 closepath fill
newpath 104.734 20.4688 moveto
103.832 20.4688 lineto
103.832 25.8398 lineto
104.734 25.8398 lineto
 closepath fill
newpath 104.793 26.7383 moveto
103.77301 26.7383 lineto
103.77301 27.6758 lineto
104.793 27.6758 lineto
 closepath fill
newpath 111.016 20.4688 moveto
110.109 20.4688 lineto
110.109 23.5273 lineto
110.109 23.77339 110.098 24.0078 110.06601 24.2227 curveto
110.039 24.4375 109.984 24.6094 109.90599 24.7305 curveto
109.828 24.8633 109.715 24.9648 109.563 25.0313 curveto
109.41 25.0938 109.215 25.1289 108.97699 25.1289 curveto
108.73 25.1289 108.473 25.0664 108.203 24.9453 curveto
107.93399 24.8242 107.67601 24.668 107.43 24.4805 curveto
107.43 20.4688 lineto
106.52301 20.4688 lineto
106.52301 25.8398 lineto
107.43 25.8398 lineto
107.43 25.2422 lineto
107.711 25.47661 108 25.6602 108.305 25.793 curveto
108.605 25.9219 108.914 25.9883 109.23 25.9883 curveto
109.813 25.9883 110.254 25.8125 110.55899 25.4648 curveto
110.863 25.1172 111.016 24.6133 111.016 23.957 curveto
 closepath fill
newpath 116.59 22.0195 moveto
116.59 21.5273 116.387 21.125 115.98 20.8125 curveto
115.578 20.4961 115.02301 20.3398 114.32 20.3398 curveto
113.92601 20.3398 113.55899 20.3867 113.22699 20.4805 curveto
112.895 20.5781 112.617 20.6797 112.395 20.793 curveto
112.395 21.8047 lineto
112.44101 21.8047 lineto
112.72699 21.5898 113.043 21.4219 113.395 21.293 curveto
113.742 21.168 114.078 21.1055 114.39801 21.1055 curveto
114.797 21.1055 115.105 21.168 115.332 21.2969 curveto
115.555 21.4258 115.668 21.625 115.668 21.9023 curveto
115.668 22.1133 115.605 22.27339 115.484 22.3828 curveto
115.363 22.4922 115.129 22.58589 114.78099 22.66411 curveto
114.652 22.6914 114.488 22.72661 114.28099 22.7617 curveto
114.07399 22.8008 113.887 22.8438 113.715 22.8867 curveto
113.242 23.0117 112.91 23.1992 112.715 23.4375 curveto
112.516 23.6797 112.418 23.97661 112.418 24.332 curveto
112.418 24.5508 112.465 24.7617 112.555 24.957 curveto
112.645 25.1523 112.785 25.3242 112.96901 25.4805 curveto
113.14801 25.6289 113.379 25.75 113.65599 25.83589 curveto
113.93399 25.9258 114.242 25.9688 114.586 25.9688 curveto
114.90599 25.9688 115.23 25.9297 115.55899 25.85161 curveto
115.887 25.77339 116.16 25.6797 116.379 25.5664 curveto
116.379 24.60161 lineto
116.332 24.60161 lineto
116.10199 24.7695 115.82 24.91411 115.488 25.0313 curveto
115.16 25.14839 114.836 25.207 114.52 25.207 curveto
114.188 25.207 113.91 25.1406 113.68399 25.0156 curveto
113.453 24.8906 113.34 24.6992 113.34 24.4492 curveto
113.34 24.2305 113.41 24.0625 113.547 23.9492 curveto
113.68399 23.8398 113.89801 23.7461 114.19899 23.6758 curveto
114.367 23.6367 114.555 23.60161 114.762 23.5625 curveto
114.96901 23.52339 115.141 23.4883 115.277 23.457 curveto
115.69899 23.3594 116.02 23.1953 116.25 22.96089 curveto
116.47699 22.7227 116.59 22.4102 116.59 22.0195 curveto
 closepath fill
newpath 120.672 20.5195 moveto
120.5 20.4727 120.31601 20.4375 120.117 20.4063 curveto
119.914 20.3789 119.738 20.3633 119.578 20.3633 curveto
119.03099 20.3633 118.613 20.5117 118.328 20.8047 curveto
118.047 21.10161 117.902 21.5742 117.902 22.22661 curveto
117.902 25.082 lineto
117.293 25.082 lineto
117.293 25.8398 lineto
117.902 25.8398 lineto
117.902 27.3828 lineto
118.805 27.3828 lineto
118.805 25.8398 lineto
120.672 25.8398 lineto
120.672 25.082 lineto
118.805 25.082 lineto
118.805 22.6328 lineto
118.805 22.35161 118.813 22.1328 118.82399 21.9727 curveto
118.84 21.8125 118.883 21.66411 118.961 21.5273 curveto
119.03099 21.39839 119.129 21.3047 119.25 21.2461 curveto
119.375 21.1875 119.563 21.1563 119.81601 21.1563 curveto
119.965 21.1563 120.117 21.1797 120.277 21.2227 curveto
120.438 21.2656 120.55101 21.3008 120.621 21.332 curveto
120.672 21.332 lineto
 closepath fill
newpath 122.67601 20.4688 moveto
121.77301 20.4688 lineto
121.77301 25.8398 lineto
122.67601 25.8398 lineto
 closepath fill
newpath 122.734 26.7383 moveto
121.715 26.7383 lineto
121.715 27.6758 lineto
122.734 27.6758 lineto
 closepath fill
newpath 127.254 20.5195 moveto
127.082 20.4727 126.89801 20.4375 126.695 20.4063 curveto
126.496 20.3789 126.31601 20.3633 126.16 20.3633 curveto
125.613 20.3633 125.195 20.5117 124.91 20.8047 curveto
124.625 21.10161 124.484 21.5742 124.484 22.22661 curveto
124.484 25.082 lineto
123.871 25.082 lineto
123.871 25.8398 lineto
124.484 25.8398 lineto
124.484 27.3828 lineto
125.387 27.3828 lineto
125.387 25.8398 lineto
127.254 25.8398 lineto
127.254 25.082 lineto
125.387 25.082 lineto
125.387 22.6328 lineto
125.387 22.35161 125.395 22.1328 125.40599 21.9727 curveto
125.418 21.8125 125.465 21.66411 125.539 21.5273 curveto
125.609 21.39839 125.707 21.3047 125.832 21.2461 curveto
125.953 21.1875 126.145 21.1563 126.395 21.1563 curveto
126.543 21.1563 126.69899 21.1797 126.859 21.2227 curveto
127.02 21.2656 127.133 21.3008 127.203 21.332 curveto
127.254 21.332 lineto
 closepath fill
newpath 132.793 20.4688 moveto
131.891 20.4688 lineto
131.891 21.0664 lineto
131.586 20.8242 131.293 20.6406 131.016 20.5117 curveto
130.738 20.3867 130.43 20.3203 130.094 20.3203 curveto
129.527 20.3203 129.09 20.4922 128.773 20.83589 curveto
128.461 21.1836 128.305 21.6875 128.305 22.3555 curveto
128.305 25.8398 lineto
129.207 25.8398 lineto
129.207 22.7813 lineto
129.207 22.5117 129.223 22.2773 129.246 22.082 curveto
129.273 21.8906 129.328 21.7227 129.41 21.58589 curveto
129.496 21.4453 129.609 21.3398 129.746 21.2773 curveto
129.883 21.2148 130.086 21.1797 130.348 21.1797 curveto
130.582 21.1797 130.836 21.2422 131.113 21.3633 curveto
131.391 21.4844 131.648 21.6406 131.891 21.832 curveto
131.891 25.8398 lineto
132.793 25.8398 lineto
 closepath fill
newpath 137.355 20.5195 moveto
137.184 20.4727 137 20.4375 136.801 20.4063 curveto
136.598 20.3789 136.422 20.3633 136.266 20.3633 curveto
135.715 20.3633 135.301 20.5117 135.016 20.8047 curveto
134.73 21.10161 134.586 21.5742 134.586 22.22661 curveto
134.586 25.082 lineto
133.977 25.082 lineto
133.977 25.8398 lineto
134.586 25.8398 lineto
134.586 27.3828 lineto
135.488 27.3828 lineto
135.488 25.8398 lineto
137.355 25.8398 lineto
137.355 25.082 lineto
135.488 25.082 lineto
135.488 22.6328 lineto
135.488 22.35161 135.496 22.1328 135.508 21.9727 curveto
135.52 21.8125 135.566 21.66411 135.645 21.5273 curveto
135.715 21.39839 135.813 21.3047 135.934 21.2461 curveto
136.059 21.1875 136.246 21.1563 136.5 21.1563 curveto
136.645 21.1563 136.801 21.1797 136.961 21.2227 curveto
137.121 21.2656 137.234 21.3008 137.309 21.332 curveto
137.355 21.332 lineto
 closepath fill
newpath 53.418 12.6875 moveto
53.71089 12.3672 53.9336 11.9766 54.0898 11.5117 curveto
54.2461 11.0469 54.3242 10.5195 54.3242 9.92969 curveto
54.3242 9.33984 54.2422 8.8125 54.08589 8.34375 curveto
53.9258 7.8789 53.707 7.49219 53.418 7.17969 curveto
53.125 6.85547 52.7773 6.61328 52.375 6.44922 curveto
51.9727 6.28516 51.5117 6.20313 50.9961 6.20313 curveto
51.0039 7.02734 lineto
51.7148 7.02734 52.2813 7.27344 52.7031 7.77344 curveto
53.1211 8.27344 53.332 8.99219 53.332 9.92969 curveto
53.332 9.92969 lineto
53.332 10.8594 53.125 11.5742 52.707 12.082 curveto
52.293 12.5859 51.7227 12.8359 51.0039 12.8359 curveto
50.27339 12.8359 49.7031 12.5859 49.28911 12.082 curveto
48.8711 11.5742 48.66411 10.8594 48.66411 9.92969 curveto
48.66411 8.99219 48.8789 8.27344 49.3008 7.77344 curveto
49.7227 7.27344 50.28911 7.02734 51.0039 7.02734 curveto
50.9961 6.20313 lineto
50.4922 6.20313 50.0352 6.28906 49.625 6.45313 curveto
49.2148 6.6211 48.8633 6.86328 48.5742 7.17969 curveto
48.2852 7.4961 48.0625 7.88672 47.9102 8.34766 curveto
47.7539 8.8086 47.6758 9.33594 47.6758 9.92969 curveto
47.6758 10.5117 47.7539 11.0352 47.9063 11.5 curveto
48.0586 11.9609 48.2852 12.3594 48.5781 12.6875 curveto
48.8594 13.0039 49.21089 13.2422 49.6289 13.4102 curveto
50.0469 13.5781 50.5039 13.6602 50.9961 13.6602 curveto
51.5117 13.6602 51.9688 13.5742 52.3789 13.4063 curveto
52.78911 13.2383 53.1328 13 53.418 12.6875 curveto
 closepath fill
newpath 60.4844 9.07813 moveto
60.4844 8.63281 60.4219 8.22656 60.2969 7.86719 curveto
60.168 7.50781 60 7.20703 59.7852 6.96484 curveto
59.5547 6.71094 59.3047 6.51953 59.0352 6.39453 curveto
58.7617 6.26563 58.46089 6.20313 58.1367 6.20313 curveto
57.832 6.20313 57.5664 6.23828 57.33589 6.3125 curveto
57.1094 6.38672 56.8867 6.48047 56.66411 6.60156 curveto
56.66411 7.32422 lineto
56.9219 7.20703 57.1406 7.1289 57.3242 7.08203 curveto
57.5117 7.03906 57.7188 7.01563 57.9531 7.01563 curveto
58.4531 7.01563 58.8438 7.17969 59.1289 7.51172 curveto
59.4102 7.83594 59.5547 8.35156 59.5547 9.05469 curveto
59.5547 9.05469 lineto
59.5547 9.69531 59.4492 10.1836 59.2344 10.5117 curveto
59.02339 10.8438 58.6836 11.0117 58.21089 11.0117 curveto
57.9492 11.0117 57.6836 10.9531 57.41411 10.8398 curveto
57.1445 10.7266 56.8945 10.5781 56.66411 10.4023 curveto
56.66411 7.32422 lineto
56.66411 6.60156 lineto
56.6055 6.35156 lineto
55.7617 6.35156 lineto
55.7617 13.832 lineto
56.66411 13.832 lineto
56.66411 11.1602 lineto
56.918 11.3672 57.1875 11.5391 57.4727 11.6719 curveto
57.7578 11.8047 58.0781 11.8711 58.4336 11.8711 curveto
59.0703 11.8711 59.5703 11.6289 59.9375 11.1406 curveto
60.3008 10.6523 60.4844 9.96484 60.4844 9.07813 curveto
 closepath fill
newpath 66.3906 8.94531 moveto
62.4336 8.94531 lineto
62.4336 9.63672 lineto
65.5117 9.63672 lineto
65.5078 10.1094 65.3867 10.4766 65.1523 10.7383 curveto
64.91411 10.9961 64.5586 11.125 64.0781 11.125 curveto
63.5938 11.125 63.207 10.9844 62.9219 10.6992 curveto
62.6328 10.4141 62.4727 10.0586 62.4336 9.63672 curveto
62.4336 8.94531 lineto
62.4336 8.61328 62.4844 8.32813 62.582 8.08203 curveto
62.6797 7.83594 62.8164 7.63672 62.9922 7.47656 curveto
63.1563 7.32422 63.3555 7.20703 63.58589 7.13281 curveto
63.8125 7.05469 64.0664 7.01563 64.3398 7.01563 curveto
64.707 7.01563 65.0742 7.08984 65.4453 7.23438 curveto
65.8164 7.38281 66.0781 7.52344 66.2344 7.66406 curveto
66.2852 7.66406 lineto
66.2852 6.67969 lineto
65.9805 6.55078 65.668 6.44531 65.35161 6.35938 curveto
65.0352 6.26953 64.6992 6.22656 64.35161 6.22656 curveto
63.46089 6.22656 62.7656 6.46875 62.2656 6.95313 curveto
61.7656 7.4336 61.5156 8.11719 61.5156 9.00781 curveto
61.5156 9.88672 61.7539 10.582 62.2344 11.0977 curveto
62.71089 11.6133 63.3438 11.8711 64.125 11.8711 curveto
64.8477 11.8711 65.4063 11.6602 65.8008 11.2383 curveto
66.1914 10.8125 66.3906 10.2148 66.3906 9.4336 curveto
 closepath fill
newpath 71.1094 10.7383 moveto
71.0625 10.7383 lineto
70.9258 10.7695 70.7969 10.793 70.668 10.8086 curveto
70.543 10.8203 70.3945 10.8281 70.2188 10.8281 curveto
69.9414 10.8281 69.6719 10.7656 69.41411 10.6445 curveto
69.1523 10.5195 68.9023 10.3594 68.66411 10.1641 curveto
68.66411 6.35156 lineto
67.7578 6.35156 lineto
67.7578 11.7227 lineto
68.66411 11.7227 lineto
68.66411 10.9297 lineto
69.02339 11.2188 69.3398 11.4219 69.6133 11.543 curveto
69.8867 11.6641 70.16411 11.7227 70.4492 11.7227 curveto
70.6094 11.7227 70.7227 11.7188 70.793 11.7109 curveto
70.8633 11.7031 70.9688 11.6875 71.1094 11.6641 curveto
 closepath fill
newpath 78.7148 11.7227 moveto
77.3164 6.35156 lineto
76.4805 6.35156 lineto
75.0977 10.4922 lineto
73.7305 6.35156 lineto
72.89839 6.35156 lineto
71.4844 11.7227 lineto
72.4258 11.7227 lineto
73.4102 7.5625 lineto
74.7539 11.7227 lineto
75.5 11.7227 lineto
76.875 7.5625 lineto
77.8047 11.7227 lineto
 closepath fill
newpath 84.5938 9.03516 moveto
84.5938 8.16016 84.3672 7.46875 83.9219 6.96484 curveto
83.4727 6.45703 82.8711 6.20313 82.1172 6.20313 curveto
81.3594 6.20313 80.7539 6.45703 80.3086 6.96484 curveto
79.8594 7.46875 79.6367 8.16016 79.6367 9.03516 curveto
79.6367 9.91016 79.8594 10.6016 80.3086 11.1094 curveto
80.7539 11.6172 81.3594 11.8711 82.1172 11.8711 curveto
82.1172 11.0938 lineto
81.6289 11.0938 81.2461 10.9219 80.97661 10.5859 curveto
80.707 10.2461 80.5703 9.73047 80.5703 9.03516 curveto
80.5703 8.36328 80.707 7.85156 80.97661 7.5039 curveto
81.25 7.15625 81.6328 6.98438 82.1172 6.98438 curveto
82.5977 6.98438 82.97661 7.15625 83.25 7.5 curveto
83.52339 7.84375 83.6602 8.35547 83.6602 9.03516 curveto
83.6602 9.03516 lineto
83.6602 9.73047 83.52339 10.2461 83.2539 10.5859 curveto
82.9805 10.9219 82.60161 11.0938 82.1172 11.0938 curveto
82.1172 11.8711 lineto
82.8711 11.8711 83.4727 11.6172 83.9219 11.1094 curveto
84.3672 10.6016 84.5938 9.91016 84.5938 9.03516 curveto
 closepath fill
newpath 86.9063 6.35156 moveto
86.0039 6.35156 lineto
86.0039 13.832 lineto
86.9063 13.832 lineto
 closepath fill
newpath 91.582 12.957 moveto
91.5352 12.957 lineto
91.4336 12.9883 91.3047 13.0156 91.1445 13.0469 curveto
90.9844 13.0781 90.8438 13.0938 90.7227 13.0938 curveto
90.33589 13.0938 90.0547 13.0078 89.8789 12.8359 curveto
89.7031 12.6641 89.6172 12.3555 89.6172 11.9063 curveto
89.6172 11.7227 lineto
91.2461 11.7227 lineto
91.2461 10.9648 lineto
89.6445 10.9648 lineto
89.6445 6.35156 lineto
88.7422 6.35156 lineto
88.7422 10.9648 lineto
88.1328 10.9648 lineto
88.1328 11.7227 lineto
88.7422 11.7227 lineto
88.7422 11.8984 lineto
88.7422 12.5391 88.9023 13.0273 89.2188 13.3672 curveto
89.5352 13.7109 89.9922 13.8828 90.5938 13.8828 curveto
90.793 13.8828 90.97661 13.8711 91.1367 13.8516 curveto
91.3008 13.832 91.4492 13.8086 91.582 13.7852 curveto
 closepath fill
newpath 96.3281 6.35156 moveto
95.4297 6.35156 lineto
95.4297 6.92578 lineto
95.3477 6.8711 95.2383 6.79297 95.1055 6.69922 curveto
94.6992 7.23047 lineto
94.96089 7.35547 95.2031 7.5 95.4297 7.67578 curveto
95.4297 7.67578 lineto
95.4297 9.17188 lineto
95.1523 9.15234 94.8281 9.1289 94.457 9.09766 curveto
94.082 9.0664 93.7852 9.01953 93.5703 8.95703 curveto
93.3086 8.88672 93.0977 8.76953 92.9375 8.61328 curveto
92.7773 8.46094 92.6992 8.2461 92.6992 7.97266 curveto
92.6992 7.66406 92.78911 7.4336 92.97661 7.27734 curveto
93.16411 7.1211 93.4453 7.04688 93.8281 7.04688 curveto
94.1445 7.04688 94.4336 7.10547 94.6992 7.23047 curveto
95.1055 6.69922 lineto
94.9688 6.59766 94.83589 6.51953 94.707 6.46484 curveto
94.5547 6.39063 94.3828 6.32813 94.1875 6.27734 curveto
93.9922 6.23047 93.7656 6.20313 93.5 6.20313 curveto
93.0156 6.20313 92.6055 6.36328 92.2695 6.6836 curveto
91.9336 7.00781 91.7656 7.41406 91.7656 7.91016 curveto
91.7656 8.32031 91.85161 8.64844 92.0273 8.89844 curveto
92.2031 9.14844 92.4531 9.34766 92.77339 9.49219 curveto
93.10161 9.63672 93.4961 9.73438 93.9531 9.78516 curveto
94.4102 9.83594 94.9023 9.875 95.4297 9.90234 curveto
95.4297 10.0391 lineto
95.4297 10.2461 95.3945 10.4141 95.3203 10.5508 curveto
95.2461 10.6836 95.1445 10.7891 95.0117 10.8672 curveto
94.8828 10.9414 94.72661 10.9883 94.5469 11.0156 curveto
94.3672 11.043 94.1797 11.0547 93.9844 11.0547 curveto
93.75 11.0547 93.4844 11.0234 93.1953 10.9609 curveto
92.9023 10.8984 92.60161 10.8086 92.28911 10.6875 curveto
92.2422 10.6875 lineto
92.2422 11.6055 lineto
92.418 11.6563 92.6719 11.707 93.0078 11.7656 curveto
93.3398 11.8242 93.668 11.8516 93.9922 11.8516 curveto
94.3672 11.8516 94.6992 11.8203 94.9805 11.7578 curveto
95.2578 11.6953 95.5039 11.5898 95.707 11.4375 curveto
95.9102 11.293 96.0625 11.1016 96.168 10.8672 curveto
96.27339 10.6328 96.3281 10.3438 96.3281 9.9961 curveto
 closepath fill
newpath 102.039 6.6914 moveto
101.738 6.54688 101.44899 6.4336 101.18 6.35156 curveto
100.91 6.27344 100.621 6.23438 100.31601 6.23438 curveto
99.9297 6.23438 99.5742 6.28906 99.25 6.40234 curveto
98.9258 6.51563 98.64839 6.6914 98.418 6.92188 curveto
98.1836 7.15234 98.0039 7.44531 97.875 7.79688 curveto
97.7461 8.14844 97.6836 8.5586 97.6836 9.03125 curveto
97.6836 9.91016 97.9219 10.5977 98.4063 11.0977 curveto
98.8906 11.5977 99.5273 11.8477 100.31601 11.8477 curveto
100.625 11.8477 100.92601 11.8047 101.223 11.7188 curveto
101.52 11.6328 101.793 11.5273 102.039 11.4023 curveto
102.039 10.3945 lineto
101.988 10.3945 lineto
101.715 10.6094 101.43 10.7773 101.137 10.8906 curveto
100.84401 11.0078 100.55899 11.0625 100.277 11.0625 curveto
99.7656 11.0625 99.3594 10.8906 99.0664 10.5469 curveto
98.7695 10.2031 98.6211 9.69922 98.6211 9.03125 curveto
98.6211 8.38281 98.7656 7.88672 99.0547 7.53906 curveto
99.3438 7.1914 99.7539 7.01563 100.277 7.01563 curveto
100.461 7.01563 100.64801 7.03906 100.836 7.08984 curveto
101.02301 7.13672 101.195 7.19922 101.348 7.27734 curveto
101.47699 7.34375 101.60199 7.41406 101.715 7.48828 curveto
101.832 7.5664 101.922 7.63281 101.988 7.6836 curveto
102.039 7.6836 lineto
 closepath fill
newpath 107.688 6.35156 moveto
106.78099 6.35156 lineto
106.78099 9.41016 lineto
106.78099 9.65625 106.77 9.88672 106.738 10.1055 curveto
106.711 10.3203 106.65599 10.4922 106.582 10.6133 curveto
106.5 10.7461 106.387 10.8477 106.234 10.9141 curveto
106.086 10.9766 105.887 11.0117 105.64801 11.0117 curveto
105.402 11.0117 105.145 10.9492 104.875 10.8281 curveto
104.605 10.707 104.348 10.5508 104.10199 10.3633 curveto
104.10199 6.35156 lineto
103.195 6.35156 lineto
103.195 13.832 lineto
104.10199 13.832 lineto
104.10199 11.125 lineto
104.383 11.3594 104.67601 11.543 104.97699 11.6758 curveto
105.277 11.8047 105.586 11.8711 105.902 11.8711 curveto
106.484 11.8711 106.92601 11.6992 107.23 11.3477 curveto
107.535 11 107.688 10.4961 107.688 9.83984 curveto
 closepath fill
newpath 397.719 34.375 moveto
392.789 22.97661 lineto
387.81299 34.375 lineto
383.93799 18.3047 lineto
386.39801 18.3047 lineto
388.52701 27.7773 lineto
392.789 17.66411 lineto
397.051 27.7773 lineto
399.156 18.3047 lineto
401.621 18.3047 lineto
 closepath fill
newpath 430.883 26.1094 moveto
430.883 24.1055 lineto
434.965 24.1055 lineto
434.52701 21.53911 432.73001 19.9492 430.012 19.9492 curveto
426.72699 19.9492 424.51999 22.6172 424.51999 26.1875 curveto
424.51999 29.4453 426.801 31.9883 430.06299 31.9883 curveto
432.035 31.9883 433.47699 31.16411 434.93799 29.2656 curveto
436.762 30.6797 lineto
435.039 32.9883 432.80899 34.1172 430.012 34.1172 curveto
428.215 34.1172 426.695 33.5547 425.262 32.5 curveto
423.18399 30.96089 422.055 28.6758 422.055 26.0078 curveto
422.055 23.7461 422.89801 21.6406 424.43799 20.10161 curveto
425.953 18.5625 427.621 17.8203 430.012 17.8203 curveto
432.293 17.8203 434.01599 18.58589 435.426 20.1289 curveto
436.785 21.5664 437.453 23.2852 437.68799 26.1094 curveto
 closepath fill
newpath 465.66 33.6563 moveto
463.43 33.6563 lineto
463.43 23.207 lineto
451.93399 33.9648 lineto
451.93399 18.3047 lineto
454.164 18.3047 lineto
454.164 28.7773 lineto
465.66 17.9961 lineto
 closepath fill
newpath 500.031 18.3047 moveto
495.41 25.082 lineto
497.56601 25.64839 498.72699 27.1367 498.72699 29.293 curveto
498.72699 30.8594 498.031 32.2188 496.77301 32.9375 curveto
495.76999 33.5547 494.949 33.6563 492.074 33.6563 curveto
489.406 33.6563 lineto
489.406 18.3047 lineto
491.64099 18.3047 lineto
491.64099 24.8789 lineto
491.64099 26.9063 lineto
491.64099 31.6523 lineto
493.51599 31.6523 lineto
494.56601 31.6523 495.207 31.5 495.64499 31.1133 curveto
496.133 30.6797 496.43799 29.9336 496.43799 29.1875 curveto
496.43799 28.2656 495.949 27.4961 495.10501 27.1367 curveto
494.668 26.957 494.078 26.9063 492.69101 26.9063 curveto
491.64099 26.9063 lineto
491.64099 24.8789 lineto
492.82 24.8789 lineto
497.211 18.3047 lineto
 closepath fill
newpath 445.336 33.6563 moveto
443.074 33.6563 lineto
443.074 18.3047 lineto
445.336 18.3047 lineto
 closepath fill
newpath 378.75 33.6563 moveto
376.51999 33.6563 lineto
376.51999 18.3047 lineto
378.75 18.3047 lineto
 closepath fill
newpath 515.10199 33.6563 moveto
512.76599 33.6563 lineto
508.81299 27.3164 lineto
504.781 33.6563 lineto
502.31601 33.6563 lineto
507.656 24.9805 lineto
507.656 18.3047 lineto
509.89099 18.3047 lineto
509.89099 25.2383 lineto
 closepath fill
newpath 416.76599 18.3047 moveto
419.23001 18.3047 lineto
411.81299 34.2188 lineto
404.39499 18.3047 lineto
406.85501 18.3047 lineto
408.445 21.9258 lineto
415.14801 21.9258 lineto
414.27301 23.9258 lineto
409.34799 23.9258 lineto
411.81299 29.4961 lineto
414.27301 23.9258 lineto
415.14801 21.9258 lineto
 closepath fill
newpath 482.449 18.3047 moveto
484.914 18.3047 lineto
477.496 34.2188 lineto
470.078 18.3047 lineto
472.539 18.3047 lineto
474.133 21.9258 lineto
480.832 21.9258 lineto
479.961 23.9258 lineto
475.031 23.9258 lineto
477.496 29.4961 lineto
479.961 23.9258 lineto
480.832 21.9258 lineto
 closepath fill
newpath 408.32 11.582 moveto
408.32 10.8867 lineto
409.06299 10.8867 409.65201 10.2695 409.65201 9.52734 curveto
409.65201 8.8086 409.06299 8.21875 408.32 8.21875 curveto
407.60199 8.21875 407.035 8.8086 407.035 9.52734 curveto
407.035 10.2695 407.60199 10.8867 408.32 10.8867 curveto
408.32 10.8867 lineto
408.32 11.582 lineto
407.19101 11.582 406.26999 10.6836 406.26999 9.52734 curveto
406.26999 8.3711 407.19101 7.47266 408.32 7.47266 curveto
409.47699 7.47266 410.39801 8.3711 410.39801 9.52734 curveto
410.39801 10.6836 409.47699 11.582 408.32 11.582 curveto
 closepath fill
newpath 412.426 11.4531 moveto
411.68399 11.4531 lineto
411.68399 5.39453 lineto
412.426 5.39453 lineto
412.426 8.21875 lineto
412.449 8.21875 lineto
412.73401 7.78125 413.195 7.47266 413.762 7.47266 curveto
414.94101 7.47266 415.586 8.44922 415.586 9.57813 curveto
415.586 10.6328 414.89099 11.582 413.785 11.582 curveto
413.60501 10.9141 lineto
414.40201 10.9141 414.863 10.2969 414.863 9.55078 curveto
414.863 8.78125 414.40201 8.16797 413.60501 8.16797 curveto
413.60501 8.16797 lineto
412.81299 8.16797 412.375 8.83203 412.375 9.55078 curveto
412.375 10.2461 412.84 10.9141 413.60501 10.9141 curveto
413.785 11.582 lineto
413.195 11.582 412.73401 11.2969 412.449 10.8359 curveto
412.426 10.8359 lineto
 closepath fill
newpath 420.51599 9.39844 moveto
420.51599 9.52734 lineto
420.51599 10.6836 419.945 11.582 418.715 11.582 curveto
417.48401 11.582 416.844 10.6836 416.844 9.5 curveto
416.844 8.3711 417.56299 7.47266 418.715 7.47266 curveto
419.48401 7.47266 420.15201 7.85938 420.51599 8.52734 curveto
419.89499 8.88672 lineto
419.613 8.42188 419.30899 8.16797 418.715 8.16797 curveto
418.02301 8.16797 417.586 8.75781 417.586 9.39844 curveto
417.60901 9.98828 lineto
417.715 10.5273 418.14801 10.9375 418.715 10.9375 curveto
419.30899 10.9375 419.69101 10.5781 419.76999 9.98828 curveto
417.60901 9.98828 lineto
417.586 9.39844 lineto
 closepath fill
newpath 422.72299 11.4531 moveto
421.97699 11.4531 lineto
421.97699 7.6289 lineto
422.72299 7.6289 lineto
422.72299 9.3711 lineto
422.72299 10.0898 422.72299 10.9141 423.672 10.9141 curveto
424.43799 10.9141 424.543 10.4492 424.543 9.8086 curveto
424.543 7.6289 lineto
425.23401 7.6289 lineto
425.23401 9.91016 lineto
425.23401 10.8633 425.004 11.582 423.89801 11.582 curveto
423.43799 11.582 422.97699 11.375 422.746 10.9375 curveto
422.72299 10.9375 lineto
 closepath fill
newpath 431.496 11.4531 moveto
430.73001 11.4531 lineto
430.73001 7.6289 lineto
431.496 7.6289 lineto
431.496 9.5 lineto
431.496 10.1172 431.551 10.9141 432.34799 10.9141 curveto
433.039 10.9141 433.06299 10.168 433.06299 9.65625 curveto
433.06299 7.6289 lineto
433.80899 7.6289 lineto
433.80899 9.5 lineto
433.80899 10.1172 433.85901 10.9141 434.656 10.9141 curveto
435.297 10.9141 435.375 10.2969 435.375 9.78516 curveto
435.375 7.6289 lineto
436.094 7.6289 lineto
436.094 9.91016 lineto
436.094 10.7852 435.836 11.582 434.836 11.582 curveto
434.34799 11.582 433.887 11.3242 433.629 10.9141 curveto
433.39801 11.3477 433.039 11.582 432.52301 11.582 curveto
432.09 11.582 431.703 11.3242 431.496 10.9648 curveto
 closepath fill
newpath 441.508 11.4531 moveto
440.789 11.4531 lineto
440.789 10.8359 lineto
440.76599 10.8359 lineto
440.457 11.2969 439.992 11.582 439.43 11.582 curveto
439.55899 10.9141 lineto
440.35501 10.9141 440.81601 10.2969 440.81601 9.55078 curveto
440.81601 8.78125 440.35501 8.16797 439.55899 8.16797 curveto
439.55899 8.16797 lineto
438.76599 8.16797 438.324 8.83203 438.324 9.55078 curveto
438.324 10.2461 438.785 10.9141 439.55899 10.9141 curveto
439.43 11.582 lineto
438.301 11.582 437.60501 10.6328 437.60501 9.57813 curveto
437.60501 8.44922 438.27301 7.47266 439.43 7.47266 curveto
439.992 7.47266 440.457 7.78125 440.76599 8.21875 curveto
440.789 8.21875 lineto
440.789 7.6289 lineto
441.508 7.6289 lineto
 closepath fill
newpath 446.72299 13.7891 moveto
446.72299 7.6289 lineto
447.465 7.6289 lineto
447.465 9.3711 lineto
447.465 10.0898 447.465 10.9141 448.414 10.9141 curveto
449.18399 10.9141 449.262 10.4492 449.262 9.8086 curveto
449.262 7.6289 lineto
450.008 7.6289 lineto
450.008 9.91016 lineto
450.008 10.8633 449.72299 11.582 448.617 11.582 curveto
448.18399 11.582 447.72299 11.375 447.465 10.9375 curveto
447.465 13.7891 lineto
 closepath fill
newpath 455.344 9.39844 moveto
455.344 9.52734 lineto
455.344 10.6836 454.754 11.582 453.51999 11.582 curveto
452.289 11.582 451.676 10.6836 451.676 9.5 curveto
451.676 8.3711 452.367 7.47266 453.547 7.47266 curveto
454.289 7.47266 454.98401 7.85938 455.344 8.52734 curveto
454.73001 8.88672 lineto
454.445 8.42188 454.14099 8.16797 453.547 8.16797 curveto
452.85501 8.16797 452.418 8.75781 452.39499 9.39844 curveto
452.44101 9.98828 lineto
452.51999 10.5273 452.957 10.9375 453.51999 10.9375 curveto
454.14099 10.9375 454.52301 10.5781 454.60199 9.98828 curveto
452.44101 9.98828 lineto
452.39499 9.39844 lineto
 closepath fill
newpath 457.85901 11.4531 moveto
457.113 11.4531 lineto
457.113 7.6289 lineto
457.85901 7.6289 lineto
457.85901 9.5 lineto
457.85901 10.1172 457.91 10.9141 458.707 10.9141 curveto
459.371 10.9141 459.39801 10.168 459.39801 9.65625 curveto
459.39801 7.6289 lineto
460.14499 7.6289 lineto
460.14499 9.5 lineto
460.14499 10.1172 460.22299 10.9141 460.988 10.9141 curveto
461.656 10.9141 461.73401 10.2969 461.73401 9.78516 curveto
461.73401 7.6289 lineto
462.453 7.6289 lineto
462.453 9.91016 lineto
462.453 10.7852 462.195 11.582 461.195 11.582 curveto
460.711 11.582 460.246 11.3242 459.988 10.9141 curveto
459.73401 11.3477 459.371 11.582 458.887 11.582 curveto
458.449 11.582 458.09 11.3242 457.85901 10.9648 curveto
 closepath fill
newpath 467.867 11.4531 moveto
467.125 11.4531 lineto
467.125 10.8359 lineto
466.81601 11.2969 466.35501 11.582 465.789 11.582 curveto
465.922 10.9141 lineto
466.715 10.9141 467.176 10.2969 467.176 9.55078 curveto
467.176 8.78125 466.715 8.16797 465.922 8.16797 curveto
465.922 8.16797 lineto
465.121 8.16797 464.68799 8.83203 464.68799 9.55078 curveto
464.68799 10.2461 465.14801 10.9141 465.922 10.9141 curveto
465.789 11.582 lineto
464.66 11.582 463.969 10.6328 463.969 9.57813 curveto
463.969 8.44922 464.637 7.47266 465.789 7.47266 curveto
466.35501 7.47266 466.81601 7.78125 467.125 8.21875 curveto
467.125 7.6289 lineto
467.867 7.6289 lineto
 closepath fill
newpath 473.824 11.4531 moveto
473.10501 11.4531 lineto
473.10501 7.6289 lineto
473.824 7.6289 lineto
 closepath fill
newpath 473.492 13.7617 moveto
473.18399 13.7617 472.98001 13.5078 472.98001 13.2227 curveto
472.98001 12.9414 473.18399 12.7344 473.492 12.7344 curveto
473.746 12.7344 474.004 12.9414 474.004 13.2227 curveto
474.004 13.5078 473.746 13.7617 473.492 13.7617 curveto
 closepath fill
newpath 479.06299 10.7344 moveto
478.906 10.9883 478.39499 11.582 477.51999 11.582 curveto
476.34 11.582 475.414 10.707 475.414 9.5 curveto
475.414 8.34766 476.34 7.47266 477.47299 7.47266 curveto
478.31601 7.47266 478.77701 7.9336 479.012 8.26953 curveto
478.496 8.65625 lineto
478.26599 8.39844 478.035 8.16797 477.496 8.16797 curveto
476.676 8.16797 476.137 8.75781 476.137 9.55078 curveto
476.137 10.2461 476.699 10.9141 477.445 10.9141 curveto
477.883 10.9141 478.238 10.707 478.52301 10.375 curveto
 closepath fill
newpath 482.47699 10.9141 moveto
482.26999 11.3477 481.887 11.582 481.426 11.582 curveto
480.781 11.582 480.293 11.1172 480.293 10.4492 curveto
480.293 9.9375 480.60199 9.73047 481.01599 9.5 curveto
481.758 9.11719 lineto
481.91 8.98828 482.01599 8.88672 482.01599 8.67969 curveto
482.01599 8.34766 481.758 8.16797 481.449 8.16797 curveto
481.09 8.16797 480.887 8.34766 480.758 8.65625 curveto
480.09 8.34766 lineto
480.32 7.8086 480.887 7.47266 481.449 7.47266 curveto
482.14499 7.47266 482.781 8.01172 482.781 8.75781 curveto
482.781 9.34766 482.34799 9.65625 481.887 9.85938 curveto
481.426 10.0391 480.98401 10.2188 480.98401 10.5273 curveto
480.98401 10.7617 481.19101 10.9141 481.371 10.9141 curveto
481.60501 10.9141 481.781 10.7852 481.887 10.6055 curveto
 closepath fill
newpath 444.332 10.7852 moveto
445.051 10.7852 lineto
445.051 11.4531 lineto
444.332 11.4531 lineto
444.332 12.9414 lineto
443.56299 12.9414 lineto
443.56299 11.4531 lineto
443.15201 11.4531 lineto
443.15201 10.7852 lineto
443.56299 10.7852 lineto
443.56299 7.6289 lineto
444.332 7.6289 lineto
 closepath fill
newpath 470.76999 10.7852 moveto
471.539 10.7852 lineto
471.539 11.4531 lineto
470.76999 11.4531 lineto
470.76999 12.9414 lineto
470.051 12.9414 lineto
470.051 11.4531 lineto
469.64499 11.4531 lineto
469.64499 10.7852 lineto
470.051 10.7852 lineto
470.051 7.6289 lineto
470.76999 7.6289 lineto
 closepath fill
newpath 183.273 11.8047 moveto
183.273 15.3086 lineto
183.734 15.3086 lineto
183.734 12.2188 lineto
185.27 12.2188 lineto
185.27 11.8047 lineto
 closepath fill
newpath 187.75 13.0156 moveto
185.961 13.0156 lineto
185.973 13.3359 lineto
187.344 13.3359 lineto
187.344 13.5117 187.289 13.6602 187.18 13.7773 curveto
187.059 13.9102 186.891 13.9727 186.68 13.9727 curveto
186.68 13.9727 lineto
186.484 13.9727 186.32 13.9102 186.188 13.7813 curveto
186.063 13.6641 185.988 13.5117 185.973 13.3359 curveto
185.961 13.0156 lineto
185.961 12.7227 186.039 12.5 186.199 12.3438 curveto
186.34 12.207 186.52 12.1406 186.742 12.1406 curveto
186.992 12.1406 187.203 12.2148 187.371 12.3633 curveto
187.555 12.043 lineto
187.488 11.9766 187.383 11.918 187.242 11.8672 curveto
187.066 11.8047 186.871 11.7695 186.656 11.7695 curveto
186.344 11.7695 186.078 11.875 185.859 12.0898 curveto
185.621 12.3203 185.496 12.6328 185.496 13.0273 curveto
185.496 13.4375 185.621 13.7656 185.871 14.0117 curveto
186.094 14.2344 186.355 14.3438 186.66 14.3438 curveto
187.012 14.3438 187.289 14.2461 187.492 14.043 curveto
187.684 13.8516 187.781 13.5977 187.781 13.2813 curveto
187.781 13.1836 187.77 13.0977 187.75 13.0156 curveto
 closepath fill
newpath 188.785 15.2227 moveto
188.863 15.2227 188.926 15.1953 188.98 15.1406 curveto
189.035 15.0898 189.059 15.0234 189.059 14.9492 curveto
189.059 14.875 189.035 14.8125 188.98 14.7578 curveto
188.926 14.7031 188.863 14.6758 188.785 14.6758 curveto
188.715 14.6758 188.648 14.7031 188.594 14.7578 curveto
188.543 14.8125 188.516 14.875 188.516 14.9492 curveto
188.516 15.0273 188.543 15.0898 188.594 15.1445 curveto
188.645 15.1953 188.711 15.2227 188.785 15.2227 curveto
 closepath fill
newpath 188.609 11.8047 moveto
188.609 13.9141 lineto
188.27 13.9141 lineto
188.27 14.2852 lineto
189.051 14.2852 lineto
189.051 11.8047 lineto
 closepath fill
newpath 190.277 11.9805 moveto
190.125 11.7578 lineto
189.902 11.7578 lineto
189.902 15.3242 lineto
190.344 15.3242 lineto
190.344 14.1016 lineto
190.531 13.8906 lineto
190.438 13.8438 190.371 13.8008 190.344 13.7656 curveto
190.344 13.7656 lineto
190.344 12.332 lineto
190.344 12.3086 190.398 12.2695 190.508 12.2109 curveto
190.617 12.1563 190.703 12.1289 190.758 12.1289 curveto
191.059 12.1289 191.273 12.1992 191.402 12.3438 curveto
191.531 12.4883 191.598 12.7266 191.598 13.0664 curveto
191.598 13.3477 191.52 13.5664 191.371 13.7227 curveto
191.219 13.8789 191.016 13.9609 190.758 13.9609 curveto
190.703 13.9609 190.629 13.9375 190.531 13.8906 curveto
190.344 14.1016 lineto
190.387 14.1563 190.465 14.2109 190.578 14.2578 curveto
190.695 14.3047 190.809 14.332 190.918 14.332 curveto
191.258 14.332 191.531 14.2109 191.742 13.9805 curveto
191.953 13.7422 192.059 13.4453 192.059 13.0898 curveto
192.059 12.6758 191.953 12.3477 191.742 12.1133 curveto
191.531 11.875 191.246 11.7578 190.883 11.7578 curveto
190.766 11.7578 190.652 11.7773 190.539 11.8242 curveto
190.426 11.8672 190.34 11.918 190.277 11.9805 curveto
 closepath fill
newpath 194.184 11.8047 moveto
194.184 13.2461 lineto
194.184 13.5117 194.145 13.6953 194.063 13.8008 curveto
193.984 13.9063 193.852 13.9609 193.664 13.9609 curveto
193.566 13.9609 193.461 13.9297 193.352 13.8711 curveto
193.238 13.8086 193.156 13.7344 193.098 13.6484 curveto
193.098 11.8047 lineto
192.656 11.8047 lineto
192.656 14.2852 lineto
192.957 14.2852 lineto
193.098 13.9648 lineto
193.242 14.207 193.48 14.332 193.809 14.332 curveto
194.352 14.332 194.625 14 194.625 13.3398 curveto
194.625 11.8047 lineto
 closepath fill
newpath 195.715 15.2227 moveto
195.789 15.2227 195.855 15.1953 195.906 15.1406 curveto
195.961 15.0898 195.988 15.0234 195.988 14.9492 curveto
195.988 14.875 195.961 14.8125 195.906 14.7578 curveto
195.855 14.7031 195.789 14.6758 195.715 14.6758 curveto
195.641 14.6758 195.574 14.7031 195.523 14.7578 curveto
195.469 14.8125 195.441 14.875 195.441 14.9492 curveto
195.441 15.0273 195.469 15.0898 195.52 15.1445 curveto
195.574 15.1953 195.637 15.2227 195.715 15.2227 curveto
 closepath fill
newpath 195.535 11.8047 moveto
195.535 13.9141 lineto
195.195 13.9141 lineto
195.195 14.2852 lineto
195.977 14.2852 lineto
195.977 11.8047 lineto
 closepath fill
newpath 197.402 12.1992 moveto
198.777 12.1992 lineto
198.777 11.8047 lineto
196.711 11.8047 lineto
196.711 11.918 lineto
198.121 13.8906 lineto
196.734 13.8906 lineto
196.734 14.2852 lineto
198.766 14.2852 lineto
198.766 14.1602 lineto
 closepath fill
newpath 216.895 20.4297 moveto
217.129 20.1289 217.711 19.5977 219.133 20.957 curveto
220.559 22.3125 219.832 21.7422 220.641 19.9922 curveto
221.449 18.25 221.93 19.22661 221.973 19.5703 curveto
222.078 20.4297 221.789 22.1094 221.598 22.78911 curveto
221.438 23.3633 220.438 23.6328 220.043 23.33589 curveto
219.672 23.0625 218.691 21.9336 218.035 21.7148 curveto
217.375 21.4922 217.891 22.1328 217.707 23.1836 curveto
217.527 24.2383 217.129 24.71089 216.715 24.5273 curveto
216.438 24.4023 215.844 23.8008 215.539 23.9258 curveto
214.887 24.1836 214 24.9492 212.211 24.03911 curveto
208.969 22.3867 211.375 25.7617 211.375 25.7617 curveto
211.375 25.7617 213.766 29.5078 212.508 31.4414 curveto
211.277 33.3242 209.09 29.9961 208.547 28.9648 curveto
207.824 27.5938 207.262 25.7227 206.645 22.89839 curveto
206.285 21.2578 204.293 20.6406 203.793 21.2773 curveto
203.254 21.96089 203.359 24.6953 201.484 23.5195 curveto
199.609 22.3438 199.668 20.043 198.492 22.6289 curveto
197.316 25.2148 196.148 23.52339 195.996 23.2461 curveto
195.789 22.8594 195.91 22.02339 195.594 21.83589 curveto
195.234 21.625 194.77 22.35161 194.496 22.4492 curveto
194.199 22.5508 192.313 20.9648 191.469 19.3086 curveto
190.254 16.9258 187.902 21.9961 188.094 22.3555 curveto
188.262 22.668 192.828 29.03911 193.375 29.9688 curveto
193.961 30.9531 194.383 31.2773 194.738 31.3281 curveto
195.09 31.3828 199.434 32.4453 202.77 35.7969 curveto
205.602 38.6406 205.328 39.5313 204.746 40.3086 curveto
204.57 40.53911 204.313 40.71089 203.973 40.8242 curveto
202.277 41.39839 198.367 37.7656 198.008 37.418 curveto
198.82 36.8672 lineto
201.145 39.0195 201.086 38.8398 201.414 39.0547 curveto
202.027 39.4492 203.434 40.2188 203.859 39.8398 curveto
204.332 39.4219 204.133 38.5117 203.395 37.7227 curveto
202.637 36.9102 200.457 34.6914 198.539 33.6289 curveto
197.246 32.91411 192.086 30.3047 196.996 35.0898 curveto
196.996 35.0898 lineto
197.754 35.8281 198.324 36.4063 198.82 36.8672 curveto
198.008 37.418 lineto
197.426 36.8594 193.973 33 193.719 32.4805 curveto
193.469 31.96089 187.438 32.1133 187.438 32.1133 curveto
186.742 31.7617 187.523 31.4883 187.523 31.4883 curveto
187.523 31.4883 190.246 31.1211 191.938 31.21089 curveto
193.402 31.28911 192.551 30.3242 192.336 30.043 curveto
191.074 28.4297 188.891 24.9844 188.09 24.0352 curveto
187.324 23.125 185.883 23.9883 185.48 24.0664 curveto
185.066 24.14839 182.785 24.46089 183.324 22.5586 curveto
184.355 22.9727 lineto
184.406 23.60161 185.063 22.9688 185.816 22.9961 curveto
186.582 23.0273 185.57 22.28911 185.301 22.1719 curveto
185.301 22.1719 lineto
185.043 22.0664 184.324 22.6563 184.355 22.9727 curveto
183.324 22.5586 lineto
183.867 20.6563 185.59 21.5313 186.336 21.3594 curveto
186.563 21.3086 187.09 21.0625 187.219 20.77339 curveto
187.504 20.1328 187.875 19.4219 188.188 18.9375 curveto
188.707 18.1328 190.941 15.9805 192.465 18.9023 curveto
194.141 22.1133 195.313 20.9258 195.434 19.2031 curveto
195.555 17.47661 196.098 18.1289 196.723 18.418 curveto
197.344 18.6992 196.793 19.8906 196.84 21.457 curveto
196.883 23.02339 198.301 20.6758 198.332 20.0469 curveto
198.359 19.5898 199.188 19.52339 200.043 19.8828 curveto
200.895 20.2422 200.051 20.9063 201.219 22.0078 curveto
202.387 23.1055 202.605 20.5898 202.875 19.9805 curveto
203.105 19.4727 204.242 18.5703 204.922 19.875 curveto
205.523 21.0273 206.738 20.6445 206.758 18.9922 curveto
207.621 19.33589 lineto
207.16 20.918 208.277 22.2695 208.277 22.2695 curveto
208.277 22.2695 208.75 22.89839 209.059 22.89839 curveto
208.289 23.2148 lineto
207.918 22.7969 207.566 22.46089 207.852 23.6328 curveto
208.141 24.8242 207.992 24.3281 208.133 24.8398 curveto
208.285 25.4063 208.832 27.3633 209.016 27.77339 curveto
209.281 28.35161 209.348 28.6211 210.059 29.6797 curveto
210.059 29.6797 210.559 30.3086 210.648 30.4023 curveto
211.035 30.793 212.469 31.4805 211.781 28.875 curveto
211.234 26.8086 210.805 26.332 209.871 24.8281 curveto
209.871 24.8281 lineto
209.691 24.53911 209.355 25.1992 208.707 24.3594 curveto
208.438 24.0078 208.617 23.5898 208.289 23.2148 curveto
209.059 22.89839 lineto
209.441 22.89839 210.199 22.7578 209.957 21.83589 curveto
209.957 21.83589 lineto
209.715 20.9102 209.301 19.4414 208.941 18.9844 curveto
208.691 18.668 208.086 17.7578 207.621 19.33589 curveto
206.758 18.9922 lineto
206.77 17.6172 207.773 17.332 208.152 17.3203 curveto
208.289 17.3125 208.445 17.3281 208.66 17.418 curveto
209.414 17.72661 210.609 19.3867 210.594 20.8438 curveto
210.566 23.3164 214.586 23.7148 214.301 22.875 curveto
214.094 22.2695 213.203 20.4883 214.289 20.5273 curveto
215.379 20.5703 214.914 21.5 215.914 22.5703 curveto
216.918 23.6406 216.504 20.9297 216.895 20.4297 curveto
 closepath fill
newpath 203.555 29.7461 moveto
203.438 28.2188 204.375 28.7305 204.375 28.7305 curveto
206.125 29.6563 204.715 30.4688 204.715 30.4688 curveto
204.715 30.4688 203.68 31.27339 203.555 29.7461 curveto
 closepath fill
newpath 228.996 15.5742 moveto
228.906 15.8125 228.668 16.1133 227.957 15.2422 curveto
226.875 13.9102 226.984 14.7148 226.871 15.582 curveto
226.855 15.7266 226.738 16.418 226.246 16.6836 curveto
225.793 16.9219 223.941 17.5352 224.398 17.89839 curveto
225.531 18.78911 225.5 18.7227 225.828 19.0938 curveto
226.23 19.5469 227.543 21.22661 227.434 22.9023 curveto
227.309 24.85161 224.527 24.6289 224.527 24.6289 curveto
222.621 24.33589 223.488 22.6719 224.805 22.8789 curveto
226.262 23.1055 225.918 21.8281 225.824 21.4922 curveto
225.824 21.4922 lineto
225.82 21.4688 225.813 21.4492 225.805 21.4297 curveto
225.824 21.4922 lineto
225.824 21.4922 lineto
225.824 21.4922 225.672 21.08589 225.363 20.5977 curveto
224.949 19.9453 224.324 19.08589 223.941 18.6602 curveto
223.691 18.3789 222.234 17.4336 223.285 16.9336 curveto
225.027 16.10161 226.387 14.082 225.5 13.5313 curveto
224.879 13.1445 219.938 10.8555 218.832 10.3672 curveto
219.359 9.67578 lineto
224.574 12.207 224.809 12.3477 224.809 12.3477 curveto
225.188 12.5 225.91 12.9844 225.445 12.1992 curveto
225.445 12.1992 lineto
225.445 12.1992 223.629 8.38672 223.398 8.03516 curveto
223.125 7.61328 221.707 5.59766 219.59 5.28906 curveto
217.469 4.98047 216.418 5.8125 216.371 6.86328 curveto
216.324 7.86719 217.031 8.54688 219.359 9.67578 curveto
218.832 10.3672 lineto
217.766 9.89453 215.383 9.03516 215.402 6.73438 curveto
215.426 4.25781 218.848 4.27734 219.598 4.40625 curveto
221.762 4.78516 222.91 5.97266 223.723 6.96094 curveto
224.418 7.8086 226.059 11.2461 226.246 11.8555 curveto
226.41 12.3711 227.051 14.293 227.973 14.5508 curveto
229.004 14.8398 229.125 15.2305 228.996 15.5742 curveto
 closepath fill
newpath 223.906 28.9961 moveto
223.445 29.1758 222.086 28.4531 222.516 27.293 curveto
222.953 26.1055 226.027 28.16411 223.906 28.9961 curveto
 closepath fill
newpath 177.633 37.2305 moveto
177.344 38.7383 lineto
176.871 37.2539 lineto
176.668 37.2539 lineto
176.18 38.7383 lineto
175.895 37.2305 lineto
175.578 37.2305 lineto
176.035 39.5781 lineto
176.246 39.5781 lineto
176.77 37.8672 lineto
177.246 39.5781 lineto
177.457 39.5781 lineto
177.949 37.2305 lineto
 closepath fill
newpath 179.742 38.0586 moveto
178.504 38.0586 lineto
178.512 38.2813 lineto
179.461 38.2813 lineto
179.461 38.4023 179.426 38.5039 179.348 38.5898 curveto
179.262 38.6758 179.148 38.7227 179.004 38.7227 curveto
179.004 38.7227 lineto
178.867 38.7227 178.754 38.6797 178.66 38.5898 curveto
178.574 38.5078 178.523 38.4023 178.512 38.2813 curveto
178.504 38.0586 lineto
178.504 37.8594 178.559 37.7031 178.668 37.5977 curveto
178.766 37.5039 178.891 37.457 179.043 37.457 curveto
179.219 37.457 179.363 37.5078 179.48 37.6094 curveto
179.609 37.3867 lineto
179.563 37.3398 179.488 37.3008 179.391 37.2656 curveto
179.27 37.2227 179.133 37.1992 178.984 37.1992 curveto
178.77 37.1992 178.586 37.27339 178.438 37.418 curveto
178.27 37.5781 178.184 37.7969 178.184 38.0703 curveto
178.184 38.35161 178.27 38.5781 178.441 38.75 curveto
178.598 38.9023 178.777 38.9805 178.988 38.9805 curveto
179.234 38.9805 179.426 38.9102 179.563 38.77339 curveto
179.699 38.6406 179.766 38.4648 179.766 38.2461 curveto
179.766 38.1797 179.758 38.1172 179.742 38.0586 curveto
 closepath fill
newpath 182.129 37.2305 moveto
182.129 38.3164 lineto
182.129 38.58589 182.012 38.7227 181.777 38.7227 curveto
181.703 38.7227 181.633 38.6992 181.57 38.6563 curveto
181.508 38.6094 181.461 38.5586 181.438 38.5 curveto
181.438 37.2305 lineto
181.137 37.2305 lineto
181.137 38.4492 lineto
181.137 38.5352 181.102 38.60161 181.039 38.64839 curveto
180.977 38.6992 180.891 38.7227 180.789 38.7227 curveto
180.727 38.7227 180.66 38.6992 180.594 38.6523 curveto
180.523 38.6055 180.477 38.5547 180.445 38.4961 curveto
180.445 37.2305 lineto
180.141 37.2305 lineto
180.141 38.9453 lineto
180.34 38.9453 lineto
180.441 38.75 lineto
180.559 38.9023 180.707 38.9805 180.883 38.9805 curveto
181.129 38.9805 181.301 38.9023 181.398 38.75 curveto
181.434 38.8164 181.496 38.8711 181.59 38.91411 curveto
181.68 38.957 181.777 38.9805 181.875 38.9805 curveto
182.051 38.9805 182.188 38.9258 182.285 38.8203 curveto
182.383 38.7148 182.434 38.5664 182.434 38.3789 curveto
182.434 37.2305 lineto
 closepath fill
newpath 183.18 37.3555 moveto
183.074 37.1992 lineto
182.922 37.1992 lineto
182.922 39.64839 lineto
183.227 39.64839 lineto
183.227 38.8203 lineto
183.355 38.6758 lineto
183.289 38.6406 183.246 38.6133 183.227 38.5898 curveto
183.227 38.5898 lineto
183.227 37.5977 lineto
183.227 37.582 183.262 37.5547 183.34 37.5156 curveto
183.414 37.47661 183.473 37.457 183.512 37.457 curveto
183.719 37.457 183.867 37.5039 183.957 37.6055 curveto
184.047 37.7031 184.094 37.8711 184.094 38.1055 curveto
184.094 38.2969 184.039 38.4492 183.934 38.5586 curveto
183.832 38.668 183.688 38.7227 183.512 38.7227 curveto
183.473 38.7227 183.422 38.707 183.355 38.6758 curveto
183.227 38.8203 lineto
183.254 38.8594 183.309 38.8945 183.387 38.9297 curveto
183.469 38.96089 183.547 38.9805 183.621 38.9805 curveto
183.855 38.9805 184.047 38.89839 184.191 38.7344 curveto
184.34 38.5742 184.41 38.3672 184.41 38.1211 curveto
184.41 37.83589 184.34 37.6094 184.191 37.4453 curveto
184.047 37.2813 183.848 37.1992 183.598 37.1992 curveto
183.516 37.1992 183.438 37.2148 183.359 37.2461 curveto
183.281 37.2773 183.223 37.3125 183.18 37.3555 curveto
 closepath fill
newpath 186.25 38.0586 moveto
185.012 38.0586 lineto
185.02 38.2813 lineto
185.969 38.2813 lineto
185.969 38.4023 185.934 38.5039 185.855 38.5898 curveto
185.77 38.6758 185.656 38.7227 185.512 38.7227 curveto
185.512 38.7227 lineto
185.375 38.7227 185.262 38.6797 185.172 38.5898 curveto
185.082 38.5078 185.031 38.4023 185.02 38.2813 curveto
185.012 38.0586 lineto
185.012 37.8594 185.066 37.7031 185.18 37.5977 curveto
185.273 37.5039 185.398 37.457 185.555 37.457 curveto
185.727 37.457 185.871 37.5078 185.988 37.6094 curveto
186.117 37.3867 lineto
186.07 37.3398 185.996 37.3008 185.898 37.2656 curveto
185.777 37.2227 185.645 37.1992 185.492 37.1992 curveto
185.277 37.1992 185.094 37.27339 184.945 37.418 curveto
184.777 37.5781 184.691 37.7969 184.691 38.0703 curveto
184.691 38.35161 184.777 38.5781 184.949 38.75 curveto
185.105 38.9023 185.285 38.9805 185.496 38.9805 curveto
185.742 38.9805 185.934 38.9102 186.07 38.77339 curveto
186.207 38.6406 186.273 38.4648 186.273 38.2461 curveto
186.273 38.1797 186.266 38.1172 186.25 38.0586 curveto
 closepath fill
newpath 187.582 38.6523 moveto
187.516 38.6992 187.449 38.7227 187.383 38.7227 curveto
187.273 38.7227 187.18 38.6719 187.098 38.5742 curveto
187.02 38.4727 186.977 38.3555 186.977 38.2148 curveto
186.977 37.2305 lineto
186.676 37.2305 lineto
186.676 38.9453 lineto
186.977 38.9453 lineto
186.977 38.6719 lineto
187.09 38.875 187.254 38.9805 187.473 38.9805 curveto
187.527 38.9805 187.605 38.9688 187.707 38.9492 curveto
 closepath fill
newpath 188.688 38.0938 moveto
188.688 38.3594 188.758 38.5703 188.902 38.7344 curveto
189.043 38.89839 189.23 38.9805 189.465 38.9805 curveto
189.465 38.7305 lineto
189.324 38.7305 189.215 38.6719 189.133 38.5625 curveto
189.051 38.4492 189.008 38.293 189.008 38.0938 curveto
189.008 38.0938 lineto
189.008 37.66411 189.16 37.4492 189.465 37.4492 curveto
189.605 37.4492 189.719 37.5039 189.797 37.6211 curveto
189.879 37.7344 189.918 37.8945 189.918 38.0938 curveto
189.918 38.5195 189.77 38.7305 189.465 38.7305 curveto
189.465 38.9805 lineto
189.711 38.9805 189.902 38.9023 190.035 38.7422 curveto
190.172 38.58589 190.238 38.3711 190.238 38.0938 curveto
190.238 37.8164 190.172 37.5977 190.031 37.4375 curveto
189.895 37.2773 189.703 37.1992 189.465 37.1992 curveto
189.219 37.1992 189.031 37.2813 188.895 37.4414 curveto
188.758 37.60161 188.688 37.8203 188.688 38.0938 curveto
 closepath fill
newpath 191.543 39.3789 moveto
191.48 39.39839 191.426 39.4102 191.371 39.4102 curveto
191.277 39.4102 191.203 39.375 191.141 39.3047 curveto
191.082 39.2344 191.051 39.1445 191.051 39.0352 curveto
191.051 39.0078 191.055 38.97661 191.059 38.9453 curveto
191.406 38.9453 lineto
191.406 38.6914 lineto
191.059 38.6914 lineto
191.059 37.2305 lineto
190.754 37.2305 lineto
190.754 38.6914 lineto
190.504 38.6914 lineto
190.504 38.9453 lineto
190.754 38.9453 lineto
190.754 39.16411 190.809 39.33589 190.918 39.46089 curveto
191.023 39.58589 191.168 39.64839 191.344 39.64839 curveto
191.434 39.64839 191.527 39.6328 191.629 39.60161 curveto
 closepath fill
newpath 185.289 6.73828 moveto
185.039 7.53906 lineto
183.676 7.53906 lineto
183.805 7.91797 lineto
184.895 7.91797 lineto
184.375 9.39063 lineto
183.805 7.91797 lineto
183.676 7.53906 lineto
183.402 6.73828 lineto
182.844 6.73828 lineto
184.277 10.3125 lineto
184.52 10.3125 lineto
185.844 6.73828 lineto
 closepath fill
newpath 186.441 6.89063 moveto
186.598 7.3086 lineto
186.848 7.14844 187.051 7.0664 187.203 7.0664 curveto
187.48 7.0664 187.617 7.17969 187.617 7.41016 curveto
187.617 7.57422 187.484 7.71875 187.219 7.83594 curveto
187.012 7.92969 186.871 8 186.801 8.04688 curveto
186.73 8.09375 186.668 8.14844 186.613 8.21094 curveto
186.563 8.27344 186.523 8.33594 186.496 8.40625 curveto
186.473 8.47656 186.457 8.55078 186.457 8.6289 curveto
186.457 8.83594 186.535 8.99219 186.684 9.10938 curveto
186.836 9.22266 187.031 9.28125 187.277 9.28125 curveto
187.461 9.28125 187.691 9.22266 187.973 9.10938 curveto
187.844 8.69922 lineto
187.668 8.83984 187.488 8.91016 187.309 8.91016 curveto
187.203 8.91016 187.113 8.88281 187.039 8.83594 curveto
186.965 8.78516 186.93 8.72266 186.93 8.64453 curveto
186.93 8.48438 187.023 8.36328 187.207 8.28125 curveto
187.527 8.13672 lineto
187.723 8.05078 187.867 7.94922 187.953 7.83594 curveto
188.043 7.72266 188.09 7.57813 188.09 7.41016 curveto
188.09 7.1836 188.012 7.00781 187.852 6.88281 curveto
187.691 6.75781 187.473 6.6914 187.191 6.6914 curveto
186.926 6.6914 186.676 6.75781 186.441 6.89063 curveto
 closepath fill
newpath 188.66 6.89063 moveto
188.816 7.3086 lineto
189.066 7.14844 189.27 7.0664 189.422 7.0664 curveto
189.695 7.0664 189.836 7.17969 189.836 7.41016 curveto
189.836 7.57422 189.703 7.71875 189.434 7.83594 curveto
189.23 7.92969 189.09 8 189.02 8.04688 curveto
188.949 8.09375 188.887 8.14844 188.832 8.21094 curveto
188.781 8.27344 188.742 8.33594 188.715 8.40625 curveto
188.688 8.47656 188.676 8.55078 188.676 8.6289 curveto
188.676 8.83594 188.75 8.99219 188.902 9.10938 curveto
189.055 9.22266 189.25 9.28125 189.492 9.28125 curveto
189.68 9.28125 189.91 9.22266 190.188 9.10938 curveto
190.063 8.69922 lineto
189.883 8.83984 189.707 8.91016 189.527 8.91016 curveto
189.422 8.91016 189.328 8.88281 189.258 8.83594 curveto
189.184 8.78516 189.148 8.72266 189.148 8.64453 curveto
189.148 8.48438 189.238 8.36328 189.422 8.28125 curveto
189.742 8.13672 lineto
189.941 8.05078 190.082 7.94922 190.172 7.83594 curveto
190.262 7.72266 190.309 7.57813 190.309 7.41016 curveto
190.309 7.1836 190.227 7.00781 190.07 6.88281 curveto
189.91 6.75781 189.691 6.6914 189.41 6.6914 curveto
189.145 6.6914 188.895 6.75781 188.66 6.89063 curveto
 closepath fill
newpath 190.867 7.99219 moveto
190.867 8.3789 190.973 8.6875 191.184 8.92578 curveto
191.395 9.16406 191.668 9.28125 192.012 9.28125 curveto
192.012 8.92188 lineto
191.809 8.92188 191.645 8.83984 191.523 8.67188 curveto
191.402 8.50781 191.34 8.28125 191.34 7.99219 curveto
191.34 7.99219 lineto
191.34 7.36719 191.563 7.05469 192.012 7.05469 curveto
192.223 7.05469 192.387 7.13672 192.504 7.30469 curveto
192.621 7.47266 192.684 7.70313 192.684 7.99219 curveto
192.684 8.60938 192.457 8.92188 192.012 8.92188 curveto
192.012 9.28125 lineto
192.375 9.28125 192.652 9.16797 192.855 8.9414 curveto
193.055 8.71094 193.152 8.39844 193.152 7.99219 curveto
193.152 7.58984 193.051 7.27344 192.848 7.04297 curveto
192.641 6.8086 192.363 6.6914 192.012 6.6914 curveto
191.652 6.6914 191.371 6.8086 191.172 7.04297 curveto
190.969 7.28125 190.867 7.59375 190.867 7.99219 curveto
 closepath fill
newpath 195.797 9.03125 moveto
195.574 8.71875 lineto
195.531 8.76563 195.449 8.8086 195.336 8.84766 curveto
195.219 8.88672 195.105 8.91016 194.992 8.91016 curveto
194.75 8.91016 194.555 8.82422 194.414 8.65625 curveto
194.27 8.48828 194.199 8.25781 194.199 7.96484 curveto
194.199 7.67188 194.273 7.44922 194.418 7.29688 curveto
194.566 7.14453 194.766 7.0664 195.027 7.0664 curveto
195.227 7.0664 195.43 7.14453 195.637 7.29688 curveto
195.813 6.92578 lineto
195.57 6.76953 195.273 6.6914 194.918 6.6914 curveto
194.574 6.6914 194.289 6.8086 194.063 7.03516 curveto
193.84 7.26563 193.727 7.57422 193.727 7.96484 curveto
193.727 8.35938 193.844 8.67969 194.078 8.92188 curveto
194.313 9.16016 194.629 9.28125 195.035 9.28125 curveto
195.168 9.28125 195.309 9.2539 195.461 9.19922 curveto
195.613 9.14453 195.727 9.08984 195.797 9.03125 curveto
 closepath fill
newpath 196.938 10.1797 moveto
197.012 10.1797 197.078 10.1523 197.133 10.0977 curveto
197.184 10.043 197.211 9.98047 197.211 9.90625 curveto
197.211 9.82813 197.184 9.76563 197.133 9.71094 curveto
197.078 9.65625 197.012 9.6289 196.938 9.6289 curveto
196.863 9.6289 196.797 9.65625 196.746 9.71094 curveto
196.691 9.76563 196.664 9.82813 196.664 9.90625 curveto
196.664 9.98047 196.691 10.0469 196.742 10.0977 curveto
196.797 10.1523 196.859 10.1797 196.938 10.1797 curveto
 closepath fill
newpath 196.773 6.73828 moveto
196.773 8.86328 lineto
196.43 8.86328 lineto
196.43 9.23438 lineto
197.215 9.23438 lineto
197.215 6.73828 lineto
 closepath fill
newpath 199.57 7.02734 moveto
199.395 6.80469 199.121 6.6914 198.758 6.6914 curveto
198.563 6.6914 198.391 6.76563 198.25 6.90625 curveto
198.105 7.04688 198.031 7.22656 198.031 7.4375 curveto
198.031 7.6914 198.145 7.90234 198.363 8.07813 curveto
198.586 8.2539 198.867 8.33984 199.211 8.33984 curveto
199.305 8.33984 199.41 8.32031 199.527 8.28125 curveto
199.527 7.96484 lineto
199.387 7.9961 199.289 8.01172 199.234 8.01172 curveto
199.012 8.01172 198.828 7.95313 198.688 7.83984 curveto
198.547 7.72266 198.477 7.58984 198.477 7.4336 curveto
198.477 7.17188 198.629 7.04297 198.934 7.04297 curveto
199.156 7.04297 199.355 7.14844 199.527 7.36328 curveto
199.527 7.96484 lineto
199.527 8.28125 lineto
199.527 8.6836 199.348 8.88672 198.988 8.88672 curveto
198.711 8.88672 198.5 8.8125 198.348 8.66016 curveto
198.164 9.03125 lineto
198.246 9.10156 198.363 9.16016 198.512 9.20703 curveto
198.66 9.25781 198.801 9.28125 198.938 9.28125 curveto
199.297 9.28125 199.563 9.19922 199.727 9.03516 curveto
199.891 8.8711 199.969 8.60938 199.969 8.25 curveto
199.969 7.35547 lineto
199.969 7.13672 200.035 6.98828 200.168 6.91797 curveto
200.168 6.69531 lineto
199.988 6.69531 199.852 6.72266 199.762 6.77344 curveto
199.672 6.82422 199.609 6.91016 199.57 7.02734 curveto
 closepath fill
newpath 200.934 8.88672 moveto
200.645 8.88672 lineto
200.645 9.23438 lineto
200.934 9.23438 lineto
200.934 9.75781 lineto
201.375 9.92578 lineto
201.375 9.23438 lineto
202.059 9.23438 lineto
202.059 8.88672 lineto
201.375 8.88672 lineto
201.375 7.64453 lineto
201.375 7.4375 201.41 7.28906 201.48 7.19922 curveto
201.551 7.10938 201.664 7.0664 201.824 7.0664 curveto
201.938 7.0664 202.055 7.09375 202.176 7.15234 curveto
202.238 6.76172 lineto
202.055 6.71484 201.855 6.6914 201.637 6.6914 curveto
201.438 6.6914 201.273 6.76563 201.137 6.91406 curveto
201 7.0586 200.934 7.2461 200.934 7.46875 curveto
 closepath fill
newpath 203.313 10.1797 moveto
203.387 10.1797 203.453 10.1523 203.504 10.0977 curveto
203.559 10.043 203.586 9.98047 203.586 9.90625 curveto
203.586 9.82813 203.559 9.76563 203.504 9.71094 curveto
203.453 9.65625 203.387 9.6289 203.313 9.6289 curveto
203.238 9.6289 203.172 9.65625 203.117 9.71094 curveto
203.066 9.76563 203.039 9.82813 203.039 9.90625 curveto
203.039 9.98047 203.066 10.0469 203.117 10.0977 curveto
203.172 10.1523 203.234 10.1797 203.313 10.1797 curveto
 closepath fill
newpath 203.145 6.73828 moveto
203.145 8.86328 lineto
202.801 8.86328 lineto
202.801 9.23438 lineto
203.586 9.23438 lineto
203.586 6.73828 lineto
 closepath fill
newpath 204.34 7.99219 moveto
204.34 8.3789 204.449 8.6875 204.664 8.92578 curveto
204.875 9.16406 205.16 9.28125 205.508 9.28125 curveto
205.508 8.92188 lineto
205.301 8.92188 205.133 8.83984 205.008 8.67188 curveto
204.887 8.50781 204.824 8.28125 204.824 7.99219 curveto
204.824 7.99219 lineto
204.824 7.36719 205.051 7.05469 205.508 7.05469 curveto
205.723 7.05469 205.891 7.13672 206.012 7.30469 curveto
206.133 7.47266 206.191 7.70313 206.191 7.99219 curveto
206.191 8.60938 205.965 8.92188 205.508 8.92188 curveto
205.508 9.28125 lineto
205.879 9.28125 206.164 9.16797 206.367 8.9414 curveto
206.574 8.71094 206.676 8.39844 206.676 7.99219 curveto
206.676 7.58984 206.57 7.27344 206.363 7.04297 curveto
206.152 6.8086 205.867 6.6914 205.508 6.6914 curveto
205.141 6.6914 204.855 6.8086 204.648 7.04297 curveto
204.445 7.28125 204.34 7.59375 204.34 7.99219 curveto
 closepath fill
newpath 208.84 6.73828 moveto
208.84 8.1914 lineto
208.84 8.45703 208.801 8.64453 208.723 8.75 curveto
208.641 8.85547 208.508 8.91016 208.32 8.91016 curveto
208.219 8.91016 208.113 8.8789 208.004 8.8164 curveto
207.891 8.75781 207.809 8.6836 207.75 8.59375 curveto
207.75 6.73828 lineto
207.305 6.73828 lineto
207.305 9.23438 lineto
207.609 9.23438 lineto
207.75 8.91406 lineto
207.895 9.16016 208.133 9.28125 208.465 9.28125 curveto
209.012 9.28125 209.285 8.94922 209.285 8.28516 curveto
209.285 6.73828 lineto
 closepath fill
showpage
%%EOF
}

\snapshot@savemps\snapshot@logo@de{
%!PS-Adobe-3.0 EPSF-3.0
%%BoundingBox: 0 4 516 43
%%HiResBoundingBox: 0.48376 4.70842 515.10199 42.47836
%%Creator: MetaPost 1.803
%%CreationDate: 2017.05.22:1447
%%Pages: 1
%%BeginProlog
%%EndProlog
%%Page: 1 1
 0 0 0 setrgbcolor 0 2.46121 dtransform truncate idtransform setlinewidth pop
 [] 0 setdash 0 setlinecap 0 setlinejoin 10 setmiterlimit
newpath 11.5586 6.78906 moveto
28.6133 6.78906 lineto
34.0469 6.78906 38.457 11.1992 38.457 16.6367 curveto
38.457 22.0703 34.0469 26.4805 28.6133 26.4805 curveto
20.08589 26.4805 lineto
11.5586 26.4805 lineto
28.6133 26.4805 lineto stroke
newpath 37.1367 21.5586 moveto
28.6133 36.3242 lineto
25.8945 41.0313 19.8711 42.6445 15.1641 39.9297 curveto
10.457 37.21089 8.84375 31.1875 11.5586 26.4805 curveto
11.5586 26.4805 lineto
15.8242 19.0938 lineto
20.08589 11.7109 lineto
11.5586 26.4805 lineto stroke
newpath 11.5586 36.3242 moveto
3.03516 21.5586 lineto
0.3164 16.85161 1.92969 10.8242 6.63672 8.10938 curveto
11.3438 5.39063 17.3672 7.00781 20.08589 11.7109 curveto
24.3477 19.0938 lineto
20.08589 11.7109 lineto
28.6133 26.4805 lineto stroke
newpath 54.457 33.83589 moveto
53.5078 33.83589 lineto
53.5078 40.0039 lineto
51.5156 35.8086 lineto
50.9492 35.8086 lineto
48.9727 40.0039 lineto
48.9727 33.83589 lineto
48.08589 33.83589 lineto
48.08589 40.9961 lineto
49.3828 40.9961 lineto
51.28911 37.0117 lineto
53.1367 40.9961 lineto
54.457 40.9961 lineto
 closepath fill
newpath 60.4805 33.83589 moveto
59.582 33.83589 lineto
59.582 34.4102 lineto
59.5039 34.3555 59.3945 34.2773 59.2578 34.1797 curveto
58.85161 34.7148 lineto
59.1133 34.8398 59.3594 34.9883 59.582 35.1602 curveto
59.582 35.1602 lineto
59.582 36.6563 lineto
59.3047 36.6367 58.9805 36.6133 58.6094 36.582 curveto
58.2344 36.5508 57.9414 36.5039 57.7227 36.4414 curveto
57.46089 36.3711 57.2539 36.2539 57.0938 36.0977 curveto
56.9336 35.9453 56.85161 35.7305 56.85161 35.457 curveto
56.85161 35.14839 56.9453 34.918 57.1328 34.7617 curveto
57.3164 34.6094 57.60161 34.5313 57.9805 34.5313 curveto
58.2969 34.5313 58.5898 34.5898 58.85161 34.7148 curveto
59.2578 34.1797 lineto
59.1211 34.082 58.9883 34.0078 58.8594 33.9492 curveto
58.71089 33.875 58.53911 33.8125 58.3438 33.7617 curveto
58.14839 33.7148 57.918 33.6875 57.6563 33.6875 curveto
57.1719 33.6875 56.7617 33.8477 56.4258 34.168 curveto
56.08589 34.4883 55.918 34.89839 55.918 35.3945 curveto
55.918 35.8008 56.0078 36.1328 56.1797 36.3828 curveto
56.3555 36.6328 56.6055 36.832 56.9297 36.97661 curveto
57.2578 37.1211 57.64839 37.2188 58.1055 37.2695 curveto
58.5664 37.3203 59.0547 37.3594 59.582 37.3867 curveto
59.582 37.52339 lineto
59.582 37.7305 59.5469 37.89839 59.4727 38.0352 curveto
59.4023 38.168 59.2969 38.27339 59.16411 38.35161 curveto
59.0352 38.4258 58.8828 38.47661 58.7031 38.5 curveto
58.52339 38.5273 58.33589 38.53911 58.1406 38.53911 curveto
57.9023 38.53911 57.6406 38.5078 57.3477 38.4453 curveto
57.0547 38.3828 56.7539 38.293 56.4453 38.1719 curveto
56.3945 38.1719 lineto
56.3945 39.0898 lineto
56.5703 39.1406 56.8281 39.1914 57.1602 39.25 curveto
57.4922 39.3086 57.8203 39.33589 58.1445 39.33589 curveto
58.52339 39.33589 58.85161 39.3047 59.1328 39.2422 curveto
59.41411 39.1797 59.6563 39.0742 59.8594 38.9219 curveto
60.0625 38.7773 60.2188 38.58589 60.3242 38.35161 curveto
60.4297 38.1172 60.4805 37.8281 60.4805 37.4805 curveto
 closepath fill
newpath 65.0078 33.8867 moveto
64.8398 33.8398 64.6563 33.8047 64.4531 33.77339 curveto
64.2539 33.7461 64.0742 33.7305 63.918 33.7305 curveto
63.3711 33.7305 62.9531 33.8789 62.668 34.1758 curveto
62.3828 34.4688 62.2422 34.9414 62.2422 35.5938 curveto
62.2422 38.4492 lineto
61.6289 38.4492 lineto
61.6289 39.207 lineto
62.2422 39.207 lineto
62.2422 40.75 lineto
63.1445 40.75 lineto
63.1445 39.207 lineto
65.0078 39.207 lineto
65.0078 38.4492 lineto
63.1445 38.4492 lineto
63.1445 36 lineto
63.1445 35.7188 63.1523 35.5 63.16411 35.3398 curveto
63.1758 35.1797 63.2227 35.0313 63.2969 34.8945 curveto
63.3672 34.7656 63.4648 34.6719 63.5898 34.6133 curveto
63.71089 34.5547 63.9023 34.52339 64.1523 34.52339 curveto
64.3008 34.52339 64.457 34.5469 64.6133 34.5898 curveto
64.7773 34.6328 64.8906 34.668 64.96089 34.6992 curveto
65.0078 34.6992 lineto
 closepath fill
newpath 70.5898 33.83589 moveto
69.6875 33.83589 lineto
69.6875 36.8945 lineto
69.6875 37.1406 69.6719 37.375 69.6445 37.5898 curveto
69.6133 37.8047 69.5625 37.97661 69.4844 38.0977 curveto
69.4063 38.2305 69.28911 38.332 69.1406 38.39839 curveto
68.9883 38.46089 68.793 38.4961 68.5508 38.4961 curveto
68.3047 38.4961 68.0469 38.4336 67.7773 38.3125 curveto
67.5078 38.1914 67.25 38.0352 67.0039 37.8477 curveto
67.0039 33.83589 lineto
66.10161 33.83589 lineto
66.10161 41.3164 lineto
67.0039 41.3164 lineto
67.0039 38.6094 lineto
67.2852 38.8438 67.5781 39.0273 67.8789 39.1602 curveto
68.1797 39.28911 68.4883 39.3555 68.8086 39.3555 curveto
69.3867 39.3555 69.8281 39.1797 70.1328 38.832 curveto
70.4375 38.4844 70.5898 37.9805 70.5898 37.3242 curveto
 closepath fill
newpath 76.8242 36.4297 moveto
72.8672 36.4297 lineto
72.8672 37.1211 lineto
75.9453 37.1211 lineto
75.9414 37.5938 75.8242 37.96089 75.58589 38.2227 curveto
75.35161 38.4805 74.9922 38.6094 74.5117 38.6094 curveto
74.0313 38.6094 73.6445 38.4688 73.3555 38.1836 curveto
73.0703 37.89839 72.9063 37.543 72.8672 37.1211 curveto
72.8672 36.4297 lineto
72.8672 36.0977 72.918 35.8125 73.0195 35.5664 curveto
73.1172 35.3203 73.2539 35.1211 73.4258 34.96089 curveto
73.5938 34.8086 73.78911 34.6914 74.0195 34.6172 curveto
74.25 34.53911 74.5039 34.5 74.7773 34.5 curveto
75.1445 34.5 75.5117 34.5742 75.8828 34.7188 curveto
76.25 34.8672 76.5156 35.0078 76.6719 35.14839 curveto
76.7188 35.14839 lineto
76.7188 34.16411 lineto
76.41411 34.0352 76.1055 33.9297 75.7852 33.8438 curveto
75.4688 33.7578 75.1367 33.71089 74.7852 33.71089 curveto
73.8945 33.71089 73.1992 33.9531 72.6992 34.4375 curveto
72.1992 34.918 71.9531 35.60161 71.9531 36.4922 curveto
71.9531 37.3711 72.1914 38.0664 72.668 38.582 curveto
73.14839 39.0977 73.7813 39.3555 74.5625 39.3555 curveto
75.2852 39.3555 75.8438 39.1445 76.2344 38.7227 curveto
76.6289 38.2969 76.8242 37.6992 76.8242 36.918 curveto
 closepath fill
newpath 86.0313 33.83589 moveto
85.1289 33.83589 lineto
85.1289 36.8945 lineto
85.1289 37.125 85.1172 37.3477 85.0977 37.5625 curveto
85.0742 37.7773 85.0313 37.9492 84.9648 38.0781 curveto
84.8906 38.2148 84.7852 38.3203 84.64839 38.3906 curveto
84.5078 38.46089 84.3086 38.4961 84.0508 38.4961 curveto
83.7969 38.4961 83.543 38.4336 83.28911 38.3047 curveto
83.03911 38.1797 82.7852 38.0195 82.5313 37.8242 curveto
82.53911 37.75 82.5469 37.66411 82.5547 37.5664 curveto
82.5625 37.4688 82.5664 37.3711 82.5664 37.27339 curveto
82.5664 33.83589 lineto
81.6602 33.83589 lineto
81.6602 36.8945 lineto
81.6602 37.1328 81.6523 37.3555 81.6289 37.5703 curveto
81.6094 37.7852 81.5664 37.9531 81.4961 38.082 curveto
81.4258 38.2188 81.3203 38.3242 81.1797 38.3906 curveto
81.043 38.46089 80.8438 38.4961 80.58589 38.4961 curveto
80.3398 38.4961 80.0898 38.4336 79.8438 38.3125 curveto
79.5938 38.1914 79.3477 38.0352 79.0977 37.8477 curveto
79.0977 33.83589 lineto
78.1953 33.83589 lineto
78.1953 39.207 lineto
79.0977 39.207 lineto
79.0977 38.6094 lineto
79.3828 38.8438 79.66411 39.0273 79.9414 39.1602 curveto
80.2227 39.28911 80.52339 39.3555 80.8398 39.3555 curveto
81.2031 39.3555 81.5156 39.2773 81.7695 39.125 curveto
82.02339 38.9727 82.2148 38.7578 82.3398 38.4844 curveto
82.7031 38.793 83.03911 39.0156 83.3398 39.1523 curveto
83.6406 39.28911 83.96089 39.3555 84.3047 39.3555 curveto
84.8945 39.3555 85.332 39.1758 85.6094 38.8203 curveto
85.8906 38.46089 86.0313 37.9648 86.0313 37.3242 curveto
 closepath fill
newpath 91.9453 33.83589 moveto
91.043 33.83589 lineto
91.043 34.4102 lineto
90.9648 34.3555 90.8555 34.2773 90.7188 34.1797 curveto
90.3125 34.7148 lineto
90.5781 34.8398 90.8203 34.9883 91.043 35.1602 curveto
91.043 35.1602 lineto
91.043 36.6563 lineto
90.7695 36.6367 90.4453 36.6133 90.0703 36.582 curveto
89.6992 36.5508 89.4023 36.5039 89.1836 36.4414 curveto
88.9258 36.3711 88.7148 36.2539 88.5547 36.0977 curveto
88.3945 35.9453 88.3125 35.7305 88.3125 35.457 curveto
88.3125 35.14839 88.4063 34.918 88.5938 34.7617 curveto
88.7773 34.6094 89.0625 34.5313 89.4453 34.5313 curveto
89.7617 34.5313 90.0508 34.5898 90.3125 34.7148 curveto
90.7188 34.1797 lineto
90.582 34.082 90.4531 34.0078 90.3242 33.9492 curveto
90.1719 33.875 90 33.8125 89.8047 33.7617 curveto
89.6094 33.7148 89.3789 33.6875 89.1172 33.6875 curveto
88.6328 33.6875 88.2227 33.8477 87.8867 34.168 curveto
87.5508 34.4883 87.3828 34.89839 87.3828 35.3945 curveto
87.3828 35.8008 87.4688 36.1328 87.6445 36.3828 curveto
87.8164 36.6328 88.0664 36.832 88.3906 36.97661 curveto
88.7188 37.1211 89.1094 37.2188 89.5703 37.2695 curveto
90.0273 37.3203 90.5195 37.3594 91.043 37.3867 curveto
91.043 37.52339 lineto
91.043 37.7305 91.0078 37.89839 90.9375 38.0352 curveto
90.8633 38.168 90.7617 38.27339 90.625 38.35161 curveto
90.4961 38.4258 90.3438 38.47661 90.16411 38.5 curveto
89.9844 38.5273 89.7969 38.53911 89.60161 38.53911 curveto
89.3633 38.53911 89.10161 38.5078 88.8086 38.4453 curveto
88.5156 38.3828 88.2148 38.293 87.9063 38.1719 curveto
87.8555 38.1719 lineto
87.8555 39.0898 lineto
88.0352 39.1406 88.28911 39.1914 88.6211 39.25 curveto
88.9531 39.3086 89.2852 39.33589 89.6055 39.33589 curveto
89.9844 39.33589 90.3164 39.3047 90.5938 39.2422 curveto
90.875 39.1797 91.1172 39.0742 91.3242 38.9219 curveto
91.52339 38.7773 91.6797 38.58589 91.7852 38.35161 curveto
91.8906 38.1172 91.9453 37.8281 91.9453 37.4805 curveto
 closepath fill
newpath 96.4727 33.8867 moveto
96.3008 33.8398 96.1172 33.8047 95.918 33.77339 curveto
95.7148 33.7461 95.53911 33.7305 95.3828 33.7305 curveto
94.832 33.7305 94.41411 33.8789 94.1328 34.1758 curveto
93.8477 34.4688 93.7031 34.9414 93.7031 35.5938 curveto
93.7031 38.4492 lineto
93.0938 38.4492 lineto
93.0938 39.207 lineto
93.7031 39.207 lineto
93.7031 40.75 lineto
94.6055 40.75 lineto
94.6055 39.207 lineto
96.4727 39.207 lineto
96.4727 38.4492 lineto
94.6055 38.4492 lineto
94.6055 36 lineto
94.6055 35.7188 94.6133 35.5 94.625 35.3398 curveto
94.6406 35.1797 94.6836 35.0313 94.7617 34.8945 curveto
94.832 34.7656 94.9258 34.6719 95.0508 34.6133 curveto
95.1758 34.5547 95.3633 34.52339 95.6172 34.52339 curveto
95.7656 34.52339 95.918 34.5469 96.0781 34.5898 curveto
96.2383 34.6328 96.35161 34.668 96.4219 34.6992 curveto
96.4727 34.6992 lineto
 closepath fill
newpath 98.47661 33.83589 moveto
97.5742 33.83589 lineto
97.5742 39.207 lineto
98.47661 39.207 lineto
 closepath fill
newpath 98.5352 40.1055 moveto
97.5156 40.1055 lineto
97.5156 41.043 lineto
98.5352 41.043 lineto
 closepath fill
newpath 104.10199 35.3867 moveto
104.10199 34.8945 103.89801 34.4922 103.492 34.1797 curveto
103.086 33.8633 102.53099 33.707 101.832 33.707 curveto
101.43399 33.707 101.07 33.7539 100.738 33.85161 curveto
100.40599 33.9453 100.129 34.0469 99.9023 34.1602 curveto
99.9023 35.1758 lineto
99.9531 35.1758 lineto
100.238 34.96089 100.555 34.78911 100.902 34.6602 curveto
101.254 34.5352 101.59 34.4727 101.90599 34.4727 curveto
102.305 34.4727 102.617 34.5352 102.84 34.66411 curveto
103.06601 34.793 103.17601 34.9961 103.17601 35.2695 curveto
103.17601 35.4805 103.117 35.6406 102.996 35.75 curveto
102.871 35.8594 102.641 35.9531 102.293 36.0313 curveto
102.164 36.0586 101.996 36.0938 101.789 36.1289 curveto
101.586 36.168 101.395 36.21089 101.22699 36.2539 curveto
100.754 36.3789 100.422 36.5625 100.223 36.8047 curveto
100.027 37.0469 99.9258 37.3438 99.9258 37.6992 curveto
99.9258 37.918 99.9727 38.1289 100.06601 38.3242 curveto
100.15599 38.5195 100.297 38.6914 100.48 38.8477 curveto
100.66 38.9961 100.887 39.1172 101.164 39.2031 curveto
101.44101 39.293 101.754 39.33589 102.098 39.33589 curveto
102.414 39.33589 102.742 39.2969 103.07 39.2188 curveto
103.39801 39.1406 103.672 39.0469 103.891 38.9336 curveto
103.891 37.9688 lineto
103.84 37.9688 lineto
103.609 38.1367 103.328 38.2813 103 38.39839 curveto
102.668 38.5156 102.348 38.5742 102.027 38.5742 curveto
101.69899 38.5742 101.418 38.5078 101.19101 38.3828 curveto
100.965 38.2578 100.85199 38.0664 100.85199 37.8164 curveto
100.85199 37.5977 100.918 37.4297 101.05899 37.3164 curveto
101.19101 37.207 101.41 37.1133 101.711 37.043 curveto
101.879 37.0039 102.063 36.9688 102.27 36.9297 curveto
102.47699 36.8906 102.64801 36.8555 102.789 36.8242 curveto
103.207 36.72661 103.53099 36.5625 103.758 36.3281 curveto
103.984 36.0898 104.10199 35.7773 104.10199 35.3867 curveto
 closepath fill
newpath 109.363 34.1758 moveto
109.063 34.0313 108.777 33.918 108.508 33.83589 curveto
108.234 33.7578 107.94899 33.7188 107.645 33.7188 curveto
107.254 33.7188 106.89801 33.77339 106.57399 33.8867 curveto
106.254 34 105.97699 34.1758 105.746 34.4063 curveto
105.512 34.6367 105.328 34.9258 105.19899 35.2813 curveto
105.07399 35.6328 105.008 36.043 105.008 36.5156 curveto
105.008 37.3945 105.25 38.082 105.73 38.582 curveto
106.215 39.082 106.85199 39.332 107.645 39.332 curveto
107.94899 39.332 108.254 39.28911 108.55101 39.2031 curveto
108.848 39.1172 109.117 39.0117 109.363 38.8867 curveto
109.363 37.8789 lineto
109.31601 37.8789 lineto
109.039 38.0938 108.758 38.2617 108.465 38.375 curveto
108.172 38.4922 107.883 38.5469 107.605 38.5469 curveto
107.09401 38.5469 106.688 38.375 106.391 38.0313 curveto
106.09401 37.6875 105.945 37.1836 105.945 36.5156 curveto
105.945 35.8672 106.09 35.3711 106.383 35.02339 curveto
106.672 34.6758 107.078 34.5 107.605 34.5 curveto
107.789 34.5 107.973 34.52339 108.164 34.5742 curveto
108.35199 34.6211 108.52 34.6836 108.672 34.7617 curveto
108.805 34.8281 108.92601 34.89839 109.043 34.9727 curveto
109.15599 35.0508 109.25 35.1133 109.31601 35.168 curveto
109.363 35.168 lineto
 closepath fill
newpath 115.012 33.83589 moveto
114.109 33.83589 lineto
114.109 36.8945 lineto
114.109 37.1406 114.09401 37.375 114.06601 37.5898 curveto
114.035 37.8047 113.984 37.97661 113.90599 38.0977 curveto
113.828 38.2305 113.711 38.332 113.563 38.39839 curveto
113.41 38.46089 113.215 38.4961 112.973 38.4961 curveto
112.72699 38.4961 112.46901 38.4336 112.19899 38.3125 curveto
111.93 38.1914 111.672 38.0352 111.42601 37.8477 curveto
111.42601 33.83589 lineto
110.52301 33.83589 lineto
110.52301 41.3164 lineto
111.42601 41.3164 lineto
111.42601 38.6094 lineto
111.707 38.8438 112 39.0273 112.30101 39.1602 curveto
112.60199 39.28911 112.91 39.3555 113.23 39.3555 curveto
113.80899 39.3555 114.25 39.1797 114.555 38.832 curveto
114.859 38.4844 115.012 37.9805 115.012 37.3242 curveto
 closepath fill
newpath 121.246 36.4297 moveto
117.289 36.4297 lineto
117.289 37.1211 lineto
120.367 37.1211 lineto
120.363 37.5938 120.246 37.96089 120.008 38.2227 curveto
119.77301 38.4805 119.414 38.6094 118.93399 38.6094 curveto
118.44899 38.6094 118.06601 38.4688 117.777 38.1836 curveto
117.492 37.89839 117.328 37.543 117.289 37.1211 curveto
117.289 36.4297 lineto
117.289 36.0977 117.34 35.8125 117.44101 35.5664 curveto
117.539 35.3203 117.67601 35.1211 117.848 34.96089 curveto
118.016 34.8086 118.215 34.6914 118.44101 34.6172 curveto
118.672 34.53911 118.92601 34.5 119.19899 34.5 curveto
119.56601 34.5 119.93399 34.5742 120.305 34.7188 curveto
120.672 34.8672 120.938 35.0078 121.09401 35.14839 curveto
121.141 35.14839 lineto
121.141 34.16411 lineto
120.836 34.0352 120.527 33.9297 120.211 33.8438 curveto
119.891 33.7578 119.55899 33.71089 119.211 33.71089 curveto
118.31601 33.71089 117.621 33.9531 117.121 34.4375 curveto
116.621 34.918 116.371 35.60161 116.371 36.4922 curveto
116.371 37.3711 116.613 38.0664 117.09 38.582 curveto
117.57 39.0977 118.19899 39.3555 118.984 39.3555 curveto
119.707 39.3555 120.266 39.1445 120.65599 38.7227 curveto
121.05101 38.2969 121.246 37.6992 121.246 36.918 curveto
 closepath fill
newpath 126.453 35.3867 moveto
126.453 34.8945 126.25 34.4922 125.84401 34.1797 curveto
125.438 33.8633 124.887 33.707 124.18399 33.707 curveto
123.785 33.707 123.422 33.7539 123.09 33.85161 curveto
122.758 33.9453 122.48 34.0469 122.258 34.1602 curveto
122.258 35.1758 lineto
122.305 35.1758 lineto
122.59 34.96089 122.90599 34.78911 123.258 34.6602 curveto
123.605 34.5352 123.94101 34.4727 124.262 34.4727 curveto
124.65599 34.4727 124.96901 34.5352 125.19101 34.66411 curveto
125.418 34.793 125.53099 34.9961 125.53099 35.2695 curveto
125.53099 35.4805 125.46901 35.6406 125.348 35.75 curveto
125.22699 35.8594 124.992 35.9531 124.645 36.0313 curveto
124.516 36.0586 124.35199 36.0938 124.145 36.1289 curveto
123.938 36.168 123.746 36.21089 123.578 36.2539 curveto
123.105 36.3789 122.77301 36.5625 122.57399 36.8047 curveto
122.379 37.0469 122.28099 37.3438 122.28099 37.6992 curveto
122.28099 37.918 122.32399 38.1289 122.418 38.3242 curveto
122.508 38.5195 122.64801 38.6914 122.832 38.8477 curveto
123.012 38.9961 123.242 39.1172 123.52 39.2031 curveto
123.797 39.293 124.105 39.33589 124.44899 39.33589 curveto
124.77 39.33589 125.09401 39.2969 125.422 39.2188 curveto
125.75 39.1406 126.02301 39.0469 126.242 38.9336 curveto
126.242 37.9688 lineto
126.19101 37.9688 lineto
125.961 38.1367 125.68399 38.2813 125.35199 38.39839 curveto
125.02301 38.5156 124.69899 38.5742 124.383 38.5742 curveto
124.05101 38.5742 123.77301 38.5078 123.543 38.3828 curveto
123.31601 38.2578 123.203 38.0664 123.203 37.8164 curveto
123.203 37.5977 123.27301 37.4297 123.41 37.3164 curveto
123.543 37.207 123.762 37.1133 124.063 37.043 curveto
124.23 37.0039 124.418 36.9688 124.625 36.9297 curveto
124.832 36.8906 125.004 36.8555 125.141 36.8242 curveto
125.563 36.72661 125.883 36.5625 126.109 36.3281 curveto
126.34 36.0898 126.453 35.7773 126.453 35.3867 curveto
 closepath fill
newpath 52.6563 26.7813 moveto
49.0352 26.7813 lineto
49.0352 24.7617 lineto
52.1445 24.7617 lineto
52.1445 23.918 lineto
49.0352 23.918 lineto
49.0352 20.4688 lineto
48.08589 20.4688 lineto
48.08589 27.6289 lineto
52.6563 27.6289 lineto
 closepath fill
newpath 58.0117 23.1523 moveto
58.0117 22.2773 57.7852 21.58589 57.33589 21.082 curveto
56.8867 20.5742 56.2852 20.3203 55.5352 20.3203 curveto
54.77339 20.3203 54.1719 20.5742 53.7227 21.082 curveto
53.2773 21.58589 53.0547 22.2773 53.0547 23.1523 curveto
53.0547 24.0273 53.2773 24.7188 53.7227 25.22661 curveto
54.1719 25.7344 54.77339 25.9883 55.5352 25.9883 curveto
55.5352 25.21089 lineto
55.043 25.21089 54.66411 25.043 54.3906 24.7031 curveto
54.1211 24.3633 53.9844 23.8477 53.9844 23.1523 curveto
53.9844 22.4805 54.1211 21.9688 54.3945 21.6211 curveto
54.668 21.27339 55.0469 21.10161 55.5352 21.10161 curveto
56.0156 21.10161 56.3906 21.27339 56.66411 21.6172 curveto
56.9414 21.96089 57.0781 22.4727 57.0781 23.1523 curveto
57.0781 23.1523 lineto
57.0781 23.8477 56.9414 24.3633 56.668 24.7031 curveto
56.3945 25.043 56.0195 25.21089 55.5352 25.21089 curveto
55.5352 25.9883 lineto
56.2852 25.9883 56.8867 25.7344 57.33589 25.22661 curveto
57.7852 24.7188 58.0117 24.0273 58.0117 23.1523 curveto
 closepath fill
newpath 62.7617 24.8555 moveto
62.7148 24.8555 lineto
62.5781 24.8867 62.4492 24.9102 62.3203 24.9258 curveto
62.1953 24.9375 62.043 24.9453 61.8711 24.9453 curveto
61.5938 24.9453 61.3242 24.8828 61.0625 24.7617 curveto
60.8047 24.6367 60.5547 24.47661 60.3125 24.2813 curveto
60.3125 20.4688 lineto
59.4102 20.4688 lineto
59.4102 25.8398 lineto
60.3125 25.8398 lineto
60.3125 25.0469 lineto
60.6719 25.33589 60.9883 25.53911 61.2617 25.6602 curveto
61.53911 25.7813 61.8164 25.8398 62.10161 25.8398 curveto
62.2578 25.8398 62.3711 25.83589 62.4453 25.8281 curveto
62.5156 25.8203 62.6211 25.8047 62.7617 25.7813 curveto
 closepath fill
newpath 67.4492 22.0195 moveto
67.4492 21.5273 67.2461 21.125 66.8398 20.8125 curveto
66.4336 20.4961 65.8789 20.3398 65.1797 20.3398 curveto
64.7813 20.3398 64.418 20.3867 64.08589 20.4805 curveto
63.7539 20.5781 63.47661 20.6797 63.25 20.793 curveto
63.25 21.8047 lineto
63.2969 21.8047 lineto
63.58589 21.5898 63.9023 21.4219 64.25 21.293 curveto
64.60161 21.168 64.9336 21.1055 65.2539 21.1055 curveto
65.6523 21.1055 65.9648 21.168 66.1875 21.2969 curveto
66.4102 21.4258 66.52339 21.625 66.52339 21.9023 curveto
66.52339 22.1133 66.4648 22.27339 66.3438 22.3828 curveto
66.2188 22.4922 65.9844 22.58589 65.6406 22.66411 curveto
65.5117 22.6914 65.3438 22.72661 65.1367 22.7617 curveto
64.9297 22.8008 64.7422 22.8438 64.5742 22.8867 curveto
64.10161 23.0117 63.7695 23.1992 63.5703 23.4375 curveto
63.375 23.6797 63.27339 23.97661 63.27339 24.332 curveto
63.27339 24.5508 63.3203 24.7617 63.4102 24.957 curveto
63.5039 25.1523 63.6406 25.3242 63.8281 25.4805 curveto
64.0078 25.6289 64.2344 25.75 64.5117 25.83589 curveto
64.78911 25.9258 65.10161 25.9688 65.4414 25.9688 curveto
65.7617 25.9688 66.0898 25.9297 66.418 25.85161 curveto
66.7461 25.77339 67.0195 25.6797 67.2344 25.5664 curveto
67.2344 24.60161 lineto
67.1875 24.60161 lineto
66.957 24.7695 66.6758 24.91411 66.3477 25.0313 curveto
66.0156 25.14839 65.6914 25.207 65.375 25.207 curveto
65.0469 25.207 64.7656 25.1406 64.53911 25.0156 curveto
64.3125 24.8906 64.1992 24.6992 64.1992 24.4492 curveto
64.1992 24.2305 64.2656 24.0625 64.4063 23.9492 curveto
64.53911 23.8398 64.7578 23.7461 65.0586 23.6758 curveto
65.22661 23.6367 65.4102 23.60161 65.6172 23.5625 curveto
65.8242 23.52339 65.9961 23.4883 66.1367 23.457 curveto
66.5547 23.3594 66.8789 23.1953 67.1055 22.96089 curveto
67.332 22.7227 67.4492 22.4102 67.4492 22.0195 curveto
 closepath fill
newpath 72.71089 20.8047 moveto
72.4102 20.66411 72.125 20.5508 71.85161 20.4688 curveto
71.582 20.3906 71.293 20.35161 70.9922 20.35161 curveto
70.60161 20.35161 70.2461 20.4063 69.9219 20.5195 curveto
69.5977 20.6367 69.3242 20.8047 69.0938 21.03911 curveto
68.8594 21.2695 68.6758 21.5586 68.5469 21.9102 curveto
68.4219 22.2656 68.3555 22.6758 68.3555 23.14839 curveto
68.3555 24.0273 68.5977 24.7148 69.0781 25.2148 curveto
69.5625 25.7148 70.1992 25.9648 70.9922 25.9648 curveto
71.2969 25.9648 71.60161 25.9219 71.89839 25.83589 curveto
72.1914 25.75 72.4648 25.6445 72.71089 25.5195 curveto
72.71089 24.5117 lineto
72.66411 24.5117 lineto
72.3867 24.72661 72.10161 24.8945 71.8086 25.0078 curveto
71.5156 25.125 71.2305 25.1797 70.9531 25.1797 curveto
70.4414 25.1797 70.0352 25.0078 69.7383 24.66411 curveto
69.4414 24.3203 69.293 23.8164 69.293 23.14839 curveto
69.293 22.5 69.4375 22.0039 69.72661 21.6563 curveto
70.0195 21.3086 70.4258 21.1367 70.9531 21.1367 curveto
71.1367 21.1367 71.3203 21.1563 71.5117 21.207 curveto
71.6992 21.2539 71.8672 21.3164 72.0195 21.3945 curveto
72.1523 21.46089 72.27339 21.5313 72.3906 21.6055 curveto
72.5039 21.6836 72.5977 21.7461 72.66411 21.8008 curveto
72.71089 21.8008 lineto
 closepath fill
newpath 78.3594 20.4688 moveto
77.457 20.4688 lineto
77.457 23.5273 lineto
77.457 23.77339 77.4414 24.0078 77.41411 24.2227 curveto
77.3828 24.4375 77.332 24.6094 77.2539 24.7305 curveto
77.1719 24.8633 77.0586 24.9648 76.9063 25.0313 curveto
76.7578 25.0938 76.5625 25.1289 76.3203 25.1289 curveto
76.0742 25.1289 75.8164 25.0664 75.5469 24.9453 curveto
75.2773 24.8242 75.0195 24.668 74.77339 24.4805 curveto
74.77339 20.4688 lineto
73.8711 20.4688 lineto
73.8711 27.9492 lineto
74.77339 27.9492 lineto
74.77339 25.2422 lineto
75.0547 25.47661 75.3477 25.6602 75.64839 25.793 curveto
75.9492 25.9219 76.2578 25.9883 76.5781 25.9883 curveto
77.1563 25.9883 77.5977 25.8125 77.9023 25.4648 curveto
78.207 25.1172 78.3594 24.6133 78.3594 23.957 curveto
 closepath fill
newpath 84.5508 20.4688 moveto
83.64839 20.4688 lineto
83.64839 21.0664 lineto
83.3438 20.8242 83.0508 20.6406 82.77339 20.5117 curveto
82.4922 20.3867 82.1875 20.3203 81.8477 20.3203 curveto
81.2852 20.3203 80.8477 20.4922 80.5313 20.83589 curveto
80.2188 21.1836 80.0625 21.6875 80.0625 22.3555 curveto
80.0625 25.8398 lineto
80.9648 25.8398 lineto
80.9648 22.7813 lineto
80.9648 22.5117 80.97661 22.2773 81.0039 22.082 curveto
81.0313 21.8906 81.082 21.7227 81.168 21.58589 curveto
81.2539 21.4453 81.3672 21.3398 81.5039 21.2773 curveto
81.6406 21.2148 81.8398 21.1797 82.1055 21.1797 curveto
82.3398 21.1797 82.5938 21.2422 82.8711 21.3633 curveto
83.14839 21.4844 83.4063 21.6406 83.64839 21.832 curveto
83.64839 25.8398 lineto
84.5508 25.8398 lineto
 closepath fill
newpath 90.8203 20.4688 moveto
89.91411 20.4688 lineto
89.91411 23.5273 lineto
89.91411 23.77339 89.9023 24.0078 89.8711 24.2227 curveto
89.8438 24.4375 89.78911 24.6094 89.7148 24.7305 curveto
89.6328 24.8633 89.5195 24.9648 89.3672 25.0313 curveto
89.2188 25.0938 89.02339 25.1289 88.7813 25.1289 curveto
88.5352 25.1289 88.2773 25.0664 88.0078 24.9453 curveto
87.7383 24.8242 87.4805 24.668 87.2344 24.4805 curveto
87.2344 20.4688 lineto
86.3281 20.4688 lineto
86.3281 25.8398 lineto
87.2344 25.8398 lineto
87.2344 25.2422 lineto
87.5156 25.47661 87.8086 25.6602 88.1094 25.793 curveto
88.4102 25.9219 88.7188 25.9883 89.0352 25.9883 curveto
89.6172 25.9883 90.0586 25.8125 90.3633 25.4648 curveto
90.668 25.1172 90.8203 24.6133 90.8203 23.957 curveto
 closepath fill
newpath 96.91411 21.082 moveto
96.91411 20.1719 96.707 19.5039 96.293 19.0781 curveto
95.8828 18.64839 95.2461 18.4375 94.3867 18.4375 curveto
94.10161 18.4375 93.8242 18.457 93.5508 18.4961 curveto
93.2813 18.5352 93.0156 18.5938 92.7539 18.668 curveto
92.7539 19.5898 lineto
92.8008 19.5898 lineto
92.9492 19.5313 93.1797 19.46089 93.5039 19.375 curveto
93.8242 19.293 94.1445 19.25 94.4648 19.25 curveto
94.7695 19.25 95.0273 19.2852 95.22661 19.3594 curveto
95.4297 19.4336 95.58589 19.5352 95.6992 19.668 curveto
95.8125 19.793 95.8906 19.9453 95.9375 20.1211 curveto
95.9883 20.2969 96.0117 20.4922 96.0117 20.71089 curveto
96.0117 21.1992 lineto
95.7383 20.9844 95.47661 20.8203 95.2305 20.71089 curveto
94.9805 20.6055 94.66411 20.5508 94.2813 20.5508 curveto
93.6406 20.5508 93.1328 20.7813 92.7539 21.2461 curveto
92.3789 21.71089 92.1914 22.3633 92.1914 23.207 curveto
92.1914 23.668 92.2539 24.0664 92.3828 24.39839 curveto
92.5156 24.7344 92.6914 25.02339 92.91411 25.2695 curveto
93.125 25.4961 93.3789 25.6719 93.6758 25.8008 curveto
93.9727 25.9258 94.2695 25.9883 94.5664 25.9883 curveto
94.875 25.9883 95.1367 25.957 95.3438 25.8945 curveto
95.5547 25.832 95.7773 25.7383 96.0117 25.6094 curveto
96.0117 24.875 lineto
95.7695 24.9844 95.5469 25.0586 95.3398 25.1055 curveto
95.1328 25.1523 94.9258 25.1758 94.7227 25.1758 curveto
94.22661 25.1758 93.83589 25.0117 93.5508 24.6758 curveto
93.2656 24.3438 93.1211 23.8594 93.1211 23.22661 curveto
93.1211 22.6211 93.22661 22.16411 93.4414 21.8555 curveto
93.6523 21.543 94.0039 21.3867 94.4922 21.3867 curveto
94.7539 21.3867 95.0195 21.4375 95.2813 21.53911 curveto
95.5469 21.6406 95.78911 21.7773 96.0117 21.9453 curveto
96.0117 21.9453 lineto
96.0117 24.875 lineto
96.0117 25.6094 lineto
96.0703 25.8398 lineto
96.91411 25.8398 lineto
 closepath fill
newpath 102.527 22.0195 moveto
102.527 21.5273 102.328 21.125 101.922 20.8125 curveto
101.516 20.4961 100.961 20.3398 100.262 20.3398 curveto
99.8633 20.3398 99.5 20.3867 99.168 20.4805 curveto
98.83589 20.5781 98.5586 20.6797 98.332 20.793 curveto
98.332 21.8047 lineto
98.3828 21.8047 lineto
98.66411 21.5898 98.9844 21.4219 99.332 21.293 curveto
99.6836 21.168 100.016 21.1055 100.336 21.1055 curveto
100.734 21.1055 101.047 21.168 101.27 21.2969 curveto
101.492 21.4258 101.605 21.625 101.605 21.9023 curveto
101.605 22.1133 101.547 22.27339 101.42601 22.3828 curveto
101.30101 22.4922 101.06601 22.58589 100.723 22.66411 curveto
100.59401 22.6914 100.42601 22.72661 100.21901 22.7617 curveto
100.012 22.8008 99.8242 22.8438 99.6563 22.8867 curveto
99.1836 23.0117 98.8477 23.1992 98.6523 23.4375 curveto
98.457 23.6797 98.3555 23.97661 98.3555 24.332 curveto
98.3555 24.5508 98.4023 24.7617 98.4922 24.957 curveto
98.58589 25.1523 98.7227 25.3242 98.9102 25.4805 curveto
99.0898 25.6289 99.3164 25.75 99.5938 25.83589 curveto
99.8711 25.9258 100.18399 25.9688 100.52301 25.9688 curveto
100.84401 25.9688 101.172 25.9297 101.5 25.85161 curveto
101.828 25.77339 102.10199 25.6797 102.31601 25.5664 curveto
102.31601 24.60161 lineto
102.27 24.60161 lineto
102.039 24.7695 101.758 24.91411 101.43 25.0313 curveto
101.098 25.14839 100.77301 25.207 100.457 25.207 curveto
100.129 25.207 99.8477 25.1406 99.6211 25.0156 curveto
99.3945 24.8906 99.2813 24.6992 99.2813 24.4492 curveto
99.2813 24.2305 99.3477 24.0625 99.4883 23.9492 curveto
99.6211 23.8398 99.8398 23.7461 100.141 23.6758 curveto
100.30899 23.6367 100.492 23.60161 100.69899 23.5625 curveto
100.90599 23.52339 101.078 23.4883 101.21901 23.457 curveto
101.637 23.3594 101.961 23.1953 102.188 22.96089 curveto
102.414 22.7227 102.527 22.4102 102.527 22.0195 curveto
 closepath fill
newpath 104.734 20.4688 moveto
103.832 20.4688 lineto
103.832 25.8398 lineto
104.734 25.8398 lineto
 closepath fill
newpath 104.793 26.7383 moveto
103.77301 26.7383 lineto
103.77301 27.6758 lineto
104.793 27.6758 lineto
 closepath fill
newpath 111.016 20.4688 moveto
110.109 20.4688 lineto
110.109 23.5273 lineto
110.109 23.77339 110.098 24.0078 110.06601 24.2227 curveto
110.039 24.4375 109.984 24.6094 109.90599 24.7305 curveto
109.828 24.8633 109.715 24.9648 109.563 25.0313 curveto
109.41 25.0938 109.215 25.1289 108.97699 25.1289 curveto
108.73 25.1289 108.473 25.0664 108.203 24.9453 curveto
107.93399 24.8242 107.67601 24.668 107.43 24.4805 curveto
107.43 20.4688 lineto
106.52301 20.4688 lineto
106.52301 25.8398 lineto
107.43 25.8398 lineto
107.43 25.2422 lineto
107.711 25.47661 108 25.6602 108.305 25.793 curveto
108.605 25.9219 108.914 25.9883 109.23 25.9883 curveto
109.813 25.9883 110.254 25.8125 110.55899 25.4648 curveto
110.863 25.1172 111.016 24.6133 111.016 23.957 curveto
 closepath fill
newpath 116.59 22.0195 moveto
116.59 21.5273 116.387 21.125 115.98 20.8125 curveto
115.578 20.4961 115.02301 20.3398 114.32 20.3398 curveto
113.92601 20.3398 113.55899 20.3867 113.22699 20.4805 curveto
112.895 20.5781 112.617 20.6797 112.395 20.793 curveto
112.395 21.8047 lineto
112.44101 21.8047 lineto
112.72699 21.5898 113.043 21.4219 113.395 21.293 curveto
113.742 21.168 114.078 21.1055 114.39801 21.1055 curveto
114.797 21.1055 115.105 21.168 115.332 21.2969 curveto
115.555 21.4258 115.668 21.625 115.668 21.9023 curveto
115.668 22.1133 115.605 22.27339 115.484 22.3828 curveto
115.363 22.4922 115.129 22.58589 114.78099 22.66411 curveto
114.652 22.6914 114.488 22.72661 114.28099 22.7617 curveto
114.07399 22.8008 113.887 22.8438 113.715 22.8867 curveto
113.242 23.0117 112.91 23.1992 112.715 23.4375 curveto
112.516 23.6797 112.418 23.97661 112.418 24.332 curveto
112.418 24.5508 112.465 24.7617 112.555 24.957 curveto
112.645 25.1523 112.785 25.3242 112.96901 25.4805 curveto
113.14801 25.6289 113.379 25.75 113.65599 25.83589 curveto
113.93399 25.9258 114.242 25.9688 114.586 25.9688 curveto
114.90599 25.9688 115.23 25.9297 115.55899 25.85161 curveto
115.887 25.77339 116.16 25.6797 116.379 25.5664 curveto
116.379 24.60161 lineto
116.332 24.60161 lineto
116.10199 24.7695 115.82 24.91411 115.488 25.0313 curveto
115.16 25.14839 114.836 25.207 114.52 25.207 curveto
114.188 25.207 113.91 25.1406 113.68399 25.0156 curveto
113.453 24.8906 113.34 24.6992 113.34 24.4492 curveto
113.34 24.2305 113.41 24.0625 113.547 23.9492 curveto
113.68399 23.8398 113.89801 23.7461 114.19899 23.6758 curveto
114.367 23.6367 114.555 23.60161 114.762 23.5625 curveto
114.96901 23.52339 115.141 23.4883 115.277 23.457 curveto
115.69899 23.3594 116.02 23.1953 116.25 22.96089 curveto
116.47699 22.7227 116.59 22.4102 116.59 22.0195 curveto
 closepath fill
newpath 120.672 20.5195 moveto
120.5 20.4727 120.31601 20.4375 120.117 20.4063 curveto
119.914 20.3789 119.738 20.3633 119.578 20.3633 curveto
119.03099 20.3633 118.613 20.5117 118.328 20.8047 curveto
118.047 21.10161 117.902 21.5742 117.902 22.22661 curveto
117.902 25.082 lineto
117.293 25.082 lineto
117.293 25.8398 lineto
117.902 25.8398 lineto
117.902 27.3828 lineto
118.805 27.3828 lineto
118.805 25.8398 lineto
120.672 25.8398 lineto
120.672 25.082 lineto
118.805 25.082 lineto
118.805 22.6328 lineto
118.805 22.35161 118.813 22.1328 118.82399 21.9727 curveto
118.84 21.8125 118.883 21.66411 118.961 21.5273 curveto
119.03099 21.39839 119.129 21.3047 119.25 21.2461 curveto
119.375 21.1875 119.563 21.1563 119.81601 21.1563 curveto
119.965 21.1563 120.117 21.1797 120.277 21.2227 curveto
120.438 21.2656 120.55101 21.3008 120.621 21.332 curveto
120.672 21.332 lineto
 closepath fill
newpath 122.67601 20.4688 moveto
121.77301 20.4688 lineto
121.77301 25.8398 lineto
122.67601 25.8398 lineto
 closepath fill
newpath 122.734 26.7383 moveto
121.715 26.7383 lineto
121.715 27.6758 lineto
122.734 27.6758 lineto
 closepath fill
newpath 127.254 20.5195 moveto
127.082 20.4727 126.89801 20.4375 126.695 20.4063 curveto
126.496 20.3789 126.31601 20.3633 126.16 20.3633 curveto
125.613 20.3633 125.195 20.5117 124.91 20.8047 curveto
124.625 21.10161 124.484 21.5742 124.484 22.22661 curveto
124.484 25.082 lineto
123.871 25.082 lineto
123.871 25.8398 lineto
124.484 25.8398 lineto
124.484 27.3828 lineto
125.387 27.3828 lineto
125.387 25.8398 lineto
127.254 25.8398 lineto
127.254 25.082 lineto
125.387 25.082 lineto
125.387 22.6328 lineto
125.387 22.35161 125.395 22.1328 125.40599 21.9727 curveto
125.418 21.8125 125.465 21.66411 125.539 21.5273 curveto
125.609 21.39839 125.707 21.3047 125.832 21.2461 curveto
125.953 21.1875 126.145 21.1563 126.395 21.1563 curveto
126.543 21.1563 126.69899 21.1797 126.859 21.2227 curveto
127.02 21.2656 127.133 21.3008 127.203 21.332 curveto
127.254 21.332 lineto
 closepath fill
newpath 132.793 20.4688 moveto
131.891 20.4688 lineto
131.891 21.0664 lineto
131.586 20.8242 131.293 20.6406 131.016 20.5117 curveto
130.738 20.3867 130.43 20.3203 130.094 20.3203 curveto
129.527 20.3203 129.09 20.4922 128.773 20.83589 curveto
128.461 21.1836 128.305 21.6875 128.305 22.3555 curveto
128.305 25.8398 lineto
129.207 25.8398 lineto
129.207 22.7813 lineto
129.207 22.5117 129.223 22.2773 129.246 22.082 curveto
129.273 21.8906 129.328 21.7227 129.41 21.58589 curveto
129.496 21.4453 129.609 21.3398 129.746 21.2773 curveto
129.883 21.2148 130.086 21.1797 130.348 21.1797 curveto
130.582 21.1797 130.836 21.2422 131.113 21.3633 curveto
131.391 21.4844 131.648 21.6406 131.891 21.832 curveto
131.891 25.8398 lineto
132.793 25.8398 lineto
 closepath fill
newpath 137.355 20.5195 moveto
137.184 20.4727 137 20.4375 136.801 20.4063 curveto
136.598 20.3789 136.422 20.3633 136.266 20.3633 curveto
135.715 20.3633 135.301 20.5117 135.016 20.8047 curveto
134.73 21.10161 134.586 21.5742 134.586 22.22661 curveto
134.586 25.082 lineto
133.977 25.082 lineto
133.977 25.8398 lineto
134.586 25.8398 lineto
134.586 27.3828 lineto
135.488 27.3828 lineto
135.488 25.8398 lineto
137.355 25.8398 lineto
137.355 25.082 lineto
135.488 25.082 lineto
135.488 22.6328 lineto
135.488 22.35161 135.496 22.1328 135.508 21.9727 curveto
135.52 21.8125 135.566 21.66411 135.645 21.5273 curveto
135.715 21.39839 135.813 21.3047 135.934 21.2461 curveto
136.059 21.1875 136.246 21.1563 136.5 21.1563 curveto
136.645 21.1563 136.801 21.1797 136.961 21.2227 curveto
137.121 21.2656 137.234 21.3008 137.309 21.332 curveto
137.355 21.332 lineto
 closepath fill
newpath 53.418 12.6875 moveto
53.71089 12.3672 53.9336 11.9766 54.0898 11.5117 curveto
54.2461 11.0469 54.3242 10.5195 54.3242 9.92969 curveto
54.3242 9.33984 54.2422 8.8125 54.08589 8.34375 curveto
53.9258 7.8789 53.707 7.49219 53.418 7.17969 curveto
53.125 6.85547 52.7773 6.61328 52.375 6.44922 curveto
51.9727 6.28516 51.5117 6.20313 50.9961 6.20313 curveto
51.0039 7.02734 lineto
51.7148 7.02734 52.2813 7.27344 52.7031 7.77344 curveto
53.1211 8.27344 53.332 8.99219 53.332 9.92969 curveto
53.332 9.92969 lineto
53.332 10.8594 53.125 11.5742 52.707 12.082 curveto
52.293 12.5859 51.7227 12.8359 51.0039 12.8359 curveto
50.27339 12.8359 49.7031 12.5859 49.28911 12.082 curveto
48.8711 11.5742 48.66411 10.8594 48.66411 9.92969 curveto
48.66411 8.99219 48.8789 8.27344 49.3008 7.77344 curveto
49.7227 7.27344 50.28911 7.02734 51.0039 7.02734 curveto
50.9961 6.20313 lineto
50.4922 6.20313 50.0352 6.28906 49.625 6.45313 curveto
49.2148 6.6211 48.8633 6.86328 48.5742 7.17969 curveto
48.2852 7.4961 48.0625 7.88672 47.9102 8.34766 curveto
47.7539 8.8086 47.6758 9.33594 47.6758 9.92969 curveto
47.6758 10.5117 47.7539 11.0352 47.9063 11.5 curveto
48.0586 11.9609 48.2852 12.3594 48.5781 12.6875 curveto
48.8594 13.0039 49.21089 13.2422 49.6289 13.4102 curveto
50.0469 13.5781 50.5039 13.6602 50.9961 13.6602 curveto
51.5117 13.6602 51.9688 13.5742 52.3789 13.4063 curveto
52.78911 13.2383 53.1328 13 53.418 12.6875 curveto
 closepath fill
newpath 60.4844 9.07813 moveto
60.4844 8.63281 60.4219 8.22656 60.2969 7.86719 curveto
60.168 7.50781 60 7.20703 59.7852 6.96484 curveto
59.5547 6.71094 59.3047 6.51953 59.0352 6.39453 curveto
58.7617 6.26563 58.46089 6.20313 58.1367 6.20313 curveto
57.832 6.20313 57.5664 6.23828 57.33589 6.3125 curveto
57.1094 6.38672 56.8867 6.48047 56.66411 6.60156 curveto
56.66411 7.32422 lineto
56.9219 7.20703 57.1406 7.1289 57.3242 7.08203 curveto
57.5117 7.03906 57.7188 7.01563 57.9531 7.01563 curveto
58.4531 7.01563 58.8438 7.17969 59.1289 7.51172 curveto
59.4102 7.83594 59.5547 8.35156 59.5547 9.05469 curveto
59.5547 9.05469 lineto
59.5547 9.69531 59.4492 10.1836 59.2344 10.5117 curveto
59.02339 10.8438 58.6836 11.0117 58.21089 11.0117 curveto
57.9492 11.0117 57.6836 10.9531 57.41411 10.8398 curveto
57.1445 10.7266 56.8945 10.5781 56.66411 10.4023 curveto
56.66411 7.32422 lineto
56.66411 6.60156 lineto
56.6055 6.35156 lineto
55.7617 6.35156 lineto
55.7617 13.832 lineto
56.66411 13.832 lineto
56.66411 11.1602 lineto
56.918 11.3672 57.1875 11.5391 57.4727 11.6719 curveto
57.7578 11.8047 58.0781 11.8711 58.4336 11.8711 curveto
59.0703 11.8711 59.5703 11.6289 59.9375 11.1406 curveto
60.3008 10.6523 60.4844 9.96484 60.4844 9.07813 curveto
 closepath fill
newpath 66.3906 8.94531 moveto
62.4336 8.94531 lineto
62.4336 9.63672 lineto
65.5117 9.63672 lineto
65.5078 10.1094 65.3867 10.4766 65.1523 10.7383 curveto
64.91411 10.9961 64.5586 11.125 64.0781 11.125 curveto
63.5938 11.125 63.207 10.9844 62.9219 10.6992 curveto
62.6328 10.4141 62.4727 10.0586 62.4336 9.63672 curveto
62.4336 8.94531 lineto
62.4336 8.61328 62.4844 8.32813 62.582 8.08203 curveto
62.6797 7.83594 62.8164 7.63672 62.9922 7.47656 curveto
63.1563 7.32422 63.3555 7.20703 63.58589 7.13281 curveto
63.8125 7.05469 64.0664 7.01563 64.3398 7.01563 curveto
64.707 7.01563 65.0742 7.08984 65.4453 7.23438 curveto
65.8164 7.38281 66.0781 7.52344 66.2344 7.66406 curveto
66.2852 7.66406 lineto
66.2852 6.67969 lineto
65.9805 6.55078 65.668 6.44531 65.35161 6.35938 curveto
65.0352 6.26953 64.6992 6.22656 64.35161 6.22656 curveto
63.46089 6.22656 62.7656 6.46875 62.2656 6.95313 curveto
61.7656 7.4336 61.5156 8.11719 61.5156 9.00781 curveto
61.5156 9.88672 61.7539 10.582 62.2344 11.0977 curveto
62.71089 11.6133 63.3438 11.8711 64.125 11.8711 curveto
64.8477 11.8711 65.4063 11.6602 65.8008 11.2383 curveto
66.1914 10.8125 66.3906 10.2148 66.3906 9.4336 curveto
 closepath fill
newpath 71.1094 10.7383 moveto
71.0625 10.7383 lineto
70.9258 10.7695 70.7969 10.793 70.668 10.8086 curveto
70.543 10.8203 70.3945 10.8281 70.2188 10.8281 curveto
69.9414 10.8281 69.6719 10.7656 69.41411 10.6445 curveto
69.1523 10.5195 68.9023 10.3594 68.66411 10.1641 curveto
68.66411 6.35156 lineto
67.7578 6.35156 lineto
67.7578 11.7227 lineto
68.66411 11.7227 lineto
68.66411 10.9297 lineto
69.02339 11.2188 69.3398 11.4219 69.6133 11.543 curveto
69.8867 11.6641 70.16411 11.7227 70.4492 11.7227 curveto
70.6094 11.7227 70.7227 11.7188 70.793 11.7109 curveto
70.8633 11.7031 70.9688 11.6875 71.1094 11.6641 curveto
 closepath fill
newpath 78.7148 11.7227 moveto
77.3164 6.35156 lineto
76.4805 6.35156 lineto
75.0977 10.4922 lineto
73.7305 6.35156 lineto
72.89839 6.35156 lineto
71.4844 11.7227 lineto
72.4258 11.7227 lineto
73.4102 7.5625 lineto
74.7539 11.7227 lineto
75.5 11.7227 lineto
76.875 7.5625 lineto
77.8047 11.7227 lineto
 closepath fill
newpath 84.5938 9.03516 moveto
84.5938 8.16016 84.3672 7.46875 83.9219 6.96484 curveto
83.4727 6.45703 82.8711 6.20313 82.1172 6.20313 curveto
81.3594 6.20313 80.7539 6.45703 80.3086 6.96484 curveto
79.8594 7.46875 79.6367 8.16016 79.6367 9.03516 curveto
79.6367 9.91016 79.8594 10.6016 80.3086 11.1094 curveto
80.7539 11.6172 81.3594 11.8711 82.1172 11.8711 curveto
82.1172 11.0938 lineto
81.6289 11.0938 81.2461 10.9219 80.97661 10.5859 curveto
80.707 10.2461 80.5703 9.73047 80.5703 9.03516 curveto
80.5703 8.36328 80.707 7.85156 80.97661 7.5039 curveto
81.25 7.15625 81.6328 6.98438 82.1172 6.98438 curveto
82.5977 6.98438 82.97661 7.15625 83.25 7.5 curveto
83.52339 7.84375 83.6602 8.35547 83.6602 9.03516 curveto
83.6602 9.03516 lineto
83.6602 9.73047 83.52339 10.2461 83.2539 10.5859 curveto
82.9805 10.9219 82.60161 11.0938 82.1172 11.0938 curveto
82.1172 11.8711 lineto
82.8711 11.8711 83.4727 11.6172 83.9219 11.1094 curveto
84.3672 10.6016 84.5938 9.91016 84.5938 9.03516 curveto
 closepath fill
newpath 86.9063 6.35156 moveto
86.0039 6.35156 lineto
86.0039 13.832 lineto
86.9063 13.832 lineto
 closepath fill
newpath 91.582 12.957 moveto
91.5352 12.957 lineto
91.4336 12.9883 91.3047 13.0156 91.1445 13.0469 curveto
90.9844 13.0781 90.8438 13.0938 90.7227 13.0938 curveto
90.33589 13.0938 90.0547 13.0078 89.8789 12.8359 curveto
89.7031 12.6641 89.6172 12.3555 89.6172 11.9063 curveto
89.6172 11.7227 lineto
91.2461 11.7227 lineto
91.2461 10.9648 lineto
89.6445 10.9648 lineto
89.6445 6.35156 lineto
88.7422 6.35156 lineto
88.7422 10.9648 lineto
88.1328 10.9648 lineto
88.1328 11.7227 lineto
88.7422 11.7227 lineto
88.7422 11.8984 lineto
88.7422 12.5391 88.9023 13.0273 89.2188 13.3672 curveto
89.5352 13.7109 89.9922 13.8828 90.5938 13.8828 curveto
90.793 13.8828 90.97661 13.8711 91.1367 13.8516 curveto
91.3008 13.832 91.4492 13.8086 91.582 13.7852 curveto
 closepath fill
newpath 96.3281 6.35156 moveto
95.4297 6.35156 lineto
95.4297 6.92578 lineto
95.3477 6.8711 95.2383 6.79297 95.1055 6.69922 curveto
94.6992 7.23047 lineto
94.96089 7.35547 95.2031 7.5 95.4297 7.67578 curveto
95.4297 7.67578 lineto
95.4297 9.17188 lineto
95.1523 9.15234 94.8281 9.1289 94.457 9.09766 curveto
94.082 9.0664 93.7852 9.01953 93.5703 8.95703 curveto
93.3086 8.88672 93.0977 8.76953 92.9375 8.61328 curveto
92.7773 8.46094 92.6992 8.2461 92.6992 7.97266 curveto
92.6992 7.66406 92.78911 7.4336 92.97661 7.27734 curveto
93.16411 7.1211 93.4453 7.04688 93.8281 7.04688 curveto
94.1445 7.04688 94.4336 7.10547 94.6992 7.23047 curveto
95.1055 6.69922 lineto
94.9688 6.59766 94.83589 6.51953 94.707 6.46484 curveto
94.5547 6.39063 94.3828 6.32813 94.1875 6.27734 curveto
93.9922 6.23047 93.7656 6.20313 93.5 6.20313 curveto
93.0156 6.20313 92.6055 6.36328 92.2695 6.6836 curveto
91.9336 7.00781 91.7656 7.41406 91.7656 7.91016 curveto
91.7656 8.32031 91.85161 8.64844 92.0273 8.89844 curveto
92.2031 9.14844 92.4531 9.34766 92.77339 9.49219 curveto
93.10161 9.63672 93.4961 9.73438 93.9531 9.78516 curveto
94.4102 9.83594 94.9023 9.875 95.4297 9.90234 curveto
95.4297 10.0391 lineto
95.4297 10.2461 95.3945 10.4141 95.3203 10.5508 curveto
95.2461 10.6836 95.1445 10.7891 95.0117 10.8672 curveto
94.8828 10.9414 94.72661 10.9883 94.5469 11.0156 curveto
94.3672 11.043 94.1797 11.0547 93.9844 11.0547 curveto
93.75 11.0547 93.4844 11.0234 93.1953 10.9609 curveto
92.9023 10.8984 92.60161 10.8086 92.28911 10.6875 curveto
92.2422 10.6875 lineto
92.2422 11.6055 lineto
92.418 11.6563 92.6719 11.707 93.0078 11.7656 curveto
93.3398 11.8242 93.668 11.8516 93.9922 11.8516 curveto
94.3672 11.8516 94.6992 11.8203 94.9805 11.7578 curveto
95.2578 11.6953 95.5039 11.5898 95.707 11.4375 curveto
95.9102 11.293 96.0625 11.1016 96.168 10.8672 curveto
96.27339 10.6328 96.3281 10.3438 96.3281 9.9961 curveto
 closepath fill
newpath 102.039 6.6914 moveto
101.738 6.54688 101.44899 6.4336 101.18 6.35156 curveto
100.91 6.27344 100.621 6.23438 100.31601 6.23438 curveto
99.9297 6.23438 99.5742 6.28906 99.25 6.40234 curveto
98.9258 6.51563 98.64839 6.6914 98.418 6.92188 curveto
98.1836 7.15234 98.0039 7.44531 97.875 7.79688 curveto
97.7461 8.14844 97.6836 8.5586 97.6836 9.03125 curveto
97.6836 9.91016 97.9219 10.5977 98.4063 11.0977 curveto
98.8906 11.5977 99.5273 11.8477 100.31601 11.8477 curveto
100.625 11.8477 100.92601 11.8047 101.223 11.7188 curveto
101.52 11.6328 101.793 11.5273 102.039 11.4023 curveto
102.039 10.3945 lineto
101.988 10.3945 lineto
101.715 10.6094 101.43 10.7773 101.137 10.8906 curveto
100.84401 11.0078 100.55899 11.0625 100.277 11.0625 curveto
99.7656 11.0625 99.3594 10.8906 99.0664 10.5469 curveto
98.7695 10.2031 98.6211 9.69922 98.6211 9.03125 curveto
98.6211 8.38281 98.7656 7.88672 99.0547 7.53906 curveto
99.3438 7.1914 99.7539 7.01563 100.277 7.01563 curveto
100.461 7.01563 100.64801 7.03906 100.836 7.08984 curveto
101.02301 7.13672 101.195 7.19922 101.348 7.27734 curveto
101.47699 7.34375 101.60199 7.41406 101.715 7.48828 curveto
101.832 7.5664 101.922 7.63281 101.988 7.6836 curveto
102.039 7.6836 lineto
 closepath fill
newpath 107.688 6.35156 moveto
106.78099 6.35156 lineto
106.78099 9.41016 lineto
106.78099 9.65625 106.77 9.88672 106.738 10.1055 curveto
106.711 10.3203 106.65599 10.4922 106.582 10.6133 curveto
106.5 10.7461 106.387 10.8477 106.234 10.9141 curveto
106.086 10.9766 105.887 11.0117 105.64801 11.0117 curveto
105.402 11.0117 105.145 10.9492 104.875 10.8281 curveto
104.605 10.707 104.348 10.5508 104.10199 10.3633 curveto
104.10199 6.35156 lineto
103.195 6.35156 lineto
103.195 13.832 lineto
104.10199 13.832 lineto
104.10199 11.125 lineto
104.383 11.3594 104.67601 11.543 104.97699 11.6758 curveto
105.277 11.8047 105.586 11.8711 105.902 11.8711 curveto
106.484 11.8711 106.92601 11.6992 107.23 11.3477 curveto
107.535 11 107.688 10.4961 107.688 9.83984 curveto
 closepath fill
newpath 397.719 34.375 moveto
392.789 22.97661 lineto
387.81299 34.375 lineto
383.93799 18.3047 lineto
386.39801 18.3047 lineto
388.52701 27.7773 lineto
392.789 17.66411 lineto
397.051 27.7773 lineto
399.156 18.3047 lineto
401.621 18.3047 lineto
 closepath fill
newpath 430.883 26.1094 moveto
430.883 24.1055 lineto
434.965 24.1055 lineto
434.52701 21.53911 432.73001 19.9492 430.012 19.9492 curveto
426.72699 19.9492 424.51999 22.6172 424.51999 26.1875 curveto
424.51999 29.4453 426.801 31.9883 430.06299 31.9883 curveto
432.035 31.9883 433.47699 31.16411 434.93799 29.2656 curveto
436.762 30.6797 lineto
435.039 32.9883 432.80899 34.1172 430.012 34.1172 curveto
428.215 34.1172 426.695 33.5547 425.262 32.5 curveto
423.18399 30.96089 422.055 28.6758 422.055 26.0078 curveto
422.055 23.7461 422.89801 21.6406 424.43799 20.10161 curveto
425.953 18.5625 427.621 17.8203 430.012 17.8203 curveto
432.293 17.8203 434.01599 18.58589 435.426 20.1289 curveto
436.785 21.5664 437.453 23.2852 437.68799 26.1094 curveto
 closepath fill
newpath 465.66 33.6563 moveto
463.43 33.6563 lineto
463.43 23.207 lineto
451.93399 33.9648 lineto
451.93399 18.3047 lineto
454.164 18.3047 lineto
454.164 28.7773 lineto
465.66 17.9961 lineto
 closepath fill
newpath 500.031 18.3047 moveto
495.41 25.082 lineto
497.56601 25.64839 498.72699 27.1367 498.72699 29.293 curveto
498.72699 30.8594 498.031 32.2188 496.77301 32.9375 curveto
495.76999 33.5547 494.949 33.6563 492.074 33.6563 curveto
489.406 33.6563 lineto
489.406 18.3047 lineto
491.64099 18.3047 lineto
491.64099 24.8789 lineto
491.64099 26.9063 lineto
491.64099 31.6523 lineto
493.51599 31.6523 lineto
494.56601 31.6523 495.207 31.5 495.64499 31.1133 curveto
496.133 30.6797 496.43799 29.9336 496.43799 29.1875 curveto
496.43799 28.2656 495.949 27.4961 495.10501 27.1367 curveto
494.668 26.957 494.078 26.9063 492.69101 26.9063 curveto
491.64099 26.9063 lineto
491.64099 24.8789 lineto
492.82 24.8789 lineto
497.211 18.3047 lineto
 closepath fill
newpath 445.336 33.6563 moveto
443.074 33.6563 lineto
443.074 18.3047 lineto
445.336 18.3047 lineto
 closepath fill
newpath 378.75 33.6563 moveto
376.51999 33.6563 lineto
376.51999 18.3047 lineto
378.75 18.3047 lineto
 closepath fill
newpath 515.10199 33.6563 moveto
512.76599 33.6563 lineto
508.81299 27.3164 lineto
504.781 33.6563 lineto
502.31601 33.6563 lineto
507.656 24.9805 lineto
507.656 18.3047 lineto
509.89099 18.3047 lineto
509.89099 25.2383 lineto
 closepath fill
newpath 416.76599 18.3047 moveto
419.23001 18.3047 lineto
411.81299 34.2188 lineto
404.39499 18.3047 lineto
406.85501 18.3047 lineto
408.445 21.9258 lineto
415.14801 21.9258 lineto
414.27301 23.9258 lineto
409.34799 23.9258 lineto
411.81299 29.4961 lineto
414.27301 23.9258 lineto
415.14801 21.9258 lineto
 closepath fill
newpath 482.449 18.3047 moveto
484.914 18.3047 lineto
477.496 34.2188 lineto
470.078 18.3047 lineto
472.539 18.3047 lineto
474.133 21.9258 lineto
480.832 21.9258 lineto
479.961 23.9258 lineto
475.031 23.9258 lineto
477.496 29.4961 lineto
479.961 23.9258 lineto
480.832 21.9258 lineto
 closepath fill
newpath 408.32 11.582 moveto
408.32 10.8867 lineto
409.06299 10.8867 409.65201 10.2695 409.65201 9.52734 curveto
409.65201 8.8086 409.06299 8.21875 408.32 8.21875 curveto
407.60199 8.21875 407.035 8.8086 407.035 9.52734 curveto
407.035 10.2695 407.60199 10.8867 408.32 10.8867 curveto
408.32 10.8867 lineto
408.32 11.582 lineto
407.19101 11.582 406.26999 10.6836 406.26999 9.52734 curveto
406.26999 8.3711 407.19101 7.47266 408.32 7.47266 curveto
409.47699 7.47266 410.39801 8.3711 410.39801 9.52734 curveto
410.39801 10.6836 409.47699 11.582 408.32 11.582 curveto
 closepath fill
newpath 412.426 11.4531 moveto
411.68399 11.4531 lineto
411.68399 5.39453 lineto
412.426 5.39453 lineto
412.426 8.21875 lineto
412.449 8.21875 lineto
412.73401 7.78125 413.195 7.47266 413.762 7.47266 curveto
414.94101 7.47266 415.586 8.44922 415.586 9.57813 curveto
415.586 10.6328 414.89099 11.582 413.785 11.582 curveto
413.60501 10.9141 lineto
414.40201 10.9141 414.863 10.2969 414.863 9.55078 curveto
414.863 8.78125 414.40201 8.16797 413.60501 8.16797 curveto
413.60501 8.16797 lineto
412.81299 8.16797 412.375 8.83203 412.375 9.55078 curveto
412.375 10.2461 412.84 10.9141 413.60501 10.9141 curveto
413.785 11.582 lineto
413.195 11.582 412.73401 11.2969 412.449 10.8359 curveto
412.426 10.8359 lineto
 closepath fill
newpath 420.51599 9.39844 moveto
420.51599 9.52734 lineto
420.51599 10.6836 419.945 11.582 418.715 11.582 curveto
417.48401 11.582 416.844 10.6836 416.844 9.5 curveto
416.844 8.3711 417.56299 7.47266 418.715 7.47266 curveto
419.48401 7.47266 420.15201 7.85938 420.51599 8.52734 curveto
419.89499 8.88672 lineto
419.613 8.42188 419.30899 8.16797 418.715 8.16797 curveto
418.02301 8.16797 417.586 8.75781 417.586 9.39844 curveto
417.60901 9.98828 lineto
417.715 10.5273 418.14801 10.9375 418.715 10.9375 curveto
419.30899 10.9375 419.69101 10.5781 419.76999 9.98828 curveto
417.60901 9.98828 lineto
417.586 9.39844 lineto
 closepath fill
newpath 422.72299 11.4531 moveto
421.97699 11.4531 lineto
421.97699 7.6289 lineto
422.72299 7.6289 lineto
422.72299 9.3711 lineto
422.72299 10.0898 422.72299 10.9141 423.672 10.9141 curveto
424.43799 10.9141 424.543 10.4492 424.543 9.8086 curveto
424.543 7.6289 lineto
425.23401 7.6289 lineto
425.23401 9.91016 lineto
425.23401 10.8633 425.004 11.582 423.89801 11.582 curveto
423.43799 11.582 422.97699 11.375 422.746 10.9375 curveto
422.72299 10.9375 lineto
 closepath fill
newpath 431.496 11.4531 moveto
430.73001 11.4531 lineto
430.73001 7.6289 lineto
431.496 7.6289 lineto
431.496 9.5 lineto
431.496 10.1172 431.551 10.9141 432.34799 10.9141 curveto
433.039 10.9141 433.06299 10.168 433.06299 9.65625 curveto
433.06299 7.6289 lineto
433.80899 7.6289 lineto
433.80899 9.5 lineto
433.80899 10.1172 433.85901 10.9141 434.656 10.9141 curveto
435.297 10.9141 435.375 10.2969 435.375 9.78516 curveto
435.375 7.6289 lineto
436.094 7.6289 lineto
436.094 9.91016 lineto
436.094 10.7852 435.836 11.582 434.836 11.582 curveto
434.34799 11.582 433.887 11.3242 433.629 10.9141 curveto
433.39801 11.3477 433.039 11.582 432.52301 11.582 curveto
432.09 11.582 431.703 11.3242 431.496 10.9648 curveto
 closepath fill
newpath 441.508 11.4531 moveto
440.789 11.4531 lineto
440.789 10.8359 lineto
440.76599 10.8359 lineto
440.457 11.2969 439.992 11.582 439.43 11.582 curveto
439.55899 10.9141 lineto
440.35501 10.9141 440.81601 10.2969 440.81601 9.55078 curveto
440.81601 8.78125 440.35501 8.16797 439.55899 8.16797 curveto
439.55899 8.16797 lineto
438.76599 8.16797 438.324 8.83203 438.324 9.55078 curveto
438.324 10.2461 438.785 10.9141 439.55899 10.9141 curveto
439.43 11.582 lineto
438.301 11.582 437.60501 10.6328 437.60501 9.57813 curveto
437.60501 8.44922 438.27301 7.47266 439.43 7.47266 curveto
439.992 7.47266 440.457 7.78125 440.76599 8.21875 curveto
440.789 8.21875 lineto
440.789 7.6289 lineto
441.508 7.6289 lineto
 closepath fill
newpath 446.72299 13.7891 moveto
446.72299 7.6289 lineto
447.465 7.6289 lineto
447.465 9.3711 lineto
447.465 10.0898 447.465 10.9141 448.414 10.9141 curveto
449.18399 10.9141 449.262 10.4492 449.262 9.8086 curveto
449.262 7.6289 lineto
450.008 7.6289 lineto
450.008 9.91016 lineto
450.008 10.8633 449.72299 11.582 448.617 11.582 curveto
448.18399 11.582 447.72299 11.375 447.465 10.9375 curveto
447.465 13.7891 lineto
 closepath fill
newpath 455.344 9.39844 moveto
455.344 9.52734 lineto
455.344 10.6836 454.754 11.582 453.51999 11.582 curveto
452.289 11.582 451.676 10.6836 451.676 9.5 curveto
451.676 8.3711 452.367 7.47266 453.547 7.47266 curveto
454.289 7.47266 454.98401 7.85938 455.344 8.52734 curveto
454.73001 8.88672 lineto
454.445 8.42188 454.14099 8.16797 453.547 8.16797 curveto
452.85501 8.16797 452.418 8.75781 452.39499 9.39844 curveto
452.44101 9.98828 lineto
452.51999 10.5273 452.957 10.9375 453.51999 10.9375 curveto
454.14099 10.9375 454.52301 10.5781 454.60199 9.98828 curveto
452.44101 9.98828 lineto
452.39499 9.39844 lineto
 closepath fill
newpath 457.85901 11.4531 moveto
457.113 11.4531 lineto
457.113 7.6289 lineto
457.85901 7.6289 lineto
457.85901 9.5 lineto
457.85901 10.1172 457.91 10.9141 458.707 10.9141 curveto
459.371 10.9141 459.39801 10.168 459.39801 9.65625 curveto
459.39801 7.6289 lineto
460.14499 7.6289 lineto
460.14499 9.5 lineto
460.14499 10.1172 460.22299 10.9141 460.988 10.9141 curveto
461.656 10.9141 461.73401 10.2969 461.73401 9.78516 curveto
461.73401 7.6289 lineto
462.453 7.6289 lineto
462.453 9.91016 lineto
462.453 10.7852 462.195 11.582 461.195 11.582 curveto
460.711 11.582 460.246 11.3242 459.988 10.9141 curveto
459.73401 11.3477 459.371 11.582 458.887 11.582 curveto
458.449 11.582 458.09 11.3242 457.85901 10.9648 curveto
 closepath fill
newpath 467.867 11.4531 moveto
467.125 11.4531 lineto
467.125 10.8359 lineto
466.81601 11.2969 466.35501 11.582 465.789 11.582 curveto
465.922 10.9141 lineto
466.715 10.9141 467.176 10.2969 467.176 9.55078 curveto
467.176 8.78125 466.715 8.16797 465.922 8.16797 curveto
465.922 8.16797 lineto
465.121 8.16797 464.68799 8.83203 464.68799 9.55078 curveto
464.68799 10.2461 465.14801 10.9141 465.922 10.9141 curveto
465.789 11.582 lineto
464.66 11.582 463.969 10.6328 463.969 9.57813 curveto
463.969 8.44922 464.637 7.47266 465.789 7.47266 curveto
466.35501 7.47266 466.81601 7.78125 467.125 8.21875 curveto
467.125 7.6289 lineto
467.867 7.6289 lineto
 closepath fill
newpath 473.824 11.4531 moveto
473.10501 11.4531 lineto
473.10501 7.6289 lineto
473.824 7.6289 lineto
 closepath fill
newpath 473.492 13.7617 moveto
473.18399 13.7617 472.98001 13.5078 472.98001 13.2227 curveto
472.98001 12.9414 473.18399 12.7344 473.492 12.7344 curveto
473.746 12.7344 474.004 12.9414 474.004 13.2227 curveto
474.004 13.5078 473.746 13.7617 473.492 13.7617 curveto
 closepath fill
newpath 479.06299 10.7344 moveto
478.906 10.9883 478.39499 11.582 477.51999 11.582 curveto
476.34 11.582 475.414 10.707 475.414 9.5 curveto
475.414 8.34766 476.34 7.47266 477.47299 7.47266 curveto
478.31601 7.47266 478.77701 7.9336 479.012 8.26953 curveto
478.496 8.65625 lineto
478.26599 8.39844 478.035 8.16797 477.496 8.16797 curveto
476.676 8.16797 476.137 8.75781 476.137 9.55078 curveto
476.137 10.2461 476.699 10.9141 477.445 10.9141 curveto
477.883 10.9141 478.238 10.707 478.52301 10.375 curveto
 closepath fill
newpath 482.47699 10.9141 moveto
482.26999 11.3477 481.887 11.582 481.426 11.582 curveto
480.781 11.582 480.293 11.1172 480.293 10.4492 curveto
480.293 9.9375 480.60199 9.73047 481.01599 9.5 curveto
481.758 9.11719 lineto
481.91 8.98828 482.01599 8.88672 482.01599 8.67969 curveto
482.01599 8.34766 481.758 8.16797 481.449 8.16797 curveto
481.09 8.16797 480.887 8.34766 480.758 8.65625 curveto
480.09 8.34766 lineto
480.32 7.8086 480.887 7.47266 481.449 7.47266 curveto
482.14499 7.47266 482.781 8.01172 482.781 8.75781 curveto
482.781 9.34766 482.34799 9.65625 481.887 9.85938 curveto
481.426 10.0391 480.98401 10.2188 480.98401 10.5273 curveto
480.98401 10.7617 481.19101 10.9141 481.371 10.9141 curveto
481.60501 10.9141 481.781 10.7852 481.887 10.6055 curveto
 closepath fill
newpath 444.332 10.7852 moveto
445.051 10.7852 lineto
445.051 11.4531 lineto
444.332 11.4531 lineto
444.332 12.9414 lineto
443.56299 12.9414 lineto
443.56299 11.4531 lineto
443.15201 11.4531 lineto
443.15201 10.7852 lineto
443.56299 10.7852 lineto
443.56299 7.6289 lineto
444.332 7.6289 lineto
 closepath fill
newpath 470.76999 10.7852 moveto
471.539 10.7852 lineto
471.539 11.4531 lineto
470.76999 11.4531 lineto
470.76999 12.9414 lineto
470.051 12.9414 lineto
470.051 11.4531 lineto
469.64499 11.4531 lineto
469.64499 10.7852 lineto
470.051 10.7852 lineto
470.051 7.6289 lineto
470.76999 7.6289 lineto
 closepath fill
newpath 181.344 12.0547 moveto
181.344 15.5156 lineto
181.801 15.5156 lineto
181.801 12.4648 lineto
183.313 12.4648 lineto
183.313 12.0547 lineto
 closepath fill
newpath 185.762 13.25 moveto
183.996 13.25 lineto
184.008 13.5664 lineto
185.363 13.5664 lineto
185.363 13.7422 185.309 13.8867 185.199 14.0039 curveto
185.078 14.1328 184.914 14.1953 184.707 14.1953 curveto
184.707 14.1953 lineto
184.516 14.1953 184.352 14.1328 184.219 14.0078 curveto
184.094 13.8906 184.023 13.7422 184.008 13.5664 curveto
183.996 13.25 lineto
183.996 12.9648 184.074 12.7422 184.23 12.5898 curveto
184.371 12.4531 184.547 12.3867 184.766 12.3867 curveto
185.016 12.3867 185.223 12.4609 185.387 12.6055 curveto
185.57 12.293 lineto
185.504 12.2227 185.402 12.168 185.262 12.1172 curveto
185.086 12.0547 184.895 12.0234 184.68 12.0234 curveto
184.375 12.0234 184.113 12.1289 183.898 12.3359 curveto
183.66 12.5664 183.539 12.875 183.539 13.2656 curveto
183.539 13.668 183.66 13.9922 183.906 14.2344 curveto
184.125 14.4531 184.387 14.5625 184.688 14.5625 curveto
185.035 14.5625 185.309 14.4648 185.508 14.2656 curveto
185.699 14.0781 185.793 13.8281 185.793 13.5156 curveto
185.793 13.418 185.781 13.332 185.762 13.25 curveto
 closepath fill
newpath 186.785 15.4297 moveto
186.859 15.4297 186.922 15.4023 186.977 15.3516 curveto
187.027 15.2969 187.055 15.2344 187.055 15.1602 curveto
187.055 15.0859 187.027 15.0234 186.977 14.9688 curveto
186.922 14.918 186.859 14.8906 186.785 14.8906 curveto
186.715 14.8906 186.648 14.918 186.598 14.9688 curveto
186.543 15.0234 186.52 15.0859 186.52 15.1602 curveto
186.52 15.2344 186.543 15.2969 186.594 15.3516 curveto
186.648 15.4023 186.711 15.4297 186.785 15.4297 curveto
 closepath fill
newpath 186.609 12.0547 moveto
186.609 14.1367 lineto
186.273 14.1367 lineto
186.273 14.5039 lineto
187.043 14.5039 lineto
187.043 12.0547 lineto
 closepath fill
newpath 188.258 12.2305 moveto
188.105 12.0078 lineto
187.887 12.0078 lineto
187.887 15.5273 lineto
188.324 15.5273 lineto
188.324 14.3203 lineto
188.508 14.1133 lineto
188.414 14.0703 188.352 14.0273 188.324 13.9922 curveto
188.324 13.9922 lineto
188.324 12.5781 lineto
188.324 12.5547 188.375 12.5156 188.484 12.457 curveto
188.594 12.4023 188.676 12.375 188.73 12.375 curveto
189.027 12.375 189.238 12.4453 189.367 12.5859 curveto
189.496 12.7305 189.559 12.9688 189.559 13.3008 curveto
189.559 13.5781 189.484 13.793 189.336 13.9492 curveto
189.184 14.1055 188.984 14.1836 188.73 14.1836 curveto
188.68 14.1836 188.605 14.1602 188.508 14.1133 curveto
188.324 14.3203 lineto
188.363 14.3789 188.441 14.4297 188.555 14.4766 curveto
188.668 14.5234 188.777 14.5508 188.891 14.5508 curveto
189.223 14.5508 189.496 14.4336 189.703 14.2031 curveto
189.91 13.9688 190.016 13.6758 190.016 13.3242 curveto
190.016 12.9141 189.91 12.5938 189.703 12.3594 curveto
189.492 12.125 189.211 12.0078 188.855 12.0078 curveto
188.738 12.0078 188.625 12.0313 188.512 12.0742 curveto
188.402 12.1172 188.316 12.168 188.258 12.2305 curveto
 closepath fill
newpath 192.109 12.0547 moveto
192.109 13.4805 lineto
192.109 13.7383 192.07 13.9219 191.992 14.0273 curveto
191.914 14.1328 191.785 14.1836 191.598 14.1836 curveto
191.5 14.1836 191.398 14.1523 191.289 14.0938 curveto
191.18 14.0352 191.098 13.9609 191.039 13.875 curveto
191.039 12.0547 lineto
190.605 12.0547 lineto
190.605 14.5039 lineto
190.902 14.5039 lineto
191.039 14.1875 lineto
191.184 14.4297 191.418 14.5508 191.742 14.5508 curveto
192.277 14.5508 192.547 14.2227 192.547 13.5703 curveto
192.547 12.0547 lineto
 closepath fill
newpath 193.621 15.4297 moveto
193.695 15.4297 193.758 15.4023 193.813 15.3516 curveto
193.867 15.2969 193.891 15.2344 193.891 15.1602 curveto
193.891 15.0859 193.867 15.0234 193.813 14.9688 curveto
193.758 14.918 193.695 14.8906 193.621 14.8906 curveto
193.547 14.8906 193.484 14.918 193.434 14.9688 curveto
193.379 15.0234 193.355 15.0859 193.355 15.1602 curveto
193.355 15.2344 193.379 15.2969 193.434 15.3516 curveto
193.484 15.4023 193.547 15.4297 193.621 15.4297 curveto
 closepath fill
newpath 193.445 12.0547 moveto
193.445 14.1367 lineto
193.109 14.1367 lineto
193.109 14.5039 lineto
193.879 14.5039 lineto
193.879 12.0547 lineto
 closepath fill
newpath 195.289 12.4453 moveto
196.645 12.4453 lineto
196.645 12.0547 lineto
194.605 12.0547 lineto
194.605 12.168 lineto
196 14.1133 lineto
194.629 14.1133 lineto
194.629 14.5039 lineto
196.633 14.5039 lineto
196.633 14.3789 lineto
 closepath fill
newpath 183.781 10.2305 moveto
183.594 9.85156 lineto
183.363 10.0234 183.137 10.1055 182.914 10.1055 curveto
182.566 10.1055 182.289 9.98438 182.086 9.73828 curveto
181.883 9.49219 181.781 9.16406 181.781 8.75781 curveto
181.781 8.3711 181.883 8.0586 182.078 7.82031 curveto
182.281 7.58594 182.551 7.46875 182.895 7.46875 curveto
183.137 7.46875 183.336 7.53906 183.484 7.6875 curveto
183.484 8.47266 lineto
183.02 8.47266 lineto
183.02 8.85938 lineto
183.941 8.85938 lineto
183.941 7.40234 lineto
183.82 7.29688 183.648 7.21484 183.43 7.15234 curveto
183.215 7.08984 183.004 7.05469 182.797 7.05469 curveto
182.336 7.05469 181.969 7.21094 181.703 7.52344 curveto
181.438 7.83984 181.301 8.2539 181.301 8.77344 curveto
181.301 9.29297 181.449 9.71484 181.742 10.0352 curveto
182.035 10.3594 182.43 10.5195 182.93 10.5195 curveto
183.277 10.5195 183.563 10.4219 183.781 10.2305 curveto
 closepath fill
newpath 186.688 8.29297 moveto
184.922 8.29297 lineto
184.934 8.60938 lineto
186.289 8.60938 lineto
186.289 8.78516 186.234 8.9336 186.125 9.05078 curveto
186.004 9.17578 185.84 9.24219 185.633 9.24219 curveto
185.633 9.24219 lineto
185.441 9.24219 185.277 9.17969 185.148 9.05469 curveto
185.023 8.9336 184.949 8.78516 184.934 8.60938 curveto
184.922 8.29297 lineto
184.922 8.00781 185 7.78906 185.16 7.63672 curveto
185.297 7.5 185.477 7.4336 185.695 7.4336 curveto
185.941 7.4336 186.148 7.5039 186.316 7.64844 curveto
186.5 7.33594 lineto
186.43 7.26953 186.328 7.21094 186.188 7.16406 curveto
186.016 7.09766 185.82 7.0664 185.609 7.0664 curveto
185.301 7.0664 185.039 7.17188 184.824 7.3789 curveto
184.586 7.60938 184.465 7.91797 184.465 8.3086 curveto
184.465 8.71094 184.59 9.03516 184.836 9.28125 curveto
185.055 9.4961 185.313 9.60547 185.613 9.60547 curveto
185.961 9.60547 186.234 9.50781 186.434 9.3125 curveto
186.625 9.1211 186.723 8.8711 186.723 8.5586 curveto
186.723 8.46484 186.711 8.375 186.688 8.29297 curveto
 closepath fill
newpath 190.211 7.11328 moveto
190.211 8.66406 lineto
190.211 9.04688 190.043 9.24219 189.707 9.24219 curveto
189.602 9.24219 189.504 9.20703 189.414 9.14453 curveto
189.32 9.07813 189.258 9.00781 189.227 8.92188 curveto
189.227 7.11328 lineto
188.789 7.11328 lineto
188.789 8.85156 lineto
188.789 8.97266 188.746 9.0664 188.656 9.13672 curveto
188.566 9.20703 188.445 9.24219 188.293 9.24219 curveto
188.207 9.24219 188.117 9.20703 188.016 9.14063 curveto
187.918 9.07422 187.848 9 187.809 8.91797 curveto
187.809 7.11328 lineto
187.375 7.11328 lineto
187.375 9.5625 lineto
187.656 9.5625 lineto
187.801 9.27734 lineto
187.969 9.4961 188.18 9.60547 188.43 9.60547 curveto
188.781 9.60547 189.027 9.4961 189.164 9.28125 curveto
189.215 9.3711 189.305 9.44922 189.438 9.51172 curveto
189.57 9.57813 189.707 9.60547 189.848 9.60547 curveto
190.098 9.60547 190.297 9.53125 190.434 9.38281 curveto
190.574 9.23047 190.645 9.01953 190.645 8.75 curveto
190.645 7.11328 lineto
 closepath fill
newpath 193.539 8.29297 moveto
191.773 8.29297 lineto
191.785 8.60938 lineto
193.141 8.60938 lineto
193.141 8.78516 193.086 8.9336 192.977 9.05078 curveto
192.855 9.17578 192.691 9.24219 192.484 9.24219 curveto
192.484 9.24219 lineto
192.289 9.24219 192.129 9.17969 191.996 9.05469 curveto
191.871 8.9336 191.801 8.78516 191.785 8.60938 curveto
191.773 8.29297 lineto
191.773 8.00781 191.852 7.78906 192.008 7.63672 curveto
192.148 7.5 192.324 7.4336 192.543 7.4336 curveto
192.793 7.4336 193 7.5039 193.164 7.64844 curveto
193.348 7.33594 lineto
193.281 7.26953 193.18 7.21094 193.039 7.16406 curveto
192.867 7.09766 192.672 7.0664 192.461 7.0664 curveto
192.152 7.0664 191.891 7.17188 191.676 7.3789 curveto
191.438 7.60938 191.316 7.91797 191.316 8.3086 curveto
191.316 8.71094 191.438 9.03516 191.684 9.28125 curveto
191.902 9.4961 192.164 9.60547 192.465 9.60547 curveto
192.813 9.60547 193.086 9.50781 193.285 9.3125 curveto
193.477 9.1211 193.574 8.8711 193.574 8.5586 curveto
193.574 8.46484 193.563 8.375 193.539 8.29297 curveto
 closepath fill
newpath 194.574 10.4883 moveto
194.648 10.4883 194.711 10.4609 194.766 10.4102 curveto
194.816 10.3555 194.844 10.293 194.844 10.2188 curveto
194.844 10.1445 194.816 10.082 194.766 10.0273 curveto
194.711 9.97656 194.648 9.94922 194.574 9.94922 curveto
194.5 9.94922 194.438 9.97656 194.383 10.0273 curveto
194.332 10.082 194.305 10.1445 194.305 10.2188 curveto
194.305 10.293 194.332 10.3555 194.383 10.4102 curveto
194.438 10.4609 194.5 10.4883 194.574 10.4883 curveto
 closepath fill
newpath 194.398 7.11328 moveto
194.398 9.19531 lineto
194.063 9.19531 lineto
194.063 9.5625 lineto
194.832 9.5625 lineto
194.832 7.11328 lineto
 closepath fill
newpath 197.234 7.11328 moveto
197.234 8.53906 lineto
197.234 8.79688 197.195 8.98047 197.117 9.08594 curveto
197.039 9.1875 196.906 9.24219 196.723 9.24219 curveto
196.625 9.24219 196.52 9.21094 196.41 9.15234 curveto
196.305 9.09375 196.219 9.01953 196.164 8.9336 curveto
196.164 7.11328 lineto
195.727 7.11328 lineto
195.727 9.5625 lineto
196.023 9.5625 lineto
196.164 9.2461 lineto
196.305 9.48828 196.539 9.60547 196.863 9.60547 curveto
197.402 9.60547 197.668 9.28125 197.668 8.6289 curveto
197.668 7.11328 lineto
 closepath fill
newpath 198.402 7.25781 moveto
198.559 7.67188 lineto
198.801 7.51172 198.996 7.4336 199.145 7.4336 curveto
199.41 7.4336 199.547 7.54688 199.547 7.76953 curveto
199.547 7.9336 199.418 8.07031 199.156 8.1875 curveto
198.957 8.28125 198.82 8.34766 198.754 8.39453 curveto
198.684 8.4414 198.625 8.4961 198.574 8.5586 curveto
198.523 8.61719 198.484 8.67969 198.457 8.75 curveto
198.434 8.8164 198.422 8.89063 198.422 8.96484 curveto
198.422 9.16797 198.496 9.32422 198.641 9.4375 curveto
198.785 9.55078 198.98 9.60547 199.215 9.60547 curveto
199.395 9.60547 199.617 9.55078 199.891 9.4375 curveto
199.766 9.03516 lineto
199.594 9.17188 199.422 9.24219 199.246 9.24219 curveto
199.145 9.24219 199.055 9.21875 198.984 9.16797 curveto
198.914 9.11719 198.879 9.0586 198.879 8.98438 curveto
198.879 8.82422 198.969 8.70703 199.145 8.625 curveto
199.457 8.48438 lineto
199.648 8.39844 199.785 8.29688 199.871 8.1875 curveto
199.961 8.07422 200.004 7.9375 200.004 7.76953 curveto
200.004 7.55078 199.926 7.3789 199.773 7.2539 curveto
199.617 7.1289 199.406 7.0664 199.133 7.0664 curveto
198.875 7.0664 198.633 7.13281 198.402 7.25781 curveto
 closepath fill
newpath 202.398 9.36328 moveto
202.184 9.05469 lineto
202.141 9.10156 202.063 9.14063 201.949 9.17969 curveto
201.84 9.22266 201.727 9.24219 201.621 9.24219 curveto
201.383 9.24219 201.195 9.15625 201.059 8.99219 curveto
200.918 8.82813 200.848 8.60156 200.848 8.3125 curveto
200.848 8.02734 200.922 7.8086 201.063 7.66016 curveto
201.203 7.50781 201.398 7.4336 201.652 7.4336 curveto
201.848 7.4336 202.043 7.50781 202.242 7.66016 curveto
202.414 7.29297 lineto
202.18 7.14453 201.891 7.0664 201.547 7.0664 curveto
201.215 7.0664 200.938 7.17969 200.719 7.40234 curveto
200.5 7.6289 200.391 7.92969 200.391 8.3125 curveto
200.391 8.70313 200.504 9.01563 200.734 9.2539 curveto
200.957 9.48828 201.27 9.60547 201.66 9.60547 curveto
201.789 9.60547 201.926 9.57813 202.074 9.52734 curveto
202.219 9.47266 202.328 9.41797 202.398 9.36328 curveto
 closepath fill
newpath 204.547 7.11328 moveto
204.547 8.65234 lineto
204.547 8.83594 204.504 8.97656 204.414 9.08203 curveto
204.324 9.1875 204.195 9.24219 204.035 9.24219 curveto
203.93 9.24219 203.824 9.21094 203.719 9.14844 curveto
203.609 9.08594 203.531 9.01563 203.473 8.9336 curveto
203.473 7.11328 lineto
203.039 7.11328 lineto
203.039 10.5664 lineto
203.473 10.5664 lineto
203.473 9.29297 lineto
203.531 9.38281 203.625 9.45703 203.754 9.51563 curveto
203.883 9.57813 204.016 9.60547 204.152 9.60547 curveto
204.41 9.60547 204.613 9.51953 204.762 9.35156 curveto
204.91 9.17969 204.984 8.94531 204.984 8.65234 curveto
204.984 7.11328 lineto
 closepath fill
newpath 207.117 7.39453 moveto
206.945 7.17578 206.676 7.0664 206.32 7.0664 curveto
206.125 7.0664 205.961 7.13672 205.82 7.27734 curveto
205.68 7.41406 205.609 7.58984 205.609 7.79688 curveto
205.609 8.04297 205.719 8.2539 205.934 8.42578 curveto
206.152 8.59766 206.43 8.6836 206.766 8.6836 curveto
206.855 8.6836 206.961 8.66406 207.074 8.625 curveto
207.074 8.3164 lineto
206.938 8.34766 206.844 8.35938 206.789 8.35938 curveto
206.57 8.35938 206.391 8.30469 206.25 8.1914 curveto
206.113 8.07813 206.043 7.94531 206.043 7.79297 curveto
206.043 7.53906 206.191 7.41016 206.492 7.41016 curveto
206.711 7.41016 206.906 7.51563 207.074 7.72266 curveto
207.074 8.3164 lineto
207.074 8.625 lineto
207.074 9.01953 206.898 9.21875 206.547 9.21875 curveto
206.273 9.21875 206.066 9.14453 205.918 9 curveto
205.734 9.36328 lineto
205.816 9.42969 205.93 9.48828 206.078 9.53516 curveto
206.223 9.58203 206.363 9.60547 206.496 9.60547 curveto
206.852 9.60547 207.109 9.52734 207.27 9.36328 curveto
207.43 9.20313 207.512 8.94531 207.512 8.59375 curveto
207.512 7.71484 lineto
207.512 7.5 207.574 7.35938 207.703 7.28516 curveto
207.703 7.07031 lineto
207.523 7.07031 207.391 7.09375 207.305 7.14453 curveto
207.219 7.19531 207.156 7.27734 207.117 7.39453 curveto
 closepath fill
newpath 209.59 10.1758 moveto
209.5 10.207 209.418 10.2227 209.34 10.2227 curveto
209.211 10.2227 209.102 10.1719 209.012 10.0703 curveto
208.926 9.96875 208.883 9.84375 208.883 9.6875 curveto
208.883 9.64844 208.887 9.60547 208.898 9.5625 curveto
209.395 9.5625 lineto
209.395 9.19531 lineto
208.898 9.19531 lineto
208.898 7.11328 lineto
208.461 7.11328 lineto
208.461 9.19531 lineto
208.105 9.19531 lineto
208.105 9.5625 lineto
208.461 9.5625 lineto
208.461 9.875 208.539 10.1172 208.691 10.2969 curveto
208.848 10.4766 209.051 10.5664 209.301 10.5664 curveto
209.43 10.5664 209.566 10.543 209.711 10.4961 curveto
 closepath fill
newpath 210.211 9.21875 moveto
209.926 9.21875 lineto
209.926 9.5625 lineto
210.211 9.5625 lineto
210.211 10.0742 lineto
210.645 10.2383 lineto
210.645 9.5625 lineto
211.316 9.5625 lineto
211.316 9.21875 lineto
210.645 9.21875 lineto
210.645 8.0039 lineto
210.645 7.79688 210.68 7.64844 210.75 7.5625 curveto
210.82 7.47656 210.93 7.4336 211.086 7.4336 curveto
211.195 7.4336 211.313 7.46094 211.43 7.51953 curveto
211.496 7.13672 lineto
211.313 7.08984 211.117 7.0664 210.902 7.0664 curveto
210.707 7.0664 210.543 7.14063 210.41 7.28516 curveto
210.277 7.42969 210.211 7.60938 210.211 7.82813 curveto
 closepath fill
newpath 214.523 20.5664 moveto
214.754 20.27339 215.332 19.7461 216.734 21.08589 curveto
218.141 22.4297 217.426 21.8633 218.219 20.1367 curveto
219.02 18.41411 219.492 19.3789 219.535 19.7188 curveto
219.641 20.5664 219.355 22.22661 219.164 22.89839 curveto
219.008 23.46089 218.02 23.72661 217.633 23.4375 curveto
217.266 23.168 216.301 22.0547 215.648 21.83589 curveto
215 21.6172 215.508 22.25 215.328 23.28911 curveto
215.148 24.3242 214.754 24.793 214.348 24.6094 curveto
214.07 24.4883 213.488 23.8945 213.188 24.0195 curveto
212.543 24.27339 211.668 25.0313 209.902 24.1289 curveto
206.703 22.5 209.078 25.832 209.078 25.832 curveto
209.078 25.832 211.438 29.5273 210.195 31.4336 curveto
208.98 33.2969 206.82 30.0117 206.289 28.9922 curveto
205.574 27.6406 205.02 25.793 204.406 23.0039 curveto
204.055 21.3828 202.086 20.7773 201.594 21.4063 curveto
201.063 22.082 201.164 24.7813 199.316 23.6172 curveto
197.465 22.457 197.523 20.1875 196.363 22.7383 curveto
195.203 25.28911 194.051 23.6211 193.902 23.3477 curveto
193.695 22.9688 193.816 22.1406 193.504 21.9531 curveto
193.148 21.7461 192.691 22.4648 192.418 22.5625 curveto
192.125 22.66411 190.266 21.0977 189.434 19.4648 curveto
188.234 17.1094 185.914 22.1172 186.102 22.4688 curveto
186.266 22.7773 190.773 29.0625 191.316 29.9805 curveto
191.891 30.957 192.309 31.27339 192.656 31.3242 curveto
193.008 31.375 197.293 32.4258 200.586 35.7344 curveto
203.379 38.53911 203.109 39.418 202.535 40.1875 curveto
202.363 40.41411 202.109 40.582 201.77 40.6953 curveto
200.102 41.2617 196.238 37.6758 195.887 37.33589 curveto
196.688 36.78911 lineto
198.98 38.91411 198.926 38.7383 199.25 38.9492 curveto
199.855 39.3398 201.242 40.0977 201.66 39.7227 curveto
202.129 39.3086 201.93 38.41411 201.203 37.6328 curveto
200.453 36.832 198.301 34.6445 196.41 33.5977 curveto
195.133 32.8906 190.039 30.3164 194.887 35.0352 curveto
194.887 35.0352 lineto
195.633 35.7656 196.199 36.33589 196.688 36.78911 curveto
195.887 37.33589 lineto
195.309 36.7813 191.902 32.9727 191.656 32.46089 curveto
191.406 31.9492 185.453 32.0977 185.453 32.0977 curveto
184.766 31.75 185.539 31.4805 185.539 31.4805 curveto
185.539 31.4805 188.227 31.1211 189.895 31.207 curveto
191.344 31.2852 190.5 30.332 190.285 30.0586 curveto
189.043 28.4648 186.887 25.0625 186.098 24.125 curveto
185.34 23.2305 183.922 24.0781 183.52 24.1563 curveto
183.113 24.2383 180.863 24.5469 181.395 22.668 curveto
182.41 23.0781 lineto
182.461 23.6953 183.109 23.0742 183.855 23.10161 curveto
184.609 23.1328 183.609 22.4023 183.344 22.2852 curveto
183.344 22.2852 lineto
183.09 22.1836 182.383 22.7656 182.41 23.0781 curveto
181.395 22.668 lineto
181.93 20.78911 183.633 21.6523 184.367 21.4844 curveto
184.59 21.4375 185.109 21.1914 185.238 20.9063 curveto
185.52 20.2773 185.887 19.5742 186.191 19.0977 curveto
186.707 18.3008 188.91 16.1797 190.414 19.0625 curveto
192.066 22.2305 193.227 21.0586 193.344 19.3555 curveto
193.461 17.6563 194 18.3008 194.617 18.582 curveto
195.23 18.8633 194.688 20.0352 194.73 21.582 curveto
194.777 23.125 196.176 20.8086 196.207 20.1914 curveto
196.23 19.7383 197.051 19.6719 197.895 20.0273 curveto
198.734 20.3828 197.902 21.03911 199.055 22.125 curveto
200.207 23.21089 200.422 20.72661 200.691 20.125 curveto
200.914 19.625 202.039 18.7305 202.711 20.02339 curveto
203.301 21.1563 204.504 20.7813 204.52 19.14839 curveto
205.375 19.4883 lineto
204.918 21.0508 206.02 22.3828 206.02 22.3828 curveto
206.02 22.3828 206.488 23.0039 206.793 23.0039 curveto
206.031 23.3164 lineto
205.664 22.9023 205.32 22.5703 205.598 23.7305 curveto
205.887 24.9063 205.738 24.41411 205.879 24.918 curveto
206.027 25.47661 206.566 27.4102 206.75 27.8125 curveto
207.012 28.3867 207.078 28.6523 207.781 29.6953 curveto
207.781 29.6953 208.27 30.3164 208.363 30.4102 curveto
208.742 30.7969 210.156 31.4727 209.48 28.9063 curveto
208.941 26.8633 208.516 26.3945 207.59 24.9102 curveto
207.59 24.9102 lineto
207.414 24.6211 207.082 25.27339 206.445 24.4492 curveto
206.18 24.10161 206.355 23.6875 206.031 23.3164 curveto
206.793 23.0039 lineto
207.168 23.0039 207.918 22.8672 207.68 21.957 curveto
207.68 21.957 lineto
207.441 21.043 207.027 19.5938 206.676 19.1406 curveto
206.43 18.832 205.832 17.9297 205.375 19.4883 curveto
204.52 19.14839 lineto
204.535 17.793 205.52 17.5117 205.898 17.5 curveto
206.031 17.4922 206.184 17.5078 206.398 17.5938 curveto
207.145 17.9023 208.32 19.53911 208.305 20.97661 curveto
208.281 23.418 212.246 23.8086 211.965 22.9805 curveto
211.758 22.3867 210.879 20.6289 211.953 20.668 curveto
213.027 20.707 212.57 21.625 213.559 22.6836 curveto
214.547 23.7383 214.137 21.0625 214.523 20.5664 curveto
 closepath fill
newpath 201.359 29.7617 moveto
201.242 28.2578 202.172 28.7578 202.172 28.7578 curveto
203.895 29.6758 202.508 30.47661 202.508 30.47661 curveto
202.508 30.47661 201.484 31.2695 201.359 29.7617 curveto
 closepath fill
newpath 226.469 15.7773 moveto
226.379 16.0078 226.145 16.3086 225.445 15.4492 curveto
224.375 14.1328 224.48 14.9297 224.371 15.7813 curveto
224.355 15.9258 224.242 16.6094 223.754 16.8711 curveto
223.305 17.1055 221.48 17.71089 221.934 18.0703 curveto
223.047 18.9492 223.016 18.8828 223.344 19.25 curveto
223.738 19.6992 225.031 21.3555 224.926 23.0078 curveto
224.805 24.9336 222.059 24.71089 222.059 24.71089 curveto
220.176 24.4219 221.031 22.7813 222.332 22.9844 curveto
223.77 23.21089 223.43 21.9492 223.336 21.6172 curveto
223.336 21.6172 lineto
223.332 21.5938 223.324 21.5742 223.32 21.5586 curveto
223.336 21.6172 lineto
223.336 21.6172 lineto
223.336 21.6133 223.188 21.2148 222.883 20.7344 curveto
222.473 20.0898 221.855 19.2422 221.477 18.8203 curveto
221.23 18.5469 219.793 17.6133 220.832 17.1172 curveto
222.551 16.2969 223.891 14.3047 223.016 13.7578 curveto
222.402 13.3789 217.527 11.1211 216.438 10.6367 curveto
216.957 9.95313 lineto
222.105 12.4531 222.336 12.5938 222.336 12.5938 curveto
222.707 12.7422 223.422 13.2227 222.965 12.4453 curveto
222.965 12.4453 lineto
222.965 12.4453 221.168 8.6836 220.945 8.33594 curveto
220.672 7.91797 219.273 5.92969 217.184 5.625 curveto
215.09 5.32422 214.055 6.14063 214.008 7.17969 curveto
213.961 8.16797 214.66 8.83984 216.957 9.95313 curveto
216.438 10.6367 lineto
215.383 10.1719 213.031 9.32422 213.051 7.05078 curveto
213.074 4.60547 216.449 4.625 217.191 4.7539 curveto
219.328 5.1289 220.461 6.30078 221.266 7.27734 curveto
221.949 8.10938 223.566 11.5039 223.754 12.1055 curveto
223.914 12.6133 224.551 14.5117 225.457 14.7656 curveto
226.477 15.0547 226.598 15.4336 226.469 15.7773 curveto
 closepath fill
newpath 221.445 29.0195 moveto
220.988 29.1992 219.648 28.4883 220.07 27.3398 curveto
220.504 26.1719 223.539 28.1992 221.445 29.0195 curveto
 closepath fill
newpath 174.574 37.1523 moveto
174.281 38.71089 lineto
173.785 37.16411 lineto
173.605 37.16411 lineto
173.098 38.71089 lineto
172.809 37.1523 lineto
172.488 37.1523 lineto
172.953 39.582 lineto
173.152 39.582 lineto
173.695 37.8086 lineto
174.191 39.582 lineto
174.395 39.582 lineto
174.895 37.1523 lineto
 closepath fill
newpath 175.445 39.5273 moveto
175.496 39.5273 175.543 39.5078 175.578 39.4727 curveto
175.617 39.4336 175.633 39.3906 175.633 39.3398 curveto
175.633 39.2852 175.617 39.2422 175.578 39.2031 curveto
175.543 39.168 175.496 39.14839 175.445 39.14839 curveto
175.391 39.14839 175.348 39.168 175.313 39.2031 curveto
175.273 39.2422 175.254 39.2852 175.254 39.3398 curveto
175.254 39.3906 175.273 39.4336 175.309 39.4727 curveto
175.348 39.5078 175.391 39.5273 175.445 39.5273 curveto
 closepath fill
newpath 175.324 37.14839 moveto
175.324 38.6172 lineto
175.086 38.6172 lineto
175.086 38.875 lineto
175.629 38.875 lineto
175.629 37.14839 lineto
 closepath fill
newpath 176.273 38.6328 moveto
176.074 38.6328 lineto
176.074 38.875 lineto
176.273 38.875 lineto
176.273 39.2344 lineto
176.578 39.35161 lineto
176.578 38.875 lineto
177.051 38.875 lineto
177.051 38.6328 lineto
176.578 38.6328 lineto
176.578 37.7773 lineto
176.578 37.6328 176.602 37.5273 176.652 37.4688 curveto
176.703 37.4063 176.781 37.375 176.887 37.375 curveto
176.965 37.375 177.047 37.3945 177.133 37.4336 curveto
177.176 37.168 lineto
177.051 37.1328 176.91 37.1172 176.762 37.1172 curveto
176.625 37.1172 176.508 37.168 176.414 37.2695 curveto
176.32 37.3711 176.273 37.5 176.273 37.6523 curveto
 closepath fill
newpath 177.504 36.6797 moveto
177.668 36.875 lineto
177.848 36.7578 178.012 36.6953 178.164 36.6953 curveto
178.301 36.6953 178.41 36.7227 178.488 36.7695 curveto
178.57 36.8164 178.609 36.875 178.609 36.9453 curveto
178.609 37.08589 178.508 37.1563 178.309 37.1563 curveto
178.273 37.1563 178.211 37.14839 178.121 37.1289 curveto
178.031 37.1133 177.961 37.1055 177.91 37.1055 curveto
177.664 37.1055 177.543 37.1953 177.543 37.3828 curveto
177.543 37.4375 177.57 37.53911 177.629 37.582 curveto
177.688 37.6289 177.758 37.66411 177.84 37.6836 curveto
177.598 37.7969 177.477 37.9961 177.477 38.2773 curveto
177.477 38.457 177.543 38.6055 177.668 38.72661 curveto
177.793 38.8477 177.949 38.9063 178.133 38.9063 curveto
178.152 38.6758 lineto
178.043 38.6758 177.953 38.6367 177.883 38.5586 curveto
177.813 38.4805 177.777 38.3867 177.777 38.27339 curveto
177.777 38.14839 177.813 38.0469 177.879 37.9648 curveto
177.945 37.8828 178.039 37.8398 178.152 37.8398 curveto
178.266 37.8398 178.355 37.8789 178.418 37.96089 curveto
178.48 38.03911 178.512 38.1445 178.512 38.27339 curveto
178.512 38.3867 178.48 38.4805 178.41 38.5586 curveto
178.34 38.6367 178.254 38.6758 178.152 38.6758 curveto
178.152 38.6758 lineto
178.133 38.9063 lineto
178.301 38.9063 178.434 38.8711 178.531 38.8008 curveto
178.684 38.9844 lineto
178.883 38.7969 lineto
178.699 38.6602 lineto
178.777 38.5586 178.816 38.4219 178.816 38.2578 curveto
178.816 38.08589 178.762 37.9414 178.652 37.8203 curveto
178.547 37.7031 178.402 37.6367 178.227 37.6172 curveto
178.008 37.5977 lineto
177.941 37.5898 177.898 37.5742 177.848 37.5547 curveto
177.77 37.5273 177.766 37.4727 177.777 37.4336 curveto
177.789 37.3906 177.816 37.3555 177.922 37.3555 curveto
177.969 37.3555 178.055 37.375 178.152 37.3906 curveto
178.25 37.4063 178.32 37.418 178.367 37.418 curveto
178.539 37.418 178.672 37.375 178.766 37.293 curveto
178.859 37.2148 178.906 37.10161 178.906 36.957 curveto
178.906 36.7969 178.836 36.6719 178.695 36.5742 curveto
178.551 36.47661 178.371 36.4258 178.152 36.4258 curveto
178.043 36.4258 177.926 36.4453 177.801 36.4844 curveto
177.68 36.5273 177.578 36.6211 177.504 36.6797 curveto
 closepath fill
newpath 179.293 37.6367 moveto
179.293 39.582 lineto
179.598 39.582 lineto
179.598 37.6914 lineto
179.598 37.5977 179.625 37.52339 179.68 37.4727 curveto
179.73 37.418 179.801 37.3906 179.887 37.3906 curveto
179.887 37.1172 lineto
179.492 37.1172 179.293 37.293 179.293 37.6367 curveto
 closepath fill
newpath 180.559 39.5273 moveto
180.609 39.5273 180.656 39.5078 180.691 39.4727 curveto
180.73 39.4336 180.746 39.3906 180.746 39.3398 curveto
180.746 39.2852 180.73 39.2422 180.691 39.2031 curveto
180.656 39.168 180.609 39.14839 180.559 39.14839 curveto
180.508 39.14839 180.461 39.168 180.426 39.2031 curveto
180.387 39.2422 180.367 39.2852 180.367 39.3398 curveto
180.367 39.3906 180.387 39.4336 180.422 39.4727 curveto
180.461 39.5078 180.504 39.5273 180.559 39.5273 curveto
 closepath fill
newpath 180.438 37.14839 moveto
180.438 38.6172 lineto
180.199 38.6172 lineto
180.199 38.875 lineto
180.742 38.875 lineto
180.742 37.14839 lineto
 closepath fill
newpath 182.73 37.9844 moveto
181.488 37.9844 lineto
181.496 38.2031 lineto
182.449 38.2031 lineto
182.449 38.3281 182.41 38.4297 182.332 38.5156 curveto
182.25 38.6055 182.133 38.64839 181.988 38.64839 curveto
181.988 38.64839 lineto
181.852 38.64839 181.738 38.6055 181.645 38.5156 curveto
181.555 38.4336 181.508 38.3281 181.496 38.2031 curveto
181.488 37.9844 lineto
181.488 37.7813 181.543 37.625 181.652 37.5156 curveto
181.75 37.4219 181.875 37.375 182.027 37.375 curveto
182.203 37.375 182.352 37.4258 182.469 37.5273 curveto
182.598 37.3086 lineto
182.551 37.2617 182.477 37.2188 182.379 37.1836 curveto
182.258 37.1406 182.121 37.1172 181.969 37.1172 curveto
181.754 37.1172 181.57 37.1914 181.418 37.3398 curveto
181.25 37.5 181.164 37.7188 181.164 37.9922 curveto
181.164 38.2773 181.25 38.5039 181.426 38.6758 curveto
181.578 38.8281 181.762 38.9063 181.973 38.9063 curveto
182.219 38.9063 182.41 38.83589 182.551 38.6992 curveto
182.688 38.5664 182.754 38.3906 182.754 38.168 curveto
182.754 38.10161 182.746 38.03911 182.73 37.9844 curveto
 closepath fill
newpath 184.266 37.1523 moveto
184.266 37.2773 lineto
184.137 37.4219 lineto
184.207 37.4531 184.246 37.4844 184.266 37.5195 curveto
184.266 38.47661 lineto
184.188 38.5898 184.082 38.64839 183.945 38.64839 curveto
183.781 38.64839 183.648 38.5898 183.551 38.4648 curveto
183.449 38.3438 183.398 38.1875 183.398 38 curveto
183.398 37.582 183.586 37.375 183.965 37.375 curveto
184.012 37.375 184.07 37.3906 184.137 37.4219 curveto
184.266 37.2773 lineto
184.16 37.1719 184.004 37.1211 183.801 37.1211 curveto
183.586 37.1211 183.41 37.1953 183.277 37.35161 curveto
183.141 37.5078 183.074 37.71089 183.074 37.9688 curveto
183.074 38.22661 183.152 38.4492 183.309 38.6328 curveto
183.461 38.8164 183.645 38.9063 183.859 38.9063 curveto
184.035 38.9063 184.172 38.8633 184.266 38.7813 curveto
184.266 39.582 lineto
184.57 39.582 lineto
184.57 37.1523 lineto
 closepath fill
newpath 187.191 37.1523 moveto
187.191 37.2773 lineto
187.063 37.4219 lineto
187.129 37.4531 187.172 37.4844 187.191 37.5195 curveto
187.191 38.47661 lineto
187.113 38.5898 187.008 38.64839 186.871 38.64839 curveto
186.707 38.64839 186.574 38.5898 186.477 38.4648 curveto
186.371 38.3438 186.324 38.1875 186.324 38 curveto
186.324 37.582 186.512 37.375 186.891 37.375 curveto
186.938 37.375 186.996 37.3906 187.063 37.4219 curveto
187.191 37.2773 lineto
187.082 37.1719 186.93 37.1211 186.727 37.1211 curveto
186.512 37.1211 186.336 37.1953 186.203 37.35161 curveto
186.066 37.5078 186 37.71089 186 37.9688 curveto
186 38.22661 186.078 38.4492 186.23 38.6328 curveto
186.387 38.8164 186.57 38.9063 186.785 38.9063 curveto
186.961 38.9063 187.098 38.8633 187.191 38.7813 curveto
187.191 39.582 lineto
187.496 39.582 lineto
187.496 37.1523 lineto
 closepath fill
newpath 189.387 37.9844 moveto
188.145 37.9844 lineto
188.152 38.2031 lineto
189.105 38.2031 lineto
189.105 38.3281 189.066 38.4297 188.988 38.5156 curveto
188.906 38.6055 188.789 38.64839 188.645 38.64839 curveto
188.645 38.64839 lineto
188.508 38.64839 188.395 38.6055 188.301 38.5156 curveto
188.215 38.4336 188.164 38.3281 188.152 38.2031 curveto
188.145 37.9844 lineto
188.145 37.7813 188.199 37.625 188.309 37.5156 curveto
188.406 37.4219 188.531 37.375 188.688 37.375 curveto
188.859 37.375 189.008 37.4258 189.125 37.5273 curveto
189.254 37.3086 lineto
189.207 37.2617 189.133 37.2188 189.035 37.1836 curveto
188.914 37.1406 188.777 37.1172 188.625 37.1172 curveto
188.41 37.1172 188.227 37.1914 188.074 37.3398 curveto
187.906 37.5 187.82 37.7188 187.82 37.9922 curveto
187.82 38.2773 187.906 38.5039 188.082 38.6758 curveto
188.234 38.8281 188.418 38.9063 188.629 38.9063 curveto
188.875 38.9063 189.066 38.83589 189.207 38.6992 curveto
189.344 38.5664 189.41 38.3906 189.41 38.168 curveto
189.41 38.10161 189.402 38.03911 189.387 37.9844 curveto
 closepath fill
newpath 190.715 38.5781 moveto
190.648 38.625 190.582 38.64839 190.516 38.64839 curveto
190.406 38.64839 190.313 38.5977 190.23 38.5 curveto
190.152 38.39839 190.109 38.2773 190.109 38.1406 curveto
190.109 37.14839 lineto
189.805 37.14839 lineto
189.805 38.875 lineto
190.109 38.875 lineto
190.109 38.5977 lineto
190.223 38.8047 190.387 38.9063 190.605 38.9063 curveto
190.664 38.9063 190.742 38.89839 190.844 38.8789 curveto
 closepath fill
showpage
%%EOF
}

