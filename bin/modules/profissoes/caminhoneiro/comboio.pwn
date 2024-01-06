

Comboio_Draws(Comboio) {
    for(new i; i < 2; i++) {
        AConvoys[Comboio][ComboioDraw][i] = TextDrawCreate(302.000000, 360.000000, "");
        TextDrawAlignment(AConvoys[Comboio][ComboioDraw][i], 2);
        TextDrawBackgroundColor(AConvoys[Comboio][ComboioDraw][i], 255);
        TextDrawFont(AConvoys[Comboio][ComboioDraw][i], 1);
        TextDrawLetterSize(AConvoys[Comboio][ComboioDraw][i], 0.240000, 0.999999);
        TextDrawColor(AConvoys[Comboio][ComboioDraw][i], -1);
        TextDrawSetOutline(AConvoys[Comboio][ComboioDraw][i], 1);
        TextDrawSetProportional(AConvoys[Comboio][ComboioDraw][i], 1);
        TextDrawUseBox(AConvoys[Comboio][ComboioDraw][i], 1);
        TextDrawBoxColor(AConvoys[Comboio][ComboioDraw][i], 0xFFFFFF00);
        TextDrawTextSize(AConvoys[Comboio][ComboioDraw][i], 0.000000, 293.000000);
        TextDrawSetSelectable(AConvoys[Comboio][ComboioDraw][i], 0);
    }
    return 1;
}
Convoy_Create(playerid, Convoy)
{
	//new Msg[144];
	//GetPlayerName(playerid, Name, sizeof(Name));
	if (Convoy_PlayerAllowed(playerid))
	{
		AConvoys[Convoy][Status] = CONVOY_OPEN;
		AConvoys[Convoy][Members][0] = playerid;
		Jogador[playerid][InConvoy] = true;
		Jogador[playerid][ConvoyID] = Convoy;
		for (new i = 1; i < CONVOY_MAX_MEMBERS; i++)
		    AConvoys[Convoy][Members][i] = -1;
		AConvoys[Convoy][ConvoyTimer] = SetTimerEx("Convoy_Timer", 1000, true, "i", Convoy);
        //format(Msg, 144, "{ffff00}* %s criou um comboio, use /comboio para entrar!", GetUserName(playerid));
        //SendClientMessageToAll(-1, Msg);
        Comboio_Draws(Convoy);
        //if(Jogador[playerid][AparecerInfosTrabalho][0] == true)
     	//	for(new i; i < 2; i++)  {
        //        PlayerTextDrawSetString(playerid,Jogador[playerid][TrabalhoDraw][i],"_");
    	//		PlayerTextDrawShow(playerid, Jogador[playerid][TrabalhoDraw][i]);
        //    }
        //TextDrawShowForPlayer(playerid,AConvoys[Convoy][ComboioDraw][0]); // Draw de Lider
        ShowPlayerDialog(playerid, DialogTrocarNomeComboio, DIALOG_STYLE_INPUT, "{ffffff}Nome de comboio:", "{"COR_LARANJA_INC"}Digite o nome de comboio desejado:\n", "Colocar", "Cancelar");
	}
	return 1;
}

