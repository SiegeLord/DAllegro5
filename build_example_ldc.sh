#!/bin/sh

ldc -release -of example example.d -L -lallegro_primitives -L -lallegro_ttf -L -lallegro_font -L -lallegro -L -lallegro_image -I. -L -L. -L -ldallegro5
