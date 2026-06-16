// A卷 Q5 — 两铰门式刚架力法（水平均布荷载q）
settings.tex = "pdflatex";
settings.outformat = "pdf";
size(10cm, 0);
defaultpen(fontsize(10pt));
include "figures/struct_mech";

real H = 6, L = 8;
pair A = (0,0), B = (0,H), C = (L,H), D = (L,0);

// 杆件
draw(A--B, linewidth(1.5));
draw(B--C, linewidth(1.5));
draw(C--D, linewidth(1.5));

// 固定端
fixed_support(A, S);
fixed_support(D, S);

// 铰节点 B, C
hinge_joint(B);
hinge_joint(C);

// 水平均布荷载（左柱，向右）
point_load(0.5*(A+B),E);

// 标注
label("$A$", 0.5*(B+C), N);
label("$I$", 0.5*(A+B), W);
label("$I$", 0.5*(C+D), W);
label("$12$kN", 0.5*(A+B)+(0.7,0), E);

// 尺寸
dimension((0,-1.0), (L,-1.0), offset=0, label="8m");
dimension((L+1.0,0), (L+1.0,H), offset=0, label="6m");
