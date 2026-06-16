# HQU Exam LaTeX Template

本项目是华侨大学研究生考试卷及参考答案的 LaTeX 模板，用于生成单一来源的考试卷（A4）和参考答案（A3）。

## 项目概述

- **用途**：生成本科生课程《结构力学》（朱慈勉著）期末考试卷及参考答案。
- **主要文件**：`main.tex`（唯一源文件，包含题目与解答）。
- **技术栈**：XeLaTeX + `ctex`/`xeCJK`（中文支持）+ `comment`（条件编译）+ `environ`（自定义环境）。
- **字体**：项目根目录附带 `simsun.ttc`（宋体），通过 `\setCJKmainfont` 引入。
- **编译方式**：`latexmk -xelatex`。
- **辅助文件输出目录**：`.aux/`。

## 构建命令

生成考试卷（A4，不含解答）：

```bash
latexmk -xelatex -outdir=.aux MS.tex
```

生成参考答案（A3，含解答）：

1. 在 `MS.tex` 中将 `% \solutiontrue` 取消注释（即启用 `\solutiontrue`），并将 `\solutionfalse` 注释掉。
2. 重新运行：

```bash
latexmk -xelatex -outdir=.aux MS.tex
```

> 说明：启用 `\solutiontrue` 后，纸张自动切换为 A3，且仅输出 `solution` 环境内的内容。

生成不同版本（A/B 卷）：

- 在导言区，通过 `\includecomment{versionA}` / `\excludecomment{versionB}` 控制当前输出版本。
- 交换上述两条命令的注释状态即可切换为 B 卷。

## 项目结构

```
.
├── main.tex              # 唯一源文件：题目 + 解答 + 版本控制
├── simsun.ttc          # 中文字体（宋体）
├── .aux/               # latexmk 辅助文件输出目录
│   ├── main.aux
│   ├── main.fdb_latexmk
│   ├── main.fls
│   ├── main.log
│   ├── main.xdv
│   └── comment.cut     # comment 包生成的裁剪内容
└── main.synctex.gz       # SyncTeX 正向/反向搜索数据
```

## 代码组织与关键宏

### 条件编译标志

| 标志 | 作用 |
|------|------|
| `\solutiontrue` / `\solutionfalse` | 控制是否输出参考答案；同时控制纸张大小（A3/A4）和图宽参数 |
| `\includecomment{versionA}` / `\excludecomment{versionB}` | 控制输出 A 卷或 B 卷内容 |

### 自定义环境

- `\begin{question}{<raise_height>}` ... `\end{question}`
  - 题目环境，自动编号（一、二、三……）。
  - 参数 `<raise_height>` 为 `\raisebox` 高度系数（考试卷模式下用于调整题目垂直位置）。
- `\begin{solution}` ... `\end{solution}`
  - 解答环境。仅在 `\solutiontrue` 时输出。
- `\begin{page1}` ... `\end{page1}`
  - 首页环境：输出卷头（学院、课程、日期、得分表格等）。
- `\begin{page2}` ... `\end{page2}`
  - 第二页环境：考试卷模式下将内容框在 `\framebox` 内。

### 基本信息宏

在导言区修改以下宏即可适配不同课程：

```latex
\def\year{2025-2026}      % 学年
\def\semester{一}          % 学期（一/二）
\def\college{土木工程学院}  % 学院
\def\course{结构力学} % 课程名称
\def\date{2026.1.7}        % 考试日期
```

## 开发约定

1. **单文件维护**：所有题目与解答均写在 `MS.tex` 中，不拆分多文件。
2. **题目与解答成对出现**：每个 `question` 环境后紧跟对应的 `solution` 环境，便于同步修改。
3. **版本内容隔离**：A 卷和 B 卷的题目分别放在 `versionA` 和 `versionB` 环境中，互不干扰。
4. **数学排版**：使用 `amsmath` 的 `\[` `\]` 与 `aligned` 环境；张量指标统一使用 `ij`、`kl` 等下标。
5. **单位格式**：物理量与单位之间使用 `\,` 细空格分隔，如 `200 \, \text{GPa}`。

## 注意事项

- 本项目**不含** `pyproject.toml`、`package.json`、`Cargo.toml` 等现代编程语言配置文件，仅为纯 LaTeX 文档工程。
- `simsun.ttc` 为 TrueType 字体集合，macOS 下通过 `Path=./` 直接引用；在其他平台可能需要调整字体路径或改用系统宋体。
- `.aux/` 目录中的 `stress.*` 文件为历史遗留的编译产物，与当前主文件无关，可安全删除。
- 修改 `\solutiontrue` / `\solutionfalse` 后，建议先执行 `latexmk -C -outdir=.aux main.tex` 清理旧辅助文件，再重新编译，以避免条件编译残留导致排版异常。

---

## Asymptote 结构力学作图规则

> 组件库位于 `figures/struct_mech.asy`（单文件，含支座/荷载/度量全部组件）。
> 编译：从项目根目录执行 `asy -f pdf path/to/file.asy`

