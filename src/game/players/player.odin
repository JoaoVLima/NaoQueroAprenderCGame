package player

// Library Imports
import rl "vendor:raylib"

// Structs
playerState :: struct {
    size: rl.Vector2,
    position: rl.Vector2,
    velocity: rl.Vector2,
    speed: f32,
    on_screen: bool,
}

// Global Variables
PLAYER := playerState {
    size = {64, 64},
    position = {5, 5},
    velocity = {0, 0},
    speed = 2,
    on_screen = false,
}

// Procs
// ---------------------------
InitPlayer :: proc() {
    PLAYER.on_screen = true
}

UpdatePlayerState :: proc() {
    if PLAYER.on_screen {
        rl.DrawRectangleV(PLAYER.position, PLAYER.size,  rl.GREEN)
    }
}

RemovePlayer :: proc() {
    PLAYER.on_screen = false
}

// Movement
// -------------------
MoveForward :: proc() {
    PLAYER.position.x += PLAYER.speed
}


// -------------------
// ---------------------------