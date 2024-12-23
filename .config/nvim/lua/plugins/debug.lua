return {
  'mfussenegger/nvim-dap',

  dependencies = {
    -- UI for nvim-dap
    'rcarriga/nvim-dap-ui',

    -- Shows value of variable next to it
    'theHamsta/nvim-dap-virtual-text',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },

  keys = function(_, keys)
    local dap = require 'dap'
    local dapui = require 'dapui'

    return {
      { '<F1>', dap.continue, desc = 'Debug: Start/Continue' },
      { '<F2>', dap.step_into, desc = 'Debug: Step Into' },
      { '<F3>', dap.step_over, desc = 'Debug: Step Over' },
      { '<F4>', dap.step_out, desc = 'Debug: Step Out' },
      { '<F5>', dap.step_back, desc = 'Debug: Step Back' },
      { '<F6>', dap.restart, desc = 'Debug: Restart' },

      { '<leader>dt', dapui.toggle, desc = '[D]ebug [T]oggle UI' },
      { '<leader>db', dap.toggle_breakpoint, desc = 'Toggle [d]ebug [b]reakpoint' },
      { '<leader>dc', dap.run_to_cursor, desc = '[D]ebug until [c]ursor' },
      {
        '<leader>de',
        function()
          require("dapui").eval(nil, { enter = true })
        end,
        desc = '[D]ebug [E]valuate'
      },
      {
        '<leader>dB',
        function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Set [d]ebug [b]reakpoint',
      },
      unpack(keys),
    }
  end,

  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    dapui.setup()
    dap.defaults.fallback.external_terminal = {
        command = '/usr/bin/kitty';
        args = {'--hold'};
    }
    require('mason-nvim-dap').setup {
      automatic_installation = true,
      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},
      ensure_installed = {
        'python', 'cppdbg'
      },
    }

    require("nvim-dap-virtual-text").setup {
      commented = true,
    }

    -- Opens/closes dapui when debugging starts/ends
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end
}

