// ============================== [ include ] ============================== //
#include "../bin/modules/casas/cmds.pwn"
#include "../bin/modules/casas/dialogs.pwn"
#include "../bin/modules/casas/gerenciar.pwn"
#include "../bin/modules/casas/interiores.pwn"
#include "../bin/modules/casas/garagem.pwn"

// ============================== [ functions ] ============================== //
const HOUSE_LENG_RENDER_VAR = 512;

stock static function HOUSE::render_string(casaid)
{
	new _str[HOUSE_LENG_RENDER_VAR];
	if ( Casa[casaid][IsCash] ){
		//format(_str, sizeof(_str),
		//	"Casa\nProprietário: {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"}\nEnd.: {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"}, N°: {"COR_AZUL_INC"}%d{"COR_BRANCO_INC"}\nValor BitCoins: {DAA520}%d{"COR_BRANCO_INC"}\nMoradores: {"COR_AZUL_INC"}%d/%d{"COR_BRANCO_INC"}\nAluguel: %s",
		//	Casa[casaid][Owner][Name], call::HOUSE->GetHouseLocalName(casaid), casaid, Casa[casaid][Valor], call::HOUSE->CountMoradores(casaid), GetInteriorSlots(Casa[casaid][InteriorID]), (Casa[casaid][Alugavel] ? ("{"COR_VERDE_INC"}Ativado") : ("{"COR_VERMELHO_INC"}Desativado")) );
	
		format(_str, sizeof(_str),
			"{ffffff}Casa\n%s\n{ffffff}» Proprietário(a): {"COR_VERDE_CLARO_INC"}%s\n{ffffff}» Endereço: {"COR_VERDE_CLARO_INC"}%s{ffffff}, Nº: {"COR_VERDE_CLARO_INC"}%d\n{ffffff}» BitCoins: {"COR_VERDE_CLARO_INC"}R$%s",
			Casa[casaid][Mensagem], Casa[casaid][Owner][Name], call::HOUSE->GetHouseLocalName(casaid), casaid, RealStr(Casa[casaid][Valor]));
	}
	else{
		//format(_str, sizeof(_str),
		//	"Casa\nProprietário: {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"}\nEnd.: {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"}, N°: {"COR_AZUL_INC"}%d{"COR_BRANCO_INC"}\nValor: {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}\nMoradores: {"COR_AZUL_INC"}%d/%d{"COR_BRANCO_INC"}\nAluguel: %s",
		//	Casa[casaid][Owner][Name], call::HOUSE->GetHouseLocalName(casaid), casaid, RealStr(Casa[casaid][Valor]), call::HOUSE->CountMoradores(casaid), GetInteriorSlots(Casa[casaid][InteriorID]), (Casa[casaid][Alugavel] ? ("{"COR_VERDE_INC"}Ativado") : ("{"COR_VERMELHO_INC"}Desativado")) );
		format(_str, sizeof(_str),
			"{ffffff}Casa\n%s\n{ffffff}» Proprietário(a): {"COR_VERDE_CLARO_INC"}%s\n{ffffff}» Endereço: {"COR_VERDE_CLARO_INC"}%s{ffffff}, Nº: {"COR_VERDE_CLARO_INC"}%d\n{ffffff}» Valor: {"COR_VERDE_CLARO_INC"}R$%s",
			Casa[casaid][Mensagem], Casa[casaid][Owner][Name], call::HOUSE->GetHouseLocalName(casaid), casaid, RealStr(Casa[casaid][Valor]));
	}
	return _str;
}

stock GetHouseTableValue(casaid, const colunm[], value[], len = sizeof(value))
{
	if ( !call::HOUSE->IsValidHouse(casaid) )
		return false;

	new query[128];
	mysql_format(getConexao(), query, sizeof(query), "SELECT %e FROM "TABLE_HOUSES" WHERE `id`='%d' LIMIT 1;", colunm, Casa[casaid][ID]);
	new Cache:c = mysql_query(getConexao(), query, true);
	
	if ( cache_num_rows() )
		cache_get_value_name(0, colunm, value, len);	

	cache_delete(c);
	return true;
}

