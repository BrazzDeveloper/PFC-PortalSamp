
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

new Text:DataHora[3], Text:HUDP[7], PlayerText:StatusOP[MAX_PLAYERS][6], PlayerText:ExpOP[MAX_PLAYERS][1];

hook OnGameModeInit()
{
	print("Criando textdraws do HUD");

	// Data e Hora
	DataHora[0] = TextDrawCreate(57.000000, 281.000000, "Segunda");
	TextDrawFont(DataHora[0], 2);
	TextDrawLetterSize(DataHora[0], 0.295833, 2.000000);
	TextDrawTextSize(DataHora[0], 400.000000, 17.000000);
	TextDrawSetOutline(DataHora[0], 0);
	TextDrawSetShadow(DataHora[0], 1);
	TextDrawAlignment(DataHora[0], 1);
	TextDrawColor(DataHora[0], -1);
	TextDrawBackgroundColor(DataHora[0], 255);
	TextDrawBoxColor(DataHora[0], 50);
	TextDrawUseBox(DataHora[0], 0);
	TextDrawSetProportional(DataHora[0], 1);
	TextDrawSetSelectable(DataHora[0], 0);

	DataHora[1] = TextDrawCreate(51.000000, 295.000000, "12/04/2021");
	TextDrawFont(DataHora[1], 2);
	TextDrawLetterSize(DataHora[1], 0.295833, 2.000000);
	TextDrawTextSize(DataHora[1], 400.000000, 17.000000);
	TextDrawSetOutline(DataHora[1], 0);
	TextDrawSetShadow(DataHora[1], 1);
	TextDrawAlignment(DataHora[1], 1);
	TextDrawColor(DataHora[1], -1);
	TextDrawBackgroundColor(DataHora[1], 255);
	TextDrawBoxColor(DataHora[1], 50);
	TextDrawUseBox(DataHora[1], 0);
	TextDrawSetProportional(DataHora[1], 1);
	TextDrawSetSelectable(DataHora[1], 0);

	DataHora[2] = TextDrawCreate(555.000000, 23.120000, "99:99");
	TextDrawLetterSize(DataHora[2], 0.418999, 1.851999);
	TextDrawAlignment(DataHora[2], 1);
	TextDrawColor(DataHora[2], -1);
	TextDrawSetShadow(DataHora[2], 0);
	TextDrawSetOutline(DataHora[2], 1);
	TextDrawBackgroundColor(DataHora[2], 255);
	TextDrawFont(DataHora[2], 3);
	TextDrawSetProportional(DataHora[2], 1);
	TextDrawSetShadow(DataHora[2], 0);

	// HUD PUBLIC

	HUDP[0] = TextDrawCreate(592.000000, 338.000000, "_");
	TextDrawFont(HUDP[0], 1);
	TextDrawLetterSize(HUDP[0], 0.904166, 8.250016);
	TextDrawTextSize(HUDP[0], 609.500000, 38.000000);
	TextDrawSetOutline(HUDP[0], 1);
	TextDrawSetShadow(HUDP[0], 0);
	TextDrawAlignment(HUDP[0], 1);
	TextDrawColor(HUDP[0], -1094795521);
	TextDrawBackgroundColor(HUDP[0], 255);
	TextDrawBoxColor(HUDP[0], 50);
	TextDrawUseBox(HUDP[0], 1);
	TextDrawSetProportional(HUDP[0], 1);
	TextDrawSetSelectable(HUDP[0], 0);

	HUDP[1] = TextDrawCreate(587.000000, 393.000000, "l");
	TextDrawFont(HUDP[1], 1);
	TextDrawLetterSize(HUDP[1], 3.154171, 0.350000);
	TextDrawTextSize(HUDP[1], 400.000000, 17.000000);
	TextDrawSetOutline(HUDP[1], 0);
	TextDrawSetShadow(HUDP[1], 0);
	TextDrawAlignment(HUDP[1], 1);
	TextDrawColor(HUDP[1], 1687547391);
	TextDrawBackgroundColor(HUDP[1], 255);
	TextDrawBoxColor(HUDP[1], 1097457970);
	TextDrawUseBox(HUDP[1], 0);
	TextDrawSetProportional(HUDP[1], 1);
	TextDrawSetSelectable(HUDP[1], 0);

	HUDP[2] = TextDrawCreate(608.000000, 393.000000, "l");
	TextDrawFont(HUDP[2], 1);
	TextDrawLetterSize(HUDP[2], 3.154171, 0.350000);
	TextDrawTextSize(HUDP[2], 400.000000, 17.000000);
	TextDrawSetOutline(HUDP[2], 0);
	TextDrawSetShadow(HUDP[2], 0);
	TextDrawAlignment(HUDP[2], 1);
	TextDrawColor(HUDP[2], 1687547391);
	TextDrawBackgroundColor(HUDP[2], 255);
	TextDrawBoxColor(HUDP[2], 1097457970);
	TextDrawUseBox(HUDP[2], 0);
	TextDrawSetProportional(HUDP[2], 1);
	TextDrawSetSelectable(HUDP[2], 0);

	HUDP[3] = TextDrawCreate(595.000000, 396.000000, "EXP");
	TextDrawFont(HUDP[3], 2);
	TextDrawLetterSize(HUDP[3], 0.175000, 1.650000);
	TextDrawTextSize(HUDP[3], 400.000000, 17.000000);
	TextDrawSetOutline(HUDP[3], 0);
	TextDrawSetShadow(HUDP[3], 1);
	TextDrawAlignment(HUDP[3], 1);
	TextDrawColor(HUDP[3], -1);
	TextDrawBackgroundColor(HUDP[3], 255);
	TextDrawBoxColor(HUDP[3], 50);
	TextDrawUseBox(HUDP[3], 0);
	TextDrawSetProportional(HUDP[3], 1);
	TextDrawSetSelectable(HUDP[3], 0);

	/*HUDP[4] = TextDrawCreate(0.000000, 430.000000, "_");
	TextDrawFont(HUDP[4], 1);
	TextDrawLetterSize(HUDP[4], 0.645833, 2.000000);
	TextDrawTextSize(HUDP[4], 680.000000, 17.000000);
	TextDrawSetOutline(HUDP[4], 1);
	TextDrawSetShadow(HUDP[4], 0);
	TextDrawAlignment(HUDP[4], 1);
	TextDrawColor(HUDP[4], -1);
	TextDrawBackgroundColor(HUDP[4], 255);
	TextDrawBoxColor(HUDP[4], 1296911805);
	TextDrawUseBox(HUDP[4], 1);
	TextDrawSetProportional(HUDP[4], 1);
	TextDrawSetSelectable(HUDP[4], 0);*/
	HUDP[4] = TextDrawCreate(494.000000, 139.000000, "l");
	TextDrawFont(HUDP[4], 1);
	TextDrawLetterSize(HUDP[4], 13.966696, 0.399998);
	TextDrawTextSize(HUDP[4], 400.000000, 17.000000);
	TextDrawSetOutline(HUDP[4], 0);
	TextDrawSetShadow(HUDP[4], 0);
	TextDrawAlignment(HUDP[4], 1);
	TextDrawColor(HUDP[4], 560008191);
	TextDrawBackgroundColor(HUDP[4], 255);
	TextDrawBoxColor(HUDP[4], 50);
	TextDrawUseBox(HUDP[4], 0);
	TextDrawSetProportional(HUDP[4], 1);
	TextDrawSetSelectable(HUDP[4], 0);

	HUDP[5] = TextDrawCreate(510.000000, 122.000000, "Perfect City RPG");
	TextDrawFont(HUDP[5], 2);
	TextDrawLetterSize(HUDP[5], 0.233333, 2.000000);
	TextDrawTextSize(HUDP[5], 607.000000, 59.000000);
	TextDrawSetOutline(HUDP[5], 0);
	TextDrawSetShadow(HUDP[5], 1);
	TextDrawAlignment(HUDP[5], 1);
	TextDrawColor(HUDP[5], -741092353);
	TextDrawBackgroundColor(HUDP[5], 255);
	TextDrawBoxColor(HUDP[5], 50);
	TextDrawUseBox(HUDP[5], 0);
	TextDrawSetProportional(HUDP[5], 1);
	TextDrawSetSelectable(HUDP[5], 0);

	HUDP[6] = TextDrawCreate(634.000000, 338.000000, "_");
	TextDrawFont(HUDP[6], 1);
	TextDrawLetterSize(HUDP[6], 0.908333, 8.250016);
	TextDrawTextSize(HUDP[6], 610.500000, 44.000000);
	TextDrawSetOutline(HUDP[6], 1);
	TextDrawSetShadow(HUDP[6], 0);
	TextDrawAlignment(HUDP[6], 1);
	TextDrawColor(HUDP[6], -1094795521);
	TextDrawBackgroundColor(HUDP[6], 255);
	TextDrawBoxColor(HUDP[6], 50);
	TextDrawUseBox(HUDP[6], 1);
	TextDrawSetProportional(HUDP[6], 1);
	TextDrawSetSelectable(HUDP[6], 0);

	return 1;
}

