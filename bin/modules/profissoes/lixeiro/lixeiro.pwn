#include <YSI_Coding\y_hooks>

enum e_LIXEIRO
{
	CompanheiroId,
	bool:Working,
	WorkVehicle,
	bool:Coletador,
	bool:Motorista
}
static Lixeiro[MAX_PLAYERS][e_LIXEIRO];

static lCP[MAX_PLAYERS] = -1;
new bool:ColetandoCP[MAX_PLAYERS] = false, TimerColetando[MAX_PLAYERS];

static const Float:RotaMotorista[][] =
{
	{1106.8776, -1882.2081, 14.0978},
	{1128.9005, -1882.4664, 14.0213},
	{1097.1498, -1785.7178, 14.1702},
	{1041.1333, -1633.0819, 13.9377},
	{1006.4941, -1298.8251, 13.9221},
	{965.9962, -1331.0905, 13.9020},
	{878.2236, -1331.0896, 13.9682},
	{868.4543, -1331.1051, 13.9920},
	{739.3978, -1340.5680, 14.0667},
	{739.3984, -1340.5682, 14.0667},
	{739.3984, -1340.5682, 14.0667},
	{519.9084, -1369.3551, 16.5172},
	{409.0477, -1441.1466, 32.4603},
	{466.9436, -1596.8544, 25.7002},
	{786.1205, -1612.3260, 13.9349},
	{806.6089, -1715.1938, 13.9345},
	{1002.0911, -1809.9302, 14.5971},
	{2149.9343, -1996.5524, 13.5545}
};

static const Float:RotaColetador[][] =
{
	{1109.9916, -1876.2633, 13.5469},
	{1129.5942, -1876.0481, 13.5469},
	{1104.2012, -1782.6920, 13.6150},
	{1044.1298, -1640.3969, 13.5469},
	{1014.2618, -1297.0774, 13.5469},
	{958.0511, -1334.4913, 13.5270},
	{869.3752, -1337.8184, 13.5469},
	{875.9703, -1337.7213, 13.5469},
	{733.7153, -1341.1183, 13.5259},
	{733.9457, -1338.3109, 13.5320},
	{734.2125, -1335.3896, 13.5384},
	{530.1688, -1364.4806, 15.9397},
	{402.5035, -1437.4139, 32.6142},
	{464.3469, -1605.0778, 25.5685},
	{789.9702, -1605.3403, 13.3906},
	{803.6594, -1708.7545, 13.5469},
	{996.3932, -1817.1256, 14.0212}
};

