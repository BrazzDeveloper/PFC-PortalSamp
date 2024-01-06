
#include <YSI_Coding\y_hooks>
forward OnLoadVehiclesPlayer(playerid);
// ============================== [ VARS ] ============================== //
static 
	BuyVehicle_pID[MAX_PLAYERS] = INVALID_PLAYER_ID, BuyVehicle_Value[MAX_PLAYERS], BuyVehicle_vID[MAX_PLAYERS] = INVALID_VEHICLE_ID;



// ============================== [ FORWARDS ] ============================== //
forward OnPlayerVendingVehiclePlayer(playerid, id, avisos);

// ============================== [ CALLBACKs ] ============================== //

hook OnPlayerDisconnect(playerid, reason)
{
	if ( BuyVehicle_pID[playerid] != INVALID_PLAYER_ID )
	{
		if ( BuyVehicle_vID[playerid] != INVALID_VEHICLE_ID )
		{
			SendClientMessage(BuyVehicle_pID[playerid], COR_AVISO, "| AVISO | O(A) Jogador(a) saiu do servidor e a venda do veiculo foi cancelada.");
			BuyVehicle_Value[playerid] = 0;
			BuyVehicle_vID[playerid] = INVALID_VEHICLE_ID;
			BuyVehicle_pID[playerid] = INVALID_PLAYER_ID;
		}
		else
		{
			new id = BuyVehicle_pID[playerid];
			if ( IsPlayerConnected(id) )
				SendClientMessage(id, COR_AVISO, "| AVISO | O(A) Jogador(a) saiu do servidor e a venda do veiculo foi cancelada.");

			BuyVehicle_Value[id] = 0;
			BuyVehicle_vID[id] = INVALID_VEHICLE_ID;
			BuyVehicle_pID[id] = INVALID_PLAYER_ID;
			BuyVehicle_pID[playerid] = INVALID_PLAYER_ID;
		}
	}
	foreach(new i: VehiclePlayers)
	{
		if ( Jogador[playerid][PlayerID] == Vehicle[i][Owner][Id] )
		{
			DestroyVehicle(Vehicle[i][Id]);
			new r[e_VEHICLE_INFO];
			Vehicle[i] = r;
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}
hook OnPlayerExitVehicle(playerid, vehicleid)
{
	if ( vehicleid != INVALID_VEHICLE_ID )
	{
		if ( Vehicle[vehicleid][RadioOn] )
		{
			StopAudioStreamForPlayer(playerid);
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}
hook OnPlayerConnect(playerid)
{
	BuyVehicle_vID[playerid] = INVALID_PLAYER_ID;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	
	if ( IsPlayerInAnyVehicle(playerid) )
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if ( newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
		{
			if ( Vehicle[vehicleid][RadioOn] )
			{
				new name[MAX_STATION_NAME], url[MAX_STATION_URL];
				GetStationName(Vehicle[vehicleid][RadioID], name), GetStationUrl(Vehicle[vehicleid][RadioID], url);
				PlayAudioStreamForPlayer(playerid, url);
				SendClientMessage(playerid, COR_BRANCO, "%s{"COR_SISTEMA_INC"} sintonizada.", name);
			}
		}

		if(newstate == PLAYER_STATE_DRIVER){
			if(IsBike(GetVehicleModel(vehicleid)) && GetVehicleParams(vehicleid, VEHICLE_TYPE_ENGINE) != VEHICLE_PARAMS_ON){
				SetVehicleParams(vehicleid, VEHICLE_TYPE_ENGINE, VEHICLE_PARAMS_ON);
			}
		}

		if(Iter_Contains(VehiclePlayers, vehicleid))
		{
			if(!call::ADMIN->IsAdminInJob(playerid))
			{
				if(Vehicle[vehicleid][Owner][Id] != Jogador[playerid][PlayerID])
				{
					if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
					{
						SendClientMessage(playerid, COR_AMARELO, "| INFO | Este veiculo pertence à {ffffff}%s{ffff00} e você não poderá dirigi-lo.", Vehicle[vehicleid][Owner][Name]);
						RemovePlayerFromVehicle(playerid);
						return 1;
					}
				}
				else 
				{
					SendClientMessage(playerid, COR_AMARELO, "| INFO | Seja bem-vindo(a) ao seu veículo, {ffffff}%s{ffff00}.", GetUserName(playerid));
				}
			}
			else if(call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE && call::ADMIN->IsAdminInJob(playerid))
			{
				new id;
				id = GetPlayerIDByName(Vehicle[vehicleid][Owner][Name]);

				SendClientMessage(playerid, COR_VERMELHO, "| PFC - ADMIN | Este veículo pertence à %s[%d].", GetUserName(id), id);
			}
			return Y_HOOKS_CONTINUE_RETURN_1;
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

public OnPlayerVendingVehiclePlayer(playerid, id, avisos)
{
	if ( BuyVehicle_pID[id] == playerid )
	{
		--avisos;
		if ( !avisos )
		{
			SendClientMessage(playerid, COR_AVISO, "O(A) Jogador(a) demorou para responder a proposta de venda do veiculo e a mesma foi cancelada.");
			SendClientMessage(id, COR_AVISO, "Você demorou para responder e a proposta de venda do veiculo foi cancelada.");
			
			BuyVehicle_pID[id] = INVALID_PLAYER_ID;
			BuyVehicle_vID[id] = INVALID_VEHICLE_ID;
			BuyVehicle_Value[id] = 0;
			return true;
		}
		SendClientMessage(id, COR_AZUL, "» {"COR_BRANCO_INC"}O(A) Jogador(a) está te oferecendo o veiculo {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"} no valor de {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}, use /aceitarveiculo.", GetVehicleName(BuyVehicle_vID[id]), RealStr(BuyVehicle_Value[id]));
		SetTimerEx("OnPlayerVendingVehiclePlayer", 15000, false, "ddd", playerid, id, avisos);
		return true;
	}
	return true;
}

// ============================== [ CMDs ] ============================== //

alias:ligar("ligarmotor");
CMD:ligar(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COR_ERRO, "Você não pode ligar o veiculo se não estiver dirigindo.");

	new vehicleid = GetPlayerVehicleID(playerid), model = GetVehicleModel(vehicleid);
	if(GetVehicleParams(vehicleid, VEHICLE_TYPE_ENGINE) == VEHICLE_PARAMS_ON || call::CONCE->IsValidVehicleConce(vehicleid))
		return true;
	
	if ( IsBike(model) )
		return true;

	if(call::VH->GetVehicleFuel(vehicleid) <= 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse veiculo está sem combustível.");

	new Float:health;
	GetVehicleHealth(vehicleid, health);
	if ( health <= 300 )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Veiculo está muito danificado, chame um Mecânico.");

	SendClientMessage(playerid, COR_AMARELO, "| INFO | Veículo ligado!");
	SetVehicleParams(vehicleid, VEHICLE_TYPE_ENGINE, VEHICLE_PARAMS_ON);
	//call::TD->ShowPlayerVelocimetro(playerid);
	//ShowPlayerSpeedo(playerid, GetPlayerVehicleID(playerid));
	return true;
}

alias:desligar("desligarmotor");
CMD:desligar(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COR_ERRO, "Você não pode desligar o veiculo se não estiver dirigindo.");

	new vehicleid = GetPlayerVehicleID(playerid), model = GetVehicleModel(vehicleid);
	if(GetVehicleParams(vehicleid, VEHICLE_TYPE_ENGINE) <= VEHICLE_PARAMS_OFF)
		return true;
	
	if ( IsBike(model) )
		return true;

	SendClientMessage(playerid, COR_AMARELO, "| INFO | Veículo desligado!");
	SetVehicleParams(vehicleid, VEHICLE_TYPE_ENGINE, VEHICLE_PARAMS_OFF);
	//ShowPlayerSpeedo(playerid, GetPlayerVehicleID(playerid));
	return true;
}

CMD:ligarfarois(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COR_ERRO, "Você não pode ligar o farol se não estiver dirigindo.");

	new vehicleid = GetPlayerVehicleID(playerid), model = GetVehicleModel(vehicleid);
	
	if ( IsBike(model) )
		return true;

	if(GetVehicleParams(vehicleid, VEHICLE_TYPE_LIGHTS) == VEHICLE_PARAMS_ON)
		return true;

	SendClientMessage(playerid, COR_AMARELO, "| INFO | Farois ligados!");
	SetVehicleParams(vehicleid, VEHICLE_TYPE_LIGHTS, VEHICLE_PARAMS_ON);
	//ShowPlayerSpeedo(playerid, GetPlayerVehicleID(playerid));
	return true;
}

CMD:desligarfarois(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COR_ERRO, "Você não pode desligar o farol se não estiver dirigindo.");

	new vehicleid = GetPlayerVehicleID(playerid), model = GetVehicleModel(vehicleid);
	if(GetVehicleParams(vehicleid, VEHICLE_TYPE_LIGHTS) <= VEHICLE_PARAMS_OFF)
		return false;

	if ( IsBike(model) )
		return true;

	SendClientMessage(playerid, COR_AMARELO, "| INFO | Farois desligados!");
	SetVehicleParams(vehicleid, VEHICLE_TYPE_LIGHTS, VEHICLE_PARAMS_OFF);
	//ShowPlayerSpeedo(playerid, GetPlayerVehicleID(playerid));
	return true;
}

CMD:abrircapo(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COR_ERRO, "Você não pode abrir o capo se não estiver dirigindo.");

	new vehicleid = GetPlayerVehicleID(playerid), model = GetVehicleModel(vehicleid);
	if(GetVehicleParams(vehicleid, VEHICLE_TYPE_BONNET) == VEHICLE_PARAMS_ON)
		return false;

	if ( IsBike(model) )
		return true;

	SetVehicleParams(vehicleid, VEHICLE_TYPE_BONNET, VEHICLE_PARAMS_ON);
	return true;
}

CMD:fecharcapo(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COR_ERRO, "Você não pode fechar o capo se não estiver dirigindo.");

	new vehicleid = GetPlayerVehicleID(playerid), model = GetVehicleModel(vehicleid);
	if(GetVehicleParams(vehicleid, VEHICLE_TYPE_BONNET) <= VEHICLE_PARAMS_OFF)
		return false;
	
	if ( IsBike(model) )
		return true;

	SetVehicleParams(vehicleid, VEHICLE_TYPE_BONNET, VEHICLE_PARAMS_OFF);
	return true;
}

CMD:abrirportamalas(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COR_ERRO, "Você não pode abrir o portamalas se não estiver dirigindo.");

	new vehicleid = GetPlayerVehicleID(playerid), model = GetVehicleModel(vehicleid);
	if(GetVehicleParams(vehicleid, VEHICLE_TYPE_BOOT) == VEHICLE_PARAMS_ON)
		return false;

	if ( IsBike(model) )
		return true;

	SetVehicleParams(vehicleid, VEHICLE_TYPE_BOOT, VEHICLE_PARAMS_ON);
	return true;
}

CMD:fecharportamalas(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COR_ERRO, "Você não pode fechar o portamalas se não estiver dirigindo.");

	new vehicleid = GetPlayerVehicleID(playerid), model = GetVehicleModel(vehicleid);
	if(GetVehicleParams(vehicleid, VEHICLE_TYPE_BOOT) <= VEHICLE_PARAMS_OFF)
		return false;

	if ( IsBike(model) )
		return true;

	SetVehicleParams(vehicleid, VEHICLE_TYPE_BOOT, VEHICLE_PARAMS_OFF);
	return true;
}

