local M = {}

function M.get_groups(p)
    return {
        -- VIML

        vimVar = { fg = p.nb2 },
        vimFuncName = { fg = p.main3 },
        vimFunction = { fg = p.main2 },
        vimHiGroup = { fg = p.main3 },
        vimHiGuiRgb = { fg = p.constant },
        vimHiGuiFgBg = { fg = p.nb2 },
        -- HTML

        ['@tag.html'] = { fg = p.main2 },
        ['@tag.delimiter.html'] = { fg = p.main1 },
        ['@tag.attribute.html'] = { fg = p.nb1 },
        ['@character.special.html'] = { fg = p.purple },
        ['@string.html'] = { fg = p.constant },

        -- htmlValue = { fg = p.number },
        -- htmlEndTag = { fg = p.noisell },
        -- htmlArg = { fg = p.nb1 },
        -- htmlEvent = { fg = p.alt },
        -- htmlTag = { fg = p.main2 },
        -- htmlTagName = { fg = p.main2 },
        -- htmlSpecialTagName = { fg = p.main1 },
        -- htmlComment = { fg = p.commentl },
        -- htmlEventDQ = { fg = p.alth },
        -- htmlStyleArg = { fg = p.fuchsia },

        -- CSS

        ['@type.css']         = { fg = p.purple, bg = p.purple_bg },    -- `hide` { - I.e. a class name
        ['@attribute.css']    = { fg = p.nb1, bg = "none", nocombine = true },     -- :`active` 
        ['@property.css']     = { fg = p.yellow },  -- `align-items`
        ['@string.css']       = { fg = p.aqua },    -- 16`px`
        ['@number.css']       = { fg = p.green },   -- `16`px
        ['@number.float.css'] = { fg = p.green },   -- `1.125`
        ['@function.css']     = { fg = p.aqua },    -- `var`()
        ['@punctuation.delimiter.css'] = { fg = p.fg1, bold=true },    -- `var`()

        cssTagName = { fg = p.main1, bg = p.main1_bg },
        cssAttributeSelector = { fg = p.speciall, bg = p.special_bg },
        cssClassName = { fg = p.purple, bg = p.purple_bg },
        cssClassNameDot = { link = 'cssClassName' },
        cssIdentifier = { fg = p.main2, bg = p.main2_bg },
        cssUnitDecorators = { fg = p.numberl },
        cssColor = { fg = p.constanth },
        cssBraces = { fg = p.alth },
        cssVendor = { fg = p.main3 },
        cssProp = { fg = p.nb2 },

        -- PYTHON

        -- pythonBuiltin = { fg = p.pink },
        -- pythonDecorator = { fg = p.pinkl },
        -- pythonDecoratorname = { fg = p.pink },
        -- pythonQuotes = { fg = p.stringl },
        -- pythonRawstring = { fg = p.number },
        -- pythonSpaceerror = { fg = p.white, bg = p.isoerrorred },

        -- DJANGO

        -- djangoStatement = { fg = p.purpleh },
        -- djangoFilter = { fg = p.pink, bg = p.alt_bg },
        -- djangoArgument = { fg = p.purplel, bg = p.alt_bg },
        -- djangoTagBlock = { fg = p.normalh, bg = p.alt_bg },
        -- djangoVarBlock = { fg = p.pinkh, bg = p.alt_bg },
        -- djangoComment = { fg = p.commentl, bg = p.alt_bg },
        -- djangoComBlock = { fg = p.comment, bg = p.alt_bg },

        -- JAVASCRIPT / TYPESCRIPT
        ["@variable"] = { fg = p.fg1, bold=false },
        -- jsfunccall = { fg = p.nb3 },
        -- jsGlobalObjects = { fg = p.purple },
        -- jsParensIfElse = { fg = p.nb1 },
        -- jsParensRepeat = { fg = p.nb2 },
        -- jsParensSwitch = { fg = p.nb2 },
        -- jsFuncParens = { fg = p.main2 },
        -- jsClassBraces = { fg = p.brown },
        -- jsFuncBraces = { fg = p.main2 },
        -- jsIfElseBraces = { fg = p.nb1 },
        -- jsTryCatchBraces = { fg = p.main1 },
        -- jsFinallyBraces = { fg = p.main1 },
        -- jsSwitchBraces = { fg = p.nb2 },
        -- jsRepeatBraces = { fg = p.nb2 },
        -- jsObjectBraces = { fg = p.alt1 },
        -- jsfunction  = { fg = p.main1 },
        -- jsClassKeyword = { fg = p.main1 },
        -- jsClassDefinition = { fg = p.main2 },

        -- JSON

        jsonBraces = { fg = p.alth },
    }
end

return M
