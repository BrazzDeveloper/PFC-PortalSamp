Dialog:BUY_HOUSE(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(!call::HOUSE->IsPlayerInHouse(playerid, 2.0))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo a nenhuma casa");

		new casaid = call::HOUSE->GetHouseIdInRange(playerid, 3.0);	

		if( Casa[casaid][Owner][Id] != 0 )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Está casa já tem dono.");
		
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

		if( GetPlayerHouse(playerid) != INVALID_HOUSE_ID )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já possui uma casa.");

		if ( Casa[casaid][IsCash] )
		{
			if( Casa[casaid][Valor] > Jogador[playerid][Cash] )
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem BitCoins suficiente para comprar esta casa.");
			


			Jogador[playerid][Cash] = Jogador[playerid][Cash]-Casa[casaid][Valor];

			
			SendClientMessage(playerid, COR_BRANCO, "CASA: Você comprou a casa {"COR_AZUL_INC"}%d{"COR_BRANCO_INC"} por {"COR_LARANJA_INC"}%s{"COR_BRANCO_INC"}.", casaid, RealStr(Casa[casaid][Valor]) );
		}
		else
		{
			if(call::HOUSE->GetHouseParamInt(casaid, Valor) > GetPlayerMoney(playerid))
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem o dinheiro suficiente para comprar esta casa.");

			GivePlayerMoney(playerid, -Casa[casaid][Valor], true);
			SendClientMessage(playerid, COR_BRANCO, "CASA: Você comprou a casa {"COR_AZUL_INC"}%d{"COR_BRANCO_INC"} por {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}.", casaid, RealStr(Casa[casaid][Valor]));
		}
		
		
		format(Casa[casaid][Owner][Name], MAX_PLAYER_NAME, GetUserName(playerid));
		Casa[casaid][Owner][Id] = Jogador[playerid][PlayerID];

		new query[130];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_HOUSES" SET `proprietario_id`='%d' WHERE `id`='%d' LIMIT 1;", Jogador[playerid][PlayerID], call::HOUSE->GetHouseParamInt(casaid, ID));
		mysql_tquery(getConexao(), query);

		UpdateHouseLabel(casaid);

		//SendClientMessageToAll(COR_BRANCO, "[!] O(A) jogador(a) {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"} comprou a casa ID {"COR_VERDE_INC"}%d{"COR_BRANCO_INC"} localizada em {"COR_AMARELO_INC"}%s{"COR_BRANCO_INC"}.", GetUserName(playerid), casaid, call::HOUSE->GetHouseLocalName(casaid));
		SendClientMessageToAll(COR_LARANJA, "| CASA | O(A) jogador(a) {ffffff}%s {"COR_LARANJA_INC"}comprou a Casa ID {ffffff}%d {"COR_LARANJA_INC"}localizada em {ffffff}%s{"COR_LARANJA_INC"}!", GetUserName(playerid), casaid, call::HOUSE->GetHouseLocalName(casaid));
		return true;
	}
	return true;
}

