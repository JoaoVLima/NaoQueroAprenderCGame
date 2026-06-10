package game

// Imports
import fmt "core:fmt"
import rl "vendor:raylib"

// Level Imports
import lvl "Levels"
// -------------
import bemvindo "Levels/BemVindo"
import menu "Levels/Menu"
import tutorial "Levels/Tutorial"
// -------------

// Global Variables
GAME_NAME :: "NaoQueroAprenderC"

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
    window_name := fmt.ctprintf("%s - %d - %s", GAME_NAME, current_level.id, current_level.name)

    // Configuração da janela
    rl.InitWindow(1280, 720, window_name)
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
    rl.CloseWindow()
}
