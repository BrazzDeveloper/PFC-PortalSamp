
static 
	pVehicleDetran[MAX_PLAYERS] = INVALID_VEHICLE_ID, e_HABILITACAO:pHabilitacao[MAX_PLAYERS], DetranID[MAX_PLAYERS] = INVALID_PROPERTY_ID,
	pTypeHab[MAX_PLAYERS]
;

static pCP[MAX_PLAYERS] = -1, detran@timer_id[MAX_PLAYERS], detran@timer_car[MAX_PLAYERS];


static const 
	TYPE_TERRESTRE = 1,
	TYPE_MARITIMO = 2,
	TYPE_AVIARIO = 3
;
static const Float:TesteDirecaoTerrestre[][] =
{
	{1198.7053, -1850.6117, 12.9637},
	{1074.7169, -1850.0745, 12.9615},
	{822.0010, -1771.8380, 12.9680},
	{646.5030, -1731.9175, 13.2118},
	{634.1828, -1227.0664, 17.5399},
	{947.3314, -972.3824, 38.1074},
	{1351.5038, -942.9570, 33.9915},
	{1345.5555, -1281.4939, 12.9468},
	{1295.0248, -1697.9221, 12.9450},
	{1188.2675, -1709.7379, 12.9817},
	{1173.3726, -1840.2555, 12.9732},
	{1269.5675, -1839.9767, 13.1184}
};


static const Float:TestePilotagemAviao[][] =
{
	{155.3967, 2505.4895, 17.2127},
	{-274.672, 2510.7021, 104.5977},
	{-698.475, 2342.3003, 199.3245},
	{-945.166, 1825.5444, 231.4259},
	{-784.876, 1111.4108, 297.2880},
	{-336.866, 595.96090, 289.7714},
	{273.7920, 444.33630, 210.2015},
	{722.7396, 800.70810, 170.4709},
	{862.6204, 1688.4358, 156.1649},
	{885.3099, 2361.1152, 145.2465},
	{128.9989, 2508.8982, 17.2250}
};



static const Float:SpawnVehiclesDetran[][] =
{
	{1261.2853,-1794.7522,13.0191,176.3989},
	{1263.0004,-1794.5305,13.0163,178.7869},
	{1265.2332,-1794.6747,13.0112,186.0015},
	{1267.4796,-1794.6152,13.0074,173.8034}
};


#include <YSI_Coding\y_hooks>
hook OnGameModeInit()
{
	// Detran de Los Santos
	CreateDynamicObject(8230, 1295.34875, -1871.27478, 14.56397,  0.00000, 0.00000, 358.772, .interiorid=0, .worldid=-1, .streamdistance=100.0);
	CreateDynamicObject(8231, 1295.47949, -1871.26880, 14.40310,  0.00000, 0.00000, 0.00000, .interiorid=0, .worldid=-1, .streamdistance=100.0);
	CreateDynamicObject(8237, 1301.50342, -1878.01672, 12.62962,  0.00000, 0.00000, 0.00000, .interiorid=0, .worldid=-1, .streamdistance=100.0);
	CreateDynamicObject(1498, 1296.62146, -1862.61572, 12.67960,  0.00000, 0.00000, 0.16680, .interiorid=0, .worldid=-1, .streamdistance=100.0);
	
	// Detran de San Fierro
	CreateDynamicObject(1498, 1167.77466, 1362.90430, 9.89650, 0.00000, 0.00000, 0.00000, .interiorid=0, .worldid=-1, .streamdistance=100.0); // Porta
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if ( Jogador[playerid][TesteDirecao] )
	{
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você foi reprovado em seu teste da Auto Escola.");
	}
	resetVariables(playerid);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	if ( Jogador[playerid][TesteDirecao] )
	{
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você foi reprovado em seu teste da Auto Escola.");
	}
	resetVariables(playerid);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	foreach(new i: Player)
	{
		if(vehicleid == pVehicleDetran[i])
		{
			SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode entrar em um veículo de auto escola.");

			ClearAnimations(playerid);
		}
	}
	return 1;
}