/*CMD:trancarveiculo(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return false;

		new vehicleid = GetPlayerVehicleID(playerid), model = GetVehicleModel(vehicleid);
		
		if ( IsBike(model) )
			return true;

		if( Iter_Contains(VehiclePlayers, vehicleid) )
		{
			if(GetVehicleParams(vehicleid, VEHICLE_TYPE_DOORS) == VEHICLE_PARAMS_ON)
				return false;
				
			SetVehicleParams(vehicleid, VEHICLE_TYPE_DOORS, VEHICLE_PARAMS_ON);
			SendClientMessage(playerid, COR_VERDE, "» Veiculo trancado.");

			new query[128];
			mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_VEHICLES_PLAYER" SET `porta`='%d' WHERE `id`='%d'", VEHICLE_PARAMS_ON, Vehicle[vehicleid][Id]);
			mysql_tquery(getConexao(), query);
		}
		else
		{
			foreach(new i: Player)
			{
				if(i != playerid)
				{
					SetVehicleParamsForPlayer(vehicleid, i, 0, VEHICLE_PARAMS_ON);
				}
			}
			SendClientMessage(playerid, COR_VERDE, "» Veiculo trancado.");
		}
		return true;
	}
	else
	{
		new Float:vx, Float:vy, Float:vz;
		foreach(new vehicleid: VehiclePlayers)
		{
			GetVehiclePos(vehicleid, vx, vy, vz);
			if(GetPlayerDistanceFromPoint(playerid, vx, vy, vz) <= 2.0)
			{
				if(GetVehicleParams(vehicleid, VEHICLE_TYPE_DOORS) == VEHICLE_PARAMS_ON)
					return true;

				if ( IsBike(GetVehicleModel(vehicleid)) )
					return true;

				SetVehicleParams(vehicleid, VEHICLE_TYPE_DOORS, VEHICLE_PARAMS_ON);
				SendClientMessage(playerid, COR_VERDE, "» Veiculo trancado.");

				new query[128];
				mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_VEHICLES_PLAYER" SET `porta`='%d' WHERE `id`='%d'", VEHICLE_PARAMS_ON, Vehicle[vehicleid][Id]);
				mysql_tquery(getConexao(), query);
				return true;
			}
		}
	}
	return true;
}*/

