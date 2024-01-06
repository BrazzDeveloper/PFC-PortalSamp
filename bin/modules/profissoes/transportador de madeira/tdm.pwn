enum _InfoEntrega
{
	Carga,
	LocalName[15],
	Dono[MAX_PLAYER_NAME],
	Mercadoria,
	Valor,
	VehicleID,
	bool:Carregado,
	Objectid,
}
static TDM[MAX_VEHICLES][_InfoEntrega];

static VehicleDFT[10], Madeiras[3], PlayerBar:pBar[MAX_PLAYERS];

// =====================================[ FUNCTIONS ] =====================================================//
function TDM::CancelarEntrega(playerid, msg[]="")
{
	DestroyObject(TDM[playerid][Objectid]);

	new r[_InfoEntrega];
	TDM[playerid] = r;
	call::PLAYER->SetPlayerVarInt(playerid, QuantMadeiras, 0);

	TDM[playerid][Carga] = -1;
	TDM[playerid][VehicleID] = INVALID_VEHICLE_ID;
	DisablePlayerRaceCheckpoint(playerid);

	if(!isnull(msg))
		SendClientMessage(playerid, COR_AVISO, msg);

	return true;
}
// ========================================= [ CallBacks ] =================================================//
#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	VehicleDFT[0] = CreateVehicle(578, -535.0861,-74.2421,63.4520,269.8809, -1, -1, TIME_VEHICLE_SPAWN);
	VehicleDFT[1] = CreateVehicle(578, -530.3393,-60.7794,63.5320,270.2386, -1, -1, TIME_VEHICLE_SPAWN);
	VehicleDFT[2] = CreateVehicle(578, -527.3130,-102.6159,63.9224,266.5440, -1, -1, TIME_VEHICLE_SPAWN);
	VehicleDFT[3] = CreateVehicle(578, -542.2752,-100.7723,64.0335,359.3366, -1, -1, TIME_VEHICLE_SPAWN);
	VehicleDFT[4] = CreateVehicle(578, -547.5319,-100.7696,64.2831,359.8327, -1, -1, TIME_VEHICLE_SPAWN);
	VehicleDFT[5] = CreateVehicle(578, -551.9951,-100.8357,64.4947,0.0803, -1, -1, TIME_VEHICLE_SPAWN);
	VehicleDFT[6] = CreateVehicle(578, -551.8131,-75.9830,63.9141,182.5851, -1, -1, TIME_VEHICLE_SPAWN);
	VehicleDFT[7] = CreateVehicle(578, -556.9590,-76.0548,64.4924,179.6019, -1, -1, TIME_VEHICLE_SPAWN);
	VehicleDFT[8] = CreateVehicle(578, -562.2077,-76.0527,64.7290,179.7290, -1, -1, TIME_VEHICLE_SPAWN);
	VehicleDFT[9] = CreateVehicle(578, -567.3942,-75.9914,64.9526,180.0247, -1, -1, TIME_VEHICLE_SPAWN);

	call::JOB->SetVehicleJob(VehicleDFT[0], TRANSPORTADOR);
	call::JOB->SetVehicleJob(VehicleDFT[1], TRANSPORTADOR);
	call::JOB->SetVehicleJob(VehicleDFT[2], TRANSPORTADOR);
	call::JOB->SetVehicleJob(VehicleDFT[3], TRANSPORTADOR);
	call::JOB->SetVehicleJob(VehicleDFT[4], TRANSPORTADOR);
	call::JOB->SetVehicleJob(VehicleDFT[5], TRANSPORTADOR);
	call::JOB->SetVehicleJob(VehicleDFT[6], TRANSPORTADOR);
	call::JOB->SetVehicleJob(VehicleDFT[7], TRANSPORTADOR);
	call::JOB->SetVehicleJob(VehicleDFT[8], TRANSPORTADOR);
	call::JOB->SetVehicleJob(VehicleDFT[9], TRANSPORTADOR);

	Madeiras[0] = CreateDynamicObject(1463,-2039.8000000,-2378.3999000,29.4000000,0.0000000,0.0000000,0.0000000);//angel pine
	Madeiras[1] = CreateDynamicObject(1463,-533.3998,-161.5798,78.2108,0.0000000,0.0000000,0.0000000);//the farm
	Madeiras[2] = CreateDynamicObject(1463,-1857.1000000,117.1000000,13.9000000,0.0000000,0.0000000,0.0000000);//sf
	
	CreateDynamicObject(17324,-1852.8000000,117.3000000,14.1000000,0.0000000,0.0000000,88.2500000); //object(cw_combbarn) (3)
	CreateDynamicObject(17324,-1041.0000000,-1080.0000000,128.1000100,0.0000000,0.0000000,2.0000000); //object(cw_combbarn) (1)

 	CreateDynamicCP(-494.9909,-67.7966,61.2460, 3.5, .interiorid = 0, .streamdistance = 40.0);
	CreateDynamic3DTextLabel("Use {"COR_AMARELO_INC"}/CarregarMadeiras{"COR_BRANCO_INC"} para carregar o caminhão", COR_BRANCO, -494.9909,-67.7966,61.2460, 50.0, .streamdistance=40.0, .interiorid=0, .worldid=0, .testlos=1);

	CreateDynamicCP(-477.7238,-67.8238,60.5723, 3.5, .interiorid = 0, .streamdistance = 40.0);
	CreateDynamic3DTextLabel("Use {"COR_AMARELO_INC"}/CarregarMadeiras{"COR_BRANCO_INC"} para carregar o caminhão", COR_BRANCO, -477.7238,-67.8238,60.5723, 50.0, .streamdistance=40.0, .interiorid=0, .worldid=0, .testlos=1);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	call::TDM->CancelarEntrega(playerid);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(call::JOB->IsValidVehicleJob(vehicleid))
		{
			if(call::JOB->GetVehicleJob(vehicleid) == TRANSPORTADOR && TDM[vehicleid][Carregado])
			{
				SendClientMessage(playerid, COR_AZUL, "============================== [ ROMANEIO ] ==============================");
				SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Entrega: {"COR_SISTEMA_INC"}%s", TDM[vehicleid][LocalName]);
				SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Motorista: {"COR_SISTEMA_INC"}%s{"COR_BRANCO_INC"}", TDM[vehicleid][Dono]);
				SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Valor: {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}", RealStr(TDM[playerid][Valor]));
				return true;
			}
		}	
	}	
	return Y_HOOKS_CONTINUE_RETURN_1;
}

