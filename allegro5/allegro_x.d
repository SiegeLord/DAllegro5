module allegro5.allegro_x;

import allegro.bitmap;
import allegro.display;

nothrow @nogc extern (C) {
    /*
     * The correct return type of al_get_x_window_id is XID. For C, XID is
     * defined in <X11/Xdefs.h> or <X11/X.h> as a 32-bit unsigned integer,
     * either C's unsigned long (if that is 32 bits long) or C's unsigned int.
     *
     * Since there seem to be no canonical D bindings for the X Window System,
     * we hardcode al_get_x_window_id's return type as D's 32-bit uint.
     */
    uint al_get_x_window_id(ALLEGRO_DISPLAY*);

    bool al_x_set_initial_icon(ALLEGRO_BITMAP*);
}
