forward OnFinishCreateGaragem(playerid, casaid);

flags:excluircasa(ADMINISTRADOR);
CMD:excluircasa(playerid, params[])
{
	if(isnull(params) || !IsNumeric(params))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/excluircasa [casaid]");

	new casaid = strval(params);
	if(call::HOUSE->IsValidHouse(casaid))
	{
		new query[128], str[70];
		mysql_format(getConexao(), query, sizeof(query), "DELETE FROM "TABLE_HOUSES" WHERE `id`='%d' LIMIT 1;", call::HOUSE->GetHouseParamInt(casaid, ID));
		mysql_tquery(getConexao(), query);

		SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Casa id %d deletada com sucesso!", casaid);
		call::HOUSE->DestroyHouse(casaid);
		DestroyGaragem(casaid);

		format(str, sizeof(str), "O(A) %s destroiu a casa id %d", GetUserName(playerid), casaid);
		WriteLog(FILE_DESTROY_HOUSE, str);
		return true;
	}
	SendClientMessage(playerid, COR_ERRO, "| ERRO | Você digitou um id inválido.");
	return true;
}


flags:editarcasa(MODERADOR);
CMD:editarcasa(playerid)
{
	new casaid = call::HOUSE->GetHouseIdInRange(playerid);
	
	if ( casaid == INVALID_HOUSE_ID )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de uma casa.");

	ShowPlayerDialog(playerid, ADM_GERENCIAR_CASA, DIALOG_STYLE_TABLIST, "GERENCIAR CASA", "Novo Interior\nLiberar Casa\nValor\nGaragem", "Selecionar", "Fechar");
	return true;
}


// ============================== [ DIALOGs ] ============================== //

new static Listitems[MAX_PLAYERS][100];

Dialog:ADM_GERENCIAR_CASA(playerid, response, listitem, inputtex[])
{
	if ( response )
	{
		switch(listitem)
		{
			case 0: // Novo Interior
			{
				new casaid = call::HOUSE->GetHouseIdInRange(playerid, 3.0);

				if ( casaid == INVALID_HOUSE_ID )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Casa não encontrada.");

				new query[128];
				mysql_format(getConexao(), query, sizeof(query), "SELECT * FROM `casas_interior` WHERE `level`<='%d'", call::HOUSE->GetHouseParamInt(casaid, Level));
				new Cache:cache = mysql_query(getConexao(), query, true), nome[70], str[1024], id;

				for(new i, rows = cache_num_rows(); i < rows; i++)
				{
					cache_get_value_name_int(i, "id", id);
					Listitems[playerid][i] = id;
					cache_get_value_name(i, "nome", nome);
					format(str, sizeof(str), "%s%s\n", str, nome);
				}
				cache_delete(cache);
				ShowPlayerDialog(playerid, ADM_CASA_NOVO_INTERIOR, DIALOG_STYLE_TABLIST, "{"COR_DISABLE_INC"}GERENCIAR CASA » {"COR_BRANCO_INC"}NOVO INTERIOR", str, "Selecionar", "Voltar");
				return true;
			}
			case 1: // Liberar Casa
			{
				new casaid = call::HOUSE->GetHouseIdInRange(playerid);

				if ( casaid == INVALID_HOUSE_ID )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Casa não encontrada.");

				new _str[1024];
				/*new Cache:cache = mysql_query(getConexao(), "SELECT * FROM `casas`", true);
				new id, nome[70];

				cache_get_value_name_int(casaid, "id", id);
				cache_get_value_name_int(casaid, "proprietario_id", nome);*/

				format(_str, sizeof(_str), "{ffffff}Você deseja liberar a casa id {"COR_AZUL_INC"}%d {ffffff}do proprietário %s?\n\n\t{"COR_VERMELHO_INC"}Esta ação é irreversível!", casaid, Casa[casaid][Owner][Name]);

				ShowPlayerDialog(playerid, MANAGER_LIBERAR_CASA, DIALOG_STYLE_MSGBOX, "{"COR_DISABLE_INC"}GERENCIAR CASA » {"COR_BRANCO_INC"}LIBERAR CASA",
					_str, "Liberar", "Voltar");

				//ShowPlayerDialog(playerid, MANAGER_LIBERAR_CASA, DIALOG_STYLE_MSGBOX, "{"COR_DISABLE_INC"}GERENCIAR CASA » {"COR_BRANCO_INC"}LIBERAR CASA", 
				//	"{"COR_BRANCO_INC"}Você deseja liberar a casa id %s do proprietário %s\n\n\t{"COR_VERMELHO_INC"}Esta ação é irreversível!", "Liberar", "Voltar");
				return true;
			}
			case 2: // Valor
			{
				new casaid = call::HOUSE->GetHouseIdInRange(playerid);

				if ( casaid == INVALID_HOUSE_ID )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo a uma casa.");

				ShowPlayerDialog(playerid, MANAGER_HOUSE_VALUE_TYPE, DIALOG_STYLE_LIST, "GERENCIAR CASA » TIPO", "Dinheiro\nBitCoins", "Selecionar", "Voltar");
				return true;
			}
			case 3: // Garagem
			{
				new casaid = call::HOUSE->GetHouseIdInRange(playerid, 3.0);

				if ( casaid == INVALID_HOUSE_ID )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo a uma casa.");

				ShowPlayerDialog(playerid, MANAGER_GARAGEM_CASA, DIALOG_STYLE_LIST, "GERENCIAR CASA {"COR_AZUL_INC"}»{"COR_BRANCO_INC"} GARAGEM", "Criar\nModificar\nDeletar", "Selecionar", "Voltar");
				return true;
			}
		}
		return true;
	}
	return true;
}

