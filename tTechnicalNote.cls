%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% A class designed for my technical notes. It wraps the memoir class.
%
% Version: 0.1 - May 2016.
% Version: 0.2 - Nov 2016.
%
% Author: Timothy A.V. Teatro <timothy.teatro@uoit.net>
%
%
\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{tTechnicalNote}
\makeatletter
\LoadClass[11pt, oneside, article]{memoir}

\usepackage{tColours}

\usepackage[pdftex,
  plainpages=false,
  pdfpagelabels,
  bookmarksnumbered,
  bookmarksopen,
  colorlinks, % Removes boxes and colors links, but shows in print off.
  linkcolor={gitish:red},
  citecolor={gitish:red},
  urlcolor ={gitish:red},
  ]{hyperref}

\usepackage{memhfixc}
\usepackage{microtype}
\usepackage{siunitx}
\usepackage{xparse, calc}
\usepackage{ragged2e}
\usepackage{marginnote}



%%% Page layout
%====================================================================


\settrims{0pt}{0pt}
\settypeblocksize{50\onelineskip}{130mm}{*}
\setlrmargins{10.45mm}{*}{1} % 15.45 = (215.9mm - 5mm - 60mm - 130mm)/2
\setulmargins{*}{*}{1}
\setmarginnotes{5mm}{60mm}{5pt}
\setheadfoot{\baselineskip}{9mm}
\setheaderspaces{*}{9mm}{*}
\checkandfixthelayout



%%% Numbered margin notes.
%====================================================================


