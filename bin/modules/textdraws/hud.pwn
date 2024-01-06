
/*
*			@title 		HUD
*			@author: 	NelsonC.
*			@date: 		21/01/2021
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

static Text:HudTextD[18], PlayerText:PHudTextD[MAX_PLAYERS][3], pBar[MAX_PLAYERS][pBarInfo];

/*
*
*			hooks callbacks
*
*/

hook OnGameModeInit()
{
    print("» Criando textdraws da HUD.\n");

    HudTextD[0] = TextDrawCreate(139.000000, 349.000000, "_");
	TextDrawFont(HudTextD[0], 1);
	TextDrawLetterSize(HudTextD[0], 0.575000, 8.150004);
	TextDrawTextSize(HudTextD[0], 234.500000, 52.000000);
	TextDrawSetOutline(HudTextD[0], 1);
	TextDrawSetShadow(HudTextD[0], 0);
	TextDrawAlignment(HudTextD[0], 1);
	TextDrawColor(HudTextD[0], -1);
	TextDrawBackgroundColor(HudTextD[0], 255);
	TextDrawBoxColor(HudTextD[0], 50);
	TextDrawUseBox(HudTextD[0], 1);
	TextDrawSetProportional(HudTextD[0], 1);
	TextDrawSetSelectable(HudTextD[0], 0);

	HudTextD[1] = TextDrawCreate(139.000000, 349.000000, "_");
	TextDrawFont(HudTextD[1], 1);
	TextDrawLetterSize(HudTextD[1], 0.575000, 8.150004);
	TextDrawTextSize(HudTextD[1], 234.500000, 52.000000);
	TextDrawSetOutline(HudTextD[1], 1);
	TextDrawSetShadow(HudTextD[1], 0);
	TextDrawAlignment(HudTextD[1], 1);
	TextDrawColor(HudTextD[1], -1);
	TextDrawBackgroundColor(HudTextD[1], 255);
	TextDrawBoxColor(HudTextD[1], 50);
	TextDrawUseBox(HudTextD[1], 1);
	TextDrawSetProportional(HudTextD[1], 1);
	TextDrawSetSelectable(HudTextD[1], 0);

	HudTextD[2] = TextDrawCreate(139.000000, 349.000000, "_");
	TextDrawFont(HudTextD[2], 1);
	TextDrawLetterSize(HudTextD[2], 0.575000, 8.150004);
	TextDrawTextSize(HudTextD[2], 234.500000, 52.000000);
	TextDrawSetOutline(HudTextD[2], 1);
	TextDrawSetShadow(HudTextD[2], 0);
	TextDrawAlignment(HudTextD[2], 1);
	TextDrawColor(HudTextD[2], -1);
	TextDrawBackgroundColor(HudTextD[2], 255);
	TextDrawBoxColor(HudTextD[2], 50);
	TextDrawUseBox(HudTextD[2], 1);
	TextDrawSetProportional(HudTextD[2], 1);
	TextDrawSetSelectable(HudTextD[2], 0);

	HudTextD[3] = TextDrawCreate(139.000000, 349.000000, "_");
	TextDrawFont(HudTextD[3], 1);
	TextDrawLetterSize(HudTextD[3], 0.575000, 8.150004);
	TextDrawTextSize(HudTextD[3], 234.500000, 52.000000);
	TextDrawSetOutline(HudTextD[3], 1);
	TextDrawSetShadow(HudTextD[3], 0);
	TextDrawAlignment(HudTextD[3], 1);
	TextDrawColor(HudTextD[3], -1);
	TextDrawBackgroundColor(HudTextD[3], 255);
	TextDrawBoxColor(HudTextD[3], 50);
	TextDrawUseBox(HudTextD[3], 1);
	TextDrawSetProportional(HudTextD[3], 1);
	TextDrawSetSelectable(HudTextD[3], 0);

	HudTextD[4] = TextDrawCreate(140.000000, 364.000000, "HUD:radar_burgershot");
	TextDrawFont(HudTextD[4], 4);
	TextDrawLetterSize(HudTextD[4], 0.600000, 2.000000);
	TextDrawTextSize(HudTextD[4], 10.000000, 11.500000);
	TextDrawSetOutline(HudTextD[4], 1);
	TextDrawSetShadow(HudTextD[4], 0);
	TextDrawAlignment(HudTextD[4], 1);
	TextDrawColor(HudTextD[4], -1);
	TextDrawBackgroundColor(HudTextD[4], 255);
	TextDrawBoxColor(HudTextD[4], 50);
	TextDrawUseBox(HudTextD[4], 1);
	TextDrawSetProportional(HudTextD[4], 1);
	TextDrawSetSelectable(HudTextD[4], 0);

	HudTextD[5] = TextDrawCreate(140.000000, 378.000000, "hud:radar_dateDrink");
	TextDrawFont(HudTextD[5], 4);
	TextDrawLetterSize(HudTextD[5], 0.600000, 2.000000);
	TextDrawTextSize(HudTextD[5], 10.000000, 11.500000);
	TextDrawSetOutline(HudTextD[5], 1);
	TextDrawSetShadow(HudTextD[5], 0);
	TextDrawAlignment(HudTextD[5], 1);
	TextDrawColor(HudTextD[5], -1);
	TextDrawBackgroundColor(HudTextD[5], 255);
	TextDrawBoxColor(HudTextD[5], 50);
	TextDrawUseBox(HudTextD[5], 1);
	TextDrawSetProportional(HudTextD[5], 1);
	TextDrawSetSelectable(HudTextD[5], 0);

	HudTextD[6] = TextDrawCreate(140.000000, 393.000000, "hud:radar_ZERO");
	TextDrawFont(HudTextD[6], 4);
	TextDrawLetterSize(HudTextD[6], 0.600000, 2.000000);
	TextDrawTextSize(HudTextD[6], 10.000000, 11.500000);
	TextDrawSetOutline(HudTextD[6], 1);
	TextDrawSetShadow(HudTextD[6], 0);
	TextDrawAlignment(HudTextD[6], 1);
	TextDrawColor(HudTextD[6], -1);
	TextDrawBackgroundColor(HudTextD[6], 255);
	TextDrawBoxColor(HudTextD[6], 50);
	TextDrawUseBox(HudTextD[6], 1);
	TextDrawSetProportional(HudTextD[6], 1);
	TextDrawSetSelectable(HudTextD[6], 0);

	HudTextD[7] = TextDrawCreate(174.000000, 339.000000, "Status");
	TextDrawFont(HudTextD[7], 3);
	TextDrawLetterSize(HudTextD[7], 0.212500, 1.400000);
	TextDrawTextSize(HudTextD[7], 400.000000, 17.000000);
	TextDrawSetOutline(HudTextD[7], 1);
	TextDrawSetShadow(HudTextD[7], 0);
	TextDrawAlignment(HudTextD[7], 1);
	TextDrawColor(HudTextD[7], -1);
	TextDrawBackgroundColor(HudTextD[7], 255);
	TextDrawBoxColor(HudTextD[7], 50);
	TextDrawUseBox(HudTextD[7], 0);
	TextDrawSetProportional(HudTextD[7], 1);
	TextDrawSetSelectable(HudTextD[7], 0);

	HudTextD[8] = TextDrawCreate(199.000000, 337.000000, "l");
	TextDrawFont(HudTextD[8], 1);
	TextDrawLetterSize(HudTextD[8], 0.208333, 9.549998);
	TextDrawTextSize(HudTextD[8], 400.000000, 17.000000);
	TextDrawSetOutline(HudTextD[8], 1);
	TextDrawSetShadow(HudTextD[8], 0);
	TextDrawAlignment(HudTextD[8], 1);
	TextDrawColor(HudTextD[8], -1);
	TextDrawBackgroundColor(HudTextD[8], 255);
	TextDrawBoxColor(HudTextD[8], 50);
	TextDrawUseBox(HudTextD[8], 0);
	TextDrawSetProportional(HudTextD[8], 1);
	TextDrawSetSelectable(HudTextD[8], 0);

	HudTextD[9] = TextDrawCreate(202.000000, 398.000000, "");
	TextDrawFont(HudTextD[9], 5);
	TextDrawLetterSize(HudTextD[9], 0.308333, 0.949998);
	TextDrawTextSize(HudTextD[9], 11.500000, 11.500000);
	TextDrawSetOutline(HudTextD[9], 1);
	TextDrawSetShadow(HudTextD[9], 0);
	TextDrawAlignment(HudTextD[9], 1);
	TextDrawColor(HudTextD[9], -1);
	TextDrawBackgroundColor(HudTextD[9], 0);
	TextDrawBoxColor(HudTextD[9], -206);
	TextDrawUseBox(HudTextD[9], 0);
	TextDrawSetProportional(HudTextD[9], 1);
	TextDrawSetSelectable(HudTextD[9], 0);
	TextDrawSetPreviewModel(HudTextD[9], 1247);
	TextDrawSetPreviewRot(HudTextD[9], -10.000000, 0.000000, -6.000000, 0.709999);
	TextDrawSetPreviewVehCol(HudTextD[9], 6, 0);

	HudTextD[10] = TextDrawCreate(213.000000, 398.000000, ":");
	TextDrawFont(HudTextD[10], 0);
	TextDrawLetterSize(HudTextD[10], 0.183329, 0.999997);
	TextDrawTextSize(HudTextD[10], 400.000000, 17.000000);
	TextDrawSetOutline(HudTextD[10], 1);
	TextDrawSetShadow(HudTextD[10], 0);
	TextDrawAlignment(HudTextD[10], 1);
	TextDrawColor(HudTextD[10], -1);
	TextDrawBackgroundColor(HudTextD[10], 255);
	TextDrawBoxColor(HudTextD[10], 50);
	TextDrawUseBox(HudTextD[10], 0);
	TextDrawSetProportional(HudTextD[10], 1);
	TextDrawSetSelectable(HudTextD[10], 0);

	HudTextD[11] = TextDrawCreate(216.000000, 398.000000, "");
	TextDrawFont(HudTextD[11], 1);
	TextDrawLetterSize(HudTextD[11], 0.183329, 0.999997);
	TextDrawTextSize(HudTextD[11], 400.000000, 17.000000);
	TextDrawSetOutline(HudTextD[11], 1);
	TextDrawSetShadow(HudTextD[11], 0);
	TextDrawAlignment(HudTextD[11], 1);
	TextDrawColor(HudTextD[11], -1);
	TextDrawBackgroundColor(HudTextD[11], 255);
	TextDrawBoxColor(HudTextD[11], 50);
	TextDrawUseBox(HudTextD[11], 0);
	TextDrawSetProportional(HudTextD[11], 1);
	TextDrawSetSelectable(HudTextD[11], 0);

    HudTextD[12] = TextDrawCreate(203.000000, 358.000000, "+UP:");
	TextDrawFont(HudTextD[12], 1);
	TextDrawLetterSize(HudTextD[12], 0.133331, 0.999997);
	TextDrawTextSize(HudTextD[12], 400.000000, 17.000000);
	TextDrawSetOutline(HudTextD[12], 1);
	TextDrawSetShadow(HudTextD[12], 0);
	TextDrawAlignment(HudTextD[12], 1);
	TextDrawColor(HudTextD[12], -1);
	TextDrawBackgroundColor(HudTextD[12], 255);
	TextDrawBoxColor(HudTextD[12], 50);
	TextDrawUseBox(HudTextD[12], 0);
	TextDrawSetProportional(HudTextD[12], 1);
	TextDrawSetSelectable(HudTextD[12], 0);

	HudTextD[13] = TextDrawCreate(203.000000, 368.000000, "Level:");
	TextDrawFont(HudTextD[13], 1);
	TextDrawLetterSize(HudTextD[13], 0.133331, 0.999997);
	TextDrawTextSize(HudTextD[13], 400.000000, 17.000000);
	TextDrawSetOutline(HudTextD[13], 1);
	TextDrawSetShadow(HudTextD[13], 0);
	TextDrawAlignment(HudTextD[13], 1);
	TextDrawColor(HudTextD[13], -1);
	TextDrawBackgroundColor(HudTextD[13], 255);
	TextDrawBoxColor(HudTextD[13], 50);
	TextDrawUseBox(HudTextD[13], 0);
	TextDrawSetProportional(HudTextD[13], 1);
	TextDrawSetSelectable(HudTextD[13], 0);

	HudTextD[14] = TextDrawCreate(203.000000, 377.000000, "EXP:");
	TextDrawFont(HudTextD[14], 1);
	TextDrawLetterSize(HudTextD[14], 0.133331, 0.999997);
	TextDrawTextSize(HudTextD[14], 400.000000, 17.000000);
	TextDrawSetOutline(HudTextD[14], 1);
	TextDrawSetShadow(HudTextD[14], 0);
	TextDrawAlignment(HudTextD[14], 1);
	TextDrawColor(HudTextD[14], -1);
	TextDrawBackgroundColor(HudTextD[14], 255);
	TextDrawBoxColor(HudTextD[14], 50);
	TextDrawUseBox(HudTextD[14], 0);
	TextDrawSetProportional(HudTextD[14], 1);
	TextDrawSetSelectable(HudTextD[14], 0);

    HudTextD[15] = TextDrawCreate(634.000000, 8.249985, "-"); // data
	TextDrawLetterSize(HudTextD[15], 0.371294, 1.045832);
	TextDrawTextSize(HudTextD[15], 770.000000, 0.000000);
	TextDrawAlignment(HudTextD[15], 3);
	TextDrawColor(HudTextD[15], -1);
	TextDrawUseBox(HudTextD[15], 1);
	TextDrawBoxColor(HudTextD[15], 0);
	TextDrawSetShadow(HudTextD[15], 1);
	TextDrawSetOutline(HudTextD[15], 0);
	TextDrawBackgroundColor(HudTextD[15], 255);
	TextDrawFont(HudTextD[15], 1);
	TextDrawSetProportional(HudTextD[15], 1);
	TextDrawSetShadow(HudTextD[15], 1);

	HudTextD[16] = TextDrawCreate(547.253234, 23.616699, "-"); // hora
	TextDrawLetterSize(HudTextD[16], 0.400000, 1.600000);
	TextDrawAlignment(HudTextD[16], 1);
	TextDrawColor(HudTextD[16], -1);
	TextDrawSetShadow(HudTextD[16], 1);
	TextDrawSetOutline(HudTextD[16], 0);
	TextDrawBackgroundColor(HudTextD[16], 255);
	TextDrawFont(HudTextD[16], 2);
	TextDrawSetProportional(HudTextD[16], 1);
	TextDrawSetShadow(HudTextD[16], 1);

	HudTextD[17] = TextDrawCreate(31.928283, 426.166534, "Perfect City RPG");
	TextDrawLetterSize(HudTextD[17], 0.275841, 0.964166);
	TextDrawTextSize(HudTextD[17], 189.000000, 0.000000);
	TextDrawAlignment(HudTextD[17], 1);
	TextDrawColor(HudTextD[17], -1);
	TextDrawUseBox(HudTextD[17], 1);
	TextDrawBoxColor(HudTextD[17], 0);
	TextDrawSetShadow(HudTextD[17], 1);
	TextDrawSetOutline(HudTextD[17], 0);
	TextDrawBackgroundColor(HudTextD[17], 255);
	TextDrawFont(HudTextD[17], 2);
	TextDrawSetProportional(HudTextD[17], 1);
	TextDrawSetShadow(HudTextD[17], 1);

    SetSVarInt("dateInit", 0);
}

