module allegro5.allegro_windows;

import allegro5.display;
import core.sys.windows.windows;

nothrow @nogc extern (C) {
    HWND al_get_win_window_handle(ALLEGRO_DISPLAY*);

    bool al_win_add_window_callback(
        ALLEGRO_DISPLAY* display,
        bool function(
            ALLEGRO_DISPLAY* display,
            uint message,
            WPARAM wparam,
            LPARAM lparam,
            LRESULT* result,
            void* userdata) callback,
        void* userdata);

    bool al_win_remove_window_callback(
        ALLEGRO_DISPLAY* display,
        bool function(
            ALLEGRO_DISPLAY* display,
            uint message,
            WPARAM wparam,
            LPARAM lparam,
            LRESULT* result,
            void* userdata) callback,
        void* userdata);
}
