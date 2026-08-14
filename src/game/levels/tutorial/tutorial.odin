package tutorial

// Library Imports
import rl "vendor:raylib"

// Imports
import colors "../../../gamecore/colors"

// Global Variables
NAME :: "Tutorial"

Draw :: proc() {
    rl.ClearBackground(colors.VintageTurquoise)
    rl.DrawText("Você está no Tutorial.", 100, 100, 20, colors.Revolver)
}