
/*
*			@title 		HUD
*			@author: 	NelsonC.
*			@date: 		12/04/2021
*
*/


/*
*
*			Hooks included
*
*/
#include <YSI_Coding\y_hooks>

/*
*
*			variaveis
*
*/

static Text:TD@VELO[3], PlayerText:TDP@VELO[MAX_PLAYERS][9];
new Timer@UPCARINFO[MAX_PLAYERS];


hook OnGameModeInit()
{
	TD@VELO[0] = TextDrawCreate(182.000000, 358.859100, "KM/H");
	TextDrawLetterSize(TD@VELO[0], 0.347999, 1.661599);
	TextDrawAlignment(TD@VELO[0], 1);
	TextDrawColor(TD@VELO[0], -1);
	TextDrawSetShadow(TD@VELO[0], 0);
	TextDrawSetOutline(TD@VELO[0], 0);
	TextDrawBackgroundColor(TD@VELO[0], 255);
	TextDrawFont(TD@VELO[0], 2);
	TextDrawSetProportional(TD@VELO[0], 1);
	TextDrawSetShadow(TD@VELO[0], 0);

	TD@VELO[1] = TextDrawCreate(139.000000, 349.159393, "-");
	TextDrawLetterSize(TD@VELO[1], 6.030499, 1.051200);
	TextDrawAlignment(TD@VELO[1], 1);
	TextDrawColor(TD@VELO[1], 512819199);
	TextDrawSetShadow(TD@VELO[1], 0);
	TextDrawSetOutline(TD@VELO[1], 0);
	TextDrawBackgroundColor(TD@VELO[1], 255);
	TextDrawFont(TD@VELO[1], 1);
	TextDrawSetProportional(TD@VELO[1], 1);
	TextDrawSetShadow(TD@VELO[1], 0);

	TD@VELO[2] = TextDrawCreate(142.000152, 384.040161, "kilometros");
	TextDrawLetterSize(TD@VELO[2], 0.165500, 1.112800);
	TextDrawAlignment(TD@VELO[2], 1);
	TextDrawColor(TD@VELO[2], -2686721);
	TextDrawSetShadow(TD@VELO[2], 0);
	TextDrawSetOutline(TD@VELO[2], 1);
	TextDrawBackgroundColor(TD@VELO[2], 255);
	TextDrawFont(TD@VELO[2], 2);
	TextDrawSetProportional(TD@VELO[2], 1);
	TextDrawSetShadow(TD@VELO[2], 0);

	return 1;
}

