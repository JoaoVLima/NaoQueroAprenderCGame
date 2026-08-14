package keymaps

// Library Imports
import rl "vendor:raylib"

// Imports
import window "../window"
import player "../../game/players"

// Enum & Structs
keyBinds :: struct {
    modifier: rl.KeyboardKey,
    key: rl.KeyboardKey,
    action: proc(),
    action_type: action_types
}

action_types :: enum {
    PRESSED,
    HOLD,
    RELEASED,
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
    STAND_UP,
    // ----------------
}

// Global Variables
KEYMAP :: [actions][1]keyBinds { // 1 keymap per action
    .TOGGLE_FULLSCREEN = {
        { modifier = .LEFT_ALT, key = .ENTER, action = onToggleFullscreen, action_type = .PRESSED }
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
        { modifier = .KEY_NULL, key = .SPACE, action = onPlayerJump, action_type = .HOLD  }
    },
    .CROUCH = {
        { modifier = .KEY_NULL, key = .LEFT_CONTROL, action = onPlayerCrouch, action_type = .PRESSED  },
    },
    .STAND_UP = {
        { modifier = .KEY_NULL, key = .LEFT_CONTROL, action = onPlayerStandUp, action_type = .RELEASED }
    },
    // ---------------------
}

// Actions
// ---------------------------
onToggleFullscreen :: window.ToggleFullscreen
// Player
// -------------------
onPlayerFoward :: player.MoveForward
onPlayerBackward :: player.MoveBackward
onPlayerJump :: player.Jump
onPlayerCrouch :: player.Crouch
onPlayerStandUp :: player.StandUp
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

    key_triggered: bool
    switch bind.action_type {
        case .PRESSED:  key_triggered = rl.IsKeyPressed(bind.key)
        case .HOLD:     key_triggered = rl.IsKeyDown(bind.key)
        case .RELEASED: key_triggered = rl.IsKeyReleased(bind.key)
    }

    return modifier_held && key_triggered
}