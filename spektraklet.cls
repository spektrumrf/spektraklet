\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{spektraklet}[2015/01/07 Class Spektraklet]


% Base class of this class
\LoadClass[a5paper, twoside]{article}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Packages


\RequirePackage[swedish]{babel}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}

\RequirePackage{etoolbox}
\RequirePackage{lmodern}

\RequirePackage[top=2.5cm, bottom=2.5cm, left=1cm, right=1cm]{geometry}
\RequirePackage{needspace}% Prevent page break after a sectioning command
\RequirePackage[svgnames]{xcolor}

\RequirePackage{lastpage}
\RequirePackage{fancyhdr}

\RequirePackage{hyperref}
\hypersetup{colorlinks=true}

\RequirePackage{tikz}
\usetikzlibrary{
	calc,
	decorations.pathmorphing,
	fadings,
	shadows,
	shapes.geometric,
	shapes.misc,
	positioning,
}


\RequirePackage{multicol}

\RequirePackage{xparse}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Options

%% Toggle reflection
\newif\if@mirrors\@mirrorsfalse
\DeclareOption{mirrors}{
	\@mirrorstrue
}

%% Colors
\newif\if@red\@redfalse
\DeclareOption{red}{
	\@redtrue
}

\ExecuteOptions{}
\ProcessOptions\relax



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configuration

\renewcommand{\familydefault}{\sfdefault}
\setlength{\parskip}{0.5\baselineskip}

%% Colors
\colorlet{toctitle}{DarkGray!50!black}
\colorlet{titlebg}{Black}
\colorlet{titlefg}{White}
\colorlet{titletxt}{MidnightBlue}
\colorlet{sectionfg}{Black}
\colorlet{subsectionfg}{SteelBlue}
\colorlet{subsubsectionfg}{LightSteelBlue!60!black}

\if@red
\colorlet{toctitle}{DarkGray!50!black}
\colorlet{titlebg}{DarkRed}
\colorlet{titlefg}{FireBrick!50}
\colorlet{titletxt}{DarkRed}
\colorlet{sectionfg}{DarkRed}
\colorlet{subsectionfg}{Crimson!50!black}
\colorlet{subsubsectionfg}{LightSteelBlue!60!black}
\fi


\AtEndDocument{%
}


