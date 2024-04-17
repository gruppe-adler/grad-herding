params ["_unit", "_vehicle"];

_unit playmovenow "acex_sitting_HubSittingChairC_move1"; _unit attachTo [_vehicle, [0,-2,0]];
_unit setVectorDirAndUp [ 
 [ sin 180 * cos 0,cos 180 * cos 0,sin 0], 
 [ [ sin 0,-sin 0,cos 0 * cos 0],-0] call BIS_fnc_rotateVector2D 
]; _unit addEventhandler ["AnimDone", { (_this select 0) playmovenow "acex_sitting_HubSittingChairC_move1"; }];