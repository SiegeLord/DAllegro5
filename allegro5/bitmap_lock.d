module allegro5.bitmap_lock;

import allegro5.bitmap;

nothrow @nogc extern(C)
{
	/*
	 * Locking flags
	 */
	enum : int
	{
		ALLEGRO_LOCK_READWRITE  = 0,
		ALLEGRO_LOCK_READONLY   = 1,
		ALLEGRO_LOCK_WRITEONLY  = 2
	}

	struct ALLEGRO_LOCKED_REGION 
	{
		void* data;
		int format;
		int pitch;
		int pixel_size;
	}

	ALLEGRO_LOCKED_REGION* al_lock_bitmap(ALLEGRO_BITMAP* bitmap, int format, int flags);
	ALLEGRO_LOCKED_REGION* al_lock_bitmap_region(ALLEGRO_BITMAP* bitmap, int x, int y, int width, int height, int format, int flags);
	void al_unlock_bitmap(ALLEGRO_BITMAP* bitmap);
	bool al_is_bitmap_locked(ALLEGRO_BITMAP* bitmap);
}