Dialog:ADM_CASA_NOVO_INTERIOR(playerid, response, listitem, inputtex[])
{
	callcmd::editarcasa(playerid);
	if ( response )
	{
		new query[512], casaid = call::HOUSE->GetHouseIdInRange(playerid);

		if ( casaid == INVALID_HOUSE_ID )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo a uma casa.");

		mysql_format(getConexao(), query, sizeof(query), "SELECT * FROM "TABLE_HOUSES_INTERIORS" WHERE `id`='%d' LIMIT 1;", Listitems[playerid][listitem] );
		new Cache:cache = mysql_query(getConexao(), query, true), rowid;

		cache_get_value_name_int(0, "id", rowid);
		Casa[casaid][InteriorID] = GetInteriorIdByRow(rowid);

		cache_get_value_name_float(0, "x", Casa[casaid][Saida][X]);
		cache_get_value_name_float(0, "y", Casa[casaid][Saida][Y]);
		cache_get_value_name_float(0, "z", Casa[casaid][Saida][Z]);
		cache_get_value_name_float(0, "a", Casa[casaid][Saida][A]);
		cache_get_value_name_int(0, "interior", Casa[casaid][Interior]);
		cache_delete(cache);

		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_HOUSES" SET `interior`='%d' WHERE `id`='%d' LIMIT 1;", rowid, Casa[casaid][ID]);
		mysql_tquery(getConexao(), query);

		DestroyDynamic3DTextLabel(Casa[casaid][Label][1]);
		Casa[casaid][Label][1] = CreateDynamic3DTextLabel("aperte '{"COR_AMARELO_INC"}F{"COR_BRANCO_INC"}' para sair.", COR_BRANCO, Casa[casaid][Saida][X], Casa[casaid][Saida][Y], Casa[casaid][Saida][Z] + 0.5, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, casaid, Casa[casaid][Interior], -1, HOUSE_RENDER_STREAMER);
		
		Teleport(
			playerid,
			Casa[casaid][Saida][X],
			Casa[casaid][Saida][Y],
			Casa[casaid][Saida][Z],
			Casa[casaid][Saida][A],
			Casa[casaid][Interior],
			casaid,
			ENTROU_CASA
		);

		SendClientMessage(playerid, COR_BRANCO, "» {"COR_SISTEMA_INC"}Você alterou o interior da casa id {"COR_BRANCO_INC"}%d{"COR_SISTEMA_INC"}.", casaid);

		UpdateHouseLabel(casaid);

		new str[128];
		format(str, sizeof(str), "[ NOVO INTERIOR ] O %s %s editou o interior da casa id %d", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), casaid);
		WriteLog(FILE_EDIT_HOUSE, str);
		return true;
	}
	return true;
}
Dialog:MANAGER_LIBERAR_CASA(playerid, response, listitem, inputtex[])
{
	callcmd::editarcasa(playerid);
	if ( response )
	{
		new casaid = call::HOUSE->GetHouseIdInRange(playerid);

		if ( casaid == INVALID_HOUSE_ID )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo a uma casa.");

		format(Casa[casaid][Owner][Name], MAX_PLAYER_NAME, "Ninguem");
		Casa[casaid][Owner][Id] = 0;
		format(Casa[casaid][Mensagem], MAX_PLAYER_NAME, "Nada");
		Casa[casaid][Level] = 0;
		Casa[casaid][Impostos] = 0;
		Casa[casaid][ImpostosPagos] = 0;
		Casa[casaid][Cofre] = 0;
		Casa[casaid][Aluguel] = 0;
		Casa[casaid][Mensagem][0] = EOS;
		Casa[casaid][Trancado] = false;

		new query[350];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_HOUSES" SET `proprietario_id`=NULL,`level`='0',`cofre`='0',`trancado`='0',`impostos`='0',`mensagem`='nada',`impostos`=0,`impostos_pagos`=0 WHERE `id`='%d' LIMIT 1;", Casa[casaid][ID]);
		mysql_tquery(getConexao(), query);

		/**
		 *
		 *	Update label house.
		 *
		 */
		UpdateHouseLabel(casaid);

		SendClientMessageToAll(COR_BRANCO, "» {"COR_AZUL_INC"}A Casa ID {"COR_BRANCO_INC"}%d{"COR_AZUL_INC"} foi liberada pelo {"COR_BRANCO_INC"}%s %s{"COR_AZUL_INC"}", casaid, call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));

		new str[128];
		format(str, sizeof(str), "[ LIBERAR CASA ] O %s %s liberou a casa id %d", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), casaid);
		WriteLog(FILE_EDIT_HOUSE, str);
		return true;
	}
	return true;
}



