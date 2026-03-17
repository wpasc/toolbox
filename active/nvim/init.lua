-- NeoVim Configuration
-- Philosophy: Learn defaults first, override only for clear ergonomic wins

-- =============================================================================
-- LEADER KEY
-- =============================================================================
-- Setting leader before lazy.nvim loads (required)
-- Space is popular because it's easy to hit and not used for much in normal mode
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- =============================================================================
-- CORE OPTIONS
-- =============================================================================

-- Line numbers
vim.opt.number = true

-- Indentation (adjust per project as needed)
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search behavior
vim.opt.ignorecase = true  -- Case insensitive search...
vim.opt.smartcase = true   -- ...unless you use capitals

-- Visual feedback
vim.opt.cursorline = true  -- Highlight current line
vim.opt.signcolumn = "yes" -- Always show sign column (avoids layout shift)
vim.opt.termguicolors = true -- Enable 24-bit color

-- Scrolling
vim.opt.scrolloff = 8 -- Keep 8 lines visible above/below cursor

-- Splits (more intuitive positioning)
vim.opt.splitright = true -- Vertical splits open to the right
vim.opt.splitbelow = true -- Horizontal splits open below

-- Set terminal title to just the filename (tail only).
-- tmux picks this up as the window name via #{pane_title}.
-- Default titlestring includes path and "- NVIM" which bloats tmux tabs.
vim.opt.title = true
vim.opt.titlestring = "%t"

-- Clipboard (use system clipboard)
-- On remote machines there is no clipboard provider (no X11/Wayland/pbcopy).
-- OSC 52 tunnels clipboard data through the SSH connection to the local terminal.
-- Requires: Neovim 0.10+, and a terminal that supports OSC 52 (iTerm2 does).
-- If using tmux, also add to tmux.conf: set -g set-clipboard on
vim.opt.clipboard = "unnamedplus"
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}

-- Yank/change reporting (default is 2, so single-line yanks are silent)
vim.opt.report = 0

-- Undo persistence (keep undo history across sessions)
vim.opt.undofile = true

-- Folding (nvim-ufo needs these)
vim.opt.foldcolumn = "1"     -- show fold indicators in gutter
vim.opt.foldlevel = 99       -- start with all folds open
vim.opt.foldlevelstart = 99  -- start with all folds open for new buffers
vim.opt.foldenable = true

-- =============================================================================
-- KEYMAPS - OVERRIDES WITH CLEAR RATIONALE
-- =============================================================================
-- Format: vim.keymap.set(mode, key, action, { desc = "description" })

-- EXAMPLE: Half-page scroll with cursor centered (candidate for Ctrl-j/k later)
-- Default Ctrl-d/u work fine, but you mentioned wanting Ctrl-j/k
-- Uncomment these if you want to try that override:
-- vim.keymap.set("n", "<C-j>", "<C-d>zz", { desc = "Half-page down, centered" })
-- vim.keymap.set("n", "<C-k>", "<C-u>zz", { desc = "Half-page up, centered" })

-- H/L for start/end of line (more ergonomic than ^/$)
-- Originals (top/bottom of screen) are rarely used; these compose with operators:
-- dL = delete to end of line, yH = yank to start, vL = select to end, etc.
vim.keymap.set({ "n", "v", "o" }, "H", "^", { desc = "Start of line (first non-blank)" })
vim.keymap.set({ "n", "v", "o" }, "L", "$", { desc = "End of line" })

-- J/K for half-page scroll with centering (modifier key extends base j/k movement)
-- Overrides: J (join lines — use :join instead), K (keyword lookup — rarely used)
vim.keymap.set({ "n", "v" }, "J", "<C-d>zz", { desc = "Half-page down, centered" })
vim.keymap.set({ "n", "v" }, "K", "<C-u>zz", { desc = "Half-page up, centered" })

-- Keep search results centered
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result, centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result, centered" })

-- Clear search highlight with Escape
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Exit insert mode with jk (home row, no modifier needed)
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Save / quit (no more :wq!)
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>wq", "<cmd>wq<CR>", { desc = "Save and quit" })
vim.keymap.set("n", "<leader>qq", "<cmd>q!<CR>", { desc = "Force quit" })