Convoy_Join(playerid, Convoy)
{
	new NomeQ[20];
	if (Convoy_PlayerAllowed(playerid))
	{
		if (Convoy_CountMembers(Convoy) < CONVOY_MAX_MEMBERS)
		{

			if(strlen(AConvoys[Convoy][ComboioNome]) > 0)
				format(NomeQ, 20, AConvoys[Convoy][ComboioNome]);
			else
			    format(NomeQ, 20, "[sem nome]");
			new _msg[256];
			format(_msg, sizeof(_msg), "| COMBOIO | O(A) %s(%d) entrou no comboio!", GetUserName(playerid), playerid);
			Convoy_SendMessage(Convoy, _msg);
			//format(Msg, 144, "{a9c4e4}Você entrou no comboio {ffffff}%s{a9c4e4}!", NomeQ);
			//SendClientMessage(playerid, 0xFFFFFFFF, Msg);
			SendClientMessage(playerid, COR_AMARELO, "| COMBOIO | Você entrou no comboio {ffffff}%s", NomeQ);
			for (new i; i < CONVOY_MAX_MEMBERS; i++)
			{
			    if (AConvoys[Convoy][Members][i] == -1)
				{
					AConvoys[Convoy][Members][i] = playerid;
					break;
				}
			}
			Jogador[playerid][InConvoy] = true;
			Jogador[playerid][ConvoyID] = Convoy;
			if (Convoy_CountMembers(Convoy) == CONVOY_MAX_MEMBERS)
			    AConvoys[Convoy][Status] = CONVOY_FULL;
            //if(Jogador[playerid][AparecerInfosTrabalho][0] == true)
    		//	for(new i; i < 2; i++) {
            //        PlayerTextDrawSetString(playerid,Jogador[playerid][TrabalhoDraw][i],"_");
    		//	    PlayerTextDrawShow(playerid, Jogador[playerid][TrabalhoDraw][i]);
            //    }
            TextDrawShowForPlayer(playerid,AConvoys[Convoy][ComboioDraw][1]); // Draw de Membro
		}
		else
		    SendClientMessage(playerid, COR_ERRO, "| ERRO | O comboio está cheio!");
	}
}
Convoy_Leave(playerid)
{
	new Convoy, NumMembers, MemberID;
	if (Jogador[playerid][InConvoy] == false)
	    return 1;
	Convoy = Jogador[playerid][ConvoyID];
	NumMembers = Convoy_CountMembers(Convoy);
	Jogador[playerid][InConvoy] = false;
	Jogador[playerid][ConvoyID] = 0;

	//for(new i; i < 2; i++) {
    //    PlayerTextDrawSetString(playerid,Jogador[playerid][TrabalhoDraw][i],"_");
	//    PlayerTextDrawHide(playerid, Jogador[playerid][TrabalhoDraw][i]);
    //    TextDrawHideForPlayer(playerid,AConvoys[Convoy][ComboioDraw][i]);
    //}

	if (Convoy_CountMembers(Convoy) == CONVOY_MAX_MEMBERS && Jogador[playerid][JobStarted] == true)
		AConvoys[Convoy][Status] = CONVOY_CLOSED;
	if (Convoy_CountMembers(Convoy) == CONVOY_MAX_MEMBERS && Jogador[playerid][JobStarted] == false)
        AConvoys[Convoy][Status] = CONVOY_OPEN;
	if (NumMembers == 1)
	{
		Convoy_Cancel(Convoy);
		return 1;
	}
	if (AConvoys[Convoy][Members][0] == playerid)
	{
		for (new j = 1; j < CONVOY_MAX_MEMBERS; j++)
		{
			MemberID = AConvoys[Convoy][Members][j];
			if (MemberID != -1)
			{
				AConvoys[Convoy][Members][0] = MemberID;
				AConvoys[Convoy][Members][j] = -1;
                //TextDrawHideForPlayer(MemberID,AConvoys[Convoy][ComboioDraw][1]);
                //TextDrawShowForPlayer(MemberID,AConvoys[Convoy][ComboioDraw][0]);
				return 1;
			}
		}
	}
	else
	{
		for (new i = 1; i < CONVOY_MAX_MEMBERS; i++)
		{
			if (AConvoys[Convoy][Members][i] == playerid)
			{
			    AConvoys[Convoy][Members][i] = -1;
				Trucker_EndJob(playerid);
				return 1;
			}
		}
	}
    if(Jogador[playerid][JobStarted] == true)
        Trucker_EndJob(playerid);
    return 1;
}
Convoy_Cancel(Convoy)
{
	new MemberID;
	for (new i; i < CONVOY_MAX_MEMBERS; i++)
	{
	    MemberID = AConvoys[Convoy][Members][i];
		if (MemberID != -1)
		{
			//for(new x;x < 2; x++) {
            //    PlayerTextDrawSetString(MemberID,Jogador[MemberID][TrabalhoDraw][x],"_");
			//    PlayerTextDrawHide(MemberID, Jogador[MemberID][TrabalhoDraw][x]);
            //    TextDrawHideForPlayer(MemberID,AConvoys[Convoy][ComboioDraw][x]);
            //}
			Jogador[MemberID][InConvoy] = false;
			Jogador[MemberID][ConvoyID] = 0;
			Trucker_EndJob(MemberID);
		    AConvoys[Convoy][Members][i] = -1;
			//SendClientMessage(MemberID, 0xFFFFFFFF, "{a9c4e4}O comboio foi {FF0000}cancelado{a9c4e4} pelo líder!");
			SendClientMessage(MemberID, COR_ERRO, "| INFO | O comboio foi cancelado pelo líder!");
		}
	}
	AConvoys[Convoy][LoadID] = 0;
	AConvoys[Convoy][Location1] = 0;
	AConvoys[Convoy][Location2] = 0;
	AConvoys[Convoy][Status] = CONVOY_EMPTY;
	AConvoys[Convoy][ConvoyStep] = 0;
	AConvoys[Convoy][TrailerModel] = 0;
    AConvoys[Convoy][TruckModel] = 0;
    AConvoys[Convoy][ComboioNome] = 0;
	AConvoys[Convoy][LeaderInformedTrailers] = false;
	AConvoys[Convoy][SenhaComboio] = 0;
	KillTimer(AConvoys[Convoy][ConvoyTimer]);
    for(new i; i < 2; i++)
        TextDrawDestroy(AConvoys[Convoy][ComboioDraw][i]);
	return 1;
}
Convoy_StartMemberJob(playerid, Convoy)
{
	new StartLoc[50], EndLoc[50], Load[50], Float:x, Float:y, Float:z;
	Jogador[playerid][JobStarted] = true;
	Jogador[playerid][LoadID] = AConvoys[Convoy][LoadID];
	Jogador[playerid][JobLoc1] = AConvoys[Convoy][Location1];
	Jogador[playerid][JobLoc2] = AConvoys[Convoy][Location2];
	//Jogador[playerid][UltimaRota][0] = Jogador[playerid][LoadID];
	//Jogador[playerid][UltimaRota][1] = Jogador[playerid][JobLoc1];
	//Jogador[playerid][UltimaRota][2] = Jogador[playerid][JobLoc2];
	Jogador[playerid][VehicleID] = GetPlayerVehicleID(playerid);
	Jogador[playerid][TrailerID] = GetVehicleTrailer(GetPlayerVehicleID(playerid));
	Jogador[playerid][JobStep] = 1;
	format(StartLoc, 50, ALocations[Jogador[playerid][JobLoc1]][LocationName]);
	format(EndLoc, 50, ALocations[Jogador[playerid][JobLoc2]][LocationName]);
	format(Load, 50, ALoads[Jogador[playerid][LoadID]][LoadName]);
	x = ALocations[Jogador[playerid][JobLoc1]][LocX];
	y = ALocations[Jogador[playerid][JobLoc1]][LocY];
	z = ALocations[Jogador[playerid][JobLoc1]][LocZ];
	SetPlayerCheckpoint(playerid, x, y, z, 7);
	Jogador[playerid][VehicleTimerTime] = gettime() + Job_TimeToFailMission;
	//format(LoadMsg, 128, "{00D700}Carga: {FFFFFF}%s   {00D700}Local de carregamento: {FFFFFF}%s.", Load, StartLoc);
	//SendClientMessage(playerid, 0xFFFFFFFF, LoadMsg);
	//SendClientMessage(playerid, 0xFFFFFFFF, "{a9c4e4}Encontre os outros membros no ponto de carregamento.");

	SendClientMessage(playerid, COR_BRANCO, "| COMBOIO | Vá até o local de carregamento em {"COR_VERDE_INC"}%s {ffffff}para carregar {"COR_LARANJA_INC"}%s", StartLoc, Load);
    //AtualizarLabelJogador(playerid);
    Jogador[playerid][TrabalhoTempo] = gettime();
    //if(Jogador[playerid][AparecerInfosTrabalho][0] == true)
    // 	for(new i; i < 2; i++) {
    //        PlayerTextDrawSetString(playerid,Jogador[playerid][TrabalhoDraw][i],"_");
    //		PlayerTextDrawShow(playerid, Jogador[playerid][TrabalhoDraw][i]);
    //    }
   	return 1;
}
Convoy_UpdateMemberJob(playerid)
{
	new StartLoc[50], EndLoc[50], Float:x, Float:y, Float:z;
	Jogador[playerid][JobStep] = 3;
	format(StartLoc, 50, ALocations[Jogador[playerid][JobLoc1]][LocationName]);
	format(EndLoc, 50, ALocations[Jogador[playerid][JobLoc2]][LocationName]);
	//format(Load, 50, ALoads[Jogador[playerid][LoadID]][LoadName]);
	x = ALocations[Jogador[playerid][JobLoc2]][LocX];
	y = ALocations[Jogador[playerid][JobLoc2]][LocY];
	z = ALocations[Jogador[playerid][JobLoc2]][LocZ];
	SetPlayerCheckpoint(playerid, x, y, z, 7);
	//format(UnloadMsg, 128, "{00D700}Carga: {FFFFFF}%s    {00D700}Destino: {FFFFFF}%s.", Load, EndLoc);
	//SendClientMessage(playerid, 0xFFFFFFFF, UnloadMsg);
	SendClientMessage(playerid, COR_BRANCO, "| COMBOIO | Vá até o destino em {"COR_VERDE_INC"}%s {ffffff}para descarregar", EndLoc);
	return 1;
}
forward Convoy_Timer(Convoy);
public Convoy_Timer(Convoy)
{
	new LeaderID, MemberID;
    //Convoy_UpdateTextDraws(Convoy);
	LeaderID = AConvoys[Convoy][Members][0];
	switch (AConvoys[Convoy][ConvoyStep])
	{
		case 0:
		{
        	new bool:AllSameTrailer = true;
			if (Jogador[LeaderID][JobStarted] == true)
			{
				AConvoys[Convoy][LoadID] = Jogador[LeaderID][LoadID];
				AConvoys[Convoy][Location1] = Jogador[LeaderID][JobLoc1];
				AConvoys[Convoy][Location2] = Jogador[LeaderID][JobLoc2];
				AConvoys[Convoy][TrailerModel] = GetVehicleModel(Jogador[LeaderID][TrailerID]);
                AConvoys[Convoy][TruckModel] = GetVehicleModel(Jogador[LeaderID][VehicleID]);
				if (AConvoys[Convoy][TrailerModel] != 0)
				{
					for (new i = 1; i < CONVOY_MAX_MEMBERS; i++)
					{
						MemberID = AConvoys[Convoy][Members][i];
						if (MemberID != -1)
						{
                            Jogador[MemberID][comVeiculo] = 0;
                            if (GetVehicleModel(GetVehicleTrailer(GetPlayerVehicleID(MemberID))) != AConvoys[Convoy][TrailerModel])
							{
							    switch (AConvoys[Convoy][TrailerModel])
							    {
									case VehicleTrailerCargo, VehicleTrailerCargo2: GameTextForPlayer(MemberID, "~w~Você precisa de um trailer ~g~baú~w~!", 5000, 4), Jogador[MemberID][comVeiculo] = 1;
									case VehicleTrailerOre: GameTextForPlayer(MemberID, "~w~Você precisa de um trailer de ~g~minério~w~!", 5000, 4), Jogador[MemberID][comVeiculo] = 1;
                                    case VehicleTrailerFluids: GameTextForPlayer(MemberID, "~w~Você precisa de um trailer de ~g~fluídos~w~!", 5000, 4), Jogador[MemberID][comVeiculo] = 1;
                                }
								AllSameTrailer = false;
                            }
                        }
					}
				}
				else
				{
					for (new i = 1; i < CONVOY_MAX_MEMBERS; i++)
					{
						MemberID = AConvoys[Convoy][Members][i];
                        if (MemberID != -1)
						{
                            Jogador[MemberID][comVeiculo] = 0;
                            if(GetVehicleModel(GetPlayerVehicleID(MemberID)) != AConvoys[Convoy][TruckModel]) {
       							switch (AConvoys[Convoy][TruckModel])
       							{
       								case VehicleFlatbed, VehicleDFT30, VehicleYankee: {
                                        GameTextForPlayer(MemberID, "~w~Você precisa de um ~g~Flatbed~w~, ~g~DFT-30 ~w~ou ~g~Yankee~w~!", 5000, 4);
                                        Jogador[MemberID][comVeiculo] = 1;
                                    }
                                    case VehicleCementTruck: {
                                        GameTextForPlayer(MemberID, "~w~Você precisa de um ~g~Cement Truck~w~!", 5000, 4);
                                        Jogador[MemberID][comVeiculo] = 1;
                                    }
       							}
                                AllSameTrailer = false;
                            }
						}
					}
				}
				if (AllSameTrailer == true)
				{
					SendClientMessage(LeaderID, COR_BRANCO, "| COMBOIO | Todos os membros estão com seus devidos veículos/trailers, o comboio foi iniciado.");
					GameTextForPlayer(LeaderID,  "~w~Comboio ~b~iniciado~w~!", 5000, 4);
					for (new i = 1; i < CONVOY_MAX_MEMBERS; i++)
					{
						MemberID = AConvoys[Convoy][Members][i];
						if (MemberID != -1)
                        {
							Convoy_StartMemberJob(MemberID, Convoy);
                            Jogador[MemberID][comVeiculo] = 0;
                            GameTextForPlayer(LeaderID, "~w~Comboio ~b~iniciado~w~! Carregue seu caminhao no ~r~checkpoint~w~!", 5000, 4);
                        }
					}
	                AConvoys[Convoy][ConvoyStep] = 1;
				    AConvoys[Convoy][Status] = CONVOY_CLOSED;
				}
				else
				{
					if (AConvoys[Convoy][LeaderInformedTrailers] == false)
					{
						SendClientMessage(LeaderID, COR_ERRO, "| ERRO | O comboio não pode ser iniciado pois alguns /membros estão sem o veículo/trailer correto.");
						AConvoys[Convoy][LeaderInformedTrailers] = true;
					}
				}
			}
		}
		case 1:
		{
			new bool:AllMembersLoaded = true;
			for (new i; i < CONVOY_MAX_MEMBERS; i++)
			{
				MemberID = AConvoys[Convoy][Members][i];
				if (MemberID != -1)
                {
                    Jogador[MemberID][comVeiculo] = 0;
                    if (Jogador[MemberID][JobStep] != 2)
                    {
                        AllMembersLoaded = false;
                        Jogador[MemberID][comVeiculo] = 2;
                    }
                }
            }
			if (AllMembersLoaded == true)
			{
				SendClientMessage(LeaderID, COR_BRANCO, "| COMBOIO | Todos os membros carregados, o comboio poderá seguir para o ponto de descarregamento.");
				GameTextForPlayer(LeaderID, "~w~Comboio ~b~carregado~w~!", 5000, 4);
				for (new i; i < CONVOY_MAX_MEMBERS; i++)
				{
					MemberID = AConvoys[Convoy][Members][i];
					if (MemberID != -1)
                    {
						Convoy_UpdateMemberJob(MemberID);
                        Jogador[MemberID][comVeiculo] = 0;
                        GameTextForPlayer(LeaderID, "~w~Comboio ~b~carregado~w~! Descarregue seu caminhao no ~r~checkpoint~w~!", 5000, 4);
                    }
                }
                AConvoys[Convoy][ConvoyStep] = 2;
			}
		}
		case 2:
		{
			new bool:AllMembersUnloaded = true;
			for (new i; i < CONVOY_MAX_MEMBERS; i++)
			{
				MemberID = AConvoys[Convoy][Members][i];
				if (MemberID != -1)
                {
                    Jogador[MemberID][comVeiculo] = 0;
                    if (Jogador[MemberID][JobStep] != 4)
                    {
                	    AllMembersUnloaded = false;
                        Jogador[MemberID][comVeiculo] = 3;
                    }
                }
            }
			if (AllMembersUnloaded == true)
            {
				AConvoys[Convoy][ConvoyStep] = 3;
            }
		}
		case 3:
		{
			new Float:Distance, Payment, Msg1[144], Msg2[144], Bonus, NumMembers, BonusMsg[144], TempoTotal, Minutos, Float:VehVida, Float:TrailerVida, Preju;
            TempoTotal = gettime() - Jogador[LeaderID][TrabalhoTempo];
            if(TempoTotal >= 60)
            {
                Minutos = TempoTotal / 60;
                TempoTotal = TempoTotal - (Minutos * 60);
            }
            //Segundos = TempoTotal;
            NumMembers = Convoy_CountMembers(Convoy);

			Distance = GetPointDistanceToPointEx(ALocations[Jogador[LeaderID][JobLoc1]][LocX],ALocations[Jogador[LeaderID][JobLoc1]][LocY],ALocations[Jogador[LeaderID][JobLoc1]][LocZ],ALocations[Jogador[LeaderID][JobLoc2]][LocX],ALocations[Jogador[LeaderID][JobLoc2]][LocY],ALocations[Jogador[LeaderID][JobLoc2]][LocZ]);
			Payment = floatround((Distance * ALoads[Jogador[LeaderID][LoadID]][PayPerUnit]), floatround_floor);
            //format(Msg1, 144, "{FFFF00}[COMBOIO] O comboio %s lider %s {FFFFFF}%s{FFFF00} acabou de fazer a rota:", (Jogador[LeaderID][Sexo] == SEXO_FEMININO ? ("da") : ("do")), RankingTruck[Jogador[LeaderID][RankTruck]][RankNome], Jogador[LeaderID][PlayerName]);
            //format(Msg2, 144, "{FFFF00}[COMBOIO] %s > %s > %s (em %02d min e %02d seg)", ALoads[Jogador[LeaderID][LoadID]][LoadName], ALocations[Jogador[LeaderID][JobLoc1]][LocationName], ALocations[Jogador[LeaderID][JobLoc2]][LocationName], Minutos, Segundos);
			if (RandomBonusMission[MissionFinished] == false)
			{
				if (RandomBonusMission[RandomLoad] == Jogador[LeaderID][LoadID])
					if (RandomBonusMission[RandomStartLoc] == Jogador[LeaderID][JobLoc1])
						if (RandomBonusMission[RandomEndLoc] == Jogador[LeaderID][JobLoc2])
						{
						    Payment = Payment * 2;
                            RandomBonusMission[MissionFinished] = true;
							format(BonusMsg, 144, "| INFO | O comboio do líder {ffffff}%s{"COR_AMARELO_INC"} finalizou a missão bonus.", GetUserName(LeaderID));
							//Jogador[LeaderID][RankPointTruck] += 10;
						}
			}
            for(new p; p <= GetPlayerPoolSize(); p++) {
                if(!IsPlayerConnected(p) || Jogador[p][Logado] == false) continue;// || Jogador[p][AparecerInfosTrabalho][1] == false) continue;
                SendClientMessage(p, -1, Msg1);
                SendClientMessage(p, -1, Msg2);
                if(strlen(BonusMsg) > 10)
                    SendClientMessage(p, COR_AMARELO, BonusMsg);
            }
		    Bonus = (NumMembers * 20) + 100;
			Payment = (Payment * Bonus) / 100;
			for (new i; i < CONVOY_MAX_MEMBERS; i++)
			{
				MemberID = AConvoys[Convoy][Members][i];
				if (MemberID != -1)
				{
                    GetVehicleHealth(GetPlayerVehicleID(MemberID), VehVida);
                    GetVehicleHealth(GetVehicleTrailer(GetPlayerVehicleID(MemberID)), TrailerVida);

                    Jogador[MemberID][comVeiculo] = 0;
		            //Jogador[MemberID][StatsConvoyJobs]++;
				    //format(Message, sizeof(Message), "{a9c4e4}Você finalizou a entrega em comboio e ganhou {00ff00}R${FFFFFF}%i.", Payment);
				    //SendClientMessage(MemberID, 0xFFFFFFFF, Message);
				    //SendClientMessage(MemberID, -1, "Você finalizou a entrega em comboio e ganho ou %s", RealStr(Payment));
				    SendClientMessage(MemberID, COR_BRANCO, "| ENTREGA | Você finalizou a entrega em comboio e ganhou {"COR_VERDE_INC"}R$%s", RealStr(Payment));
				    RewardPlayer(MemberID, Payment);
                    if(Jogador[MemberID][Vip] == false)
                    {
                        if(Distance > 1800.0)
                        {

					       //RewardPlayer(MemberID, Payment, 5, 0);
					       //Jogador[MemberID][RankPointTruck] = Jogador[MemberID][RankPointTruck] + 2;
						}
					    else
					    {
                           //RewardPlayer(MemberID, Payment, 1, 0);
                           //Jogador[MemberID][RankPointTruck] = Jogador[MemberID][RankPointTruck] + 1;
						}
                    }
                    else
                    {
                       new Preco;
                       if(Distance > 1000.0)
                       {
                           //Preco = Payment/50;
                           //RewardPlayer(MemberID, Preco);
                           //RewardPlayer(MemberID, Payment, 5, Preco);
                           //Jogador[MemberID][RankPointTruck] = Jogador[MemberID][RankPointTruck] + 4;

                       }
                       else
                       {
                           //Preco = Payment/150;
                           //RewardPlayer(MemberID, Preco);
                           //RewardPlayer(MemberID, Payment, 3, Preco);
                           //Jogador[MemberID][RankPointTruck] = Jogador[MemberID][RankPointTruck] + 1;
                       }
                       //format(Message, 144, "{a9c4e4}Bônus: {ffffff}%i{a9c4e4} de golds!", Preco);
                       //SendClientMessage(MemberID, 0xFFFFFFFF, Message);
                       //SendClientMessage(MemberID, -1, "%d Bonus", Preco);
                       Bonus = (Payment * 7) / 100;
                       SendClientMessage(MemberID, COR_BRANCO, "| ENTREGA | Você recebeu ( {"COR_VERDE_INC"}R$%s {ffffff}) de bônus por ser um(a) jogador(a) {"COR_LARANJA_INC"}VIP {ffffff}no servidor", RealStr(Preco));
                       RewardPlayer(MemberID, Preco);
                    }
                    if(VehVida < 1000.0) {
                        Preju = (100 - floatround(VehVida / 10)) * 5;
                        if(TrailerVida < 1000.0 && IsTrailerAttachedToVehicle(GetPlayerVehicleID(MemberID)))
                            Preju += (100 - floatround(TrailerVida / 10)) * 20;
                        //RewardPlayer(MemberID, -Preju, 0, 0);
                        //format(Message, sizeof(Message), "** Houve danos durante o transporte, você teve o prejuízo de {00FF00}R${FFFFFF}%i{a9c4e4}.", Message, Preju);
                        //SendClientMessage(MemberID, -1, Message);
                        SendClientMessage(MemberID, COR_ERRO, "| ENTREGA | {ffffff}Houve danos durante o transporte, você teve o prejuízo de {"COR_VERMELHO_INC"}R$%s\n", RealStr(Preju));
                    	RewardPlayer(MemberID, -Preju);
                    }
                    Jogador[MemberID][TempoComando][10] = gettime() + (60 * 10);
				    Trucker_EndJob(MemberID);
       			}
			}

            AConvoys[Convoy][LoadID] = 0;
			AConvoys[Convoy][Location1] = 0;
			AConvoys[Convoy][Location2] = 0;
            if (Convoy_CountMembers(Convoy) == CONVOY_MAX_MEMBERS)
                AConvoys[Convoy][Status] = CONVOY_FULL;
            else
			    AConvoys[Convoy][Status] = CONVOY_OPEN;
			AConvoys[Convoy][ConvoyStep] = 0;
			AConvoys[Convoy][TrailerModel] = 0;
            AConvoys[Convoy][TruckModel] = 0;
			AConvoys[Convoy][SenhaComboio] = 0;
			AConvoys[Convoy][LeaderInformedTrailers] = false;
		}
	}
	return 1;
}
/*Convoy_UpdateTextDraws(Convoy)
{
	new LeaderID, MemberID, LeaderName[24], NumMembers, TextLeader[128], TextMember[128], LastMember[24], LastMemberID, Float:Distance;
	LeaderID = AConvoys[Convoy][Members][0];
	GetPlayerName(LeaderID, LeaderName, sizeof(LeaderName));
	NumMembers = Convoy_CountMembers(Convoy);
	if (NumMembers > 1)
	{
	    LastMemberID = Convoy_GetFurthestMember(Convoy);
		GetPlayerName(LastMemberID, LastMember, sizeof(LastMember));
		Distance = PlayerToPlayer(LeaderID, LastMemberID);
	}
	else
	{
		format(LastMember, 24, " - ");
		Distance = 0.0;
	}
	format(TextLeader, 128, "~y~COMBOIO~w~: Membros: ~b~%i ~w~/ Distante: ~r~%s (%4.2fm)", NumMembers, LastMember, Distance);
    TextDrawSetString(AConvoys[Convoy][ComboioDraw][0], TextLeader);

	for (new i = 1; i < CONVOY_MAX_MEMBERS; i++)
	{
		MemberID = AConvoys[Convoy][Members][i];
		if (MemberID != -1)
		{
			Distance = PlayerToPlayer(LeaderID, MemberID);
			format(TextMember, 128, "~y~COMBOIO~w~: Lider: ~g~%s (%4.2fm) ~w~/ Membros: ~r~%i~w~", LeaderName, Distance, NumMembers);
            TextDrawSetString(AConvoys[Convoy][ComboioDraw][1],TextMember);
		}
	}
	return 1;
}*/
Convoy_CountMembers(Convoy)
{
	new NumMembers;
	for (new i; i < CONVOY_MAX_MEMBERS; i++)
	{
		if (AConvoys[Convoy][Members][i] != -1)
		    NumMembers++;
	}
	return NumMembers;
}
Convoy_PlayerAllowed(playerid)
{
	if (call::PLAYER->GetPlayerVarInt(playerid, Profissao) == CAMINHONEIRO)
	{
		if (Jogador[playerid][InConvoy] == false)
		{
			if (Jogador[playerid][JobStarted] == false)
				return true;
			else
			    SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já começou um trabalho, você não pode criar ou participar de um comboio no momento!");
		}
		else
		    SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está em um comboio!");
	}
	else
	    SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte desta profissão.");
	return false;
}
Convoy_SendMessage(Convoy, MensagemConvoy[])
{
	new MemberID;
	for (new i; i < CONVOY_MAX_MEMBERS; i++)
	{
	    MemberID = AConvoys[Convoy][Members][i];
	    if (MemberID != -1)
		{
			//SendClientMessage(MemberID, 0xFFFFFFFF, Message);
			SendClientMessage(MemberID, -1, MensagemConvoy);
		}
	}
	return 1;
}

