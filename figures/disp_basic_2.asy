// 位移法三类基本结构 + 弯矩图
usepackage("amsmath");
settings.tex = "pdflatex";
settings.outformat = "pdf";
size(12cm, 0);
defaultpen(fontsize(14pt));
include "figures/struct_mech";

real y0 = 0, dy = -4, L = 7;
real i = 0.8;

// ============================================================
// (a) 两端固定梁
// ============================================================
real y = y0;
draw((0,y)--(L,y), linewidth(1.2));
fixed_support((0,y), W);
fixed_support((L,y), E);
label("$A$", (-0.3,y), SW);
label("$B$", (L,y), SW);

real m = 6*i/L;
draw((0,y)--(0,y+m), blue);
draw((L,y)--(L,y-m), blue);
draw((0,y+m)--(L,y-m), blue);
label("$\displaystyle -6\frac{i}{l}$", (0,y+m), NE, blue);
label("$\displaystyle -6\frac{i}{l}$", (L,y-m), SW, blue);
label("$l$", (L/2, y), N);
dimension((L,y),(L,y-1));
label("$\Delta=1$", (L+1.2, y-0.5));
label("$\displaystyle F_{QAB}=12\frac{i}{l^2},\quad F_{QBA}=12\frac{i}{l^2}$",(L/2, y-2));
