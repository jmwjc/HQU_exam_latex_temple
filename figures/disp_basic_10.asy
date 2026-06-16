// 位移法三类基本结构 + 弯矩图
import graph;
usepackage("amsmath");
settings.tex = "pdflatex";
settings.outformat = "pdf";
size(12cm, 0);
defaultpen(fontsize(14pt));
include "figures/struct_mech";

real y0 = 0, dy = -4, L = 7;
real i = 0.3;

real f(real x) {
    return 0.2*(0.5*x^2-5/8*L*x+L^2/8);
}
real y = y0;
draw((0,y)--(L,y), linewidth(1.2));
fixed_support((0,y), W);
roller_support((L,y), S);
uniform_load((0,y),(L,y));
label("$A$", (-0.3,y), SW);
label("$B$", (L,y), SE);

real m = 0.2*L^2/8;
draw(graph(f,0,L), blue);
draw((0,y)--(0,y+m), blue);
label("$\displaystyle -\frac{1}{8}ql^2$", (0,y+m), NE, blue);
label("$l$", (L/2, y), S);
label("$q$", (L/2, y+0.5), N);
label("$\displaystyle F_{QAB}=\frac{5}{8}ql,\quad F_{QBA}=-\frac{3}{8}ql$",(L/2, y-1.2));
