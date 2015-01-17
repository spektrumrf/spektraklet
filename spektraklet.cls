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

\RequirePackage{wrapfig}


\RequirePackage{multicol}

\RequirePackage{xparse}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Options

%%% Toggle reflection
%\newif\if@mirrors\@mirrorsfalse
%\DeclareOption{mirrors}{
%	\@mirrorstrue
%}
%
%%% Colors
%\newif\if@red\@redfalse
%\DeclareOption{red}{
%	\@redtrue
%}
%
%\ExecuteOptions{}
%\ProcessOptions\relax



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configuration

\renewcommand{\familydefault}{\sfdefault}
\setlength{\parskip}{0.5\baselineskip}

%% Colors
\colorlet{titlebg}{Black}
\colorlet{titlefg}{White}
\colorlet{sectionfg}{Black}

%\if@red
%\colorlet{toctitle}{DarkGray!50!black}
%\colorlet{titlebg}{DarkRed}
%\colorlet{titlefg}{FireBrick!50}
%\colorlet{titletxt}{DarkRed}
%\colorlet{sectionfg}{DarkRed}
%\colorlet{subsectionfg}{Crimson!50!black}
%\colorlet{subsubsectionfg}{LightSteelBlue!60!black}
%\fi



% Calculates if the page count is dividable with four when compiling.
% It shows a message with how many pages there currently is if an
% error occurs.
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

\fancyfoot[LE,RO]{\thepage}

\renewcommand{\headrulewidth}{0.8pt}
\addtolength{\headheight}{\baselineskip}
\renewcommand{\headrule}{\color{LightGray}\hrule}
\fancyhead[LO,RE]{ \textcolor{gray}{\slshape SPEKTRAKLET} }
\fancyhead[LE,RO]{ \textcolor{gray}{\slshape \leftmark} }





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Table of contents

\renewcommand*\l@section{\color{Black}\def\@linkcolor{Black}\@dottedtocline{1}{1.5em}{2.3em}}
\def\contentsline#1#2#3#4{%
	\ifx\\#4\\%
	\csname l@#1\endcsname{#2}{#3}%
	\else
	\csname l@#1\endcsname{\hyper@linkstart{link}{#4}{#2}\hyper@linkend}{%
		\hyper@linkstart{link}{#4}{#3}\hyper@linkend
	}%
	\fi
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Title page style

\renewcommand\titlepage{
	\my@titlepage
}

\tikzstyle{titlepagestyle}=[
	text=titlefg,
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


\DeclareDocumentCommand{\wrappicture}{ m m O{L} }{
	\begin{wrapfigure}{#3}{#1}
		\centering
		\includegraphics[width=#1]{#2}
	\end{wrapfigure}
}

\DeclareDocumentCommand{\picture}{ m m }{
	\begin{figure*}[ht!]
		\centering
		\includegraphics[width=#1]{#2}
	\end{figure*}
}

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




\DeclareDocumentEnvironment{ledaren}{ m }
{
	\section*{Ledaren}
}
{
	\hfill\large\ #1\newpage
}

\DeclareDocumentEnvironment{ordforandespalten}{ m }
{
	\section*{Ordförandespalten}
}
{
	\hfill\large\ #1\newpage
}


\DeclareDocumentEnvironment{TwoColumns}{}
{
	\begin{multicols}{2}
}
{
	\end{multicols}
}


\DeclareDocumentEnvironment{article}{ m m }
{%
	\section*{#1}
}
{%
	\hfill\large\ #2\newpage
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Svammel commands and environments

\DeclareDocumentCommand{\SvammelLeft}{m m O{2cm}}{
	\path let \p1=(p) in node (p) at (-\textwidth/2 + 1cm, \y1 - #3) [right, align=left] {#1\\- #2};
}
\DeclareDocumentCommand{\SvammelRight}{m m O{2cm}}{
	\path let \p1=(p) in node (p) at (\textwidth/2 - 1cm, \y1 - #3) [left, align=left] {#1\\- #2};
}

\DeclareDocumentEnvironment{svammelpage}{}
{
	\begin{center}
	\begin{tikzpicture}[remember picture, overlay]
		\path let \p1=(0,0) in node (p) at (0cm, 1cm) {};
}
{
	\end{tikzpicture}
	\end{center}
	\newpage
}

\DeclareDocumentEnvironment{svammel}{ O{Alltid nu som då händer det ju sig att fiffiga spektrumiter kläcker ur sig livsvisdomar. Vi på spektraklet gör vårt bästa för att samla åt oss dessa livsvisdomar för att sen dela vidare dem åt våra läsare. För att göra detta behöver vi dock er hjälp; kom ihåg e-mailen ''svammel@spektrum.fi'' nästa gång ni hör något som skulle kunna klassa som svammel.} }
{
	\section*{Svammel}
	#1
}
{
}



\endinput

