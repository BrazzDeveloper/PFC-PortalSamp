/**
*
*		Modulo de criação de gangzones domináveis.
*
**/



#include <YSI_Coding\y_hooks>


/**
*
*	Forwards
*
**/
forward OnEnterGangZone();

/**
*
*	Variáveis
*
**/

static 	bool:gangzone@Showed[MAX_PLAYERS] = false,
		PlayerText:TDEditor_PTD[MAX_PLAYERS][3],
		bool:isShowed[MAX_PLAYERS]
;

// ============================== | FUNÇÕES | ============================== //

/**
*
*	# 	IsPlayerInGangeZone(playerid);	 #
*
*	@description: Função para checar se o jogador está em um zona de guerra ou não.
*	@params:
*		# playerid: o id do jogador que será checado.
*	@return: retorna verdadeiro se o jogador estiver em uma zona de guerra, e falso se não estiver.
*
**/
stock IsPlayerInGangeZone(playerid)
{
	foreach(new i: GangZone)
	{
		if ( IsPlayerInPlace(playerid, GangZone[i][Min_x], GangZone[i][Min_y], GangZone[i][Max_x], GangZone[i][Max_y]) )
			return true;
	}
	return false;
}

/**
*
*	# 	getGangzoneFactionId(area_id);	 #
*
*	@description: Função para obter o id da facção que domina a area.
*	@params:
*		# area_id: o id da area a ser verificada.
*	@return: retorna o id da facção se tudo ocorrer bem, e retorna INVALID_FACTION_ID se ocorrer erros.
*
**/
stock getGangzoneFactionId(area_id)
{
	if ( !Iter_Contains(GangZone, area_id) )
		return INVALID_FACTION_ID;

	return GetFactionIdByRowId(GangZone[area_id][FactionRowId]);
}

/**
*
*	# 	getPlayerGangZoneId(playerid);	 #
*
*	@description: Função para obter o id da gang zone em que o jogador está.
*	@params:
*		# playerid: id do jogador a ser verificado.
*	@return: retorna o id da gangzone.
*
**/
stock getPlayerGangZoneId(playerid)
{
	foreach(new i: GangZone)
	{
		if ( IsPlayerInPlace(playerid, GangZone[i][Min_x], GangZone[i][Min_y], GangZone[i][Max_x], GangZone[i][Max_y]) )
			return i;
	}
	return INVALID_GANG_ZONE;
}


/**
*
*	# 	InitGangZoneDomination(); 	#
*
*	@description: Função para iniciar a guerra na gangzone.
*	@params: null
*	@return: void.
*
**/
stock InitGangZoneDomination(gang_zone_id)
{
	if ( Iter_Contains(GangZone, gang_zone_id) )
	{
		GangZoneFlashForAll(GangZone[gang_zone_id][GangZoneID], 0xFF0000AA);
		GangZone[gang_zone_id][EmDominacao] = true;
	}
}


stock StopGangZoneDomination(gang_zone_id, faction_id)
{
	if ( Iter_Contains(GangZone, gang_zone_id) )
	{
		GangZoneStopFlashForAll(GangZone[gang_zone_id][GangZoneID]);
		GangZoneShowForAll(GangZone[gang_zone_id][GangZoneID], Faccao[faction_id][Cor]);
		
		foreach(new i: Player)
		{

			if ( getPlayerGangZoneId(i) == gang_zone_id)
				DestroyPlayerGuerraInfo(i);
		}

		GangZone[gang_zone_id][EmDominacao] = false;

		GangZone[gang_zone_id][FactionRowId] = Faccao[faction_id][RowId];
		GangZone[gang_zone_id][Color] = Faccao[faction_id][Cor];

		GangZone[gang_zone_id][Liberado] = false;
		
		foreach(new i: Player)
		{
			if ( call::PLAYER->GetPlayerVarInt(i, pFaccao) == faction_id )
			{
				GivePlayerMoney(i, 3000);
				SendClientMessage(i, COR_BRANCO, "* Você recebeu {"COR_VERDE_INC"}R$3.000{"COR_BRANCO_INC"} por dominar a gangzone {"COR_VERMELHO_INC"}%s{"COR_BRANCO_INC"}.", GangZone[gang_zone_id][Nome]);
			}
		}
		SendClientMessageToAll(COR_VERMELHO, "* {"COR_BRANCO_INC"}A Facção {696969}%s{"COR_BRANCO_INC"} dominou o(a) {696969}%s{"COR_BRANCO_INC"}", Faccao[faction_id][Nome], GangZone[gang_zone_id][Nome]);
		KillTimer(faccao@timer_domination[gang_zone_id]);
		faccao@timer_domination[gang_zone_id] = 0;
		
		new str[128];
		format(str, sizeof(str), "Local: {60A0C5}%s{FFFFFF}\nDono: {60A0C5}%s{FFFFFF}", GangZone[gang_zone_id][Nome], Faccao[faction_id][Nome]);
		UpdateDynamic3DTextLabelText(GangZone[gang_zone_id][Label], COR_BRANCO, str);

		/**
		*
		*	setar valores no banco de dados.
		*
		**/
		new query[255];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_GANGZONE" SET `faction_id`='%d',`cor`='%d' WHERE `id`='%d' LIMIT 1;", Faccao[faction_id][RowId], Faccao[faction_id][Cor], GangZone[gang_zone_id][ID]);
		mysql_tquery(getConexao(), query);
	}
}

