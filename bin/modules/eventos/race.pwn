

enum e_RACE_INFO
{
	bool:Participando,
	cpID,
	Voltas,
	Vehicleid
}
static Race[MAX_PLAYERS][e_RACE_INFO];

static Participantes, _posicao, Valor_Arrecadado = 0;




// -1368.5232, -92.4031, 1053.7690, 172.0959, 7
//

static Float:Vehicles[][] =
{
	{-1427.8682,-277.2126,1051.1284,288.7306},
	{-1425.5806,-284.8130,1051.1376,288.8156},
	{-1437.7433,-279.2576,1051.0582,276.0805},
	{-1437.3821,-286.9268,1051.0619,273.4674},
	{-1447.6327,-279.3011,1050.8379,265.4852},
	{-1448.5901,-286.7902,1050.8391,264.4107}

};

static Float:CheckPoints[][] =
{
	{-1387.7278,-148.9961,1050.8401},
	{-1332.1610,-279.7201,1046.6139},
	{-1522.1860,-169.2147,1050.3927},
	{-1477.1727,-275.9250,1049.9564}
};

#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	printf("» Carregando evento de race. Valor da inscrição em R$%s\n", RealStr(VALOR_INSCRICAO));

	// BASE
	CreateObject(3452, -1359.08740, -99.97107, 1058.49561,   0.00000, 0.00000, 175.92001);
	CreateObject(3452, -1329.57141, -102.08698, 1058.49561,   0.00000, 0.00000, 175.92001);

	new tmpobjid;
	tmpobjid = CreateDynamicObject(18766, -1371.696777, -94.957542, 1053.722045, 0.000000, 0.000000, 86.947998, .streamdistance=100.0, .interiorid=7);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	
	tmpobjid = CreateDynamicObject(18981, -1359.601684, -90.106849, 1051.483154, 0.000000, 0.000000, 87.060050, .streamdistance=100.0, .interiorid=7);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	
	tmpobjid = CreateDynamicObject(18981, -1334.673828, -91.730239, 1051.483154, 0.000000, 0.000000, 85.520050, .streamdistance=100.0, .interiorid=7);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	
	tmpobjid = CreateDynamicObject(18981, -1328.285644, -111.643463, 1043.367919, 0.000000, 0.000000, 85.936759, .streamdistance=100.0, .interiorid=7);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	
	tmpobjid = CreateDynamicObject(18981, -1373.436523, -96.619338, 1048.621582, -20.000000, 0.000000, 174.360107, .streamdistance=100.0, .interiorid=7);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	
	tmpobjid = CreateDynamicObject(18981, -1362.083496, -109.213668, 1043.367919, 0.000000, 0.000000, 85.936759, .streamdistance=100.0, .interiorid=7);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	
	tmpobjid = CreateDynamicObject(18981, -1337.181274, -110.963539, 1043.367919, 0.000000, 0.000000, 85.936759, .streamdistance=100.0, .interiorid=7);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	
	tmpobjid = CreateDynamicObject(18981, -1314.73706, -100.61266, 1048.62158, -20.00000, 0.00000, 174.36011, .streamdistance=100.0, .interiorid=7);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);

	CreateDynamicObject(7212, -1351.61462, -110.39807, 1056.90918, 0.00000, 0.00000, 85.94159, .streamdistance=100.0, .interiorid=7);
	CreateDynamicObject(7212, -1338.88123, -111.29730, 1056.90918, 0.00000, 0.00000, 266.02280, .streamdistance=100.0, .interiorid=7);

	CreateDynamicCP(-1317.1350, -96.6939, 1075.7690, 1.5, .interiorid=7, .streamdistance=30.0);
	
	new str[200];
	format(str, sizeof(str), "Utilize '{"COR_AMARELO_INC"}/inscreverse{"COR_BRANCO_INC"}' para se inscrever na corrida.\nO Valor do evento é de {"COR_VERDE_INC"}R$%d{"COR_BRANCO_INC"} pela inscrição.", VALOR_INSCRICAO);
	CreateDynamic3DTextLabel(str, COR_BRANCO, -1317.13, -96.69, 1054.00, 30.0, .streamdistance=30.0);
	
	return true;
}

