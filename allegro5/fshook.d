module allegro5.fshook;

import allegro5.base;
import allegro5.file;
import allegro5.path;
import allegro5.internal.da5;

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

version (Tango)
{
	import tango.stdc.time : time_t;
}
else
{
	import core.stdc.time : time_t;
}

nothrow @nogc extern (C)
{
	struct ALLEGRO_FS_ENTRY 
	{
		const ALLEGRO_FS_INTERFACE* vtable;
	}

	enum ALLEGRO_FILE_MODE
	{
		ALLEGRO_FILEMODE_READ    = 1,
		ALLEGRO_FILEMODE_WRITE   = 1 << 1,
		ALLEGRO_FILEMODE_EXECUTE = 1 << 2,
		ALLEGRO_FILEMODE_HIDDEN  = 1 << 3,
		ALLEGRO_FILEMODE_ISFILE  = 1 << 4,
		ALLEGRO_FILEMODE_ISDIR   = 1 << 5,
	}
	
	struct ALLEGRO_FS_INTERFACE
	{
		ALLEGRO_FS_ENTRY* function(in char* path) fs_create_entry;
		void              function(ALLEGRO_FS_ENTRY* e) fs_destroy_entry;
		const_char*       function(ALLEGRO_FS_ENTRY* e) fs_entry_name;
		bool              function(ALLEGRO_FS_ENTRY* e) fs_update_entry;
		uint              function(ALLEGRO_FS_ENTRY* e) fs_entry_mode;
		time_t            function(ALLEGRO_FS_ENTRY* e) fs_entry_atime;
		time_t            function(ALLEGRO_FS_ENTRY* e) fs_entry_mtime;
		time_t            function(ALLEGRO_FS_ENTRY* e) fs_entry_ctime;
		off_t             function(ALLEGRO_FS_ENTRY* e) fs_entry_size;
		bool              function(ALLEGRO_FS_ENTRY* e) fs_entry_exists;
		bool              function(ALLEGRO_FS_ENTRY* e) fs_remove_entry;

		bool              function(ALLEGRO_FS_ENTRY* e) fs_open_directory;
		ALLEGRO_FS_ENTRY* function(ALLEGRO_FS_ENTRY* e) fs_read_directory;
		bool              function(ALLEGRO_FS_ENTRY* e) fs_close_directory;

		bool              function(in char* path) fs_filename_exists;
		bool              function(in char* path) fs_remove_filename;
		ALLEGRO_PATH*     function() fs_get_current_directory;
		bool              function(in char* path) fs_change_directory;
		bool              function(in char* path) fs_make_directory;
		
		ALLEGRO_FILE *    function(ALLEGRO_FS_ENTRY* e, in char* mode) fs_open_file;
	}

	ALLEGRO_FS_ENTRY*    al_create_fs_entry(in char* path);
	void                 al_destroy_fs_entry(ALLEGRO_FS_ENTRY* e);
	const_char*          al_get_fs_entry_name(ALLEGRO_FS_ENTRY* e);
	bool                 al_update_fs_entry(ALLEGRO_FS_ENTRY* e);
	uint                 al_get_fs_entry_mode(ALLEGRO_FS_ENTRY* e);
	time_t               al_get_fs_entry_atime(ALLEGRO_FS_ENTRY* e);
	time_t               al_get_fs_entry_mtime(ALLEGRO_FS_ENTRY* e);
	time_t               al_get_fs_entry_ctime(ALLEGRO_FS_ENTRY* e);
	off_t                al_get_fs_entry_size(ALLEGRO_FS_ENTRY* e);
	bool                 al_fs_entry_exists(ALLEGRO_FS_ENTRY* e);
	bool                 al_remove_fs_entry(ALLEGRO_FS_ENTRY* e);

	bool                 al_open_directory(ALLEGRO_FS_ENTRY* e);
	ALLEGRO_FS_ENTRY*    al_read_directory(ALLEGRO_FS_ENTRY* e);
	bool                 al_close_directory(ALLEGRO_FS_ENTRY* e);

	bool                 al_filename_exists(in char* path);
	bool                 al_remove_filename(in char* path);
	char*                al_get_current_directory();
	bool                 al_change_directory(in char* path);
	bool                 al_make_directory(in char* path);
	
	ALLEGRO_FILE*        al_open_fs_entry(ALLEGRO_FS_ENTRY* e, in char* mode);

	enum ALLEGRO_FOR_EACH_FS_ENTRY_RESULT
	{
	   ALLEGRO_FOR_EACH_FS_ENTRY_ERROR = -1,
	   ALLEGRO_FOR_EACH_FS_ENTRY_OK    =  0,
	   ALLEGRO_FOR_EACH_FS_ENTRY_SKIP  =  1,
	   ALLEGRO_FOR_EACH_FS_ENTRY_STOP  =  2
	}

	int al_for_each_fs_entry(ALLEGRO_FS_ENTRY *dir,
		int function(ALLEGRO_FS_ENTRY*, void*) callback,
		void *extra);

	/* Thread-local state. */
	ALLEGRO_FS_INTERFACE* al_get_fs_interface();
	void al_set_fs_interface(in ALLEGRO_FS_INTERFACE* vtable);
	void al_set_standard_fs_interface();
}
