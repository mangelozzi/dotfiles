-- Syntax hilighting groups
-- :help group-name

local M = {}

function M.get_palette(p)
    return {
        main1            = '#ff4434',
        main2            = '#ff8300',
        main3            = '#ffb300',
        main1_bg         = '#571712',
        main2_bg         = '#633300',
        nb1              = '#ffed00',
        nb2              = '#ffe000',
        nb3              = '#d0d000',
        specialh         = '#9edaff',
        special          = '#efa0a0',
        speciall         = '#70b7e3',
        special_bg       = '#2f4d5f',
        bushgreen        = '#c0c000',
        stringh          = '#88ff18',
        string           = '#86e929',
        stringl          = '#71c423',
        numberh          = '#00f000',
        number           = '#00d000',
        numberl          = '#00b000',
        constanth        = '#bdff2d',
        constant         = '#ade929',
        constantl        = '#8aba21',
        noiseh           = '#f7d6d6',
        noise            = '#dbbdbd',
        noisel           = '#c1a7a7',
        noisell          = '#a69090',
        commenth         = '#dadada',
        comment          = '#c0c0c0',
        commentl         = '#a0a0a0',
        alth             = '#e2cffd',
        alt              = '#bdb3ce',
        altl             = '#ada4bc',
        alt_bg           = '#4e4a55',
        brownh           = '#f5af8a',
        brown            = '#d09576',
        brownl           = '#b07e63',
        pinkh            = '#ff6b8a',
        pink             = '#ff90a7',
        pinkl            = '#e17f93',
        purpleh          = '#ff82dc',
        -- purple           = '#ffa5e6', -- In gruvbox already
        purplel          = '#e392cc',
        purple_bg        = '#634059',
        oldlime          = '#8aba21',
        oldneonlime      = '#888888',
        oldmustard       = '#888888',
        oldstone         = '#888888',
        oldskygray       = '#888888',
        oldskybright     = '#888888',
        oldskypale       = '#888888',
        oldgray          = '#888888',
        oldindigo        = '#888888',
        oldbluegray      = '#888888',
        oldpurple        = '#888888',
        oldpeach         = '#888888',
        isoerrorred      = '#ff4434',
        isowarningorange = '#ff8300',
        isocautionyellow = '#ffed00',
        bg               = '#000000',
        bgh              = '#404040',
        bghh             = '#606060',
    }
end

function M.get_groups(p)
    return {
        Comment     = {fg=p.comment}, -- any comment

        Constant	= {fg=p.constant}, -- any constant
        String		= {fg=p.string}, -- a string constant: "this is a string"
        Character	= {fg=p.character}, -- a character constant: 'c', '\n'
        Number		= {fg=p.number}, -- a number constant: 234, 0xff
        Boolean		= {fg=p.constant}, -- a boolean constant: TRUE, false
        Float		= {fg=p.numberl}, -- a floating point constant: 2.3e10

        Identifier	= {fg=p.main3}, -- any variable name
        Function	= {fg=p.main2}, -- function name (also: methods for classes)

        Statement	= {fg=p.main1}, -- any statement
        Conditional	= {fg=p.nb1}, -- if, then, else, endif, switch, etc.
        Repeat		= {fg=p.nb2}, -- for, do, while, etc.
        Label		= {fg=p.nb2}, -- case, default, etc.
        Operator	= {fg=p.nb3}, -- "sizeof", "+", "*", etc.
        Keyword		= {fg=p.nb3}, -- any other keyword
        Exception	= {fg=p.main3}, -- try, catch, throw

        PreProc		= {fg=p.purpleh}, -- generic Preprocessor
        Include		= {fg=p.purple}, -- preprocessor #include
        Define		= {fg=p.purplel}, -- preprocessor #define
        Macro		= {fg=p.purplel}, -- same as Define
        PreCondit	= {fg=p.purplel}, -- preprocessor #if, #else, #endif, etc.

        Type		= {fg=p.brown}, -- int, long, char, etc.
        StorageClass= {fg=p.brown}, -- 	static, register, volatile, etc.
        Structure	= {fg=p.brown}, -- struct, union, enum, etc.
        Typedef		= {fg=p.brownh}, -- a typedef

        Special		= {fg=p.special}, -- any special symbol
        SpecialChar	= {fg=p.specialh}, -- special character in a constant
        Tag		    = {fg=p.specialh}, -- you can use CTRL-] on this
        Delimiter	= {fg=p.alt}, -- character that needs attention
        SpecialComme= {fg=p.altl}, -- nt	special things inside a comment
        Debug		= {fg=p.alt1}, -- debugging statements

        Underlined	= {fg=p.speciall, underline = true}, -- text that stands out, HTML links

        Ignore		= {fg=p.grey0}, -- left blank, hidden  |hl-Ignore|

        Error		= {fg=p.fg0, bg=p.red, bold=true }, -- any erroneous construct

        Todo		= {fg=p.fg0, bg=p.blue, bold=true }, -- anything that needs extra attention; mostly the keywords TODO FIXME and XXX

        Added		= {fg=p.green}, -- added line in a diff
        Changed		= {fg=p.yellow}, -- changed line in a diff
        Removed		= {fg=p.red}, -- removed line in a diff
    }
end

return M
