module allegro5.monitor;

nothrow @nogc extern(C)
{
	struct ALLEGRO_MONITOR_INFO
	{
		int x1;
		int y1;
		int x2;
		int y2;
	}

	enum
	{
		ALLEGRO_DEFAULT_DISPLAY_ADAPTER = -1
	}

	int al_get_num_video_adapters();
	bool al_get_monitor_info(int adapter, ALLEGRO_MONITOR_INFO* info);
}
