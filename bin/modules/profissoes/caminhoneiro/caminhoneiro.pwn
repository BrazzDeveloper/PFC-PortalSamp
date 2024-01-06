

Trucker_EnterCheckpoint(playerid) {
	if ( GetPlayerVehicleID(playerid) == Jogador[playerid][VehicleID]) {
		if(Jogador[playerid][TrailerID] == GetVehicleTrailer(GetPlayerVehicleID(playerid))) {
			switch ( Jogador[playerid][JobStep] )
			{
				case 1: MostrarDrawTela(playerid, 5000, "~g~Carregando~n~_", "Por favor, aguarde..");
				case 2, 3: MostrarDrawTela(playerid, 5000, "~r~Descarregando~n~_", "Por favor, aguarde...");
			}
			TogglePlayerControllable(playerid, false);
			if(Jogador[playerid][LoadingTimer] == 0)
				Jogador[playerid][LoadingTimer] = SetTimerEx("Trucker_LoadUnLoad", 4000, false, "d", playerid);
		}
		else
			SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar com o seu trailer atrelado para proseguir!");
	}
	else
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa setar no seu veículo para proseguir!");
	return true;
}

forward Trucker_LoadUnLoad(playerid);
public Trucker_LoadUnLoad(playerid)
{
	if(Jogador[playerid][LoadingTimer] != 0)
		KillTimer(Jogador[playerid][LoadingTimer]);

	Jogador[playerid][LoadingTimer] = 0;
	DisablePlayerCheckpoint(playerid);

	if ( Jogador[playerid][InConvoy] == true )
	{
		if(Jogador[playerid][JobStep] == 1) 
		{
			Jogador[playerid][JobStep] = 2;
			GameTextForPlayer(playerid, "Aguardando todos os membros do comboio carregarem..", 4000, 4);
		}
		if(Jogador[playerid][JobStep] == 3)
		{
			Jogador[playerid][JobStep] = 4;
			GameTextForPlayer(playerid, "Aguardando todos os membros do comboio descarregarem..", 4000, 4);
		}
		TogglePlayerControllable(playerid, true);
		return 1;
	}
	switch(Jogador[playerid][JobStep])
	{
		case 1:
		{
			Jogador[playerid][JobStep] = 2;

			Trucker_SetRandomOverloaded(playerid);

			if ( Jogador[playerid][Overloaded] == true)
				SendClientMessage(playerid, COR_AMARELO, "| INFO | Você está sobrecarregado!");

			// Colocar pra mafia conseguir ver

			SetPlayerCheckpoint(playerid, ALocations[Jogador[playerid][JobLoc2]][LocX], ALocations[Jogador[playerid][JobLoc2]][LocY], ALocations[Jogador[playerid][JobLoc2]][LocZ], 7);
			SendClientMessage(playerid, COR_BRANCO, "| ENTREGA | Seu Trailer foi carregado com {"COR_AZUL_INC"}%s {ffffff}para {"COR_VERDE_INC"}%s", ALoads[Jogador[playerid][LoadID]][LoadName], ALocations[Jogador[playerid][JobLoc2]][LocationName]);
		}
		case 2:
		{
			//new TempoTotal, Minutos, Segundos, Float:Distance, Message[500], Payment, Bonus, Preju, Bonus2, Bonus3;

			new TempoTotal, Minutos, Float:Distance, Payment, Bonus, Preju, Bonus2, Bonus3;

			TempoTotal = gettime() - Jogador[playerid][TrabalhoTempo];

			if(TempoTotal >= 60) {
                Minutos = TempoTotal / 60;
                TempoTotal = TempoTotal - (Minutos * 60);
            }
            //Segundos = TempoTotal;

            //format(Msg1, 144, "{FF8000}%s caminhoneir%s %s {FFFFFF}%s {FF8000}transportou {FFFFFF}%s{FF8000}.", (Jogador[playerid][Sexo] == SEXO_FEMININO) ? ("A") : ("O"), (Jogador[playerid][Sexo] == SEXO_FEMININO) ? ("a") : ("o"), RankingTruck[Jogador[playerid][RankTruck]], Jogador[playerid][PlayerName], ALoads[Jogador[playerid][LoadID]][LoadName]);
            //format(Msg2, 144, "{FF8000}De: {FFFFFF}%s {FF8000}Para: {FFFFFF}%s{FF8000} em %i min(s) e %i seg(s).", ALocations[Jogador[playerid][JobLoc1]][LocationName], ALocations[Jogador[playerid][JobLoc2]][LocationName], Minutos, Segundos);


            Distance = GetPointDistanceToPointEx(ALocations[Jogador[playerid][JobLoc1]][LocX],ALocations[Jogador[playerid][JobLoc1]][LocY],ALocations[Jogador[playerid][JobLoc1]][LocZ],ALocations[Jogador[playerid][JobLoc2]][LocX],ALocations[Jogador[playerid][JobLoc2]][LocY],ALocations[Jogador[playerid][JobLoc2]][LocZ]);
			Payment = floatround((Distance * ALoads[Jogador[playerid][LoadID]][PayPerUnit]), floatround_floor);

			//format(Message, sizeof(Message), "realizou o trabalho como caminhoneiro em %02d:%02d e recebeu R$%i (distância %4.2fm)", Minutos, Segundos, Payment, Distance);
            
            //RegistrarAtividade(Jogador[playerid][PlayerID], "Trabalho", Message);

            if(Jogador[playerid][Vip] == false)
            {
            	RewardPlayer(playerid, Payment);
            	Bonus2 = (Payment * 4) / 100;
            	SendClientMessage(playerid, COR_BRANCO, "| ENTREGA | Você finalizou seu trabalho recebeu {"COR_VERDE_INC"}R$%s", RealStr(Payment));

            	if(Distance > 1500.0)
            		RewardPlayer(playerid, Bonus2);
            }
            else
            {
            	Bonus3 = (Payment * 4) / 100;
            	Bonus = (Payment * 7) / 100;
            	RewardPlayer(playerid, Payment);
            	SendClientMessage(playerid, COR_BRANCO, "| ENTREGA | Você finalizou seu trabalho recebeu {"COR_VERDE_INC"}R$%s", RealStr(Payment));

            	//SendClientMessage(playerid, COR_BRANCO, "| ENTREGA | Você recebeu um bonus de 20%% ({"COR_VERDE_INC"}R$%s{ffffff}) por ser VIP!", RealStr(Bonus));
            	SendClientMessage(playerid, COR_BRANCO, "| ENTREGA | Você recebeu ( {"COR_VERDE_INC"}R$%s {ffffff}) de bônus por ser um(a) jogador(a) {"COR_LARANJA_INC"}VIP {ffffff}no servidor", RealStr(Bonus));
            	RewardPlayer(playerid, Bonus);
            }

            if(Jogador[playerid][DanoCarga] > 0.0) {
            	Preju = (floatround(Jogador[playerid][DanoCarga])) * 2;
            	/*if(TrailerVida < 1000.0 && IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
            	    Preju += (100 - floatround(TrailerVida / 10)) * 20;*/
            	RewardPlayer(playerid, -Preju);
				SendClientMessage(playerid, COR_ERRO, "| ENTREGA | {ffffff}Houve danos durante o transporte, você teve o prejuízo de {"COR_VERMELHO_INC"}R$%s\n", RealStr(Preju));
            }

            if (Distance > 3000.0)
				RewardPlayer(playerid, Bonus3);

			Jogador[playerid][TempoComando][10] = gettime() + (60 * 10);

			Trucker_EndJob(playerid);
		}
	}
	TogglePlayerControllable(playerid, 1);
	return 1;
}

