#include <YSI_Coding\y_hooks>

/**

( hud:radar_burgerShot = Player sem fome ficar cor branca, player com 50% de fome ficar laranja, player quase morrendo de fome ficar vermelho) 
( 2647 = Player sem sede = branco, player com 50% de sede = laranja, player quase morrendo de sede = vermelho)
( 2x hud:radar_ZERO = Player sem sono = branco , Player com 50% de sono = laranja , Player quase dormindo = vermelho)

*/ 


new Text:StatusTDE[8],PlayerText:StatusPTDE[MAX_PLAYERS][6];

hook OnGameModeInit()
{
	LoadStatus();
	return 1;
}

hook OnPlayerConnect(playerid)
{
	LoadPlayerStatus(playerid);
	return 1;
}

stock LoadStatus()
{
	StatusTDE[0] = TextDrawCreate(482.333129, 254.555465, "");
	TextDrawTextSize(StatusTDE[0], 200.000000, 212.000000);
	TextDrawAlignment(StatusTDE[0], 1);
	TextDrawColor(StatusTDE[0], 115);
	TextDrawBackgroundColor(StatusTDE[0], 0);
	TextDrawBoxColor(StatusTDE[0], 50);
	TextDrawUseBox(StatusTDE[0], 0);
	TextDrawSetShadow(StatusTDE[0], 0);
	TextDrawFont(StatusTDE[0], 5);
	TextDrawSetProportional(StatusTDE[0], 0);
	TextDrawSetPreviewModel(StatusTDE[0], 3003);
	TextDrawSetPreviewRot(StatusTDE[0], 0.000000, 0.000000, 0.000000, 1.000000);

	StatusTDE[1] = TextDrawCreate(553.767028, 368.363952, "PERFECT");
	TextDrawLetterSize(StatusTDE[1], 0.279332, 1.405035);
	TextDrawAlignment(StatusTDE[1], 1);
	TextDrawColor(StatusTDE[1], -1);
	TextDrawSetShadow(StatusTDE[1], 0);
	TextDrawSetOutline(StatusTDE[1], 1);
	TextDrawBackgroundColor(StatusTDE[1], 255);
	TextDrawFont(StatusTDE[1], 1);
	TextDrawSetProportional(StatusTDE[1], 1);

	StatusTDE[2] = TextDrawCreate(590.858215, 368.693572, "CITY");
	TextDrawLetterSize(StatusTDE[2], 0.279332, 1.405035);
	TextDrawAlignment(StatusTDE[2], 1);
	TextDrawColor(StatusTDE[2], 41215);
	TextDrawSetShadow(StatusTDE[2], 0);
	TextDrawSetOutline(StatusTDE[2], 1);
	TextDrawBackgroundColor(StatusTDE[2], 255);
	TextDrawFont(StatusTDE[2], 1);
	TextDrawSetProportional(StatusTDE[2], 1);

	StatusTDE[3] = TextDrawCreate(602.200317, 378.864044, "RPG");
	TextDrawLetterSize(StatusTDE[3], 0.194000, 1.085628);
	TextDrawAlignment(StatusTDE[3], 1);
	TextDrawColor(StatusTDE[3], -1);
	TextDrawSetShadow(StatusTDE[3], 0);
	TextDrawSetOutline(StatusTDE[3], 1);
	TextDrawBackgroundColor(StatusTDE[3], 255);
	TextDrawFont(StatusTDE[3], 1);
	TextDrawSetProportional(StatusTDE[3], 1);

	StatusTDE[4] = TextDrawCreate(525.950744, 319.166473, "");
	TextDrawTextSize(StatusTDE[4], 43.000000, 42.000000);
	TextDrawAlignment(StatusTDE[4], 1);
	TextDrawColor(StatusTDE[4], 144);
	TextDrawBackgroundColor(StatusTDE[4], 0);
	TextDrawBoxColor(StatusTDE[4], 50);
	TextDrawUseBox(StatusTDE[4], 0);
	TextDrawSetShadow(StatusTDE[4], 0);
	TextDrawFont(StatusTDE[4], 5);
	TextDrawSetProportional(StatusTDE[4], 0);
	TextDrawSetPreviewModel(StatusTDE[4], 3003);
	TextDrawSetPreviewRot(StatusTDE[4], 0.000000, 0.000000, 0.000000, 1.000000);

	StatusTDE[5] = TextDrawCreate(520.666503, 342.496093, "");
	TextDrawTextSize(StatusTDE[5], 43.000000, 42.000000);
	TextDrawAlignment(StatusTDE[5], 1);
	TextDrawColor(StatusTDE[5], 144);
	TextDrawBackgroundColor(StatusTDE[5], 0);
	TextDrawBoxColor(StatusTDE[5], 50);
	TextDrawUseBox(StatusTDE[5], 0);
	TextDrawSetShadow(StatusTDE[5], 0);
	TextDrawFont(StatusTDE[5], 5);
	TextDrawSetProportional(StatusTDE[5], 0);
	TextDrawSetPreviewModel(StatusTDE[5], 3003);
	TextDrawSetPreviewRot(StatusTDE[5], 0.000000, 0.000000, 0.000000, 1.000000);

	StatusTDE[6] = TextDrawCreate(526.165161, 364.797454, "");
	TextDrawTextSize(StatusTDE[6], 43.000000, 42.000000);
	TextDrawAlignment(StatusTDE[6], 1);
	TextDrawColor(StatusTDE[6], 144);
	TextDrawBackgroundColor(StatusTDE[6], 0);
	TextDrawBoxColor(StatusTDE[6], 50);
	TextDrawUseBox(StatusTDE[6], 0);
	TextDrawSetShadow(StatusTDE[6], 0);
	TextDrawFont(StatusTDE[6], 5);
	TextDrawSetProportional(StatusTDE[6], 0);
	TextDrawSetPreviewModel(StatusTDE[6], 3003);
	TextDrawSetPreviewRot(StatusTDE[6], 0.000000, 0.000000, 0.000000, 1.000000);

	StatusTDE[7] = TextDrawCreate(565.631652, 303.874206, "LD_GRAV:timer");
	TextDrawTextSize(StatusTDE[7], 12.000000, 12.000000);
	TextDrawAlignment(StatusTDE[7], 1);
	TextDrawColor(StatusTDE[7], -1);
	TextDrawSetShadow(StatusTDE[7], 0);
	TextDrawBackgroundColor(StatusTDE[7], 255);
	TextDrawFont(StatusTDE[7], 4);
	TextDrawSetProportional(StatusTDE[7], 0);

	return 1;
}


