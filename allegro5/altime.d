module allegro5.altime;

nothrow @nogc extern(C)
{
	struct ALLEGRO_TIMEOUT
	{
		ulong __pad1__;
		ulong __pad2__;
	}

	double al_get_time();
	void al_rest(double seconds);
	void al_init_timeout(ALLEGRO_TIMEOUT* timeout, double seconds);
}
