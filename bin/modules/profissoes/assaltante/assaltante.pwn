
static 
	SendoAssaltado[MAX_PROPERTY];

//
forward ExplosaoCofre(playerid, id, type);

#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	call::JOB->SetVehicleJob(CreateVehicle(468, -419.9060,-1750.7931,6.4963,290.7137, -1, -1, TIME_VEHICLE_SPAWN), ASSALTANTE);
	call::JOB->SetVehicleJob(CreateVehicle(468, -419.0804,-1752.0431,6.3809,285.5425, -1, -1, TIME_VEHICLE_SPAWN), ASSALTANTE);
	call::JOB->SetVehicleJob(CreateVehicle(468, -418.0897,-1753.2405,6.2682,281.4153, -1, -1, TIME_VEHICLE_SPAWN), ASSALTANTE);
	call::JOB->SetVehicleJob(CreateVehicle(468, -417.3026,-1754.4327,6.1586,284.4162, -1, -1, TIME_VEHICLE_SPAWN), ASSALTANTE);
	call::JOB->SetVehicleJob(CreateVehicle(468, -416.2046,-1755.6143,6.0306,283.0361, -1, -1, TIME_VEHICLE_SPAWN), ASSALTANTE);
	call::JOB->SetVehicleJob(CreateVehicle(468, -425.6103,-1756.0616,6.1315,160.0669, -1, -1, TIME_VEHICLE_SPAWN), ASSALTANTE);
	call::JOB->SetVehicleJob(CreateVehicle(468, -424.1806,-1756.9990,6.0129,163.2827, -1, -1, TIME_VEHICLE_SPAWN), ASSALTANTE);
	call::JOB->SetVehicleJob(CreateVehicle(468, -422.9190,-1757.9210,5.8822,166.5544, -1, -1, TIME_VEHICLE_SPAWN), ASSALTANTE);
	call::JOB->SetVehicleJob(CreateVehicle(468, -421.6958,-1759.1848,5.7120,172.4518, -1, -1, TIME_VEHICLE_SPAWN), ASSALTANTE);
	call::JOB->SetVehicleJob(CreateVehicle(468, -420.1869,-1760.8174,5.4933,220.5844, -1, -1, TIME_VEHICLE_SPAWN), ASSALTANTE);


	return Y_HOOKS_CONTINUE_RETURN_1;
}

CMD:arrombar(playerid, params[])
{
	if ( call::PLAYER->GetPlayerVarInt(playerid, Profissao) != ASSALTANTE )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é um assaltante.");

	if ( !IsPlayerInRangeOfPoint(playerid, 2.2, 1413.4065, -308.3211, 4576.0054) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo ao cofre.");
	
	new id = GetPlayerVirtualWorld(playerid);
	
	if ( SendoAssaltado[id] > gettime())
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse banco já foi assaltado recentemente, aguarde {"COR_BRANCO_INC"}%d{"COR_ERRO_INC"} segundos", SendoAssaltado[id] - gettime() );


	SendoAssaltado[id] = gettime() + (30 * 60);

	SetTimerEx("ExplosaoCofre", 60000, false, "ddd", playerid, id, 0);
	ApplyAnimation(playerid, "BOMBER", "BOM_PLANT_LOOP", 4.1, 1, 0, 0, 0, 0, 0);
	SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid) + 1);

	//SendClientMessageToAll(COR_BRANCO, "O Assaltante {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"} está arrombando o cofre do {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"}", GetUserName(playerid), Propriedade[id][Nome]);
	SendClientMessageToAll(COR_AMARELO, "| BANCO | O(A) Assaltante {ffffff}%s {"COR_AMARELO_INC"}está arrombando o cofre do {ffffff}%s{"COR_AMARELO_INC"}!", GetUserName(playerid), Propriedade[id][Nome]);
	return true;
}

public ExplosaoCofre(playerid, id, type)
{
	if ( type == 0) // Plantando
	{
		ClearAnimations(playerid);
		SendClientMessage(playerid, GetPlayerColor(playerid), "| ASSALTO | Você ativou a bomba para explodir o cofre, saia de perto para não se ferir.");
		SetTimerEx("ExplosaoCofre", 7000, false, "ddd", playerid, id, 1);
		return true;
	}
	else
	{
		new money = random(8000, 2000);

		CreateExplosion(1413.4065, -308.3211, 4576.0054, 0, 5.0);
		SendClientMessageToAll(COR_AMARELO, "| BANCO | O(A) Assaltante {ffffff}%s{"COR_AMARELO_INC"} conseguiu roubar o cofre do {ffffff}%s{"COR_AMARELO_INC"} no valor de {"COR_VERDE_INC"}R$%s{"COR_AMARELO_INC"}.", GetUserName(playerid), Propriedade[id][Nome], RealStr(money));

		
		GivePlayerMoney(playerid, money);
		SendClientMessage(playerid, COR_BRANCO, "Você roubou o banco com {"COR_VERDE_INC"}sucesso{"COR_BRANCO_INC"}, você pegou {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"} nesse assalto.", RealStr(money));
		SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid) + 5);
	}
	return true;
}