package game

// Library Imports
import fmt "core:fmt"
import rl "vendor:raylib"

// Imports
import win "gamecore/window"
import km "gamecore/keymaps"
import lvl "game/levels"
import player "game/players"

// Global Variables
GAME_NAME :: "NaoQueroAprenderC" // (Untyped string) constant (::)
GAME_VERSION :: "0.0.3"

// Main Logic
main :: proc() {
    win.InitWindow()
    defer win.CloseWindow() // defer faz ele executar no final da funcao (Pilha - LIFO: Last In, First Out)

    current_level := lvl.LEVELS[0]

    // Título inicial da janela
    window_name := fmt.ctprintf("%s - %d - %s", GAME_NAME, current_level.id, current_level.name) // "c" para retornar tipo cstring // "t" alocador temporario 
    rl.SetWindowTitle(window_name)
    
    player.InitPlayer()

    // Loop principal do jogo
    for !rl.WindowShouldClose() {
        player.ResetVelocity()

        // Keymaps
        km.CheckKeysPressed()

        // Update States
        win.UpdateWindowState()
        player.ApplyVelocity()

        
        // Drawing the frame
        // ------------------------
        rl.BeginDrawing()
        // ---------------
        rl.ClearBackground(rl.WHITE)

        // Debug
        rl.DrawFPS(10, 10)
        rl.DrawText(fmt.ctprintf("Player:\nposition: %f,%f\nvelocity: %f,%f", player.PLAYER.position.x, player.PLAYER.position.y, player.PLAYER.velocity.x, player.PLAYER.velocity.y), 444, 444, 20, rl.DARKGRAY)

        // Current Level
        if current_level.draw != nil {
            current_level.draw()
        }

        // Player
        player.Draw()
                
        // Enemies

        // ---------------
        rl.EndDrawing()
        // ------------------------
    }
}
