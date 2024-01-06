// PROFISSÃO DE SEDEX


#define COLETA 1
#define ESTADUAL 2
#define INTERESTADUAL 3

#define BUSCANDO_1 1
#define BUSCANDO_2 2
#define BUSCANDO_3 3
#define TRANSPORTANDO 4

new GATE_SEDEX;
new bool:IsGateOpening;

enum ProfissaoSEDEX
{
	LevelProf,
	bool:SetAlready,
	Parte,
	Rand1,
	Rand2,
	Rand3,
	Rand4,
	Rand5,
	bool:AbleToRemove,
	bool:HoldingCrate
	//bool:AbleToPut
}
new pInfoSEDEX[MAX_PLAYERS][ProfissaoSEDEX];

enum VeiculoSEDEX
{
	Caixas
}
new VehicleSEDEX[MAX_VEHICLES][VeiculoSEDEX];

static Float:placesSpawn[4][5] = {
	{1783.3351,-1920.4504,13.5645,269.6474},
	{1783.1864,-1912.3917,13.5651,269.6104},
	{1783.3192,-1903.1941,13.5654,270.2614},
	{1783.6808,-1894.8472,13.5655,270.5495}
};

/*forward ConvertText(id, Float:Posicao0, Float:Posicao1, Float:Posicao2, Float:Posicao3, id1, id2, i3, id4, id5, id6);
public ConvertText(id, Float:Posicao0, Float:Posicao1, Float:Posicao2, Float:Posicao3, id1, id2, i3, id4, id5, id6)
{
	printf("{%f,%f,%f},", Posicao0, Posicao1, Posicao2);
	return 1;
}

forward Convert();
public Convert()
{
	ConvertText(154,2472.9797,-1238.6160,32.5695,359.8234,0,0,0,0,0,0); // casa1
	ConvertText(154,2492.2434,-1239.0109,37.9054,13.1992,0,0,0,0,0,0); // casa2
	ConvertText(154,2536.8113,-1235.1847,43.6563,88.7345,0,0,0,0,0,0); // casa3
	ConvertText(154,2550.7903,-1234.5283,49.0014,351.1747,0,0,0,0,0,0); // casa4
	ConvertText(154,2468.7600,-1277.9855,30.3664,203.6960,0,0,0,0,0,0); // casa5
	ConvertText(154,2434.0876,-1275.1442,24.7567,84.5831,0,0,0,0,0,0); // casa6
	ConvertText(154,2435.3276,-1289.2683,25.3479,274.3935,0,0,0,0,0,0); // casa7
	ConvertText(154,2434.6179,-1303.2102,24.9157,5.4404,0,0,0,0,0,0); // casa8
	ConvertText(154,2434.0508,-1320.7662,24.9824,84.8414,0,0,0,0,0,0); // casa9
	ConvertText(154,2439.8674,-1338.6547,24.1089,88.7711,0,0,0,0,0,0); // casa10
	ConvertText(154,2440.0427,-1356.9377,24.1000,105.0387,0,0,0,0,0,0); // casa11
	ConvertText(154,2000.3763,-1114.2072,27.1250,358.4849,0,0,0,0,0,0); // casa12
	ConvertText(154,2022.8429,-1120.4249,26.4210,358.1481,0,0,0,0,0,0); // casa13
	ConvertText(154,2045.1931,-1116.5488,26.3617,109.7750,0,0,0,0,0,0); // casa14
	ConvertText(154,1955.2761,-1115.3696,27.8305,25.3791,0,0,0,0,0,0); // casa15
	ConvertText(154,1939.0778,-1114.7220,27.4523,18.7005,0,0,0,0,0,0); // casa16
	ConvertText(154,1921.3611,-1115.1880,27.0883,25.1577,0,0,0,0,0,0); // casa17
	ConvertText(154,1905.9888,-1112.9441,26.6641,5.8044,0,0,0,0,0,0); // casa18
	ConvertText(154,2852.0549,-1366.0420,14.1708,93.5533,0,0,0,0,0,0); // casa19
	ConvertText(154,2841.9946,-1334.9148,14.7421,91.9389,0,0,0,0,0,0); // casa20
	ConvertText(154,2808.0334,-1190.2004,25.3442,117.9984,0,0,0,0,0,0); // casa21
	ConvertText(154,2326.8127,-1717.0574,13.9074,171.1391,0,0,0,0,0,0); // casa22
	ConvertText(154,2308.9912,-1714.5468,14.6496,359.6812,0,0,0,0,0,0); // casa23
	ConvertText(154,2327.2944,-1681.7899,14.9297,96.5489,0,0,0,0,0,0); // casa24
	ConvertText(154,2368.3682,-1674.7894,14.1682,213.1346,0,0,0,0,0,0); // casa25
	ConvertText(154,2408.8875,-1674.5913,14.2508,178.0813,0,0,0,0,0,0); // casa26
	ConvertText(154,2486.5032,-1645.4365,14.0772,356.9329,0,0,0,0,0,0); // casa27
	ConvertText(154,2513.2576,-1650.7103,14.3557,312.1935,0,0,0,0,0,0); // casa28
	ConvertText(154,1761.0935,-2125.1938,14.0566,190.5440,0,0,0,0,0,0); // casa29
	ConvertText(154,1734.1555,-2098.7183,14.0366,31.8713,0,0,0,0,0,0); // casa30
	ConvertText(154,1674.1532,-2122.1006,14.1460,125.7318,0,0,0,0,0,0); // casa31
	ConvertText(154,2486.3398,-2021.4045,13.9988,186.8542,0,0,0,0,0,0); // casa32
	ConvertText(154,2508.0938,-1998.6483,13.9025,336.4177,0,0,0,0,0,0); // casa33
	ConvertText(154,2465.0420,-1996.2872,13.6889,345.4210,0,0,0,0,0,0); // casa34
}*/

