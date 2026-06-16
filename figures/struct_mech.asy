// struct_mech.asy — 结构力学计算简图组件库
// 用法：include "figures/struct_mech";
// 编译：asy -f pdf file.asy（从项目根目录）
// 修改 LW 即可统一调整所有线宽

import patterns;

real LW = 1.0;                      // 主线宽
real LW_D = LW;               // 细节线宽（铰点圆、刻度）
real LW_M = 0.6 * LW;               // 度量线宽

defaultpen(linewidth(LW));

// ============================================================
// 基础填充影线（内部辅助）
// ============================================================
void hatch_block(pair origin, pair dir, pair perp,
                 real half_width, real depth,
                 real hatch_angle=-45, real hatch_spacing=1.0,
                 pen p=currentpen) {
    pair n = unit(dir);
    pair t = unit(perp);
    path rect = (origin - half_width*t)
             -- (origin + half_width*t)
             -- (origin + half_width*t + depth*n)
             -- (origin - half_width*t + depth*n)
             -- cycle;
    string hname = "h" + string(hatch_angle) + "_" + string(hatch_spacing);
    add(hname, hatch(hatch_spacing*mm, dir(hatch_angle)));
    fill(rect, pattern(hname) + p);
}

// ============================================================
// 固定端 (Fixed support)
// ============================================================
void fixed_support(pair pos, pair dir=W, real size=1.0, pen p=currentpen,
                   real hatch_angle=-45, real hatch_spacing=0.6) {
    pair n = unit(dir);
    pair t = rotate(90) * n;
    real hw = 0.45 * size;
    real fd = 0.25 * size;
    draw(pos + hw*t -- pos - hw*t, p + linewidth(LW));
    hatch_block(pos + 0.04*fd*n, n, t, hw, fd, hatch_angle, hatch_spacing, p);
}

// ============================================================
// 固定铰支座 (Pinned support)
// ============================================================
void pinned_support(pair pos, pair dir=S, real size=1.0, pen p=currentpen,
                    real hatch_angle=-45, real hatch_spacing=1.0) {
    pair n = unit(dir);
    pair t = rotate(90) * n;
    real h = 0.55 * size;
    real w = h / sqrt(3);
    real r = 0.09 * size;
    real fw = 0.45 * size;
    real fd = 0.25 * size;
    pair base_L = pos + h*n - w*t;
    pair base_R = pos + h*n + w*t;
    hatch_block(pos + h*n, n, t, fw, fd, hatch_angle, hatch_spacing, p);
    draw((pos + h*n - fw*t) -- (pos + h*n + fw*t), p + linewidth(LW));
    draw(pos -- base_L -- base_R -- cycle, p + linewidth(LW));
    filldraw(circle(pos, r), white, p + linewidth(LW_D));
    filldraw(circle(base_L, r), white, p + linewidth(LW_D));
    filldraw(circle(base_R, r), white, p + linewidth(LW_D));
}

// ============================================================
// 活动铰支座 / 链杆支座 (Roller support)
// ============================================================
void roller_support(pair pos, pair dir=S, real size=1.0, pen p=currentpen,
                    real hatch_angle=-45, real hatch_spacing=1.0) {
    pair n = unit(dir);
    pair t = rotate(90) * n;
    real r = 0.09 * size;
    real len = 0.55 * size;
    real fw = 0.45 * size;
    real fd = 0.25 * size;
    pair bottom = pos + len*n;
    hatch_block(bottom, n, t, fw, fd, hatch_angle, hatch_spacing, p);
    draw(bottom - fw*t -- bottom + fw*t, p + linewidth(LW));
    draw(pos -- bottom, p + linewidth(LW));
    filldraw(circle(pos, r), white, p + linewidth(LW_D));
    filldraw(circle(bottom, r), white, p + linewidth(LW_D));
}

// ============================================================
// 定向滑动支座 (Sliding / guided support)
// ============================================================
void sliding_support(pair pos, pair dir=E, real size=1.0,
                     bool foundation=true, pen p=currentpen,
                     real hatch_angle=-45, real hatch_spacing=1.0) {
    pair n = unit(dir);
    pair t = rotate(90) * n;
    real gap = 0.6 * size;
    real half_h = 0.45 * size;
    real r = 0.09 * size;
    real h_offset = 0.25 * size;
    draw(pos + half_h*t -- pos - half_h*t, p + linewidth(LW));
    pair L2 = pos + gap*n;
    draw(L2 + half_h*t -- L2 - half_h*t, p + linewidth(LW));
    for (int i = -1; i <= 1; i += 2) {
        pair h1 = pos + r*n + i*h_offset*t;
        pair h2 = L2 - r*n + i*h_offset*t;
        draw(h1 -- h2, p + linewidth(LW_D));
        filldraw(circle(h1, r), white, p + linewidth(LW_D));
        filldraw(circle(h2, r), white, p + linewidth(LW_D));
    }
    if (foundation) {
        hatch_block(L2, n, t, half_h, 0.25*size, hatch_angle, hatch_spacing, p);
    }
}

