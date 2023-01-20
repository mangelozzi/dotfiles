from xkeysnail.transform import Key, define_keymap

define_keymap(
    None,
    {
        Key.CAPSLOCK:  Key.LEFT_META,
        Key.LEFT_META: Key.ESC,
        Key.ESC : Key.CAPSLOCK,
    },
    "Michael"
)
