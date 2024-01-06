#define MAX_PLANTACOES 9
#define INVALID_PLANTACAO_ID 						(MAX_PLANTACOES + 1)
#define VALOR_POR_SEMENTES 							300
#define minutos(%0) (1000 * %0 * 60)

enum e_PLANTACAO
{
	ID,
	Dono[MAX_PLAYER_NAME],
	Tipo[10],
	Float: Entrada[e_POSITION],
	SendoUsada,
	Text3D:Label
}
new 
	Plantacao[MAX_PLANTACOES][e_PLANTACAO], Iterator:Plantacao<MAX_PLANTACOES>;

enum e_Player_PLANTACAO
{
	bool:_Coletando,
	bool: Tempo,
	Plantou
}
new 
	_Plantacao[MAX_PLAYERS][e_Player_PLANTACAO], TimerPlantacao[MAX_PLAYERS], ActorProdutor, ObjectPlant[MAX_PLAYERS];



// ================================ [ FUNCTIONS ] =============================== //
const PLANTACAO_LENG_RENDER_VAR = 128;

stock static function PLANTACAO::render_string(plantacaoid)
{
	new s[PLANTACAO_LENG_RENDER_VAR];
	
	if(!Plantacao[plantacaoid][SendoUsada])
		format(s, PLANTACAO_LENG_RENDER_VAR, "Plantação\nProdutor(a): {"COR_VERMELHO_INC"}Ninguem{"COR_BRANCO_INC"}\nCultivando: {088A08}Nada");
	
	else
		format(s, PLANTACAO_LENG_RENDER_VAR, "Plantação\nProdutor(a): {"COR_VERDE_INC"}%s{"COR_BRANCO_INC"}\nCultivando: {088A08}%s.", Plantacao[plantacaoid][Dono], Plantacao[plantacaoid][Tipo]);
	
	return s;
}

function PLANTACAO::UpdatePlantacaoLabel(plantacaoid)
{
	if( !call::PLANTACAO->IsValidPlantacao(plantacaoid) )
		return false;

	UpdateDynamic3DTextLabelText(Plantacao[plantacaoid][Label], COR_BRANCO, call::PLANTACAO->render_string(plantacaoid));
	return true;
}

function PLANTACAO::GetPlantacaoID(playerid, Float:range=2.0)
{

	foreach(new plantacaoid: Plantacao)
	{
		if(!call::PLANTACAO->IsValidPlantacao(plantacaoid))
			return false;

		if(IsPlayerInRangeOfPoint(playerid, range, Plantacao[plantacaoid][Entrada][X], Plantacao[plantacaoid][Entrada][Y], Plantacao[plantacaoid][Entrada][Z]))
			return plantacaoid;
	}
	return INVALID_PLANTACAO_ID;
}

function PLANTACAO::IsPlayerPlantacao(playerid, Float:range=2.0)
{

	foreach(new plantacaoid: Plantacao)
	{
		if(!call::PLANTACAO->IsValidPlantacao(plantacaoid))
			return false;

		if(IsPlayerInRangeOfPoint(playerid, range, Plantacao[plantacaoid][Entrada][X], Plantacao[plantacaoid][Entrada][Y], Plantacao[plantacaoid][Entrada][Z]))
			return true;
	}
	return false;
}

function PLANTACAO::IsValidPlantacao(plantacaoid)
{
	if(plantacaoid < 0 || plantacaoid > sizeof(Plantacao))
		return false;

	return (Iter_Contains(Plantacao, plantacaoid) && !isnull(Plantacao[plantacaoid][Dono]));
}