-- Copy file path to system clipboard
-- cp/cr/cf = copy path/relative/filename — covers all common paste contexts.
-- Absolute for terminals/chat, relative for project references, filename for quick mention.
vim.keymap.set("n", "<leader>cp", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy absolute path" })
vim.keymap.set("n", "<leader>cr", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy relative path" })
vim.keymap.set("n", "<leader>cf", function()
  local name = vim.fn.expand("%:t")
  vim.fn.setreg("+", name)
  vim.notify("Copied: " .. name)
end, { desc = "Copy filename" })

-- =============================================================================
-- CHEAT SHEET (floating window with custom overrides and leader bindings)
-- =============================================================================
local function show_cheatsheet()
  local lines = {
    "  CUSTOM OVERRIDES                          ",
    "  ──────────────────────────────────────────",
    "  H          Start of line (replaces ^)     ",
    "  L          End of line (replaces $)       ",
    "  J          Half-page down, centered       ",
    "  K          Half-page up, centered         ",
    "  jk         Exit insert mode               ",
    "  n / N      Next/prev search, centered     ",
    "  <Esc>      Clear search highlight          ",
    "",
    "  LEADER BINDINGS  (<leader> = Space)       ",
    "  ──────────────────────────────────────────",
    "  <leader>?    This cheat sheet             ",
    "  <leader>w    Save file                    ",
    "  <leader>wq   Save and quit                ",
    "  <leader>qq   Force quit                   ",
    "  <leader>e    Toggle file explorer         ",
    "  <leader>o    Focus file explorer          ",
    "",
    "  <leader>ff   Find files                   ",
    "  <leader>fg   Live grep                    ",
    "  <leader>fb   Find buffers                 ",
    "  <leader>fr   Find references (LSP)        ",
    "",
    "  <leader>gb   Toggle git blame             ",
    "  <leader>gd   Diff view (vs index)         ",
    "  <leader>gm   Diff vs main (PR view)       ",
    "  <leader>gh   File git history             ",
    "  <leader>gq   Close diff view              ",
    "",
    "  <leader>mr   Toggle markdown render       ",
    "  <leader>mp   Toggle markdown preview      ",
    "",
    "  <leader>cp   Copy absolute file path       ",
    "  <leader>cr   Copy relative file path       ",
    "  <leader>cf   Copy filename only            ",
    "",
    "  <leader>cc   CLI tool cheat sheets        ",
    "",
    "  LSP (when language server attached)       ",
    "  ──────────────────────────────────────────",
    "  gd           Go to definition             ",
    "  gr           Go to references             ",
    "  <leader>k    Hover docs                   ",
    "  <leader>rn   Rename symbol                ",
    "  <leader>ca   Code action                  ",
    "  <leader>d    Show diagnostic              ",
    "  [d / ]d      Prev/next diagnostic         ",
    "",
    "  Press q or <Esc> to close                 ",
  }

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = "wipe"

  local width = 48
  local height = #lines
  local ui = vim.api.nvim_list_uis()[1]
  local row = math.floor((ui.height - height) / 2)
  local col = math.floor((ui.width - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " Cheat Sheet ",
    title_pos = "center",
  })

  local function close()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end
  vim.keymap.set("n", "q", close, { buffer = buf, nowait = true })
  vim.keymap.set("n", "<Esc>", close, { buffer = buf, nowait = true })
end

vim.keymap.set("n", "<leader>?", show_cheatsheet, { desc = "Show cheat sheet" })

-- =============================================================================
-- CLI TOOL CHEAT SHEETS (markdown files opened via Telescope)
-- =============================================================================
-- Cheat sheets live in active/cli-tools/notes/ (sibling to this nvim config dir)
-- Uses Telescope to pick a file, then opens it with render-markdown.nvim rendering
local function get_cheatsheet_dir()
  local config_dir = vim.fn.resolve(vim.fn.stdpath("config"))
  return vim.fn.fnamemodify(config_dir, ":h") .. "/cli-tools/notes"
end

vim.keymap.set("n", "<leader>cc", function()
  local dir = get_cheatsheet_dir()
  if vim.fn.isdirectory(dir) == 0 then
    vim.notify("Cheat sheets not found: " .. dir, vim.log.levels.WARN)
    return
  end
  require("telescope.builtin").find_files({
    prompt_title = "CLI Cheat Sheets",
    cwd = dir,
  })
end, { desc = "CLI tool cheat sheets" })

-- =============================================================================
-- PLUGIN MANAGER (lazy.nvim)
-- =============================================================================
-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- PLUGINS
-- =============================================================================
require("lazy").setup({
  -- Colorscheme (VS Code Default Dark Modern)
  {
    "gmr458/vscode_modern_theme.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vscode_modern").setup({
        cursorline = true,
        transparent_background = false,
      })
      vim.cmd.colorscheme("vscode_modern")
    end,
  },

  -- Keymap popup (press <leader> and wait to see available bindings)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        delay = 300, -- ms before popup appears
      })
      -- Label groups so the popup shows "+find", "+git", etc.
      wk.add({
        { "<leader>?", desc = "Show cheat sheet" },
        { "<leader>c", group = "copy/cheatsheets" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>m", group = "markdown" },
      })

      -- Vim builtins cheat sheet (add bindings here as you learn them)
      -- These don't change behavior, just add descriptions to which-key
      wk.add({
        -- Folding
        { "za", desc = "Toggle fold under cursor" },
        { "zo", desc = "Open fold under cursor" },
        { "zc", desc = "Close fold under cursor" },
        { "zR", desc = "Open all folds (ufo)" },
        { "zM", desc = "Close all folds (ufo)" },
        { "zK", desc = "Peek inside fold (ufo)" },
        -- Navigation
        { "gg", desc = "Go to first line" },
        { "G", desc = "Go to last line" },
        { "%", desc = "Jump to matching bracket" },
        { "{", desc = "Previous blank line" },
        { "}", desc = "Next blank line" },
        { "<C-d>", desc = "Half-page down" },
        { "<C-u>", desc = "Half-page up" },
        { "<C-o>", desc = "Jump back (older)" },
        { "<C-i>", desc = "Jump forward (newer)" },
        -- Editing
        { "ciw", desc = "Change inner word" },
        { "diw", desc = "Delete inner word" },
        { "yiw", desc = "Yank (copy) inner word" },
        { "ci\"", desc = "Change inside quotes" },
        { "da{", desc = "Delete around braces" },
        { ">>", desc = "Indent line" },
        { "<<", desc = "Unindent line" },
        { "~", desc = "Toggle case" },
        { ".", desc = "Repeat last change" },
        { "u", desc = "Undo" },
        { "<C-r>", desc = "Redo" },
      })
    end,
  },

  -- File explorer (neo-tree)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        window = { width = 35 },
        filesystem = {
          follow_current_file = { enabled = true },
          filtered_items = { visible = true },
        },
      })
      vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle file explorer" })
      vim.keymap.set("n", "<leader>o", "<cmd>Neotree focus<CR>", { desc = "Focus file explorer" })
    end,
  },

  -- Git signs in gutter + blame
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = false, -- Toggle with :Gitsigns toggle_current_line_blame
      })
      -- Toggle inline blame with leader+gb
      vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle git blame" })
    end,
  },

  -- Diff viewer (PR-style side-by-side diffs)
  {
    "sindrets/diffview.nvim",
    config = function()
      vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Open diff view (vs index)" })
      vim.keymap.set("n", "<leader>gm", "<cmd>DiffviewOpen main<CR>", { desc = "Diff vs main (PR view)" })
      vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "File git history" })
      vim.keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<CR>", { desc = "Close diff view" })
    end,
  },

  -- Status line (minimal, informative)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "auto" },
      })
    end,
  },

  -- Fuzzy finder (essential for navigation)
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "Find references" })
    end,
  },

  -- Syntax highlighting (treesitter)
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = function()
      require("nvim-treesitter").install({ "lua", "python", "javascript", "typescript", "markdown", "json", "yaml" })
    end,
  },

  -- Markdown rendering (inline in buffer)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    config = function()
      require("render-markdown").setup({})
      vim.keymap.set("n", "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle markdown render" })
    end,
  },

  -- Markdown preview in browser (full render with heading sizes, mermaid, etc.)
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = "cd app && npm install",
    config = function()
      vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle markdown preview (browser)" })
    end,
  },

  -- Folding (nvim-ufo: async folds with preview, powered by treesitter)
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" } -- treesitter first, indent as fallback
        end,
      })
      -- Override default fold commands with ufo versions
      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
      vim.keymap.set("n", "zK", function()
        require("ufo").peekFoldedLinesUnderCursor()
      end, { desc = "Peek inside fold" })
    end,
  },

  -- =============================================================================
  -- LSP + COMPLETION (Python IDE features)
  -- =============================================================================

  -- Mason: auto-installs LSP servers and tools
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Bridge between mason and lspconfig (auto-setup installed servers)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "ruff" },
      })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-e>"] = cmp.mapping.abort(),
        }),
      })
    end,
  },

  -- LSP configuration (vim.lsp.config API — requires Neovim 0.11+)
  -- nvim-lspconfig provides default server configs (cmd, filetypes, root_dir);
  -- we override with capabilities and enable via the native vim.lsp API.
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Pyright: type checking, go-to-definition, references, hover
      -- (Same engine as Pylance in VS Code/Cursor)
      vim.lsp.config("pyright", {
        capabilities = capabilities,
      })

      -- Ruff: fast linting + formatting (replaces flake8, isort, black)
      vim.lsp.config("ruff", {
        capabilities = capabilities,
      })

      vim.lsp.enable({ "pyright", "ruff" })

      -- LSP keymaps (active only when a language server attaches)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local opts = function(desc)
            return { buffer = event.buf, desc = desc }
          end
          -- Navigation
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("Go to references"))
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
          -- Info + refactoring
          vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts("Hover documentation"))
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename symbol"))
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
          -- Diagnostics
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts("Previous diagnostic"))
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts("Next diagnostic"))
          vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts("Show diagnostic"))
        end,
      })
    end,
  },

  -- =============================================================================
  -- BOOKMARKS - PLACEHOLDER
  -- =============================================================================
  -- TODO: Add bookmark plugin when needed
  -- Options: marks.nvim, vim-bookmarks, or use built-in marks

}, {
  -- lazy.nvim options
  checker = { enabled = false }, -- Don't auto-check for updates
})

