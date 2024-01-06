
/**
*
*		Definições
*
**/
#define DIR_EVENT(%0) 		"eventos"%0".ini"


const
	MAX_VEHICLES_EVENTOS = 20
;

static 
	INIT_EVENTO = 0,
	bool:OPEN_EVENTO = false,
	ContagemInit = false
;
/**
*
*		Variáveis
*
**/
enum e_PLAYER_EVENTO
{
	bool:InEvento,
}
static pEvento[MAX_PLAYERS][e_PLAYER_EVENTO];


enum e_EVENTO
{
	Float:Pos[3],
	Interior,
	World,
	Entrou
}
static Evento[e_EVENTO];

/**
*
*		Funções
*
**/
stock IsPlayerInEvent(playerid)
{
	return pEvento[playerid][InEvento];
}

stock TogglePlayerEvent(playerid, bool:toggle)
{
	pEvento[playerid][InEvento] = toggle;
}

/**
*
*		Comandos
*
**/

flags:ajudaevento(MODERADOR);
CMD:ajudaevento(playerid, params[])
{
	new str[1024];

	strcat(str, "{"COR_AZUL_INC"}*{"COR_BRANCO_INC"} Comandos\n\n");
	strcat(str, "{"COR_VERMELHO_INC"}/iniciarevento{"COR_BRANCO_INC"} » Comando para criar o evento.\n");
	strcat(str, "{"COR_VERMELHO_INC"}/abrirevento{"COR_BRANCO_INC"} » Comando para abrir o evento e torna útil o comando /irevento para os jogadores.\n");
	strcat(str, "{"COR_VERMELHO_INC"}/fecharevento{"COR_BRANCO_INC"} » Comando que fechará o evento. Isso deixará o comando /irevento inutilizável. Portanto, use quando todos os jogadores já estiverem no evento.\n");
	strcat(str, "{"COR_VERMELHO_INC"}/finalizarevento{"COR_BRANCO_INC"} » Comando para finalizar o evento. Esse comando respawnará os jogadores que ainda tiverem no evento na prefeitura de Los Santos e fecherá o evento.\n");
	strcat(str, "{"COR_VERMELHO_INC"}/dararmatodos{"COR_BRANCO_INC"} » Comando para dar armas para os jogadores no evento.\n");
	strcat(str, "{"COR_VERMELHO_INC"}/darvidatodos{"COR_BRANCO_INC"} » Comando para dar vida para os jogadores no evento.\n");
	strcat(str, "{"COR_VERMELHO_INC"}/darcoletetodos{"COR_BRANCO_INC"} » Comando para dar colete para os jogadores no evento.\n");
	strcat(str, "{"COR_VERMELHO_INC"}/congelartodos{"COR_BRANCO_INC"} » Comando para congelar jogadores no evento.\n");
	strcat(str, "{"COR_VERMELHO_INC"}/descongelartodos{"COR_BRANCO_INC"} » Comando para descongelar jogadores no evento.\n");
	strcat(str, "{"COR_VERMELHO_INC"}/contar{"COR_BRANCO_INC"} » Comando para abrir uma contagem na tela do jogador que esteja no evento.\n");

	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "AJUDA EVENTO", str, "OK", "");
	return true;
}

flags:iniciarevento(MODERADOR);
CMD:iniciarevento(playerid, params[])
{
	if (  isnull(params) )
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/iniciarevento [nome do evento]");

	if ( INIT_EVENTO )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Já tem um evento rolando. Use /finalizarevento");

	/**
	*
	*	Pegar info do evento
	*
	**/
	GetPlayerPos(playerid, Evento[Pos][0], Evento[Pos][1], Evento[Pos][2]);
	
	Evento[Interior] = GetPlayerInterior(playerid);
	Evento[World] = GetPlayerVirtualWorld(playerid);
	Evento[Entrou] = Jogador[playerid][Entrou];

	INIT_EVENTO = true;

	SendClientMessage(playerid, COR_AZUL, "*{"COR_BRANCO_INC"} Você criou um evento use {"COR_BRANCO_INC"}/abrirevento{"COR_AZUL_INC"} para torna-lo público aos jogadores.");
	return true;
}