\newcounter{sideNoteNum}[chapter]
\NewDocumentCommand{\SideNote}{mO{0pt}}{%
        \refstepcounter{sideNoteNum}%
        \mbox{\textsuperscript{\arabic{sideNoteNum}}}%
        \marginnote{\indent\mbox{\normalsize\textsuperscript{\arabic{sideNoteNum}}}\hspace{0pt}~\footnotesize #1}[#2]%
}
\renewcommand*{\raggedleftmarginnote}{\RaggedRight}
\renewcommand*{\raggedrightmarginnote}{\RaggedRight}



%%% Theorems, proofs, defs, etc.
%====================================================================


\usepackage{amsthm}
\usepackage[framemethod=tikz]{mdframed}

\newtheoremstyle{plain}
  {\topsep}    % ABOVESPACE
  {\topsep}    % BELOWSPACE
  {\itshape}  % BODYFONT
  {0pt}        % INDENT (empty value is the same as 0pt)
  {\bfseries}  % HEADFONT
  {.}          % HEADPUNCT
  {5pt plus 1pt minus 1pt} % HEADSPACE
  {}          % CUSTOM-HEAD-SPEC

\newtheoremstyle{definition}
  {\topsep}    % ABOVESPACE
  {\topsep}    % BELOWSPACE
  {\normalfont}  % BODYFONT
  {0pt}        % INDENT (empty value is the same as 0pt)
  {\bfseries}  % HEADFONT
  {.}          % HEADPUNCT
  {5pt plus 1pt minus 1pt} % HEADSPACE
  {}          % CUSTOM-HEAD-SPEC

\newtheoremstyle{remark}
  {.5\topsep}    % ABOVESPACE
  {.5\topsep}    % BELOWSPACE
  {\normalfont}  % BODYFONT
  {0pt}        % INDENT (empty value is the same as 0pt)
  {\itshape}  % HEADFONT
  {.}          % HEADPUNCT
  {5pt plus 1pt minus 1pt} % HEADSPACE
  {}          % CUSTOM-HEAD-SPEC

\theoremstyle{plain}

\newtheorem*{identity*}{Identity}
\surroundwithmdframed[
  hidealllines=true,
  innerleftmargin=1em,
  innerrightmargin=1em,
  innertopmargin=0pt,
  ]{identity*}

\newmdtheoremenv[
  hidealllines=true,
  innerleftmargin=1em,
  innerrightmargin=1em,
  innertopmargin=0pt,
  ]{identity}{Identity}[chapter]

\newmdtheoremenv[
  hidealllines=true,
  leftline=true,
  innerleftmargin=10pt,
  innerrightmargin=10pt,
  innertopmargin=0pt,
  ]{definition}{Definition}

\theoremstyle{definition}
\newmdtheoremenv[
  hidealllines=true,
  innerleftmargin=1em,
  innerrightmargin=1em,
  subtitlefont={\itshape},
  ]{displayAlgorithm}{Algorithm}[chapter]

\theoremstyle{remark}
\newtheorem*{remark*}{Remark}
\surroundwithmdframed[
  hidealllines=true,
  leftline=true,
  innerleftmargin=10pt,
  innerrightmargin=10pt,
  innertopmargin=0pt,
  ]{remark*}

\NewDocumentCommand{\MarginDefinition}{mO{0pt}}{%
   \refstepcounter{definition}%
   \@afterindentfalse\@afterheading%
   \marginnote{\rule{\marginparwidth}{2pt}\smallbreak\noindent\footnotesize\textbf{Definition \thedefinition.}\hspace{0.5em plus 0.25em minus .1em} #1\smallbreak%
   \noindent\rule{\marginparwidth}{.5pt}}[#2]%
}



%%% Chapter Style
%====================================================================


\renewcommand{\chaptitlefont}{\Large\bfseries\sffamily}
\setsecheadstyle{\sffamily}
\setsubsecheadstyle{\itshape}



%%% Page Style
%====================================================================


\makepagestyle{technote}
\setlength{\headwidth}{\textwidth}
  \addtolength{\headwidth}{\marginparsep}
  \addtolength{\headwidth}{\marginparwidth}
\makerunningwidth{technote}{\headwidth}
\makeheadrule{technote}{\headwidth}{\normalrulethickness}
\makefootrule{technote}{\headwidth}{\normalrulethickness}{5pt}
\makeheadposition{technote}{flushright}{flushleft}{flushright}{flushleft}
\makepsmarks{technote}{%
  \def\chaptermark##1{\markboth{##1}{##1}}    % left mark & right marks
  \def\sectionmark##1{\markright{%
    \ifnum \c@secnumdepth>\z@
      \thesection. \ %
    \fi
    ##1}}
  \def\tocmark{\markboth{\contentsname}{\contentsname}}
  \def\lofmark{\markboth{\listfigurename}{\listfigurename}}
  \def\lotmark{\markboth{\listtablename}{\listtablename}}
  \def\bibmark{\markboth{\bibname}{\bibname}}
  \def\indexmark{\markboth{\indexname}{\indexname}}}
\makepsmarks{technote}{%
  \nouppercaseheads
  \createmark{chapter}{both}{nonumber}{}{}
  \createmark{section}{right}{shownumber}{}{. \space}
  \createplainmark{toc}{both}{\contentsname}
  \createplainmark{lof}{both}{\listfigurename}
  \createplainmark{lot}{both}{\listtablename}
  \createplainmark{bib}{both}{\bibname}
  \createplainmark{index}{both}{\indexname}
  \createplainmark{glossary}{both}{\glossaryname}}
\makeevenhead{technote}{\normalfont\thepage}{}%
                        {\let\\=\relax\normalfont\thetitle}
\makeoddhead{technote}{\let\\=\relax\normalfont\thetitle}{}%
                       {\normalfont\thepage}
\makeevenfoot{technote}{\scriptsize ©\the\year\ \@author\ — All Rights Reserved}{}{}
\makeoddfoot{technote}{\scriptsize ©\the\year\ \@author\ — All Rights Reserved}{}{}

\aliaspagestyle{chapter}{technote}
\setlength{\headwidth}{\textwidth}
\addtolength{\headwidth}{\marginparsep}
\addtolength{\headwidth}{\marginparwidth}

\copypagestyle{technote-titlepage}{technote}
\makeevenhead{technote-titlepage}{}{}{}
\makeoddhead{technote-titlepage}{}{}{}
\makeheadrule{technote-titlepage}{0pt}{0pt}

\pagestyle{technote}



%%% Make Title
%====================================================================


\NewDocumentCommand{\authoremail}{m}{\providecommand{\@authoremail}{#1}}
\NewDocumentCommand{\docversion}{m}{\providecommand{\@docversion}{#1}}
\NewDocumentCommand{\notetype}{m}{\providecommand{\@notetype}{#1}}
\let\abstract\undefined
\NewDocumentCommand{\abstract}{m}{\providecommand{\@abstract}{#1}}

\aliaspagestyle{title}{technote}

\renewcommand{\@maketitle}{%
    \let\footnote\@mem@titlefootkill
    \ifdim\pagetotal>\z@
      \newpage
    \fi
    % \null\vskip 1cm
    \noindent\Huge\@title
    \vskip 5mm
    \noindent\Large\@author
    \vskip 5mm
    \normalsize\noindent\hskip 0mm%
    {\renewcommand{\arraystretch}{1.25}%
    \begin{tabular}{r@{\hskip 1em}p{10.5cm}}
      \ifdefined\@authoremail
      \textsf{Email}     & \texttt{\@authoremail}\\
      \fi
      \ifdefined\@docversion
      \textsf{Version}   & \@docversion\\
      \fi
      \ifdefined\@notetype
      \textsf{Note Type} & \@notetype\\
      \fi
      \ifdefined\@abstract
      \textsf{\textit{Abstract}}  & \@abstract
      \fi
    \end{tabular}
    }
}

%%% Figures
%====================================================================


\usepackage[wide, outercaption]{sidecap}
  \renewcommand{\sidecaptionsep}{5mm}



%%% Text macros
%====================================================================


\NewDocumentCommand{\anno}{m}{\oldstylenums{#1}}
\NewDocumentCommand{\decade}{m}{\anno{#1}s}



\makeatother