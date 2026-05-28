local start = vim.health.start or vim.health.report_start
local ok = vim.health.ok or vim.health.report_ok
local warn = vim.health.warn or vim.health.report_warn
local error = vim.health.error or vim.health.report_error

local M = {}

local function check_neovim_version()
    if vim.fn.has("nvim-0.12.0") ~= 1 then
        error("serpy requires Neovim >= 0.12.0")
        return false
    else
        ok("Neovim >= 0.12.0")
        return true
    end
end

local function check_serpy_module()
    local ok_load, serpy = pcall(require, "serpy")
    if ok_load then
        ok("serpy module is loadable")
        return true
    else
        error("serpy module failed to load: " .. serpy)
        return false
    end
end

local function check_python()
    local python_executables = { "python", "python3", "py" }

    for _, executable in ipairs(python_executables) do
        if vim.fn.executable(executable) == 1 then
            local version_cmd = string.format("%s --version", executable)
            local version = vim.fn.system(version_cmd)
            ok(string.format("Python found: %s (%s)", executable, version:gsub("\n", "")))
            return true
        end
    end

    if not python_found then
        error("Python is required but not found. Install python, python3, or py and make sure it's in your PATH")
        return false
    end
end

function M.check()
    start("serpy")

    if not check_neovim_version() then
        return
    end

    if not check_serpy_module() then
        return
    end

    if not check_python() then
        return
    end

    ok("serpy is ready to use")
end

return M
