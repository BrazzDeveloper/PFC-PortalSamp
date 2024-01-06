CMD:pegarmercadoria(playerid)
{
	if( IsPlayerInDynamicCP(playerid, CP_BAYSIDE) )
	{
		if(call::PLAYER->GetPlayerVarInt(playerid, EmpresaID) == INVALID_BUSINESS_ID)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não trabalha em nenhuma empresa.");
		
		if ( Jogador[playerid][Mercadoria] > MERCADORIA_LIBERADA)
		{
			new ExpiraMerc[128];
			rHoraMinuto(Jogador[playerid][Mercadoria] + gettime(), ExpiraMerc, sizeof(ExpiraMerc));

			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa esperar %s para pegar outra mercadoria.",  ExpiraMerc);
		}
			
		if ( Jogador[playerid][Mercadoria] == MERCADORIA_CARREGADA )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está com a mercadoria, entregue a em sua empresa.");

		if( Jogador[playerid][Mercadoria] == MERCADORIA_LIBERADA )
		{
			Jogador[playerid][Mercadoria] = MERCADORIA_CARREGADA;
			SendClientMessage(playerid, COR_AMARELO, "| EMPRESA | Você pegou {ffffff}1 {ffff00}mercadoria para a Empresa ID {ffffff}%d {ffff00}que você trabalha.", \
			call::BUSINESS->GetBusinessParamsInt( Jogador[playerid][EmpresaID], ID ) );
			return true;
		}
		return true;
	}
	SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em Bayside.");
	return true;
}

/*CMD:entregarmercadoria(playerid)
{
	new businessid = call::BUSINESS->GetBusinessInRangeP(playerid, 3.0);
	
	if(businessid == INVALID_BUSINESS_ID)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo a uma empresa.");

	if(businessid != call::PLAYER->GetPlayerVarInt(playerid, EmpresaID))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não trabalha nestá empresa.");

	if( Jogador[playerid][Mercadoria] == MERCADORIA_CARREGADA)
	{
		Jogador[playerid][Mercadoria] = MERCADORIA_TEMPO;
		new funcid = Jogador[playerid][FuncionarioID], valorEntrega = call::BUSINESS->GetBusinessInfoEntrega(businessid);

		call::BUSINESS->SetBusinessParamsInt(businessid, Producao, call::BUSINESS->GetBusinessParamsInt(businessid, Producao) + 1);
		
		call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + (valorEntrega - call::BUSINESS->GetBusinessParamsInt(businessid, Salario)));
		GivePlayerMoney(playerid, call::BUSINESS->GetBusinessParamsInt(businessid, Salario));

		call::BUSINESS->UpdateBusinessTexts(businessid);
		
		SendClientMessage(playerid, -1, "| EMPRESA | Você entregou {1c88f0}1 {ffffff}mercadoria na empresa e recebeu {31B404}R$%s {ffffff}pelo seu serviço.", RealStr(call::BUSINESS->GetBusinessParamsInt(businessid, Salario)));
		
		new pName[MAX_PLAYER_NAME], query[255];
		call::BUSINESS->GetBusinessParams(businessid, Proprietario, pName);
		if ( strcmp(pName, GetUserName(playerid), true) == 0 )
		{
			mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_BUSINESS" SET `producao`='%d',`cofre`='%d' WHERE `id`='%d'", call::BUSINESS->GetBusinessParamsInt(businessid, Producao), call::BUSINESS->GetBusinessParamsInt(businessid, Cofre), call::BUSINESS->GetBusinessColumID(businessid));
			mysql_tquery(getConexao(), query);
		}
		else
		{
			call::BUSINESS->SetFuncionarioEntrega(businessid, funcid, call::BUSINESS->GetFuncionarioEntrega(businessid, funcid) + 1);
			
			mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_BUSINESS" SET `producao`='%d',`entregas_funcionario_%d`='%d',`cofre`='%d' WHERE `id`='%d'", call::BUSINESS->GetBusinessParamsInt(businessid, Producao), funcid, call::BUSINESS->GetFuncionarioEntrega(businessid, funcid), call::BUSINESS->GetBusinessParamsInt(businessid, Cofre), call::BUSINESS->GetBusinessColumID(businessid));
			mysql_tquery(getConexao(), query);
		}

		query[0] = EOS;
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `mercadoria`='%d' WHERE `id`='%d' LIMIT 1;", Jogador[playerid][Mercadoria], Jogador[playerid][PlayerID]);
		mysql_tquery(getConexao(), query);
		
		return true;
	}
	SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está com a mercadoria.");
	return true;
}*/

/*CMD:infoempresa(playerid)
{
	new businessid = call::BUSINESS->GetBusinessInRangeP(playerid, 2.0);
	if(businessid != INVALID_BUSINESS_ID)
	{
		call::BUSINESS->ShowPlayerBusinessInfo(playerid, businessid);
		return true;
	}
	return true;
}*/

