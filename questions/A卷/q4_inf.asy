// A卷 Q4 — 多跨静定梁机动法影响线（求RC）
settings.tex = "pdflatex";
settings.outformat = "pdf";
size(10cm, 0);
defaultpen(fontsize(10pt));
include "figures/struct_mech";

real y = 0;
pair A = (0,y), B = (1,y), C = (2,y), D = (3,y), E = (4,y), F = (5,y);

// 梁（连续贯穿）
draw(A--F,linewidth(1.5));

fixed_support(A, W, 0.5);
roller_support(C-(0,0.04), S, 0.5);
roller_support(E-(0,0.04), S, 0.5);

// 铰节点 B, C, D, E
hinge_joint(B, 0.5);
hinge_joint(D, 0.5);

// 单位荷载 P=1
point_load(B, S, size=1.0, label="P=1");

// 标注
label("$A$", A, NE);
label("$B$", B, N);
label("$C$", C, N);
label("$D$", D, N);
label("$E$", E, N);
label("$F$", F, NE);
