#define MAX_ARVORES 8
#define INVALID_ARVORE_ID 						(MAX_ARVORES + 1)
#define VALOR_CADA_SEMENTE 50
#define minutos(%0) (1000 * %0 * 60)

enum e_APLANTACAO
{
	ID,
	Dono[MAX_PLAYER_NAME],
	Float: Entrada[e_POSITION],
	SendoUsada,
	Text3D:Label
}
new 
	Aplantacao[MAX_ARVORES][e_APLANTACAO], Iterator:Aplantacao<MAX_ARVORES>;

enum e_Player_APLANTACAO
{
	bool:_Coletando,
	bool: Tempo,
	Plantou
}
new 
	_Aplantacao[MAX_PLAYERS][e_Player_APLANTACAO], TimeraPlantacao[MAX_PLAYERS], ObjectArvore[MAX_PLAYERS], CP_LENHADOR, PlayerBar:pBarP[MAX_PLAYERS], LifeP[MAX_PLAYERS]
;

new VehicleLENHADOR[5];

// ================================ [ FUNCTIONS ] =============================== //
const APLANTACAO_LENG_RENDER_VAR = 128;

stock static function ARVORE::render_string(plantacaoid)
{
	new s[APLANTACAO_LENG_RENDER_VAR];
	
	if(!Aplantacao[plantacaoid][SendoUsada])
		format(s, APLANTACAO_LENG_RENDER_VAR, "Plantação\nLenhador(a): {"COR_VERMELHO_INC"}Ninguem{"COR_BRANCO_INC"}");
	
	else
		format(s, APLANTACAO_LENG_RENDER_VAR, "Plantação\nLenhador(a): {"COR_VERDE_INC"}%s{"COR_BRANCO_INC"}", Aplantacao[plantacaoid][Dono]);
	
	return s;
}

function ARVORE::UpdateArvoreLabel(plantacaoid)
{
	if( !call::ARVORE->IsValidArvore(plantacaoid) )
		return false;

	UpdateDynamic3DTextLabelText(Aplantacao[plantacaoid][Label], COR_BRANCO, call::ARVORE->render_string(plantacaoid));
	return true;
}

function ARVORE::GetArvoreID(playerid, Float:range=2.0)
{

	foreach(new plantacaoid: Aplantacao)
	{
		if(!call::ARVORE->IsValidArvore(plantacaoid))
			return false;

		if(IsPlayerInRangeOfPoint(playerid, range, Aplantacao[plantacaoid][Entrada][X], Aplantacao[plantacaoid][Entrada][Y], Aplantacao[plantacaoid][Entrada][Z]))
			return plantacaoid;
	}
	return INVALID_ARVORE_ID;
}

function ARVORE::IsPlayerArvore(playerid, Float:range=2.0)
{

	foreach(new plantacaoid: Aplantacao)
	{
		if(!call::ARVORE->IsValidArvore(plantacaoid))
			return false;

		if(IsPlayerInRangeOfPoint(playerid, range, Aplantacao[plantacaoid][Entrada][X], Aplantacao[plantacaoid][Entrada][Y], Aplantacao[plantacaoid][Entrada][Z]))
			return true;
	}
	return false;
}

function ARVORE::IsValidArvore(plantacaoid)
{
	if(plantacaoid < 0 || plantacaoid > sizeof(Plantacao))
		return false;

	return (Iter_Contains(Aplantacao, plantacaoid) && !isnull(Aplantacao[plantacaoid][Dono]));
}