hook OnGameModeInit()
{
	CreateDynamicObject(1415,1110.2785600,-1874.5987500,12.5451600,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1415,1110.2785600,-1874.5987500,12.5451600,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1415,1130.3437500,-1874.4812000,12.5466400,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1415,1105.7801500,-1782.8265400,12.5909600,0.0000000,0.0000000,270.2641000); //
	CreateDynamicObject(1440,1043.1835900,-1639.3866000,13.0118300,0.0000000,0.0000000,-96.8400000); //
	CreateDynamicObject(1415,1014.7058700,-1295.9765600,12.5474000,0.0000000,0.0000000,-0.4800000); //
	CreateDynamicObject(1415,877.5349100,-1338.3487500,12.5452900,0.0000000,0.0000000,-89.6999700); //
	CreateDynamicObject(1415,867.9342000,-1338.3569300,12.5480000,0.0000000,0.0000000,90.2399800); //
	CreateDynamicObject(1415,732.6167600,-1337.7094700,12.5360400,0.0000000,0.0000000,90.6000100); //
	CreateDynamicObject(1440,732.7954700,-1335.2713600,12.9171500,0.0000000,0.0000000,-97.0199700); //
	CreateDynamicObject(1440,732.8335600,-1340.1325700,12.9171500,0.0000000,0.0000000,87.0000200); //
	CreateDynamicObject(1415,530.0130000,-1362.7379200,15.0846100,0.0000000,0.0000000,-348.4798300); //
	CreateDynamicObject(1440,403.7917500,-1437.8486300,31.9562100,-3.1800000,-5.5200000,-242.3398300); //
	CreateDynamicObject(1415,464.0212100,-1606.8964800,24.5740100,0.0000000,0.0000000,-180.3598500); //
	CreateDynamicObject(1415,791.6431900,-1605.5200200,12.3801000,0.0000000,0.0000000,-90.0000800); //
	CreateDynamicObject(1440,804.5333900,-1709.4802200,13.0376900,0.0000000,0.0000000,-276.0595100); //
	CreateDynamicObject(1415,995.8720100,-1818.2900400,12.7664700,0.0000000,0.0000000,-192.4798600); //
	CreateDynamicObject(1440,958.7821000,-1333.1499000,13.0312500,356.8584000,0.0000000,3.1415900); //

	call::JOB->SetVehicleJob(CreateVehicle(408, 2182.7065, -1993.1611, 14.0965, 359.4415, 3, 3, TIME_VEHICLE_SPAWN), LIXEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(408, 2190.1338, -1995.8306, 14.0961, 2.0225, 3, 3, TIME_VEHICLE_SPAWN), LIXEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(408, 2153.5112, -1972.2920, 14.0984, 178.2159, 3, 3, TIME_VEHICLE_SPAWN), LIXEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(408, 2147.4021, -1972.0337, 14.1053, 179.1102, 3, 3, TIME_VEHICLE_SPAWN), LIXEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(408, 2141.3677, -1972.1952, 14.1044, 178.6223, 3, 3, TIME_VEHICLE_SPAWN), LIXEIRO);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid)
{
	RemoveBuildingForPlayer(playerid, 1227, 1092.0078, -1881.2813, 13.3047, 0.25);
    RemoveBuildingForPlayer(playerid, 1220, 1092.8438, -1879.6016, 12.8594, 0.25);
    RemoveBuildingForPlayer(playerid, 1220, 1093.5391, -1878.6094, 12.8594, 0.25);
    RemoveBuildingForPlayer(playerid, 1227, 1175.3828, -1877.5625, 13.3047, 0.25);
    RemoveBuildingForPlayer(playerid, 1227, 1091.9844, -1876.8281, 13.3047, 0.25);
    RemoveBuildingForPlayer(playerid, 1227, 1101.9922, -1874.9766, 13.3047, 0.25);
    RemoveBuildingForPlayer(playerid, 1227, 1117.4688, -1874.9766, 13.3047, 0.25);
    RemoveBuildingForPlayer(playerid, 1438, 872.2656, -1346.4141, 12.5313, 0.25);
    RemoveBuildingForPlayer(playerid, 1440, 957.9688, -1336.4531, 13.0313, 0.25);
    RemoveBuildingForPlayer(playerid, 1415, 732.8516, -1332.8984, 12.6875, 0.25);
    RemoveBuildingForPlayer(playerid, 1439, 732.7266, -1341.7734, 12.6328, 0.25);
    
	Lixeiro[playerid][CompanheiroId] = INVALID_PLAYER_ID;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if ( Lixeiro[playerid][CompanheiroId] != INVALID_PLAYER_ID )
	{
		SendClientMessage(Lixeiro[playerid][CompanheiroId], COR_ERRO, "| ERRO | Seu companheiro de trabalho sai do servidor e o serviço foi cancelado.");
		call::LIXEIRO->CancelarServico(Lixeiro[playerid][CompanheiroId]);
	}
	call::LIXEIRO->CancelarServico(playerid);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	if ( playerid != INVALID_PLAYER_ID )
	{
		if ( Lixeiro[playerid][CompanheiroId] != INVALID_PLAYER_ID )
		{
			SendClientMessage(Lixeiro[playerid][CompanheiroId], COR_ERRO, "| ERRO | Seu companheiro de trabalho foi morto e o serviço foi cancelado.");
			call::LIXEIRO->CancelarServico(Lixeiro[playerid][CompanheiroId]);
		}
		call::LIXEIRO->CancelarServico(playerid);
	}

	return Y_HOOKS_CONTINUE_RETURN_1;	
}

