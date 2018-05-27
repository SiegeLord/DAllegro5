module allegro5.internal.da5;

char[] ColorWrapper(in char[] prefix, in char[] func, in char[] arg_decls, in char[] arg_names)
{
	return
	`nothrow @nogc ALLEGRO_COLOR ` ~ func ~ `(` ~ arg_decls ~ `)
	{
		auto ret = ` ~ prefix ~ func ~ `(` ~ arg_names ~ `);
		version(ALLEGRO_SUB)
		{
			asm nothrow @nogc
			{
				sub ESP, 4;
			}
		}
		return ret;
	}`;
}

version(D_Version2)
	mixin(`alias const(char) const_char;`);
else
	alias char const_char;