/*Convoy_GetFurthestMember(Convoy)
{
	new Float:distance, Float:distance2, LeaderID, MemberID, result = -1;
	LeaderID = AConvoys[Convoy][Members][0];
	for(new i = 1; i < CONVOY_MAX_MEMBERS; i++)
	{
		MemberID = AConvoys[Convoy][Members][i];
		if (MemberID != -1)
		{
			distance2 = PlayerToPlayer(LeaderID, MemberID);
			if(distance2 > distance)
			{
				distance = distance2;
				result = MemberID;
			}
		}
	}
	return result;
}*/

CMD:comboios(playerid, params[])
{

	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != CAMINHONEIRO)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte desta profissão.");

	new ConvoyList[2000], NumMembers, ConvoyStatus[10], NomeQ[20];
    switch(GetVehicleModel(GetPlayerVehicleID(playerid)))
    {
        case VehicleDFT30, VehicleFlatbed, VehicleYankee, VehicleCementTruck: { }
        case VehicleRoadTrain, VehicleTanker, VehicleLineRunner: {
            switch(GetVehicleModel(GetVehicleTrailer(GetPlayerVehicleID(playerid)))) {
                case VehicleTrailerFluids, VehicleTrailerCargo, VehicleTrailerCargo2, VehicleTrailerOre: { }
            }
        }
        default: return SendClientMessage(playerid, -1, "{ff0000}Esteja com um caminhão ou atrele um trailer!");
    }
    if(!isnull(params)) {
        if(strval(params) < 0 || strval(params) >= MAX_CONVOYS) return SendClientMessage(playerid, -1, "{ff0000}Comboio inválido!");
        return 0;
    }
    strcat(ConvoyList,"Comboio\tLíder\tMembros\tStatus\n");
    for (new i; i < MAX_CONVOYS; i++) {
		if (AConvoys[i][Status] == CONVOY_EMPTY) {
			NumMembers = 0;
			format(ConvoyStatus, 10, "vazio");
            strcat(ConvoyList, "*\tNinguém\t0\tVazio\n");
		} else {
			NumMembers = Convoy_CountMembers(i);
			if(strlen(AConvoys[i][ComboioNome]) > 0)
			    format(NomeQ, 20, AConvoys[i][ComboioNome]);
			else
			    format(NomeQ, 20, "[Sem Nome]");
            switch (AConvoys[i][Status]) {
				case CONVOY_OPEN: format(ConvoyStatus, 10, "Aberto");
				case CONVOY_FULL: format(ConvoyStatus, 10, "Cheio");
				case CONVOY_CLOSED: format(ConvoyStatus, 10, "Fechado");
			}
			format(ConvoyList, sizeof(ConvoyList), "%s%s\t%s\t%i\t%s\n", ConvoyList, NomeQ, GetUserName(AConvoys[i][Members][0]), NumMembers, ConvoyStatus);
		}
    }
 	ShowPlayerDialog(playerid, SelectConvoy, DIALOG_STYLE_TABLIST_HEADERS, "Selecione o comboio:", ConvoyList, "Selecionar", "Cancelar");
	return 1;
}