stock GetHouseTableValueInt(casaid, const colunm[])
{
	if ( !call::HOUSE->IsValidHouse(casaid) )
		return false;

	new value[11];
	GetHouseTableValue(casaid, colunm, value, sizeof(value));
	return strval(value);
}

function HOUSE::CountMoradores(casaid)
{
	new query[255], ammount;
	mysql_format(getConexao(), query, sizeof(query), "SELECT count(id) as moradores FROM "TABLE_USERS" WHERE `morador_casa_id`='%d' LIMIT %d;", Casa[casaid][ID], GetInteriorSlots(Casa[casaid][InteriorID]));
	new Cache:cache_id = mysql_query(getConexao(), query);
	cache_get_value_name_int(0, "moradores", ammount);
	cache_delete(cache_id);
	return ammount;
}

function HOUSE::MoradorNome(casaid)
{
	new query[255], nomemorador[MAX_PLAYER_NAME + 5];
	mysql_format(getConexao(), query, sizeof(query), "SELECT username as morador FROM "TABLE_USERS" where `morador_casa_id`='%d' LIMIT 1;", Casa[casaid][ID]);
	new Cache:cache_id = mysql_query(getConexao(), query);
	cache_get_value_name(0, "morador", nomemorador);
	cache_delete(cache_id);
	return nomemorador;
}

function HOUSE::ShowPlayerBuyHouse(playerid, casaid)
{
	if(!call::HOUSE->IsValidHouse(casaid))
		return false;

	new valor = call::HOUSE->GetHouseParamInt(casaid, Valor);
	ShowPlayerDialog(playerid, BUY_HOUSE, DIALOG_STYLE_MSGBOX, "{"COR_DISABLE_INC"}CASA » {"COR_BRANCO_INC"}COMPRAR", "{"COR_BRANCO_INC"}Você deseja adquirir está casa por {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"} em %s.\n\nFique Ciente que caso deseje vender/liberar a casa, você só terá o retorno de {"COR_AZUL_INC"}50%%{"COR_BRANCO_INC"} do valor gasto.", "Comprar", "Cancelar", RealStr(valor), (Casa[casaid][IsCash] ? ("{"COR_LARANJA_INC"}BitCoins{"COR_BRANCO_INC"}"):("Dinheiro")) );
	return true;
}

ShowPlayerMenuHouse(playerid, casaid)
{
	if(!call::HOUSE->IsValidHouse(casaid))
		return false;

	ShowPlayerDialog(playerid, MENU_HOUSE, DIALOG_STYLE_TABLIST, "{"COR_DISABLE_INC"}CASA » {"COR_BRANCO_INC"}MENU", 
		"Expulsar Morador\t{"COR_AZUL_INC"}%d/%d\n\
		Porta\t%s\n\
		Alugar Casa\t{"COR_VERDE_INC"}R$%s\n\
		Alterar Mensagem\n\
		Atualizar Interior\n\
		Vender Casa", 
	"Selecionar", "Fechar", call::HOUSE->CountMoradores(casaid), GetInteriorSlots(Casa[casaid][InteriorID]), (call::HOUSE->GetHouseParamInt(casaid, Trancado) ? ("{00FF00}trancada"):("{FF0000}destrancada")),  RealStr(call::HOUSE->GetHouseParamInt(casaid, Aluguel)) );
	return true;
}


stock GetHousePickupId(casaid)
{
	if ( !call::HOUSE->IsValidHouse(casaid) )
		return 0;
	
	if ( Casa[casaid][ValorVenda] != 0 )
		return PH_OCCUPIED_VEDING;

	if ( Casa[casaid][IsCash] ){
		
		if ( !Casa[casaid][Owner][Id] )
			return PH_BTC_OCCUPIED;

		return PH_BTC_NON_OCCUPIED;
	}
	else{
		
		if ( !Casa[casaid][Owner][Id] )
			return PH_NON_OCCUPIED;

		return PH_OCCUPIED;
	}
}

