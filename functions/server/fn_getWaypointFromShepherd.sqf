params ["_shepherd"];

// get new wp in 20° angle in front of shepherd
private _wp = _shepherd getRelPos [GRAD_HERDING_DISTANCE_TO_SHEPHERD, (random 10 - random 20)];

_wp