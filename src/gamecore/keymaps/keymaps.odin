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
    // Player
    // ----------------
    // Movement
    // -------------
    PLAYER_FOWARD,
    PLAYER_BACKWARD,
    JUMP,
    CROUCH,
    // ----------------
}

// Global Variables
KEYMAP :: [actions][1]keyBinds { // 1 keymap per action
    .TOGGLE_FULLSCREEN = {
        { modifier = .LEFT_ALT, key = .ENTER, action = onToggleFullscreen, action_type = .TOGGLE }
    },
    // Player
    // ---------------------
    // Movement
    // ----------------
    .PLAYER_FOWARD = {
        { modifier = .KEY_NULL, key = .D, action = onPlayerFoward, action_type = .HOLD  }
    },
    .PLAYER_BACKWARD = {
        { modifier = .KEY_NULL, key = .A, action = onPlayerBackward, action_type = .HOLD  }
    },
    .JUMP = {
        { modifier = .KEY_NULL, key = .SPACE, action = onPlayerJump, action_type = .TOGGLE  }
    },
    .CROUCH = {
        { modifier = .KEY_NULL, key = .LEFT_CONTROL, action = onPlayerCrouch, action_type = .HOLD  }
    },
    // ---------------------
}

// Actions
// ---------------------------
onToggleFullscreen :: win.ToggleFullscreen
// Player
// -------------------
onPlayerFoward :: player.MoveForward
onPlayerBackward :: player.MoveBackward
onPlayerJump :: player.Jump
onPlayerCrouch :: player.Crouch
// ---------------------------


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