stock UpdateHouseLabel(casaid)
{
	if( !call::HOUSE->IsValidHouse(casaid) )return 0;
	
	UpdateDynamic3DTextLabelText(Casa[casaid][Label][0], COR_BRANCO, call::HOUSE->render_string(casaid));
	
	DestroyDynamicPickup(Casa[casaid][Pickup]);
	Casa[casaid][Pickup] = CreateDynamicPickup(GetHousePickupId(casaid), 23, Casa[casaid][Entrada][X], Casa[casaid][Entrada][Y], Casa[casaid][Entrada][Z], 0, 0, -1, HOUSE_RENDER_STREAMER);
	
	DestroyDynamicMapIcon(Casa[casaid][Map]);
	CreateDynamicMapIcon(Casa[casaid][Entrada][X], Casa[casaid][Entrada][Y], Casa[casaid][Entrada][Z], RETURN_MAPICON_HOUSE(casaid), COR_BRANCO, 0, 0, -1, HOUSE_RENDER_STREAMER, MAPICON_LOCAL);

	RenderGaragem(casaid);
	return true;
}

function HOUSE::DestroyHouse(casaid)
{
	if( !call::HOUSE->IsValidHouse(casaid) )
		return false;

	DestroyDynamicPickup(Casa[casaid][Pickup]);
	DestroyDynamicMapIcon(Casa[casaid][Map]);
	DestroyDynamic3DTextLabel(Casa[casaid][Label][0]);
	DestroyDynamic3DTextLabel(Casa[casaid][Label][1]);

	new resetH[e_HOUSE_INFO];
	Casa[casaid] = resetH;
	return true;
}

function HOUSE::SetHouseParam(casaid, e_HOUSE_INFO:param, value[], len = sizeof(value))
{
	if(!call::HOUSE->IsValidHouse(casaid))
		return false;

	format(Casa[casaid][param], len, value);
	return true;
}

function HOUSE::SetHouseParamInt(casaid, e_HOUSE_INFO:param, value)
{
	if(!call::HOUSE->IsValidHouse(casaid))
		return false;

	Casa[casaid][param] = value;
	return true;
}
function HOUSE::GetHouseParamInt(casaid, e_HOUSE_INFO:param)
{
	if(!call::HOUSE->IsValidHouse(casaid))
		return false;

	return Casa[casaid][param];
}

function HOUSE::IsValidHouse(houseid)
{
	if(houseid < 0 || houseid > sizeof(Casa))
		return false;

	return (Iter_Contains(Casas, houseid) );
}
function HOUSE::GetHouseLocalName(casaid)
{
	new endereco[MAX_ZONE_NAME];
	if(!call::HOUSE->IsValidHouse(casaid))
		return endereco;

	GetLocalName(Casa[casaid][Entrada][X], Casa[casaid][Entrada][Y], endereco, sizeof(endereco));
	return endereco;
}

function HOUSE::GetHousePos(casaid, &Float:x, &Float:y, &Float:z)
{
	if(!call::HOUSE->IsValidHouse(casaid))
		return false;

	x = Casa[casaid][Entrada][X];
	y = Casa[casaid][Entrada][Y];
	z = Casa[casaid][Entrada][Z];
	return true;
}

