// A卷 Q3(a) — 平面桁架/组合结构几何构造分析
settings.tex = "pdflatex";
settings.outformat = "pdf";
size(5cm, 0);
defaultpen(fontsize(10pt));
include "figures/struct_mech";

pair A = (0,0), B = (0,3), C = (2,1), D = (2,0);
pair E = (3,1), F = (3,0), G = (5,0), H = (5,3);

draw(A -- B);
draw(E -- F);
draw(H -- G);
draw(C -- D);
draw(A -- D);
draw(D -- F);
draw(F -- G);
draw(C -- E);
draw(B -- H);
draw(B -- C);
draw(E -- A);
draw(E -- G);
draw(C -- H);

hinge_joint(A, 0.8);
hinge_joint(B, 0.8);
hinge_joint(C, 0.8);
hinge_joint(D, 0.8);
hinge_joint(E, 0.8);
hinge_joint(F, 0.8);
hinge_joint(G, 0.8);
hinge_joint(H, 0.8);

pinned_support(A, S, 0.8);
roller_support(G, S, 0.8);