CMD:menuempresa(playerid)
{
	new businessid = call::BUSINESS->GetBusinessInRangeP(playerid, 2.0);
	if(businessid == INVALID_BUSINESS_ID)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de nenhuma empresa.");
		
	if(businessid != INVALID_BUSINESS_ID)
	{
		if(!call::BUSINESS->CheckBusinessFunc(playerid, businessid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário desta empresa.");

		call::BUSINESS->ShowPlayerBusinessMenu(playerid, businessid);
		return true;
	}
	return true;
}

CMD:comprarempresa(playerid)
{
	if(GetPlayerScore(playerid) < 80) 
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem level suficiente para comprar uma empresa.");

	if(call::PLAYER->GetPlayerVarInt(playerid, EmpresaID) != INVALID_BUSINESS_ID)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já possui uma empresa ou trabalha em uma.");

	new businessid = call::BUSINESS->GetBusinessInRangeP(playerid, 2.0), pName[MAX_PLAYER_NAME];

	if(businessid == INVALID_BUSINESS_ID)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de nenhuma empresa.");

	if(businessid != INVALID_BUSINESS_ID)
	{
		call::BUSINESS->GetBusinessParams(businessid, Proprietario, pName);
		if(call::BUSINESS->GetBusinessParamsInt(businessid, ValorVenda) <= 0 && strcmp(pName, "Ninguem", true) != 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esta empresa não está a venda.");
		
		if(GetPlayerMoney(playerid) < call::BUSINESS->GetBusinessParamsInt(businessid, Valor))
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente para comprar esta empresa.");

		new String[500], Str[500];

		strcat(String, "{ff8000}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n");
		format(Str, 500, "{ffffff}Empresa ID:\t{ff8000}%d\n", call::BUSINESS->GetBusinessParamsInt(businessid, ID));
		strcat(String, Str);

		format(Str, 500, "{ffffff}Valor:\t{31b404}R$%s\n", RealStr(call::BUSINESS->GetBusinessParamsInt(businessid, Valor)) );
		strcat(String, Str);

		format(Str, 500, "{ffffff}Você deseja comprar esta empresa?\n\n");
		strcat(String, Str);
		strcat(String, "{ff8000}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

		ShowPlayerDialog(playerid, bMENU_BUY_BUSINESS, DIALOG_STYLE_MSGBOX, "{ffffff}Compra de Empresa", String, "Sim", "Não");
		
		//bMENU_BUY_BUSINESS;
		return true;
	}

	return true;
}


/*CMD:venderempresa(playerid, params[])
{
	if(call::PLAYER->GetPlayerVarInt(playerid, EmpresaID) == INVALID_BUSINESS_ID)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui uma empresa.");

	new businessid = call::BUSINESS->GetBusinessInRangeP(playerid, 2.0), pName[MAX_PLAYER_NAME];

	if(call::BUSINESS->GetBusinessParamsInt(businessid, Impostos) >= 1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Sua empresa tem impostos para pagar.");

	if(businessid == INVALID_BUSINESS_ID)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo a nenhuma empresa.");

	if(businessid == call::PLAYER->GetPlayerVarInt(playerid, EmpresaID))
	{
		call::BUSINESS->GetBusinessParams(businessid, Proprietario, pName);
		if(strcmp(pName, GetUserName(playerid), true) == 0)
		{
			new valor = RETURN_VALOR_VENDA(businessid);
			ShowPlayerDialog(playerid, bMENU_VENDA_BUSINESS, DIALOG_STYLE_MSGBOX, "VENDER EMPRESA", "{"COR_BRANCO_INC"}Você quer realmente vender sua empresa?\n\nVocê ira receber {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"} pela venda.\n\n\t{"COR_ERRO_INC"}Essa ação é permanente e irreversível.", "Vender", "Sair", RealStr(valor));
			return true;
		}
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário desta empresa.");
		return true;
	}
	return true;
}*/

CMD:demissao(playerid)
{
	if ( call::PLAYER->GetPlayerVarInt(playerid, EmpresaID) == INVALID_BUSINESS_ID )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não trabalha em nenhuma empresa.");

	new empresaid = call::BUSINESS->GetBusinessInRangeP(playerid, 2.0);
	if ( empresaid == INVALID_BUSINESS_ID )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo a nenhuma empresa.");

	new pNome[MAX_PLAYER_NAME];
	call::BUSINESS->GetBusinessParams(empresaid, Proprietario, pNome, MAX_PLAYER_NAME);

	if ( strcmp(pNome, GetUserName(playerid), true) == 0 || isnull((pNome)) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você é o proprietário desta empresa.");

	if ( empresaid != call::PLAYER->GetPlayerVarInt(playerid, EmpresaID) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não trabalha nessa empresa.");

	new query[350];
	mysql_format(getConexao(), query, 350, "UPDATE `usuarios` SET `empresaid`='0', `entregasempresa`='0' WHERE `id`='%d'", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
	mysql_tquery(getConexao(), query);
	
	SendClientMessage(playerid, -1, "| EMPRESA | Você se demitiu da Empresa ID {1C88F0}%d {ffffff}com sucesso.", call::BUSINESS->GetBusinessParamsInt(empresaid, ID));
	
	call::PLAYER->SetPlayerVarInt(playerid, EmpresaID, INVALID_BUSINESS_ID);

	call::BUSINESS->UpdateBusinessTexts(empresaid);
	return true;
}