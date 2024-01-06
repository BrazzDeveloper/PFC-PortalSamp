#define MAX_PRODUCOES 6
#define INVALID_PRODUCAO_ID 						(MAX_PRODUCOES + 1)
#define VALOR_POR_MATERIAS 							400
#define minutos(%0) (1000 * %0 * 60)

enum e_PRODUCAO
{
	ID,
	Dono[MAX_PLAYER_NAME],
	Tipo[10],
	Float: Entrada[e_POSITION],
	SendoUsada,
	Text3D:Label
}
new 
	Producoes[MAX_PRODUCOES][e_PRODUCAO], Iterator:Producoes<MAX_PRODUCOES>;

enum e_Player_PRODUCAO
{
	bool:_Coletando,
	bool: Tempo,
	Plantou
}
new 
	_Producao[MAX_PLAYERS][e_Player_PRODUCAO], TimerProducao[MAX_PLAYERS], ObjectProd[MAX_PLAYERS];

new RandomDrogaName[2][10] =
{
	"Crack",
	"Cocaina"
};

// ================================ [ FUNCTIONS ] =============================== //
const PRODUCAO_LENG_RENDER_VAR = 128;

stock static function PRODUCAO::render_string(producaoid)
{
	new s[PRODUCAO_LENG_RENDER_VAR];
	
	if(!Producoes[producaoid][SendoUsada])
		format(s, PRODUCAO_LENG_RENDER_VAR, "Produção\nProdutor(a): {"COR_VERMELHO_INC"}Ninguem{"COR_BRANCO_INC"}\nID: {"COR_AMARELO_INC"}%d{"COR_BRANCO_INC"}\nProduzindo: {088A08}Nada", Producoes[producaoid][ID]);
	
	else
		format(s, PRODUCAO_LENG_RENDER_VAR, "Produção\nProdutor(a): {"COR_VERMELHO_INC"}%s{"COR_BRANCO_INC"}\nID: {"COR_AMARELO_INC"}%d{"COR_BRANCO_INC"}\nProduzindo: {088A08}%s.", Producoes[producaoid][Dono], Producoes[producaoid][ID], Producoes[producaoid][Tipo]);
	
	return s;
}

function PRODUCAO::UpdateProducaoLabel(producaoid)
{
	if( !call::PRODUCAO->IsValidProducao(producaoid) )
		return false;

	UpdateDynamic3DTextLabelText(Producoes[producaoid][Label], COR_BRANCO, call::PRODUCAO->render_string(producaoid));
	return true;
}

function PRODUCAO::GetProducaoID(playerid, Float:range=2.0)
{

	foreach(new producaoid: Producoes)
	{
		if(!call::PRODUCAO->IsValidProducao(producaoid))
			return false;

		if(IsPlayerInRangeOfPoint(playerid, range, Producoes[producaoid][Entrada][X], Producoes[producaoid][Entrada][Y], Producoes[producaoid][Entrada][Z]))
			return producaoid;
	}
	return INVALID_PRODUCAO_ID;
}

function PRODUCAO::IsPlayerProducao(playerid, Float:range=2.0)
{

	foreach(new producaoid: Producoes)
	{
		if(!call::PRODUCAO->IsValidProducao(producaoid))
			return false;

		if(IsPlayerInRangeOfPoint(playerid, range, Producoes[producaoid][Entrada][X], Producoes[producaoid][Entrada][Y], Producoes[producaoid][Entrada][Z]))
			return true;
	}
	return false;
}

function PRODUCAO::IsValidProducao(producaoid)
{
	if(producaoid < 0 || producaoid > sizeof(Producoes))
		return false;

	return (Iter_Contains(Producoes, producaoid) && !isnull(Producoes[producaoid][Dono]));
}