hook OnPlayerEnterRaceCP(playerid)
{
	if ( pVehicleDetran[playerid] == GetPlayerVehicleID(playerid) )
	{
		++pCP[playerid];

	
		if ( (pTypeHab[playerid] == TYPE_TERRESTRE && pCP[playerid] >= sizeof(TesteDirecaoTerrestre) ) || (pTypeHab[playerid] == TYPE_AVIARIO && pCP[playerid] >= sizeof(TestePilotagemAviao) ) )
		{

			/**
			*
			*	enviar um som ao jogador.
			*
			**/
			PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
			
			new str[512], tipo, query[100];
			if ( pTypeHab[playerid] == TYPE_TERRESTRE )
			{
				/**
				*
				*	Verifica a hora, e aplica ...
				*
				**/

				new hora;
				gettime(hora);
				
				if ( hora > 18 || hora <= 4)
				{
					if ( !GetVehicleParams(GetPlayerVehicleID(playerid), VEHICLE_TYPE_LIGHTS) )
					{
						Jogador[playerid][PontosInTeste] -= 19;
						SendClientMessage(playerid, 0x8566CCFF, "| INSTRUTOR | Você perdeu 10 pontos por não acender o farol a noite.");
					}
				}
				/**
				*
				*	Desativar o checkpoint e destruir o veiculo.
				*
				**/
				DisablePlayerRaceCheckpoint(playerid);
				DestroyVehicle(pVehicleDetran[playerid]);
				
				/**
				*
				*	enviar o jogador 'playerid' a Auto Escola que ele entrou.
				*
				**/
				if ( call::PROPERTY->IsValidProperty(DetranID[playerid]) )
				{
					//new p = DetranID[playerid];
					Teleport(playerid,
						-2029.6383,
						-118.0932,
						1035.1719,
						358.1646,
						3,
						7,
						ENTROU_PROPRIEDADE,
						true
					);
				}
			
				/**
				*
				*	Mensagem a ser enviada.
				*
				**/
				SendClientMessage(playerid, COR_BRANCO, "Você finalizou o teste de direção com {"COR_VERDE_INC"}sucesso{"COR_BRANCO_INC"}.");

				/**
				*
				*	Verificar habilitação e setar na variável e no banco de dados.
				*
				**/
				if ( BitFlag_Get(pHabilitacao[playerid], HAB_MOTO) ){
					tipo='a';
					mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `habilitacao_a`='1' WHERE `id`='%d' LIMIT 1;", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
				}
				else if ( BitFlag_Get(pHabilitacao[playerid], HAB_CARRO) ){
					tipo='b';
					mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `habilitacao_b`='1' WHERE `id`='%d' LIMIT 1;", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
				}
				else if ( BitFlag_Get(pHabilitacao[playerid], HAB_CAMINHAO) ){
					tipo='c';
					mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `habilitacao_c`='1' WHERE `id`='%d' LIMIT 1;", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
				}
				
				/**
				*
				*	Formatar uma texto para ser mostrado no dialog.
				*
				**/
				format(str, sizeof(str), "{"COR_VERDE_INC"}~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {"COR_BRANCO_INC"}RESULTADO {"COR_VERDE_INC"}~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
				if ( Jogador[playerid][PontosInTeste] >= 70)
				{
					mysql_tquery(getConexao(), query);

					format(str, sizeof(str), "%s{"COR_BRANCO_INC"}Você fez {"COR_AZUL_INC"}%d{"COR_BRANCO_INC"} pontos.\n", str, Jogador[playerid][PontosInTeste]);
					format(str, sizeof(str), "%sVocê foi {"COR_VERDE_INC"}aprovado(a){"COR_BRANCO_INC"} no teste de direção, com isso você recebeu sua habilitacão da categoria {"COR_AMARELO_INC"}%c{"COR_BRANCO_INC"}", str, toupper(tipo));

					BitFlag_Set(Jogador[playerid][Habilitacao], pHabilitacao[playerid]);
				}
				else
				{
					format(str, sizeof(str), "{"COR_BRANCO_INC"}Você fez {"COR_VERMELHO_INC"}%d{"COR_BRANCO_INC"} pontos.\n", Jogador[playerid][PontosInTeste]);
					format(str, sizeof(str), "%sVocê foi {"COR_VERMELHO_INC"}reprovado(a){"COR_BRANCO_INC"} no teste de direção.\n\n\tTente novamente depois.", str);
				}
				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{"COR_AZUL_INC"}RESULTADO DO TESTE", str, "OK", "");
			}
			else if ( pTypeHab[playerid] == TYPE_AVIARIO )
			{
				/**
				*
				*	Mensagem a ser enviada.
				*
				**/
				SendClientMessage(playerid, COR_BRANCO, "Você finalizou seu teste de pilotagem com {"COR_VERDE_INC"}sucesso{"COR_BRANCO_INC"}.");

				/**
				*
				*	Salvar informação no banco de dados.
				*
				**/
				mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `habilitacao_e`='1' WHERE `id`='%d' LIMIT 1;", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
				mysql_tquery(getConexao(), query);

				/**
				*
				*	Setar informação na variável.
				*
				**/
				BitFlag_Set(Jogador[playerid][Habilitacao], HAB_AVIAO);

				/**
				*
				*	Formatar uma texto para ser mostrado no dialog.
				*
				**/
				format(str, sizeof(str), "{C4C4C4}============================== {"COR_BRANCO_INC"}RESULTADO {C4C4C4}==============================\n");
				if ( Jogador[playerid][PontosInTeste] >= 70)
				{
					mysql_tquery(getConexao(), query);

					format(str, sizeof(str), "%s{"COR_BRANCO_INC"}Você fez {"COR_AZUL_INC"}%d{"COR_BRANCO_INC"} pontos.\n", str, Jogador[playerid][PontosInTeste]);
					format(str, sizeof(str), "%sVocê foi {"COR_VERDE_INC"}aprovado(a){"COR_BRANCO_INC"} no teste de pilotagem, com isso você recebeu sua habilitacão da categoria {"COR_AMARELO_INC"}E{"COR_BRANCO_INC"}", str);

					BitFlag_Set(Jogador[playerid][Habilitacao], pHabilitacao[playerid]);
				}
				else
				{
					format(str, sizeof(str), "{"COR_BRANCO_INC"}Você fez {"COR_VERMELHO_INC"}%d{"COR_BRANCO_INC"} pontos.\n", Jogador[playerid][PontosInTeste]);
					format(str, sizeof(str), "%sVocê foi {"COR_VERMELHO_INC"}reprovado(a){"COR_BRANCO_INC"} no teste de pilotagem.\n\n\tTente novamente depois.", str);
				}
				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{"COR_AZUL_INC"}RESULTADO DO TESTE", str, "OK", "");
			}
			/**
			*
			*	resetar as variáveis.
			*
			**/
			resetVariables(playerid);
			return Y_HOOKS_CONTINUE_RETURN_1;
		}
		
		PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);

		if ( pTypeHab[playerid] == TYPE_TERRESTRE)
		{
			new atual = pCP[playerid], prox = (atual >= sizeof(TesteDirecaoTerrestre)-1 ? 0 : (atual+1) ), type = (!prox ? 1 : 0);
			SetPlayerRaceCheckpoint(playerid, type, TesteDirecaoTerrestre[atual][0], TesteDirecaoTerrestre[atual][1], TesteDirecaoTerrestre[atual][2], TesteDirecaoTerrestre[prox][0], TesteDirecaoTerrestre[prox][1], TesteDirecaoTerrestre[prox][2], 5.0);	
		}
		else if ( pTypeHab[playerid] == TYPE_AVIARIO )
		{
			new atual = pCP[playerid], prox = (atual >= sizeof(TestePilotagemAviao)-1 ? 0 : (atual+1) ), type = (!prox ? 1 : 3);
			SetPlayerRaceCheckpoint(playerid, type, TestePilotagemAviao[atual][0], TestePilotagemAviao[atual][1], TestePilotagemAviao[atual][2], TestePilotagemAviao[prox][0], TestePilotagemAviao[prox][1], TestePilotagemAviao[prox][2], 5.0);	
		}
		return Y_HOOKS_CONTINUE_RETURN_1;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}


// ============================== [ FUNCTIONS ] ============================== //

function DETRAN::IsPlayerInDetran(playerid)
{
	for(new i; i < sizeof(CP_DETRAN); i++)
		if(IsPlayerInDynamicCP(playerid, CP_DETRAN[i]))
			return true;

	return false;
}

stock static modelVehicleTeste(e_HABILITACAO:teste)
{
	if ( BitFlag_Get(teste, HAB_MOTO) )
		return 581;
	else if ( BitFlag_Get(teste, HAB_CARRO) )
		return 405;
	else if ( BitFlag_Get(teste, HAB_CAMINHAO) )
		return 573;
	else if ( BitFlag_Get(teste, HAB_BARCO) )
		return 453;
	else if ( BitFlag_Get(teste, HAB_AVIAO) )
		return 476;

	return 0;
}

/**
*
*	# 	resetVariables(playerid);
*
*	@description: resetar as variaveis do jogador que estiver em teste.
*	@params:
*		# playerid: id do jogador.
*	@return: retorna true se o jogador estiver em teste.
*
**/
stock static resetVariables(playerid)
{
	if ( Jogador[playerid][TesteDirecao] )
	{
		/**
		*
		*	deleta o veiculo
		*
		**/
		if ( pVehicleDetran[playerid] != INVALID_VEHICLE_ID )
		{
			DestroyVehicle(pVehicleDetran[playerid]);
		}

		/**
		*
		*	desativa o checkpoint
		*
		**/
		DisablePlayerRaceCheckpoint(playerid);

		/**
		*
		*	reseta as variáveis.
		*
		**/
		pVehicleDetran[playerid] = INVALID_VEHICLE_ID;
		pHabilitacao[playerid] = e_HABILITACAO:0;
		DetranID[playerid] = INVALID_PROPERTY_ID;
		pCP[playerid] = -1;
		pTypeHab[playerid] = 0;

		
		
		/**
		*
		*	matar o timer
		*
		**/
		if ( detran@timer_id[playerid] != 0 )
		{
			KillTimer(detran@timer_id[playerid]);
			detran@timer_id[playerid] = 0;
			detran@timer_car[playerid] = 0;
		}
		Jogador[playerid][TesteDirecao] = false;
		Jogador[playerid][PontosInTeste] = 0;
		return true;
	}
	return false;
}

// ============================== [ COMMANDs ] ============================== //
CMD:menudetran(playerid)
{
	if(!call::DETRAN->IsPlayerInDetran(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está na Auto Escola.");

	ShowPlayerDialog(playerid, DETRAN_MENU_PRINCIPAL, DIALOG_STYLE_LIST, "MENU AUTO ESCOLA", "Tirar Habilitação\nPagar IPVA\nPagar Multas", "Selecionar", "Fechar");
	return true;
}

CMD:menudetranaviacao(playerid)
{
	ShowPlayerDialog(playerid, AUTO_ESCOLA_AVIACAO, DIALOG_STYLE_TABLIST, "MENU HABILITAÇÕES", "Habilitação Aviões\t{"COR_VERDE_INC"}R$6.000", "Selecionar", "Voltar");
	return true;
}
// ============================== [ DIALOGs ] ============================== //

Dialog:DETRAN_MENU_PRINCIPAL(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: // Tirar Habilitação
			{
				/**
				*
				*	Todas as Habilitações - {"COR_VERDE_INC"}R$15.000
				*
				**/
				ShowPlayerDialog(playerid, DETRAN_MENU_HABILITACAO, DIALOG_STYLE_TABLIST, "MENU HABILITAÇÕES", "Habilitação Motos\t{"COR_VERDE_INC"}R$1.000\nHabilitação Carros\t{"COR_VERDE_INC"}R$2.000\nHabilitação Caminhões\t{"COR_VERDE_INC"}R$4.000\nHabilitação Barcos\t{"COR_VERDE_INC"}R$4.000\nHabilitação Aviões\t{"COR_VERDE_INC"}R$6.000 - {"COR_VERMELHO_INC"}( Las Venturas )\nTodas as Habilitações\t( {"COR_VERMELHO_INC"}desabilitado{"COR_BRANCO_INC"} )", "Selecionar", "Voltar");
				return true;
			}
			case 1: // Pagar IPVA
			{
				new str[512] = "Veiculo\tIPVAs atrasados\tPlaca\n", count;
				foreach(new vehicleid: VehiclePlayers)
				{
					if ( Vehicle[vehicleid][Owner][Id] == Jogador[playerid][PlayerID])
					{
						format(str, sizeof(str), "%s{"COR_VERMELHO_INC"}%s\t{"COR_VERDE_INC"}%d\t{"COR_VERMELHO_INC"}%s\n", str, GetVehicleName(vehicleid), Vehicle[vehicleid][IPVA], Vehicle[vehicleid][Placa]);
						count++;
					}
				}
				if(!count)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem um veiculo.");

				ShowPlayerDialog(playerid, DETRAN_MENU_IPVA, DIALOG_STYLE_TABLIST_HEADERS, "{"COR_DISABLE_INC"}MENU AUTO ESCOLA » {"COR_DISABLE_INC"}PAGAR IPVA", str, "Selecionar", "Voltar");
				return true;
			}
			case 2: // Multas
			{
				new str[512] = "Veiculo\tMultas\tPlaca\n", count;
				foreach(new vehicleid: VehiclePlayers)
				{
					if ( Vehicle[vehicleid][Owner][Id] == Jogador[playerid][PlayerID] )
					{
						format(str, sizeof(str), "%s{"COR_VERMELHO_INC"}%s\t{"COR_VERDE_INC"}%d\t{"COR_VERMELHO_INC"}%s\n", str, GetVehicleName(vehicleid), Vehicle[vehicleid][Multas], Vehicle[vehicleid][Placa]);
						count++;
					}
				}
				if(!count)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem um veiculo.");

				ShowPlayerDialog(playerid, DETRAN_MENU_MULTAS, DIALOG_STYLE_TABLIST_HEADERS, "{"COR_DISABLE_INC"}MENU AUTO ESCOLA » {"COR_DISABLE_INC"}PAGAR MULTAS", str, "Selecionar", "Voltar");
				
				return true;
			}
		}
		return true;
	}
	return true;
}
Dialog:DETRAN_MENU_IPVA(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		new count;
		foreach(new vehicleid: VehiclePlayers)
		{
			if( Vehicle[vehicleid][Owner][Id] == Jogador[playerid][PlayerID] )
			{
				if(listitem == count)
				{
					new model = GetVehicleModel(vehicleid), valor = CALCULATE_IMPOSTOS(call::VH->GetVehicleModelValor(model), Vehicle[vehicleid][IPVA]);
					
					if ( valor <= 0)
						return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse veiculo não tem IPVA atrasado."), callcmd::menudetran(playerid);

					if ( GetPlayerMoney(playerid) < valor )
						return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente para pagar todas as dívidas do veiculo."), callcmd::menudetran(playerid);

					SetPVarInt(playerid, "IPVA@VeiculoSelecionado", vehicleid);

					ShowPlayerDialog(playerid, PAGAR_IPVA, DIALOG_STYLE_MSGBOX, "{"COR_DISABLE_INC"}MENU AUTO ESCOLA » MENU IPVA » {"COR_BRANCO_INC"}PAGAR IPVA", 
						"{"COR_BRANCO_INC"}\tVeiculo: {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"}\n\tIPVAs atrasados: {"COR_AZUL_INC"}%d{"COR_BRANCO_INC"}\n\tValor a pagar: {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}\n\nVocê deseja pagar os IPVAs atrasado do seu veiculo?",
						"Pagar", "Cancelar", GetVehicleModelName(model), Vehicle[vehicleid][IPVA], RealStr( valor ) );
					return true;
				}
				count++;
			}
		}
		return true;
	}
	callcmd::menudetran(playerid);
	return true;
}
Dialog:PAGAR_IPVA(playerid, response, listitem, inputtext[])
{
	callcmd::menudetran(playerid);
	if ( response )
	{

		new vehicleid = GetPVarInt(playerid, "IPVA@VeiculoSelecionado");
		DeletePVar(playerid, "IPVA@VeiculoSelecionado");

		if ( Vehicle[vehicleid][IPVA] < 1 )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse veiculo não tem IPVA a pagar."), callcmd::menudetran(playerid);

		new query[128], valor = CALCULATE_IMPOSTOS(call::VH->GetVehicleModelValor(GetVehicleModel(vehicleid)), Vehicle[vehicleid][IPVA]);

		if ( valor <= 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse veiculo não tem IPVA atrasado."), callcmd::menudetran(playerid);

		if ( GetPlayerMoney(playerid) < valor )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente para pagar o IPVA do veiculo."), callcmd::menudetran(playerid);

		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_VEHICLES_PLAYER" SET `ipva`=0 WHERE `id`='%d'", Vehicle[vehicleid][Id]);
		mysql_tquery(getConexao(), query);
		Vehicle[vehicleid][IPVA]=0;

		GivePlayerMoney(playerid, -valor, true);
		SendClientMessage(playerid, -1, "| DETRAN | Você pagou todos os IPVAs pendentes do seu veículo {"COR_LARANJA_INC"}%s{ffffff}.", GetVehicleName(vehicleid));
		return true;
	}
	return true;
}