new static Listitems[100];
Dialog:MENU_HOUSE(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(!call::HOUSE->IsPlayerInHouse(playerid, 1.1))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo a uma casa.");

		new casaid = call::HOUSE->GetHouseIdInRange(playerid, 1.1);
		
		if ( casaid == INVALID_HOUSE_ID )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo de uma casa.");

		if ( Jogador[playerid][PlayerID] != Casa[casaid][Owner][Id] )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário desta casa.");

		switch(listitem)
		{
			case 0: // Expulsar Morador
			{
				new query[255], Cache:cache_id, rows, username[MAX_PLAYER_NAME];
				mysql_format(getConexao(), query, sizeof(query), "SELECT username FROM "TABLE_USERS" WHERE `morador_casa_id`='%d'", Casa[casaid][ID]);
				cache_id = mysql_query(getConexao(), query, true);
				rows = cache_num_rows();
				if ( rows )
				{
					new str[512];
					for(new i; i < rows; i++)
					{
						cache_get_value_name(i, "username", username, MAX_PLAYER_NAME);
						format(str, sizeof(str), "%s%s\n", str, username);
					}
					ShowPlayerDialog(playerid, MN_MORADORES, DIALOG_STYLE_LIST, "MENU » CASA » MORADORES", str, "Selecionar", "Voltar");
					SetPVarInt(playerid, "casaid_", casaid);
				}
				else
				{
					ShowPlayerDialog(playerid, MN_MORADORES_1, DIALOG_STYLE_MSGBOX, "MENU » CASA » MORADORES", "Sua casa não tem quartos alugados.", "Ok", "");
				}
				cache_delete(cache_id);
				return true;
			}
			case 1: // Trancar
			{
				call::HOUSE->SetHouseParamInt(casaid, Trancado, (call::HOUSE->GetHouseParamInt(casaid, Trancado) ? false : true) );
				SendClientMessage(playerid, COR_VERDE, "CASA: {"COR_BRANCO_INC"}Você %s a casa", (call::HOUSE->GetHouseParamInt(casaid, Trancado) ? ("{"COR_VERDE_INC"}trancou{"COR_BRANCO_INC"}") : ("{"COR_ERRO_INC"}destrancou{"COR_BRANCO_INC"}") ) );

				new query[128];
				mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_HOUSES" SET `trancado`='%d' WHERE `id`='%d' LIMIT 1;", call::HOUSE->GetHouseParamInt(casaid, Trancado), call::HOUSE->GetHouseParamInt(casaid, ID));
				mysql_tquery(getConexao(), query); // executar em segundo plano.

				return callcmd::menucasa(playerid);
			}
			case 2: // Alugar Casa
			{
				ShowPlayerDialog(playerid, MENU_HOUSE_ATIV_ALUGUEL, DIALOG_STYLE_INPUT, "{"COR_DISABLE_INC"}CASA » MENU » {"COR_BRANCO_INC"}ATIVAR ALUGUEL", 
					"{"COR_BRANCO_INC"}Digite o valor do alguel de sua casa\nPara desativar o aluguel coloque o numero {"COR_VERDE_INC"}0{"COR_BRANCO_INC"}", "Confirmar", "Voltar");
				return true;
			}
			case 3: // Alterar Mensagem
			{
				ShowPlayerDialog(playerid, MENU_HOUSE_ALTER_MSG, DIALOG_STYLE_INPUT, "{"COR_DISABLE_INC"}CASA » MENU » {"COR_BRANCO_INC"}ALTERAR MENSAGEM", "{"COR_BRANCO_INC"}Digite a baixo a mensagem para sua casa.", "Mudar", "Voltar");
				return true;
			}
			case 4:// Atualizar Interior
			{
				new Cache:cache = mysql_query(getConexao(), "SELECT * FROM "TABLE_HOUSES_INTERIORS";", true), nome[70], str[1024], id, quartos, level, valor;
				str = "nome\tlevel\tquartos\tValor\n";
				for(new i, rows = cache_num_rows(); i < rows; i++)
				{
					cache_get_value_name_int(i, "id", id);
					Listitems[i] = id;
					cache_get_value_name(i, "nome", nome);
					cache_get_value_name_int(i, "level", level);
					cache_get_value_name_int(i, "slots", quartos);
					cache_get_value_name_int(i, "valor", valor);
					format(str, sizeof(str), "%s%s\t%d\t%d\t{"COR_VERDE_INC"}R$%s\n", str, nome, level, quartos, RealStr(valor));
				}
				cache_delete(cache);
				ShowPlayerDialog(playerid, CASA_ATUALIZAR_INTERIOR, DIALOG_STYLE_TABLIST_HEADERS, "{"COR_DISABLE_INC"}CASA MENU » {"COR_BRANCO_INC"}ATUALIZAR INTERIOR", str, "Selecionar", "Voltar");
				return true;	
			}
			case 5: // Vender
			{
				new valor = HOUSE_VALOR_VENDA(casaid);
				ShowPlayerDialog(playerid, MENU_VENDER_HOUSE, DIALOG_STYLE_MSGBOX, "{"COR_DISABLE_INC"}CASA » MENU » {"COR_BRANCO_INC"}VENDER", 
					(Casa[casaid][IsCash] ?
						("{"COR_BRANCO_INC"}Você deseja vender sua casa por {"COR_LARANJA_INC"}%s{"COR_BRANCO_INC"} BitCoins ?\n\n\t{"COR_ERRO_INC"}Essa ação é irreverssível!"):
						("{"COR_BRANCO_INC"}Você deseja vender sua casa por {"COR_VERDE_INC"}R$%s {"COR_BRANCO_INC"}?\n\n\t{"COR_ERRO_INC"}Essa ação é irreverssível!")
					),
					"Vender", "Cancelar", RealStr(valor));
				return true;
			}
		}
		return true;
	}
	return true;
}
#pragma unused Listitems

