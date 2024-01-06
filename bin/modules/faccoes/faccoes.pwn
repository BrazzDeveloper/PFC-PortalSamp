
/**
*
*	- 	Modulo de facções 	-
*
*  	@author: 	SammyJ
* 	@date: 		15/04/2018
* 	@version: 	v0.0.1
*
**/
#include <YSI_Coding\y_hooks>


/**
*
*	- 	Variáveis 	-
*  	@ variáveis de definições e configurações importantes do modulo.
*
**/


#define LOG_FACTION(%0) 	"faccoes/"%0".txt"
#define CREATE_FACTION_VALUE	100000

static 
	query[255];

enum
{
	ERROR_NONE,
	ERROR_MAX_LIMIT,
	ERROR_NULL_NAME,
	ERROR_NULL_LIDER_NAME,
	ERROR_FACTION_EXISTS,
	ERROR_CRITICAL,
}


/**
*
*	Variáveis para criação da facção.
*
*	@name -> utilizada para armazenar o nome da facção a ser criada.
* 	@color -> utilizada para armazenar a cor da facção a ser criada.
**/
new faccao@name[MAX_FACTION_NAME], faccao@lider[MAX_PLAYER_NAME], faccao@color[] = "FFFFFF", faccao@ponto[MAX_FACTIONS];


/**
*
*	Variável de dominação de gangzones.
*
**/
new faccao@timer_domination[MAX_FACTIONS], faccao@UpdatePoints[MAX_GANG_ZONES];

// ============================== | FORWARDS | ============================== //
forward OnPlayerCreateFaction(playerid);
forward FactionLoad();

// ============================== | FUNÇÕES | ============================== //

/**
*
*	- 	registerLog() 	-
*  	
*	@description: função para obter o número de facções criadas na tabela do banco de dados.
* 	@params: null
* 	@return: retorna verdadeiro se a função for executada corretamente.
*
**/

static stock registerLogError(const message_log[], len = sizeof(message_log))
{
	WriteLog(LOG_FACTION("errors"), message_log, len);
	printf("» Faction: %s", message_log);
	return true;
}
static faction@message_log[255];
#define registerLogError(%0,%1) (format(faction@message_log,sizeof(faction@message_log),%0,%1),registerLogError(faction@message_log))

/**
*
*	- 	getNumberFactionsCreateds() 	-
*  	
*	@description: função para obter o número de facções criadas na tabela do banco de dados.
* 	@params: null
* 	@return: retorna o número de contas criadas na tabela do banco de dados.
*
**/
static stock getNumberFactionsCreateds()
{
	new Cache:cache = mysql_query(getConexao(), "SELECT id FROM "TABLE_FACTIONS" WHERE 1;"), rows = cache_num_rows();
	cache_delete(cache);
	return rows;
}


/**
*
*	- 	isFactionExists(const faction_name[]) 	-
*  	
*	@description: função para verificar se uma facção existe (pelo nome) no banco de dados.
* 	@params:
* 		* faction_name -> nome da facção a ser verificada.
* 	@return: retorna true se encontrar uma facção, e falso caso não encontre.
*
**/
static stock isFactionExists(const faction_name[])
{
	mysql_format(getConexao(), query, sizeof(query), "SELECT id FROM "TABLE_FACTIONS" WHERE `nome`='%e' LIMIT 1;", faction_name);
	new Cache:cache = mysql_query(getConexao(), query), rows = cache_num_rows();
	cache_delete(cache);
	return rows;
}


/**
*
*	- 	SetFactionData(index, cache) 	-
*  	
*	@description: função para atribuir valores na variável de facção.
* 	@params:
* 		* index -> index do vector Faccao.
*		* cache -> cache do banco de dados.
* 	@return: retorna true.
*
**/
static stock SetFactionData(index, cache=-1)
{
	cache = ( cache == -1 ? index : cache);

	// add a index 'i' no loop do foreach
	Iter_Add(Faccao, index);

	cache_get_value_name_int(cache, "id", Faccao[index][RowId]);

	cache_get_value_name(cache, "nome", Faccao[index][Nome], MAX_FACTION_NAME);
	cache_get_value_name_int(cache, "cofre", Faccao[index][Cofre]);
	
	cache_get_value_name_int(cache, "level", Faccao[index][Level]);
	cache_get_value_name_int(cache, "cor", Faccao[index][Cor]);

	cache_get_value_name_int(cache, "max_membros", Faccao[index][MaxMembros]);
	cache_get_value_name_int(cache, "armamentos", Faccao[index][Armamentos]);
	cache_get_value_name_int(cache, "drogas", Faccao[index][Drogas]);
	cache_get_value_name_int(cache, "base_id", Faccao[index][BaseID]);

	new cargo[10];
	for(new c=1; c < MAX_CARGOS; c++)
	{
		format(cargo, sizeof(cargo), "cargo_%d", c);
		cache_get_value_name(cache, cargo, Cargo[index][c], 70);
	}
	return true;
}


