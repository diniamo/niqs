return {
    inputZoxide = function()
        local keyword = vim.fn.input("Keyword: ")
        local directory = vim.system({ "zoxide", "query", keyword }, { text = true })
            :wait().stdout
            :match("(.*)[\n\r]")

        if directory == "" or directory == nil then
            vim.notify("No match found", vim.log.levels.ERROR)
        else
            vim.notify(directory)
            vim.fn.chdir(directory)
        end
    end,
    insertMultipleAtPosition = function(t, pos, ...)
        local args = { ... }
        local count = #args
        for i = #t + count, pos + count, -1 do
            t[i] = t[i - count]
        end
        for i = 1, count do
            t[pos + i - 1] = args[i]
        end
    end
}
