["ace_common_playActionNow", {
	params ["_unit", "_anim"];

	// units might become shepherd later in game, thats why eh runs on all clients
	if (_unit getVariable ["GRAD_HERDING_SHEPHERD", false]) then {
		if (_anim isEqualTo "ace_gestures_point") then {
			private _target = screenToWorld [0.5, 0.5];
			if (_target distance _unit < 1000) then {
				_unit setVariable ["GRAD_HERDING_TARGET", _target, true];
				[_unit, [selectRandom ["whistle3", "whistle4"]], 80] remoteExec ["say3D"];
			} else {
				"Too far away" call CBA_fnc_notify;
			};
		};

		if (_anim isEqualTo "ace_gestures_regroup") then {
			private _target = position _unit;
			_unit setVariable ["GRAD_HERDING_TARGET", _target, true];
			[_unit, [selectRandom ["whistle1", "whistle2"]], 80] remoteExec ["say3D"];
		};
	};

}] call CBA_fnc_addEventHandler;

call grad_herding_fnc_setFPS; // loops and determines best performing client to put sheeps on, dedicated has engine bug with animals moveTo
