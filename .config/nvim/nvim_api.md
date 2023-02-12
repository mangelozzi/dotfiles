# Neovim Lua API

## CREATE A CUSTOM COMMAND

```lua
vim.api.nvim_create_user_command("Foo", function()
    print("Foo ran")
end, {})
```

## GET USER INPUT

```lua
value = vim.fn.input("Enter a value")
print("The value was:", value)
```

## STRINGS

### Convert String to Number

```lua
tonumber("123")
```

### Split A String

```lua
vim.split("hello how are you", " ")
```

## START ASYNC JOB
local command = {"ls", "-la"}
vim.fn.jobstart(command, {
    stdout_buffered = true, -- Wait for complete lines, before getting updates
    on_stdout = function(_, data) 
        if data then
            print(data)
        end
    end,
    on_stderr = function(_, data) print(data) end,
})
