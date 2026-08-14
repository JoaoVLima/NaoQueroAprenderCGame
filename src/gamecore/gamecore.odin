package gamecore

// Library Imports
import rl "vendor:raylib"

// Global Variables
GRAVITY : f32 : 2000  // pixels per second^2
GRAVITY_DRAG_SCALAR :: f32(0.00008)
FIXED_DT  : f32 : 1.0 / 60.0


// Procs
InitialLoad :: proc() {
    // Load Game Assets and Devices
    // rl.InitAudioDevice()
}

CleanLoad :: proc() {
    // Unload Game Assets and Devices
    // rl.CloseAudioDevice()
}