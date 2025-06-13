return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "theHamsta/nvim-dap-virtual-text",
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "williamboman/mason.nvim",
    },
    config = function()
        local dap = require("dap")
        local ui = require("dapui")

        require("dapui").setup()
        require("nvim-dap-virtual-text").setup()
        dap.adapters.python = {
            type = "executable",
            command = "python",
            args = { "-m", "debugpy.adapter" },
            options = {
                source_filetype = "python",
            },
        }
        dap.configurations.python = {
            {
                type = "python",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                pythonPath = function()
                    -- return '/usr/bin/python'
                    local venv_path = os.getenv("VIRTUAL_ENV")
                    if venv_path then
                        print("Using virtualenv:", venv_path)
                        return venv_path .. "/bin/python"
                    end
                end,
            },
        }
    end,
    keys = function()
        local dap = require("dap")
        return {
            { "<F1>", dap.continue, desc = "DAP Continue" },
            { "<F2>", dap.step_into, desc = "DAP Step Into" },
            { "<F3>", dap.step_over, desc = "DAP Step Over" },
            { "<F4>", dap.step_out, desc = "DAP Step Out" },
            { "<F5>", dap.step_back, desc = "DAP Step Back" },
            { "<F13>", dap.restart, desc = "DAP Restart" },
            {
                "<space>b",
                dap.toggle_breakpoint,
                desc = "DAP Toggle Breakpoint",
            },
            {
                "<space>gb",
                dap.run_to_cursor,
                desc = "DAP Run To Cursor",
            },
            {
                "<space>?",
                function()
                    require("dapui").eval(nil, { enter = true })
                end,
                desc = "DAP Eval Var Under Cursor",
            },
        }
    end,
}
