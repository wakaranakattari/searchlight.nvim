[![Lua](https://img.shields.io/badge/Made%20with%20Lua-blueviolet.svg?style=flat&logo=lua)](https://lua.org)
[![Neovim](https://img.shields.io/badge/Neovim-0.9%2B-green.svg?style=flat&logo=neovim)](https://neovim.io)

## 🔦 searchlight.nvim

#### Fast workspace search UI for Neovim powered by ripgrep.
#### Lightweight, keyboard-driven, no Telescope, no bloat.

---

### ✨ Features

- ⚡ Blazing fast search via ripgrep

- 📂 Results grouped by file

- 🌈 Syntax highlighted live preview

- 🧠 Uses real file buffers (full Vim highlighting, treesitter, folds)

- ⌨️ Fully keyboard controlled

- 🪶 Zero heavy dependencies

- 🧩 Works with Lazy.nvim, AstroNvim, vanilla setups

### 📦 Requirements
- Tool	Version
- Neovim	≥ 0.9
- ripgrep	latest

### 📥 Installation
#### Lazy.nvim
```lua
{
  "wakaranakattari/searchlight.nvim",
}
```

### 🚀 Usage
```vim
:Searchlight your_query
```

#### Example:
```vim
- :Searchlight function
```

#### Search runs across the current working directory.

### 🎮 Keybindings (Search Panel)

#### Key	Action
-  Enter	Open file at match
- Tab	Fold / unfold file results
- j / k	Navigate results
- q	Close search
- Preview auto	Cursor movement updates preview

### 🪟 Preview Window

#### Preview is a real Vim buffer, not fake text.

#### That means:

- Colorscheme works

- Treesitter works

- Filetype detection works

- Folding works

- Indentation works

- Matches are highlighted on top of syntax.

### 🧠 How It Works

- Uses rg --json for structured results

- Async job via libuv

- Custom UI renderer (no quickfix, no telescope)

- Separate state, panel, renderer, preview modules

### 📁 Project Structure
```bash
lua/custom/searchlight/
├── init.lua
├── panel.lua
├── preview.lua
├── renderer.lua
├── rg.lua
└── state.lua
plugin/
└── searchlight.lua
```
