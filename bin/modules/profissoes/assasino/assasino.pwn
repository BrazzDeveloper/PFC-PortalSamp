new
	bool: EmContrato[MAX_PLAYERS], DinheiroContrato[MAX_PLAYERS], LocalizandoA[MAX_PLAYERS], TimerLocalizar[MAX_PLAYERS], bool: Block[MAX_PLAYERS]
;

//
forward Localizando(playerid, id);
forward BloqueandoArmas(playerid);

#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	call::JOB->SetVehicleJob(CreateVehicle(516, 886.8154, -20.7157, 63.1494, 157.6666, 0, 0, TIME_VEHICLE_SPAWN), ASSASINO);
	call::JOB->SetVehicleJob(CreateVehicle(516, 890.3300, -22.1953, 63.1004, 155.8927, 0, 0, TIME_VEHICLE_SPAWN), ASSASINO);
	call::JOB->SetVehicleJob(CreateVehicle(516, 893.5695, -23.5298, 63.0974, 156.1554, 0, 0, TIME_VEHICLE_SPAWN), ASSASINO);
	call::JOB->SetVehicleJob(CreateVehicle(581, 877.6987, -25.5591, 62.7929, 157.6170, 0, 0, TIME_VEHICLE_SPAWN), ASSASINO);
	call::JOB->SetVehicleJob(CreateVehicle(581, 880.3276, -26.8287, 62.7928, 155.6814, 0, 0, TIME_VEHICLE_SPAWN), ASSASINO);
	
	CP_ARMAS = CreateDynamicCP(865.4198, -23.1674, 63.1953, 1.0, .interiorid=0, .streamdistance=10.0);
	CreateDynamic3DTextLabel("Armas", COR_AZUL, 865.4198, -23.1674, 63.1953, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 8.0);
	
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDisconnect(playerid)
{
	EmContrato[playerid] = false, DinheiroContrato[playerid] = 0, Block[playerid] = false;
	return true;
}