new Float:placesCasas[70][5] = {
	{762.1741,-1564.3114,13.5469},
	{771.7000,-1511.3607,13.5469},
	{783.6038,-1464.4218,13.5469},
	{900.2029,-1471.4486,14.3431},
	{739.1859,-1418.4817,13.5234},
	{883.4903,-1799.1555,13.7806},
	{992.9171,-1817.0284,13.9540},
	{824.5013,-1423.3293,14.4933},
	{1103.3499,-1091.2196,28.4688},
	{1068.7360,-1081.5164,27.4419},
	{1118.2266,-1022.3157,34.9922},
	{1127.7208,-1023.4709,34.9922},
	{1182.3550,-1077.3245,31.6719},
	{1182.9260,-1097.0819,28.2578},
	{1284.6776,-1089.2679,28.2578},
	{1298.763427,-798.541381,84.140602},
	{1331.739868,-631.825195,109.134902},
	{1112.177978,-741.716125,100.132896},
	{1094.050537,-806.976989,107.418502},
	{980.070190,-676.929626,121.976303},
	{945.750976,-709.980529,122.619903},
	{898.066894,-677.624877,116.890403},
	{867.919372,-716.978393,105.679702},
	{891.084228,-782.405090,101.306900},
	{836.054077,-894.606872,68.768898},
	{827.913085,-857.958679,70.330802},
	{724.758972,-998.617675,52.734401},
	{700.008117,-1060.163696,49.421699},
	{1326.722290,-1068.841308,31.554700},
	{1326.431762,-1088.824951,27.983600},
	{1421.665283,-885.422729,50.656600},
	{1467.838378,-904.984375,54.835899},
	{1540.114746,-851.151672,64.336097},
	{1534.176879,-800.312683,72.849502},
	{1527.203979,-773.080200,80.578102},
	{1496.839599,-687.899780,95.563301},
	{2472.979736,-1238.615966,32.569499},
	{2492.243408,-1239.010864,37.905399},
	{2536.811279,-1235.184692,43.656299},
	{2550.790283,-1234.528320,49.001399},
	{2468.760009,-1277.985473,30.366399},
	{2434.087646,-1275.144165,24.756700},
	{2435.327636,-1289.268310,25.347900},
	{2434.617919,-1303.210205,24.915700},
	{2434.050781,-1320.766235,24.982400},
	{2439.867431,-1338.654663,24.108900},
	{2440.042724,-1356.937744,24.100000},
	{2000.376342,-1114.207153,27.125000},
	{2022.842895,-1120.424926,26.420999},
	{2045.193115,-1116.548828,26.361700},
	{1955.276123,-1115.369628,27.830499},
	{1939.077758,-1114.722045,27.452299},
	{1921.361083,-1115.187988,27.088300},
	{1905.988769,-1112.944091,26.664100},
	{2852.054931,-1366.041992,14.170800},
	{2841.994628,-1334.914794,14.742099},
	{2808.033447,-1190.200439,25.344200},
	{2326.812744,-1717.057373,13.907400},
	{2308.991210,-1714.546752,14.649600},
	{2327.294433,-1681.789916,14.929699},
	{2368.368164,-1674.789428,14.168199},
	{2408.887451,-1674.591308,14.250800},
	{2486.503173,-1645.436523,14.077199},
	{2513.257568,-1650.710327,14.355699},
	{1761.093505,-2125.193847,14.056599},
	{1734.155517,-2098.718261,14.036600},
	{1674.153198,-2122.100585,14.145999},
	{2486.339843,-2021.404541,13.998800},
	{2508.093750,-1998.648315,13.902500},
	{2465.041992,-1996.287231,13.688899}
};


