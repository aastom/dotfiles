-- GitHub Copilot — AI pair programmer inside Neovim.
-- Uses the official LazyVim extras (coding.copilot + coding.copilot-chat)
-- which install zbirenbaum/copilot.lua and CopilotC-Nvim/CopilotChat.nvim.
-- This file adds extra keymaps, tweaks panel behaviour, and configures the
-- chat window to your preferences.
return {

  -- ─── copilot.lua ────────────────────────────────────────────────────────────
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,   -- show ghost-text automatically as you type
        debounce = 75,
        keymap = {
          accept = "<M-l>",        -- Alt+l  → accept whole suggestion
          accept_word = "<M-w>",   -- Alt+w  → accept one word
          accept_line = "<M-j>",   -- Alt+j  → accept one line
          next = "<M-]>",          -- Alt+]  → cycle to next suggestion
          prev = "<M-[>",          -- Alt+[  → cycle to previous suggestion
          dismiss = "<C-]>",       -- Ctrl+] → dismiss suggestion
        },
      },
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>",         -- Alt+Enter → open Copilot panel
        },
        layout = {
          position = "right",      -- "bottom" | "top" | "left" | "right"
          ratio = 0.35,
        },
      },
      -- Filetypes to explicitly enable/disable
      filetypes = {
        yaml = true,
        markdown = true,
        gitcommit = true,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
    },
  },

  -- ─── CopilotChat.nvim ───────────────────────────────────────────────────────
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      -- Model: Claude Opus 4.6 via GitHub Copilot
      model = "claude-opus-4.6",

      -- Window layout
      window = {
        layout = "vertical",  -- "vertical" | "horizontal" | "float" | "replace"
        width = 0.4,
        height = 0.6,
        title = " Copilot Chat",
      },
      -- Show diff when accepting code
      show_diff = true,
      -- Mappings inside the chat window
      mappings = {
        complete = { detail = "Use @<Tab> or /<Tab> for options", insert = "<Tab>" },
        close = { normal = "q", insert = "<C-c>" },
        reset = { normal = "<C-l>", insert = "<C-l>" },
        submit_prompt = { normal = "<CR>", insert = "<C-s>" },
        accept_diff = { normal = "<C-y>", insert = "<C-y>" },
        yank_diff = { normal = "gy", register = '"' },
        show_diff = { normal = "gd" },
        show_system_prompt = { normal = "gp" },
        show_user_selection = { normal = "gs" },
      },
    },
    keys = {
      -- Open / toggle chat
      { "<leader>aa", "<cmd>CopilotChatToggle<cr>",        desc = "Copilot Chat Toggle",          mode = { "n", "v" } },
      { "<leader>ac", "<cmd>CopilotChat<cr>",              desc = "Copilot Chat Open",             mode = { "n", "v" } },
      { "<leader>ar", "<cmd>CopilotChatReset<cr>",         desc = "Copilot Chat Reset",            mode = "n" },
      -- Quick prompts
      { "<leader>ae", "<cmd>CopilotChatExplain<cr>",       desc = "Copilot Explain",               mode = { "n", "v" } },
      { "<leader>af", "<cmd>CopilotChatFix<cr>",           desc = "Copilot Fix",                   mode = { "n", "v" } },
      { "<leader>at", "<cmd>CopilotChatTests<cr>",         desc = "Copilot Generate Tests",        mode = { "n", "v" } },
      { "<leader>ao", "<cmd>CopilotChatOptimize<cr>",      desc = "Copilot Optimize",              mode = { "n", "v" } },
      { "<leader>ad", "<cmd>CopilotChatDocs<cr>",          desc = "Copilot Generate Docs",         mode = { "n", "v" } },
      { "<leader>aR", "<cmd>CopilotChatReview<cr>",        desc = "Copilot Review",                mode = { "n", "v" } },
      -- Commit helpers
      { "<leader>am", "<cmd>CopilotChatCommit<cr>",        desc = "Copilot Commit Message",        mode = "n" },
      { "<leader>aM", "<cmd>CopilotChatCommitStaged<cr>",  desc = "Copilot Commit Staged Message", mode = "n" },
      -- Inline
      { "<leader>ai", "<cmd>CopilotChatInPlace<cr>",       desc = "Copilot Inline Chat",           mode = { "n", "v" } },
      -- Quick chat (freeform prompt)
      {
        "<leader>aq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            vim.cmd("CopilotChat " .. input)
          end
        end,
        desc = "Copilot Quick Chat",
        mode = { "n", "v" },
      },
    },
  },
}
