package bemvindo

// Library Imports
import rl "vendor:raylib"

// Global Variables
NAME :: "Bem Vindo"

draw :: proc() {
    rl.DrawText("Você está no Bemvindo.", 100, 100, 20, rl.DARKGRAY)
}