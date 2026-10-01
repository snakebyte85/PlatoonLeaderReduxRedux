#include "\a3\editor_f\Data\Scripts\dikCodes.h"

[
	_versionName,
	"Select HC Group", 
	"Selects the HC-Group of the Unit the player aims at", 
	{_this spawn KMD_fnc_selectGroup}, 
	"", 
	[DIK_T, [false, false, false]]

] call CBA_fnc_addKeybind;

[
	_versionName,
	"hcSquadIn_key", 
	"Remote View Leader of HC Group", 
	{_this spawn KMD_fnc_spawnCam}, 
	"", 
	[DIK_HOME, [false, false, false]]

] call CBA_fnc_addKeybind;

[
	_versionName,
	"hcSquadOut_key", 
	"Release Remote View", 
	{_this spawn KMD_fnc_remoteCameraOut}, 
	"", 
	[DIK_END, [false, false, false]]

] call CBA_fnc_addKeybind;