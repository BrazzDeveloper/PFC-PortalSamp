/*
*
*		Includes
*
*/

#include ../bin/modules/jogador/callbacks.pwn
#include ../bin/modules/jogador/dialogs.pwn
#include ../bin/modules/jogador/cmds.pwn
//#include ../bin/modules/jogador/afk.pwn
#include ../bin/modules/jogador/tutorial.pwn
#include ../bin/modules/jogador/veiculo.pwn

/*
*
*		Functions
*
*/

stock GetUserName(playerid){
	new pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pName, sizeof(pName));
	return pName;
}

stock GetPlayerTableValue(playerid, column[], value[], len = sizeof(value))
{
	if ( !Jogador[playerid][Logado] )
		return false;

	new query[128];
	mysql_format(getConexao(), query, sizeof(query), "SELECT %e FROM "TABLE_USERS" WHERE `id`='%d' LIMIT 1;", column, Jogador[playerid][PlayerID]);
	new Cache:c = mysql_query(getConexao(), query, true);
	cache_get_value_name(0, column, value, len);
	cache_delete(c);
	return true;
}

stock GetPlayerTableValueInt(playerid, column[])
{
	if ( Jogador[playerid][Logado] )
		return -1;

	new tmp_value[11];
	GetPlayerTableValue(playerid, column, tmp_value);
	return strval(tmp_value);
}

stock Teleport(playerid, Float:x, Float:y, Float:z, Float:a, interior, world, entrou, bool:garagem=false)
{
	
	if(garagem == false)
	{
		if ( IsPlayerInAnyVehicle(playerid) )
		{
			
			SendClientMessage(playerid, COR_ERRO, "| ERRO | Saia do veículo primeiro.");
			return 1;
		}
	}

	if(garagem == true)
	{
		if( IsPlayerInAnyVehicle(playerid) )
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			SetVehiclePos(vehicleid, x, y, z);
			SetVehicleZAngle(vehicleid, a);
			LinkVehicleToInterior(vehicleid, interior);
			SetVehicleVirtualWorld(vehicleid, world);
		}
	}

	if(Jogador[playerid][Preso] > 0)
	{
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode sair da prisão.");
		return 1;
	}

	call::PLAYER->DisablePlayerGPS(playerid);
	SetPlayerPos(playerid, x, y, z);
	SetPlayerFacingAngle(playerid,a);
	SetPlayerInterior(playerid, interior);
	SetPlayerVirtualWorld(playerid, world);
	Jogador[playerid][Entrou] = entrou;
	GameTextForPlayer(playerid, "~r~Aguarde, carregando...", 3000, 3);
	SetTimerEx("DescongelarTeleport", 3000, false, "u", playerid);
	TogglePlayerControllable(playerid, 0);
	return 1;
}

stock TeleportPreso(playerid, Float:x, Float:y, Float:z, Float:a, interior, world, entrou)
{

	SetPlayerPos(playerid, x, y, z);
	SetPlayerFacingAngle(playerid,a);

	SetPlayerInterior(playerid, interior);
	SetPlayerVirtualWorld(playerid, world);
	Jogador[playerid][Entrou] = entrou;
	GameTextForPlayer(playerid, "~r~Aguarde, carregando...", 3000, 3);
	SetTimerEx("DescongelarTeleport", 4000, false, "u", playerid);
	TogglePlayerControllable(playerid, 0);
}

forward DescongelarTeleport(playerid);
public DescongelarTeleport(playerid)
{
	TogglePlayerControllable(playerid, 1);
	return 1;
}

stock function PLAYER::IsPlayerLogged(playerid){
	if( playerid == INVALID_PLAYER_ID || !IsPlayerConnected(playerid))
		return false;

	return Jogador[playerid][Logado];
}

stock function PLAYER::TogglePlayerLogged(playerid, bool:toggle)
{
	SetPVarInt(playerid, "pLogged_FS", toggle);
	Jogador[playerid][Logado]=toggle;
	return true;
}

stock function PLAYER::IsPlayerLoggin(playerid){
	return Jogador[playerid][inLogin];
}
stock function PLAYER::TogglePlayerLoggin(playerid, bool:toggle){
	Jogador[playerid][inLogin] = toggle;
	return true;
}

stock function PLAYER::GetPlayerMaxExp(playerid){
	new  exp = (MIN_EXP + (GetPlayerScore(playerid) * MIN_EXP));
	return exp;
}

