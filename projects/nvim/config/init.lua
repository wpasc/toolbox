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

-- Clipboard (use system clipboard)
vim.opt.clipboard = "unnamedplus"

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
vim.keymap.set({ "n", "v" }, "H", "^", { desc = "Start of line (first non-blank)" })
vim.keymap.set({ "n", "v" }, "L", "$", { desc = "End of line" })

-- Keep search results centered
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result, centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result, centered" })

-- Clear search highlight with Escape
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Exit insert mode with jk (home row, no modifier needed)
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

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
    branch = "0.1.x",
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
  -- LSP + COMPLETION (Python support, etc.) - PLACEHOLDER
  -- =============================================================================
  -- TODO: Add LSP config for Python (pyright or pylsp)
  -- TODO: Add nvim-cmp for autocompletion
  -- TODO: Add flake8/ruff integration
  -- Keeping this minimal for now - add when ready to dive into LSP

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
-- Quick save:
-- vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
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
