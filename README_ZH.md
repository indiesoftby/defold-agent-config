# Defold AI Agent 配置

这份项目包含了 `AGENTS.md` 配置文件示例以及一系列 Skill  (`.agents/`)，旨在利用 AI 在 [Defold](https://defold.com) 引擎上进行游戏开发。这虽然是一个探索性项目，但你可以自由地在自己的项目中使用这些配置和 Skill 。

`.deps/` 文件夹被 `defold-project-setup` Skill 用于下载项目依赖库的源码和 Defold 内置模块 (builtins)，从而让你的 AI Agent 能够轻松访问 API 和类型（仅限读取）。在修改了 `game.project` 中的依赖后，请运行 `defold-project-setup` 技能进行更新。

翻译版本：[English](README.md) | [Русский](README_RU.md)

## 支持的 AI Agent

此配置采用 `.agents/` 目录格式，支持以下工具：

- **[Amp](https://ampcode.com)**
- **[Claude Code](https://claude.ai/code)** (需重命名 `.agents/` 为 `.claude/`)
- **[Codex CLI](https://github.com/openai/codex)**
- **[Cursor](https://cursor.com)**
- **[Factory Droid](https://factory.ai)**
- **[Gemini CLI](https://github.com/google-gemini/gemini-cli)**
- **[GitHub Copilot](https://github.com/features/copilot)** (需重命名 `.agents/` 为 `.github/`)
- **[Kilo Code](https://kilocode.ai)**
- **[OpenCode](https://opencode.ai)**
- **[Warp](https://warp.dev)**
- **[Windsurf](https://windsurf.com)** (需重命名 `.agents/` 为 `.windsurf/`)
- **[Trae CN](https://www.trae.cn)** (需重命名 `.agents/` 为 `.trae/`)
- **[Trae](https://www.trae.ai)** (需重命名 `.agents/` 为 `.trae/`)
- **[Codebuddy](https://www.codebuddy.ai)** (需重命名 `.agents/` 为 `.codebuddy/`)
- 以及其他许多 AI 工具

## 要求

- **[Defold](https://defold.com) >= 1.12.2**
- **Python >= 3.11** —— Skill 脚本运行所需。
  - **Windows:** `winget install Python.Python.3`
  - **macOS:** `brew install python3`
  - **Linux:** `sudo apt-get install python3`

## 安装步骤

1. 将 `AGENTS.md`、`.agents/` 文件夹和 `.defignore` 文件复制到你的 Defold 项目根目录。

> **注意：** 某些 AI Agent 使用特定的目录名：
> - **Claude Code**: 将 `.agents/` 重命名为 `.claude/`，并在所有 `.md` 文件中执行搜索替换：`.agents/` → `.claude/`
> - **GitHub Copilot**: 将 `.agents/` 重命名为 `.github/`，并在所有 `.md` 文件中执行搜索替换：`.agents/skills/` → `.github/skills/`
> - **Windsurf**: 将 `.agents/` 重命名为 `.windsurf/`，并在所有 `.md` 文件中执行搜索替换：`.agents/` → `.windsurf/`
> - **Trae CN**: 将 `.agents/` 重命名为 `.trae/`，并在所有 `.md` 文件中执行搜索替换：`.agents/` → `.trae/`
> - **Trae**: 将 `.agents/` 重命名为 `.trae/`，并在所有 `.md` 文件中执行搜索替换：`.agents/` → `.trae/`
> - **Codebuddy**: 将 `.agents/` 重命名为 `.codebuddy/`，并在所有 `.md` 文件中执行搜索替换：`.agents/` → `.codebuddy/`  

2. 对你的 AI Agent 说：`运行Skill defold-project-setup 以将依赖项下载到 .deps/`
3. 对你的 AI Agent 说：`根据我的项目结构、依赖项和文件夹更新 AGENTS.md`

完成了。这个 AI Agent 将自动识别指令和 Skill 。

## 关于 .deps 的 gitignore 设置 —— 请仔细阅读！

如果你将 `.deps/` 添加到 `.gitignore`（为了不提交下载的依赖库），**AI Agent 默认也会忽略它** —— 因为它们的内部工具（Glob, Grep, 文件选择器）会遵循 `.gitignore` 的规则。讽刺的是，虽然大多数 AI Agent 会对 JS 项目中的 `node_modules` 进行特殊处理强制索引，但 Defold 项目中的 `.deps` 却没有这种待遇。为了让代理能看到 `.deps` 但不让它进入 git 仓库，请添加以下文件：

**1. `.gitignore`** —— 使用 `.deps/**`（而不是 `/.deps`），这样取反规则才能生效：

```
.deps/**
```

**2. `.cursorignore`** (仅限 Cursor) —— 使用取反规则，强制索引 `.deps`：

```
!.deps
!.deps/**
```

**3. `.ignore`** (适用于 ripgrep/Grep) —— 同样的取反规则，使搜索能找到 `.deps` 中的文件：

```
!.deps
!.deps/**
```

**Claude Code** 没有 `.cursorignore`。请在 `.claude/settings.json` 中添加：

```json
{
  "permissions": {
    "allow": ["Read(./.deps/**)"]
  }
}
```

对于其他 AI Agent ，请查阅其文档寻找绕过方法（忽略文件、索引设置或访问权限）。

**自我检查：** 询问 AI Agent ：*“查找所有   input_binding 文件”*。它应该返回 `.deps/builtins/input/all.input_binding`。如果没有，说明 AI Agent 仍然看不到 `.deps`，请重新检查上述设置。

## 安装好了……然后呢？

在 Defold 编辑器中打开项目，并同时打开 AI Agent 。你可以尝试以下指令：

- **“创建一个名为 `main_menu` 的新屏幕，包含两个按钮：‘开始游戏’和‘设置’”** —— AI Agent 将使用 `monarch-screen-setup` 来创建 screen collection、GUI 和 script 。
- **“添加一个玩家游戏对象，带有精灵图和碰撞体”** —— AI Agent 将使用 `defold-proto-file-editing` 来创建 `.go`、`.sprite` 和 `.collisionobject` 文件。
- **“编写一个脚本，允许使用箭头键控制玩家左右移动”** —— AI Agent 将查找 Defold 输入 API 并根据项目规范编写 `.script`。
- **“编译并运行游戏”** —— AI Agent 将使用 `defold-project-build` 通过运行中的 Defold 编辑器进行编译，并报告任何错误。
- **“`go.animate` 是如何工作的？”** —— AI Agent 将通过 `defold-api-fetch` 加载 API 文档并给出示例。
- **“我在 game.project 中添加了新依赖，请更新 .deps”** —— AI Agent 将运行 `defold-project-setup` 重新下载依赖。
- **“基于 quad-tree 实现一个独立的 2D 碰撞检测 Lua 模块，并附带测试”** —— AI Agent 将根据项目规范编写自包含模块并创建单元测试。
- **“将这段代码提取到局部 Lua 函数中，并创建一个 C++ 原生扩展版本”** —— AI Agent 将提取代码，然后使用 `defold-native-extension-editing` 创建 C++ 实现。

只需描述你的需求（支持任何语言）—— AI Agent 已经通过 `AGENTS.md` 掌握了项目结构、Defold API 和所有规范。

### 最佳实践

- **先规划，后实现** —— 在动手前要求 AI Agent 制定计划。某些 AI Agent 有专门的“Plan”模式。你可以将计划保存到文件（如 `PLAN.md`），然后在不同的会话中分步骤让代理实现。
- **一事一议** —— 简短、专注的请求比冗长、多步骤的会话效果更好。
- **保持上下文在 65% 以下** —— 当会话变得太长时，AI Agent 会失去焦点。在此之前开启新的会话。
- **从已有项目开始** —— 目前仅靠 AI Agent 从零创建一个完整的游戏还很困难。最好的方法是将 AI Agent 文件（`AGENTS.md`, `.agents/`）加入到一个已经运行的 Defold 项目中并逐步扩展。
- **添加尽可能多的日志** —— 在脚本中调用的 `print()` 越多，AI Agent 通过输出调试问题的效率就越高。例如，调用 `monarch.debug()` 来记录屏幕切换。本项目还在 `main/main.script` 中提供了一个有用的 `fail_on_error()` 函数 —— 它会在发生第一个错误时立即关闭游戏，这样你就能立刻看到问题发生的位置，而不是翻阅数千行日志。

## Skill 列表 

`.agents/skills/` 包含以下Skill：

| Skill | 描述 |
|---|---|
| **defold-api-fetch** | 获取 Defold 引擎 API 文档 |
| **defold-assets-search** | 在 Defold 资源商店中搜索库和扩展 |
| **defold-docs-fetch** | 获取 Defold 指南和概念性文档 |
| **defold-examples-fetch** | 获取 Defold 各主题的代码示例 |
| **defold-native-extension-editing** | 辅助开发原生扩展 (C/C++, JS, 清单文件) |
| **defold-project-build** | 通过运行中的 Defold 编辑器构建项目 |
| **defold-project-setup** | 将项目依赖项下载到 `.deps/` |
| **defold-proto-file-editing** | 创建和编辑 Protobuf Text 格式的 Defold 文件 |
| **defold-scripts-editing** | 辅助编辑 Lua 脚本 |
| **defold-shaders-editing** | 创建和编辑 Defold 着色器文件 (.vp, .fp, .glsl) |
| **defold-skill-maintain** | 维护和更新技能定义 |
| **monarch-screen-setup** | 使用 Monarch 设置屏幕和弹出窗口 |
| **xmath-usage** | xmath API 参考及无分配数学优化模式 |

## 支持的 Defold 模块

`AGENTS.md` 配置包含对项目中以下库的内置支持：

- **[Monarch](https://github.com/britzl/monarch)** —— 屏幕和弹出窗口管理
- **[Object Interpolation](https://github.com/indiesoftby/defold-object-interpolation)** —— 具有固定时间步长的平滑物体运动
- **[Sharp Sprite](https://github.com/indiesoftby/defold-sharp-sprite)** —— 带有 RGSS 材质的像素完美精灵渲染
- **[Xmath](https://github.com/thejustinwalsh/defold-xmath)** —— 针对向量、四元数和矩阵的零分配数学运算

## 路线图 (Roadmap)

1. **实际项目测试** —— 在真实的 Defold 项目中使用此配置并不断迭代。顺便说一句，你可以随时要求 AI Agent “根据我们的对话优化此技能”，它会自动更新技能文件。
2. **基于最佳实践的新 Skill ** —— 添加开发者最初没想到的技能：编写着色器、优化游戏性能、分离逻辑与表现层等。
3. **热门库的 Skill ** —— 为流行的 Defold 库创建 Skill ，当项目中存在这些库时自动激活。
4. **Defold 的 MCP 服务** —— 尝试基于 [Defold 编辑器 HTTP 服务](https://gist.github.com/vlaaad/395bd021e8a4ba6561fd4f8d3562456f) 开发一个 [MCP](https://modelcontextprotocol.io/) 服务器，以便 AI Agent 能直接与编辑器交互。
5. **探索 Defold 的 AI 潜力** —— 确定引擎和编辑器还需要哪些功能，才能达到 Web 开发和移动应用开发那样的 AI 辅助水平。

## 参与贡献

我们欢迎任何形式的贡献！请随时开启 Issue 或提交 Pull Request。

- 🌍 **可以用任何语言提交 Issue** —— AI 会负责翻译和理解。
- 🐍 **项目中所有脚本必须使用 Python 或原生 Shell** (bash, PowerShell)，以避免增加依赖负担。

## 许可证

本项目通过 [CC0 1.0 Universal](LICENSE) 协议发布至公有领域。