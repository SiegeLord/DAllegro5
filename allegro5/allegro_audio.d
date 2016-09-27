module allegro5.allegro_audio;

version(ALLEGRO_NO_PRAGMA_LIB) {}
else
{
	pragma(lib, "allegro_audio");
}

version (ALLEGRO_UNSTABLE)
	version = AllegroAudioUnstable;
version(ALLEGRO_INTERNAL_UNSTABLE)
	version = AllegroAudioUnstable;
version(ALLEGRO_KCM_AUDIO_SRC)
	version = AllegroAudioUnstable;

import allegro5.allegro;
import allegro5.events;
import allegro5.internal.da5;

nothrow @nogc extern (C)
{
	version (AllegroAudioUnstable)
	{
		struct ALLEGRO_AUDIO_RECORDER_EVENT
		{
			mixin(_AL_EVENT_HEADER("ALLEGRO_AUDIO_RECORDER"));
			ALLEGRO_USER_EVENT_DESCRIPTOR* __internal__descr;
			void* buffer;
			uint samples;
		};
	}

	enum ALLEGRO_AUDIO_DEPTH
	{
		ALLEGRO_AUDIO_DEPTH_INT8      = 0x00,
		ALLEGRO_AUDIO_DEPTH_INT16     = 0x01,
		ALLEGRO_AUDIO_DEPTH_INT24     = 0x02,
		ALLEGRO_AUDIO_DEPTH_FLOAT32   = 0x03,

		ALLEGRO_AUDIO_DEPTH_UNSIGNED  = 0x08,

		/* For convenience */
		ALLEGRO_AUDIO_DEPTH_UINT8  = ALLEGRO_AUDIO_DEPTH_INT8 | ALLEGRO_AUDIO_DEPTH_UNSIGNED,
		ALLEGRO_AUDIO_DEPTH_UINT16 = ALLEGRO_AUDIO_DEPTH_INT16 | ALLEGRO_AUDIO_DEPTH_UNSIGNED,
		ALLEGRO_AUDIO_DEPTH_UINT24 = ALLEGRO_AUDIO_DEPTH_INT24 | ALLEGRO_AUDIO_DEPTH_UNSIGNED
	}

	enum ALLEGRO_CHANNEL_CONF
	{
		ALLEGRO_CHANNEL_CONF_1   = 0x10,
		ALLEGRO_CHANNEL_CONF_2   = 0x20,
		ALLEGRO_CHANNEL_CONF_3   = 0x30,
		ALLEGRO_CHANNEL_CONF_4   = 0x40,
		ALLEGRO_CHANNEL_CONF_5_1 = 0x51,
		ALLEGRO_CHANNEL_CONF_6_1 = 0x61,
		ALLEGRO_CHANNEL_CONF_7_1 = 0x71
	}
	
	const ALLEGRO_MAX_CHANNELS = 8;

	enum ALLEGRO_PLAYMODE
	{
		ALLEGRO_PLAYMODE_ONCE   = 0x100,
		ALLEGRO_PLAYMODE_LOOP   = 0x101,
		ALLEGRO_PLAYMODE_BIDIR  = 0x102,
		_ALLEGRO_PLAYMODE_STREAM_ONCE   = 0x103,   /* internal */
		_ALLEGRO_PLAYMODE_STREAM_ONEDIR = 0x104    /* internal */
	}

	enum ALLEGRO_MIXER_QUALITY
	{
		ALLEGRO_MIXER_QUALITY_POINT   = 0x110,
		ALLEGRO_MIXER_QUALITY_LINEAR  = 0x111,
		ALLEGRO_MIXER_QUALITY_CUBIC   = 0x112
	}

	const float ALLEGRO_AUDIO_PAN_NONE = -1000.0f;
	
	enum ALLEGRO_AUDIO_EVENT_TYPE
	{
		ALLEGRO_EVENT_AUDIO_ROUTE_CHANGE       = 520,
		ALLEGRO_EVENT_AUDIO_INTERRUPTION       = 521,
		ALLEGRO_EVENT_AUDIO_END_INTERRUPTION   = 522
	}

	struct ALLEGRO_SAMPLE {};

	struct ALLEGRO_SAMPLE_ID
	{
		int _index;
		int _id;
	}

	struct ALLEGRO_SAMPLE_INSTANCE {};
	
	struct ALLEGRO_AUDIO_STREAM {};
	
	struct ALLEGRO_MIXER {};

	struct ALLEGRO_VOICE {};

	version (AllegroAudioUnstable)
		struct ALLEGRO_AUDIO_RECORDER {};

	ALLEGRO_SAMPLE* al_create_sample(void* buf, uint samples, uint freq, ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf, bool free_buf);
	void al_destroy_sample(ALLEGRO_SAMPLE* spl);

	/* Sample instance functions */
	ALLEGRO_SAMPLE_INSTANCE* al_create_sample_instance(ALLEGRO_SAMPLE* data);
	void al_destroy_sample_instance(ALLEGRO_SAMPLE_INSTANCE* spl);

	uint al_get_sample_frequency(in ALLEGRO_SAMPLE* spl);
	uint al_get_sample_length(in ALLEGRO_SAMPLE* spl);
	ALLEGRO_AUDIO_DEPTH al_get_sample_depth(in ALLEGRO_SAMPLE* spl);
	ALLEGRO_CHANNEL_CONF al_get_sample_channels(in ALLEGRO_SAMPLE* spl);
	void* al_get_sample_data(in ALLEGRO_SAMPLE* spl);

	uint al_get_sample_instance_frequency(in ALLEGRO_SAMPLE_INSTANCE* spl);
	uint al_get_sample_instance_length(in ALLEGRO_SAMPLE_INSTANCE* spl);
	uint al_get_sample_instance_position(in ALLEGRO_SAMPLE_INSTANCE* spl);

	float al_get_sample_instance_speed(in ALLEGRO_SAMPLE_INSTANCE* spl);
	float al_get_sample_instance_gain(in ALLEGRO_SAMPLE_INSTANCE* spl);
	float al_get_sample_instance_pan(in ALLEGRO_SAMPLE_INSTANCE* spl);
	float al_get_sample_instance_time(in ALLEGRO_SAMPLE_INSTANCE* spl);

	ALLEGRO_AUDIO_DEPTH al_get_sample_instance_depth(in ALLEGRO_SAMPLE_INSTANCE* spl);
	ALLEGRO_CHANNEL_CONF al_get_sample_instance_channels(in ALLEGRO_SAMPLE_INSTANCE* spl);
	ALLEGRO_PLAYMODE al_get_sample_instance_playmode(in ALLEGRO_SAMPLE_INSTANCE* spl);

	bool al_get_sample_instance_playing(in ALLEGRO_SAMPLE_INSTANCE* spl);
	bool al_get_sample_instance_attached(in ALLEGRO_SAMPLE_INSTANCE* spl);

	bool al_set_sample_instance_position(ALLEGRO_SAMPLE_INSTANCE* spl, uint val);
	bool al_set_sample_instance_length(ALLEGRO_SAMPLE_INSTANCE* spl, uint val);

	bool al_set_sample_instance_speed(ALLEGRO_SAMPLE_INSTANCE* spl, float val);
	bool al_set_sample_instance_gain(ALLEGRO_SAMPLE_INSTANCE* spl, float val);
	bool al_set_sample_instance_pan(ALLEGRO_SAMPLE_INSTANCE* spl, float val);

	bool al_set_sample_instance_playmode(ALLEGRO_SAMPLE_INSTANCE* spl, ALLEGRO_PLAYMODE val);

	bool al_set_sample_instance_playing(ALLEGRO_SAMPLE_INSTANCE* spl, bool val);
	bool al_detach_sample_instance(ALLEGRO_SAMPLE_INSTANCE* spl);

	bool al_set_sample(ALLEGRO_SAMPLE_INSTANCE* spl, ALLEGRO_SAMPLE* data);
	ALLEGRO_SAMPLE* al_get_sample(ALLEGRO_SAMPLE_INSTANCE* spl);
	bool al_play_sample_instance(ALLEGRO_SAMPLE_INSTANCE* spl);
	bool al_stop_sample_instance(ALLEGRO_SAMPLE_INSTANCE* spl);


	/* Stream functions */
	ALLEGRO_AUDIO_STREAM* al_create_audio_stream(size_t buffer_count, uint samples, uint freq, ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf);
	void al_destroy_audio_stream(ALLEGRO_AUDIO_STREAM* stream);
	void al_drain_audio_stream(ALLEGRO_AUDIO_STREAM* stream);

	uint al_get_audio_stream_frequency(in ALLEGRO_AUDIO_STREAM* stream);
	uint al_get_audio_stream_length(in ALLEGRO_AUDIO_STREAM* stream);
	uint al_get_audio_stream_fragments(in ALLEGRO_AUDIO_STREAM* stream);
	uint al_get_available_audio_stream_fragments(in ALLEGRO_AUDIO_STREAM* stream);

	float al_get_audio_stream_speed(in ALLEGRO_AUDIO_STREAM* stream);
	float al_get_audio_stream_gain(in ALLEGRO_AUDIO_STREAM* stream);
	float al_get_audio_stream_pan(in ALLEGRO_AUDIO_STREAM* stream);

	ALLEGRO_CHANNEL_CONF al_get_audio_stream_channels(in ALLEGRO_AUDIO_STREAM* stream);
	ALLEGRO_AUDIO_DEPTH al_get_audio_stream_depth(in ALLEGRO_AUDIO_STREAM* stream);
	ALLEGRO_PLAYMODE al_get_audio_stream_playmode(in ALLEGRO_AUDIO_STREAM* stream);

	bool al_get_audio_stream_playing(in ALLEGRO_AUDIO_STREAM* spl);
	bool al_get_audio_stream_attached(in ALLEGRO_AUDIO_STREAM* spl);
	ulong al_get_audio_stream_played_samples(in ALLEGRO_AUDIO_STREAM* stream);

	void* al_get_audio_stream_fragment(in ALLEGRO_AUDIO_STREAM* stream);

	bool al_set_audio_stream_speed(ALLEGRO_AUDIO_STREAM* stream, float val);
	bool al_set_audio_stream_gain(ALLEGRO_AUDIO_STREAM* stream, float val);
	bool al_set_audio_stream_pan(ALLEGRO_AUDIO_STREAM* stream, float val);

	bool al_set_audio_stream_playmode(ALLEGRO_AUDIO_STREAM* stream, ALLEGRO_PLAYMODE val);

	bool al_set_audio_stream_playing(ALLEGRO_AUDIO_STREAM* stream, bool val);
	bool al_detach_audio_stream(ALLEGRO_AUDIO_STREAM* stream);
	bool al_set_audio_stream_fragment(ALLEGRO_AUDIO_STREAM* stream, void* val);

	bool al_rewind_audio_stream(ALLEGRO_AUDIO_STREAM* stream);
	bool al_seek_audio_stream_secs(ALLEGRO_AUDIO_STREAM* stream, double time);
	double al_get_audio_stream_position_secs(ALLEGRO_AUDIO_STREAM* stream);
	double al_get_audio_stream_length_secs(ALLEGRO_AUDIO_STREAM* stream);
	bool al_set_audio_stream_loop_secs(ALLEGRO_AUDIO_STREAM* stream, double start, double end);

	ALLEGRO_EVENT_SOURCE * al_get_audio_stream_event_source(ALLEGRO_AUDIO_STREAM* stream);

	/* Mixer functions */
	ALLEGRO_MIXER* al_create_mixer(uint freq,
	ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf);
	void al_destroy_mixer(ALLEGRO_MIXER* mixer);
	bool al_attach_sample_instance_to_mixer(ALLEGRO_SAMPLE_INSTANCE* stream, ALLEGRO_MIXER* mixer);
	bool al_attach_audio_stream_to_mixer(ALLEGRO_AUDIO_STREAM* stream, ALLEGRO_MIXER* mixer);
	bool al_attach_mixer_to_mixer(ALLEGRO_MIXER* stream, ALLEGRO_MIXER* mixer);
	bool al_set_mixer_postprocess_callback(ALLEGRO_MIXER* mixer, void function(void* buf, uint samples, void* data) cb, void* data);

	uint al_get_mixer_frequency(in ALLEGRO_MIXER* mixer);
	ALLEGRO_CHANNEL_CONF al_get_mixer_channels(in ALLEGRO_MIXER* mixer);
	ALLEGRO_AUDIO_DEPTH al_get_mixer_depth(in ALLEGRO_MIXER* mixer);
	ALLEGRO_MIXER_QUALITY al_get_mixer_quality(in ALLEGRO_MIXER* mixer);
	float al_get_mixer_gain(in ALLEGRO_MIXER *mixer);
	bool al_get_mixer_playing(in ALLEGRO_MIXER* mixer);
	bool al_get_mixer_attached(in ALLEGRO_MIXER* mixer);
	bool al_set_mixer_frequency(ALLEGRO_MIXER* mixer, uint val);
	bool al_set_mixer_quality(ALLEGRO_MIXER* mixer, ALLEGRO_MIXER_QUALITY val);
	bool al_set_mixer_gain(ALLEGRO_MIXER *mixer, float gain);
	bool al_set_mixer_playing(ALLEGRO_MIXER* mixer, bool val);
	bool al_detach_mixer(ALLEGRO_MIXER* mixer);

	/* Voice functions */
	ALLEGRO_VOICE* al_create_voice(uint freq,
	ALLEGRO_AUDIO_DEPTH depth,
	ALLEGRO_CHANNEL_CONF chan_conf);
	void al_destroy_voice(ALLEGRO_VOICE* voice);
	bool al_attach_sample_instance_to_voice(ALLEGRO_SAMPLE_INSTANCE* stream, ALLEGRO_VOICE* voice);
	bool al_attach_audio_stream_to_voice(ALLEGRO_AUDIO_STREAM* stream, ALLEGRO_VOICE* voice );
	bool al_attach_mixer_to_voice(ALLEGRO_MIXER* mixer,
	ALLEGRO_VOICE* voice);
	void al_detach_voice(ALLEGRO_VOICE* voice);

	uint al_get_voice_frequency(in ALLEGRO_VOICE* voice);
	uint al_get_voice_position(in ALLEGRO_VOICE* voice);
	ALLEGRO_CHANNEL_CONF al_get_voice_channels(in ALLEGRO_VOICE* voice);
	ALLEGRO_AUDIO_DEPTH al_get_voice_depth(in ALLEGRO_VOICE* voice);
	bool al_get_voice_playing(in ALLEGRO_VOICE* voice);
	bool al_set_voice_position(ALLEGRO_VOICE* voice, uint val);
	bool al_set_voice_playing(ALLEGRO_VOICE* voice, bool val);

	/* Misc. audio functions */
	bool al_install_audio();
	void al_uninstall_audio();
	bool al_is_audio_installed();
	uint al_get_allegro_audio_version();

	size_t al_get_channel_count(ALLEGRO_CHANNEL_CONF conf);
	size_t al_get_audio_depth_size(ALLEGRO_AUDIO_DEPTH conf);

	void al_fill_silence(void* buf, uint samples, ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf);

	/* Simple audio layer */
	bool al_reserve_samples(int reserve_samples);
	ALLEGRO_MIXER* al_get_default_mixer();
	bool al_set_default_mixer(ALLEGRO_MIXER* mixer);
	bool al_restore_default_mixer();
	bool al_play_sample(ALLEGRO_SAMPLE* data, float gain, float pan, float speed, int loop, ALLEGRO_SAMPLE_ID* ret_id);
	void al_stop_sample(ALLEGRO_SAMPLE_ID* spl_id);
	void al_stop_samples();
	ALLEGRO_VOICE* al_get_default_voice();
	void al_set_default_voice(ALLEGRO_VOICE* voice);

	/* File type handlers */
	bool al_register_sample_loader(in char* ext, ALLEGRO_SAMPLE* function(in char* filename) loader);
	bool al_register_sample_saver(in char* ext, bool function(in char* filename, ALLEGRO_SAMPLE* spl) saver);
	bool al_register_audio_stream_loader(in char* ext, ALLEGRO_AUDIO_STREAM* function(in char* filename, size_t buffer_count, uint samples) stream_loader);

	bool al_register_sample_loader_f(in char* ext, ALLEGRO_SAMPLE* function(ALLEGRO_FILE* fp) loader);
	bool al_register_sample_saver_f(in char* ext, bool function(ALLEGRO_FILE* fp, ALLEGRO_SAMPLE* spl) saver);
	bool al_register_audio_stream_loader_f(in char* ext, ALLEGRO_AUDIO_STREAM* function(ALLEGRO_FILE* fp, size_t buffer_count, uint samples) stream_loader);

	ALLEGRO_SAMPLE* al_load_sample(in char* filename);
	bool al_save_sample(in char* filename, ALLEGRO_SAMPLE* spl);
	ALLEGRO_AUDIO_STREAM* al_load_audio_stream(in char* filename, size_t buffer_count, uint samples);

	ALLEGRO_SAMPLE* al_load_sample_f(ALLEGRO_FILE* fp, in char* ident);
	bool al_save_sample_f(ALLEGRO_FILE* fp, in char* ident, ALLEGRO_SAMPLE* spl);
	ALLEGRO_AUDIO_STREAM * al_load_audio_stream_f(ALLEGRO_FILE* fp, in char* ident,	size_t buffer_count, uint samples);

	/* Recording functions */
	version (AllegroAudioUnstable)
	{
		ALLEGRO_AUDIO_RECORDER* al_create_audio_recorder(size_t fragment_count, uint samples, uint freq, ALLEGRO_AUDIO_DEPTH depth, ALLEGRO_CHANNEL_CONF chan_conf);
		bool al_start_audio_recorder(ALLEGRO_AUDIO_RECORDER* r);
		void al_stop_audio_recorder(ALLEGRO_AUDIO_RECORDER* r);
		bool al_is_audio_recorder_recording(ALLEGRO_AUDIO_RECORDER* r);
		ALLEGRO_EVENT_SOURCE* al_get_audio_recorder_event_source(ALLEGRO_AUDIO_RECORDER* r);
		ALLEGRO_AUDIO_RECORDER_EVENT* al_get_audio_recorder_event(ALLEGRO_EVENT* event);
		void al_destroy_audio_recorder(ALLEGRO_AUDIO_RECORDER* r);
	}
}