ShowPlayerInfoBanned(playerid)
{
	new str[255], ip[16];
	GetPlayerIp(playerid, ip, sizeof(ip));
	ReadBan(GetUserName(playerid), ip, str, sizeof(str));
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{"COR_DISABLE_INC"}"SERVER_NAME" » {"COR_BRANCO_INC"}BANNED", str, "OK", "");
	return true;
}

function PLAYER::SetPlayerMarkGPS(playerid, Float:x, Float:y, Float:z){
	if(!IsPlayerConnected(playerid))
		return false;
	
	SetPlayerCheckpoint_CP(playerid, x, y, z, 1.0);
	SetPVarInt(playerid, "SetPlayerMarkGPS", 1);
	return true;
}

function PLAYER::DisablePlayerGPS(playerid)
{
	if(GetPVarInt(playerid, "SetPlayerMarkGPS")){
		DeletePVar(playerid, "SetPlayerMarkGPS");
		return DisablePlayerCheckpoint(playerid);
	}
	return 0;
}

function PLAYER::GetPlayerRequestGPS(playerid){
	return GetPVarInt(playerid, "SetPlayerMarkGPS");
}

function PLAYER::SetPlayerVarInt(playerid, e_PLAYER_INFO:param, value){
	Jogador[playerid][param] = value;
	return true;
}

function PLAYER::GetPlayerVarInt(playerid, e_PLAYER_INFO:param){
	if ( !IsPlayerConnected(playerid) )
		return false;
	return Jogador[playerid][param];
}

function PLAYER::SetPlayerVarFloat(playerid, e_PLAYER_INFO:param, Float:value){
	Jogador[playerid][param] = _:value;
	return true;
}

Float:function PLAYER::GetPlayerVarFloat(playerid, e_PLAYER_INFO:param){
	return Float:Jogador[playerid][param];
}

function PLAYER::SetPlayerVarBool(playerid, e_PLAYER_INFO:param, bool:value){
	Jogador[playerid][param] = value;
	return true;
}

bool:function PLAYER::GetPlayerVarBool(playerid, e_PLAYER_INFO:param){
	return bool:call::PLAYER->GetPlayerVarInt(playerid, param);
}

function PLAYER::CreatePlayerFadeSono(playerid)
{
	if(!GetPVarInt(playerid, "fadeSonoCreated"))
	{
		new PlayerText:textdraw = CreatePlayerTextDraw(playerid, 0.000000, 0.000000, "box_tampão");
		SetPVarInt(playerid, "fadeSonoTextdrawID", _:textdraw);
		SetPVarInt(playerid, "fadeSonoCreated", 1);

		PlayerTextDrawLetterSize(playerid, textdraw, 0.000000, 80.000000);
		PlayerTextDrawTextSize(playerid, textdraw, 800.000000, 0.000000);
		PlayerTextDrawAlignment(playerid, textdraw, 1);
		PlayerTextDrawColor(playerid, textdraw, -1);
		PlayerTextDrawUseBox(playerid, textdraw, 1);
		PlayerTextDrawBoxColor(playerid, textdraw, 0);
		PlayerTextDrawSetShadow(playerid, textdraw, 0);
		PlayerTextDrawSetOutline(playerid, textdraw, 0);
		PlayerTextDrawBackgroundColor(playerid, textdraw, 255);
		PlayerTextDrawFont(playerid, textdraw, 1);
		PlayerTextDrawSetProportional(playerid, textdraw, 1);
		PlayerTextDrawSetShadow(playerid, textdraw, 0);
		return true;
	}
	return false;
}
forward function PLAYER::DestroyPlayerFadeSono(playerid, value);
public function PLAYER::DestroyPlayerFadeSono(playerid, value)
{
	if(GetPVarInt(playerid, "fadeSonoCreated") != 0)
	{
		call::PLAYER->SetPlayerFadeEffect(playerid, value);
		if(value >= 250)
		{
			if(call::PLAYER->GetPlayerVarInt(playerid, pDormindo) == 0)
			{
				PlayerTextDrawDestroy(playerid, PlayerText:GetPVarInt(playerid, "fadeSonoTextdrawID"));
				DeletePVar(playerid, "fadeSonoTextdrawID");
				DeletePVar(playerid, "fadeSonoCreated");
				DeletePVar(playerid, "fadeSonoInit");
			}
			return true;
		}
		value += 10;
		return SetTimerEx("PLAYER_DestroyPlayerFadeSono", 100, false, "dd", playerid, value);
	}
	return false;
}

