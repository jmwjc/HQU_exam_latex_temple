// A卷 Q3(b) — 菱形组合桁架几何构造分析
settings.tex = "pdflatex";
settings.outformat = "pdf";
size(5cm, 0);
defaultpen(fontsize(10pt));
include "figures/struct_mech";

pair A = (0,2), B = (2,3), C = (2,2), D = (2,1), E = (2,0), F = (1,0);
pair G = (4,3), H = (4,2), I = (4,1), J = (4,0), K = (6,2);


draw(A--B);
draw(B--G);
draw(G--K);
draw(A--C);
draw(C--H);
draw(H--K);
draw(C--D);
draw(H--I);
draw(C--I);
draw(D--H);
draw(B--H);
draw(C--G);
draw(A--D);
draw(I--K);

hinge_joint(A,0.8);
hinge_joint(B,0.8);
hinge_joint(C,0.8);
hinge_joint(D,0.8);
hinge_joint(G,0.8);
hinge_joint(H,0.8);
hinge_joint(I,0.8);
hinge_joint(K,0.8);

pinned_support(D, S, 0.8);
roller_support(I, S, 0.8);