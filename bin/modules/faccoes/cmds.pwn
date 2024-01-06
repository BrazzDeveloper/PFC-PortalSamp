
/**
*
*	#	Comando para criação da facção in game 	-
*
**/
/*CMD:criarfaccao(playerid)
{
	if ( call::PLAYER->GetPlayerVarInt(playerid, pFaccao) != INVALID_FACTION_ID )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já faz parte de uma facção.");

	if ( GetPlayerMoney(playerid) < CREATE_FACTION_VALUE )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente para criar uma facção.");

	ShowPlayerDialog(playerid, MENU_CREATE_FACTION, DIALOG_STYLE_TABLIST, "{"COR_AZUL_INC"}CRIAR FACÇÃO", "Nome\t%s\nCor\t{%s}%s\n{"COR_AZUL_INC"}Criar Facção", "Selecionar", "Sair", faccao@name, faccao@color, faccao@color);
	return true;
}*/


/**
*
*	#	Comando para dominar uma área.
*
**/
alias:dominar("do");
CMD:dominar(playerid)
{
	if ( call::PLAYER->GetPlayerVarInt(playerid, pFaccao) == INVALID_FACTION_ID )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte de uma facção para dominar territórios.");

	if ( !IsPlayerInGangeZone(playerid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em uma zona de guerra.");

	if ( call::PLAYER->GetPlayerVarInt(playerid, pCargo) > F_CARGO_3 )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão para usar este comando.");
	
	new faction_id = call::PLAYER->GetPlayerVarInt(playerid, pFaccao), gang_zone_id = getPlayerGangZoneId(playerid);

	if ( faction_id == getGangzoneFactionId(gang_zone_id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Sua facção já domina essa area.");

	if ( !GangZone[gang_zone_id][Liberado] )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode dominar esse território no momento, aguarde o próximo payday.");

	if ( faccao@timer_domination[gang_zone_id] != 0 )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Essa área já está em guerra.");

	SendClientMessageToAll(COR_VERMELHO, "A Facção {"COR_BRANCO_INC"}%s{"COR_VERMELHO_INC"} estão dominando o(a) {"COR_BRANCO_INC"}%s{"COR_VERMELHO_INC"} dominada pelo {"COR_BRANCO_INC"}%s{"COR_VERMELHO_INC"}.", Faccao[faction_id][Nome], GangZone[gang_zone_id][Nome], Faccao[getGangzoneFactionId(gang_zone_id)][Nome]);
	InitGangZoneDomination(gang_zone_id);

	/**
	*
	*	Guerra info
	*
	**/
	ShowPlayerGuerraInfo(playerid);

	faccao@UpdatePoints[gang_zone_id] = gettime() + 30;
	faccao@timer_domination[gang_zone_id] = SetTimerEx("OnFactionDominationArea", 100, false, "ddd", gang_zone_id, getGangzoneFactionId(gang_zone_id), faction_id);
	
	return true;
}

/**
*
*	Comando para administração da facção, utilizada somente por lideres e sub Lideres.
*
**/
CMD:menufaccao(playerid)
{
	if ( call::PLAYER->GetPlayerVarInt(playerid, pFaccao) == INVALID_FACTION_ID )
		return SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);

	if ( call::PLAYER->GetPlayerVarInt(playerid, pCargo) >= F_CARGO_3 )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão para usar este comando.");

	call::TD->ShowPlayerMenuFaction(playerid);
	return true;
}

CMD:convidarfaccao(playerid, params[]) {

	if ( call::PLAYER->GetPlayerVarInt(playerid, pFaccao) == INVALID_FACTION_ID ||
			call::PLAYER->GetPlayerVarInt(playerid, pCargo) >= F_CARGO_5 )
		return SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);

	if(isnull(params))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/convidarfaccao [playerid/username]");

	new id = strval(params);

	if(call::PLAYER->GetPlayerVarInt(id, pFaccao) != INVALID_FACTION_ID)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse jogador(a) já faz parte de uma facção.");

	call::PLAYER->SetPlayerVarInt(id, ConviteFaccao, call::PLAYER->GetPlayerVarInt(playerid, pFaccao));
	SendClientMessage(id, COR_AVISO, "[ ATENÇÂO ] Você esta sendo convidado para ingressar na facção %s.", Faccao[call::PLAYER->GetPlayerVarInt(playerid, pFaccao)][Nome]);
	SendClientMessage(id, COR_AVISO, "Digite /aceitarfaccao para aceitar");

	SendClientMessage(playerid, COR_AVISO, "Você esta convidando %s para sua facção, aguarde até que ele aceite o convite", GetUserName(id));

	return true;
}

CMD:aceitarfaccao(playerid) {

	if( call::PLAYER->GetPlayerVarInt(playerid, ConviteFaccao) == INVALID_FACTION_ID )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui um convite para facção.");

	if(call::PLAYER->GetPlayerVarInt(playerid, pFaccao) != INVALID_FACTION_ID)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já faz parte de uma facção.");

	new query[100];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `faccao`='%d',`cargo_faccao`='%d' WHERE `id`='%d'", call::PLAYER->GetPlayerVarInt(playerid, ConviteFaccao), 1, call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
	mysql_tquery(getConexao(), query);

	call::PLAYER->SetPlayerVarInt(playerid, pFaccao, call::PLAYER->GetPlayerVarInt(playerid, ConviteFaccao));

	SendClientMessage(playerid, COR_AVISO, "Você aceitou o convite para entrar na faccção %s", Faccao[call::PLAYER->GetPlayerVarInt(playerid, pFaccao)][Nome]);

	return true;
}

CMD:sairfaccao(playerid) {

	if ( call::PLAYER->GetPlayerVarInt(playerid, pFaccao) == INVALID_FACTION_ID )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte de uma facção.");

	if ( call::PLAYER->GetPlayerVarInt(playerid, pCargo) == F_CARGO_1 )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você é o lider da facção, use /excluirfaccao.");

	SendClientMessage(playerid, COR_AVISO, "Você saiu da facção %s.", Faccao[call::PLAYER->GetPlayerVarInt(playerid, pFaccao)][Nome]);
	call::PLAYER->SetPlayerVarInt(playerid, pFaccao, INVALID_FACTION_ID);
	return true;
}

CMD:excluirfaccao(playerid) {

	if ( call::PLAYER->GetPlayerVarInt(playerid, pFaccao) == INVALID_FACTION_ID )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte de uma facção.");

	if ( call::PLAYER->GetPlayerVarInt(playerid, pCargo) != F_CARGO_1 )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é o lider da facção, use /sairfaccao.");

	SendClientMessage(playerid, COR_ERRO, "[ ATENÇÂO ] Você saiu e excluiu a facção %s", Faccao[call::PLAYER->GetPlayerVarInt(playerid, pFaccao)][Nome]);
	DeleteFaction(call::PLAYER->GetPlayerVarInt(playerid, pFaccao));

	return true;
}

CMD:cf(playerid, params[])
{
	if( isnull(params) )
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/cf [mensagem]");

	checaXingamento(playerid, params);

	foreach(new i: Player)
	{
		if(call::PLAYER->GetPlayerVarInt(playerid, pFaccao) == call::PLAYER->GetPlayerVarInt(i, pFaccao))
		{
			SendClientMessage(i, Faccao[call::PLAYER->GetPlayerVarInt(playerid, pFaccao)][Cor], "[Chat Facção] %s[%d] disse: %s", GetUserName(playerid), playerid, params);
		}
	}
	return true;
}