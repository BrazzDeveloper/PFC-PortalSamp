#include <YSI_Coding\y_hooks>

static 
	Concessionaria[MAX_VEHICLES_CONCE + 1][e_CONCE_INFO];

forward OnCreateVehicleForPlayer(playerid, valor);

// ============================== [ FUNCTIONs ] ============================== //

stock function CONCE::IsValidVehicleConce(vehicleid)
{
	new index = call::CONCE->GetVehicleIndexConce(vehicleid);
	
	if(index == INVALID_CONCE_VEHICLE_ID)
		return false;

	return Iter_Contains(Concessionaria, index);
}

stock function CONCE::GetVehicleIndexConce(vehicleid)
{
	foreach(new i: Concessionaria)
	{
		if(Concessionaria[i][VehicleID] == vehicleid)
		{
			return i;
		}
	}
	return INVALID_CONCE_VEHICLE_ID;
}

stock function CONCE::GetVehicleConceVarInt(vehicleid, e_CONCE_INFO:param)
{
	if(!call::CONCE->IsValidVehicleConce(vehicleid))
		return -1;

	new index = call::CONCE->GetVehicleIndexConce(vehicleid);
	if(index == INVALID_CONCE_VEHICLE_ID)
		return -1;

	return Concessionaria[index][param];
}
stock function CONCE::GetVehicleValorByModel(model)
{
	foreach(new i: Concessionaria)
	{
		if ( Concessionaria[i][Modelid] == model )
		{
			return Concessionaria[i][Valor];
		}
	}
	return -1;
}

// ============================== [ CALLBACKs ] ============================== //

hook OnGameModeInit()
{
	print("» Carregando veiculos da Concessionária.");

	new Cache:cache = mysql_query(getConexao(), "SELECT * FROM "TABLE_VEHICLES_CONCE""), rows = cache_num_rows(), str[128];
	if(rows)
	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "modelo", Concessionaria[i][Modelid]);

			cache_get_value_name_float(i, "posicao_x", Concessionaria[i][Position][X]);
			cache_get_value_name_float(i, "posicao_y", Concessionaria[i][Position][Y]);
			cache_get_value_name_float(i, "posicao_z", Concessionaria[i][Position][Z]);
			cache_get_value_name_float(i, "posicao_a", Concessionaria[i][Position][A]);

			cache_get_value_name_int(i, "cor1", Concessionaria[i][Color1]);
			cache_get_value_name_int(i, "cor2", Concessionaria[i][Color2]);
			cache_get_value_name_int(i, "valor", Concessionaria[i][Valor]);

			Concessionaria[i][VehicleID] = CreateVehicle(Concessionaria[i][Modelid], Concessionaria[i][Position][X], Concessionaria[i][Position][Y], Concessionaria[i][Position][Z], Concessionaria[i][Position][A], Concessionaria[i][Color1], Concessionaria[i][Color2], 180);
			Iter_Add(Concessionaria, i);

			format(str, sizeof(str), "Veiculo: {"COR_AMARELO_INC"}%s{"COR_BRANCO_INC"}\nModelo: {"COR_AMARELO_INC"}%d{"COR_BRANCO_INC"}\nValor: {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}", GetVehicleModelName(Concessionaria[i][Modelid]), Concessionaria[i][Modelid], RealStr(Concessionaria[i][Valor]));
			CreateDynamic3DTextLabel(str, COR_BRANCO, 0.0, 0.0, 0.5, 15, .attachedvehicle=Concessionaria[i][VehicleID], .testlos=1, .worldid=0, .interiorid=0, .streamdistance=20.0);

		}
		printf("	- Total de %d veiculo(s) carregado(s).\n", rows);
	}
	else
		print("	* Não foi encontrado nenhum veiculo na tabela.\n");

	cache_delete(cache);
	return true;
}

