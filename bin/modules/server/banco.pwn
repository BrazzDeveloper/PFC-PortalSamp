
// ============================== [ CALLBACKS ] ============================== //

// Cofre aberto 1829
// Cofre fechado 2332
// Pickup de cash no chão 1212
static 
	COFRES[2];
#include <YSI_Coding\y_hooks>
hook OnGameModeInit()
{
	CP_BANCO[0] = CreateDynamicCP(1396.9323,-32.7127,1000.8950, 1.5, .interiorid=0, .streamdistance=30.0);
	CP_BANCO[1] = CreateDynamicCP(1394.2756,-32.9165,1000.8950, 1.5, .interiorid=0, .streamdistance=30.0);
	CP_BANCO[2] = CreateDynamicCP(1391.4854,-32.6057,1000.8950, 1.5, .interiorid=0, .streamdistance=30.0);
	CP_BANCO[3] = CreateDynamicCP(1388.5740,-32.7423,1000.8950, 1.5, .interiorid=0, .streamdistance=30.0);
	CP_BANCO[4] = CreateDynamicCP(1385.8556,-32.6330,1000.8950, 1.5, .interiorid=0, .streamdistance=30.0);
	CP_BANCO[5] = CreateDynamicCP(1383.1891,-32.7556,1000.8950, 1.5, .interiorid=0, .streamdistance=30.0);

	// MAPA DO COFRE
	CreateObject(14576, 1413.57227, -330.85840, 4583.18701,   0.00000, 0.00000, 0.00000); // Base
	CreateDynamicObject(16637, 1415.65259, -347.02960, 4584.86475,   0.00000, 0.00000, 0.00000, .interiorid=0, .streamdistance=30.0);
	CreateDynamicObject(16637, 1416.67920, -345.52768, 4584.90479,   0.00000, 0.00000, 270.25000, .interiorid=0, .streamdistance=30.0);
	// COFRES
	COFRES[0] = CreateDynamicObject(2332, 1413.74609, -307.54791, 4575.40820,   0.00000, 0.00000, 0.00000, .interiorid=0, .streamdistance=30.0);
	COFRES[1] = CreateDynamicObject(2332, 1412.92029, -307.50861, 4575.40820,   0.00000, 0.00000, 0.00000, .interiorid=0, .streamdistance=30.0);
	//
	CreateDynamicObject(1508, 1432.00000, -1085.42188, 18.25272,   0.00000, 0.00000, 0.00000, .interiorid=0, .streamdistance=30.0);
	CreateDynamicObject(1318, 1460.63086, -1010.61426, 26.49222,   0.00000, 0.00000, 90.00000, .interiorid=0, .streamdistance=30.0);
	CreateDynamicObject(1318, 1431.49255, -1085.41638, 17.94011,   0.00000, 0.00000, 0.00000, .interiorid=0, .streamdistance=30.0);
	CreateDynamicObject(3029, 1419.30896, -348.21060, 4583.28662,   0.00000, 0.00000, 359.06311, .interiorid=0, .streamdistance=30.0);
	CreateDynamicObject(16637, 1415.64075, -347.02789, 4585.54492,   0.00000, 0.00000, 0.00000, .interiorid=0, .streamdistance=30.0);

	CreateDynamic3DTextLabelEx("Use '{"COR_AMARELO_INC"}F{"COR_BRANCO_INC"}' para entrar no cofre do banco", COR_BRANCO, 1390.2467,-27.1702,1000.8950, 20.0, .interiors={0}, .worlds={10, 13, 14, 15}, .streamdistance=20.0, .testlos=1); // Entrada 
	CreateDynamic3DTextLabelEx("Use '{"COR_AMARELO_INC"}F{"COR_BRANCO_INC"}' para sair do cofre do banco", COR_BRANCO, 1418.3618, -347.5796, 4584.3970, 20.0, .interiors={0}, .worlds={10, 13, 14, 15}, .streamdistance=20.0, .testlos=1); // Saida

	CreateDynamic3DTextLabelEx("Use {"COR_AMARELO_INC"}/arrombar{"COR_BRANCO_INC"} para arrombar o cofre do banco.", COR_BRANCO, 1413.4065, -308.3211, 4576.0054, 20.0, .interiors={0}, .worlds={10, 13, 14, 15}, .streamdistance=20.0, .testlos=1);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	if ( checkpointid == CP_BANCO[0] || checkpointid == CP_BANCO[1] || checkpointid == CP_BANCO[2] || checkpointid == CP_BANCO[3] || checkpointid == CP_BANCO[4] || checkpointid == CP_BANCO[5] )
	{	
		call::BANK->ShowPlayerBankMenu(playerid);
		return Y_HOOKS_BREAK_RETURN_1;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if ( PRESSED(KEY_SECONDARY_ATTACK) )
	{
		// Entrada ao cofre 2315.6213,0.1695,26.7422,356.9882
		if ( IsPlayerInRangeOfPoint(playerid, 2.2, 1390.2467,-27.1702,1000.8950) )
		{
			if(Jogador[playerid][Profissao] == POLICIA_MILITAR)	
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
			
			SetPlayerPos(playerid, 1418.3618, -347.5796, 4584.3970);
			SetPlayerFacingAngle(playerid, 314.6876);
			SetPlayerInterior(playerid, 0);
			GameTextForPlayer(playerid, "~r~Aguarde, carregando...", 3000, 3);
			SetTimerEx("DescongelarTeleport", 1500, false, "u", playerid);
			TogglePlayerControllable(playerid, 0);
			return Y_HOOKS_BREAK_RETURN_1;
		}
		// Saida do cofre
		else if ( IsPlayerInRangeOfPoint(playerid, 2.2, 1418.3618, -347.5796, 4584.3970) )
		{
			SetPlayerPos(playerid, 1390.2467,-27.1702,1000.8950);
			SetPlayerFacingAngle(playerid, 356.9882);
			SetPlayerInterior(playerid, 0);
			GameTextForPlayer(playerid, "~r~Aguarde, carregando...", 3000, 3);
			SetTimerEx("DescongelarTeleport", 1500, false, "u", playerid);
			TogglePlayerControllable(playerid, 0);
			return Y_HOOKS_BREAK_RETURN_1;
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

forward OnPlayerCreateAccountBank(playerid);
public OnPlayerCreateAccountBank(playerid)
{
	if ( cache_affected_rows() <= 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foi possivel criar sua conta bancária.");

	//SendClientMessage(playerid, COR_SISTEMA, "============================== [ BANCO ] ==============================");
	SendClientMessage(playerid, COR_VERDE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~ {ffffff}BANCO {"COR_VERDE_INC"}~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, COR_LARANJA, "» {"COR_BRANCO_INC"}Sua conta bancária foi criada com {"COR_VERDE_INC"}êxito{"COR_BRANCO_INC"}!");
	SendClientMessage(playerid, COR_LARANJA, "» {"COR_BRANCO_INC"}O Número da sua conta é {"COR_AZUL_INC"}%06d{"COR_BRANCO_INC"}.", call::BANK->GetPlayerValueBankAccount(playerid, "id"));
	return call::BANK->ShowPlayerBankMenu(playerid);
}

// ============================== [ DIALOGS ] ============================== //
Dialog:MENU_BANCO_OPEN_ACCOUNT(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		if ( call::BANK->IsPlayerAccountOpenned(playerid) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já tem uma conta criada.");

		new query[250];
		mysql_format(getConexao(), query, sizeof(query), "INSERT INTO "TABLE_BANK" (id,username,saldo,senha)VALUES('%d','%s','100','%s');",
			call::PLAYER->GetPlayerVarInt(playerid, PlayerID), GetUserName(playerid), Hash(inputtext));
		mysql_tquery(getConexao(), query, "OnPlayerCreateAccountBank", "i", playerid);
		return true;
	}
	return true;
}

Dialog:MENU_BANCO_SENHA(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		new query[255];
		mysql_format(getConexao(), query, sizeof(query), "SELECT `senha` FROM "TABLE_BANK" WHERE `username`='%e' AND `senha`='%s'", GetUserName(playerid), Hash(inputtext));
		new Cache:cache = mysql_query(getConexao(), query, true);
		call::PLAYER->SetPlayerVarInt(playerid, BankLogin, cache_num_rows());
		cache_delete(cache);

		if ( !call::PLAYER->GetPlayerVarInt(playerid, BankLogin) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você digitou a senha errada.");
		
		call::BANK->ShowPlayerBankMenu(playerid);
		return true;
	}
	return true;
}

Dialog:MENU_CAIXA_SENHA(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		new query[255];
		mysql_format(getConexao(), query, sizeof(query), "SELECT `senha` FROM "TABLE_BANK" WHERE `username`='%e' AND `senha`='%s'", GetUserName(playerid), Hash(inputtext));
		new Cache:cache = mysql_query(getConexao(), query, true);
		call::PLAYER->SetPlayerVarInt(playerid, BankLogin, cache_num_rows());
		cache_delete(cache);

		if ( !call::PLAYER->GetPlayerVarInt(playerid, BankLogin) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você digitou a senha errada.");
		
		call::BANK->ShowPlayerCaixaMenu(playerid);
		return true;
	}
	return true;
}

Dialog:MENU_CAIXA(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		if ( !call::BANK->IsPlayerAccountOpenned(playerid) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem uma conta aberta no banco.");

		switch(listitem)
		{
			case 0: // saldo
			{
				call::BANK->ShowPlayerSaldoCaixa(playerid);
				return true;
			}
			case 1: // Saque
			{
				call::BANK->ShowPlayerSaqueMenuCaixa(playerid);
				return true;
			}
			case 2: // deposito
			{
				SendClientMessage(playerid, COR_ERRO, "| ERRO | Vá até um banco para abrir essa opção");
				return true;
			}
			case 3: // Transferências
			{
				SendClientMessage(playerid, COR_ERRO, "| ERRO | Vá até um banco para abrir essa opção");
				return true;
			}
			case 4: // Extrato
			{
				SendClientMessage(playerid, COR_ERRO, "| ERRO | Vá até um banco para abrir essa opção");
				return true;
			}
		}
		return true;
	}
	return true;
}

Dialog:MENU_CAIXA_SALDO(playerid, response, listitem, inputtext[])
{
	call::BANK->ShowPlayerCaixaMenu(playerid);
	return true;
}

Dialog:MENU_CAIXA_SAQUE(playerid, response, listitem, inputtext[])
{
	call::BANK->ShowPlayerCaixaMenu(playerid);
	if ( response )
	{
		if ( !call::BANK->IsPlayerAccountOpenned(playerid) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem uma conta aberta no banco.");

		if ( isnull(inputtext) || !IsNumeric(inputtext) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você deve digitar um valor válido.");

		new valor = strval(inputtext);

		if ( valor < 1 )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você deve digitar um número maior que 0.");

		if ( valor > 10000 )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não pode sacar uma quantia acima de R$10.000, vá até um banco mais próximo");

		if ( call::BANK->GetPlayerValueBankAccount(playerid, "saldo") < valor)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem saldo disponivel para efetuar o saque.");

		new query[128];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_BANK" SET `saldo`=`saldo`-'%d' WHERE `id`='%d' LIMIT 1;", valor, call::PLAYER->GetPlayerVarInt(playerid, PlayerID) );
		mysql_tquery(getConexao(), query);

		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `dinheiro`=`dinheiro`+'%d' WHERE `id`='%d' LIMIT 1;", valor, call::PLAYER->GetPlayerVarInt(playerid, PlayerID) );
		mysql_tquery(getConexao(), query);

		GivePlayerMoney(playerid, valor);
		call::BANK->ShowPlayerCaixaMenu(playerid);

		SendClientMessage(playerid, COR_SISTEMA, "CAIXA: {"COR_BRANCO_INC"}Você sacou {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"} da sua conta bancária.", RealStr(valor) );
		return true;
	}
	return true;
}

stock function BANK::ShowPlayerSaldoCaixa(playerid)
{
	new saldo = call::BANK->GetPlayerValueBankAccount(playerid, "saldo");
	ShowPlayerDialog(playerid, MENU_CAIXA_SALDO, DIALOG_STYLE_MSGBOX, "{"COR_DISABLE_INC"}MENU CAIXA » {"COR_BRANCO_INC"}SALDO",	"{"COR_BRANCO_INC"}Saldo disponível: {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}.", "OK", "", RealStr(saldo));
	return true;
}
stock function BANK::ShowPlayerSaqueMenuCaixa(playerid)
{
	new saldo = call::BANK->GetPlayerValueBankAccount(playerid, "saldo");
	ShowPlayerDialog(playerid, MENU_CAIXA_SAQUE, DIALOG_STYLE_INPUT, "{"COR_DISABLE_INC"}MENU CAIXA » {"COR_BRANCO_INC"}SAQUE", "{"COR_BRANCO_INC"}Seu saldo disponivel para saque é de {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}\n\tDigite o valor que deseja sacar.", "Sacar", "Voltar", RealStr(saldo));
	return true;
}

Dialog:MENU_BANCO(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		if ( !call::BANK->IsPlayerAccountOpenned(playerid) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem uma conta aberta no banco.");

		switch(listitem)
		{
			case 0: // saldo
			{
				call::BANK->ShowPlayerSaldo(playerid);
				return true;
			}
			case 1: // Saque
			{
				call::BANK->ShowPlayerSaqueMenu(playerid);
				return true;
			}
			case 2: // deposito
			{
				call::BANK->ShowPlayerDepositoMenu(playerid);
				return true;
			}
			case 3: // Transferências
			{
				call::BANK->ShowPlayerTransfMenu(playerid);
				return true;
			}
			case 4: // Extrato
			{
				call::BANK->ShowPlayerExtract(playerid);
				return true;
			}
		}
		return true;
	}
	return true;
}
Dialog:MENU_BANCO_SALDO(playerid, response, listitem, inputtext[])
{
	call::BANK->ShowPlayerBankMenu(playerid);
	return true;
}
Dialog:MENU_BANCO_SAQUE(playerid, response, listitem, inputtext[])
{
	call::BANK->ShowPlayerBankMenu(playerid);
	if ( response )
	{
		if ( !call::BANK->IsPlayerAccountOpenned(playerid) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem uma conta aberta no banco.");

		if ( isnull(inputtext) || !IsNumeric(inputtext) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você deve digitar um valor válido.");

		new valor = strval(inputtext);

		if ( valor < 1 )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você deve digitar um número maior que 0.");

		if ( call::BANK->GetPlayerValueBankAccount(playerid, "saldo") < valor)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem saldo disponivel para efetuar o saque.");

		new query[128];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_BANK" SET `saldo`=`saldo`-'%d' WHERE `id`='%d' LIMIT 1;", valor, call::PLAYER->GetPlayerVarInt(playerid, PlayerID) );
		mysql_tquery(getConexao(), query);

		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `dinheiro`=`dinheiro`+'%d' WHERE `id`='%d' LIMIT 1;", valor, call::PLAYER->GetPlayerVarInt(playerid, PlayerID) );
		mysql_tquery(getConexao(), query);

		GivePlayerMoney(playerid, valor);
		call::BANK->ShowPlayerBankMenu(playerid);

		SendClientMessage(playerid, COR_SISTEMA, "BANCO: {"COR_BRANCO_INC"}Você sacou {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"} da sua conta bancária.", RealStr(valor) );
		return true;
	}
	return true;
}
Dialog:MENU_BANCO_DEPOSITO(playerid, response, listitem, inputtext[])
{
	call::BANK->ShowPlayerBankMenu(playerid);
	if ( response )
	{
		if ( !call::BANK->IsPlayerAccountOpenned(playerid) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui uma conta.");
		
		if ( isnull(inputtext) || !IsNumeric(inputtext) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você deve digitar um valor válido.");

		new valor = strval(inputtext);
		if ( valor < 1 )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você deve digitar um número maior que 0.");

		if ( GetPlayerMoney(playerid) < valor)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem o dinheiro para depositar.");

		new query[128];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_BANK" SET `saldo`=`saldo`+'%d' WHERE `id`='%d' LIMIT 1;", valor, call::PLAYER->GetPlayerVarInt(playerid, PlayerID) );
		mysql_tquery(getConexao(), query);
		GivePlayerMoney(playerid, -valor);
		
		SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Você depositou {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"} em sua conta bancária.", RealStr(valor));
		return true;
	}
	return true;
}
Dialog:MENU_BANCO_TRANSFERENCIA(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		if ( !call::BANK->IsPlayerAccountOpenned(playerid) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui uma conta.");

		if ( isnull(inputtext) || !IsNumeric(inputtext) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você digitou uma conta inválida."), call::BANK->ShowPlayerTransfMenu(playerid);


		new accountNumber = strval(inputtext), query[128];

		if ( accountNumber == Jogador[playerid][PlayerID] )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode transferir dinheiro para sua conta, use o deposito."), call::BANK->ShowPlayerTransfMenu(playerid); 

		mysql_format(getConexao(), query, sizeof(query), "SELECT `username` FROM "TABLE_BANK" WHERE `id`='%d'", accountNumber);
		new Cache:cache = mysql_query(getConexao(), query, true), rows = cache_num_rows();
		
		if ( rows )
		{
			cache_get_value_name(0, "username", Jogador[playerid][TitularTransf]);
			call::PLAYER->SetPlayerVarInt(playerid, NumeroTransf, accountNumber);
			call::BANK->ShowPlayerTransfMenuValor(playerid);

			cache_delete(cache);
			return true;
		}
		cache_delete(cache);
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Essa conta não existe, por favor verifique o número da conta.");
		call::BANK->ShowPlayerTransfMenu(playerid);
		return true;
	}
	call::BANK->ShowPlayerBankMenu(playerid);
	return true;
}
Dialog:MENU_BANCO_TRANSF_VALOR(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		if ( !call::BANK->IsPlayerAccountOpenned(playerid) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui uma conta.");

		if ( isnull(inputtext) || !IsNumeric(inputtext) || strval(inputtext) < 1)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você digitou um valor inválido."), call::BANK->ShowPlayerTransfMenuValor(playerid);

		new valor = strval(inputtext);

		if ( call::BANK->GetPlayerValueBankAccount(playerid, "saldo") < valor)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem saldo suficiente para fazer essa transferência."), call::BANK->ShowPlayerTransfMenuValor(playerid);

		call::PLAYER->SetPlayerVarInt(playerid, ValorTransf, valor);
		call::BANK->ShowPlayerTransfConfirm(playerid);
		return true;
	}
	call::BANK->ShowPlayerTransfMenu(playerid);
	return true;
}

Dialog:MENU_BANCO_TRANSF_CON(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		if ( !call::BANK->IsPlayerAccountOpenned(playerid) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui uma conta.");

		if ( call::BANK->GetPlayerValueBankAccount(playerid, "saldo") < call::PLAYER->GetPlayerVarInt(playerid, ValorTransf) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem saldo suficiente para fazer essa transferência."), call::BANK->ShowPlayerBankMenu(playerid);

		new query[512];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_BANK" SET `saldo`=`saldo`-'%d' WHERE `id`='%d' LIMIT 1;", call::PLAYER->GetPlayerVarInt(playerid, ValorTransf), call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
		mysql_tquery(getConexao(), query);
		
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_BANK" SET `saldo`=`saldo`+'%d' WHERE `id`='%d' LIMIT 1;", call::PLAYER->GetPlayerVarInt(playerid, ValorTransf), call::PLAYER->GetPlayerVarInt(playerid, NumeroTransf));
		mysql_tquery(getConexao(), query);

		mysql_format(getConexao(), query, sizeof (query), "INSERT INTO "TABLE_BANK_TRANSACTION" (from_, to_, value, date)VALUES('%d','%d','%d',NOW());", call::PLAYER->GetPlayerVarInt(playerid, PlayerID), call::PLAYER->GetPlayerVarInt(playerid, NumeroTransf), call::PLAYER->GetPlayerVarInt(playerid, ValorTransf));
		mysql_tquery(getConexao(), query);

		ShowPlayerDialog(playerid, MENU_BANCO_EXTRACT, DIALOG_STYLE_MSGBOX, "{"COR_DISABLE_INC"}MENU BANCO » TRANSFERENCIA » VALOR » {"COR_BRANCO_INC"}EXTRATO",
			"{"COR_VERDE_INC"}TRANSFERENCIA REALIZADA COM ÊXITO!{"COR_BRANCO_INC"}\n\n\
			N° da Conta: {"COR_AZUL_INC"}%06d{"COR_BRANCO_INC"}\nTitular: {"COR_AMARELO_INC"}%s{"COR_BRANCO_INC"}\nValor: {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}", "OK", "", call::PLAYER->GetPlayerVarInt(playerid, NumeroTransf), Jogador[playerid][TitularTransf], RealStr( call::PLAYER->GetPlayerVarInt(playerid, ValorTransf) ) );
		
		call::PLAYER->SetPlayerVarInt(playerid, NumeroTransf, 0);
		call::PLAYER->SetPlayerVarInt(playerid, ValorTransf, 0);
		return true;
	}
	call::BANK->ShowPlayerTransfMenuValor(playerid);
	return true;
}

Dialog:MENU_BANCO_EXTRACT(playerid, response, listitem, inputtext[])
{
	call::BANK->ShowPlayerBankMenu(playerid);
	return false;
}
// ============================== [ FUNCTIONS ] ============================== //

stock function BANK::IsPlayerAccountOpenned(playerid)
{
	new query[128];
	mysql_format(getConexao(), query, sizeof(query), "SELECT `id` FROM "TABLE_BANK" WHERE `id`='%d' LIMIT 1;",  call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
	new Cache:cache = mysql_query(getConexao(), query, true), rows = cache_num_rows();
	cache_delete(cache);
	return rows;
}

stock function BANK::ShowPlayerCaixaMenu(playerid)
{
	if( !call::BANK->IsPlayerAccountOpenned(playerid))
		return SendClientMessage(playerid, COR_AMARELO, "| ERRO | Você não tem uma conta bancária, vá até um banco e abra uma.");

	if ( !call::PLAYER->GetPlayerVarInt(playerid, BankLogin) )
		return ShowPlayerDialog(playerid, MENU_CAIXA_SENHA, DIALOG_STYLE_PASSWORD, "{"COR_DISABLE_INC"}MENU BANCO » {"COR_BRANCO_INC"}SENHA", "{"COR_BRANCO_INC"}Digite a senha de sua conta bancária.", "Confirmar", "Fechar");
	
	ShowPlayerDialog(playerid, MENU_CAIXA, DIALOG_STYLE_LIST, "MENU CAIXA ELETRÔNICO", "Saldo\nSaque\n{ff0000}Deposito\n{ff0000}Transferência\n{ff0000}Extrato", "Selecionar", "Fechar");
	return true;
}

stock function BANK::ShowPlayerBankMenu(playerid)
{
	if ( !call::BANK->IsPlayerAccountOpenned(playerid) )
		return ShowPlayerDialog(playerid, MENU_BANCO_OPEN_ACCOUNT, DIALOG_STYLE_INPUT, "ABERTURA DE CONTA", 
			"{"COR_BRANCO_INC"}Olá, {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"}!\nVocê ainda não tem uma conta bancária, no entanto podemos resolver isso agora mesmo!\n\n\
Para isso você precisa digitar uma senha para criar sua conta.\n\
Essa senha será utilizada constantemente em suas transações, então é importante que anote.\n\n", "Confirmar", "Fechar", GetUserName(playerid));

	if ( !call::PLAYER->GetPlayerVarInt(playerid, BankLogin) )
		return ShowPlayerDialog(playerid, MENU_BANCO_SENHA, DIALOG_STYLE_PASSWORD, "{"COR_DISABLE_INC"}MENU BANCO » {"COR_BRANCO_INC"}SENHA", "{"COR_BRANCO_INC"}Digite a senha de sua conta bancária.", "Confirmar", "Fechar");

	ShowPlayerDialog(playerid, MENU_BANCO, DIALOG_STYLE_LIST, "MENU BANCO", "Saldo\nSaque\nDeposito\nTransferência\nExtrato", "Selecionar", "Fechar");
	return true;
}
stock function BANK::ShowPlayerSaldo(playerid)
{
	new saldo = call::BANK->GetPlayerValueBankAccount(playerid, "saldo");
	ShowPlayerDialog(playerid, MENU_BANCO_SALDO, DIALOG_STYLE_MSGBOX, "{"COR_DISABLE_INC"}MENU BANCO » {"COR_BRANCO_INC"}SALDO",	"{"COR_BRANCO_INC"}Saldo disponível: {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}.", "OK", "", RealStr(saldo));
	return true;
}
stock function BANK::ShowPlayerSaqueMenu(playerid)
{
	new saldo = call::BANK->GetPlayerValueBankAccount(playerid, "saldo");
	ShowPlayerDialog(playerid, MENU_BANCO_SAQUE, DIALOG_STYLE_INPUT, "{"COR_DISABLE_INC"}MENU BANCO » {"COR_BRANCO_INC"}SAQUE", "{"COR_BRANCO_INC"}Seu saldo disponivel para saque é de {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}\n\tDigite o valor que deseja sacar.", "Sacar", "Voltar", RealStr(saldo));
	return true;
}
stock function BANK::ShowPlayerDepositoMenu(playerid)
{
	ShowPlayerDialog(playerid, MENU_BANCO_DEPOSITO, DIALOG_STYLE_INPUT, "{"COR_DISABLE_INC"}MENU BANCO » {"COR_BRANCO_INC"}DEPOSITO", "{"COR_BRANCO_INC"}Digite um valor para depositar em sua conta.", "Depositar", "Voltar");
	return true;
}
stock function BANK::ShowPlayerTransfMenu(playerid)
{
	ShowPlayerDialog(playerid, MENU_BANCO_TRANSFERENCIA, DIALOG_STYLE_INPUT, "{"COR_DISABLE_INC"}MENU BANCO » {"COR_BRANCO_INC"}TRANSFERENCIA", "{"COR_BRANCO_INC"}Para fazer uma transferência você deve saber o número da conta que você deseja transferir.\n\n\t{"COR_VERMELHO_INC"}Digite abaixo o número da conta", "Confirmar", "Voltar");
	return true;
}
stock function BANK::ShowPlayerTransfMenuValor(playerid)
{
	new saldo = call::BANK->GetPlayerValueBankAccount(playerid, "saldo");
	ShowPlayerDialog(playerid, MENU_BANCO_TRANSF_VALOR, DIALOG_STYLE_INPUT, "{"COR_DISABLE_INC"}MENU BANCO » TRANSFERENCIA » {"COR_BRANCO_INC"}VALOR", 
		"{"COR_BRANCO_INC"}Saldo disponivel: {"COR_VERDE_INC"}R$%s\n\n{"COR_VERMELHO_INC"}Digite abaixo o valor que dejesa transferir.", "Confirmar", "Voltar", RealStr(saldo));
	return true;
}
stock function BANK::ShowPlayerTransfConfirm(playerid)
{
	new valor = call::PLAYER->GetPlayerVarInt(playerid, ValorTransf);
	ShowPlayerDialog(playerid, MENU_BANCO_TRANSF_CON, DIALOG_STYLE_MSGBOX, "{"COR_DISABLE_INC"}MENU BANCO » TRANSFERENCIA » {"COR_BRANCO_INC"}CONFIRMAR", 
		"{"COR_BRANCO_INC"}Confirme os dados abaixo e clique em '{"COR_AZUL_INC"}transferir{"COR_BRANCO_INC"}' abaixo.\n\nConta: {"COR_AZUL_INC"}%06d{"COR_BRANCO_INC"}\nTitular: {"COR_AMARELO_INC"}%s{"COR_BRANCO_INC"}\nValor: {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}", "Transferir", "Voltar", call::PLAYER->GetPlayerVarInt(playerid, NumeroTransf), Jogador[playerid][TitularTransf], RealStr(valor));
	return true;
}
stock function BANK::ShowPlayerExtract(playerid)
{
	if ( !call::BANK->IsPlayerAccountOpenned(playerid) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui uma conta."), call::BANK->ShowPlayerBankMenu(playerid);

	new query[512];
	mysql_format(getConexao(), query, sizeof(query), "SELECT from_, to_, value, DATE_FORMAT( date, \"%%d/%%m/%%Y\" ) AS date \
		FROM "TABLE_BANK_TRANSACTION" WHERE from_ = %d OR to_ = %d ORDER BY date DESC LIMIT 10", call::PLAYER->GetPlayerVarInt(playerid, PlayerID), call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
	new Cache:cache = mysql_query(getConexao(), query, true), rows = cache_num_rows(), str[1024];
	
	if ( !rows )
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem extrato de transações feitas."), call::BANK->ShowPlayerBankMenu(playerid);

	str = "{"COR_AZUL_INC"}De\t{"COR_LARANJA_INC"}Para\t{"COR_VERDE_INC"}Valor\t{ffffff}Data\n";

	for(new i; i < rows; i++)
	{
		new from, to, value, date[11];
		cache_get_value_index_int(i, 0, from);
		cache_get_value_index_int(i, 1, to);
		cache_get_value_index_int(i, 2, value);
		cache_get_value_index(i, 3, date);

		format(str, sizeof(str), "%s{ff0000}%dº {"COR_AZUL_INC"}%06d\t{"COR_LARANJA_INC"}%06d\t{"COR_VERDE_INC"}R$%s\t{ffffff}%s\n", str, (i+1), from, to, RealStr(value), date);
		//format(str, sizeof(str), "%s{"COR_BRANCO_INC"}De: {"COR_AZUL_INC"}%06d{"COR_BRANCO_INC"}\tPara: {"COR_AMARELO_INC"}%06d{"COR_BRANCO_INC"}\tValor: {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}\tData: {"COR_AMARELO_INC"}%s{"COR_BRANCO_INC"}\n", str, from, to, RealStr(value), date);
	}
	cache_delete(cache);
	//ShowPlayerDialog(playerid, MENU_BANCO_EXTRACT, DIALOG_STYLE_MSGBOX, "{"COR_AZUL_INC"}EXTRATO", str, "Confirmar", "");
	ShowPlayerDialog(playerid, MENU_BANCO_EXTRACT, DIALOG_STYLE_TABLIST_HEADERS, "{"COR_AMARELO_INC"}Extrato", str, "Confirmar", "");
	return true;
}
stock function BANK::GetPlayerValueBankAccount(playerid, column[])
{
	if ( call::BANK->IsPlayerAccountOpenned(playerid) )
	{
		new value, query[128];
		mysql_format(getConexao(), query, sizeof(query), "SELECT %s FROM "TABLE_BANK" WHERE `id`='%d' LIMIT 1;",  column, call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
		new Cache:cache = mysql_query(getConexao(), query, true);
		cache_get_value_name_int(0, column, value), cache_delete(cache);
		return value;
	}
	return false;
}