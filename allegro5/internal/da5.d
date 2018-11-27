module allegro5.internal.da5;

/*
 * Issue: MinGW 4.5 and below has a bizzare calling convention when
 * returning structs. ColorWrapper takes care of the difference in
 * calling convention. If this wrapper is necessary, then D programs
 * that use DAllegro5 should link against allegro_color even when they
 * never call any allegro_color function.
 *
 * The following toolchains (to compile Allegro DLLs) are free of this issue:
 *  - MSVC,
 *  - maybe MinGW 4.6.
 * ColorWrapper resolves to a mere binding on all systems that don't
 * need the caretaking, and allegro_color needs not be linked against
 * then unless you call a function from allegro_color.
 *
 * ColorWrapper is private to DAllegro5. Call ColorWrapper in DAllegro5
 * outside any "nothrow @nogc extern (C)" because ColorWrapper will
 * insert attributes itself.
 */
char[] ColorWrapper(
	in char[] prefix, in char[] func, in char[] arg_decls, in char[] arg_names)
{
	static if (NeedsMinGW4CallingConvention)
	{
		// Implement a new D function to wrap Allegro's C function,
		// fixing the calling convention (see comment for ColorWrapper above).
		return
			`nothrow @nogc ALLEGRO_COLOR ` ~ func ~ `(` ~ arg_decls ~ `)
			{
				auto ret = ` ~ prefix ~ func ~ `(` ~ arg_names ~ `);
				asm nothrow @nogc
				{
					sub ESP, 4;
				}
				return ret;
			}`;
	}
	else
	{
		// Declare function as a normal C binding.
		return
			`nothrow @nogc extern (C)
			ALLEGRO_COLOR ` ~ func ~ `(` ~ arg_decls ~ `);`;
	}
}

bool NeedsMinGW4CallingConvention() pure nothrow @nogc
{
	version(ALLEGRO_MINGW_4_5)
	{
		return true;
	}
	else
	{
		return false;
	}
}
