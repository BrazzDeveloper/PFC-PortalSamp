CMD:infocasa(playerid)
{
	if(call::HOUSE->IsPlayerInHouse(playerid, 2.0))
	{
		ShowPlayerInfoHouse(playerid);
		return true;
	}
	return true;
}

CMD:menucasa(playerid)
{
	new casaid = call::HOUSE->GetHouseIdInRange(playerid, 2.0);
	
	if ( casaid == INVALID_HOUSE_ID )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em uma casa");

	if( Jogador[playerid][PlayerID] != Casa[casaid][Owner][Id] )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário desta casa.");

	ShowPlayerMenuHouse(playerid, casaid);
	return true;
}

CMD:comprarcasa(playerid)
{
	if(GetPlayerScore(playerid) < 25) 
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem level suficiente para comprar uma casa.");
	
	if( call::HOUSE->IsPlayerInHouse(playerid, 2.0) )
	{
		new casaid = call::HOUSE->GetHouseIdInRange(playerid, 2.0);
		if ( Casa[casaid][Owner][Id] == Jogador[playerid][PlayerID] )
		{
			SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já é dono de uma casa.");
			return 0;
		}

		if ( Casa[casaid][ID] == Jogador[playerid][pMorador] )
		{
			SendClientMessage(playerid, COR_ERRO, "| ERRO | Você tem um quarto alugado.");
			return 0;
		}

		call::HOUSE->ShowPlayerBuyHouse(playerid, casaid);
		return true;
	}
	return true;
}