Trucker_SetRandomOverloaded(playerid)
{
	switch (GetVehicleModel(GetPlayerVehicleID(playerid)))
	{
		case VehicleCementTruck: return 0;
		case VehicleLineRunner, VehicleTanker, VehicleRoadTrain:
		{
			if (GetVehicleModel(GetVehicleTrailer(GetPlayerVehicleID(playerid))) == VehicleTrailerFluids) return 0;
		}
	}
	return 1;
}
Trucker_StartRandomJob(playerid)
{
	if (Trucker_SetRandomJob(playerid) != 0) return dialogoConfirmarTrabalho(playerid);
	return 1;
}
Trucker_SetRandomJob(playerid)
{
	if (GetPlayerVehicleSeat(playerid) == 0)
	{
		switch (GetVehicleModel(GetPlayerVehicleID(playerid)))
		{
			case VehicleFlatbed, VehicleDFT30, VehicleYankee, VehicleRumpo, VehicleYosemite:
				return Trucker_SetRandomJobData(playerid, PCV_TruckerNoTrailer);
			case VehicleCementTruck:
				return Trucker_SetRandomJobData(playerid, PCV_TruckerCementTruck);
			case VehicleLineRunner, VehicleTanker, VehicleRoadTrain:
			{
				switch (GetVehicleModel(GetVehicleTrailer(GetPlayerVehicleID(playerid))))
				{
					case VehicleTrailerCargo, VehicleTrailerCargo2:
						return Trucker_SetRandomJobData(playerid, PCV_TruckerCargoTrailer);
					case VehicleTrailerOre:
						return Trucker_SetRandomJobData(playerid, PCV_TruckerOreTrailer);
					case VehicleTrailerFluids:
						return Trucker_SetRandomJobData(playerid, PCV_TruckerFluidsTrailer);
				}
			}
		}
	}
	return 0;
}
Trucker_SetRandomJobData(playerid, PCV_Needed)
{
    Jogador[playerid][LoadID] = Product_GetRandom(PCV_Needed);
    Jogador[playerid][JobLoc1] = Product_GetRandomStartLoc(Jogador[playerid][LoadID]);
    Jogador[playerid][JobLoc2] = Product_GetRandomEndLoc(Jogador[playerid][LoadID]);
    if(Jogador[playerid][JobLoc1] == Jogador[playerid][JobLoc2]) return SendClientMessage(playerid, COR_ERRO, "| ERRO | Seu trabalho não pode ser iniciado pois o local de carga é o mesmo de descarga. Relate para a administração este problema.");
	Jogador[playerid][VehicleID] = GetPlayerVehicleID(playerid);
	Jogador[playerid][TrailerID] = GetVehicleTrailer(GetPlayerVehicleID(playerid));
	return 1;
}