Dialog:MENU_HOUSE_ATIV_ALUGUEL(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new casaid = GetPlayerHouse(playerid);
		
		if(!call::HOUSE->IsPlayerInHouse(playerid, 2.0))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo a sua casa.");
		
		if ( Jogador[playerid][PlayerID] != Casa[casaid][Owner][Id] )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário desta residência.");

		if(!IsNumeric(inputtext))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não digitou um número válido.");

		new valor = strval(inputtext);
		if ( valor > (call::HOUSE->GetHouseParamInt(casaid, Valor) * 0.01) && !Casa[casaid][IsCash] )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode definir um valor maior que 1%% do valor da casa.");

		new query[128];

		call::HOUSE->SetHouseParamInt(casaid, Aluguel, valor);
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_HOUSES" SET `valor_aluguel`='%d' WHERE `id`='%d' LIMIT 1;", valor, call::HOUSE->GetHouseParamInt(casaid, ID) );
		mysql_tquery(getConexao(), query);

		if(valor > 0)
			SendClientMessage(playerid, COR_AZUL, "CASA: {"COR_BRANCO_INC"}Você {"COR_VERDE_INC"}ativou{"COR_BRANCO_INC"} o aluguel de sua casa para {"COR_VERDE_INC"}R$%s", RealStr(valor)), call::HOUSE->SetHouseParamInt(casaid, Alugavel, 1);
		else
			SendClientMessage(playerid, COR_AZUL, "CASA: {"COR_BRANCO_INC"}Você {"COR_VERMELHO_INC"}desativou{"COR_BRANCO_INC"} aluguel de sua casa."), call::HOUSE->SetHouseParamInt(casaid, Alugavel, 0);

		UpdateHouseLabel(casaid);
	}
	callcmd::menucasa(playerid);
	return true;
}

Dialog:MENU_HOUSE_ALTER_MSG(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new casaid = GetPlayerHouse(playerid);
		
		if(!call::HOUSE->IsPlayerInHouse(playerid, 2.0))
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo a sua casa.");
		
		if ( Jogador[playerid][PlayerID] != Casa[casaid][Owner][Id] )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário desta residência.");

		new len = strlen(inputtext);
		if(len > MAX_HOUSE_MENSAGEM)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você digitou uma mensagem muito grande.");

		if(!len || isnull(inputtext))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você digitou uma mensagem muito pequena.");
		
		new mensagem[MAX_HOUSE_MENSAGEM];

		format(mensagem, sizeof(mensagem), str_replace("'", "", inputtext)); // replace symbol '
		format(mensagem, sizeof(mensagem), str_replace("`", "", inputtext)); // replace symbol `

		call::HOUSE->SetHouseParam(casaid, Mensagem, mensagem, MAX_HOUSE_MENSAGEM);

		UpdateHouseLabel(casaid);

		new query[128];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_HOUSES" SET `mensagem`='%e' WHERE `id`='%d'", mensagem, call::HOUSE->GetHouseParamInt(casaid, ID));
		mysql_tquery(getConexao(), query);

		SendClientMessage(playerid, -1, "| CASA | Você alterou a mensagem da sua casa para: {1C88F0}%s{ffffff}!", inputtext);
		
	}
	callcmd::menucasa(playerid);
	return true;
}

