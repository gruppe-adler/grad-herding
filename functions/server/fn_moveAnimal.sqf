params ["_animal", "_distance", "_targetPos"];

if (_distance > 4) then {
	[_animal, 1.5] remoteExec ["setAnimSpeedCoef"];
	_animal playMoveNow GRAD_HERDING_ANIM_RUN;
} else {
	if (_distance > 2) then {
		[_animal, 1] remoteExec ["setAnimSpeedCoef"];
		_animal playMoveNow GRAD_HERDING_ANIM_WALK;
	} else {
		[_animal, 1] remoteExec ["setAnimSpeedCoef"];
		_animal playMoveNow GRAD_HERDING_ANIM_IDLE;
	};
};


_animal moveTo _targetPos;
_animal doFollow _animal;

private _pointer = "Sign_Pointer_Pink_F" createVehicle (getPos _animal);

[{
	params ["_pointer"];
	 deleteVehicle _pointer;
}, [_pointer], 2] call CBA_fnc_waitAndExecute;

private _pointer = "Sign_Pointer_F" createVehicle _targetPos;

[{
	params ["_pointer"];
	 deleteVehicle _pointer;
}, [_pointer], 2] call CBA_fnc_waitAndExecute;