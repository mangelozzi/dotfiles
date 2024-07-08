local testlevel1 =
{ testlevel2 =
    { testlevel3 =
        { testlevel4 =
            { testlevel5 =
                { testlevel6 =
                    { testlevel7 =
                        { foo = 1,

                        }
                    }
                }
            }
        }
    }
}

local Plugin = {
    "HiPhish/rainbow-delimiters.nvim",
}

Plugin.config = function()
    -- This module contains a number of default definitions
    local rainbow_delimiters = require 'rainbow-delimiters'

    -- This module contains a number of default definitions
    require('rainbow-delimiters.setup').setup {
        strategy = {
            [''] = rainbow_delimiters.strategy['global'],
            vim = rainbow_delimiters.strategy['local'],
            -- Use local for HTML (from help)
            html = rainbow_delimiters.strategy['local'],
        },
        query = {
            [''] = 'rainbow-delimiters',
            lua = 'rainbow-blocks',
            javascript = 'rainbow-blocks',
            python = 'rainbow-blocks',
        },
        priority = {
            [''] = 110,
            lua = 210,
        },
        highlight = {
            'rainbowDelimiter1',
            'rainbowDelimiter2',
            'rainbowDelimiter3',
            'rainbowDelimiter4',
            'rainbowDelimiter5',
            'rainbowDelimiter6',
            'rainbowDelimiter7',
        },
    }
end

return Plugin