hook OnPlayerEnterRaceCP(playerid)
{
	new vehicleid = Lixeiro[playerid][WorkVehicle];

	if(call::JOB->GetVehicleJob(vehicleid) == LIXEIRO)
	{
		if ( Lixeiro[playerid][Motorista] == true )
		{
			if( lCP[playerid] >= (sizeof(RotaMotorista) - 1) )
			{
				new id = Lixeiro[playerid][CompanheiroId], ValoraPagar = random(4000, 2000);

				GivePlayerMoney(playerid, ValoraPagar);
				SendClientMessage(playerid, COR_VERDE, "» Seu caminhão foi descarregado com sucesso.");
				SendClientMessage(playerid, COR_BRANCO, "» Valor ganho: {"COR_VERDE_INC"}R$%s{"COR_VERDE_INC"}.", RealStr(ValoraPagar));

				SendClientMessage(id, COR_VERDE, "» Seu caminhão foi descarregado com sucesso.");
				SendClientMessage(id, COR_BRANCO, "» Valor ganho: {"COR_VERDE_INC"}R$%s{"COR_VERDE_INC"}.", RealStr(ValoraPagar));
				GivePlayerMoney(id, ValoraPagar);
				SetVehicleToRespawn(vehicleid);
				
				call::LIXEIRO->CancelarServico(playerid), call::LIXEIRO->CancelarServico(id);
			}
			else
			{
				DisablePlayerRaceCheckpoint(playerid);

				new id = Lixeiro[playerid][CompanheiroId], lcp = lCP[id];
				SendClientMessage(playerid, COR_BRANCO, "» Aguarde seu companheiro coletar o lixo para prosseguir.");
				SetPlayerCheckpoint(id, RotaColetador[lcp][0], RotaColetador[lcp][1], RotaColetador[lcp][2], 2.0);
				SendClientMessage(id, -1, "» Colete o lixo para prosseguir a rota.");
				return Y_HOOKS_CONTINUE_RETURN_1;
			}
		}
		return Y_HOOKS_CONTINUE_RETURN_1;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
	if(ColetandoCP[playerid] == true)
	{
		DisablePlayerCheckpoint(playerid), ColetandoCP[playerid] = false;

		TogglePlayerControllable(playerid, false);
		ApplyAnimation(playerid,"BOMBER","BOM_Plant_Loop", 2.0, 1, 0, 0, 0, 0);
		GameTextForPlayer(playerid, "~r~Guardando...", 4000, 3);
    	SetTimerEx("GuardandoLixo", 4000, false, "i", playerid);
		return true;
	}

	if(Lixeiro[playerid][Coletador] == true)
	{
		DisablePlayerCheckpoint(playerid);

		TogglePlayerControllable(playerid, false);
		ApplyAnimation(playerid,"BOMBER","BOM_Plant_Loop", 2.0, 1, 0, 0, 0, 0);
		GameTextForPlayer(playerid, "~r~Coletando...", 4500, 3);
		TimerColetando[playerid] = SetTimerEx("ColetandoLixo", 4000, false, "i", playerid);
		return true;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

function LIXEIRO::CancelarServico(playerid)
{
	if ( TimerColetando[playerid] )
	{
		KillTimer(TimerColetando[playerid]);
		TimerColetando[playerid]=0;
	}

	DisablePlayerRaceCheckpoint(playerid);
	DisablePlayerCheckpoint(playerid), RemovePlayerAttachedObject(playerid, 5);

	new r[e_LIXEIRO];
	Lixeiro[playerid] = r;
	lCP[playerid] = 0;
	return true;
}

CMD:iniciarrota(playerid, params[])
{
	if ( !IsPlayerInAnyVehicle(playerid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo.");

	if ( Jogador[playerid][Profissao] != LIXEIRO )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte da profissão Lixeiro");

	//if(!call::JOB->IsPlayerInWorking(playerid))
	//	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando para usar este comando.");

	if( Lixeiro[playerid][Working] )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já tem uma rota para ser concluido.");

	if ( GetPlayerState(playerid) != PLAYER_STATE_DRIVER )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é o motorista.");

	new vehicleid = GetPlayerVehicleID(playerid);

	if ( call::JOB->GetVehicleJob(vehicleid) != LIXEIRO )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um caminhão de Lixeiro.");

	if ( !IsVehicleSeatOccupied(vehicleid, 1) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa de um parceiro de profissão sentado no banco do carona.");

	foreach(new i: Player)
	{
		if( IsPlayerInVehicle(i, vehicleid) && GetPlayerVehicleSeat(i) == 1 )
		{
			Lixeiro[playerid][CompanheiroId] = i;
			Lixeiro[playerid][Working] = true;
			Lixeiro[playerid][WorkVehicle] = vehicleid;
			Lixeiro[playerid][Motorista] = true;
			SendClientMessage(playerid, COR_BRANCO, "» Motorista: {"COR_VERDE_INC"}%s{"COR_BRANCO_INC"}.", GetUserName(playerid));
			SendClientMessage(playerid, COR_BRANCO, "» Coletador: {"COR_VERDE_INC"}%s{"COR_BRANCO_INC"}.", GetUserName(i));
			SendClientMessage(playerid, COR_BRANCO, "» Coleta: {"COR_AMARELO_INC"}Los Santos{"COR_BRANCO_INC"}.");

			Lixeiro[i][CompanheiroId] = playerid;
			Lixeiro[i][Working] = true;
			Lixeiro[i][WorkVehicle] = vehicleid;
			Lixeiro[i][Coletador] = true;
			SendClientMessage(i, COR_BRANCO, "» Motorista: {"COR_VERDE_INC"}%s{"COR_BRANCO_INC"}.", GetUserName(playerid));
			SendClientMessage(i, COR_BRANCO, "» Coletador: {"COR_VERDE_INC"}%s{"COR_BRANCO_INC"}.", GetUserName(i));
			SendClientMessage(i, COR_BRANCO, "» Coleta: {"COR_AMARELO_INC"}Los Santos{"COR_BRANCO_INC"}.");
			
			SetPlayerRaceCheckpoint(playerid, 0, RotaMotorista[0][0], RotaMotorista[0][1], RotaMotorista[0][2], 0, 0, 0, 2.0);
			return 1;
		}
	}
	return 1;
}

forward ColetandoLixo(playerid);
public ColetandoLixo(playerid)
{
	ColetandoCP[playerid] = true, ClearAnimations(playerid),  KillTimer(TimerColetando[playerid]);
	TogglePlayerControllable(playerid, true);

	SetPlayerAttachedObject(playerid, 5, 1264, 6, 0.097999, 0.076999, 0.011000, 172.699859, -4.799996, 89.199981, 1.000000, 0.629000, 0.678000);
	SendClientMessage(playerid, COR_BRANCO, "» Você pegou o saco de lixo, leve até o caminhão.");
	RandomItens(playerid);

	new Float: vpos[4], vehicleid = Lixeiro[playerid][WorkVehicle];
	const Float: distancia = -4.0;

	GetVehiclePos(vehicleid, vpos[0], vpos[1], vpos[2]);
	GetVehicleZAngle(vehicleid, vpos[3]);
	vpos[0] += distancia * floatsin(-vpos[3], degrees);
	vpos[1] += distancia * floatcos(-vpos[3], degrees);
	SetPlayerCheckpoint(playerid, vpos[0], vpos[1], vpos[2], 2.0);
	return true;
}

forward GuardandoLixo(playerid);
public GuardandoLixo(playerid)
{
	new companheiroid = Lixeiro[playerid][CompanheiroId];

	++lCP[playerid], ++lCP[companheiroid], ClearAnimations(playerid), TogglePlayerControllable(playerid, true);
	RemovePlayerAttachedObject(playerid, 5);
	
	new atual = lCP[companheiroid], prox = (atual >= sizeof(RotaMotorista)-1 ? 0 : (atual+1) ), type = (!prox ? 1 : 0);
	SetPlayerRaceCheckpoint(companheiroid, type, RotaMotorista[atual][0], RotaMotorista[atual][1], RotaMotorista[atual][2], 0, 0, 0, 2.0);
	SendClientMessage(companheiroid, COR_BRANCO, "» Prossiga ao próximo checkpoint.");
	return true;
}

stock RandomItens(playerid)
{
	if(Lixeiro[playerid][Coletador] == true)
	{
		new item = random(16, 1), id = Lixeiro[playerid][CompanheiroId];
		switch(item)
		{
			case 1:
			{
				new rand = random(200, 100), valorapagar;
				valorapagar = floatround(rand) / 2;
				SendClientMessage(playerid, COR_BRANCO, "» Você encontrou uma Carteira com {"COR_VERDE_INC"}R$%d{"COR_BRANCO_INC"} e dividiu {"COR_VERDE_INC"}%d{"COR_BRANCO_INC"} com seu companheiro.", rand, valorapagar);
				SendClientMessage(id, COR_BRANCO, "» Seu companheiro encontrou uma carteira com {"COR_VERDE_INC"}R$%d{"COR_VERDE_INC"} e dividiu {"COR_VERDE_INC"}%d{"COR_BRANCO_INC"} com você.", rand, valorapagar);
				GivePlayerMoney(playerid, valorapagar), GivePlayerMoney(id, valorapagar);
			}
			case 3:
			{
				new rand = random(400, 50), valorapagar;
				valorapagar = floatround(rand) / 2;
				SendClientMessage(playerid, COR_BRANCO, "» Você encontrou uma Carteira com {"COR_VERDE_INC"}R$%d{"COR_BRANCO_INC"} e dividiu {"COR_VERDE_INC"}%d{"COR_BRANCO_INC"} com seu companheiro.", rand, valorapagar);
				SendClientMessage(id, COR_BRANCO, "» Seu companheiro encontrou uma carteira com {"COR_VERDE_INC"}R$%d{"COR_VERDE_INC"} e dividiu {"COR_VERDE_INC"}R$%d{"COR_BRANCO_INC"} com você.", rand, valorapagar);
				GivePlayerMoney(playerid, valorapagar), GivePlayerMoney(id, valorapagar);
			}
			case 5:
			{
				SendClientMessage(playerid, COR_BRANCO, "» Você encontrou {"COR_VERDE_INC"}4{"COR_BRANCO_INC"} cigarros de Maconha e dividiu com seu companheiro.");
				SendClientMessage(id, COR_BRANCO, "» Seu companheiro encontrou {"COR_VERDE_INC"}4{"COR_BRANCO_INC"} cigarros de Maconha e dividiu com você.");
				Jogador[playerid][Maconha] += 2, Jogador[id][Maconha] += 2;
			}
			case 7:
			{
				SendClientMessage(playerid, COR_BRANCO, "» Você encontrou {"COR_VERDE_INC"}8{"COR_BRANCO_INC"} cigarros de Maconha e dividiu com seu companheiro.");
				SendClientMessage(id, COR_BRANCO, "» Seu companheiro encontrou {"COR_VERDE_INC"}8{"COR_BRANCO_INC"} cigarroes de Maconha e dividiu com você.");
				Jogador[playerid][Maconha] += 4, Jogador[id][Maconha] += 4;
			}
			case 9:
			{
				SendClientMessage(playerid, COR_BRANCO, "» Você encontrou {"COR_VERDE_INC"}4{"COR_BRANCO_INC"} folhas de cocaina e dividiu com seu companheiro.");
				SendClientMessage(id, COR_BRANCO, "» Seu companheiro encontrou {"COR_VERDE_INC"}4{"COR_BRANCO_INC"} folhas de cocaina e dividiu com você.");
				Jogador[playerid][Cocaina] += 2, Jogador[id][Cocaina] += 2;
			}
			case 11:
			{
				SendClientMessage(playerid, COR_BRANCO, "» Você encontrou {"COR_VERDE_INC"}8{"COR_BRANCO_INC"} folhas de Cocaina e dividiu com seu companheiro.");
				SendClientMessage(id, COR_BRANCO, "» Seu companheiro encontrou {"COR_VERDE_INC"}8{"COR_BRANCO_INC"} folhas de Cocaina e dividiu com você.");
				Jogador[playerid][Cocaina] += 4, Jogador[id][Cocaina] += 4;
			}
			case 13:
			{
				SendClientMessage(playerid, COR_BRANCO, "» Você encontrou {"COR_VERDE_INC"}4{"COR_BRANCO_INC"} pedras de Crack e dividiu com seu companheiro.");
				SendClientMessage(id, COR_BRANCO, "» Seu companheiro encontrou {"COR_VERDE_INC"}4{"COR_BRANCO_INC"} pedras de Crack e dividiu com você.");
				Jogador[playerid][Crack] += 2, Jogador[id][Crack] += 2;
			}
			case 15:
			{
				SendClientMessage(playerid, COR_BRANCO, "» Você encontrou {"COR_VERDE_INC"}8{"COR_BRANCO_INC"} pedras de Crack e dividiu com seu companheiro.");
				SendClientMessage(id, COR_BRANCO, "» Seu companheiro encontrou {"COR_VERDE_INC"}8{"COR_BRANCO_INC"} pedras de Crack e dividiu com você.");
				Jogador[playerid][Crack] += 4, Jogador[id][Crack] += 4;
			}
		}
	}
	return true;
}