stock ShowPlayerInfoHouse(playerid)
{
	new casaid = call::HOUSE->GetHouseIdInRange(playerid, 2.0);

	if( !call::HOUSE->IsValidHouse(casaid) )
		return false;

	new str[1024], query[255];
	format(str, sizeof(str), "{"COR_BRANCO_INC"}» Proprietario: {"COR_AMARELO_INC"}%s{"COR_BRANCO_INC"}\n\n» End.: {"COR_SISTEMA_INC"}%s{"COR_BRANCO_INC"}, N° {"COR_SISTEMA_INC"}%d{"COR_BRANCO_INC"}\n» Level: {"COR_VERMELHO_INC"}%d{"COR_BRANCO_INC"}\n» Valor: {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}\n» Aluguel: %s\n» Valor Aluguel: {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}\n» Mensagem: {"COR_AMARELO_INC"}%s{"COR_BRANCO_INC"}\n\n» Moradores:\n", Casa[casaid][Owner][Name], call::HOUSE->GetHouseLocalName(casaid), casaid, Casa[casaid][Level], RealStr(Casa[casaid][Valor]), (Casa[casaid][Aluguel] ? ("{"COR_VERDE_INC"}Ativado{"COR_BRANCO_INC"}"):("{"COR_VERMELHO_INC"}Desativado{"COR_BRANCO_INC"}")), RealStr(call::HOUSE->GetHouseParamInt(casaid, Aluguel)), Casa[casaid][Mensagem]);

	mysql_format(getConexao(), query, sizeof(query), "SELECT id, username FROM "TABLE_USERS" WHERE `morador_casa_id`='%d' LIMIT %d;", Casa[casaid][ID], GetInteriorSlots(Casa[casaid][InteriorID]));
	new Cache:cache_id = mysql_query(getConexao(), query, true), rows = cache_num_rows();
	
	if ( rows )
	{
		new id, username[MAX_PLAYER_NAME];
		for(new i; i < rows; i++){
			cache_get_value_name_int(i, "id", id);
			cache_get_value_name(i, "username", username, MAX_PLAYER_NAME);
			format(str, sizeof(str), "%s{"COR_SISTEMA_INC"}%d{"COR_BRANCO_INC"}. {"COR_LARANJA_INC"}%s{"COR_BRANCO_INC"}\n", str, i + 1, username);
		}
		
	}
	else{
		format(str, sizeof(str), "%sNão tem moradores nessa casa.\n", str);
	}
	cache_delete(cache_id);

	if( Jogador[playerid][PlayerID] == Casa[casaid][Owner][Id] )
	{
		format(str, sizeof(str), "%s\n» Cofre: {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}\n» Impostos: {"COR_VERMELHO_INC"}%d{"COR_BRANCO_INC"}", str, RealStr(Casa[casaid][Cofre]), Casa[casaid][Impostos]);
	}
	ShowPlayerDialog(playerid, HOUSE_INFO, DIALOG_STYLE_MSGBOX, "{"COR_DISABLE_INC"}CASA » {"COR_BRANCO_INC"}INFORMAÇÕES", str, "OK", "");
	return true;
}

function HOUSE::IsPlayerInHouse(playerid, Float:range=2.0)
{
	if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_CASA )
		return true;
		
	foreach(new casaid: Casas)
	{
		if(IsPlayerInRangeOfPoint(playerid, range, Casa[casaid][Entrada][X], Casa[casaid][Entrada][Y], Casa[casaid][Entrada][Z]))
			return true;
	}
	return false;
}


function HOUSE::GetHouseIdInRange(playerid, Float:range=2.0)
{
	if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_CASA )
		return GetPlayerVirtualWorld(playerid);

	foreach(new casaid: Casas)
	{
		if(IsPlayerInRangeOfPoint(playerid, range, Casa[casaid][Entrada][X], Casa[casaid][Entrada][Y], Casa[casaid][Entrada][Z]))
			return casaid;
	}
	return INVALID_HOUSE_ID;
}

function HOUSE::render(casaid)
{
	Casa[casaid][Pickup] = CreateDynamicPickup(GetHousePickupId(casaid), 23, Casa[casaid][Entrada][X], Casa[casaid][Entrada][Y], Casa[casaid][Entrada][Z], 0, 0, -1, HOUSE_RENDER_STREAMER);
	
	Casa[casaid][Label][0] = CreateDynamic3DTextLabel(call::HOUSE->render_string(casaid), COR_BRANCO, Casa[casaid][Entrada][X], Casa[casaid][Entrada][Y], Casa[casaid][Entrada][Z] + 0.3, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0, -1, HOUSE_RENDER_STREAMER);
	Casa[casaid][Label][1] = CreateDynamic3DTextLabel("Aperte '{"COR_AMARELO_INC"}F{"COR_BRANCO_INC"}' para sair.", COR_BRANCO, Casa[casaid][Saida][X], Casa[casaid][Saida][Y], Casa[casaid][Saida][Z] + 0.5, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, casaid, Casa[casaid][Interior], -1, HOUSE_RENDER_STREAMER);
	Casa[casaid][Map] = CreateDynamicMapIcon(Casa[casaid][Entrada][X], Casa[casaid][Entrada][Y], Casa[casaid][Entrada][Z], RETURN_MAPICON_HOUSE(casaid), COR_BRANCO, 0, 0, -1, HOUSE_RENDER_STREAMER, MAPICON_LOCAL);
}

