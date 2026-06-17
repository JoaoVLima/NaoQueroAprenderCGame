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
    speed = 1,
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


// Plano Cartesiano
//         -y
//         -2
//         -1
// -y -2 -1 0 1 2 +y
//          1
//          2
//         +y

// Movement
// -------------------
MoveForward :: proc() {
    PLAYER.position.x += PLAYER.speed
}
MoveBackward :: proc() {
    PLAYER.position.x -= PLAYER.speed
}
Jump :: proc() {
    PLAYER.position.y -= PLAYER.speed
}
Crouch :: proc() {
    PLAYER.position.y += PLAYER.speed
}
// ---------------------------