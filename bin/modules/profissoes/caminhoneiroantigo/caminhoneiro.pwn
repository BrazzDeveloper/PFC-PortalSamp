enum e_EntregaInfo
{
	Float:entregaX,
	Float:entregaY,
	Float:entregaZ,
	Pagamento,
	Nome[50]
}
static Cargas[][e_EntregaInfo] = 
{
	{0.0, 0.0, 0.0, 0, ""}, // nulo
	{1705.6357, 674.1620, 10.6952, 		1500, 	"Deposito de Las Venturas"},
	{-576.3858, -500.6673, 26.1293, 	1200, 	"Deposito de San Fierro"},
	{65.1519, -288.6596, 1.5781,    	1000,  	"Deposito de BlueBerry"},
	{-1823.9897, 87.7128, 14.8980,		1500,  	"Fábrica  Solarim"}
};

enum e_InfoEntrega
{
	Carga,
	Motorista[MAX_PLAYER_NAME],
	MotoristaID,
	Mercadoria,
	bool:Carregado
}
static Caminhao[MAX_VEHICLES][e_InfoEntrega], reset[e_InfoEntrega], pVehicleID[MAX_PLAYERS] = INVALID_VEHICLE_ID;


static PlayerBar:pBar[MAX_PLAYERS];


// ============================== [ FUNCTIONs ] ============================== //

function JOB_CAM::ShowPlayerEntregas(playerid)
{
	new entrega = random(sizeof(Cargas), 1);
	SetPVarInt(playerid, "entregaid", entrega);
	ShowPlayerDialog(playerid, ENTREGAS_CAMINHONEIRO, DIALOG_STYLE_MSGBOX, "ENTREGAS", "{"COR_BRANCO_INC"}Temos uma entrega para {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"} no valor de  {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"} pela entrega!\n\n\t\tVocê deseja fazer está entrega? * Se você não fizer, você terá que aguardar até 3 minutos para pegar outra carga!",
		"Confirmar", "Cancelar", Cargas[entrega][Nome], RealStr(Cargas[entrega][Pagamento]));
}

