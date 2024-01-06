#include <YSI_Coding\y_hooks>

// Enums
enum cheat_type
{
	MOP_HACK,
	MONEY_HACK,
	AUTO_AIM,
	VPN_PROXY,
	WEAPON_HACK
}

// Vars
enum warnings_player
{
	wMoneyHack,
	lMoneyHack,
	tMoneyHack,

	wMOPHack,
	lMOPHack,
	tMOPHack,

	wWeaponHack,
	lWeaponHack,
	tWeaponHack
}

new pACData[MAX_PLAYERS][warnings_player];

// Stocks
//stock GivePlayerMoneyEx(playerid, money) return pData[playerid][pMoney] += money, GivePlayerMoney(playerid, money);
//stock SetPlayerMoneyEx(playerid, money) return pData[playerid][pMoney] = money, ResetPlayerMoney(playerid), GivePlayerMoney(playerid, pData[playerid][pMoney]);
//stock ResetPlayerMoneyEx(playerid) return pData[playerid][pMoney] = 0, ResetPlayerMoney(playerid);
//stock GetPlayerMoneyEx(playerid) return pData[playerid][pMoney];

stock KickPlayerForCheat(playerid, const cheat[])
{
	if(!IsPlayerConnected(playerid))
	{
		return 0;
	}
	new String[500];
	format(String, sizeof(String), "{FFFFFF}Você foi kickado por suspeita de cheat/hack.\n\n\
									{FFFFFF}Nick: {FF0000}%s\n\
									{FFFFFF}Suspeita de: {FF0000}%s\n\
									{FFFFFF}Data: {FF0000}%s\n\n\
									{FFFFFF}Se você não utiliza nenhum cheat/hack, volte e jogue normalmente.", GetUserName(playerid), cheat, CreateTimestamp());
	ShowPlayerDialog(playerid, DIALOG_NULL, DIALOG_STYLE_MSGBOX, "{FF0000}AntiCheat", String, "Fechar", "");
	format(String, sizeof(String), "| ANTI-CHEAT | %s foi kickado por suspeita de \"%s\"", GetUserName(playerid), cheat);
	SendMessageToAdmins(COLOR_RED, String);
	Kick(playerid);
	return 1;
}



stock BanPlayerForCheat(playerid, const cheat[])
{
	if(!IsPlayerConnected(playerid))
	{
		return 0;
	}
	new String[500];
	format(String, sizeof(String), "{FFFFFF}Você foi banido por suspeita de cheat/hack.\n\n\
									{FFFFFF}Nick: {FF0000}%s\n\
									{FFFFFF}Suspeita de: {FF0000}%s\n\
									{FFFFFF}Data: {FF0000}%s\n\n\
									{FFFFFF}Caso você acha que foi um engano, faça revisão.", GetUserName(playerid), cheat, CreateTimestamp());
	ShowPlayerDialog(playerid, DIALOG_NULL, DIALOG_STYLE_MSGBOX, "{FF0000}AntiCheat", String, "Fechar", "");
	format(String, sizeof(String), "| ANTI-CHEAT | %s foi banido por suspeita de \"%s\"", GetUserName(playerid), cheat);
	//SendMessageToAdmins(COLOR_RED, String);
	new ip[17];
	GetPlayerIp(playerid, ip, sizeof(ip));
	mysql_format(gConnect, query, sizeof(query), "INSERT INTO `bans`(`pName`,`pIP`,`pMotivo`,`pAdmin`,`pData`) VALUES('%e','%e','%e', 'SERVER', '%e')", GetUserName(playerid), ip, cheat, CreateTimestamp());
	mysql_query(gConnect, query);
	Kick(playerid);
	return 1;
}

// Callbacks
hook OnPlayerCheckAccount(playerid)
{
	// Anti Lock-on/auto-aim
	if(IsPlayerMobile(playerid) && IsPlayerHaveAutoaim(playerid))
	{
		KickPlayerForCheat(playerid, "Lock-on/Auto-aim");
		return 1;
	}

	// Anti VPN
	//new ip[17];
	//
	//GetPlayerIp(playerid, ip, sizeof(ip));
	//
	//if(strcmp(ip, "127.0.0.1", true))
	//{
	//	format(String, sizeof String, "www.shroomery.org/ythan/proxycheck.php?ip=%s", ip);
	//	HTTP(playerid, HTTP_GET, String, "", "CheckPlayerUsingVPN");
	//}
	return 1;
}

