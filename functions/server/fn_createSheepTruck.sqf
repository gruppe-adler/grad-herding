params ["_position"];

private _vehicle = createVehicle ["rhsgref_ins_g_gaz66o_flat", _position];
private _unit = (createGroup civilian) createUnit ["C_Man_1", [0,0,0], [], 0, "NONE"];

[_unit, false] call GRAD_civPartisans_fnc_equip;
_unit assignAsDriver _vehicle;
_unit moveInDriver _vehicle;

[
	_vehicle,
	["rhs_sand",1], 
	["light_hide",1,"bench_hide",1,"cover_hide",1,"spare_hide",0,"rear_numplate_hide",1]
] call BIS_fnc_initVehicle;

[_vehicle] spawn { 
		params ["_vehicle"];

		private _offsetY = -0.25; 
		private _offsetZ = -0.55; 
		 
		private _positions = [ 
		 [-0.75, -0.1+_offsetY, 0+_offsetZ], 
		 [-0.25, -0.1+_offsetY, 0+_offsetZ], 
		 [0.25, -0.1+_offsetY, 0+_offsetZ], 
		 [0.75, -0.1+_offsetY, 0+_offsetZ], 
		 
		 [-0.5, -1+_offsetY, 0+_offsetZ], 
		 [0, -1+_offsetY, 0+_offsetZ], 
		 [0.5, -1+_offsetY, 0+_offsetZ], 
		 
		 [-0.75, -1.8+_offsetY, 0+_offsetZ], 
		 [-0.25, -1.8+_offsetY, 0+_offsetZ], 
		 [0.25, -1.8+_offsetY, 0+_offsetZ], 
		 [0.75, -1.8+_offsetY, 0+_offsetZ]	 
		  
		]; 
		 
		for "_i" from 0 to 10 do { 
		 
		  // Spawn animal 
		  private _animal = createAgent ["Sheep_random_F", [0,0,0], [], 0, "NONE"]; 
		  _animal playmovenow "Sheep_Idle_Stop";  
		  _animal addEventHandler ["AnimDone", { 
		   params ["_animal"]; 
		   if (!alive _animal) exitWith { _animal removeAllEventHandlers "AnimDone"; }; 
		   _animal playmovenow "Sheep_Idle_Stop";  
		  }]; 
		 
		  // Disable animal behaviour 
		  _animal setVariable ["BIS_fnc_animalBehaviour_disable", true]; 
		  _animal disableAI "FSM"; 
		  _animal disableAI "MOVE"; 
		  doStop _animal; 
		  // _animal disableAI "ANIM"; 
		  _animal setBehaviour "CARELESS"; 
		  _animal setCombatMode "RED"; 
		  // _animal setSkill 0; 
		 
		  _animal attachTo [_vehicle, _positions select _i]; 
		  sleep random 1; 
		}; 
};