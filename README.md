# grad-herding

Really basic herding behaviour for Arma3 (wip)

* spawn herd
* attach to shepherd
* herd will move where shepherd moves
* will move on its own when shepherd dies
* will run away from fire when fired near (up to 50m close gunshots registered as of firedNear EH)

Sample Call:

`[position player, player, 15, "Sheep_random_F"] call GRAD_herding_fnc_create;`
