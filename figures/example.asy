// example.asy — 结构力学组件库示例
// 编译：asy -f pdf figures/example.asy（从项目根目录）

settings.outformat = "pdf";
size(14cm, 0);
defaultpen(fontsize(11pt));
include "figures/struct_mech";

// === 简支梁 + 集中力 + 均布荷载 ===
real y1 = 0, L = 10;
draw((0,y1)--(L,y1), linewidth(1.2));
pinned_support((0,y1), S, size=0.9);
roller_support((L,y1), S, size=0.9);
point_load((L/3,y1), S, label="P");
uniform_load((2*L/3,y1), (L,y1), N, label="q");
label("$l$", (L/2, y1-0.8));

// === 悬臂梁 ===
real y2 = -3, Lc = 5;
draw((0,y2)--(Lc,y2), linewidth(1.2));
fixed_support((0,y2), W, size=0.9);
point_load((Lc,y2), S, label="F");
point_moment((Lc,y2), label="M_c");
point_moment((Lc-1.5,y2), label="M_a", clockwise=false);

// === 滑动支座对比 ===
real y3 = -6;
sliding_support((7.5,y3), E, size=0.8, foundation=true);
label("w/ base", (8.3,y3), E);
sliding_support((11,y3), E, size=0.8, foundation=false);
label("w/o base", (11.8,y3), E);

// === 度量 ===
real y4 = -8;
draw((0,y4)--(L,y4), linewidth(1.2));
pinned_support((0,y4), S, size=0.7);
roller_support((L,y4), S, size=0.7);
dimension((0,y4), (L,y4), offset=1.2, label="l");
