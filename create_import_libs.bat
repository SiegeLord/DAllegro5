rem This batch file creates import dlls in the current folder and strips the version number
rem because OPTLINK sucks.

@echo off
for %%a in (*.dll) do (
	for /f "tokens=1 delims=-" %%i in ("%%~DPNa") do (
		implib /s %%i %%~DPNa.dll
	)
)
