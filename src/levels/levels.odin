package levels

// Imports
import fmt "core:fmt"
import rl "vendor:raylib"

// Level Imports
// -------------
import bemvindo "bemvindo"
import menu "menu"
import tutorial "tutorial"
// -------------

// Structs
Level :: struct {
    id:   u8,
    name: string,
    draw_proc: proc(),
}

// Procs
SwitchLevel :: proc(current: ^Level, next: Level, game_name: string) {
    current^ = next
    title := fmt.ctprintf("%s - %d - %s", game_name, next.id, next.name)
    rl.SetWindowTitle(title)
}

// Levels
LEVELS := []Level{ // mutable (:=)
    {
        id = 0, 
        name = menu.NAME, 
        draw_proc = menu.draw
    },
    {
        id = 1, 
        name = bemvindo.NAME, 
        draw_proc = bemvindo.draw
    },
    {
        id = 2, 
        name = tutorial.NAME, 
        draw_proc = tutorial.draw
    },
}

