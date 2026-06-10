package levels

// Imports
import fmt "core:fmt"
import rl "vendor:raylib"

Level :: struct {
    id:   u8,
    name: string,
    draw_proc: proc(),
}

SwitchLevel :: proc(current: ^Level, next: Level, game_name: string) {
    current^ = next
    title := fmt.ctprintf("%s - %d - %s", game_name, next.id, next.name)
    rl.SetWindowTitle(title)
}