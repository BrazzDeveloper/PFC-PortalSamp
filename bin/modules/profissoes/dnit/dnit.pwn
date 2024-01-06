

/*
*
*			file: dnit.pwn
* 			date: 07/12/2017
*
*/
#include <YSI_Coding\y_hooks>

new VehicleProf[MAX_PLAYERS];


static 
	RepairRadar[MAX_PLAYERS] = -1, bool:ReparandoRadar[MAX_PLAYERS], ValorServico[MAX_PLAYERS];
// ============================== [ HOOKs ] ============================== //
hook OnGameModeInit()
{
	call::JOB->SetVehicleJob(CreateVehicle(552, 293.5323, -155.3700, 1.1871, 88.8000, -1, -1, TIME_VEHICLE_SPAWN), DNIT);
	call::JOB->SetVehicleJob(CreateVehicle(552, 293.4630, -159.4820, 1.1871, 88.8000, -1, -1, TIME_VEHICLE_SPAWN), DNIT);
	call::JOB->SetVehicleJob(CreateVehicle(552, 293.5635, -163.6553, 1.1871, 88.8000, -1, -1, TIME_VEHICLE_SPAWN), DNIT);
	call::JOB->SetVehicleJob(CreateVehicle(552, 293.3917, -173.2824, 1.1871, 86.2800, -1, -1, TIME_VEHICLE_SPAWN), DNIT);
	call::JOB->SetVehicleJob(CreateVehicle(552, 293.4544, -177.4621, 1.1871, 85.2000, -1, -1, TIME_VEHICLE_SPAWN), DNIT);
	call::JOB->SetVehicleJob(CreateVehicle(552, 293.4776, -181.7421, 1.1871, 85.2000, -1, -1, TIME_VEHICLE_SPAWN), DNIT);
	call::JOB->SetVehicleJob(CreateVehicle(552, 293.6039, -167.8035, 1.1871, 88.8000, -1, -1, TIME_VEHICLE_SPAWN), DNIT);
	
	return true;
}

hook OnPlayerConnect(playerid)
{
	call::DNIT->CancelarServico(playerid);
}

forward OnPlayerRepairRadar(playerid, radarid);
public OnPlayerRepairRadar(playerid, radarid)
{
	if(!IsPlayerConnected(playerid) || RepairRadar[playerid] == -1)
		return false;

	ClearAnimations(playerid);
	TogglePlayerControllable(playerid, true);

	new repairvalue = random(90, 40), Float:value = ( (call::RADAR->GetRadarVarFloat(radarid, Vida) + repairvalue) > 1000.0 ? 1000.0 : (call::RADAR->GetRadarVarFloat(radarid, Vida) + repairvalue));
		
	GivePlayerMoney(playerid, ValorServico[playerid]);
	call::RADAR->SetRadarVarFloat(radarid, Vida, value);
	SendClientMessage(playerid, GetPlayerColor(playerid), "» {"COR_BRANCO_INC"}Você reparou o radar com êxito, você recebeu {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"} pelo serviço.", RealStr(ValorServico[playerid]));
	call::PLAYER->DisablePlayerGPS(playerid);

	call::DNIT->CancelarServico(playerid);
	return true;
}

function DNIT::CancelarServico(playerid)
{
	RepairRadar[playerid] = -1;
	ReparandoRadar[playerid] = false;
	ValorServico[playerid]=0;
	VehicleProf[playerid] = INVALID_VEHICLE_ID;
	return true;
}

hook OnVehicleSpawn(vehicleid)
{
	foreach(new i: Player)
	{
		if(Jogador[i][Profissao] == DNIT)
		{
			if(vehicleid == VehicleProf[i])
			{
				SendClientMessage(i, COR_ERRO, "| ERRO | Seus serviços foram cancelados por seu veículo explodir / respawnar.");
				call::DNIT->CancelarServico(i);
			}
		}
	}
	return 1;
}


// ============================== [ HOOKs ] ============================== //
CMD:repararradar(playerid)
{
	if ( IsPlayerInAnyVehicle(playerid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode reparar um radar dentro do veiculo.");

	//if(!call::JOB->IsPlayerInWorking(playerid))
	//	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando para usar este comando.");

	if ( ReparandoRadar[playerid] )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já esta em um reparo.");

	new Float:x, Float:y, Float:z;
	foreach(new i: Radar)
	{
		call::RADAR->GetRadarPos(i, x, y, z);
		if(IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z))
		{
			if ( call::RADAR->GetRadarVarFloat(i, Vida) >= 1000)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Parece que você chegou tarde de mais, esse radar está em perfeito estado.");

			if(RepairRadar[playerid] != i)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não foi chamado para reparar esse radar.");

			ReparandoRadar[playerid] = true;
			// code repair radar
			ClearAnimations(playerid);
			
			TogglePlayerControllable(playerid, false);
			ApplyAnimation(playerid, "BOMBER", "BOM_PLANT_LOOP", 4.1, 1, 0, 0, 0, 0, 0);

			SetTimerEx("OnPlayerRepairRadar", random(60000, 20000), false, "dd", playerid, i);
			SendClientMessage(playerid, GetPlayerColor(playerid), "» {"COR_BRANCO_INC"}Reparando radar...");
			GameTextForPlayer(playerid, "~h~~h~~h~~y~Reparando radar...", 23000, 4);
			return true;
		}
	}
	return true;
}

CMD:pegarservico(playerid)
{
	if ( call::PLAYER->GetPlayerVarInt(playerid, Profissao) != DNIT )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte da profissão de DNIT");

	//if( !call::JOB->IsPlayerInWorking(playerid) )
	//	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando para usar este comando.");

	if ( !IsPlayerInAnyVehicle(playerid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você só pode pegar um serviço dentro do veiculo.");

	if ( call::JOB->GetVehicleJob(GetPlayerVehicleID(playerid)) != DNIT)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo do DNIT.");

	if ( RepairRadar[playerid] != -1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Já lhe foi dado um serviço, vá e o termine-o");

	new i = random(Iter_Count(Radar)), zone[MAX_ZONE_NAME];
	RepairRadar[playerid] = i;
	new Float:x, Float:y, Float:z;

	call::RADAR->GetRadarPos(i, x, y, z);
	call::PLAYER->SetPlayerMarkGPS(playerid, x, y, z);
	GetLocalName(x, y, zone, sizeof(zone));
	ValorServico[playerid] = floatround(GetPlayerDistanceFromPoint(playerid, x, y, z) * 80 / 100);

	VehicleProf[playerid] = GetPlayerVehicleID(playerid);

	SendClientMessage(playerid, GetPlayerColor(playerid), "» {"COR_BRANCO_INC"}Encontramos um radar em {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"}, vá até lá e use {"COR_AMARELO_INC"}/repararradar{"COR_BRANCO_INC"}.", zone);
	return true;
}