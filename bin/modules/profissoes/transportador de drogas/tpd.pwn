enum _EntregaInfoDrogas
{ 
	Mercadoria[10],
	Valor,
	VehicleID,
	bool:Carregado
}
static 
	TPD[MAX_PLAYERS][_EntregaInfoDrogas], Entregas[3];

new CPEntrega[MAX_PLAYERS];

// =====================================[ FUNCTIONS ] =====================================================//
function TPD::CancelarEntrega(playerid, msg[]="")
{
	new r[_EntregaInfoDrogas];
	TPD[playerid] = r;
	call::PLAYER->SetPlayerVarInt(playerid, QuantDrogas, 0);

	TPD[playerid][VehicleID] = INVALID_PLAYER_ID;
	CPEntrega[playerid] = 0;
	DisablePlayerRaceCheckpoint(playerid);

	if(!isnull(msg))
		SendClientMessage(playerid, COR_AVISO, msg);

	return true;
}
// ========================================= [ CallBacks ] =============================================== //
#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	call::JOB->SetVehicleJob(CreateVehicle(482, -2101.5127, -224.9362, 35.4389, 89.4265, -1, -1, TIME_VEHICLE_SPAWN), TRANSP_DROGAS);
	call::JOB->SetVehicleJob(CreateVehicle(482, -2101.3123, -228.8041, 35.4470, 89.4265, -1, -1, TIME_VEHICLE_SPAWN), TRANSP_DROGAS);
	call::JOB->SetVehicleJob(CreateVehicle(482, -2101.4724, -233.9297, 35.4471, 89.4265, -1, -1, TIME_VEHICLE_SPAWN), TRANSP_DROGAS);
	call::JOB->SetVehicleJob(CreateVehicle(482, -2101.4407, -238.3336, 35.4571, 89.4265, -1, -1, TIME_VEHICLE_SPAWN), TRANSP_DROGAS);
	call::JOB->SetVehicleJob(CreateVehicle(482, -2101.2788, -243.5284, 35.4490, 89.4265, -1, -1, TIME_VEHICLE_SPAWN), TRANSP_DROGAS);
	call::JOB->SetVehicleJob(CreateVehicle(482, -2101.3794, -248.2311, 35.4499, 89.4265, -1, -1, TIME_VEHICLE_SPAWN), TRANSP_DROGAS);
	call::JOB->SetVehicleJob(CreateVehicle(482, -2101.6848, -253.5170, 35.4525, 89.4265, -1, -1, TIME_VEHICLE_SPAWN), TRANSP_DROGAS);
	call::JOB->SetVehicleJob(CreateVehicle(482, -2101.7979, -258.0337, 35.4536, 89.4265, -1, -1, TIME_VEHICLE_SPAWN), TRANSP_DROGAS);

	Entregas[0] = CreateDynamicObject(1463, 2416.2317, -1704.1948, 29.4000000, 0.0000000, 0.0000000, 0.0000000);//grove
	Entregas[1] = CreateDynamicObject(1463, 2332.6348, -1948.1844, 128.0000000, 0.0000000, 0.0000000, 0.0000000);//ballas
	Entregas[2] = CreateDynamicObject(1463, 1978.9236, -1234.1865, 13.9000000, 0.0000000, 0.0000000, 0.0000000);//park glen

	CreateDynamicCP(-2115.6042, -270.3838, 35.3203, 2.5, .interiorid = 0, .streamdistance = 40.0);
	CreateDynamic3DTextLabel("Use {"COR_AMARELO_INC"}/carregardrogas{"COR_BRANCO_INC"} para carregar seu veiculo", COR_BRANCO, -2115.6042, -270.3838, 35.3203, 50.0, .streamdistance=40.0, .interiorid=0, .worldid=0, .testlos=1);
	return true;
}

hook OnPlayerDisconnect(playerid, reason)
{
	call::TPD->CancelarEntrega(playerid);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid)
{
	call::TPD->CancelarEntrega(playerid);
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	if(TPD[playerid][Carregado])
	{
		call::TPD->CancelarEntrega(playerid, "| ERRO | Sua entrega de DROGAS foi cancelada.");
	}
}

