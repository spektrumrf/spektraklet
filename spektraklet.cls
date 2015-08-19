\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{spektraklet}[2015/01/07 Class Spektraklet]


% Base class of this class
\LoadClass[a5paper, twoside]{article}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Packages

%-----------------------------------------------------------------------------------
% The class uses UTF8 as input encoding. The files created should use this as well.
% It has language support for swedish by default, if an article in another language
% will be added, then list of langauges in the babel argument has to be updated.
%-----------------------------------------------------------------------------------
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[swedish]{babel}

%-----------------------------------------------------------------------------------
% Mathematical packages for equations and stuff.
%-----------------------------------------------------------------------------------
\RequirePackage{amsthm}
\RequirePackage{amsfonts}         
\RequirePackage{amsmath}
\RequirePackage{amssymb}

%-----------------------------------------------------------------------------------
% More control over the paragraphs.
%-----------------------------------------------------------------------------------
\RequirePackage{parskip}
\RequirePackage[normalem]{ulem}	% Used for use with \sout{} command, to 
								% write strikethrough text.

\RequirePackage{etoolbox}

\RequirePackage[top=2.0cm, bottom=2.5cm, left=1cm, right=1cm]{geometry}
\RequirePackage{needspace}	% Prevent page break after a sectioning command
\RequirePackage[svgnames]{xcolor}

\RequirePackage{lastpage}
\RequirePackage{fancyhdr}

\RequirePackage{hyperref}
\hypersetup{colorlinks=true}

\RequirePackage{tikz}
\usetikzlibrary{
	calc,
	positioning,
}

\RequirePackage[export]{adjustbox}
\RequirePackage{wrapfig}
\RequirePackage{float}
\RequirePackage{caption}

\RequirePackage{multicol}

\RequirePackage{xparse}
\RequirePackage{pgfkeys}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Options

%% Toggle page check
\newif\if@pagecheck\@pagecheckfalse
\DeclareOption{pagecheck}{
	\@pagechecktrue
}

\ExecuteOptions{}
\ProcessOptions\relax



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configuration

\renewcommand{\familydefault}{\sfdefault}
\setlength{\parskip}{0.5\baselineskip}

%% Colors
\colorlet{titlebg}{Black}
\colorlet{titlefg}{White}
\colorlet{sectionfg}{Black}


