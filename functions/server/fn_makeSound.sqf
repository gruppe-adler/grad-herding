params ["_animal"];

[_animal, [selectRandom GRAD_HERDING_SOUNDS, 120]] remoteExec ["say3D",0,false];