/*CMD:destrancarveiculo(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return true;

		new vehicleid = GetPlayerVehicleID(playerid);

		if(Iter_Contains(VehiclePlayers, vehicleid))
		{
			if(GetVehicleParams(vehicleid, VEHICLE_TYPE_DOORS) == VEHICLE_PARAMS_OFF)
				return true;

			if ( IsBike(GetVehicleModel(vehicleid)) )
				return true;

			SetVehicleParams(vehicleid, VEHICLE_TYPE_DOORS, VEHICLE_PARAMS_OFF);
			SendClientMessage(playerid, COR_VERDE, "» Veiculo destrancado.");
			
			new query[128];
			mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_VEHICLES_PLAYER" SET `porta`='%d' WHERE `id`='%d'", VEHICLE_PARAMS_OFF, Vehicle[vehicleid][Id]);
			mysql_tquery(getConexao(), query);
			return true;
		}
		else
		{
			foreach(new i: Player)
			{
				if(i != playerid)
				{
					SetVehicleParamsForPlayer(vehicleid, i, 0, VEHICLE_PARAMS_OFF);
				}
			}
			SendClientMessage(playerid, COR_VERDE, "» Veiculo destrancado.");
			return true;
		}
	}
	else
	{
		new Float:vx, Float:vy, Float:vz;
		foreach(new vehicleid: VehiclePlayers)
		{
			GetVehiclePos(vehicleid, vx, vy, vz);
			if(GetPlayerDistanceFromPoint(playerid, vx, vy, vz) <= 2.0)
			{
				if(GetVehicleParams(vehicleid, VEHICLE_TYPE_DOORS) == VEHICLE_PARAMS_OFF)
					return true;
				
				if ( IsBike(GetVehicleModel(vehicleid)) )
					return true;

				SetVehicleParams(vehicleid, VEHICLE_TYPE_DOORS, VEHICLE_PARAMS_OFF);
				SendClientMessage(playerid, COR_VERDE, "» Veiculo destrancado.");

				new query[128];
				mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_VEHICLES_PLAYER" SET `porta`='%d' WHERE `id`='%d'", VEHICLE_PARAMS_OFF, Vehicle[vehicleid][Id]);
				mysql_tquery(getConexao(), query);
				return true;
			}
		}
		return true;
	}
}*/

