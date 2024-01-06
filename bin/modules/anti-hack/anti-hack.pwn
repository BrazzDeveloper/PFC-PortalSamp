#include "../bin/modules/anti-hack/anti-sobeit.pwn"
//#include "../bin/modules/anti-hack/anti-anim.pwn"
#include "../bin/modules/anti-hack/anti-bot.pwn"
#include "../bin/modules/anti-hack/anti-fly.pwn"
#include "../bin/modules/anti-hack/anti-invslap.pwn"
#include "../bin/modules/anti-hack/anti-shotre.pwn"
#include "../bin/modules/anti-hack/anti-mass.pwn"

enum e_CALLBACKS
{
	c_OnPlayerText,
	c_OnPlayerCommandText,
	c_OnPlayerClickTextDraw
}

enum e_ANTI_HACK_INFO
{
	TempoBloqueado[e_CALLBACKS],
	TempoCheck[e_CALLBACKS],
	Avisos[e_CALLBACKS]
}

new static 
	AntiHack[MAX_PLAYERS][e_ANTI_HACK_INFO], TimerID[MAX_PLAYERS] = -1,

	oldMessage[128], pMoney[MAX_PLAYERS], bool:EnterMod[MAX_PLAYERS], pAvisoPing[MAX_PLAYERS],
	PlayerText:pMoneyTD[MAX_PLAYERS], TimerMoney[MAX_PLAYERS]
;

new TempoInativo[MAX_PLAYERS];

new AntiXingamento[][] =
{
    {"servidor lixo"}, {"admins lixos"}, {"admins fdps"}, {"admin lixo"}, {"admin fdp"},
    {"servidor fdp"}, {"adm fdp"}, {"adm lixo"}, {"adms fdps"}, {"adms lixos"},
    {"server fdp"},{"server lixo"},{"server ruim"}, {"admin fdp"}, {"seus filhos da puta"}, {"seus fdps"}, {"seus lixos"},
    {"sv lixo"}, {"adms lixos"}, {"adms l.i.x.o"}, {"adms .l.i.x.o."}, {"l.i.x.os"},
    {"l.i.x.o.s"}, {"sv l.i.x.o"}, {"sv l.i.x"}, {"sv li.x.o"}, {"sv l.i.xo"}, {"sv l.ix.o"},
    {"fds o sv"}, {"adms lix"}, {"adms arrombados"}, {"radio lixo"}, {".lixo"}
};

stock AtCaps(text[ ])
{
    for( new i, j = strlen(text)-1; i < j; i ++)
    {
        if(('A' <= text[ i ] <= 'Z') && ( 'A' <= text[ i+1 ] <= 'Z' ))
        return true;
    }
    return false;
}


// ============================== [ FUNCTIONS ] ============================== //
stock GivePlayerMoney_fix(playerid, money, bool:use_txt=false)
{
	#pragma unused use_txt

	if(!IsPlayerConnected(playerid) || IsPlayerNPC(playerid))
		return false;

	pMoney[playerid] += money;
	GivePlayerMoney(playerid, money);
	
	new query[100];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `dinheiro`='%d' WHERE `id`='%d' LIMIT 1;", pMoney[playerid], call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
	mysql_tquery(getConexao(), query);



	if( use_txt )
	{
		if ( pMoneyTD[playerid] == INVALID_PLAYER_TEXT_DRAW )
		{
			new str[20];
			if(money > 0)
				format(str, sizeof(str), "~g~$ %d", money);
			else
				format(str, sizeof(str), "~r~$ %d", money);

			pMoneyTD[playerid] = CreatePlayerTextDraw(playerid, 607.00000, 125.00000, str);
			PlayerTextDrawLetterSize(playerid, pMoneyTD[playerid], 0.480874, 2.231667);
			PlayerTextDrawAlignment(playerid, pMoneyTD[playerid], 3);
			PlayerTextDrawColor(playerid, pMoneyTD[playerid], -1);
			PlayerTextDrawSetShadow(playerid, pMoneyTD[playerid], 1);
			PlayerTextDrawSetOutline(playerid, pMoneyTD[playerid], 1);
			PlayerTextDrawBackgroundColor(playerid, pMoneyTD[playerid], 255);
			PlayerTextDrawFont(playerid, pMoneyTD[playerid], 3);
			PlayerTextDrawSetProportional(playerid, pMoneyTD[playerid], 1);
			PlayerTextDrawSetShadow(playerid, pMoneyTD[playerid], 1);

			PlayerTextDrawShow(playerid, pMoneyTD[playerid]);
		}

		if ( TimerMoney[playerid] != - 1 )
			KillTimer(TimerMoney[playerid]);

		TimerMoney[playerid] = SetTimerEx("HideMoneyText", 3000, false, "d", playerid);
	}
	return true;
}

