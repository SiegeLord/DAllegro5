module allegro5.al_debug;

nothrow @nogc extern (C)
{
	void al_register_assert_handler(void function(const(char)* expr, const(char)* file, int line, const(char)* func) handler);
	void al_register_trace_handler(void function(const(char)*) handler);
}
