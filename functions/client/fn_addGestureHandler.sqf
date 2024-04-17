["ace_common_playActionNow", {
	params ["_unit", "_anim"];

	if (_anim isEqualTo "ace_gestures_point") then {
		private _target = screenToWorld [0.5, 0.5];
		_unit setVariable ["GRAD_HERDING_TARGET", _target, true];
	};

	if (_anim isEqualTo "ace_gestures_regroup") then {
		private _target = position _unit;
		_unit setVariable ["GRAD_HERDING_TARGET", _target, true];
	};

}] call CBA_fnc_addEventHandler;