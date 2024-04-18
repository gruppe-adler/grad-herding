params ["_herdArray"];


[{
	params ["_args", "_handle"];

	_args params ["_herdArray"];

	_herdArray params ["_shepherd", "_leadAnimal", "_animalArrayLiving", ["_animalArrayDead", []]];

	// _herdArray = [_leadanimal, _shepherd, [_animal1, _animal2,...]]

	// stop loop if all animals are dead
	if (count _animalArrayLiving isEqualTo 0) exitWith {
			[_handle] call CBA_fnc_removePerFrameHandler;
			diag_log format ["herd %1 is dead, ending loop", _index];
			systemChat format ["herd %1 is dead, ending loop", _index];
	};

	// change lead animal if necessary
	if (!alive _leadAnimal) then {
			private _newLeader = selectRandom _animalArrayLiving;
			_herd set [0, _newLeader];
			missionNamespace setVariable [_instanceString, _herd, true];
			diag_log format ["lead animal %1 is dead, setting new leader %2", _leadAnimal, _newLeader];
			systemChat format ["lead animal %1 is dead, setting new leader %2", _leadAnimal, _newLeader];
	};

	systemChat format ["_animalArrayLiving %1", _animalArrayLiving];

	// target wp
	private _targetPos = [-1,-1,-1];
	private _panicState = format ["GRAD_herding_instance_%2_panicState", _index];
	private _herdInPanic = missionNamespace getVariable [_panicState, false];

	// handle things differently depending on state of panic / shepherd
	if (_herdInPanic) then {
			_targetPos = [_animal] call GRAD_herding_fnc_getWaypointInPanic;
	} else {
			if (alive _shepherd) then {
				_targetPos = [_shepherd, _leadAnimal, _animal] call GRAD_herding_fnc_getWaypointFromShepherd;
			} else {
				_targetPos = [_shepherd, _leadAnimal, _animal] call GRAD_herding_fnc_getRandomWaypoint;
			};
	};

	private _count = count (_animalArrayLiving + [_leadanimal]);
	// animations and move command
	{
		private _distance = _x distance _targetPos;
		if (!alive _animal) exitWith {
				[_animal, _index] call GRAD_herding_fnc_removeAnimalFromHerd;
		};

		// [{
		//	params ["_animal", "_distance", "_targetPos"];

			[_animal, _distance, _targetPos] call GRAD_herding_fnc_moveAnimal;

			systemChat format ["moving %1 to %2", _animal, _targetPos];

		// }, [_animal, _distance, _targetPos], random 1] call CBA_fnc_waitAndExecute;

	 	if (random _count > _count - _count/GRAD_HERDING_SOUND_PROBABILITY) then {
	 			[_x] call GRAD_herding_fnc_makeSound;
	 	};
	} forEach (_animalArrayLiving + [_leadanimal]);


}, 2, [_herdArray]] call CBA_fnc_addPerFrameHandler;