Trucker_EndJob(playerid)
{
	if (Jogador[playerid][JobStarted] == true)
	{
        DisablePlayerCheckpoint(playerid);
        Jogador[playerid][JobStarted] = false;
		Jogador[playerid][JobStep] = 0;
		Jogador[playerid][VehicleTimerTime] = 0;
		Jogador[playerid][VehicleID] = 0;
		Jogador[playerid][TrailerID] = 0;
		Jogador[playerid][LoadID] = 0;
		Jogador[playerid][JobLoc1] = 0;
		Jogador[playerid][JobLoc2] = 0;
		//Jogador[playerid][MafiaLoad] = false;
		if(Jogador[playerid][LoadingTimer] != 0)
			KillTimer(Jogador[playerid][LoadingTimer]);
        Jogador[playerid][LoadingTimer] = 0;
        Jogador[playerid][DanoCarga] = 0.0;
        /*if (Jogador[playerid][Overloaded] == true)
		{
		    Jogador[playerid][Overloaded] = false;
            if(GetPVarInt(playerid, "balanca_vezes") > 0) {
                new vPro, vMulta;
                vPro = 2 * GetPVarInt(playerid, "balanca_vezes");
                vMulta = 1000 * GetPVarInt(playerid, "balanca_vezes");
    			if (Jogador[playerid][Procurado] >= vPro)
                    Jogador[playerid][Procurado] -= vPro;
                if(Jogador[playerid][ValorMulta] >= vMulta)
                    Jogador[playerid][ValorMulta] -= vMulta;
            }
		}
        DeletePVar(playerid, "balanca_vezes");*/
        /*SumirInfoTrabalho(playerid);
        RankPlayer(playerid);
        AtualizarLabelJogador(playerid);
        PlayerFile_Save(playerid);*/
	}
    Jogador[playerid][TrabalhoTempo] = 0;
	return 1;
}

