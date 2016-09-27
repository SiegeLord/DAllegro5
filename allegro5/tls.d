module allegro5.tls;

nothrow @nogc extern (C)
{
	enum ALLEGRO_STATE_FLAGS
	{
		ALLEGRO_STATE_NEW_DISPLAY_PARAMETERS = 0x0001,
		ALLEGRO_STATE_NEW_BITMAP_PARAMETERS  = 0x0002,
		ALLEGRO_STATE_DISPLAY                = 0x0004,
		ALLEGRO_STATE_TARGET_BITMAP          = 0x0008,
		ALLEGRO_STATE_BLENDER                = 0x0010,
		ALLEGRO_STATE_NEW_FILE_INTERFACE     = 0x0020,
		ALLEGRO_STATE_TRANSFORM              = 0x0040,
		ALLEGRO_STATE_PROJECTION_TRANSFORM   = 0x0100,

		ALLEGRO_STATE_BITMAP                 = ALLEGRO_STATE_TARGET_BITMAP + ALLEGRO_STATE_NEW_BITMAP_PARAMETERS,

		ALLEGRO_STATE_ALL                    = 0xffff
	}
	
	struct ALLEGRO_STATE
	{
		char[1024] _tls;
	}

	void al_store_state(ALLEGRO_STATE *state, int flags);
	void al_restore_state(in ALLEGRO_STATE *state);
}
