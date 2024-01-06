static 
	PlayerText:TDEditor_PTD[MAX_PLAYERS][12];


#include <YSI_Coding\y_hooks>
hook OnPlayerConnect(playerid)
{
	TDEditor_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 636.348510, 351.633392, "box");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][0], 0.000000, 9.016104);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][0], 553.299926, 0.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][0], 255);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][0], 0);

	TDEditor_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 577.504028, 311.333282, "_"); // Preview model
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][1], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][1], 74.000000, 72.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][1], 0);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][1], 5);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][1], 0);
	PlayerTextDrawSetPreviewModel(playerid, TDEditor_PTD[playerid][1], 400);
	PlayerTextDrawSetPreviewRot(playerid, TDEditor_PTD[playerid][1], 360.000000, 0.000000, 333.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, TDEditor_PTD[playerid][1], 1, 1);

	TDEditor_PTD[playerid][2] = CreatePlayerTextDraw(playerid, 629.796691, 327.666900, "_"); // Modelo do veiculo
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][2], 0.198066, 1.109998);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][2], 688.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][2], 3);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][2], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][2], 1);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][2], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][2], 0);

	TDEditor_PTD[playerid][3] = CreatePlayerTextDraw(playerid, 560.337341, 372.282714, "-");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][3], 5.000000, 0.300000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][3], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][3], 0);

	TDEditor_PTD[playerid][4] = CreatePlayerTextDraw(playerid, 598.168029, 371.850158, "_"); // Velocidade
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][4], 0.300369, 2.300000);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][4], 782.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][4], 3);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][4], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][4], 1);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][4], 1);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][4], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][4], 2);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][4], 0);

	TDEditor_PTD[playerid][5] = CreatePlayerTextDraw(playerid, 600.473754, 381.682647, "km/h");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][5], 0.180261, 1.004999);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][5], 695.699340, 0.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][5], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][5], 1);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][5], 1);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][5], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][5], 2);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][5], 0);

	TDEditor_PTD[playerid][6] = CreatePlayerTextDraw(playerid, 564.591674, 361.733428, "motor: ~g~off"); // status do motor
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][6], 0.180262, 1.004999);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][6], 654.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][6], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][6], 1);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][6], 1);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][6], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][6], 2);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][6], 0);

	TDEditor_PTD[playerid][7] = CreatePlayerTextDraw(playerid, 566.984130, 406.447753, "farois: ~g~off"); // status dos farois
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][7], 0.180262, 1.004999);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][7], 655.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][7], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][7], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][7], 1);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][7], 1);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][7], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][7], 2);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][7], 0);

	TDEditor_PTD[playerid][8] = CreatePlayerTextDraw(playerid, 561.742797, 403.782867, "-");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][8], 5.000000, 0.300000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][8], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][8], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][8], 0);

	TDEditor_PTD[playerid][9] = CreatePlayerTextDraw(playerid, 630.496337, 423.531341, "combustivel: 000/000"); // combustivel
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][9], 0.139501, 0.876666);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][9], 713.450622, 0.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][9], 3);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][9], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][9], 1);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][9], 1);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][9], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][9], 2);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][9], 0);

	TDEditor_PTD[playerid][10] = CreatePlayerTextDraw(playerid, 598.101318, 393.333343, "0");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][10], 0.191000, 1.010831);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][10], 3);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][10], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][10], 2);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][10], 0);

	TDEditor_PTD[playerid][11] = CreatePlayerTextDraw(playerid, 600.599365, 393.166748, "KM");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][11], 0.233499, 1.028333);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][11], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][11], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][11], 2);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][11], 0);

}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER){
		call::TD->ShowPlayerVelocimetro(playerid);
	}
	else if(oldstate == PLAYER_STATE_DRIVER){
		call::TD->HidePlayerVelocimetro(playerid);
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}
 // FUNCTIONS

function TD::ShowPlayerVelocimetro(playerid)
{
	new str[25], vehicleid = GetPlayerVehicleID(playerid), model = GetVehicleModel(vehicleid);
	
	if ( IsBike(model) )
		return false;

	format(str, sizeof(str), "%d", GetVehicleSpeed(vehicleid, false));
	PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][4], str);

	format(str, sizeof(str), "combustivel: %03d/%03d", floatround(call::VH->GetVehicleFuel(vehicleid)), GetVehicleMaxFuel(model) );
	PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][9], str);

	new color1, color2;
	GetVehicleColor(vehicleid, color1, color2);   
	PlayerTextDrawSetPreviewModel(playerid, TDEditor_PTD[playerid][1], model);
	PlayerTextDrawSetPreviewVehCol(playerid, TDEditor_PTD[playerid][1], color1, color2);

	format(str, sizeof(str), "%s", GetVehicleName(vehicleid));
	PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][2], str);

	format(str, sizeof(str), "%d", (floatround(GetDistanceTraveled(vehicleid)) / 1000));
	PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][10], str);

	PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][6], (GetVehicleParams(vehicleid, VEHICLE_TYPE_ENGINE) == VEHICLE_PARAMS_ON ? ("motor: ~g~on"):("motor: ~r~off") ) );
	PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][7], (GetVehicleParams(vehicleid, VEHICLE_TYPE_LIGHTS) == VEHICLE_PARAMS_ON ? ("farois: ~g~on"):("farois: ~r~off") ) );
	
	for(new i; i < sizeof(TDEditor_PTD[]); i++){
		PlayerTextDrawShow(playerid, TDEditor_PTD[playerid][i]);
	}
	return true;
}

function TD::HidePlayerVelocimetro(playerid)
{
	for(new i; i < sizeof(TDEditor_PTD[]); i++){
		PlayerTextDrawHide(playerid, TDEditor_PTD[playerid][i]);
	}
	return true;
}

function TD::UpdatePlayerVelocimetro(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid))
		return false;

	new vehicleid = GetPlayerVehicleID(playerid);
	if(GetVehicleParams(vehicleid, VEHICLE_TYPE_ENGINE) == VEHICLE_PARAMS_ON)
	{
		new str[25];
		format(str, sizeof(str), "%d", GetVehicleSpeed(vehicleid, false));
		PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][4], str);

		format(str, sizeof(str), "combustivel: %03d/%03d", floatround(call::VH->GetVehicleFuel(vehicleid)), GetVehicleMaxFuel(GetVehicleModel(vehicleid)));
		PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][9], str);

		format(str, sizeof(str), "%d", (floatround(GetDistanceTraveled(vehicleid)) / 1000));
		PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][10], str);
		
		return true;
	}
	return false;
}