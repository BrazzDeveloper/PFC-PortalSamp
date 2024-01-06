// ============================== [ functions ] ============================== //
stock GetHotelPickupId(hotelid)
{
	if ( !IsValidHotel(hotelid) )
		return 0;
	
	if ( !Hotel[hotelid][Owner][Id] )
		return PICKUP_VEDING;

	return PICKUP_OCCUPED;
}

stock GetHotelTableValue(hotelid, const colunm[], value[], len = sizeof(value))
{
	if (!IsValidHouse(hotelid) )
		return false;

	new query[128];
	mysql_format(getConexao(), query, sizeof(query), "SELECT %e FROM "TABLE_HOTEIS" WHERE `id`='%d' LIMIT 1;", colunm, Hotel[hotelid][ID]);
	new Cache:c = mysql_query(getConexao(), query, true);
	
	if ( cache_num_rows() )
		cache_get_value_name(0, colunm, value, len);	

	cache_delete(c);
	return true;
}

stock GetHotelTableValueInt(hotelid, const colunm[])
{
	if (!IsValidHouse(hotelid) )
		return false;

	new value[11];
	GetHotelTableValue(hotelid, colunm, value, sizeof(value));
	return strval(value);
}

stock GetPlayerHotel(playerid)
{
	foreach(new i: Hotel)
	{
		if ( Jogador[playerid][PlayerID] == Hotel[i][Owner][Id])
		{
			return i;
		}
	}
	return INVALID_HOTEL_ID;
}

stock IsValidHotel(hotelid)
{
	if(hotelid < 0 || hotelid > sizeof(Hotel))
		return false;

	return (Iter_Contains(Hotel, hotelid));
}

stock DynamicLabel(hotelid)
{
	if(!IsValidHotel(hotelid))
		return 0;

	new str[236];
	format(str, sizeof(str), "Hotel\nN°: {"COR_AMARELO_INC"}%d{"COR_BRANCO_INC"}\nAlugado por: {"COR_AZUL_INC"}%s", Hotel[hotelid][ID], Hotel[hotelid][Owner][Name]);

	foreach(new empresaid: Business)
	{
		Hotel[hotelid][Label][0] = CreateDynamic3DTextLabel(str, COR_BRANCO, Hotel[hotelid][Entrada][X], Hotel[hotelid][Entrada][Y], Hotel[hotelid][Entrada][Z], 15.0, .worldid=empresaid, .interiorid=0, .streamdistance=HOTEL_RENDER_STREAMER);		Hotel[hotelid][Label][1] = CreateDynamic3DTextLabel("Use a tecla {"COR_AMARELO_INC"}'F'{"COR_BRANCO_INC"} para sair do apartamento.", COR_BRANCO, Hotel[hotelid][Saida][X], Hotel[hotelid][Saida][Y], Hotel[hotelid][Saida][Z], 15.0, .worldid=hotelid, .interiorid=Hotel[hotelid][Interior], .streamdistance=HOTEL_RENDER_STREAMER);
		Hotel[hotelid][Pickup] = CreateDynamicPickup(GetHotelPickupId(hotelid), 23, Hotel[hotelid][Entrada][X], Hotel[hotelid][Entrada][Y], Hotel[hotelid][Entrada][Z], empresaid, 0, -1, HOTEL_RENDER_STREAMER);

		CreateDynamicActor(169, 1318.75, -1048.67, 3359.71, 176.51, .invulnerable=1, .health = 100.0, .worldid=empresaid, .interiorid=0, .streamdistance=50.0); //maria_eduarda
		CreateDynamic3DTextLabel("Maria_Eduarda", 0xFD811DFF, 1318.75, -1048.67, 3359.71+0.7, 15.0, .worldid=empresaid, .interiorid=0, .streamdistance=15.0);

		CreateDynamicActor(171, 1321.52, -1048.75, 3359.71, 178.954, .invulnerable=1, .health = 100.0, .worldid=empresaid, .interiorid=0, .streamdistance=50.0); //bruno_almeida
		CreateDynamic3DTextLabel("Bruno_Almeida", 0xFD811DFF, 1321.52, -1048.75, 3359.71+0.7, 15.0, .worldid=empresaid, .interiorid=0, .streamdistance=15.0);
	}
	return true;
}

stock UpdateLabelHotel(hotelid)
{
	if(!IsValidHotel(hotelid))
		return 0;

	new str[236];
	format(str, sizeof(str), "Hotel\nN°: {"COR_AMARELO_INC"}%d{"COR_BRANCO_INC"}\nAlugado por: {"COR_AZUL_INC"}%s", Hotel[hotelid][ID], Hotel[hotelid][Owner][Name]);

	UpdateDynamic3DTextLabelText(Hotel[hotelid][Label][0], COR_BRANCO, str);
	DestroyDynamicPickup(Hotel[hotelid][Pickup]);

	Hotel[hotelid][Pickup] = CreateDynamicPickup(GetHotelPickupId(hotelid), 23, Hotel[hotelid][Entrada][X], Hotel[hotelid][Entrada][Y], Hotel[hotelid][Entrada][Z], 0, Hotel[hotelid][Interior], -1, HOTEL_RENDER_STREAMER);
	return true;
}