hook OnPlayerEnterRaceCP(playerid)
{
	if(CPEntrega[playerid] == 1)
	{
		new vehicleid = GetPlayerVehicleID(playerid);

		if(call::JOB->GetVehicleJob(vehicleid) != TRANSP_DROGAS)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo da profissão de Transportador de Drogas.");

		TogglePlayerControllable(playerid, false);

		SetTimerEx("UnLoadingDrogas", 5000, false, "i", playerid);
    	GameTextForPlayer(playerid, "~r~Descarregando...", 5000, 3);
	}
	else if(CPEntrega[playerid] == 2)
	{
		new vehicleid = GetPlayerVehicleID(playerid);

		if(call::JOB->GetVehicleJob(vehicleid) != TRANSP_DROGAS)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo da profissão de Transportador de Drogas.");

		TogglePlayerControllable(playerid, false);

		SetTimerEx("UnLoadingDrogas", 5000, false, "i", playerid);
    	GameTextForPlayer(playerid, "~r~Descarregando...", 5000, 3);
	}
	else if(CPEntrega[playerid] == 3)
	{
		new vehicleid = GetPlayerVehicleID(playerid);

		if(call::JOB->GetVehicleJob(vehicleid) != TRANSP_DROGAS)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo da profissão de Transportador de Drogas.");
		
		TogglePlayerControllable(playerid, false);

		SetTimerEx("UnLoadingDrogas", 5000, false, "i", playerid);
    	GameTextForPlayer(playerid, "~r~Descarregando...", 5000, 3);
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

forward UnLoadingDrogas(playerid);
public UnLoadingDrogas(playerid)
{
	TogglePlayerControllable(playerid, true);
	new Bonus = call::PLAYER->GetPlayerVarInt(playerid, QuantDrogas) * 185;

	SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid) + 3);
		
	GivePlayerMoney(playerid, TPD[playerid][Valor] + Bonus);
	SendClientMessage(playerid, GetPlayerColor(playerid), "» {"COR_BRANCO_INC"}Veiculo descarregado com {"COR_VERDE_INC"}sucesso{"COR_BRANCO_INC"}!");
	SendClientMessage(playerid, GetPlayerColor(playerid), "» {"COR_BRANCO_INC"}Você recebeu {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"} por realizar a entrega.", RealStr(TPD[playerid][Valor]));
	SendClientMessage(playerid, GetPlayerColor(playerid), "» {"COR_BRANCO_INC"}Você recebeu {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"} de Bônus.", RealStr(Bonus));
		
	call::TPD->CancelarEntrega(playerid);
	return true;
}

forward LoadingDrogas(playerid);
public LoadingDrogas(playerid)
{
	TogglePlayerControllable(playerid, true);

	SendClientMessage(playerid, COR_BRANCO, "» Motorista: {"COR_VERMELHO_INC"}%s", GetUserName(playerid));

	if( strcmp(TPD[playerid][Mercadoria], "Cocaina", true) == 0)
		SendClientMessage(playerid, COR_BRANCO, "» Você está transportando {"COR_AMARELO_INC"}%d{"COR_BRANCO_INC"} kg de {"COR_VERMELHO_INC"}%s{"COR_BRANCO_INC"}, siga o checkpoint.", call::PLAYER->GetPlayerVarInt(playerid, QuantDrogas), TPD[playerid][Mercadoria]);

	else if( strcmp(TPD[playerid][Mercadoria], "Crack", true) == 0)
		SendClientMessage(playerid, COR_BRANCO, "» Você está transportando {"COR_AMARELO_INC"}%d{"COR_BRANCO_INC"} pedras de {"COR_VERMELHO_INC"}%s{"COR_BRANCO_INC"}, siga o checkpoint.", call::PLAYER->GetPlayerVarInt(playerid, QuantDrogas), TPD[playerid][Mercadoria]);

	else if( strcmp(TPD[playerid][Mercadoria], "Maconha", true) == 0)
		SendClientMessage(playerid, COR_BRANCO, "» Você está transportando {"COR_AMARELO_INC"}%d{"COR_BRANCO_INC"} kg de {"COR_VERMELHO_INC"}%s{"COR_BRANCO_INC"}, siga o checkpoint.", call::PLAYER->GetPlayerVarInt(playerid, QuantDrogas), TPD[playerid][Mercadoria]);
	return true;
}