#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	new ActorSEDEX;
	ActorSEDEX = CreateDynamicActor(8,1805.7096,-1895.0659,13.4047,92.0760);
	ApplyDynamicActorAnimation(ActorSEDEX, "PED","IDLE_CHAT", 4.1,1,1,1,1,1);

	CreateDynamicPickup(1239, 1, 1804.6782,-1895.1226,13.4047); // Locar Veículo
	CreateDynamic3DTextLabel("SEDEX\nAperte '{ffff00}Y{ffffff}' para locar seu veículo", -1, 1804.6782,-1895.1226,13.4047, 10.0); // Label

	CreateDynamicPickup(1575, 1, 1775.9697,-1892.1173,13.3864); // Entregar Caixas
	CreateDynamic3DTextLabel("SEDEX\nAperte '{ffff00}Y{ffffff}' para descarregar caixas", -1, 1775.9697,-1892.1173,13.3864, 10.0); // Label Caixas

	CreateDynamicPickup(1575, 1, 1775.6233,-1899.4628,13.3861); // Pegar Caixas
	CreateDynamic3DTextLabel("SEDEX\nAperte '{ffff00}Y{ffffff}' para pegar caixas para seu veículo", -1, 1775.6233,-1899.4628,13.3861, 10.0); // Label Caixas
	
	GATE_SEDEX = CreateDynamicObject(971, 1811.74524, -1890.14917, 11.66197,   0.00000, 0.00000, -89.78000);

	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	DisablePlayerRaceCheckpoint(playerid);
	
	pInfoSEDEX[playerid][LevelProf] = 0;
	pInfoSEDEX[playerid][SetAlready] = false;
	pInfoSEDEX[playerid][Parte] = 0;
	pInfoSEDEX[playerid][Rand1] = -1;
	pInfoSEDEX[playerid][Rand2] = -1;
	pInfoSEDEX[playerid][Rand3] = -1;
	pInfoSEDEX[playerid][Rand4] = -1;
	pInfoSEDEX[playerid][Rand5] = -1;
	pInfoSEDEX[playerid][AbleToRemove] = false;
	pInfoSEDEX[playerid][HoldingCrate] = false;

	CancelarServicos(playerid);
	return 1;
}

/*hook OnPlayerDeath(playerid, killerid, reason)
{
	if(pInfoSEDEX[playerid][LevelProf] != 0)
	{
		SendClientMessage(playerid, COR_ERRO, "| SERVIÇOS | Seus serviços foram cancelados por você se ferir durante o trabalho.");
		CancelarServicos(playerid);
	}
	return 1;
}*/

/*hook OnVehicleSpawn(vehicleid)
{
	foreach(new i: Player)
	{
		if(vehicleid == Jogador[i][VeiculoLocado])
		{
			SendClientMessage(i, COR_ERRO, "| SERVIÇOS | Seus serviços foram cancelados pelo seu veículo explodir / respawnar.");
			CancelarServicos(i);
		}
	}
	return 1;	
}*/

