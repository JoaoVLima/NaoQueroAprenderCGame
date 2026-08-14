package bemvindo

// Library Imports
import rl "vendor:raylib"

// Imports
import colors "../../../gamecore/colors"

// Global Variables
NAME :: "Bem Vindo"


Draw :: proc() {
    rl.ClearBackground(colors.DullRed)
    rl.DrawText("Você está no Bemvindo.", 100, 100, 20, colors.Revolver)
}