// ============================================================
// 铰结点 (Hinge joint)
// ============================================================
void hinge_joint(pair pos, real size=1.0, pen p=currentpen) {
    filldraw(circle(pos, 0.09*size), white, p + linewidth(LW_D));
}

// ============================================================
// 集中力 (Point load)
// ============================================================
void point_load(pair pos, pair dir=S, real size=0.7, string label="",
                pen p=red, real offset=0.0) {
    pair n = unit(dir);
    real len = size;
    real as = 2.5 * size / 0.7;
    pair tail = pos + offset*n;
    pair tip = pos + offset*n + len*n;
    draw(tail -- tip, p + linewidth(LW),
         arrow=ArcArrow(SimpleHead, size=as*mm));
    pair label_pos = (tail + tip)/2 + (0.5*size) * (rotate(-90)*n);
    label("$" + label + "$", label_pos);
}

// ============================================================
// 集中弯矩 (Point moment)
// ============================================================
void point_moment(pair pos, real size=0.7, string label="",
                  pen p=red, bool clockwise=true,
                  real angle_start=90, real angle_end=-90) {
    real r = 0.5 * size;
    real as = 2.5 * size / 0.7;
    path g;
    if (clockwise) {
        g = arc(pos, r, angle_start, angle_end, CW);
    } else {
        g = arc(pos, r, angle_start, angle_end, CCW);
    }
    draw(g, p + linewidth(LW), arrow=ArcArrow(SimpleHead, size=as*mm));
    label("$" + label + "$", pos + (0, r + 0.3*size));
}

// ============================================================
// 均布荷载 (Uniform load)
// ============================================================
void uniform_load(pair start, pair end, pair dir=N, real size=0.7,
                  string label="", pen p=red) {
    pair n = unit(dir);
    real len = 0.55 * size;
    real as = 2.5 * size / 0.7;
    real L = length(end - start);
    real spacing = 0.5*size;
    int n_arrows = max(3, floor(L / spacing));
    for (int i = 0; i <= n_arrows; ++i) {
        real frac = i / (real)n_arrows;
        pair tip = interp(start, end, frac);
        pair tail = tip + len*n;
        draw(tail -- tip, p + linewidth(LW),
             arrow=ArcArrow(SimpleHead, size=as*mm));
    }
    draw(start + len*n -- end + len*n, p + linewidth(LW));
    pair mid = (start + end) / 2;
    label("$" + label + "$", mid + len*n + 0.4*size*n);
}

// ============================================================
// 长度度量 (Dimension)
// ============================================================
void dimension(pair start, pair end, real offset=0.5, string label="",
               pen p=currentpen) {
    pair d = unit(end - start);
    pair n = rotate(90) * d;
    if (n.y > 0) n = -n;
    real sign = (offset >= 0) ? 1 : -1;
    pair off = abs(offset) * n;
    pair ds = start + sign*off;
    pair de = end + sign*off;
    draw(ds -- de, p + linewidth(LW_M),
         arrow=Arrows(SimpleHead, size=1.5mm));
    real tick = 0.15;
    draw(ds - tick*n -- ds + tick*n, p + linewidth(LW_D));
    draw(de - tick*n -- de + tick*n, p + linewidth(LW_D));
    if (label != "") {
        pair mid = (ds + de) / 2;
        label("$" + label + "$", mid + 0.15*sign*n, align=-2.5*sign*n);
    }
}

// ============================================================
// 角度度量 (Angle dimension)
// ============================================================
void angle_dimension(pair vertex, pair dir1, pair dir2, real radius=0.4,
                     string label="", pen p=currentpen) {
    real a1 = degrees(dir1);
    real a2 = degrees(dir2);
    path arc_path = arc(vertex, radius, a1, a2);
    draw(arc_path, p + linewidth(LW_M),
         arrow=Arrows(SimpleHead, size=1.5mm));
    if (label != "") {
        real mid_a = (a1 + a2) / 2;
        pair label_pos = vertex + (radius + 0.18) * dir(mid_a);
        label("$" + label + "$", label_pos);
    }
}
