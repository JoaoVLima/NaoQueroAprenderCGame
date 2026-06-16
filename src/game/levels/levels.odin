package levels

// Library Imports
import fmt "core:fmt"
import rl "vendor:raylib"

// Level Imports
// -------------
import bemvindo "bemvindo"
import menu "menu"
import tutorial "tutorial"
// -------------

// Structs
level :: struct {
    id: u8, // natural 8bit number
    name: string,
    draw: proc(),
}

// Procs
SwitchLevel :: proc(current: ^level, next: level, game_name: string) {
    current^ = next
    title := fmt.ctprintf("%s - %d - %s", game_name, next.id, next.name)
    rl.SetWindowTitle(title)
}

// Levels
LEVELS := []level{ // mutable (:=)
    {
        id = 0, 
        name = menu.NAME, 
        draw = menu.draw
    },
    {
        id = 1, 
        name = bemvindo.NAME, 
        draw = bemvindo.draw
    },
    {
        id = 2, 
        name = tutorial.NAME, 
        draw = tutorial.draw
    },
}

