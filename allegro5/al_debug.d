module allegro5.al_debug;

nothrow @nogc extern (C)
{
	void al_register_assert_handler(void function(in char* expr, in char* file, int line, in char* func) handler);
	void al_register_trace_handler(void function(in char*) handler);
}
