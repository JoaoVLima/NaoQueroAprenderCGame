package game

// Imports
import "core:fmt"
import rl "vendor:raylib"

// Global Variables
// (Untyped string) constant (::)
GAME_NAME :: "NaoQueroAprenderC"

// Levels
Level :: struct {
    id:   u8,
    name: string,
}
LEVELS :: []Level{
    {id = 0, name = "Menu"},
    {id = 1, name = "Bem Vindo"},
    {id = 2, name = "Tutorial"},
}

// Main Logic
main :: proc() {
    current_level := LEVELS[1]

    // Concatenando Strings
    // Usando o alocador temporario (c no inicio para retornar cstring)
    window_name := fmt.ctprintf("%s - %d - %s", GAME_NAME, current_level.id, current_level.name)

    // Configuração da janela
    rl.InitWindow(1280, 720, window_name)
    rl.SetTargetFPS(60) // Boa prática na Raylib para evitar uso de 100% da CPU

    // Loop principal do jogo
    for !rl.WindowShouldClose() {
        rl.BeginDrawing()
        // ------------------------


        rl.ClearBackground(rl.WHITE)
        rl.DrawText(GAME_NAME, 12, 12, 20, rl.BLACK)
        

        // ------------------------
        rl.EndDrawing()
    }
    rl.CloseWindow()
}
