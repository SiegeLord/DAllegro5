#!/bin/sh

dmd -lib -oflibdallegro5.a -release allegro5/*.d allegro5/internal/*.d $@