/**
*
*   # ShowPlayerGuerraInfo(playerid);
*
*   @description: Mostra para o jogador uma interface/textdraw do "placa" da guerra.
*   @params:    
*       # playerid: id do jogador que será mostrado a interface/textdraw.
*   @return: retorna false se o jogador estiver desconectado e true se ocorrer tudo bem.
*
**/
stock ShowPlayerGuerraInfo(playerid)
{
    if ( !IsPlayerConnected(playerid) )
        return false;


    /**
    *
    *   verifica se a interface/textdraw já foi mostrada ao jogador. se sim, então então não é preciso cria-la novamente.
    *
    **/
    if ( !isShowed[playerid] )
    {
		TDEditor_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 143.647064, 352.166778, "box");
        PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][0], 0.000000, 6.423527);
        PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][0], 226.000000, 0.000000);
        PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][0], 1);
        PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][0], 100);
        PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][0], 1);
        PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][0], 100);
        PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][0], 0);
        PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][0], 0);
        PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][0], 255);
        PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][0], 1);
        PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][0], 1);
        PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][0], 0);

        TDEditor_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 145.529663, 357.416656, "_");
        PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][1], 0.190117, 1.080832);
        PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][1], 244.000000, 0.000000);
        PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][1], 1);
        PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][1], -1);
        PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][1], 1);
        PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][1], 0);
        PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][1], 0);
        PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][1], 0);
        PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][1], 255);
        PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][1], 2);
        PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][1], 1);
        PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][1], 0);

        TDEditor_PTD[playerid][2] = CreatePlayerTextDraw(playerid, 145.529663, 384.818328, "_");
        PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][2], 0.190117, 1.080832);
        PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][2], 244.000000, 0.000000);
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

        isShowed[playerid] = true;
    }
	PlayerTextDrawShow(playerid, TDEditor_PTD[playerid][0]);
	PlayerTextDrawShow(playerid, TDEditor_PTD[playerid][1]);
	PlayerTextDrawShow(playerid, TDEditor_PTD[playerid][2]);
    return true;
}

/**
*
*   # DestroyPlayerGuerraInfo(playerid);
*
*   @description: função para destruir a interface criada pela função ShowPlayerGuerraInfo(playerid).
*   @params: 
*       # playerid: o id do jogador que será destruida a interface.
*   @return: void. (não tem nenhum tipo de retorno)
*
**/
stock DestroyPlayerGuerraInfo(playerid)
{
    if ( isShowed[playerid] )
    {
        isShowed[playerid] = false;

        for(new i; i < sizeof(TDEditor_PTD[]); i++)
        {
            PlayerTextDrawDestroy(playerid, TDEditor_PTD[playerid][i]);
        }
    }
}

/**
*
*   # UpdateGuerraInfo(playerid, attack_point, defender_point);
*
*   @description: Atualizar a interface com os valores atuais da guera ao jogador.
*   @params:
*       # playerid: id do jogador.
*       # attack_point: ponto da facção atacante.
*       # defender_point: ponto da facção defensora.
*   @return: void. (não tem nenhum tipo de retorno)
*
**/
stock UpdateGuerraInfo(playerid, faction_id, index)
{
    new str[30];

    format(str, sizeof(str), "%s: %d", Faccao[faction_id][Nome], faccao@ponto[faction_id]);
    PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][index], str);
}


