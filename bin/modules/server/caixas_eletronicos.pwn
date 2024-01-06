

#include <YSI_Coding\y_hooks>



static const CAIXA_OBJECT = 2942;


static 
	bool:InCreateCaixa[MAX_PLAYERS], ObjectCreatedID[MAX_PLAYERS];

// ============================== [ HOOKs ] ============================== //
hook OnGameModeInit()
{
	new Cache:cache = mysql_query(getConexao(), "SELECT * FROM "TABLE_CAIXA_ELETRONICO";"), rows = cache_num_rows();
	if ( rows )
	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "id", Caixa[i][ID]);
			cache_get_value_name_int(i, "valor", Caixa[i][Valor]);

			cache_get_value_name_float(i, "x", Caixa[i][Pos][X]);
			cache_get_value_name_float(i, "y", Caixa[i][Pos][Y]);
			cache_get_value_name_float(i, "z", Caixa[i][Pos][Z]);
			cache_get_value_name_float(i, "a", Caixa[i][Pos][A]);

			cache_get_value_name_int(i, "world", Caixa[i][World]);
			cache_get_value_name_int(i, "interior", Caixa[i][Interior]);

			call::CAIXA->render(i);
			Iter_Add(Caixa, i);
		}
	}
	cache_delete(cache);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid)
{
	InCreateCaixa[playerid] = false;
	ObjectCreatedID[playerid] = 0;
}