stock function PLANTACAO::resetVar(playerid)
{
	if ( TimerPlantacao[playerid] )
	{
		KillTimer(TimerPlantacao[playerid]);
		TimerPlantacao[playerid]=0;
	}

	if(_Plantacao[playerid][Plantou] == 1)
	{
		DestroyDynamicObject(ObjectPlant[playerid]);
		_Plantacao[playerid][Tempo] = false, _Plantacao[playerid][Plantou] = 0, _Plantacao[playerid][_Coletando] = false;
		foreach(new plantacaoid: Plantacao)
		{
			if ( strcmp(GetUserName(playerid), Plantacao[plantacaoid][Dono], false) == 0 )
			{
				format(Plantacao[plantacaoid][Tipo], 10, "Nada"), format(Plantacao[plantacaoid][Dono], MAX_PLAYER_NAME, "Ninguem"), Plantacao[plantacaoid][SendoUsada] = 0;

				new query[130];
				mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_PLANTACOES" SET `username`='Ninguem',`plantando`='Nada',`sendousada`='0' WHERE `id`='%d' LIMIT 1;", Plantacao[plantacaoid][Dono], Plantacao[plantacaoid][Tipo], Plantacao[plantacaoid][SendoUsada], Plantacao[plantacaoid][ID]);
				mysql_tquery(getConexao(), query);
				call::PLANTACAO->UpdatePlantacaoLabel(plantacaoid);
				break;
			}
		}
	}
}
// ================================== [ CALLBACKS ] ============================== //
#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	ActorProdutor = CreateDynamicActor(293, 2523.9048, -2207.8892, 17.3572, 12.6498, 1, 100.0, 0); // ator 
	ApplyDynamicActorAnimation(ActorProdutor, "PED", "IDLE_CHAT", 4.1, 1, 1, 1, 1, 0);

	new actor_4 = CreateDynamicActor(271, -1450.5469, -1467.5693, 101.7578, 83.7746, 1, .worldid=0, .interiorid=0);
	ApplyDynamicActorAnimation(actor_4,"SMOKING", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0);
	

	CreateDynamicCP(2523.9565, -2206.6477, 17.3572, 1.0, .interiorid=0, .streamdistance=10.0);
	CreateDynamic3DTextLabel("Use: {"COR_AMARELO_INC"}/ComprarSementes {ffffff}ou {"COR_AMARELO_INC"}/ComprarMaterias.", COR_BRANCO, 2523.9565, -2206.6477, 17.3572, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 8.0);

	new Cache:cache = mysql_query(getConexao(), "SELECT * FROM "TABLE_PLANTACOES"", true), rows = cache_num_rows();

	if(rows)
	{
		for(new i; i < rows; i++)
		{
			Iter_Add(Plantacao, i);

			cache_get_value_name_int(i, "id", Plantacao[i][ID]);
			cache_get_value_name_int(i, "sendousada", Plantacao[i][SendoUsada]);

			cache_get_value_name(i, "username", Plantacao[i][Dono], MAX_PLAYER_NAME);
			cache_get_value_name(i, "plantando", Plantacao[i][Tipo]);
				
			cache_get_value_name_float(i, "localx", Plantacao[i][Entrada][X]);
			cache_get_value_name_float(i, "localy", Plantacao[i][Entrada][Y]);
			cache_get_value_name_float(i, "localz", Plantacao[i][Entrada][Z]);

			Plantacao[i][Label] = CreateDynamic3DTextLabel(call::PLANTACAO->render_string(i), COR_BRANCO, Plantacao[i][Entrada][X], Plantacao[i][Entrada][Y], Plantacao[i][Entrada][Z] + 0.3, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0, -1, 20.0);
		}
	}
	cache_delete(cache);
	return true;
}

hook OnGameModeExit()
{
	new query[100];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_PLANTACOES" SET `username`='Ninguem',`plantando`='Nada',`sendousada`='0' WHERE 1;");
	mysql_tquery(getConexao(), query);
}

hook OnPlayerDisconnect(playerid, reason)
{
	
	call::PLANTACAO->resetVar(playerid);
	return Y_HOOKS_CONTINUE_RETURN_1;
}
// ======================================== [ COMANDOS ] ================================== //

