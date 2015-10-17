\ProvidesClass{xmbk}[2015/02/16 xmbk: XeLaTeX + memoir + beamer + koTeX (for personal template)]
% cancel compiling if the engine is not XeTeX
\RequirePackage{iftex}
\ifXeTeX\else
    \ClassError{xmbk}{Requires XeTeX!}{No LuaTeX, pdfLaTeX, etc.}
\fi

% class options
\RequirePackage{xkeyval}

% typography option : allserif (memoir default) / mathserif / titlesans / allsans (beamer default)
\newif\ifdefaultsans\defaultsansfalse
\newif\ifmathsans\mathsansfalse
\newif\iftitlesans\titlesansfalse
\DeclareOptionX{allserif}{\defaultsansfalse\mathsansfalse\titlesansfalse}
\DeclareOptionX{mathserif}{\defaultsanstrue\mathsansfalse\titlesansfalse}
\DeclareOptionX{titlesans}{\defaultsansfalse\mathsansfalse\titlesanstrue}
\DeclareOptionX{allsans}{\mathsanstrue\defaultsanstrue\titlesansfalse}

% hangul option
\newif\ifhangul\hangulfalse
\DeclareOptionX{hangul}{
    \hangultrue
    \PassOptionsToPackage{\CurrentOption}{xetexko}
}

% hyperref option : borderlinks (memoir default) / colorlinks (beamer default) / hidelinks
\newif\ifcolorlinks\colorlinksfalse
\newif\ifhidelinks\hidelinksfalse
\DeclareOptionX{hidelinks}{
    \hidelinkstrue\colorlinksfalse
}
\DeclareOptionX{borderlinks}{
    \hidelinksfalse\colorlinksfalse
}
\DeclareOptionX{colorlinks}{
    \hidelinksfalse\colorlinkstrue
}

% some memoir options (article / oneside / wordlikemargin)
\newif\ifarticle\articlefalse
\DeclareOptionX{article}{
    \articletrue
    \PassOptionsToClass{\CurrentOption}{memoir}
}
\newif\ifoneside\onesidefalse
\DeclareOptionX{oneside}{
    \onesidetrue
    \PassOptionsToClass{\CurrentOption}{memoir}
}
\newif\ifwordlikemargin\wordlikemarginfalse
\DeclareOptionX{wordlikemargin}{\wordlikemargintrue}

% beamer section page
\newif\ifsectionpage\sectionpagefalse
\DeclareOptionX{sectionpage}{\sectionpagetrue}

% bibliography options
\newif\iffootcite\footcitefalse
\DeclareOptionX{footcite}{\footcitetrue}
\newif\ifbst\bstfalse
\DeclareOptionX{bst}[]{\newcommand\bst{#1}\bsttrue}

% base class : memoir (default) / beamer
\newif\ifmemoir\memoirtrue
\DeclareOptionX{memoir}{
    \ExecuteOptionsX{allserif}
    \ExecuteOptionsX{borderlinks}
    \DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{memoir}}
}
\DeclareOptionX{beamer}{
    \memoirfalse
    \ExecuteOptionsX{allsans}
    \ExecuteOptionsX{colorlinks}
    \ExecuteOptionsX{article}
    \DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{beamer}}
}
\ExecuteOptionsX{memoir}

% pass memoir / beamer options
\ProcessOptionsX
\ifmemoir
    \LoadClass{memoir}
\else
    \LoadClass[notheorems,compress]{beamer}
\fi

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

% memoir template
\ifmemoir
    \ifwordlikemargin
        \setulmarginsandblock{1in}{1in}{*}
        \setlrmarginsandblock{1in}{1in}{*}
        \checkandfixthelayout
    \fi
    \setlength{\epigraphrule}{0pt}
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
% beamer template
\else
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
    \setbeamertemplate{frametitle continuation}[from second][(cont.)]
    \makeatletter
        \def\th@plain{\def\inserttheoremblockenv{block}}
        \def\th@definition{\def\inserttheoremblockenv{exampleblock}}
        \def\th@remark{\def\inserttheoremblockenv{alertblock}}
    \makeatother
    \newcommand*{\theorembreak}{%
      \usebeamertemplate{theorem end}
      \framebreak
      \def\inserttheoremaddition{cont.}
      \usebeamertemplate{theorem begin}}
    \makeatletter
    \newcommand*{\blockbreak}{%
      \gdef\getcolor block body{}
      \expandafter\gdef\expandafter\@block@theme\expandafter{\beamer@colbox@color}
      \usebeamertemplate{block\expandafter\getcolor\@block@theme\space end}
      \framebreak
      \let\oldinsertblocktitle\insertblocktitle
      \def\insertblocktitle{\oldinsertblocktitle\space (cont.)}
      \usebeamertemplate{block\expandafter\getcolor\@block@theme\space begin}
    }
    \makeatother