hook OnPlayerEditObject( playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ )
{

	if ( InCreateCaixa[playerid] )
	{
		if ( response == EDIT_RESPONSE_FINAL )
		{
			for(new i; i < sizeof(Caixa); i++)
			{
				if ( !Iter_Contains(Caixa, i) )
				{
					new query[512];
					mysql_format(getConexao(), query, sizeof(query), "INSERT INTO "TABLE_CAIXA_ELETRONICO" (x,y,z,a,world,interior)VALUES('%.3f','%.3f','%.3f','%.3f','%d','%d');", fX, fY, fZ, fRotZ, Caixa[i][World], Caixa[i][Interior]);
					
					if ( !mysql_tquery(getConexao(), query, "OnCreateCaixa", "d", playerid) )
						SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foi possivel criar o caixa eletrônico, verifique os logs do mysql.");

					return Y_HOOKS_BREAK_RETURN_1;
				}
			}
		}
		else if ( response == EDIT_RESPONSE_CANCEL )
		{
			DestroyPlayerObject(playerid, ObjectCreatedID[playerid]);
			return true;
		}
		return Y_HOOKS_BREAK_RETURN_1;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}


forward OnCreateCaixa(playerid);
public OnCreateCaixa(playerid)
{
	new id = cache_insert_id();

	if ( id < 1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foi possivel criar o caixa eletrônico, verifique os logs do mysql.");

	new query[128];
	mysql_format(getConexao(), query, sizeof(query), "SELECT * FROM "TABLE_CAIXA_ELETRONICO" WHERE `id`='%d'", id);
	new Cache:cache = mysql_query(getConexao(), query, true), rows = cache_num_rows();

	if ( rows )
	{
		for(new i; i < sizeof(Caixa); i++)
		{
			if ( !Iter_Contains(Caixa, i) )
			{
				cache_get_value_name_int(0, "id", Caixa[i][ID]);
				cache_get_value_name_int(0, "valor", Caixa[i][Valor]);

				cache_get_value_name_float(0, "x", Caixa[i][Pos][X]);
				cache_get_value_name_float(0, "y", Caixa[i][Pos][Y]);
				cache_get_value_name_float(0, "z", Caixa[i][Pos][Z]);
				cache_get_value_name_float(0, "a", Caixa[i][Pos][A]);

				cache_get_value_name_int(0, "world", Caixa[i][World]);
				cache_get_value_name_int(0, "interior", Caixa[i][Interior]);

				DestroyDynamicObject(Caixa[i][ObjectID]);
				call::CAIXA->render(i);

				Iter_Add(Caixa, i);
				DestroyPlayerObject(playerid, ObjectCreatedID[playerid]);

				InCreateCaixa[playerid]=false;
				ObjectCreatedID[playerid]=0;
				cache_delete(cache);

				SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Caixa eletrônico criado com sucesso.");
				return true;
			}
		}
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foi possivel criar o radar, o limite foi ultrapassado.");
	}
	cache_delete(cache);
	return true;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if ( PRESSED(KEY_YES) && !IsPlayerInAnyVehicle(playerid))
	{
		foreach(new i: Caixa)
		{
			if ( IsPlayerInRangeOfPoint(playerid, 2.1, Caixa[i][Pos][X], Caixa[i][Pos][Y], Caixa[i][Pos][Z]) )
			{
				if ( !call::BANK->IsPlayerAccountOpenned(playerid) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa abrir uma conta no banco antes de utilizar os caixas eletrônicos.");

				call::BANK->ShowPlayerCaixaMenu(playerid);
				return Y_HOOKS_BREAK_RETURN_1;
			}
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}
// ============================== [ CMDs ] ============================== //

flags:criarcaixa(ADMINISTRADOR);
CMD:criarcaixa(playerid, params[])
{
	for(new i; i < sizeof(Caixa); i++)
	{
		if ( !Iter_Contains(Caixa, i) )
		{
			GetPlayerPos(playerid, Caixa[i][Pos][X], Caixa[i][Pos][Y], Caixa[i][Pos][Z]);
			GetPlayerFacingAngle(playerid, Caixa[i][Pos][A]);
			Caixa[i][Interior] = GetPlayerInterior(playerid);
			Caixa[i][World]  = GetPlayerVirtualWorld(playerid);

			ObjectCreatedID[playerid] = CreatePlayerObject(playerid, CAIXA_OBJECT, Caixa[i][Pos][X], Caixa[i][Pos][Y], Caixa[i][Pos][Z], 0.0, 0.0, Caixa[i][Pos][A]);
			EditPlayerObject(playerid, ObjectCreatedID[playerid]);

			InCreateCaixa[playerid] = true;
			return true;
		}
	}
	return true;
}

// ============================== [ FUNCTIONs ] ============================== //
static function CAIXA::render(i)
{
	new _format[256];

	format(_format, sizeof(_format), "Caixa Eletrônico ({ffffff}%d{"COR_AMARELO_INC"})\n{"COR_BRANCO_INC"}Use '{"COR_AMARELO_INC"}Y{"COR_BRANCO_INC"}' para abrir o menu do caixa.", Caixa[i][ID]);
	Caixa[i][ObjectID] = CreateDynamicObject(CAIXA_OBJECT, Caixa[i][Pos][X], Caixa[i][Pos][Y], Caixa[i][Pos][Z], 0.0, 0.0, Caixa[i][Pos][A], .worldid=Caixa[i][World], .interiorid=Caixa[i][Interior], .streamdistance=30.0);
	//Caixa[i][Label] = CreateDynamic3DTextLabel("Caixa Eletrônico (%s)\n{"COR_BRANCO_INC"}Use '{"COR_AMARELO_INC"}Y{"COR_BRANCO_INC"}' para abrir o menu do caixa.", COR_AMARELO, Caixa[i][Pos][X], Caixa[i][Pos][Y], Caixa[i][Pos][Z], 8.0, .streamdistance=12.0, .worldid=Caixa[i][World], .interiorid=Caixa[i][Interior]);
	Caixa[i][Label] = CreateDynamic3DTextLabel(_format, COR_AMARELO, Caixa[i][Pos][X], Caixa[i][Pos][Y], Caixa[i][Pos][Z], 8.0, .streamdistance=12.0, .worldid=Caixa[i][World], .interiorid=Caixa[i][Interior]);
	return true;
}