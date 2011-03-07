@echo off
dir /s /b allegro5\*.d > module_list
dmd -lib -release -oflibdallegro5.lib @module_list
del module_list
