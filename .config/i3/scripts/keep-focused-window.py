#!/usr/bin/env python3

from argparse import ArgumentParser
import i3ipc

i3 = i3ipc.Connection()


def kill_unfocussed_windows():
    if focused := i3.get_tree().find_focused():
        if workspace := focused.workspace():
            for node in workspace.nodes:
                not node.focused and node.command('kill')


if __name__ == '__main__':
    parser = ArgumentParser(
        description='Within the current workspace, kill all viewable windows other than the current focused one.'
    )
    parser.parse_args()

    kill_unfocussed_windows()
