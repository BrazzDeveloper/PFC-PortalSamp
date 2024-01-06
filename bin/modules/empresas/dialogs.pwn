

Dialog:bMENU_BUY_BUSINESS(playerid, response, listitem, inputtext[])
{
	if(!response)
		return SendClientMessage(playerid, COR_ERRO, "| INFO | Você cancelou a compra da empresa.");
	
	if(response)
	{
		new pName[MAX_PLAYER_NAME];

		if(call::BUSINESS->GetBusinessInRangeP(playerid, 2.0) == INVALID_BUSINESS_ID)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de nenhuma empresa.");
		
		new businessid = call::BUSINESS->GetBusinessInRangeP(playerid, 2.0);
		
		call::BUSINESS->GetBusinessParams(businessid, Proprietario, pName);

		if(call::BUSINESS->GetBusinessParamsInt(businessid, ValorVenda) <= 0 && strcmp(pName, "Ninguem", true) != 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esta empresa não está a venda.");
		
		if(call::PLAYER->GetPlayerVarInt(playerid, EmpresaID) != INVALID_BUSINESS_ID)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já possui uma empresa ou trabalha em uma.");
		
		SendClientMessageToAll(-1, "| EMPRESA | O(A) jogador(a) %s[%d] comprou a Empresa {1c88f0}%d {ffffff}localizada em {"COR_LARANJA_INC"}%s{ffffff}.", \
		GetUserName(playerid), playerid, call::BUSINESS->GetBusinessParamsInt(businessid, ID), call::BUSINESS->GetBusinessLocalName(businessid) );

		call::PLAYER->SetPlayerVarInt(playerid, EmpresaID, businessid);

		call::BUSINESS->SetBusinessParams(businessid, Proprietario, GetUserName(playerid));

		GivePlayerMoney(playerid, -call::BUSINESS->GetBusinessParamsInt(businessid, Valor));

		new query[350];

		mysql_format(getConexao(), query, 350, "UPDATE `usuarios` SET `empresaid`=0 WHERE `empresaid`=%d", \ 
		call::BUSINESS->GetBusinessParamsInt(businessid, ID));
		mysql_tquery(getConexao(), query);

		mysql_format(getConexao(), query, 350, "UPDATE `usuarios` SET `entregasempresa`=0 WHERE `empresaid`=%d", \ 
		call::BUSINESS->GetBusinessParamsInt(businessid, ID));
		mysql_tquery(getConexao(), query);

		mysql_format(getConexao(), query, 350, "UPDATE `usuarios` SET `empresaid`='%d' WHERE `id`='%d'", call::BUSINESS->GetBusinessParamsInt(businessid, ID), \
		call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
		mysql_tquery(getConexao(), query);


		new id = call::BUSINESS->GetBusinessParamsInt(businessid, ID);

		mysql_format(getConexao(), query, 350, "UPDATE `empresas` SET `proprietario`='%s', `cofre`='0' WHERE `id`='%d'", \
		GetUserName(playerid), id);
		mysql_tquery(getConexao(), query);

		call::BUSINESS->ResetVariables(businessid);

		call::BUSINESS->UpdateBusinessTexts(businessid);
	
	}

	return 1;
}

new SelectedFunc[MAX_PLAYERS][MAX_FUNCIONARIOS];

Dialog:BUSINESS_MENU(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: // Mensagem
			{
				ShowPlayerDialog(playerid, BUSINESS_MSG, DIALOG_STYLE_INPUT, "{ffffff}Alterar a Mensagem", "{ffffff}Digite a mensagem que deseja para sua empresa.\n{ffffff}OBS: É possível utilizar cores HTML na mensagem.", "Confirmar", "Cancelar");
			}

			case 1: // Cofre
			{
				new businessid = call::BUSINESS->GetBusinessInRangeP(playerid, 2.0);

				if(!call::BUSINESS->CheckBusinessProper(playerid, businessid))
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário(a) desta empresa.");

				if(call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) == 0)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem lucros para sacar.");
				
				SendClientMessage(playerid, -1, "| EMPRESA | Você sacou {31b404}R$%s {ffffff}do cofre de sua empresa.", \ 
				RealStr(call::BUSINESS->GetBusinessParamsInt(businessid, Cofre)) );

				GivePlayerMoney(playerid, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre));
				call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, 0);
			}

			case 2: // Funcionários
			{
				new businessid = call::BUSINESS->GetBusinessInRangeP(playerid, 2.0);

				new propname[MAX_PLAYER_NAME];

				call::BUSINESS->GetBusinessParams(businessid, Proprietario, propname, MAX_PLAYER_NAME);

				new query[350];

				format(query, 350, "SELECT * FROM `usuarios` WHERE `empresaid`=%d AND username!='%s'", \ 
				call::BUSINESS->GetBusinessParamsInt(businessid, ID), propname);
				
				new Cache:result = mysql_query(getConexao(), query, true), rows = cache_num_rows();

				if(rows == 0)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Sua empresa não possui funcionários.");

				new String[1000], Str[1000];

				strcat(String, "{ffffff}Funcionário\t{ffffff}Nome\t{ffffff}Entregas Realizadas\n");

				if(rows > 0)
				{
					for(new i; i < rows; i++)
					{
						
						new nome[MAX_PLAYER_NAME], entregas, id;
						cache_get_value_int(i, "id", SelectedFunc[playerid][i]);
						cache_get_value_int(i, "id", id);
						cache_get_value_name(i, "username", nome);
						cache_get_value_int(i, "entregasempresa", entregas);

						format(Str, sizeof(Str), "{1c88f0}Funcionário %d\t{ffffff}%s\t{ff8000}%d\n", i+1, nome, entregas);
						strcat(String, Str);
					}
					new titulo[150];
					format(titulo, 150, "{ffffff}Funcionários da Empresa [ {31b404}%d {ffffff}]", rows);

					ShowPlayerDialog(playerid, DIALOG_EMP_FUNCIONARIOS, DIALOG_STYLE_TABLIST_HEADERS, titulo, String, "Demitir", "Voltar");
				}

				cache_delete(result);
				
			}

			case 3: // Vender Empresa
			{
				new businessid = call::BUSINESS->GetBusinessInRangeP(playerid, 2.0);

				if(businessid == INVALID_BUSINESS_ID)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de nenhuma empresa.");

				if(!call::BUSINESS->CheckBusinessProper(playerid, businessid))
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário(a) desta empresa.");
				
				new String[1000], Str[1000];
				
				strcat(String, "{ff8000}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n");
				
				format(Str, 1000, "{ffffff}» Você deseja vender sua Empresa ID {1c88f0}%d {ffffff}por {31b404}R$%s{ffffff}?\n", \
				call::BUSINESS->GetBusinessParamsInt(businessid, ID), RealStr(call::BUSINESS->GetBusinessParamsInt(businessid, Valor) * 80 / 100) );
				strcat(String, Str);

				format(Str, 1000, "{ffffff}» {ff0000}OBS: Esta ação é irreversível!\n\n");
				strcat(String, Str);

				strcat(String, "{ff8000}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

				ShowPlayerDialog(playerid, DIALOG_EMP_VENDA, DIALOG_STYLE_MSGBOX, "{ffffff}Venda da Empresa", String, "Sim", "Não");
			}

			case 4: // Entregar Mercadoria
			{
				new businessid = call::BUSINESS->GetBusinessInRangeP(playerid, 2.0);

				if(businessid == INVALID_BUSINESS_ID)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de nenhuma empresa.");

				if(!call::BUSINESS->CheckBusinessFunc(playerid, businessid))
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é funcionário(a) desta empresa.");
				
				if(call::PLAYER->GetPlayerVarInt(playerid, Mercadoria) != MERCADORIA_CARREGADA)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não carregou nenhuma mercadoria.");
				
				if(call::PLAYER->GetPlayerVarInt(playerid, Mercadoria) == MERCADORIA_CARREGADA)
				{
					new valorEntrega;
					valorEntrega = call::BUSINESS->GetBusinessParamsInt(businessid, Valor)  / 500;

					call::PLAYER->SetPlayerVarInt(playerid, Mercadoria, MERCADORIA_TEMPO);
					call::BUSINESS->SetBusinessParamsInt(businessid, Producao, call::BUSINESS->GetBusinessParamsInt(businessid, Producao)+1);
					
					call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + valorEntrega);

					if(!call::BUSINESS->CheckBusinessProper(playerid, businessid))
					{
						SendClientMessage(playerid, -1, "| EMPRESA | Você entregou {"COR_LARANJA_INC"}1 {ffffff}mercadoria na Empresa ID {1c88f0}%d {ffffff}e recebeu {31b404}R$2.500{ffffff}.", \
						call::BUSINESS->GetBusinessParamsInt(businessid, ID));
						GivePlayerMoney(playerid, 2500);
					}
					else 
					{
						SendClientMessage(playerid, -1, "| EMPRESA | Você entregou {"COR_LARANJA_INC"}1 {ffffff}mercadoria na Empresa ID {1c88f0}%d{ffffff}.", \
						call::BUSINESS->GetBusinessParamsInt(businessid, ID));
					}

					new query[350];
					mysql_format(getConexao(), query, 350, "UPDATE `empresas` SET `producao`='%d', `cofre`='%d' WHERE `id`='%d'", call::BUSINESS->GetBusinessParamsInt(businessid, Producao), \
					call::BUSINESS->GetBusinessParamsInt(businessid, Cofre), call::BUSINESS->GetBusinessParamsInt(businessid, ID));
					mysql_tquery(getConexao(), query);

					mysql_format(getConexao(), query, 350, "UPDATE `usuarios` SET `entregasempresa`=`entregasempresa`+1 WHERE `id`='%d'", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
					mysql_tquery(getConexao(), query);

					mysql_format(getConexao(), query, 350, "UPDATE `usuarios` SET `mercadoria`='0' WHERE `id`='%d'", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
					mysql_tquery(getConexao(), query);

				}
			}

			case 5: // Contratar Funcionário(a)
			{
				new businessid = call::BUSINESS->GetBusinessInRangeP(playerid, 2.0);

				if(businessid == INVALID_BUSINESS_ID)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de nenhuma empresa.");

				if(!call::BUSINESS->CheckBusinessProper(playerid, businessid))
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário(a) desta empresa.");
				
				new query[350];
				format(query, 350, "SELECT * FROM `usuarios` WHERE `empresaid`='%d'", call::BUSINESS->GetBusinessParamsInt(businessid, ID));
				new Cache:result = mysql_query(getConexao(), query, true), rows = cache_num_rows();

				if(rows > MAX_FUNCIONARIOS)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Sua empresa já atingiu o máximo de funcionários.");
				
				ShowPlayerDialog(playerid, DIALOG_EMP_CONTRATO, DIALOG_STYLE_INPUT, "{ffffff}Contratar Funcionário(a)", "{ffffff}Digite o ID do(a) jogador(a) que deseja contratar.", "Contratar", "Cancelar");

				cache_delete(result);
			}
		}
	}
	return 1;	
}

