params ["_unit"];

_unit playMoveNow "Acts_listeningToRadio_Loop";

_unit setVariable ["grad_herding_phoneCount", 0, true];

_unit addEventHandler ["AnimDone", {
		params ["_unit", "_anim"];

		private _phoneCount = _unit getVariable ["grad_herding_phoneCount", 0];
		_unit setVariable ["grad_herding_phoneCount", _phoneCount + 1, true];

		private _grad_herding_shouts = [
			"grad_herding_shout_1",
			"grad_herding_shout_2",
			"grad_herding_shout_3",
			"grad_herding_shout_4",
			"grad_herding_shout_5",
			"grad_herding_shout_6",
			"grad_herding_shout_7",
			"grad_herding_shout_8",
			"grad_herding_shout_9",
			"grad_herding_shout_10",
			"grad_herding_shout_11",
			"grad_herding_shout_12"
		];

		if (!alive _unit || (_unit getVariable ["grad_herding_phoneCount", 0] > 6)) exitWith {
			_unit removeAllEventHandlers "AnimDone";
		};

		if (!(_unit getVariable ["ACE_isUnconscious", false])) then {
			_unit playMoveNow "Acts_listeningToRadio_Loop";
			[_unit, [selectRandom _grad_herding_shouts, 200]] remoteExec ["say3D",0,false];
		};
}];