function CheckPlayerUsingVPN(playerid, response_code, data[])
{
	if(response_code == 200)
	{	
		if(data[0] == 'Y')
		{
			CallLocalFunction("OnCheatDetected", "ii", playerid, VPN_PROXY);
		}
	}
	return 1;
}

hook OnPlayerConnect(playerid)
{
	// Clear variables Money Hack
	pACData[playerid][wMoneyHack] = 0;
	pACData[playerid][lMoneyHack] = gettime();
	pACData[playerid][tMoneyHack] = gettime();

	// Clear variables MOP Hack
	pACData[playerid][wMOPHack] = 0;
	pACData[playerid][lMOPHack] = gettime();
	pACData[playerid][tMOPHack] = gettime();

	// Clear variables Weapon Hack
	/*pACData[playerid][wWeaponHack] = 0;
	pACData[playerid][lWeaponHack] = gettime();
	pACData[playerid][tWeaponHack] = gettime();*/
	return 1;
}

hook OnPlayerUpdate(playerid)
{
	
	// Clear Money Hack warnings
	if(gettime() > pACData[playerid][tMoneyHack] && pACData[playerid][wMoneyHack] > 0)
	{
		pACData[playerid][wMoneyHack] --;
		pACData[playerid][tMoneyHack] = gettime() + 15;
	}

	// Clear MOP Hack Warnings
	if(gettime() > pACData[playerid][tMOPHack] && pACData[playerid][wMOPHack] > 0)
	{
		pACData[playerid][wMOPHack] --;
		pACData[playerid][tMOPHack] = gettime() + 15;
	}

	// Clear Weapon Hack Warnings
	/*if(gettime() > pACData[playerid][tWeaponHack] && pACData[playerid][wWeaponHack] > 0)
	{
		pACData[playerid][wWeaponHack] --;
		pACData[playerid][tWeaponHack] = gettime() + 15;
	}*/

	// Money Hack
	if(GetPlayerMoney(playerid) > pData[playerid][pMoney] && gettime() > pACData[playerid][lMoneyHack])
	{
		pACData[playerid][lMoneyHack] = gettime() + 1;
		pACData[playerid][wMoneyHack] ++;
		pACData[playerid][tMoneyHack] = gettime() + 15;
		CallLocalFunction("OnCheatDetected", "ii", playerid, MONEY_HACK);
	}

	// Mod Vassoura (MOP)
	new anim1[64], anim2[64];

	GetAnimationName(GetPlayerAnimationIndex(playerid), anim1, 64, anim2, 64);
	if(IsPlayerMobile(playerid)) return 0;
	if(!strcmp(anim1, "PED", true) && !strcmp(anim2, "CAR_SIT_PRO", true) && !IsPlayerInAnyVehicle(playerid) && gettime() > pACData[playerid][lMOPHack] && pData[playerid][pSelectingGang] == 0 && pData[playerid][pLogged] == true)
	{
		pACData[playerid][lMOPHack] = gettime() + 1;
		pACData[playerid][wMOPHack] ++;
		pACData[playerid][tMOPHack] = gettime() + 15;
		CallLocalFunction("OnCheatDetected", "ii", playerid, MOP_HACK);
	}

	// Weapon Hack
	/*if(GetPlayerWeapon(playerid) > pData[playerid][pGuns] && gettime() > pACData[playerid][lWeaponHack] && pData[playerid][pSelectingGang] == 0 && pData[playerid][pLogged] == true)
	{
		pACData[playerid][lWeaponHack] = gettime() + 1;
		pACData[playerid][wWeaponHack] ++;
		pACData[playerid][tWeaponHack] = gettime() + 15;
		CallLocalFunction("OnCheatDetected", "ii", playerid, WEAPON_HACK);
	}*/
	return 1;
}

