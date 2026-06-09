package game

// Imports
import rl "vendor:raylib"
import fmt "core:fmt"

// Global Variables
// (Untyped string) constant (::)
GAME_NAME :: "NaoQueroAprenderC"

// Main Logic
main :: proc() {
    // Level: int = 0
    // Level_Name: string = "Menu"
    // Level: int = 1
    // Level_Name: string = "Bem Vindo"
    Level: int = 2
    Level_Name: string = "Tutorial"

    // Concatenando Strings
    // Usando o alocador temporario (c no inicio para retornar cstring)
    WindowName := fmt.ctprintf("%s : %d - %s", GAME_NAME, Level, Level_Name)
    // para usar o alocador permanente
    // use o fmt.caprintf e libere memoria com o delete() depois


    // Raylib Window
    rl.InitWindow(1280, 720, WindowName)

    for !rl.WindowShouldClose() {
        rl.BeginDrawing()
        rl.ClearBackground(rl.RED)
        rl.EndDrawing()
    }

    rl.CloseWindow()

}