forward LoadingMadeira(playerid);
public LoadingMadeira(playerid)
{
	if(!IsPlayerConnected(playerid) || !call::PLAYER->IsPlayerLogged(playerid))
		return false;

	TDM[playerid][Mercadoria] += random(20);
	SetPlayerProgressBarValue(playerid, pBar[playerid], TDM[playerid][Mercadoria]);

	if(TDM[playerid][Mercadoria] >= 100)
	{
		new Quant = random(15, 1);
		call::PLAYER->SetPlayerVarInt(playerid, QuantMadeiras, Quant);

		TogglePlayerControllable(playerid, true);
		DestroyPlayerProgressBar(playerid, pBar[playerid]);

		new Float:x, Float:y, Float:z, dist, zone[MAX_ZONE_NAME], valor, cargaid = TDM[playerid][Carga], vehicleid = GetPlayerVehicleID(playerid);

		GetDynamicObjectPos(Madeiras[cargaid], x, y, z);
		SetPlayerRaceCheckpoint(playerid, 1, x, y, z, 0.0, 0.0, 0.0, 8.0);
		GetLocalName(x, y, zone, sizeof(zone));
		dist = floatround(GetPlayerDistanceFromPoint(playerid, x, y, z));
		valor = (dist * 60 / 100);

		SendClientMessage(playerid, COR_AZUL, "============================== [ CARREGAMENTO ] ==============================");
		SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Entrega: {"COR_SISTEMA_INC"}%s", zone);
		SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Motorista: {"COR_SISTEMA_INC"}%s{"COR_BRANCO_INC"}", GetUserName(playerid));
		SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Valor: {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}", RealStr(valor));
		SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Quantidade de Madeiras: {"COR_AMARELO_INC"}%d{"COR_BRANCO_INC"}", Quant);
		SendClientMessage(playerid, COR_AZUL, "============================== [ CARREGAMENTO ] ==============================");

		TDM[playerid][Valor] = (dist * 220 / 100);
		TDM[playerid][Carregado] = true;
		TDM[playerid][Mercadoria] = 100;
		TDM[playerid][VehicleID] = vehicleid;
		format(TDM[vehicleid][LocalName], 15, zone);
		format(TDM[vehicleid][Dono], MAX_PLAYER_NAME, GetUserName(playerid));

		TDM[playerid][Objectid] = CreateObject(18609, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
		AttachObjectToVehicle(TDM[playerid][Objectid], vehicleid, -0.15, -4.5, 0.85, 0.0, 0.0, 0.0);
		return true;
	}
	GameTextForPlayer(playerid, "~y~Carregando...", 1000, 4);
	SetTimerEx("LoadingMadeira", 1000, false, "d", playerid);
	return true;
}

forward UnLoadingMadeiras(playerid);
public UnLoadingMadeiras(playerid)
{
	if(!IsPlayerConnected(playerid) || !call::PLAYER->IsPlayerLogged(playerid))
		return false;

	if(!IsPlayerInAnyVehicle(playerid))
		return false;

	TDM[playerid][Mercadoria] -= random(20);
	SetPlayerProgressBarValue(playerid, pBar[playerid], TDM[playerid][Mercadoria]);

	if(TDM[playerid][Mercadoria] <= 0)
	{
		TogglePlayerControllable(playerid, true);
		DestroyPlayerProgressBar(playerid, pBar[playerid]);
		new Bonus = call::PLAYER->GetPlayerVarInt(playerid, QuantMadeiras) * random(50, 30);
		
		GivePlayerMoney(playerid, TDM[playerid][Valor] + Bonus);
		SendClientMessage(playerid, GetPlayerColor(playerid), "» {"COR_BRANCO_INC"}Caminhão descarregado com {"COR_VERDE_INC"}sucesso{"COR_BRANCO_INC"}!");
		SendClientMessage(playerid, GetPlayerColor(playerid), "» {"COR_BRANCO_INC"}Você recebeu {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"} por realizar a entrega.", RealStr(TDM[playerid][Valor]));
		SendClientMessage(playerid, GetPlayerColor(playerid), "» {"COR_BRANCO_INC"}Você recebeu {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"} de Bônus.", RealStr(Bonus));
		
		call::TDM->CancelarEntrega(playerid);
		return true;
	}
	GameTextForPlayer(playerid, "~y~Descarregando...", 1000, 4);
	SetTimerEx("UnLoadingMadeiras", 1000, false, "d", playerid);
	return true;
}

CMD:carregarmadeiras(playerid, params[])
{
	//if(!call::JOB->IsPlayerInWorking(playerid))
	//	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");

	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != TRANSPORTADOR)
		return SendClientMessage(playerid, COR_ERRO, "Você não faz parte desta profissão.");

	if(IsPlayerInRangeOfPoint(playerid, 4.0, -494.9909,-67.7966,61.2460) || IsPlayerInRangeOfPoint(playerid, 4.0, -477.7238,-67.8238,60.5723)) // Transportador
	{

		new vehicleid = GetPlayerVehicleID(playerid);

		if(call::JOB->GetVehicleJob(vehicleid) != TRANSPORTADOR)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo da profissão de Transportador de Madeira.");

		new str[512], zone[MAX_ZONE_NAME], Float:x, Float:y, Float:z, valor, dist;
		str = "Entrega\tDistancia\tValor\n";
		for(new i; i < sizeof(Madeiras); i++)
		{
			GetDynamicObjectPos(Madeiras[i], x, y, z);
			GetLocalName(x, y, zone, sizeof(zone));

			dist = floatround(GetPlayerDistanceFromPoint(playerid, x, y, z));
			valor = (dist * 60 / 100);

			format(str, sizeof(str), "%s%s\t%d\t{"COR_VERDE_INC"}R$%s\n", str, zone, dist, RealStr(valor));
		}
		ShowPlayerDialog(playerid, ENTREGAS_TDM, DIALOG_STYLE_TABLIST_HEADERS, "Madeiras disponíveis para serem transportadas.", str, "Confirmar", "Cancelar");
		return true;
	}
	SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está no local para carregar o caminhão.");
	return true;
}

