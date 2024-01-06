
// id do objeto 18880


const 
	RADAR_OBJECT = 18880,
	Float:CHECK_RADAR_RADIUS = 25.0
;

static 
	Radar[MAX_RADARS][e_RADAR_INFO], Text:Flash
;

#include <YSI_Coding\y_hooks>
hook OnGameModeInit()
{
	print("» Carregando radares...");
	new Cache:cache = mysql_query(getConexao(), "SELECT * FROM "TABLE_RADARS""), rows = cache_num_rows(), str[120];
	if( rows )
	{

		for(new i; i < rows; i++)
		{
			if ( i >= MAX_RADARS )break;
			
			cache_get_value_name_int(i, "id", Radar[i][ID]);

			cache_get_value_name_float(i, "posicao_x", Radar[i][Position][0]);
			cache_get_value_name_float(i, "posicao_y", Radar[i][Position][1]);
			cache_get_value_name_float(i, "posicao_z", Radar[i][Position][2]);

			cache_get_value_name_float(i, "rotacao_x", Radar[i][Rotation][0]);
			cache_get_value_name_float(i, "rotacao_y", Radar[i][Rotation][1]);
			cache_get_value_name_float(i, "rotacao_z", Radar[i][Rotation][2]);

			cache_get_value_name_float(i, "vida", Radar[i][Vida]);
			cache_get_value_name_int(i, "velocidade", Radar[i][Velocidade]);

			format(str, sizeof(str), "RADAR\n{ffffff}Limite de Velocidade:\n{ffff00}%d{"COR_BRANCO_INC"} Km/h", Radar[i][Velocidade]);
			Radar[i][Label] = CreateDynamic3DTextLabel(str, 0xFF0000FF, Radar[i][Position][0], Radar[i][Position][1], Radar[i][Position][2] + 2, 80.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 80.0);
			Radar[i][ObjectID] = CreateDynamicObject(RADAR_OBJECT, Radar[i][Position][0], Radar[i][Position][1], Radar[i][Position][2], Radar[i][Rotation][0], Radar[i][Rotation][1], Radar[i][Rotation][2], 0, 0, -1, 100.0, 100.0);
			Radar[i][MapIcon] = CreateDynamicMapIcon(Radar[i][Position][0], Radar[i][Position][1], Radar[i][Position][2], 34, COR_BRANCO, 0, 0, -1, 80.0, MAPICON_LOCAL);
			Iter_Add(Radar, i);


		}
		printf("\t- Total de %d radares carregado.\n", rows);
	}
	else
		print("\t- Nenhum radar foi carregado.\n");

	cache_delete(cache);

	SetTimer("RADAR_UpdateAllRadarHealth", 20000, true);


	// ============================== [ FLASH ] ============================== //
	Flash = TextDrawCreate(-20.000000, 2.000000, "|");
	TextDrawUseBox(Flash, 1);
	TextDrawBoxColor(Flash, 0xffffff66);
	TextDrawTextSize(Flash, 660.000000,22.000000);
	TextDrawAlignment(Flash, 0);
	TextDrawBackgroundColor(Flash, 0x000000ff);
	TextDrawFont(Flash, 3);
	TextDrawLetterSize(Flash, 1.000000, 52.200000);
	TextDrawColor(Flash, 0xffffffff);
	TextDrawSetOutline(Flash, 1);
	TextDrawSetProportional(Flash, 1);
	TextDrawSetShadow(Flash, 1);
	return true;
}

