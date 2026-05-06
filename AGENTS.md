# HQU Exam LaTeX Template

本项目是华侨大学研究生考试卷及参考答案的 LaTeX 模板，用于生成单一来源的考试卷（A4）和参考答案（A3）。

## 项目概述

- **用途**：生成研究生课程《弹塑性力学与有限元》期末考试卷及参考答案。
- **主要文件**：`MS.tex`（唯一源文件，包含题目与解答）。
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
├── MS.tex              # 唯一源文件：题目 + 解答 + 版本控制
├── simsun.ttc          # 中文字体（宋体）
├── .aux/               # latexmk 辅助文件输出目录
│   ├── MS.aux
│   ├── MS.fdb_latexmk
│   ├── MS.fls
│   ├── MS.log
│   ├── MS.xdv
│   └── comment.cut     # comment 包生成的裁剪内容
└── MS.synctex.gz       # SyncTeX 正向/反向搜索数据
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
\def\course{弹塑性力学与有限元} % 课程名称
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
- 修改 `\solutiontrue` / `\solutionfalse` 后，建议先执行 `latexmk -C -outdir=.aux MS.tex` 清理旧辅助文件，再重新编译，以避免条件编译残留导致排版异常。
