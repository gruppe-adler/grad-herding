params ["_spawnPosition", ["_count",10], ["_shepherd", objNull], ["_animalType", "Goat_random_F"]];

private _herdArray = [_shepherd, objNull, [], []];
private _herdAnimals = [];

for "_i" from 1 to _count do {

		// Spawn animal
		_animal = createAgent [_animalType, _spawnPosition, [], 0, "NONE"];

		// Disable animal behaviour
		_animal setVariable ["BIS_fnc_animalBehaviour_disable", true];

		// Declare first animal to leader of flock
		if (_forEachIndex isEqualTo 1) then {
				_animal setDir (random 360);
				_herd set [1, _animal];

				[_animal] call GRAD_herding_fnc_addEventhandler;
		} else {
				_animal setDir (_animal getRelDir (_herd select 1));
						
				// Add animal to animal list
				_herdAnimals pushBack _animal;
		};
};

// fill herd with animal array
_herd set [2, _herdAnimals];


// get amount of herds created and add to counter
private _currentIndex = (missionNamespace getVariable ["GRAD_herding_instanceCount", -1] + 1);
missionNamespace setVariable ["GRAD_herding_instanceCount", _currentIndex, true];

// save herd index to make it globally und publicly accessible 
private _instanceString = format ["GRAD_herding_instance_%1", _currentIndex];
missionNamespace setVariable [_instanceString, _herd, true];

[_currentIndex] call GRAD_herd_fnc_loop;

_herd