stock function ARVORE::resetVar(playerid)
{
	if ( TimeraPlantacao[playerid] )
	{
		KillTimer(TimeraPlantacao[playerid]);
		TimeraPlantacao[playerid]=0;
	}

	if(_Aplantacao[playerid][Plantou] == 1)
	{
		DestroyDynamicObject(ObjectArvore[playerid]);
		_Aplantacao[playerid][Tempo] = false, _Aplantacao[playerid][Plantou] = 0, _Aplantacao[playerid][_Coletando] = false;
		foreach(new plantacaoid: Aplantacao)
		{
			if ( strcmp(GetUserName(playerid), Aplantacao[plantacaoid][Dono], false) == 0 )
			{
				format(Aplantacao[plantacaoid][Dono], MAX_PLAYER_NAME, "Ninguem"), Aplantacao[plantacaoid][SendoUsada] = 0;

				new query[130];
				mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_PLANTACAO" SET `username`='Ninguem',`sendousada`='0' WHERE `id`='%d' LIMIT 1;", Aplantacao[plantacaoid][Dono], Aplantacao[plantacaoid][SendoUsada], Aplantacao[plantacaoid][ID]);
				mysql_tquery(getConexao(), query);
				call::ARVORE->UpdateArvoreLabel(plantacaoid);
				break;
			}
		}
	}
}
// ================================== [ CALLBACKS ] ============================== //
#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	CreateDynamicActor(11, -435.5748,-59.1107,58.8750,179.5380, 1, 100.0, 0); // ator 
	CP_LENHADOR = CreateDynamicCP(-435.6280,-59.8546,58.8750, 1.1, .streamdistance=20.0, .interiorid=0);

	CreateDynamic3DTextLabel("Compra de sementes\nValor cada uma: {"COR_VERDE_INC"}R$"#VALOR_CADA_SEMENTE"", COR_BRANCO, -435.6280,-59.8546,58.8750, 50.0, .streamdistance=40.0, .interiorid=0, .worldid=0, .testlos=1); // "


	VehicleLENHADOR[0] = CreateVehicle(471,-446.8942,-56.7552,58.8604,182.1779, 236,236, TIME_VEHICLE_SPAWN);
	VehicleLENHADOR[1] = CreateVehicle(471,-453.9212,-52.2240,59.2789,85.3795, 236,236, TIME_VEHICLE_SPAWN);
	VehicleLENHADOR[2] = CreateVehicle(471,-453.7847,-49.8817,59.2715,88.3307, 236,236, TIME_VEHICLE_SPAWN);
	VehicleLENHADOR[3] = CreateVehicle(471,-453.5647,-47.2554,59.2897,90.0129, 236,236, TIME_VEHICLE_SPAWN);
	VehicleLENHADOR[4] = CreateVehicle(471,-453.5804,-44.6091,59.3176,88.8604, 236,236, TIME_VEHICLE_SPAWN);

	call::JOB->SetVehicleJob(VehicleLENHADOR[0], LENHADOR);
	call::JOB->SetVehicleJob(VehicleLENHADOR[1], LENHADOR);
	call::JOB->SetVehicleJob(VehicleLENHADOR[2], LENHADOR);
	call::JOB->SetVehicleJob(VehicleLENHADOR[3], LENHADOR);
	call::JOB->SetVehicleJob(VehicleLENHADOR[4], LENHADOR);

	new Cache:cache = mysql_query(getConexao(), "SELECT * FROM "TABLE_PLANTACAO"", true), rows = cache_num_rows();

	if(rows)
	{
		for(new i; i < rows; i++)
		{
			Iter_Add(Aplantacao, i);

			cache_get_value_name_int(i, "id", Aplantacao[i][ID]);
			cache_get_value_name_int(i, "sendousada", Aplantacao[i][SendoUsada]);

			cache_get_value_name(i, "username", Aplantacao[i][Dono], MAX_PLAYER_NAME);
				
			cache_get_value_name_float(i, "localx", Aplantacao[i][Entrada][X]);
			cache_get_value_name_float(i, "localy", Aplantacao[i][Entrada][Y]);
			cache_get_value_name_float(i, "localz", Aplantacao[i][Entrada][Z]);

			Aplantacao[i][Label] = CreateDynamic3DTextLabel(call::ARVORE->render_string(i), COR_BRANCO, Aplantacao[i][Entrada][X], Aplantacao[i][Entrada][Y], Aplantacao[i][Entrada][Z] + 0.3, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0, -1, 20.0);
		}
	}
	cache_delete(cache);

	return true;
}