Dialog:DETRAN_MENU_MULTAS(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		new count;
		foreach(new vehicleid: VehiclePlayers)
		{
			if( Vehicle[vehicleid][Owner][Id] == Jogador[playerid][PlayerID] )
			{
				if(listitem == count)
				{
					if ( Vehicle[vehicleid][Multas] < 1)
						return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse veiculo não tem multas a pagar."), callcmd::menudetran(playerid);

					new model = GetVehicleModel(vehicleid), valor = (VALOR_POR_MULTA * Vehicle[vehicleid][Multas]);
					

					if ( GetPlayerMoney(playerid) < valor )
						return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente para pagar todas as multas do veiculo."), callcmd::menudetran(playerid);


					SetPVarInt(playerid, "Multas@VeiculoSelecionado", vehicleid);

					ShowPlayerDialog(playerid, PAGAR_MULTA, DIALOG_STYLE_MSGBOX, "{"COR_DISABLE_INC"}MENU AUTO ESCOLA » MULTAS » {"COR_BRANCO_INC"}PAGAR MULTAS", 
						"{"COR_BRANCO_INC"}\tVeiculo: {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"}\n\tMultas Pendentes: {"COR_AZUL_INC"}%d{"COR_BRANCO_INC"}\n\tValor a pagar: {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}\n\nVocê deseja pagar os IPVAs atrasado do seu veiculo?", "Pagar", "Cancelar", GetVehicleModelName(model), Vehicle[vehicleid][Multas], RealStr(valor) );
					return true;
				}
				count++;
			}
		}
		return true;
	}
	callcmd::menudetran(playerid);
	return true;
}
Dialog:PAGAR_MULTA(playerid, response, listitem, inputtext[])
{
	callcmd::menudetran(playerid);

	if ( response )
	{
		new vehicleid = GetPVarInt(playerid, "Multas@VeiculoSelecionado");
		DeletePVar(playerid, "Multas@VeiculoSelecionado");


		new query[128], valor = Vehicle[vehicleid][Multas] * VALOR_POR_MULTA;

		if ( valor <= 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse veiculo não tem multas a pagar."), callcmd::menudetran(playerid);

		if ( GetPlayerMoney(playerid) < valor )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente para pagar todas as multas do veiculo."), callcmd::menudetran(playerid);

		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_VEHICLES_PLAYER" SET `multas`=0 WHERE `id`='%d'", Vehicle[vehicleid][Id]);
		mysql_tquery(getConexao(), query);

		Vehicle[vehicleid][Multas] = 0;

		GivePlayerMoney(playerid, -valor, true);
		SendClientMessage(playerid, -1, "| MULTAS | Você pagou todas as suas multas do veículo {1c88f0}%s{ffffff}.", GetVehicleName(vehicleid));
		return true;
	}
	return true;
}