/**
*
*	- 	LoadPlayerFaction(playerid) 	-
*
*	@description: seta na variável do jogador o id da facção encontrada.
*	@params:
* 		* playerid -> o id do jogador que será setado o id da facção.
*		* rowid -> identificador único da facção.
*	@return: retorna false se não for encontrato uma facção, e true se for encontrada.
*
**/
stock LoadPlayerFaction(playerid, rowid)
{
	call::PLAYER->SetPlayerVarInt(playerid, pFaccao, INVALID_FACTION_ID);
	call::PLAYER->SetPlayerVarInt(playerid, ConviteFaccao, INVALID_FACTION_ID);
	foreach(new i: Faccao)
	{
		if ( Faccao[i][RowId] == rowid)
		{
			call::PLAYER->SetPlayerVarInt(playerid, pFaccao, i);
			return true;
		}
	}
	return false;
}

/**
*
*	- 	GetFactionIdByRowId(row_id) 	-
*  	
*	@description: Função para obter o id (index da variável Faccao) da facção pelo id único da tabela.
* 	@params:
*		* row_id ->
*	@return: retorna o index se encotrado, caso não seja encontrado retorna INVALID_FACTION_ID.
*
**/
stock GetFactionIdByRowId(row_id)
{
	foreach(new i: Faccao)
	{
		if ( Faccao[i][RowId] == row_id )
		{
			return i;
		}
	}
	return INVALID_FACTION_ID;
}

/**
*
*	- 	CreateFaction_database(const name[], const lider[]) 	-
*  	
*	@description: função para obter o número de facções criadas na tabela do banco de dados.
* 	@params:
*		* name -> Nome da facção a ser criada.
*		* lider -> Nome do lider da facção.
*	@return: retorna 0 se não houver erros, e retorna o identificador do erro casa haja.
*
**/
stock CreateFaction_database(const faction_nome[MAX_FACTION_NAME], const lider[MAX_PLAYER_NAME], color[] = "FFFFFFFF")
{
	if ( isnull(faction_nome) )
		return registerLogError("Não é possivel criar uma facção com nome vazio."), ERROR_NULL_NAME;

	if ( isnull(lider) )
		return registerLogError("Não é possivel criar uma facção com nome do lider vazio."), ERROR_NULL_LIDER_NAME;

	if ( getNumberFactionsCreateds() >= MAX_FACTIONS )
		return registerLogError("Não foi possivel criar a facção %s (( motivo: número máximo de facções criadas alcançado. ))", faction_nome), ERROR_MAX_LIMIT;

	if ( isFactionExists(faction_nome) )
		return registerLogError("Não foi possivel criar a facção %s (( motivo: Nome da facção já existe no banco de dados.))", faction_nome), ERROR_FACTION_EXISTS;
	
	new id = GetPlayerIDByName(lider);
	if ( id != INVALID_PLAYER_ID )
	{
		format(faccao@lider, MAX_PLAYER_NAME, lider);
		mysql_format(getConexao(), query, sizeof(query), "INSERT INTO "TABLE_FACTIONS"\
		(id,nome,cofre,cor,level,max_membros,cargo_1,cargo_2,cargo_3,cargo_4,cargo_5,cargo_6)VALUES\
		('%d','%s','0','%d','0','4','Lider','Sub Lider','','','','');", call::PLAYER->GetPlayerVarInt(id, PlayerID), faction_nome, HexToInt(color));

		mysql_tquery(getConexao(), query, "OnPlayerCreateFaction", "d", id);
		return ERROR_NONE;
	}
	return ERROR_CRITICAL;
}

// ============================== | CALLBACKS | ============================== //