stock LoadPlayerStatus(playerid)
{
	StatusPTDE[playerid][0] = CreatePlayerTextDraw(playerid, 541.966796, 333.400024, "hud:radar_burgerShot");
	PlayerTextDrawTextSize(playerid, StatusPTDE[playerid][0], 11.000000, 13.000000);
	PlayerTextDrawAlignment(playerid, StatusPTDE[playerid][0], 1);
	PlayerTextDrawColor(playerid, StatusPTDE[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, StatusPTDE[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, StatusPTDE[playerid][0], 255);
	PlayerTextDrawFont(playerid, StatusPTDE[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, StatusPTDE[playerid][0], 0);

	StatusPTDE[playerid][1] = CreatePlayerTextDraw(playerid, 528.267822, 353.108856, "");
	PlayerTextDrawTextSize(playerid, StatusPTDE[playerid][1], 27.000000, 21.000000);
	PlayerTextDrawAlignment(playerid, StatusPTDE[playerid][1], 1);
	PlayerTextDrawColor(playerid, StatusPTDE[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, StatusPTDE[playerid][1], 0);
	PlayerTextDrawBoxColor(playerid, StatusPTDE[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, StatusPTDE[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, StatusPTDE[playerid][1], 0);
	PlayerTextDrawFont(playerid, StatusPTDE[playerid][1], 5);
	PlayerTextDrawSetProportional(playerid, StatusPTDE[playerid][1], 0);
	PlayerTextDrawSetPreviewModel(playerid, StatusPTDE[playerid][1], 2647);
	PlayerTextDrawSetPreviewRot(playerid, StatusPTDE[playerid][1], 0.000000, 0.000000, 270.000000, 1.000000);

	StatusPTDE[playerid][2] = CreatePlayerTextDraw(playerid, 541.966796, 384.403137, "hud:radar_ZERO");
	PlayerTextDrawTextSize(playerid, StatusPTDE[playerid][2], 7.000000, 7.000000);
	PlayerTextDrawAlignment(playerid, StatusPTDE[playerid][2], 1);
	PlayerTextDrawColor(playerid, StatusPTDE[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, StatusPTDE[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, StatusPTDE[playerid][2], 255);
	PlayerTextDrawFont(playerid, StatusPTDE[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, StatusPTDE[playerid][2], 0);

	StatusPTDE[playerid][3] = CreatePlayerTextDraw(playerid, 546.265747, 380.702911, "hud:radar_ZERO");
	PlayerTextDrawTextSize(playerid, StatusPTDE[playerid][3], 7.000000, 7.000000);
	PlayerTextDrawAlignment(playerid, StatusPTDE[playerid][3], 1);
	PlayerTextDrawColor(playerid, StatusPTDE[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, StatusPTDE[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, StatusPTDE[playerid][3], 255);
	PlayerTextDrawFont(playerid, StatusPTDE[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, StatusPTDE[playerid][3], 0);

	StatusPTDE[playerid][4] = CreatePlayerTextDraw(playerid, 578.095153, 303.722625, "100%");
	PlayerTextDrawLetterSize(playerid, StatusPTDE[playerid][4], 0.234666, 1.264000);
	PlayerTextDrawAlignment(playerid, StatusPTDE[playerid][4], 1);
	PlayerTextDrawColor(playerid, StatusPTDE[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, StatusPTDE[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, StatusPTDE[playerid][4], 255);
	PlayerTextDrawFont(playerid, StatusPTDE[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, StatusPTDE[playerid][4], 1);

	StatusPTDE[playerid][5] = CreatePlayerTextDraw(playerid, 546.699890, 322.440795, ""); // Skin
	PlayerTextDrawTextSize(playerid, StatusPTDE[playerid][5], 73.000000, 47.000000);
	PlayerTextDrawAlignment(playerid, StatusPTDE[playerid][5], 1);
	PlayerTextDrawColor(playerid, StatusPTDE[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, StatusPTDE[playerid][5], 0);
	PlayerTextDrawBoxColor(playerid, StatusPTDE[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, StatusPTDE[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, StatusPTDE[playerid][5], 0);
	PlayerTextDrawFont(playerid, StatusPTDE[playerid][5], 5);
	PlayerTextDrawSetProportional(playerid, StatusPTDE[playerid][5], 0);
	PlayerTextDrawSetPreviewModel(playerid, StatusPTDE[playerid][5], GetPlayerSkin(playerid));
	PlayerTextDrawSetPreviewRot(playerid, StatusPTDE[playerid][5], 0.000000, 0.000000, -30.000000, 1.000000);

	return 1;
}

/*
*
*			functions
*
*/

CMD:status(playerid)
{
	call::TD->ShowStatus(playerid);
	call::TD->ShowPlayerStatus(playerid);
	return true;
}

stock function TD::ShowStatus(playerid)
{
	for(new i; i < sizeof(StatusTDE); i++)
		TextDrawShowForPlayer(playerid, StatusTDE[i]);

	return true;
}

stock function TD::HideStatus(playerid)
{
	for(new i; i < sizeof(StatusTDE); i++)
		TextDrawHideForPlayer(playerid, StatusTDE[i]);

	return true;
}

stock function TD::ShowPlayerStatus(playerid)
{
	for(new i; i < sizeof(StatusPTDE); i++)
		PlayerTextDrawShow(playerid, StatusPTDE[playerid][i]);

	return true;
}

stock function TD::HidePlayerStatus(playerid)
{
	for(new i; i < sizeof(StatusPTDE); i++)
		PlayerTextDrawHide(playerid, StatusPTDE[playerid][i]);

	return true;
}

forward Timer@UP1();
public Timer@UP1()
{
	new query[255], _strporc[30];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(Jogador[i][AFK] == false)
		{
			Jogador[i][PorcLevel] = Jogador[i][PorcLevel]+1;

			if(Jogador[i][PorcLevel] < 100)
			{
				mysql_format(getConexao(), query, sizeof(query), "UPDATE `usuarios` SET `porc_level`='%d' WHERE `username`='%s'", Jogador[i][PorcLevel], GetUserName(i));
				mysql_tquery(getConexao(), query);
			}
			if(Jogador[i][PorcLevel] > 100)
			{
				Jogador[i][PorcLevel] = 1;
				new level;
				level = GetPlayerScore(i)+1;

				SetPlayerScore(i, level);

				mysql_format(getConexao(), query, sizeof(query), "UPDATE `usuarios` SET `porc_level`='%d', `level`='%d' WHERE `username`='%s'", Jogador[i][PorcLevel], level, GetUserName(i));
				mysql_tquery(getConexao(), query);
			
				SendClientMessage(i, COR_VERDE_CLARO, "| NÍVEL | Você acumulou 100%s de experiência e subiu para o nível %d!", "%%", level);
				GameTextForPlayer(i, "~g~~h~up!", 3000, 6);
			}
			format(_strporc, sizeof(_strporc), "%d%", Jogador[i][PorcLevel]);
			PlayerTextDrawSetString(i, StatusPTDE[i][4], _strporc);
		}
	}
	return 1;
}