Dialog:TruckerJobMethod(playerid, response, listitem)
{
	new ProductList[50], NumProducts, TotalLoadList[1000];
	if(!response) return 1;
	switch (listitem)
	{
		case 0:
		{
			switch (GetVehicleModel(GetPlayerVehicleID(playerid)))
			{
				case VehicleFlatbed, VehicleDFT30, VehicleYankee, VehicleYosemite, VehicleRumpo:
					ProductList = Product_GetList(PCV_TruckerNoTrailer, NumProducts);
                case VehicleCementTruck:
	                ProductList = Product_GetList(PCV_TruckerCementTruck, NumProducts);
                case VehicleLineRunner, VehicleTanker, VehicleRoadTrain:
				{
					switch (GetVehicleModel(GetVehicleTrailer(GetPlayerVehicleID(playerid))))
					{
						case VehicleTrailerCargo, VehicleTrailerCargo2:
							ProductList = Product_GetList(PCV_TruckerCargoTrailer, NumProducts);
                        case VehicleTrailerOre:
	                        ProductList = Product_GetList(PCV_TruckerOreTrailer, NumProducts);
                        case VehicleTrailerFluids:
	                        ProductList = Product_GetList(PCV_TruckerFluidsTrailer, NumProducts);
     				}
				}
			}
			for (new i; i < NumProducts; i++) {
                strcat(TotalLoadList, ALoads[ProductList[i]][LoadName]);
                if(ALoads[ProductList[i]][LoadTime] > 0) {
                    if(ALoads[ProductList[i]][LoadTime] > gettime()) {
                        static tt[6],str[30];
                        gm_timestamp_to_date(ALoads[ProductList[i]][LoadTime], tt[0], tt[1], tt[2], tt[3], tt[4], tt[5]);
                        format(str, sizeof(str), "\t[EXPIRA EM %02d/%02d/%d]", tt[5], tt[4], tt[3]);
                        strcat(TotalLoadList, str);
                    }
                    else
                        strcat(TotalLoadList, "\t[EXPIRADA]");
                }
                strcat(TotalLoadList, "\n");
            }
            ShowPlayerDialog(playerid, TruckerSelectLoad, DIALOG_STYLE_LIST, "Selecione a carga:", TotalLoadList, "Selecionar", "Cancelar");
		}
		case 1: Trucker_StartRandomJob(playerid);
        /*case 2:
        {
            if(RandomBonusMission[MissionFinished] == false && RandomBonusMission[RandomLoad] != 0)
            {
                new InfBonus[500], Requer[200], Inf1[50], Inf2[50], Inf3[50];
                switch(ALoads[RandomBonusMission[RandomLoad]][PCV_Required])
	            {
		            case PCV_TruckerOreTrailer: format(Requer, 200, "Caminhão {a9c4e4}com {ffffff}Trailer de minério");
		            case PCV_TruckerFluidsTrailer: format(Requer, 200, "Caminhão {a9c4e4}com {ffffff}Trailer de fluídos");
		            case PCV_TruckerCargoTrailer: format(Requer, 200, "Caminhão {a9c4e4}com {ffffff}Trailer baú");
		            case PCV_TruckerCementTruck: format(Requer, 200, "Caminhão de cimento");
		            case PCV_TruckerNoTrailer: format(Requer, 200, "Flatbed {a9c4e4}, {ffffff}DFT-30 {a9c4e4}ou {ffffff}Yankee");
                }
                format(Inf1, 50, ALoads[RandomBonusMission[RandomLoad]][LoadName]);
	            format(Inf2, 50, ALocations[RandomBonusMission[RandomStartLoc]][LocationName]);
	            format(Inf3, 50, ALocations[RandomBonusMission[RandomEndLoc]][LocationName]);

                format(InfBonus, 500, "%s{a9c4e4}A rota bonus é transportar {ffffff}%s\n", InfBonus, Inf1);
                format(InfBonus, 500, "%s{a9c4e4}de {ffffff}%s {a9c4e4}até {ffffff}%s\n", InfBonus, Inf2, Inf3);
                format(InfBonus, 500, "%s{a9c4e4}e para completar essa missão, tenha um {ffffff}%s\n", InfBonus, Requer);
                format(InfBonus, 500, "%s{a9c4e4}Clique em Iniciar para iniciar a missão bonus.\n", InfBonus);
                ShowPlayerDialog(playerid, DialogRotaBonus, DIALOG_STYLE_MSGBOX, "Rota Bonus", InfBonus, "Iniciar Rota", "Cancelar");
            }
            else
                SendClientMessage(playerid, 0xff0000ff, "Não foi possivel ver a missão bonus.");
        }
        case 3: {
            if(Jogador[playerid][UltimaRota][0] == 0) return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem uma última rota salva no atual momento. Faça uma rota, e ela ficará salva (temporariamente).");
			switch (ALoads[Jogador[playerid][UltimaRota][0]][PCV_Required]) {
				case PCV_TruckerOreTrailer:  if(GetVehicleModel(GetVehicleTrailer(GetPlayerVehicleID(playerid))) != VehicleTrailerOre) return SCM(playerid, "{ff0000}Esteja com o trailer da rota!");
                case PCV_TruckerCargoTrailer:  if(GetVehicleModel(GetVehicleTrailer(GetPlayerVehicleID(playerid))) != VehicleTrailerCargo && GetVehicleModel(GetVehicleTrailer(GetPlayerVehicleID(playerid))) != VehicleTrailerCargo2) return SCM(playerid, "{ff0000}Esteja com o trailer da rota!");
                case PCV_TruckerFluidsTrailer: if(GetVehicleModel(GetVehicleTrailer(GetPlayerVehicleID(playerid))) != VehicleTrailerFluids) return SCM(playerid, "{ff0000}Esteja com o trailer da rota!");
                case PCV_TruckerCementTruck:  if(GetVehicleModel(GetPlayerVehicleID(playerid)) != VehicleCementTruck) return SCM(playerid, "{ff0000}Esteja com o caminhão de cimento!");
                case PCV_TruckerNoTrailer: {}
				default: return SCM(playerid, "{ff0000}Sua ultima não é para caminhoneiro!");
			}
            if(ALoads[Jogador[playerid][UltimaRota][0]][LoadTime] < gettime() && ALoads[Jogador[playerid][UltimaRota][0]][LoadTime] > 0) return SendClientMessage(playerid, COR_ERRO, "| ERRO | Infelizmente esta rota já expirou.");
            new LoadMsg[144];
			Jogador[playerid][LoadID] = Jogador[playerid][UltimaRota][0];
			Jogador[playerid][JobLoc1] = Jogador[playerid][UltimaRota][1];
			Jogador[playerid][JobLoc2] = Jogador[playerid][UltimaRota][2];

			Jogador[playerid][JobStarted] = true;
			Jogador[playerid][VehicleID] = GetPlayerVehicleID(playerid);
			Jogador[playerid][TrailerID] = GetVehicleTrailer(GetPlayerVehicleID(playerid));
			Jogador[playerid][JobStep] = 1;

			SetPlayerCheckpoint(playerid, ALocations[Jogador[playerid][JobLoc1]][LocX], ALocations[Jogador[playerid][JobLoc1]][LocY], ALocations[Jogador[playerid][JobLoc1]][LocZ], 7);
			Jogador[playerid][VehicleTimerTime] = gettime() + Job_TimeToFailMission;
			format(LoadMsg, sizeof(LoadMsg), "{D9DCE9}Carga: {FFFFFF}%s   {D9DCE9}Local de carregamento: {FFFFFF}%s", ALoads[Jogador[playerid][LoadID]][LoadName], ALocations[Jogador[playerid][JobLoc1]][LocationName]);
			SendClientMessage(playerid, 0xFFFFFFFF, LoadMsg);
		    AtualizarLabelJogador(playerid);
		    Jogador[playerid][TrabalhoTempo] = gettime();

            if(Jogador[playerid][AparecerInfosTrabalho][0] == true)
    			for(new i; i < 2; i++) {
                    PlayerTextDrawSetString(playerid, Jogador[playerid][TrabalhoDraw][i], "_");
                	PlayerTextDrawShow(playerid, Jogador[playerid][TrabalhoDraw][i]);
                }

		}
        case 4: SelecionarClubeTrabalho(playerid, 1);*/
    }

	return 1;
}

