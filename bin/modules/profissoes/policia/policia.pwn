#if defined _inc_policia
	#error arquivo gerado
#endif

static const Float:CelasPrisao[][] =
{
	{1315.4972,-872.4409,11.5027},
	{1318.9247,-872.1858,11.5027},
	{1321.9772,-872.2748,11.5027},
	{1325.4086,-872.6105,11.5027},
	{1328.4598,-872.1888,11.5027},
	{1331.4542,-875.3322,11.5027},
	{1331.6722,-878.4890,11.5027},
	{1331.4469,-881.7667,11.5027},
	{1331.3391,-884.9438,11.5027}
};

/*static const Float:CelasLosSantos[][] =
{
	{264.1914, 86.2944, 1001.0391, 90.0000},
	{264.2642, 81.0629, 1001.0391, 90.0000},
	{264.7795, 81.7773, 1001.0457, 90.0000}
};

static const Float:CelasSF[][] = 
{
	{219.11975, 108.59809, 998.01532},
	{214.76483, 108.13013, 998.01532},
	{223.02049, 108.45776, 998.01532},
	{226.95946, 108.58559, 998.01532}
};

static const Float:CelasLV[][]=
{
	{194.54076, 162.35536, 1002.02435},
	{190.50098, 162.24921, 1002.02435},
	{198.91145, 162.25813, 1002.02435},
	{188.76086, 174.33563, 1002.02344},
	{193.05070, 174.45988, 1002.02344},
	{197.13063, 174.70404, 1002.02344}
};*/

new static 
	PlayerText:TimePrison[MAX_PLAYERS], TimerPerseguicao[MAX_PLAYERS], Localizando[MAX_PLAYERS], PmID[MAX_PLAYERS];

#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	CreateDynamicPickup(1247, 23, 1525.9398, -1677.3005, 5.8906, 0, 0, .streamdistance=30.0); // /prender Los Santos
	CreateDynamicPickup(1247, 23, -1606.1379, 673.2057, -5.2422, 0, 0, .streamdistance=30.0); // /prender San Fierro
	CreateDynamicPickup(1247, 23, 2282.2183, 2424.3428, 3.4766, 0, 0, .streamdistance=30.0); // /prender Las Venturas

	//CreateDynamicPickup(1242, 24, 257.8182,77.7084,1003.6406, .interiorid=6, .streamdistance=10.0); // /trocar skin Los Santos
	//CreateDynamic3DTextLabel("Aperte F para trocar skin", 0x16A75AFF, 254.0876, 78.8198, 1003.6406, 1.0, .interiorid=6, .streamdistance=10.0);//trocar skin Los Santos

	// Veiculos
	call::JOB->SetVehicleJob(CreateVehicle(596, 1535.9813, -1667.6187, 12.9729, 0.1341, -1, -1, 	TIME_VEHICLE_SPAWN), 	POLICIA_MILITAR);
	call::JOB->SetVehicleJob(CreateVehicle(596, 1536.0015, -1678.1123, 12.9729, 359.7990, -1, -1, 	TIME_VEHICLE_SPAWN),	POLICIA_MILITAR);
	call::JOB->SetVehicleJob(CreateVehicle(596, 1552.4932, -1614.6538, 13.0397, 0.0000, -1, -1, 	TIME_VEHICLE_SPAWN), 	POLICIA_MILITAR);
	call::JOB->SetVehicleJob(CreateVehicle(596, 1557.0504, -1614.6760, 13.0397, 0.0000, -1, -1, 	TIME_VEHICLE_SPAWN), 	POLICIA_MILITAR);
	call::JOB->SetVehicleJob(CreateVehicle(596, 1561.7593, -1614.6534, 13.0397, 0.0000, -1, -1, 	TIME_VEHICLE_SPAWN), 	POLICIA_MILITAR);
	call::JOB->SetVehicleJob(CreateVehicle(596, 1566.4622, -1614.6753, 13.0397, 0.0000, -1, -1, 	TIME_VEHICLE_SPAWN), 	POLICIA_MILITAR);
	call::JOB->SetVehicleJob(CreateVehicle(596, 1571.0800, -1614.7461, 13.0397, 0.0000, -1, -1, 	TIME_VEHICLE_SPAWN), 	POLICIA_MILITAR);
	call::JOB->SetVehicleJob(CreateVehicle(596, 1575.4910, -1614.7804, 13.0397, 0.0000, -1, -1, 	TIME_VEHICLE_SPAWN), 	POLICIA_MILITAR);
	call::JOB->SetVehicleJob(CreateVehicle(523, 1580.2361, -1604.1326, 12.9488, 177.3033, -1, -1, 	TIME_VEHICLE_SPAWN), 	POLICIA_MILITAR);
	call::JOB->SetVehicleJob(CreateVehicle(523, 1582.0455, -1604.2159, 12.9496, 178.2768, -1, -1, 	TIME_VEHICLE_SPAWN), 	POLICIA_MILITAR);
	call::JOB->SetVehicleJob(CreateVehicle(523, 1583.9740, -1604.1248, 12.9521, 179.4607, -1, -1, 	TIME_VEHICLE_SPAWN), 	POLICIA_MILITAR);
	call::JOB->SetVehicleJob(CreateVehicle(523, 1585.9513, -1604.1871, 12.9523, 179.9288, -1, -1, 	TIME_VEHICLE_SPAWN), 	POLICIA_MILITAR);
	call::JOB->SetVehicleJob(CreateVehicle(523, 1587.7197, -1604.1445, 12.9509, 179.8583, -1, -1, 	TIME_VEHICLE_SPAWN), 	POLICIA_MILITAR);
	call::JOB->SetVehicleJob(CreateVehicle(599, -1399.9597, 2631.7783, 55.9460,92.1383, -1, -1, 	TIME_VEHICLE_SPAWN), 	POLICIA_MILITAR);
	call::JOB->SetVehicleJob(CreateVehicle(599, -1399.9863, 2637.8792, 55.8776, 90.7791, -1, -1, 	TIME_VEHICLE_SPAWN), 	POLICIA_MILITAR);
	call::JOB->SetVehicleJob(CreateVehicle(599, -1399.6434, 2650.2114, 55.8786,88.6543, -1, -1, 	TIME_VEHICLE_SPAWN), 	POLICIA_MILITAR);
	call::JOB->SetVehicleJob(CreateVehicle(599, -1399.6257, 2656.6499, 55.8735,90.1429, -1, -1, 	TIME_VEHICLE_SPAWN), 	POLICIA_MILITAR);
	CreateObject(1522, -1390.80627, 2639.21533, 54.97758,   0.00000, 0.00000, 0.00000);
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if( call::JOB->IsValidVehicleJob(vehicleid) )
	{
		if(call::JOB->GetVehicleJob(vehicleid) == POLICIA_MILITAR)
		{
			if(!call::JOB->IsPlayerInWorking(playerid))
			{
				SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está uniformizado.");
				ClearAnimations(playerid);
			}
			return true;
		}
	}
	return 1;
}

