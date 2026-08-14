package menu

// Library Imports
import rl "vendor:raylib"

// Global Variables
NAME :: "Menu"

draw :: proc() {
    rl.ClearBackground(rl.WHITE)
    rl.DrawText("Você está no MENU.", 100, 100, 20, rl.DARKGRAY)
}