Dialog:TruckerSelectLoad(playerid, response, listitem, inputtext[])
{
	new TotalStartLocList[2000], ProductList[100], NumProducts, ProductID, LocID;
	if(!response) return ShowPlayerDialog(playerid, TruckerJobMethod, DIALOG_STYLE_LIST, "{ffffff}Selecione o método:", "{ffffff}Configurar sua própria carga e rota\r\nAtribuir auto-carga", "Selecionar", "Cancelar");
	switch (GetVehicleModel(GetPlayerVehicleID(playerid)))
	{
		case VehicleFlatbed, VehicleDFT30, VehicleYankee, VehicleYosemite, VehicleRumpo:
			ProductList = Product_GetList(PCV_TruckerNoTrailer, NumProducts);
		case VehicleCementTruck:
			ProductList = Product_GetList(PCV_TruckerCementTruck, NumProducts);
		case VehicleLineRunner, VehicleTanker, VehicleRoadTrain:
		{
			switch (GetVehicleModel(GetVehicleTrailer(GetPlayerVehicleID(playerid))))
			{
				case VehicleTrailerCargo, VehicleTrailerCargo2:
					ProductList = Product_GetList(PCV_TruckerCargoTrailer, NumProducts);
				case VehicleTrailerOre:
					ProductList = Product_GetList(PCV_TruckerOreTrailer, NumProducts);
				case VehicleTrailerFluids:
					ProductList = Product_GetList(PCV_TruckerFluidsTrailer, NumProducts);
			}
		}
	}
    if(ALoads[ProductList[listitem]][LoadTime] < gettime() && ALoads[ProductList[listitem]][LoadTime] > 0) return SendClientMessage(playerid, COR_ERRO, "| ERRO | Infelizmente esta rota já expirou.");
	Jogador[playerid][LoadID] = ProductList[listitem];
	ProductID = Jogador[playerid][LoadID];
    for (new i; i < 75; i++)
	{
        if(ALoads[ProductID][fLo][i] == false) continue;
        LocID = ALoads[ProductID][FromLocations][i];
	    if (LocID != 0)
			format(TotalStartLocList, sizeof(TotalStartLocList), "{ffffff}%s%s\t%4.2fm\n", TotalStartLocList, ALocations[LocID][LocationName], GetPlayerDistanceFromPoint(playerid, ALocations[LocID][LocX], ALocations[LocID][LocY], ALocations[LocID][LocZ]));
		else
		    break;
	}
    if(strlen(TotalStartLocList) == 0) return SendClientMessage(playerid, COR_ERRO, "| ERRO | Sem locais para carregar ou descarregar.");
    format(TotalStartLocList, sizeof(TotalStartLocList), "{ffffff}Local\t{ffffff}Distância\n%s", TotalStartLocList);
    ShowPlayerDialog(playerid, TruckerSelectStartLoc, DIALOG_STYLE_TABLIST_HEADERS, "{ffffff}Selecione o ponto de carregamento:", TotalStartLocList, "Selecionar", "Cancelar");
	return 1;
}