hook OnPlayerConnect(playerid)
{
	TimePrison[playerid] = PlayerText:INVALID_TEXT_DRAW;
	PmID[playerid] = INVALID_PLAYER_ID;	
	DeletePVar(playerid, "MotivoID");
	DeletePVar(playerid, "AlgemadoPor");
}

hook OnPlayerDisconnect(playerid, reason)
{
	DeletePVar(playerid, "MotivoID");
	DeletePVar(playerid, "AlgemadoPor");
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if ( PRESSED(KEY_CROUCH))
	{
		if ( call::PLAYER->GetPlayerVarInt(playerid, Profissao) != POLICIA_MILITAR)
			return Y_HOOKS_CONTINUE_RETURN_1;

		call::MAP->AbrirPortaoDP(playerid);
		return Y_HOOKS_CONTINUE_RETURN_1;
	}
	/*if(PRESSED(KEY_SECONDARY_ATTACK))
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.0, 272.5082, 117.7337, 1004.6172))
		{
			if ( call::PLAYER->GetPlayerVarInt(playerid, Profissao) != POLICIA_MILITAR )
			return true;

			if(!call::JOB->IsPlayerInWorking(playerid))
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");

			ShowPlayerDialog(playerid, DIALOG_SKINPM, DIALOG_STYLE_LIST, "| POLICIA | Escolha sua nova skin", "Policia Los Santos\nPolicia San Fierro\nPolicia Las Venturas\nCounty Sheriff\nS.W.A.T", "Escolher", "Sair");
		}
	}*/
	return Y_HOOKS_CONTINUE_RETURN_1;
}

/*Dialog:DIALOG_SKINPM(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: SetPlayerSkin(playerid, 280), SendClientMessage(playerid, COR_AZUL, "| POLICIA | Você alterou sua skin para 280");
			case 1: SetPlayerSkin(playerid, 281), SendClientMessage(playerid, COR_AZUL, "| POLICIA | Você alterou sua skin para 281");
			case 2: SetPlayerSkin(playerid, 282), SendClientMessage(playerid, COR_AZUL, "| POLICIA | Você alterou sua skin para 282");
			case 3: SetPlayerSkin(playerid, 283), SendClientMessage(playerid, COR_AZUL, "| POLICIA | Você alterou sua skin para 283");
			case 4: SetPlayerSkin(playerid, 285), SendClientMessage(playerid, COR_AZUL, "| POLICIA | Você alterou sua skin para 285");
		}
	}
}*/

