
#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	SetTimer("UpdateVehicleStatus", 1000, true);
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if (newstate == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerid), model = GetVehicleModel(vehicleid);

		if ( !call::PLAYER->GetPlayerVarBool(playerid, TesteDirecao))
		{
			if ( IsMoto(model) && !BitFlag_Get(Jogador[playerid][Habilitacao], HAB_MOTO) )
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui habilitação da categoria A.");

			else if ( IsCar(model) && !BitFlag_Get(Jogador[playerid][Habilitacao], HAB_CARRO) )
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui habilitação da categoria B");

			else if ( IsTruck(model) && !BitFlag_Get(Jogador[playerid][Habilitacao], HAB_CAMINHAO) )
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui habilitação da categoria C");
		}

		if ( !IsBike(model) )
		{
			SendClientMessage(playerid, COR_BRANCO, "| INFO | Para ligar ou desligar seu veículo use a tecla '{"COR_SISTEMA_INC"}Y{ffffff}'");
			SendClientMessage(playerid, COR_BRANCO, "| INFO | Para ligar ou desligar os faróis use a tecla '{"COR_SISTEMA_INC"}N{ffffff}'");
			//SendClientMessage(playerid, COR_AZUL, "» {"COR_BRANCO_INC"}Use a tecla '{"COR_AMARELO_INC"}Y{"COR_BRANCO_INC"}' ou {"COR_AMARELO_INC"}/ligar{"COR_BRANCO_INC"} - {"COR_AMARELO_INC"}/desligar{"COR_BRANCO_INC"} para ligar/desligar o veiculo.");
			//SendClientMessage(playerid, COR_AZUL, "» {"COR_BRANCO_INC"}Use a tecla '{"COR_AMARELO_INC"}N{"COR_BRANCO_INC"}' ou {"COR_AMARELO_INC"}/ligarfarois{"COR_BRANCO_INC"} - {"COR_AMARELO_INC"}/desligarfarois{"COR_BRANCO_INC"} para ligar/desligar os faróis.");
		}
		return Y_HOOKS_CONTINUE_RETURN_1;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(!IsPlayerInAnyVehicle(playerid) || call::CONCE->IsValidVehicleConce(GetPlayerVehicleID(playerid)))
		return Y_HOOKS_CONTINUE_RETURN_1;

	if(PRESSED(KEY_YES))
	{
		if(GetVehicleParams(GetPlayerVehicleID(playerid), VEHICLE_TYPE_ENGINE) != VEHICLE_PARAMS_ON)
			callcmd::ligar(playerid);
		else
			callcmd::desligar(playerid);

		return Y_HOOKS_BREAK_RETURN_1;
	}
	else if( PRESSED(KEY_NO))
	{
		if ( GetVehicleParams(GetPlayerVehicleID(playerid), VEHICLE_TYPE_LIGHTS) != VEHICLE_PARAMS_ON)
			callcmd::ligarfarois(playerid);
		else
			callcmd::desligarfarois(playerid);

		return Y_HOOKS_BREAK_RETURN_1;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerExitVehicle(playerid, vehicleid) {
	call::TD->ShowPlayerVelocimetro(playerid, 0, "carinfo");
	return 1;
}

public OnVehicleCreated(vehicleid)
{
	if(IsValidVehicle(vehicleid))
	{
		new model = GetVehicleModel(vehicleid);
		call::VH->SetVehicleFuel(vehicleid, GetVehicleMaxFuel(model));
		
		if(!Iter_Contains(Vehicles, vehicleid))
		{
			Iter_Add(Vehicles, vehicleid);
		}
		return true;
	}
	return false;
}

public OnVehicleDestroyed(vehicleid)
{
	if(IsValidVehicle(vehicleid))
	{
		if(Iter_Contains(Vehicles, vehicleid)){
			Iter_Remove(Vehicles, vehicleid);
		}

		if(Iter_Contains(VehiclePlayers, vehicleid)){
			Iter_Remove(VehiclePlayers, vehicleid);
		}
		
		new r[e_VEHICLE_INFO];
		Vehicle[vehicleid] = r;
		return true;
	}
	return false;
}

public OnVehicleSpawn(vehicleid)
{
	if ( Iter_Contains(Vehicles, vehicleid) )
		call::VH->SetVehicleFuel(vehicleid, GetVehicleMaxFuel(GetVehicleModel(vehicleid)));

	if ( Iter_Contains(VehiclePlayers, vehicleid) )
	{
		if ( Vehicle[vehicleid][PaintJob] >= 0)
			ChangeVehiclePaintjob(vehicleid, Vehicle[vehicleid][PaintJob]);
	}
	return false;
}


public UpdateVehicleStatus()
{
	foreach(new vehicleid: Vehicles)
	{
		if( IsValidVehicle(vehicleid) )
		{
			if(GetVehicleParams(vehicleid, VEHICLE_TYPE_ENGINE) == VEHICLE_PARAMS_ON)
			{
				call::VH->UpdateVehicleFuel(vehicleid);
			}
		}
	}
	return false;
}

hook OnVehicleHealthChange(vehicleid, Float:newhealth, Float:oldhealth)
{
	if ( IsValidVehicle(vehicleid) )
	{
		if ( newhealth < 299)
		{
			new pid = GetVehicleDriverID(vehicleid), Float:vPos[4];

			if (  pid != INVALID_PLAYER_ID )
				SendClientMessage(pid, COR_AMARELO, "| INFO | Seu veículo está quebrado, chame um(a) Mecânico(a)!"), SetCameraBehindPlayer(pid);

			
			GetVehiclePos(vehicleid, vPos[0], vPos[1], vPos[2]);
			SetVehiclePos(vehicleid, vPos[0], vPos[1], vPos[2]);
			
			GetVehicleZAngle(vehicleid, vPos[3]);
			SetVehicleZAngle(vehicleid, vPos[3]);

			SetVehicleHealth(vehicleid, 300);
			SetVehicleParams(vehicleid, VEHICLE_TYPE_ENGINE, VEHICLE_PARAMS_OFF);
			return true;
		}
	}
	return true;
}


public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	if(Iter_Contains(VehiclePlayers, vehicleid))
	{
		static query[128];
		query[0] = EOS;

		Vehicle[vehicleid][PaintJob] = paintjobid;
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_VEHICLES_PLAYER" SET `paintjob`='%d' WHERE `id`='%d' LIMIT 1;", Vehicle[vehicleid][PaintJob], Vehicle[vehicleid][Id]);
		mysql_tquery(getConexao(), query);
		return true;
	}
	return false;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	if( Iter_Contains(VehiclePlayers, vehicleid) )
	{
		new query[128];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_VEHICLES_PLAYER" SET `cor1`='%d',`cor2`='%d' WHERE `id`='%d' LIMIT 1;", color1, color2, Vehicle[vehicleid][Id]);
		mysql_tquery(getConexao(), query);

		return true;
	}
	return false;
}