forward BackGate(playerid);
public BackGate(playerid)
{
	IsGateOpening = false;
	MoveDynamicObject(GATE_SEDEX, 1811.74524, -1890.14917, 11.66197, 5.0);
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == KEY_CROUCH)
	{	
		if(IsPlayerInRangeOfPoint(playerid, 5.0, 1815.4678,-1890.1704,13.4141) || IsPlayerInRangeOfPoint(playerid, 5.0, 1807.2469,-1890.0985,13.4093))
		{
			if(Jogador[playerid][Profissao] != SEDEX)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");

			IsGateOpening = true;

			MoveDynamicObject(GATE_SEDEX, 1812.1155, -1899.6062, 11.6620, 5.0);
			SetTimer("BackGate", 10000, 0);

			//SendClientMessage(playerid, COR_AMARELO, "| PORTÃO | O portão está abrindo e fechará em 10 segundos.");
		}
	}

	if(newkeys == KEY_YES)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 1775.6233,-1899.4628,13.3861))
		{
			if(Jogador[playerid][Profissao] != SEDEX)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
			
			if(pInfoSEDEX[playerid][HoldingCrate] == true)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está segurando nenhuma caixa.");
			
			if(Jogador[playerid][VeiculoLocado] == INVALID_VEHICLE_ID)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa locar um veículo primeiro.");
			
			if(pInfoSEDEX[playerid][LevelProf] != ESTADUAL)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está com o veículo correto locado.");
			
			if(VehicleSEDEX[ Jogador[playerid][VeiculoLocado] ][Caixas] == 15)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Seu veículo já está com a quantidade máxima de caixas.");
			
			new Float:Posicao[4];
			GetVehiclePos(Jogador[playerid][VeiculoLocado], Posicao[0], Posicao[1], Posicao[2]);
			if(!IsPlayerInRangeOfPoint(playerid, 30.0, Posicao[0], Posicao[1], Posicao[2]))
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar mais próximo de seu veículo.");
			
			SetPlayerSpecialAction(playerid, 25);
			SetPlayerAttachedObject(playerid, 1, 2912, 1, 0.2509, 0.2330, -0.0069, -97.1999, -8.2999, -83.7000, 0.6480, 0.5520, 0.6630, 0xFFFFFFFF, 0xFFFFFFFF);
			pInfoSEDEX[playerid][HoldingCrate] = true;

			SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Você pegou uma caixa do depósito. Digite {ffffff}/Caixa Colocar {ffff00}perto de seu veículo para colocá-la!");

		}

		if(IsPlayerInRangeOfPoint(playerid, 3.0, 1775.9697,-1892.1173,13.3864))
		{
			if(Jogador[playerid][Profissao] != SEDEX)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
			
			if(pInfoSEDEX[playerid][HoldingCrate] == false)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está segurando nenhuma caixa.");
			
			if(pInfoSEDEX[playerid][LevelProf] == ESTADUAL || pInfoSEDEX[playerid][LevelProf] == INTERESTADUAL)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode entregar suas caixas aqui.");
			
			new Float:Posicao[4];
			GetVehiclePos(Jogador[playerid][VeiculoLocado], Posicao[0], Posicao[1], Posicao[2]);
			if(!IsPlayerInRangeOfPoint(playerid, 30.0, Posicao[0], Posicao[1], Posicao[2]))
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar mais próximo de seu veículo.");
			
			new value = 300 + random(100);

			SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Você descarregou {ffffff}1 {ffff00}caixa e recebeu R$%d", value);
			
			pInfoSEDEX[playerid][HoldingCrate] = false;

			pInfoSEDEX[playerid][SetAlready] = false;

			pInfoSEDEX[playerid][Rand1] = -1;

			DisablePlayerRaceCheckpoint(playerid);
			RemovePlayerMapIcon(playerid, 50);

			RemovePlayerAttachedObject(playerid, 1);
			SetPlayerSpecialAction(playerid, 0);

			GivePlayerMoney(playerid, value);

		}

		if(IsPlayerInRangeOfPoint(playerid, 3.0, 1804.6782,-1895.1226,13.4047))
		{
			if(Jogador[playerid][Profissao] != SEDEX)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");

			if(Jogador[playerid][VeiculoLocado] == INVALID_VEHICLE_ID) // Se não tem veículo locado
			{
				new string[700];
				strcat(string, "{ffffff}Veículo\t{ff8000}Level Necessário\t\t{ffff00}Função\t{"COR_VERDE_INC"}Valor\n");
				strcat(string, "{ffffff}Burrito\t{ff8000}Level 10\t\t{ffff00}Coleta de Mercadorias\t{"COR_VERDE_INC"}R$350\n");
				strcat(string, "{ffffff}Yankee\t{ff8000}Level 15\t\t{ffff00}Frete Estadual\t{"COR_VERDE_INC"}R$600\n");
				//strcat(string, "{ffffff}Linerunner\t{ff8000}Level 9\t{ffff00}Frete Interestadual\t{"COR_VERDE_INC"}R$1.000\n");
				ShowPlayerDialog(playerid, DIALOG_LOCAR_SEDEX, DIALOG_STYLE_TABLIST_HEADERS, "Escolha seu veículo para locar", string, "Locar", "Cancelar");
			}
			else 
			{
				if(GetPlayerVehicleID(playerid) != Jogador[playerid][VeiculoLocado])
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar em seu veículo locado.");

				ShowPlayerDialog(playerid, DIALOG_DESLOCAR_SEDEX, DIALOG_STYLE_MSGBOX, "Locar Veículo", "{ffffff}Você deseja devolver seu veículo locado?", "Sim", "Não");
			}
		}

		if(IsPlayerInRangeOfPoint(playerid, 3.0, 1741.7241,-1863.6991,13.5748))
		{
			if(Jogador[playerid][Profissao] != SEDEX)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
			
			//SendClientMessage(playerid, -1, "| CAIXA | Você pegou uma caixa.")
		}
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(Jogador[playerid][Profissao] == SEDEX)
	{
		if(newstate == PLAYER_STATE_DRIVER)
		{
			if(GetPlayerVehicleID(playerid) == Jogador[playerid][VeiculoLocado])
			{
				if(pInfoSEDEX[playerid][LevelProf] == COLETA)
				{
					if(pInfoSEDEX[playerid][SetAlready] == false)
					{
						SetTimerEx("SendMessage", 300, 0, "i", playerid);
					}
				}

				if(pInfoSEDEX[playerid][LevelProf] == ESTADUAL)
				{
					if(pInfoSEDEX[playerid][SetAlready] == false)
					{
						SetTimerEx("SendMessage", 300, 0, "i", playerid);
					}
				}

				if(pInfoSEDEX[playerid][LevelProf] == INTERESTADUAL)
				{
					if(pInfoSEDEX[playerid][SetAlready] == false)
					{
						SetTimerEx("SendMessage", 300, 0, "i", playerid);
					}
				}

			}
		}
	}
	return 1;
}

