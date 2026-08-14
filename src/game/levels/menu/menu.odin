package menu

// Library Imports
import rl "vendor:raylib"

// Imports
import colors "../../../gamecore/colors"

// Global Variables
NAME :: "Menu"

Draw :: proc() {
    rl.ClearBackground(colors.Revolver)
    rl.DrawText("Você está no MENU.", 100, 100, 20, colors.MutedOrange)
}