hook OnPlayerConnect(playerid)
{
	TDP@VELO[playerid][0] = CreatePlayerTextDraw(playerid, 160.301818, 396.780303, "MOTOR");
	PlayerTextDrawLetterSize(playerid, TDP@VELO[playerid][0], 0.180000, 1.095999);
	PlayerTextDrawTextSize(playerid, TDP@VELO[playerid][0], 0.000000, 34.000000);
	PlayerTextDrawAlignment(playerid, TDP@VELO[playerid][0], 2);
	PlayerTextDrawColor(playerid, TDP@VELO[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, TDP@VELO[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, TDP@VELO[playerid][0], 255);
	PlayerTextDrawSetShadow(playerid, TDP@VELO[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, TDP@VELO[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, TDP@VELO[playerid][0], 255);
	PlayerTextDrawFont(playerid, TDP@VELO[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, TDP@VELO[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TDP@VELO[playerid][0], 0);

	TDP@VELO[playerid][1] = CreatePlayerTextDraw(playerid, 199.304199, 396.780303, "FAROL");
	PlayerTextDrawLetterSize(playerid, TDP@VELO[playerid][1], 0.180000, 1.095999);
	PlayerTextDrawTextSize(playerid, TDP@VELO[playerid][1], 0.000000, 34.000000);
	PlayerTextDrawAlignment(playerid, TDP@VELO[playerid][1], 2);
	PlayerTextDrawColor(playerid, TDP@VELO[playerid][1], -1);
	PlayerTextDrawUseBox(playerid, TDP@VELO[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, TDP@VELO[playerid][1], 255);
	PlayerTextDrawSetShadow(playerid, TDP@VELO[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, TDP@VELO[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, TDP@VELO[playerid][1], 255);
	PlayerTextDrawFont(playerid, TDP@VELO[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, TDP@VELO[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TDP@VELO[playerid][1], 0);

	TDP@VELO[playerid][2] = CreatePlayerTextDraw(playerid, 160.301818, 411.981231, "JANELAS");
	PlayerTextDrawLetterSize(playerid, TDP@VELO[playerid][2], 0.180000, 1.095999);
	PlayerTextDrawTextSize(playerid, TDP@VELO[playerid][2], 0.000000, 34.000000);
	PlayerTextDrawAlignment(playerid, TDP@VELO[playerid][2], 2);
	PlayerTextDrawColor(playerid, TDP@VELO[playerid][2], -1);
	PlayerTextDrawUseBox(playerid, TDP@VELO[playerid][2], 1);
	PlayerTextDrawBoxColor(playerid, TDP@VELO[playerid][2], 255);
	PlayerTextDrawSetShadow(playerid, TDP@VELO[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, TDP@VELO[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, TDP@VELO[playerid][2], 255);
	PlayerTextDrawFont(playerid, TDP@VELO[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, TDP@VELO[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, TDP@VELO[playerid][2], 0);

	TDP@VELO[playerid][3] = CreatePlayerTextDraw(playerid, 199.504211, 411.981231, "PORTAS");
	PlayerTextDrawLetterSize(playerid, TDP@VELO[playerid][3], 0.180000, 1.095999);
	PlayerTextDrawTextSize(playerid, TDP@VELO[playerid][3], 0.000000, 34.000000);
	PlayerTextDrawAlignment(playerid, TDP@VELO[playerid][3], 2);
	PlayerTextDrawColor(playerid, TDP@VELO[playerid][3], -1);
	PlayerTextDrawUseBox(playerid, TDP@VELO[playerid][3], 1);
	PlayerTextDrawBoxColor(playerid, TDP@VELO[playerid][3], 255);
	PlayerTextDrawSetShadow(playerid, TDP@VELO[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, TDP@VELO[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, TDP@VELO[playerid][3], 255);
	PlayerTextDrawFont(playerid, TDP@VELO[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, TDP@VELO[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, TDP@VELO[playerid][3], 0);

	TDP@VELO[playerid][4] = CreatePlayerTextDraw(playerid, 159.500000, 353.759155, "100");
	PlayerTextDrawLetterSize(playerid, TDP@VELO[playerid][4], 0.398499, 2.568799);
	PlayerTextDrawAlignment(playerid, TDP@VELO[playerid][4], 2);
	PlayerTextDrawColor(playerid, TDP@VELO[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, TDP@VELO[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, TDP@VELO[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, TDP@VELO[playerid][4], 255);
	PlayerTextDrawFont(playerid, TDP@VELO[playerid][4], 2);
	PlayerTextDrawSetProportional(playerid, TDP@VELO[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, TDP@VELO[playerid][4], 0);

	TDP@VELO[playerid][5] = CreatePlayerTextDraw(playerid, 181.500000, 342.299377, "Sultan");
	PlayerTextDrawLetterSize(playerid, TDP@VELO[playerid][5], 0.197999, 1.146399);
	PlayerTextDrawAlignment(playerid, TDP@VELO[playerid][5], 2);
	PlayerTextDrawColor(playerid, TDP@VELO[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, TDP@VELO[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, TDP@VELO[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, TDP@VELO[playerid][5], 255);
	PlayerTextDrawFont(playerid, TDP@VELO[playerid][5], 2);
	PlayerTextDrawSetProportional(playerid, TDP@VELO[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, TDP@VELO[playerid][5], 0);

	TDP@VELO[playerid][6] = CreatePlayerTextDraw(playerid, 142.000152, 374.539581, "Gasolina");
	PlayerTextDrawLetterSize(playerid, TDP@VELO[playerid][6], 0.165500, 1.112800);
	PlayerTextDrawAlignment(playerid, TDP@VELO[playerid][6], 1);
	PlayerTextDrawColor(playerid, TDP@VELO[playerid][6], 579543807);
	PlayerTextDrawSetShadow(playerid, TDP@VELO[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, TDP@VELO[playerid][6], 1);
	PlayerTextDrawBackgroundColor(playerid, TDP@VELO[playerid][6], 255);
	PlayerTextDrawFont(playerid, TDP@VELO[playerid][6], 2);
	PlayerTextDrawSetProportional(playerid, TDP@VELO[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, TDP@VELO[playerid][6], 0);

	TDP@VELO[playerid][7] = CreatePlayerTextDraw(playerid, 218.904846, 374.539581, "900.00");
	PlayerTextDrawLetterSize(playerid, TDP@VELO[playerid][7], 0.165500, 1.112800);
	PlayerTextDrawAlignment(playerid, TDP@VELO[playerid][7], 3);
	PlayerTextDrawColor(playerid, TDP@VELO[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, TDP@VELO[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, TDP@VELO[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, TDP@VELO[playerid][7], 255);
	PlayerTextDrawFont(playerid, TDP@VELO[playerid][7], 2);
	PlayerTextDrawSetProportional(playerid, TDP@VELO[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, TDP@VELO[playerid][7], 0);

	TDP@VELO[playerid][8] = CreatePlayerTextDraw(playerid, 218.904846, 384.040161, "100.5");
	PlayerTextDrawLetterSize(playerid, TDP@VELO[playerid][8], 0.165500, 1.112800);
	PlayerTextDrawAlignment(playerid, TDP@VELO[playerid][8], 3);
	PlayerTextDrawColor(playerid, TDP@VELO[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, TDP@VELO[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, TDP@VELO[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, TDP@VELO[playerid][8], 255);
	PlayerTextDrawFont(playerid, TDP@VELO[playerid][8], 2);
	PlayerTextDrawSetProportional(playerid, TDP@VELO[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, TDP@VELO[playerid][8], 0);

	return 1;
}

stock function TD::ShowPlayerVelocimetro(playerid, action, tname[])
{
	// Mostrar
	if ( action ) {
		if(!strcmp(tname, "carinfo")) {
			for(new i = 0; i < 3; i++) { TextDrawShowForPlayer(playerid, TD@VELO[i]); }
			for(new i = 0; i < 9; i++) { PlayerTextDrawShow(playerid, TDP@VELO[playerid][i]); }

			Timer@UPCARINFO[playerid] = SetTimerEx( "UpdateCar@INFO", 100, 1, "d", playerid );
		}
	}
	// Esconder
	if( !action) {
		if(!strcmp(tname, "carinfo")) {
			for(new i = 0; i < 3; i++) { TextDrawHideForPlayer(playerid, TD@VELO[i]); }
			for(new i = 0; i < 9; i++) { PlayerTextDrawHide(playerid, TDP@VELO[playerid][i]); }
	
			KillTimer(Timer@UPCARINFO[playerid]);
		}
	}
}

forward UpdateCar@INFO(playerid);
public UpdateCar@INFO(playerid) 
{
	new _strvelo[256], vehicleid = GetPlayerVehicleID(playerid);
	if(!IsBike(GetPlayerVehicleID(playerid)))
	{
		format(_strvelo, sizeof(_strvelo), "%d", GetPlayerSpeed(playerid));
		PlayerTextDrawSetString(playerid, TDP@VELO[playerid][4], _strvelo);

		format(_strvelo, sizeof(_strvelo), "%s", carName[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
		PlayerTextDrawSetString(playerid, TDP@VELO[playerid][5], _strvelo);

		format(_strvelo, sizeof(_strvelo), "%03d", floatround(call::VH->GetVehicleFuel(vehicleid)));
		PlayerTextDrawSetString(playerid, TDP@VELO[playerid][7], _strvelo);

		format(_strvelo, sizeof(_strvelo), "%d", (floatround(GetDistanceTraveled(vehicleid)) / 1000));
		PlayerTextDrawSetString(playerid, TDP@VELO[playerid][8], _strvelo);

		new engine, lights, doors, alarm, bonnet, boot, objective;
		GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);

	    new driver, passenger, backleft, backright, window;
	    GetVehicleParamsCarWindows(GetPlayerVehicleID(playerid), driver, passenger, backleft, backright);
	    switch(GetPlayerVehicleSeat(playerid))
	    {
	        case 0:
	            window = driver;
	        case 1:
	            window = passenger;
	        case 2:
	            window = backleft;
	        default:
	            window = backright;
	    }

	    PlayerTextDrawBoxColor(playerid, TDP@VELO[playerid][0], (engine == VEHICLE_PARAMS_ON) ? 8388863 : -1523963137);
		PlayerTextDrawBoxColor(playerid, TDP@VELO[playerid][2], (!window) ? 8388863 : -1523963137);
		PlayerTextDrawBoxColor(playerid, TDP@VELO[playerid][1], (lights == VEHICLE_PARAMS_ON) ? 8388863 : -1523963137);
		PlayerTextDrawBoxColor(playerid, TDP@VELO[playerid][3], (doors == VEHICLE_PARAMS_ON) ? 8388863 : -1523963137);
		for(new i = 0; i < 4; i++) { PlayerTextDrawShow(playerid, TDP@VELO[playerid][i]); }
	}
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER)
        call::TD->ShowPlayerVelocimetro(playerid, 1, "carinfo");
    else if( (oldstate == PLAYER_STATE_DRIVER) && newstate == PLAYER_STATE_ONFOOT)
        call::TD->ShowPlayerVelocimetro(playerid, 0, "carinfo");
    return 1;
}