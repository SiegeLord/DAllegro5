module allegro5.haptic;

import allegro5.display;
import allegro5.mouse;
import allegro5.joystick;
import allegro5.keyboard;
import allegro5.touch_input;

version (ALLEGRO_UNSTABLE)
	version = AllegroHapticUnstable;
version (ALLEGRO_INTERNAL_UNSTABLE)
	version = AllegroHapticUnstable;
version (ALLEGRO_SRC)
	version = AllegroHapticUnstable;

version (AllegroHapticUnstable):
enum ALLEGRO_HAPTIC_CONSTANTS
{
	ALLEGRO_HAPTIC_RUMBLE = 1 << 0,
	ALLEGRO_HAPTIC_PERIODIC = 1 << 1,
	ALLEGRO_HAPTIC_CONSTANT = 1 << 2,
	ALLEGRO_HAPTIC_SPRING = 1 << 3,
	ALLEGRO_HAPTIC_FRICTION = 1 << 4,
	ALLEGRO_HAPTIC_DAMPER = 1 << 5,
	ALLEGRO_HAPTIC_INERTIA = 1 << 6,
	ALLEGRO_HAPTIC_RAMP = 1 << 7,
	ALLEGRO_HAPTIC_SQUARE = 1 << 8,
	ALLEGRO_HAPTIC_TRIANGLE = 1 << 9,
	ALLEGRO_HAPTIC_SINE = 1 << 10,
	ALLEGRO_HAPTIC_SAW_UP = 1 << 11,
	ALLEGRO_HAPTIC_SAW_DOWN = 1 << 12,
	ALLEGRO_HAPTIC_CUSTOM = 1 << 13,
	ALLEGRO_HAPTIC_GAIN = 1 << 14,
	ALLEGRO_HAPTIC_ANGLE = 1 << 15,
	ALLEGRO_HAPTIC_RADIUS = 1 << 16,
	ALLEGRO_HAPTIC_AZIMUTH = 1 << 17,
	ALLEGRO_HAPTIC_AUTOCENTER = 1 << 18,
}

struct ALLEGRO_HAPTIC {}

struct ALLEGRO_HAPTIC_DIRECTION
{
	double angle;
	double radius;
	double azimuth;
}

struct ALLEGRO_HAPTIC_REPLAY
{
	double length;
	double delay;
}

struct ALLEGRO_HAPTIC_ENVELOPE
{
	double attack_length;
	double attack_level;
	double fade_length;
	double fade_level;
}

struct ALLEGRO_HAPTIC_CONSTANT_EFFECT
{
	double level;
	ALLEGRO_HAPTIC_ENVELOPE envelope;
}

struct ALLEGRO_HAPTIC_RAMP_EFFECT
{
	double start_level;
	double end_level;
	ALLEGRO_HAPTIC_ENVELOPE envelope;
}

struct ALLEGRO_HAPTIC_CONDITION_EFFECT
{
	double right_saturation;
	double left_saturation;
	double right_coeff;
	double left_coeff;
	double deadband;
	double center;
}

struct ALLEGRO_HAPTIC_PERIODIC_EFFECT
{
	int waveform;
	double period;
	double magnitude;
	double offset;
	double phase;

	ALLEGRO_HAPTIC_ENVELOPE envelope;
	int custom_len;
	double *custom_data;
}

struct ALLEGRO_HAPTIC_RUMBLE_EFFECT
{
	double strong_magnitude;
	double weak_magnitude;
}

union ALLEGRO_HAPTIC_EFFECT_UNION
{
	ALLEGRO_HAPTIC_CONSTANT_EFFECT constant;
	ALLEGRO_HAPTIC_RAMP_EFFECT ramp;
	ALLEGRO_HAPTIC_PERIODIC_EFFECT periodic;
	ALLEGRO_HAPTIC_CONDITION_EFFECT condition;
	ALLEGRO_HAPTIC_RUMBLE_EFFECT rumble;
}

struct ALLEGRO_HAPTIC_EFFECT
{
	int type;
	ALLEGRO_HAPTIC_DIRECTION direction;
	ALLEGRO_HAPTIC_REPLAY replay;
	ALLEGRO_HAPTIC_EFFECT_UNION data;
}

struct ALLEGRO_HAPTIC_EFFECT_ID
{
	ALLEGRO_HAPTIC* _haptic;
	int _id;
	int _handle;
	void* _pointer;
	double _effect_duration;
	bool _playing;
	double _start_time;
	double _end_time;
	void* driver;
}

nothrow @nogc extern(C)
{
   bool al_install_haptic();
   void al_uninstall_haptic();
   bool al_is_haptic_installed();

   bool al_is_mouse_haptic(ALLEGRO_MOUSE*);
   bool al_is_joystick_haptic(ALLEGRO_JOYSTICK*);
   bool al_is_keyboard_haptic(ALLEGRO_KEYBOARD*);
   bool al_is_display_haptic(ALLEGRO_DISPLAY*);
   bool al_is_touch_input_haptic(ALLEGRO_TOUCH_INPUT*);

   ALLEGRO_HAPTIC*  al_get_haptic_from_mouse(ALLEGRO_MOUSE*);
   ALLEGRO_HAPTIC*  al_get_haptic_from_joystick(ALLEGRO_JOYSTICK*);
   ALLEGRO_HAPTIC*  al_get_haptic_from_keyboard(ALLEGRO_KEYBOARD*);
   ALLEGRO_HAPTIC*  al_get_haptic_from_display(ALLEGRO_DISPLAY*);
   ALLEGRO_HAPTIC*  al_get_haptic_from_touch_input(ALLEGRO_TOUCH_INPUT*);

   bool al_release_haptic(ALLEGRO_HAPTIC*);

   bool al_is_haptic_active(ALLEGRO_HAPTIC*);
   int al_get_haptic_capabilities(ALLEGRO_HAPTIC*);
   bool al_is_haptic_capable(ALLEGRO_HAPTIC*, int);

   bool al_set_haptic_gain(ALLEGRO_HAPTIC*, double gain);
   double al_get_haptic_gain(ALLEGRO_HAPTIC*);

   int al_get_max_haptic_effects(ALLEGRO_HAPTIC*);
   bool al_is_haptic_effect_ok(ALLEGRO_HAPTIC*, ALLEGRO_HAPTIC_EFFECT*);
   bool al_upload_haptic_effect(ALLEGRO_HAPTIC*, ALLEGRO_HAPTIC_EFFECT*, ALLEGRO_HAPTIC_EFFECT_ID* play_id);
   bool al_play_haptic_effect(ALLEGRO_HAPTIC_EFFECT_ID*, int loop);
   bool al_upload_and_play_haptic_effect(ALLEGRO_HAPTIC*, ALLEGRO_HAPTIC_EFFECT*, int loop, ALLEGRO_HAPTIC_EFFECT_ID* play_id);
   bool al_stop_haptic_effect(ALLEGRO_HAPTIC_EFFECT_ID*);
   bool al_is_haptic_effect_playing(ALLEGRO_HAPTIC_EFFECT_ID*);
   bool al_release_haptic_effect(ALLEGRO_HAPTIC_EFFECT_ID*);
   double al_get_haptic_effect_duration(ALLEGRO_HAPTIC_EFFECT *);
   bool al_rumble_haptic(ALLEGRO_HAPTIC*, double intensity, double duration, ALLEGRO_HAPTIC_EFFECT_ID*);
}
