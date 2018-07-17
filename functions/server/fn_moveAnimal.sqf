params ["_animal", "_distance", "_targetPos"];

if (_distance > 4) then {
	_x setAnimSpeedCoef 1.5;
	_x playMove GRAD_HERDING_ANIM_RUN;
} else {
	if (_distance > 2) then {
		_x setAnimSpeedCoef 1;
		_x playMove GRAD_HERDING_ANIM_WALK;
	} else {
		_x setAnimSpeedCoef 1;
		_x playMove GRAD_HERDING_ANIM_IDLE;
	};
};

_x moveTo _targetPos;