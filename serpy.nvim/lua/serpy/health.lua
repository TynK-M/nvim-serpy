local M = {}

function M.health()
    vim.health.start("Serpy")

    vim.health.ok("Module loaded")

    if vim.fn.executable("python3") == 1 then
        vim.health.ok("python3 found")
    else
        vim.health.error("python3 not found in PATH")
    end
end

return M
