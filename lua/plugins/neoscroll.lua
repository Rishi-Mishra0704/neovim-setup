return {
    "karb94/neoscroll.nvim",
    config = function()
        require('neoscroll').setup({
            -- Configuration for smooth scrolling speeds
            easing_function = "quadratic", -- You can use "sine", "circular", etc.
            hide_cursor = false,           -- Keep the cursor visible while scrolling
            stop_eof = false,              -- Don't stop at the end of file
            respect_scrolloff = true,      -- Scroll according to scrolloff setting
            cursor_scrolls_alone = true,   -- Cursor will keep scrolling after reaching window boundary
        })

        -- Set up custom mappings for smooth scrolling with j, k, G, gg, H, L
        local t = {}

        -- Syntax: t[keys] = {function, {function arguments}}
        t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '150'}} -- Half-page up
        t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '150'}} -- Half-page down
        t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '250'}} -- Full page up
        t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '250'}} -- Full page down
        t['<C-y>'] = {'scroll', {'-0.10', 'false', '50'}} -- Scroll up one line
        t['<C-e>'] = {'scroll', { '0.10', 'false', '50'}} -- Scroll down one line

        -- Add smooth scrolling to regular j/k and G/gg
        t['k'] = {'scroll', {'-vim.wo.scroll', 'true', '100'}} -- Scroll up smoothly with 'k'
        t['j'] = {'scroll', { 'vim.wo.scroll', 'true', '100'}} -- Scroll down smoothly with 'j'
        t['gg'] = {'scroll', {'-vim.api.nvim_buf_line_count(0)', 'true', '300'}} -- Smooth scroll to top
        t['G'] = {'scroll', { 'vim.api.nvim_buf_line_count(0)', 'true', '300'}} -- Smooth scroll to bottom
        t['H'] = {'scroll', {'-0.30', 'true', '150'}} -- Smooth scroll to top of window
        t['L'] = {'scroll', { '0.30', 'true', '150'}} -- Smooth scroll to bottom of window

        -- Pass the mapping table to Neoscroll
        require('neoscroll.config').set_mappings(t)
    end,
}