CMD:plantar(playerid, params[])
{
	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != PLANTADOR)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte da profissão de Plantador de Drogas");

	new plantacaoid = call::PLANTACAO->GetPlantacaoID(playerid, 2.0);

	if(!call::PLANTACAO->IsValidPlantacao(plantacaoid))
		return false;

	if(!call::PLANTACAO->IsPlayerPlantacao(playerid, 2.0))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo a nenhuma plantação");

	//if ( !call::JOB->IsPlayerInWorking(playerid) )
	//	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");

	if(strcmp(Plantacao[plantacaoid][Dono], "Ninguem", true) != 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Está plantação já tem dono.");

	if(Plantacao[plantacaoid][SendoUsada] == 1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Essa plantação já está sendo utilizada.");

	if(call::PLAYER->GetPlayerVarInt(playerid, Sementes) == 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem sementes para plantar.");

	if(_Plantacao[playerid][Plantou] == 1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está usando uma plantação.");

	if ( TimerPlantacao[playerid] )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está plantando sua droga.");

	TogglePlayerControllable(playerid, false);

	ApplyAnimation(playerid,"BOMBER","BOM_Plant_Loop", 2.0, 1, 0, 0, 0, 0);	

    SetPlayerAttachedObject(playerid, 2, 337, 6, 0.097999, 0.076999, 0.011000, 172.699859, -4.799996, 89.199981, 1.000000, 0.629000, 0.678000);
    TimerPlantacao[playerid] = SetTimerEx("Plantando", 4000, false, "i", playerid);
    GameTextForPlayer(playerid, "~r~Plantando...", 4500, 3);
	return true;
}

CMD:colher(playerid, params[])
{
	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != PLANTADOR)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte da profissão de Plantador de Drogas");

	//if ( !call::JOB->IsPlayerInWorking(playerid) )
	//	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");

	if(_Plantacao[playerid][Tempo] == true)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Sua colheita ainda não está pronta.");

	if(_Plantacao[playerid][Plantou] == 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está usando uma plantação.");

	if( !call::PLANTACAO->IsPlayerPlantacao(playerid, 2.0) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo a nenhuma plantação");

	new plantacaoid = call::PLANTACAO->GetPlantacaoID(playerid, 2.0);

	if( !call::PLANTACAO->IsValidPlantacao(plantacaoid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo a uma plantação de Drogas.");

	if(strcmp(GetUserName(playerid), Plantacao[plantacaoid][Dono], true) != 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Está plantação não é sua.");

	if ( _Plantacao[playerid][_Coletando] )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está colhendo, aguarde...");

	KillTimer(TimerPlantacao[playerid]);

	TogglePlayerControllable(playerid, false);
	
	_Plantacao[playerid][_Coletando] = true;
    
    SetPlayerAttachedObject(playerid, 2, 337, 6, 0.097999, 0.076999, 0.011000, 172.699859, -4.799996, 89.199981, 1.000000, 0.629000, 0.678000);
   
    ApplyAnimation(playerid,"BOMBER","BOM_Plant_Loop", 2.0, 1, 0, 0, 0, 0);
    
    SetTimerEx("Colhendo", 6000, false, "i", playerid);
    GameTextForPlayer(playerid, "~r~Colhendo...", 6000, 3);
	return true;
}

CMD:comprarsementes(playerid)
{
	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != PLANTADOR)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte da profissão de Plantador de Drogas");

	if(!IsPlayerInRangeOfPoint(playerid, 2.0, 2523.9565, -2206.6477, 17.3572))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está no porto para comprar sementes.");

	if( call::PLAYER->GetPlayerVarInt(playerid, Sementes) >= 15)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já tem o máximo de sementes para produzir.");

	ShowPlayerDialog(playerid, Dialog_Porto, DIALOG_STYLE_INPUT, "{"COR_VERMELHO_INC"}* Loja de Sementes preço: {088A08}R$300 cada", "Digite o número de sementes a serem compradas.", "Confirmar", "Fechar");
	return true;
}

CMD:porto(playerid)
{
	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != PLANTADOR && (call::PLAYER->GetPlayerVarInt(playerid, Profissao) != PRODUTOR))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte da profissão de Plantador de Drogas");

	//if ( !call::JOB->IsPlayerInWorking(playerid) )
	//	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");

	call::PLAYER->SetPlayerMarkGPS(playerid, 2523.9565, -2206.6477, 17.3572);
	SendClientMessage(playerid, COR_AVISO, "| INFO | Porto foi marcado em seu mapa.");
	return true;
}

Dialog:Dialog_Porto(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if ( isnull(inputtext) || !IsNumeric(inputtext))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você tem que digitar um número válido.");

		new sementes = strval(inputtext);

		if( (VALOR_POR_SEMENTES * sementes) > GetPlayerMoney(playerid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente.");

		if ( (call::PLAYER->GetPlayerVarInt(playerid, Sementes) + sementes ) > 15 )
    		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode possuir mais que 15 sementes.");


		GivePlayerMoney(playerid, -(VALOR_POR_SEMENTES * sementes) );
		call::PLAYER->SetPlayerVarInt(playerid, Sementes, call::PLAYER->GetPlayerVarInt(playerid, Sementes) + strval(inputtext));

		new query[128];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `sementes`='%d' WHERE `id`='%d' LIMIT 1;", call::PLAYER->GetPlayerVarInt(playerid, Sementes), call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
		mysql_tquery(getConexao(), query);

		SendClientMessage(playerid, COR_BRANCO, "* Você comprou {"COR_AMARELO_INC"}%d{"COR_BRANCO_INC"} sementes no valor de {088A08}R$%s{"COR_BRANCO_INC"}.", sementes, RealStr(VALOR_POR_SEMENTES * sementes));
	}
	return true;
}

forward Plantando(playerid);
public Plantando(playerid)
{
	new plantacaoid = call::PLANTACAO->GetPlantacaoID(playerid, 2.0);

	_Plantacao[playerid][Plantou] = 1, _Plantacao[playerid][Tempo] = true, call::PLAYER->SetPlayerVarInt(playerid, Sementes, call::PLAYER->GetPlayerVarInt(playerid, Sementes) -1);
    RemovePlayerAttachedObject(playerid, 2), ClearAnimations(playerid);
    TimerPlantacao[playerid]=0;

    format(Plantacao[plantacaoid][Tipo], 10, "Maconha");
    format(Plantacao[plantacaoid][Dono], MAX_PLAYER_NAME,GetUserName(playerid));
    Plantacao[plantacaoid][SendoUsada] = 1;

    TogglePlayerControllable(playerid, true);

    SendClientMessage(playerid, COR_VERDE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, COR_AVISO, "» {ffffff}Nick: {"COR_VERDE_INC"}%s", GetUserName(playerid));
	SendClientMessage(playerid, COR_AVISO, "» {ffffff}Sementes: {"COR_AMARELO_INC"}%d", call::PLAYER->GetPlayerVarInt(playerid, SementesL));
	SendClientMessage(playerid, COR_AVISO, "» {ffffff}Você plantou {"COR_AMARELO_INC"}1{"COR_BRANCO_INC"} de semente de {"COR_VERMELHO_INC"}%s{"COR_BRANCO_INC"}, aguarde!", Plantacao[plantacaoid][Tipo]);
	SendClientMessage(playerid, COR_VERDE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

	TimerPlantacao[playerid] = SetTimerEx("PlantaCrescer", minutos(3), false, "d", playerid);

	new query[130];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_PLANTACOES" SET `username`='%s',`plantando`='%s',`sendousada`='1' WHERE `id`='%d' LIMIT 1;", Plantacao[plantacaoid][Dono], Plantacao[plantacaoid][Tipo], Plantacao[plantacaoid][SendoUsada], Plantacao[plantacaoid][ID]);
	mysql_tquery(getConexao(), query);

	query[0] = EOS;
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `sementes`='%d' WHERE `id`='%d';", call::PLAYER->GetPlayerVarInt(playerid, Sementes), call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
	mysql_tquery(getConexao(), query);
	print(query);

	call::PLANTACAO->UpdatePlantacaoLabel(plantacaoid);
	return true;
}

forward PlantaCrescer(playerid);
public PlantaCrescer(playerid)
{
	SendClientMessage(playerid, COR_AVISO, "| INFO | {ffffff}Sua {"COR_VERMELHO_INC"}Maconha{"COR_BRANCO_INC"} está pronta para ser colhida, não demore para colhe-las!");
	_Plantacao[playerid][Tempo] = false;
	TimerPlantacao[playerid] = SetTimerEx("ExpirandoColheita", minutos(3), false, "d", playerid);

	foreach(new plantacaoid: Plantacao)
	{
		if ( strcmp(GetUserName(playerid), Plantacao[plantacaoid][Dono], false) == 0 )
		{
			ObjectPlant[playerid] = CreateDynamicObject(19473,  Plantacao[plantacaoid][Entrada][X],  Plantacao[plantacaoid][Entrada][Y], 100.06420,   0.00000, 0.00000, 0.00000);
			return true;
		}
	}
	return true;
}

forward ExpirandoColheita(playerid);
public ExpirandoColheita(playerid)
{
	_Plantacao[playerid][Plantou] = 0, _Plantacao[playerid][Tempo] = false, _Plantacao[playerid][_Coletando] = false;
	TimerPlantacao[playerid]=0;
	RemovePlayerAttachedObject(playerid, 2), ClearAnimations(playerid), DestroyDynamicObject(ObjectPlant[playerid]);

	SendClientMessage(playerid, COR_AVISO, "| INFO | {ffffff}Você não colheu sua {"COR_VERMELHO_INC"}Maconha{"COR_BRANCO_INC"} e ela foi destruida!");

	foreach(new plantacaoid: Plantacao)
	{
		if ( strcmp(GetUserName(playerid), Plantacao[plantacaoid][Dono], false) == 0 )
		{
			format(Plantacao[plantacaoid][Tipo], 10, "Nada"), format(Plantacao[plantacaoid][Dono], MAX_PLAYER_NAME, "Ninguem"), Plantacao[plantacaoid][SendoUsada] = 0;

			new query[130];
			mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_PLANTACOES" SET `username`='Ninguem',`plantando`='Nada',`sendousada`='0' WHERE `id`='%d' LIMIT 1;", Plantacao[plantacaoid][Dono], Plantacao[plantacaoid][Tipo], Plantacao[plantacaoid][SendoUsada], Plantacao[plantacaoid][ID]);
			mysql_tquery(getConexao(), query);
			call::PLANTACAO->UpdatePlantacaoLabel(plantacaoid);
			break;
		}
	}
	return true;
}

forward Colhendo(playerid);
public Colhendo(playerid)
{
	new plantacaoid = call::PLANTACAO->GetPlantacaoID(playerid, 2.0);
	
	if ( !call::PLANTACAO->IsValidPlantacao(plantacaoid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo a uma plantação.");

	new ValoraPagar = random(1750, 1050), producao = random(5, 1);

	SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid) + 1);

	TogglePlayerControllable(playerid, true);

	DestroyDynamicObject(ObjectPlant[playerid]);

	GivePlayerMoney(playerid, ValoraPagar);

	SendClientMessage(playerid, COR_BRANCO, "* Você colheu  {"COR_VERMELHO_INC"}%d{"COR_BRANCO_INC"} Kg de {"COR_VERMELHO_INC"}%s{"COR_BRANCO_INC"}, recebeu {088A08}R$%s{"COR_BRANCO_INC"} por sua produção!", producao, Plantacao[plantacaoid][Tipo], RealStr(ValoraPagar));

	RemovePlayerAttachedObject(playerid, 2), ClearAnimations(playerid);

	new query[130];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_PLANTACOES" SET `username`='Ninguem',`plantando`='Nada',`sendousada`='0' WHERE `id`='%d' LIMIT 1;", Plantacao[plantacaoid][ID]);
	mysql_tquery(getConexao(), query);

	/**
	*
	*	Colhendo drogas
	*
	**/
	
	if(strcmp(Plantacao[plantacaoid][Tipo], "Maconha", true) == 0)
		call::PLAYER->SetPlayerVarInt(playerid, Maconha, call::PLAYER->GetPlayerVarInt(playerid, Maconha) + producao);

	query[0] = EOS;
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `maconha`=`maconha`+'%d' WHERE `id`='%d' LIMIT 1;", producao, call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
	mysql_tquery(getConexao(), query);

	/**
	*
	*	reset
	*
	**/

	_Plantacao[playerid][Plantou] = 0, _Plantacao[playerid][Tempo] = false, _Plantacao[playerid][_Coletando] = false;
	Plantacao[plantacaoid][SendoUsada] = 0, format(Plantacao[plantacaoid][Dono], 10, "Ninguem", format(Plantacao[plantacaoid][Tipo], 10, "Nada"));
	TimerPlantacao[playerid]=0;
	
	call::PLANTACAO->UpdatePlantacaoLabel(plantacaoid);
	return true;
}