Dialog:MANAGER_HOUSE_VALUE_TYPE(playerid, response, listitem, inputtex[])
{
	if ( response )
	{
		switch(listitem)
		{
			case 0..1:
			{
				SetPVarInt(playerid, "house_type", listitem);
				ShowPlayerDialog(playerid, MANAGER_HOUSE_VALUE, DIALOG_STYLE_INPUT, "GERENCIAR CASA »", "{"COR_BRANCO_INC"}Digite o valor da casa.", "Confimar", "Voltar");
			}
		}
		return true;
	}
	callcmd::editarcasa(playerid);
	return true;
}

Dialog:MANAGER_HOUSE_VALUE(playerid, response, listitem, inputtex[])
{
	callcmd::editarcasa(playerid);
	if ( response )
	{
		new casaid = call::HOUSE->GetHouseIdInRange(playerid);
		if ( casaid == INVALID_HOUSE_ID )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo a uma casa.");

		if ( !IsNumeric(inputtex) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você tem que digitar u número.");

		/**
		 *
		 *	Setar valores nas variáveis da propriedade.
		 *
		 */
		Casa[casaid][Valor] = strval(inputtex);
		Casa[casaid][IsCash] = bool:GetPVarInt(playerid, "house_type");
		DeletePVar(playerid, "house_type");

		/**
		 *
		 *	Setar valores no banco de dados da propriedade.
		 *
		 */
		new query[255];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_HOUSES" SET `valor`='%d',`is_cash`='%d' WHERE `id`='%d' LIMIT 1;", Casa[casaid][Valor], Casa[casaid][IsCash], Casa[casaid][ID]);
		mysql_tquery(getConexao(), query);

		// update house label
		UpdateHouseLabel(casaid);
		return true;
	}
	return true;
}

Dialog:MANAGER_GARAGEM_CASA(playerid, response, listitem, inputtex[])
{
	if ( response )
	{
		switch(listitem)
		{
			case 0: // criar
			{
				new casaid = call::HOUSE->GetHouseIdInRange(playerid);
				
				if ( casaid == INVALID_HOUSE_ID )
				{
					SendClientMessage(playerid, COR_ERRO, "[X] Você não está próximo a uma casa.");
					return 0;
				}

				if ( GetPVarInt(playerid, "casaid_") )
				{
					SendClientMessage(playerid, COR_ERRO, "[X] Você já está criando/modificando uma garagem.");
					ShowCreateGarage(playerid);
					return 0;
				}

				if ( Casa[casaid][Garagem][Id] )
				{
					SendClientMessage(playerid, COR_ERRO, "[X] Essa casa já tem uma garagem criada.");
					callcmd::editarcasa(playerid);
					return 0;
				}

				SetPVarInt(playerid, "casaid_", casaid);
				ShowCreateGarage(playerid);
				return true;
			}
			case 1:
			{
				SendClientMessage(playerid, COR_ERRO, "Sistema desativado temporariamente.");
				callcmd::editarcasa(playerid);
				return 1;
			}
			case 2: // deletar
			{
				new casaid = call::HOUSE->GetHouseIdInRange(playerid);
				
				if ( casaid == INVALID_HOUSE_ID )
				{
					SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo a uma casa.");
					return 0;
				}
				
				if ( !Casa[casaid][Garagem][Id] )
				{
					SendClientMessage(playerid, COR_ERRO, "[X] Essa casa não tem uma garagem criada.");
					callcmd::editarcasa(playerid);
					return 0;
				}

				SetPVarInt(playerid, "casaid_", casaid);
				ShowPlayerDialog(playerid, DELETE_GARAGEM, DIALOG_STYLE_MSGBOX, "CASA » GARAGEM » EXCLUIR", "{"COR_BRANCO_INC"}Você tem certeza que quer excluir essa garagem ?", "SIM", "NÃO");
				return 1;
			}
		}
		return true;
	}
	callcmd::editarcasa(playerid);
	return true;
}