hook OnPlayerConnect(playerid)
{
    PHudTextD[playerid][0] = CreatePlayerTextDraw(playerid, 214.000000, 358.000000, "10:00"); // relogio up
	PlayerTextDrawFont(playerid, PHudTextD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, PHudTextD[playerid][0], 0.133332, 0.999997);
	PlayerTextDrawTextSize(playerid, PHudTextD[playerid][0], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PHudTextD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, PHudTextD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, PHudTextD[playerid][0], 1);
	PlayerTextDrawColor(playerid, PHudTextD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, PHudTextD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, PHudTextD[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, PHudTextD[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, PHudTextD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, PHudTextD[playerid][0], 0);

    PHudTextD[playerid][1] = CreatePlayerTextDraw(playerid, 217.000000, 369.000000, "000"); // level
	PlayerTextDrawFont(playerid, PHudTextD[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, PHudTextD[playerid][1], 0.166664, 0.899995);
	PlayerTextDrawTextSize(playerid, PHudTextD[playerid][1], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PHudTextD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, PHudTextD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, PHudTextD[playerid][1], 1);
	PlayerTextDrawColor(playerid, PHudTextD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, PHudTextD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, PHudTextD[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, PHudTextD[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, PHudTextD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, PHudTextD[playerid][1], 0);

	PHudTextD[playerid][2] = CreatePlayerTextDraw(playerid, 215.000000, 378.000000, "-/-"); // exp
	PlayerTextDrawFont(playerid, PHudTextD[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, PHudTextD[playerid][2], 0.166664, 0.899995);
	PlayerTextDrawTextSize(playerid, PHudTextD[playerid][2], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PHudTextD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, PHudTextD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, PHudTextD[playerid][2], 1);
	PlayerTextDrawColor(playerid, PHudTextD[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, PHudTextD[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, PHudTextD[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, PHudTextD[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, PHudTextD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, PHudTextD[playerid][2], 0);

    pBar[playerid][pBarFome] = CreatePlayerProgressBar(playerid, 153.000000, 368.000000, 41.000000, 4.500000, 0xB2CC04FF, 100.000000, 0);
	pBar[playerid][pBarSede] = CreatePlayerProgressBar(playerid, 153.000000, 381.000000, 41.000000, 4.500000, 0x20B6F5FF, 100.000000, 0); // Sede
	pBar[playerid][pBarSono] = CreatePlayerProgressBar(playerid, 153.000000, 396.000000, 41.000000, 4.500000, 0x755591FF, 100.000000, 0); // Sono

    return true;
}

/*
*
*			functions
*
*/

stock function TD::ShowPlayerHud(playerid)
{
	for(new i; i < sizeof(HudTextD); i++)
		TextDrawShowForPlayer(playerid, HudTextD[i]);
	
	for(new i; i < sizeof(PHudTextD[]); i++)
		PlayerTextDrawShow(playerid, PHudTextD[playerid][i]);

	for(new i; i < sizeof(pBar[]); i++)
		ShowPlayerProgressBar(playerid,  PlayerBar:pBar[playerid][pBarInfo:i]);

	call::TD->UpdateTextDrawHudExp(playerid);
	call::TD->UpdateTextDrawHudLevel(playerid);
	return true;
}

stock function TD::HidePlayerHud(playerid)
{
	for(new i; i < sizeof(HudTextD); i++)
		TextDrawHideForPlayer(playerid, HudTextD[i]);

	for(new i; i < sizeof(PHudTextD[]); i++)
		PlayerTextDrawHide(playerid, PHudTextD[playerid][i]);

	for(new i; i < sizeof(pBar[]); i++)
		HidePlayerProgressBar(playerid, PlayerBar:pBar[playerid][pBarInfo:i]);

	return true;
}

stock function TD::ShowPlayerHudData(playerid)
{
	TextDrawShowForPlayer(playerid, HudTextD[15]); // Data
	TextDrawShowForPlayer(playerid, HudTextD[16]); // Hora
}
stock function TD::HidePlayerHudData(playerid)
{
	TextDrawHideForPlayer(playerid, HudTextD[15]); // Data
	TextDrawHideForPlayer(playerid, HudTextD[16]); // Hora
}

stock function TD::ShowPlayerHudStatus(playerid)
{
	for(new i; i < sizeof(PHudTextD[]); i++)
		PlayerTextDrawShow(playerid, PHudTextD[playerid][i]);

	for(new i; i < sizeof(pBar[]); i++)
		ShowPlayerProgressBar(playerid,  PlayerBar:pBar[playerid][pBarInfo:i]);

	for(new i=3; i < sizeof(HudTextD); i++)
		TextDrawShowForPlayer(playerid, HudTextD[i]);
	return true;
}
stock function TD::HidePlayerHudStatus(playerid)
{
	for(new i; i < sizeof(PHudTextD[]); i++)
		PlayerTextDrawHide(playerid, PHudTextD[playerid][i]);

	for(new i; i < sizeof(pBar[]); i++)
		HidePlayerProgressBar(playerid,  PlayerBar:pBar[playerid][pBarInfo:i]);

	for(new i=3; i < sizeof(HudTextD); i++)
		TextDrawHideForPlayer(playerid, HudTextD[i]);
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
		format(str, sizeof(str), "%02d de %s de %d", dia, ReturnMesFormat(mes), ano);
		TextDrawSetString(HudTextD[15], str);
	}
	format(str, sizeof(str), "%02d:%02d:%02d", hora, minutos, segundos);
	TextDrawSetString(HudTextD[16], str);
	
}

function TD::UpdateTextDrawPlayerHud(playerid)
{
	new str[30];
	format(str, sizeof(str), "%02d:%02d", Jogador[playerid][UPm], Jogador[playerid][UPs]);
	//SendClientMessage(playerid, -1, str);
	PlayerTextDrawSetString(playerid, PHudTextD[playerid][0], str);
	
	SetPlayerProgressBarValue(playerid, pBar[playerid][pBarFome], Jogador[playerid][Fome]);
	SetPlayerProgressBarValue(playerid, pBar[playerid][pBarSede], Jogador[playerid][Sede]);
	SetPlayerProgressBarValue(playerid, pBar[playerid][pBarSono], Jogador[playerid][Sono]);
}

function TD::UpdateTextDrawHudLevel(playerid)
{
	new str[10];
	format(str, sizeof(str), "%d", GetPlayerScore(playerid));
	PlayerTextDrawSetString(playerid, PHudTextD[playerid][1], str);
}

function TD::UpdateTextDrawHudExp(playerid){
	new str[30];
	format(str, sizeof(str), "%d/%d", Jogador[playerid][EXP], call::PLAYER->requestXP(playerid));
	PlayerTextDrawSetString(playerid, PHudTextD[playerid][2], str);
}