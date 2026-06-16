% ============================================
% 华侨大学考试卷类文件
% 选项：
%   - graduate/undergraduate : 研究生/本科生
%   - answers : 生成参考答案（默认：考试卷）
%   - version=A/version=B : 选择试卷版本（默认：A卷）
% ============================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hqu-exam}[2026/05/06 HQU Exam Template]

% ---------- 条件编译开关 ----------
\newif\ifsolution
\solutionfalse

% ---------- 选项 ----------
\DeclareOption{graduate}{
    \def\examtype{研究生}
}
\DeclareOption{undergraduate}{
    \def\examtype{本科}
}
\DeclareOption{answers}{
    \solutiontrue
}
\DeclareOption{version=A}{
    \def\examversion{A}
}
\DeclareOption{version=B}{
    \def\examversion{B}
}
\DeclareOption*{
    \ClassWarning{hqu-exam}{Unknown option `\CurrentOption'}
}
\ExecuteOptions{graduate,version=A}
\ProcessOptions\relax

% ---------- 加载基础类 ----------
\LoadClass{article}

% ---------- 基础宏包 ----------
\RequirePackage{geometry}
\RequirePackage{comment}
\RequirePackage{graphicx}
\RequirePackage{tabularx,array}
\RequirePackage{ulem}
\RequirePackage{environ}
\RequirePackage{xeCJK,ctex}
\RequirePackage{amsmath,amsfonts,amssymb}

% ---------- 字体设置 ----------
\setmainfont{Times New Roman}
\IfFileExists{./simsun.ttc}{
    \setCJKmainfont{simsun.ttc}[AutoFakeSlant, AutoFakeBold={3}]
}{
    \setCJKmainfont{simsun.ttc}[Path=./, AutoFakeSlant, AutoFakeBold={3}]
}

% ---------- 段落设置 ----------
% \baselineskip already defined by LaTeX, use directly
%\setlength{\baselineskip}{21pt}
\setlength{\parskip}{12pt}
\setlength{\parindent}{0pt}

% ---------- question 环境 ----------
% 参数 #1：非答案模式下题目底部留白比例
\newcounter{question}
\renewcommand{\thequestion}{\chinese{question}、}
\NewEnviron{question}[1]{
\ifsolution
\parbox{\textwidth}{
    \vspace{6pt}
    \stepcounter{question}
    \setlength{\parskip}{6pt}
    \setlength{\baselineskip}{21pt}
    \thequestion \hangindent = 24pt \BODY
}
\else
\raisebox{#1\textheight}{\parbox{\textwidth}{
    \vspace{6pt}
    \stepcounter{question}
    \setlength{\parskip}{6pt}
    \setlength{\baselineskip}{21pt}
    \thequestion \hangindent = 24pt \BODY
}}
\fi
\par
}

% ---------- solution 环境 ----------
\NewEnviron{solution}{
\ifsolution
\parbox{\textwidth}{
    \vspace{6pt}
    \setlength{\parskip}{6pt}
    \setlength{\baselineskip}{21pt}
    \textbf{解：}\BODY
}
\fi
}

% ---------- page1 环境 ----------
\NewEnviron{page1}{
\ifsolution
    \makebox[\textwidth]{\fontsize{16pt}{\baselineskip}\selectfont \textbf{华侨大学\examtype 考试卷答案}}
\else
    \makebox[\textwidth]{\fontsize{16pt}{\baselineskip}\selectfont \textbf{华侨大学\examtype 考试卷}}
\fi

\makebox[\textwidth]{\year 学年第\semester 学期（\examversion）}

\makebox[0.3\textwidth][l]{学院\uline{\hfill\college\hfill}}
\makebox[0.4\textwidth][c]{课程名称\uline{\hfill\course\hfill}}
\makebox[0.3\textwidth][fr]{考试日期\uline{\hfill\date\hfill}}

\ifsolution
\BODY
\else
\makebox[0.22\textwidth][l]{姓名\uline{\hfill}}
\makebox[0.22\textwidth][l]{专业\uline{\hfill}}
\makebox[0.22\textwidth][l]{学号\uline{\hfill}}
\makebox[0.34\textwidth][l]{任课教师姓名\uline{\hfill}}

\framebox[15cm][l]{\parbox{\textwidth}{
{
    \renewcommand{\arraystretch}{1.5}
    \begin{tabularx}{14.57cm}[t]{|*7{>{\centering\arraybackslash}X|}}
    \hline
    \textbf{题\hspace{12pt}号} & 一 & 二 & 三 & 四 & 五 & 总分 \\
    \hline
    \textbf{得\hspace{12pt}分} & & & & & & \\
    \hline
    \end{tabularx}
}
\BODY
}}
\fi
}

% ---------- page2 环境 ----------
\NewEnviron{page2}{
\ifsolution
\BODY
\else
\framebox[15cm][l]{\parbox{\textheight}{
    \BODY
}}
\fi
}

% ---------- 版本控制 ----------
% 根据 examversion 选项设置版本
\ifdefined\examversion
    \if\examversion A%
        \includecomment{versionA}
        \excludecomment{versionB}
    \else
        \excludecomment{versionA}
        \includecomment{versionB}
    \fi
\else
    \includecomment{versionA}
    \excludecomment{versionB}
\fi

% ---------- 纸张设置 ----------
% 根据 solution 选项设置纸张大小
\ifsolution
\geometry{a3paper,top=1cm,bottom=2cm,left=1cm,right=1cm,bindingoffset=0cm}
\def\figwidth{0.3\textwidth}
\else
\geometry{a4paper,top=2.54cm,bottom=2.54cm,left=3.17cm,right=3.17cm,bindingoffset=0cm}
\def\figwidth{0.5\textwidth}
\fi

% ---------- 输出控制 ----------
% 用户可在 MS.tex 中覆盖默认值
% 通过 \solutiontrue/\solutionfalse 切换
% 通过 \includecomment/\excludecomment 控制版本