Dialog:TruckerSelectStartLoc(playerid, response, listitem, inputtext[])
{
	new ProductID, LocID, TotalEndLocList[2000];
	if(!response)
    {
	    new ProductList[50], NumProducts, TotalLoadList[1000];
        switch (GetVehicleModel(GetPlayerVehicleID(playerid)))
	    {
			case VehicleFlatbed, VehicleDFT30, VehicleYankee, VehicleYosemite, VehicleRumpo:
				ProductList = Product_GetList(PCV_TruckerNoTrailer, NumProducts);
            case VehicleCementTruck:
	            ProductList = Product_GetList(PCV_TruckerCementTruck, NumProducts);
            case VehicleLineRunner, VehicleTanker, VehicleRoadTrain:
		    {
				switch (GetVehicleModel(GetVehicleTrailer(GetPlayerVehicleID(playerid))))
				{
					case VehicleTrailerCargo, VehicleTrailerCargo2:
						ProductList = Product_GetList(PCV_TruckerCargoTrailer, NumProducts);
                    case VehicleTrailerOre:
	                    ProductList = Product_GetList(PCV_TruckerOreTrailer, NumProducts);
                    case VehicleTrailerFluids:
	                    ProductList = Product_GetList(PCV_TruckerFluidsTrailer, NumProducts);
     			}
			}
		}
        if(NumProducts == 0) return SendClientMessage(playerid, COR_ERRO, "| ERRO | Nenhum produto encontrado!");
        for (new i; i < NumProducts; i++)
        {
            strcat(TotalLoadList, ALoads[ProductList[i]][LoadName]);
            if(ALoads[ProductList[i]][LoadTime] > 0) {
                if(ALoads[ProductList[i]][LoadTime] > gettime()) {
                    static tt[6],str[30];
                    gm_timestamp_to_date(ALoads[ProductList[i]][LoadTime], tt[0], tt[1], tt[2], tt[3], tt[4], tt[5]);
                    format(str, sizeof(str), "\t[EXPIRA EM %02d/%02d/%d]", tt[5], tt[4], tt[3]);
                    strcat(TotalLoadList, str);
                }
                else
                    strcat(TotalLoadList, "\t[EXPIRADA]");
            }
            strcat(TotalLoadList, "\n");
        }
        return ShowPlayerDialog(playerid, TruckerSelectLoad, DIALOG_STYLE_LIST, "{ffffff}Selecione a carga:", TotalLoadList, "Selecionar", "Cancelar");
    }
    ProductID = Jogador[playerid][LoadID];
    for(new i, op = 0; i < 75; i++) {  // Verificação e OK
        if(ALoads[ProductID][fLo][i] == false) continue;
        if(listitem == op) {
            Jogador[playerid][JobLoc1] = ALoads[ProductID][FromLocations][i];
            break;
        }
        else
            op++;
    }
	for (new i; i < 75; i++)
	{
        if(ALoads[ProductID][tLo][i] == false) continue;
        LocID = ALoads[ProductID][ToLocations][i];
	    if (LocID != 0)
			format(TotalEndLocList, sizeof(TotalEndLocList), "%s%s\t%4.2fm\n", TotalEndLocList, ALocations[LocID][LocationName], GetPlayerDistanceFromPoint(playerid, ALocations[LocID][LocX], ALocations[LocID][LocY], ALocations[LocID][LocZ]));
		else
		    break;
	}
    if(strlen(TotalEndLocList) == 0) return SendClientMessage(playerid, COR_ERRO, "| ERRO | Sem locais para carregar ou descarregar.");
    format(TotalEndLocList, sizeof(TotalEndLocList), "{ffffff}Local\t{ffffff}Distância\n%s", TotalEndLocList);
    return ShowPlayerDialog(playerid, TruckerSelectEndLoc, DIALOG_STYLE_TABLIST_HEADERS,  "{ffffff}Selecione o ponto de descarga:", TotalEndLocList, "Selecionar", "Cancelar");
}

Dialog:TruckerSelectEndLoc(playerid, response, listitem, inputtext[])
{
	new ProductID;
	if(!response)
    {
	    new ProductList[50], NumProducts, TotalLoadList[1000];
        switch (GetVehicleModel(GetPlayerVehicleID(playerid)))
	    {
			case VehicleFlatbed, VehicleDFT30, VehicleYankee, VehicleYosemite, VehicleRumpo:
				ProductList = Product_GetList(PCV_TruckerNoTrailer, NumProducts);
            case VehicleCementTruck:
	            ProductList = Product_GetList(PCV_TruckerCementTruck, NumProducts);
            case VehicleLineRunner, VehicleTanker, VehicleRoadTrain:
		    {
				switch (GetVehicleModel(GetVehicleTrailer(GetPlayerVehicleID(playerid))))
				{
					case VehicleTrailerCargo, VehicleTrailerCargo2:
						ProductList = Product_GetList(PCV_TruckerCargoTrailer, NumProducts);
                    case VehicleTrailerOre:
	                    ProductList = Product_GetList(PCV_TruckerOreTrailer, NumProducts);
                    case VehicleTrailerFluids:
	                    ProductList = Product_GetList(PCV_TruckerFluidsTrailer, NumProducts);
     			}
			}
		}
        if(NumProducts == 0) return SendClientMessage(playerid, COR_ERRO, "| ERRO | Nenhum produto encontrado!");
        for (new i; i < NumProducts; i++)
        {
            strcat(TotalLoadList, ALoads[ProductList[i]][LoadName]);
            if(ALoads[ProductList[i]][LoadTime] > 0) {
                if(ALoads[ProductList[i]][LoadTime] > gettime()) {
                    static tt[6],str[30];
                    gm_timestamp_to_date(ALoads[ProductList[i]][LoadTime], tt[0], tt[1], tt[2], tt[3], tt[4], tt[5]);
                    format(str, sizeof(str), "\t[EXPIRA EM %02d/%02d/%d]", tt[5], tt[4], tt[3]);
                    strcat(TotalLoadList, str);
                }
                else
                    strcat(TotalLoadList, "\t[EXPIRADA]");
            }
            strcat(TotalLoadList, "\n");
        }
 		return ShowPlayerDialog(playerid, TruckerSelectLoad, DIALOG_STYLE_LIST, "{ffffff}Selecione a carga:", TotalLoadList, "Selecionar", "Cancelar");
    }
    ProductID = Jogador[playerid][LoadID];
    for(new i, op = 0; i < 75; i++) {  // Verificação e OK
        if(ALoads[ProductID][tLo][i] == false) continue;
        if(listitem == op) {
            Jogador[playerid][JobLoc2] = ALoads[ProductID][ToLocations][i];
            break;
        }
        else
            op++;
    }
    if(Jogador[playerid][JobLoc1] == Jogador[playerid][JobLoc2]) return SendClientMessage(playerid, COR_ERRO, "| ERRO | Seu trabalho não pode ser iniciado pois o local de carga é o mesmo de descarga. Relate para a administração este problema.");
	Jogador[playerid][VehicleID] = GetPlayerVehicleID(playerid);
	Jogador[playerid][TrailerID] = GetVehicleTrailer(GetPlayerVehicleID(playerid));

    dialogoConfirmarTrabalho(playerid);
	return 1;
}

