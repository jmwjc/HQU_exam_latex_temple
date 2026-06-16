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

// θ_A=1 弯矩图（蓝）
real m = L/8;
draw((0,y)--(0,y+m), blue);
draw((0,y+m)--(L/2,y-m), blue);
draw((L/2,y-m)--(L,y+m), blue);
draw((L,y+m)--(L,y), blue);
point_load((L/2,y+0.7),dir=S);
label("$\displaystyle -8\frac{F_p l}{8}$", (0,y+m), NE, blue);
label("$\displaystyle -8\frac{F_p l}{8}$", (L,y+m), NW, blue);
label("$l$", (L/2, y), S);
label("$\displaystyle F_{QAB}=\frac{F_p}{2},\quad F_{QBA}=\frac{F_p}{2}$",(L/2, y-1.2));