// ============================== | HOOKS | ============================== //

/**
*
*	OnGameModeInit -> Para carregar as gangzones do banco de dados.
*
**/
hook OnGameModeInit()
{
	print("[GangZone] Carregando Gang Zones.\n");

	new Cache:cache = mysql_query(getConexao(), "SELECT * FROM "TABLE_GANGZONE" WHERE 1;"), rows = cache_num_rows(), str[100];

	if ( rows )
	{
		for(new i; i < rows; i++)
		{
			Iter_Add(GangZone, i);

			cache_get_value_name_int(i, "id", GangZone[i][ID]);

			cache_get_value_name(i, "nome", GangZone[i][Nome], 70);

			cache_get_value_name_int(i, "faction_id", GangZone[i][FactionRowId]);

			cache_get_value_name_float(i, "min_x", GangZone[i][Min_x]);
			cache_get_value_name_float(i, "min_y", GangZone[i][Min_y]);
			cache_get_value_name_float(i, "max_x", GangZone[i][Max_x]);
			cache_get_value_name_float(i, "max_y", GangZone[i][Max_y]);

			cache_get_value_name_float(i, "ponto_x", GangZone[i][Ponto_x]);
			cache_get_value_name_float(i, "ponto_y", GangZone[i][Ponto_y]);
			cache_get_value_name_float(i, "ponto_z", GangZone[i][Ponto_z]);

			GangZone[i][EmDominacao] = false;
			GangZone[i][Liberado] = false;
			cache_get_value_name_int(i, "cor", GangZone[i][Color]);

			GangZone[i][GangZoneID] = GangZoneCreate(GangZone[i][Min_x], GangZone[i][Min_y], GangZone[i][Max_x], GangZone[i][Max_y]);
			
			new faction_id = GetFactionIdByRowId(GangZone[i][FactionRowId]);

			format(str, sizeof(str), "Local: {60A0C5}%s{FFFFFF}\nDono: {60A0C5}%s{FFFFFF}", GangZone[i][Nome], Faccao[faction_id][Nome]);
			GangZone[i][Label] =  CreateDynamic3DTextLabel(str, COR_BRANCO, GangZone[i][Ponto_x], GangZone[i][Ponto_y], GangZone[i][Ponto_z], 50.0, .streamdistance=50.0, .interiorid=0, .worldid=0);

			GangZone[i][Pickup] = CreateDynamicPickup(1313, 23, GangZone[i][Ponto_x], GangZone[i][Ponto_y], GangZone[i][Ponto_z], .streamdistance=50.0, .worldid=0, .interiorid=0);
		}
	}
	cache_delete(cache);
	return true;
}

/**
*
*	OnPlayerSpawn -> Para mostrar as gangzones ao player que spawnou.
*
**/
hook OnPlayerSpawn(playerid)
{
	if ( !gangzone@Showed[playerid] )
	{
		gangzone@Showed[playerid] = true;

		foreach(new i: GangZone)
		{
			GangZoneShowForAll(GangZone[i][GangZoneID], GangZone[i][Color]);
			
			/**
			*
			*	Se a zona estiver em guerra, então mostre-a em flash.
			*
			**/
			if ( GangZone[i][EmDominacao] )
				GangZoneFlashForAll(GangZone[i][GangZoneID], COR_VERMELHO);
			
		}
	}
	return true;
}

/**
*
*	OnPlayerDisconnect -> Para resetar as variáveis.
*
**/
hook OnPlayerDisconnect(playerid, reason)
{
	gangzone@Showed[playerid] = false;
}


/**
*
*	OnPlayerDeath -> Para contagem de pontos.
*
**/
hook OnPlayerDeath(playerid, killerid, reason)
{
	new gang_zone_id = getPlayerGangZoneId(playerid);

	if ( Iter_Contains(GangZone, gang_zone_id) )
	{
		new faction_id = call::PLAYER->GetPlayerVarInt(killerid, pFaccao);
		faccao@ponto[faction_id] += 3;
		DestroyPlayerGuerraInfo(playerid);
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}