function OnCheatDetected(playerid, type_cheat)
{
	// Discord LOG
	new DCC_Embed:lEmbed;

	// Types
	switch(type_cheat)
	{
		case MONEY_HACK:
		{
			if(pACData[playerid][wMoneyHack] == 3)
			{
				// Log system
				format(String, sizeof(String), "[KICK] Money Hack: %s (%d)", GetUserName(playerid), playerid);
				//CreateLog(LOG_ANTI_CHEAT, String);

				format(String, sizeof(String), "**Anti-Cheat [%s]**", CreateLogTimestamp());
				lEmbed = DCC_CreateEmbed(String);
				format(String, sizeof(String), "**`[KICK] Money Hack: %s (%d)`**", GetUserName(playerid), playerid);
				DCC_SetEmbedDescription(lEmbed, String);
				DCC_SetEmbedColor(lEmbed, 16711680);
				DCC_SetEmbedThumbnail(lEmbed, "https://i.imgur.com/g09Pkie.png");
				DCC_SendChannelEmbedMessage(g_Logs, lEmbed);

				// General
				KickPlayerForCheat(playerid, "Money Hack");
			}
			else
			{
				// Log system
				format(String, sizeof(String), "[REPORT] Money Hack: %s (%d) [%s > %s]", GetUserName(playerid), playerid, ConvertNumber(GetPlayerMoneyEx(playerid)), ConvertNumber(GetPlayerMoney(playerid)));
				CreateLog(LOG_ANTI_CHEAT, String);

				format(String, sizeof(String), "**Anti-Cheat [%s]**", CreateLogTimestamp());
				lEmbed = DCC_CreateEmbed(String);
				format(String, sizeof(String), "**`[REPORT] Money Hack: %s (%d) [%s > %s]`**", GetUserName(playerid), playerid, ConvertNumber(GetPlayerMoneyEx(playerid)), ConvertNumber(GetPlayerMoney(playerid)));
				DCC_SetEmbedDescription(lEmbed, String);
				DCC_SetEmbedColor(lEmbed, 16776960);
				DCC_SetEmbedThumbnail(lEmbed, "https://i.imgur.com/g09Pkie.png");
				DCC_SendChannelEmbedMessage(g_Logs, lEmbed);

				// General
				format(String, sizeof(String), "| ANTI-CHEAT | Money Hack: %s (%d) [%s > %s]", GetUserName(playerid), playerid, ConvertNumber(GetPlayerMoneyEx(playerid)), ConvertNumber(GetPlayerMoney(playerid)));
				SendMessageToAdmins(COLOR_YELLOW, String);
				SetPlayerMoneyEx(playerid, GetPlayerMoneyEx(playerid));
			}
		}

		case MOP_HACK:
		{
			if(pACData[playerid][wMOPHack] == 3)
			{
				// Log system
				format(String, sizeof(String), "[KICK] MOP-Hack: %s (%d)", GetUserName(playerid), playerid);
				CreateLog(LOG_ANTI_CHEAT, String);

				format(String, sizeof(String), "**Anti-Cheat [%s]**", CreateLogTimestamp());
				lEmbed = DCC_CreateEmbed(String);
				format(String, sizeof(String), "**`[KICK] MOP-Hack: %s (%d)`**", GetUserName(playerid), playerid);
				DCC_SetEmbedDescription(lEmbed, String);
				DCC_SetEmbedColor(lEmbed, 16711680);
				DCC_SetEmbedThumbnail(lEmbed, "https://i.imgur.com/g09Pkie.png");
				DCC_SendChannelEmbedMessage(g_Logs, lEmbed);

				// General
				KickPlayerForCheat(playerid, "MOP-Hack");
			}
			else
			{
				// Log system
				format(String, sizeof(String), "[REPORT] MOP-Hack: %s (%d)", GetUserName(playerid), playerid);
				CreateLog(LOG_ANTI_CHEAT, String);

				format(String, sizeof(String), "**Anti-Cheat [%s]**", CreateLogTimestamp());
				lEmbed = DCC_CreateEmbed(String);
				format(String, sizeof(String), "**`[REPORT] MOP-Hack: %s (%d)`**", GetUserName(playerid), playerid);
				DCC_SetEmbedDescription(lEmbed, String);
				DCC_SetEmbedColor(lEmbed, 16776960);
				DCC_SetEmbedThumbnail(lEmbed, "https://i.imgur.com/g09Pkie.png");
				DCC_SendChannelEmbedMessage(g_Logs, lEmbed);

				// General
				format(String, sizeof(String), "| ANTI-CHEAT | MOP-Hack: %s (%d)", GetUserName(playerid), playerid);
				SendMessageToAdmins(COLOR_YELLOW, String);
			}
		}

		case VPN_PROXY:
		{
			// Log system
			format(String, sizeof(String), "[REPORT] VPN: %s (%d) | %s - %s (%s) - %s (%s) - %s (%s)", GetUserName(playerid), playerid, GetPlayerCity(playerid), GetPlayerRegion(playerid), GetPlayerRegionCode(playerid), GetPlayerCountry(playerid), GetPlayerCountryCode(playerid), GetPlayerContinent(playerid), GetPlayerContinentCode(playerid));
			CreateLog(LOG_ANTI_CHEAT, String);

			format(String, sizeof(String), "**Anti-Cheat [%s]**", CreateLogTimestamp());
			lEmbed = DCC_CreateEmbed(String);
			format(String, sizeof(String), "**`[REPORT] VPN: %s (%d) | %s - %s (%s) - %s (%s) - %s (%s)`**", GetUserName(playerid), playerid, GetPlayerCity(playerid), GetPlayerRegion(playerid), GetPlayerRegionCode(playerid), GetPlayerCountry(playerid), GetPlayerCountryCode(playerid), GetPlayerContinent(playerid), GetPlayerContinentCode(playerid));
			DCC_SetEmbedDescription(lEmbed, String);
			DCC_SetEmbedColor(lEmbed, 16776960);
			DCC_SetEmbedThumbnail(lEmbed, "https://i.imgur.com/g09Pkie.png");
			DCC_SendChannelEmbedMessage(g_Logs, lEmbed);

			// General
			format(String, sizeof(String), "| ANTI-CHEAT | VPN: %s (%d) | %s - %s (%s) - %s (%s) - %s (%s)", GetUserName(playerid), playerid, GetPlayerCity(playerid), GetPlayerRegion(playerid), GetPlayerRegionCode(playerid), GetPlayerCountry(playerid), GetPlayerCountryCode(playerid), GetPlayerContinent(playerid), GetPlayerContinentCode(playerid));
			SendMessageToAdmins(COLOR_YELLOW, String);
		}

		/*case WEAPON_HACK:
		{
			if(pACData[playerid][wWeaponHack] == 3)
			{
				// Log system
				format(String, sizeof(String), "[KICK] Weapon Hack: %s (%d)", GetUserName(playerid), playerid);
				CreateLog(LOG_ANTI_CHEAT, String);

				format(String, sizeof(String), "**Anti-Cheat [%s]**", CreateLogTimestamp());
				lEmbed = DCC_CreateEmbed(String);
				format(String, sizeof(String), "**`[KICK] Weapon Hack: %s (%d)`**", GetUserName(playerid), playerid);
				DCC_SetEmbedDescription(lEmbed, String);
				DCC_SetEmbedColor(lEmbed, 16711680);
				DCC_SetEmbedThumbnail(lEmbed, "https://i.imgur.com/g09Pkie.png");
				DCC_SendChannelEmbedMessage(g_Logs, lEmbed);

				// General
				KickPlayerForCheat(playerid, "Weapon Hack");
			}
			else
			{
				// Log system
				format(String, sizeof(String), "[REPORT] Weapon Hack: %s (%d)", GetUserName(playerid), playerid);
				CreateLog(LOG_ANTI_CHEAT, String);

				format(String, sizeof(String), "**Anti-Cheat [%s]**", CreateLogTimestamp());
				lEmbed = DCC_CreateEmbed(String);
				format(String, sizeof(String), "**`[REPORT] Weapon Hack: %s (%d)`**", GetUserName(playerid), playerid);
				DCC_SetEmbedDescription(lEmbed, String);
				DCC_SetEmbedColor(lEmbed, 16776960);
				DCC_SetEmbedThumbnail(lEmbed, "https://i.imgur.com/g09Pkie.png");
				DCC_SendChannelEmbedMessage(g_Logs, lEmbed);

				// General
				format(String, sizeof(String), "| ANTI-CHEAT | Weapon Hack: %s (%d)", GetUserName(playerid), playerid);
				SendMessageToAdmins(COLOR_YELLOW, String);
				SetPlayerArmedWeapon(playerid, 0);
			}
		}*/
	}
	return 1;
}