dialogoConfirmarTrabalho(playerid) {
    new Float:Distancia, Msg[400], Pagamento, bool:RotaBonus = false;
    if(RandomBonusMission[MissionFinished] == false && RandomBonusMission[RandomLoad] == Jogador[playerid][LoadID] && RandomBonusMission[RandomStartLoc] == Jogador[playerid][JobLoc1] && RandomBonusMission[RandomEndLoc] == Jogador[playerid][JobLoc2])
    //RotaBonus = true;
    Distancia = GetPointDistanceToPointEx(ALocations[Jogador[playerid][JobLoc1]][LocX],ALocations[Jogador[playerid][JobLoc1]][LocY],ALocations[Jogador[playerid][JobLoc1]][LocZ],ALocations[Jogador[playerid][JobLoc2]][LocX],ALocations[Jogador[playerid][JobLoc2]][LocY],ALocations[Jogador[playerid][JobLoc2]][LocZ]);
    Pagamento = floatround((Distancia * ALoads[Jogador[playerid][LoadID]][PayPerUnit]), floatround_floor);
    if(Jogador[playerid][InConvoy] == true)
    {
        new Bonus, Membros;
        Membros = (Jogador[playerid][InConvoy] == true ? (Convoy_CountMembers(Jogador[playerid][ConvoyID])) : (Convoy_CountMembers(Jogador[playerid][ConvoyID])));
        Bonus = (Membros * 20) + 100;
		Pagamento = (Pagamento * Bonus) / 100;
        format(Msg, sizeof(Msg), "{ffffff}Produto: {"COR_LARANJA_INC"}Produto: %s [Rota em %s]\n{ffffff}Valor estimado para {"COR_ERRO_INC"}%i membros: {"COR_VERDE_INC"}R$%i %s", ALoads[Jogador[playerid][LoadID]][LoadName], (Jogador[playerid][InConvoy] == true ? ("{B18904}comboio") : ("{6A0888}quadrilha")), Membros, (RotaBonus == true ? (Pagamento * 2) : (Pagamento)), (RotaBonus == true ? ("{F7FE2E}(ROTA BONUS)") : ("")));
    }
    else
    	format(Msg, sizeof(Msg), "{ffffff}Produto: {"COR_LARANJA_INC"}%s", ALoads[Jogador[playerid][LoadID]][LoadName]);

    format(Msg, sizeof(Msg), "%s\n\n{ffffff}Local de carregamento: {"COR_VERDE_INC"}%s\n{ffffff}Distância: {"COR_LARANJA_INC"}%4.2fm\n\n{ffffff}Local de descarregamento: {"COR_VERDE_INC"}%s\n{ffffff}Distância: {"COR_LARANJA_INC"}%4.2fm\n\n{ffffff}Distância entre os locais: {"COR_LARANJA_INC"}%4.2fm\n\n{ffffff}Deseja iniciar o trabalho?", Msg,
        ALocations[Jogador[playerid][JobLoc1]][LocationName],GetPlayerDistanceFromPoint(playerid,ALocations[Jogador[playerid][JobLoc1]][LocX],ALocations[Jogador[playerid][JobLoc1]][LocY],ALocations[Jogador[playerid][JobLoc1]][LocZ]),ALocations[Jogador[playerid][JobLoc2]][LocationName],
        GetPlayerDistanceFromPoint(playerid,ALocations[Jogador[playerid][JobLoc2]][LocX],ALocations[Jogador[playerid][JobLoc2]][LocY],ALocations[Jogador[playerid][JobLoc2]][LocZ]),Distancia);
    return ShowPlayerDialog(playerid, ConfirmarTrabalho, DIALOG_STYLE_MSGBOX, "{FFFF00}» {FFFFFF}Confirmar trabalho?", Msg, "Sim", "Não");
}

