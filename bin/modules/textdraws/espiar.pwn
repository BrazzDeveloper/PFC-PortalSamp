

forward UpdateMonitoramentoStats(playerid, to_id);

static PlayerText:TDEditor_PTD[MAX_PLAYERS][3], espiar_td@timer[MAX_PLAYERS], _str[100];

hook OnPlayerConnect(playerid)
{
	for(new i; i < sizeof(TDEditor_PTD[]); i++)
	{
		TDEditor_PTD[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}
	espiar_td@timer[playerid] = -1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	for(new i; i < sizeof(TDEditor_PTD[]); i++)
	{
		PlayerTextDrawDestroy(playerid, TDEditor_PTD[playerid][i]);
		TDEditor_PTD[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}
	KillTimer(espiar_td@timer[playerid]);
	espiar_td@timer[playerid] = -1;
}

stock function TD::ShowPlayerMonitoramento(playerid, to_id)
{
	if ( TDEditor_PTD[playerid][0] == INVALID_PLAYER_TEXT_DRAW)
	{
		TDEditor_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 509.764556, 311.333374, "box");
		PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][0], 0.000000, 7.552943);
		PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][0], 630.000000, 0.000000);
		PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][0], 1);
		PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][0], -1);
		PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][0], 1);
		PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][0], 100);
		PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][0], 0);
		PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][0], 0);
		PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][0], 255);
		PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][0], 1);
		PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][0], 1);
		PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][0], 0);
	}

	if ( TDEditor_PTD[playerid][1] == INVALID_PLAYER_TEXT_DRAW)
	{

		TDEditor_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 569.740966, 311.316802, "Monitorando: _");
		PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][1], 0.192470, 1.238332);
		PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][1], 0.000000, 119.000000);
		PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][1], 2);
		PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][1], -1);
		PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][1], 1);
		PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][1], 255);
		PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][1], 0);
		PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][1], 0);
		PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][1], 255);
		PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][1], 2);
		PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][1], 1);
		PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][1], 0);
	}

	if ( TDEditor_PTD[playerid][2] == INVALID_PLAYER_TEXT_DRAW)
	{

		TDEditor_PTD[playerid][2] = CreatePlayerTextDraw(playerid, 510.005889, 340.000000, "Velocidade: _");
		PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][2], 0.130352, 1.022498);
		PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][2], 629.300170, 0.000000);
		PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][2], 1);
		PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][2], -1);
		PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][2], 1);
		PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][2], 0);
		PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][2], 0);
		PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][2], 0);
		PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][2], 255);
		PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][2], 2);
		PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][2], 1);
		PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][2], 0);
	}
	format(_str, sizeof(_str), "Monitorando: %s", GetUserName(to_id));
	PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][1], _str);

	PlayerTextDrawShow(playerid, TDEditor_PTD[playerid][0]);
	PlayerTextDrawShow(playerid, TDEditor_PTD[playerid][1]);
	PlayerTextDrawShow(playerid, TDEditor_PTD[playerid][2]);
	espiar_td@timer[playerid] = SetTimerEx("UpdateMonitoramentoStats", 1000, true, "dd", playerid, to_id);
	return true;
}

stock function TD::HidePlayerMonitoramento(playerid)
{
	for(new i; i < sizeof(TDEditor_PTD[]); i++)
	{
		PlayerTextDrawDestroy(playerid, TDEditor_PTD[playerid][i]);
		TDEditor_PTD[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}
	KillTimer(espiar_td@timer[playerid]);
	espiar_td@timer[playerid] = -1;
	return true;
}

/*hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_SPECTATING)
	{
		TogglePlayerSpectating(playerid, false);

		SetPlayerSkin(playerid, GetPVarInt(playerid, "spectating-skin"));
		SetPlayerPos(playerid, GetPVarFloat(playerid, "spectating-x"), GetPVarFloat(playerid, "spectating-y"), GetPVarFloat(playerid, "spectating-z"));
		SetPlayerInterior(playerid, GetPVarInt(playerid, "spectating-interior"));
		SetPlayerVirtualWorld(playerid, GetPVarInt(playerid, "spectating-world"));
		
		DeletePVar(playerid, "spectating-x");
		DeletePVar(playerid, "spectating-y");
		DeletePVar(playerid, "spectating-z");
		DeletePVar(playerid, "spectating-interior");
		DeletePVar(playerid, "spectating-world");
		DeletePVar(playerid, "spectating-skin");

		call::TD->HidePlayerMonitoramento(playerid);
	}
	return 1;
}*/

public UpdateMonitoramentoStats(playerid, to_id)
{
	if ( IsPlayerConnected(to_id) )
	{
		if ( IsPlayerInAnyVehicle(to_id) )
		{
			format(_str, sizeof(_str), "Velocidade: %d", GetVehicleSpeed(GetPlayerVehicleID(to_id)));
			PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][2], _str);
		}
		return true;
	}
	KillTimer(espiar_td@timer[playerid]);
	return true;
}