-- GitHub Browse Plugin
-- Opens current buffer's file in GitHub web view
-- Supports line ranges in visual mode

local M = {}

-- Parse git remote URL to get GitHub repo info
local function parse_github_remote(remote_url)
    -- Handle SSH format: git@github.com:user/repo.git
    local user, repo = remote_url:match("git@github%.com:([^/]+)/(.+)%.git")
    if user and repo then
        return user, repo
    end

    -- Handle HTTPS format: https://github.com/user/repo.git
    user, repo = remote_url:match("https://github%.com/([^/]+)/(.+)%.git")
    if user and repo then
        return user, repo
    end

    -- Handle HTTPS format without .git: https://github.com/user/repo
    user, repo = remote_url:match("https://github%.com/([^/]+)/([^/]+)$")
    if user and repo then
        return user, repo
    end

    return nil, nil
end

-- Get current git branch
local function get_current_branch()
    local handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null")
    if not handle then return nil end

    local branch = handle:read("*line")
    handle:close()

    return branch
end

-- Get git remote URL
local function get_remote_url()
    local handle = io.popen("git remote get-url origin 2>/dev/null")
    if not handle then return nil end

    local url = handle:read("*line")
    handle:close()

    return url
end

-- Get file path relative to git root
local function get_relative_path(filepath)
    local handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
    if not handle then return nil end

    local root = handle:read("*line")
    handle:close()

    if not root then return nil end

    -- Remove trailing slash from root if present
    root = root:gsub("/$", "")

    -- Get relative path
    if filepath:sub(1, #root) == root then
        return filepath:sub(#root + 2) -- +2 to skip the leading slash
    end

    return nil
end

-- Open GitHub URL in browser
local function open_url(url)
    local open_cmd
    if vim.fn.has("mac") == 1 then
        open_cmd = "open"
    elseif vim.fn.has("unix") == 1 then
        open_cmd = "xdg-open"
    elseif vim.fn.has("win32") == 1 then
        open_cmd = "start"
    else
        print("Unsupported platform")
        return
    end

    os.execute(open_cmd .. ' "' .. url .. '"')
end

-- Main function to browse on GitHub
function M.browse(start_line, end_line)
    -- Get current file path
    local filepath = vim.fn.expand("%:p")
    if filepath == "" then
        print("No file in current buffer")
        return
    end

    -- Get git info
    local remote_url = get_remote_url()
    if not remote_url then
        print("Not in a git repository")
        return
    end

    local user, repo = parse_github_remote(remote_url)
    if not user or not repo then
        print("Could not parse GitHub URL from remote: " .. remote_url)
        return
    end

    local branch = get_current_branch()
    if not branch then
        print("Could not determine git branch")
        return
    end

    local relative_path = get_relative_path(filepath)
    if not relative_path then
        print("Could not determine relative path")
        return
    end

    -- Build GitHub URL
    local url = string.format("https://github.com/%s/%s/blob/%s/%s",
                              user, repo, branch, relative_path)

    -- Add line numbers if provided
    if start_line then
        if end_line and end_line ~= start_line then
            url = url .. "#L" .. start_line .. "-L" .. end_line
        else
            url = url .. "#L" .. start_line
        end
    end

    print("Opening: " .. url)
    open_url(url)
end

-- Setup function to create commands
function M.setup()
    -- Command for current line or file
    vim.api.nvim_create_user_command('GHBrowse', function()
        local line = vim.fn.line('.')
        M.browse(line, line)
    end, { desc = "Open current file/line in GitHub" })

    -- Visual mode command for line ranges
    vim.api.nvim_create_user_command('GHBrowseRange', function(opts)
        M.browse(opts.line1, opts.line2)
    end, { range = true, desc = "Open selected lines in GitHub" })

    -- Keybindings (optional - you can customize these)
    vim.keymap.set('n', '<leader>gh', ':GHBrowse<CR>', { silent = true, desc = "Browse file on GitHub" })
    vim.keymap.set('v', '<leader>gh', ':GHBrowseRange<CR>', { silent = true, desc = "Browse selection on GitHub" })
end

return M
