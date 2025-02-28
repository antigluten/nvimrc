local progress_handle

return {
    'wojciech-kulik/xcodebuild.nvim',
    dependencies = {
        'nvim-telescope/telescope.nvim',
        'MunifTanjim/nui.nvim',
        'stevearc/oil.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
    keys = {
        {
            '<leader>X',
            '<cmd>XcodebuildPicker<cr>',
            mode = 'n',
            { desc = 'Show Xcodebuild Actions' },
        },
        {
            '<leader>xf',
            '<cmd>XcodebuildProjectManager<cr>',
            mode = 'n',
            { desc = 'Show Project Manager Actions' },
        },
        {
            '<leader>xb',
            '<cmd>XcodebuildBuild<cr>',
            mode = 'n',
            { desc = 'Build Project' },
        },
        {
            '<leader>xB',
            '<cmd>XcodebuildBuildForTesting<cr>',
            mode = 'n',
            { desc = 'Build For Testing' },
        },
        {
            '<leader>xr',
            '<cmd>XcodebuildBuildRun<cr>',
            mode = 'n',
            { desc = 'Build & Run Project' },
        },
        {
            '<leader>xt',
            '<cmd>XcodebuildTest<cr>',
            mode = 'n',
            { desc = 'Run Tests' },
        },
        {
            '<leader>xt',
            '<cmd>XcodebuildTestSelected<cr>',
            mode = 'v',
            { desc = 'Run Selected Tests' },
        },
        {
            '<leader>xT',
            '<cmd>XcodebuildTestClass<cr>',
            mode = 'n',
            { desc = 'Run This Test Class' },
        },
        {
            '<leader>xl',
            '<cmd>XcodebuildToggleLogs<cr>',
            mode = 'n',
            { desc = 'Toggle Xcodebuild Logs' },
        },
        {
            '<leader>xc',
            '<cmd>XcodebuildToggleCodeCoverage<cr>',
            mode = 'n',
            { desc = 'Toggle Code Coverage' },
        },
        {
            '<leader>xC',
            '<cmd>XcodebuildShowCodeCoverageReport<cr>',
            mode = 'n',
            { desc = 'Show Code Coverage Report' },
        },
        {
            '<leader>xe',
            '<cmd>XcodebuildTestExplorerToggle<cr>',
            mode = 'n',
            { desc = 'Toggle Test Explorer' },
        },
        {
            '<leader>xs',
            '<cmd>XcodebuildFailingSnapshots<cr>',
            mode = 'n',
            { desc = 'Show Failing Snapshots' },
        },

        {
            '<leader>xd',
            '<cmd>XcodebuildSelectDevice<cr>',
            mode = 'n',
            { desc = 'Select Device' },
        },
        {
            '<leader>xp',
            '<cmd>XcodebuildSelectTestPlan<cr>',
            mode = 'n',
            { desc = 'Select Test Plan' },
        },

        {
            '<leader>xx',
            '<cmd>XcodebuildQuickfixLine<cr>',
            mode = 'n',
            { desc = 'Quickfix Line' },
        },
        {
            '<leader>xa',
            '<cmd>XcodebuildCodeActions<cr>',
            mode = 'n',
            { desc = 'Show Code Actions' },
        },
    },
    opts = {
        show_build_progress_bar = false,
        logs = {
            auto_open_on_success_tests = false,
            auto_open_on_failed_tests = false,
            auto_open_on_success_build = false,
            auto_open_on_failed_build = false,
            auto_focus = false,
            auto_close_on_app_launch = true,
            only_summary = true,
            notify = function(message, severity)
                local fidget = require('fidget')
                if progress_handle then
                    progress_handle.message = message
                    if not message:find('Loading') then
                        progress_handle:finish()
                        progress_handle = nil
                        if vim.trim(message) ~= '' then
                            fidget.notify(message, severity)
                        end
                    end
                else
                    fidget.notify(message, severity)
                end
            end,
            notify_progress = function(message)
                local progress = require('fidget.progress')

                if progress_handle then
                    progress_handle.title = ''
                    progress_handle.message = message
                else
                    progress_handle = progress.handle.create({
                        message = message,
                        lsp_client = { name = 'xcodebuild.nvim' },
                    })
                end
            end,
        },
        code_coverage = {
            enabled = true,
        },
    },
}
