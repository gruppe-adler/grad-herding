params ["_animal"];

if (random 2 > 1.7) then {
	[_animal, [selectRandom GRAD_SAY_SOUNDS, 70]] remoteExec ["say3D",0,false];
} else {
	[_animal, [selectRandom GRAD_BELL_SOUNDS, 200]] remoteExec ["say3D",0,false];
};