Dialog:MAN_GARAGEM_CRIAR(playerid, response, listitem, inputtex[])
{
	if ( response )
	{
		switch(listitem)
		{
			case 0: // spawn jogador
			{
				SetPVarInt(playerid, "GaragemPosicaoJogador", 1);
				SendClientMessage(playerid, COR_SISTEMA, "[!] Vá até a posição do spawn para jogador e clique com a tecla C para salvar.");
				return 1;
			}
			case 1: // spawn veiculo
			{
				SetPVarInt(playerid, "GaragemPosicaoVeiculo", 1);
				SendClientMessage(playerid, COR_SISTEMA, "[!] Vá até a posição do spawn para o veiculo e clique com a tecla H para salvar.");
				SendClientMessage(playerid, COR_SISTEMA, "[!] Crie um veiculo com o comando /criarveiculo e vá até a posição desejada.");
				return 1;
			}
			case 2: // escolher interior da garagem
			{
				new str[128];

				for(new i; i < sizeof(InteriorGaragem); i++)
				{
					format(str, sizeof(str), "%s%d. %s\n", str, i + 1, InteriorGaragem[i][Name]);
				}
				ShowPlayerDialog(playerid, MAN_GARAGEM_CRIAR_IN_LIST, DIALOG_STYLE_LIST, "GARAGEM » CRIAR » INTERIOR DA GARAGEM", str, "Selecionar", "Voltar");
				return 1;
			}
			case 3:	// finalizar e criar garagem.
			{
				if ( !GetPVarInt(playerid, "GaragemPosicaoVeiculo") ){
					SendClientMessage(playerid, COR_ERRO, "| ERRO | Você tem que definir a posição de spawn do jogador ao sair da garagem.");
					ShowCreateGarage(playerid);
					return 0;
				}

				if ( !GetPVarInt(playerid, "GaragemPosicaoJogador") ){
					SendClientMessage(playerid, COR_ERRO, "| ERRO | Você tem que definir a posição de spawn do veiculo ao sair da garagem.");
					ShowCreateGarage(playerid);
					return 0;
				}

				SendClientMessage(playerid, COR_AZUL, "»`{"COR_BRANCO_INC"}Criando garagem.");

				new query[1024], index = GetPVarInt(playerid, "GaragemInteriorIndex"), casaid =  GetPVarInt(playerid, "casaid_");
				mysql_format(getConexao(), query, sizeof(query),
					"INSERT INTO "TABLE_HOUSES_GARAGES"(`casaid`, `vEntrada_x`, `vEntrada_y`, `vEntrada_z`, `vEntrada_a`, `vSaida_x`, `vSaida_y`, `vSaida_z`, `vSaida_a`, `pEntrada_x`, `pEntrada_y`, `pEntrada_z`, `pEntrada_a`, `pSaida_x`, `pSaida_y`, `pSaida_z`, `pSaida_a`, `garagem_trancada`)\
					VALUES ('%d','%.3f','%.3f','%.3f','%.3f','%.3f','%.3f','%.3f','%.3f','%.3f','%.3f','%.3f','%.3f','%.3f','%.3f','%.3f','%.3f',0)",
					Casa[casaid][ID],
					// veiculo
					GetPVarFloat(playerid, "GaragemVeiculoX"), GetPVarFloat(playerid, "GaragemVeiculoY"), GetPVarFloat(playerid, "GaragemVeiculoZ"), GetPVarFloat(playerid, "GaragemVeiculoA"),
					InteriorGaragem[index][vGaragem][0], InteriorGaragem[index][vGaragem][1], InteriorGaragem[index][vGaragem][2], InteriorGaragem[index][vGaragem][3],
					// player
					GetPVarFloat(playerid, "GaragemPlayerX"), GetPVarFloat(playerid, "GaragemPlayerY"), GetPVarFloat(playerid, "GaragemPlayerZ"), GetPVarFloat(playerid, "GaragemPlayerA"),
					InteriorGaragem[index][pGaragem][0], InteriorGaragem[index][pGaragem][1], InteriorGaragem[index][pGaragem][2], InteriorGaragem[index][pGaragem][3]
				);

				if ( !mysql_tquery(getConexao(), query, "OnFinishCreateGaragem", "dd", playerid, GetPVarInt(playerid, "casaid_")) ){
					SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foi possível criar a garagem.");
					SendClientMessage(playerid, COR_ERRO, "| ERRO | Por favor informe o erro a um GameMaster.");
				}

				// reset
				DeletePVar(playerid, "GaragemVeiculoX");
				DeletePVar(playerid, "GaragemVeiculoY");
				DeletePVar(playerid, "GaragemVeiculoZ");
				DeletePVar(playerid, "GaragemVeiculoA");

				DeletePVar(playerid, "GaragemPlayerX");
				DeletePVar(playerid, "GaragemPlayerY");
				DeletePVar(playerid, "GaragemPlayerZ");
				DeletePVar(playerid, "GaragemPlayerA");

				DeletePVar(playerid, "GaragemInteriorIndex");
				DeletePVar(playerid, "casaid_");
				return 1;
			}
		}
		return 1;
	}
	// reset
	DeletePVar(playerid, "GaragemVeiculoX");
	DeletePVar(playerid, "GaragemVeiculoY");
	DeletePVar(playerid, "GaragemVeiculoZ");
	DeletePVar(playerid, "GaragemVeiculoA");

	DeletePVar(playerid, "GaragemPlayerX");
	DeletePVar(playerid, "GaragemPlayerY");
	DeletePVar(playerid, "GaragemPlayerZ");
	DeletePVar(playerid, "GaragemPlayerA");

	DeletePVar(playerid, "GaragemInteriorIndex");
	DeletePVar(playerid, "casaid_");
	callcmd::editarcasa(playerid);
	return 0;
}