Dialog:DIALOG_EMP_FUNCIONARIOS(playerid, response, listitem, inputtext[])
{
	new businessid = call::BUSINESS->GetBusinessInRangeP(playerid, 2.0);

	if(!response)
		return call::BUSINESS->ShowPlayerBusinessMenu(playerid, businessid);

	if(response)
	{
		if(businessid == INVALID_BUSINESS_ID)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de nenhuma empresa.");

		if(!call::BUSINESS->CheckBusinessProper(playerid, businessid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário(a) desta empresa.");

		new selected = SelectedFunc[playerid][listitem];
		for(new i; i < sizeof(SelectedFunc[]); i++)
			SelectedFunc[playerid][i] = -1;
		
		SetPVarInt(playerid, "DemitirFunc", selected);

		new query[350];
		format(query, 350, "SELECT * FROM `usuarios` WHERE `id`='%d'", selected);
		new Cache:result = mysql_query(getConexao(), query, true), rows = cache_num_rows();
		if(rows)
		{
			new name[MAX_PLAYER_NAME];
			new String[500], Str[500];

			cache_get_value_name(0, "username", name);

			format(Str, 500, "{ffffff}Você deseja demitir o(a) funcionário(a) {1c88f0}%s{ffffff}?", name);
			strcat(String, Str);

			ShowPlayerDialog(playerid, DIALOG_EMP_DEMITIR, DIALOG_STYLE_MSGBOX, "{ffffff}Demitir Funcionário", String, "Sim", "Não");	
			return 1;
		}

		SendClientMessage(playerid, COR_ERRO, "| ERRO | Houve um erro ao processar a informação. Contate um administrador.");

		cache_delete(result);
	}
	return 1;
}

Dialog:DIALOG_EMP_DEMITIR(playerid, response, listitem, inputtext[])
{
	new businessid = call::BUSINESS->GetBusinessInRangeP(playerid, 2.0);

	if(!response)
		return call::BUSINESS->ShowPlayerBusinessMenu(playerid, businessid);

	if(response)
	{
		new query[350];

		foreach(new i: Player)
		{
			if(call::PLAYER->GetPlayerVarInt(i, PlayerID) == GetPVarInt(playerid, "DemitirFunc"))
			{
				SendClientMessage(playerid, -1, "| EMPRESA | Você demitiu o(a) jogador(a) %s[%d] da Empresa ID {"COR_LARANJA_INC"}%d{ffffff}.", GetUserName(i), i, \
				call::BUSINESS->GetBusinessParamsInt(businessid, ID));

				SendClientMessage(i, COR_ERRO, "| EMPRESA | Você foi demitido(a) da Empresa ID %d pelo(a) proprietário(a) %s[%d]", call::BUSINESS->GetBusinessParamsInt(businessid, ID), \
				GetUserName(playerid), playerid);

				call::PLAYER->SetPlayerVarInt(i, EmpresaID, INVALID_BUSINESS_ID);

				mysql_format(getConexao(), query, 350, "UPDATE `usuarios` SET `empresaid`='0', `entregasempresa`='0' WHERE `id`='%d'", call::PLAYER->GetPlayerVarInt(i, PlayerID));
				mysql_tquery(getConexao(), query);
				return 1;
			}
		}

		format(query, 350, "SELECT * FROM `usuarios` WHERE `id`='%d'", GetPVarInt(playerid, "DemitirFunc"));
		new Cache:result = mysql_query(getConexao(), query, true), rows = cache_num_rows();

		if(rows)
		{
			new name[MAX_PLAYER_NAME];
			cache_get_value_name(0, "username", name, MAX_PLAYER_NAME);

			SendClientMessage(playerid, -1, "| EMPRESA | Você demitiu o(a) jogador(a) {1c88f0}%s {ffffff}da Empresa ID {"COR_LARANJA_INC"}%d{ffffff}.", name, \
			call::BUSINESS->GetBusinessParamsInt(businessid, ID));

			mysql_format(getConexao(), query, 350, "UPDATE usuarios SET `empresaid`='0', `entregasempresa`='0' WHERE `id`='%d'", GetPVarInt(playerid, "DemitirFunc"));
			mysql_tquery(getConexao(), query);
		}

		cache_delete(result);
	}
	return 1;
}

Dialog:DIALOG_EMP_CONTRATO(playerid, response, listitem, inputtext[])
{
	new businessid = call::BUSINESS->GetBusinessInRangeP(playerid, 2.0);

	if(!response)
		return call::BUSINESS->ShowPlayerBusinessMenu(playerid, businessid);

	if(response)
	{
		new id = strval(inputtext);

		if(!IsNumeric(inputtext))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Digite um ID.");
	

		if(businessid == INVALID_BUSINESS_ID)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de nenhuma empresa.");

		if(!call::BUSINESS->CheckBusinessProper(playerid, businessid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário desta empresa.");
		
		if(!IsPlayerConnected(id))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a)");
		
		if(GetPlayerScore(id) < 5)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) precisa ter pelo menos Level 5 para ser contratado.");
		
		new Float:Posicao[4];
		GetPlayerPos(playerid, Posicao[0], Posicao[1], Posicao[2]);

		if(!IsPlayerInRangeOfPoint(id, 6.0, Posicao[0], Posicao[1], Posicao[2]))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) precisa estar próximo de você.");
		
		if(call::PLAYER->GetPlayerVarInt(id, EmpresaID) != INVALID_BUSINESS_ID)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) %s[%d] já é funcionário(a) de uma empresa.", GetUserName(id), id);

		SendClientMessage(id, -1, "| EMPRESA | O(A) jogador(a) %s[%d] lhe contratou na Empresa ID {1c88f0}%d{ffffff}.", GetUserName(playerid), playerid, call::BUSINESS->GetBusinessParamsInt(businessid, ID));
		SendClientMessage(playerid, -1, "| EMPRESA | Você contratou o(a) jogador(a) %s[%d] na Empresa ID {1c88f0}%d{ffffff}.", GetUserName(id), id, call::BUSINESS->GetBusinessParamsInt(businessid, ID));
		
		call::PLAYER->SetPlayerVarInt(id, EmpresaID, GetBusinessIdByRow(call::BUSINESS->GetBusinessParamsInt(businessid, ID)));

		new query[350];
		mysql_format(getConexao(), query, 350, "UPDATE `usuarios` SET `empresaid`='%d' WHERE `id`='%d'", call::BUSINESS->GetBusinessParamsInt(businessid, ID), \
		call::PLAYER->GetPlayerVarInt(id, PlayerID));
		mysql_tquery(getConexao(), query);
	}
	return 1;
}

