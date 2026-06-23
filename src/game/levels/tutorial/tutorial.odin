package tutorial

// Library Imports
import rl "vendor:raylib"

// Global Variables
NAME :: "Tutorial"

draw :: proc() {
    rl.DrawText("Você está no Tutorial.", 100, 100, 20, rl.DARKGRAY)
}