use raylib::init;
use raylib::color::Color;
use raylib::prelude::RaylibDraw;

const GAME_NAME: &'static str = "NaoQueroAprenderC";

struct Level {
    id: u8,
    name: &'static str,
}

fn main() {
    let levels = vec![
        Level { id: 0, name: "Menu" },
        Level { id: 1, name: "Bem Vindo" },
        Level { id: 2, name: "Tutorial" },
    ];

    let current_level = &levels[2];

    let TITLE = format!("{} - {} - {}", GAME_NAME, current_level.id, current_level.name);

    let (mut rl, thread) = raylib::init()
        .size(1280, 720)
        .title(TITLE.as_str())
        .build();

    while !rl.window_should_close() {
        let mut canvas = rl.begin_drawing(&thread);

        canvas.clear_background(Color::WHITE);
        canvas.draw_text(GAME_NAME, 12, 12, 20, Color::BLACK);
    }

}