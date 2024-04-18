params ["_shepherd", "_leadAnimal", "_animal"];

private _wp = [0,0,0];

if (_leadAnimal == _animal) then {
	// get new wp in 20° angle in front of shepherd
	_wp = _shepherd getRelPos [GRAD_HERDING_DISTANCE_TO_SHEPHERD, (random 10 - random 20)];

	diag_log format ["getting new wp from shepherd %1, %2", _shepherd, _wp];
} else {

	private _relPosInHerd = _leadAnimal getVariable ["GRAD_herdings_relPosInHerd", [0,0,0]];
	_wp = _leadAnimal getRelPos _relPosInHerd;
	
	diag_log format ["getting new wp from leadanimal %1, %2", _leadAnimal, _relPosInHerd];
};

_wp