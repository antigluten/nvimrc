local function setupListeners()
    local dap = require('dap')
    local areSet = false

    dap.listeners.after['event_initialized']['me'] = function()
        if not areSet then
            areSet = true
            vim.keymap.set(
                'n',
                '<leader>dc',
                dap.continue,
                { desc = 'Continue', noremap = true }
            )
            vim.keymap.set(
                'n',
                '<leader>dC',
                dap.run_to_cursor,
                { desc = 'Run To Cursor' }
            )
            vim.keymap.set(
                'n',
                '<leader>ds',
                dap.step_over,
                { desc = 'Step Over' }
            )
            vim.keymap.set(
                'n',
                '<leader>di',
                dap.step_into,
                { desc = 'Step Into' }
            )
            vim.keymap.set(
                'n',
                '<leader>do',
                dap.step_out,
                { desc = 'Step Out' }
            )
            vim.keymap.set(
                { 'n', 'v' },
                '<Leader>dh',
                require('dap.ui.widgets').hover,
                { desc = 'Hover' }
            )
            vim.keymap.set(
                { 'n', 'v' },
                '<Leader>de',
                require('dapui').eval,
                { desc = 'Eval' }
            )
        end
    end

    dap.listeners.after['event_terminated']['me'] = function()
        if areSet then
            areSet = false
            vim.keymap.del('n', '<leader>dc')
            vim.keymap.del('n', '<leader>dC')
            vim.keymap.del('n', '<leader>ds')
            vim.keymap.del('n', '<leader>di')
            vim.keymap.del('n', '<leader>do')
            vim.keymap.del({ 'n', 'v' }, '<Leader>dh')
            vim.keymap.del({ 'n', 'v' }, '<Leader>de')
        end
    end
end

return {
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio',
        },
        config = function()
            local dapui = require('dapui')
            local dap = require('dap')
            dapui.setup({
                controls = {
                    element = 'repl',
                    enabled = true,
                    icons = {
                        disconnect = '',
                        run_last = '',
                        terminate = '⏹︎',
                        pause = '⏸︎',
                        play = '',
                        step_into = '󰆹',
                        step_out = '󰆸',
                        step_over = '',
                        step_back = '',
                    },
                },
                floating = {
                    border = 'single',
                    mappings = {
                        close = { 'q', '<Esc>' },
                    },
                },
                icons = {
                    collapsed = '',
                    expanded = '',
                    current_frame = '',
                },
                layouts = {
                    {
                        elements = {
                            { id = 'stacks', size = 0.25 },
                            { id = 'scopes', size = 0.25 },
                            { id = 'breakpoints', size = 0.25 },
                            { id = 'watches', size = 0.25 },
                        },
                        position = 'left',
                        size = 40,
                    },
                    {
                        elements = {
                            { id = 'repl', size = 0.4 },
                            { id = 'console', size = 0.6 },
                        },
                        position = 'bottom',
                        size = 10,
                    },
                },
            })

            local group =
                vim.api.nvim_create_augroup('dapui_config', { clear = true })

            -- hide ~ in DAPUI
            vim.api.nvim_create_autocmd('BufWinEnter', {
                group = group,
                pattern = 'DAP*',
                callback = function()
                    vim.wo.fillchars = 'eob: '
                end,
            })
            vim.api.nvim_create_autocmd('BufWinEnter', {
                group = group,
                pattern = '\\[dap\\-repl\\]',
                callback = function()
                    vim.wo.fillchars = 'eob: '
                end,
            })

            dap.listeners.after.event_initialized['dapui_config'] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated['dapui_config'] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited['dapui_config'] = function()
                dapui.close()
            end

            require('overseer').enable_dap(true)
        end,
    },
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'stevearc/overseer.nvim',
            'wojciech-kulik/xcodebuild.nvim',
        },
        config = function()
            local xcodebuild = require('xcodebuild.integrations.dap')
            -- dap.set_log_level("DEBUG")

            -- TODO: make sure to set path to your codelldb
            local codelldbPath = os.getenv('HOME')
                .. '/tools/codelldb-aarch64-darwin/extension/adapter/codelldb'
            xcodebuild.setup(codelldbPath)

            local define = vim.fn.sign_define
            define('DapBreakpointCondition', {
                text = '?',
                texthl = 'DiagnosticError',
                linehl = '',
                numhl = '',
            })
            define('DapBreakpoint', {
                text = '',
                texthl = 'DiagnosticError',
                linehl = '',
                numhl = '',
            })
            define('DapBreakpointRejected', {
                text = '',
                texthl = 'DiagnosticError',
                linehl = '',
                numhl = '',
            })
            define('DapStopped', {
                text = '',
                texthl = 'DiagnosticOk',
                linehl = '',
                numhl = '',
            })
            define('DapLogPoint', {
                text = '',
                texthl = 'DiagnosticInfo',
                linehl = '',
                numhl = '',
            })
            define('DapLogPoint', {
                text = '',
                texthl = 'DiagnosticInfo',
                linehl = '',
                numhl = '',
            })

            setupListeners()
            --when breakpoint is hit, it sets the focus to the buffer with the breakpoint
            require('dap').defaults.fallback.switchbuf = 'usetab,uselast'

            vim.keymap.set(
                'n',
                '<leader>dd',
                xcodebuild.build_and_debug,
                { desc = 'Build & Debug' }
            )
            vim.keymap.set(
                'n',
                '<leader>dr',
                xcodebuild.debug_without_build,
                { desc = 'Debug Without Building' }
            )
            vim.keymap.set(
                'n',
                '<leader>dt',
                xcodebuild.debug_tests,
                { desc = 'Debug Tests' }
            )
            vim.keymap.set(
                'n',
                '<leader>dT',
                xcodebuild.debug_class_tests,
                { desc = 'Debug Class Tests' }
            )
            vim.keymap.set(
                'n',
                '<leader>b',
                xcodebuild.toggle_breakpoint,
                { desc = 'Toggle Breakpoint' }
            )
            vim.keymap.set(
                'n',
                '<leader>B',
                xcodebuild.toggle_message_breakpoint,
                { desc = 'Toggle Message Breakpoint' }
            )

            vim.keymap.set('n', '<leader>dx', function()
                xcodebuild.terminate_session()
                require('dap').listeners.after['event_terminated']['me']()
            end, { desc = 'Terminate debugger' })
        end,
    },
}