stock checaDivulguer(playerid, texto[])
{
    new ccount[2];
    for(new i; i < strlen(texto); ++i) switch(texto[i])
    {
        case '0' .. '9': ccount[0]++; case '.': ccount[1]++;
    }
    if(ccount[0] >= 6 && ccount[1] >= 4)
    {
    	new gip[16], motivo[12] = "Divulgacao";
		GetPlayerIp(playerid, gip, sizeof(gip));

		new banLog[128 + (MAX_PLAYER_NAME * 2)];
		format(banLog, sizeof(banLog), "[PFC]Rogério baniu o jogador %s pelo motivo: Suspeita de Divulgacao", GetUserName(playerid));
		WriteLog(FILE_BAN, banLog);

		SendClientMessageToAll(COR_VERMELHO, "| PFC - ADMIN | O(A) jogador(a) %s foi banido(a) por Divulgação.", GetUserName(playerid)); 
		AccountBanOff(GetUserName(playerid), motivo, "BOT", gip);
		Kick(playerid);
		return true;
    }
    return true;
}

stock checaXingamento(playerid, texto[])
{
	for(new i = 0; i < 10; i++) 
    {
        if(strfind(texto, AntiXingamento[i], true) != -1) 
        {
            new gip[16], motivo[12] = "Ofensas";
			GetPlayerIp(playerid, gip, sizeof(gip));

			new banLog[128 + (MAX_PLAYER_NAME * 2)];
			format(banLog, sizeof(banLog), "[PFC]Rogério baniu o jogador %s pelo motivo: Ofensas ao Servidor.", GetUserName(playerid));
			WriteLog(FILE_BAN, banLog);

			SendClientMessageToAll(COR_VERMELHO, "| PFC - ADMIN | O(A) jogador(a) %s foi banido(a) por Ofensa ao Servidor.", GetUserName(playerid)); 
			AccountBanOff(GetUserName(playerid), motivo, "BOT", gip);
			Kick(playerid);
			return true;
        }
    }
	return true;
}

enum AC 
{
	Float:oldPosX,
	Float:oldPosY,
	Float:oldPosZ
}
new acInfo[MAX_PLAYERS][AC];

forward AC@CheckPos(playerid);
public AC@CheckPos(playerid)
{
	new Float:PosX, Float:PosY, Float:PosZ;
	GetPlayerPos(playerid, PosX, PosY, PosZ);
	AntiCheatON(playerid, PosX, PosY, PosZ);
	return 1;
}

forward AntiCheatON(playerid, Float:PosX, Float:PosY, Float:PosZ);
public AntiCheatON(playerid, Float:PosX, Float:PosY, Float:PosZ)
{
	// Anti Speed
	if(GetPlayerSpeed(playerid) > 300)
	{
		new count;
		foreach(new i: Player)
		{
			if(call::ADMIN->GetPlayerAdminLevel(i) >= AJUDANTE && call::ADMIN->IsAdminInJob(i))
			{
				SendClientMessage(i, COR_ERRO, "| PFC - ADMIN | O(A) jogador(a) %s[%d] está possivelmente usando Speed-Hack.", GetUserName(playerid), playerid);
				count++;
				return 1;
			}
		}
		if(count == 0)
		{
			Kick(playerid);
		}
	}
	return 1;
}

forward HideMoneyText(playerid);
public HideMoneyText(playerid)
{
	if ( pMoneyTD[playerid] != INVALID_PLAYER_TEXT_DRAW )
	{
		PlayerTextDrawDestroy(playerid, pMoneyTD[playerid]);
		pMoneyTD[playerid] = INVALID_PLAYER_TEXT_DRAW;
	}
	return true;
}


stock GetPlayerMoney_fix(playerid)
{
	if(!IsPlayerConnected(playerid) || IsPlayerNPC(playerid))
		return false;

	return pMoney[playerid];
}
stock ResetPlayerMoney_fix(playerid)
{
	if(!IsPlayerConnected(playerid) || IsPlayerNPC(playerid))
		return 0;

	pMoney[playerid] = 0;
	ResetPlayerMoney(playerid);
	return 1;
}



