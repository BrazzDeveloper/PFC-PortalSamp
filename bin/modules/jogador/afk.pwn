
forward CheckPlayerAFK(playerid);

#define TIME_CHECK_AFK 		( 3 * 60 )

enum e_AFK_INFO
{
	TimerID,
	bool:AFK,
	TimeCMD,
	TimeChat,
	Float:Postition[3],
	Time,
	Points,
	Key,
	Acertou,
	Errou
}
static AFK[MAX_PLAYERS][e_AFK_INFO], reset[e_AFK_INFO];

static KeysAFKs[][] = 
{
	{KEY_ACTION, "~k~TAB"},
	{KEY_SPRINT, "~k~SPACE"},
	{KEY_SECONDARY_ATTACK, "~k~ENTER"},
	{KEY_JUMP, "~k~LSHIFT"},
	{KEY_YES,  "~k~Y"},
	{KEY_NO,  "~k~N"}
};

public CheckPlayerAFK(playerid)
{
	if ( !call::PLAYER->IsPlayerLogged(playerid) )
		return false;

	if( AFK[playerid][Time] < gettime() )
	{
		AFK[playerid][Time] = gettime() + TIME_CHECK_AFK;

		/**
		*
		*	Verificação de posição.
		*
		**/
		if( IsPlayerInRangeOfPoint(playerid, 2.2, AFK[playerid][Postition][0] , AFK[playerid][Postition][1], AFK[playerid][Postition][2]))
		{
			AFK[playerid][Points] += 10;
		}
		else
		{
			AFK[playerid][Points] -= 10;
			AFK[playerid][Points] = AFK[playerid][Points] < 0 ? 0 : AFK[playerid][Points];
		}
		GetPlayerPos(playerid, AFK[playerid][Postition][0] , AFK[playerid][Postition][1], AFK[playerid][Postition][2]);

		/**
		*
		*	Verificação de comandos.
		*
		**/
		if ( AFK[playerid][TimeCMD] < gettime() )
		{
			AFK[playerid][Points] += 5;
		}

		/**
		*
		*	Verificação de chat.
		*
		**/
		if ( AFK[playerid][TimeChat] < gettime() )
		{
			AFK[playerid][Points] += 2;
		}

		/**
		*
		*	Verificar Avisos e aplicar ação.
		*
		**/
		if( AFK[playerid][Points] > 15 )
		{
			if( AFK[playerid][Points] > 15 && !AFK[playerid][AFK] )
			{
				new rand = random(sizeof(KeysAFKs));
				call::TD->ShowPlayerTextAFK(playerid, KeysAFKs[rand][1]);

				AFK[playerid][Key] = KeysAFKs[rand][0];
				AFK[playerid][AFK] = true;

				if ( IsPlayerInAnyVehicle(playerid) )
				{
					RemovePlayerFromVehicle(playerid);
				}

				TogglePlayerControllable(playerid, false);
			}
			else if( AFK[playerid][Points] > 20 )
			{
				CleanChat(playerid);
				SendClientMessage(playerid, COR_VERMELHO, "| AFK | Você foi kickado por ficar muito tempo AFK.");
				Kick(playerid);
			}
		}
	}
	return true;
}

stock GetPlayerAFK(playerid)
{
	return AFK[playerid][AFK];
}



/**
*
*	Hooks
*
**/
#include <YSI_Coding\y_hooks>

hook OnPlayerText(playerid, text[])
{
	if ( AFK[playerid][TimeChat] < gettime() )
	{
		AFK[playerid][Points] -= 2;
		AFK[playerid][Points] = AFK[playerid][Points] < 0 ? 0 : AFK[playerid][Points];
		AFK[playerid][TimeChat] = gettime() + TIME_CHECK_AFK;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	if ( AFK[playerid][TimeCMD] < gettime() )
	{
		AFK[playerid][Points] -= 5;
		AFK[playerid][Points] = AFK[playerid][Points] < 0 ? 0 : AFK[playerid][Points];
		AFK[playerid][TimeCMD] = gettime() + TIME_CHECK_AFK;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if( GetPlayerAFK(playerid) )
	{
		if( PRESSED(AFK[playerid][Key]) )
		{
			AFK[playerid][Acertou]++;
			
			if( AFK[playerid][Acertou] >= 3 )
			{
				AFK[playerid] = reset;
				TogglePlayerControllable(playerid, true);
				call::TD->HidePlayerTextAFK(playerid);
				SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Você saiu do modo AFK.");
			}
			return Y_HOOKS_CONTINUE_RETURN_1;
		}
		else if( RELEASED(AFK[playerid][Key]) )
		{
			new rand = random(sizeof(KeysAFKs));
			call::TD->ShowPlayerTextAFK(playerid, KeysAFKs[rand][1], "~g~pressione a proxima tecla...");
			AFK[playerid][Key] = KeysAFKs[rand][0];
			return Y_HOOKS_CONTINUE_RETURN_1;
		}

		AFK[playerid][Errou]++;
		if ( AFK[playerid][Errou] > 3 )
		{
			AFK[playerid][Errou] = 0;
			SendClientMessage(playerid, COR_ERRO, "* Você foi kickado por errar muitas vezes a letra.");
			Kick(playerid);
			return Y_HOOKS_CONTINUE_RETURN_1;
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;                                                                                                                                                                                                                                                            
}

hook OnPlayerConnect(playerid)
{
	AFK[playerid][TimeChat] = gettime() + TIME_CHECK_AFK;
	AFK[playerid][TimeCMD] = gettime() + TIME_CHECK_AFK;

	AFK[playerid][TimerID] = SetTimerEx("CheckPlayerAFK", 800, true, "d", playerid);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	KillTimer(AFK[playerid][TimerID]);
	AFK[playerid] = reset;
	return Y_HOOKS_CONTINUE_RETURN_1;
}