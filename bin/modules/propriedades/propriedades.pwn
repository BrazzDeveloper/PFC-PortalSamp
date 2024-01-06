// aaaa


/*			functions 			*/

function PROPERTY::render(propriedadeid)
{
	Propriedade[propriedadeid][Pickup] = CreateDynamicPickup(1239, 23, Propriedade[propriedadeid][Entrada][X], Propriedade[propriedadeid][Entrada][Y], Propriedade[propriedadeid][Entrada][Z], 0, 0, -1, PROPERTY_RENDER_STREAMER);
	
	new str[255];
	format(str, sizeof(str), PROPERTY_STRING_RENDER, PROPERTY_VAR_RENDER);
	Propriedade[propriedadeid][Label] = CreateDynamic3DTextLabel(str, COR_BRANCO, Propriedade[propriedadeid][Entrada][X], Propriedade[propriedadeid][Entrada][Y], Propriedade[propriedadeid][Entrada][Z] + 0.3, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, PROPERTY_RENDER_STREAMER);
	CreateDynamic3DTextLabel("Aperte '{"COR_AMARELO_INC"}F{"COR_BRANCO_INC"}' para sair.", COR_BRANCO, Propriedade[propriedadeid][Saida][X], Propriedade[propriedadeid][Saida][Y], Propriedade[propriedadeid][Saida][Z] + 0.3, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, propriedadeid, Propriedade[propriedadeid][Interior], -1, PROPERTY_RENDER_STREAMER);
	Propriedade[propriedadeid][Map] = CreateDynamicMapIcon(Propriedade[propriedadeid][Entrada][X], Propriedade[propriedadeid][Entrada][Y], Propriedade[propriedadeid][Entrada][Z], Propriedade[propriedadeid][MapIcon], COR_BRANCO, 0, 0, -1, PROPERTY_RENDER_STREAMER, MAPICON_LOCAL);
	return true;
}

function PROPERTY::GetPropertyName(propriedadeid)
{
	new name[MAX_PROPERTY_NAME];
	if(!call::PROPERTY->IsValidProperty(propriedadeid))
		return name;


	format(name, sizeof(name), Propriedade[propriedadeid][Nome]);
	return name;
}

function PROPERTY::GetPropertyPos(propriedadeid, &Float:x, &Float:y, &Float:z)
{
	if(!call::PROPERTY->IsValidProperty(propriedadeid))
		return false;

	x = Propriedade[propriedadeid][Entrada][X];
	y = Propriedade[propriedadeid][Entrada][Y];
	z = Propriedade[propriedadeid][Entrada][Z];
	
	return true;
}

function PROPERTY::IsValidProperty(propriedadeid){
	if(propriedadeid > MAX_PROPERTY || propriedadeid < 0)
		return false;

	return (Iter_Contains(Propriedades, propriedadeid) && !isnull(Propriedade[propriedadeid][Nome]));
}

/*function PROPERTY::GetPropertyLocalName(propriedadeid)
{
	new localName[MAX_ZONE_NAME];

	if(!call::PROPERTY->IsValidProperty(propriedadeid))
		return localName;

	GetLocalName(Propriedade[propriedadeid][Entrada][X], Propriedade[propriedadeid][Entrada][Y], localName, sizeof(localName));
	return localName;
}*/

/*			callbacks 				*/


#include <YSI_Coding\y_hooks>
hook OnGameModeInit()
{
	print("» Carregando propriedades públicas.\n");

	new Cache:cache = mysql_query(getConexao(), "SELECT * FROM "TABLE_PROPERTY"", true);
	
	if(cache_num_rows())
	{
		for(new i=0, rows = cache_num_rows(); i < rows; i++)
		{
			cache_get_value_name_int(i, "id", Propriedade[i][ID]);

			cache_get_value_name(i, "nome", Propriedade[i][Nome], MAX_PROPERTY_NAME);

			cache_get_value_name_float(i, "entrada_x", Propriedade[i][Entrada][X]);
			cache_get_value_name_float(i, "entrada_y", Propriedade[i][Entrada][Y]);
			cache_get_value_name_float(i, "entrada_z", Propriedade[i][Entrada][Z]);
			cache_get_value_name_float(i, "entrada_a", Propriedade[i][Entrada][A]);

			cache_get_value_name_float(i, "saida_x", Propriedade[i][Saida][X]);
			cache_get_value_name_float(i, "saida_y", Propriedade[i][Saida][Y]);
			cache_get_value_name_float(i, "saida_z", Propriedade[i][Saida][Z]);
			cache_get_value_name_float(i, "saida_a", Propriedade[i][Saida][A]);

			cache_get_value_name_int(i, "interior", Propriedade[i][Interior]);
			cache_get_value_name_int(i, "mapicon", Propriedade[i][MapIcon]);

			Iter_Add(Propriedades, i);
			call::PROPERTY->render(i);
		}
		printf("\t- Total de %d Propriedades criada(s).\n", cache_num_rows());
		return true;
	}
	else
		print("\tWarning: Nenhuma propriedade foi criada.\n");

	cache_delete(cache);
	return true;
}


hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_SECONDARY_ATTACK)) // Ao pressionar a tecla 'F'
	{
		foreach(new propriedadeid: Propriedades)
		{
			if(strcmp(Propriedade[propriedadeid][Nome], "Hospital de Los Santos", true) == 0 && isnull(Propriedade[propriedadeid][Nome]))
				continue;

			if(IsPlayerInRangeOfPoint(playerid, 2.0, Propriedade[propriedadeid][Entrada][X], Propriedade[propriedadeid][Entrada][Y], Propriedade[propriedadeid][Entrada][Z]) && GetPlayerVirtualWorld(playerid) == 0)
			{
				Teleport(
					playerid,
					Propriedade[propriedadeid][Saida][X],
					Propriedade[propriedadeid][Saida][Y],
					Propriedade[propriedadeid][Saida][Z],
					Propriedade[propriedadeid][Saida][A],
					Propriedade[propriedadeid][Interior],
					propriedadeid,
					ENTROU_PROPRIEDADE
				);

				FreezePlayer(playerid, 2);
				SetCameraBehindPlayer(playerid);
				return Y_HOOKS_BREAK_RETURN_1;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 2.0, Propriedade[propriedadeid][Saida][X], Propriedade[propriedadeid][Saida][Y], Propriedade[propriedadeid][Saida][Z]) && GetPlayerVirtualWorld(playerid) == propriedadeid)
			{
				SetPlayerPos(playerid, Propriedade[propriedadeid][Entrada][X], Propriedade[propriedadeid][Entrada][Y], Propriedade[propriedadeid][Entrada][Z]);
				SetPlayerFacingAngle(playerid, Propriedade[propriedadeid][Entrada][A]);
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);

				Teleport(
					playerid,
					Propriedade[propriedadeid][Entrada][X],
					Propriedade[propriedadeid][Entrada][Y],
					Propriedade[propriedadeid][Entrada][Z],
					Propriedade[propriedadeid][Entrada][A],
					0,
					0,
					ENTROU_NONE
				);

				return Y_HOOKS_BREAK_RETURN_1;
			}
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}