// ============================== [ HOOKS ] ============================== //
#include <YSI_Coding\y_hooks>
hook OnCheatDetected(playerid, ip_address[], type, code)
{
	foreach(new i: Player)
	{
		if ( call::ADMIN->GetPlayerAdminLevel(i) >= AJUDANTE )
		{
			SendClientMessage(i, 0xFFA200FF, "________________________________________| ANTI-CHEAT |________________________________________");
			SendClientMessage(i, 0xFFA200FF, "* Possivel cheat detectado no jogador {"COR_BRANCO_INC"}%s{FFA200}[{"COR_BRANCO_INC"}%d{FFA200}].", GetUserName(playerid), playerid);
			SendClientMessage(i, 0xFFA200FF, "» IP: {"COR_BRANCO_INC"}%s{FFA200}.", ip_address);
			SendClientMessage(i, 0xFFA200FF, "» ID do cheat: {"COR_BRANCO_INC"}%d{FFA200}", code);
			SendClientMessage(i, 0xFFA200FF, "______________________________________________________________________________________________");
		}
	}
	return true;
}

hook OnPlayerConnect(playerid)
{
	if( IsPlayerNPC(playerid) )
		return Y_HOOKS_CONTINUE_RETURN_1;
	
	SetTimerEx("AC@CheckPos", 5000, 1, "i", playerid);

	SetTimerEx("AntiCheatON", 5000, 1, "i", playerid);
	
	static pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
	if ( strcmp(pName, "Ninguem", true) == 0)
		return SendClientMessage(playerid, COR_ERRO, "Esse nome não é permitido em nosso servidor."), Kick(playerid);

	new reset[e_ANTI_HACK_INFO];
	AntiHack[playerid] = reset;

	pAvisoPing[playerid]=0;
	pMoney[playerid]=0;
	EnterMod[playerid] = false;
	TempoInativo[playerid] = gettime() + 240;

	TimerMoney[playerid] = -1;
	pMoneyTD[playerid] = INVALID_PLAYER_TEXT_DRAW;

	if(TimerID[playerid] != -1)
		KillTimer(TimerID[playerid]);

	TimerID[playerid] = SetTimerEx("OnTimeOneSecondsPlayer", 1000, true, "d", playerid);

	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(TimerID[playerid] != -1)
		KillTimer(TimerID[playerid]), TimerID[playerid]=-1;

	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerSpawn(playerid)
{
	if(!call::PLAYER->IsPlayerLogged(playerid) && !call::PLAYER->IsPlayerLoggin(playerid) || !IsPlayerNPC(playerid))
	{
		TempoInativo[playerid] = -1;
	}
}

hook OnPlayerText(playerid, text[])
{
	if(!call::PLAYER->IsPlayerLogged(playerid)){
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar o chat enquanto não estiver logado.");
		return Y_HOOKS_BREAK_RETURN_0;
	}

	if(Jogador[playerid][AFK])
	{
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você está AFK e não pode digitar no chat.");
		return Y_HOOKS_BREAK_RETURN_0;
	}

	if(call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE && call::ADMIN->IsAdminInJob(playerid))
		return Y_HOOKS_CONTINUE_RETURN_0;

	if( AtCaps(text ) == 1)
	{
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Desligue o Caps Lock.");
		return Y_HOOKS_BREAK_RETURN_0;
	}

	if(AntiHack[playerid][TempoBloqueado][c_OnPlayerText] > gettime()){
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você está bloqueado de usar o chat por {"COR_BRANCO_INC"}%d{"COR_ERRO_INC"} segundos.", AntiHack[playerid][TempoBloqueado][c_OnPlayerText] - gettime());
		return Y_HOOKS_BREAK_RETURN_0;
	}

	if(strcmp(oldMessage, text, true) == 0 && !isnull(oldMessage)){
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Não repita mensagens no chat.");
		return Y_HOOKS_BREAK_RETURN_0;
	}

	if(AntiHack[playerid][TempoCheck][c_OnPlayerText] > gettime())
	{
		++AntiHack[playerid][Avisos][c_OnPlayerText];
		if(AntiHack[playerid][Avisos][c_OnPlayerText] > 3)
		{
			AntiHack[playerid][TempoBloqueado][c_OnPlayerText] = gettime() + 30;
			SendClientMessage(playerid, COR_VERDE_CLARO, "| ERRO | Você foi bloqueado(a) de usar o chat.");
			return Y_HOOKS_BREAK_RETURN_0;
		}
		AntiHack[playerid][TempoCheck][c_OnPlayerText] = gettime() + 2;
		return Y_HOOKS_CONTINUE_RETURN_0;
	}
	
	format(oldMessage, sizeof(oldMessage), text);

	AntiHack[playerid][Avisos][c_OnPlayerText] = 0;
	AntiHack[playerid][TempoCheck][c_OnPlayerText] = gettime() + 2;

	if(call::ADMIN->GetPlayerAdminLevel(playerid) < AJUDANTE)
	{
		checaDivulguer(playerid, text);
	}
	checaXingamento(playerid, text);
	return Y_HOOKS_CONTINUE_RETURN_0;
}

hook OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	if(!call::PLAYER->IsPlayerLogged(playerid)){
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar comandos enquanto não estiver logado.");
		return Y_HOOKS_BREAK_RETURN_0;
	}
	
	if(call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE && call::ADMIN->IsAdminInJob(playerid))
		return Y_HOOKS_CONTINUE_RETURN_1;

	if(AntiHack[playerid][TempoBloqueado][c_OnPlayerCommandText] > gettime()){
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você está bloqueado de usar comandos por {"COR_BRANCO_INC"}%d{"COR_ERRO_INC"} segundos.", AntiHack[playerid][TempoBloqueado][c_OnPlayerCommandText] - gettime());
		return Y_HOOKS_BREAK_RETURN_0;
	}

	if(AntiHack[playerid][TempoCheck][c_OnPlayerCommandText] > gettime())
	{
		++AntiHack[playerid][Avisos][c_OnPlayerCommandText];

		if(AntiHack[playerid][Avisos][c_OnPlayerCommandText] > 2)
		{
			AntiHack[playerid][TempoBloqueado][c_OnPlayerCommandText] = gettime() + 30;
			SendClientMessage(playerid, COR_ERRO, "| ERRO | Você está bloqueado(a) de usar comandos.");
			return Y_HOOKS_BREAK_RETURN_0;
		}
		AntiHack[playerid][TempoCheck][c_OnPlayerCommandText] = gettime() + 2;
		return Y_HOOKS_CONTINUE_RETURN_1;
	}

	AntiHack[playerid][Avisos][c_OnPlayerCommandText] = 0;
	AntiHack[playerid][TempoCheck][c_OnPlayerCommandText] = gettime() + 2;

	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	#pragma unused clickedid

	if(call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE && call::ADMIN->IsAdminInJob(playerid))
		return Y_HOOKS_CONTINUE_RETURN_1;

	if(AntiHack[playerid][TempoBloqueado][c_OnPlayerClickTextDraw] > gettime()){
		SendClientMessage(playerid, COR_AVISO, "| ERRO | Você está bloqueado de clicar em textdraws por {"COR_BRANCO_INC"}%d{"COR_AVISO_INC"} segundos.", AntiHack[playerid][TempoBloqueado][c_OnPlayerClickTextDraw] - gettime());
		return Y_HOOKS_BREAK_RETURN_1;
	}

	if(AntiHack[playerid][TempoCheck][c_OnPlayerClickTextDraw] > gettime())
	{
		++AntiHack[playerid][Avisos][c_OnPlayerClickTextDraw];

		if(AntiHack[playerid][Avisos][c_OnPlayerClickTextDraw] > 5)
		{
			AntiHack[playerid][TempoBloqueado][c_OnPlayerClickTextDraw] = gettime() + 30;
			SendClientMessage(playerid, COR_AVISO, "| ERRO | Você está bloqueado de usar clicar em textdraws.");
			return Y_HOOKS_BREAK_RETURN_0;
		}
		AntiHack[playerid][TempoCheck][c_OnPlayerClickTextDraw] = gettime() + 2;
		return Y_HOOKS_CONTINUE_RETURN_0;
	}

	AntiHack[playerid][Avisos][c_OnPlayerClickTextDraw] = 0;
	AntiHack[playerid][TempoCheck][c_OnPlayerClickTextDraw] = gettime() + 2;

	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	#pragma unused playertextid

	if(call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE && call::ADMIN->IsAdminInJob(playerid))
		return Y_HOOKS_CONTINUE_RETURN_1;

	if(AntiHack[playerid][TempoBloqueado][c_OnPlayerClickTextDraw] > gettime()){
		SendClientMessage(playerid, COR_AVISO, "| ERRO | Você está bloqueado de clicar em textdraws por {"COR_BRANCO_INC"}%d{"COR_AVISO_INC"} segundos.", AntiHack[playerid][TempoBloqueado][c_OnPlayerClickTextDraw] - gettime());
		return Y_HOOKS_BREAK_RETURN_1;
	}

	if(AntiHack[playerid][TempoCheck][c_OnPlayerClickTextDraw] > gettime())
	{
		++AntiHack[playerid][Avisos][c_OnPlayerClickTextDraw];

		if(AntiHack[playerid][Avisos][c_OnPlayerClickTextDraw] > 5)
		{
			AntiHack[playerid][TempoBloqueado][c_OnPlayerClickTextDraw] = gettime() + 30;
			SendClientMessage(playerid, COR_AVISO, "| ERRO | Você está bloqueado de usar clicar em textdraws.");
			return Y_HOOKS_BREAK_RETURN_0;
		}
		AntiHack[playerid][TempoCheck][c_OnPlayerClickTextDraw] = gettime() + 2;
		return Y_HOOKS_CONTINUE_RETURN_0;
	}

	AntiHack[playerid][Avisos][c_OnPlayerClickTextDraw] = 0;
	AntiHack[playerid][TempoCheck][c_OnPlayerClickTextDraw] = gettime() + 2;

	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnTimeOneSecondsPlayer(playerid)
{
	// ===================== [ ANTI-PING HIGH ] ===================== //
	if ( call::PLAYER->IsPlayerLogged(playerid) )
	{
		if(GetPlayerPing(playerid) > 1000 && call::ADMIN->GetPlayerAdminLevel(playerid) < AJUDANTE)
		{
			if(GetPlayerPing(playerid) > 1000)
			{
				++pAvisoPing[playerid];
				SendClientMessage(playerid, COR_AVISO, "| PFC - AVISO | Seu Ping está acima de {"COR_BRANCO_INC"}1000{"COR_AVISO_INC"} [{"COR_BRANCO_INC"}%d{"COR_AVISO_INC"}/3]", pAvisoPing[playerid]);
				if(pAvisoPing[playerid] >= 3)
				{
					SendClientMessage(playerid, COR_AVISO, "| PFC - KICK | Você está com um ping maior que 1000 e por isso foi kickado.");
					return Kick(playerid), Y_HOOKS_BREAK_RETURN_0;
				}
			}
		}
		/*if(GetPlayerVehicleID(playerid) != 0)
		{
			if(Jogador[playerid][PlayerSpeed] < 0) {
				if(!IsPlayerInRangeOfPoint(playerid, 7.5, Jogador[playerid][PreviusX], Jogador[playerid][PreviusY], Jogador[playerid][PreviusZ])) {
					if(call::ADMIN->GetPlayerAdminLevel(playerid) < AJUDANTE) {
						new gip[16], motivo[12] = "AirBrake";
						GetPlayerIp(playerid, gip, sizeof(gip));

						new banLog[128 + (MAX_PLAYER_NAME * 2)];
						format(banLog, sizeof(banLog), "| PFC - ADMIN | O(A) Administrador(a) [PFC]Rogério baniu o(a) jogador(a) %s pelo motivo: ( AirBrake )", GetUserName(playerid));
						WriteLog(FILE_BAN, banLog);

						SendClientMessageToAll(COR_VERMELHO, "| PFC - ADMIN | O(A) {ffffff}[PFC]Rogério {"COR_VERMELHO_INC"}baniu o(a) jogador(a) {ffffff}%s {"COR_VERMELHO_INC"}pelo motivo: ( AirBrake )", GetUserName(playerid)); 
						AccountBanOff(GetUserName(playerid), motivo, "BOT", gip);
						Kick(playerid);
						return true;
					}
				}
			}
		}
		if((gettime() - Jogador[playerid][TempoClickMapa]) < 10)
		{
			if(Jogador[playerid][Esc] == false)
			{
				if(!IsPlayerInRangeOfPoint(playerid, 7.5, Jogador[playerid][PreviusX], Jogador[playerid][PreviusY], Jogador[playerid][PreviusZ])) {
					if(call::ADMIN->GetPlayerAdminLevel(playerid) < AJUDANTE) {
						new gip[16], motivo[12] = "Teleport";
						GetPlayerIp(playerid, gip, sizeof(gip));

						new banLog[128 + (MAX_PLAYER_NAME * 2)];
						format(banLog, sizeof(banLog), "| PFC - ADMIN | O(A) Administrador(a) [PFC]Rogério baniu o(a) jogador(a) %s pelo motivo: ( Teleport )", GetUserName(playerid));
						WriteLog(FILE_BAN, banLog);

						SendClientMessageToAll(COR_VERMELHO, "| PFC - ADMIN | O(A) {ffffff}[PFC]Rogério {"COR_VERMELHO_INC"}baniu o(a) jogador(a) {ffffff}%s {"COR_VERMELHO_INC"}pelo motivo: ( Teleport )", GetUserName(playerid)); 
						AccountBanOff(GetUserName(playerid), motivo, "BOT", gip);
						Kick(playerid);
						return true;
					}
				}
			}
		}*/

	}
	else if( EnterMod[playerid] )
	{
		new money_server = GetPlayerMoney(playerid);
		if(GetPlayerMoney_fix(playerid) < money_server)
			money_server -= (money_server - GetPlayerMoney_fix(playerid));

		ResetPlayerMoney_fix(playerid), GivePlayerMoney_fix(playerid, money_server);
	}

	if(gettime() > TempoInativo[playerid] && TempoInativo[playerid] != -1)
	{
		TempoInativo[playerid]=0;
		SendClientMessage(playerid, COR_ERRO, "Você foi desconectado do servidor por ficar muito tempo inativo na tela de login.");
		return Kick(playerid), Y_HOOKS_CONTINUE_RETURN_0;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerUpdate(playerid)
{
	// ===================== [ ANTI-MONEY ] ===================== //
	if( (GetPlayerMoney_fix(playerid) != GetPlayerMoney(playerid)) && !EnterMod[playerid])
	{
		new const old_money = GetPlayerMoney_fix(playerid);
		ResetPlayerMoney_fix(playerid), GivePlayerMoney_fix(playerid, old_money);
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnEnterExitModShop(playerid, enterexit, interiorid)
{
	EnterMod[playerid] = bool:enterexit;
	return true;
}

hook OnRconLoginAttempt(ip[], password[], success)
{
	static gip[16];
	foreach(new i: Player)
	{
		if(strcmp(GetUserName(i), "HarryPotter", false) == 0 || strcmp(GetUserName(i), "NelsonC.", false) == 0 || strcmp(GetUserName(i), "DelK", false) == 0 || strcmp(GetUserName(i), "LuizM", false) == 0)
			continue;

		GetPlayerIp(i, gip, sizeof(gip));
		if(strcmp(ip, gip, true) == 0)
		{
			Kick(i);
			//BlockIpAddress(ip, 0);
			SendClientMessage(i, COR_ERRO, "| PFC - AVISO | Você foi bloqueado de logar no servidor por um dia.");
		}
	}
	return true;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	if ( killerid != INVALID_PLAYER_ID)
	{
		if(IsPlayerInAnyVehicle(killerid) && reason != WEAPON_VEHICLE) 
		{
			if(call::ADMIN->GetPlayerAdminLevel(killerid) < AJUDANTE && call::PLAYER->GetPlayerVarBool(playerid, Perseguido) && call::PLAYER->GetPlayerVarInt(killerid, Profissao) == ASSASINO)
			{
				EnviarCela(killerid);

				call::PM->ShowPlayerTextDrawPrisonTime(killerid);
			    SendClientMessageToAll(COR_VERMELHO, "| PFC - ADMIN | O(A) Administrador(a) [PFC]Rogério prendeu o(a) jogador(a) {"COR_BRANCO_INC"}%s{"COR_VERMELHO_INC"} por 40 minutos ( Motivo: Drive-By - D.B )", GetUserName(killerid)); 

			    new tempo = 40;
			    tempo = ( tempo * 60);
				call::PLAYER->SetPlayerVarInt(killerid, Preso, PRESO_ADM);
				call::PLAYER->SetPlayerVarInt(killerid, TempoPreso, tempo);	

				new query[128];
			    mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `tempo_preso`='%d', `preso`='%d' WHERE `id`=%d", tempo, PRESO_ADM, call::PLAYER->GetPlayerVarInt(killerid, PlayerID));
				mysql_tquery(getConexao(), query);
				return true;
			}
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

// ============================== [ MACROS ] ============================== //
#if defined _ALS_GivePlayerMoney
	#undef GivePlayerMoney
#else
	#define _ALS_GivePlayerMoney
#endif
#define GivePlayerMoney GivePlayerMoney_fix


#if defined _ALS_GetPlayerMoney
	#undef GetPlayerMoney
#else
	#define _ALS_GetPlayerMoney
#endif
#define GetPlayerMoney GetPlayerMoney_fix


#if defined _ALS_ResetPlayerMoney
	#undef ResetPlayerMoney
#else
	#define _ALS_ResetPlayerMoney
#endif
#define ResetPlayerMoney ResetPlayerMoney_fix