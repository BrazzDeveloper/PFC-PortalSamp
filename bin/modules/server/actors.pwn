#include <YSI_Coding\y_hooks>

#define 	MAX_DYN_ACTORS 			(50)

enum e_ACTOR_INFO
{
	ID,
	Actor_id,
	Nome[MAX_PLAYER_NAME],
	Float:Pos[e_POSITION],
	Interior,
	World,
	Skin,
	AnimLib[30],
	AnimName[30],
	fDelta,
	bool:Loop,
	bool:LockX,
	bool:lockY,
	bool:Freeze,
	Time,
}
static Actor[MAX_DYN_ACTORS][e_ACTOR_INFO];


hook OnGameModeInit()
{
	new Cache:cache = mysql_query(getConexao(), "SELECT * FROM actors;"), rows = cache_num_rows();
	rows = (rows > MAX_DYN_ACTORS ? MAX_DYN_ACTORS : rows);
	if ( rows )
	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "id", Actor[i][ID]);

			cache_get_value_name(i, "nome", Actor[i][Nome]);

			cache_get_value_name_float(i, "x", Actor[i][Pos][X]);
			cache_get_value_name_float(i, "y", Actor[i][Pos][Y]);
			cache_get_value_name_float(i, "z", Actor[i][Pos][Z]);
			cache_get_value_name_float(i, "a", Actor[i][Pos][A]);
			
			cache_get_value_name_int(i, "world", Actor[i][World]);
			cache_get_value_name_int(i, "interior", Actor[i][Interior]);

			cache_get_value_name_int(i, "skin", Actor[i][Skin]);

			cache_get_value_name(i, "animlib", Actor[i][AnimLib], 30);
			cache_get_value_name(i, "animname", Actor[i][AnimName], 30);

			cache_get_value_name_int(i, "delta", Actor[i][fDelta]);
			cache_get_value_name_bool(i, "loop_", Actor[i][Loop]);
			cache_get_value_name_bool(i, "lockx", Actor[i][LockX]);
			cache_get_value_name_bool(i, "locky", Actor[i][lockY]);
			cache_get_value_name_bool(i, "freeze", Actor[i][Freeze]);
			cache_get_value_name_int(i, "time", Actor[i][Time]);

			CreateDynamic3DTextLabel(Actor[i][Nome], 0xFD811DFF, Actor[i][Pos][X], Actor[i][Pos][Y], Actor[i][Pos][Z]+0.7, 15.0, .worldid=Actor[i][World], .interiorid=Actor[i][Interior], .streamdistance=15.0, .testlos=1);
			Actor[i][Actor_id] = CreateDynamicActor(Actor[i][Skin], Actor[i][Pos][X], Actor[i][Pos][Y], Actor[i][Pos][Z], Actor[i][Pos][A], .invulnerable=0, .health = 100.0, .worldid=Actor[i][World], .interiorid=Actor[i][Interior], .streamdistance=50.0);
			
			if ( !isnull( Actor[i][AnimLib] ) && !isnull( Actor[i][AnimName] ) )
				ApplyDynamicActorAnimation(Actor[i][Actor_id], Actor[i][AnimLib], Actor[i][AnimName], Actor[i][fDelta], Actor[i][Loop], Actor[i][LockX], Actor[i][lockY], Actor[i][Freeze], Actor[i][Time]);

			Iter_Add(Actor, i);
		}
	}

	// DP DE LS
	CreateDynamicActor(281, 1554.6349,-1677.3937,16.1953,76.5918); // ACTOR DEPARTAMENTO 
	CreateDynamicActor(282, 1544.6881,-1631.5542,13.3828,103.2634);

	// HOSPITAL DE LS
	CreateDynamicActor(275, 1174.7430,-1310.1837,13.9926,276.5826);



	cache_delete(cache);
	return true;
}

CMD:infos(playerid, params[]) {

	if(IsPlayerInRangeOfPoint(playerid, 1.5, 1688.1864,-2246.5581,13.5469))
	{
		new __str[1024];
		format(__str, sizeof(__str), "{ffffff}Bem vindo(a), {"COR_LARANJA_INC"}%s{ffffff}\n\n\
Siga para a {"COR_LARANJA_INC"}Agência de Empregos{ffffff}, selecione um emprego e vá até o mesmo para assinar contrato.\n\
Use o comando  {"COR_LARANJA_INC"}/Gps {ffffff}para descobrir os locais do servidor\n\
Após juntar um dinheiro, crie sua conta bancária em nosso {"COR_LARANJA_INC"}Banco{ffffff}, logo em seguida faça um plano de saúde em nosso {"COR_LARANJA_INC"}Hospital{ffffff}\n\
Há {"COR_LARANJA_INC"}Auto Escolas{ffffff} em toda San Andreas, tire sua habilitação para evitar problemas com a lei.. Há a opção de fugir, mas é arriscado, hein!\n\
Há {"COR_LARANJA_INC"}Concessionárias{ffffff} pelo mapa, caso deseje ter um veículo pessoal para melhor locomoção!\n\n\
Bom jogo e siga as regras do servidor, use {"COR_LARANJA_INC"}/Regras{ffffff}\n\n\
{ffffff}Acesse nosso Discord: {"COR_LARANJA_INC"}https://discord.gg/rwUbARa4g9\n\
{ffffff}Acesse nosso Site: {"COR_LARANJA_INC"}www.perfectcityrpg.com.br\n\
{ffffff}Acesse nosso Fórum: {"COR_LARANJA_INC"}www.perfectcityrpg.com.br/forum", GetUserName(playerid));

		ShowPlayerDialog(playerid, DIALOG_INFOS, DIALOG_STYLE_MSGBOX, "Pequenas Informações", __str, "Ok", #);
	}
	return true;
}
