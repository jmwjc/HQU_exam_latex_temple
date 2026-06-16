// A卷 Q3(b) — 菱形组合桁架几何构造分析
settings.tex = "pdflatex";
settings.outformat = "pdf";
size(5cm, 0);
defaultpen(fontsize(10pt));
include "figures/struct_mech";

pair A = (0,0), B = (2,0), C = (4,0), D = (2,1.5), F = (2,3);

draw(A--D);
draw(B--D);
draw(C--F);
draw(D--F);

hinge_joint(D);
hinge_joint(F);

pinned_support(A, S);
pinned_support(B, S);
pinned_support(C, S);