stock GetHotelIdInRange(playerid, Float:range=2.0)
{
	if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_CASA )
		return GetPlayerVirtualWorld(playerid);

	foreach(new hotelid: Hotel)
	{
		if(IsPlayerInRangeOfPoint(playerid, range, Hotel[hotelid][Entrada][X], Hotel[hotelid][Entrada][Y], Hotel[hotelid][Entrada][Z]))
			return hotelid;
	}
	return INVALID_HOTEL_ID;
}

// ============================== [ hooks & callbacks ] ============================== //

#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	print("» Carregando hoteis...\n");

	new Cache:cache = mysql_query(getConexao(), "SELECT h.*, u.username as proprietario FROM "TABLE_HOTEIS" as h LEFT JOIN "TABLE_USERS" as u ON u.id = h.proprietario_id WHERE 1;", true), rows = cache_num_rows();
	if(rows)
	{
		for(new hotelid; hotelid < rows; hotelid++)
		{
			if(hotelid >= MAX_HOTEL){
				rows = MAX_HOTEL;
				print("Sistema de Hoteis chegou ao seu limite de "#MAX_HOTEL#" Hotel carregadas.");
				break;
			}

			Iter_Add(Hotel, hotelid);

			cache_get_value_name_int(hotelid, "id", Hotel[hotelid][ID]);

			new bool:owner_is_null;
			cache_is_value_name_null(hotelid, "proprietario", owner_is_null);
			if ( owner_is_null )
			{
				format(Hotel[hotelid][Owner][Name], MAX_PLAYER_NAME, "Ninguem");
				Hotel[hotelid][Owner][Id] = 0;
			}
			else{
				cache_get_value_name(hotelid, "proprietario", Hotel[hotelid][Owner][Name], MAX_PLAYER_NAME);
				cache_get_value_name_int(hotelid, "proprietario_id", Hotel[hotelid][Owner][Id]);
			}

			cache_get_value_name_float(hotelid, "entrada_x", Hotel[hotelid][Entrada][X]);
			cache_get_value_name_float(hotelid, "entrada_y", Hotel[hotelid][Entrada][Y]);
			cache_get_value_name_float(hotelid, "entrada_z", Hotel[hotelid][Entrada][Z]);
			cache_get_value_name_float(hotelid, "entrada_a", Hotel[hotelid][Entrada][A]);

			new rowid;
			cache_get_value_name_int(hotelid, "interior", rowid);
			Hotel[hotelid][InteriorID] = GetInteriorIdByRow(rowid);
			GetHouseInteriorInfo(Hotel[hotelid][InteriorID], Hotel[hotelid][Saida][X], Hotel[hotelid][Saida][Y], Hotel[hotelid][Saida][Z], Hotel[hotelid][Saida][A], Hotel[hotelid][Interior]);

			cache_get_value_name_int(hotelid, "interior", Hotel[hotelid][Interior]);
			cache_get_value_name_int(hotelid, "trancado", Hotel[hotelid][Trancado]);

			cache_get_value_name_int(hotelid, "valor", Hotel[hotelid][Valor]);
			cache_get_value_name_int(hotelid, "impostos", Hotel[hotelid][Impostos]);

			DynamicLabel(hotelid);
		}
		printf("\t- Total de %d hoteis carregadas.\n", Iter_Count(Hotel));
	}
	else
		print("\t- Nenhum hotel carregado.\n");


	cache_delete(cache);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_SECONDARY_ATTACK))
	{
		foreach(new hotelid: Hotel)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.0, Hotel[hotelid][Entrada][X], Hotel[hotelid][Entrada][Y], Hotel[hotelid][Entrada][Z]))
			{
				if(Hotel[hotelid][Trancado])
					return GameTextForPlayer(playerid, "~r~TRANCADO!", 2500, 4);

				new businessid = GetPlayerVirtualWorld(playerid);
				BusID[playerid] = businessid;
				
				Teleport(
					playerid,
					Hotel[hotelid][Saida][X],
					Hotel[hotelid][Saida][Y],
					Hotel[hotelid][Saida][Z],
					Hotel[hotelid][Saida][A],
					Hotel[hotelid][Interior],
					hotelid,
					ENTROU_CASA
				);
				return Y_HOOKS_BREAK_RETURN_1;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 2.0, Hotel[hotelid][Saida][X], Hotel[hotelid][Saida][Y], Hotel[hotelid][Saida][Z]) && GetPlayerVirtualWorld(playerid) == hotelid)
			{
				Teleport(
					playerid,
					Hotel[hotelid][Entrada][X],
					Hotel[hotelid][Entrada][Y],
					Hotel[hotelid][Entrada][Z],
					Hotel[hotelid][Entrada][A],
					0,
					BusID[playerid],
					ENTROU_EMPRESA
				);
				return Y_HOOKS_BREAK_RETURN_1;
			}
		}
		return Y_HOOKS_CONTINUE_RETURN_1;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}