function PLAYER::SetPlayerFadeEffect(playerid, value)
{
	if(GetPVarInt(playerid, "fadeSonoCreated") != 0)
	{
		PlayerTextDrawBoxColor(playerid, PlayerText:GetPVarInt(playerid, "fadeSonoTextdrawID"), value);
		PlayerTextDrawShow(playerid, PlayerText:GetPVarInt(playerid, "fadeSonoTextdrawID"));
	}
	return true;
}

function PLAYER::IsNickRegistered(const nickname[])
{
	new query[128];
	mysql_format(getConexao(), query, sizeof(query), "SELECT username FROM "TABLE_USERS" WHERE `username`='%s' LIMIT 1;", nickname);
	new Cache:cache = mysql_query(getConexao(), query, true), rows = cache_num_rows();
	cache_delete(cache);
	return rows;
}

function PLAYER::IsEmailRegistered(const email[])
{
	new query[128];
	mysql_format(getConexao(), query, sizeof(query), "SELECT email FROM "TABLE_USERS" WHERE `email`='%s' LIMIT 1;", email);
	new Cache:cache = mysql_query(getConexao(), query, true), rows = cache_num_rows();
	cache_delete(cache);
	return rows;
}

function PLAYER::InitPlayerFadeEffect(playerid)
{
	if(call::PLAYER->CreatePlayerFadeSono(playerid) && !GetPVarInt(playerid, "fadeSonoInit"))
	{
		call::PLAYER->SetPlayerFadeEffect(playerid, 0);

		SetPVarInt(playerid, "fadeSonoInit", 1);
		SetTimerEx("PLAYER_DestroyPlayerFadeSono", 100, false, "dd", playerid, 0);
		return true;
	}
	return false;
}

static const Float:BombasDeCombustivel[][] =
{
	{-1685.6428, 408.8816, 7.3984}, {-1681.1162, 413.4082, 7.3984}, {-1676.1760, 418.3715, 7.4057}, {-1671.5475, 422.9988, 7.3984},
	{-1666.1249, 417.4100, 7.3984}, {-1670.3676, 413.1571, 7.3984}, {-1674.6177, 406.7124, 7.3984}, {-1678.9054, 402.4112, 7.3984},
	{-2410.0349, 970.8682, 45.4249}, {-2410.0366, 976.4913, 45.4254}, {-2410.0371, 981.9242, 45.4255}, {-1477.7137, 1860.5037, 32.6328},
	{-1477.8115, 1866.5459, 32.6398}, {-1465.4430, 1867.5077, 32.6328}, {-1464.8628, 1861.3409, 32.6398}, {623.5948, 1678.2305, 6.9922},
	{621.0383, 1681.8629, 6.9922}, {617.8644, 1687.0299, 6.9922}, {614.4550, 1691.8368, 6.9922}, {610.6506, 1696.6006, 6.9922},
	{607.2646, 1701.5338, 6.9922}, {604.2061, 1706.7931, 6.9922}, {2207.1150, 2470.2629, 10.9952}, {2207.0620, 2474.8887, 10.9952},
	{2207.1101, 2480.5164, 10.9952}, {2197.4905, 2480.3076, 10.9952}, {2197.4924, 2474.3420, 10.9952}, {2197.4910, 2470.0723, 10.9952},
	{2120.6501, 926.1002, 10.9609}, {2114.8953, 926.0962, 10.9609}, {2109.3398, 926.0967, 10.9609}, {2109.0032, 915.3163, 10.9609},
	{2114.8662, 915.3051, 10.9609}, {2121.0227, 915.3093, 10.9609}, {2121.0227, 915.3093, 10.9609}, {1385.4211, 458.9976, 20.0588},
	{1383.6833, 459.8147, 20.0596}, {1380.8464, 461.0646, 20.0579}, {1379.3223, 461.7320, 20.0509}, {654.9645, -559.7467, 16.5015},
	{654.9614, -570.4188, 16.5015}, {998.1636, -938.5319, 42.1797}, {1002.7866, -937.8485, 42.1797}, {1005.5317, -937.4445, 42.1797},
	{1009.9985, -936.7746, 42.1797}, {1942.4419, -1778.6445, 13.3906}, {1942.4546, -1774.0309, 13.3906}, {1942.4867, -1771.7413, 13.3906},
	{1942.4053, -1766.9242, 13.6406}, {-89.1856, -1176.8947, 2.1296}, {-96.4075, -1174.1829, 2.3391}, {-91.2620, -1161.9806, 2.2336},
	{-85.9206, -1164.9369, 2.3742}, {-1611.2872, -2721.8093, 48.5391}, {-1610.1115, -2720.1145, 48.5391}, {-1607.9084, -2717.4937, 48.5391},
	{-1606.7477, -2715.7356, 48.5391}, {-1604.5034, -2712.8130, 48.5335}, {-1603.3942, -2711.4067, 48.5335}, {-1601.1882, -2708.4817, 48.5391},
	{-1600.0770, -2706.9666, 48.5391}, {-2240.3833, -2562.8064, 31.9219}, {-2242.7314, -2561.6111, 31.9219}, {-2245.6765, -2560.2932, 31.9219},
	{-2247.4031, -2559.3462, 31.9219}, {2141.6262, 2752.3855, 10.8203}, {2147.4482, 2752.2949, 10.8203}, {2153.0962, 2752.2544, 10.8203},
	{2153.5481, 2743.8215, 10.8203}, {2147.9138, 2743.5083, 10.8203}, {2141.8120, 2743.5342, 10.8203}, {-1328.0707, 2682.9189, 49.7896}, {-1329.1359, 2677.6624, 49.7896},
	{-1329.1886, 2672.0464, 49.7896}, {2202.0750,2474.1509,10.3851}, {1540.6892,-2173.6021,13.5532}

};