Dialog:DETRAN_MENU_HABILITACAO(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		CancelarServicos(playerid);
		
		switch(listitem)
		{
			case 0: // Motos
			{
				if ( BitFlag_Get(Jogador[playerid][Habilitacao], HAB_MOTO) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já possui habilitação categoria A");

				if ( GetPlayerMoney(playerid) < 1000 )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente.");
				
				Jogador[playerid][TesteDirecao] = true;
				Jogador[playerid][PontosInTeste] = 100;

				SendClientMessage(playerid, COR_VERDE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {C4C4C4}TESTE DE DIREÇÃO {"COR_VERDE_INC"}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
				SendClientMessage(playerid, 0xC4C4C4FF, "» {"COR_BRANCO_INC"}Para começar o teste de direção ligue o veiculo usando a tecla {C4C4C4}Y{"COR_BRANCO_INC"} ou o comando {C4C4C4}/ligar{"COR_BRANCO_INC"}.");
				SendClientMessage(playerid, 0xC4C4C4FF, "» {"COR_BRANCO_INC"}Você tem que evitar passar nos radares em alta velocidade");
				SendClientMessage(playerid, 0xC4C4C4FF, "» {"COR_BRANCO_INC"}E também evite danificar o veiculo da Auto Escola");
				SendClientMessage(playerid, COR_VERDE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

				GivePlayerMoney(playerid, -1000, true);

				DetranID[playerid] = GetPlayerVirtualWorld(playerid);


				SetVehicleParams(GetPlayerVehicleID(playerid), VEHICLE_TYPE_DOORS, VEHICLE_PARAMS_ON);

				pCP[playerid] = 0;
				BitFlag_Set(pHabilitacao[playerid], HAB_MOTO);
				new rand = random(sizeof(SpawnVehiclesDetran));
				
				Teleport(
					playerid,
					SpawnVehiclesDetran[rand][0],
					SpawnVehiclesDetran[rand][1],
					SpawnVehiclesDetran[rand][2],
					0.0,
					0,
					0,
					ENTROU_NONE
				);

				pVehicleDetran[playerid] = CreateVehicle(modelVehicleTeste(pHabilitacao[playerid]), SpawnVehiclesDetran[rand][0], SpawnVehiclesDetran[rand][1], SpawnVehiclesDetran[rand][2], SpawnVehiclesDetran[rand][3], random(255), random(255), 30);
				PutPlayerInVehicle(playerid, pVehicleDetran[playerid], 0);

				SetPlayerRaceCheckpoint(playerid, 0, TesteDirecaoTerrestre[0][0], TesteDirecaoTerrestre[0][1], TesteDirecaoTerrestre[0][2], TesteDirecaoTerrestre[1][0], TesteDirecaoTerrestre[1][1], TesteDirecaoTerrestre[1][2], 5.0);

				pTypeHab[playerid] = TYPE_TERRESTRE;
				return true;
			}
			case 1: // Carros
			{
				if ( BitFlag_Get(Jogador[playerid][Habilitacao], HAB_CARRO) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já possui habilitação categoria B");
				
				if ( GetPlayerMoney(playerid) < 2000 )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente.");

				DetranID[playerid] = GetPlayerVirtualWorld(playerid);
				
				Jogador[playerid][TesteDirecao] = true;
				Jogador[playerid][PontosInTeste] = 100;

				SendClientMessage(playerid, COR_VERDE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {C4C4C4}TESTE DE DIREÇÃO {"COR_VERDE_INC"}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
				SendClientMessage(playerid, 0xC4C4C4FF, "» {"COR_BRANCO_INC"}Para começar o teste de direção ligue o veiculo usando a tecla {C4C4C4}Y{"COR_BRANCO_INC"} ou o comando {C4C4C4}/ligar{"COR_BRANCO_INC"}.");
				SendClientMessage(playerid, 0xC4C4C4FF, "» {"COR_BRANCO_INC"}Você tem que evitar passar nos radares em alta velocidade");
				SendClientMessage(playerid, 0xC4C4C4FF, "» {"COR_BRANCO_INC"}E também evite danificar o veiculo da Auto Escola");
				SendClientMessage(playerid, COR_VERDE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

				GivePlayerMoney(playerid, -2000, true);

				pCP[playerid] = 0;
				BitFlag_Set(pHabilitacao[playerid], HAB_CARRO);
				new rand = random(sizeof(SpawnVehiclesDetran));
				
				Teleport(
					playerid,
					SpawnVehiclesDetran[rand][0],
					SpawnVehiclesDetran[rand][1],
					SpawnVehiclesDetran[rand][2],
					0.0,
					0,
					0,
					ENTROU_NONE
				);

				pVehicleDetran[playerid] = CreateVehicle(modelVehicleTeste(pHabilitacao[playerid]), SpawnVehiclesDetran[rand][0], SpawnVehiclesDetran[rand][1], SpawnVehiclesDetran[rand][2], SpawnVehiclesDetran[rand][3], random(255), random(255), 30);
				PutPlayerInVehicle(playerid, pVehicleDetran[playerid], 0);

				SetPlayerRaceCheckpoint(playerid, 0, TesteDirecaoTerrestre[0][0], TesteDirecaoTerrestre[0][1], TesteDirecaoTerrestre[0][2], TesteDirecaoTerrestre[1][0], TesteDirecaoTerrestre[1][1], TesteDirecaoTerrestre[1][2], 5.0);
				
				pTypeHab[playerid] = TYPE_TERRESTRE;
				return true;
			}
			case 2: // Caminhões
			{
				if ( BitFlag_Get(Jogador[playerid][Habilitacao], HAB_CAMINHAO) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já possui habilitação categoria C");
				
				if ( GetPlayerMoney(playerid) < 4000 )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente.");

				DetranID[playerid] = GetPlayerVirtualWorld(playerid);
				
				Jogador[playerid][TesteDirecao] = true;
				Jogador[playerid][PontosInTeste] = 100;

				SendClientMessage(playerid, COR_VERDE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {C4C4C4}TESTE DE DIREÇÃO {"COR_VERDE_INC"}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
				SendClientMessage(playerid, 0xC4C4C4FF, "» {"COR_BRANCO_INC"}Para começar o teste de direção ligue o veiculo usando a tecla {C4C4C4}Y{"COR_BRANCO_INC"} ou o comando {C4C4C4}/ligar{"COR_BRANCO_INC"}.");
				SendClientMessage(playerid, 0xC4C4C4FF, "» {"COR_BRANCO_INC"}Você tem que evitar passar nos radares em alta velocidade");
				SendClientMessage(playerid, 0xC4C4C4FF, "» {"COR_BRANCO_INC"}E também evite danificar o veiculo da Auto Escola");
				SendClientMessage(playerid, COR_VERDE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

				GivePlayerMoney(playerid, -4000, true);

				pCP[playerid] = 0;
				BitFlag_Set(pHabilitacao[playerid], HAB_CAMINHAO);
				new rand = random(sizeof(SpawnVehiclesDetran));

				Teleport(
					playerid,
					SpawnVehiclesDetran[rand][0],
					SpawnVehiclesDetran[rand][1],
					SpawnVehiclesDetran[rand][2],
					0.0,
					0,
					0,
					ENTROU_NONE
				);
				pVehicleDetran[playerid] = CreateVehicle(modelVehicleTeste(pHabilitacao[playerid]), SpawnVehiclesDetran[rand][0], SpawnVehiclesDetran[rand][1], SpawnVehiclesDetran[rand][2], SpawnVehiclesDetran[rand][3], random(255), random(255), 30);
				PutPlayerInVehicle(playerid, pVehicleDetran[playerid], 0);

				SetPlayerRaceCheckpoint(playerid, 0, TesteDirecaoTerrestre[0][0], TesteDirecaoTerrestre[0][1], TesteDirecaoTerrestre[0][2], TesteDirecaoTerrestre[1][0], TesteDirecaoTerrestre[1][1], TesteDirecaoTerrestre[1][2], 5.0);
				
				pTypeHab[playerid] = TYPE_TERRESTRE;
				return true;
			}
			case 3: // Barcos
			{
				SendClientMessage(playerid, COR_ERRO, "O Menu não se encontra pronto.");
				return true;
			}
			case 4: // Aviões
			{
				if ( BitFlag_Get(Jogador[playerid][Habilitacao], HAB_AVIAO) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já possui habilitação categoria E");
				
				if ( GetPlayerMoney(playerid) < 4000 )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente.");

				SendClientMessage(playerid, COR_ERRO, "Você deve ir até a auto escola de aviação em Las Venturas.");
				SendClientMessage(playerid, COR_ERRO, "Marcamos no seu radar o local para efetuar o teste.");
				call::PLAYER->SetPlayerMarkGPS(playerid, 415.3265, 2533.5447, 19.14840);
				return true;
			}
			case 5: // Todas
			{
				SendClientMessage(playerid, COR_ERRO, "O Menu não se encontra pronto.");
				return true;
			}
		}
		return true;
	}
	callcmd::menudetran(playerid);
	return true;
}

Dialog:AUTO_ESCOLA_AVIACAO(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		switch(listitem)
		{
			case 0: // aviação
			{
				if ( BitFlag_Get(Jogador[playerid][Habilitacao], HAB_AVIAO) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já possui habilitação categoria C");
				
				if ( GetPlayerMoney(playerid) < 4000 )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente.");
				
				Jogador[playerid][TesteDirecao] = true;
				Jogador[playerid][PontosInTeste] = 100;

				SendClientMessage(playerid, COR_VERDE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {C4C4C4}TESTE DE PILOTAGEM {"COR_VERDE_INC"}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
				SendClientMessage(playerid, 0xC4C4C4FF, "» {"COR_BRANCO_INC"}Para começar o teste de pilotagem ligue o motor do avião usando a tecla {C4C4C4}Y{"COR_BRANCO_INC"} ou o comando {C4C4C4}/ligar{"COR_BRANCO_INC"}.");
				SendClientMessage(playerid, 0xC4C4C4FF, "» {"COR_BRANCO_INC"}Se você explodir o avião você será reprovado.");
				SendClientMessage(playerid, COR_VERDE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

				GivePlayerMoney(playerid, -6000, true);

				pCP[playerid] = 0;
				BitFlag_Set(pHabilitacao[playerid], HAB_AVIAO);

				pVehicleDetran[playerid] = CreateVehicle(476, 346.1782,2541.2439,17.4704,179.3723, random(255), random(255), 30);
				PutPlayerInVehicle(playerid, pVehicleDetran[playerid], 0);

				SetPlayerRaceCheckpoint(playerid, 0, TestePilotagemAviao[0][0], TestePilotagemAviao[0][1], TestePilotagemAviao[0][2], TestePilotagemAviao[1][0], TestePilotagemAviao[1][1], TestePilotagemAviao[1][2], 5.0);
				
				pTypeHab[playerid] = TYPE_AVIARIO;
				return true;
			}
		}
		return true;
	}
	return true;
}


hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if ( Jogador[playerid][TesteDirecao]  )
	{
		if ( newstate != PLAYER_STATE_DRIVER )
		{
			if ( GetPlayerVehicleID(playerid) == pVehicleDetran[playerid] )
			{
				SendClientMessage(playerid, COR_ERRO, "| ERRO | Seu teste foi cancelado por você sair do veículo.");
				CancelarTeste(playerid);
			}
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
	if ( Jogador[playerid][TesteDirecao]  )
	{
		if ( vehicleid == pVehicleDetran[playerid] )
		{
			GameTextForPlayer(playerid, "5", 1000, 3);
			detran@timer_car[playerid] = 5;
			detran@timer_id[playerid] = SetTimerEx("CancelarTeste", 1000, true, "d", playerid);
			return Y_HOOKS_CONTINUE_RETURN_1;
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

forward CancelarTeste(playerid);
public CancelarTeste(playerid)
{
	if ( detran@timer_car[playerid] <= 0)
	{
		SendClientMessage(playerid, COR_BRANCO, "Você {"COR_VERMELHO_INC"}não{"COR_BRANCO_INC"} finalizou o teste de direção.");

		if ( call::PROPERTY->IsValidProperty(DetranID[playerid]) )
		{
			new p = DetranID[playerid];
			SetPlayerPos(playerid, Propriedade[p][Saida][X], Propriedade[p][Saida][Y], Propriedade[p][Saida][Z]);
			SetPlayerVirtualWorld(playerid, p);
			SetPlayerInterior(playerid, Propriedade[p][Interior]);
		}
		resetVariables(playerid);
		return true;
	}
	--detran@timer_car[playerid];

	new str[2];
	format(str, sizeof(str), "%d", detran@timer_car[playerid]);
	GameTextForPlayer(playerid, str, 1000, 5);
	return true;
}