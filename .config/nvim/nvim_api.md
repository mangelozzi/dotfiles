# Neovim Lua API

## INSPECT A TABLE

```lua
print(vim.inspect(foo))
```

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

## COMMANDS

### External Command String

```lua
local return_code = os.execute('echo hi')
local ok = return_code == 0
```

### External Command List

```lua
local output = vim.fn.system { 'echo', 'hi' }
-- output will have the value 'hi'
local return_code = vim.v.shell_error
-- return_code = 0, if it was an error something like -1
```

### Start ASYNC Job

```lua
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
```

### Defer a command

```lua
callback = function() vim.fn.feedkeys("g<") end
delay_ms = 1000
vim.defer_fn(callback , delay_ms)
```
