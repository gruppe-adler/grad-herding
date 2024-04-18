params ["_animal", "_indexOfHerd"];

private _string = format ["GRAD_herding_instance_%1", _indexOfHerd];
private _herd = missionNamespace getVariable [_instanceString, []];
_herd params ["_shepherd", "_leadanimal", "_animalArrayLiving", "_animalArrayDead"];

_animalArrayLiving deleteAt (_animalArrayLiving find _animal);
_animalArrayDead pushBack _animal;

_herd set [2, _animalArrayLiving];
_herd set [3, _animalArrayDead];

missionNamespace setVariable [_instanceString, _herd];

diag_log format ["GRAD HERDING: removing %1 from array living, adding to dead", _animal];