CMD:saircomboio(playerid)
{
	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != CAMINHONEIRO)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte desta profissão.");

	if(Jogador[playerid][InConvoy] == true) {
		Convoy_Leave(playerid);
		SendClientMessage(playerid, COR_AVISO, "| COMBOIO | Você saiu do comboio.");
	}
	return true;
}

Dialog:SelectConvoy(playerid, response, listitem, inputtext[])
{
	if(!response) return 1;

	new Convoy;
	Convoy = listitem;

	switch (AConvoys[Convoy][Status])
	{

		case CONVOY_EMPTY: 
		{
			Convoy_Create(playerid, Convoy); 
		}
		case CONVOY_OPEN:
		{
			if(strlen(AConvoys[Convoy][SenhaComboio]) > 1)
			{
				SetPVarInt(playerid, "ComboioPass", Convoy);
				return ShowPlayerDialog(playerid, DialogSenhaComboio, DIALOG_STYLE_PASSWORD, "Senha do comboio", "Digite a senha definida pelo líder do comboio:", "Ok", "Cancelar");
			}
			
			Convoy_Join(playerid, Convoy); 
		}
		case CONVOY_FULL: 
		{

			SendClientMessage(playerid, COR_ERRO, "| ERRO | O comboio está cheio!");
		}
		case CONVOY_CLOSED:
		{

			SendClientMessage(playerid, COR_ERRO, "| ERRO | Este comboio já tem um destino, você não pode entrar nele agora.");
		}
	}

	return 1;
}