CMD:estacionar(playerid, params[])
{
	if ( !IsPlayerInAnyVehicle(playerid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo.");

	new vehicleid = GetPlayerVehicleID(playerid);

	if ( !Iter_Contains(VehiclePlayers, vehicleid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode fazer isso.");

	new query[512];

	GetVehiclePos(vehicleid, Vehicle[vehicleid][Position][X], Vehicle[vehicleid][Position][Y], Vehicle[vehicleid][Position][Z]);
	GetVehicleZAngle(vehicleid, Vehicle[vehicleid][Position][A]);

	EVF::SetVehicleSpawnInfo(vehicleid, Vehicle[vehicleid][Position][X], Vehicle[vehicleid][Position][Y], Vehicle[vehicleid][Position][Z], Vehicle[vehicleid][Position][A], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_VEHICLES_PLAYER" SET `posicao_x`='%.3f',`posicao_y`='%.3f',`posicao_z`='%.3f',`posicao_a`='%.3f',`world`='%d',`interior`='%d' WHERE `id`='%d' LIMIT 1;",
		Vehicle[vehicleid][Position][X], Vehicle[vehicleid][Position][Y], Vehicle[vehicleid][Position][Z], Vehicle[vehicleid][Position][A],
		GetVehicleVirtualWorld(vehicleid),
		GetVehicleInterior(vehicleid),
		Vehicle[vehicleid][Id]
	);
	mysql_tquery(getConexao(), query);

	SendClientMessage(playerid, -1, "| VEÍCULO | A posição do veículo foi salva com sucesso.");

	return true;
}

CMD:localizarveiculos(playerid)
{
	new count, str[255], zone[MAX_ZONE_NAME], Float:x, Float:y, Float:z;
	
	str = "{ffffff}Veiculo\t{ff8000}Localização\n";
	foreach(new vehicleid: VehiclePlayers)
	{
		if( Vehicle[vehicleid][Owner][Id] == Jogador[playerid][PlayerID] )
		{
			new casaid = GetVehicleVirtualWorld(vehicleid);
			if ( casaid != 0 )
			{
				if ( !call::HOUSE->IsValidHouse(casaid) )return 1;
				GetLocalName(Casa[casaid][Entrada][X], Casa[casaid][Entrada][Y], zone, MAX_ZONE_NAME);
			}
			else
			{
				GetVehiclePos(vehicleid, x, y, z);
				GetLocalName(x, y, zone, sizeof(zone));
			}
			
			format(str, sizeof(str), "%s{ffffff}%s\t{ff8000}%s\n", str, GetVehicleName(vehicleid), zone);
			count++;
		}
	}
	if ( count )
		return ShowPlayerDialog(playerid, LOCALIZAR_VEICULO, DIALOG_STYLE_TABLIST_HEADERS, "LOCALIZAR VEICULOS", str, "Localizar", "Fechar");
	
	SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui nenhum veiculo.");
	return true;
}

new SelectedVehicle[MAX_PLAYERS][50];

CMD:menuveiculo(playerid, params[])
{
	new query[350];
	format(query, sizeof(query), "SELECT `id`, `modelo` FROM `veiculos` WHERE `proprietario_id`='%d'", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
	new Cache:result = mysql_query(getConexao(), query, true);
	new rows = cache_num_rows();

	new String[300], Str[300];
	strcat(String, "{ffffff}ID\t{ffffff}Veículo\n");

	if(rows > 0)
	{
		for(new i; i < rows; i++)
		{
			new nome[40], modelo;

			cache_get_value_int(i, "modelo", modelo);
			cache_get_value_int(i, "id", SelectedVehicle[playerid][i]);

			format(nome, 40, "%s", GetVehicleModelName(modelo));
			
			format(Str, sizeof(Str), "{00FF00}N° %d:\t{ffffff}%s\n", i+1, nome);
			strcat(String, Str);

		}
		ShowPlayerDialog(playerid, DIALOG_MENU_VEICULO, DIALOG_STYLE_TABLIST_HEADERS, "{ffffff}Menu Veículo", String, "Selecionar", "Cancelar");
	}
	else 
	{
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui veículos.");
	}

	cache_delete(result);
	return 1;
}

Dialog:DIALOG_MENU_VEICULO(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new vehicle = SelectedVehicle[playerid][listitem];
        for(new i; i < sizeof(SelectedVehicle[]); i++)
            SelectedVehicle[playerid][i] = -1;
		

        SetPVarInt(playerid, "SelectedVehicle", vehicle);

		new String[1000];
		strcat(String, "Localizar o Veículo\n");
		strcat(String, "Salvar a Posição\n");
		strcat(String, "Vender o Veículo\n");
		strcat(String, "Alterar a Cor\n");
		strcat(String, "Abrir o Porta-Malas\n");
		strcat(String, "Fechar o Porta-Malas\n");
		strcat(String, "Abrir o Capô\n");
		strcat(String, "Fechar o Capô\n");

		ShowPlayerDialog(playerid, DIALOG_VEHICLE_OPTIONS, DIALOG_STYLE_LIST, "{ffffff}Menu Veículo", String, "Selecionar", "Cancelar");

		return 1;
	}
	else 
	{
		SetPVarInt(playerid, "SelectedVehicle", -1);
	}
	return 1;
}

Dialog:DIALOG_VEHICLE_OPTIONS(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: // Localizar o Veículo
			{
				foreach(new vehicleid: VehiclePlayers)
				{
					if(Vehicle[vehicleid][Id] == GetPVarInt(playerid, "SelectedVehicle"))
					{
						new Float:Posicao[4], zone[MAX_ZONE_NAME];
						GetVehiclePos(vehicleid, Posicao[0], Posicao[1], Posicao[2]);
						GetLocalName(Posicao[0], Posicao[1], zone, MAX_ZONE_NAME);
						call::PLAYER->SetPlayerMarkGPS(playerid, Posicao[0], Posicao[1], Posicao[2]);

						SendClientMessage(playerid, -1, "| VEÍCULO | Seu veículo '{ffff00}%s{ffffff}' está localizado em {1c88f0}%s{ffffff}.", GetVehicleName(vehicleid), zone);
						
					}
				}
			}

			case 1: // Salvar a Posição
			{
				if ( !IsPlayerInAnyVehicle(playerid) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo.");

				new vehicleid = GetPlayerVehicleID(playerid);

				if ( !Iter_Contains(VehiclePlayers, vehicleid) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Este veículo não pode ser salvo.");
				
				if(Vehicle[vehicleid][Owner][Id] != call::PLAYER->GetPlayerVarInt(playerid, PlayerID))
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Este veículo não te pertence.");
				
				if(Vehicle[vehicleid][Id] != GetPVarInt(playerid, "SelectedVehicle"))
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não selecionou este veículo.");

				new query[512];

				GetVehiclePos(vehicleid, Vehicle[vehicleid][Position][X], Vehicle[vehicleid][Position][Y], Vehicle[vehicleid][Position][Z]);
				GetPlayerFacingAngle(playerid, Vehicle[vehicleid][Position][A]);

				EVF::SetVehicleSpawnInfo(vehicleid, Vehicle[vehicleid][Position][X], Vehicle[vehicleid][Position][Y], Vehicle[vehicleid][Position][Z], Vehicle[vehicleid][Position][A], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

				mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_VEHICLES_PLAYER" SET `posicao_x`='%f',`posicao_y`='%f',`posicao_z`='%f',`posicao_a`='%f',`world`='%d',`interior`='%d' WHERE `id`='%d' LIMIT 1;",
					Vehicle[vehicleid][Position][X], Vehicle[vehicleid][Position][Y], Vehicle[vehicleid][Position][Z], Vehicle[vehicleid][Position][A],
					GetVehicleVirtualWorld(vehicleid),
					GetVehicleInterior(vehicleid),
					Vehicle[vehicleid][Id]
				);
				mysql_tquery(getConexao(), query);

				SendClientMessage(playerid, COR_AMARELO, "| VEÍCULO | Veiculo estacionado com sucesso!");
			}	

			case 2: // Vender o Veículo
			{
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar dentro de seu veículo para poder vendê-lo!");
				
				new vehicleid = GetPlayerVehicleID(playerid);

				if ( !Iter_Contains(VehiclePlayers, vehicleid) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo de concessionária.");

				if ( Vehicle[vehicleid][Owner][Id] != Jogador[playerid][PlayerID] )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário deste veiculo.");
				
				if(Vehicle[vehicleid][Id] != GetPVarInt(playerid, "SelectedVehicle"))
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não selecionou este veículo.");

				new query[350];

				format(query, sizeof(query), "SELECT `valor` FROM `veiculos` WHERE `id`='%d'", Vehicle[vehicleid][Id]);
				new Cache:result = mysql_query(getConexao(), query, true), rows = cache_num_rows();
				new value;

				if(rows)
				{
					cache_get_value_int(0, "valor", value);
				}

				new String[500];

				new valor = ((value*80)/100);

				SetPVarInt(playerid, "ValorVenda", valor);

				format(String, sizeof(String), "{ffffff}Você deseja vender seu '{ffff00}%s{ffffff}' por {"COR_VERDE_CLARO_INC"}R$%s?", GetVehicleName(GetPlayerVehicleID(playerid)), RealStr(valor));
				ShowPlayerDialog(playerid, DIALOG_VENDA_VEICULO, DIALOG_STYLE_MSGBOX, "Vender Veículo", String, "Sim", "Não");

				cache_delete(result);
			}

			case 3: // Alterar a Cor
			{
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar dentro de seu veículo para poder pintá-lo!");
				
				new vehicleid = GetPlayerVehicleID(playerid);

				if ( !Iter_Contains(VehiclePlayers, vehicleid) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo de concessionária.");

				if ( Vehicle[vehicleid][Owner][Id] != Jogador[playerid][PlayerID] )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário deste veiculo.");
				
				if(Vehicle[vehicleid][Id] != GetPVarInt(playerid, "SelectedVehicle"))
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não selecionou este veículo.");

				ShowPlayerDialog(playerid, DIALOG_PAINT_VEHICLE_1, DIALOG_STYLE_INPUT, "{ffffff}Alterar a Cor", "{ffffff}Digite o ID da cor 1 que deseja pintar o seu veículo.", "Pintar", "Cancelar");
			}

			case 4: // Abrir o porta-malas
			{
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar dentro de seu veículo para poder abrir o porta-malas!");
				
				new vehicleid = GetPlayerVehicleID(playerid);

				if ( !Iter_Contains(VehiclePlayers, vehicleid) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo de concessionária.");

				if ( Vehicle[vehicleid][Owner][Id] != Jogador[playerid][PlayerID] )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário deste veiculo.");
				
				if(Vehicle[vehicleid][Id] != GetPVarInt(playerid, "SelectedVehicle"))
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não selecionou este veículo.");

				new model = GetVehicleModel(vehicleid);

				if(GetVehicleParams(vehicleid, VEHICLE_TYPE_BOOT) == VEHICLE_PARAMS_ON)
					return false;

				if ( IsBike(model) )
					return true;

				SetVehicleParams(vehicleid, VEHICLE_TYPE_BOOT, VEHICLE_PARAMS_ON);
			}

			case 5: // Fechar o porta-malas
			{
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar dentro de seu veículo para poder fechar o porta-malas!");
				
				new vehicleid = GetPlayerVehicleID(playerid);

				if ( !Iter_Contains(VehiclePlayers, vehicleid) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo de concessionária.");

				if ( Vehicle[vehicleid][Owner][Id] != Jogador[playerid][PlayerID] )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário deste veiculo.");
				
				if(Vehicle[vehicleid][Id] != GetPVarInt(playerid, "SelectedVehicle"))
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não selecionou este veículo.");

				new model = GetVehicleModel(vehicleid);
				if(GetVehicleParams(vehicleid, VEHICLE_TYPE_BOOT) <= VEHICLE_PARAMS_OFF)
					return false;

				if ( IsBike(model) )
					return true;

				SetVehicleParams(vehicleid, VEHICLE_TYPE_BOOT, VEHICLE_PARAMS_OFF);
			}

			case 6: // Abrir o Capô
			{
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar dentro de seu veículo para poder abrir o capô!");
				
				new vehicleid = GetPlayerVehicleID(playerid);

				if ( !Iter_Contains(VehiclePlayers, vehicleid) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo de concessionária.");

				if ( Vehicle[vehicleid][Owner][Id] != Jogador[playerid][PlayerID] )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário deste veiculo.");
				
				if(Vehicle[vehicleid][Id] != GetPVarInt(playerid, "SelectedVehicle"))
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não selecionou este veículo.");
				
			
				new model = GetVehicleModel(vehicleid);
				if(GetVehicleParams(vehicleid, VEHICLE_TYPE_BONNET) == VEHICLE_PARAMS_ON)
					return false;

				if ( IsBike(model) )
					return true;

				SetVehicleParams(vehicleid, VEHICLE_TYPE_BONNET, VEHICLE_PARAMS_ON);
			}

			case 7: // Fechar o Capô
			{
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar dentro de seu veículo para poder fechar o capô!");
				
				new vehicleid = GetPlayerVehicleID(playerid);

				if ( !Iter_Contains(VehiclePlayers, vehicleid) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo de concessionária.");

				if ( Vehicle[vehicleid][Owner][Id] != Jogador[playerid][PlayerID] )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário deste veiculo.");
				
				if(Vehicle[vehicleid][Id] != GetPVarInt(playerid, "SelectedVehicle"))
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não selecionou este veículo.");

				
				new model = GetVehicleModel(vehicleid);
				if(GetVehicleParams(vehicleid, VEHICLE_TYPE_BONNET) <= VEHICLE_PARAMS_OFF)
					return false;
				
				if ( IsBike(model) )
					return true;

				SetVehicleParams(vehicleid, VEHICLE_TYPE_BONNET, VEHICLE_PARAMS_OFF);
			}
		}
	}
	return 1;
}

Dialog:DIALOG_PAINT_VEHICLE_1(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(!IsNumeric(inputtext))
			return ShowPlayerDialog(playerid, DIALOG_PAINT_VEHICLE_1, DIALOG_STYLE_INPUT, "{ffffff}Alterar a Cor", "{ffffff}Digite o ID da cor 1 que deseja pintar o seu veículo.", "Pintar", "Cancelar");

		if(strval(inputtext) == 0) 	
			return SetPVarInt(playerid, "Cor1", 0), ShowPlayerDialog(playerid, DIALOG_PAINT_VEHICLE_2, DIALOG_STYLE_INPUT, "{ffffff}Alterar a Cor", "{ffffff}Digite o ID da cor 2 que deseja pintar seu veículo.", "Pintar", "Cancelar");
		
		ShowPlayerDialog(playerid, DIALOG_PAINT_VEHICLE_2, DIALOG_STYLE_INPUT, "{ffffff}Alterar a Cor", "{ffffff}Digite o ID da cor 2 que deseja pintar seu veículo.", "Pintar", "Cancelar");
		SetPVarInt(playerid, "Cor1", strval(inputtext));
	}
	return 1;
}

Dialog:DIALOG_PAINT_VEHICLE_2(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(!IsNumeric(inputtext))
			return ShowPlayerDialog(playerid, DIALOG_PAINT_VEHICLE_2, DIALOG_STYLE_INPUT, "{ffffff}Alterar a Cor", "{ffffff}Digite o ID da cor 2 que deseja pintar seu veículo.", "Pintar", "Cancelar");
		
		SetPVarInt(playerid, "Cor2", strval(inputtext));

		if(strval(inputtext) == 0) 	
		{
			SetPVarInt(playerid, "Cor2", 0);
		}

		ChangeVehicleColor(GetPlayerVehicleID(playerid), GetPVarInt(playerid, "Cor1"), GetPVarInt(playerid, "Cor2"));

		new query[350];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE `veiculos` SET `cor1`='%d', `cor2`='%d' WHERE `id`='%d'", GetPVarInt(playerid, "Cor1"), GetPVarInt(playerid, "Cor2"), GetPVarInt(playerid, "SelectedVehicle"));
		mysql_tquery(getConexao(), query);

	}
	return 1;
}


/*CMD:venderveiculo(playerid, params[])
{
	if ( !IsPlayerInAnyVehicle(playerid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa está dentro do veiculo que quer vender.");

	new vehicleid = GetPlayerVehicleID(playerid);

	if ( !Iter_Contains(VehiclePlayers, vehicleid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo de concessionária.");

	if ( Vehicle[vehicleid][Owner][Id] != Jogador[playerid][PlayerID] )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário deste veiculo.");

	new id, valor;
	if (sscanf(params, "dd", id, valor))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/venderveiculo [id] [valor]");

	if ( id == playerid )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode oferecer um veiculo a sí mesmo.");

	if ( valor > call::VH->GetVehicleModelValor(GetVehicleModel(vehicleid)) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode vender o veiculo mais caro do que na concessionária.");

	if ( !call::PLAYER->IsPlayerLogged(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) Jogador(a) não está conectado(a).");

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if ( GetPlayerDistanceToPoint(id, x, y) > 15)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) Jogador(a) não está próximo de você.");
	
	BuyVehicle_pID[playerid] = id;

	BuyVehicle_pID[id] = playerid;
	BuyVehicle_vID[id] = vehicleid;
	BuyVehicle_Value[id] = valor;
	
	SendClientMessage(id, COR_AZUL, "» {"COR_BRANCO_INC"}O(A) Jogador(a) {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"} está te oferecendo o veiculo {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"}...", GetUserName(playerid), GetVehicleName(vehicleid));
	SendClientMessage(id, COR_BRANCO, "no valor de {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}, use {"COR_AMARELO_INC"}/aceitarveiculo{"COR_BRANCO_INC"}.", RealStr(valor));

	SendClientMessage(playerid, COR_BRANCO, "Você ofereceu o seu veiculo {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"} ao jogador {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"}  por {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}, aguarde a resposta.", GetVehicleName(vehicleid), GetUserName(id), RealStr(valor));
	SetTimerEx("OnPlayerVendingVehiclePlayer", 15000, false, "ddd", playerid, id, 5);
	return true;
}*/


Dialog:DIALOG_VENDER_VEICULO(playerid, response, listitem, inputtext[])
{
	
	return 1;
}

CMD:aceitarveiculo(playerid)
{
	if ( BuyVehicle_vID[playerid] != INVALID_VEHICLE_ID )
	{
		if ( BuyVehicle_Value[playerid] > GetPlayerMoney(playerid) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem a quantia necessária para comprar o veiculo.");

		new vehicleid = BuyVehicle_vID[playerid];

		Vehicle[vehicleid][Owner][Id] = Jogador[playerid][PlayerID];
		format(Vehicle[vehicleid][Owner][Name], MAX_PLAYER_NAME, GetUserName(playerid) );

		SendClientMessage(playerid, COR_BRANCO, "» Você comprou o veiculo {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"} por {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"} do jogador {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"}.", GetVehicleName(vehicleid), RealStr(BuyVehicle_Value[playerid]), GetUserName(BuyVehicle_pID[playerid]) );
		SendClientMessage(BuyVehicle_pID[playerid], COR_BRANCO, "» O(A) Jogador(a) {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"} comprou o veiculo {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"}, e você recebeu {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}.", GetUserName(playerid), GetVehicleName(vehicleid), RealStr(BuyVehicle_Value[playerid]));

		new query[128];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_VEHICLES_PLAYER" SET `proprietario_id`='%d' WHERE `id`='%d' LIMIT 1;", Vehicle[vehicleid][Owner][Id], Vehicle[vehicleid][Id]);
		mysql_tquery(getConexao(), query);

		GivePlayerMoney(playerid, -BuyVehicle_Value[playerid]);
		GivePlayerMoney(BuyVehicle_pID[playerid], BuyVehicle_Value[playerid]);

		BuyVehicle_vID[playerid] = INVALID_VEHICLE_ID;
		BuyVehicle_pID[playerid] = INVALID_PLAYER_ID;
		BuyVehicle_Value[playerid] = 0;

		BuyVehicle_pID[BuyVehicle_pID[playerid]] = INVALID_PLAYER_ID;
		return true;
	}
	SendClientMessage(playerid, COR_ERRO, "| ERRO | Não lhe foi oferecido nenhum veiculo.");
	return true;
}

/*CMD:janela(playerid, params[], help)
{
	new vehicleid = GetPlayerVehicleID(playerid), model = GetVehicleModel(vehicleid);

    if(!IsPlayerInAnyVehicle(playerid))
        SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veículo.");
    else if ( IsBike(model) )
        SendClientMessage(playerid, COR_ERRO, "| ERRO | Este veículo não possui janela.");
    else
    {
        new driver, passenger, backleft, backright;
        GetVehicleParamsCarWindows(vehicleid, driver, passenger, backleft, backright);

        switch(GetPlayerVehicleSeat(playerid))
        {
            case 0:
            {
                if(driver == -1 || driver == 1)
                {
                    SendClientMessage(playerid, COR_BRANCO, "| INFO | Você abriu a janela do motorista.");
                    SetVehicleParamsCarWindows(vehicleid, 0, passenger, backleft, backright);
                }
                else
                {
                    SendClientMessage(playerid, COR_BRANCO, "| INFO | Você fechou a janela do motorista.");
                    SetVehicleParamsCarWindows(vehicleid, 1, passenger, backleft, backright);
                }
            }
            case 1:
            {
                if(passenger == -1 || passenger == 1)
                {
                    SendClientMessage(playerid, COR_BRANCO, "| INFO | Você abriu a janela do passageiro.");
                    SetVehicleParamsCarWindows(vehicleid, driver, 0, backleft, backright);
                }
                else
                {
                    SendClientMessage(playerid, COR_BRANCO, "| INFO | Você fechou a janela do passageiro.");
                    SetVehicleParamsCarWindows(vehicleid, driver, 1, backleft, backright);
                }
            }
            case 2:
            {
                if(backleft == -1 || backleft == 1)
                {
                    SendClientMessage(playerid, COR_BRANCO, "| INFO | Você abriu a janela do passageiro.");
                    SetVehicleParamsCarWindows(vehicleid, driver, passenger, 0, backright);
                }
                else
                {
                    SendClientMessage(playerid, COR_BRANCO, "| INFO | Você fechou a janela do passageiro.");
                    SetVehicleParamsCarWindows(vehicleid, driver, passenger, 1, backright);
                }
            }
            case 3:
            {
                if(backright == -1 || backright == 1)
                {
                    SendClientMessage(playerid, COR_BRANCO, "| INFO | Você abriu a janela do passageiro.");
                    SetVehicleParamsCarWindows(vehicleid, driver, passenger, backleft, 0);
                }
                else
                {
                    SendClientMessage(playerid, COR_BRANCO, "| INFO | Você fechou a janela do passageiro.");
                    SetVehicleParamsCarWindows(vehicleid, driver, passenger, backleft, 1);
                }
            }
            default:
            {
                SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode abrir essa janela.");
            }
        }
    }
    return 1;
}*/

// ============================== [ DIALOGs ] ============================== //
Dialog:LOCALIZAR_VEICULO(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new count;
		foreach(new vehicleid: VehiclePlayers)
		{
			if( Vehicle[vehicleid][Owner][Id] == Jogador[playerid][PlayerID] )
			{
				if(listitem == count)
				{
					new casaid = GetVehicleVirtualWorld(vehicleid);
					if ( casaid )
					{
						if ( !call::HOUSE->IsValidHouse(casaid) )return 1;

						new zone[MAX_ZONE_NAME];
						GetLocalName(Casa[casaid][Entrada][X], Casa[casaid][Entrada][Y], zone, MAX_ZONE_NAME);

						call::PLAYER->SetPlayerMarkGPS(playerid, Casa[casaid][Garagem][pEntrada][X], Casa[casaid][Garagem][pEntrada][Y], Casa[casaid][Garagem][pEntrada][Z]);
						SendClientMessage(playerid, COR_BRANCO, "| VEÍCULO | Seu veiculo {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"} está localizado em uma garagem na cidade de {"COR_AMARELO_INC"}%s{"COR_BRANCO_INC"}.", GetVehicleName(vehicleid), zone);
						return 1;
					}
					else
					{
						new zone[MAX_ZONE_NAME], Float:x, Float:y, Float:z;
						GetVehiclePos(vehicleid, x, y, z);
						GetLocalName(x, y, zone, MAX_ZONE_NAME);
						call::PLAYER->SetPlayerMarkGPS(playerid, x, y, z);
						SendClientMessage(playerid, COR_AMARELO, "| VEÍCULO | Seu veículo {ffffff}%s {ffff00}está localizado em {ffffff}%s{ffff00}.", GetVehicleName(vehicleid), zone);
						return 1;
					}
				}
				count++;
			}
		}
		return 1;
	}
	return 1;
}


stock LoadPlayerVehicles(playerid)
{
	new query[255];
	mysql_format(getConexao(), query, sizeof(query), "SELECT *, u.username as proprietario FROM "TABLE_VEHICLES_PLAYER" as v LEFT JOIN "TABLE_USERS" as u ON u.id = v.proprietario_id WHERE proprietario_id = %d;", Jogador[playerid][PlayerID]);
	mysql_tquery(getConexao(), query, "OnLoadVehiclesPlayer", "i", playerid);
	return 1;
}

public OnLoadVehiclesPlayer(playerid)
{
	new rows = cache_num_rows();
	if ( rows )
	{
		new model, color1, color2, Float:x, Float:y, Float:z, Float:a, Float:km, Float:health;
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "modelo", model);
			cache_get_value_name_int(i, "cor1", color1);
			cache_get_value_name_int(i, "cor2", color2);

			cache_get_value_name_float(i, "posicao_x", x);
			cache_get_value_name_float(i, "posicao_y", y);
			cache_get_value_name_float(i, "posicao_z", z);
			cache_get_value_name_float(i, "posicao_a", a);
			
			new vehicleid = CreateVehicle(model, x, y, z, a, color1, color2, -1);
			
			Vehicle[vehicleid][Position][X] = x;
			Vehicle[vehicleid][Position][Y] = y;
			Vehicle[vehicleid][Position][Z] = z;
			Vehicle[vehicleid][Position][A] = a;
			cache_get_value_name_int(i, "interior", Vehicle[vehicleid][Interior]);
			LinkVehicleToInterior(vehicleid, Vehicle[vehicleid][Interior]);

			cache_get_value_name_int(i, "world", Vehicle[vehicleid][World]);
			SetVehicleVirtualWorld(vehicleid, Vehicle[vehicleid][World]);

			Iter_Add(VehiclePlayers, vehicleid);

			cache_get_value_name_int(i, "id", Vehicle[vehicleid][Id]);
			cache_get_value_name(i, "proprietario", Vehicle[vehicleid][Owner][Name], MAX_PLAYER_NAME);
			cache_get_value_name_int(i, "proprietario_id", Vehicle[vehicleid][Owner][Id]);

			printf("proprietario: %s", Vehicle[vehicleid][Owner][Name]);
			printf("proprietario_id: %d", Vehicle[vehicleid][Owner][Id]);
			
			cache_get_value_name(i, "placa", Vehicle[vehicleid][Placa], MAX_VEHICLE_PLACA_LEN);
			SetVehicleNumberPlate(vehicleid, Vehicle[vehicleid][Placa]);
			
			cache_get_value_name_int(i, "nitro", Vehicle[vehicleid][Nitro]);
			AddVehicleComponent(vehicleid, Vehicle[vehicleid][Nitro]);

			cache_get_value_name_int(i, "roda", Vehicle[vehicleid][Rodas]);
			AddVehicleComponent(vehicleid, Vehicle[vehicleid][Rodas]);

			cache_get_value_name_int(i, "hidraulica", Vehicle[vehicleid][Hidraulica]);
			AddVehicleComponent(vehicleid, Vehicle[vehicleid][Hidraulica]);

			cache_get_value_name_int(i, "paintjob", Vehicle[vehicleid][PaintJob]);
			ChangeVehiclePaintjob(vehicleid, Vehicle[vehicleid][PaintJob]);

			cache_get_value_name_int(i, "porta", Vehicle[vehicleid][Porta]);
			SetVehicleParams(vehicleid, VEHICLE_TYPE_DOORS, Vehicle[vehicleid][Porta]);

			cache_get_value_name_float(i, "km", km);
			SetVehicleDistanceTravaled(vehicleid, km);

			cache_get_value_name_float(i, "vida", health);
			SetVehicleHealth(vehicleid, (health > 300.0 ? health : 300.0));

			cache_get_value_name_int(i, "multas", Vehicle[vehicleid][Multas]);

			cache_get_value_name_float(i, "combustivel", Vehicle[vehicleid][Fuel]);
			
			if(Vehicle[vehicleid][Fuel] > GetVehicleMaxFuel(model) )
				Vehicle[vehicleid][Fuel] = GetVehicleMaxFuel(model);

			cache_get_value_name_int(i, "ipva", Vehicle[vehicleid][IPVA]);
			new interior, world;
			cache_get_value_name_int(i, "interior", interior);
			LinkVehicleToInterior(vehicleid, interior);

			cache_get_value_name_int(i, "world", world);
			SetVehicleVirtualWorld(vehicleid, world);
		}
	}
}

stock SavePlayerVehicles(playerid)
{
	new query[1024 * 2], Float:health, bool:is_verified = false;
	for(new i; i < MAX_VEHICLES; i++)
	{
		if ( !IsValidVehicle(i) )continue;

		if ( Jogador[playerid][PlayerID] == Vehicle[i][Owner][Id] )
		{
			is_verified = true;
			GetVehicleHealth(i, health);
			format(query, sizeof(query), "%sUPDATE "TABLE_VEHICLES_PLAYER" SET `combustivel`='%.3f',`vida`='%.3f',`km`='%.3f' WHERE `id`='%d';", query, Vehicle[i][Fuel], health, GetDistanceTraveled(i), Vehicle[i][Id]);
			
			DestroyVehicle(i);

			// resetar variaveis do veiculo do jogador.
			new r[e_VEHICLE_INFO];
			Vehicle[i] = r;

			Iter_SafeRemove(VehiclePlayers, i, i);
		}
	}
	if ( !is_verified )return 0;

	mysql_tquery(getConexao(), query);
	return 1;
}