hook OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	if(checkpointid == CP_ARMAS)
	{
		if ( call::PLAYER->GetPlayerVarInt(playerid, Profissao) != ASSASINO )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é um assasino.");

	    if(Block[playerid] == true) return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já pegou armas recentemente.");
	    GivePlayerWeapon(playerid, 23, 300), GivePlayerWeapon(playerid, 31, 300), GivePlayerWeapon(playerid, 34, 6);
		SendClientMessage(playerid, COR_SISTEMA, "Suas armas foram setadas.");
	    Block[playerid] = true, SetTimerEx("BloqueandoArmas", 150000, true, "i", playerid);
		return Y_HOOKS_BREAK_RETURN_1;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	if ( killerid != INVALID_PLAYER_ID)
	{
		if ( call::PLAYER->GetPlayerVarInt(killerid, Profissao) == ASSASINO )
		{
			if(EmContrato[playerid] == true)
			{
				new zone[MAX_ZONE_NAME], Float: pos[3];
				GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
				GetLocalName(pos[0], pos[1], zone, MAX_ZONE_NAME);

		 		SendClientMessageToAll(COR_VERMELHO, "| INFO | O(A) Assassino(a) %s matou o(a) jogador(a) %s na localidade de %s", GetUserName(killerid), GetUserName(playerid), zone);
			    SetPlayerWantedLevel(killerid, GetPlayerWantedLevel(killerid) + 2);
			    SendClientMessage(killerid, COR_AVISO, "Você completou um contrato e recebou: {"COR_BRANCO_INC"}%iR${"COR_AVISO_INC"} pelo serviço.", DinheiroContrato[playerid]);
			    GivePlayerMoney(killerid, DinheiroContrato[playerid]);
			    DinheiroContrato[playerid] = 0, EmContrato[playerid] = false;
			    KillTimer(TimerLocalizar[killerid]);
				DisablePlayerCheckpoint(killerid);
				return true;
			}
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

CMD:contrato(playerid, params[])
{
	new id, qtd;

	if ( call::PLAYER->GetPlayerVarInt(playerid, Profissao) == ASSASINO )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você é um Assasino e por isso não pode usar este comando.");

	if(sscanf(params, "ud", id, qtd))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/contrato [playerid/username] [Grana]");

	if(EmContrato[id] == true)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse(a) jogador(a) já está em um contrato.");

	if(id == playerid)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em si mesmo.");

	if(qtd < 800 || qtd > 2500)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você só pode digitar valores de 800R$ a 2.500R$.");

	if( call::ADMIN->IsAdminInJob(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não colocar um Admin em modo trabalho em contrato");
		

	EmContrato[id] = true;
	DinheiroContrato[id] = qtd; 
	GivePlayerMoney(playerid, -qtd);
	SendClientMessage(playerid, COR_SISTEMA, "CONTRATO: {"COR_BRANCO_INC"}Você colocou o(a) {"COR_VERMELHO_INC"}%s{"COR_BRANCO_INC"} em contrato de morte ( Preço: {"COR_VERDE_INC"}R$%s )", GetUserName(id), RealStr(DinheiroContrato[id]));
	
	foreach(new i: Player)
 	{
  		if(call::PLAYER->GetPlayerVarInt(i, Profissao) == ASSASINO)
    	{
     		SendClientMessage(i, COR_SISTEMA, "* {"COR_BRANCO_INC"}O(A) jogador(a) {"COR_VERDE_INC"}%s{"COR_BRANCO_INC"} colocou o(a) {"COR_VERMELHO_INC"}%s[%d]{"COR_BRANCO_INC"} em contrato ( Preço: {"COR_VERDE_INC"}R$%s {"COR_BRANCO_INC"}).", GetUserName(playerid), GetUserName(id), id, RealStr(DinheiroContrato[id]));
       	}
    }
	return true;
}

CMD:contratos(playerid)
{
	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != ASSASINO)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é um assasino.");

	new str[1045] = "ID\tNick\tValor\tDistância\n", Float:x, Float:y, Float:z, count, contrato[35];
	foreach(new i: Player)
	{
		if(IsPlayerConnected(i) && EmContrato[i] == true)
		{
	    	GetPlayerPos(i, x, y, z);
			format(str, sizeof(str), "%s%d\t{"COR_VERMELHO_INC"}%s\t{"COR_VERDE_INC"}%sR$\t{"COR_VERMELHO_INC"}%0.1f{"COR_BRANCO_INC"}\n", str, i, GetUserName(i), RealStr(DinheiroContrato[i]), GetPlayerDistanceFromPoint(playerid, x, y, z));
			count++;
			format(contrato, sizeof(contrato), "{"COR_VERMELHO_INC"}Lista de contratos [%d]", count);
		}
	}
	if(count)
		return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, contrato, str, "OK", "");

	SendClientMessage(playerid, COR_ERRO, "Não há nenhum alvo em contrato.");
	return true;
}
CMD:lalvo(playerid, params[])
{
   	
	if ( call::PLAYER->GetPlayerVarInt(playerid, Profissao) != ASSASINO )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é um assasino.");
		
	if ( isnull(params) || !IsNumeric(params))
			return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/lalvo [playerid]");
		
	new id = strval(params);
		
	if ( !IsPlayerConnected(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Jogador não está conectado.");

	if( call::ADMIN->IsAdminInJob(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode localizar um Administrador em modo trabalho.");

	if ( LocalizandoA[playerid] )
		RemovePlayerMapIcon(playerid, 15), KillTimer(TimerLocalizar[playerid]);

	SendClientMessage(playerid, COR_AVISO, "Você está localizando o(a) %s", GetUserName(id));

	static Float:x, Float:y, Float:z;
	GetPlayerPos(id, x, y, z);
	SetPlayerMapIcon(playerid, 15, x, y, z, 0, COR_VERMELHO);
	TimerLocalizar[playerid] = SetTimerEx("AssassinoLocalizando", 500, true, "dd", playerid, id);
	return true;
}

CMD:dalvo(playerid, params[])
{
	if ( call::PLAYER->GetPlayerVarInt(playerid, Profissao) != ASSASINO )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é um assasino.");

	if ( !LocalizandoA[playerid] )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está localizando ninguém.");

	RemovePlayerMapIcon(playerid, 15);
	KillTimer(TimerLocalizar[playerid]);
	TimerLocalizar[playerid]=0;

	SendClientMessage(playerid, COR_AZUL, "* Você desativou o localizador.");
	return true;
}

forward AssassinoLocalizando(playerid, suspeitoid);
public AssassinoLocalizando(playerid, suspeitoid)
{
	if ( !IsPlayerConnected(suspeitoid) )
	{
		RemovePlayerMapIcon(playerid, 15);
		SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) Jogador(a) que você estava localizando saiu do servidor.");
		return KillTimer(TimerLocalizar[playerid]), TimerLocalizar[playerid]=0, LocalizandoA[playerid]=0;
	}

	if ( !IsPlayerConnected(playerid) )
		return KillTimer(TimerLocalizar[playerid]), TimerLocalizar[playerid]=0, LocalizandoA[playerid]=0;

	static Float:x, Float:y, Float:z;
	
	RemovePlayerMapIcon(playerid, 15);
	GetPlayerPos(suspeitoid, x, y, z);
	SetPlayerMapIcon(playerid, 15, x, y, z, 0, COR_VERMELHO);
	return true;
}

public BloqueandoArmas(playerid) return Block[playerid] = false;
