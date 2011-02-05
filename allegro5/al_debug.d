module allegro5.al_debug;

extern (C)
{
	void al_assert(in char *file, int linenr);
	void al_trace(in char *msg, ...);

	void al_register_assert_handler(int function(in char* msg) handler);
	void al_register_trace_handler(int function(in char* msg) handler);
}
