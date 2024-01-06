
/*
*			@title 		HUD
*			@author: 	NelsonC.
*			@date: 		27/03/2021
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

enum pBarInfo
{
	PlayerBar:pBarFome,
	PlayerBar:pBarSede,
	PlayerBar:pBarSono
}

static Text:DataHora[2], Text:Hud[6], PlayerText:HudTD[MAX_PLAYERS][2], pBar[MAX_PLAYERS][pBarInfo];

hook OnGameModeInit()
{
	print("Criando textdraws do HUD");

					/*		Data e Hora		*/

	DataHora[0] = TextDrawCreate(500.000000, 7.000000, "-");
	TextDrawFont(DataHora[0], 1);
	TextDrawLetterSize(DataHora[0], 0.404166, 1.500000);
	TextDrawTextSize(DataHora[0], 400.000000, 17.000000);
	TextDrawSetOutline(DataHora[0], 0);
	TextDrawSetShadow(DataHora[0], 0);
	TextDrawAlignment(DataHora[0], 1);
	TextDrawColor(DataHora[0], -1);
	TextDrawBackgroundColor(DataHora[0], 255);
	TextDrawBoxColor(DataHora[0], 50);
	TextDrawUseBox(DataHora[0], 0);
	TextDrawSetProportional(DataHora[0], 1);
	TextDrawSetSelectable(DataHora[0], 0);

	DataHora[1] = TextDrawCreate(544.000000, 21.000000, "-");
	TextDrawFont(DataHora[1], 1);
	TextDrawLetterSize(DataHora[1], 0.404166, 1.500000);
	TextDrawTextSize(DataHora[1], 400.000000, 17.000000);
	TextDrawSetOutline(DataHora[1], 0);
	TextDrawSetShadow(DataHora[1], 0);
	TextDrawAlignment(DataHora[1], 1);
	TextDrawColor(DataHora[1], -1);
	TextDrawBackgroundColor(DataHora[1], 255);
	TextDrawBoxColor(DataHora[1], 50);
	TextDrawUseBox(DataHora[1], 0);
	TextDrawSetProportional(DataHora[1], 1);
	TextDrawSetSelectable(DataHora[1], 0);

				/*		Hud		*/

	Hud[0] = TextDrawCreate(114.000000, 337.000000, "_");
	TextDrawFont(Hud[0], 1);
	TextDrawLetterSize(Hud[0], -0.029164, 8.849991);
	TextDrawTextSize(Hud[0], 204.500000, 17.000000);
	TextDrawSetOutline(Hud[0], 1);
	TextDrawSetShadow(Hud[0], 0);
	TextDrawAlignment(Hud[0], 1);
	TextDrawColor(Hud[0], -1);
	TextDrawBackgroundColor(Hud[0], 255);
	TextDrawBoxColor(Hud[0], 50);
	TextDrawUseBox(Hud[0], 1);
	TextDrawSetProportional(Hud[0], 1);
	TextDrawSetSelectable(Hud[0], 0);

	Hud[1] = TextDrawCreate(115.000000, 354.000000, "hud:radar_burgerShot");
	TextDrawFont(Hud[1], 4);
	TextDrawLetterSize(Hud[1], 0.600000, 2.000000);
	TextDrawTextSize(Hud[1], 9.500000, 10.500000);
	TextDrawSetOutline(Hud[1], 4);
	TextDrawSetShadow(Hud[1], 2);
	TextDrawAlignment(Hud[1], 1);
	TextDrawColor(Hud[1], -1);
	TextDrawBackgroundColor(Hud[1], 255);
	TextDrawBoxColor(Hud[1], 50);
	TextDrawUseBox(Hud[1], 1);
	TextDrawSetProportional(Hud[1], 1);
	TextDrawSetSelectable(Hud[1], 0);

	Hud[2] = TextDrawCreate(115.000000, 372.000000, "hud:radar_dateDrink");
	TextDrawFont(Hud[2], 4);
	TextDrawLetterSize(Hud[2], 0.600000, 2.000000);
	TextDrawTextSize(Hud[2], 9.500000, 10.500000);
	TextDrawSetOutline(Hud[2], 1);
	TextDrawSetShadow(Hud[2], 0);
	TextDrawAlignment(Hud[2], 1);
	TextDrawColor(Hud[2], -1);
	TextDrawBackgroundColor(Hud[2], 255);
	TextDrawBoxColor(Hud[2], 50);
	TextDrawUseBox(Hud[2], 1);
	TextDrawSetProportional(Hud[2], 1);
	TextDrawSetSelectable(Hud[2], 0);

	Hud[3] = TextDrawCreate(115.000000, 389.000000, "hud:radar_SWEET");
	TextDrawFont(Hud[3], 4);
	TextDrawLetterSize(Hud[3], 0.600000, 2.000000);
	TextDrawTextSize(Hud[3], 9.500000, 10.500000);
	TextDrawSetOutline(Hud[3], 1);
	TextDrawSetShadow(Hud[3], 0);
	TextDrawAlignment(Hud[3], 1);
	TextDrawColor(Hud[3], -1);
	TextDrawBackgroundColor(Hud[3], 255);
	TextDrawBoxColor(Hud[3], 50);
	TextDrawUseBox(Hud[3], 1);
	TextDrawSetProportional(Hud[3], 1);
	TextDrawSetSelectable(Hud[3], 0);

	Hud[4] = TextDrawCreate(170.000000, 331.000000, "l");
	TextDrawFont(Hud[4], 1);
	TextDrawLetterSize(Hud[4], 0.529165, 9.100002);
	TextDrawTextSize(Hud[4], 400.000000, 17.000000);
	TextDrawSetOutline(Hud[4], 0);
	TextDrawSetShadow(Hud[4], 0);
	TextDrawAlignment(Hud[4], 1);
	TextDrawColor(Hud[4], 1097458175);
	TextDrawBackgroundColor(Hud[4], 255);
	TextDrawBoxColor(Hud[4], 50);
	TextDrawUseBox(Hud[4], 0);
	TextDrawSetProportional(Hud[4], 1);
	TextDrawSetSelectable(Hud[4], 0);

	Hud[5] = TextDrawCreate(177.000000, 360.000000, "TextDraw");
	TextDrawFont(Hud[5], 5);
	TextDrawLetterSize(Hud[5], 0.600000, 2.000000);
	TextDrawTextSize(Hud[5], 23.500000, 17.000000);
	TextDrawSetOutline(Hud[5], 1);
	TextDrawSetShadow(Hud[5], 0);
	TextDrawAlignment(Hud[5], 1);
	TextDrawColor(Hud[5], -1);
	TextDrawBackgroundColor(Hud[5], -256);
	TextDrawBoxColor(Hud[5], 0);
	TextDrawUseBox(Hud[5], 0);
	TextDrawSetProportional(Hud[5], 1);
	TextDrawSetSelectable(Hud[5], 0);
	TextDrawSetPreviewModel(Hud[5], 1247);
	TextDrawSetPreviewRot(Hud[5], -10.000000, 0.000000, -9.000000, 1.000000);
	TextDrawSetPreviewVehCol(Hud[5], 1, 1);
	return 1;
}

