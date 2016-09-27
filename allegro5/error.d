module allegro5.error;

nothrow @nogc extern(C)
{
	int al_get_errno();
	void al_set_errno(int errnum);
}