stock function PRODUCAO::resetVar(playerid)
{
	if ( TimerProducao[playerid] )
	{
		KillTimer(TimerProducao[playerid]);
		TimerProducao[playerid]=0;
	}

	if(_Producao[playerid][Plantou] == 1)
	{
		DestroyDynamicObject(ObjectProd[playerid]);
		_Producao[playerid][Tempo] = false, _Producao[playerid][Plantou] = 0, _Producao[playerid][_Coletando] = false;
		foreach(new producaoid: Producoes)
		{
			if ( strcmp(GetUserName(playerid), Producoes[producaoid][Dono], false) == 0 )
			{
				format(Producoes[producaoid][Tipo], 10, "Nada"), format(Producoes[producaoid][Dono], MAX_PLAYER_NAME, "Ninguem"), Producoes[producaoid][SendoUsada] = 0;

				new query[130];
				mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_PRODUCOES" SET `username`='Ninguem',`produzindo`='Nada',`sendousada`='0' WHERE `id`='%d' LIMIT 1;", Producoes[producaoid][Dono], Producoes[producaoid][Tipo], Producoes[producaoid][SendoUsada], Producoes[producaoid][ID]);
				mysql_tquery(getConexao(), query);
				call::PRODUCAO->UpdateProducaoLabel(producaoid);
				break;
			}
		}
	}
}
// ================================== [ CALLBACKS ] ============================== //
#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	new Cache:cache = mysql_query(getConexao(), "SELECT * FROM "TABLE_PRODUCOES"", true), rows = cache_num_rows();

	if(rows)
	{
		for(new i; i < rows; i++)
		{
			Iter_Add(Producoes, i);

			cache_get_value_name_int(i, "id", Producoes[i][ID]);
			cache_get_value_name_int(i, "sendousada", Producoes[i][SendoUsada]);

			cache_get_value_name(i, "username", Producoes[i][Dono], MAX_PLAYER_NAME);
			cache_get_value_name(i, "produzindo", Producoes[i][Tipo]);
				
			cache_get_value_name_float(i, "localx", Producoes[i][Entrada][X]);
			cache_get_value_name_float(i, "localy", Producoes[i][Entrada][Y]);
			cache_get_value_name_float(i, "localz", Producoes[i][Entrada][Z]);

			Producoes[i][Label] = CreateDynamic3DTextLabel(call::PRODUCAO->render_string(i), COR_BRANCO, Producoes[i][Entrada][X], Producoes[i][Entrada][Y], Producoes[i][Entrada][Z] + 0.3, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0, -1, 20.0);
		}
	}
	cache_delete(cache);
	return true;
}

hook OnGameModeExit()
{
	new query[100];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_PRODUCOES" SET `username`='Ninguem',`produzindo`='Nada',`sendousada`='0' WHERE 1;");
	mysql_tquery(getConexao(), query);
}

hook OnPlayerDisconnect(playerid, reason)
{
	
	call::PRODUCAO->resetVar(playerid);
	return Y_HOOKS_CONTINUE_RETURN_1;
}
// ======================================== [ COMANDOS ] ================================== //
CMD:comprarmaterias(playerid)
{
	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != PRODUTOR)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte da profissão de Produtor de Drogas");

	if(!IsPlayerInRangeOfPoint(playerid, 2.0, 2523.9565, -2206.6477, 17.3572))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está no porto para comprar Matéria-prima.");

	if( call::PLAYER->GetPlayerVarInt(playerid, Materias) >= 15)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já tem o máximo de Matérias-Primas para produzir.");

	ShowPlayerDialog(playerid, Dialog_Porto2, DIALOG_STYLE_INPUT, "{"COR_VERMELHO_INC"}* Loja de Matéria-Prima preço: {088A08}R$400 cada", "Digite o número de Matérias a serem compradas.", "Confirmar", "Fechar");
	return true;
}