forward SendMessage(playerid);
public SendMessage(playerid)
{
	if(pInfoSEDEX[playerid][LevelProf] == COLETA)
	{
		if(pInfoSEDEX[playerid][SetAlready] == false)
		{
			SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Sua função será coletar mercadorias nas casas dos jogadores e entregá-las no depósito.");
			SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Inicie seus serviços utilizando o comando /Iniciar.");
		}
	}

	if(pInfoSEDEX[playerid][LevelProf] == ESTADUAL)
	{
		if(pInfoSEDEX[playerid][SetAlready] == false)
		{
			SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Sua função será pegar mercadorias no depósito e as entregar nas casas dos jogadores em Los Santos.");
			SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Inicie seus serviços utilizando o comando /Iniciar.");
		}
	}

	if(pInfoSEDEX[playerid][LevelProf] == INTERESTADUAL)
	{
		if(pInfoSEDEX[playerid][SetAlready] == false)
		{
			SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Sua função será pegar mercadorias no depósito e as entregar nas casas dos jogadores em outras cidades.");
			SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Inicie seus serviços utilizando o comando /Iniciar.");
		}
	}

	return 1;
}

forward GenerateHouses(playerid);
public GenerateHouses(playerid)
{
	new Rand = random(sizeof(placesCasas));
	if(Rand == pInfoSEDEX[playerid][Rand1] || Rand == pInfoSEDEX[playerid][Rand2] || Rand == pInfoSEDEX[playerid][Rand3] || Rand == pInfoSEDEX[playerid][Rand4] || Rand == pInfoSEDEX[playerid][Rand5]) 
		return GenerateHouses(playerid);
	
	pInfoSEDEX[playerid][Rand1] = Rand;

	SetPlayerRaceCheckpoint(playerid, 1, placesCasas[Rand][0], placesCasas[Rand][1], placesCasas[Rand][2], 0.0, 0.0, 0.0, 1.0);
	//SetPlayerMapIcon(playerid, 50, placesCasas[Rand][0], placesCasas[Rand][1], placesCasas[Rand][2], 51, -1);

	return 1;
}

forward NextLevel(playerid);
public NextLevel(playerid)
{
	TogglePlayerControllable(playerid, true);

	if(pInfoSEDEX[playerid][LevelProf] == COLETA)
	{
		pInfoSEDEX[playerid][HoldingCrate] = true;

		SetPlayerSpecialAction(playerid, 25);
		SetPlayerAttachedObject(playerid, 1, 2912, 1, 0.2509, 0.2330, -0.0069, -97.1999, -8.2999, -83.7000, 0.6480, 0.5520, 0.6630, 0xFFFFFFFF, 0xFFFFFFFF);
		
		SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Você coletou {ffffff}1 {ffff00}caixa da casa. Digite {ffffff}/Caixa Colocar {ffff00}perto do seu veículo para colocá-la!");
		SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Você pode ir ao depósito (caminhão no mapa) entregar as caixas ou continuar retirando caixas.");

		SetPlayerMapIcon(playerid, 50, 1775.9697,-1892.1173,13.3864, 51, -1, MAPICON_GLOBAL);

		GenerateHouses(playerid);
	}

	if(pInfoSEDEX[playerid][LevelProf] == ESTADUAL)
	{

		new value;
		value = 400 + random(100);

		RemovePlayerAttachedObject(playerid, 1);
		SetPlayerSpecialAction(playerid, 0);

		if(VehicleSEDEX[ Jogador[playerid][VeiculoLocado] ][Caixas] > 0)
		{
			SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Você realizou a entrega com sucesso. Você recebeu R$%s pelo seu trabalho!", RealStr(value));
			SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Seu veículo possui {ffffff}%d {ffff00}caixas.", VehicleSEDEX[ Jogador[playerid][VeiculoLocado] ][Caixas]);
			GivePlayerMoney(playerid, value);

			GenerateHouses(playerid);
			//return 1;
		}

		else if(VehicleSEDEX[ Jogador[playerid][VeiculoLocado] ][Caixas] == 0)
		{
			SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Você realizou a entrega com sucesso. Você recebeu R$%s pelo seu trabalho!", RealStr(value));
			SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Você entregou todas as mercadorias com sucesso. Volte ao depósito para pegar mais!");

			GivePlayerMoney(playerid, value);
			
			pInfoSEDEX[playerid][Rand1] = -1;
			pInfoSEDEX[playerid][Rand2] = -1;
			pInfoSEDEX[playerid][Rand3] = -1;
			pInfoSEDEX[playerid][Rand4] = -1;
			pInfoSEDEX[playerid][Rand5] = -1;

			pInfoSEDEX[playerid][LevelProf] = ESTADUAL;
			pInfoSEDEX[playerid][SetAlready] = false;

			DisablePlayerRaceCheckpoint(playerid);
		}

	}
	return 1;
}

hook OnVehicleSpawn(vehicleid)
{
	VehicleSEDEX[vehicleid][Caixas] = 0;
	return 1;
}