public OnPlayerCreateFaction(playerid)
{
	new affected_rows = cache_affected_rows();


	/**
	*	
	*	print query execute time.
	*	
	**/
	printf("[benchmark] -> query execute time: %dms", cache_get_query_exec_time(MILLISECONDS));

	if ( affected_rows <= 0 )
		return SendClientMessage(playerid, COR_ERRO, "Não foi possivel criar sua facção."),registerLogError("Ocorreu algum erro na execução da query."), false;

	
	GivePlayerMoney(playerid, -CREATE_FACTION_VALUE);
	/**
	*	
	*	fazer o load das infomações da facção apôs ter ocorrido a inserção no banco de dados com êxito.
	*	
	**/
	mysql_format(getConexao(), query, sizeof(query), "SELECT * FROM "TABLE_FACTIONS" WHERE `id`='%d' LIMIT 1;", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
	mysql_tquery(getConexao(), query, "FactionLoad");
	return true;
}

public FactionLoad()
{
	for(new i; i < MAX_FACTIONS; i++)
	{
		if ( !Iter_Contains(Faccao, i) )
		{
			SetFactionData(i, 0);

			new pid = GetPlayerIDByName(faccao@lider);
			if ( pid != INVALID_PLAYER_ID )
			{
				call::PLAYER->SetPlayerVarInt(pid, pFaccao, i);
				call::PLAYER->SetPlayerVarInt(pid, pCargo, 1);

				mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `faccao`='%d',`cargo_faccao`='%d' WHERE `id`='%d'", call::PLAYER->GetPlayerVarInt(pid, PlayerID), 1, call::PLAYER->GetPlayerVarInt(pid, PlayerID));
				mysql_tquery(getConexao(), query);

				SendClientMessage(pid, COR_AZUL, "=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[ FACÇÃO ]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=");
				SendClientMessage(pid, Faccao[i][Cor], "* {"COR_BRANCO_INC"}Sua facção foi criada com {"COR_VERDE_INC"}sucessso{"COR_BRANCO_INC"}.");
				SendClientMessage(pid, Faccao[i][Cor], "* {"COR_BRANCO_INC"}Agora chame seus {"COR_AZUL_INC"}amigos{"COR_BRANCO_INC"} para entrarem em sua facção.");
				SendClientMessage(pid, COR_AZUL, "=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~==~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~==~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=");
			}
			SendClientMessageToAll(COR_AZUL, "* {"COR_BRANCO_INC"}Deem as boas vindas a mais nova facção do servidor.");
			SendClientMessageToAll(COR_AZUL, "* %s", Faccao[i][Nome]);
			break;
		}
	}
	return false;
}


/**
*
*	# OnFactionDominationArea(domination_faction_id, attacked_faction_id);
*
*	@params:
*		# gang_zone_id 				-> id da gang zone.
*		# domination_faction_id 	-> id da facção que domina a area atualmente.
*		# attacked_faction_id		-> id da facção que está atacando a area.
*
**/
forward OnFactionDominationArea(gang_zone_id, domination_faction_id, attacked_faction_id);
public OnFactionDominationArea(gang_zone_id, domination_faction_id, attacked_faction_id)
{
	if ( domination_faction_id != INVALID_FACTION_ID && attacked_faction_id != INVALID_FACTION_ID)
	{
		if ( faccao@UpdatePoints[gang_zone_id] < gettime() )
		{
			faccao@UpdatePoints[gang_zone_id] = gettime() + 30;

			foreach(new i: Player)
			{
				if ( gang_zone_id == getPlayerGangZoneId(i) )
				{
					if ( call::PLAYER->GetPlayerVarInt(i, pFaccao) == domination_faction_id)
					{
						++faccao@ponto[domination_faction_id];

						if ( faccao@ponto[domination_faction_id] >= 100)
						{
							StopGangZoneDomination(gang_zone_id, domination_faction_id);

							faccao@ponto[domination_faction_id]	= 0;
							faccao@ponto[attacked_faction_id]	= 0;

							SendClientMessageToAll(COR_VERMELHO, "* {"COR_BRANCO_INC"}A Facção {696969}%s{"COR_BRANCO_INC"} manteve o dominio do seu território em {696969}%s{"COR_BRANCO_INC"}", Faccao[domination_faction_id][Nome], GangZone[gang_zone_id][Nome], Faccao[attacked_faction_id][Nome]);
						}
					}
					if ( call::PLAYER->GetPlayerVarInt(i, pFaccao) == attacked_faction_id)
					{
						++faccao@ponto[attacked_faction_id];

						if ( faccao@ponto[attacked_faction_id] >= 100)
						{
							StopGangZoneDomination(gang_zone_id, attacked_faction_id);

							faccao@ponto[attacked_faction_id] = 0;
							faccao@ponto[domination_faction_id] = 0;

							SendClientMessageToAll(COR_VERMELHO, "* {"COR_BRANCO_INC"}A Facção {696969}%s{"COR_BRANCO_INC"} dominou o(a) {696969}%s{"COR_BRANCO_INC"} dos(as) {696969}%s{"COR_BRANCO_INC"}", Faccao[attacked_faction_id][Nome], GangZone[gang_zone_id][Nome], Faccao[domination_faction_id][Nome]);
							return true;
						}
					}
				}
				else
				{
					DestroyPlayerGuerraInfo(i);
				}
				ShowPlayerGuerraInfo(i);
				UpdateGuerraInfo(i, attacked_faction_id, 1);
				UpdateGuerraInfo(i, domination_faction_id, 2);
			}
		}
		faccao@timer_domination[gang_zone_id] = SetTimerEx("OnFactionDominationArea", 500, false, "ddd", gang_zone_id, domination_faction_id, attacked_faction_id);
		return true;
	}
	return true;
}

DeleteFaction(factionid) {
	mysql_format(getConexao(), query, sizeof(query), "UPDATE usuarios SET faccao = 0, cargo_faccao = 0 WHERE faccao = %d", factionid);
	mysql_query(getConexao(), query, false);
}


/**
*
*	hooks 
*
**/
hook OnGameModeInit()
{
	print("» Carregando facções do servidor...\n");

	// load all faction createds
	new Cache:cache = mysql_query(getConexao(), "SELECT * FROM "TABLE_FACTIONS" WHERE 1;", true), rows = cache_num_rows();
	if ( rows )
	{
		for(new i; i < rows; i++)
		{
			SetFactionData(i);
		}
	}
	printf("	[Faction] -> Foram carregados %d facções.\n", rows);
	
	cache_delete(cache);
	return Y_HOOKS_CONTINUE_RETURN_1;
}
// ============================== | INCLUDES MODULES | ============================== //

#include ../bin\modules\faccoes\cmds.pwn
#include ../bin\modules\faccoes\dialogs.pwn

