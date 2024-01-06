

enum e_TDV_ROTAS
{
	CompanheiroId,
	VeiculoId,
	Valor,
	CaixaId,
	bool:Trabalhando
}
static Tdv[MAX_PLAYERS][e_TDV_ROTAS];



// =================== [ HOOKS ]
#include <YSI\y_hooks>


hook OnGameModeInit()
{
	CreateDynamic3DTextLabel("Use {"COR_AMARELO_INC"}/PegarMalote{"COR_BRANCO_INC"}", COR_BRANCO, 1410.9916,-317.2098, 4576.0054, 10.0, .streamdistance=10.0, .testlos=1);

	// veiculos da profissão
	call::JOB->SetVehicleJob(CreateVehicle(428, 603.0027, -1304.8356, 14.3035, 3.4160,   0, 0, TIME_VEHICLE_SPAWN), TRANSP_VALORES); // 
	call::JOB->SetVehicleJob(CreateVehicle(428, 608.1136, -1304.5900, 14.5222, 359.5390, 0, 0, TIME_VEHICLE_SPAWN), TRANSP_VALORES); // 
	call::JOB->SetVehicleJob(CreateVehicle(428, 612.6477, -1304.8009, 14.6849, 357.7086, 0, 0, TIME_VEHICLE_SPAWN), TRANSP_VALORES); // 
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if ( Jogador[playerid][Profissao] == TRANSP_VALORES )
	{
		if ( !call::JOB->IsValidVehicleJob(vehicleid) )return Y_HOOKS_CONTINUE_RETURN_1;

		if ( Tdv[playerid][Trabalhando] && vehicleid != Tdv[playerid][VeiculoId])
		{
			SendClientMessage(playerid, COR_ERRO, "| ERRO | Volte ao seu veiculo para finalizar a entrega ou use o comando /terminartrabalho.");
			return Y_HOOKS_CONTINUE_RETURN_1;
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if ( Jogador[playerid][Profissao] == TRANSP_VALORES )
	{
		// iniciar rota de entrega dos malotes.
		if ( newstate == PLAYER_STATE_DRIVER )
		{
			if ( !call::JOB->IsValidVehicleJob(GetPlayerVehicleID(playerid)) )return Y_HOOKS_CONTINUE_RETURN_1;

			ShowPlayerDialog(playerid, ROTA_TRANS_VALORES, DIALOG_STYLE_MSGBOX, "INICIAR ROTA", "{"COR_BRANCO_INC"}Deseja iniciar uma rota para entrega de malote nos caixas eletronicos ?", "Sim", "Não");
			return Y_HOOKS_CONTINUE_RETURN_1;
		}

		// remover malote da mão do segurança
		else if ( newstate == PLAYER_STATE_PASSENGER )
		{
			if ( !Iter_Contains(Caixa, Tdv[playerid][CaixaId]) )
			{
				SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa pegar o malote no banco");
				return Y_HOOKS_CONTINUE_RETURN_1;
			}

			if ( IsPlayerAttachedObjectSlotUsed(playerid, 1) )
				RemovePlayerAttachedObject(playerid, 1);

			new caixaid = Tdv[playerid][CaixaId], companheiroId = Tdv[playerid][CompanheiroId];

			SetPlayerCheckpoint(companheiroId, Caixa[caixaid][Pos][X], Caixa[caixaid][Pos][Y], Caixa[caixaid][Pos][Z], 2.2);
			return Y_HOOKS_CONTINUE_RETURN_1;
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}


// ================== [ CMDS ] =======

CMD:pegarmalote(playerid)
{
	if ( Jogador[playerid][Profissao] != TRANSP_VALORES )
	{
		SendClientMessage(playerid, COR_ERRO, "* Você não é da profissão de Transportador de Valores.");
		return 0;
	}

	if ( !call::JOB->IsPlayerInWorking(playerid) )
	{
		SendClientMessage(playerid, COR_ERRO, "* Você não está trabalhando");
		return 0;
	}

	if ( !IsPlayerInRangeOfPoint(playerid, 2.0, 1410.9916, -317.2098, 4576.0054) )
	{
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não esta no local para pegar o malote.");
		return 0;
	}

	if ( !Tdv[playerid][Trabalhando] )
	{
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você ainda não iniciou a rota.");
		return 0;
	}

	
	/**
	 *
	 *	@Pegar attach do objeto nas costas do jogador.
	 *
	 */
	new caixaid = Iter_Random(Caixa), companheiroId = Tdv[playerid][CompanheiroId], Float:distance;
	
	distance = GetPlayerDistanceFromPoint(playerid, Caixa[caixaid][Pos][X], Caixa[caixaid][Pos][Y], Caixa[caixaid][Pos][Z]);

	new valor = floatround( distance * 30 / 100 );

	Tdv[playerid][CaixaId] = caixaid;
	Tdv[playerid][Valor] = valor; // pegar valor pela distancia.

	Tdv[companheiroId][CaixaId] = caixaid;
	Tdv[companheiroId][Valor] = valor; // pegar o valor pela distancia.

	SetPlayerAttachedObject(playerid, 1, 1550, 6, 0.057000, -0.132000, 0.094999, -20.900054, -6.800011, -92.699958, 1.000000, 1.000000, 1.000000, 0, 0);
	SendClientMessage(playerid, COR_AZUL, "| INFO | Você pegou o malote, agora leve-o até o carro forte para seguir viagem.");
	return 1;
}


// =================== [ Dialogs ]
Dialog:ROTA_TRANS_VALORES(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		if ( !IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER )
		{
			SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo como motorista.");
			return 0;
		}

		new vehicleid = GetPlayerVehicleID(playerid), bool:isPassager;

		Tdv[playerid][Trabalhando] = true;
		Tdv[playerid][VeiculoId] = vehicleid;

		foreach(new i: Player)
		{
			if( IsPlayerInVehicle(i, vehicleid) && GetPlayerVehicleSeat(i) == 1 )
			{
				if ( !call::JOB->IsPlayerInWorking(i) )
				{
					SendClientMessage(i, COR_ERRO, "* Você não está trabalhando");
					SendClientMessage(playerid, COR_ERRO, "* O Seu companheiro não está trabalhando.");
					return 0;
				}

				Tdv[i][Trabalhando] = true;
				Tdv[i][VeiculoId] = vehicleid;

				isPassager = true;
				SendClientMessage(i, COR_AZUL, "» {"COR_BRANCO_INC"}Vá até o interior do banco para pegar o malote de dinheiro.");


				SendClientMessage(playerid, COR_AZUL, "» {"COR_BRANCO_INC"}Você iniciou uma rota, aguarde seu companheiro ir pegar o malote no interior do banco.");
				return 1;
			}
		}

		if ( !isPassager )
			SendClientMessage(playerid, COR_AZUL, "» {"COR_BRANCO_INC"}Você iniciou uma rota, aguarde chama um companheiro de trabalho para ajudar na entrega dos malotes.");
		
		return 1;
	}
	RemovePlayerFromVehicle(playerid);
	return 1;
}