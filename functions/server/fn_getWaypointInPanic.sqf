params ["_animal", "_index"];

private _instanceString = format ["GRAD_herding_instance_%1_panicPos", _index];
private _panicPos = missionNamespace getVariable [_instanceString, [0,0,0]];

private _oppositeDirection = (_animal getRelDir _panicPos) - 180 + (random 5 - random 10);

private _wp = _animal getRelPos [GRAD_HERDING_DISTANCE_TO_SHEPHERD * 10, _oppositeDirection];

diag_log format ["getting new wp in panic %1", _wp];

_wp