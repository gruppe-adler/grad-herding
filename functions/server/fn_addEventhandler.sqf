/*

	only on lead animal, used to determine nearby threats

*/

params ["_animal", "_index"];

diag_log format ["adding EH for %1", _index];

// reset everything to zero
_animal setVariable ["GRAD_herding_index", _index];

private _panicState = format ["GRAD_herding_instance_%2_panicState", _index];
missionNamespace setVariable [_panicState, false, true];

_animal addEventhandler ["FiredNear", {
		params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];

		private _index = _unit getVariable ["GRAD_herding_index", 0];
		private _panicPosVar = format ["GRAD_herding_instance_%1_panicPos", _index];
		private _panicState = format ["GRAD_herding_instance_%2_panicState", _index];
		
		// save panic position to missionnamespace
		missionNamespace setVariable [_panicPosVar, position _firer, true];
		missionNamespace setVariable [_panicState, true, true];
	
		// delay next reaction for some seconds to prevent spam when bullets are flying
		[{
			params ["_animal"];

			[_animal] call GRAD_herding_fnc_addEventhandler;

		}, [_animal], 30] call CBA_fnc_waitAndExecute;

		_animal removeAllEventHandlers "FiredNear";
}];