hook OnPlayerEnterRaceCP(playerid)
{
	/*if(pInfoSEDEX[playerid][Parte] == BUSCANDO_1 || pInfoSEDEX[playerid][Parte] == BUSCANDO_2 || pInfoSEDEX[playerid][Parte] == BUSCANDO_3)
	{
		new Float:Posicao[4];
		GetVehiclePos(Jogador[playerid][VeiculoLocado], Posicao[0], Posicao[1], Posicao[2]);
		if(!IsPlayerInRangeOfPoint(playerid, 30.0, Posicao[0], Posicao[1], Posicao[2]))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar mais perto de seu veículo.");

		GameTextForPlayer(playerid, "~r~retirando ~w~produto", 5000, 3);
		TogglePlayerControllable(playerid, false);

		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
		SetTimerEx("NextLevel", 5000, 0, "i", playerid);
		return 1;
	}*/

	/*if(pInfoSEDEX[playerid][LevelProf] == TRANSPORTANDO)
	{
		SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Desça do veículo e aperte '{ffffff}N{ffff00}' na lateral do veículo para pegar as caixas.");
		pInfoSEDEX[playerid][LevelProf] = COLETA;
		pInfoSEDEX[playerid][SetAlready] = false;
		DisablePlayerRaceCheckpoint(playerid);
	}*/

	if(pInfoSEDEX[playerid][LevelProf] == ESTADUAL)
	{
		/*
		new Float:Posicao[4];
		GetVehiclePos(Jogador[playerid][VeiculoLocado], Posicao[0], Posicao[1], Posicao[2]);
		if(!IsPlayerInRangeOfPoint(playerid, 30.0, Posicao[0], Posicao[1], Posicao[2]))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar mais perto de seu veículo.");
		
		GameTextForPlayer(playerid, "~r~entregando ~w~produto", 5000, 3);
		TogglePlayerControllable(playerid, false);

		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
		SetTimerEx("NextLevel", 5000, 0, "i", playerid);
		*/
		//DisablePlayerRaceCheckpoint(playerid);
	}
	return 1;
}