Dialog:ConfirmarTrabalho(playerid, response, listitem, inputtext[])
{
	if(!response) {
        Jogador[playerid][LoadID] = Jogador[playerid][JobLoc1] = Jogador[playerid][JobLoc2] = Jogador[playerid][VehicleID] = Jogador[playerid][TrailerID] = 0;
        return SendClientMessage(playerid, COR_AVISO, "| INFO | Você desistiu do trabalho.");
    }
    //new LoadMsg[144];
    //Jogador[playerid][UltimaRota][0] = Jogador[playerid][LoadID];
    //Jogador[playerid][UltimaRota][1] = Jogador[playerid][JobLoc1];
    //Jogador[playerid][UltimaRota][2] = Jogador[playerid][JobLoc2];
    Jogador[playerid][TrabalhoTempo] = gettime();
    Jogador[playerid][JobStarted] = true;
    Jogador[playerid][JobStep] = 1;
    Jogador[playerid][VehicleTimerTime] = gettime() + Job_TimeToFailMission;
    SetPlayerCheckpoint(playerid, ALocations[Jogador[playerid][JobLoc1]][LocX], ALocations[Jogador[playerid][JobLoc1]][LocY], ALocations[Jogador[playerid][JobLoc1]][LocZ], 7);
    //format(LoadMsg, sizeof(LoadMsg), "{D9DCE9}Carga: {FFFFFF}%s   {D9DCE9}Local de carregamento: {FFFFFF}%s", ALoads[Jogador[playerid][LoadID]][LoadName], ALocations[Jogador[playerid][JobLoc1]][LocationName]);
	//SendClientMessage(playerid, 0xFFFFFFFF, LoadMsg);
    SendClientMessage(playerid, COR_BRANCO, "| ENTREGA | Vá até {"COR_VERDE_INC"}%s {ffffff}para carregar {"COR_LARANJA_INC"}%s", ALocations[Jogador[playerid][JobLoc1]][LocationName], ALoads[Jogador[playerid][LoadID]][LoadName]);
	return 1;
}

CMD:carregarc(playerid, params[])
{
	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) != CAMINHONEIRO)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte desta profissão.");

	if(Jogador[playerid][JobStarted] == true)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Finalize primeiro seu trabalho para iniciar outro.");

	new Convoy = Jogador[playerid][ConvoyID];
	if ((Jogador[playerid][InConvoy] == true) && (AConvoys[Convoy][Members][0] != playerid)) 
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é o líder do comboio e não pode iniciar um carregamento.");

	if (GetPlayerVehicleSeat(playerid) != 0) 
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é o(a) motorista");

	if(Jogador[playerid][InConvoy] == true && Convoy_CountMembers(Convoy) == 1) 
		return SendClientMessage(playerid, COR_ERRO, "| ERRO |Você não pode iniciar o comboio sozinho(a)!");

	switch (GetVehicleModel(GetPlayerVehicleID(playerid)))
	{
		case VehicleFlatbed, VehicleDFT30, VehicleYankee, VehicleYosemite, VehicleRumpo:
        {
    		//if (Jogador[playerid][TruckerLicense] == true)
			ShowPlayerDialog(playerid, TruckerJobMethod, DIALOG_STYLE_LIST, "{ffffff}Selecione o método:", "{ffffff}Configurar sua própria carga e rota\r\nAtribuir auto-carga", "Selecionar", "Cancelar");
			//else
	    	//    Trucker_StartRandomJob(playerid);
        }
        case VehicleCementTruck: {
    		//if (Jogador[playerid][TruckerLicense] == true)
			ShowPlayerDialog(playerid, TruckerJobMethod, DIALOG_STYLE_LIST, "{ffffff}Selecione o método:", "{ffffff}Configurar sua própria carga e rota\r\nAtribuir auto-carga", "Selecionar", "Cancelar");
			//else
	    	//    Trucker_StartRandomJob(playerid);
        }
        case VehicleLineRunner, VehicleTanker, VehicleRoadTrain:
        {
        	if(!IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid))) return SendClientMessage(playerid, 0xFF0000FF, "Você precisa de um trailer para iniciar o trabalho.");
			//if (Jogador[playerid][TruckerLicense] == true)
			ShowPlayerDialog(playerid, TruckerJobMethod, DIALOG_STYLE_LIST, "{ffffff}Selecione o método:", "{ffffff}Configurar sua própria carga e rota\r\nAtribuir auto-carga", "Selecionar", "Cancelar");
			//else
			//    Trucker_StartRandomJob(playerid);
		}
        default: return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esteja conduzindo um caminhão para iniciar um trabalho!");
	}

	return true;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(call::PLAYER->GetPlayerVarInt(playerid, Profissao) == CAMINHONEIRO)
		Trucker_EnterCheckpoint(playerid);
	return true;
}