hook OnPlayerConnect(playerid)
{
	new reset[e_RACE_INFO];
	Race[playerid] = reset;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(Race[playerid][Participando])
	{
		--Participantes;
		if( !Participantes )
		{
			SendClientMessageToAll(COR_SISTEMA, "CORRIDA: {"COR_BRANCO_INC"}A Corrida terminou.");
			_posicao=0;
			Valor_Arrecadado=0;
		}

		DisableRemoteVehicleCollisions(playerid, 0);
		DestroyVehicle(Race[playerid][Vehicleid]);
		DisablePlayerRaceCheckpoint(playerid);
		SetPlayerPos(playerid, -1317.1350, -96.6939, 1054.000);

		new reset[e_RACE_INFO];
		Race[playerid] = reset;
	}
	return true;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	if( Race[playerid][Participando] )
	{
		--Participantes;
		if( !Participantes )
		{
			SendClientMessageToAll(COR_SISTEMA, "CORRIDA: {"COR_BRANCO_INC"}A Corrida terminou.");
			_posicao=0;
			Valor_Arrecadado=0;
		}

		DisableRemoteVehicleCollisions(playerid, 0);
		DestroyVehicle(Race[playerid][Vehicleid]);
		DisablePlayerRaceCheckpoint(playerid);
		SetPlayerPos(playerid, -1317.1350, -96.6939, 1053.7690);
		new reset[e_RACE_INFO];
		Race[playerid] = reset;
	}
	return true;	
}

