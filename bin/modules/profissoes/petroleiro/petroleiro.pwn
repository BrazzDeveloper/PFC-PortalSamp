
/*
	AddPlayerClass(21,256.8712,1366.7665,10.7075,106.4098,0,0,0,0,0,0); // carregar petroleiro
	AddPlayerClass(21,240.0140,1375.8624,10.5859,103.9031,0,0,0,0,0,0); // carregar petroleiro2

	AddPlayerClass(21,240.0272,1400.7694,10.7075,254.2811,0,0,0,0,0,0); // carregar petroleiro
	AddPlayerClass(21,256.7518,1391.5623,10.7075,235.1676,0,0,0,0,0,0); // carregar petroleiro2
*/

// ============================== [ VARIAVEIS ] ============================== //
static const 
	ENTER = 0,
	EXIT = 1
;
enum e_PETROLEIRO_INFO
{
	bool:Carregado,
	Carga,
	Valor,
	Quantidade,
	VehicleID,
	TrailerID,
}
static 
	Petroleiro[MAX_PLAYERS][e_PETROLEIRO_INFO], Tanques[7], PlayerBar:pBar[MAX_PLAYERS], Cancela[2], bool:Opened[2];


// ============================== [ CALLBACKS ] ============================== //
static function PETROLEIRO::AbrirCancela(obj_idx)
{
	if(Opened[obj_idx])
		return false;

	static Float:x, Float:y, Float:z;
	GetDynamicObjectPos(Cancela[obj_idx], x, y, z);
	MoveDynamicObject(Cancela[obj_idx], x, y, z+0.0001, 0.0001, 0.000000, 0.000000, (obj_idx == EXIT ? -90.00000 : 90.00000));
	SetTimerEx("PETROLEIRO_FecharCancela", 8000, false, "d", obj_idx);
	Opened[obj_idx] = true;
	return true;
}

function PETROLEIRO::CancelarEntrega(playerid, msg[]="")
{
	new r[e_PETROLEIRO_INFO];
	Petroleiro[playerid] = r;

	Petroleiro[playerid][Carga] = -1;
	DisablePlayerRaceCheckpoint(playerid);
	
	if(!isnull(msg))
		SendClientMessage(playerid, COR_AVISO, msg);

	return true;
}

// ============================== [ CALLBACKS ] ============================== //