Dialog:MAN_GARAGEM_CRIAR_IN_LIST(playerid, response, listitem, inputtex[])
{
	if ( response )
	{
		SendClientMessage(playerid, COR_LARANJA, "» {"COR_BRANCO_INC"}Você selecionou a garagem: {"COR_LARANJA_INC"}%s{"COR_BRANCO_INC"}.", InteriorGaragem[listitem][Name]);
		SetPVarInt(playerid, "GaragemInteriorIndex", listitem);
		ShowCreateGarage(playerid);
		return 1;
	}
	ShowCreateGarage(playerid);
	return 1;
}


Dialog:DELETE_GARAGEM(playerid, response, listitem, inputtex[])
{
	if ( response )
	{
		new casaid = GetPVarInt(playerid, "casaid_");
		DeletePVar(playerid, "casaid_");
		if ( !call::HOUSE->IsValidHouse(casaid) )
		{
			SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foi possível deletar a garagem da casa.");
			return 0;
		}

		new query[128];
		mysql_format(getConexao(), query, sizeof(query), "DELETE FROM "TABLE_HOUSES_GARAGES" WHERE casaid='%d' LIMIT 1;", Casa[casaid][ID]);
		mysql_tquery(getConexao(), query);
		
		DestroyGaragem(casaid);

		SendClientMessage(playerid, COR_SISTEMA, "» Garagem deletada com sucesso.");
		return 1;
	}
	callcmd::editarcasa(playerid);
	return 1;
}


