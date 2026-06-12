package game

// Library Imports
import rl "vendor:raylib"

windowState :: struct {
    width: i32,
    height: i32,
    target_fps: i32,
    is_fullscreen: bool,
}

InitWindow :: proc(window: ^windowState) {
    rl.SetConfigFlags(rl.ConfigFlags{.FULLSCREEN_MODE})
    
    rl.InitWindow(window.width, window.height, "Inicializando...") 
    rl.SetTargetFPS(window.target_fps)
    
    // rl.InitAudioDevice()
}

CloseWindow :: proc() {
    // rl.CloseAudioDevice()
    rl.CloseWindow()
}