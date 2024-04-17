params ["_barrel", "_ural"];


_barrel disableCollisionWith _ural;

private _dir = vectorDir _barrel;
private _up = vectorUp _barrel;

// diag_log format ["attachposi %1 - %2, %3, %4", typeOf _barrel, _barrel worldToModel (position _ural), _dir, _up ];

_barrel attachTo [_ural]; 

_barrel setVectorDir _dir;
_barrel setVectorUp _up;