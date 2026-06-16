// A卷 Q3(a) — 平面桁架/组合结构几何构造分析
settings.tex = "pdflatex";
settings.outformat = "pdf";
size(5cm, 0);
defaultpen(fontsize(10pt));
include "figures/struct_mech";

pair A = (0,0), B = (0,3), C = (3,3), D = (3,0), F = (6,0), G = (6,3);

draw(A -- B);
draw(B -- C);
draw(D -- F);
draw(F -- G);
draw(B -- D);
draw(C -- F);

hinge_joint(B+(0.1,-0.1));
hinge_joint(F+(-0.1,0.1));

roller_support(A, W);
roller_support(C, N);
roller_support(D, S);
roller_support(G, E);