hook OnPlayerDisconnect(playerid, reason)
{
	SetPVarInt(playerid, "ValorVenda", 0);
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate != PLAYER_STATE_DRIVER)
		return Y_HOOKS_CONTINUE_RETURN_1;

	if(call::CONCE->IsValidVehicleConce(GetPlayerVehicleID(playerid)))
	{
		foreach(new i: Concessionaria)
		{
			if(GetPlayerVehicleID(playerid) != Concessionaria[i][VehicleID])
				continue;

			SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Para comprar este veiculo use {"COR_AMARELO_INC"}/comprarveiculo{"COR_BRANCO_INC"}.");
			break;
		}
		return Y_HOOKS_BREAK_RETURN_1;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

public OnCreateVehicleForPlayer(playerid, valor)
{
	if( !cache_affected_rows() )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foi possivel efetuar a compra do seu veiculo.");

	new query[255], id = cache_insert_id();
	mysql_format(getConexao(), query, sizeof(query), "SELECT *, u.username as proprietario FROM "TABLE_VEHICLES_PLAYER" as v LEFT JOIN "TABLE_USERS" as u ON u.id = v.proprietario_id WHERE v.id = %d;", id);
	new Cache:cache = mysql_query(getConexao(), query, true);
	
	// descontar dinheiro
	GivePlayerMoney(playerid, -valor);

	if ( cache_num_rows() )
	{
		new vehicleid, model, color1, color2, Float:x, Float:y, Float:z, Float:a;

		cache_get_value_name_int(0, "modelo", model);
		cache_get_value_name_int(0, "cor1", color1);
		cache_get_value_name_int(0, "cor2", color2);
		
		cache_get_value_name_float(0, "posicao_x", x);
		cache_get_value_name_float(0, "posicao_y", y);
		cache_get_value_name_float(0, "posicao_z", z);
		cache_get_value_name_float(0, "posicao_a", a);

		vehicleid = CreateVehicle(model, x, y, z, a, color1, color2, -1);
		Vehicle[vehicleid][Position][X] = x;
		Vehicle[vehicleid][Position][Y] = y;
		Vehicle[vehicleid][Position][Z] = z;
		Vehicle[vehicleid][Position][A] = a;

		Iter_Add(VehiclePlayers, vehicleid);

		Vehicle[vehicleid][Id] = id;

		cache_get_value_name(0, "proprietario", Vehicle[vehicleid][Owner][Name], MAX_PLAYER_NAME);
		cache_get_value_name_int(0, "proprietario_id", Vehicle[vehicleid][Owner][Id]);
		cache_get_value_name_int(0, "porta", Vehicle[vehicleid][Porta]);

		printf("proprietario: %s", Vehicle[vehicleid][Owner][Name]);
		printf("proprietario_id: %d", Vehicle[vehicleid][Owner][Id]);
		
		cache_get_value_name_int(0, "nitro", Vehicle[vehicleid][Nitro]);
		AddVehicleComponent(vehicleid, Vehicle[vehicleid][Nitro]);

		cache_get_value_name_int(0, "roda", Vehicle[vehicleid][Rodas]);
		AddVehicleComponent(vehicleid, Vehicle[vehicleid][Rodas]);

		cache_get_value_name_int(0, "paintjob", Vehicle[vehicleid][PaintJob]);
		ChangeVehiclePaintjob(vehicleid, Vehicle[vehicleid][PaintJob]);
		
		cache_get_value_name(0, "placa", Vehicle[vehicleid][Placa], MAX_VEHICLE_PLACA_LEN);
		SetVehicleNumberPlate(vehicleid, Vehicle[vehicleid][Placa]);

		cache_get_value_name_int(0, "interior", Vehicle[vehicleid][Interior]);
		LinkVehicleToInterior(vehicleid, Vehicle[vehicleid][Interior]);

		cache_get_value_name_int(0, "world", Vehicle[vehicleid][World]);
		SetVehicleVirtualWorld(vehicleid, Vehicle[vehicleid][World]);

		cache_get_value_name_float(0, "combustivel", Vehicle[vehicleid][Fuel]);
		call::VH->SetVehicleFuel(vehicleid, Vehicle[vehicleid][Fuel]);

		SendClientMessage(playerid, -1, "| VEÍCULO | Você adquiriu o veiculo {1c88f0}%s{ffffff} por {"COR_VERDE_CLARO_INC"}R$%s{"COR_BRANCO_INC"}.", GetVehicleModelName(model), RealStr(valor));
		SendClientMessage(playerid, -1, "| VEÍCULO | Seu veiculo já está pronto para uso, localize-o utilizando /LocalizarVeiculos.");
	}
	else
	{
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foi possivel carregar o seu veiculo.");
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Contate um desenvolvedor.");
	}
	cache_delete(cache);
	return true;
}

Dialog:DIALOG_VENDA_VEICULO(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		new query[350];
		mysql_format(getConexao(), query, sizeof(query), "DELETE FROM `veiculos` WHERE `id`='%d'", Vehicle[vehicleid][Id]);
		mysql_tquery(getConexao(), query);

		GivePlayerMoney(playerid, GetPVarInt(playerid, "ValorVenda"));
		DestroyVehicle(vehicleid);

		SendClientMessage(playerid, COR_AMARELO, "| VEÍCULO | Você vendeu seu veículo por {ffffff}R$%s{ffff00}.", RealStr(GetPVarInt(playerid, "ValorVenda")) );

	}
	else 
	{
		SendClientMessage(playerid, COR_ERRO, "| VENDA | Você cancelou a venda do seu veículo.");
	}
	return 1;
}

