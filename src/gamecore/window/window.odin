package window

// Library Imports
import rl "vendor:raylib"

// Structs
windowState :: struct {
    width: i32,
    height: i32,
    pos_x: i32,
    pos_y: i32,
    target_fps: i32,
    is_fullscreen: bool,
}

// Global Variables
WINDOW := windowState {
    is_fullscreen = false,
    width = 1280,
    height = 720,
    pos_x = 0,
    pos_y = 0,
    target_fps = 300, // meh
}

// Procs
InitWindow :: proc() {
    width := WINDOW.width
    height := WINDOW.height
    flags: rl.ConfigFlags = {.WINDOW_RESIZABLE}

    
    if WINDOW.is_fullscreen {
        flags += {.FULLSCREEN_MODE}
        width = 0 // Passando 0 o raylib pega a resolução do monitor
        height = 0
    }
    
    rl.SetConfigFlags(flags)
    
    rl.InitWindow(width, height, "Inicializando...") 
    rl.SetTargetFPS(WINDOW.target_fps)
}

UpdateWindowState :: proc() {
    // Check if the user dragged and resized the window
    if rl.IsWindowResized() && !WINDOW.is_fullscreen {
        WINDOW.width = rl.GetScreenWidth()
        WINDOW.height = rl.GetScreenHeight()

        pos := rl.GetWindowPosition()
        WINDOW.pos_x = cast(i32)pos.x
        WINDOW.pos_y = cast(i32)pos.y
    }
}

ToggleFullscreen :: proc() {
    WINDOW.is_fullscreen = !WINDOW.is_fullscreen

    if WINDOW.is_fullscreen { // Entrar em Fullscreen
        pos := rl.GetWindowPosition()
        WINDOW.pos_x = cast(i32)pos.x
        WINDOW.pos_y = cast(i32)pos.y
        
        monitor := rl.GetCurrentMonitor()
        monitor_w := rl.GetMonitorWidth(monitor)
        monitor_h := rl.GetMonitorHeight(monitor)

        // Redimensiona para o tamanho do monitor ANTES de ativar o fullscreen
        // Isso evita bugs de resolução e estiramento de imagem no raylib
        rl.SetWindowSize(monitor_w, monitor_h)
        rl.ToggleFullscreen()
    } else {  // Entrar em Windowed
        rl.ToggleFullscreen()
        rl.SetWindowSize(WINDOW.width, WINDOW.height)
        rl.SetWindowPosition(WINDOW.pos_x, WINDOW.pos_y)
    }
}

CloseWindow :: proc() {
    rl.CloseWindow()
}