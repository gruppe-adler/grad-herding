[{
	params ["_args", "_handle"];
	
	(missionNameSpace getVariable ["GRAD_HERDING_MAXFPS", [0, -1]]) params ["_maxFPS", "_ownerID"];
	private _ownFPS = diag_fps;

	if (_ownFPS > _maxFPS) then {
		missionNameSpace setVariable ["GRAD_HERDING_MAXFPS", [_ownFPS, clientOwner]];
	};

}, [], 5] call CBA_fnc_addPerFrameHandler;