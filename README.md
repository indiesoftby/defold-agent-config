# Defold AI Agent Configuration

An example configuration of `AGENTS.md` and a set of skills (`.agents/`) for AI-assisted game development with the [Defold](https://defold.com) engine. While this is primarily a research project, you can freely use the configuration and skills in your own Defold projects.

The `.deps/` folder is used by the `defold-project-setup` skill to download project dependency sources and Defold builtins, giving your AI agent easy read-only access to dependency APIs and types. To update it after changing dependencies in `game.project`, run the `defold-project-setup` skill.

Translations: [Русский](README_RU.md)

## Supported AI Agents

The configuration uses the `.agents/` directory format, which is supported by:

- **[Amp](https://ampcode.com)**
- **[Claude Code](https://claude.ai/code)** (requires renaming `.agents/` to `.claude/`)
- **[Codex CLI](https://github.com/openai/codex)**
- **[Cursor](https://cursor.com)**
- **[Factory Droid](https://factory.ai)**
- **[GitHub Copilot](https://github.com/features/copilot)** (requires renaming `.agents/` to `.github/`)
- **[Kilo Code](https://kilocode.ai)**
- **[OpenCode](https://opencode.ai)**
- **[Warp](https://warp.dev)**
- **[Windsurf](https://windsurf.com)** (requires renaming `.agents/` to `.windsurf/`)
- and many others

## Prerequisites

- **[Defold](https://defold.com) >= 1.12.2**
- **Python >= 3.11** - required for skill scripts.
  - **Windows:** `winget install Python.Python.3`
  - **macOS:** `brew install python3`
  - **Linux:** `sudo apt-get install python3`

## Installation

1. Copy `AGENTS.md`, the `.agents/` folder, and the `.defignore` file into the root of your Defold project.

> **Note:** Some AI agents use their own directories:
> - **Claude Code**: Rename `.agents/` to `.claude/` and run find-and-replace across all `.md` files: `.agents/` → `.claude/`
> - **GitHub Copilot**: Rename `.agents/` to `.github/` and run find-and-replace across all `.md` files: `.agents/skills/` → `.github/skills/`
> - **Windsurf**: Rename `.agents/` to `.windsurf/` and run find-and-replace across all `.md` files: `.agents/` → `.windsurf/`

2. Ask your AI agent: `Run the defold-project-setup skill to download dependencies into .deps/`
3. Ask your AI agent: `Update AGENTS.md based on my project's structure, dependencies, and folders`

That's it - the agent will pick up the instructions and skills automatically.

## Installed... so what's next?

Open your project in Defold Editor and your AI agent side by side. Here's what you can do:

- **"Create a new screen called `main_menu` with two buttons: Play and Settings"** - the agent will use `monarch-screen-setup` to scaffold the screen collection, GUI, and script.
- **"Add a player game object with a sprite and collision"** - the agent will use `defold-proto-file-editing` to create `.go`, `.sprite`, and `.collisionobject` files.
- **"Write a script that moves the player left and right with arrow keys"** - the agent will look up the Defold input API and write a `.script` following project conventions.
- **"Build and run the game"** - the agent will use `defold-project-build` to compile via the running Defold Editor and report any errors.
- **"How does `go.animate` work?"** - the agent will fetch the API docs with `defold-api-fetch` and explain it with examples.
- **"I added a new dependency to game.project, update .deps"** — the agent will run `defold-project-setup` to re-download dependencies.
- **"Implement an isolated Lua module for arcade 2D collision based on quad-tree, with tests"** — the agent will write a self-contained module following project conventions and create unit tests for it.
- **"Isolate this code into a local Lua function and create its C++ native extension variant"** — the agent will refactor selected code into a Lua function and then use `defold-native-extension-editing` to create a C++ implementation.

Just describe what you want in plain language - the agent knows your project structure, Defold APIs, and all the conventions from `AGENTS.md`.

### Best practices

- **Plan first, then execute** - ask the agent to create a plan before implementing anything. Some agents even have a dedicated "plan" mode for this. Save the plan to a file (e.g. `PLAN.md`) and then ask the agent to implement it step by step in separate conversations.
- **One task per conversation** — smaller, focused requests produce better results than long multi-step sessions.
- **Keep context under ~65%** - when the conversation gets too long, the agent loses focus. Start a new chat session before that happens.
- **Add as many logs as possible** — the more `print()` calls your scripts have, the easier it is for the AI agent to debug issues from the output. For example, call `monarch.debug()` to log screen transitions. This project also includes a handy `fail_on_error()` function in `main/main.script` — it immediately closes the game on the first error, so you can see exactly where the problem occurred instead of scrolling through thousands of log lines.
- **Start from an existing project** — creating a complete game from scratch with an AI agent alone is unlikely to work well yet. The best approach is to add the agent files (`AGENTS.md`, `.agents/`) to an already working Defold project and build on top of it.

## Skills

The following skills are included in `.agents/skills/`:

| Skill | Description |
|---|---|
| **defold-api-fetch** | Fetches Defold engine API documentation |
| **defold-assets-search** | Searches the Defold Asset Store for community libraries and extensions |
| **defold-docs-fetch** | Fetches Defold manuals and conceptual documentation |
| **defold-examples-fetch** | Fetches Defold code examples by topic |
| **defold-native-extension-editing** | Assists with native extension development (C/C++, JS, manifests) |
| **defold-project-build** | Builds the project via the running Defold editor |
| **defold-project-setup** | Downloads project dependencies into `.deps/` |
| **defold-proto-file-editing** | Creates and edits Defold Protobuf Text Format files |
| **defold-scripts-editing** | Assists with Lua script editing |
| **defold-shaders-editing** | Creates and edits Defold shader files (.vp, .fp, .glsl) |
| **defold-skill-maintain** | Maintains and updates skill definitions |
| **monarch-screen-setup** | Sets up screens and popups using Monarch screen manager |
| **xmath-usage** | Provides xmath API reference and in-place math optimization patterns |

## Supported Defold Modules

The `AGENTS.md` configuration includes built-in awareness of these Defold libraries when they are present in your project:

- **[Monarch](https://github.com/britzl/monarch)** - Screen and popup management
- **[Object Interpolation](https://github.com/indiesoftby/defold-object-interpolation)** - Smooth object movement with fixed timestep
- **[Sharp Sprite](https://github.com/indiesoftby/defold-sharp-sprite)** - Pixel-perfect sprite rendering with RGSS materials
- **[Xmath](https://github.com/thejustinwalsh/defold-xmath)** - Zero-allocation in-place math operations for vectors, quaternions, and matrices

## Roadmap - and can the community help with that?...

1. **Battle-test on real projects** — use this configuration in production Defold projects and refine it along the way. Btw, you can always ask your AI agent to "improve this skill based on our conversation" and it will update the skill files automatically.
2. **New skills from best practices** — add skills for things the authors didn't think of right away: writing shaders, building high-performance games, separating logic from presentation, and more.
3. **Skills for popular libraries** — create skills for widely-used Defold libraries that activate automatically when the library is present in the user's project.
4. **Defold MCP server** — try building an [MCP](https://modelcontextprotocol.io/) server based on [Defold Editor's HTTP server API](https://gist.github.com/vlaaad/395bd021e8a4ba6561fd4f8d3562456f), allowing AI agents to interact with the running editor directly (evaluate editor scripts, read project structure, etc.).
5. **Identify gaps in Defold** — understand what Defold is missing as an engine and editor to reach the level of AI-assisted development that already exists for websites and mobile apps.

## Contributing

Contributions are welcome! Feel free to open issues and pull requests.

- 🌍 **Issues can be written in any language** - AI will translate and understand everything.
- 🐍 **All scripts in this project must be written in Python or native platform shell** (bash, PowerShell) to keep dependencies minimal and avoid requiring additional software.

## License

This project is dedicated to the public domain under the [CC0 1.0 Universal](LICENSE) license.
