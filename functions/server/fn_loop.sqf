params ["_index"];


[{
	params ["_args", "_handle"];

	_args params ["_index"];

	// save herd index to make it globally und publicly accessible 
	private _instanceString = format ["GRAD_herding_instance_%1", _index];
	private _herd = missionNamespace getVariable [_instanceString, []];
	_herd params ["_leadanimal", "_shepherd", "_animalArrayLiving", "_animalArrayDead"];

	// _herdArray = [_leadanimal, _shepherd, [_animal1, _animal2,...]]

	// stop loop if all animals are dead
	if (count _animalArrayLiving isEqualTo 0) exitWith {
			[_handle] call CBA_fnc_removePerFrameHandler;
			diag_log format ["herd %1 is dead, ending loop", _index];
	};

	// change lead animal if necessary
	if (!alive _leadAnimal) then {
			private _newLeader = selectRandom _animalArrayLiving;
			_herd set [0, _newLeader];
			missionNamespace setVariable [_instanceString, _herd, true];
	};


	// target wp
	private _targetPos = [0,0,0];
	private _panicState = format ["GRAD_herding_instance_%2_panicState", _index];
	private _herdInPanic = missionNamespace getVariable [_panicState, false];

	// handle things differently depending on state of panic / shepherd
	if (_herdInPanic) then {
			_targetPos = [_animal] call GRAD_herding_fnc_getWaypointInPanic;
	} else {
			if (alive _shepherd) then {
				_targetPos = [_shepherd] call GRAD_herding_fnc_getWaypointFromShepherd;
			} else {
				_targetPos = [_shepherd] call GRAD_herding_fnc_getRandomWaypoint;
			};
	};

	private _count = count _animalArrayLiving + [_leadanimal];
	// animations and move command
	private _distance = _x distance _targetPos;
	{
		if (!alive _animal) exitWith {
				[_animal, _index] call GRAD_herding_fnc_removeAnimalFromHerd;
		};

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

	 	_x moveTo _targetPos;	// go to shepherd

	 	if (random _count > _count - _count/10) then {
	 			[_x] call GRAD_herding_fnc_makeSound;
	 	};
	} forEach _animalArrayLiving + [_leadanimal];


}, 2, [_index]] call CBA_fnc_addPerFrameHandler;