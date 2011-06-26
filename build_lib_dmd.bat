@echo off
dir /s /b allegro5\*.d > module_list
dmd -lib -release -ofdallegro5.lib %* @module_list
del module_list
