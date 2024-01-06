#include <YSI_Coding\y_hooks>

//new CodigoReal[MAX_PLAYERS][128];

hook OnGameModeInit()
{
	SetTimer("OnTimeOneSeconds", 1000, true); // Timer de um segundo.
	SetTimer("AFKTimer", 1000, true);
}

forward AFKTimer();
public AFKTimer()
{
	new _str[200];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(call::PLAYER->IsPlayerLogged(i))
		{
			if(playerLastComand[i] < (GetTickCount() - 600000) && !Jogador[i][AFK])
			{
				TogglePlayerControllable(i, false);
				Jogador[i][AFK] = true;
				new randAFK = random(sizeof(RandomCODE_AFK));
				Code@AFK[i] = RandomCODE_AFK[randAFK];
				format(_str, sizeof(_str), "Digite /SairAFK: ~y~%s", Code@AFK[i]);
				PlayerTextDrawSetString(i, TD@AFK[i][1], _str);
				for(new t = 0; t < 2; t++) { PlayerTextDrawShow(i, TD@AFK[i][t]); }
			}
		}
	}
	return 1;
}

hook OnTimeOneSecondsPlayer(playerid)
{
	if( call::PLAYER->IsPlayerLogged(playerid) )
	{
		/*if(Jogador[playerid][VerificarAFK] < gettime())
		{
			new Float:PosX, Float:PosY, Float:PosZ;
			GetPlayerPos(playerid, PosX, PosY, PosZ);
			if(!floatcmp(PosX, Jogador[playerid][AFK_X]) && !floatcmp(PosY, Jogador[playerid][AFK_Y]))
			{
				++Jogador[playerid][AFK_Avisos];
				if(Jogador[playerid][AFK_Avisos] >= 3){
					SendClientMessage(playerid, COR_ERRO, "| ANTI-AFK | Você foi kickado por ficar ausente!"), OcultarAntiAFK(playerid);
					Kick(playerid);
				}
				else if(Jogador[playerid][AFK_Avisos] == 2){
					Jogador[playerid][AFK] = true;
					format(CodigoReal[playerid], 128, GetRandomString(5));
                    MostrarAntiAFK(playerid);
                    PadraoRandom(playerid, CodigoReal[playerid]);
				}
			}else{
				if(!Jogador[playerid][AFK])
					Jogador[playerid][AFK_Avisos] = 0;
			}
			Jogador[playerid][AFK_X] = PosX;
			Jogador[playerid][AFK_Y] = PosY;
			Jogador[playerid][VerificarAFK] = gettime() + 180;
		}*/

		//if( !GetPlayerAFK(playerid) )
		//{
		if( Jogador[playerid][AFK] == false)
		{
			if( call::ADMIN->IsAdminInJob(playerid) )
			{
				++Jogador[playerid][TempoAtividade][SEGUNDOS];
				if(Jogador[playerid][TempoAtividade][SEGUNDOS] >= 60)
				{
					++Jogador[playerid][TempoAtividade][MINUTOS];
					Jogador[playerid][TempoAtividade][SEGUNDOS] = 0;

					if(Jogador[playerid][TempoAtividade][MINUTOS] >= 60)
						++Jogador[playerid][TempoAtividade][HORAS], Jogador[playerid][TempoAtividade][MINUTOS] = 0;
				}
			}
			/*if( IsPlayerInAnyVehicle(playerid) )
			{
				call::TD->UpdatePlayerVelocimetro(playerid);
			}*/

			/**
			*
			*	Liberar mercadoria ao passar 1 hora.
			*
			**/
			if (  call::PLAYER->GetPlayerVarInt(playerid, EmpresaID) != INVALID_BUSINESS_ID )
			{
				if ( Jogador[playerid][Mercadoria] > MERCADORIA_LIBERADA)
				{
					--Jogador[playerid][Mercadoria];
					
					if ( Jogador[playerid][Mercadoria] == MERCADORIA_LIBERADA ){
						
					}
				}
			}

			if ( Jogador[playerid][Preso] == SOLTO )
			{
				--Jogador[playerid][UPs];
			}
			
			new actorid = GetPlayerTargetDynamicActor(playerid), empresaid = GetPlayerVirtualWorld(playerid);

			if(IsValidDynamicActor(actorid) && GetPlayerWeapon(playerid) >= 22)
			{
				if(actorid == 367 || actorid == 368)
				{
					if(Jogador[playerid][Profissao] != ASSALTANTE)
						return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte da profissão Assaltante.");

					if (!call::BUSINESS->IsValidBusiness(empresaid) )
						return false;

					if(call::BUSINESS->GetBusinessParamsInt(empresaid, Cofre) <= 0)
						return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse hotel não pode ser assaltado no momento.");

					OnPlayerTargetDynamicActor(playerid);
				}
			}

			//if(Jogador[playerid][UPs] <= 0)
			//{
			//	if(Jogador[playerid][UPm] <= 0)
			//	{
			//		Jogador[playerid][UPm] = 10;
			//		Jogador[playerid][UPs] = 0;
			//		
			//		++Jogador[playerid][EXP];
			//		SendClientMessage(playerid, COR_LARANJA, "| NÍVEL | Você upou {ffffff}+1 {"COR_LARANJA_INC"}ponto de experiência, acumulando {ffffff}%d{"COR_LARANJA_INC"}/{ffffff}%d", Jogador[playerid][EXP], call::PLAYER->requestXP(playerid));
			//		//SendClientMessage(playerid, COR_BRANCO, "» {"COR_VERDE_INC"}Você ganhou {"COR_BRANCO_INC"}+1{"COR_VERDE_INC"} ponto de experiência, você acumulou %d/%d.", Jogador[playerid][EXP], call::PLAYER->requestXP(playerid));
			//		PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
//
			//		if(Jogador[playerid][EXP] >= call::PLAYER->requestXP(playerid) )
			//		{
			//			SetPlayerScore(playerid, GetPlayerScore(playerid) + 1);
			//			//call::TD->UpdateTextDrawHudLevel(playerid);
			//			
			//			SendClientMessage(playerid, COR_LARANJA, "| NÍVEL | Você completou os {ffffff}%d{"COR_LARANJA_INC"}/{ffffff}%d {"COR_LARANJA_INC"}pontos de experiência!", Jogador[playerid][EXP], call::PLAYER->requestXP(playerid));
			//			SendClientMessage(playerid, COR_LARANJA, "| NÍVEL | Parabéns {ffffff}%s{"COR_LARANJA_INC"}, seu nível agora é {ffffff}%d{"COR_LARANJA_INC"}!", GetUserName(playerid), GetPlayerScore(playerid));
			//			//SendClientMessage(playerid, COR_BRANCO, "» {"COR_VERDE_INC"}Parabéns você ganhou {"COR_BRANCO_INC"}+1{"COR_VERDE_INC"} de level por acumular todas as experiência necessárias.");
			//			
			//			Jogador[playerid][EXP] = 0;
			//			PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
//
			//			switch( GetPlayerScore(playerid) )
			//			{
			//				case 50: {
			//					GivePlayerMoney(playerid, 5000);
			//					SendClientMessage(playerid, COR_VERDE, "| INFO | Você recebeu +R$5.000 por chegar ao level 50");
			//				}
			//				case 100:{
			//					GivePlayerMoney(playerid, 10000);
			//					SendClientMessage(playerid, COR_VERDE, "| INFO | Você recebeu +R$10.000 por chegar ao level 100");
			//				}
			//				case 250:{
			//					GivePlayerMoney(playerid, 20000);
			//					SendClientMessage(playerid, COR_VERDE, "| INFO | Você recebeu +R$20.000 por chegar ao level 250");
			//				}
			//				case 500:{
			//					GivePlayerMoney(playerid, 40000);
			//					SendClientMessage(playerid, COR_VERDE, "| INFO | Você recebeu +R$40.000 por chegar ao level 500");
			//				}
			//				case 1000:{
			//					GivePlayerMoney(playerid, 75000); // mais vip 30 dias vips
			//					SendClientMessage(playerid, COR_VERDE, "| INFO | Você recebeu +R$75.000 por chegar ao level 1000");
			//				}
			//				case 1500:{
			//					GivePlayerMoney(playerid, 125000); // mais vip 30 dias vips
			//					SendClientMessage(playerid, COR_VERDE, "| INFO | Você recebeu +R$125.000 por chegar ao level 1500");
			//				}
			//				case 2000:{
			//					GivePlayerMoney(playerid, 180000); // mais vip 30 dias vips
			//					SendClientMessage(playerid, COR_VERDE, "| INFO | Você recebeu +R$180.000 por chegar ao level 2000");
			//				}
			//			}
			//		}
			//		//call::TD->UpdateTextDrawHudExp(playerid);
			//		
			//		new query[128];
			//		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `exp`='%d',`level`='%d' WHERE `id`='%d'", Jogador[playerid][EXP], GetPlayerScore(playerid), call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
			//		mysql_tquery(getConexao(), query);
			//	}
			//	else{
			//		--Jogador[playerid][UPm];
			//		Jogador[playerid][UPs] = 59;
			//	}
			//}
			//if(Jogador[playerid][Fome] > 100)
			//	Jogador[playerid][Fome] = 100;
			//
			//if(Jogador[playerid][Sede] > 100)
			//	Jogador[playerid][Sede] = 100;
			//
			//if(Jogador[playerid][Sono] > 100)
			//	Jogador[playerid][Sono] = 100;

			//if(call::PLAYER->GetPlayerVarInt(playerid, pDormindo) == 0)
			//{
			//	Jogador[playerid][Fome] = Jogador[playerid][Fome] - 0.009;
			//	Jogador[playerid][Sede] = Jogador[playerid][Sede] - 0.013;
			//	Jogador[playerid][Sono] = Jogador[playerid][Sono] - 0.005;
//
			//	if( floatround(call::PLAYER->GetPlayerVarFloat(playerid, Sono)) <= 10)
			//	{
			//		if( floatround(call::PLAYER->GetPlayerVarFloat(playerid, Sono)) == 10)
			//		{
			//			call::PLAYER->SetPlayerVarFloat(playerid, Sono, 9.0);
			//			call::PLAYER->InitPlayerFadeEffect(playerid);
			//			SendClientMessage(playerid, COR_AMARELO, "| AVISO | Seu personagem está com muito Sono, vá até um Hotel para dormir!");
			//		}
			//		else if( floatround(call::PLAYER->GetPlayerVarFloat(playerid, Sono)) == 5)
			//		{
			//			call::PLAYER->SetPlayerVarFloat(playerid, Sono, 4.0);
			//			call::PLAYER->InitPlayerFadeEffect(playerid);
			//			SendClientMessage(playerid, COR_AMARELO, "| AVISO | Seu personagem está com muito Sono, vá até um Hotel para dormir!");
			//		}
			//		else if(call::PLAYER->GetPlayerVarFloat(playerid, Sono) <= 0.000)
			//		{
			//			callcmd::dormir(playerid);
			//			SendClientMessage(playerid, COR_AMARELO, "| AVISO | Seu personagem desmaiou de Sono!");
			//		}
			//	}
			//}
			//else
			//{
			//	static Float:health;
			//	GetPlayerHealth(playerid, health);
			//	if ( health <= 80 )
			//	{
			//		SetPlayerHealth(playerid, health + 0.03);
			//	}
//
			//	Jogador[playerid][Fome] = Jogador[playerid][Fome] - 0.015;
			//	Jogador[playerid][Sede] = Jogador[playerid][Sede] - 0.03;
			//	Jogador[playerid][Sono] = Jogador[playerid][Sono] + 0.5;
			//	
			//	if(Jogador[playerid][Sono] >= 100)
			//		callcmd::acordar(playerid), Jogador[playerid][Sono] = 100.0;
			//}
//
			//if( floatround(call::PLAYER->GetPlayerVarFloat(playerid, Fome)) <= 15)
			//{
			//	if( floatround(call::PLAYER->GetPlayerVarFloat(playerid, Fome)) == 15)
			//	{
			//		call::PLAYER->SetPlayerVarFloat(playerid, Fome, 14.0);
			//		SendClientMessage(playerid, COR_AMARELO, "| AVISO | Seu personagem está com muita Fome, vá até um Restaurante para comer!");
			//	}
			//	else if( floatround(call::PLAYER->GetPlayerVarFloat(playerid, Fome)) == 10)
			//	{
			//		call::PLAYER->SetPlayerVarFloat(playerid, Fome, 9.0);
			//		SendClientMessage(playerid, COR_AMARELO, "| AVISO | Seu personagem está com muita Fome, vá até um Restaurante para comer!");
			//	}
			//	else if( floatround(call::PLAYER->GetPlayerVarFloat(playerid, Fome)) == 5)
			//	{
			//		call::PLAYER->SetPlayerVarFloat(playerid, Fome, 4.0);
			//		SendClientMessage(playerid, COR_AMARELO, "| AVISO | Seu personagem está com muita Fome, vá até um Restaurante para comer!");
			//	}
			//	else if(call::PLAYER->GetPlayerVarFloat(playerid, Fome) <= 0.000)
			//	{
			//		SetPlayerHealth(playerid, 0), call::PLAYER->SetPlayerVarFloat(playerid, Fome, 10.0);
			//		SendClientMessage(playerid, COR_AMARELO, "| AVISO | Seu personagem desmaiou de Fome!");
			//	}
			//}
//
			//if( floatround(call::PLAYER->GetPlayerVarFloat(playerid, Sede)) <= 15)
			//{
			//	if( floatround(call::PLAYER->GetPlayerVarFloat(playerid, Sede)) == 15)
			//	{
			//		call::PLAYER->SetPlayerVarFloat(playerid, Sede, 14.0);
			//		SendClientMessage(playerid, COR_AMARELO, "| AVISO | Seu personagem está com muita Sede, vá até um Restaurante para beber!");
			//	}
			//	else if( floatround(call::PLAYER->GetPlayerVarFloat(playerid, Sede)) == 10)
			//	{
			//		call::PLAYER->SetPlayerVarFloat(playerid, Sede, 9.0);
			//		SendClientMessage(playerid, COR_AMARELO, "| AVISO | Seu personagem está com muita Sede, vá até um Restaurante para beber!");
			//	}
			//	else if( floatround(call::PLAYER->GetPlayerVarFloat(playerid, Sede)) == 5)
			//	{
			//		call::PLAYER->SetPlayerVarFloat(playerid, Sede, 4.0);
			//		SendClientMessage(playerid, COR_AMARELO, "| AVISO | Seu personagem está com muita Sede, vá até um Restaurante para beber!");
			//	}
			//	else if(call::PLAYER->GetPlayerVarFloat(playerid, Sede) <= 0.000)
			//	{
			//		SetPlayerHealth(playerid, 0), call::PLAYER->SetPlayerVarFloat(playerid, Sede, 15.0);
			//		SendClientMessage(playerid, COR_AMARELO, "| AVISO | Seu personagem desmaiou de Sede!");
			//	}
			//}			

			/*if(call::PLAYER->GetPlayerVarFloat(playerid, Sede) <= 0.0)
			{
				SetPlayerHealth(playerid, 0), call::PLAYER->SetPlayerVarFloat(playerid, Sede, 5.0);
				SendClientMessage(playerid, COR_ERRO, "| AVISO | Você desmaiou por desidratação, e foi levado para um hospital.");
			}

			if(call::PLAYER->GetPlayerVarFloat(playerid, Fome) <= 0.0)
			{
				SetPlayerHealth(playerid, 0), call::PLAYER->SetPlayerVarFloat(playerid, Fome, 5.0);
				SendClientMessage(playerid, COR_AMARELO, "| AVISO | Você desmaiou de fome, e foi levado para um hospital.");
			}*/

			new query[326];
			if(Jogador[playerid][TempoVip] < gettime())
			{
				if(Jogador[playerid][Vip])
				{
					Jogador[playerid][TempoVip] = 0, Jogador[playerid][Vip] = false;

					mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `vencimento_vip`='0', `vip`='0' WHERE `id`='%d'", Jogador[playerid][PlayerID]);
					mysql_tquery(getConexao(), query);

					SendClientMessage(playerid, COR_SISTEMA, "| INFO | {ffffff}Seu VIP expirou, caso queira renovar seu vip, vá até nosso discord e abra um ticket!");
				}
			}

			if(GetPVarInt(playerid, "ColorChanged") == 0)
			{
				call::JOB->LogarProf(playerid);
			}
			
			static hour, minute;
			gettime(hour, minute);
			switch(hour)
			{
				case 18:
					SetPlayerTime(playerid, hour+2, minute);
				case 19..22:
					SetPlayerTime(playerid, hour+4, minute);
				default:
					SetPlayerTime(playerid, hour, minute);
			}
			//call::TD->UpdateTextDrawPlayerHud(playerid);
			//call::TD->UpdateWantedLevel(playerid);

			if(call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE && call::PLAYER->GetPlayerVarInt(playerid, pDormindo) == 0 && call::ADMIN->IsAdminInJob(playerid))
			{
				SetPlayerChatBubble(playerid, call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid), true), -1, 10.0, 1000);
			}
			else
			{
				if(call::PLAYER->GetPlayerVarInt(playerid, pDormindo))
					SetPlayerChatBubble(playerid, "zZzzZZZzz", COR_BRANCO, 10.0, 1000);

				else if( Jogador[playerid][Vip] )
					SetPlayerChatBubble(playerid, "VIP", Jogador[playerid][CorTag], 10.0, 1000);
				
				else if( Jogador[playerid][Beta] == 1)
				{
					SetPlayerChatBubble(playerid, "Beta", 0xc4c4c4AA, 10.0, 1000);
				}

				else if( Jogador[playerid][Beta] == 2)
				{
					SetPlayerChatBubble(playerid, "Mapper", 0xFF00FFAA, 10.0, 1000);
				}

				else if( Jogador[playerid][Beta] == 3)
				{
					SetPlayerChatBubble(playerid, "DJ", 0x4910B4AA, 10.0, 1000);
				}

				else if( Jogador[playerid][Beta] == 4)
				{
					SetPlayerChatBubble(playerid, "YouTuber", 0x921515AA, 10.0, 1000);
				}
			}
		}
		/*foreach(new i: Player)
		{
			if(IsPlayerInFavela(i))
			{
				if(!Jogador[i][inFavela])
				{
					Jogador[i][inFavela] = true;
					ShowPlayerTextoFavela(i), GivePlayerKitFavela(i, Jogador[i][KitFavela]);
					SetPlayerArmour(i, 0);
				}
			}
			else
			{
				if(Jogador[i][inFavela])
				{
					ResetPlayerWeapons(i), HidePlayerTextoFavela(i);
					Jogador[i][inFavela] = false;
				}
			}
		}*/
		/*foreach(new i: Player)
		{
			CheckSoundProx(i);
			CheckCarSoundProx(i);
		}*/
		
		if(call::PLAYER->GetPlayerVarInt(playerid, ObjectAttached) < gettime())
		{
			if(IsPlayerAttachedObjectSlotUsed(playerid, 0))
			{
				RemovePlayerAttachedObject(playerid, 0);
			}
		}
		return true;
	}
	return false;
}