stock GetPlayerHouse(playerid)
{
	foreach(new i: Casas)
	{
		if ( Jogador[playerid][PlayerID] == Casa[i][Owner][Id] || Jogador[playerid][pMorador] == Casa[i][ID] )
		{
			return i;
		}
	}
	return INVALID_HOUSE_ID;
}

// ============================== [ hooks & callbacks ] ============================== //

#include <YSI_Coding\y_hooks>


hook OnGameModeInit()
{
	print("» Carregando Casas...");

	new Cache:cache = mysql_query(getConexao(), "SELECT c.*, g.*, u.username as proprietario FROM "TABLE_HOUSES" as c LEFT JOIN "TABLE_HOUSES_GARAGES" as g ON g.casaid = c.id LEFT JOIN "TABLE_USERS" as u ON u.id = c.proprietario_id WHERE 1;", true), rows = cache_num_rows();

	if(rows)
	{
		for(new casaid; casaid < rows; casaid++)
		{
			if ( casaid >= MAX_HOUSE )
			{
				print("[WARNING] O limite de casas foi atingido.");
				return 0;
			}

			Iter_Add(Casas, casaid);

			cache_get_value_name_int(casaid, "id", Casa[casaid][ID]);

			new bool:owner_is_null;
			cache_is_value_name_null(casaid, "proprietario", owner_is_null);
			if ( owner_is_null )
			{
				format(Casa[casaid][Owner][Name], MAX_PLAYER_NAME, "Ninguem");
				Casa[casaid][Owner][Id] = 0;
			}
			else{
				cache_get_value_name(casaid, "proprietario", Casa[casaid][Owner][Name], MAX_PLAYER_NAME);
				cache_get_value_name_int(casaid, "proprietario_id", Casa[casaid][Owner][Id]);
			}

			cache_get_value_name_float(casaid, "entrada_x", Casa[casaid][Entrada][X]);
			cache_get_value_name_float(casaid, "entrada_y", Casa[casaid][Entrada][Y]);
			cache_get_value_name_float(casaid, "entrada_z", Casa[casaid][Entrada][Z]);
			cache_get_value_name_float(casaid, "entrada_a", Casa[casaid][Entrada][A]);

			/**
			 *
			 *	Obter o interior da residência.
			 *
			 */
			new rowid;
			cache_get_value_name_int(casaid, "interior", rowid);
			Casa[casaid][InteriorID] = GetInteriorIdByRow(rowid);
			GetHouseInteriorInfo(Casa[casaid][InteriorID], Casa[casaid][Saida][X], Casa[casaid][Saida][Y], Casa[casaid][Saida][Z], Casa[casaid][Saida][A], Casa[casaid][Interior]);

			cache_get_value_name(casaid, "mensagem", Casa[casaid][Mensagem], MAX_HOUSE_MENSAGEM);

			cache_get_value_name_int(casaid, "valor", Casa[casaid][Valor]);
			cache_get_value_name_int(casaid, "level", Casa[casaid][Level]);
			cache_get_value_name_int(casaid, "trancado", Casa[casaid][Trancado]);

			cache_get_value_name_int(casaid, "valor_aluguel", Casa[casaid][Aluguel]);
			Casa[casaid][Alugavel] = (Casa[casaid][Aluguel] > 0 ? true : false);

			cache_get_value_name_int(casaid, "cofre", Casa[casaid][Cofre]);			

			cache_get_value_name_int(casaid, "impostos_pagos", Casa[casaid][ImpostosPagos]);

			cache_get_value_name_int(casaid, "is_cash", Casa[casaid][IsCash]);

			if ( !Casa[casaid][IsCash] )
			{
				cache_get_value_name_int(casaid, "impostos", Casa[casaid][Impostos]);
			}
			
			/**
			 *
			 *	@Carregar infomações da garagem
			 *
			 */
			new garagemID[20];
			cache_get_value_name(casaid, "garagemId", garagemID);
			Casa[casaid][Garagem][Id] = strval(garagemID);

			if ( Casa[casaid][Garagem][Id] )
			{
				cache_get_value_name_int(casaid, "garagemId", Casa[casaid][Garagem][Id]);

				cache_get_value_name_float(casaid, "vEntrada_x", Casa[casaid][Garagem][vEntrada][X]);
				cache_get_value_name_float(casaid, "vEntrada_y", Casa[casaid][Garagem][vEntrada][Y]);
				cache_get_value_name_float(casaid, "vEntrada_z", Casa[casaid][Garagem][vEntrada][Z]);
				cache_get_value_name_float(casaid, "vEntrada_a", Casa[casaid][Garagem][vEntrada][A]);

				cache_get_value_name_float(casaid, "vSaida_x", Casa[casaid][Garagem][vSaida][X]);
				cache_get_value_name_float(casaid, "vSaida_y", Casa[casaid][Garagem][vSaida][Y]);
				cache_get_value_name_float(casaid, "vSaida_z", Casa[casaid][Garagem][vSaida][Z]);
				cache_get_value_name_float(casaid, "vSaida_a", Casa[casaid][Garagem][vSaida][A]);

				cache_get_value_name_float(casaid, "pEntrada_x", Casa[casaid][Garagem][pEntrada][X]);
				cache_get_value_name_float(casaid, "pEntrada_y", Casa[casaid][Garagem][pEntrada][Y]);
				cache_get_value_name_float(casaid, "pEntrada_z", Casa[casaid][Garagem][pEntrada][Z]);
				cache_get_value_name_float(casaid, "pEntrada_a", Casa[casaid][Garagem][pEntrada][A]);

				cache_get_value_name_float(casaid, "pSaida_x", Casa[casaid][Garagem][pSaida][X]);
				cache_get_value_name_float(casaid, "pSaida_y", Casa[casaid][Garagem][pSaida][Y]);
				cache_get_value_name_float(casaid, "pSaida_z", Casa[casaid][Garagem][pSaida][Z]);
				cache_get_value_name_float(casaid, "pSaida_a", Casa[casaid][Garagem][pSaida][A]);

				cache_get_value_name_int(casaid, "garagem_trancada", Casa[casaid][Garagem][Trancado]);

				Iter_Add(Garagens, casaid);
				RenderGaragem(casaid);
			}

			cache_unset_active(); // desativa o cache ativo

			// render house label
			call::HOUSE->render(casaid);

			cache_set_active(cache); // ativa o cache de carregamento das casas novamente.
		}
		printf("\t- Total de %d casa(s) e %d garagens carregada(s).\n", Iter_Count(Casas), Iter_Count(Garagens));
	}
	else
		print("\t- Não foi encontrar nenhuma casa no tabela `"TABLE_HOUSES"`.\n");

	// label do interior da garagem
	CreateDynamic3DTextLabel("Use {"COR_LARANJA_INC"}/sair{"COR_BRANCO_INC"} para sair da garagem.", COR_BRANCO, InteriorGaragem[0][pGaragem][0], InteriorGaragem[0][pGaragem][1], InteriorGaragem[0][pGaragem][2], 10.0);
	
	cache_delete(cache);
	return true;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_SECONDARY_ATTACK))
	{
		foreach(new casaid: Casas)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.0, Casa[casaid][Entrada][X], Casa[casaid][Entrada][Y], Casa[casaid][Entrada][Z]))
			{
				if(Casa[casaid][Trancado])
					return GameTextForPlayer(playerid, "~r~TRANCADO!", 2500, 4);

				Teleport(
					playerid,
					Casa[casaid][Saida][X],
					Casa[casaid][Saida][Y],
					Casa[casaid][Saida][Z],
					Casa[casaid][Saida][A],
					Casa[casaid][Interior],
					casaid,
					ENTROU_CASA
				);
				return Y_HOOKS_BREAK_RETURN_1;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 2.0, Casa[casaid][Saida][X], Casa[casaid][Saida][Y], Casa[casaid][Saida][Z]) && GetPlayerVirtualWorld(playerid) == casaid)
			{
				Teleport(
					playerid,
					Casa[casaid][Entrada][X],
					Casa[casaid][Entrada][Y],
					Casa[casaid][Entrada][Z],
					Casa[casaid][Entrada][A],
					0,
					0,
					ENTROU_NONE
				);
				return Y_HOOKS_BREAK_RETURN_1;
			}
		}
		return Y_HOOKS_CONTINUE_RETURN_1;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}