forward ResetableVarsPerseguicao(pmid, playerid);
public ResetableVarsPerseguicao(pmid, playerid)
{
	if ( call::PLAYER->GetPlayerVarBool(playerid, Perseguido) )
	{
		TimerPerseguicao[pmid] = -1;
		TimerPerseguicao[playerid] = -1;

		call::PLAYER->SetPlayerVarBool(pmid, Perseguindo, false);
		SendClientMessage(pmid, GetPlayerColor(pmid), "O(A) jogador(a) %s não está mais sendo perseguido.", GetUserName(playerid));

		call::PLAYER->SetPlayerVarInt(playerid, TempoPerseguido, gettime() + 120);

		call::PLAYER->SetPlayerVarBool(playerid, Perseguido, false);
		SendClientMessage(playerid, GetPlayerColor(pmid), "O(A) Policial %s não está mais lhe perseguindo.", GetUserName(pmid));

		SendClientMessageToAll(GetPlayerColor(playerid), "O(A) Policial %s não está mais perseguindo o suspeito %s", GetUserName(pmid), GetUserName(playerid));
	}
	return true;
}


stock function PM::resetVarsPerseguicao(playerid)
{
	if( call::PLAYER->GetPlayerVarInt(playerid, Perseguido) )
	{
		new pmid = PmID[playerid];
		PmID[playerid] = INVALID_PLAYER_ID;

		TimerPerseguicao[pmid] = -1;
		TimerPerseguicao[playerid] = -1;

		call::PLAYER->SetPlayerVarBool(pmid, Perseguindo, false);
		call::PLAYER->SetPlayerVarBool(playerid, Perseguido, false);
	}
	return true;
}

// ============================== [ COMMANDs ] ============================== //