Dialog:DIALOG_EMP_VENDA(playerid, response, listitem, inputtext[])
{
	new businessid = call::BUSINESS->GetBusinessInRangeP(playerid, 2.0);

	if(!response)
		return call::BUSINESS->ShowPlayerBusinessMenu(playerid, businessid);

	if(response)
	{

		if(businessid == INVALID_BUSINESS_ID)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de nenhuma empresa.");
		
		if(!call::BUSINESS->CheckBusinessProper(playerid, businessid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário desta empresa.");
		
		if(call::BUSINESS->GetBusinessParamsInt(businessid, Impostos) > 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Sua empresa possui impostos pendentes. Pague-os primeiro para poder vender.");
		
		GivePlayerMoney(playerid, call::BUSINESS->GetBusinessParamsInt(businessid, Valor) * 80 / 100);

		SendClientMessageToAll(-1, "| EMPRESA | O(A) jogador(a) %s[%d] vendeu a Empresa ID {1c88f0}%d {ffffff}localizada em {"COR_LARANJA_INC"}%s{ffffff}.", GetUserName(playerid), playerid, call::BUSINESS->GetBusinessParamsInt(businessid, ID), call::BUSINESS->GetBusinessLocalName(businessid) );

		SendClientMessage(playerid, -1, "| EMPRESA | Você vendeu sua Empresa ID {1c88f0}%d {ffffff}e recebeu {31b404}R$%s{ffffff}.", call::BUSINESS->GetBusinessParamsInt(businessid, ID), \
		RealStr( call::BUSINESS->GetBusinessParamsInt(businessid, Valor) * 80 / 100) );

		new query[500];
		mysql_format(getConexao(), query, 350, "UPDATE `usuarios` SET `empresaid`='0', `entregasempresa`='0' WHERE `empresaid`=%d", call::BUSINESS->GetBusinessParamsInt(businessid, ID));
		mysql_tquery(getConexao(), query);

		mysql_format(getConexao(), query, 500, "UPDATE `empresas` SET `proprietario`='Ninguem', `producao`=0, `mensagem`='Nada', `impostos`=0 WHERE `id`=%d", \
		call::BUSINESS->GetBusinessParamsInt(businessid, ID));
		mysql_tquery(getConexao(), query);

		call::BUSINESS->SetBusinessParams(businessid, Proprietario, "Ninguem");
		call::BUSINESS->SetBusinessParamsInt(businessid, Producao, 0);
		call::BUSINESS->SetBusinessParams(businessid, Mensagem, "Nada");
		call::BUSINESS->SetBusinessParamsInt(businessid, Impostos, 0);
		call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, 0);

		call::BUSINESS->UpdateBusinessTexts(businessid);

		call::PLAYER->SetPlayerVarInt(playerid, EmpresaID, INVALID_BUSINESS_ID);

		foreach(new i: Player)
		{
			if( call::PLAYER->GetPlayerVarInt(i, EmpresaID) == GetBusinessIdByRow( call::BUSINESS->GetBusinessParamsInt(businessid, ID) ) )
			{
				if(i != playerid)
				{
					SendClientMessage(i, COR_ERRO, "| EMPRESA | O(A) jogador(a) %s[%d] vendeu a empresa e você foi demitido.", GetUserName(playerid), playerid);
					call::PLAYER->SetPlayerVarInt(i, EmpresaID, INVALID_BUSINESS_ID);
				}
			}
		}
	}
	return 1;
}

Dialog:BUSINESS_MSG(playerid, response, listitem, inputtext[])
{
	new businessid = call::BUSINESS->GetBusinessInRangeP(playerid, 2.0);

	if(!response)
		return call::BUSINESS->ShowPlayerBusinessMenu(playerid, businessid);

	if(strlen(inputtext) > 30 || strlen(inputtext) < 1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você pode colocar até 30 caracteres.");
	
	
	if(businessid == INVALID_BUSINESS_ID)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de nenhuma empresa.");
	
	new proprietario[MAX_PLAYER_NAME];

	call::BUSINESS->GetBusinessParams(businessid, Proprietario, proprietario, MAX_PLAYER_NAME);

	if(strcmp(proprietario, GetUserName(playerid), false, MAX_PLAYER_NAME) == 1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é o proprietário desta empresa.");
	
	call::BUSINESS->SetBusinessParams(businessid, Mensagem, inputtext);

	new query[350];
	mysql_format(getConexao(), query, 350, "UPDATE `empresas` SET `mensagem`='%s' WHERE `id`='%d' LIMIT 1;", inputtext, call::BUSINESS->GetBusinessParamsInt(businessid, ID));
	mysql_tquery(getConexao(), query);

	SendClientMessage(playerid, -1, "| EMPRESA | Você alterou a mensagem de sua empresa para: ( %s {ffffff})", inputtext);

	call::BUSINESS->UpdateBusinessTexts(businessid);
	return 1;	
}