Dialog:MENU_VENDER_HOUSE(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new casaid = GetPlayerHouse(playerid);

		if ( call::HOUSE->GetHouseParamInt(casaid, Impostos) >= 1)
   			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Sua casa tem impostos para pagar.");
		
		if ( casaid == INVALID_HOUSE_ID )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem uma Casa.");

		if( !call::HOUSE->IsPlayerInHouse(playerid, 2.0) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo a sua casa.");
		
		if ( Jogador[playerid][PlayerID] != Casa[casaid][Owner][Id] )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário desta residência.");

		if ( call::HOUSE->GetHouseParamInt(casaid, Impostos) != 0 && !Casa[casaid][IsCash])
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você tem que pagar os impostos antes de vender sua casa.");

		foreach(new i: Player)
		{
			if ( Jogador[i][pMorador] == Casa[casaid][ID] ){
				Jogador[i][pMorador] = 0;
				SendClientMessage(i, COR_ERRO, "INFO: {"COR_BRANCO_INC"}A Casa em que você tinha um quarto alugado foi vendido e você foi despejado.");
			}
		}
		new valor = HOUSE_VALOR_VENDA(casaid);
		if ( Casa[casaid][IsCash] ){
			GivePlayerMoney(playerid, Casa[casaid][Cofre]);
			Jogador[playerid][Cash] += valor;
			SendClientMessage(playerid, COR_SISTEMA, "* {"COR_BRANCO_INC"}Você vendeu sua casa por {"COR_AZUL_INC"}%s {"COR_LARANJA_INC"}BitCoins{"COR_BRANCO_INC"}.", valor);
		}
		else{
			valor += Casa[casaid][Cofre];
			GivePlayerMoney(playerid, valor);
			SendClientMessage(playerid, COR_SISTEMA, "* {"COR_BRANCO_INC"}Você vendeu sua casa por {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}.", RealStr(valor));
		}

		new query[512];
		// atualizar infomações no banco de dados da casa.
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_HOUSES" SET `proprietario_id`=NULL,`impostos`=0,`impostos_pagos`=0,`cofre`=0,`mensagem`='',`valor_aluguel`=0,`valor_venda`=0,`trancado`=0,`interior`=1 WHERE `id`='%d'", call::HOUSE->GetHouseParamInt(casaid, ID));
		mysql_tquery(getConexao(), query);


		// atualizar informação no banco de dados para os moradores da casa.
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `morador_casa_id`=0 WHERE `morador_casa_id`='%d';", Casa[casaid][ID]);
		mysql_tquery(getConexao(), query);

		/**
		 *
		 *	Limpar variáveis.
		 *
		 */
		Casa[casaid][InteriorID] = GetInteriorIdByRow(1);
		GetHouseInteriorInfo(Casa[casaid][InteriorID], Casa[casaid][Saida][X], Casa[casaid][Saida][Y], Casa[casaid][Saida][Z], Casa[casaid][Saida][A], Casa[casaid][Interior]);
		
		Casa[casaid][Level] = 0;
		Casa[casaid][Impostos] = 0;
		Casa[casaid][ImpostosPagos] = 0;
		Casa[casaid][Cofre] = 0;
		Casa[casaid][Aluguel] = 0;
		Casa[casaid][Mensagem][0] = EOS;
		Casa[casaid][Trancado] = false;

		format(Casa[casaid][Owner][Name], MAX_PLAYER_NAME, "Ninguem");
		Casa[casaid][Owner][Id] = 0;

		/**
		 *
		 *	Update label.
		 *
		 */
		UpdateHouseLabel(casaid);

		Teleport(
			playerid,
			Casa[casaid][Entrada][X],
			Casa[casaid][Entrada][Y],
			Casa[casaid][Entrada][Z],
			Casa[casaid][Entrada][A],
			0,
			0,
			ENTROU_NONE
		);

		//SendClientMessageToAll(COR_SISTEMA, "CASA-CASA: {"COR_BRANCO_INC"}O(A) jogador(a) {"COR_VERDE_INC"}%s{"COR_BRANCO_INC"} vendeu sua casa ID {"COR_VERDE_INC"}%d{"COR_BRANCO_INC"} localizada em {"COR_AMARELO_INC"}%s{"COR_BRANCO_INC"}.", GetUserName(playerid), casaid, call::HOUSE->GetHouseLocalName(casaid));
		SendClientMessageToAll(COR_LARANJA, "| CASA | O(A) jogador(a) {ffffff}%s {"COR_LARANJA_INC"}vendeu sua Casa ID {ffffff}%d {"COR_LARANJA_INC"}localizada em {ffffff}%s{"COR_LARANJA_INC"}!", GetUserName(playerid), casaid, call::HOUSE->GetHouseLocalName(casaid));
		return true;
	}
	callcmd::menucasa(playerid);
	return true;
}