CMD:iniciar(playerid, params[])
{
	if(Jogador[playerid][Profissao] != SEDEX)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
	
	if(pInfoSEDEX[playerid][SetAlready] == true)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já iniciou seus serviços.");

	if(pInfoSEDEX[playerid][LevelProf] == TRANSPORTANDO)
	{
		if(VehicleSEDEX[ Jogador[playerid][VeiculoLocado] ][Caixas] > 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você ainda tem caixas no seu veículo. Retire-as primeiro.");
	}

	if(pInfoSEDEX[playerid][LevelProf] == COLETA)
	{
		SendClientMessage(playerid, COR_LARANJA, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Siga para o caminhão marcado em seu mapa para fazer a coleta da mercadoria.");
		SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Use: {ffffff}/Caixa Coletar {ffff00}para coletar a caixa na casa.");
		SendClientMessage(playerid, COR_LARANJA, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

		new Rand = random(sizeof(placesCasas));

		pInfoSEDEX[playerid][Rand1] = Rand;

		SetPlayerRaceCheckpoint(playerid, 1, placesCasas[Rand][0], placesCasas[Rand][1], placesCasas[Rand][2], 0.0, 0.0, 0.0, 1.0);

	}

	if(pInfoSEDEX[playerid][LevelProf] == ESTADUAL)
	{
		new caixas;
		caixas = VehicleSEDEX[ Jogador[playerid][VeiculoLocado] ][Caixas];

		if(caixas == 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui caixas no seu caminhão.");

		SendClientMessage(playerid, COR_LARANJA, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Seu caminhão está carregado com {ffffff}%d {ffff00}caixas.", caixas);
		SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Siga para o caminhão marcado em seu mapa para fazer a entrega das mercadorias.");
		SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Remova a caixa do seu veículo usando {ffffff}/Caixa Pegar {ffff00}e use {ffffff}/Caixa Entregar {ffff00}para entregá-la na casa.");
		SendClientMessage(playerid, COR_LARANJA, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

		new Rand = random(sizeof(placesCasas));

		pInfoSEDEX[playerid][Rand1] = Rand;

		SetPlayerRaceCheckpoint(playerid, 1, placesCasas[Rand][0], placesCasas[Rand][1], placesCasas[Rand][2], 0.0, 0.0, 0.0, 1.0);

	}

	pInfoSEDEX[playerid][SetAlready] = true;
	pInfoSEDEX[playerid][AbleToRemove] = false;
	return 1;
}

CMD:caixa(playerid, params[])
{
	new digitado[50];
	if(sscanf(params, "s[50]", digitado))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /Caixa [colocar/pegar/entregar/coletar]");
	
	if(!strcmp(digitado, "colocar", true))
	{
		if(pInfoSEDEX[playerid][HoldingCrate] == false)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está segurando nenhuma caixa.");
		
		new Float:Posicao[4];
		GetVehiclePos(Jogador[playerid][VeiculoLocado], Posicao[0], Posicao[1], Posicao[2]);
		if(!IsPlayerInRangeOfPoint(playerid, 5.0, Posicao[0], Posicao[1], Posicao[2]))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar mais próximo de seu veículo.");
		
		if(IsPlayerInAnyVehicle(playerid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode colocar uma caixa de dentro de um veículo.");

		VehicleSEDEX[ Jogador[playerid][VeiculoLocado] ][Caixas]++;

		SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Você colocou {ffffff}1 {ffff00}caixa no seu veículo. Seu veículo atualmente possui {ffffff}%d {ffff00}caixas.", VehicleSEDEX[ Jogador[playerid][VeiculoLocado] ][Caixas]);

		if(pInfoSEDEX[playerid][LevelProf] == COLETA)
		{
			if(VehicleSEDEX[ Jogador[playerid][VeiculoLocado] ][Caixas] == 10)
			{
				SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Seu veículo atingiu o limite máximo de caixas. Vá ao depósito descarregá-las!");
				DisablePlayerRaceCheckpoint(playerid);
				//RemovePlayerMapIcon(playerid, 50);
			}
		}

		pInfoSEDEX[playerid][HoldingCrate] = false;

		RemovePlayerAttachedObject(playerid, 1);
		SetPlayerSpecialAction(playerid, 0);

	}

	if(!strcmp(digitado, "pegar", true))
	{
		new Float:Posicao[4];
		GetVehiclePos(Jogador[playerid][VeiculoLocado], Posicao[0], Posicao[1], Posicao[2]);
		if(!IsPlayerInRangeOfPoint(playerid, 5.0, Posicao[0], Posicao[1], Posicao[2]))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar mais próximo de seu veículo.");

		if(pInfoSEDEX[playerid][HoldingCrate] == true)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está segurando uma caixa.");
		
		if(VehicleSEDEX[ Jogador[playerid][VeiculoLocado] ][Caixas] == 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Este veículo não possui caixas.");
		
		if(IsPlayerInAnyVehicle(playerid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode pegar uma caixa de dentro de um veículo.");


		VehicleSEDEX[ Jogador[playerid][VeiculoLocado] ][Caixas]--;

		SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Você pegou {ffffff}1 {ffff00}caixa do seu veículo. Seu veículo atualmente possui {ffffff}%d {ffff00}caixas.", VehicleSEDEX[ Jogador[playerid][VeiculoLocado] ][Caixas]);
		
		if(pInfoSEDEX[playerid][LevelProf] == ESTADUAL)
		{
			SendClientMessage(playerid, 0xFFFF00AA, "| SEDEX | Use {ffffff}/Caixa Entregar {ffff00}para entregar a caixa na casa.");
		}

		pInfoSEDEX[playerid][HoldingCrate] = true;

		SetPlayerSpecialAction(playerid, 25);
		SetPlayerAttachedObject(playerid, 1, 2912, 1, 0.2509, 0.2330, -0.0069, -97.1999, -8.2999, -83.7000, 0.6480, 0.5520, 0.6630, 0xFFFFFFFF, 0xFFFFFFFF);
	}

	if(!strcmp(digitado, "coletar", true))
	{
		new Float:Posicao[4];

		if(pInfoSEDEX[playerid][LevelProf] == ESTADUAL)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode coletar caixas estando fazendo entregas estaduais.");
		

		GetVehiclePos(Jogador[playerid][VeiculoLocado], Posicao[0], Posicao[1], Posicao[2]);
		if(!IsPlayerInRangeOfPoint(playerid, 30.0, Posicao[0], Posicao[1], Posicao[2]))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar mais próximo de seu veículo.");

		if(pInfoSEDEX[playerid][HoldingCrate] == true)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está segurando uma caixa.");
		
		if(IsPlayerInAnyVehicle(playerid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode coletar uma caixa de dentro de um veículo.");
		
		if(!IsPlayerInRangeOfPoint(playerid, 5.0, placesCasas[pInfoSEDEX[playerid][Rand1]][0], placesCasas[pInfoSEDEX[playerid][Rand1]][1], placesCasas[pInfoSEDEX[playerid][Rand1]][2]))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar próximo da casa para fazer a entrega.");

		GameTextForPlayer(playerid, "~r~retirando ~w~produto", 5000, 3);
		TogglePlayerControllable(playerid, false);

		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
		SetTimerEx("NextLevel", 5000, 0, "i", playerid);
		

	}

	if(!strcmp(digitado, "entregar", true))
	{
		new Float:Posicao[4];
		GetVehiclePos(Jogador[playerid][VeiculoLocado], Posicao[0], Posicao[1], Posicao[2]);

		if(pInfoSEDEX[playerid][HoldingCrate] == false)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar segurando uma caixa.");
		
		if(pInfoSEDEX[playerid][LevelProf] != ESTADUAL)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode entregar caixas estando em trabalho de coleta.");

		if(!IsPlayerInRangeOfPoint(playerid, 30.0, Posicao[0], Posicao[1], Posicao[2]))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar mais perto de seu veículo.");
		
		if(IsPlayerInAnyVehicle(playerid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode entregar uma caixa de dentro de um veículo.");
		

		if(!IsPlayerInRangeOfPoint(playerid, 3.0, placesCasas[pInfoSEDEX[playerid][Rand1]][0], placesCasas[pInfoSEDEX[playerid][Rand1]][1], placesCasas[pInfoSEDEX[playerid][Rand1]][2]))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar próximo da casa para fazer a entrega.");
		
		GameTextForPlayer(playerid, "~r~entregando ~w~produto", 5000, 3);
		TogglePlayerControllable(playerid, false);

		pInfoSEDEX[playerid][HoldingCrate] = false;

		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
		SetTimerEx("NextLevel", 5000, 0, "i", playerid);
	}

	return 1;
}


Dialog:DIALOG_LOCAR_SEDEX(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: // Burrito
			{
				if(GetPlayerScore(playerid) < 10)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui Level suficiente para locar este veículo");

				if(GetPlayerMoney(playerid) < 350)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui dinheiro suficiente.");
				
				SendClientMessage(playerid, -1, "| VEÍCULO | Seu veículo foi locado com sucesso! Siga o ponto {ff0000}vermelho {ffffff}em seu mapa para pegá-lo!");
		
				new Rand = random(sizeof(placesSpawn));

				SetPlayerCheckpoint(playerid, placesSpawn[Rand][0], placesSpawn[Rand][1], placesSpawn[Rand][2], 1.0);
				Jogador[playerid][VeiculoLocado] = CreateVehicle(482, placesSpawn[Rand][0], placesSpawn[Rand][1], placesSpawn[Rand][2], placesSpawn[Rand][3], 6, 6, 300000);
				VehicleSEDEX[ Jogador[playerid][VeiculoLocado] ][Caixas] = 0;

				pInfoSEDEX[playerid][LevelProf] = COLETA;

				GivePlayerMoney(playerid, -350);
			}
			case 1: // Yankee
			{
				if(GetPlayerScore(playerid) < 15)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui Level suficiente para locar este veículo.");
				
				if(GetPlayerMoney(playerid) < 600)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui dinheiro suficiente.");
				
				SendClientMessage(playerid, -1, "| VEÍCULO | Seu veículo foi locado com sucesso! Siga o ponto {ff0000}vermelho {ffffff}em seu mapa para pegá-lo!");
		
				new Rand = random(sizeof(placesSpawn));

				SetPlayerCheckpoint(playerid, placesSpawn[Rand][0], placesSpawn[Rand][1], placesSpawn[Rand][2], 1.0);
				Jogador[playerid][VeiculoLocado] = CreateVehicle(456, placesSpawn[Rand][0], placesSpawn[Rand][1], placesSpawn[Rand][2], placesSpawn[Rand][3], 6, 6, 300000);
				VehicleSEDEX[ Jogador[playerid][VeiculoLocado] ][Caixas] = 0;

				pInfoSEDEX[playerid][LevelProf] = ESTADUAL;

				GivePlayerMoney(playerid, -600);
			}
			case 2: // Linerunner
			{
				/*SendClientMessage(playerid, -1, "| VEÍCULO | Seu veículo foi locado com sucesso! Siga o ponto {ff0000}vermelho {ffffff}em seu mapa para pegá-lo!");
		
				new Rand = random(sizeof(placesSpawn));

				SetPlayerCheckpoint(playerid, placesSpawn[Rand][0], placesSpawn[Rand][1], placesSpawn[Rand][2], 1.0);
				Jogador[playerid][VeiculoLocado] = CreateVehicle(403, placesSpawn[Rand][0], placesSpawn[Rand][1], placesSpawn[Rand][2], placesSpawn[Rand][3], 6, 6, 300000);

				pInfoSEDEX[playerid][LevelProf] = INTERESTADUAL;*/
				SendClientMessage(playerid, COR_ERRO, "| ERRO | Ainda não disponível.");
			}
		}

	}
	return 1;
}

Dialog:DIALOG_DESLOCAR_SEDEX(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		SendClientMessage(playerid, -1, "| VEÍCULO | Você devolveu seu veículo locado com sucesso.");
		DestroyVehicle(Jogador[playerid][VeiculoLocado]);
		Jogador[playerid][VeiculoLocado] = INVALID_VEHICLE_ID;

		pInfoSEDEX[playerid][LevelProf] = 0;

		CancelarServicos(playerid);
	}
	return 1;
}

/*public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ )
{
	if(response)
	{
		SendClientMessage(playerid, -1, "fOffsetX: %f, fOffsetY: %f, fOffsetZ: %f, fRotX: %f, fRotY: %f, fRotZ: %f", Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ);
	}
	return 1;
}*/