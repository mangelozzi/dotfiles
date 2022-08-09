#!/usr/bin/env python3

from argparse import ArgumentParser
import i3ipc

i3 = i3ipc.Connection()


def kill_all_windows():
    if focused := i3.get_tree().find_focused():
        if workspace := focused.workspace():
            for node in workspace.nodes:
                node.command('kill')
    i3.command('workspace next')

if __name__ == '__main__':
    parser = ArgumentParser(
        description='Kill all windows in the current workspace, then move to the previous workspace.'
    )
    parser.parse_args()

    kill_all_windows()
