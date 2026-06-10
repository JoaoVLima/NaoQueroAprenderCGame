package game

// Imports
import fmt "core:fmt"
import rl "vendor:raylib"

// Level Imports
import lvl "levels"
// -------------
import bemvindo "levels/bemvindo"
import menu "levels/menu"
import tutorial "levels/tutorial"
// -------------

// Global Variables
GAME_NAME :: "NaoQueroAprenderC" // (Untyped string) constant (::)

// Levels
LEVELS := []lvl.Level{
    {
        id = 0, 
        name = menu.NAME, 
        draw_proc = menu.draw
    },
    {
        id = 1, 
        name = bemvindo.NAME, 
        draw_proc = bemvindo.draw
    },
    {
        id = 2, 
        name = tutorial.NAME, 
        draw_proc = tutorial.draw
    },
}

// Main Logic
main :: proc() {
    current_level := LEVELS[0]

    // Título inicial da janela
    window_name := fmt.ctprintf("%s - %d - %s", GAME_NAME, current_level.id, current_level.name) // "c" para retornar tipo cstring // "t" alocador temporario 


    // Configuração da janela
    rl.InitWindow(1280, 720, window_name)
    defer rl.CloseWindow() // defer faz ele executar no final da funcao (Pilha - LIFO: Last In, First Out)
    rl.SetTargetFPS(60)

    // Loop principal do jogo
    for !rl.WindowShouldClose() {
        // temp, aperta espaco e muda de level
        if rl.IsKeyPressed(.SPACE) {
            next_level := (current_level.id + 1) % 3
            lvl.SwitchLevel(&current_level, LEVELS[next_level], GAME_NAME)
        }
        
        rl.BeginDrawing()
        // ------------------------

        rl.ClearBackground(rl.WHITE)
        rl.DrawText(GAME_NAME, 12, 12, 20, rl.BLACK)
        
        // draw da fase atual
        if current_level.draw_proc != nil {
            current_level.draw_proc()
        }
        // ------------------------
        rl.EndDrawing()
    }
}
