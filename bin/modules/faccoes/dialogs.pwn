Dialog:MENU_CREATE_FACTION(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		switch(listitem)
		{
			case 0:
			{
				ShowPlayerDialog(playerid, MCF_FACTION_NAME, DIALOG_STYLE_INPUT, "{"COR_AZUL_INC"}CRIAR FAC��O � NOME", "{"COR_BRANCO_INC"}Digite o nome da sua fac��o.", "Confirmar", "Voltar");
				return true;
			}
			case 1:
			{
				ShowPlayerDialog(playerid, MCF_FACTION_COLOR, DIALOG_STYLE_INPUT, "{"COR_AZUL_INC"}CRIAR FAC��O � COR", "{"COR_BRANCO_INC"}Digite a cor para sua fac��o no formato RGB.\n\nExemplo: FFFFFF", "Confirmar", "Voltar");
				return true;
			}
			case 2:
			{
				if ( isnull(faccao@name) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Voc� n�o digitou um nome para sua fac��o.");

				if ( GetPlayerMoney(playerid) < CREATE_FACTION_VALUE )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Voc� n�o tem o valor necess�rio para criar sua fac��o.");
				
				/**
				*
				*	mensagem de espera enquanto todo o processo de inser��o � efetuado.
				*
				**/
				SendClientMessage(playerid, COR_AZUL, "* {"COR_BRANCO_INC"}Estamos trabalhando na cria��o da sua fac��o, {"COR_AMARELO_INC"}por favor aguarde{"COR_BRANCO_INC"}.");


				/**
				*
				*	cria a fac��o no banco de dados e se tudo ocorrer bem seta as informa��es vari�veis da fac��o.
				*	@return: retorna o indentificador do erro, caso n�o haja retorna 0.
				*
				**/
				new color[VERIFY_HEX_8];
				format(color, sizeof(color), "%sAA", faccao@color);
				new rtn = CreateFaction_database(faccao@name, GetUserName(playerid), color);	
				

				switch(rtn)
				{
					case ERROR_MAX_LIMIT: SendClientMessage(playerid, COR_ERRO, "| ERRO | N�o foi possivel criar a fac��o, p�s o limite foi ultrapassado.");
					case ERROR_NULL_NAME: SendClientMessage(playerid, COR_ERRO, "| ERRO | N�o foi possivel criar a fac��o, p�s o nome da fac��o n�o pode ser nulo.");
					case ERROR_NULL_LIDER_NAME: SendClientMessage(playerid, COR_ERRO, "| ERRO | N�o foi possivel criar a fac��o, p�s o nome do lider n�o pode ser nulo.");
					case ERROR_FACTION_EXISTS: SendClientMessage(playerid, COR_ERRO, "| ERRO | N�o foi possivel criar a fac��o, p�s o nome da fac��o j� existe.");
					case ERROR_CRITICAL: SendClientMessage(playerid, COR_ERRO, "| ERRO | N�o foi possivel criar sua fac��o, um erro grave aconteceu.");
				}

				/**
				*
				*	resetar as vari�veis.
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
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Voc� precisa digitar um nome para sua fac��o."), callcmd::criarfaccao(playerid);

		if ( IsNumeric(inputtext) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Voc� precisa digitar um nome v�lido para sua fac��o."), callcmd::criarfaccao(playerid);

		if ( strlen(inputtext) >= MAX_FACTION_NAME )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Voc� digitou um nome para sua fac��o muito grande."), callcmd::criarfaccao(playerid);

		if ( strlen(inputtext) < 4 )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Voc� digitou um nome para sua fac��o muito pequeno."), callcmd::criarfaccao(playerid);

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
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Voc� precisa digitar uma cor para sua fac��o."), callcmd::criarfaccao(playerid);

		if ( !IsValidHex(inputtext, VERIFY_HEX_6) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Voc� precisa digitar uma cor v�lida para sua fac��o no formato RGB."), callcmd::criarfaccao(playerid);

		format(faccao@color, 7, inputtext);
	}
	callcmd::criarfaccao(playerid);
	return true;
}*/