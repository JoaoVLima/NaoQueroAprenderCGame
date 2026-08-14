package game
// Here is were the magic happens,
// this is the main file that run the game

// Library Imports
import fmt "core:fmt"
import rl "vendor:raylib"

// Imports
import gamecore "gamecore"
import colors "gamecore/colors"
import window "gamecore/window"
import kmaps "gamecore/keymaps"
import lvl "game/levels"
import player "game/players"

// Global Variables
GAME_NAME :: "NaoQueroAprenderC" // (Untyped string) constant (::)
GAME_VERSION :: "0.0.6"

// Main Logic
main :: proc() {
    window.InitWindow()
    defer window.CloseWindow() // defer makes the subproc be executed at the end of this proc (Pilha - LIFO: Last In, First Out)

    gamecore.InitialLoad() // Loading devices, audio, assets, etc
    defer gamecore.CleanLoad()

    current_level := lvl.LEVELS[0] // Menu

    // Window Title
    window_name := fmt.ctprintf("%s - %d - %s", GAME_NAME, current_level.id, current_level.name) // "c" return type cstring // "t" temporary alocator 
    rl.SetWindowTitle(window_name)
    
    // Show the player (this will be called only when in levels)
    player.RenderPlayer()

    // Accumulator holds leftover time between frames
    // Each frame we add the real elapsed time, then drain it in fixed 1/60s chunks
    // This decouples physics from render FPS
    accumulator: f32 = 0.0

    // Main game loop
    for !rl.WindowShouldClose() {
        // Update States Before Keymaps
        // ------------------------
        player.UpdateVelocityState()
        // ------------------------
        
        // Keymaps
        kmaps.CheckKeysPressed()

        // Update States
        // ------------------------
        window.UpdateWindowState()

        // Spiral of death prevention:
        // If the game froze (alt-tab, debugger breakpoint, heavy load),
        // GetFrameTime() could return a huge value like 5.0s, which would
        // make the inner loop run 300 times in one frame and freeze again.
        // Clamping to 0.25s means at worst 15 physics steps per frame.
        if accumulator > 0.25 {
            accumulator = 0.25
        }
        accumulator += rl.GetFrameTime()

        // Drain the accumulator in fixed 1/60s steps
        // At 60fps: runs exactly once per frame
        // At 120fps: runs every other frame
        // At 30fps: runs twice per frame
        // Physics result is always the same regardless
        for accumulator >= gamecore.FIXED_DT {
            player.UpdatePositionState()
            // enemy.UpdatePositionState() <- enemies go here, same fixed step
            accumulator -= gamecore.FIXED_DT
        }


        // ------------------------
        
        // Drawing the frame
        // ------------------------
        rl.BeginDrawing()
        // ---------------
        
        // Current Level
        if current_level.draw != nil {
            current_level.draw()
        }

        // Debug
        rl.DrawFPS(10, 10)
        player.DebugDraw(500, 150, 20, colors.AmericanBrown)
        

        // Drawing Player if is_rendering
        player.Draw()
                
        // Enemies

        // ---------------
        rl.EndDrawing()
        // ------------------------
    }
}