function PLAYER::IsPlayerInPosto(playerid, Float:range=2.0)
{
	for(new i; i < sizeof(BombasDeCombustivel); i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, range, BombasDeCombustivel[i][0], BombasDeCombustivel[i][1], BombasDeCombustivel[i][2]))
			return true;
	}
	return false;
}

forward SetPlayerCameraLogin(playerid, mode);
public SetPlayerCameraLogin(playerid, mode)
{
	if ( mode != 0 )
	{
		SetPlayerCameraPos(playerid, 1682.6057,-2337.3450,30.9513);
		SetPlayerCameraLookAt(playerid, 1683.9274,-2247.9771,13.5496);
		return true;
	}
	SetTimerEx("SetPlayerCameraLogin", 1000, false, "dd", playerid, 1);
	return true;
}

stock IsPlayerTimeVip(playerid)
{
	new query[255];
	mysql_format(getConexao(), query, sizeof(query), "SELECT DATEDIFF(`vencimento_vip`, CURRENT_DATE) as dias FROM "TABLE_USERS" WHERE `username`='%s'", GetUserName(playerid));
	new Cache:cache = mysql_query(getConexao(), query, true), dias;
	cache_get_value_name_int(0, "dias", dias);
	cache_delete(cache);
	return ( dias < 1 ? 0 : dias);
}

stock SetPlayerVip(username[], dias, bool:increment)
{
	new query[255];
	if ( !increment )
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `vencimento_vip`=DATE_ADD(CURRENT_DATE, INTERVAL %d DAY) WHERE `username`='%s' LIMIT 1;", dias, username);
	else
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `vencimento_vip`=DATE_ADD(`vencimento_vip`, INTERVAL %d DAY) WHERE `username`='%s' LIMIT 1;", dias, username);

	new Cache:cache = mysql_query(getConexao(), query), affectedrows = cache_affected_rows();
	cache_delete(cache);

	if ( affectedrows )
		return true;

	return false;
}

/*stock function PLAYER::requestXP(playerid)
{
	new multiplicador = floatround( GetPlayerScore(playerid) / 100);
    return (MIN_XP + (Jogador[playerid][Vip] ? 0 : ( multiplicador * 2 )));
}*/

stock function PLAYER::requestXP(playerid)
{
	new multiplicador = floatround( GetPlayerScore(playerid) / 100);
    return (MIN_XP + (Jogador[playerid][Vip] ? 0 : ( multiplicador * 0 )));
}

function PLAYER::SetPlayerBetaLevel(playerid, level) {
	if( level < 0 || level > 1)
		return false;

	Jogador[playerid][Beta] = true;

	return true;
}

function PLAYER::RemovePlayerBeta(playerid){

	Jogador[playerid][Beta] = false;
	return false;
}

RewardPlayer(playerid, Money)
{
	GivePlayerMoney(playerid, Money);
    return 1;
}

//new PlayerText:pTextoFavela[MAX_PLAYERS][4];