hook OnPlayerConnect(playerid)
{
					/*		Hud		*/

	HudTD[playerid][0] = CreatePlayerTextDraw(playerid, 131.000000, 339.000000, "~y~+~w~EXP");
	PlayerTextDrawFont(playerid, HudTD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, HudTD[playerid][0], 0.212500, 0.899999);
	PlayerTextDrawTextSize(playerid, HudTD[playerid][0], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, HudTD[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, HudTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, HudTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, HudTD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, HudTD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, HudTD[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, HudTD[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, HudTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, HudTD[playerid][0], 0);

	HudTD[playerid][1] = CreatePlayerTextDraw(playerid, 150.000000, 339.000000, "~r~N/A");
	PlayerTextDrawFont(playerid, HudTD[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, HudTD[playerid][1], 0.162498, 0.949998);
	PlayerTextDrawTextSize(playerid, HudTD[playerid][1], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, HudTD[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, HudTD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, HudTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, HudTD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, HudTD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, HudTD[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, HudTD[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, HudTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, HudTD[playerid][1], 0);

	/*HudTD[playerid][2] = CreatePlayerTextDraw(playerid, 185.000000, 373.000000, "5");
	PlayerTextDrawFont(playerid, HudTD[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, HudTD[playerid][2], 0.320832, 1.600000);
	PlayerTextDrawTextSize(playerid, HudTD[playerid][2], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, HudTD[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, HudTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, HudTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, HudTD[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, HudTD[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, HudTD[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, HudTD[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, HudTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, HudTD[playerid][2], 0);*/

	pBar[playerid][pBarFome] = CreatePlayerProgressBar(playerid, 129.000000, 354.000000, 40.500000, 10.500000, 0xFFFFFFFF, 100.000000, 0);
	pBar[playerid][pBarSede] = CreatePlayerProgressBar(playerid, 129.000000, 372.000000, 40.500000, 10.500000, 0xFFFFFFFF, 100.000000, 0); // Sede
	pBar[playerid][pBarSono] = CreatePlayerProgressBar(playerid, 129.000000, 389.000000, 40.500000, 10.500000, 0xFFFFFFFF, 100.000000, 0); // Sono
	return 1;
}

/*
*
*			functions
*
*/

stock function TD::ShowPlayerHud(playerid)
{
	for(new i; i < sizeof(Hud); i++)
		TextDrawShowForPlayer(playerid, Hud[i]);
	
	for(new i; i < sizeof(HudTD[]); i++)
		PlayerTextDrawShow(playerid, HudTD[playerid][i]);

	for(new i; i < sizeof(pBar[]); i++)
		ShowPlayerProgressBar(playerid,  PlayerBar:pBar[playerid][pBarInfo:i]);

	//call::TD->UpdateTextDrawHudExp(playerid);
	//call::TD->UpdateTextDrawHudLevel(playerid);
	return true;
}

stock function TD::HidePlayerHud(playerid)
{
	for(new i; i < sizeof(Hud); i++)
		TextDrawHideForPlayer(playerid, Hud[i]);

	for(new i; i < sizeof(HudTD[]); i++)
		PlayerTextDrawHide(playerid, HudTD[playerid][i]);

	for(new i; i < sizeof(pBar[]); i++)
		HidePlayerProgressBar(playerid, PlayerBar:pBar[playerid][pBarInfo:i]);

	return true;
}

stock function TD::ShowPlayerHudData(playerid)
{
	TextDrawShowForPlayer(playerid, DataHora[0]); // Data
	TextDrawShowForPlayer(playerid, DataHora[1]); // Hora
}
stock function TD::HidePlayerHudData(playerid)
{
	TextDrawHideForPlayer(playerid, DataHora[0]); // Data
	TextDrawHideForPlayer(playerid, DataHora[1]); // Hora
}

stock function TD::ShowPlayerHudStatus(playerid)
{
	for(new i; i < sizeof(HudTD[]); i++)
		PlayerTextDrawShow(playerid, HudTD[playerid][i]);

	for(new i; i < sizeof(pBar[]); i++)
		ShowPlayerProgressBar(playerid,  PlayerBar:pBar[playerid][pBarInfo:i]);

	for(new i; i < sizeof(Hud); i++)
		TextDrawShowForPlayer(playerid, Hud[i]);

	PlayerTextDrawShow(playerid, WantedInfo[playerid]);
	return true;
}
stock function TD::HidePlayerHudStatus(playerid)
{
	for(new i; i < sizeof(HudTD[]); i++)
		PlayerTextDrawHide(playerid, HudTD[playerid][i]);

	for(new i; i < sizeof(pBar[]); i++)
		HidePlayerProgressBar(playerid,  PlayerBar:pBar[playerid][pBarInfo:i]);

	for(new i; i < sizeof(Hud); i++)
		TextDrawHideForPlayer(playerid, Hud[i]);

	PlayerTextDrawHide(playerid, WantedInfo[playerid]);
	return true;
}

function TD::UpdateTextDrawHud()
{
	new
		str[128], hora, minutos, segundos;

	gettime(hora,minutos,segundos);

	if(hora == 0 && minutos == 0 || !GetSVarInt("dateInit"))
	{
		static
			dia, mes, ano;

		getdate(ano,mes,dia);
		SetSVarInt("dateInit", 1);
		format(str, sizeof(str), "%02d/%d/%d", dia, mes, ano);
		TextDrawSetString(DataHora[0], str);
	}
	format(str, sizeof(str), "%02d:%02d", hora, minutos);
	TextDrawSetString(DataHora[1], str);
	
}

function TD::UpdateTextDrawPlayerHud(playerid)
{
	new str[30];
	format(str, sizeof(str), "~b~%02d:%02d", Jogador[playerid][UPm], Jogador[playerid][UPs]);
	//SendClientMessage(playerid, -1, str);
	PlayerTextDrawSetString(playerid, HudTD[playerid][1], str);
	
	SetPlayerProgressBarValue(playerid, pBar[playerid][pBarFome], Jogador[playerid][Fome]);
	SetPlayerProgressBarValue(playerid, pBar[playerid][pBarSede], Jogador[playerid][Sede]);
	SetPlayerProgressBarValue(playerid, pBar[playerid][pBarSono], Jogador[playerid][Sono]);
}

/*function TD::UpdateWantedLevel(playerid){
	new str[30];
	if(GetPlayerWantedLevel(playerid) == 0) {
		PlayerTextDrawSetString(playerid, HudTD[playerid][2], "0");
	} else if(GetPlayerWantedLevel(playerid) >= 1){
		format(str, sizeof(str), "%d", GetPlayerWantedLevel(playerid));
	}
	PlayerTextDrawSetString(playerid, HudTD[playerid][2], str);
}*/