CMD:descarregarmadeiras(playerid)
{
	//if(!call::JOB->IsPlayerInWorking(playerid))
	//	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");
		
	if(!IsPlayerInAnyVehicle(playerid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo.");

	new vehicleid = GetPlayerVehicleID(playerid);
	
	if(call::JOB->GetVehicleJob(vehicleid) != TRANSPORTADOR)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um caminhão dos Petroleiros.");

	if(!TDM[playerid][Carregado])
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Seu Caminhão não está carregado.");

	if(TDM[playerid][VehicleID] != vehicleid)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está no caminhão que carregou as madeiras.");	

	new Float:x, Float:y, Float:z, cargaid = TDM[playerid][Carga];
	GetDynamicObjectPos(Madeiras[cargaid], x, y, z);

	if(IsPlayerInRangeOfPoint(playerid, 8.0, x, y, z))
	{
		TogglePlayerControllable(playerid, false);

		pBar[playerid] = CreatePlayerProgressBar(playerid, 1.0, 443.0, 641.5, 3.2, GetPlayerColor(playerid), 100.0000, 0);
		SetPlayerProgressBarValue(playerid, pBar[playerid], 100);
		ShowPlayerProgressBar(playerid, pBar[playerid]);

		SetTimerEx("UnLoadingMadeiras", 1000, false, "d", playerid);
		return true;
	}
	SendClientMessage(playerid, COR_ERRO, "Você não está no local do descarregamento.");
	return true;
}

Dialog:ENTREGAS_TDM(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo.");

		new vehicleid = GetPlayerVehicleID(playerid);
		
		if(call::JOB->GetVehicleJob(vehicleid) != TRANSPORTADOR)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um caminhão dos Petroleiros.");

		if(TDM[playerid][Carregado])
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já carregou seu caminhão.");

		TDM[playerid][Carga] = listitem;
		TogglePlayerControllable(playerid, false);

		pBar[playerid] = CreatePlayerProgressBar(playerid, 1.0, 443.0, 641.5, 3.2, GetPlayerColor(playerid), 100.0000, 0);
		ShowPlayerProgressBar(playerid, pBar[playerid]);

		SetTimerEx("LoadingMadeira", 1000, false, "d", playerid);
	}
	return true;
}