### 统一尺度约定

所有组件（支座、荷载、度量）的**核心跨度**均为 `0.55 * size`：

| 组件 | 跨度参数 | 含义 |
|------|---------|------|
| `pinned_support` | `h = 0.55*size` | 正三角形高 |
| `roller_support` | `len = 0.55*size` | 链杆长（两铰圆心距） |
| `sliding_support` | `gap = 0.55*size` | 两平行线间距 |
| `point_load` | `len = 0.55*size` | 箭头长度 |
| `uniform_load` | `len = 0.55*size` | 箭头长度 |

统一基础参数：

| 参数 | 值 | 含义 |
|------|-----|------|
| 基础半宽 `fw/hw/half_h` | `0.45 * size` | 四个支座一致 |
| 基础厚度 `fd` | `0.3 * size` | 四个支座一致 |
| 铰点半径 `r` | `0.09 * size` | pinned/roller/sliding 一致 |
| 影线间距 `hatch_spacing` | `0.6 mm` | 基础填充默认值 |
| 影线角度 `hatch_angle` | `-45`° | 默认斜向 |

### 支座 (supports.asy)

四种支座，`dir` 控制延伸方向（S=下, W=左, E=右, N=上）：

| 函数 | 画法 | 默认 dir |
|------|------|---------|
| `fixed_support(pos, dir)` | 杆端横线 + 填充基础 | `W` |
| `pinned_support(pos, dir)` | 正三角形 + 三顶点铰点 + 基础 | `S` |
| `roller_support(pos, dir)` | 两铰点 + 链杆 + 基础 | `S` |
| `sliding_support(pos, dir, foundation)` | 两平行线 + 4 铰点 + 可选基础 | `E` |

- 所有带基础的支座，基础在**最下层**（先 `hatch_block` 后 `draw` 支座图形）
- 基础顶边线宽与支座图形一致（`linewidth(1.2)`）
- `sliding_support` 铰点**切于**平行线（圆心偏移 `r`，非居中穿过）

### 荷载 (loads.asy)

| 函数 | 箭头约定 | 默认 dir |
|------|---------|---------|
| `point_load(pos, dir)` | 箭尾在作用点，尖端沿 dir 朝外 | `S`（↓） |
| `uniform_load(start, end, dir)` | 尖端在杆件（作用点），箭尾在远端，箭尾连线 | `N`（↓，从上至下） |
| `point_moment(pos, clockwise)` | 圆心=作用点，默认 90°→-90° 顺时针 180° 弧 | `clockwise=true` |

- 荷载默认红色（`pen p=red`）
- 线宽统一 `linewidth(1.0)`，箭头 `ArcArrow(SimpleHead, size=2.5mm)`
- `point_load` 标签在力中段右边；`uniform_load` 标签在箭尾连线上方
- `point_moment` 支持 `angle_start`/`angle_end` 自定义弧范围

### 度量 (dimensions.asy)

| 函数 | 用途 |
|------|------|
| `dimension(start, end, offset, label)` | 长度度量线 + 两端箭头 + 垂直短刻度 |
| `angle_dimension(vertex, dir1, dir2, radius, label)` | 角度弧 + 两端箭头 |

- 刻度**垂直于**度量线（`tick*n`）
- `offset` 正=法线方向偏下，负=反向

### 画图速查

```asy
// 模板头
settings.tex = "pdflatex";
settings.outformat = "pdf";
size(12cm, 0);                    // 固定宽度，自动高度，保持 x/y 等比例
defaultpen(fontsize(10pt));
include "figures/struct_mech";

// 定义节点坐标
pair A = (0,0), B = (4,0), C = (8,0);

// 杆件
draw(A -- B, linewidth(1.2));     // 单杆（linewidth 用 LW 变量或直接写数值）

// 支座（dir: S=下, W=左, E=右）
pinned_support(A, S, size=0.7);   // 固定铰
roller_support(B, S, size=0.7);   // 活动铰
fixed_support(C, W, size=0.7);    // 固定端
sliding_support(C, E, size=0.7);  // 定向滑动（可选 foundation=false）

// 铰点
hinge_joint(pos, size=0.09);      // 空心圆，表示铰接

// 荷载（dir: S=↓, N=↓从上至下）
point_load((x,y), S, size=0.7, label="P");                 // 集中力
uniform_load(A, B, N, size=0.7, label="q");                // 均布荷载
point_moment((x,y), size=0.7, label="M");                  // 集中弯矩（顺时针）
point_moment((x,y), label="M", clockwise=false);           // 逆时针

// 度量
dimension(A, B, offset=1.2, label="l");                    // 长度
angle_dimension(vertex, dir(0), dir(45), radius=0.5, label="θ");  // 角度

// 标注
label("$A$", A, SW);
dot(C);                             // 实心点标记截面位置
```

### 图片尺寸

```asy
size(14cm, 0);  // 固定宽度，自动高度，保持 x/y 等比例
```