#include <YSI_Coding\y_hooks>
hook OnGameModeInit()
{
	// ============================== [ OBJETOS DE POSTOS ] ============================== //
	CreateDynamicObject(1686, 1941.66492, -1778.56824, 12.67719,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1686, 1941.64673, -1774.12073, 12.67719,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1686, 1941.68811, -1771.82080, 12.67719,   0.00000, 0.00000, 0.10000);
	CreateDynamicObject(1686, 1941.63733, -1767.05579, 12.67719,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1686, 998.15167, -937.75372, 41.38248,   0.00000, 0.00000, 97.91725);
	CreateDynamicObject(1686, 1002.72144, -937.08386, 41.38248,   0.00000, 0.00000, 97.91725);
	CreateDynamicObject(1686, 1005.23413, -936.67865, 41.38248,   0.00000, 0.00000, 95.81725);
	CreateDynamicObject(1686, 1009.71478, -936.01379, 41.38248,   0.00000, 0.00000, 97.91725);
	CreateDynamicObject(3633, 1007.85199, -929.89105, 41.83505,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1686, -92.02525, -1161.76392, 1.43975,   0.00000, 0.00000, 337.08514);
	CreateDynamicObject(1686, -85.10934, -1165.03479, 1.43975,   0.00000, 0.00000, 334.86520);
	CreateDynamicObject(1686, -89.89443, -1176.56738, 1.43975,   0.00000, 0.00000, 337.08514);
	CreateDynamicObject(1686, -97.16402, -1173.99231, 1.43975,   0.00000, 0.00000, 337.08514);
	CreateDynamicObject(3643, -77.45654, -1151.18066, 6.27639,   0.00000, 0.00000, -297.95969);
	CreateDynamicObject(3633, 662.29388, -578.48163, 15.71673,   0.00000, 0.00000, 0.80619);
	
	Tanques[0] = CreateDynamicObject(3287, -84.30626, -1147.50903, 3.12364,   0.00000, 0.00000, -116.45998);
	Tanques[1] = CreateDynamicObject(3287, 667.98462, -580.41284, 17.78752,   0.00000, 0.00000, 0.24000);
	Tanques[2] = CreateDynamicObject(3287, 1367.42627, 481.08258, 21.72389,   0.00000, 0.00000, -27.18000);
	Tanques[3] = CreateDynamicObject(3287, 2102.96777, 943.24902, 12.29225,   0.00000, 0.00000, 89.39998);
	Tanques[4] = CreateDynamicObject(3287, 2172.68579, 2480.43774, 12.26996,   0.00000, 0.00000, 0.00000);
	Tanques[5] = CreateDynamicObject(3287, 1940.90051, -1794.92126, 14.99220,   0.00000, 0.00000, 89.96464);
	Tanques[6] = CreateDynamicObject(3287, 984.24634, -895.43915, 44.00448,   0.00000, 0.00000, 0.00000);

	// ============================== [ OBJETOS DE POSTOS ] ============================== //
	CreateDynamicObject(3636, 192.38680, 1457.08679, 17.09380,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3636, 193.00670, 1396.66345, 17.43380,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(979, 260.19791, 1415.31836, 10.32950,   0.00000, 0.00000, 269.96280);
	CreateDynamicObject(979, 283.57751, 1420.74463, 10.32950,   0.00000, 0.00000, 541.88379);
	CreateDynamicObject(979, 274.26941, 1420.44507, 10.32950,   0.00000, 0.00000, 541.88379);
	CreateDynamicObject(979, 264.92371, 1420.14026, 10.32950,   0.00000, 0.00000, 541.88379);
	CreateDynamicObject(979, 260.18549, 1406.04065, 10.32950,   0.00000, 0.00000, 269.93661);
	CreateDynamicObject(1237, 288.19623, 1410.73425, 9.42960,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1237, 280.29675, 1410.82275, 9.42960,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1237, 277.38586, 1410.86487, 9.42960,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1237, 271.35068, 1399.46765, 9.42960,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1237, 283.29501, 1410.84900, 9.42960,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1237, 271.45200, 1406.82544, 9.42960,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(966, 288.33029, 1418.89221, 9.35210,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(967, 289.86450, 1419.32092, 9.52460,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(966, 288.37869, 1402.35828, 9.35210,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(967, 286.05865, 1399.52930, 9.52460,   0.00000, 0.00000, 272.57974);
	CreateDynamicObject(1237, 288.49930, 1401.07166, 9.42960,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1237, 271.30087, 1403.25549, 9.42960,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1237, 274.59271, 1410.85437, 9.42960,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1237, 271.50015, 1410.85571, 9.42960,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1237, 285.96475, 1410.82458, 9.42960,   0.00000, 0.00000, 0.00000);

	Cancela[ENTER] = CreateDynamicObject(968, 288.31631, 1418.94263, 10.08100,   0.00000, -90.00000, 90.00000);
	Cancela[EXIT] = CreateDynamicObject(968, 288.38190, 1402.38379, 10.08100,   0.00000, -90.00000, -90.00000);

	// ============================== [ CARROS ] ============================== //
	call::JOB->SetVehicleJob(CreateVehicle(514, 187.3780, 1341.1639, 11.1184, 1.3600, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(514, 181.6608, 1341.1958, 11.1184, 1.3600, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(514, 193.2635, 1341.3145, 11.1184, 1.3600, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(514, 199.7320, 1341.2560, 11.1184, 1.3600, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(514, 205.9066, 1341.2783, 11.1184, 1.3600, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(514, 181.2937, 1363.1971, 11.1184, 180.7601, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(514, 187.9763, 1363.5581, 11.1184, 180.7601, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(514, 195.9843, 1363.8485, 11.1184, 180.7601, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(514, 203.2249, 1363.7776, 11.1184, 180.7601, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(514, 209.7441, 1363.8795, 11.1184, 180.7601, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(514, 228.2153, 1356.6782, 11.1184, 180.7601, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(514, 238.0152, 1356.7206, 11.1184, 180.7601, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);

	// ============================== [ TRAILERs ] ============================== //
	call::JOB->SetVehicleJob(CreateVehicle(584, 283.0398, 1338.5623, 11.5454, -269.9402, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(584, 283.0307, 1342.5248, 11.5454, -270.7802, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(584, 283.0738, 1346.0884, 11.5454, -270.7802, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(584, 283.0656, 1349.4539, 11.5454, -270.7802, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(584, 282.9677, 1353.0050, 11.5454, -270.7802, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(584, 283.0199, 1356.7279, 11.5454, -270.7802, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(584, 283.0374, 1360.0614, 11.5454, -270.7802, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(584, 283.0246, 1363.5514, 11.5454, -270.7802, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(584, 283.0510, 1367.1022, 11.5454, -270.7802, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(584, 283.0266, 1370.8876, 11.5454, -270.7802, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(584, 283.0017, 1374.8177, 11.5454, -270.7802, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(584, 282.8985, 1378.5585, 11.5454, -270.7802, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(584, 282.9868, 1382.1936, 11.5454, -270.7802, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(584, 283.0612, 1386.0526, 11.5454, -270.7802, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(584, 283.1009, 1389.8312, 11.5454, -270.7802, -1, -1, TIME_VEHICLE_SPAWN), PETROLEIRO);
	// 
	CreateDynamic3DTextLabel("Digite {"COR_BRANCO_INC"}/CarregarTanque{FF0000} para carregar o tanque do caminhão.", 0xFF0000FF, 246.2657,1370.6819,10.5859, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, .worldid=0, .interiorid=0, .streamdistance=50.0);

}

hook OnPlayerConnect(playerid)
{
	RemoveBuildingForPlayer(playerid, 1676, 1941.6563, -1778.4531, 14.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 1676, 1941.6563, -1774.3125, 14.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 1676, 1941.6563, -1771.3438, 14.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 1676, 1941.6563, -1767.2891, 14.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 1370, 1373.4531, 469.9688, 19.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 1370, 1373.1719, 471.1016, 19.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 1448, 1357.7188, 481.7031, 19.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 1370, 1358.4844, 483.6563, 19.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 1450, 1355.8516, 483.3906, 19.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 1358, 1356.3750, 485.1875, 20.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 1676, -92.1016, -1161.7891, 2.9609, 0.25);
	RemoveBuildingForPlayer(playerid, 1676, -97.0703, -1173.7500, 3.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 1676, -85.2422, -1165.0313, 2.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 1676, -90.1406, -1176.6250, 2.6328, 0.25);

	call::PETROLEIRO->CancelarEntrega(playerid);
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	if(Petroleiro[playerid][Carregado])
	{
		call::PETROLEIRO->CancelarEntrega(playerid, "Sua entrega de combustível foi cancelada.");
	}
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != PETROLEIRO)
		return Y_HOOKS_CONTINUE_RETURN_1;

	if(PRESSED(KEY_CROUCH))
	{
		if(IsPlayerInPlace(playerid, 272.0977, 1399.0709, 287.4967,1410.3652)) // Abrir cancela de saida
			call::PETROLEIRO->AbrirCancela(EXIT);
		
		else if(IsPlayerInPlace(playerid, 288.9249, 1411.9735, 303.2178, 1418.2609)) // Abrir cancela de entrada
			call::PETROLEIRO->AbrirCancela(ENTER);
		
		return Y_HOOKS_BREAK_RETURN_1;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

forward PETROLEIRO_FecharCancela(obj_idx);
public PETROLEIRO_FecharCancela(obj_idx)
{
	static Float:x, Float:y, Float:z;
	GetDynamicObjectPos(Cancela[obj_idx], x, y, z);
	MoveDynamicObject(Cancela[obj_idx], x, y, z-0.0001, 0.0001, 0.00000, -90.00000, (obj_idx == EXIT ? -90.00000 : 90.00000));
	Opened[obj_idx] = false;
	return true;
}

forward LoadingTanquePetrol(playerid);
public LoadingTanquePetrol(playerid)
{
	if(!IsPlayerConnected(playerid) || !call::PLAYER->IsPlayerLogged(playerid))
		return false;

	Petroleiro[playerid][Quantidade] += random(20);
	SetPlayerProgressBarValue(playerid, pBar[playerid], Petroleiro[playerid][Quantidade]);

	if(Petroleiro[playerid][Quantidade] >= 100)
	{
		TogglePlayerControllable(playerid, true);
		DestroyPlayerProgressBar(playerid, pBar[playerid]);

		new Float:x, Float:y, Float:z, dist, cargaid = Petroleiro[playerid][Carga];

		GetDynamicObjectPos(Tanques[cargaid], x, y, z);
		SetPlayerRaceCheckpoint(playerid, 0, x, y, z, 0.0, 0.0, 0.0, 1.1);

		dist = floatround(GetPlayerDistanceFromPoint(playerid, x, y, z));
		Petroleiro[playerid][Valor] = (dist * 30 / 100);

		Petroleiro[playerid][Carregado] = true;
		Petroleiro[playerid][Quantidade] = 100;
		Petroleiro[playerid][VehicleID] = GetPlayerVehicleID(playerid);
		Petroleiro[playerid][TrailerID] = GetVehicleTrailer(Petroleiro[playerid][VehicleID]);

		SendClientMessage(playerid, GetPlayerColor(playerid), "» {"COR_BRANCO_INC"}Seu Caminhão foi carregado com {"COR_VERDE_INC"}sucesso{"COR_BRANCO_INC"}!");
		SendClientMessage(playerid, GetPlayerColor(playerid), "» {"COR_BRANCO_INC"}Você deve levar a carga até o posto marcado em seu mapa.");
		return true;
	}
	GameTextForPlayer(playerid, "~y~Carregando...", 1000, 4);
	SetTimerEx("LoadingTanquePetrol", 1000, false, "d", playerid);
	return true;
}

forward UnLoadingTanquePetrol(playerid);
public UnLoadingTanquePetrol(playerid)
{
	if(!IsPlayerConnected(playerid) || !call::PLAYER->IsPlayerLogged(playerid))
		return false;

	if(!IsPlayerInAnyVehicle(playerid))
		return false;

	Petroleiro[playerid][Quantidade] -= random(20);
	SetPlayerProgressBarValue(playerid, pBar[playerid], Petroleiro[playerid][Quantidade]);

	if(Petroleiro[playerid][Quantidade] <= 0)
	{
		TogglePlayerControllable(playerid, true);
		DestroyPlayerProgressBar(playerid, pBar[playerid]);

		SetVehicleToRespawn(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
		
		GivePlayerMoney(playerid, Petroleiro[playerid][Valor]);
		SendClientMessage(playerid, GetPlayerColor(playerid), "» {"COR_BRANCO_INC"}Caminhão descarregado com {"COR_VERDE_INC"}sucesso{"COR_BRANCO_INC"}!");
		SendClientMessage(playerid, GetPlayerColor(playerid), "» {"COR_BRANCO_INC"}Você recebeu {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"} por realizar a entrega.", RealStr(Petroleiro[playerid][Valor]));
		
		call::PETROLEIRO->CancelarEntrega(playerid);
		return true;
	}
	GameTextForPlayer(playerid, "~y~Descarregando...", 1000, 4);
	SetTimerEx("UnLoadingTanquePetrol", 1000, false, "d", playerid);
	return true;
}

// ============================== [ COMANDOS ] ============================== //

CMD:carregartanque(playerid)
{
	if(!call::JOB->IsPlayerInWorking(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");

	if(IsPlayerInPlace(playerid, 240.0140, 1366.7665, 256.8712, 1375.8624) || IsPlayerInPlace(playerid, 240.0272, 1391.5623, 256.7518, 1400.7694))
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo.");

		new vehicleid = GetPlayerVehicleID(playerid);
		
		if(call::JOB->GetVehicleJob(vehicleid) != PETROLEIRO)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um caminhão dos Petroleiros.");

		if(call::JOB->GetVehicleJob(GetVehicleTrailer(vehicleid)) != PETROLEIRO)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não engatou um trailer dos Petroleiros.");

		if(Petroleiro[playerid][Carregado])
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já carregou seu caminhão.");

		new str[512], zone[MAX_ZONE_NAME], Float:x, Float:y, Float:z, valor, dist;
		str = "Entrega\tDistancia\tValor\n";
		for(new i; i < sizeof(Tanques); i++)
		{
			GetDynamicObjectPos(Tanques[i], x, y, z);
			GetLocalName(x, y, zone, sizeof(zone));

			dist = floatround(GetPlayerDistanceFromPoint(playerid, x, y, z));
			valor = (dist * 40 / 100);

			format(str, sizeof(str), "%s%s\t%d\t{"COR_VERDE_INC"}R$%s\n", str, zone, dist, RealStr(valor));
		}
		ShowPlayerDialog(playerid, CARGAS_PETROLEIRO, DIALOG_STYLE_TABLIST_HEADERS, "CARGAS » PETROLEIRO", str, "Carregar", "Fechar");
		return true;
	}
	SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está no local de carregamento.");
	return true;
}

CMD:descarregartanque(playerid)
{
	if(!call::JOB->IsPlayerInWorking(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");
		
	if(!IsPlayerInAnyVehicle(playerid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo.");

	new vehicleid = GetPlayerVehicleID(playerid);
	
	if(call::JOB->GetVehicleJob(vehicleid) != PETROLEIRO)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um caminhão dos Petroleiros.");

	if(call::JOB->GetVehicleJob(GetVehicleTrailer(vehicleid)) != PETROLEIRO)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não engatou um trailer dos Petroleiros.");

	if(!Petroleiro[playerid][Carregado])
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Seu Caminhão não está carregado.");

	if(Petroleiro[playerid][Carga] == -1)
		return false;

	if(Petroleiro[playerid][VehicleID] != vehicleid)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está no caminhão que carregou o combustível.");
		
	if(Petroleiro[playerid][TrailerID] != GetVehicleTrailer(vehicleid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não engatou o trailer que carregou o combustível.");
		

	new Float:x, Float:y, Float:z, cargaid = Petroleiro[playerid][Carga];
	GetDynamicObjectPos(Tanques[cargaid], x, y, z);

	if( IsPlayerInRangeOfPoint(playerid, 10.0, x, y, z) )
	{
		TogglePlayerControllable(playerid, false);

		pBar[playerid] = CreatePlayerProgressBar(playerid, 1.0, 443.0, 641.5, 3.2, COR_AMARELO, 100.0000, 0);
		SetPlayerProgressBarValue(playerid, pBar[playerid], 100);
		ShowPlayerProgressBar(playerid, pBar[playerid]);

		SetTimerEx("UnLoadingTanquePetrol", 1000, false, "d", playerid);
		return true;
	}
	SendClientMessage(playerid, COR_ERRO, "Você não está no local do descarregamento.");
	return true;
}

// ============================== [ DIALOGs ] ============================== //

Dialog:CARGAS_PETROLEIRO(playerid, response, listitem, inpttext[])
{
	if(response)
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo.");

		new vehicleid = GetPlayerVehicleID(playerid);
		
		if(call::JOB->GetVehicleJob(vehicleid) != PETROLEIRO)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um caminhão dos Petroleiros.");

		if(call::JOB->GetVehicleJob(GetVehicleTrailer(vehicleid)) != PETROLEIRO)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não engatou um trailer dos Petroleiros.");

		if(Petroleiro[playerid][Carregado])
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já carregou seu caminhão.");

		if(Petroleiro[playerid][Carga] != -1)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está carregando seu caminhão, aguarde o término.");

		Petroleiro[playerid][Carga] = listitem;
		TogglePlayerControllable(playerid, false);

		pBar[playerid] = CreatePlayerProgressBar(playerid, 1.0, 443.0, 641.5, 3.2, COR_AMARELO, 100.0000, 0);
		ShowPlayerProgressBar(playerid, pBar[playerid]);

		SetTimerEx("LoadingTanquePetrol", 1000, false, "d", playerid);
		return true;
	}
	return true;
}
