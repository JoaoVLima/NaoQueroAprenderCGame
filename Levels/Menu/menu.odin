package menu

// Imports
import fmt "core:fmt"
import rl "vendor:raylib"

draw :: proc() {
    rl.DrawText("Você está no MENU. Pressione ESPAÇO para iniciar.", 100, 100, 20, rl.DARKGRAY)
}