hook OnPlayerConnect(playerid)
{

	StatusOP[playerid][0] = CreatePlayerTextDraw(playerid, 590.000000, 339.000000, "HUD:radar_datefood");
	PlayerTextDrawFont(playerid, StatusOP[playerid][0], 5);
	PlayerTextDrawLetterSize(playerid, StatusOP[playerid][0], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, StatusOP[playerid][0], 19.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, StatusOP[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, StatusOP[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, StatusOP[playerid][0], 1);
	PlayerTextDrawColor(playerid, StatusOP[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, StatusOP[playerid][0], 0);
	PlayerTextDrawBoxColor(playerid, StatusOP[playerid][0], 0);
	PlayerTextDrawUseBox(playerid, StatusOP[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, StatusOP[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, StatusOP[playerid][0], 0);
	PlayerTextDrawSetPreviewModel(playerid, StatusOP[playerid][0], 2702);
	PlayerTextDrawSetPreviewRot(playerid, StatusOP[playerid][0], -161.000000, -104.000000, -59.000000, 0.650000);
	PlayerTextDrawSetPreviewVehCol(playerid, StatusOP[playerid][0], 1, 1);

	StatusOP[playerid][1] = CreatePlayerTextDraw(playerid, 590.000000, 357.000000, "HUD:radar_datefood");
	PlayerTextDrawFont(playerid, StatusOP[playerid][1], 5);
	PlayerTextDrawLetterSize(playerid, StatusOP[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, StatusOP[playerid][1], 19.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, StatusOP[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, StatusOP[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, StatusOP[playerid][1], 1);
	PlayerTextDrawColor(playerid, StatusOP[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, StatusOP[playerid][1], 0);
	PlayerTextDrawBoxColor(playerid, StatusOP[playerid][1], 0);
	PlayerTextDrawUseBox(playerid, StatusOP[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, StatusOP[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, StatusOP[playerid][1], 0);
	PlayerTextDrawSetPreviewModel(playerid, StatusOP[playerid][1], 1544);
	PlayerTextDrawSetPreviewRot(playerid, StatusOP[playerid][1], -181.000000, -183.000000, -36.000000, 0.720000);
	PlayerTextDrawSetPreviewVehCol(playerid, StatusOP[playerid][1], 1, 1);

	StatusOP[playerid][2] = CreatePlayerTextDraw(playerid, 593.000000, 381.000000, "HUD:radar_datefood");
	PlayerTextDrawFont(playerid, StatusOP[playerid][2], 5);
	PlayerTextDrawLetterSize(playerid, StatusOP[playerid][2], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, StatusOP[playerid][2], 19.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, StatusOP[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, StatusOP[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, StatusOP[playerid][2], 1);
	PlayerTextDrawColor(playerid, StatusOP[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, StatusOP[playerid][2], 0);
	PlayerTextDrawBoxColor(playerid, StatusOP[playerid][2], 0);
	PlayerTextDrawUseBox(playerid, StatusOP[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, StatusOP[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, StatusOP[playerid][2], 0);
	PlayerTextDrawSetPreviewModel(playerid, StatusOP[playerid][2], 2299);
	PlayerTextDrawSetPreviewRot(playerid, StatusOP[playerid][2], -220.000000, -176.000000, 37.000000, 0.760000);
	PlayerTextDrawSetPreviewVehCol(playerid, StatusOP[playerid][2], 1, 1);

	StatusOP[playerid][3] = CreatePlayerTextDraw(playerid, 614.000000, 341.000000, "100");
	PlayerTextDrawFont(playerid, StatusOP[playerid][3], 2);
	PlayerTextDrawLetterSize(playerid, StatusOP[playerid][3], 0.175000, 1.650000);
	PlayerTextDrawTextSize(playerid, StatusOP[playerid][3], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, StatusOP[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, StatusOP[playerid][3], 1);
	PlayerTextDrawAlignment(playerid, StatusOP[playerid][3], 1);
	PlayerTextDrawColor(playerid, StatusOP[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, StatusOP[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, StatusOP[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, StatusOP[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, StatusOP[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, StatusOP[playerid][3], 0);

	StatusOP[playerid][4] = CreatePlayerTextDraw(playerid, 614.000000, 360.000000, "100");
	PlayerTextDrawFont(playerid, StatusOP[playerid][4], 2);
	PlayerTextDrawLetterSize(playerid, StatusOP[playerid][4], 0.175000, 1.650000);
	PlayerTextDrawTextSize(playerid, StatusOP[playerid][4], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, StatusOP[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, StatusOP[playerid][4], 1);
	PlayerTextDrawAlignment(playerid, StatusOP[playerid][4], 1);
	PlayerTextDrawColor(playerid, StatusOP[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, StatusOP[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, StatusOP[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, StatusOP[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, StatusOP[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, StatusOP[playerid][4], 0);

	StatusOP[playerid][5] = CreatePlayerTextDraw(playerid, 614.000000, 377.000000, "100");
	PlayerTextDrawFont(playerid, StatusOP[playerid][5], 2);
	PlayerTextDrawLetterSize(playerid, StatusOP[playerid][5], 0.175000, 1.650000);
	PlayerTextDrawTextSize(playerid, StatusOP[playerid][5], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, StatusOP[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, StatusOP[playerid][5], 1);
	PlayerTextDrawAlignment(playerid, StatusOP[playerid][5], 1);
	PlayerTextDrawColor(playerid, StatusOP[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, StatusOP[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, StatusOP[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, StatusOP[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, StatusOP[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, StatusOP[playerid][5], 0);

	ExpOP[playerid][0] = CreatePlayerTextDraw(playerid, 614.000000, 396.000000, "100");
	PlayerTextDrawFont(playerid, ExpOP[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, ExpOP[playerid][0], 0.175000, 1.650000);
	PlayerTextDrawTextSize(playerid, ExpOP[playerid][0], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ExpOP[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, ExpOP[playerid][0], 1);
	PlayerTextDrawAlignment(playerid, ExpOP[playerid][0], 1);
	PlayerTextDrawColor(playerid, ExpOP[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, ExpOP[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, ExpOP[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, ExpOP[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, ExpOP[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, ExpOP[playerid][0], 0);

	return true;
}

/*
*
*			functions
*
*/

stock function TD::ShowPlayerHud(playerid)
{
	for(new i; i < sizeof(HUDP); i++)
		TextDrawShowForPlayer(playerid, HUDP[i]);

	return true;
}

stock function TD::HidePlayerHud(playerid)
{
	for(new i; i < sizeof(HUDP); i++)
		TextDrawHideForPlayer(playerid, HUDP[i]);

	return true;
}

stock function TD::ShowPlayerHudData(playerid)
{
	TextDrawShowForPlayer(playerid, DataHora[0]); // Data
	TextDrawShowForPlayer(playerid, DataHora[1]); // Dia
	TextDrawShowForPlayer(playerid, DataHora[2]); // Hora
}
stock function TD::HidePlayerHudData(playerid)
{
	TextDrawHideForPlayer(playerid, DataHora[0]); // Data
	TextDrawHideForPlayer(playerid, DataHora[1]); // Dia
	TextDrawHideForPlayer(playerid, DataHora[2]); // Hora
}

stock function TD::ShowPlayerHudStatus(playerid)
{
	for(new i; i < sizeof(ExpOP[]); i++)
		PlayerTextDrawShow(playerid, ExpOP[playerid][i]);

	for(new i; i < sizeof(StatusOP[]); i++)
		PlayerTextDrawShow(playerid, StatusOP[playerid][i]);

	return true;
}
stock function TD::HidePlayerHudStatus(playerid)
{
	for(new i; i < sizeof(ExpOP[]); i++)
		PlayerTextDrawHide(playerid, ExpOP[playerid][i]);

	for(new i; i < sizeof(StatusOP[]); i++)
		PlayerTextDrawHide(playerid, StatusOP[playerid][i]);
	return true;
}

/**
* DIA DA SEMANA
*/
GetWeekDay(day=0, month=0, year=0)
{
	if (!day)
	getdate(year, month, day);

	new
		weekday_str[10],
		j,
		e
	;

	if (month <= 2)
	{
		month += 12;
		--year;
	}

	j = year % 100;
	e = year / 100;

	switch ((day + (month+1)*26/10 + j + j/4 + e/4 - 2*e) % 7)
	{
		case 0: weekday_str = "Sabado";
		case 1: weekday_str = "Domingo";
		case 2: weekday_str = "Segunda";
		case 3: weekday_str = "Terca";
		case 4: weekday_str = "Quarta";
		case 5: weekday_str = "Quinta";
		case 6: weekday_str = "Sexta";
	}

	return weekday_str;
}

function TD::UpdateTextDrawHud()
{
	new Dia, Mes, Ano, Hora, Minuto, __str[50], __str2[50], __str3[50];
	gettime(Hora, Minuto);
	getdate(Ano, Mes, Dia);
	format(__str, sizeof(__str), "%02d/%02d/%04d", Dia, Mes, Ano);
	TextDrawSetString(DataHora[1], __str);

	format(__str2, sizeof(__str2), "%02d:%02d", Hora, Minuto);
	TextDrawSetString(DataHora[2], __str2);

	format(__str3, sizeof(__str3), "%s", GetWeekDay());
	TextDrawSetString(DataHora[0], __str3);
	
	return 1;
}

//function TD::UpdateTextDrawPlayerHud(playerid)
//{
//	new str[30];
//	format(str, sizeof(str), "~b~%02d:%02d", Jogador[playerid][UPm], Jogador[playerid][UPs]);
//	//SendClientMessage(playerid, -1, str);
//	PlayerTextDrawSetString(playerid, HudTD[playerid][1], str);
//	
//	SetPlayerProgressBarValue(playerid, pBar[playerid][pBarFome], Jogador[playerid][Fome]);
//	SetPlayerProgressBarValue(playerid, pBar[playerid][pBarSede], Jogador[playerid][Sede]);
//	SetPlayerProgressBarValue(playerid, pBar[playerid][pBarSono], Jogador[playerid][Sono]);
//}

forward Timer@UP();
public Timer@UP()
{
	new query[255], _strporc[30];
	for(new i = 0; i < MAX_PLAYERS; i++) 
	{
		if(Jogador[i][AFK] == false)
		{
			Jogador[i][PorcLevel] = Jogador[i][PorcLevel]+1;

			if(Jogador[i][PorcLevel] < 100)
			{
				mysql_format(getConexao(), query, sizeof(query), "UPDATE `usuarios` SET `porc_level` = '%d' WHERE `username`='%s'", Jogador[i][PorcLevel], GetUserName(i));
				mysql_tquery(getConexao(), query);
			}

			if(Jogador[i][PorcLevel] > 100)
			{
				Jogador[i][PorcLevel] = 1;
				new level;
				level = GetPlayerScore(i)+1;

				SetPlayerScore(i, level);

				mysql_format(getConexao(), query, sizeof(query), "UPDATE `usuarios` SET `porc_level` = '%d', `level` = '%d' WHERE `username`='%s'", Jogador[i][PorcLevel], level, GetUserName(i));
				mysql_tquery(getConexao(), query);

					

				SendClientMessage(i, COR_VERDE_CLARO, "| NÍVEL | Você acumulou 100%s de experiência e subiu para o nível %d!", "%%", level);
				GameTextForPlayer(i, "~g~~h~up!", 3000, 6);
			}
			format(_strporc, sizeof(_strporc), "%d%", Jogador[i][PorcLevel]);
			PlayerTextDrawSetString(i, ExpOP[i][0], _strporc);
		}
	}
	return 1;
}

/**
* SISTEMA FOME SEDE SONO
*/

forward Timer@SEDE(playerid);
public Timer@SEDE(playerid)
{
	new String[255];

	if(Jogador[playerid][Sede] == 0) { return SetPlayerHealth(playerid, 0); }

	if(Jogador[playerid][Fome] > 100) { Jogador[playerid][Sede] = 100; }

	Jogador[playerid][Sede]--;
	format(String, sizeof(String), "%d%", Jogador[playerid][Sede]);
	PlayerTextDrawSetString(playerid, StatusOP[playerid][4], String);
	if(Jogador[playerid][Sede] < 21)
	{
		SendClientMessage(playerid, COR_AMARELO, "| AVISO | Seu personagem está com muita Sede, vá até um Restaurante para beber!");
		new Float:health;
		GetPlayerHealth(playerid, health);

		SetPlayerHealth(playerid, health-10);
		return 1;
	}
	return 1;
}

forward Timer@FOME(playerid);
public Timer@FOME(playerid)
{
	new String[255];

	if(Jogador[playerid][Fome] == 0) { return SetPlayerHealth(playerid, 0); }

	if(Jogador[playerid][Fome] > 100) { Jogador[playerid][Fome] = 100; }
	Jogador[playerid][Fome]--;
	format(String, sizeof(String), "%d%", Jogador[playerid][Fome]);
	PlayerTextDrawSetString(playerid, StatusOP[playerid][3], String);
	if(Jogador[playerid][Fome] < 21)
	{
		SendClientMessage(playerid, COR_AMARELO, "| AVISO | Seu personagem está com muita Fome, vá até um Restaurante para comer!");

		new Float:health;
		GetPlayerHealth(playerid, health);

		SetPlayerHealth(playerid, health-10);
		return 1;
	}
	return 1;
}

forward Timer@SONO(playerid);
public Timer@SONO(playerid)
{
	new String[255];

	if(Jogador[playerid][Sono] == 0) { return SetPlayerHealth(playerid, 0); }

	if(Jogador[playerid][Sono] > 100) { Jogador[playerid][Sono] = 100; }
	Jogador[playerid][Sono]--;
	format(String, sizeof(String), "%d%", Jogador[playerid][Sono]);
	PlayerTextDrawSetString(playerid, StatusOP[playerid][5], String);

	if(Jogador[playerid][Sono] < 21)
	{
		SendClientMessage(playerid, COR_AMARELO, "| AVISO | Seu personagem está com muito Sono, vá até um Hotel/Casa para dormir!");
		return 1;
	}

	if(Jogador[playerid][Sono] == 0)
	{
		TogglePlayerControllable(playerid, false);
		call::PLAYER->SetPlayerVarInt(playerid, pDormindo, 1);

		call::PLAYER->InitPlayerFadeEffect(playerid);
		ApplyAnimation(playerid, "CRACK", "CRCKIDLE2", 4.1, 1, 1, 1, 1, 0);

		SendClientMessage(playerid, COR_AZUL, "| SONO | Seu personagem caiu no sono... Use: /Acordar para acordar.");
	}
	return 1;
}

forward AttFSS(playerid);
public AttFSS(playerid)
{
	if(Jogador[playerid][Fome] > 100) { Jogador[playerid][Sede] = 100; }
	if(Jogador[playerid][Fome] > 100) { Jogador[playerid][Fome] = 100; }
	if(Jogador[playerid][Sono] > 100) { Jogador[playerid][Sono] = 100; }

	//if(GetPlayerInterior(playerid) == 0 && GetPlayerVirtualWorld(playerid) != 0) { SetPlayerVirtualWorld(playerid, 0); }

	AtualizarFSS(playerid);
	return 1;
}


forward AtualizarFSS(playerid);
public AtualizarFSS(playerid)
{
	new String[50];

	
	format(String, sizeof(String), "%d%", Jogador[playerid][Fome]);
	PlayerTextDrawSetString(playerid, StatusOP[playerid][3], String);

	format(String, sizeof(String), "%d%", Jogador[playerid][Sede]);
	PlayerTextDrawSetString(playerid, StatusOP[playerid][4], String);

	format(String, sizeof(String), "%d%", Jogador[playerid][Sono]);
	PlayerTextDrawSetString(playerid, StatusOP[playerid][5], String);
	return 1;
}