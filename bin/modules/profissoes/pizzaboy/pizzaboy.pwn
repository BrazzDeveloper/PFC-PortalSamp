// NOVA PROFISSÃO DE PIZZABOY


#include <YSI_Coding\y_hooks>

enum ProfissaoPizzaboy
{
	bool:SegurandoBAG,
	ObjetoBag,
	bool:TrabalhandoPB,
	RestauranteAceito,
	EntregaAceita,
	bool:EmEntrega,
	bool:EntregandoCasa,
	bool:TemDelivery

}
new pInfoPB[MAX_PLAYERS][ProfissaoPizzaboy];

new Float:LocaisEntrega[70][5] = {
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

new Float:Restaurantes[7][8] = {
	{1202.3765,-921.0022,43.0873}, // Burger Shot Temple
	{1041.5095,-1338.4175,13.7325}, // Jim's Sticky Ring
	{925.5313,-1355.7847,13.3788}, // Cluckin' Bell Market
	{811.8968,-1613.5516,13.5500}, // Burger Shot Marina
	{2103.7131,-1804.1583,13.5547}, // The Well Stacked Pizza Co.
	{2394.9631,-1897.4462,13.5469}, // Cluckin' Bell Willowfield
	{2421.3909,-1505.9675,23.9922} // Cluckin' Bell East LS
};

new TimerDelivery[MAX_PLAYERS];


/*hook OnPlayerDisconnect(playerid, reason)
{
	// ENTREGADOR IFOOD
	pInfoPB[playerid][SegurandoBAG] = false;
	pInfoPB[playerid][TrabalhandoPB] = false;
	pInfoPB[playerid][ObjetoBag] = INVALID_OBJECT_ID;
	pInfoPB[playerid][RestauranteAceito] = -1;
	pInfoPB[playerid][EntregaAceita] = -1;
	pInfoPB[playerid][EmEntrega] = false;
	pInfoPB[playerid][EntregandoCasa] = false;
	pInfoPB[playerid][TemDelivery] = false;
	CancelarServicos(playerid);
	return 1;
}*/

/*hook OnPlayerDeath(playerid, killerid, reason)
{
	if(pInfoPB[playerid][TrabalhandoPB] == true)
	{
		SendClientMessage(playerid, COR_ERRO, "| SERVIÇOS | Seus serviços foram cancelados por você se ferir durante o trabalho.");
		CancelarServicos(playerid);
	}
	return 1;
}*/


hook OnPlayerDisconnect(playerid, reason)
{
	KillTimer(TimerDelivery[playerid]);

	DisablePlayerRaceCheckpoint(playerid);
	RemovePlayerAttachedObject(playerid, 1);

	DestroyVehicle(Jogador[playerid][VeiculoLocado]);

	Jogador[playerid][VeiculoLocado] = INVALID_VEHICLE_ID;
	pInfoPB[playerid][SegurandoBAG] = false;
	pInfoPB[playerid][ObjetoBag] = INVALID_OBJECT_ID;
	pInfoPB[playerid][TrabalhandoPB] = false;
	pInfoPB[playerid][RestauranteAceito] = -1;
	pInfoPB[playerid][EntregaAceita] = -1;
	pInfoPB[playerid][EmEntrega] = false;
	pInfoPB[playerid][EntregandoCasa] = false;
	pInfoPB[playerid][TemDelivery] = false;
	return 1;	
}


hook OnPlayerConnect(playerid)
{
	Jogador[playerid][VeiculoLocado] = INVALID_VEHICLE_ID;
	return 1;
}

stock LoadActorPizza()
{
	// ACTOR
	new ActoriFood;
	ActoriFood = CreateDynamicActor(167, 1217.3403,-875.2196,42.9021,192.9342);
	ApplyDynamicActorAnimation(ActoriFood, "PED","IDLE_CHAT", 4.1,1,1,1,1,1);

	// ACTORS de Restaurantes
	CreateDynamicActor(31,1041.4830,-1339.1610,13.7325,359.7410);

	CreateDynamicActor(167,926.5392,-1355.7130,13.3788,91.1250);

	CreateDynamicActor(205,1202.2227,-919.8669,43.0903,188.4317);

	CreateDynamicActor(205,810.9685,-1613.5942,13.5469,269.1975);

	CreateDynamicActor(155,2104.8274,-1804.1395,13.5547,90.2161);

	CreateDynamicActor(167,2420.3518,-1505.9834,24.0000,269.3684);
	
	CreateDynamicActor(167,2394.9607,-1898.5419,13.5469,1.2423);
}

hook OnGameModeInit()
{
	// Dentro da Pizzaria
	CreateDynamicPickup(1239, 1, 1217.4617,-876.2473,42.9022, -1);
	CreateDynamic3DTextLabel("Aperte '{ffff00}Y{ffffff}' para pegar sua mochila.", -1, 1217.4617,-876.2473,42.9022, 30.0);

	// Fora da Pizzaria
	CreateDynamicPickup(1239, 1, 1212.5195,-874.3787,42.9123, -1);
	CreateDynamic3DTextLabel("Entregador de iFood\nAperte {ffff00}Y {ffffff}para locar seu veículo", -1, 1212.5195,-874.3787,42.9123, 10.0);

	SetTimer("LoadActorPizza", 5000, false);
	//// ACTOR
	//new ActoriFood;
	//ActoriFood = CreateDynamicActor(167, 1217.3403,-875.2196,42.9021,192.9342);
	//ApplyDynamicActorAnimation(ActoriFood, "PED","IDLE_CHAT", 4.1,1,1,1,1,1);

	// ACTORS de Restaurantes
	//CreateDynamicActor(31,1041.4830,-1339.1610,13.7325,359.7410);
	CreateDynamicPickup(1239, 1, 1041.5095,-1338.4175,13.7325, -1);
	CreateDynamic3DTextLabel("Entregador de iFood\nAperte '{ffff00}Y{ffffff}' para pegar o lanche para delivery", -1, 1041.5095,-1338.4175,13.7325, 5.0);

	//CreateDynamicActor(167,926.5392,-1355.7130,13.3788,91.1250);
	CreateDynamicPickup(1239, 1, 925.5313,-1355.7847,13.3788, -1);
	CreateDynamic3DTextLabel("Entregador de iFood\nAperte '{ffff00}Y{ffffff}' para pegar o lanche para delivery", -1, 925.5313,-1355.7847,13.3788, 5.0);

	//CreateDynamicActor(205,1202.2227,-919.8669,43.0903,188.4317);
	CreateDynamicPickup(1239, 1, 1202.3765,-921.0022,43.0873, -1);
	CreateDynamic3DTextLabel("Entregador de iFood\nAperte '{ffff00}Y{ffffff}' para pegar o lanche para delivery", -1, 1202.3765,-921.0022,43.0873, 5.0);

	//CreateDynamicActor(205,810.9685,-1613.5942,13.5469,269.1975);
	CreateDynamicPickup(1239, 1, 811.8968,-1613.5516,13.5500, -1);
	CreateDynamic3DTextLabel("Entregador de iFood\nAperte '{ffff00}Y{ffffff}' para pegar o lanche para delivery", -1, 811.8968,-1613.5516,13.5500, 5.0);

	//CreateDynamicActor(155,2104.8274,-1804.1395,13.5547,90.2161);
	CreateDynamicPickup(1239, 1, 2103.7131,-1804.1583,13.5547, -1);
	CreateDynamic3DTextLabel("Entregador de iFood\nAperte '{ffff00}Y{ffffff}' para pegar o lanche para delivery", -1, 2103.7131,-1804.1583,13.5547, 5.0);

	//CreateDynamicActor(167,2420.3518,-1505.9834,24.0000,269.3684);
	CreateDynamicPickup(1239, 1, 2394.9631,-1897.4462,13.5469, -1);
	CreateDynamic3DTextLabel("Entregador de iFood\nAperte '{ffff00}Y{ffffff}' para pegar o lanche para delivery", -1, 2394.9631,-1897.4462,13.5469, 5.0);

	//CreateDynamicActor(167,2394.9607,-1898.5419,13.5469,1.2423);
	CreateDynamicPickup(1239, 1, 2421.2449,-1505.9525,23.9922, -1);
	CreateDynamic3DTextLabel("Entregador de iFood\nAperte '{ffff00}Y{ffffff}' para pegar o lanche para delivery", -1, 2421.2449,-1505.9525,23.9922, 5.0);

	return 1;
}



stock GetDeliveryLocalName(Float:PosX, Float:PosY)
{
	new ender[MAX_ZONE_NAME];

	GetLocalName(Float:PosX, Float:PosY, ender, sizeof(ender));
	return ender;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == KEY_YES)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 1212.5195,-874.3787,42.9123))
		{
			if(Jogador[playerid][Profissao] != PIZZA_BOY)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
			

			if(Jogador[playerid][VeiculoLocado] != INVALID_VEHICLE_ID) // Se tem veículo locado
			{
				if(GetPlayerVehicleID(playerid) != Jogador[playerid][VeiculoLocado])
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar em seu veículo locado.");
				
				ShowPlayerDialog(playerid, DIALOG_DESLOCAR_PIZZABOY, DIALOG_STYLE_MSGBOX, "Locar Veículo - Entregador de iFood", "{ffffff}Você deseja devolver seu(a) 'Mountain Bike'?", "Sim", "Não");
				return 1;
			}

			ShowPlayerDialog(playerid, DIALOG_LOCAR_PIZZABOY, DIALOG_STYLE_MSGBOX, "Locar Veículo - Entregador de iFood", "{ffffff}Você deseja locar um(a) 'Mountain Bike'?", "Sim", "Não");
		}
	}

	if(newkeys == KEY_YES)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 1217.4617,-876.2473,42.9022))
		{
			if(Jogador[playerid][Profissao] != PIZZA_BOY)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
			
			if(pInfoPB[playerid][SegurandoBAG] == false)
			{
				pInfoPB[playerid][ObjetoBag] = SetPlayerAttachedObject(playerid, 1, 19572, 1, 0.281000, -0.247000, -0.033999, -177.099960, -87.699966, 0.000000);
			}

			pInfoPB[playerid][SegurandoBAG] = true;
			pInfoPB[playerid][TrabalhandoPB] = true;

			SendClientMessage(playerid, -1, "| MOCHILA | Você pegou sua mochila. Você já está disponível para receber {1C88F0}pedidos{ffffff}.");

			new tempo = 30000 + random(40000);
			TimerDelivery[playerid] = SetTimerEx("TempoDePedido", tempo, 0, "i", playerid);

			//ShowPlayerDialog(playerid, DIALOG_MSG, DIALOG_STYLE_MSGBOX, "{ffffff}Entrega de {ffff00}Lanche", string, "Fechar", "");
		}
	}

	if(newkeys == KEY_YES)
	{
		if(pInfoPB[playerid][TrabalhandoPB] == true)
		{
			if(pInfoPB[playerid][EmEntrega] == true && pInfoPB[playerid][EntregandoCasa] == false)
			{
				if(IsPlayerInRangeOfPoint(playerid, 3.0, Restaurantes[pInfoPB[playerid][RestauranteAceito]][0], Restaurantes[pInfoPB[playerid][RestauranteAceito]][1], Restaurantes[pInfoPB[playerid][RestauranteAceito]][2]))
				{
					if(IsPlayerInAnyVehicle(playerid))
						return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você deve sair do veículo para pegar o lanche.");
					
					SendClientMessage(playerid, -1, "| DELIVERY | Você pegou o lanche. Leve-o para o {ff0000}ponto vermelho {ffffff}marcado em seu radar.");
					pInfoPB[playerid][EntregandoCasa] = true;
					SetPlayerRaceCheckpoint(playerid, 1, LocaisEntrega[pInfoPB[playerid][EntregaAceita]][0], LocaisEntrega[pInfoPB[playerid][EntregaAceita]][1], LocaisEntrega[pInfoPB[playerid][EntregaAceita]][2], 0.0, 0.0, 0.0, 1.0);
					return 1;
				}
			}

			if(pInfoPB[playerid][EmEntrega] == true && pInfoPB[playerid][EntregandoCasa] == true)
			{
				if(IsPlayerInRangeOfPoint(playerid, 3.0, LocaisEntrega[pInfoPB[playerid][EntregaAceita]][0], LocaisEntrega[pInfoPB[playerid][EntregaAceita]][1], LocaisEntrega[pInfoPB[playerid][EntregaAceita]][2]))
				{
					if(IsPlayerInAnyVehicle(playerid))
						return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você deve sair do veículo para entregar o lanche.");
				
					new value = 200 + random(400);
					SendClientMessage(playerid, -1, "| DELIVERY | Você entregou o lanche e recebeu {008000}R$%d {ffffff}pelo seu trabalho!", value);
					SendClientMessage(playerid, -1, "| DELIVERY | Agora você está disponível para novos {"COR_LARANJA_INC"}deliverys{ffffff}!");
					GivePlayerMoney(playerid, value);
					pInfoPB[playerid][RestauranteAceito] = -1;
					pInfoPB[playerid][EntregaAceita] = -1;
					pInfoPB[playerid][EmEntrega] = false;
					pInfoPB[playerid][EntregandoCasa] = false;
					pInfoPB[playerid][TemDelivery] = false;
					DisablePlayerRaceCheckpoint(playerid);
					return 1;
				}
			}
		}
	}

	return 1;
}

