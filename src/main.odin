package game

// Library Imports
import fmt "core:fmt"
import rl "vendor:raylib"

// Imports
import lvl "levels"

// Global Variables
GAME_NAME :: "NaoQueroAprenderC" // (Untyped string) constant (::)
GAME_VERSION :: "0.0.2"

// Main Logic
main :: proc() {
    window := windowState {
        is_fullscreen = true,
        width = 0, // Passando 0 o raylib pega a resolução do monitor
        height = 0,
        target_fps = 300, // meh
    }

    InitWindow(&window)
    defer CloseWindow() // defer faz ele executar no final da funcao (Pilha - LIFO: Last In, First Out)

    current_level := lvl.LEVELS[0]

    // Título inicial da janela
    window_name := fmt.ctprintf("%s - %d - %s", GAME_NAME, current_level.id, current_level.name) // "c" para retornar tipo cstring // "t" alocador temporario 
    rl.SetWindowTitle(window_name)
    
    // Loop principal do jogo
    for !rl.WindowShouldClose() {
        // temp, aperta espaco e muda de level
        if rl.IsKeyPressed(.SPACE) {
            next_level := (current_level.id + 1) % 3
            lvl.SwitchLevel(&current_level, lvl.LEVELS[next_level], GAME_NAME)
        }
        
        rl.BeginDrawing()
        // ------------------------
        rl.DrawFPS(10, 10)

        rl.ClearBackground(rl.WHITE)
        rl.DrawText(GAME_NAME, 1000, 1000, 20, rl.BLACK)
        
        // draw da fase atual
        if current_level.draw_proc != nil {
            current_level.draw_proc()
        }
        // ------------------------
        rl.EndDrawing()
    }
}