\AfterEndDocument{
	\pgfmathparse{mod(\thepage - 1,4)==0}
    \ifnum \pgfmathresult=1
    \else
    	\pgfmathparse{\thepage - 1}
    	\ClassError{- The page count (\pgfmathresult) isn't dividable by four (4) -}
    \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Header and Footer

\tikzstyle{foliostyle}=[fill=Lavender, text=MidnightBlue, inner sep=5pt, semicircle]

\pagestyle{fancy}
\fancyhf{}
%\fancyfoot[C]{
%	\vskip 3pt
%	\begin{tikzpicture}
%		\node[foliostyle]
%		{\bfseries\thepage};
%	\end{tikzpicture}
%}

\fancyfoot[LE,RO]{\thepage}

\renewcommand{\headrulewidth}{0.8pt}
\addtolength{\headheight}{\baselineskip}
\renewcommand{\headrule}{\color{LightGray}\hrule}
\fancyhead[LE]{ \textcolor{gray}{\slshape \rightmark} }
\fancyhead[RO]{ \textcolor{gray}{\slshape \leftmark} }





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Table of contents

\newcommand{\sectiontoccolor}{sectionfg}
\newcommand{\subsectiontoccolor}{subsectionfg}
\newcommand{\subsubsectiontoccolor}{subsubsectionfg}

\renewcommand*\l@section{\color{\sectiontoccolor}\def\@linkcolor{\sectiontoccolor}\@dottedtocline{1}{1.5em}{2.3em}}
\renewcommand*\l@subsection{\color{\subsectiontoccolor}\def\@linkcolor{\subsectiontoccolor}\@dottedtocline{1}{2.3em}{3.1em}}
\renewcommand*\l@subsubsection{\color{\subsubsectiontoccolor}\def\@linkcolor{\subsubsectiontoccolor}\@dottedtocline{1}{3.1em}{3.9em}}
\def\contentsline#1#2#3#4{%
	\ifx\\#4\\%
	\csname l@#1\endcsname{#2}{#3}%
	\else
	\csname l@#1\endcsname{\hyper@linkstart{link}{#4}{#2}\hyper@linkend}{%
		\hyper@linkstart{link}{#4}{#3}\hyper@linkend
	}%
	\fi
}

%% New title format -- 'section' is used by default.
%\newcommand{\tocformat}[1]{{\Huge\bf#1}}
%
%\renewcommand\tableofcontents{%
%	\tocformat{
%		\textcolor{toctitle}{\contentsname}
%		\@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}
%	}%
%	\@starttoc{toc}%
%}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Title page style

\renewcommand\titlepage{
	\my@titlepage
}

\tikzstyle{titlepagestyle}=[
%	fill=titlebg,
	text=titlefg,
%	inner sep=0.3cm,
	shift={(0, 1.1cm)},
	minimum width=\paperwidth,
	minimum height=1.2cm,
	scale=2.5,
	align=right,
	rectangle
]

%%
% #1 = Publication number
% #2 = cover image width
% #3 = cover image path
%	#4 = dx of cover image
%	#5 = dy of cover image
\DeclareDocumentCommand{\my@titlepage}{ m m m O{0cm, 0cm} }{
	\thispagestyle{empty}
	\noindent
	\begin{center}
	\begin{tikzpicture}[remember picture, overlay]
		\fill [black] (-\paperwidth/2, 3.5cm) rectangle (\paperwidth/2, -0.5cm);
		\node [titlepagestyle] {\bfseries\Huge Spektraklet\\
								\bfseries\footnotesize #1/\the\year};
	\end{tikzpicture}
	\end{center}
	\par
	\begin{tikzpicture}[remember picture, overlay]
		\node [shift={(#4)}] at (current page.center) {\includegraphics[width=#2]{#3}};
	\end{tikzpicture}
	\newpage
}


\DeclareDocumentCommand{\PublicationInformation}{ O{är ett språkrör för de som studerar - eller låter bli att studera - matematik, fysik, kemi eller datavetenskap på svenska vid Helsingfors universitet.} }{\def\publicationinformation{#1}}

\DeclareDocumentCommand{\PublicationSupport}{ O{Spektraklet får HUS-stöd för föreningstidningar.} }{\def\publicationsupport{#1}}

\DeclareDocumentCommand{\PublisherName}{ O{Spektrum rf} }{\def\publishername{#1}}
\DeclareDocumentCommand{\PublisherAddress}{ O{Kemiska institutionens svenska avdelning} }{\def\publisheraddress{#1}}
\DeclareDocumentCommand{\PublisherPostalOfficeBox}{ O{PB 55} }{\def\publisherpostalofficebox{#1}}
\DeclareDocumentCommand{\PublisherPostalCode}{ O{00014 Helsingfors universitet} }{\def\publisherpostalcode{#1}}

\newcommand{\PublisherInformation}{
	\definepublisherformation
	\publishername\\
	\publisheraddress\\
	\publisherpostalofficebox\\
	\publisherpostalcode
}
\newcommand{\PublisherInformationOneLine}{
	\definepublisherformation
	\noindent\publishername~$\bullet$~\publisheraddress~$\bullet$~\publisherpostalofficebox~$\bullet$~\publisherpostalcode
}

\newcommand{\definepublisherformation}{
	\ifx\publishername\@undefined
		\PublisherName
	\fi
	\ifx\publisheraddress\@undefined
		\PublisherAddress
	\fi
	\ifx\publisherpostalofficebox\@undefined
		\PublisherPostalOfficeBox
	\fi
	\ifx\publisherpostalcode\@undefined
		\PublisherPostalCode
	\fi
}

\DeclareDocumentCommand{\ChiefEditor}{ m }{\def\chiefeditor{#1}}
\DeclareDocumentCommand{\ManagingEditor}{ m }{\def\managingeditor{#1}}
\DeclareDocumentCommand{\Editors}{ m }{\def\editors{#1}}
\DeclareDocumentCommand{\CoverPageAuthor}{ m }{\def\coverpageauthor{#1}}

\DeclareDocumentCommand{\contentpage}{}{
	\tableofcontents
	\vfill
	\begin{minipage}[t]{0.55\linewidth}
	\ifx\publicationinformation\@undefined
		\PublicationInformation
	\fi
	\noindent\textbf{Spektraklet}~\publicationinformation

	\vspace{0.5cm}
	\noindent\textbf{Utgivare}\\
	\PublisherInformation
	
	\end{minipage}
	\hfill
	\begin{minipage}[t]{0.35\linewidth}
	
	\noindent\textbf{Chefredaktör}\\
	\chiefeditor
	
	\vspace{0.5cm}
	\noindent\textbf{Redaktionschef}\\
	\managingeditor
	
	\vspace{0.5cm}
	\noindent\textbf{Redaktörer}\\
	\editors
	
	\vspace{0.5cm}
	\noindent\textbf{Pärmbild}\\
	\coverpageauthor
	
	\end{minipage}
	
	\vspace{0.5cm}
	\ifx\publicationsupport\@undefined
		\PublicationSupport
	\fi
	\publicationsupport
	
	\newpage
}


\DeclareDocumentCommand{\lastpage}{ m m O{0cm, 0cm} }{
	\newpage	
	\fancyhf{}
%	\renewcommand{\headrulewidth}{4pt}
	\renewcommand{\headrule}{}
	\begin{tikzpicture}[remember picture, overlay]
		\node [shift={(#3)}] at (current page.center) {\includegraphics[width=#1]{#2}};
	\end{tikzpicture}
	\vfill
	\cfoot{
		\begin{scriptsize}
			Avs: \PublisherInformationOneLine
		\end{scriptsize}
	}
}

%TODO Add a 'lastpage' command, contaning an image and the PublisherInformationOneLine

%TODO add a way of easily importing images

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Section style

\renewcommand\section{
  \@ifstar
  \my@sectionstar
  \my@section
}

%% Note: to justify, text width must be set to \textwidth - 2*(inner sep).
\tikzstyle{sectionstyle}=[
  inner sep=5pt,
  text width=\textwidth-10pt,
  left color=sectionfg!100!white,
  right color=sectionfg!50!white,
  rounded corners,
  text=Ivory,
  rectangle
]

\newcommand\my@section[1]{
  \stepcounter{section}
  {\Large\needspace{\baselineskip}}
  \noindent
  \begin{tikzpicture}
    \node[sectionstyle] {\bfseries\Large\thesection\quad#1};
  \end{tikzpicture}
  \par
  \phantomsection
  \addcontentsline{toc}{section}{\thesection~#1}
  \sectionmark{#1}
}

\newcommand{\sectionmarkstar}[1]{\markboth{\MakeUppercase{#1}}{}}

\newcommand\my@sectionstar[1]{
  {\Large\needspace{\baselineskip}}
  \noindent
  \begin{tikzpicture}
    \node[sectionstyle] {\bfseries\Large#1};
  \end{tikzpicture}
  \par
  \phantomsection
  \addcontentsline{toc}{section}{#1}
  \sectionmarkstar{#1}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Subsection style

\renewcommand\subsection{
  \@ifstar
  \my@subsectionstar
  \my@subsection
}

\tikzstyle{subsectionstyle}=[
  left color=subsectionfg!50!white,
  right color=subsectionfg!100!white,
  text=Ivory,
  ellipse,
  inner sep=5pt
]

\newcommand\my@subsection[1]{
  \stepcounter{subsection}
  {\Large\needspace{\baselineskip}}
  \noindent  
  \begin{tikzpicture}
    \node[subsectionstyle,anchor=west] (number) at (0,0) {\bfseries\Large\thesubsection};
    \if@mirrors
    \node[above right,subsectionfg,anchor=south west] at ($(number.east)+(0.1,-0.1)$) {\large\bfseries#1};
    \node[yscale=-1, scope fading=south, opacity=0.4, above, anchor=south west, subsectionfg] at ($(number.east)+(0.1,0.1)$) {\large\bfseries#1};
    \else
    \node[above right,subsectionfg,anchor=west] at ($(number.east)+(0.1,0)$) {\large\bfseries#1};
    \fi
  \end{tikzpicture}
  \par
  \phantomsection
  \addcontentsline{toc}{subsection}{\thesubsection~#1}
}

\newcommand\my@subsectionstar[1]{
  {\Large\needspace{\baselineskip}}
  \noindent
  \begin{tikzpicture}
    \node[subsectionstyle,anchor=west] (number) at (0,0) {\bfseries\Large\phantom{1}};
    %
    \if@mirrors
    \node[above right,subsectionfg,anchor=south west] at ($(number.east)+(0.1,-0.1)$) {\large\bfseries#1};
    \node[yscale=-1, scope fading=south, opacity=0.4, above, anchor=south west, subsectionfg] at ($(number.east)+(0.1,0.1)$) {\large\bfseries#1};
    \else
    \node[above right,subsectionfg,anchor=west] at ($(number.east)+(0.1,0)$) {\large\bfseries#1};
    \fi
  \end{tikzpicture}
  \par
  \phantomsection
  \addcontentsline{toc}{subsection}{#1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Subsubsection style

\renewcommand\subsubsection{
  \@ifstar
  \my@subsubsectionstar
  \my@subsubsection
}

\tikzstyle{subsubsectionstyle}=[
  left color=subsubsectionfg!50!white,
  right color=subsubsectionfg!100!white,
  text=Ivory,
  shape=trapezium,
  inner sep=5pt
]

\newcommand\my@subsubsection[1]{
  \stepcounter{subsubsection}
  \noindent  
  \begin{tikzpicture}
        \node[subsubsectionstyle] (number) {\bfseries\large\thesubsubsection};
        \node[subsubsectionfg, right of=number, anchor=west] {\large\bfseries#1};
  \end{tikzpicture}
  \par
  \phantomsection
  \addcontentsline{toc}{subsubsection}{\thesubsubsection~#1}
}

\newcommand\my@subsubsectionstar[1]{
  \noindent
  \begin{tikzpicture}
        \node[subsubsectionstyle] (number) {\bfseries\large\vphantom{1}};
        \node[subsubsectionfg, right of=number, anchor=west] {\large\bfseries#1};
  \end{tikzpicture}
  \par
  \phantomsection
  \addcontentsline{toc}{subsubsection}{#1}
}





\DeclareDocumentEnvironment{article}{m m O{2}}
{%
	\section*{#1}
	\begin{multicols}{#3}
}
{%
	\end{multicols}\hfill\large\ #2\newpage
}




\endinput

