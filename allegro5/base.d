module allegro5.base;

version (Tango)
{
	import tango.math.Math;
}
else
{
	import std.math;
}

const int ALLEGRO_VERSION        = 5;
const int ALLEGRO_SUB_VERSION	 = 0;
const int ALLEGRO_WIP_VERSION	 = 10;
const int ALLEGRO_RELEASE_NUMBER = 1;

const char[] ALLEGRO_VERSION_STR = "5.0.10";
const char[] ALLEGRO_DATE_STR	 = "2013";
const int ALLEGRO_DATE         =  20130616;  /* yyyymmdd */

extern (C)
{
	uint al_get_allegro_version();
	int al_run_main(int argc, char **argv, int function(int, char **) fn);
}

const int ALLEGRO_VERSION_INT =
	 ((ALLEGRO_VERSION << 24) | (ALLEGRO_SUB_VERSION << 16) | 
	 (ALLEGRO_WIP_VERSION << 8) | ALLEGRO_RELEASE_NUMBER);

version (Tango) {
	alias tango.math.Math.PI ALLEGRO_PI;
}
else {
	alias std.math.PI ALLEGRO_PI;
}

int AL_ID(char a, char b, char c, char d)
{
	return (a << 24) | (b << 16) | (c << 8) | d;
}