flags:abrirevento(MODERADOR);
CMD:abrirevento(playerid, params[])
{
	if ( !INIT_EVENTO )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não nenhum evento criado.");

	if ( OPEN_EVENTO )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Evento já encontra-se aberto.");

	OPEN_EVENTO = true;

	SendClientMessage(playerid, COR_AZUL, "* Você abriu o evento e todos os jogadores poderão dar o comando {"COR_BRANCO_INC"}/irevento{"COR_AZUL_INC"}.");
	SendClientMessageToAll(COR_AZUL, "EVENTO: O(A) %s {"COR_BRANCO_INC"}%s{"COR_AZUL_INC"} abriu o evento, use {"COR_BRANCO_INC"}/irevento{"COR_AZUL_INC"} para participar.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
	return true;
}


flags:fecharevento(MODERADOR);
CMD:fecharevento(playerid, params[])
{
	if ( !INIT_EVENTO )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não nenhum evento aberto.");

	if ( !OPEN_EVENTO )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Evento já encontra-se fechado.");

	OPEN_EVENTO = false;
	SendClientMessage(playerid, COR_AZUL, "* Você trancou o evento e ninguém poderar vir até aqui.");
	SendClientMessageToAll(COR_AZUL, "EVENTO: O(A) %s {"COR_BRANCO_INC"}%s{"COR_AZUL_INC"} fechou o evento que estava ocorrendo.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
	return true;
}

flags:finalizarevento(MODERADOR);
CMD:finalizarevento(playerid, params[])
{
	if ( !INIT_EVENTO )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não nenhum evento aberto.");

	INIT_EVENTO = false;
	OPEN_EVENTO = false;

	foreach(new i: Player)
	{
		if ( IsPlayerInEvent(i) )
		{
			TogglePlayerEvent(i, false);
			SendClientMessage(i, COR_ERRO, "| ERRO | O(A) %s %s terminou o evento que estava acontecendo.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
		}
	}

	/**
	*
	*	resetar as variáveis.
	*
	**/
	new r[e_EVENTO];
	Evento = r;

	SendClientMessage(playerid, COR_AZUL, "O Evento foi finalizado com sucesso.");
	SendClientMessageToAll(COR_AZUL, "EVENTO: O(A) %s {"COR_BRANCO_INC"}%s{"COR_AZUL_INC"} finalizou o evento que estava ocorrendo.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
	return true;
}

flags:dararmatodos(MODERADOR);
CMD:dararmatodos(playerid, params[])
{
	static weaponid, ammo;

	if ( sscanf(params, "dd", weaponid, ammo) )	
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/dararmatodos [arma id] [munição]");

	foreach(new i: Player)
	{
		if ( IsPlayerInEvent(i) )
		{
			GivePlayerWeapon(i, weaponid, ammo);
			SendClientMessage(i, COR_AZUL, "EVENTO: O(A) %s {"COR_BRANCO_INC"}%s{"COR_AZUL_INC"} deu uma arma para você.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
		}
	}
	SendClientMessage(playerid, COR_AZUL, "Todos os jogadores no evento receberam suas armas.");
	return true;
}

flags:darvidatodos(ADMINISTRADOR);
CMD:darvidatodos(playerid, params[])
{
	static Float:vida;

	if ( sscanf(params, "f", vida) )	
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/darvidatodos [vida]");

	foreach(new i: Player)
	{
		if ( IsPlayerInEvent(i) )
		{
			SetPlayerHealth(i, vida);
			SendClientMessage(i, COR_AZUL, "EVENTO: O(A) %s {"COR_BRANCO_INC"}%s{"COR_AZUL_INC"} setou sua vida para {"COR_BRANCO_INC"}%d{"COR_AZUL_INC"}.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), floatround(vida));
		}
	}
	SendClientMessage(playerid, COR_AZUL, "Todos os jogadores no evento tiveram suas vidas restauradas a %d", floatround(vida));
	return true;
}

flags:darcoletetodos(ADMINISTRADOR);
CMD:darcoletetodos(playerid, params[])
{
	static Float:armour;

	if ( sscanf(params, "f", armour) )	
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/darcoletetodos [colete]");

	foreach(new i: Player)
	{
		if ( IsPlayerInEvent(i) )
		{
			SetPlayerArmour(i, armour);
			SendClientMessage(i, COR_AZUL, "EVENTO: O(A) %s {"COR_BRANCO_INC"}%s{"COR_AZUL_INC"} setou seu colete para {"COR_BRANCO_INC"}%d{"COR_AZUL_INC"}.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), floatround(armour));
		}
	}
	SendClientMessage(playerid, COR_AZUL, "Todos os jogadores no evento tiveram seu colete setado a %d", floatround(armour));
	return true;
}

flags:congelartodos(ADMINISTRADOR);
CMD:congelartodos(playerid, params[])
{
	foreach(new i: Player)
	{
		if ( IsPlayerInEvent(i) )
		{
			TogglePlayerControllable(i, false);
			SendClientMessage(i, COR_AZUL, "EVENTO: O(A) %s {"COR_BRANCO_INC"}%s{"COR_AZUL_INC"} congelou você.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
		}
	}
	SendClientMessage(playerid, COR_AZUL, "Todos os jogadores no evento foram congelados.");
	return true;
}

flags:descongelartodos(ADMINISTRADOR);
CMD:descongelartodos(playerid, params[])
{
	foreach(new i: Player)
	{
		if ( IsPlayerInEvent(i) )
		{
			TogglePlayerControllable(i, true);
			SendClientMessage(i, COR_AZUL, "EVENTO: O(A) %s {"COR_BRANCO_INC"}%s{"COR_AZUL_INC"} descongelou você.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
		}
	}
	SendClientMessage(playerid, COR_AZUL, "Todos os jogadores no evento foram descongelados.");
	return true;
}


flags:contarevento(ADMINISTRADOR);
CMD:contarevento(playerid, params[])
{
	if ( isnull(params) || !IsNumeric(params))	
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/contar [tempo]");

	if ( ContagemInit )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Já tem uma contagem na tela, por favor espere terminar.");

	ContagemInit=true;
	Contagem(strval(params));
	return true;
}


CMD:irevento(playerid)
{
	if ( !INIT_EVENTO )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não há um evento aberto.");

	if ( IsPlayerInEvent(playerid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está no evento.");

	TogglePlayerEvent(playerid, true);
	SendClientMessage(playerid, COR_AZUL, "* Você foi até ao evento criado pelos administradores. Por favor não faça baderna.");

	Teleport(
		playerid,
		Evento[Pos][0],
		Evento[Pos][1],
		Evento[Pos][2],
		0.0,
		Evento[Interior],
		Evento[World],
		Evento[Entrou]
	);
	return true;
}

/**
*
*		Callbacks
*
**/
forward Contagem(time);
public Contagem(time)
{
	new str[6];
	if ( time <= 0 )
	{
		foreach(new i: Player)
		{
			if ( IsPlayerInEvent(i) )
			{
				format(str, sizeof(str), "~r~GO", time);
				GameTextForPlayer(i, str, 1000, 4);
				PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
			}
		}
		ContagemInit=false;
		return true;
	}
	foreach(new i: Player)
	{
		if ( IsPlayerInEvent(i) )
		{
			format(str, sizeof(str), "~y~%d", time);
			GameTextForPlayer(i, str, 1000, 4);
			PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
		}
	}
	--time;
	SetTimerEx("Contagem", 1000, false, "d", time);
	return true;
}

/**
*
*		Includes
*
**/
#include ../bin/modules/eventos/race.pwn