hook OnTimeOneSecondsPlayer(playerid)
{
	if( !IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER )
		return Y_HOOKS_CONTINUE_RETURN_1;

	if ( call::PLAYER->GetPlayerVarInt(playerid, PassouRadar) > gettime() )
		return Y_HOOKS_CONTINUE_RETURN_1;

	new model = GetVehicleModel(GetPlayerVehicleID(playerid));
	if ( IsBike(model) )
		return Y_HOOKS_CONTINUE_RETURN_1;

	if ( call::PLAYER->GetPlayerVarInt(playerid, Profissao) == POLICIA_MILITAR && call::JOB->IsPlayerInWorking(playerid) )
		return Y_HOOKS_CONTINUE_RETURN_1;

	if( call::PLAYER->GetPlayerVarInt(playerid, Profissao) == BOMBEIRO && call::JOB->IsPlayerInWorking(playerid))
		return Y_HOOKS_CONTINUE_RETURN_1;

	foreach(new i: Radar)
	{
		if(IsPlayerInRangeOfPoint(playerid, CHECK_RADAR_RADIUS, Radar[i][Position][0], Radar[i][Position][1], Radar[i][Position][2]))
		{

			call::PLAYER->SetPlayerVarInt(playerid, PassouRadar, gettime() + 5);
			
			new speed = GetPlayerSpeed(playerid);

			if ( Radar[i][Vida] < 1)
			{
				GameTextForPlayer(playerid, "~r~~h~~h~Radar Danificado", 2000, 4);
				continue;
			}

			if(speed > Radar[i][Velocidade])
			{

				if ( Jogador[playerid][TesteDirecao] )
				{
					Jogador[playerid][PontosInTeste] -= 10;
					SendClientMessage(playerid, COR_LARANJA, "| INSTRUTOR | Você perdeu 10 pontos por passar acima da velocidade permitida.");
					return Y_HOOKS_CONTINUE_RETURN_1;
				}

				if(call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE && call::ADMIN->IsAdminInJob(playerid))
					return 1;

				if(pRacha[playerid][Participando] == true)
					return 1;

				SendClientMessage(playerid, COR_AMARELO, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {ffffff}RADAR {"COR_AMARELO_INC"}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");			
				new vehicleid = GetPlayerVehicleID(playerid);
				if ( Iter_Contains(VehiclePlayers, vehicleid) )
				{
					++Vehicle[vehicleid][Multas];

					m_string[0]=EOS;
					mysql_format(getConexao(), m_string, sizeof(m_string), "UPDATE "TABLE_VEHICLES_PLAYER" SET `multas`='%d' WHERE id='%d' LIMIT 1;", Vehicle[vehicleid][Multas], Vehicle[vehicleid][Id]);
					mysql_tquery(getConexao(), m_string);

					SendClientMessage(playerid, COR_VERMELHO, "| RADAR | {"COR_BRANCO_INC"}Este veiculo foi multado, se o veiculo acumular mais de {"COR_VERMELHO_INC"}10{"COR_BRANCO_INC"} multas o mesmo ficará em busca e apreensão.");
					SendClientMessage(playerid, COR_VERMELHO, "| RADAR | {"COR_BRANCO_INC"}E Poderá ser apreendido por qualquer Guarda ou Policial que lhe parar.");
				}

				if ( ( BitFlag_Get(Jogador[playerid][Habilitacao], HAB_MOTO) && IsMoto(model) ) ||
					 ( BitFlag_Get(Jogador[playerid][Habilitacao], HAB_CARRO) && IsCar(model) ) ||
					 ( BitFlag_Get(Jogador[playerid][Habilitacao], HAB_CAMINHAO) && IsTruck(model) ) )
				{
					call::PLAYER->SetPlayerVarInt(playerid, Multas, call::PLAYER->GetPlayerVarInt(playerid, Multas) + 1);
					SendClientMessage(playerid, COR_VERMELHO, "| RADAR | {"COR_BRANCO_INC"}Você levou um ponto na carteira por ultrapassar o limite permitido");
					SendClientMessage(playerid, COR_VERMELHO, "| RADAR | {"COR_BRANCO_INC"}Você já tem {"COR_VERMELHO_INC"}%d{"COR_BRANCO_INC"} pontos na carteira.", call::PLAYER->GetPlayerVarInt(playerid, Multas));

					if(call::PLAYER->GetPlayerVarInt(playerid, Multas) > 10)
					{
						call::PLAYER->SetPlayerVarInt(playerid, Multas, 0);
						
						Jogador[playerid][Habilitacao] = e_HABILITACAO:0;
						
						m_string[0]=EOS;
						mysql_format(getConexao(), m_string, sizeof(m_string), "UPDATE "TABLE_USERS" SET `multas`='0',`habilitacao_a`='0',`habilitacao_b`='0',`habilitacao_c`='0',`habilitacao_d`='0',`habilitacao_e`='0' WHERE `id`='%d' LIMIT 1;", Jogador[playerid][PlayerID]);
						mysql_tquery(getConexao(), m_string);

						SendClientMessage(playerid, COR_VERMELHO, "| RADAR | {"COR_BRANCO_INC"}Você perdeu sua habilitação por levar {"COR_VERMELHO_INC"}10{"COR_BRANCO_INC"} multas.");
					}
					SendClientMessage(playerid, COR_AMARELO, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {ffffff}RADAR {"COR_AMARELO_INC"}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
					GameTextForPlayer(playerid, "~r~MULTADO", 2000, 5);
				}
				else
				{
					SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid) + 1);
					SendClientMessage(playerid, COR_ERRO, "| RADAR | Você está sendo procurado pela policia por dirigir sem habilitação.");
					
					foreach(new pmid: Player)
					{
						if ( call::PLAYER->GetPlayerVarInt(pmid, Profissao) == POLICIA_MILITAR )
						{
							SendClientMessage(pmid, COR_AZUL, "O(A) Jogador(a) {"COR_BRANCO_INC"}%s{"COR_AZUL_INC"} passou em um radar acima da velocidade permitida.", GetUserName(playerid));
						}
					}
				}
				
				FlashFoto(playerid);
				SendClientMessage(playerid, COR_AMARELO, "| RADAR | Velocidade registrada: %dkm/h", speed);
				//SendClientMessage(playerid, COR_VERMELHO, "* {"COR_BRANCO_INC"}Você passou a {"COR_VERMELHO_INC"}%d{"COR_BRANCO_INC"} km\\h em uma pista de {"COR_VERMELHO_INC"}%d{"COR_BRANCO_INC"} km\\h.", speed, Radar[i][Velocidade]);
			}
			break;
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

forward function RADAR::UpdateAllRadarHealth();
public function RADAR::UpdateAllRadarHealth()
{
	foreach(new i: Radar)
	{
		if(Radar[i][Vida] > 5)
		{
			Radar[i][Vida] -= 0.5;
			continue;
		}
	}
	return true;
}

forward FlashFoto(playerid);
public FlashFoto(playerid)
{
	PlayerPlaySound(playerid, 1132, 0.0, 0.0, 0.0);
	TextDrawShowForPlayer(playerid, Flash);
	SetTimerEx("FlashFotoSair", 500, false, "i", playerid);
	return 1;
}

forward FlashFotoSair(playerid);
public FlashFotoSair(playerid)
{
	TextDrawHideForPlayer(playerid, Flash);
	return 1;
}

// ============================== [ FUNCTIONs ] ============================== //
stock function RADAR::IsValidRadar(radarid)
{
	if(radarid < 0 || radarid > sizeof(Radar))
		return false;

	return Iter_Contains(Radar, radarid);
}

stock function RADAR::GetRadarPos(radarid, &Float:x, &Float:y, &Float:z)
{
	if(!call::RADAR->IsValidRadar(radarid))
		return false;

	x = Radar[radarid][Position][0];
	y = Radar[radarid][Position][1];
	z = Radar[radarid][Position][2];
	return true;
}

stock function RADAR::SetRadarVarInt(radarid, e_RADAR_INFO:param, value)
{
	if(!call::RADAR->IsValidRadar(radarid))
		return false;

	Radar[radarid][param] = value;
	return true;
}
stock function RADAR::GetRadarVarInt(radarid, e_RADAR_INFO:param)
{
	if(!call::RADAR->IsValidRadar(radarid))
		return false;

	return Radar[radarid][param];
}


stock function RADAR::SetRadarVarFloat(radarid, e_RADAR_INFO:param, Float:value)
{
	if(!call::RADAR->IsValidRadar(radarid))
		return false;

	Radar[radarid][param] = _:value;
	return true;
}


stock Float:function RADAR::GetRadarVarFloat(radarid, e_RADAR_INFO:param)
{
	if(!call::RADAR->IsValidRadar(radarid))
		return Float:0;

	return Float:Radar[radarid][param];
}

stock function RADAR::SetRadarVar(radarid, e_RADAR_INFO:param, value[], len = sizeof(value))
{
	if(!call::RADAR->IsValidRadar(radarid))
		return false;

	format(Radar[radarid][param], len, value);
	return true;
}
stock function RADAR::GetRadarVar(radarid, e_RADAR_INFO:param)
{
	if(!call::RADAR->IsValidRadar(radarid))
		return false;

	return Radar[radarid][param];
}

		// ====================================== PROCESSO DE CRIAÇÃO ====================================== //
// ============================================================================================================================ // 

static cObjectID[MAX_PLAYERS], cVelocidadeRadar[MAX_PLAYERS], bool:InCreateRadar[MAX_PLAYERS],
		bool:InUpdateRadar[MAX_PLAYERS], InUpdateRadarRadarID[MAX_PLAYERS]
;


// Functions
static stock function RADAR::ProcessCreateRadar(playerid, velocidade)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	cObjectID[playerid] = CreatePlayerObject(playerid, RADAR_OBJECT, x, y + 2, z, 0.0, 0.0, 0.0);
	EditPlayerObject(playerid, cObjectID[playerid]);
	cVelocidadeRadar[playerid] = velocidade;
	InCreateRadar[playerid] = true;
	return true;
}

static stock function RADAR::ResetProcessCreateRadar(playerid)
{
	DestroyPlayerObject(playerid, cObjectID[playerid]);
	cObjectID[playerid]=0;
	cVelocidadeRadar[playerid]=0;
	InCreateRadar[playerid]=false;
	return true;
}


// CMDS

flags:criarradar(DIRECAO);
CMD:criarradar(playerid, params[])
{
	if ( isnull(params) || !IsNumeric(params))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/criarradar [velocidade máxima]");

	if ( InCreateRadar[playerid] )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está criando um radar.");

	if ( Iter_Count(Radar) >= MAX_RADARS )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não é possivel criar mais radares.");
	
	call::RADAR->ProcessCreateRadar(playerid, strval(params));
	return true;
}

flags:editarradar(DIRECAO);
CMD:editarradar(playerid, params[])
{
	if ( isnull(params) || !IsNumeric(params) )
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/editarradar [velocidade maxima]");

	foreach(new i: Radar)
	{
		if ( IsPlayerInRangeOfPoint(playerid, 10.0, Radar[i][Position][0], Radar[i][Position][1], Radar[i][Position][2]) )
		{
			EditDynamicObject(playerid, Radar[i][ObjectID]);
			InUpdateRadarRadarID[playerid] = i;
			InUpdateRadar[playerid]=true;
			cVelocidadeRadar[playerid] = strval(params);
			return true;
		}
	}
	SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo a um radar.");
	return true;
}


// callbacks
hook OnPlayerEditObject( playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ )
{
	if ( response == EDIT_RESPONSE_FINAL)
	{
		if ( InCreateRadar[playerid] )
		{
			if ( Iter_Count(Radar) >= MAX_RADARS )
			{	
				new query[512];
				mysql_format(getConexao(), query, sizeof(query), 
				"INSERT INTO "TABLE_RADARS" (`posicao_x`,`posicao_y`,`posicao_z`,`rotacao_x`,`rotacao_y`,`rotacao_z`,`velocidade`)\
				VALUES('%.2f','%.2f','%.2f','%.2f','%.2f','%.2f','%d');", fX, fY, fZ, 0.0, 0.0, fRotZ, cVelocidadeRadar[playerid]);
				mysql_tquery(getConexao(), query, "CriarRadar", "i", playerid);
			}
			else SendClientMessage(playerid, COR_ERRO, "| ERRO | Não é possivel criar mais radares.");
			
			call::RADAR->ResetProcessCreateRadar(playerid);
			return true;
		}
		else if ( InUpdateRadar[playerid] )
		{	
			new query[512], radarid = InUpdateRadarRadarID[playerid];
			mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_RADARS" SET `posicao_x`='%.2f',`posicao_y`='%.2f',`posicao_z`='%.2f',`rotacao_x`='%.2f',`rotacao_y`='%.2f',`rotacao_z`='%.2f',`velocidade`='%d' WHERE `id`='%d'",
				fX, fY, fZ, 0.0, 0.0, fRotZ, cVelocidadeRadar[playerid], Radar[radarid][ID]);
			mysql_tquery(getConexao(), query);

			Radar[radarid][Position][0] = fX;
			Radar[radarid][Position][1] = fY;
			Radar[radarid][Position][2] = fZ;
			
			Radar[radarid][Rotation][2] = fRotZ;

			Radar[radarid][Velocidade] = cVelocidadeRadar[playerid];

			// Recriar Label
			new str[128];
			format(str, sizeof(str), "RADAR\nLimite de Velocidade: {"COR_AMARELO_INC"}%d{"COR_BRANCO_INC"} KM\\h", Radar[radarid][Velocidade]);
			DestroyDynamic3DTextLabel(Radar[radarid][Label]);
			Radar[radarid][Label] = CreateDynamic3DTextLabel(str, COR_BRANCO, Radar[radarid][Position][0], Radar[radarid][Position][1], Radar[radarid][Position][2] + 4, 80.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0, -1, 80.0);

			// Recriar MapIcon
			DestroyDynamicMapIcon(Radar[radarid][MapIcon]);
			Radar[radarid][MapIcon] = CreateDynamicMapIcon(Radar[radarid][Position][0], Radar[radarid][Position][1], Radar[radarid][Position][2], 34, COR_BRANCO, 0, 0, -1, 80.0, MAPICON_LOCAL);
			
			InUpdateRadar[playerid]=false;
			InUpdateRadarRadarID[playerid]=0;
			return true;
		}
		return true;
	}
	else if ( response == EDIT_RESPONSE_CANCEL )
	{
		call::RADAR->ResetProcessCreateRadar(playerid);
		InUpdateRadar[playerid]=false;
		InUpdateRadarRadarID[playerid]=0;
		return true;
	}
	return true;
}


forward CriarRadar(playerid);
public CriarRadar(playerid)
{
	new id = cache_insert_id();
	if ( id < 1 )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foi possivel inserir o radar no banco de dados.");

	new query[128];
	mysql_format(getConexao(), query, sizeof(query), "SELECT * FROM "TABLE_RADARS" WHERE `id`='%d'", id);
	new Cache:cache = mysql_query(getConexao(), query, true), rows = cache_num_rows();

	if ( rows )
	{
		for(new i; i < sizeof(Radar); i++)
		{
			if ( !Radar[i][ID] )
				continue; 

			cache_get_value_name_int(0, "id", Radar[i][ID]);

			cache_get_value_name_float(0, "posicao_x", Radar[i][Position][0]);
			cache_get_value_name_float(0, "posicao_y", Radar[i][Position][1]);
			cache_get_value_name_float(0, "posicao_z", Radar[i][Position][2]);

			cache_get_value_name_float(0, "rotacao_x", Radar[i][Rotation][0]);
			cache_get_value_name_float(0, "rotacao_y", Radar[i][Rotation][1]);
			cache_get_value_name_float(0, "rotacao_z", Radar[i][Rotation][2]);

			cache_get_value_name_float(0, "vida", Radar[i][Vida]);
			cache_get_value_name_int(0, "velocidade", Radar[i][Velocidade]);

			new str[128];
			format(str, sizeof(str), "RADAR\nLimite de Velocidade: {"COR_AMARELO_INC"}%d{"COR_BRANCO_INC"} KM\\h", Radar[i][Velocidade]);
			Radar[i][Label] = CreateDynamic3DTextLabel(str, COR_BRANCO, Radar[i][Position][0], Radar[i][Position][1], Radar[i][Position][2] + 4, 80.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 80.0);
			Radar[i][ObjectID] = CreateDynamicObject(RADAR_OBJECT, Radar[i][Position][0], Radar[i][Position][1], Radar[i][Position][2], Radar[i][Rotation][0], Radar[i][Rotation][1], Radar[i][Rotation][2], 0, 0, -1, 80.0, 80.0);
			Radar[i][MapIcon] = CreateDynamicMapIcon(Radar[i][Position][0], Radar[i][Position][1], Radar[i][Position][2], 34, COR_BRANCO, 0, 0, -1, 80.0, MAPICON_LOCAL);
			Iter_Add(Radar, i);
			break;
		}
		cache_delete(cache);
		SendClientMessage(playerid, COR_BRANCO, "O Radar foi criado com {"COR_VERDE_INC"}êxito{"COR_BRANCO_INC"}!");
		return true;
	}
	cache_delete(cache);
	SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foi possivel encontrar o radar no banco de dados.");
	return true;
}
#pragma unused cObjectID
