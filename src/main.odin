package game

// Library Imports
import fmt "core:fmt"
import rl "vendor:raylib"

// Imports
import win "gamecore/window"
import lvl "game/levels"

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

    
    // Loop principal do jogo
    for !rl.WindowShouldClose() {
        // Update States
        win.UpdateWindowSize()
        
        // Keymaps
        if (rl.IsKeyDown(.LEFT_ALT) || rl.IsKeyDown(.RIGHT_ALT)) && rl.IsKeyPressed(.ENTER) {
            win.ToggleFullscreen(); 
        }

        // temp, aperta espaco e muda de level
        if rl.IsKeyPressed(.SPACE) {
            next_level := (current_level.id + 1) % 3
            lvl.SwitchLevel(&current_level, lvl.LEVELS[next_level], GAME_NAME)
        }
        
        rl.BeginDrawing()
        // ------------------------
        rl.DrawFPS(10, 10)

        rl.ClearBackground(rl.WHITE)
        rl.DrawText(fmt.ctprintf("%d", win.WINDOW.width), 500, 500, 20, rl.BLACK)
        
        // draw da fase atual
        if current_level.draw_proc != nil {
            current_level.draw_proc()
        }
        // ------------------------
        rl.EndDrawing()
    }
}