%-----------------------------------------------------------------------------------
% Calculates if the page count is dividable with four when compiling. It shows a 
% message with how many pages there currently is if an error occurs.
%
% This helps with the booklet layout. Normally a book or booklet has even number
% of pages, to be able to glue or tie them together.
%-----------------------------------------------------------------------------------
\AfterEndDocument{
	\if@pagecheck
		\pgfmathparse{mod(\thepage - 1,4)==0}
	    \ifnum \pgfmathresult=1
	    \else
	    	\pgfmathparse{\thepage - 1}
	    	\ClassError{- The page count (\pgfmathresult) isn't dividable by four (4) -}
    \fi
    \fi
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Header and Footer

\tikzstyle{foliostyle}=[fill=Lavender, text=MidnightBlue, inner sep=5pt, semicircle]

\pagestyle{fancy}
\fancyhf{}

\fancyfoot[LE,RO]{\thepage}

\renewcommand{\headrulewidth}{0.8pt}
% \addtolength{\headheight}{\baselineskip}
\addtolength{\headheight}{24.88675pt}
\renewcommand{\headrule}{\color{LightGray}\hrule}
\fancyhead[LO,RE]{ \textcolor{gray}{\slshape SPEKTRAKLET} }
\fancyhead[LE,RO]{ \textcolor{gray}{\slshape \leftmark} }





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Table of contents

\renewcommand*\l@section{\color{sectionfg}\def\@linkcolor{sectionfg}\@dottedtocline{1}{1.5em}{2.3em}}
\def\contentsline#1#2#3#4{%
	\ifx\\#4\\%
	\csname l@#1\endcsname{#2}{#3}%
	\else
	\csname l@#1\endcsname{\hyper@linkstart{link}{#4}{#2}\hyper@linkend}{%
		\hyper@linkstart{link}{#4}{#3}\hyper@linkend
	}%
	\fi
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Title page style

\renewcommand\titlepage{
	\my@titlepage
}

\tikzstyle{titlebgstyle}=[
	fill=titlebg
]

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
% The cover page, including the Header, the number of the newsletter and an
% cover image.
%
% Arguments:
%	Mandatory:
%		#1 = Publication number
%		#2 = cover image width
%		#3 = cover image path
%	Optional:
%		#4 = dx of cover image
%		#5 = dy of cover image
%
\DeclareDocumentCommand{\my@titlepage}{ m m m O{0cm, 0cm} }{
	\thispagestyle{empty}
	\noindent
	\begin{center}
	\begin{tikzpicture}[remember picture, overlay]
		\fill [titlebgstyle, shift={(0mm, 0mm)}] (-\paperwidth/2, 3.5cm) rectangle (\paperwidth/2, -0.5cm);
		\node [titlepagestyle, shift={(0mm, 0mm)}] {\bfseries\Huge Spektraklet\\
								\bfseries\footnotesize #1/\the\year};
	\end{tikzpicture}
	\end{center}
	\par
	\begin{tikzpicture}[remember picture, overlay]
		\node [shift={(#4)}] at (current page.center) {\includegraphics[width=#2]{#3}};
	\end{tikzpicture}
	\newpage
}


%-----------------------------------------------------------------------------------
% Properties of the newsletter. All of these have default values, that can be
% overriden.
%-----------------------------------------------------------------------------------
\DeclareDocumentCommand{\PublicationInformation}{%
		O{är ett språkrör för de som studerar - eller låter bli att studera - matematik, fysik, kemi eller datavetenskap på svenska vid Helsingfors universitet.}
	}{\def\publicationinformation{#1}}

\DeclareDocumentCommand{\PublicationSupport}{ O{Spektraklet får HUS-stöd för föreningstidningar.} }{\def\publicationsupport{#1}}

\DeclareDocumentCommand{\PublisherName}{ O{Spektrum rf} }{\def\publishername{#1}}
\DeclareDocumentCommand{\PublisherAddress}{ O{Exactum} }{\def\publisheraddress{#1}}
\DeclareDocumentCommand{\PublisherPostalOfficeBox}{ O{PB 68} }{\def\publisherpostalofficebox{#1}}
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

%%----------------------------------------------------------------------------------
% Helper function to create the different fields if they dont exist. This function
% should not be called manually if one doesn't know what's going on.
%-----------------------------------------------------------------------------------
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
		
	\vspace{0.5cm}
	\ifx\publicationsupport\@undefined
		\PublicationSupport
	\fi
	\publicationsupport
	
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
	
	
	\newpage
}


\DeclareDocumentCommand{\lastpage}{ m m O{0cm, 0cm} }{
	\newpage	
	\fancyhf{}
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


%%----------------------------------------------------------------------------------
% Exteonsion to the Wrap figure environment. Possible usage situations are when the
% scriber wants to add a picture in the middle of available text. The text will
% then wrap around the figure.
%
% This environment variable has default values on the different commands provided
% by the wrapfig environment.
%-----------------------------------------------------------------------------------
\ExplSyntaxOn
\DeclareDocumentCommand{\wrappicture}{ m O{5cm} O{L} o }{
	%-------------------------------------------------------------------------------
	% If the second argument is empty
	%-------------------------------------------------------------------------------
	\tl_if_empty:nTF{#2}
	{
		%---------------------------------------------------------------------------
		% If the second and the third arguments are empty
		%---------------------------------------------------------------------------
		\tl_if_empty:nTF{#3}
		{
			\begin{wrapfigure}{L}{5cm}
				\includegraphics[width=5cm]{#1}
				\IfNoValueF{#4}{ \caption*{#4} }
			\end{wrapfigure}
		}
		{
			\begin{wrapfigure}{#3}{5cm}
				\includegraphics[width=5cm]{#1}
				\IfNoValueF{#4}{ \caption*{#4} }
			\end{wrapfigure}
		}
	}
	{
		%---------------------------------------------------------------------------
		% If the second argument exist but the third is empty.
		%---------------------------------------------------------------------------
		\tl_if_empty:nTF{#3}
		{
			\begin{wrapfigure}{L}{#2}
				\includegraphics[width=#2]{#1}
				\IfNoValueF{#4}{ \caption*{#4} }
			\end{wrapfigure}
		}
		{
			\begin{wrapfigure}{#3}{#2}
				\includegraphics[width=#2]{#1}
				\IfNoValueF{#4}{ \caption*{#4} }
			\end{wrapfigure}
		}
	}
}
\ExplSyntaxOff

% Set up the keys. Only the ones directly under /picture
% can be accepted as options to the \picture macro.
\pgfkeys{
	/picture/.is family, /picture,
	%-------------------------------------------------------------------------------
	% default options selected if the user doesn't pass the specific one.
	%-------------------------------------------------------------------------------
	default/.style = 
	{
		width = \columnwidth,
		align = center,
		float = here
	},
	%-------------------------------------------------------------------------------
	% Here are the options that a user can pass
	%-------------------------------------------------------------------------------
	width/.estore in = \pictureWidth,
	align/.estore in = \pictureAlign,
	float/.style = {floats/#1/.get = \pictureFloat},
	%-------------------------------------------------------------------------------
	% Float dictionary
	%-------------------------------------------------------------------------------
	floats/.cd,
		here/.initial = H,
		top/.initial = !t,
		bottom/.initial = !b,
}

% This command declaration is overwriting the default LaTeX \picture command.
\ExplSyntaxOn
\DeclareDocumentCommand{\picture}{ o m o }{%
	\pgfkeys{/picture, default, #1}%
	% Expand the variable with the float placement manually.
	% The figure-environment can't handle this by default.
	\expandafter\figure\expandafter[\pictureFloat]
		% Insert the graphics for the picture.
		\includegraphics[width=\pictureWidth, \pictureAlign]{#2}
		% Optional caption (if the [] is not present in the command
		% it'll skip the caption.
		\IfNoValueF{#3}{\caption*{#3}}
	\endfigure
}
\ExplSyntaxOff


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Section style

\renewcommand\section{
  \@ifstar
  \my@sectionstar
  \my@section
}

%% Note: to justify, text width must be set to \textwidth - 2*(inner sep).
\tikzstyle{sectionstyle}=[
  inner sep=5pt,
  text width=\textwidth - 10pt,
  left color=sectionfg!100!white,
  right color=sectionfg!50!white,
  rounded corners,
  text=titlefg,
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


\DeclareDocumentEnvironment{twocolumns}{}
{
	\begin{multicols}{2}
}
{
	\end{multicols}
}


%%----------------------------------------------------------------------------------
% Creates the body for the article. By providing the header and the author in the
% mandatory fields all articles will be consistent and have the same information.
% An extra optional argument is provided if one considers adding more stuff to the
% end of the article or just wants to skip the automatic new page.
%
% Arguments:
%	Mandatory:
%		#1	The article header
%		#2	The author's name
%	Optional:
%		#3	After author stuff
%-----------------------------------------------------------------------------------
\DeclareDocumentEnvironment{artikel}{ m m o }
{%
	\section*{#1}
}
{%
	\hfill{\large\ #2}
	\IfNoValueTF{#3}
	{ \newpage }
	{ #3 }
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Svammel commands and environments

% Align the svammel-box to the left
\DeclareDocumentCommand{\SvammelLeft}{ m m O{2cm} }
{
	\path let \p1=(p) in node (p) at (-\textwidth/2 + 1cm, \y1 - #3) [right, align=left] {#1\\- #2};
}

% Align the svammel-box to the right
\DeclareDocumentCommand{\SvammelRight}{ m m O{2cm} }
{
	\path let \p1=(p) in node (p) at (\textwidth/2 - 1cm, \y1 - #3) [left, align=left] {#1\\- #2};
}

% Align the svammel-box to the center
\DeclareDocumentCommand{\SvammelCenter}{ m m O{2cm} }
{
	\path let \p1=(p) in node (p) at (0, \y1 - #3) [align=left] {#1\\- #2};
}


% Start a new svammel page.
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


% Start the svammel section.
\DeclareDocumentEnvironment{svammel}{ O{Alltid nu som då händer det ju sig att fiffiga spektrumiter kläcker ur sig livsvisdomar. Vi på spektraklet gör vårt bästa för att samla åt oss dessa livsvisdomar för att sen dela vidare dem åt våra läsare. För att göra detta behöver vi dock er hjälp; kom ihåg e-mailen ''svammel@spektrum.fi'' nästa gång ni hör något som skulle kunna klassa som svammel.} }
{
	\section*{Svammel}
	#1
}
{
}



\endinput

