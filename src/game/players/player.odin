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
    speed = 1000,
    on_screen = false,
}

// Procs
// ---------------------------
InitPlayer :: proc() {
    PLAYER.on_screen = true
}

Draw :: proc() {
    if PLAYER.on_screen {
        rl.DrawRectangleV(PLAYER.position, PLAYER.size,  rl.GREEN)
    }
}

RemovePlayer :: proc() {
    PLAYER.on_screen = false
}

// Velocity
// -------------------
ResetVelocity :: proc() {
    PLAYER.velocity = {0, 0}
}
ApplyVelocity :: proc() {
    PLAYER.position += PLAYER.velocity * rl.GetFrameTime()
}


// Plano Cartesiano
//         -y
//         -2
//         -1
// -x -2 -1 0 1 2 +x
//          1
//          2
//         +y

// Without frame time — speed depends on FPS
// At 60fps: moves 5 units/frame
// At 120fps: moves 10 units/frame <- broken!
// PLAYER.position.x += 5

// With frame time — speed is consistent regardless of FPS
// At 60fps:  5 * 0.0166 = 0.083 units/frame
// At 120fps: 5 * 0.0083 = 0.041 units/frame
// Both = ~5 units/second <- correct
// PLAYER.position.x += 5 * rl.GetFrameTime()

// Movement
// -------------------
MoveForward :: proc() {
    PLAYER.velocity.x += PLAYER.speed
}
MoveBackward :: proc() {
    PLAYER.velocity.x -= PLAYER.speed
}
Jump :: proc() {
    PLAYER.velocity.y -= PLAYER.speed
}
Crouch :: proc() {
    PLAYER.velocity.y += PLAYER.speed
}
// ---------------------------