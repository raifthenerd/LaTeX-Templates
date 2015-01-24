\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{RAIF}[2015/01/06 RAIF: Personal LaTeX templates]

% cancel compiling if the engine is not XeTeX
\RequirePackage{iftex}
\ifXeTeX\else
    \ClassError{RAIF}{Requires XeTeX!}{No LuaTeX, pdfLaTeX, etc.}
\fi

\RequirePackage{xkeyval}

% hyperref option : borderlinks (memoir default) / colorlinks (beamer default) / hidelinks
\newif\ifcolorlinks\colorlinksfalse
\newif\ifhidelinks\hidelinksfalse
\DeclareOptionX{hidelinks}{
    \hidelinkstrue\colorlinksfalse
    \PassOptionsToPackage{\CurrentOption}{hyperref}
}
\DeclareOptionX{borderlinks}{
    \ifhidelinks\else
        \PassOptionsToPackage{colorlinks=false}{hyperref}
    \fi
}
\DeclareOptionX{colorlinks}{
    \ifhidelinks\else
        \PassOptionsToPackage{colorlinks=true}{hyperref}
    \fi
}

% typography option : allserif (memoir default) / mathserif / allsans (beamer default)
\newif\ifdefaultsans\defaultsansfalse
\newif\ifmathsans\mathsansfalse
\DeclareOptionX{allserif}{\defaultsansfalse\mathsansfalse}
\DeclareOptionX{mathserif}{\defaultsanstrue\mathsansfalse}
\DeclareOptionX{allsans}{\mathsanstrue\defaultsanstrue}

% base class : memoir (default) / beamer
\newcommand{\baseclass}{}
\newif\ifmemoir\memoirfalse
\newif\ifbeamer\beamerfalse
\DeclareOptionX{memoir}{
    \memoirtrue\beamerfalse
    \renewcommand{\baseclass}{memoir}
    \ExecuteOptionsX{allserif}
    \ExecuteOptionsX{borderlinks}
}
\DeclareOptionX{beamer}{
    \memoirfalse\beamertrue
    \renewcommand{\baseclass}{beamer}
    \PassOptionsToClass{notheorems}{\baseclass}
    \PassOptionsToClass{compress}{\baseclass}
    \ExecuteOptionsX{allsans}
    \ExecuteOptionsX{colorlinks}
    \ExecuteOptionsX{titlepage}
}
\ExecuteOptionsX{memoir}

% hangul option
\newif\ifhangul\hangulfalse
\DeclareOptionX{hangul}{
    \hangultrue
    \PassOptionsToPackage{\CurrentOption}{xetexko}
}

% some memoir options (e.g. article / oneside) that used in this class
\newif\ifarticle\articlefalse
\DeclareOptionX{article}{
    \ifmemoir
        \articletrue
        \PassOptionsToClass{\CurrentOption}{\baseclass}
    \fi
}
\newif\ifoneside\onesidefalse
\DeclareOptionX{oneside}{
    \ifmemoir
        \onesidetrue
        \PassOptionsToClass{\CurrentOption}{\baseclass}
    \fi
}

% beamer section page
\newif\ifsectionpage\sectionpagefalse
\DeclareOptionX{sectionpage}{\sectionpagetrue}

% bibliography options
\newif\iffootcite\footcitefalse
\DeclareOptionX{footcite}{
    \footcitetrue
}
\newif\ifbst\bstfalse
\DeclareOptionX{bst}[]{
    \newcommand\bst{#1}
    \bsttrue
}

% pass memoir / beamer options
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{\baseclass}}
\ProcessOptionsX
\LoadClass{\baseclass}

