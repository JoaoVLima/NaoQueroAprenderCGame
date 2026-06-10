package game

// Imports
import fmt "core:fmt"
import rl "vendor:raylib"

// Level Imports
import bemvindo "Levels/BemVindo"
import menu "Levels/Menu"
import tutorial "Levels/Tutorial"

// Global Variables
// (Untyped string) constant (::)
GAME_NAME :: "NaoQueroAprenderC"

// Levels
Level :: struct {
    id:   u8,
    name: string,
    draw_proc: proc(),
}
LEVELS := []Level{
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

switch_level :: proc(current: ^Level, next: Level) {
    current^ = next
    title := fmt.ctprintf("%s - %d - %s", GAME_NAME, next.id, next.name)
    rl.SetWindowTitle(title)
}

// Main Logic
main :: proc() {
    current_level := LEVELS[0]

    // Título inicial da janela
    // Concatenando Strings
    // Usando o alocador temporario (c no inicio para retornar cstring)
    window_name := fmt.ctprintf("%s - %d - %s", GAME_NAME, current_level.id, current_level.name)
    // para usar o alocador permanente
    // use o fmt.caprintf e libere memoria com o delete() depois

    // Configuração da janela
    rl.InitWindow(1280, 720, window_name)
    rl.SetTargetFPS(60)

    // Loop principal do jogo
    for !rl.WindowShouldClose() {
        if rl.IsKeyPressed(.SPACE) {
            next_level := (current_level.id + 1) % 3
            switch_level(&current_level, LEVELS[next_level])
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