Dialog:CASA_ATUALIZAR_INTERIOR(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		new query[512], casaid = call::HOUSE->GetHouseIdInRange(playerid, 3.0);

		if ( casaid == INVALID_HOUSE_ID )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo a uma casa.");

		if ( Jogador[playerid][PlayerID] != Casa[casaid][Owner][Id] )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário desta casa.");

		mysql_format(getConexao(), query, sizeof(query), "SELECT * FROM "TABLE_HOUSES_INTERIORS" WHERE `id`='%d' LIMIT 1;", Listitems[listitem] );
		new Cache:cache = mysql_query(getConexao(), query, true), i_name[64], rowid;

		cache_get_value_name_int(0, "id", rowid);
		new interior_id = GetInteriorIdByRow(rowid);

		if ( Casa[casaid][InteriorID] == interior_id ){
			cache_delete(cache);
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Sua casa já está com esse interior.");
		}

		if ( GetInteriorValue(interior_id) > GetPlayerMoney(playerid) ){
			cache_delete(cache);
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem o dinheiro suficiente para fazer o upgrade do interior de sua casa.");
		}

		new level;
		cache_get_value_name_int(0, "level", level);
		if ( Casa[casaid][Level] < level){
			cache_delete(cache);
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Sua casa não tem o level necessário para alterar para esse interior.");
		}

		Casa[casaid][InteriorID] = interior_id;

		cache_get_value_name(0, "nome", i_name);

		cache_get_value_name_float(0, "x", Casa[casaid][Saida][X]);
		cache_get_value_name_float(0, "y", Casa[casaid][Saida][Y]);
		cache_get_value_name_float(0, "z", Casa[casaid][Saida][Z]);
		cache_get_value_name_float(0, "a", Casa[casaid][Saida][A]);
		cache_get_value_name_int(0, "interior", Casa[casaid][Interior]);
		cache_delete(cache);

		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_HOUSES" SET `interior`='%d' WHERE `id`='%d' LIMIT 1;", rowid, Casa[casaid][ID]);
		mysql_tquery(getConexao(), query);

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
		DestroyDynamic3DTextLabel(Casa[casaid][Label][1]);
		Casa[casaid][Label][1] = CreateDynamic3DTextLabel("aperte '{"COR_AMARELO_INC"}F{"COR_BRANCO_INC"}' para sair.", COR_BRANCO, Casa[casaid][Saida][X], Casa[casaid][Saida][Y], Casa[casaid][Saida][Z] + 1.0, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, casaid, Casa[casaid][Interior], -1, HOUSE_RENDER_STREAMER);

		new valor = GetInteriorValue(Casa[casaid][InteriorID]);
		SendClientMessage(playerid, COR_BRANCO, "* Você alterou o interior da sua casa para o interior {"COR_VERMELHO_INC"}%s{"COR_BRANCO_INC"} com {"COR_AZUL_INC"}%d{"COR_BRANCO_INC"} quartos.", i_name, GetInteriorSlots(Casa[casaid][InteriorID]));
		GivePlayerMoney(playerid, -valor, true);

		UpdateHouseLabel(casaid);
		
		new str[128];
		format(str, sizeof(str), "[ INTERIOR ] O(A) %s editou o interior de sua casa id %d.", GetUserName(playerid), casaid);
		WriteLog("casa/novo_interior.txt", str);
		return true;
	}
	callcmd::menucasa(playerid);
	return true;
}