% define color scheme
\RequirePackage{xcolor}
% Bootstrap-like color scheme
\definecolor{black}{HTML}{000000}
\definecolor{gray-darker}{HTML}{222222}
\definecolor{gray-dark}{HTML}{333333}
\definecolor{gray}{HTML}{555555}
\definecolor{gray-light}{HTML}{777777}
\definecolor{gray-lighter}{HTML}{EEEEEE}
\definecolor{white}{HTML}{FFFFFF}
\definecolor{primary}{HTML}{428BCA}
\definecolor{success}{HTML}{5CB85C}
\definecolor{success-bg}{HTML}{DFF0D8}
\definecolor{success-text}{HTML}{3C763D}
\definecolor{info}{HTML}{5BC0DE}
\definecolor{info-bg}{HTML}{D9EDF7}
\definecolor{info-text}{HTML}{31708F}
\definecolor{warning}{HTML}{F0AD4E}
\definecolor{warning-bg}{HTML}{FCF8E3}
\definecolor{warning-text}{HTML}{8A6D3B}
\definecolor{danger}{HTML}{D9534F}
\definecolor{danger-bg}{HTML}{F2DEDE}
\definecolor{danger-text}{HTML}{A94442}
\colorlet{background}{white}
\colorlet{text}{gray-dark}
\definecolor{listing-bg}{HTML}{F5F5F5}
\definecolor{listing-border}{HTML}{CCCCCC}
\definecolor{listing-kwd}{HTML}{2F6F9F}
\definecolor{listing-str}{HTML}{D44950}
\definecolor{code-bg}{HTML}{F9F2F4}
\definecolor{code-text}{HTML}{C7254E}
\colorlet{kbd-bg}{gray}
\colorlet{kbd-text}{gray-lighter}
% set document color
\makeatletter
\newcommand{\globalcolor}[1]{\color{#1}\global\let\default@color\current@color}
\makeatother
\AtBeginDocument{\globalcolor{text}\pagecolor{background}}

% allows using mathematical expression
\RequirePackage{amsmath,amssymb,amsfonts,amsthm,mathtools}
\DeclareMathOperator*{\argmax}{arg\,max}
\DeclareMathOperator*{\argmin}{arg\,min}
\theoremstyle{plain}
\ifhangul
    \ifmemoir\ifarticle
        \newtheorem{theorem}{정리}
    \else
        \newtheorem{theorem}{정리}[chapter]
    \fi\else
        \newtheorem{theorem}{정리}
    \fi
    \newtheorem{corollary}{따름정리}[theorem]
    \newtheorem{lemma}[theorem]{보조정리}
\else
    \ifmemoir\ifarticle
        \newtheorem{theorem}{Theorem}
    \else
        \newtheorem{theorem}{Theorem}[chapter]
    \fi\else
        \newtheorem{theorem}{Theorem}
    \fi
    \newtheorem{corollary}{Corollary}[theorem]
    \newtheorem{lemma}[theorem]{Lemma}
\fi
\theoremstyle{definition}
\ifhangul
    \ifmemoir\ifarticle
        \newtheorem{definition}{정의}
        \newtheorem{example}{예제}
    \else
        \newtheorem{definition}{정의}[chapter]
        \newtheorem{example}{예제}[chapter]
    \fi\else
        \newtheorem{definition}{정의}
        \newtheorem{example}{예제}
    \fi
\else
    \ifmemoir\ifarticle
        \newtheorem{definition}{Definition}
        \newtheorem{example}{Example}
    \else
        \newtheorem{definition}{Definition}[chapter]
        \newtheorem{example}{Example}[chapter]
    \fi\else
        \newtheorem{definition}{Definition}
        \newtheorem{example}{Example}
    \fi
\fi
\theoremstyle{remark}
\ifhangul
    \newtheorem*{remark}{참고}
\else
    \newtheorem*{remark}{Remark}
\fi

% allows using algorithm environment
\ifmemoir\ifarticle
    \RequirePackage{algorithm}
\else
    \RequirePackage[chapter]{algorithm}
\fi\else
    \RequirePackage{algorithm}
\fi
\RequirePackage[noend]{algpseudocode}
\ifhangul
    \makeatletter
        \renewcommand{\ALG@name}{알고리즘}
        \renewcommand{\listalgorithmname}{\ALG@name~차례}
    \makeatother
\fi
\ifmemoir
    \newlistof{listofalgorithms}{loa}{\listalgorithmname}
    \newlistentry{algorithm}{loa}{0}
\fi
\algnewcommand\algorithmicto{\textbf{to}}
\algnewcommand\algorithmicdownto{\textbf{downto}}
\algdef{SE}[FOR]{ForTo}{EndForTo}[2]{\algorithmicfor\ #1 \algorithmicto\ #2 \algorithmicdo}{\algorithmicend\ \algorithmicfor}
\algdef{SnE}[FOR]{ForTo}{EndForTo}[2]{\algorithmicfor\ #1 \algorithmicto\ #2 \algorithmicdo}
\algdef{SE}[FOR]{ForDownTo}{EndForDownTo}[2]{\algorithmicfor\ #1 \algorithmicdownto\ #2 \algorithmicdo}{\algorithmicend\ \algorithmicfor}
\algdef{SnE}[FOR]{ForDownTo}{EndForDownTo}[2]{\algorithmicfor\ #1 \algorithmicdownto\ #2 \algorithmicdo}

% graphic package : tikz
\RequirePackage{tikz}

% various packages for table
\RequirePackage{booktabs,array,multirow}
% allows customizing list environments
\RequirePackage[inline]{enumitem}
\setlist[enumerate,1]{label=\arabic*.}
\setlist[enumerate,2]{label=(\alph*)}
\setlist[enumerate,3]{label=\roman*.}
\setlist[enumerate,4]{label=\Alph*.}
\setlist[itemize,1]{label=$\triangleright$}
\setlist[itemize,2]{label=-}
\setlist[itemize,3]{label=$\ast$}
\setlist[itemize,4]{label=$\cdot$}

% hyperlink option
\RequirePackage[
    breaklinks,
    pdfusetitle,
    pdfencoding=auto,
    pdfstartview={FitH},
    bookmarks=true,
    linkbordercolor=danger,
    citebordercolor=success,
    urlbordercolor=primary,
]{hyperref}
\ifbeamer
    \hypersetup {
        linkcolor=text,
        citecolor=success,
        urlcolor=primary,
        filecolor=info,
    }
\fi\ifmemoir
    \hypersetup {
        linkcolor=danger,
        citecolor=success,
        urlcolor=primary,
        filecolor=info,
    }
\fi

% advanced citations, references, captions
\iffootcite
    \RequirePackage[notes,natbib]{biblatex-chicago}
    \bibliography{bibliography}
\else
    \RequirePackage[sort&compress]{natbib}
    \ifbst
        \bibliographystyle{\bst}
    \else
        \bibliographystyle{chicago}
    \fi
    \newcommand{\autocite}[2][]{
        \ifx&#1&
            \cite{#2}
        \else
            \cite[#1]{#2}
        \fi
    }
    \newcommand{\printbibliography}{\bibliography{bibliography}}
\fi
\RequirePackage{cleveref,caption}
\newcommand{\crefrangeconjunction}{--}
\newcommand{\crefmiddleconjunction}{, }
\crefformat{section}{\S#2#1#3}
\Crefformat{section}{\S#2#1#3}
\crefformat{subsection}{\S#2#1#3}
\Crefformat{subsection}{\S#2#1#3}
\crefformat{subsubsection}{\S#2#1#3}
\Crefformat{subsubsection}{\S#2#1#3}
\crefmultiformat{section}%
    {\S#2#1#3}{ and \S#2#1#3}{, \S#2#1#3}{ and \S#2#1#3}
\crefrangemultiformat{section}%
    {\S#3#1#4--\S#5#2#6}{ and \S#3#1#4--\S#5#2#6}{, \S#3#1#4--\S#5#2#6}{ and \S#3#1#4--#5#2#6}
\Crefmultiformat{section}%
    {\S#2#1#3}{ and \S#2#1#3}{, \S#2#1#3}{ and \S#2#1#3}
\Crefrangemultiformat{section}%
    {\S#3#1#4--\S#5#2#6}{ and \S#3#1#4--\S#5#2#6}{, \S#3#1#4--\S#5#2#6}{ and \S#3#1#4--#5#2#6}
\crefmultiformat{section}%
    {\S#2#1#3}{ and \S#2#1#3}{, \S#2#1#3}{ and \S#2#1#3}
\crefrangemultiformat{subsection}%
    {\S#3#1#4--\S#5#2#6}{ and \S#3#1#4--\S#5#2#6}{, \S#3#1#4--\S#5#2#6}{ and \S#3#1#4--#5#2#6}
\Crefmultiformat{subsection}%
    {\S#2#1#3}{ and \S#2#1#3}{, \S#2#1#3}{ and \S#2#1#3}
\Crefrangemultiformat{subsection}%
    {\S#3#1#4--\S#5#2#6}{ and \S#3#1#4--\S#5#2#6}{, \S#3#1#4--\S#5#2#6}{ and \S#3#1#4--#5#2#6}
\crefmultiformat{subsubsection}%
    {\S#2#1#3}{ and \S#2#1#3}{, \S#2#1#3}{ and \S#2#1#3}
\crefrangemultiformat{subsubsection}%
    {\S#3#1#4--\S#5#2#6}{ and \S#3#1#4--\S#5#2#6}{, \S#3#1#4--\S#5#2#6}{ and \S#3#1#4--#5#2#6}
\Crefmultiformat{subsubsection}%
    {\S#2#1#3}{ and \S#2#1#3}{, \S#2#1#3}{ and \S#2#1#3}
\Crefrangemultiformat{subsubsection}%
    {\S#3#1#4--\S#5#2#6}{ and \S#3#1#4--\S#5#2#6}{, \S#3#1#4--\S#5#2#6}{ and \S#3#1#4--#5#2#6}
\crefname{figure}{figure}{figures}
\Crefname{figure}{Figure}{Figures}
\crefname{equation}{equation}{equations}
\Crefname{equation}{Equation}{Equations} 
\crefname{lstlisting}{listing}{listings}
\Crefname{lstlisting}{Listing}{Listings}
\ifhangul
    \DeclareCaptionLabelFormat{hangul}{<#1 #2>}
    \captionsetup{labelformat=hangul,labelsep=space}
    \makeatletter
        \ifmemoir
            \footmarkstyle{#1) }
        \fi\ifbeamer
            \renewcommand{\@makefntext}[1]{\noindent\makebox[1.5em][r]\@thefnmark) #1}
        \fi
    \makeatother
    \RequirePackage{ulem}
    \crefname{figure}{그림}{그림}
    \Crefname{figure}{그림}{그림}
    \crefname{table}{표}{표}
    \Crefname{table}{표}{표}
    \crefformat{part}{#2#1#3편}
    \Crefformat{part}{#2#1#3편}
    \crefmultiformat{part}%
        {#2#1#3편}{\와 #2#1#3편}{, #2#1#3편}{\와 #2#1#3편}
    \crefrangemultiformat{part}%
        {#3#1#4--#5#2#6편}{\와 #3#1#4--#5#2#6편}{, #3#1#4--#5#2#6편}{\와 #3#1#4--#5#2#6편}
    \Crefmultiformat{part}%
        {#2#1#3편}{\와 #2#1#3편}{, #2#1#3편}{\와 #2#1#3편}
    \Crefrangemultiformat{part}%
        {#3#1#4--#5#2#6편}{\와 #3#1#4--#5#2#6편}{, #3#1#4--#5#2#6편}{\와 #3#1#4--#5#2#6편}
    \crefname{appendix}{부록}{부록}
    \Crefname{appendix}{부록}{부록}
    \crefname{equation}{식}{식}
    \Crefname{equation}{식}{식} 
    \crefname{item}{항목}{항목}
    \Crefname{item}{항목}{항목}
    \crefformat{chapter}{#2#1#3장}
    \Crefformat{chapter}{#2#1#3장}
    \crefmultiformat{chapter}%
        {#2#1#3장}{\와 #2#1#3장}{, #2#1#3장}{\와 #2#1#3장}
    \crefrangemultiformat{chapter}%
        {#3#1#4--#5#2#6장}{\와 #3#1#4--#5#2#6장}{, #3#1#4--#5#2#6장}{\와 #3#1#4--#5#2#6장}
    \Crefmultiformat{chapter}%
        {#2#1#3장}{\와 #2#1#3장}{, #2#1#3장}{\와 #2#1#3장}
    \Crefrangemultiformat{chapter}%
        {#3#1#4--#5#2#6장}{\와 #3#1#4--#5#2#6장}{, #3#1#4--#5#2#6장}{\와 #3#1#4--#5#2#6장}
    \crefmultiformat{section}%
        {\S#2#1#3}{\와 \S#2#1#3}{, \S#2#1#3}{\와 \S#2#1#3}
    \crefrangemultiformat{section}%
        {\S#3#1#4--\S#5#2#6}{\와 \S#3#1#4--\S#5#2#6}{, \S#3#1#4--\S#5#2#6}{\와 \S#3#1#4--#5#2#6}
    \Crefmultiformat{section}%
        {\S#2#1#3}{\와 \S#2#1#3}{, \S#2#1#3}{\와 \S#2#1#3}
    \Crefrangemultiformat{section}%
        {\S#3#1#4--\S#5#2#6}{\와 \S#3#1#4--\S#5#2#6}{, \S#3#1#4--\S#5#2#6}{\와 \S#3#1#4--#5#2#6}
    \crefmultiformat{section}%
        {\S#2#1#3}{\와 \S#2#1#3}{, \S#2#1#3}{\와 \S#2#1#3}
    \crefrangemultiformat{subsection}%
        {\S#3#1#4--\S#5#2#6}{\와 \S#3#1#4--\S#5#2#6}{, \S#3#1#4--\S#5#2#6}{\와 \S#3#1#4--#5#2#6}
    \Crefmultiformat{subsection}%
        {\S#2#1#3}{\와 \S#2#1#3}{, \S#2#1#3}{\와 \S#2#1#3}
    \Crefrangemultiformat{subsection}%
        {\S#3#1#4--\S#5#2#6}{\와 \S#3#1#4--\S#5#2#6}{, \S#3#1#4--\S#5#2#6}{\와 \S#3#1#4--#5#2#6}
    \crefmultiformat{subsubsection}%
        {\S#2#1#3}{\와 \S#2#1#3}{, \S#2#1#3}{\와 \S#2#1#3}
    \crefrangemultiformat{subsubsection}%
        {\S#3#1#4--\S#5#2#6}{\와 \S#3#1#4--\S#5#2#6}{, \S#3#1#4--\S#5#2#6}{\와 \S#3#1#4--#5#2#6}
    \Crefmultiformat{subsubsection}%
        {\S#2#1#3}{\와 \S#2#1#3}{, \S#2#1#3}{\와 \S#2#1#3}
    \Crefrangemultiformat{subsubsection}%
        {\S#3#1#4--\S#5#2#6}{\와 \S#3#1#4--\S#5#2#6}{, \S#3#1#4--\S#5#2#6}{\와 \S#3#1#4--#5#2#6}
    \crefname{theorem}{정리}{정리}
    \Crefname{theorem}{정리}{정리}
    \crefname{lemma}{보조정리}{보조정리}
    \Crefname{lemma}{보조정리}{보조정리}
    \crefname{corollary}{따름정리}{따름정리}
    \Crefname{corollary}{따름정리}{따름정리}
    \crefname{definition}{정의}{정의}
    \Crefname{definition}{정의}{정의}
    \crefname{example}{예제}{예제}
    \Crefname{example}{예제}{예제}
    \crefformat{page}{#2#1#3~페이지}
    \Crefformat{page}{#2#1#3~페이지}
    \crefmultiformat{page}%
        {#2#1#3~페이지}{\와~#2#1#3~페이지}{, #2#1#3~페이지}{\와~#2#1#3~페이지}
    \crefrangemultiformat{page}%
        {#3#1#4--#5#2#6~페이지}{\와~#3#1#4--#5#2#6~페이지}{, #3#1#4--#5#2#6~페이지}{\와~#3#1#4--#5#2#6~페이지}
    \crefname{footnote}{각주}{각주}
    \Crefname{footnote}{각주}{각주}
    \crefname{lstlisting}{소스코드}{소스코드}
    \Crefname{lstlisting}{소스코드}{소스코드}
    \crefname{algorithm}{알고리즘}{알고리즘}
    \Crefname{algorithm}{알고리즘}{알고리즘}
    \newcommand{\crefpairconjunction}{\와 }
    \newcommand{\creflastconjunction}{\와 }
    \newcommand{\crefpairgroupconjunction}{\와 }
    \newcommand{\creflastgroupconjunction}{, 그리고 }
\fi

% font settings
\ifdefaultsans
    \renewcommand{\familydefault}{\sfdefault}
\else
    \renewcommand{\familydefault}{\rmdefault}
\fi
\ifmathsans
    \RequirePackage{eulervm}
    \RequirePackage[helvet,slantedGreek]{sfmath}
\else\ifbeamer
    \renewcommand{\mathfamilydefault}{\rmdefault}
\fi\fi
\RequirePackage{fontspec}
\defaultfontfeatures[\rmfamily,\sffamily]{Ligatures=TeX}
\setsansfont[
    Path=_fonts/TeX Gyre/,
    Scale=MatchUppercase,
    UprightFont={*-regular.otf},
    ItalicFont={*-italic.otf},
    BoldFont={*-bold.otf},
    BoldItalicFont={*-bolditalic.otf}
]{texgyreheros}

% korean option
\RequirePackage{xetexko}
\setmainhangulfont[
    Path=_fonts/KoPub/,
    UprightFont={* Light.otf},
    ItalicFont={* Light.otf}, ItalicFeatures={FakeSlant=.367},
    BoldFont={* Bold.otf},
    BoldItalicFont={* Bold.otf}, BoldItalicFeatures={FakeSlant=.367}
]{KoPubBatang_Pro}
\setsanshangulfont[
    Path=_fonts/KoPub/,
    Scale=MatchUppercase,
    UprightFont={* Medium.otf},
    ItalicFont={* Medium.otf},ItalicFeatures={FakeSlant=.367},
    BoldFont={* Bold.otf},
    BoldItalicFont={* Bold.otf}, BoldItalicFeatures={FakeSlant=.367}
]{KoPubDotum_Pro}
\setmonohangulfont[
    Path=_fonts/KoPub/,
    Scale=MatchLowercase,
    UprightFont={* Medium.otf},
    ItalicFont={* Medium.otf},ItalicFeatures={FakeSlant=.367},
    BoldFont={* Bold.otf},
    BoldItalicFont={* Bold.otf}, BoldItalicFeatures={FakeSlant=.367}
]{KoPubDotum_Pro}
\hanjabyhangulfont
\ifhangul\ifmemoir
    \AtBeginDocument{
        \renewcommand{\partname}{}
        \renewcommand{\partnamenum}[1]{제~#1~편}
        \ifarticle\else
            \renewcommand{\chaptername}{}
            \renewcommand{\chapternamenum}[1]{제~#1~장}
        \fi
        \renewcommand{\abstractname}{초~록}
    }
\fi\fi

% allows include programming codes
\RequirePackage{listings}
\ifhangul
    \renewcommand{\lstlistingname}{소스코드}
    \renewcommand{\lstlistlistingname}{\lstlistingname~차례}
\else
    \renewcommand{\lstlistlistingname}{List of Listings}
\fi
\ifmemoir
    \newlistof{lstlistoflistings}{lol}{\lstlistlistingname}
    \newlistentry{lstlisting}{lol}{0}
\fi
\makeatletter
    \let\c@lstlisting\@undefined
\makeatother
% default styles : memoir / beamer
\lstdefinestyle{memoir} {
    numberstyle=\tiny\ttfamily,
    frame=single,
    backgroundcolor=\color{background},
    rulecolor=\color{text},
    commentstyle=\em,
}
\lstdefinestyle{beamer} {
    numberstyle=\color{listing-border}\tiny\ttfamily,
    frame=single,
    frameround=tttt,
    backgroundcolor=\color{listing-bg},
    rulecolor=\color{listing-border},
    commentstyle=\color{gray-light},
    stringstyle=\color{listing-str},
    keywordstyle=\color{listing-kwd},
}
% inline environment: code / keyboard
\lstdefinestyle{memoir-inline}{
    basicstyle=\small\ttfamily,
    keywordstyle={}, commentstyle={}, stringstyle={},
}
\lstdefinestyle{beamer-code}{
    basicstyle=\small\ttfamily\color{code-text},
    keywordstyle={}, commentstyle={}, stringstyle={},
}
\lstdefinestyle{beamer-kbd}{
    basicstyle=\small\ttfamily\color{kbd-text},
    keywordstyle={}, commentstyle={}, stringstyle={},
}
% set styles
\newcommand{\lststyle}{}
\newcommand{\lstcodestyle}{}
\newcommand{\lstcodebg}{}
\newcommand{\lstkbdstyle}{}
\newcommand{\lstkbdbg}{}
\ifmemoir
    \renewcommand{\lststyle}{memoir}
    \renewcommand{\lstcodestyle}{memoir-inline}
    \renewcommand{\lstcodebg}{background}
    \renewcommand{\lstkbdstyle}{memoir-inline}
    \renewcommand{\lstkbdbg}{background}
\fi\ifbeamer
    \renewcommand{\lststyle}{beamer}
    \renewcommand{\lstcodestyle}{beamer-code}
    \renewcommand{\lstcodebg}{code-bg}
    \renewcommand{\lstkbdstyle}{beamer-kbd}
    \renewcommand{\lstkbdbg}{kbd-bg}
\fi
% setting...
\lstset {
    numbers=none,
    tabsize=4,
    firstnumber=auto,
    numbersep=1.5em,
    stepnumber=1,
    rulesep=1.5em,
    breaklines=true,
    captionpos=b,
    showspaces=false,
    keepspaces=true,
    showstringspaces=false,
    showtabs=false,
    basicstyle=\small\linespread{1}\ttfamily,
    upquote=true,
    style=\lststyle,
}
\newcommand\code[2][]{
    \tikz[overlay]\node[
        fill=\lstcodebg, inner sep=0.5ex,
        text depth=0.2ex, text height=1.25ex,
        anchor=text, rectangle, rounded corners=1mm]
        {\lstinline[style=\lstcodestyle]§#2§};
    \phantom{\lstinline§#2§\hskip-.8ex}
}
\newcommand\kbd[2][]{
    \tikz[overlay]\node[
        fill=\lstkbdbg, inner sep=0.5ex,
        text depth=0.2ex, text height=1.25ex,
        anchor=text, rectangle, rounded corners=1mm]
        {\lstinline[style=\lstkbdstyle]§#2§};
    \phantom{\lstinline§#2§\hskip-.8ex}
}

% memoir template
\ifmemoir
    \ifarticle
        \counterwithout{section}{chapter}
        \setsecnumdepth{subsubsection}
        \settocdepth{subsubsection}
        \cftsetindents{section}{0em}{1.5em}
        \cftsetindents{subsection}{1.5em}{2.3em}
        \cftsetindents{subsubsection}{3.8em}{3.2em}
        \renewcommand{\cftsectionfont}{\bfseries}
        \renewcommand{\cftsectionpresnum}{}
        \renewcommand{\cftsectionaftersnum}{}
        \renewcommand{\cftsectionaftersnumb}{}
        \renewcommand{\cftsectionleader}{\bfseries\cftdotfill{\cftsectiondotsep}}
        \renewcommand{\cftsectiondotsep}{\cftnodots}
        \renewcommand{\cftsectionpagefont}{\bfseries}
        \renewcommand{\cftsectionafterpnum}{}
        \makeatletter
            \setlength{\cftbeforesectionskip}{1.0em \@plus\p@}
            \renewcommand*{\toclevel@section}{0}
            \renewcommand*{\toclevel@subsection}{1}
            \renewcommand*{\toclevel@subsubsection}{2}
        \makeatother
    \else
        \setsecnumdepth{subsection}
        \settocdepth{subsection}
    \fi
\fi

% beamer template
\ifbeamer
    \usefonttheme{structurebold}
    \setbeamertemplate{caption}[numbered]
    \setbeamertemplate{theorems}[numbered]

    \newcommand{\insertsectionHEAD}{
        \expandafter\insertsectionHEADaux\insertsectionhead}
        \newcommand{\insertsectionHEADaux}[3]{\MakeUppercase{#3}
    }
    \ifsectionpage
        \AtBeginSection{\begingroup
            \setbeamercolor{background canvas}{bg=text}
            \begin{frame}
                \centering
                \vfill\usebeamerfont{section title}\textcolor{background}{\insertsectionHEAD}\vfill
            \end{frame}
        \endgroup}
    \fi
    % color scheme
    \setbeamercolor{normal text}{fg=text}
    \setbeamercolor{alerted text}{fg=danger}
    \setbeamercolor{example text}{fg=info}
    \setbeamercolor{structure}{fg=gray-dark}
    \setbeamercolor{title}{parent=normal text}
    \setbeamercolor{subtitle}{parent=normal text}
    \setbeamercolor{institute}{parent=normal text}
    \setbeamercolor{frametitle}{fg=background, bg=text}
    \setbeamercolor{block title}{fg=background, bg=gray-light}
    \setbeamercolor{block body}{fg=text, bg=gray-lighter}
    \setbeamercolor{block title example}{fg=background, bg=info}
    \setbeamercolor{block body example}{fg=text, bg=info-bg}
    \setbeamercolor{block title alerted}{fg=background, bg=danger}
    \setbeamercolor{block body alerted}{fg=text, bg=danger-bg}
    \setbeamercolor{page number in head/foot}{fg=gray-light}
    \makeatletter
    \def\th@plain{
        \def\inserttheoremblockenv{block}
    }
    \def\th@definition{
        \def\inserttheoremblockenv{exampleblock}
    }
    \def\th@remark{
        \def\inserttheoremblockenv{alertblock}
    }
    \makeatother
\fi

% \titlepage design
\ifmemoir
    \newcommand{\subtitle}[1]{\gdef\subt{#1}}
    \newcommand{\subt}{}
    \newcommand{\institute}[1]{\gdef\inst{#1}}
    \newcommand{\inst}{}
    \makeatletter
        \newcommand{\titlepage}{\begin{titlingpage}
            \@bsmarkseries\def\@makefnmark{\@textsuperscript{\@bsthanksheadpre\tamark\@bsthanksheadpost}}
            \long\def\@makefntext##1{\makethanksmark ##1}
            \ifoneside\centering\fi
            \vspace*{\droptitle}
            \vspace*{\baselineskip}
            \begin{Spacing}{1.1}
                \noindent\Huge\textbf\@title
            \end{Spacing}
            \noindent\large\textit\subt\\[3\baselineskip]
            \noindent\Large\textsc\@author\par
            \vfill
            \noindent\inst\\[\baselineskip]
            \noindent\small\@date\par
            \vspace*{0.1\textheight}
            \ifoneside\else\clearpage\fi
            \thispagestyle{title}
            \@thanks
            \emptythanks
        \end{titlingpage}}
    \makeatother
\fi\ifbeamer
    \setbeamertemplate{title page}{
        \makebox[\textwidth][c]{\begin{tikzpicture}
            \useasboundingbox (0,0) rectangle(\the\paperwidth,\the\paperheight);
            \fill[color=text] (0,\the\paperheight*0.45) rectangle(\the\paperwidth,\the\paperheight*1.03);
            \node[
                anchor=south,
                text width=\the\paperwidth*0.9] at
                (\the\paperwidth*0.5,\the\paperheight*0.49) {
                    \usebeamerfont{date}\color{background}\scriptsize\insertdate\par
                    \usebeamerfont{title}\color{background}\MakeUppercase{\inserttitle}\par
                };
            \node[
                anchor=north,
                text width=\the\paperwidth*0.9] at
                (\the\paperwidth*0.5,\the\paperheight*0.42) {
                    \usebeamerfont{subtitle}\color{text}\insertsubtitle
                };
            \node[
                anchor=south,
                text width=\the\paperwidth*0.9] at
                (\the\paperwidth*0.5,\the\paperheight*0.03) {
                    \usebeamerfont{author}\color{text}\scriptsize\insertauthor\par
                    \usebeamerfont{institute}\color{text}\tiny\insertinstitute
                };
        \end{tikzpicture}}
    }
\fi

\endinput
