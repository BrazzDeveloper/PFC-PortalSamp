/**
 *
 *	Interiores for houses
 *
 */



/**
 *
 *	Include
 *
 */
 #include <YSI_Coding\y_hooks>


/**
 *
 *	Variables and Definitions
 *
 */

 // please check in database TABLE_HOUSES_INTERIORS
#define MAX_INT_HOUSES 			(25)


enum e_INTERIOR_HOUSE
{
	ID,
	Float:Pos[e_POSITION],
	Interior,
	Valor,
	Level,
	Slots
}
static InteriorHouse[MAX_INT_HOUSES][e_INTERIOR_HOUSE];

/**
 *
 *	Callbacks
 *
 */

hook OnGameModeInit()
{
	print("» Carregando interiores das casas.");

	new Cache:c = mysql_query(getConexao(), "SELECT * FROM "TABLE_HOUSES_INTERIORS";", true), rows = cache_num_rows();

	if ( rows )
	{
		for(new i; i < rows; i++)
		{
			if ( i >= MAX_INT_HOUSES )
			{
				print("» não foi possível carregar todos os interiores pós o limite foi ultrapassado.");
				break;
			}

			cache_get_value_name_int(i, "id", InteriorHouse[i][ID]);

			cache_get_value_name_float(i, "x", InteriorHouse[i][Pos][X]);
			cache_get_value_name_float(i, "y", InteriorHouse[i][Pos][Y]);
			cache_get_value_name_float(i, "z", InteriorHouse[i][Pos][Z]);
			cache_get_value_name_float(i, "a", InteriorHouse[i][Pos][A]);
			cache_get_value_name_int(i, "interior", InteriorHouse[i][Interior]);
			
			cache_get_value_name_int(i, "valor", InteriorHouse[i][Valor]);
			cache_get_value_name_int(i, "level", InteriorHouse[i][Level]);
			cache_get_value_name_int(i, "slots", InteriorHouse[i][Slots]);
		}
		printf("\t- Foram encontrados %d interiores das casas.\n", rows);
	}
	cache_delete(c);
	return true;
}

/**
 *
 *	Function
 *
 */
stock IsValidInterior(interiorid)
{
	if ( interiorid < 0 || interiorid > sizeof(InteriorHouse) )
		return false;

	return true;
}

stock GetHouseInteriorInfo(interiorid, &Float:x, &Float:y, &Float:z, &Float:a, &interior)
{
	if ( !IsValidInterior(interiorid) )
		return false;
		
	x = InteriorHouse[interiorid][Pos][X];
	y = InteriorHouse[interiorid][Pos][Y];
	z = InteriorHouse[interiorid][Pos][Z];
	a = InteriorHouse[interiorid][Pos][A];
	interior = InteriorHouse[interiorid][Interior];
	return true;
}

stock GetInteriorIdByRow(rowid)
{
	for(new i, size = sizeof(InteriorHouse); i < size; i++)
	{
		if ( InteriorHouse[i][ID] == rowid )
			return i;
	}
	return 0;
}

stock GetInteriorSlots(interiorid)
{
	if ( !IsValidInterior(interiorid) )
		return 0;

	return InteriorHouse[interiorid][Slots];
}

stock GetInteriorValue(interiorid)
{
	if ( !IsValidInterior(interiorid) )
		return 0;

	return InteriorHouse[interiorid][Valor];
}