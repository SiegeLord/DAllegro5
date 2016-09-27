module allegro5.cpu;

import allegro5.base;

nothrow @nogc extern (C)
{
	int al_get_cpu_count();
	int al_get_ram_size();
}
