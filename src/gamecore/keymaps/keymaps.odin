package keymaps

// Library Imports
import rl "vendor:raylib"

// Imports
import win "../window"
import player "../../game/players"

// Enum & Structs
keyBinds :: struct {
    modifier: rl.KeyboardKey,
    key: rl.KeyboardKey,
    action: proc(),
    action_type: action_types
}

action_types :: enum {
    TOGGLE,
    HOLD,
}

actions :: enum {
    TOGGLE_FULLSCREEN,
    PLAYER_FOWARD,
}

// Global Variables
KEYMAP :: [actions][1]keyBinds { // 1 keymap per action
    .TOGGLE_FULLSCREEN = {
        { modifier = .LEFT_ALT, key = .ENTER, action = onToggleFullscreen, action_type = .TOGGLE }
    },
    .PLAYER_FOWARD = {
        { modifier = .KEY_NULL, key = .D, action = onPlayer_Foward, action_type = .HOLD  }
    },
}

// Actions
onToggleFullscreen :: proc() {
    win.ToggleFullscreen()
}

onPlayer_Foward :: proc() {
    player.MoveForward()
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

    alt := bind.action_type == .TOGGLE ? rl.IsKeyPressed(bind.key) : rl.IsKeyDown(bind.key)
    
    return modifier_held && alt
}