CMD:trancarcasa(playerid)
{
	new casaid = call::HOUSE->GetHouseIdInRange(playerid, 2.0);

	if(casaid != GetPlayerHouse(playerid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui a chave desta casa.");

	if(call::HOUSE->GetHouseParamInt(casaid, Trancado))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | A casa já está trancada.");

	call::HOUSE->SetHouseParamInt(casaid, Trancado, true);
	SendClientMessage(playerid, COR_SISTEMA, "CASA: {"COR_BRANCO_INC"}Você {"COR_VERDE_INC"}trancou{"COR_BRANCO_INC"} a casa.");

	new query[128];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_HOUSES" SET `trancado`='1' WHERE `id`='%d' LIMIT 1;", call::HOUSE->GetHouseParamInt(casaid, ID));
	mysql_tquery(getConexao(), query);

	return true;
}

CMD:destrancarcasa(playerid)
{
	new casaid = call::HOUSE->GetHouseIdInRange(playerid, 2.0);
	
	if( casaid != GetPlayerHouse(playerid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui a chave desta casa.");

	if(!call::HOUSE->GetHouseParamInt(casaid, Trancado))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | A Casa já está destrancada.");

	call::HOUSE->SetHouseParamInt(casaid, Trancado, false);
	SendClientMessage(playerid, COR_SISTEMA, "CASA: {"COR_BRANCO_INC"}Você {"COR_ERRO_INC"}destrancou{"COR_BRANCO_INC"} a casa.");

	new query[128];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_HOUSES" SET `trancado`='0' WHERE `id`='%d' LIMIT 1;", call::HOUSE->GetHouseParamInt(casaid, ID));
	mysql_tquery(getConexao(), query);

	return true;
}

CMD:alugarquarto(playerid)
{
	if ( GetPlayerHouse(playerid) != INVALID_HOUSE_ID ){
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já tem uma casa.");
		return 0;
	}

	new casaid = call::HOUSE->GetHouseIdInRange(playerid, 3.0);
	if ( casaid == INVALID_HOUSE_ID ){
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de uma casa.");
		return 0;
	}

	if ( !Casa[casaid][Owner][Id] )
	{
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Essa casa ainda não tem proprietário, tente encontrar uma casa com um proprietário para alugar um quarto.");
		return 0;
	}

	if ( !Casa[casaid][Alugavel] )
	{
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Está casa não está com aluguel de quartos ativada.");
		return 0;
	}

	if ( call::HOUSE->CountMoradores(casaid) >= GetInteriorSlots(Casa[casaid][InteriorID])){
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Essa casa já não tem mais quartos disponíveis.");
		return 0;
	}

	new query[128];

	Jogador[playerid][pMorador] = Casa[casaid][ID];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `morador_casa_id`='%d' WHERE `id`='%d' LIMIT 1;", Casa[casaid][ID], Jogador[playerid][PlayerID]);
	mysql_query(getConexao(), query, false);
	
	UpdateHouseLabel(casaid);

	SendClientMessage(playerid, COR_SISTEMA, "[!] Você alugou um quarto localizado em {"COR_LARANJA_INC"}%s{"COR_SISTEMA_INC"}.", call::HOUSE->GetHouseLocalName(casaid));
	return 1;
}

CMD:desalugarquarto(playerid)
{
	if ( GetPlayerHouse(playerid) == INVALID_HOUSE_ID ){
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem um quarto alugado.");
		return 0;
	}

	new casaid = call::HOUSE->GetHouseIdInRange(playerid, 3.0);
	if ( casaid == INVALID_HOUSE_ID ){
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de uma casa.");
		return 0;
	}

	new query[128];

	Jogador[playerid][pMorador] = 0;
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `morador_casa_id`='0' WHERE `id`='%d' LIMIT 1;", Jogador[playerid][PlayerID]);
	mysql_query(getConexao(), query, false);
	
	UpdateHouseLabel(casaid);

	SendClientMessage(playerid, COR_SISTEMA, "[!] Quarto desalugado com sucesso.");
	return 1;
}

CMD:entrar(playerid)
{
	if ( IsPlayerInAnyVehicle(playerid) )
	{
		foreach(new i: Garagens)
		{
			if ( IsPlayerInRangeOfPoint(playerid, 5.0, Casa[i][Garagem][vEntrada][X], Casa[i][Garagem][vEntrada][Y], Casa[i][Garagem][vEntrada][Z]) )
			{
				if ( Casa[i][Garagem][Trancado] )
				{
					GameTextForPlayer(playerid, "~r~GARAGEM TRANCADA", 3000, 4);
					return 0;
				}
				Teleport(
					playerid,
					Casa[i][Garagem][vSaida][X],
					Casa[i][Garagem][vSaida][Y],
					Casa[i][Garagem][vSaida][Z],
					Casa[i][Garagem][vSaida][A],
					0,
					i,
					ENTROU_GARAGEM,
					true
				);
				return 0;
			}
		}
	}
	else
	{
		foreach(new i: Garagens)
		{
			if ( IsPlayerInRangeOfPoint(playerid, 2.2, Casa[i][Garagem][pEntrada][X], Casa[i][Garagem][pEntrada][Y], Casa[i][Garagem][pEntrada][Z]) )
			{
				if ( Casa[i][Garagem][Trancado] )
				{
					GameTextForPlayer(playerid, "~r~GARAGEM TRANCADA", 3000, 4);
					return 0;
				}
				Teleport(
					playerid,
					Casa[i][Garagem][pSaida][X],
					Casa[i][Garagem][pSaida][Y],
					Casa[i][Garagem][pSaida][Z],
					Casa[i][Garagem][pSaida][A],
					0,
					i,
					ENTROU_GARAGEM
				);
				return Y_HOOKS_BREAK_RETURN_1;
			}
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

CMD:sair(playerid)
{
	if ( IsPlayerInAnyVehicle(playerid) )
	{
		foreach(new i: Garagens)
		{
			if ( IsPlayerInRangeOfPoint(playerid, 5.0, Casa[i][Garagem][vSaida][X], Casa[i][Garagem][vSaida][Y], Casa[i][Garagem][vSaida][Z]) && GetPlayerVirtualWorld(playerid) == i)
			{
				if ( Casa[i][Garagem][Trancado] )
				{
					GameTextForPlayer(playerid, "~r~GARAGEM TRANCADA", 3000, 4);
					return 0;
				}
				Teleport(
					playerid,
					Casa[i][Garagem][vEntrada][X],
					Casa[i][Garagem][vEntrada][Y],
					Casa[i][Garagem][vEntrada][Z],
					Casa[i][Garagem][vEntrada][A],
					0,
					0,
					ENTROU_NONE,
					true
				);
				return 0;
			}
		}
	}
	else
	{
		foreach(new i: Garagens)
		{
			if ( IsPlayerInRangeOfPoint(playerid, 2.2, Casa[i][Garagem][pSaida][X], Casa[i][Garagem][pSaida][Y], Casa[i][Garagem][pSaida][Z]) && GetPlayerVirtualWorld(playerid) == i)
			{
				Teleport(
					playerid,
					Casa[i][Garagem][pEntrada][X],
					Casa[i][Garagem][pEntrada][Y],
					Casa[i][Garagem][pEntrada][Z],
					Casa[i][Garagem][pEntrada][A],
					0,
					0,
					ENTROU_NONE
				);
				return 0;
			}
		}
		return 0;
	}
	return 1;
}