CMD:prender(playerid, params[])
{
	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != POLICIA_MILITAR)
		return SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);

	if(!call::JOB->IsPlayerInWorking(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");

	new pid;
	if(sscanf(params, "u", pid))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/prender [playerid / playername]");

	if(call::ADMIN->IsAdminInJob(pid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode prender um Administrador em modo trabalho.");

	if ( GetPlayerWantedLevel(pid) < 1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse(a) jogador(a) não está sendo procurado pela policia.");
	
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, 1525.9398, -1677.3005, 5.8906))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você tem que levar o jogador para a delegacia.");
	
	if(!call::PLAYER->IsPlayerLogged(pid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) Jogador(a) não está logado(a).");

	if(!IsPlayerInRangeOfPoint(pid, 5.0, 1525.9398, -1677.3005, 5.8906))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) Suspeito(a) não está proximo.");

	if(GetPlayerWantedLevel(pid) == 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) Jogador(a) não está sendo procurado.");

	if(!call::PLAYER->GetPlayerVarBool(pid, Algemado))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) Jogador(a) não está algemado.");

	call::PM->PrenderJogador(playerid, pid);
	return true;
}

CMD:algemar(playerid, params[])
{
	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != POLICIA_MILITAR)
		return SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);

	if(!call::JOB->IsPlayerInWorking(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");

	if ( IsPlayerInAnyVehicle(playerid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode algemar um suspeito estando dentro do veiculo.");

	new pid;
	if(sscanf(params, "d", pid))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/algemar [playerid]");

	if(call::ADMIN->IsAdminInJob(pid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode algemar um Administrador em modo trabalho.");

	if ( GetPlayerWantedLevel(pid) < 1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Este(a) jogador(a) não está sendo procurado pela policia.");

	if(playerid == pid)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode algemar você mesmo.");

	if(!call::PLAYER->IsPlayerLogged(pid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) não está logado(a).");

	if(call::PLAYER->GetPlayerVarBool(pid, Algemado))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) já está algemado(a).");
	
	if(IsPlayerInAnyVehicle(pid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode algemar um(a) jogador(a) que está dentro de um veículo.");
	
	if(pAssaltante[pid][Assaltando])
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode algemar um(a) jogador(a) que está realizando um assalto.");

	SetPVarInt(pid, "AlgemadoPor", playerid);

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	if( GetPlayerDistanceFromPoint(pid, x, y, z) > 5.0 )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo ao jogador.");

	SetPlayerSpecialAction(pid, SPECIAL_ACTION_CUFFED);
	call::PLAYER->SetPlayerVarBool(pid, Algemado, true);
	SendClientMessage(pid, COR_SISTEMA, "» O(A) Policial {"COR_BRANCO_INC"}%s{"COR_SISTEMA_INC"} algemou Você.", GetUserName(playerid));
	TogglePlayerControllable(pid, false);

	SendClientMessage(playerid, COR_SISTEMA, "» O(A) suspeito(a) {"COR_BRANCO_INC"}%s{"COR_SISTEMA_INC"} foi algemado(a).", GetUserName(pid));
	return true;
}

CMD:desalgemar(playerid, params[])
{
	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != POLICIA_MILITAR)
		return SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);

	if(!call::JOB->IsPlayerInWorking(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");

	new pid;
	if(sscanf(params, "d", pid))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/desalgemar [playerid]");

	if ( GetPlayerWantedLevel(pid) < 1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse playerid não está sendo procurado pela policia.");

	if(playerid == pid)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode desalgemar Você mesmo.");

	if(!call::PLAYER->IsPlayerLogged(pid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) não está logado(a).");

	if(!call::PLAYER->GetPlayerVarBool(pid, Algemado))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) não está algemado.");

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	if(GetPlayerDistanceFromPoint(pid, x, y, z) > 5.0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo ao jogador.");

	SetPlayerSpecialAction(pid, SPECIAL_ACTION_NONE), call::PLAYER->SetPlayerVarBool(pid, Algemado, false);
	SendClientMessage(pid, COR_SISTEMA, "» O(A) Policial {"COR_BRANCO_INC"}%s{"COR_SISTEMA_INC"} desalgemou Você.", GetUserName(playerid));
	TogglePlayerControllable(pid, true);

	SendClientMessage(playerid, COR_SISTEMA, "» O(A) suspeito(a) {"COR_BRANCO_INC"}%s{"COR_SISTEMA_INC"} foi desalgemado(a).", GetUserName(pid));
	return true;
}

/*CMD:procurar(playerid, params[])
{
	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != POLICIA_MILITAR)
		return SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);

	if(!call::JOB->IsPlayerInWorking(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");

	new pid, nivel, motivo[30];
	if(sscanf(params, "uds[30]", pid, nivel, motivo))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/procurar [playerid / playername] [nivel procurado] [motivo (abreviado)]");

	if(call::ADMIN->IsAdminInJob(pid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode colocar estrelas em um Administrador em modo trabalho.");

	if(playerid == pid)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode se colocar na lista de procurados.");

	if( !call::PLAYER->IsPlayerLogged(pid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) Jogador(a) não está conectado(a).");

	if(call::PLAYER->GetPlayerVarInt(pid, Preso) != SOLTO )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode colocar o jogador na lista de procurados, pois ele está preso.");

	for(new i; i < sizeof(MotivosSu); i++)
	{
		if ( strcmp(motivo, MotivosSu[i][Abreviacao], true) == 0)
		{
			DeletePVar(playerid, "MotivoID");
			SetPVarInt(playerid, "MotivoID", i);
		}
	}

	new motivoid = GetPVarInt(playerid, "MotivoID");

	if ( strcmp(motivo, MotivosSu[motivoid][Abreviacao], true) == 0)
	{
		if(nivel != MotivosSu[motivoid][Estrelas])
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | O nivel de estrelas digitado não corresponde ao crime, verifique a lista /motivos e tente novamente.");

		SetPlayerWantedLevel(pid, GetPlayerWantedLevel(pid)+MotivosSu[motivoid][Estrelas]);
		SendClientMessage(pid, COR_AZUL, "| POLICIA | O(A) Policial {"COR_BRANCO_INC"}%s{"COR_AZUL_INC"} colocou você na lista de procurados.", GetUserName(playerid));
		SendClientMessage(pid, COR_AZUL, "| POLICIA |  Nivel: {"COR_BRANCO_INC"}%d{"COR_AZUL_INC"} Motivo: {"COR_BRANCO_INC"}%s - %s{"COR_AZUL_INC"}", MotivosSu[motivoid][Estrelas], MotivosSu[motivoid][Crime], MotivosSu[motivoid][Abreviacao]);

		SendClientMessage(playerid, COR_AZUL, "| POLICIA | Você adicionou {"COR_BRANCO_INC"}%s{"COR_AZUL_INC"} na lista de procurados.", GetUserName(pid), MotivosSu[motivoid][Crime], MotivosSu[motivoid][Abreviacao] );
		SendClientMessage(playerid, COR_AZUL, "| POLICIA | Estrelas: {"COR_BRANCO_INC"}%d{"COR_AZUL_INC"} Motivo: {"COR_BRANCO_INC"}%s - %s{"COR_AZUL_INC"}", MotivosSu[motivoid][Estrelas], MotivosSu[motivoid][Crime], MotivosSu[motivoid][Abreviacao]);

		format(Jogador[pid][Crime], 10, MotivosSu[motivoid][Abreviacao]);

		new query[128];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `crime`='%s' WHERE `id`='%d' LIMIT 1;", Jogador[pid][Crime], Jogador[pid][PlayerID]);
		mysql_tquery(getConexao(), query);

		DeletePVar(playerid, "MotivoID");	

	} else return SendClientMessage(playerid, COR_ERRO, "| ERRO | Digite o comando /motivos e tente novamente.");

	foreach(new i: Player)
	{
		if(call::PLAYER->GetPlayerVarInt(i, Profissao) == POLICIA_MILITAR)
		{
			SendClientMessage(i, GetPlayerColor(playerid), "» {"COR_SISTEMA_INC"}O(A) Policial {"COR_BRANCO_INC"}%s {"COR_SISTEMA_INC"}colocou {"COR_BRANCO_INC"}%s(%d) {"COR_SISTEMA_INC"}na lista de procurados pelo motivo: {"COR_BRANCO_INC"}%s {"COR_SISTEMA_INC"}| Nível de Procurado: {"COR_BRANCO_INC"}%d", GetUserName(playerid), GetUserName(pid), pid, motivo, nivel);
		}
		return 1;
	}
	return true;
}*/

CMD:perseguir(playerid, params[])
{
	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != POLICIA_MILITAR)
		return SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);

	if(!call::JOB->IsPlayerInWorking(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");

	new pid;
	if(sscanf(params, "u", pid))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/perseguir [playerid / playername]");

	if ( !call::PLAYER->IsPlayerLogged(pid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) não está conectado.");

	if(playerid == pid)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode perseguir você mesmo.");

	if ( GetPlayerWantedLevel(pid) < 1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse jogador não está sendo procurado pela policia.");

	if(call::ADMIN->IsAdminInJob(pid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode perseguir um Administrador em modo trabalho.");

	if(!call::PLAYER->IsPlayerLogged(pid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) Jogador(a) não está conectado(a).");

	if(!GetPlayerWantedLevel(pid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) Jogador(a) não está sendo procurado(a).");

	if( call::PLAYER->GetPlayerVarBool(pid, Perseguido) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) já está sendo perseguido(a).");

	if(call::PLAYER->GetPlayerVarInt(pid, TempoPerseguido) > gettime() )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa aguardar alguns segundos para utilizar o comando novamente.");
 	
	if ( !IsPlayerStreamedIn(playerid, pid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa está mais próximo ao jogador.");

	call::PLAYER->SetPlayerVarBool(pid, Perseguido, true);
	SendClientMessage(pid, COR_SISTEMA, "» {"COR_BRANCO_INC"}O(A) Policial {"COR_AMARELO_INC"}%s{"COR_BRANCO_INC"} está lhe perseguindo, você precisa fugir dele por 5 minutos.", GetUserName(playerid));

	call::PLAYER->SetPlayerVarBool(playerid, Perseguindo, true);
	SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Você está perseguindo o(a) jogador(a) {"COR_AMARELO_INC"}%s{"COR_BRANCO_INC"}, Você tem 5 minutos para captura-lo.", GetUserName(pid));

	SendClientMessageToAll(GetPlayerColor(playerid), "» O(A) Policial {"COR_BRANCO_INC"}%s{%06x} está perseguindo o(a) suspeito(a) {"COR_BRANCO_INC"}%s{%06x}", GetUserName(playerid), (GetPlayerColor(playerid) >>> 8), GetUserName(pid), (GetPlayerColor(playerid) >>> 8));
	
	PmID[pid] = playerid;

	KillTimer(TimerPerseguicao[playerid]);
	KillTimer(TimerPerseguicao[pid]);
	TimerPerseguicao[playerid] = TimerPerseguicao[pid] = SetTimerEx("ResetableVarsPerseguicao", (5 * (60 * 1000)), false, "dd", playerid, pid);
	return true;
}

CMD:arrastar(playerid, params[])
{
	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != POLICIA_MILITAR)
		return SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);

	if(!call::JOB->IsPlayerInWorking(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");

	if(isnull(params) || !IsNumeric(params))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/arrastar [playerid]");

	new pid = strval(params);

	if(!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo.");

	if(call::ADMIN->IsAdminInJob(pid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode arrastar um Administrador em modo trabalho.");

	if ( GetPlayerWantedLevel(pid) < 1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse(a) jogador(a) não está sendo procurado pela policia.");

	new vehicleid = GetPlayerVehicleID(playerid);

	if( call::JOB->GetVehicleJob(vehicleid) != POLICIA_MILITAR )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em uma viatura da Policia Militar.");

	if(!call::PLAYER->GetPlayerVarBool(pid, Algemado))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) não está algemado.");
	
	if(GetPVarInt(pid, "AlgemadoPor") != playerid)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não algemou este(a) jogador(a).");

	new Float:x, Float:y, Float:z;
	GetPlayerPos(pid, x, y, z);
	if ( GetPlayerDistanceFromPoint(playerid, x, y, z) > 10.0 )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa esta mais próximo do(a) jogador(a).");


	if(!IsVehicleSeatOccupied(vehicleid, 3)){
		PutPlayerInVehicle(pid, vehicleid, 3);
	}
	else if(!IsVehicleSeatOccupied(vehicleid, 4)){
		PutPlayerInVehicle(pid, vehicleid, 4);
	}
	else{
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Não tem mais vaga no veiculo.");
		return true;
	}
	TogglePlayerControllable(pid, false);
	SendClientMessage(pid, GetPlayerColor(playerid), "» {"COR_BRANCO_INC"}O Policial %s te arrastou a força para a viatura.", GetUserName(playerid));

	SendClientMessage(playerid, GetPlayerColor(playerid), "» {"COR_BRANCO_INC"}Você arrastou o suspeito %s até a viatura.", GetUserName(pid));
	return true;
}

CMD:procurados(playerid)
{
	if( call::PLAYER->GetPlayerVarInt(playerid, Profissao) != POLICIA_MILITAR )
		return SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);

	if( !call::JOB->IsPlayerInWorking(playerid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");

	if( call::JOB->GetVehicleJob(GetPlayerVehicleID(playerid)) != POLICIA_MILITAR )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em uma viatura da Policia Militar.");

	new str[1045] = "id\tnome\testrelas\tdistância\n", Float:x, Float:y, Float:z, count;
	foreach(new i: Player)
	{
		if(GetPlayerWantedLevel(i) > 0 && !call::ADMIN->IsAdminInJob(i) )
		{
			GetPlayerPos(i, x, y, z);
			format(str, sizeof(str), "%s%d\t{"COR_VERMELHO_INC"}%s\t{"COR_AMARELO_INC"}%d\t{"COR_VERDE_INC"}%0.1f{"COR_BRANCO_INC"}\n", str, i, GetUserName(i), GetPlayerWantedLevel(i), GetPlayerDistanceFromPoint(playerid, x, y, z));
			count++;
		}
	}
	if(count)
		return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "LISTA DE PROCURADOS", str, "OK", "");

	SendClientMessage(playerid, COR_ERRO, "A Cidade está limpa! Não há nenhum criminoso a solta.");
	return true;
}

CMD:localizar(playerid, params[])
{
	if( call::PLAYER->GetPlayerVarInt(playerid, Profissao) != POLICIA_MILITAR )
		return SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);
		
	if ( isnull(params) || !IsNumeric(params))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/localizar [playerid]");
	
	new id = strval(params);
	
	if ( !IsPlayerConnected(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Jogador não está conectado.");

	if( call::ADMIN->IsAdminInJob(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode localizar um Administrador em modo trabalho.");

	if ( GetPlayerWantedLevel(id) < 1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse playerid não está sendo procurado pela policia.");

	if ( Localizando[playerid] )
		RemovePlayerMapIcon(playerid, 15), KillTimer(Localizando[playerid]);

	static Float:x, Float:y, Float:z;
	GetPlayerPos(id, x, y, z);
	SetPlayerMapIcon(playerid, 15, x, y, z, 0, COR_VERMELHO);
	Localizando[playerid] = SetTimerEx("AtualizarLocalizacao", 500, true, "dd", playerid, id);

	SendClientMessage(playerid, 0x05329CFF, "| LOCALIZAR | Você localizou o(a) jogador(a) %s[%d]!", GetUserName(id), id);
	return true;
}

CMD:deslocalizar(playerid, params[])
{
	if( call::PLAYER->GetPlayerVarInt(playerid, Profissao) != POLICIA_MILITAR )
		return SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);

	if ( !Localizando[playerid] )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está localizando ninguém");

	RemovePlayerMapIcon(playerid, 15);
	KillTimer(Localizando[playerid]);
	Localizando[playerid]=0;

	SendClientMessage(playerid, COR_AZUL, "* Você desativou o localizador.");
	return true;
}

forward AtualizarLocalizacao(playerid, suspeitoid);
public AtualizarLocalizacao(playerid, suspeitoid)
{
	if ( !IsPlayerConnected(suspeitoid) )
	{
		RemovePlayerMapIcon(playerid, 15);
		SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) Jogador(a) que você estava localizando saiu do servidor.");
		return KillTimer(Localizando[playerid]), Localizando[playerid]=0;
	}

	if ( !IsPlayerConnected(playerid) )
		return KillTimer(Localizando[playerid]), Localizando[playerid]=0;

	static Float:x, Float:y, Float:z;
	
	if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) != ENTROU_NONE )
	{
		new interiorid = GetPlayerVirtualWorld(playerid);
		switch(call::PLAYER->GetPlayerVarInt(playerid, Entrou))
		{
			case ENTROU_EMPRESA:
				call::BUSINESS->GetBusinessPos(interiorid, x, y, z);

			case ENTROU_CASA:
				call::HOUSE->GetHousePos(interiorid, x, y, z);

			case ENTROU_PROPRIEDADE:
				call::PROPERTY->GetPropertyPos(interiorid, x, y, z);
		}
	}
	else
	{
		GetPlayerPos(suspeitoid, x, y, z);
	}

	RemovePlayerMapIcon(playerid, 15);
	SetPlayerMapIcon(playerid, 15, x, y, z, 0, COR_VERMELHO);
	return true;
}

// ============================== [ FUNCTIONs ] ============================== //
stock EnviarCela(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 50.0, 1525.9398, -1677.3005, 5.8906)) // Los Santos
	{
		new rand = random(sizeof(CelasPrisao));
		TeleportPreso(playerid, CelasPrisao[rand][0], CelasPrisao[rand][1], CelasPrisao[rand][2], 0.0, 0, 0, ENTROU_PROPRIEDADE);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 50.0, -1606.1379, 673.2057, -5.2422)) // San Fierro
	{
		new rand = random(sizeof(CelasPrisao));
		TeleportPreso(playerid, CelasPrisao[rand][0], CelasPrisao[rand][1], CelasPrisao[rand][2], 0.0, 0, 0, ENTROU_PROPRIEDADE);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 50.0, 2282.2183, 2424.3428, 3.4766)) // Las Venturas
	{
		new rand = random(sizeof(CelasPrisao));
		TeleportPreso(playerid, CelasPrisao[rand][0], CelasPrisao[rand][1], CelasPrisao[rand][2], 0.0, 0, 0, ENTROU_PROPRIEDADE);
	}
	else
	{
		new rand = random(sizeof(CelasPrisao));
		TeleportPreso(playerid, CelasPrisao[rand][0], CelasPrisao[rand][1], CelasPrisao[rand][2], 0.0, 0, 0, ENTROU_PROPRIEDADE);
	}
	return true;
}


stock function PM::PrenderJogador(pmid, playerid)
{
	new level = GetPlayerWantedLevel(playerid), valor = (level * 150), tempo = (level * 180);
	
	valor = ( valor > 15000 ? 15000 : valor);

	if(call::ADMIN->GetPlayerAdminLevel(pmid) >= AJUDANTE)
	{
		call::PLAYER->SetPlayerVarInt(playerid, Preso, PRESO_ADM);
	}
	else
	{
		call::PLAYER->SetPlayerVarInt(playerid, Preso, PRESO_POLICIA);
	}

	call::PLAYER->SetPlayerVarInt(playerid, TempoPreso, tempo);

	EnviarCela(playerid);

	GivePlayerMoney(pmid, valor);
	SendClientMessage(pmid, COR_AZUL, "| PRISÃO | Você prendeu o(a) procurado(a) %s[%d] e recebeu R$%s pelo seu trabalho!", RealStr(valor));
	call::PLAYER->SetPlayerVarBool(pmid, Perseguindo, false);

	call::PM->ShowPlayerTextDrawPrisonTime(playerid);
	SetPlayerHealth(playerid, 1000);
	TogglePlayerControllable(playerid, true);

	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE), call::PLAYER->SetPlayerVarInt(playerid, Algemado, 0), call::PLAYER->SetPlayerVarBool(playerid, Perseguido, false);
	SendClientMessage(playerid, COR_AZUL, "| PRISÃO | Você foi preso(a) pelo(a) Policial %s[%d].", GetUserName(playerid), playerid);

	if(TimerPerseguicao[pmid] != -1)
		KillTimer(TimerPerseguicao[pmid]), TimerPerseguicao[pmid]=-1;

	if(TimerPerseguicao[playerid] != -1)
		KillTimer(TimerPerseguicao[playerid]), TimerPerseguicao[playerid]=-1;

	if ( Localizando[pmid] != 0)
		KillTimer(Localizando[pmid]), Localizando[pmid]=0, RemovePlayerMapIcon(pmid, 15);

	/**
	*
	*	resetar estrelas e armas.
	*
	**/
	ResetPlayerWeapons(playerid);
	if( Jogador[playerid][Preso] == PRESO_POLICIA )
	{
		SetPlayerWantedLevel(playerid, 0);
	}
	return true;
}

stock function PM::SoltarPrisioneiro(playerid)
{
	PlayerTextDrawDestroy(playerid, TimePrison[playerid]);
	TimePrison[playerid] = PlayerText:INVALID_TEXT_DRAW;

	Jogador[playerid][TempoPreso] = 0;
	Jogador[playerid][Preso] = SOLTO;
	format(Jogador[playerid][Crime], 10, "Null");

	//if( IsPlayerInPlace(playerid, 261.6254, 75.6872, 266.7498, 90.1865) ) // Delegacia de Los Santos
	//{
	TeleportPreso(playerid, 1555.06, -1675.74, 16.1953 ,89.6941, 0, 0, Jogador[playerid][Entrou]);
	//}

	new query[128];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `tempo_preso`='0',  `preso`='0', `crime`='0' WHERE `id`='%d' LIMIT 1;", Jogador[playerid][PlayerID]);
	mysql_tquery(getConexao(), query);

	SetPlayerWantedLevel(playerid, 0);

	GameTextForPlayer(playerid, "~y~LIBERADO!!!", 2000, 4);
	SetPlayerHealth(playerid, 100);
	return true;
}

stock function PM::ShowPlayerTextDrawPrisonTime(playerid)
{
	if ( INVALID_TEXT_DRAW == _:TimePrison[playerid])
	{
		//TimePrison[playerid] = CreatePlayerTextDraw(playerid, 142.500000, 351.583251, "tempo~n~00:00:00"); 140.000000, 393.000000
		TimePrison[playerid] = CreatePlayerTextDraw(playerid, 125.000000, 328.000000, "tempo:~n~00:00:00");
		PlayerTextDrawLetterSize(playerid, TimePrison[playerid], 0.239500, 1.034166);
		PlayerTextDrawAlignment(playerid, TimePrison[playerid], 1);
		PlayerTextDrawColor(playerid, TimePrison[playerid], -1);
		PlayerTextDrawSetShadow(playerid, TimePrison[playerid], 1);
		PlayerTextDrawSetOutline(playerid, TimePrison[playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, TimePrison[playerid], 255);
		PlayerTextDrawFont(playerid, TimePrison[playerid], 2);
		PlayerTextDrawSetProportional(playerid, TimePrison[playerid], 1);
		PlayerTextDrawSetShadow(playerid, TimePrison[playerid], 1);
	}
	PlayerTextDrawShow(playerid, TimePrison[playerid]);
	return true;
}


stock function PM::FinalizarPerseguicao(playerid, reason)
{
	if ( call::PLAYER->GetPlayerVarInt(playerid, Perseguido) )
	{

		switch(reason)
		{
			case 1: // disconnect
			{
				/**
				*
				*	resetar variáveis do policial.
				*
				**/
				KillTimer(TimerPerseguicao[PmID[playerid]]);
				TimerPerseguicao[PmID[playerid]] = -1;
				call::PLAYER->SetPlayerVarInt(PmID[playerid], Perseguindo, false);


				call::PM->PrenderJogador(PmID[playerid], playerid);

				/**
				*
				*	resetar variáveis do fugitivo.
				*
				**/
				KillTimer(TimerPerseguicao[playerid]);
				TimerPerseguicao[playerid] = -1;
				PmID[playerid] = INVALID_PLAYER_ID;
				call::PLAYER->SetPlayerVarInt(playerid, Perseguido, false);
			}
		}
	}
	return true;
}

hook OnTimeOneSecondsPlayer(playerid)
{
	if ( Jogador[playerid][Preso] >= 1 )
	{
		if(Jogador[playerid][AFK] == true)
		{
			PlayerTextDrawSetString(playerid, TimePrison[playerid], "tempo:~n~~h~~r~pausado");
			return Y_HOOKS_CONTINUE_RETURN_1;
		}
		
		new str[30], hours, minutes, seconds;
		Jogador[playerid][TempoPreso] -= 1;
		formatSeconds(Jogador[playerid][TempoPreso], hours, minutes, seconds);

		format(str, sizeof(str), "tempo:~n~%02d:%02d:%02d", hours, minutes, seconds);
		PlayerTextDrawSetString(playerid, TimePrison[playerid], str);
		if ( Jogador[playerid][TempoPreso] <= 0 )
		{
			call::PM->SoltarPrisioneiro(playerid);
			SetPlayerHealth(playerid, 100);
		}
		else
		{
			/**
			*
			*	Vida infitina enquanto esteja preso.
			*
			**/
			SetPlayerHealth(playerid, 1000);
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

