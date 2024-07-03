if not require("namespace.utils").get_is_installed("nvim-various-textobjs") then return end

-- default config
require("various-textobjs").setup {
	-- set to 0 to only look in the current line
	lookForwardSmall = 5,
	lookForwardBig = 15,

	-- use suggested keymaps (see overview table in README)
	useDefaultKeymaps = true,

	-- disable only some default keymaps, e.g. { "ai", "ii" }
	disabledKeymaps = {},

	-- display notifications if a text object is not found
	notifyNotFound = true,
}
