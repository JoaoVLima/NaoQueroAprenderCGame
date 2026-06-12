package window

// Library Imports
import rl "vendor:raylib"

// Structs
windowState :: struct {
    width: i32,
    height: i32,
    target_fps: i32,
    is_fullscreen: bool,
}

// Procs
InitWindow :: proc(window: ^windowState) {
    width := window.width
    height := window.height

    
    if window.is_fullscreen {
        rl.SetConfigFlags(rl.ConfigFlags{.FULLSCREEN_MODE})
        width = 0 // Passando 0 o raylib pega a resolução do monitor
        height = 0
    }
    
    rl.InitWindow(width, height, "Inicializando...") 
    rl.SetTargetFPS(window.target_fps)
    
    // Load Game Assets and Devices
    // rl.InitAudioDevice()
}

ChangeWindow :: proc(window: ^windowState) {

}

CloseWindow :: proc() {
    // Unload Game Assets and Devices
    // rl.CloseAudioDevice()
    rl.CloseWindow()
}