public OnVehicleModEx(playerid, vehicleid, componentid, price, illegal)
{
	if( Iter_Contains(VehiclePlayers, vehicleid) )
	{
		if ( !illegal )
		{
			new query[128];

			GameTextForPlayer(playerid, "~y~Componente Instalado.", 3000, 5);
			if(IsWheels(componentid) )
			{
				Vehicle[vehicleid][Rodas] = componentid;
				mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_VEHICLES_PLAYER" SET `roda`='%d' WHERE `id`='%d' LIMIT 1;", Vehicle[vehicleid][Rodas], Vehicle[vehicleid][Id]);
				mysql_tquery(getConexao(), query);

				GivePlayerMoney(playerid, -price, true);
				return true;
			}
			else if(IsNitro(componentid))
			{	
				/**
				*
				*	remove component old.
				*
				**/
				RemoveVehicleComponent(vehicleid, Vehicle[vehicleid][Nitro]);

				Vehicle[vehicleid][Nitro] = componentid;
				AddVehicleComponent(vehicleid, Vehicle[vehicleid][Nitro]);

				mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_VEHICLES_PLAYER" SET `nitro`='%d' WHERE `id`='%d' LIMIT 1;", Vehicle[vehicleid][Nitro], Vehicle[vehicleid][Id]);
				mysql_tquery(getConexao(), query);

				GivePlayerMoney(playerid, -price, true);
				return true;
			}
			else if( IsHydraulic(componentid) )
			{
				Vehicle[vehicleid][Hidraulica] = componentid;
				mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_VEHICLES_PLAYER" SET `hidraulica`='%d' WHERE `id`='%d' LIMIT 1;", Vehicle[vehicleid][Hidraulica], Vehicle[vehicleid][Id]);
				mysql_tquery(getConexao(), query);

				GivePlayerMoney(playerid, -price, true);
				return true;
			}
			return true;
		}
		return false;
	}
	return false;
}

