params ["_shepherd", "_leadAnimal", "_animal"];

private _relPosInHerd = _animal getVariable ["GRAD_herdings_relPosInHerd", [0,0,0]];
// get new wp in 90° angle in front of lead animal
private _wp = _leadAnimal getRelPos _relPosInHerd;

diag_log format ["getting new wp randomly from lead animal %1", _wp];

_wp