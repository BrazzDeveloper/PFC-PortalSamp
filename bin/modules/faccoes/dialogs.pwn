Dialog:MENU_CREATE_FACTION(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		switch(listitem)
		{
			case 0:
			{
				ShowPlayerDialog(playerid, MCF_FACTION_NAME, DIALOG_STYLE_INPUT, "{"COR_AZUL_INC"}CRIAR FACÇÃO » NOME", "{"COR_BRANCO_INC"}Digite o nome da sua facção.", "Confirmar", "Voltar");
				return true;
			}
			case 1:
			{
				ShowPlayerDialog(playerid, MCF_FACTION_COLOR, DIALOG_STYLE_INPUT, "{"COR_AZUL_INC"}CRIAR FACÇÃO » COR", "{"COR_BRANCO_INC"}Digite a cor para sua facção no formato RGB.\n\nExemplo: FFFFFF", "Confirmar", "Voltar");
				return true;
			}
			case 2:
			{
				if ( isnull(faccao@name) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não digitou um nome para sua facção.");

				if ( GetPlayerMoney(playerid) < CREATE_FACTION_VALUE )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem o valor necessário para criar sua facção.");
				
				/**
				*
				*	mensagem de espera enquanto todo o processo de inserção é efetuado.
				*
				**/
				SendClientMessage(playerid, COR_AZUL, "* {"COR_BRANCO_INC"}Estamos trabalhando na criação da sua facção, {"COR_AMARELO_INC"}por favor aguarde{"COR_BRANCO_INC"}.");


				/**
				*
				*	cria a facção no banco de dados e se tudo ocorrer bem seta as informações variáveis da facção.
				*	@return: retorna o indentificador do erro, caso não haja retorna 0.
				*
				**/
				new color[VERIFY_HEX_8];
				format(color, sizeof(color), "%sAA", faccao@color);
				new rtn = CreateFaction_database(faccao@name, GetUserName(playerid), color);	
				

				switch(rtn)
				{
					case ERROR_MAX_LIMIT: SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foi possivel criar a facção, pôs o limite foi ultrapassado.");
					case ERROR_NULL_NAME: SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foi possivel criar a facção, pôs o nome da facção não pode ser nulo.");
					case ERROR_NULL_LIDER_NAME: SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foi possivel criar a facção, pôs o nome do lider não pode ser nulo.");
					case ERROR_FACTION_EXISTS: SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foi possivel criar a facção, pôs o nome da facção já existe.");
					case ERROR_CRITICAL: SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foi possivel criar sua facção, um erro grave aconteceu.");
				}

				/**
				*
				*	resetar as variáveis.
				*
				**/
				faccao@name[0] = EOS;
				faccao@color[0] = EOS;
				return true;
			}
		}
		return true;
	}
	faccao@name[0] = EOS;
	faccao@color[0] = EOS;
	return true;
}


/*Dialog:MCF_FACTION_NAME(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		if ( isnull(inputtext) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa digitar um nome para sua facção."), callcmd::criarfaccao(playerid);

		if ( IsNumeric(inputtext) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa digitar um nome válido para sua facção."), callcmd::criarfaccao(playerid);

		if ( strlen(inputtext) >= MAX_FACTION_NAME )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você digitou um nome para sua facção muito grande."), callcmd::criarfaccao(playerid);

		if ( strlen(inputtext) < 4 )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você digitou um nome para sua facção muito pequeno."), callcmd::criarfaccao(playerid);

		format(faccao@name, MAX_FACTION_NAME, inputtext);
	}
	callcmd::criarfaccao(playerid);
	return true;
}

Dialog:MCF_FACTION_COLOR(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		if ( isnull(inputtext) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa digitar uma cor para sua facção."), callcmd::criarfaccao(playerid);

		if ( !IsValidHex(inputtext, VERIFY_HEX_6) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa digitar uma cor válida para sua facção no formato RGB."), callcmd::criarfaccao(playerid);

		format(faccao@color, 7, inputtext);
	}
	callcmd::criarfaccao(playerid);
	return true;
}*/