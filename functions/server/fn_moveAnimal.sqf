params ["_animal", "_distance", "_targetPos"];

if (_distance > 4) then {
	[_x, 1.5] remoteExec ["setAnimSpeedCoef"];
	_x playMoveNow GRAD_HERDING_ANIM_RUN;
} else {
	if (_distance > 2) then {
		[_x, 1] remoteExec ["setAnimSpeedCoef"];
		_x playMoveNow GRAD_HERDING_ANIM_WALK;
	} else {
		[_x, 1] remoteExec ["setAnimSpeedCoef"];
		_x playMoveNow GRAD_HERDING_ANIM_IDLE;
	};
};

_x moveTo _targetPos;