function CAM::CancelarEntrega(playerid)
{
	if(pVehicleID[playerid] != INVALID_VEHICLE_ID)
	{
		DisablePlayerCheckpoint(playerid);
		Caminhao[pVehicleID[playerid]] = reset;
		pVehicleID[playerid] = INVALID_VEHICLE_ID;
	}
	return true;
}
// ============================== [ CALLBACKs ] ============================== //
#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	call::JOB->SetVehicleJob(CreateVehicle(435, 2725.9080, -2495.7563, 14.0977, 270.0092, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(435, 2726.0935, -2490.5557, 14.0977, 267.2244, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(435, 2742.1147, -2472.3958, 14.0977, 267.2244, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(435, 2742.3118, -2467.6995, 14.0977, 267.2244, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(435, 2742.4595, -2462.2324, 14.0977, 267.2244, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(514, 2715.3333, -2492.5947, 14.0563, 180.5999, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(514, 2693.8638, -2492.8538, 14.0563, 180.5999, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(514, 2704.4841, -2492.9072, 14.0563, 180.5999, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(514, 2709.6379, -2492.6858, 14.0563, 180.5999, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(514, 2689.2971, -2460.4055, 14.0563, 180.2031, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(435, 2689.1724, -2451.8228, 13.9305, 180.4479, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(514, 2689.2329, -2485.9683, 14.0563, 180.2031, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(435, 2689.3618, -2476.9094, 13.9295, 180.0542, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(514, 2699.3804, -2492.8286, 14.0563, 180.5999, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);

	call::JOB->SetVehicleJob(CreateVehicle(514, 2682.4272, -2518.3274, 13.5843, 0.7800, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(514, 2676.0251, -2518.2271, 13.5843, 0.7800, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(435, 2682.2610, -2530.2058, 13.7484, 0.0000, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(435, 2675.9414, -2530.0146, 13.7484, 0.0000, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(514, 2677.3630, -2484.7615, 14.1913, 179.7001, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(435, 2677.4360, -2474.7109, 14.0514, 179.9400, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(514, 2677.1021, -2460.3503, 13.5843, 179.7001, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(435, 2677.3479, -2450.2075, 14.0514, 179.9400, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(514, 2677.0396, -2435.8657, 13.9903, 179.7001, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(435, 2677.1638, -2425.7444, 14.0514, 179.9400, -1, -1, TIME_VEHICLE_SPAWN), CAMINHONEIRO);

	CreateDynamicObject(967, 2721.92676, -2401.23682, 12.45807,   0.00000, 0.00000, 179.65225);
	CreateDynamicObject(966, 2720.42749, -2402.39160, 12.36275,   0.00000, 0.00000, 87.63685);
	CreateDynamicObject(968, 2720.42139, -2402.47656, 13.22126,   0.00000, 0.00000, 86.14950);
	CreateDynamicObject(967, 2721.40210, -2499.92700, 12.45807,   0.00000, 0.00000, 179.65225);
	CreateDynamicObject(966, 2720.34814, -2500.91821, 12.36275,   0.00000, 0.00000, 87.63685);
	CreateDynamicObject(968, 2720.33545, -2500.94214, 13.22126,   0.00000, 0.00000, 86.14950);

	/*
		AddPlayerClass(106,2787.0313,-2455.6016,13.6338,274.4722,0,0,0,0,0,0); // label 2
		AddPlayerClass(106,,262.5653,0,0,0,0,0,0); // label 1
		AddPlayerClass(106,,269.7719,0,0,0,0,0,0); // label 3
	*/
	CreateDynamic3DTextLabel("Use {"COR_AMARELO_INC"}/carregarcaminhao{"COR_BRANCO_INC"} para carregar o caminhão", COR_BRANCO, 2787.0313, -2455.6016, 13.6338, 50.0, .streamdistance=40.0, .interiorid=0, .worldid=0, .testlos=1);
	CreateDynamic3DTextLabel("Use {"COR_AMARELO_INC"}/carregarcaminhao{"COR_BRANCO_INC"} para carregar o caminhão", COR_BRANCO, 2788.6582, -2417.3157, 13.6335, 50.0, .streamdistance=40.0, .interiorid=0, .worldid=0, .testlos=1);
	CreateDynamic3DTextLabel("Use {"COR_AMARELO_INC"}/carregarcaminhao{"COR_BRANCO_INC"} para carregar o caminhão", COR_BRANCO, 2783.7324, -2494.4160, 13.6552, 50.0, .streamdistance=40.0, .interiorid=0, .worldid=0, .testlos=1);

	return true;
}
hook OnPlayerDisconnect(playerid, reason)
{
	call::CAM->CancelarEntrega(playerid);
}

hook OnVehicleSpawn(vehicleid)
{
	if(call::JOB->IsValidVehicleJob(vehicleid))
	{
		if(Caminhao[vehicleid][Carregado])
		{
			if( IsPlayerConnected(Caminhao[vehicleid][MotoristaID]) )
				SendClientMessage(Caminhao[vehicleid][MotoristaID], COR_ERRO, "Sua entrega foi cancelada.");

			call::CAM->CancelarEntrega(Caminhao[vehicleid][MotoristaID]);
			return true;
		}
	}
	return true;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(call::JOB->IsValidVehicleJob(vehicleid))
		{
			if(call::JOB->GetVehicleJob(vehicleid) == CAMINHONEIRO && Caminhao[vehicleid][Carregado])
			{
				SendClientMessage(playerid, COR_AZUL, "============================== [ ROMANEIO ] ==============================");
				SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Entrega: {"COR_SISTEMA_INC"}%s", Cargas[Caminhao[vehicleid][Carga]][Nome]);
				SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Motorista: {"COR_SISTEMA_INC"}%s{"COR_BRANCO_INC"}", Caminhao[vehicleid][Motorista]);
				SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Valor: {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}", RealStr(Cargas[Caminhao[vehicleid][Carga]][Pagamento]));
				return true;
			}
		}	
	}	
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerEnterRaceCP(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(Caminhao[vehicleid][Carregado] && Caminhao[vehicleid][Mercadoria] >= 100)
	{
		if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != CAMINHONEIRO)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte desta profissão.");

		if(call::JOB->GetVehicleJob(vehicleid) != CAMINHONEIRO)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo da profissão de caminhoneiro.");

		if(!IsTrailerAttachedToVehicle(vehicleid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Trailer não está engatado no veiculo.");

		if(call::JOB->GetVehicleJob(GetVehicleTrailer(vehicleid)) != CAMINHONEIRO)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não engatou um trailer dos caminhoneiros.");

		if(strcmp(Caminhao[vehicleid][Motorista], GetUserName(playerid), true) != 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode fazer a entrega de outro motorista.");

		TogglePlayerControllable(playerid, false);
		pBar[playerid] = CreatePlayerProgressBar(playerid, 1.0, 443.0, 641.5, 3.2, COR_VERDE, 100.0000, 0);
		ShowPlayerProgressBar(playerid, pBar[playerid]);
		SetTimerEx("CAM_UpdateCaminhaoStatus", 1000, false, "dd", playerid, vehicleid);
		return false;
	}
	else if(Caminhao[vehicleid][Carregado] && Caminhao[vehicleid][Mercadoria] <= 0)
	{
		if(call::JOB->GetVehicleJob(vehicleid) != CAMINHONEIRO)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo da profissão de caminhoneiro.");

		if(strcmp(Caminhao[vehicleid][Motorista], GetUserName(playerid), true) != 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode finalizar a entrega de outro motorista.");

		SendClientMessage(playerid, COR_AZUL, "============================== [ FINALIZADO ] ==============================");
		SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Você realizou a entrega com {"COR_VERDE_INC"}exito{"COR_BRANCO_INC"}!");
		SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Você recebeu {"COR_VERDE_INC"}+ R$%s", RealStr(Cargas[Caminhao[vehicleid][Carga]][Pagamento]));

		GivePlayerMoney(playerid, Cargas[Caminhao[vehicleid][Carga]][Pagamento]);
		Caminhao[vehicleid] = reset;
		DisablePlayerRaceCheckpoint(playerid);
		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		return false;
	}
	return true;
}

forward CAM_UpdateCaminhaoStatus(playerid, vehicleid);
public CAM_UpdateCaminhaoStatus(playerid, vehicleid)
{
	if(Caminhao[vehicleid][Carregado]) // Se caminhão estiver carregado, descarregue-o
	{
		Caminhao[vehicleid][Mercadoria] -= random(10);
		if(Caminhao[vehicleid][Mercadoria] <= 0)
		{
			Caminhao[vehicleid][Mercadoria] = 0;
			TogglePlayerControllable(playerid, true);
			SetVehicleToRespawn(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
			DestroyPlayerProgressBar(playerid, pBar[playerid]);
			SendClientMessage(playerid, COR_AZUL, "============================== [ ENTREGA ] ==============================");
			SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Entrega {"COR_VERDE_INC"}finalizada{"COR_BRANCO_INC"}!");
			SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Leve o caminhão para transportadora.");
			SetPlayerRaceCheckpoint(playerid, 1, 2719.2932, -2504.1162, 14.0662, 2719.2932, -2504.1162, 14.0662, 5.0);
			return true;
		}
		GameTextForPlayer(playerid, "~g~Descarregando caminhão.", 1000, 3);
	}
	else 		// se não, carregue-o
	{
		Caminhao[vehicleid][Mercadoria] += random(10);
		if(Caminhao[vehicleid][Mercadoria] > 100)
		{
			Caminhao[vehicleid][Mercadoria] = 100;
			Caminhao[vehicleid][Carregado] = true;
			Caminhao[vehicleid][Carga] = GetPVarInt(playerid, "entregaid");

			TogglePlayerControllable(playerid, true);
			SendClientMessage(playerid, COR_AZUL, "============================== [ ROMANEIO ] ==============================");
			SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Entrega: {"COR_SISTEMA_INC"}%s", Cargas[Caminhao[vehicleid][Carga]][Nome]);
			SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Motorista: {"COR_SISTEMA_INC"}%s{"COR_BRANCO_INC"}", GetUserName(playerid));
			SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Valor: {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}", RealStr(Cargas[Caminhao[vehicleid][Carga]][Pagamento]));

			SetPlayerRaceCheckpoint(playerid, 1, Cargas[Caminhao[vehicleid][Carga]][entregaX], Cargas[Caminhao[vehicleid][Carga]][entregaY], Cargas[Caminhao[vehicleid][Carga]][entregaZ], 0.0, 0.0, 0.0, 5.0);
			format(Caminhao[vehicleid][Motorista], MAX_PLAYER_NAME, GetUserName(playerid));
			Caminhao[vehicleid][MotoristaID] = playerid;
			DestroyPlayerProgressBar(playerid, pBar[playerid]);
			return true;
		}
		GameTextForPlayer(playerid, "~g~Carregando caminhão.", 1000, 3);
	}
	SetPlayerProgressBarValue(playerid, pBar[playerid], Caminhao[vehicleid][Mercadoria]);
	SetTimerEx("CAM_UpdateCaminhaoStatus", 1000, false, "dd", playerid, vehicleid);
	return true;
}


// ============================== [ COMMANDs ] ============================== //
CMD:carregarcaminhao(playerid, params[])
{
	if(!call::JOB->IsPlayerInWorking(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");

	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != CAMINHONEIRO)
		return SendClientMessage(playerid, COR_ERRO, "Você não faz parte desta profissão.");

	if(IsPlayerInPlace(playerid, 2775.7603, -2461.1069, 2798.6313, -2451.9810) || IsPlayerInPlace(playerid, 2777.3699, -2423.0994, 2798.0623, -2413.6011) || IsPlayerInPlace(playerid, 2775.7798, -2499.9531, 2798.3660, -2490.2825)) // Caminhoneiro
	{
		if(Jogador[playerid][bCarga] > gettime())
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você tem que aguardar {"COR_BRANCO_INC"}%d{"COR_ERRO_INC"} segundos para pegar outra carga.", Jogador[playerid][bCarga] - gettime());

		new vehicleid = GetPlayerVehicleID(playerid);

		if(call::JOB->GetVehicleJob(vehicleid) != CAMINHONEIRO)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo da profissão de caminhoneiro.");

		if(!IsTrailerAttachedToVehicle(vehicleid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Trailer não está engatado no veiculo.");

		if(call::JOB->GetVehicleJob(GetVehicleTrailer(vehicleid)) != CAMINHONEIRO)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não engatou um trailer dos caminhoneiros.");

		if(Caminhao[vehicleid][Carregado] && Caminhao[vehicleid][Mercadoria] >= 100)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse veiculo já está carregado");

		call::JOB_CAM->ShowPlayerEntregas(playerid);
		return true;
	}
	SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está no local para carregar o caminhão.");
	return true;
}

// ============================== [ DIALOGs ] ============================== //
Dialog:ENTREGAS_CAMINHONEIRO(playerid, response, listitem, inpttext[])
{
	Jogador[playerid][bCarga] = gettime() + 180;
	if(response)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(call::JOB->GetVehicleJob(vehicleid) != CAMINHONEIRO)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo da profissão de caminhoneiro.");

		if(!IsTrailerAttachedToVehicle(vehicleid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Trailer não está engatado no veiculo.");

		if(call::JOB->GetVehicleJob(GetVehicleTrailer(vehicleid)) != CAMINHONEIRO)
			return SendClientMessage(playerid, COR_ERRO, "Você não engatou um trailer dos caminhoneiros.");

		pBar[playerid] = CreatePlayerProgressBar(playerid, 1.0, 443.0, 641.5, 3.2, COR_VERDE, 100.0000, 0);
		ShowPlayerProgressBar(playerid, pBar[playerid]);
		pVehicleID[playerid] = vehicleid;
		TogglePlayerControllable(playerid, false);
		SetTimerEx("CAM_UpdateCaminhaoStatus", 1000, false, "dd", playerid, vehicleid);
		return true;
	}
	return false;
}