module allegro5.internal.events;

nothrow @nogc extern (C)
{
   struct ALLEGRO_USER_EVENT {};
   struct ALLEGRO_USER_EVENT_DESCRIPTOR
   {
      void function(ALLEGRO_USER_EVENT *event) dtor;
      int refcount;
   };
}