/*LoadFavelaText(playerid)
{
	// Favela texto
	pTextoFavela[playerid][0] = CreatePlayerTextDraw(playerid, 144.318832, 370.249938, "hud:radar_emmetGun");
	PlayerTextDrawLetterSize(playerid, pTextoFavela[playerid][0], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, pTextoFavela[playerid][0], 14.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, pTextoFavela[playerid][0], 1);
	PlayerTextDrawColor(playerid, pTextoFavela[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, pTextoFavela[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, pTextoFavela[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, pTextoFavela[playerid][0], 255);
	PlayerTextDrawFont(playerid, pTextoFavela[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, pTextoFavela[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, pTextoFavela[playerid][0], 0);

	pTextoFavela[playerid][1] = CreatePlayerTextDraw(playerid, 161.440963, 367.866790, "kills: 0");
	PlayerTextDrawLetterSize(playerid, pTextoFavela[playerid][1], 0.283294, 1.191665);
	PlayerTextDrawAlignment(playerid, pTextoFavela[playerid][1], 1);
	PlayerTextDrawColor(playerid, pTextoFavela[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, pTextoFavela[playerid][1], 1);
	PlayerTextDrawSetOutline(playerid, pTextoFavela[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, pTextoFavela[playerid][1], 255);
	PlayerTextDrawFont(playerid, pTextoFavela[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, pTextoFavela[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, pTextoFavela[playerid][1], 1);

	pTextoFavela[playerid][2] = CreatePlayerTextDraw(playerid, 144.318832, 386.450225, "hud:radar_hostpital");
	PlayerTextDrawLetterSize(playerid, pTextoFavela[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, pTextoFavela[playerid][2], 14.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, pTextoFavela[playerid][2], 1);
	PlayerTextDrawColor(playerid, pTextoFavela[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, pTextoFavela[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, pTextoFavela[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, pTextoFavela[playerid][2], 255);
	PlayerTextDrawFont(playerid, pTextoFavela[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, pTextoFavela[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, pTextoFavela[playerid][2], 0);

	pTextoFavela[playerid][3] = CreatePlayerTextDraw(playerid, 161.440963, 384.766967, "deaths: 0");
	PlayerTextDrawLetterSize(playerid, pTextoFavela[playerid][3], 0.283294, 1.191665);
	PlayerTextDrawAlignment(playerid, pTextoFavela[playerid][3], 1);
	PlayerTextDrawColor(playerid, pTextoFavela[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, pTextoFavela[playerid][3], 1);
	PlayerTextDrawSetOutline(playerid, pTextoFavela[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, pTextoFavela[playerid][3], 255);
	PlayerTextDrawFont(playerid, pTextoFavela[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, pTextoFavela[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, pTextoFavela[playerid][3], 1);

}


IsPlayerInFavela(playerid)
{
	if(IsPlayerInPlace(playerid, 2102.763183, -1098.157836, 2312.763183, -1000.157836) || IsPlayerInPlace(playerid, 2172.763183, -1154.157836, 2256.763183, -1098.157836) )
		return true;
	else
		return false;
}

ShowPlayerTextoFavela(playerid)
{
	static str[128];
	format(str, sizeof(str), "Kills: %d", Jogador[playerid][Matou]);
	PlayerTextDrawSetString(playerid, pTextoFavela[playerid][1], str);

	format(str, sizeof(str), "Deaths: %d", Jogador[playerid][Morreu]);
	PlayerTextDrawSetString(playerid, pTextoFavela[playerid][3], str);

	for(new i; i < sizeof(pTextoFavela[]); i++)
	{
		PlayerTextDrawShow(playerid, pTextoFavela[playerid][i]);
	}
	return true;
}

HidePlayerTextoFavela(playerid)
{
	for(new i; i < sizeof(pTextoFavela[]); i++)
	{
		PlayerTextDrawHide(playerid, pTextoFavela[playerid][i]);
	}
	return true;
}

GivePlayerKitFavela(playerid, kit)
{
	Jogador[playerid][KitFavela] = kit;
	switch(kit)
	{
		case 1:
		{
			GivePlayerWeapon(playerid, WEAPON_COLT45, 999);
			GivePlayerWeapon(playerid, WEAPON_SHOTGUN, 150);
			GivePlayerWeapon(playerid, WEAPON_UZI, 999);
			GivePlayerWeapon(playerid, WEAPON_RIFLE, 100);
		}
		case 2:
		{
			GivePlayerWeapon(playerid, WEAPON_SILENCED, 999);
			GivePlayerWeapon(playerid, WEAPON_SAWEDOFF, 150);
			GivePlayerWeapon(playerid, WEAPON_MP5, 999);
			GivePlayerWeapon(playerid, WEAPON_RIFLE, 100);
		}
		case 3:
		{
			GivePlayerWeapon(playerid, WEAPON_DEAGLE, 999);
			GivePlayerWeapon(playerid, WEAPON_SHOTGSPA, 150);
			GivePlayerWeapon(playerid, WEAPON_M4, 999);
			GivePlayerWeapon(playerid, WEAPON_SNIPER, 100);
		}
	}
}*/