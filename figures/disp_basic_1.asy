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
fixed_support((L,y), E);
label("$A$", (-0.3,y), SW);
label("$B$", (L,y), SW);

// θ_A=1 弯矩图（蓝）
real ma = 4*i, mb = 2*i;
draw((0,y)--(0,y-ma), blue);
draw((L,y)--(L,y+mb), blue);
draw((0,y-ma)--(L,y+mb), blue);
draw((0,y)--(0.7*sin(pi/6),y+0.7*cos(pi/6)));
draw((0,y)--(0.7*cos(pi/6),y-0.7*sin(pi/6)));
label("$4i$", (0,y-ma), S, blue);
label("$2i$", (L,y+mb), N, blue);
label("$\theta=1$", (0, y+0.7));
label("$l$", (L/2, y), N);
angle_dimension((0,y),(0,1),(sin(pi/6),cos(pi/6)));
label("$\displaystyle F_{QAB}=-6\frac{i}{l},\quad F_{QBA}=-6\frac{i}{l}$",(L/2, y-2));