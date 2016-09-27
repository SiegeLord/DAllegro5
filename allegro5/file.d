module allegro5.file;

import allegro5.internal.da5;
import allegro5.path;
import allegro5.utf8;

version (Tango)
{
	import tango.core.Vararg : va_list;
}
else
{
	version(D_Version2)
	{
		import core.stdc.stdarg : va_list;
	}
	else
	{
		import std.c.stdarg : va_list;
	}
}

version(Windows)
{
	private alias long off_t;
}
else
{
	version(Tango)
	{
		import tango.stdc.posix.sys.types : off_t;
	}
	else
	{
		version(D_Version2)
		{
			import core.sys.posix.sys.types : off_t;
		}
		else
		{
			version(linux)
			{
				import std.c.linux.linux : off_t;
			}
			else
			{
				import std.c.freebsd.freebsd : off_t;
			}
		}
	}
}

nothrow @nogc extern (C)
{
	struct ALLEGRO_FILE_INTERFACE
	{
		void*   function(in char* path, in char* mode) fi_fopen;
		bool    function(ALLEGRO_FILE* handle) fi_fclose;
		size_t  function(ALLEGRO_FILE* f, void* ptr, size_t size) fi_fread;
		size_t  function(ALLEGRO_FILE* f, in void* ptr, size_t size) fi_fwrite;
		bool    function(ALLEGRO_FILE* f) fi_fflush;
		long    function(ALLEGRO_FILE* f) fi_ftell;
		bool    function(ALLEGRO_FILE* f, long offset, int whence) fi_fseek;
		bool    function(ALLEGRO_FILE* f) fi_feof;
		int     function(ALLEGRO_FILE* f) fi_ferror;
		const_char* function(ALLEGRO_FILE* f) fi_ferrmsg(ALLEGRO_FILE *f);
		void    function(ALLEGRO_FILE* f) fi_fclearerr;
		int     function(ALLEGRO_FILE* f, int c) fi_fungetc;
		off_t   function(ALLEGRO_FILE* f) fi_fsize;
	}
	
	struct ALLEGRO_FILE
	{
	}
	
	enum ALLEGRO_SEEK
	{
		ALLEGRO_SEEK_SET = 0,
		ALLEGRO_SEEK_CUR,
		ALLEGRO_SEEK_END
	}


	/* The basic operations. */
	ALLEGRO_FILE* al_fopen(in char* path, in char* mode);
	ALLEGRO_FILE* al_fopen_interface(in ALLEGRO_FILE_INTERFACE* vt, in char* path, in char* mode);
	ALLEGRO_FILE* al_create_file_handle(in ALLEGRO_FILE_INTERFACE* vt, void* userdata);
	bool al_fclose(ALLEGRO_FILE* f);
	size_t al_fread(ALLEGRO_FILE* f, void* ptr, size_t size);
	size_t al_fwrite(ALLEGRO_FILE* f, in void* ptr, size_t size);
	bool al_fflush(ALLEGRO_FILE* f);
	long al_ftell(ALLEGRO_FILE* f);
	bool al_fseek(ALLEGRO_FILE* f, long offset, int whence);
	bool al_feof(ALLEGRO_FILE* f);
	int al_ferror(ALLEGRO_FILE* f);
	const_char* al_ferrmsg(ALLEGRO_FILE *f);
	void al_fclearerr(ALLEGRO_FILE *f);
	int al_fungetc(ALLEGRO_FILE* f, int c);
	long al_fsize(ALLEGRO_FILE* f);

	/* Convenience functions. */
	int al_fgetc(ALLEGRO_FILE* f);
	int al_fputc(ALLEGRO_FILE* f, int c);
	short al_fread16le(ALLEGRO_FILE* f);
	short al_fread16be(ALLEGRO_FILE* f);
	size_t al_fwrite16le(ALLEGRO_FILE* f, short w);
	size_t al_fwrite16be(ALLEGRO_FILE* f, short w);
	int al_fread32le(ALLEGRO_FILE* f);
	int al_fread32be(ALLEGRO_FILE* f);
	size_t al_fwrite32le(ALLEGRO_FILE* f, int l);
	size_t al_fwrite32be(ALLEGRO_FILE* f, int l);
	char* al_fgets(ALLEGRO_FILE* f, in char* p, size_t max);
	ALLEGRO_USTR* al_fget_ustr(ALLEGRO_FILE* f);
	int al_fputs(ALLEGRO_FILE* f, in char* p);
	int al_fprintf(ALLEGRO_FILE *f, const char *format, ...);
	int al_vfprintf(ALLEGRO_FILE *f, const char* format, va_list args);

	/* Specific to stdio backend. */
	ALLEGRO_FILE* al_fopen_fd(int fd, in char* mode);
	ALLEGRO_FILE* al_make_temp_file(in char* tmpl,	ALLEGRO_PATH **ret_path);
	
	/* Specific to slices. */
	ALLEGRO_FILE* al_fopen_slice(ALLEGRO_FILE* fp, size_t initial_size, in char *mode);

	/* Thread-local state. */
	ALLEGRO_FILE_INTERFACE* al_get_new_file_interface();
	void al_set_new_file_interface(in ALLEGRO_FILE_INTERFACE* file_interface);
	void al_set_standard_file_interface();
	void* al_get_file_userdata(ALLEGRO_FILE *f);
}
