package player

// Library Imports
import rl "vendor:raylib"
import gamecore "../../gamecore"

// Structs
playerState :: struct {
    size: rl.Vector2,
    position: rl.Vector2,
    velocity: rl.Vector2,
    gravity: f32,
    speed: f32,
    jump_force: f32,
    on_screen: bool,
    on_ground: bool,
    is_jumping: bool,
    is_crouching: bool,
}

// Global Variables
PLAYER := playerState {
    size = {64, 64},
    position = {5, 5},
    velocity = {0, 0},
    gravity = 0,
    speed = 1000,
    jump_force = 800,
    on_screen = false,
    on_ground = false,
    is_jumping = false,
    is_crouching = false,
}

// Procs
// ---------------------------
InitPlayer :: proc() {
    PLAYER.on_screen = true
}

Draw :: proc() {
    if PLAYER.on_screen {
        rl.DrawRectangleV(PLAYER.position, PLAYER.size, rl.GREEN)
    }
}

RemovePlayer :: proc() {
    PLAYER.on_screen = false
}

// Velocity
// -------------------
ResetVelocity :: proc() {
    // Resets only horizontal velocity every frame
    // Vertical velocity is preserved across frames so jump carries upward over time
    PLAYER.velocity.x = 0
}

// Called once per fixed timestep (every 1/60s) from the game loop accumulator
// Uses FIXED_DT instead of GetFrameTime() so physics is framerate independent
// and deterministic — same result at 10fps or 10000fps
UpdatePositionState :: proc() {
    // Gravity accumulates over time (+=) so the player accelerates downward
    // like real gravity. Resets to 0 on landing.
    PLAYER.gravity += gamecore.GRAVITY * gamecore.FIXED_DT

    // Peak of jump detection — when gravity crosses 0 the player stopped going up
    // and is now falling. is_jumping becomes false so fall animation can trigger.
    if PLAYER.is_jumping && PLAYER.gravity >= 0 {
        PLAYER.is_jumping = false
    }

    // Vertical movement is driven by gravity alone after jump sets it
    // velocity.y is only used for horizontal movement
    PLAYER.position.x += PLAYER.velocity.x * gamecore.FIXED_DT
    PLAYER.position.y += PLAYER.gravity    * gamecore.FIXED_DT

    // Ground collision — clamp position and stop gravity
    GROUND_Y :: f32(600)
    if PLAYER.position.y + PLAYER.size.y >= GROUND_Y {
        PLAYER.position.y = GROUND_Y - PLAYER.size.y
        PLAYER.gravity    = 0
        PLAYER.on_ground  = true
        PLAYER.is_jumping = false
    } else {
        PLAYER.on_ground = false
    }
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
    // Only allow jumping when on the ground
    // Sets gravity to a large negative value so the player shoots upward
    // Gravity then naturally decelerates the jump and pulls the player back down
    // This feels like a real jump because the arc is smooth, not instant
    if PLAYER.on_ground {
        PLAYER.gravity    = -PLAYER.jump_force
        PLAYER.on_ground  = false
        PLAYER.is_jumping = true
    }
}
Crouch :: proc() {
    // When crouching, halve the player height and push position down
    // so the top of the player stays in place instead of the bottom
    if !PLAYER.is_crouching {
        PLAYER.size.y        = PLAYER.size.y / 2
        PLAYER.position.y   += PLAYER.size.y   // compensate so feet stay on ground
        PLAYER.is_crouching  = true
    }
}
StandUp :: proc() {
    // Restore original height and pull position back up
    if PLAYER.is_crouching {
        PLAYER.position.y   -= PLAYER.size.y   // compensate before doubling
        PLAYER.size.y        = PLAYER.size.y * 2
        PLAYER.is_crouching  = false
    }
}
// ---------------------------