hook OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	if(checkpointid == CP_LENHADOR)
	{
		if ( call::PLAYER->GetPlayerVarInt(playerid, Profissao) != LENHADOR )
			return Y_HOOKS_CONTINUE_RETURN_1;

	    ShowPlayerDialog(playerid, Dialog_Viveiro, DIALOG_STYLE_INPUT, "{"COR_VERMELHO_INC"}* Loja de Sementes preço: {088A08}R$"#VALOR_CADA_SEMENTE" cada", "Digite o número de sementes a serem compradas.", "Confirmar", "Fechar");
		return Y_HOOKS_BREAK_RETURN_1;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if ( call::PLAYER->GetPlayerVarInt(playerid, Profissao) != LENHADOR )
		return Y_HOOKS_CONTINUE_RETURN_1;
		
	if( PRESSED(KEY_FIRE))
	{
		if ( GetPlayerWeapon(playerid) != 9)
			return Y_HOOKS_CONTINUE_RETURN_1;

		if(_Aplantacao[playerid][Tempo] == true)
		return false;

		if(_Aplantacao[playerid][Plantou] == 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está usando uma plantação.");

		new plantacaoid = call::ARVORE->GetArvoreID(playerid, 2.0);

		if( !call::ARVORE->IsValidArvore(plantacaoid) )
			return false;

		if(strcmp(GetUserName(playerid), Aplantacao[plantacaoid][Dono], true) != 0)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Está plantação não é sua.");

		LifeP[playerid] -= random(12, 6);
		SetPlayerProgressBarValue(playerid, pBarP[playerid], LifeP[playerid]);
		if(LifeP[playerid] <= 0)
		{
			new ValoraPagar = 400 + random (100);
			SetPlayerAmmo(playerid, 9, 0);

			GivePlayerMoney(playerid, ValoraPagar);

			SendClientMessage(playerid, COR_AVISO, "| INFO | {ffffff}Você cortou o {"COR_VERMELHO_INC"}Pinheiro{"COR_BRANCO_INC"} e recebeu {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"} pelo serviço.", RealStr(ValoraPagar));

			/**
			*
			*	reset
			*
			**/

			KillTimer(TimeraPlantacao[playerid]), DestroyDynamicObject(ObjectArvore[playerid]), DestroyPlayerProgressBar(playerid, pBarP[playerid]);

			_Aplantacao[playerid][Plantou] = 0, _Aplantacao[playerid][Tempo] = false, _Aplantacao[playerid][_Coletando] = false;
			Aplantacao[plantacaoid][SendoUsada] = 0, format(Aplantacao[plantacaoid][Dono], 70, "Ninguem");
			TimeraPlantacao[playerid]=0;
	
			call::ARVORE->UpdateArvoreLabel(plantacaoid);
			return Y_HOOKS_CONTINUE_RETURN_1;
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnGameModeExit()
{
	new query[100];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_PLANTACAO" SET `username`='Ninguem',`sendousada`='0' WHERE 1;");
	mysql_tquery(getConexao(), query);
}

hook OnPlayerDisconnect(playerid, reason)
{
	call::ARVORE->resetVar(playerid);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

// ====================================== [ COMANDOS ] =================================== //
CMD:plantararvore(playerid, params[])
{
	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != LENHADOR)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte da profissão de Lenhador");

	//if ( !call::JOB->IsPlayerInWorking(playerid) )
	//	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");

	new plantacaoid = call::ARVORE->GetArvoreID(playerid, 2.0);

	if(!call::ARVORE->IsValidArvore(plantacaoid))
		return false;

	if(!call::ARVORE->IsPlayerArvore(playerid, 2.0))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo a nenhuma plantação.");

	if(strcmp(Aplantacao[plantacaoid][Dono], "Ninguem", true) != 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Está plantação já tem dono.");

	if(Aplantacao[plantacaoid][SendoUsada] == 1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Essa plantação já está sendo utilizada.");

	if(_Aplantacao[playerid][Plantou] == 1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está usando uma plantação.");

	if(call::PLAYER->GetPlayerVarInt(playerid, SementesL) == 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem sementes para plantar.");

	if ( TimeraPlantacao[playerid] )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está usando uma plantação.");

	TogglePlayerControllable(playerid, false);

	ApplyAnimation(playerid,"BOMBER","BOM_Plant_Loop", 2.0, 1, 0, 0, 0, 0);	

    SetPlayerAttachedObject(playerid, 2, 337, 6, 0.097999, 0.076999, 0.011000, 172.699859, -4.799996, 89.199981, 1.000000, 0.629000, 0.678000);
    TimeraPlantacao[playerid] = SetTimerEx("PlantandoArvore", 4000, false, "i", playerid);
    GameTextForPlayer(playerid, "~b~Plantando Arvore...", 4500, 3);

	return true;
}

// ============================= [ Dialogs ] ========================================= //
Dialog:Dialog_Viveiro(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if ( isnull(inputtext) || !IsNumeric(inputtext))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você tem que digitar um número válido.");

		new sementes = strval(inputtext);

		/*if(sementes > 10)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode comprar mais de 10 sementes.");*/

		if( (VALOR_CADA_SEMENTE * sementes) > GetPlayerMoney(playerid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente.");

		/*if( call::PLAYER->GetPlayerVarInt(playerid, SementesL) >= 15)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já tem o máximo de Sementes para plantar.");*/

		GivePlayerMoney(playerid, -(VALOR_CADA_SEMENTE * sementes) );
		call::PLAYER->SetPlayerVarInt(playerid, SementesL, call::PLAYER->GetPlayerVarInt(playerid, SementesL) + strval(inputtext));

		new query[128];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `sementesl`='%d' WHERE `id`='%d' LIMIT 1;", call::PLAYER->GetPlayerVarInt(playerid, SementesL), call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
		mysql_tquery(getConexao(), query);

		SendClientMessage(playerid, COR_BRANCO, "* Você comprou {"COR_AMARELO_INC"}%d{"COR_BRANCO_INC"} sementes no valor de {088A08}R$%s{"COR_BRANCO_INC"}.", sementes, RealStr(VALOR_CADA_SEMENTE * sementes));
	}
	return true;
}

// =============================== [ Publics/forwards ] ====================================== //
forward PlantandoArvore(playerid);
public PlantandoArvore(playerid)
{
	new plantacaoid = call::ARVORE->GetArvoreID(playerid, 2.0);

	_Aplantacao[playerid][Plantou] = 1, _Aplantacao[playerid][Tempo] = true, call::PLAYER->SetPlayerVarInt(playerid, SementesL, call::PLAYER->GetPlayerVarInt(playerid, SementesL) -1);
    RemovePlayerAttachedObject(playerid, 2), ClearAnimations(playerid);
    TimeraPlantacao[playerid]=0, GivePlayerWeapon(playerid, 9, 1);
    LifeP[playerid] = random(100, 50);

    format(Aplantacao[plantacaoid][Dono], MAX_PLAYER_NAME,GetUserName(playerid));
    Aplantacao[plantacaoid][SendoUsada] = 1;

    TogglePlayerControllable(playerid, true);
	
	SendClientMessage(playerid, COR_VERDE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, COR_AVISO, "» {ffffff}Nick: {"COR_VERDE_INC"}%s", GetUserName(playerid));
	SendClientMessage(playerid, COR_AVISO, "» {ffffff}Sementes: {"COR_AMARELO_INC"}%d", call::PLAYER->GetPlayerVarInt(playerid, SementesL));
	SendClientMessage(playerid, COR_AVISO, "» {ffffff}Você plantou uma semente de {"COR_VERMELHO_INC"}Pinheiro{"COR_BRANCO_INC"}, aguarde!");
	SendClientMessage(playerid, COR_VERDE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	TimeraPlantacao[playerid] = SetTimerEx("ArvoreCrescer", 90000, false, "d", playerid);

	new query[130];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_PLANTACAO" SET `username`='%s',`sendousada`='1' WHERE `id`='%d' LIMIT 1;", Aplantacao[plantacaoid][Dono], Aplantacao[plantacaoid][SendoUsada], Aplantacao[plantacaoid][ID]);
	mysql_tquery(getConexao(), query);

	query[0] = EOS;
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `sementesl`='%d' WHERE `id`='%d';", call::PLAYER->GetPlayerVarInt(playerid, SementesL), call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
	mysql_tquery(getConexao(), query);

	print(query);

	call::ARVORE->UpdateArvoreLabel(plantacaoid);
	return true;
}

forward ArvoreCrescer(playerid);
public ArvoreCrescer(playerid)
{
	SendClientMessage(playerid, COR_AVISO, "| INFO | {ffffff}Seu {"COR_VERMELHO_INC"}Pinheiro{"COR_BRANCO_INC"} está pronto para ser retirado, não demore para retirá-lo!");
	LifeP[playerid] = random(200, 50);
	_Aplantacao[playerid][Tempo] = false;

	pBarP[playerid] = CreatePlayerProgressBar(playerid, 1.0, 443.0, 641.5, 3.2, GetPlayerColor(playerid), 100.0000, 0);
	ShowPlayerProgressBar(playerid, pBarP[playerid]);

	TimeraPlantacao[playerid] = SetTimerEx("RetirarArvore", minutos(3), false, "d", playerid);

	foreach(new plantacaoid: Aplantacao)
	{
		if ( strcmp(GetUserName(playerid), Aplantacao[plantacaoid][Dono], false) == 0 )
		{
			ObjectArvore[playerid] = CreateDynamicObject(881,  Aplantacao[plantacaoid][Entrada][X],  Aplantacao[plantacaoid][Entrada][Y], 58.70660,   0.00000, 0.00000, 0.00000);
			return true;
		}
	}
	return true;
}

forward RetirarArvore(playerid);
public RetirarArvore(playerid)
{
	_Aplantacao[playerid][Plantou] = 0, _Aplantacao[playerid][Tempo] = false, _Aplantacao[playerid][_Coletando] = false;
	TimeraPlantacao[playerid]=0;
	RemovePlayerAttachedObject(playerid, 2), ClearAnimations(playerid), DestroyDynamicObject(ObjectArvore[playerid]);

	SendClientMessage(playerid, COR_AVISO, "| INFO | {ffffff}Você não retirou seu {"COR_VERMELHO_INC"}Pinheiro{"COR_BRANCO_INC"} e ele foi destruido!");

	foreach(new plantacaoid: Aplantacao)
	{
		if ( strcmp(GetUserName(playerid), Aplantacao[plantacaoid][Dono], false) == 0 )
		{
			format(Aplantacao[plantacaoid][Dono], MAX_PLAYER_NAME, "Ninguem"), Aplantacao[plantacaoid][SendoUsada] = 0;

			new query[130];
			mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_PLANTACAO" SET `username`='Ninguem',`sendousada`='0' WHERE `id`='%d' LIMIT 1;", Aplantacao[plantacaoid][Dono], Aplantacao[plantacaoid][SendoUsada], Aplantacao[plantacaoid][ID]);
			mysql_tquery(getConexao(), query);
			call::ARVORE->UpdateArvoreLabel(plantacaoid);
			break;
		}
	}
	return true;
}