hook OnPlayerEnterRaceCP(playerid)
{
	if(Race[playerid][Participando])
	{
		const maior = sizeof(CheckPoints) - 2; 

		new 
			type = 0, cpid = Race[playerid][cpID];

		switch(cpid)
		{
			case 0..maior: // 0, 1, 2
			{
				if(cpid == 2 && Race[playerid][Voltas] >= MAXIMO_VOLTAS)
					type = 1;

				SetPlayerRaceCheckpoint(playerid, type, CheckPoints[cpid][0], CheckPoints[cpid][1], CheckPoints[cpid][2], CheckPoints[cpid + 1][0], CheckPoints[cpid + 1][1], CheckPoints[cpid + 1][2], 5.0);
				
				++Race[playerid][cpID];
				return Y_HOOKS_BREAK_RETURN_1;

			}
			default: // 3
			{

				if(Race[playerid][Voltas] >= MAXIMO_VOLTAS)
				{
					new str[128];

					++_posicao;

					format(str, sizeof(str), "» {"COR_BRANCO_INC"}O(A) Jogador(a) {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"} chegou em {"COR_AZUL_INC"}%d°{"COR_BRANCO_INC"}", GetUserName(playerid), _posicao);
					SendClientMessageToAll(COR_AZUL, str);

					switch(_posicao)
					{
						case 1:
						{
							new valor = floatround(Valor_Arrecadado * 0.5);
							SendClientMessage(playerid, COR_VERDE, "» Você recebeu R$%s como bonificação por sua posição final na corrida.", RealStr(valor) );
							GivePlayerMoney(playerid, valor, true);
						}
						case 2:
						{
							new valor = floatround(Valor_Arrecadado * 0.3);
							SendClientMessage(playerid, COR_VERDE, "» Você recebeu R$%s como bonificação por sua posição final na corrida.", RealStr(valor) );
							GivePlayerMoney(playerid, valor, true);
						}
						case 3:
						{
							new valor = floatround(Valor_Arrecadado * 0.2);
							SendClientMessage(playerid, COR_VERDE, "» Você recebeu R$%s como bonificação por sua posição final na corrida.", RealStr(valor) );
							GivePlayerMoney(playerid, valor, true);
						}
					}

					DisablePlayerRaceCheckpoint(playerid);
					DisableRemoteVehicleCollisions(playerid, 0);

					SetPlayerPos(playerid, -1317.1350, -96.6939, 1053.7690);
					DestroyVehicle(Race[playerid][Vehicleid]);
					
					--Participantes;
					if(!Participantes)
					{
						SendClientMessageToAll(COR_SISTEMA, "CORRIDA: {"COR_BRANCO_INC"}A Corrida terminou.");
						Participantes=0;
						_posicao=0;
					}

					new reset[e_RACE_INFO];
					Race[playerid] = reset;

					return Y_HOOKS_BREAK_RETURN_1;
				}
				Race[playerid][Voltas]++;
				
				SetPlayerRaceCheckpoint(playerid, type, CheckPoints[cpid][0], CheckPoints[cpid][1], CheckPoints[cpid][2], CheckPoints[0][0], CheckPoints[0][1], CheckPoints[0][2], 5.0);
				Race[playerid][cpID] = 0;
				return Y_HOOKS_BREAK_RETURN_1;
			}
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

forward ContagemCorrida(contagem);
public ContagemCorrida(contagem)
{
	
	if(contagem == 3)
	{
		foreach(new i: Player)
		{
			if(Race[i][Participando] == true)
			{
				GameTextForPlayer(i, "~r~GO", 3000, 4);
				PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
				TogglePlayerControllable(i, true);
			}
		}
		return true;
	}
	++contagem;
	
	new str[20];
	format(str, sizeof(str), "~y~%d", contagem);
	
	foreach(new i: Player){
		if(Race[i][Participando] == true){
			GameTextForPlayer(i, str, 1000, 4);
			PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
		}
	}

	SetTimerEx("ContagemCorrida", 1000, false, "d", contagem);
	return true;
}

flags:terminarrace(ADMINISTRADOR);
CMD:terminarrace(playerid)
{
	if(Participantes != 0)
	{
		Participantes=0;
		_posicao=0;
		new r[e_RACE_INFO];
		foreach(new i: Player)
		{
			if(Race[i][Participando] == true)
			{
				DisablePlayerRaceCheckpoint(i);
				DisableRemoteVehicleCollisions(i, 0);
				SetPlayerPos(i, -1317.1350, -96.6939, 1053.7690);
				DestroyVehicle(Race[i][Vehicleid]);
				Race[i] = r;
				GivePlayerMoney(i, VALOR_INSCRICAO);
			}
		}
		SendClientMessageToAll(COR_VERDE, "» O(A) %s %s terminou o evento de corrida que estava acontecendo.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
		return true;
	}
	return true;
}

flags:comecarrace(ADMINISTRADOR);
CMD:comecarrace(playerid)
{
	new index;

	foreach(new i: Player)
	{
		if(Race[i][Participando] == true)
		{
			new vehicleid = Race[i][Vehicleid] = CreateVehicle(494, Vehicles[index][0], Vehicles[index][1], Vehicles[index][2], Vehicles[index][3], random(200), random(200), -1);
			SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(i));
			LinkVehicleToInterior(vehicleid, GetPlayerInterior(i));

			PutPlayerInVehicle(i, vehicleid, 0);
			DisableRemoteVehicleCollisions(i, 1);
			Race[i][cpID] = 1;
			Race[i][Voltas] = 0;
			TogglePlayerControllable(i, false);
			SetVehicleParams(vehicleid, VEHICLE_TYPE_ENGINE, VEHICLE_PARAMS_ON);
			SetPlayerRaceCheckpoint(i, 0, CheckPoints[0][0], CheckPoints[0][1], CheckPoints[0][2], CheckPoints[1][0], CheckPoints[1][1], CheckPoints[1][2], 5.0);
			index++;
		}
	}
	SetTimerEx("ContagemCorrida", 1000, false, "d", 0);
	return true;
}

/*hook OnVehicleHealthChange(vehicleid, Float:newhealth, Float:oldhealth)
{
	if ( newhealth < 300 )
	{
		foreach(new i: Player)
		{
			if ( Race[i][Participando] )
			{
				if ( Race[i][Vehicleid] == vehicleid)
				{
					new r[e_RACE_INFO];
					if(Race[i][Participando] == true)
					{
						DisablePlayerRaceCheckpoint(i);
						DisableRemoteVehicleCollisions(i, 0);
						SetPlayerPos(i, -1317.1350, -96.6939, 1053.7690);
						DestroyVehicle(Race[i][Vehicleid]);
						Race[i] = r;
						--Participantes;
						if( Participantes <= 0)
						{
							SendClientMessageToAll(COR_SISTEMA, "CORRIDA: {"COR_BRANCO_INC"}A Corrida terminou.");
							Participantes=0;
							_posicao=0;
						}
					}
				}
			}
			
		}
	}
	return true;
}*/

CMD:inscreverse(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 1.1, -1317.1350, -96.6939, 1053.7690))
	{
		if( Participantes >= sizeof(Vehicles) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Todas as vagas já foram preenchidas.");

		if( Race[playerid][Participando] )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está participando, espere a corrida começar.");

		if ( GetPlayerMoney(playerid) < VALOR_INSCRICAO )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente para se inscrever na corrida.");

		Valor_Arrecadado += ( VALOR_INSCRICAO + 200 );

		++Participantes;
		Race[playerid][Participando] = true;
		GivePlayerMoney(playerid, -VALOR_INSCRICAO);
		SendClientMessage(playerid, COR_SISTEMA, "CORRIDA: {"COR_BRANCO_INC"}Você está participando da corrida, aguarde o evento começar.");
		return true;
	}
	return true;
}