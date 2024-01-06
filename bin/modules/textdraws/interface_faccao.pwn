#include <YSI_Coding\y_hooks>

static const COLOR_HOVER = -2147483393;

static Text:TDEditor_TD[16], PlayerText:TDEditor_PTD[MAX_PLAYERS][7], Showed[MAX_PLAYERS char];

hook OnGameModeInit()
{
	TDEditor_TD[0] = TextDrawCreate(195.411651, 125.833343, "box");
	TextDrawLetterSize(TDEditor_TD[0], 0.000000, 24.261716);
	TextDrawTextSize(TDEditor_TD[0], 455.000000, 0.000000);
	TextDrawAlignment(TDEditor_TD[0], 1);
	TextDrawColor(TDEditor_TD[0], -1);
	TextDrawUseBox(TDEditor_TD[0], 1);
	TextDrawBoxColor(TDEditor_TD[0], 150);
	TextDrawSetShadow(TDEditor_TD[0], 0);
	TextDrawSetOutline(TDEditor_TD[0], 0);
	TextDrawBackgroundColor(TDEditor_TD[0], 255);
	TextDrawFont(TDEditor_TD[0], 1);
	TextDrawSetProportional(TDEditor_TD[0], 1);
	TextDrawSetShadow(TDEditor_TD[0], 0);

	TDEditor_TD[1] = TextDrawCreate(195.411819, 125.949996, "box");
	TextDrawLetterSize(TDEditor_TD[1], 0.000000, 1.341168);
	TextDrawTextSize(TDEditor_TD[1], 455.000000, 0.000000);
	TextDrawAlignment(TDEditor_TD[1], 1);
	TextDrawColor(TDEditor_TD[1], -1);
	TextDrawUseBox(TDEditor_TD[1], 1);
	TextDrawBoxColor(TDEditor_TD[1], 0x3C3C3CFF);
	TextDrawSetShadow(TDEditor_TD[1], 0);
	TextDrawSetOutline(TDEditor_TD[1], 0);
	TextDrawBackgroundColor(TDEditor_TD[1], 255);
	TextDrawFont(TDEditor_TD[1], 1);
	TextDrawSetProportional(TDEditor_TD[1], 1);
	TextDrawSetShadow(TDEditor_TD[1], 0);

	TDEditor_TD[2] = TextDrawCreate(433.793518, 123.500038, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[2], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[2], 19.000000, 16.630014);
	TextDrawAlignment(TDEditor_TD[2], 1);
	TextDrawColor(TDEditor_TD[2], 0x3C3C3CFF);
	TextDrawSetShadow(TDEditor_TD[2], 0);
	TextDrawSetOutline(TDEditor_TD[2], 0);
	TextDrawBackgroundColor(TDEditor_TD[2], 255);
	TextDrawFont(TDEditor_TD[2], 4);
	TextDrawSetProportional(TDEditor_TD[2], 0);
	TextDrawSetShadow(TDEditor_TD[2], 0);

	TDEditor_TD[3] = TextDrawCreate(436.264465, 126.799934, "X");
	TextDrawLetterSize(TDEditor_TD[3], 0.583056, 1.121665);
	TextDrawAlignment(TDEditor_TD[3], 1);
	TextDrawColor(TDEditor_TD[3], -1);
	TextDrawSetShadow(TDEditor_TD[3], 0);
	TextDrawSetOutline(TDEditor_TD[3], 1);
	TextDrawBackgroundColor(TDEditor_TD[3], 0);
	TextDrawFont(TDEditor_TD[3], 1);
	TextDrawSetProportional(TDEditor_TD[3], 1);
	TextDrawSetShadow(TDEditor_TD[3], 0);
	TextDrawSetSelectable(TDEditor_TD[3], true);

	TDEditor_TD[4] = TextDrawCreate(322.052642, 181.099945, "-");
	TextDrawLetterSize(TDEditor_TD[4], 18.000000, 0.335000);
	TextDrawAlignment(TDEditor_TD[4], 2);
	TextDrawColor(TDEditor_TD[4], -1);
	TextDrawSetShadow(TDEditor_TD[4], 0);
	TextDrawSetOutline(TDEditor_TD[4], 0);
	TextDrawBackgroundColor(TDEditor_TD[4], 255);
	TextDrawFont(TDEditor_TD[4], 1);
	TextDrawSetProportional(TDEditor_TD[4], 1);
	TextDrawSetShadow(TDEditor_TD[4], 0);

	TDEditor_TD[5] = TextDrawCreate(325.294097, 148.583404, "Gerencie sua faccao aqui");
	TextDrawLetterSize(TDEditor_TD[5], 0.246588, 1.063333);
	TextDrawAlignment(TDEditor_TD[5], 2);
	TextDrawColor(TDEditor_TD[5], -1);
	TextDrawSetShadow(TDEditor_TD[5], 1);
	TextDrawSetOutline(TDEditor_TD[5], 0);
	TextDrawBackgroundColor(TDEditor_TD[5], 255);
	TextDrawFont(TDEditor_TD[5], 1);
	TextDrawSetProportional(TDEditor_TD[5], 1);
	TextDrawSetShadow(TDEditor_TD[5], 1);

	TDEditor_TD[6] = TextDrawCreate(195.823608, 195.233566, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[6], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[6], 54.000000, 16.000000);
	TextDrawAlignment(TDEditor_TD[6], 1);
	TextDrawColor(TDEditor_TD[6], 0);
	TextDrawSetShadow(TDEditor_TD[6], 0);
	TextDrawSetOutline(TDEditor_TD[6], 0);
	TextDrawBackgroundColor(TDEditor_TD[6], 255);
	TextDrawFont(TDEditor_TD[6], 4);
	TextDrawSetProportional(TDEditor_TD[6], 0);
	TextDrawSetShadow(TDEditor_TD[6], 0);

	TDEditor_TD[7] = TextDrawCreate(222.743942, 198.050064, "Membros");
	TextDrawLetterSize(TDEditor_TD[7], 0.239999, 1.109999);
	TextDrawAlignment(TDEditor_TD[7], 2);
	TextDrawColor(TDEditor_TD[7], -1);
	TextDrawSetShadow(TDEditor_TD[7], 1);
	TextDrawSetOutline(TDEditor_TD[7], 0);
	TextDrawBackgroundColor(TDEditor_TD[7], 255);
	TextDrawFont(TDEditor_TD[7], 1);
	TextDrawSetProportional(TDEditor_TD[7], 1);
	TextDrawSetShadow(TDEditor_TD[7], 1);
	TextDrawSetSelectable(TDEditor_TD[7], true);

	TDEditor_TD[8] = TextDrawCreate(195.823608, 215.184051, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[8], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[8], 54.000000, 16.000000);
	TextDrawAlignment(TDEditor_TD[8], 1);
	TextDrawColor(TDEditor_TD[8], 0);
	TextDrawSetShadow(TDEditor_TD[8], 0);
	TextDrawSetOutline(TDEditor_TD[8], 0);
	TextDrawBackgroundColor(TDEditor_TD[8], 255);
	TextDrawFont(TDEditor_TD[8], 4);
	TextDrawSetProportional(TDEditor_TD[8], 0);
	TextDrawSetShadow(TDEditor_TD[8], 0);
	TextDrawSetSelectable(TDEditor_TD[8], true);

	TDEditor_TD[9] = TextDrawCreate(222.743942, 217.550292, "Cofre");
	TextDrawLetterSize(TDEditor_TD[9], 0.239999, 1.109999);
	TextDrawAlignment(TDEditor_TD[9], 2);
	TextDrawColor(TDEditor_TD[9], -1);
	TextDrawSetShadow(TDEditor_TD[9], 1);
	TextDrawSetOutline(TDEditor_TD[9], 0);
	TextDrawBackgroundColor(TDEditor_TD[9], 255);
	TextDrawFont(TDEditor_TD[9], 1);
	TextDrawSetProportional(TDEditor_TD[9], 1);
	TextDrawSetShadow(TDEditor_TD[9], 1);
	TextDrawSetSelectable(TDEditor_TD[9], true);

	TDEditor_TD[10] = TextDrawCreate(195.823608, 234.884552, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[10], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[10], 54.000000, 16.000000);
	TextDrawAlignment(TDEditor_TD[10], 1);
	TextDrawColor(TDEditor_TD[10], 0);
	TextDrawSetShadow(TDEditor_TD[10], 0);
	TextDrawSetOutline(TDEditor_TD[10], 0);
	TextDrawBackgroundColor(TDEditor_TD[10], 255);
	TextDrawFont(TDEditor_TD[10], 4);
	TextDrawSetProportional(TDEditor_TD[10], 0);
	TextDrawSetShadow(TDEditor_TD[10], 0);

	TDEditor_TD[11] = TextDrawCreate(222.743942, 237.801528, "Armamentos");
	TextDrawLetterSize(TDEditor_TD[11], 0.239999, 1.109999);
	TextDrawAlignment(TDEditor_TD[11], 2);
	TextDrawColor(TDEditor_TD[11], -1);
	TextDrawSetShadow(TDEditor_TD[11], 1);
	TextDrawSetOutline(TDEditor_TD[11], 0);
	TextDrawBackgroundColor(TDEditor_TD[11], 255);
	TextDrawFont(TDEditor_TD[11], 1);
	TextDrawSetProportional(TDEditor_TD[11], 1);
	TextDrawSetShadow(TDEditor_TD[11], 1);
	TextDrawSetSelectable(TDEditor_TD[11], true);

	TDEditor_TD[12] = TextDrawCreate(195.823608, 254.584777, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[12], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[12], 54.000000, 16.000000);
	TextDrawAlignment(TDEditor_TD[12], 1);
	TextDrawColor(TDEditor_TD[12], 0);
	TextDrawSetShadow(TDEditor_TD[12], 0);
	TextDrawSetOutline(TDEditor_TD[12], 0);
	TextDrawBackgroundColor(TDEditor_TD[12], 255);
	TextDrawFont(TDEditor_TD[12], 4);
	TextDrawSetProportional(TDEditor_TD[12], 0);
	TextDrawSetShadow(TDEditor_TD[12], 0);

	TDEditor_TD[13] = TextDrawCreate(222.743942, 257.501434, "Drogas");
	TextDrawLetterSize(TDEditor_TD[13], 0.239999, 1.109999);
	TextDrawAlignment(TDEditor_TD[13], 2);
	TextDrawColor(TDEditor_TD[13], -1);
	TextDrawSetShadow(TDEditor_TD[13], 1);
	TextDrawSetOutline(TDEditor_TD[13], 0);
	TextDrawBackgroundColor(TDEditor_TD[13], 255);
	TextDrawFont(TDEditor_TD[13], 1);
	TextDrawSetProportional(TDEditor_TD[13], 1);
	TextDrawSetShadow(TDEditor_TD[13], 1);
	TextDrawSetSelectable(TDEditor_TD[13], true);

	TDEditor_TD[14] = TextDrawCreate(322.052642, 290.952239, "-");
	TextDrawLetterSize(TDEditor_TD[14], 18.000000, 0.335000);
	TextDrawAlignment(TDEditor_TD[14], 2);
	TextDrawColor(TDEditor_TD[14], -1);
	TextDrawSetShadow(TDEditor_TD[14], 0);
	TextDrawSetOutline(TDEditor_TD[14], 0);
	TextDrawBackgroundColor(TDEditor_TD[14], 255);
	TextDrawFont(TDEditor_TD[14], 1);
	TextDrawSetProportional(TDEditor_TD[14], 1);
	TextDrawSetShadow(TDEditor_TD[14], 0);

	TDEditor_TD[15] = TextDrawCreate(325.293914, 188.550231, "Zonas dominadas");
	TextDrawLetterSize(TDEditor_TD[15], 0.253176, 1.203332);
	TextDrawTextSize(TDEditor_TD[15], 0.000000, 82.000000);
	TextDrawAlignment(TDEditor_TD[15], 2);
	TextDrawColor(TDEditor_TD[15], -1);
	TextDrawUseBox(TDEditor_TD[15], 0);
	TextDrawBoxColor(TDEditor_TD[15], 255);
	TextDrawSetShadow(TDEditor_TD[15], 0);
	TextDrawSetOutline(TDEditor_TD[15], 0);
	TextDrawBackgroundColor(TDEditor_TD[15], 255);
	TextDrawFont(TDEditor_TD[15], 1);
	TextDrawSetProportional(TDEditor_TD[15], 1);
	TextDrawSetShadow(TDEditor_TD[15], 0);
}


