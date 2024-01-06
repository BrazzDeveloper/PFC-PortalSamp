#include <YSI_Coding\y_hooks>

static Joao, Text3D:LabelJoao, TrainLV, TrainLS, TrainSF, PilotLV, PilotSF, PilotLS; 

static 
	bool:EntrouBuzao[MAX_PLAYERS char];

hook OnGameModeInit()
{
	ConnectNPC("TrainDriverLV","train_lv");
	ConnectNPC("TrainDriverLS","train_ls");
	ConnectNPC("TrainDriverSF","train_sf");
	ConnectNPC("PilotLV","at400_lv");
	ConnectNPC("PilotSF","at400_sf");
	ConnectNPC("PilotLS","at400_ls");
	ConnectNPC("Joao", "joao");
	
	TrainLV = AddStaticVehicle(538, 1462.0745, 	2630.8787, 	10.8203, 189.1697, -1, -1); // Train LV
	TrainLS = AddStaticVehicle(538, -1942.7950, 168.4164, 	27.0006, 88.0707, -1, -1); // Train LS
	TrainSF = AddStaticVehicle(537, 1700.7551, -1953.6531, 	14.8756, 357.3896, -1, -1); // Train SF

	PilotSF = AddStaticVehicle(577, 0.0, 0.0, 0.0, 0.0, -1, -1); // Pilot SF
	PilotLV = AddStaticVehicle(577, 0.0, 0.0, 0.0, 0.0, -1, -1); // Pilot LV
	PilotLS = AddStaticVehicle(577, 0.0, 0.0, 0.0, 0.0, -1, -1); // Pilot LS

	//Joao = AddStaticVehicle(431, 0.0, 0.0, 0.0, 0.0, -1, -1);
	//LabelJoao = Create3DTextLabel("[ LINHA 1 ]", 0x277243FF, 0.0, 0.0, 0.0, 50.0, 0);
}
// 592

hook OnPlayerConnect(playerid)
{
	if(IsPlayerNPC(playerid))
	{
	    new ip_addr_npc[64+1];
	    new ip_addr_server[64+1];

	    GetServerVarAsString("bind",ip_addr_server, sizeof(ip_addr_server));
	    GetPlayerIp(playerid, ip_addr_npc, sizeof(ip_addr_npc));
	    
		if ( !strlen(ip_addr_server) )
		    ip_addr_server = "127.0.0.1";
		
		if ( strcmp(ip_addr_npc, ip_addr_server, true) != 0 )
		{
		    printf("NPC: Got a remote NPC connecting from %s and I'm kicking it.",ip_addr_npc);
		    Kick(playerid);
		    return Y_HOOKS_BREAK_RETURN_0;
		}
		return Y_HOOKS_BREAK_RETURN_1;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}


hook OnPlayerDisconnect(playerid, reason)
{
	if ( EntrouBuzao{playerid} == true )
	{
		GivePlayerMoney(playerid, -50);
	}
	EntrouBuzao{playerid} = false;
	return Y_HOOKS_CONTINUE_RETURN_1;
}
hook OnPlayerRequestClass(playerid, classid)
{
	if(! IsPlayerNPC(playerid) )
		return Y_HOOKS_CONTINUE_RETURN_1;
	
	call::PLAYER->TogglePlayerLogged(playerid, true);
 	if(!strcmp(GetUserName(playerid),"TrainDriverLV",true)) {
        SetSpawnInfo(playerid,69,255,1462.0745,2630.8787,10.8203,0.0,-1,-1,-1,-1,-1,-1);
	}
	else if(!strcmp(GetUserName(playerid),"TrainDriverSF",true)) {
	    SetSpawnInfo(playerid,69,255,-1942.7950,168.4164,27.0006,0.0,-1,-1,-1,-1,-1,-1);
	}
	else if(!strcmp(GetUserName(playerid),"TrainDriverLS",true)) {
	    SetSpawnInfo(playerid,69,255,1700.7551,-1953.6531,14.8756,0.0,-1,-1,-1,-1,-1,-1);
	}
	else if(!strcmp(GetUserName(playerid),"PilotLV",true)) {
	    SetSpawnInfo(playerid,69,61,0.0,0.0,0.0,0.0,-1,-1,-1,-1,-1,-1);
	}
	else if(!strcmp(GetUserName(playerid),"PilotSF",true)) {
	    SetSpawnInfo(playerid,69,61,0.0,0.0,0.0,0.0,-1,-1,-1,-1,-1,-1);
	}
	else if(!strcmp(GetUserName(playerid),"PilotLS",true)) {
	    SetSpawnInfo(playerid,69,61,0.0,0.0,0.0,0.0,-1,-1,-1,-1,-1,-1);
	}
	/*else if(!strcmp(GetUserName(playerid),"Joao",true)){
		SetSpawnInfo(playerid,69,61,0.0,0.0,0.0,0.0,-1,-1,-1,-1,-1,-1);
		Attach3DTextLabelToPlayer(LabelJoao, playerid, 0.0, 0.0, 0.6);
	}*/
	return Y_HOOKS_BREAK_RETURN_1;
}

hook OnPlayerSpawn(playerid)
{
	if(!IsPlayerNPC(playerid))
		return Y_HOOKS_CONTINUE_RETURN_1;

	if(!strcmp(GetUserName(playerid), "TrainDriverLV", true)) {
        PutPlayerInVehicle(playerid, TrainLV, 0);
        SetPlayerColor(playerid,0xFFFFFFFF);
 	}
	else if(!strcmp(GetUserName(playerid), "TrainDriverSF", true)) {
	    PutPlayerInVehicle(playerid,TrainSF,0);
	    SetPlayerColor(playerid,0xFFFFFFFF);
	}
	else if(!strcmp(GetUserName(playerid), "TrainDriverLS", true)) {
	    PutPlayerInVehicle(playerid,TrainLS,0);
	    SetPlayerColor(playerid,0xFFFFFFFF);
	}
	else if(!strcmp(GetUserName(playerid), "PilotLV", true)) {
	    PutPlayerInVehicle(playerid,PilotLV,0);
	    SetPlayerColor(playerid,0xFFFFFFFF);
	}
	else if(!strcmp(GetUserName(playerid), "PilotSF", true)) {
	    PutPlayerInVehicle(playerid,PilotSF,0);
	    SetPlayerColor(playerid,0xFFFFFFFF);
	}
	else if(!strcmp(GetUserName(playerid), "PilotLS", true)) {
	    PutPlayerInVehicle(playerid,PilotLS,0);
	    SetPlayerColor(playerid,0xFFFFFFFF);
	}
	/*else if(!strcmp(GetUserName(playerid), "Joao", true)) {
	    PutPlayerInVehicle(playerid,Joao,0);
	    SetPlayerColor(playerid,0xFFFFFFFF);
	}*/
	return Y_HOOKS_BREAK_RETURN_1;
}



hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if ( ! IsPlayerNPC(playerid) )
	{
		if ( newstate == PLAYER_STATE_PASSENGER )
		{
			if ( GetPlayerVehicleID(playerid) == Joao )
			{
				EntrouBuzao{playerid} = true;
				return Y_HOOKS_CONTINUE_RETURN_1;
			}
		}
		/*else if ( EntrouBuzao{playerid} == true )
		{
			EntrouBuzao{playerid} = false;
			GivePlayerMoney(playerid, -50, true);
			SendClientMessage(playerid, COR_BRANCO, "Jo�o[?][{E9D31D}NPC{FFFFFF}] disse: Obrigado senhor!");
		}*/
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}