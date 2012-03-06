module allegro5.al_debug;

extern (C)
{
	void al_register_assert_handler(void function(in char* expr, in char* file, int line, in char* func) handler);
}