forward TempoDePedido(playerid);
public TempoDePedido(playerid)
{
	if(Jogador[playerid][Profissao] == PIZZA_BOY)
	{
		if(pInfoPB[playerid][TrabalhandoPB] == true)
		{
			if(pInfoPB[playerid][EmEntrega] == false)
			{
				new Rand = random(sizeof(Restaurantes));
				new nome[100];
				if(Rand == 0) { nome = "Burguer Shot Temple"; }
				else if(Rand == 1) { nome = "Jim's Sticky Ring"; }
				else if(Rand == 2) { nome = "Cluckin' Bell Market"; }
				else if(Rand == 3) { nome = "Burger Shot Marina"; }
				else if(Rand == 4) { nome = "The Well Stacked Pizza Co."; }
				else if(Rand == 5) { nome = "Cluckin' Bell Willowfield"; }
				else if(Rand == 6) { nome = "Cluckin' Bell East Los Santos"; }
				
				new Rand2 = random(sizeof(LocaisEntrega));

				SendClientMessage(playerid, COR_LARANJA, "~~~~~~~~~~~~~~~~~~~~ Delivery ~~~~~~~~~~~~~~~~~~~~");
				SendClientMessage(playerid, -1,          "» Você recebeu uma solicitação de delivery.");
				SendClientMessage(playerid, -1,          "» Restaurante: {1c88f0}%s{ffffff}.", nome);
				SendClientMessage(playerid, -1, 		 "» Endereço da Entrega: {1c88f0}%s{ffffff}.", GetDeliveryLocalName(LocaisEntrega[Rand2][0], LocaisEntrega[Rand2][1]));
				SendClientMessage(playerid, -1,          "» Digite {ff8000}/AceitarDelivery {ffffff}para aceitar.");
				SendClientMessage(playerid, COR_LARANJA, "~~~~~~~~~~~~~~~~~~~~ Delivery ~~~~~~~~~~~~~~~~~~~~");

				pInfoPB[playerid][TemDelivery] = true;

				pInfoPB[playerid][RestauranteAceito] = Rand;
				pInfoPB[playerid][EntregaAceita] = Rand2;
			}
			new tempo = 30000 + random(40000);
			TimerDelivery[playerid] = SetTimerEx("TempoDePedido", tempo, 0, "i", playerid);
		}
	}
	return 1;
}