hook OnPlayerConnect(playerid)
{
	for(new i; i < sizeof(TDEditor_PTD[]); i++)
		TDEditor_PTD[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if ( !Showed{playerid} || Dialog_Opened(playerid))
		return Y_HOOKS_CONTINUE_RETURN_1;

	if ( INVALID_TEXT_DRAW == _:clickedid || clickedid == TDEditor_TD[3]) // close textdraw
	{
		call::TD->HidePlayerMenuFaction(playerid);
		return Y_HOOKS_CONTINUE_RETURN_1;
	}

	SoundForPlayer(playerid, SOUND_CLICK_SUCESS);

	if ( clickedid == TDEditor_TD[7] ) // Membros
	{
		new info[MAX_PLAYER_NAME * 100], query[128], faction_id = call::PLAYER->GetPlayerVarInt(playerid, pFaccao), pName[MAX_PLAYER_NAME], _cargo;
		
		if ( faction_id == INVALID_FACTION_ID )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode fazer isso.");

		mysql_format(getConexao(), query, sizeof(query), "SELECT username, cargo_faccao FROM "TABLE_USERS" WHERE `faccao`='%d' LIMIT %d", Faccao[faction_id][RowId], Faccao[faction_id][MaxMembros]);
		new Cache:c = mysql_query(getConexao(), query, true), rows = cache_num_rows();
		if ( rows )
		{
			for(new i; i < rows; i++)
			{
				cache_get_value_name(i, "username", pName);
				cache_get_value_name_int(i, "cargo_faccao", _cargo);
				format(info, sizeof(info), "%s%s\t{22423D}%s\n", info, pName, Cargo[faction_id][_cargo]);
			}
		}
		ShowPlayerDialog(playerid, _MEMBERS_FACTION_, DIALOG_STYLE_TABLIST, "{0C6275}MEMBROS", info, "Selecionar", "Fechar");
		cache_delete(c);
		return Y_HOOKS_CONTINUE_RETURN_1;
	}
	else if ( clickedid == TDEditor_TD[9] ) // Cofre
	{
		new faction_id = call::PLAYER->GetPlayerVarInt(playerid, pFaccao);
		
		if ( faction_id == INVALID_FACTION_ID )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode fazer isso.");
		
		ShowPlayerDialog(playerid, FACTION_COFRE_SAQUE, DIALOG_STYLE_INPUT, "COFRE DA FACÇÃO", "{"COR_BRANCO_INC"}Cofre: {"COR_VERDE_INC"}R$%s", "Sacar", "Fechar", RealStr(Faccao[faction_id][Cofre]));
		return Y_HOOKS_CONTINUE_RETURN_1;
	}
	else if ( clickedid == TDEditor_TD[11] ) // Armamentos
	{
		new faction_id = call::PLAYER->GetPlayerVarInt(playerid, pFaccao);
		
		if ( faction_id == INVALID_FACTION_ID )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode fazer isso.");
		
		ShowPlayerDialog(playerid, FACTION_ARMAMENTO_DEPOSITAR, DIALOG_STYLE_INPUT, "PEÇAS DA FACÇÃO", "{"COR_BRANCO_INC"}Digite a quantidade de peças de armamento que queira depositar.", "Depositar", "Fechar");
		return Y_HOOKS_CONTINUE_RETURN_1;
	}
	else if ( clickedid == TDEditor_TD[13] ) // Drogas
	{
		new faction_id = call::PLAYER->GetPlayerVarInt(playerid, pFaccao);
		
		if ( faction_id == INVALID_FACTION_ID )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode fazer isso.");
		
		ShowPlayerDialog(playerid, FACTION_DROGAS_DEPOSITAR, DIALOG_STYLE_INPUT, "DROGAS DA FACÇÃO", "{"COR_BRANCO_INC"}Digite a quantidade de peças de drogas que queira depositar.", "Depositar", "Fechar");
		return Y_HOOKS_CONTINUE_RETURN_1;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

// ============================== [ Functions ] ============================== //

stock function TD::ShowPlayerMenuFaction(playerid)
{
	if ( Showed{playerid} )
		return false;

	Showed{playerid} = true;

	new faction_id = call::PLAYER->GetPlayerVarInt(playerid, pFaccao), str[100];

	TDEditor_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 198.917694, 123.483345, Faccao[faction_id][Nome]);
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][0], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][0], 1);


	format(str, sizeof(str), "Level: ~b~%d", Faccao[faction_id][Level]);
	TDEditor_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 197.847213, 164.916625, str);
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][1], 0.232470, 0.777500);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][1], 243.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][1], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][1], 0);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][1], 1);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][1], 1);

	format(str, sizeof(str), "Armamento: ~b~%d", Faccao[faction_id][Armamentos]);
	TDEditor_PTD[playerid][2] = CreatePlayerTextDraw(playerid, 251.847763, 165.499954, str);
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][2], 0.232470, 0.777500);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][2], 325.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][2], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][2], 0);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][2], 1);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][2], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][2], 1);

	format(str, sizeof(str), "Baseid: ~b~%d", Faccao[faction_id][BaseID]);
	TDEditor_PTD[playerid][3] = CreatePlayerTextDraw(playerid, 333.448577, 164.916625, str);
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][3], 0.232470, 0.777500);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][3], 382.800048, 0.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][3], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][3], 0);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][3], 1);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][3], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][3], 1);

	format(str, sizeof(str), "Drogas: ~b~%d", Faccao[faction_id][Drogas]);
	TDEditor_PTD[playerid][4] = CreatePlayerTextDraw(playerid, 392.849182, 164.916625, str);
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][4], 0.232470, 0.777500);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][4], 452.200073, 0.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][4], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][4], 0);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][4], 1);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][4], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][4], 1);

	TDEditor_PTD[playerid][5] = CreatePlayerTextDraw(playerid, 369.470703, 192.333343, "");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][5], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][5], 90.000000, 90.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][5], 0);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][5], 5);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, TDEditor_PTD[playerid][5], true);
	PlayerTextDrawSetPreviewModel(playerid, TDEditor_PTD[playerid][5], 107);
	PlayerTextDrawSetPreviewRot(playerid, TDEditor_PTD[playerid][5], 0.000000, 0.000000, 0.000000, 1.000000);

	TDEditor_PTD[playerid][6] = CreatePlayerTextDraw(playerid, 262.235778, 206.333267, "Nenhuma.");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][6], 0.233882, 0.917498);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][6], 383.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][6], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][6], 0);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][6], 255);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][6], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][6], 0);

	for(new i; i < sizeof(TDEditor_PTD[]); i++)
		PlayerTextDrawShow(playerid, TDEditor_PTD[playerid][i]);

	for(new i; i < sizeof(TDEditor_TD); i++)
		TextDrawShowForPlayer(playerid, TDEditor_TD[i]);

	SelectTextDraw(playerid, COLOR_HOVER);
	return true;
}

stock function TD::HidePlayerMenuFaction(playerid)
{
	if ( Showed{playerid} )
	{
		for(new i; i < sizeof(TDEditor_PTD[]); i++)
		{
			PlayerTextDrawDestroy(playerid, TDEditor_PTD[playerid][i]);
			TDEditor_PTD[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
		}

		for(new i; i < sizeof(TDEditor_TD); i++)
			TextDrawHideForPlayer(playerid, TDEditor_TD[i]);

		Showed{playerid} = false;
		CancelSelectTextDraw(playerid);
		return true;
	}
	return false;
}