%% ayacv.cls
%% Copyright 2022 Ravex
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.

%-------------------------------------------------------------------------------
%                identification
%-------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ayacv}[2022/03/01]

%-------------------------------------------------------------------------------
%                class options
%-------------------------------------------------------------------------------
% paper size options
\DeclareOption{a4paper}{\PassOptionsToClass{\CurrentOption}{moderncv}}
\DeclareOption{a5paper}{\PassOptionsToClass{\CurrentOption}{moderncv}}
\DeclareOption{b5paper}{\PassOptionsToClass{\CurrentOption}{moderncv}}
\DeclareOption{letterpaper}{\PassOptionsToClass{\CurrentOption}{moderncv}}
\DeclareOption{legalpaper}{\PassOptionsToClass{\CurrentOption}{moderncv}}
\DeclareOption{executivepaper}{\PassOptionsToClass{\CurrentOption}{moderncv}}
\DeclareOption{landscape}{\PassOptionsToClass{\CurrentOption}{moderncv}}

% font size options
\DeclareOption{10pt}{\PassOptionsToClass{\CurrentOption}{moderncv}}
\DeclareOption{11pt}{\PassOptionsToClass{\CurrentOption}{moderncv}}
\DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{moderncv}}

% font type options
\DeclareOption{sans}{\PassOptionsToClass{\CurrentOption}{moderncv}}
\DeclareOption{roman}{\PassOptionsToClass{\CurrentOption}{moderncv}}

% color options
\newif\if@ayacv@colorpurple
\DeclareOption{purple}{\@ayacv@colorpurpletrue}
\newif\if@ayacv@colorblack
\DeclareOption{black}{\@ayacv@colorblacktrue}
\newif\if@ayacv@colorblue
\DeclareOption{blue}{\@ayacv@colorbluetrue}
\newif\if@ayacv@colorburgundy
\DeclareOption{burgundy}{\@ayacv@colorburgundytrue}
\newif\if@ayacv@colorgreen
\DeclareOption{green}{\@ayacv@colorgreentrue}
\newif\if@ayacv@colorgrey
\DeclareOption{grey}{\@ayacv@colorgreytrue}
\newif\if@ayacv@colororange
\DeclareOption{orange}{\@ayacv@colororangetrue}
\newif\if@ayacv@colorred
\DeclareOption{red}{\@ayacv@colorredtrue}

% default options
\ExecuteOptions{purple}

% execute commands
\ProcessOptions\relax

% load moderncv class
\LoadClass{moderncv}

%-------------------------------------------------------------------------------
%                required packages
%-------------------------------------------------------------------------------
% enable Chinese
\RequirePackage{ctex}

\RequirePackage{etoolbox}

%-------------------------------------------------------------------------------
%                customized commands
%-------------------------------------------------------------------------------
% set style
\moderncvstyle{banking}

% set color
\if@ayacv@colorpurple
    \moderncvcolor{purple}
\fi
\if@ayacv@colorblack
    \moderncvcolor{black}
\fi
\if@ayacv@colorblue
    \moderncvcolor{blue}
\fi
\if@ayacv@colorburgundy
    \moderncvcolor{burgundy}
\fi
\if@ayacv@colorgreen
    \moderncvcolor{green}
\fi
\if@ayacv@colorgrey
    \moderncvcolor{grey}
\fi
\if@ayacv@colororange
    \moderncvcolor{orange}
\fi
\if@ayacv@colorred
    \moderncvcolor{red}
\fi

% adjust space above quote
\patchcmd{\makehead}{\\[2.5em]}{\\[0.7em]}{}{}
% adjust space below quote
\patchcmd{\makecvhead}{\makehead}{\makehead\vspace*{-2.4em}}{}{}

% known issue: 
% when there is only one row in tabular environment, 
% it seems like extra space will be padded and looks weird. 
% workaround:
% put minipage environment inside tabular environment. 
\newcommand*{\cvsimpleentry}[4][.25em]{%
    \begin{tabular*}{\maincolumnwidth}{l@{\extracolsep{\fill}}r}%
        {\bfseries #3} & {\itshape #2}\\%
        \multicolumn{2}{l}{\begin{minipage}{\maincolumnwidth}\small#4\end{minipage}}\\%
    \end{tabular*}%
    \par\addvspace{#1}%
}

% same issue as above. 
% workaround: 
% put all items in one table recursively. 
\newcommand*{\cvdateditems}[1]{%
    \begin{tabular*}{\maincolumnwidth}{l@{\extracolsep{\fill}}r}%
        \cvdateditemsi#1
}
\newcommand*{\cvdateditemsi}{%
    \@ifnextchar\bgroup{\cvdateditemsii}{\cvdateditemsiii}%
}
\newcommand*{\cvdateditemsii}[2]{%
    {#2} & {\itshape #1} \@ifnextchar\bgroup{\\ \cvdateditemsii}{\cvdateditemsiii}%
}
\newcommand*{\cvdateditemsiii}[1][.25em]{%
    \end{tabular*}%
    \par\addvspace{#1}%
}

% adjust the order of arguments
\renewcommand*{\cventry}[7][.25em]{%
    \begin{tabular*}{\maincolumnwidth}{l@{\extracolsep{\fill}}r}%
        {\bfseries #3} & {\bfseries #4}\\%
        {\itshape #5\ifthenelse{\equal{#6}{}}{}{, #6}} & {\itshape #2}\\%
    \end{tabular*}%
    \ifx&#7&%
    \else{\\%
    \begin{minipage}{\maincolumnwidth}%
        \small#7%
    \end{minipage}}\fi%
    \par\addvspace{#1}%
}