new static 
	horas, minutos, bool:verificado;

public OnTimeOneSeconds()
{
	call::TD->UpdateTextDrawHud();

	gettime(horas, minutos);
	if(horas == 0 && minutos == 0 && !verificado)
	{
		verificado = true;
		SetTimer("GerarImpostos", 3 * (60 * 1000), false);

		SendClientMessageToAll(COR_AMARELO, "| SERVIDOR | O servidor irá reiniciar em aproximadamente 3 minutos.");
		return true;
	}
	return true;
}

forward GerarImpostos();
public GerarImpostos()
{
	CleanChat();
	SendClientMessageToAll(-1, "| INFO | Servidor reiniciando, voltamos já!");
	
	// gerar impostos
	print("gerando impostos...");
	mysql_query_file(getConexao(), "querys/impostos.sql", false);


	foreach(new i: Casas)
	{
		if(Casa[i][Impostos] >= 15)
		{
			printf("A casa id %d foi liberada. Impostos: %d", Casa[i][ID], Casa[i][Impostos]);
		}
	}

	foreach(new i: Business)
	{

	}

	foreach(new i: Hotel)
	{

	}

	// Excluir contas inativas
/*	print("Verificando contas inativas...");
	new Cache:cache = mysql_query(getConexao(), "DELETE FROM "TABLE_USERS" WHERE DATEDIFF(NOW(), `ultimo_login`) > 180;", true);
	printf("Foram deletadas %d conta(s).", cache_affected_rows());
	cache_delete(cache);*/


	// Pagamento de Alugueis


	// Fazer o backup
	HTTP(0, HTTP_POST, "localhost/metropolitan/backup", "backup", "OnBackupReturn");
	return true;
}  


forward OnBackupReturn(index, response_code, data[]); public OnBackupReturn(index, response_code, data[])
{
	if ( response_code == 200)
	{
		print("» Backup efetuado com êxito.");
		printf("data: %s", data);
	}

	new str[128];
	format(str, sizeof(str), "| INFO | Servidor reiniciando. Voltamos já!");
	WriteLog("shutdown-server.txt", str, sizeof(str));

	foreach(new i: Player)
	{
		Kick(i);
	}
	SetTimer("RestartServer", 20000, 0);

	SendRconCommand("password kas,dakdksadssodadqwqe");
	return true;
}

forward RestartServer(playerid);
public RestartServer(playerid)
{
	SendRconCommand(#gmx);
	return 1;
}