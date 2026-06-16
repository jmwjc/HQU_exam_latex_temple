// 位移法三类基本结构 + 弯矩图
usepackage("amsmath");
settings.tex = "pdflatex";
settings.outformat = "pdf";
size(12cm, 0);
defaultpen(fontsize(14pt));
include "figures/struct_mech";

real y0 = 0, dy = -4, L = 7;
real i = 0.3;

// ============================================================
// (a) 两端固定梁
// ============================================================
real y = y0;
draw((0,y)--(L,y), linewidth(1.2));
fixed_support((0,y), W);
roller_support((L,y), S);
draw((0,y)--(0.7*sin(pi/6),y+0.7*cos(pi/6)));
draw((0,y)--(0.7*cos(pi/6),y-0.7*sin(pi/6)));
label("$A$", (-0.3,y), SW);
label("$B$", (L,y), SW);
label("$\theta=1$", (0, y+0.7));

real m = 3*i;
draw((0,y)--(0,y-m), blue);
draw((0,y-m)--(L,y), blue);
label("$3i$", (0,y-m), SE, blue);
label("0", (L,y), N, blue);
label("$l$", (L/2, y), N);
label("$\displaystyle F_{QAB}=-\frac{3i}{l},\quad F_{QBA}=-\frac{3i}{L}$",(L/2, y-1.2));