CMD:produzir(playerid, params[])
{
	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != PRODUTOR)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte da profissão de Produtor de Drogas");

	new producaoid = call::PRODUCAO->GetProducaoID(playerid, 2.0);

	if(!call::PRODUCAO->IsValidProducao(producaoid))
		return false;

	if(!call::PRODUCAO->IsPlayerProducao(playerid, 2.0))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo a nenhuma produção");

	//if ( !call::JOB->IsPlayerInWorking(playerid) )
	//	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");

	if(strcmp(Producoes[producaoid][Dono], "Ninguem", true) != 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Está produção já tem dono.");

	if(Producoes[producaoid][SendoUsada] == 1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Essa produção já está sendo utilizada.");

	if(call::PLAYER->GetPlayerVarInt(playerid, Materias) == 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem Matérias-Primas para produzir.");

	if(_Producao[playerid][Plantou] == 1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está usando uma produção.");

	if ( TimerProducao[playerid] )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está produzindo suas drogas.");

	TogglePlayerControllable(playerid, false);

    TimerProducao[playerid] = SetTimerEx("Produzindo", 4000, false, "i", playerid);
    GameTextForPlayer(playerid, "~r~Produzindo...", 4500, 3);
	return true;
}

CMD:coletar(playerid, params[])
{
	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != PRODUTOR)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte da profissão de Produtor de Drogas");

	//if ( !call::JOB->IsPlayerInWorking(playerid) )
	//	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");

	if(_Producao[playerid][Tempo] == true)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Sua produção ainda não está pronta.");

	if(_Producao[playerid][Plantou] == 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está usando uma produção.");

	if( !call::PRODUCAO->IsPlayerProducao(playerid, 2.0) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo a nenhuma produção");

	new producaoid = call::PRODUCAO->GetProducaoID(playerid, 2.0);

	if( !call::PRODUCAO->IsValidProducao(producaoid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo a uma produção de Drogas.");

	if(strcmp(GetUserName(playerid), Producoes[producaoid][Dono], true) != 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Está produção não é sua.");

	if ( _Producao[playerid][_Coletando] )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está coletando, aguarde...");

	KillTimer(TimerProducao[playerid]);

	TogglePlayerControllable(playerid, false);
	
	_Producao[playerid][_Coletando] = true;
    
    SetTimerEx("Coletando", 8000, false, "i", playerid);
    GameTextForPlayer(playerid, "~r~Coletando...", 8000, 3);
	return true;
}
//=========================================== [ Dialogs ] =============================================================== //
Dialog:Dialog_Porto2(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if ( isnull(inputtext) || !IsNumeric(inputtext))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você tem que digitar um número válido.");

		new materias = strval(inputtext);

		if( (VALOR_POR_MATERIAS * materias) > GetPlayerMoney(playerid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente.");

		if ( (call::PLAYER->GetPlayerVarInt(playerid, Materias) + materias ) > 15 )
    		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode possuir mais que 15 Matérias-Primas.");


		GivePlayerMoney(playerid, -(VALOR_POR_MATERIAS * materias) );
		call::PLAYER->SetPlayerVarInt(playerid, Materias, call::PLAYER->GetPlayerVarInt(playerid, Materias) + strval(inputtext));

		new query[128];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `materias`='%d' WHERE `id`='%d' LIMIT 1;", call::PLAYER->GetPlayerVarInt(playerid, Materias), call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
		mysql_tquery(getConexao(), query);
		printf("[produtor] %s", query);

		SendClientMessage(playerid, COR_BRANCO, "* Você comprou {"COR_AMARELO_INC"}%d{"COR_BRANCO_INC"} Matérias-Primas no valor de {088A08}R$%s{"COR_BRANCO_INC"}.", materias, RealStr(VALOR_POR_MATERIAS * materias));
	}
	return true;
}
//=========================================== [ Public's/Forward's ] ==================================================== //
forward Produzindo(playerid);
public Produzindo(playerid)
{
	new producaoid = call::PRODUCAO->GetProducaoID(playerid, 2.0);

	_Producao[playerid][Plantou] = 1, _Producao[playerid][Tempo] = true, call::PLAYER->SetPlayerVarInt(playerid, Materias, call::PLAYER->GetPlayerVarInt(playerid, Materias) - 1);
    TimerProducao[playerid]=0;

    Producoes[producaoid][Tipo] = RandomDrogaName[random(sizeof(RandomDrogaName))];
    format(Producoes[producaoid][Dono], MAX_PLAYER_NAME,GetUserName(playerid));
    Producoes[producaoid][SendoUsada] = 1;

    TogglePlayerControllable(playerid, true);
	
	SendClientMessage(playerid, COR_BRANCO, "» Nick: {"COR_VERMELHO_INC"}%s", GetUserName(playerid));
	SendClientMessage(playerid, COR_BRANCO, "» Matérias - Primas: {"COR_AMARELO_INC"}%d", call::PLAYER->GetPlayerVarInt(playerid, Materias));
	SendClientMessage(playerid, COR_BRANCO, "» Você está produzindo {"COR_VERMELHO_INC"}%s{"COR_BRANCO_INC"}, aguarde para a colheita!", Producoes[producaoid][Tipo]);
	TimerProducao[playerid] = SetTimerEx("ProducaoCrescer", minutos(3), false, "d", playerid);

	new query[130];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_PRODUCOES" SET `username`='%s',`produzindo`='%s',`sendousada`='1' WHERE `id`='%d' LIMIT 1;", Producoes[producaoid][Dono], Producoes[producaoid][Tipo], Producoes[producaoid][SendoUsada], Producoes[producaoid][ID]);
	mysql_tquery(getConexao(), query);

	query[0] = EOS;
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `materias`='%d' WHERE `id`='%d' LIMIT 1;", call::PLAYER->GetPlayerVarInt(playerid, Materias), call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
	mysql_tquery(getConexao(), query);
	printf("[produtor] %s", query);

	call::PRODUCAO->UpdateProducaoLabel(producaoid);
	return true;
}

forward ProducaoCrescer(playerid);
public ProducaoCrescer(playerid)
{
	_Producao[playerid][Tempo] = false;
	TimerProducao[playerid] = SetTimerEx("ExpirandoProducao", minutos(3), false, "d", playerid);

	foreach(new producaoid: Producoes)
	{
		if ( strcmp(GetUserName(playerid), Producoes[producaoid][Dono], false) == 0 )
		{
			SendClientMessage(playerid, COR_BRANCO, "» Sua(eu) {"COR_VERMELHO_INC"}%s{"COR_BRANCO_INC"} está pronta para ser colhida, não demore para colhe-las!", Producoes[producaoid][Tipo]);

			if( strcmp(Producoes[producaoid][Tipo], "Cocaina", true) == 0)
				ObjectProd[playerid] = CreateDynamicObject(1580,  Producoes[producaoid][Entrada][X],  Producoes[producaoid][Entrada][Y],  Producoes[producaoid][Entrada][Z],   0.00000, 0.00000, 0.00000);
			else if( strcmp(Producoes[producaoid][Tipo], "Crack", true) == 0)
				ObjectProd[playerid] = CreateDynamicObject(1575,  Producoes[producaoid][Entrada][X],  Producoes[producaoid][Entrada][Y],  Producoes[producaoid][Entrada][Z],   0.00000, 0.00000, 0.00000);
			return true;
		}
	}
	return true;
}

forward ExpirandoProducao(playerid);
public ExpirandoProducao(playerid)
{
	_Producao[playerid][Plantou] = 0, _Producao[playerid][Tempo] = false, _Producao[playerid][_Coletando] = false;
	TimerProducao[playerid]=0;
	DestroyDynamicObject(ObjectProd[playerid]);

	foreach(new producaoid: Producoes)
	{
		if ( strcmp(GetUserName(playerid), Producoes[producaoid][Dono], false) == 0 )
		{
			SendClientMessage(playerid, COR_BRANCO, "» Você não colheu sua(eu) {"COR_VERMELHO_INC"}%s{"COR_BRANCO_INC"} e ela foi destruida!", Producoes[producaoid][Tipo]);

			format(Producoes[producaoid][Tipo], 10, "Nada"), format(Producoes[producaoid][Dono], MAX_PLAYER_NAME, "Ninguem"), Producoes[producaoid][SendoUsada] = 0;

			new query[130];
			mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_PRODUCOES" SET `username`='Ninguem',`produzindo`='Nada',`sendousada`='0' WHERE `id`='%d' LIMIT 1;", Producoes[producaoid][Dono], Producoes[producaoid][Tipo], Producoes[producaoid][SendoUsada], Producoes[producaoid][ID]);
			mysql_tquery(getConexao(), query);
			call::PRODUCAO->UpdateProducaoLabel(producaoid);
			break;
		}
	}
	return true;
}

forward Coletando(playerid);
public Coletando(playerid)
{
	new producaoid = call::PRODUCAO->GetProducaoID(playerid, 2.0);
	
	if ( !call::PRODUCAO->IsValidProducao(producaoid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo a uma produção.");

	new producao = random(5, 1), ValoraPagar = random(3000, 1500);

	SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid) + 2);

	TogglePlayerControllable(playerid, true);

	DestroyDynamicObject(ObjectProd[playerid]);

	GivePlayerMoney(playerid, ValoraPagar);

	SendClientMessage(playerid, COR_BRANCO, "* Você produziu {"COR_VERMELHO_INC"}%d{"COR_BRANCO_INC"} Kg de {"COR_VERMELHO_INC"}%s{"COR_BRANCO_INC"}, recebeu {088A08}R$%s{"COR_BRANCO_INC"} por sua produção!", producao, Producoes[producaoid][Tipo], RealStr(ValoraPagar));

	new query[130];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_PRODUCOES" SET `username`='Ninguem',`produzindo`='Nada',`sendousada`='0' WHERE `id`='%d' LIMIT 1;", Producoes[producaoid][ID]);
	mysql_tquery(getConexao(), query);

	/**
	*
	*	Coletando drogas
	*
	**/
	
	if(strcmp(Producoes[producaoid][Tipo], "Cocaina", true) == 0)
		call::PLAYER->SetPlayerVarInt(playerid, Cocaina, call::PLAYER->GetPlayerVarInt(playerid, Cocaina) + producao);
	else if(strcmp(Producoes[producaoid][Tipo], "Crack", true) == 0)
		call::PLAYER->SetPlayerVarInt(playerid, Crack, call::PLAYER->GetPlayerVarInt(playerid, Crack) + producao);

	query[0] = EOS;
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `%s`=`%s`+'%d' WHERE `id`='%d' LIMIT 1;", Producoes[producaoid][Tipo], Producoes[producaoid][Tipo], producao, call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
	mysql_tquery(getConexao(), query);
	

	/**
	*
	*	reset
	*
	**/

	_Producao[playerid][Plantou] = 0, _Producao[playerid][Tempo] = false, _Producao[playerid][_Coletando] = false;
	Producoes[producaoid][SendoUsada] = 0, format(Producoes[producaoid][Dono], 70, "Ninguem", format(Producoes[producaoid][Tipo], 10, "Nada"));
	TimerProducao[playerid]=0;
	
	call::PRODUCAO->UpdateProducaoLabel(producaoid);
	return true;
}