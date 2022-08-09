# This file is part of ranger, the console file manager.
# License: GNU GPL version 3, see the file "AUTHORS" for details.

from __future__ import (absolute_import, division, print_function)

from ranger.colorschemes.default import Default
from ranger.gui.color import green, red, blue
from ranger.gui import color


class Scheme(Default):
    progress_bar_color = red

    def use(self, context):
        fg, bg, attr = Default.use(self, context)

        if context.in_browser:
            if context.media:
                if context.image:
                    fg = color.magenta
                else:
                    fg = color.magenta
                    attr |= color.bold
            if context.fifo or context.device:
                # Trying to keep bright yellow only for dirs
                fg = color.yellow
                attr |= color.dim
        if context.directory and not context.marked and not context.link \
                and not context.inactive_pane:
            # fg = self.progress_bar_color
            fg = color.yellow
            attr |= color.bold
        if context.in_titlebar and context.hostname:
            fg = red if context.bad else green

        return fg, bg, attr