// ============================================[ CMDS ] =================================================== //

CMD:carregardrogas(playerid, params[])
{
	//if(!call::JOB->IsPlayerInWorking(playerid))
	//	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");

	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != TRANSP_DROGAS)
		return SendClientMessage(playerid, COR_ERRO, "Você não faz parte desta profissão.");

	if(!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo.");

	if(TPD[playerid][Carregado])
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já carregou seu veiculo.");

	if(IsPlayerInRangeOfPoint(playerid, 4.0, -2115.6042, -270.3838, 35.3203)) // Transportador
	{

		new vehicleid = GetPlayerVehicleID(playerid);

		if(call::JOB->GetVehicleJob(vehicleid) != TRANSP_DROGAS)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo da profissão de Transportador de Drogas.");

		new str[512];
		str = "Entrega\tValor\n";

		format(str, sizeof(str), "%sGrove Street\t{"COR_VERDE_INC"}R$2.100\n{"COR_BRANCO_INC"}Ballas\t{"COR_VERDE_INC"}R$2.200\n{"COR_BRANCO_INC"}Park Glen\t{"COR_VERDE_INC"}R$2.000\n", str);

		ShowPlayerDialog(playerid, CARGAS_TPD, DIALOG_STYLE_TABLIST_HEADERS, "CARREGAMENTO", str, "Confirmar", "Cancelar");
		return true;
	}
	SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está no local para carregar o caminhão.");
	return true;
}

// ============================================== [ DIALOGS ] =============================================== // 

Dialog:CARGAS_TPD(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(listitem == 0)
		{
			new producao = random(10, 1);
			TogglePlayerControllable(playerid, false);
			call::PLAYER->SetPlayerVarInt(playerid, QuantDrogas, producao);
			SetPlayerRaceCheckpoint(playerid, 0, 2416.7466, -1705.5643, 13.7775, 0.0, 0.0, 0.0, 4.0);

			CPEntrega[playerid] = 1;
			TPD[playerid][VehicleID] = GetPlayerVehicleID(playerid),TPD[playerid][Carregado] = true;
			TPD[playerid][Mercadoria] = RandomDrogaName[random(sizeof(RandomDrogaName))],TPD[playerid][Valor] = 2100;

			SetTimerEx("LoadingDrogas", 5000, false, "i", playerid);
    		GameTextForPlayer(playerid, "~r~Carregando...", 5000, 3);
		}
		if(listitem == 1)
		{
			new producao = random(10, 1);
			TogglePlayerControllable(playerid, false);
			call::PLAYER->SetPlayerVarInt(playerid, QuantDrogas, producao);
			SetPlayerRaceCheckpoint(playerid, 0, 2332.6348, -1948.1844, 13.5790, 0.0, 0.0, 0.0, 4.0);

			CPEntrega[playerid] = 2;
			TPD[playerid][VehicleID] = GetPlayerVehicleID(playerid),TPD[playerid][Carregado] = true;
			TPD[playerid][Mercadoria] = RandomDrogaName[random(sizeof(RandomDrogaName))],TPD[playerid][Valor] = 2200;

			SetTimerEx("LoadingDrogas", 5000, false, "i", playerid);
    		GameTextForPlayer(playerid, "~r~Carregando...", 5000, 3);
		}
		if(listitem == 2)
		{
			new producao = random(10, 1);
			TogglePlayerControllable(playerid, false);
			call::PLAYER->SetPlayerVarInt(playerid, QuantDrogas, producao);
			SetPlayerRaceCheckpoint(playerid, 0, 1978.9236, -1234.1865, 20.0469, 0.0, 0.0, 0.0, 4.0);

			CPEntrega[playerid] = 3;
			TPD[playerid][VehicleID] = GetPlayerVehicleID(playerid),TPD[playerid][Carregado] = true;
			TPD[playerid][Mercadoria] = RandomDrogaName[random(sizeof(RandomDrogaName))],TPD[playerid][Valor] = 2000;

			SetTimerEx("LoadingDrogas", 5000, false, "i", playerid);
    		GameTextForPlayer(playerid, "~r~Carregando...", 5000, 3);
		}
	}
	return true;
}