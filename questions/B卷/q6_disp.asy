// A卷 Q6 — L形刚架位移法（横梁均布q + D端力偶M）
settings.tex = "pdflatex";
settings.outformat = "pdf";
size(6cm, 0);
defaultpen(fontsize(10pt));
include "figures/struct_mech";

pair C = (0,0), B = (0,3), A = (0,6), D = (3,3);

// 杆件
draw(C--B, linewidth(1.2));   // 下柱
draw(B--A, linewidth(1.2));   // 上柱
draw(B--D, linewidth(1.2));   // 横梁

// 支座
fixed_support(C, S);           // 底端固定
roller_support(A, W);          // 顶部竖向链杆
pinned_support(D, S);          // 右端活动铰

// 荷载
point_load(0.5*(B+D));

// 标注
label("$A$", A, NW);
label("$B$", B, W);
label("$C$", C, NE);
label("$D$", D, NE);
label("$12\mathrm{kN}$", 0.5*(B+D), SE);

// 尺寸
dimension((-1.0,0), (-1.0,3), offset=0, label="3m");
dimension((-1.0,3), (-1.0,6), offset=0, label="3m");
dimension((0,-0.5), (3,-0.5), offset=0, label="3m");