// ============================== [ callback ] ============================== //
#include <YSI_Coding\y_hooks>

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if ( PRESSED(KEY_CROUCH) )
	{
		if ( GetPVarInt(playerid, "GaragemPosicaoJogador") == 1 )
		{
			SetPVarInt(playerid, "GaragemPosicaoJogador", 2);
			static Float:x, Float:y, Float:z, Float:a;
			
			GetPlayerPos(playerid, x, y, z);
			GetPlayerFacingAngle(playerid, a);

			SetPVarFloat(playerid, "GaragemPlayerX", x);
			SetPVarFloat(playerid, "GaragemPlayerY", y);
			SetPVarFloat(playerid, "GaragemPlayerZ", z);
			SetPVarFloat(playerid, "GaragemPlayerA", a);

			ShowCreateGarage(playerid);
			return Y_HOOKS_BREAK_RETURN_1;
		}
		else if ( GetPVarInt(playerid, "GaragemPosicaoVeiculo") == 1 )
		{
			if ( !IsPlayerInAnyVehicle(playerid) )
			{
				SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa está em um veiculo");
				return Y_HOOKS_BREAK_RETURN_1;
			}

			SetPVarInt(playerid, "GaragemPosicaoVeiculo", 2);
			static Float:x, Float:y, Float:z, Float:a;
			
			new vehicleid = GetPlayerVehicleID(playerid);
			GetVehiclePos(vehicleid, x, y, z);
			GetVehicleZAngle(vehicleid, a);

			SetPVarFloat(playerid, "GaragemVeiculoX", x);
			SetPVarFloat(playerid, "GaragemVeiculoY", y);
			SetPVarFloat(playerid, "GaragemVeiculoZ", z);
			SetPVarFloat(playerid, "GaragemVeiculoA", a);

			ShowCreateGarage(playerid);
			return Y_HOOKS_BREAK_RETURN_1;
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

public OnFinishCreateGaragem(playerid, casaid)
{
	new insert_id = cache_insert_id();
	if ( !insert_id )
	{
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foi possível criar a garagem.");
		return 0;
	}
	new Cache:cache_id, query[128];
	mysql_format(getConexao(), query, sizeof(query), "SELECT * from "TABLE_HOUSES_GARAGES" WHERE garagemId='%d' LIMIT 1;", insert_id);
	cache_id = mysql_query(getConexao(), query, true);
	
	cache_get_value_name_int(0, "garagemId", Casa[casaid][Garagem][Id]);

	cache_get_value_name_float(0, "vEntrada_x", Casa[casaid][Garagem][vEntrada][X]);
	cache_get_value_name_float(0, "vEntrada_y", Casa[casaid][Garagem][vEntrada][Y]);
	cache_get_value_name_float(0, "vEntrada_z", Casa[casaid][Garagem][vEntrada][Z]);
	cache_get_value_name_float(0, "vEntrada_a", Casa[casaid][Garagem][vEntrada][A]);

	cache_get_value_name_float(0, "vSaida_x", Casa[casaid][Garagem][vSaida][X]);
	cache_get_value_name_float(0, "vSaida_y", Casa[casaid][Garagem][vSaida][Y]);
	cache_get_value_name_float(0, "vSaida_z", Casa[casaid][Garagem][vSaida][Z]);
	cache_get_value_name_float(0, "vSaida_a", Casa[casaid][Garagem][vSaida][A]);


	cache_get_value_name_float(0, "pEntrada_x", Casa[casaid][Garagem][pEntrada][X]);
	cache_get_value_name_float(0, "pEntrada_y", Casa[casaid][Garagem][pEntrada][Y]);
	cache_get_value_name_float(0, "pEntrada_z", Casa[casaid][Garagem][pEntrada][Z]);
	cache_get_value_name_float(0, "pEntrada_a", Casa[casaid][Garagem][pEntrada][A]);

	cache_get_value_name_float(0, "pSaida_x", Casa[casaid][Garagem][pSaida][X]);
	cache_get_value_name_float(0, "pSaida_y", Casa[casaid][Garagem][pSaida][Y]);
	cache_get_value_name_float(0, "pSaida_z", Casa[casaid][Garagem][pSaida][Z]);
	cache_get_value_name_float(0, "pSaida_a", Casa[casaid][Garagem][pSaida][A]);

	cache_get_value_name_int(0, "garagem_trancada", Casa[casaid][Garagem][Trancado]);
	
	Iter_Add(Garagens, casaid);

	RenderGaragem(casaid);
	cache_delete(cache_id);

	SendClientMessage(playerid, COR_BRANCO, "* Garagem criada com {"COR_VERDE_INC"}êxito{"COR_BRANCO_INC"}!");
	return 1;
}

stock ShowCreateGarage(playerid)
{
	ShowPlayerDialog(playerid, MAN_GARAGEM_CRIAR, DIALOG_STYLE_TABLIST, "MENU CASA » GARAGEM » CRIAR",
			"Spawn Jogador\t{"COR_ERRO_INC"}» Para pegar o spawn quando o jogador sair da garagem apé\nSpawn Veiculo\t{"COR_ERRO_INC"}» Para pegar a posição quando o jogador sair da garagem com o veiculo\nInterior da Garagem\t{"COR_ERRO_INC"}» Escolher o interior da garagem.\n{"COR_LARANJA_INC"}Criar Garagem",
		"Selecionar", "Voltar"
	);
}