package bemvindo

// Imports
import fmt "core:fmt"
import rl "vendor:raylib"

draw :: proc() {
    rl.DrawText("Você está no Bemvindo. Pressione ESPAÇO para iniciar.", 100, 100, 20, rl.DARKGRAY)
}