-- =============================================================================
-- DIAGNOSTICS (inline error display, like Cursor's squiggly lines)
-- =============================================================================
vim.diagnostic.config({
  virtual_text = true,      -- Show error text at end of line
  signs = true,             -- Show signs in the gutter
  underline = true,         -- Underline problematic code
  update_in_insert = false, -- Don't update while typing (less noisy)
  severity_sort = true,     -- Show errors before warnings
})

-- =============================================================================
-- FORMAT ON SAVE (Python only — ruff lint fixes + formatting)
-- =============================================================================
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    -- Apply ruff lint fixes (unused imports, isort, etc.)
    vim.lsp.buf.code_action({
      context = { only = { "source.fixAll.ruff" }, diagnostics = {} },
      apply = true,
    })
    -- Format with ruff
    vim.lsp.buf.format({ async = false })
  end,
})

-- =============================================================================
-- FUTURE KEYMAPS TO CONSIDER
-- =============================================================================
-- These are commented out - uncomment and test as you learn what you need
--
-- Window navigation (without Ctrl-w prefix):
-- vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
--
--
-- =============================================================================
-- IDEAS TO EXPLORE
-- =============================================================================
-- Consistent insert/normal mode navigation:
--   Some keys (like Ctrl-a/Ctrl-e for line start/end) could work in both modes
--   to reduce the mental overhead of switching. Investigate what insert-mode
--   mappings are safe to add without conflicting with Vim builtins.
--
-- Better way to leave insert mode:
--   Using jk (configured above). Also: <C-[> is a built-in Esc alias.