\fi

% allows using mathematical expression
\RequirePackage{amsmath,amssymb,amsfonts,amsthm,mathtools}
\everydisplay\expandafter{\the\everydisplay\def\baselinestretch{1.0}\selectfont}
\ifmemoir\else
\makeatletter
\renewcommand\donotcolorouterdisplaymaths{%
  \def\baselinestretch{1.0}\selectfont\everydisplay{\everydisplay{\beamer@setdisplaymathcolor}}
}
\makeatother
\fi
\mathchardef\mhyphen="2D
\DeclareMathOperator*{\argmax}{arg\,max}
\DeclareMathOperator*{\argmin}{arg\,min}
\ifhangul
    \renewcommand{\proofname}{증명}
\fi

% allows using algorithm environment
\ifarticle
    \RequirePackage{algorithm}
\else
    \RequirePackage[chapter]{algorithm}
\fi
\RequirePackage[noend]{algpseudocode}
\floatstyle{plain}
\restylefloat*{algorithm}
\makeatletter
    \ifhangul
        \renewcommand{\ALG@name}{알고리즘}
        \renewcommand{\listalgorithmname}{\ALG@name~차례}
    \fi
    \algrenewcommand\ALG@beginalgorithmic{\smaller[0.5]}
    \algrenewcommand\alglinenumber[1]{\smaller[3]\ttfamily #1}
\makeatother
\ifmemoir
    \newlistof{listofalgorithms}{loa}{\listalgorithmname}
    \newlistentry{algorithm}{loa}{0}
\fi
\renewcommand{\algorithmicrequire}{\textbf{Input:}}
\renewcommand{\algorithmicensure}{\textbf{Output:}}
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
\let\oldtable\table
\let\endoldtable\endtable
\ifmemoir
\renewenvironment{table}{%
  \ifhangul
    \renewcommand*{\arraystretch}{1.3888}
  \else
    \renewcommand*{\arraystretch}{1.0}
  \fi
  \oldtable
}{\endoldtable}
\fi

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

% vertical space options
\ifmemoir
  \DisemulatePackage{setspace}
\fi
\RequirePackage{setspace}

% Creative Commons License:  by / by-sa / by-nd / by-nc / by-nc-sa / by-nc-nd
\RequirePackage{atenddvi,xstring}
\makeatletter
\def\ccl@option#1{\csname @ccl@#1 \endcsname}
\providecommand\@ccl@license{by}
\providecommand\@ccl@features{Attribution}
\providecommand\@ccl@features@ko{저작자표시}
\providecommand\@ccl@version{4.0}
\providecommand\@ccl@title{}
\providecommand\@ccl@author{}
\providecommand\@ccl@authorurl{}
\providecommand\@ccl@source{}
\providecommand\@ccl@morepermissions{}
\define@key{cclsetup}{title}{
  \def\@ccl@title{#1}
}
\define@key{cclsetup}{author}{
  \def\@ccl@author{#1}
}
\define@key{cclsetup}{authorurl}{
  \def\@ccl@authorurl{#1}
}
\define@key{cclsetup}{source}{
  \def\@ccl@source{#1}
}
\define@key{cclsetup}{morepermissions}{
  \def\@ccl@morepermissions{#1}
}
\define@key{cclsetup}{license}{
  \IfStrEqCase{#1}{
    {by}{
      \def\@ccl@features@ko{저작자표시}
      \def\@ccl@features{Attribution}
    }
    {by-sa}{
      \def\@ccl@features@ko{저작자표시-동일조건변경허락}
      \def\@ccl@features{Attribution-ShareAlike}
    }
    {by-nd}{
      \def\@ccl@features@ko{저작자표시-변경금지}
      \def\@ccl@features{Attribution-NoDerivs}
    }
    {by-nc}{
        \def\@ccl@features@ko{저작자표시-비영리}
        \def\@ccl@features{Attribution-NonCommercial}
    }
    {by-nc-sa}{
        \def\@ccl@features@ko{저작자표시-비영리-동일조건변경허락}
        \def\@ccl@features{Attribution-NonCommercial-ShareAlike}
    }
    {by-nc-nd}{
        \def\@ccl@features@ko{저작자표시-비영리-변경금지}
        \def\@ccl@features{Attribution-NonCommercial-NoDerivs}
    }}[\ClassError{xmbk}{Wrong CCL! choose one of: by / by-sa / by-nd / by-nc / by-nc-sa / by-nc-nd}{More infos on http://creativecommons.org/licenses/}]
  \def\@ccl@license{#1}
}
\define@key{cclsetup}{version}{
  \IfDecimal{#1}
    {\def\@ccl@version{#1}}
    {\ClassError{xmbk}{CCL Version must be decimal!}{Check out setccl command}}
}
\bgroup
  \catcode`\#=11
  \gdef\@ccl@hash{#}
\egroup
\newwrite\xmpmetadata
\newcommand{\setlicense}[1]{
  \setkeys{cclsetup}{#1}
  \newcommand{\ccl}{CC \MakeUppercase{\@ccl@license} \@ccl@version}
  \newcommand{\cclbutton}[1][2]{
    \includegraphics[keepaspectratio=true,height=##1 em]{assets/ccl/\@ccl@license}
  }
  \newcommand{\cclurl}{\url{http://creativecommons.org/licenses/\@ccl@license/\@ccl@version/}}
  \ifhangul
    \newcommand{\ccltext}{%
      크리에이티브 커먼즈 \@ccl@features@ko\space\@ccl@version\space 국제 라이선스}
    \newcommand{\cclexplain}{%
      \IfStrEq{\@ccl@author}{}{}{\@ccl@author 의 저작물인}\space
      \IfStrEq{\@ccl@title}{}{이 저작물}{\@ccl@title}에는 \ccltext 가 적용 되어 있습니다.
      이 라이선스의 설명을 보고 싶으시면 \cclurl 을 참조하세요.}
  \else
    \newcommand{\ccltext}{%
      Creative Commons \@ccl@features\space\@ccl@version\space International License}
    \newcommand{\cclexplain}{%
      \IfStrEq{\@ccl@title}{}{This work}{\@ccl@title}\space
      \IfStrEq{\@ccl@author}{}{}{by \@ccl@author}\space
      is licensed under the \ccltext. To view a copy of this license, visit \cclurl.}
  \fi
  \AtEndDvi{
    \newcommand*{\@add@to@xml}[1]{
      \bgroup
        \@tempcnta=0
        \loop
          \lccode\@tempcnta=\@tempcnta
          \advance\@tempcnta by 1
          \ifnum\@tempcnta<256
        \repeat
        \lccode`\_=`\ \relax
        \lowercase{\xdef\@ccl@xml{\@ccl@xml##1}}
      \egroup
    }
    \bgroup
    \xdef\@ccl@xml{}
    \@add@to@xml{%
__________________________________________________^^J%
    }
    \xdef\@ccl@padding{\@ccl@xml}
    \egroup
    \xdef\@ccl@padding{\@ccl@padding\@ccl@padding}
    \xdef\@ccl@padding{\@ccl@padding\@ccl@padding}
    \xdef\@ccl@padding{\@ccl@padding\@ccl@padding}
    \xdef\@ccl@padding{\@ccl@padding\@ccl@padding}
    \xdef\@ccl@padding{\@ccl@padding\@ccl@padding}

    \@add@to@xml{%
<?xpacket begin='' id=''?>^^J%
<x:xmpmeta xmlns:x='adobe:ns:meta/'>^^J%
__<rdf:RDF xmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns\@ccl@hash'>^^J%
____<rdf:Description rdf:about=''^^J%
_____________xmlns:xapRights='http://ns.adobe.com/xap/1.0/rights/'>^^J%
______<xapRights:Marked>True</xapRights:Marked>^^J%
____</rdf:Description>^^J%
    }

    \IfStrEq{\@ccl@authorurl}{}{}{\@add@to@xml{%
____<rdf:Description rdf:about=''^^J%
_____________xmlns:xapRights='http://ns.adobe.com/xap/1.0/rights/'>^^J%
______<xapRights:WebStatement rdf:resource='\@ccl@authorurl'/>^^J%
____</rdf:Description>^^J%
    }}

    \@add@to@xml{%
____<rdf:Description rdf:about=''^^J%
_____________xmlns:xapRights='http://ns.adobe.com/xap/1.0/rights/'^^J%
_____________>^^J%
______<xapRights:UsageTerms>^^J%
____<rdf:Alt>^^J%
______<rdf:li xml:lang='x-default' >This work is licensed under a &lt;a rel=&\@ccl@hash34;license&\@ccl@hash34; href=&\@ccl@hash34;http://creativecommons.org/licenses/\@ccl@license/\@ccl@version/&\@ccl@hash34;&gt;Creative Commons \@ccl@features\space\@ccl@version\space International License&lt;/a&gt;.</rdf:li>^^J%
______<rdf:li xml:lang='en' >This work is licensed under a &lt;a rel=&\@ccl@hash34;license&\@ccl@hash34; href=&\@ccl@hash34;http://creativecommons.org/licenses/\@ccl@license/\@ccl@version/&\@ccl@hash34;&gt;Creative Commons \@ccl@features\space\@ccl@version\space International License&lt;/a&gt;.</rdf:li>^^J%
______</rdf:Alt>^^J%
______</xapRights:UsageTerms>^^J%
____</rdf:Description>^^J%
    }

    \IfStrEq{\@ccl@title}{}{}{\@add@to@xml{%
____<rdf:Description rdf:about=''^^J%
_____________xmlns:dc='http://purl.org/dc/elements/1.1/'>^^J%
______<dc:title>^^J%
____<rdf:Alt>^^J%
______<rdf:li xml:lang='x-default'>\@ccl@title</rdf:li>^^J%
______<rdf:li xml:lang='en'>\@ccl@title</rdf:li>^^J%
____</rdf:Alt>^^J%
______</dc:title>^^J%
____</rdf:Description>^^J%
    }}

    \@add@to@xml{%
____<rdf:Description rdf:about=''^^J%
______xmlns:cc='http://creativecommons.org/ns\@ccl@hash'>^^J%
______<cc:license rdf:resource='http://creativecommons.org/licenses/\@ccl@license/\@ccl@version'/>^^J%
____</rdf:Description>^^J%
    }

    \IfStrEq{\@ccl@author}{}{}{\@add@to@xml{%
____<rdf:Description rdf:about=''^^J%
______xmlns:cc='http://creativecommons.org/ns\@ccl@hash'>^^J%
______<cc:attributionName>\@ccl@author</cc:attributionName>^^J%
____</rdf:Description>^^J%
    }}

    \IfStrEq{\@ccl@morepermissions}{}{}{\@add@to@xml{%
____<rdf:Description rdf:about=''^^J%
______xmlns:cc='http://creativecommons.org/ns\@ccl@hash'>^^J%
______<cc:morePermissions rdf:resource='\@ccl@morepermissions'/>^^J%
____</rdf:Description>^^J%
    }}

    \@add@to@xml{%
__</rdf:RDF>^^J%
</x:xmpmeta>^^J%
\@ccl@padding
<?xpacket end='w'?>^^J%
    }
    \special{pdf:stream @creativecommons (\@ccl@xml)
      <<
        /Type /Metadata
        /Subtype /XML
      >>
    }
    \special{pdf:put @catalog
      <<
        /Metadata @creativecommons
      >>
    }
  }
}
\makeatother

% hyperlink option
\ifmemoir
    \RequirePackage{hyperref}
    \hypersetup{linkcolor=danger}
\else
    \hypersetup{linkcolor=text}
\fi
\hypersetup {
    breaklinks,
    pdfencoding=auto,
    pdfstartview={FitH},
    linkbordercolor=danger,
    citebordercolor=success,
    urlbordercolor=primary,
    citecolor=success,
    urlcolor=primary,
    filecolor=info,
}
\makeatletter
\AtBeginDocument{
  \hypersetup{
    pdftitle={\@title},
    pdfauthor={\@author},
  }
}
\makeatother
\ifhidelinks
    \hypersetup{hidelinks}
\else\ifcolorlinks
    \hypersetup{colorlinks=true}
\else
    \hypersetup{colorlinks=false,pdfborder={0 0 1}}
\fi\fi

% advanced citations, references, captions
\iffootcite
    \RequirePackage[notes,natbib]{biblatex-chicago}
    \bibliography{assets/bibliography}
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
    \newcommand{\printbibliography}{\bibliography{assets/bibliography}}
\fi
\RequirePackage{cleveref}
\newcommand{\crefrangeconjunction}{--}
\newcommand{\crefmiddleconjunction}{,\space}
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
    \renewcommand\Cref{\cref}
    \renewcommand\Crefrange{\crefrange}
    \renewcommand\Cpageref{\cpageref}
    \renewcommand\Cpagerefrange{\cpagerefrange}
    \crefname{figure}{그림}{그림}
    \crefname{table}{표}{표}
    \crefformat{part}{#2#1#3편}
    \crefmultiformat{part}%
        {#2#1#3편}{\와 #2#1#3편}{, #2#1#3편}{\와 #2#1#3편}
    \crefrangemultiformat{part}%
        {#3#1#4--#5#2#6편}{\와 #3#1#4--#5#2#6편}{, #3#1#4--#5#2#6편}{\와 #3#1#4--#5#2#6편}
    \crefname{appendix}{부록}{부록}
    \crefname{equation}{식}{식}
    \crefname{item}{항목}{항목}
    \crefformat{chapter}{#2#1#3장}
    \crefmultiformat{chapter}%
        {#2#1#3장}{\와 #2#1#3장}{, #2#1#3장}{\와 #2#1#3장}
    \crefrangemultiformat{chapter}%
        {#3#1#4--#5#2#6장}{\와 #3#1#4--#5#2#6장}{, #3#1#4--#5#2#6장}{\와 #3#1#4--#5#2#6장}
    \crefmultiformat{section}%
        {\S#2#1#3}{\와 \S#2#1#3}{, \S#2#1#3}{\와 \S#2#1#3}
    \crefrangemultiformat{section}%
        {\S#3#1#4--\S#5#2#6}{\와 \S#3#1#4--\S#5#2#6}{, \S#3#1#4--\S#5#2#6}{\와 \S#3#1#4--#5#2#6}
    \crefmultiformat{subsection}%
        {\S#2#1#3}{\와 \S#2#1#3}{, \S#2#1#3}{\와 \S#2#1#3}
    \crefrangemultiformat{subsection}%
        {\S#3#1#4--\S#5#2#6}{\와 \S#3#1#4--\S#5#2#6}{, \S#3#1#4--\S#5#2#6}{\와 \S#3#1#4--#5#2#6}
    \crefmultiformat{subsubsection}%
        {\S#2#1#3}{\와 \S#2#1#3}{, \S#2#1#3}{\와 \S#2#1#3}
    \crefrangemultiformat{subsubsection}%
        {\S#3#1#4--\S#5#2#6}{\와 \S#3#1#4--\S#5#2#6}{, \S#3#1#4--\S#5#2#6}{\와 \S#3#1#4--#5#2#6}
    \crefname{theorem}{정리}{정리}
    \crefname{lemma}{보조정리}{보조정리}
    \crefname{corollary}{따름정리}{따름정리}
    \crefname{definition}{정의}{정의}
    \crefname{example}{예제}{예제}
    \crefformat{page}{#2#1#3~페이지}
    \crefmultiformat{page}%
        {#2#1#3~페이지}{\와~#2#1#3~페이지}{, #2#1#3~페이지}{\와~#2#1#3~페이지}
    \crefrangemultiformat{page}%
        {#3#1#4--#5#2#6~페이지}{\와~#3#1#4--#5#2#6~페이지}{, #3#1#4--#5#2#6~페이지}{\와~#3#1#4--#5#2#6~페이지}
    \crefname{footnote}{각주}{각주}
    \crefname{lstlisting}{소스코드}{소스코드}
    \crefname{algorithm}{알고리즘}{알고리즘}
    \newcommand{\crefpairconjunction}{\와\space}
    \newcommand{\creflastconjunction}{\와\space}
    \newcommand{\crefpairgroupconjunction}{\와\space}
    \newcommand{\creflastgroupconjunction}{, 그리고\space}
\fi

% index & glossary
\ifmemoir
  \RequirePackage[toc,nopostdot,nonumberlist]{glossaries}
  \makenoidxglossaries
  \setacronymstyle{long-short}
  \setglossarystyle{super}
  \loadglsentries{assets/glossaries}
  \makeindex
  \let\oldindex\index
  \renewcommand{\index}[1]{#1\oldindex{#1}}
\fi

% mathemathical environments e.g. theorem, lemma, ...
\theoremstyle{plain}
\ifhangul
    \ifarticle
        \newtheorem{theorem}{정리}
    \else
        \newtheorem{theorem}{정리}[chapter]
    \fi
    \newtheorem{corollary}{따름정리}[theorem]
    \newtheorem{lemma}[theorem]{보조정리}
\else
    \ifarticle
        \newtheorem{theorem}{Theorem}
    \else
        \newtheorem{theorem}{Theorem}[chapter]
    \fi
    \newtheorem{corollary}{Corollary}[theorem]
    \newtheorem{lemma}[theorem]{Lemma}
\fi
\theoremstyle{definition}
\ifhangul
    \ifarticle
        \newtheorem{definition}{정의}
        \newtheorem{example}{예제}
    \else
        \newtheorem{definition}{정의}[chapter]
        \newtheorem{example}{예제}[chapter]
    \fi
\else
    \ifarticle
        \newtheorem{definition}{Definition}
        \newtheorem{example}{Example}
    \else
        \newtheorem{definition}{Definition}[chapter]
        \newtheorem{example}{Example}[chapter]
    \fi
\fi
\theoremstyle{remark}
\ifhangul
    \newtheorem*{remark}{참고}
\else
    \newtheorem*{remark}{Remark}
\fi

% font settings
\RequirePackage{relsize}
\ifdefaultsans
    \renewcommand{\familydefault}{\sfdefault}
\else
    \renewcommand{\familydefault}{\rmdefault}
\fi
\ifmathsans
    \RequirePackage{eulervm}
    \RequirePackage[helvet,slantedGreek]{sfmath}
\else\ifmemoir\else
    \renewcommand{\mathfamilydefault}{\rmdefault}
\fi\fi
\iftitlesans
    \ifmemoir
        \makeatletter
            \thm@headfont{\bfseries\sffamily}
            \def\th@remark{
                \thm@headfont{\itshape\sffamily}
                \normalfont
                \thm@preskip\topsep
                \divide\thm@preskip\tw@
                \thm@postskip\thm@preskip
            }
        \makeatother
        \makeevenhead{headings}{\thepage}{}{\slshape\sffamily\leftmark}
        \makeoddhead{headings}{\slshape\sffamily\rightmark}{}{\thepage}
        \let\oldglsnamefont\glsnamefont
        \renewcommand*{\glsnamefont}{\oldglsnamefont\sffamily}
        \let\oldproofname=\proofname
        \renewcommand{\proofname}{\sffamily{\oldproofname}}
        \let\oldcftbookfont\cftbookfont
        \renewcommand*{\cftbookfont}{\oldcftbookfont\sffamily}
        \let\oldcftpartfont\cftpartfont
        \renewcommand*{\cftpartfont}{\oldcftpartfont\sffamily}
        \let\oldcftchapterfont\cftchapterfont
        \renewcommand*{\cftchapterfont}{\oldcftchapterfont\sffamily}
        \let\oldcftsectionfont\cftsectionfont
        \renewcommand*{\cftsectionfont}{\oldcftsectionfont\sffamily}
        \let\oldcftsubsectionfont\cftsubsectionfont
        \renewcommand*{\cftsubsectionfont}{\oldcftsubsectionfont\sffamily}
        \let\oldcftsubsubsectionfont\cftsubsubsectionfont
        \renewcommand*{\cftsubsubsectionfont}{\oldcftsubsubsectionfont\sffamily}
        \let\oldcftfigurefont\cftfigurefont
        \renewcommand*{\cftfigurefont}{\oldcftfigurefont\sffamily}
        \let\oldcfttablefont\cfttablefont
        \renewcommand*{\cfttablefont}{\oldcfttablefont\sffamily}
        \let\oldcftlstlistingfont\cftlstlistingfont
        \renewcommand*{\cftlstlistingfont}{\oldcftlstlistingfont\sffamily}
        \let\oldcftalgorithmfont\cftalgorithmfont
        \renewcommand*{\cftalgorithmfont}{\oldcftalgorithmfont\sffamily}
        \let\oldbooknamefont\booknamefont
        \renewcommand*{\booknamefont}{\oldbooknamefont\sffamily}
        \let\oldbooknumfont\booknumfont
        \renewcommand*{\booknumfont}{\oldbooknumfont\sffamily}
        \let\oldbooktitlefont\booktitlefont
        \renewcommand*{\booktitlefont}{\oldbooktitlefont\sffamily}
        \let\oldpartnamefont\partnamefont
        \renewcommand*{\partnamefont}{\oldpartnamefont\sffamily}
        \let\oldpartnumfont\partnumfont
        \renewcommand*{\partnumfont}{\oldpartnumfont\sffamily}
        \let\oldparttitlefont\parttitlefont
        \renewcommand*{\parttitlefont}{\oldparttitlefont\sffamily}
        \let\oldchapnamefont\chapnamefont
        \renewcommand*{\chapnamefont}{\oldchapnamefont\sffamily}
        \let\oldchapnumfont\chapnumfont
        \renewcommand*{\chapnumfont}{\oldchapnumfont\sffamily}
        \let\oldchaptitlefont\chaptitlefont
        \renewcommand*{\chaptitlefont}{\oldchaptitlefont\sffamily}
        \let\oldsecheadstyle\secheadstyle
        \renewcommand*{\secheadstyle}{\oldsecheadstyle\sffamily}
        \let\oldsubsecheadstyle\subsecheadstyle
        \renewcommand*{\subsecheadstyle}{\oldsubsecheadstyle\sffamily}
        \let\oldsubsubsecheadstyle\subsubsecheadstyle
        \renewcommand*{\subsubsecheadstyle}{\oldsubsubsecheadstyle\sffamily}
        \let\oldparaheadstyle\paraheadstyle
        \renewcommand*{\paraheadstyle}{\oldparaheadstyle\sffamily}
        \let\oldsubparaheadstyle\subparaheadstyle
        \renewcommand*{\subparaheadstyle}{\oldsubparaheadstyle\sffamily}
        \let\oldabstractnamefont\abstractnamefont
        \renewcommand*{\abstractnamefont}{\oldabstractnamefont\sffamily}
        \precaption{\sffamily}
        \captiontitlefont{\normalfont}
    \else
        \setbeamerfont{structure}{family=\sffamily}
        \setbeamerfont{tiny structure}{family=\sffamily}
        \setbeamerfont{author}{family=\sffamily}
        \setbeamerfont{institute}{family=\sffamily}
        \setbeamerfont{date}{family=\sffamily}
    \fi
\fi
\RequirePackage{fontspec}
\defaultfontfeatures[\rmfamily,\sffamily]{Ligatures=TeX}
\setsansfont[
    Path=assets/fonts/TeX Gyre/,
    Scale=MatchUppercase,
    UprightFont={*-regular.otf},
    ItalicFont={*-italic.otf},
    BoldFont={*-bold.otf},
    BoldItalicFont={*-bolditalic.otf}
]{texgyreheros}

% korean option
\RequirePackage{xetexko}
\setmainhangulfont[
    Path=assets/fonts/KoPub/,
    UprightFont={* Light.otf},
    ItalicFont={* Light.otf}, ItalicFeatures={FakeSlant=.217},
    BoldFont={* Bold.otf},
    BoldItalicFont={* Bold.otf}, BoldItalicFeatures={FakeSlant=.217}
]{KoPubBatang_Pro}
\setsanshangulfont[
    Path=assets/fonts/KoPub/,
    Scale=MatchUppercase,
    UprightFont={* Medium.otf},
    ItalicFont={* Medium.otf},ItalicFeatures={FakeSlant=.217},
    BoldFont={* Bold.otf},
    BoldItalicFont={* Bold.otf}, BoldItalicFeatures={FakeSlant=.217}
]{KoPubDotum_Pro}
\setmonohangulfont[
    Path=assets/fonts/KoPub/,
    Scale=MatchLowercase,
    UprightFont={* Medium.otf},
    ItalicFont={* Medium.otf},ItalicFeatures={FakeSlant=.217},
    BoldFont={* Bold.otf},
    BoldItalicFont={* Bold.otf}, BoldItalicFeatures={FakeSlant=.217}
]{KoPubDotum_Pro}
\hanjabyhangulfont
\ifhangul\ifmemoir
    \captionnamefont{<}
    \captiondelim{> }
    \footmarkstyle{#1) }
    \makeatletter
        \let\oldappendix\appendix
        \renewcommand*\appendix{
            \oldappendix
            \renewcommand{\chapternamenum}{\oldchapternamenum}}
    \makeatother
    \AtBeginDocument{
        \renewcommand{\bookname}{}
        \renewcommand{\booknamenum}[1]{제~#1~권}
        \renewcommand{\partname}{}
        \renewcommand{\partnamenum}[1]{제~#1~편}
        \ifarticle\else
            \renewcommand{\chaptername}{}
            \let\oldchapternamenum\chapternamenum
            \renewcommand{\chapternamenum}[1]{제~#1~장}
        \fi
        \renewcommand{\abstractname}{초~록}
        \renewcommand{\appendixpagename}{부~록}
        \renewcommand{\appendixtocname}{부~록}
    }
\else
    \setbeamerfont{caption name}{family=<}
    \setbeamertemplate{caption label separator}{>}
    \makeatletter
        \renewcommand{\@makefntext}[1]{\noindent\makebox[1.5em][r]\@thefnmark) #1}
    \makeatother
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
    \ifmemoir\else
        \newskip\abovecaptionskip
        \newskip\belowcaptionskip
        \setlength\abovecaptionskip{7pt}
        \setlength\belowcaptionskip{7pt}
        \long\def\@makecaption#1#2{%
            \def\insertcaptionname{\lstlistingname}%
            \def\insertcaptionnumber{\thelstlisting}%
            \def\insertcaption{#2}
            \nobreak\vskip\abovecaptionskip\nobreak
            \sbox\@tempboxa{\usebeamertemplate**{caption}}%
            \ifdim \wd\@tempboxa >\hsize
                \usebeamertemplate**{caption}\par
            \else
                \global \@minipagefalse
                \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
            \fi
            \nobreak\vskip\belowcaptionskip\nobreak}
    \fi
    \let\c@lstlisting\@undefined
\makeatother
% default styles : memoir / beamer
\lstdefinestyle{memoir} {
    numberstyle=\smaller[3]\ttfamily,
    frame=single,
    backgroundcolor=\color{background},
    rulecolor=\color{text},
    commentstyle=\em,
}
\lstdefinestyle{beamer} {
    numberstyle=\color{listing-border}\smaller[3]\ttfamily,
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
    basicstyle=\smaller[0.5]\ttfamily,
    keywordstyle={}, commentstyle={}, stringstyle={},
}
\lstdefinestyle{beamer-code}{
    basicstyle=\smaller[0.5]\ttfamily\color{code-text},
    keywordstyle={}, commentstyle={}, stringstyle={},
}
\lstdefinestyle{beamer-kbd}{
    basicstyle=\smaller[0.5]\ttfamily\color{kbd-text},
    keywordstyle={}, commentstyle={}, stringstyle={},
}
\ifmemoir
    \newcommand{\lststyle}{memoir}
    \newcommand\code[2][]{
        \lstinline[style=memoir-inline]§#2§
    }
    \newcommand\kbd[2][]{
        \lstinline[style=memoir-inline]§#2§
    }
\else
    \newcommand{\lststyle}{beamer}
    \newcommand\code[2][]{
        \tikz[overlay]\node[
        fill=code-bg, inner sep=0.5ex,
        text depth=0.2ex, text height=1.25ex,
        anchor=text, rectangle, rounded corners=1mm]
        {\lstinline[style=beamer-code]§#2§};
        \phantom{\lstinline§#2§\hskip-.8ex}
    }
    \newcommand\kbd[2][]{
        \tikz[overlay]\node[
        fill=kbd-bg, inner sep=0.5ex,
        text depth=0.2ex, text height=1.25ex,
        anchor=text, rectangle, rounded corners=1mm]
        {\lstinline[style=beamer-kbd]§#2§};
        \phantom{\lstinline§#2§\hskip-.8ex}
    }
\fi
\lstset {
    float,
    numbers=none,
    tabsize=4,
    firstnumber=auto,
    numbersep=8pt,
    stepnumber=1,
    breaklines=true,
    breakindent=12pt,
    aboveskip=\intextsep,
    belowskip=\intextsep,
    abovecaptionskip=\abovecaptionskip,
    belowcaptionskip=\belowcaptionskip,
    captionpos=b,
    showspaces=false,
    keepspaces=true,
    showstringspaces=false,
    showtabs=false,
    basicstyle=\smaller[0.5]\linespread{1}\ttfamily,
    upquote=true,
    style=\lststyle,
}

% \titlepage design
\ifmemoir
    \newcommand{\subtitle}[1]{\gdef\subt{#1}}
    \newcommand{\subt}{}
    \newcommand{\institute}[1]{\gdef\inst{#1}}
    \newcommand{\inst}{}
    \pretitle{\begin{center}\LARGE\iftitlesans\sffamily\fi}
    \preauthor{\begin{center}
        \large\iftitlesans\sffamily\fi \lineskip 0.5em%
        \begin{tabular}[t]{c}}
    \predate{\begin{center}\large\iftitlesans\sffamily\fi}
    \makeatletter
        \newcommand{\titlepage}{\begin{titlingpage}
            \iftitlesans\sffamily\fi
            \@bsmarkseries\def\@makefnmark{\@textsuperscript{\@bsthanksheadpre\tamark\@bsthanksheadpost}}
            \long\def\@makefntext##1{\makethanksmark ##1}
            \ifoneside\centering\fi
            \vspace*{\droptitle}
            \vspace*{\baselineskip}
            \begin{spacing}{1.1}
                \noindent\Huge\textbf\@title
            \end{spacing}
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
\else
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