Dialog:MN_MORADORES(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		new casaid = GetPVarInt(playerid, "casaid_");
		if ( !call::HOUSE->IsValidHouse(casaid) )
		{
			SendClientMessage(playerid, COR_ERRO, "[X] Não encontramos essa casa. ");
			return 0;
		}

		if ( Casa[casaid][Owner][Id] != Jogador[playerid][PlayerID] )
		{
			SendClientMessage(playerid, COR_ERRO, "[X] Você não é proprietário dessa casa.");
			return 0;
		}
		new str[128];
		SetPVarString(playerid, "morador_name", inputtext);
		format(str, sizeof(str), "{"COR_SISTEMA_INC"}Você deseja expulsar o morador {"COR_LARANJA_INC"}%s{"COR_SISTEMA_INC"} da sua casa?", inputtext);
		ShowPlayerDialog(playerid, EXPULSAR_MORADOR, DIALOG_STYLE_MSGBOX, "CASA » EXPULSAR MORADOR » CONFIRMAR", str, "Sim", "Não");
		return 1;
	}
	DeletePVar(playerid, "casaid_");
	callcmd::menucasa(playerid);
	return 1;
}

Dialog:MN_MORADORES_1(playerid, response, listitem, inputtext[])
{
	callcmd::menucasa(playerid);

	return 1;
}

Dialog:EXPULSAR_MORADOR(playerid, response, listitem, inputtext[])
{
	new casaid = GetPVarInt(playerid, "casaid_"), username[MAX_PLAYER_NAME];
	GetPVarString(playerid, "morador_name", username, sizeof(username));
	DeletePVar(playerid, "morador_name");
	DeletePVar(playerid, "casaid_");

	if ( response )
	{

		if ( !call::HOUSE->IsValidHouse(casaid) )
		{
			SendClientMessage(playerid, COR_ERRO, "[X] Não encontramos essa casa. ");
			return 0;
		}

		if ( Casa[casaid][Owner][Id] != Jogador[playerid][PlayerID] )
		{
			SendClientMessage(playerid, COR_ERRO, "[X] Você não é proprietário(a) dessa casa.");
			return 0;
		}
		new query[128];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `morador_casa_id`='0' WHERE `username`='%s' LIMIT 1;", username);
		mysql_tquery(getConexao(), query);

		new morador_id = GetPlayerIDByName(username);
		if ( IsPlayerConnected(morador_id) )
		{
			SendClientMessage(morador_id, COR_LARANJA, "[!] {"COR_BRANCO_INC"}Você foi expulso(a) da casa que você tinha um quarto alugado.");
		}
		SendClientMessage(playerid, COR_AZUL, "» {"COR_BRANCO_INC"}O(A) jogador(a) {"COR_LARANJA_INC"}%s{"COR_BRANCO_INC"} foi removido da sua casa.", username);
		return 1;
	}
	callcmd::menucasa(playerid);
	return 1;
}