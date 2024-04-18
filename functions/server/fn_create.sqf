/*

	by nomisum for gruppe adler 2018


	[position player, 15, player, "Sheep_random_F"] call GRAD_herding_fnc_create;
*/



params ["_spawnPosition", ["_count",10], ["_shepherd", objNull], ["_animalType", "Goat_random_F"]];

if (isServer && isMultiplayer) exitWith {
	(missionNameSpace getVariable ["GRAD_HERDING_MAXFPS", [0,-1]]) params ["_maxFPS", "_client"];
	if (_client == -1) exitWith {
		diag_log "cant create sheep herd as no client known to spawn sheep on";
	};
	[_spawnPosition, _count, _shepherd, _animalType] remoteExec ["grad_herdings_fnc_create", _client];
};

_shepherd setVariable ["GRAD_HERDING_SHEPHERD", true, true];

private _herdArray = [_shepherd];
private _herdAnimals = [];

if (!isNull _shepherd) then {
	private _pole = "Land_Net_Fence_pole_F" createVehicle [0,0,0];
	_pole attachTo [_shepherd, [0,0,0], "RightHandMiddle1", true];
	_pole setObjectScale 0.5;
	_pole setVectorDirAndUp [[0,0.66,-0.33],[0,0.33,0.66]];
	_shepherd setVariable ["shepherdPole", _pole, true];

	_shepherd addEventHandler ["killed", {
		params ["_unit"];

		detach (_unit getVariable ["shepherdPole", objNull]);
	}];
};

// private _group = createGroup civilian;

for "_i" from 1 to _count do {

		// Spawn animal
		private _animal = createAgent [_animalType, _spawnPosition, [], 0, "NONE"];

		// Disable animal behaviour
		_animal setVariable ["BIS_fnc_animalBehaviour_disable", true];
		_animal disableAI "FSM";
		// _animal disableAI "MOVE";
		// _animal disableAI "ANIM";
		_animal setBehaviour "CARELESS";
		_animal setCombatMode "RED";
		// _animal setSkill 0;

		// Declare first animal to leader of flock
		if (_i isEqualTo 1) then {
				_animal setDir (random 360);
				_herdArray set [1, _animal];

				[_animal] call GRAD_herding_fnc_addEventhandler;
		} else {
				// animals are placed in increasing distance in array
				// this makes movement changes start from center of herd around leading sheep (i hope)
				private _relPosInHerd = [(_i-1) max random _i, random 360];
				_animal setVariable ["GRAD_herdings_relPosInHerd", _relPosInHerd, true];
				_animal setDir (_animal getRelDir (_herdArray select 1));
						
				// Add animal to animal list
				_herdAnimals pushBack _animal;
		};

		_animal addEventHandler ["Local", {
			params ["_entity", "_isLocal"];

			// find new client if simulation ends up on server (e.g. on disconnect)
			if (_isLocal && isServer && isMultiplayer) then {
				(missionNameSpace getVariable ["GRAD_HERDING_MAXFPS", [0,-1]]) params ["_maxFPS", "_client"];
				if (_client == -1) exitWith {
					diag_log "cant create sheep herd as no client known to move owner of sheep to";
				};
				_entity setOwner _client;
			};
		}];
};

// fill herd with animal array
_herdArray set [2, _herdAnimals];


// get amount of herds created and add to counter
private _currentIndex = (missionNamespace getVariable ["GRAD_herding_instanceCount", -1]) + 1;
missionNamespace setVariable ["GRAD_herding_instanceCount", _currentIndex, true];

// save herd index to make it globally und publicly accessible 
private _instanceString = format ["GRAD_herding_instance_%1", _currentIndex];
missionNamespace setVariable [_instanceString, _herdArray, true];

diag_log format ["_currentIndex %1, _instanceString %2", _currentIndex, _instanceString];

[_herdArray] spawn GRAD_herding_fnc_loop;

diag_log format ["created herd %1", _herdArray];

_herdArray