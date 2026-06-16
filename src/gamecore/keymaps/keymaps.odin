package keymaps

// Library Imports
import fmt "core:fmt"
import rl "vendor:raylib"

// Imports
import win "../window"

// Enum & Structs
keyBinds :: struct {
    modifier: rl.KeyboardKey,
    key: rl.KeyboardKey,
    action: proc(),
}

actions :: enum {
    TOGGLE_FULLSCREEN,
}

// Global Variables
KEYMAP :: [actions][1]keyBinds { // 1 keymap per action
    .TOGGLE_FULLSCREEN = {
        { modifier = .LEFT_ALT, key = .ENTER,  action = onToggleFullscreen }
    },
}

// Actions
onToggleFullscreen :: proc() {
    win.ToggleFullscreen()
}

// Procs
CheckKeysPressed :: proc() {
    keymap := KEYMAP // local copy, you can't index a constant with a runtime variable

    for action in actions {
        for bind in keymap[action] {
            if isBindPressed(bind) {
                if bind.action != nil do bind.action()
            }
        }
    }
}

isBindPressed :: proc(bind: keyBinds) -> bool {
    modifier_held :=
        bind.modifier == .KEY_NULL ||
        rl.IsKeyDown(bind.modifier)

    return modifier_held && rl.IsKeyPressed(bind.key)
}