CMD:aceitardelivery(playerid)
{
	if(Jogador[playerid][Profissao] != PIZZA_BOY)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
	
	if(pInfoPB[playerid][TrabalhandoPB] == false)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");
	
	if(pInfoPB[playerid][EmEntrega] == true)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já aceitou uma solicitação de delivery.");
	
	if(pInfoPB[playerid][TemDelivery] == false)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não há nenhum pedido de delivery.");
	

	
	pInfoPB[playerid][EmEntrega] = true;

	SendClientMessage(playerid, -1, "| DELIVERY | Você aceitou o delivery. Siga para o {ff0000}ponto vermelho {ffffff}marcado em seu mapa para pegar o lanche!");

	SetPlayerRaceCheckpoint(playerid, 1, Restaurantes[pInfoPB[playerid][RestauranteAceito]][0], Restaurantes[pInfoPB[playerid][RestauranteAceito]][1], Restaurantes[pInfoPB[playerid][RestauranteAceito]][2], 0.0, 0.0, 0.0, 1.0);
	return 1;
}

/*hook OnVehicleSpawn(vehicleid) // Finalizar serviço.
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

Dialog:DIALOG_DESLOCAR_PIZZABOY(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		SendClientMessage(playerid, -1, "| VEÍCULO | Você devolveu seu veículo locado com sucesso.");
		DestroyVehicle(Jogador[playerid][VeiculoLocado]);
		Jogador[playerid][VeiculoLocado] = INVALID_VEHICLE_ID;
	}
	return 1;
}

Dialog:DIALOG_LOCAR_PIZZABOY(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		SendClientMessage(playerid, -1, "| VEÍCULO | Seu veículo foi locado com sucesso! Siga o ponto {ff0000}vermelho {ffffff}em seu mapa para pegá-lo!");
		
		Jogador[playerid][VeiculoLocado] = CreateVehicle(510, 1201.7202,-876.3721,42.6302,192.9395, 1, 1, 300000);
		SetPlayerCheckpoint(playerid, 1201.7202,-876.3721,42.6302, 1.0);
		
	}
	return 1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
	if(pInfoPB[playerid][TrabalhandoPB] == true)
	{
		DisablePlayerCheckpoint(playerid);
	}
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(pInfoPB[playerid][TrabalhandoPB] == true)
	{
		if(pInfoPB[playerid][EmEntrega] == true && pInfoPB[playerid][EntregandoCasa] == true)
		{
			if(IsPlayerInAnyVehicle(playerid))
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você deve sair do veículo para entregar o lanche.");
			
			new value = 100 + random(200);
			SendClientMessage(playerid, -1, "| DELIVERY | Você entregou o lanche e recebeu {008000}R$%d {ffffff}pelo seu trabalho!", value);
			SendClientMessage(playerid, -1, "| DELIVERY | Agora você está disponível para novos {"COR_LARANJA_INC"}deliverys{ffffff}!");
			GivePlayerMoney(playerid, value);
			pInfoPB[playerid][RestauranteAceito] = -1;
			pInfoPB[playerid][EntregaAceita] = -1;
			pInfoPB[playerid][EmEntrega] = false;
			pInfoPB[playerid][EntregandoCasa] = false;
			pInfoPB[playerid][TemDelivery] = false;
			DisablePlayerRaceCheckpoint(playerid);
			return 1;
		}
	}

	//DisablePlayerRaceCheckpoint(playerid);
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

// COMANDOS