// ============================== [ COMMANDs ] ============================== //

CMD:venderveiculo(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar dentro de seu veículo para poder vendê-lo!");
	
	new vehicleid = GetPlayerVehicleID(playerid);

	if ( !Iter_Contains(VehiclePlayers, vehicleid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo de concessionária.");

	if ( Vehicle[vehicleid][Owner][Id] != Jogador[playerid][PlayerID] )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é proprietário deste veiculo.");

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
	return 1;
}

CMD:comprarveiculo(playerid)
{
	if( !IsPlayerInAnyVehicle(playerid) )
		return 1;

	if(!call::CONCE->IsValidVehicleConce(GetPlayerVehicleID(playerid)))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo da Concessionária.");

	new vehicleid = GetPlayerVehicleID(playerid), model = GetVehicleModel(vehicleid), valor = call::CONCE->GetVehicleConceVarInt(vehicleid, Valor);
	if(GetPlayerMoney(playerid) < valor)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente para comprar este veiculo.");

	new query[500];

	mysql_format(getConexao(), query, sizeof(query), "SELECT `proprietario_id` FROM `veiculos` WHERE `proprietario_id`='%d'", Jogador[playerid][PlayerID]);

	new Cache:cache = mysql_query(getConexao(), query, true), rows = cache_num_rows();
	
	if( rows >= MAX_VEHICLES_PER_PLAYER )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já atingiu seu limite de veiculos comprados.");
	
	cache_delete(cache);

	new Float:spawnvX, Float:spawnvY, Float:spawnvZ, Float:spawnvA;
	if(IsPlayerInPlace(playerid, -1967.1882, 250.9508, -1939.8126, 309.3595)) // San Fierro
	{
		
		static const WangCarsSpawnVehicle[][e_POSITION] =
		{
			{-1936.0967, 273.6908, 40.8046, 0.0},
			{-1928.6033, 273.7936, 40.8425, 0.0}
		};
		new rand = random(sizeof(WangCarsSpawnVehicle));
		spawnvX = WangCarsSpawnVehicle[rand][X], spawnvY = WangCarsSpawnVehicle[rand][Y], spawnvZ = WangCarsSpawnVehicle[rand][Z], spawnvA = WangCarsSpawnVehicle[rand][A];
	}
	else if(IsPlayerInPlace(playerid, -1702.9950, 1195.9835, -1634.5321, 1229.0648)) // San Fierro Importados
	{
		static const ImportationCars[][e_POSITION]=
		{
			{-1630.1287, 1291.0750, 6.7433, 311.5392},
			{-1634.1373, 1293.8048, 6.7420, 316.1434},
			{-1637.9504, 1297.3516, 6.7399, 311.8978}
		};
		new rand = random(sizeof(ImportationCars));
		spawnvX = ImportationCars[rand][X], spawnvY = ImportationCars[rand][Y], spawnvZ = ImportationCars[rand][Z], spawnvA = ImportationCars[rand][A];
	}
	else if(IsPlayerInPlace(playerid, 513.5149, -1330.0192, 562.3225, -1252.8619)) // Los Santos Carros Populares
	{
		static const LSConcePopular[][e_POSITION]=
		{
			{562.0217, -1264.4572, 17.0004, 11.4410},
			{563.6833, -1272.6682, 16.9998, 11.4409},
			{565.6284, -1282.2777, 17.0043, 11.4899}
		};
		new rand = random(sizeof(LSConcePopular));
		spawnvX = LSConcePopular[rand][X], spawnvY = LSConcePopular[rand][Y], spawnvZ = LSConcePopular[rand][Z], spawnvA = LSConcePopular[rand][A];
	}
	else if(IsPlayerInPlace(playerid, 2114.5422,-1160.7648, 2138.9663,-1125.5081)) // Los Santos carros Velhos/antigos
	{
		static const LSConceOld[][e_POSITION]=
		{
			{2148.7124, -1133.7797, 25.3251, 269.3145},
			{2148.8687, -1138.7577, 25.2584, 271.0084},
			{2148.9929, -1143.2252, 24.7137, 270.2445}
		};
		new rand = random(sizeof(LSConceOld));
		spawnvX = LSConceOld[rand][X], spawnvY = LSConceOld[rand][Y], spawnvZ = LSConceOld[rand][Z], spawnvA = LSConceOld[rand][A];
	}
	else if( IsPlayerInPlace(playerid, 1971.6348, 2033.0961, 1996.5238,2062.3779) ) // Las Venturas
	{
		static const LVConce[][e_POSITION]=
		{
			{1945.6621, 2043.4738, 10.5658, 358.4957},
			{1946.0294, 2063.4233, 10.5793, 359.8315},
			{1946.0596, 2073.5518, 10.5777, 359.8313},
			{1946.1217, 2094.8853, 10.5750, 359.8311}
		};
		new rand = random(sizeof(LVConce));
		spawnvX = LVConce[rand][X], spawnvY = LVConce[rand][Y], spawnvZ = LVConce[rand][Z], spawnvA = LVConce[rand][A];
	}
	else if( IsPlayerInPlace(playerid, 583.7801,-1523.3069, 617.8124,-1493.7452) )
	{
		static const Lowriders[][e_POSITION]=
		{
			{651.4484, -1501.0691, 14.9477, 93.8393},
			{651.6104, -1497.6256, 14.5856, 87.0449},
			{661.3818, -1498.1304, 14.5899, 87.0372},
			{661.0098, -1501.2050, 14.5910, 88.7982}
		};
		new rand = random(sizeof(Lowriders));
		spawnvX = Lowriders[rand][X], spawnvY = Lowriders[rand][Y], spawnvZ = Lowriders[rand][Z], spawnvA = Lowriders[rand][A];
	}
	/**
	*
	*	Concessionária de Barcos de Los Santos.
	*
	**/
	else if( IsPlayerInPlace(playerid, 2588.3936,-2480.1711, 2650.5486,-2460.8784) )
	{
		static const BarcosLS[][e_POSITION]=
		{
			{2582.1575, -2464.9712, -0.0423, 177.1668},
			{2576.8560, -2462.3103, -0.2778, 183.2577},
			{2570.5627, -2464.8311, -0.1461, 180.0641}
		};
		new rand = random(sizeof(BarcosLS));
		spawnvX = BarcosLS[rand][X], spawnvY = BarcosLS[rand][Y], spawnvZ = BarcosLS[rand][Z], spawnvA = BarcosLS[rand][A];
	}
	SendClientMessage(playerid, COR_VERDE, "» {"COR_BRANCO_INC"}Efetuando a compra, por favor aguarde...");
	
	// ======================== //
	RemovePlayerFromVehicle(playerid);


	new placa[MAX_VEHICLE_PLACA_LEN];
	GeneretePlate(placa);
	//new Float:fuel = GetVehicleMaxFuel(model);
	mysql_format(getConexao(), query, sizeof(query), "INSERT INTO "TABLE_VEHICLES_PLAYER"(`valor`, `modelo`,`proprietario`,`proprietario_id`,`placa`,`posicao_x`,`posicao_y`,`posicao_z`,`posicao_a`,`combustivel`,`vida`, `paintjob`,`interior`)\
		VALUES('%d', '%d', '%s', '%d','%s','%.3f','%.3f','%.3f','%.3f','30','1000','-1','0');",
		valor, model, GetUserName(playerid), Jogador[playerid][PlayerID], placa, spawnvX, spawnvY, spawnvZ, spawnvA
	);
	mysql_tquery(getConexao(), query, "OnCreateVehicleForPlayer", "dd", playerid, valor);
	return true;
}
