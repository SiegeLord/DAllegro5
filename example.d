module a5test;

pragma(lib, "dallegro5");

version(ALLEGRO_NO_PRAGMA_LIB)
{

}
else
{
	pragma(lib, "allegro");
	pragma(lib, "allegro_primitives");
	pragma(lib, "allegro_image");
	pragma(lib, "allegro_font");
	pragma(lib, "allegro_ttf");
	pragma(lib, "allegro_color");
}

import std.stdio;

import allegro5.allegro;
import allegro5.allegro_primitives;
import allegro5.allegro_image;
import allegro5.allegro_font;
import allegro5.allegro_ttf;
import allegro5.allegro_color;

int main(char[][] args)
{
	return al_run_allegro(
	{
		if (!al_init())
		{
			auto ver = al_get_allegro_version();
			auto major = ver >> 24;
			auto minor = (ver >> 16) & 255;
			auto revision = (ver >> 8) & 255;
			auto release = ver & 255;

			writefln("The system Allegro version (%s.%s.%s.%s) does not match the version of this binding (%s.%s.%s.%s)",
				major, minor, revision, release,
				ALLEGRO_VERSION, ALLEGRO_SUB_VERSION, ALLEGRO_WIP_VERSION, ALLEGRO_RELEASE_NUMBER);
			return 1;
		}
		
		ALLEGRO_CONFIG* cfg = al_load_config_file("test.ini");
		version(Tango)
		{
			char[] arr = fromStringz(al_get_config_value(cfg, "", "name"));
			Stdout.formatln("Entry is: {}", arr);
		}

		ALLEGRO_DISPLAY* display = al_create_display(500, 500);

		ALLEGRO_EVENT_QUEUE* queue = al_create_event_queue();

		if (!al_install_keyboard())      assert(0, "al_install_keyboard failed!");
		if (!al_install_mouse())         assert(0, "al_install_mouse failed!");
		if (!al_init_image_addon())      assert(0, "al_init_image_addon failed!");
		if (!al_init_font_addon())       assert(0, "al_init_font_addon failed!");
		if (!al_init_ttf_addon())        assert(0, "al_init_ttf_addon failed!");
		if (!al_init_primitives_addon()) assert(0, "al_init_primitives_addon failed!");

		al_register_event_source(queue, al_get_display_event_source(display));
		al_register_event_source(queue, al_get_keyboard_event_source());
		al_register_event_source(queue, al_get_mouse_event_source());

		ALLEGRO_BITMAP* bmp = al_load_bitmap("mysha.pcx");
		ALLEGRO_FONT* font = al_load_font("DejaVuSans.ttf", 18, 0);

		with(ALLEGRO_BLEND_MODE)
		{
			al_set_blender(ALLEGRO_BLEND_OPERATIONS.ALLEGRO_ADD, ALLEGRO_ALPHA, ALLEGRO_INVERSE_ALPHA);
		}

		auto color1 = al_color_hsl(0, 0, 0);
		auto color2 = al_map_rgba_f(0.5, 0.25, 0.125, 1);
		version(Tango)
		{
			Stdout.formatln("{}, {}, {}, {}", color1.r, color1.g, color2.b, color2.a);
		}
		else
		{
			writefln("%s, %s, %s, %s", color1.r, color1.g, color2.b, color2.a);
		}


		bool exit = false;
		while(!exit)
		{
			ALLEGRO_EVENT event;
			while(al_get_next_event(queue, &event))
			{
				switch(event.type)
				{
					case ALLEGRO_EVENT_DISPLAY_CLOSE:
					{
						exit = true;
						break;
					}
					case ALLEGRO_EVENT_KEY_DOWN:
					{
						switch(event.keyboard.keycode)
						{
							case ALLEGRO_KEY_ESCAPE:
							{
								exit = true;
								break;
							}
							default:
						}
						break;
					}
					case ALLEGRO_EVENT_MOUSE_BUTTON_DOWN:
					{
						exit = true;
						break;
					}
					default:
				}
			}

			al_clear_to_color(ALLEGRO_COLOR(0.5, 0.25, 0.125, 1));
			al_draw_bitmap(bmp, 50, 50, 0);
			al_draw_triangle(20, 20, 300, 30, 200, 200, ALLEGRO_COLOR(1, 1, 1, 1), 4);
			al_draw_text(font, ALLEGRO_COLOR(1, 1, 1, 1), 70, 40, ALLEGRO_ALIGN_CENTRE, "Hello!");
			al_flip_display();
		}

		return 0;
	});
}
