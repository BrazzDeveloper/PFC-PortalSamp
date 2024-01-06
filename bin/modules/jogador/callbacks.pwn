

/*
*
*
*			INCLUDE HOOK
*
*
*/
#include <YSI_Coding\y_hooks>


/*
*
*
*			CALLBACK HOOK
*
*
*/

new TimerSede[MAX_PLAYERS];
new TimerFome[MAX_PLAYERS];
new TimerSono[MAX_PLAYERS];
new TimerATTFSS[MAX_PLAYERS];

hook OnPlayerDisconnect(playerid, reason)
{
	if(call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE)
	{
		new TempoOn[128];
		InvertedrHoraMinuto(Jogador[playerid][AdmTempoLogado], TempoOn, 128);

		SendLog(LOG_LOGINADMIN, "| PFC-Logs | O(A) %s %s saiu do servidor. ( Tempo online: %s )", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), \
		GetUserName(playerid), TempoOn);
	}

	SetPVarInt(playerid, "ColorChanged", 0);

	KillTimer(TimerSede[playerid]);
	KillTimer(TimerSono[playerid]);
	KillTimer(TimerFome[playerid]);
	KillTimer(TimerATTFSS[playerid]);

	DestroyVehicle(Jogador[playerid][VeiculoLocado]);
	if( IsPlayerNPC(playerid) )
		return Y_HOOKS_CONTINUE_RETURN_1;

	if( call::PLAYER->IsPlayerLogged(playerid) )
	{
		Jogador[playerid][Calado] = false, Jogador[playerid][TempoCalado] = 0;
		
		static query[1036 * 4], Float:vida, Float:colete, Float:x, Float:y, Float:z, Float:a;

		GetPlayerPos(playerid, x, y, z), GetPlayerFacingAngle(playerid, a);
		GetPlayerHealth(playerid, vida), GetPlayerArmour(playerid, colete);
		
		query[0] = EOS;

		if( call::PLAYER->GetPlayerVarInt(playerid, Perseguido) )
		{
			SendClientMessageToAll(COR_AVISO, "O(A) jogador(a) {"COR_BRANCO_INC"}%s{"COR_AVISO_INC"} foi preso por desconectar do servidor em perseguição.", GetUserName(playerid));
			call::PLAYER->SetPlayerVarInt(playerid, TempoPreso, (GetPlayerWantedLevel(playerid) * 300));
			call::PLAYER->SetPlayerVarInt(playerid, Preso, PRESO_POLICIA);
			call::PM->FinalizarPerseguicao(playerid, 1);
		}
		
		mysql_format(getConexao(), query, sizeof(query),
			"UPDATE "TABLE_USERS" SET `vida`='%0.3f',`colete`='%0.3f',`upm`='%d',`ups`='%d',`spawn_x`='%0.3f',`spawn_y`='%0.3f',`spawn_z`='%0.3f',`spawn_a`='%0.3f',`world`='%d',`interior`='%d',`level`='%d', `dinheiro`='%d',`fome`='%d',`sede`='%d',`sono`='%d',`bloqueado_carga`='%d',`ultimo_login`=NOW(),`mercadoria`='%d',`skin`='%d',`admin_trabalhando_horas`='%d',`admin_trabalhando_minutos`='%d',`admin_trabalhando_segundos`='%d',`multas`='%d',`tempo_preso`='%d',`estrelas`='%d',`saldo`='%d',`preso`='%d',`entrou`='%d',`sementes`='%d',`crack`='%d',`maconha`='%d',`cocaina`='%d',`vip`='%d', `beta`='%d', `skill_pistol`='%d',`skill_mp5`='%d',`skill_fuzil`='%d',`skill_rifle`='%d',`skill_shotgun`='%d' WHERE `id`='%d';",
			vida, 
			colete,
			Jogador[playerid][UPm], Jogador[playerid][UPs],
			x, y, z, a, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid),
			GetPlayerScore(playerid),
			GetPlayerMoney(playerid),
			Jogador[playerid][Fome],
			Jogador[playerid][Sede],
			Jogador[playerid][Sono],
			(Jogador[playerid][bCarga] > gettime() ? Jogador[playerid][bCarga] : 0),
			Jogador[playerid][Mercadoria],
			Jogador[playerid][Skin],
			Jogador[playerid][TempoAtividade][HORAS],
			Jogador[playerid][TempoAtividade][MINUTOS],
			Jogador[playerid][TempoAtividade][SEGUNDOS],
			Jogador[playerid][Multas],
			Jogador[playerid][TempoPreso],
			GetPlayerWantedLevel(playerid),
			Jogador[playerid][SaldoCelular],
			Jogador[playerid][Preso],
			Jogador[playerid][Entrou],
			Jogador[playerid][Sementes],
			Jogador[playerid][Crack],
			Jogador[playerid][Maconha],
			Jogador[playerid][Cocaina],
			Jogador[playerid][Vip],
			Jogador[playerid][Beta],
			Jogador[playerid][SkillPistol],
			Jogador[playerid][SkillMP5],
			Jogador[playerid][SkillFuzil],
			Jogador[playerid][SkillRifle],
			Jogador[playerid][SkillShotgun],
			Jogador[playerid][PlayerID]);
		mysql_tquery(getConexao(), query);

		// salvar armas
		/*query[0] = EOS;
		new str[512], weapon, ammo;
		for(new slot; slot <= MAX_PLAYER_WEAPONS; slot++)
		{
			GetPlayerWeaponData(playerid, slot, weapon, ammo);
			format(str, sizeof(str), "%s,`slot%d`=%d,`slot%d_ammo`=%d", str, slot, weapon, slot, ammo);
		}
		str[0] = ' ';
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET %s WHERE `id`='%d'", str, Jogador[playerid][PlayerID]);
		mysql_tquery(getConexao(), query);*/

		// salvar veiculos do jogador.
		SavePlayerVehicles(playerid);
	}

	/* Finalizar a chamada, se o player estiver em uma. */
	if ( call::PLAYER->GetPlayerVarInt(playerid, StateCell) != 0)
		call::CELL->FinalizarChamada(playerid, call::PLAYER->GetPlayerVarInt(playerid, CallerID) );

	/* "Matar" timer o tratamento */
	if ( Jogador[playerid][EmTratamento] != 0 )
		KillTimer(Jogador[playerid][EmTratamento]), Jogador[playerid][EmTratamento]=0;
	
	if ( call::PLAYER->GetPlayerVarInt(playerid, PrisioneiroID) != INVALID_PLAYER_ID ) // Prisioneiro saindo
	{
		new id = call::PLAYER->GetPlayerVarInt(playerid, PrisioneiroID);
		call::PLAYER->SetPlayerVarInt(id, AdvogadoID, INVALID_PLAYER_ID);
		call::PLAYER->SetPlayerVarInt(id, AdvogadoValor, 0);
		call::PLAYER->SetPlayerVarInt(playerid, PrisioneiroID, INVALID_PLAYER_ID);

		SendClientMessage(id, COR_ERRO, "| ERRO | O(A) Prisioneiro {"COR_BRANCO_INC"}%s{"COR_ERRO_INC"} saiu do servidor e o serviço foi cancelado.", GetUserName(playerid));
	}

	if ( call::PLAYER->GetPlayerVarInt(playerid, AdvogadoID) != INVALID_PLAYER_ID ) // Advogado saindo
	{
		new id = call::PLAYER->GetPlayerVarInt(playerid, AdvogadoID);
		call::PLAYER->SetPlayerVarInt(playerid, AdvogadoID, INVALID_PLAYER_ID);
		call::PLAYER->SetPlayerVarInt(playerid, AdvogadoValor, 0);
		call::PLAYER->SetPlayerVarInt(id, PrisioneiroID, INVALID_PLAYER_ID);

		SendClientMessage(id, COR_ERRO, "| ERRO | O(A) Advogado {"COR_BRANCO_INC"}%s{"COR_ERRO_INC"} saiu do servidor e o serviço foi cancelado.", GetUserName(playerid));
	}
	
	call::PLAYER->TogglePlayerLogged(playerid, false);
	DeletePVar(playerid, "OferecedorMID"), DeletePVar(playerid, "DinheiroMaconha"), DeletePVar(playerid, "MaconhaOferecida"), DeletePVar(playerid, "MQuantidade");
	DeletePVar(playerid, "OferecedorCID"), DeletePVar(playerid, "DinheiroCocaina"), DeletePVar(playerid, "CocainaOferecida"), DeletePVar(playerid, "CQuantidade");
	DeletePVar(playerid, "OferecedorCraID"), DeletePVar(playerid, "DinheiroCrack"), DeletePVar(playerid, "CrackOferecida"), DeletePVar(playerid, "CraQuantidade");
	DeletePVar(playerid, "AddNeon");
	DestroyDynamicObject(GetPVarInt(playerid, "NeonVermelho")), DestroyDynamicObject(GetPVarInt(playerid, "NeonVermelho2")), DestroyDynamicObject(GetPVarInt(playerid, "NeonAzul"));
	DestroyDynamicObject(GetPVarInt(playerid, "NeonAzul2")), DestroyDynamicObject(GetPVarInt(playerid, "NeonVerde")), DestroyDynamicObject(GetPVarInt(playerid, "NeonVerde2"));
	DestroyDynamicObject(GetPVarInt(playerid, "NeonAmarelo")), DestroyDynamicObject(GetPVarInt(playerid, "NeonAmarelo2")), DestroyDynamicObject(GetPVarInt(playerid, "NeonRosa"));
	DestroyDynamicObject(GetPVarInt(playerid, "NeonRosa2")), DestroyDynamicObject(GetPVarInt(playerid, "NeonBranco")), DestroyDynamicObject(GetPVarInt(playerid, "NeonBranco2"));


	// destruir player progressbar
	DestroyAllPlayerProgressBars(playerid);

	/*		resetar as variaveis 		*/
	new reset[e_PLAYER_INFO];
	Jogador[playerid] = reset;

	KillTimer(Timer@UPCARINFO[playerid]);
	return true;
}

hook OnPlayerConnect(playerid)
{

	//if ( IsPlayerAndroid(playerid) )
  	//	SendClientMessage(playerid, COR_AVISO, "Você se conectou por um Celular e foi liberado do Anti-S0beit");

	// Pegar o nome do jogador.
	new loadingPlayerName[MAX_PLAYER_NAME];
	format(loadingPlayerName, MAX_PLAYER_NAME, "conectando_%d", playerid);
	SetPlayerName(playerid, loadingPlayerName);

	SetPlayerColor(playerid, 0x00000000);

	/*if(IsPlayerSobeit(playerid))
	{
		SendClientMessage(playerid, COR_ERRO, "* Você tentou entrar com s0beit e foi kickado.");
		Kick(playerid);
	}*/

	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerRequestClass(playerid, classid)
{
	// iniciar váriaveis.
	call::PLAYER->SetPlayerVarInt(playerid, PrisioneiroID, INVALID_PLAYER_ID);

	if( !call::PLAYER->IsPlayerLoggin(playerid) )
	{
		call::PLAYER->SetPlayerVarInt(playerid, AdvogadoID, INVALID_PLAYER_ID);
		PlayAudioStreamForPlayer(playerid, "https://perfectcityrpg.com.br/musicas/gta-san.mp3");
		
		SetPlayerColor(playerid, 0x000000AA);

		TogglePlayerSpectating(playerid, true);
		
		CleanChat(playerid);
		call::PLAYER->TogglePlayerLoggin(playerid, true);

		SetPlayerCameraLogin(playerid, 0);
		SendClientMessage(playerid, COR_SISTEMA, "| INFO | {"COR_BRANCO_INC"}Seja bem-vindo(a) à {"COR_AZUL_INC"}Perfect City RPG{ffffff}.");
		call::TD->ShowPlayerLogin(playerid);
		
		return Y_HOOKS_CONTINUE_RETURN_1;
	}
	return Y_HOOKS_CONTINUE_RETURN_0;
}

hook OnPlayerRequestSpawn(playerid)
{
	return call::PLAYER->IsPlayerLogged(playerid);
}

hook OnPlayerSpawn(playerid)
{
	if( !call::PLAYER->IsPlayerLogged(playerid) )
	{
		call::PLAYER->TogglePlayerLogged(playerid, true);

		call::TD->ShowPlayerHud(playerid);
		//call::JOB->SetPlayerJobColor(playerid, Jogador[playerid][Profissao]);
		call::JOB->LogarProf(playerid);
		
		StopAudioStreamForPlayer(playerid);		

		//	Criar arquivo de configuração
		new file[MAX_FILE_CONFIG_LEN];
		format(file, sizeof(file), CONFIG_PLAYER_PATH, GetUserName(playerid));

		if( !fexist(file) )
		{
			DOF2::CreateFile(file);
			
			DOF2::SetInt(file, TAG_MOSTRAR_STATUS, 1);
			DOF2::SetInt(file, TAG_MOSTRAR_DATA, 1);
			DOF2::SetInt(file, TAG_CORTAGVIP, -1);
			DOF2::SaveFile();
		}

		if ( DOF2::GetInt(file, TAG_MOSTRAR_STATUS) )
			call::TD->ShowPlayerHudStatus(playerid);
		else
			call::TD->HidePlayerHudStatus(playerid);

		if ( DOF2::GetInt(file, TAG_MOSTRAR_DATA) )
			call::TD->ShowPlayerHudData(playerid);
		else
			call::TD->HidePlayerHudData(playerid);

		Jogador[playerid][CorTag] = DOF2::GetInt(file, TAG_CORTAGVIP);
		return true;
	}

	if ( call::PLAYER->GetPlayerVarInt(playerid, Preso) == SOLTO)
	{
		/*if(Jogador[playerid][MortoFavela] == true)
		{
			SetPlayerPos(playerid, 2189.5906, -1151.5498, 40.0000);
			SetPlayerInterior(playerid, 0), SetPlayerVirtualWorld(playerid, 0);
			GivePlayerKitFavela(playerid, Jogador[playerid][KitFavela]);
			Jogador[playerid][MortoFavela] = false;
		} */
		if(call::PLAYER->GetPlayerVarInt(playerid, pHospital) != 0 )
		{
			if(call::PLAYER->GetPlayerVarInt(playerid, pHospital) == 1){
				SetPlayerPos(playerid, 1173.1145, -1323.7125, 15.3962);
				SetPlayerFacingAngle(playerid, 268.1490);
			}
			else if(call::PLAYER->GetPlayerVarInt(playerid, pHospital) == 2){
				SetPlayerPos(playerid, 2036.5521,-1412.5513,16.9922);
				SetPlayerFacingAngle(playerid, 135.5749);
			}
			else if(call::PLAYER->GetPlayerVarInt(playerid, pHospital) == 3){
				SetPlayerPos(playerid, 1607.4396,1819.1462,10.8280);
				SetPlayerFacingAngle(playerid, 359.6572);
			}
			else if(call::PLAYER->GetPlayerVarInt(playerid, pHospital) == 4){
				SetPlayerPos(playerid, -2665.0503,636.5155,14.4531);
				SetPlayerFacingAngle(playerid, 177.0288);
			}
		    else if(call::PLAYER->GetPlayerVarInt(playerid, pHospital) == 5){
	            SetPlayerPos(playerid, -315.0838,1050.7095,20.3403);
	            SetPlayerFacingAngle(playerid, 359.3905);
			}
			else if(call::PLAYER->GetPlayerVarInt(playerid, pHospital) == 6){
	            SetPlayerPos(playerid, -1514.6455,2523.4263,55.8138);
	            SetPlayerFacingAngle(playerid, 359.6804);
			}
			else if(call::PLAYER->GetPlayerVarInt(playerid, pHospital) == 7){
	            SetPlayerPos(playerid, -2208.2485,-2286.8516,30.6250);
	            SetPlayerFacingAngle(playerid, 319.4752);
			}
			SetCameraBehindPlayer(playerid);

			call::PLAYER->SetPlayerVarInt(playerid, pHospital, 0);

			if ( call::PLAYER->GetPlayerVarInt(playerid, Plano) == 0 )
			{
				//call::PLAYER->SetPlayerVarFloat(playerid, Fome, call::PLAYER->GetPlayerVarFloat(playerid, Fome) + Planos[0][FSS]);
				//call::PLAYER->SetPlayerVarFloat(playerid, Sede, call::PLAYER->GetPlayerVarFloat(playerid, Sede) + Planos[0][FSS]);
				//call::PLAYER->SetPlayerVarFloat(playerid, Sono, call::PLAYER->GetPlayerVarFloat(playerid, Sono) + Planos[0][FSS]);
				call::PLAYER->SetPlayerVarInt(playerid, Fome, call::PLAYER->GetPlayerVarInt(playerid, Fome) + Planos[0][FSS]);
				call::PLAYER->SetPlayerVarInt(playerid, Sede, call::PLAYER->GetPlayerVarInt(playerid, Sede) + Planos[0][FSS]);
				call::PLAYER->SetPlayerVarInt(playerid, Sono, call::PLAYER->GetPlayerVarInt(playerid, Sono) + Planos[0][FSS]);

				//SetPlayerArmour(playerid, Planos[0][Vida]);
				
				//SendClientMessage(playerid, COR_VERDE, "» {"COR_BRANCO_INC"}Você não possui um plano de saúde, por isso está pagando {"COR_VERDE_INC"}R$350{"COR_BRANCO_INC"} pelo tratamento.");
				SendClientMessage(playerid, COR_BRANCO, "| HOSPITAL | {"COR_LARANJA_INC"}Você não possui um plano de saúde, e foi cobrado {"COR_VERDE_INC"}R$350{"COR_LARANJA_INC"} de você pelo tratamento.");
				SendClientMessage(playerid, COR_BRANCO, "| HOSPITAL | {"COR_LARANJA_INC"}Recomendamos que faça um plano de saúde, vá até o Hospital para fazer.");
				GivePlayerMoney(playerid, -350, true);
			}	
			else
			{
				new p = call::PLAYER->GetPlayerVarInt(playerid, Plano);
				//SetPlayerArmour(playerid, Planos[p][Colete]);
				SetPlayerHealth(playerid, Planos[p][Vida]);
				//Jogador[playerid][Fome] += float(Planos[p][FSS]);
				//Jogador[playerid][Sede] += float(Planos[p][FSS]);
				//Jogador[playerid][Sono] += float(Planos[p][FSS]);

				Jogador[playerid][Fome] += Planos[p][FSS];
				Jogador[playerid][Sede] += Planos[p][FSS];
				Jogador[playerid][Sono] += Planos[p][FSS];

				//SendClientMessage(playerid, COR_AZUL, "* {"COR_BRANCO_INC"}Você é assinante do plano de saúde {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"} e está recebendo os benefícios do plano.", Planos[p][Nome]);
				SendClientMessage(playerid, COR_BRANCO, "| HOSPITAL | {"COR_LARANJA_INC"}Seu plano de saúde cobriu todas as suas despesas médicas.");
			}
		}
	}
	else
	{
		if ( call::PLAYER->GetPlayerVarInt(playerid, Preso) == PRESO_POLICIA )
		{
			EnviarCela(playerid);
		}
		
	}

	/*for(new i; i < sizeof(FavelaZone); i++){
		GangZoneShowForAll(FavelaZone[i], 0xFFFFFFAA), GangZoneFlashForAll(FavelaZone[i], 0xFF000099);
	}*/


	// Anti Cheats
	//SetTimerEx("AntiFly", 1000, true, "i", playerid);
	//SetTimerEx("AntiAnim", 1000, true, "i", playerid);
	//SetTimerEx("AntiInvSlap", 500, true, "i", playerid);

	return true;
}


hook OnPlayerDeath(playerid, killerid, reason)
{
	call::JOB->SetPlayerWorking(playerid, false);
	ResetPlayerWeapons(playerid);
	if ( IsPlayerInEvent(playerid) )
	{
		Teleport(
			playerid,
			1481.2660,
			-1771.1407,
			18.7958,
			0.0,
			0,
			0,
			ENTROU_NONE
		);
		
		TogglePlayerControllable(playerid, true);
		ClearAnimations(playerid);

		SendDeathMessage(killerid, playerid, reason);

		SetPlayerHealth(playerid, 100);

		SendClientMessage(playerid, 0xAF2A2AFF, "» Obrigado por participar do nosso evento.");
		TogglePlayerEvent(playerid, false);
	}
	else
	{
		
		if ( call::PLAYER->GetPlayerVarBool(playerid, Perseguido) && killerid != INVALID_PLAYER_ID && call::PLAYER->GetPlayerVarInt(killerid, Profissao) == POLICIA_MILITAR)
		{
			call::PM->PrenderJogador(killerid, playerid);
		}
		else
		{
			if ( call::PLAYER->GetPlayerVarInt(playerid, Preso) == SOLTO )
			{
				/*if(IsPlayerInFavela(playerid))
				{
					if(killerid != INVALID_PLAYER_ID)
					{
						if(IsPlayerInFavela(killerid)) {
							++Jogador[killerid][Matou];
						} else {
							SendClientMessage(playerid, COR_BRANCO, "| ANTI - DM | Você matou alguém fora da favela.");
						}
						++Jogador[playerid][Morreu];
						ShowPlayerTextoFavela(killerid);
					}
					Jogador[playerid][MortoFavela] = true;
				}*/

				call::PLAYER->SetPlayerVarInt(playerid, pHospital, GetPlayerHospital(playerid));
				//SendClientMessage(playerid, COR_AVISO, "Você foi levado para o hospital.");
				SendClientMessage(playerid, COR_BRANCO, "| HOSPITAL | {"COR_LARANJA_INC"}Você foi ferido(a) e foi levado até o Hospital mais próximo.");
			}		
			else
			{
				EnviarCela(playerid);
				call::PM->ShowPlayerTextDrawPrisonTime(playerid);
				SendClientMessage(playerid, COR_BRANCO, "| HOSPITAL | {"COR_LARANJA_INC"}Você foi ferido(a), mas como não cumpriu sua pena, voltou para a prisão.");
			}
		}
		SendDeathMessage(killerid, playerid, reason);
	}
	return Y_HOOKS_CONTINUE_RETURN_1;	
}

/*hook OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
    if(IsPlayerInFavela(playerid))
    {
		PlayerPlaySound(playerid , 17802, 0.0, 0.0, 0.0);
	}
	return true;
}


hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    if(IsPlayerInFavela(playerid))
    {
		PlayerPlaySound(issuerid , 17802, 0.0, 0.0, 0.0);
	}
	return true;
}*/

hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if ( IsPlayerInEvent(playerid) )
		return Y_HOOKS_CONTINUE_RETURN_1;

	if ( BULLET_HIT_TYPE_PLAYER == hittype )
	{
		if ( call::PLAYER->GetPlayerVarInt(hitid, Perseguido) && call::PLAYER->GetPlayerVarInt(playerid, Profissao) == POLICIA_MILITAR)
			return Y_HOOKS_CONTINUE_RETURN_1;

		return Y_HOOKS_CONTINUE_RETURN_1;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerText(playerid, text[])
{
	new baseid = Jogador[playerid][BaseID];
	new tagbase[20];
	call::BASE->GetBaseParams(baseid, TAG, tagbase, sizeof(tagbase));

	if(call::PLAYER->IsPlayerLogged(playerid))
	{
		/*if(call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE)
		{
			if(text[0] == '+' && text[1] == ' ') // chat admins
			{
				foreach(new i: Player)
				{
					if(call::ADMIN->GetPlayerAdminLevel(i))
						SendClientMessage(i, 0x69958FAA, "[ + ] %s [%s] disse: %s", GetUserName(playerid), call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), text[2]);
				}
				
				//SendDiscord(CHANNEL_ADM, "```[ + ] %s [%s] disse: %s```", GetUserName(playerid), call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), text[2]);
				return false;
			}
			else if(text[0] == '#' && text[1] == ' ') // chat admins
			{
				foreach(new i: Player)
				{
					if(call::ADMIN->GetPlayerAdminLevel(playerid) == call::ADMIN->GetPlayerAdminLevel(i))
						SendClientMessage(i, 0x26F5FDFF, "[ # ] %s [%s] disse: %s", GetUserName(playerid), call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), text[2]);
				}
				return false;
			}
		}*/

		static Float:x, Float:y, Float:z, cargo[35];
		GetPlayerPos(playerid, x, y, z);

		if(Jogador[playerid][Calado] == true) 
		{
			SendClientMessage(playerid, COR_ERRO, "| ERRO | Você está calado(a) e não poderá falar no chat.");
			return 1;
		}

		// =========================== [ IN CHAMADA ] =========================== //
		if ( call::PLAYER->GetPlayerVarInt(playerid, StateCell) == EM_CHAMADA )
		{
			new caller = call::PLAYER->GetPlayerVarInt(playerid, CallerID);
			SendClientMessage(caller, 0xFFEC8BFF, "%s [celular]: %s", GetUserName(playerid), text);
			SendClientMessage(playerid, 0xFFEC8BFF, "%s [celular]: %s", GetUserName(playerid), text);
			return Y_HOOKS_CONTINUE_RETURN_0;
		}
		// ===================================================================== //

		if ( call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE && call::ADMIN->IsAdminInJob(playerid) )
		{
			switch(call::ADMIN->GetPlayerAdminLevel(playerid))
			{
				case AJUDANTE:cargo="{ffff00}Ajudante";
				case MODERADOR:cargo="{ff0000}Moderador(a)";
				case ADMINISTRADOR:cargo="{009acd}Administrador(a)";
				case DIRECAO:cargo="{31B404}Diretor(a)";
				case DEV:cargo="{ff6800}Desenvolvedor";
			}

			foreach(new i: Player)
			{
				if(IsPlayerInRangeOfPoint(i, 20.0, x, y, z)  && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)){
					
					if(Jogador[playerid][BaseID] >= 0)
					{
						SendClientMessage(i, COR_BRANCO, "%s{ffffff} [%s{ffffff}]{%06x}%s{ffffff}[%d]: %s", cargo, tagbase, GetPlayerColor(playerid) >>> 8, GetUserName(playerid), playerid, text);
					}
					else 
					{
					SendClientMessage(i, COR_BRANCO, "%s{ffffff} {%06x}%s{ffffff}[%d]: %s", cargo, GetPlayerColor(playerid) >>> 8, GetUserName(playerid), playerid, text);
					}
				}
			}
		}
		else
		{
			if ( Jogador[playerid][Vip] || Jogador[playerid][Beta] > 0)
			{
				foreach(new i: Player)
				{
					if(IsPlayerInRangeOfPoint(i, 20.0, x, y, z) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))
					{
						if(Jogador[playerid][BaseID] >= 0)
						{
							SendClientMessage(i, -1, "{%06x}VIP{ffffff} [%s{ffffff}]{%06x}%s{ffffff}[%d]{"COR_BRANCO_INC"}: %s", (Jogador[playerid][CorTag] >>> 8), tagbase, (GetPlayerColor(playerid) >>> 8), GetUserName(playerid), playerid, text);
						}
						else 
						{
							SendClientMessage(i, -1, "{%06x}VIP{ffffff} {%06x}%s{ffffff}[%d]{"COR_BRANCO_INC"}: %s", (Jogador[playerid][CorTag] >>> 8), (GetPlayerColor(playerid) >>> 8), GetUserName(playerid), playerid, text);
						}
					}

				}
			}
			else
			{
				foreach(new i: Player)
				{
					if(IsPlayerInRangeOfPoint(i, 20.0, x, y, z)  && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)){
						if(Jogador[playerid][BaseID] >= 0)
						{
							SendClientMessage(i, -1, "[%s{ffffff}]{%06x}%s{ffffff}[%d]{"COR_BRANCO_INC"}: %s", tagbase, (GetPlayerColor(playerid) >>> 8), GetUserName(playerid), playerid, text);
						}
						else
						{
							SendClientMessage(i, -1, "{%06x}%s{ffffff}[%d]{"COR_BRANCO_INC"}: %s", (GetPlayerColor(playerid) >>> 8), GetUserName(playerid), playerid, text);
						}
					}
				}
			}
		}
		return Y_HOOKS_CONTINUE_RETURN_0;
	}
	return Y_HOOKS_CONTINUE_RETURN_0;
}

/*
			if(Jogador[playerid][Beta] == 4)
			{
				foreach(new i: Player)
				{
					if(IsPlayerInRangeOfPoint(i, 20.0, x, y, z) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)){
						if(Jogador[playerid][MembroBase] > 0)
						{
							SendClientMessage(i, -1, "{921515}YouTuber{ffffff} [%s{ffffff}]{%06x}%s{ffffff}[%d]{"COR_BRANCO_INC"}: %s", Jogador[playerid][TAGBase], (GetPlayerColor(playerid) >>> 8), GetUserName(playerid), playerid, text);
						}
						else 
						{
							SendClientMessage(i, -1, "{921515}YouTuber{ffffff} {%06x}%s{ffffff}[%d]{"COR_BRANCO_INC"}: %s", (GetPlayerColor(playerid) >>> 8), GetUserName(playerid), playerid, text);
						}
					}
				}
				return 1;
			}

			if(Jogador[playerid][Beta] == 3)
			{
				foreach(new i: Player)
				{
					if(IsPlayerInRangeOfPoint(i, 20.0, x, y, z) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)){
						if(Jogador[playerid][MembroBase] > 0)
						{
							SendClientMessage(i, -1, "{4910B4}DJ{ffffff} [%s{ffffff}]{%06x}%s{ffffff}[%d]{"COR_BRANCO_INC"}: %s", Jogador[playerid][TAGBase], (GetPlayerColor(playerid) >>> 8), GetUserName(playerid), playerid, text);
						}
						else 
						{
							SendClientMessage(i, -1, "{4910B4}DJ{ffffff} {%06x}%s{ffffff}[%d]{"COR_BRANCO_INC"}: %s", (GetPlayerColor(playerid) >>> 8), GetUserName(playerid), playerid, text);
						}
					}
				}
				return 1;
			}
			if(Jogador[playerid][Beta] == 2)
			{
				foreach(new i: Player)
				{
					if(IsPlayerInRangeOfPoint(i, 20.0, x, y, z) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)){
						if(Jogador[playerid][MembroBase] > 0)
						{
							SendClientMessage(i, -1, "{ff00ff}Mapper{ffffff} [%s{ffffff}]{%06x}%s{ffffff}[%d]{"COR_BRANCO_INC"}: %s", Jogador[playerid][TAGBase], (GetPlayerColor(playerid) >>> 8), GetUserName(playerid), playerid, text);
						}
						else 
						{
							SendClientMessage(i, -1, "{ff00ff}Mapper{ffffff} {%06x}%s{ffffff}[%d]{"COR_BRANCO_INC"}: %s", (GetPlayerColor(playerid) >>> 8), GetUserName(playerid), playerid, text);
						}
					}
				}
				return 1;
			}
			if(Jogador[playerid][Beta] == 1)
			{
				foreach(new i: Player)
				{
					if(IsPlayerInRangeOfPoint(i, 20.0, x, y, z) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)){
						if(Jogador[playerid][MembroBase] > 0)
						{
							SendClientMessage(i, -1, "{c4c4c4}Beta{ffffff} [%s{ffffff}]{%06x}%s{ffffff}[%d]{"COR_BRANCO_INC"}: %s", Jogador[playerid][TAGBase], (GetPlayerColor(playerid) >>> 8), GetUserName(playerid), playerid, text);
						}
						else 
						{
							SendClientMessage(i, -1, "{c4c4c4}Beta{ffffff} {%06x}%s{ffffff}[%d]{"COR_BRANCO_INC"}: %s", (GetPlayerColor(playerid) >>> 8), GetUserName(playerid), playerid, text);
						}
					}
				}
				return 1;
			}

*/


stock Nitro2(vehicleid)
{
    new nos = GetVehicleModel(vehicleid);
    switch(nos)
    {
        case 444: return 0; case 581: return 0; case 586: return 0; case 481: return 0; case 509: return 0;
        case 446: return 0; case 556: return 0; case 443: return 0; case 452: return 0; case 453: return 0;
        case 454: return 0; case 472: return 0; case 473: return 0; case 484: return 0; case 493: return 0;
        case 595: return 0; case 462: return 0; case 463: return 0; case 468: return 0; case 521: return 0;case 522:
        return 0;case 417:return 0;case 425:return 0;case 447:return 0;case 487:return 0;case 488:return 0;case 497:
        return 0;case 501:return 0;case 548:return 0;case 563:return 0;case 406:return 0;case 520:return 0;
        case 539:return 0;case 553:return 0;case 557:return 0;case 573:return 0;case 460:return 0;case 593:
        return 0;case 464:return 0;case 476:return 0;case 511:return 0;case 512:return 0;case 577:return 0;
        case 592:return 0;case 471:return 0;case 448:return 0;case 461:return 0; case 523:return 0;case 510:
        return 0;case 430:return 0;case 465:return 0;case 469:return 0; case 513:return 0;case 519:return 0;
    }
    return true;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(IsPlayerInAnyVehicle(playerid)) 
	{
        if(call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE || Jogador[playerid][Vip] == true || Jogador[playerid][Beta] > 0)  {
        	new nos = GetPlayerVehicleID(playerid);
        	new var5 = 0; 
		    var5 = GetPlayerVehicleID(playerid); 
		    if( call::PLAYER->GetPlayerVarBool(playerid, Perseguido) )
				return true; // Verificar
			
			if(Nitro2(nos) && (oldkeys & 1 || oldkeys & 4))
			{
				if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
				{
					AddVehicleComponent(var5, 1010);
				}
			}

            if(Nitro2(nos) && (oldkeys & 1 || oldkeys & 4)) {
                if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
                	if(Autotunning[playerid] == 1) 
                	{
		                if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 562) { 
		                    AddVehicleComponent(var5, 1046); 
		                    AddVehicleComponent(var5, 1171); 
		                    AddVehicleComponent(var5, 1149); 
		                    AddVehicleComponent(var5, 1035); 
		                    AddVehicleComponent(var5, 1147); 
		                    AddVehicleComponent(var5, 1036); 
		                    AddVehicleComponent(var5, 1040); 
		                    ChangeVehiclePaintjob(var5, 2); 
		                    AddVehicleComponent(var5, 1010); 
		                    AddVehicleComponent(var5, 1079); 
		                }
		                if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 560) { 
		                    AddVehicleComponent(var5, 1028); 
		                    AddVehicleComponent(var5, 1169); 
		                    AddVehicleComponent(var5, 1141); 
		                    AddVehicleComponent(var5, 1032); 
		                    AddVehicleComponent(var5, 1138); 
		                    AddVehicleComponent(var5, 1026); 
		                    AddVehicleComponent(var5, 1027); 
		                    ChangeVehiclePaintjob(var5, 2); 
		                    AddVehicleComponent(var5, 1010); 
		                    AddVehicleComponent(var5, 1079); 
		                } 
		                if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 565) { 
		                    AddVehicleComponent(var5, 1046); 
		                    AddVehicleComponent(var5, 1153); 
		                    AddVehicleComponent(var5, 1150); 
		                    AddVehicleComponent(var5, 1054); 
		                    AddVehicleComponent(var5, 1049); 
		                    AddVehicleComponent(var5, 1047); 
		                    AddVehicleComponent(var5, 1051); 
		                    AddVehicleComponent(var5, 1010); 
		                    AddVehicleComponent(var5, 1079); 
		                    ChangeVehiclePaintjob(var5, 2); 
		                } 
		                if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 559) { 
		                    AddVehicleComponent(var5, 1065); 
		                    AddVehicleComponent(var5, 1160); 
		                    AddVehicleComponent(var5, 1159); 
		                    AddVehicleComponent(var5, 1067); 
		                    AddVehicleComponent(var5, 1162); 
		                    AddVehicleComponent(var5, 1069); 
		                    AddVehicleComponent(var5, 1071); 
		                    AddVehicleComponent(var5, 1010); 
		                    AddVehicleComponent(var5, 1079); 
		                    ChangeVehiclePaintjob(var5, 2); 
		                } 
		                if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 561) { 
		                    AddVehicleComponent(var5, 1064); 
		                    AddVehicleComponent(var5, 1155); 
		                    AddVehicleComponent(var5, 1154); 
		                    AddVehicleComponent(var5, 1055); 
		                    AddVehicleComponent(var5, 1158); 
		                    AddVehicleComponent(var5, 1056); 
		                    AddVehicleComponent(var5, 1062); 
		                    AddVehicleComponent(var5, 1010); 
		                    AddVehicleComponent(var5, 1079); 
		                    ChangeVehiclePaintjob(var5, 2); 
		                } 
		                if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 558) { 
		                    AddVehicleComponent(var5, 1089); 
		                    AddVehicleComponent(var5, 1166); 
		                    AddVehicleComponent(var5, 1168); 
		                    AddVehicleComponent(var5, 1088); 
		                    AddVehicleComponent(var5, 1164); 
		                    AddVehicleComponent(var5, 1090); 
		                    AddVehicleComponent(var5, 1094); 
		                    AddVehicleComponent(var5, 1010); 
		                    AddVehicleComponent(var5, 1079); 
		                    ChangeVehiclePaintjob(var5, 2); 
		                } 
		                if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 575) { 
		                    AddVehicleComponent(var5, 1044); 
		                    AddVehicleComponent(var5, 1174); 
		                    AddVehicleComponent(var5, 1176); 
		                    AddVehicleComponent(var5, 1042); 
		                    AddVehicleComponent(var5, 1099); 
		                    AddVehicleComponent(var5, 1010); 
		                    AddVehicleComponent(var5, 1079); 
		                    ChangeVehiclePaintjob(var5, 2); 
		                } 
		                if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 534) { 
		                    AddVehicleComponent(var5, 1126); 
		                    AddVehicleComponent(var5, 1179); 
		                    AddVehicleComponent(var5, 1180); 
		                    AddVehicleComponent(var5, 1122); 
		                    AddVehicleComponent(var5, 1101); 
		                    AddVehicleComponent(var5, 1125); 
		                    AddVehicleComponent(var5, 1123); 
		                    AddVehicleComponent(var5, 1100); 
		                    AddVehicleComponent(var5, 1010); 
		                    AddVehicleComponent(var5, 1079); 
		                    ChangeVehiclePaintjob(var5, 2); 
		                } 
		                if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 536) { 
		                    AddVehicleComponent(var5, 1104); 
		                    AddVehicleComponent(var5, 1182); 
		                    AddVehicleComponent(var5, 1184); 
		                    AddVehicleComponent(var5, 1108); 
		                    AddVehicleComponent(var5, 1107); 
		                    AddVehicleComponent(var5, 1010); 
		                    AddVehicleComponent(var5, 1079); 
		                    ChangeVehiclePaintjob(var5, 2); 
		                } 
		                if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 535) { 
		                    AddVehicleComponent(var5, 1104); 
		                    AddVehicleComponent(var5, 1182); 
		                    AddVehicleComponent(var5, 1184); 
		                    AddVehicleComponent(var5, 1108); 
		                    AddVehicleComponent(var5, 1107); 
		                    AddVehicleComponent(var5, 1010); 
		                    AddVehicleComponent(var5, 1079); 
		                    ChangeVehiclePaintjob(var5, 2); 
		                } 
		                if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 567) { 
		                    AddVehicleComponent(var5, 1129); 
		                    AddVehicleComponent(var5, 1189); 
		                    AddVehicleComponent(var5, 1187); 
		                    AddVehicleComponent(var5, 1102); 
		                    AddVehicleComponent(var5, 1133); 
		                    AddVehicleComponent(var5, 1010); 
		                    AddVehicleComponent(var5, 1079); 
		                    ChangeVehiclePaintjob(var5, 2); 
		                } 
		                if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 420) { 
		                    AddVehicleComponent(var5, 1010); 
		                    AddVehicleComponent(var5, 1079); 
		                    AddVehicleComponent(var5, 1139); 
		                    AddVehicleComponent(var5, 1147); 
		                } 
		                if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 400) { 
		                    AddVehicleComponent(var5, 1010); 
		                    AddVehicleComponent(var5, 1018); 
		                    AddVehicleComponent(var5, 1013); 
		                    AddVehicleComponent(var5, 1079); 
		                    AddVehicleComponent(var5, 1086); 
		                } 
		                if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 444) { 
		                    AddVehicleComponent(var5, 1010); 
		                    AddVehicleComponent(var5, 1079); 
		                } 
		                if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 556) { 
		                    AddVehicleComponent(var5, 1010); 
		                    AddVehicleComponent(var5, 1079); 
		                } 
		                if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 557) { 
		                    AddVehicleComponent(var5, 1010); 
		                    AddVehicleComponent(var5, 1079); 
		                } 
		                if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 401) { 
		                    AddVehicleComponent(var5, 1086); 
		                    AddVehicleComponent(var5, 1139); 
		                    AddVehicleComponent(var5, 1079); 
		                    AddVehicleComponent(var5, 1010); 
		                    AddVehicleComponent(var5, 1012); 
		                    AddVehicleComponent(var5, 1013); 
		                    AddVehicleComponent(var5, 1042); 
		                    AddVehicleComponent(var5, 1043); 
		                    AddVehicleComponent(var5, 1018); 
		                    AddVehicleComponent(var5, 1006); 
		                    AddVehicleComponent(var5, 1007); 
		                    AddVehicleComponent(var5, 1017); 
		                } 
		                if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 483) { 
		                    AddVehicleComponent(var5, 1028); 
		                    AddVehicleComponent(var5, 1169); 
		                    AddVehicleComponent(var5, 1141); 
		                    AddVehicleComponent(var5, 1032); 
		                    AddVehicleComponent(var5, 1138); 
		                    AddVehicleComponent(var5, 1026); 
		                    AddVehicleComponent(var5, 1027); 
		                    ChangeVehiclePaintjob(var5, 0); 
		                    AddVehicleComponent(var5, 1010); 
		                    AddVehicleComponent(var5, 1079); 
		                } 
		                if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 576) { 
		                    ChangeVehiclePaintjob(var5, 2); 
		                    AddVehicleComponent(var5, 1191); 
		                    AddVehicleComponent(var5, 1193); 
		                    AddVehicleComponent(var5, 1010); 
		                    AddVehicleComponent(var5, 1018); 
		                    AddVehicleComponent(var5, 1079); 
		                    AddVehicleComponent(var5, 1134); 
		                    AddVehicleComponent(var5, 1137); 
		                } 
		                else{ 
		                    AddVehicleComponent(var5, 1010); 
		                    AddVehicleComponent(var5, 1079); 
		                } 
                	}
                	if(GodCar[playerid] == false)
                	{
                		RepairVehicle(var5);
                	}
                }
            }
        }
    }
	return Y_HOOKS_CONTINUE_RETURN_1;
}

public OnPlayerAuthLogin(playerid)
{
	if(call::PLAYER->IsPlayerLogged(playerid) || !call::PLAYER->IsPlayerLoggin(playerid))
		return false;

	if( !cache_num_rows() ) {
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Os dados digitados não conferem, verifique o nick e a senha.");
		return 1;
	}

	call::PLAYER->SetPlayerVarInt(playerid, CallerID, INVALID_PLAYER_ID);

	CleanChat(playerid);
	SendClientMessage(playerid, COR_SISTEMA, "| INFO | {"COR_BRANCO_INC"}Carregando sua conta...");
	
	/**
	 *
	 * Enviar mensagem no chat principal do discord
	 *
	 */

	/**
	*
	*	Destruir textdraws de login
	*
	**/
	call::TD->DestroyPlayerConnect(playerid);
	call::TD->HidePlayerLogin(playerid);

	call::PLAYER->TogglePlayerLoggin(playerid, false);

	new value_int, Float:value_float, lastLogin[30], __strstatus[30];

	cache_get_value_name_int(0, "id", Jogador[playerid][PlayerID]);

	cache_get_value_name(0, "lastLogin", lastLogin, sizeof(lastLogin));

	cache_get_value_name(0, "username", Jogador[playerid][Nome], MAX_PLAYER_NAME);
	SetPlayerName(playerid, Jogador[playerid][Nome]);
	
	cache_get_value_name(0, "email", Jogador[playerid][Email], MAX_PLAYER_EMAIL);

	cache_get_value_name_float(0, "spawn_x", Jogador[playerid][Spawn][X]);
	cache_get_value_name_float(0, "spawn_y", Jogador[playerid][Spawn][Y]);
	cache_get_value_name_float(0, "spawn_z", Jogador[playerid][Spawn][Z]);
	cache_get_value_name_float(0, "spawn_a", Jogador[playerid][Spawn][A]);
	cache_get_value_name_int(0, "skin", Jogador[playerid][Skin]);
	cache_get_value_name_int(0, "profissao", Jogador[playerid][Profissao]);

	cache_get_value_name_int(0, "vip", Jogador[playerid][Vip]); // VIP
	cache_get_value_name_int(0, "vencimento_vip", Jogador[playerid][TempoVip]);

	cache_get_value_name_int(0, "beta", Jogador[playerid][Beta]); // Beta
	
	SetSpawnInfo(playerid, NO_TEAM, Jogador[playerid][Skin], Jogador[playerid][Spawn][X], Jogador[playerid][Spawn][Y], Jogador[playerid][Spawn][Z], Jogador[playerid][Spawn][A], 0, 0, 0, 0, 0, 0);

	cache_get_value_name_int(0, "world", Jogador[playerid][World]);
	SetPlayerVirtualWorld(playerid, Jogador[playerid][World]);

	cache_get_value_name_int(0, "interior", Jogador[playerid][Interior]);
	SetPlayerInterior(playerid, Jogador[playerid][Interior]);

	cache_get_value_name_int(0, "level", value_int);
	SetPlayerScore(playerid, value_int);

	cache_get_value_name_int(0, "dinheiro", value_int);
	GivePlayerMoney(playerid, value_int);

	cache_get_value_name_float(0, "vida", value_float);
	SetPlayerHealth(playerid, (value_float > 5.0 ? value_float : 5.0));

	cache_get_value_name_float(0, "colete", value_float);

	//cache_get_value_name_int(0, "exp", Jogador[playerid][EXP]);
	cache_get_value_name_int(0, "porc_level", Jogador[playerid][PorcLevel]);
	format(__strstatus, sizeof(__strstatus), "%d%", Jogador[playerid][PorcLevel]);
	PlayerTextDrawSetString(playerid, ExpOP[playerid][0], __strstatus);

	cache_get_value_name_int(0, "upm", Jogador[playerid][UPm]);
	cache_get_value_name_int(0, "ups", Jogador[playerid][UPs]);

	//cache_get_value_name_float(0, "fome", Jogador[playerid][Fome]);
	//cache_get_value_name_float(0, "sede", Jogador[playerid][Sede]);
	//cache_get_value_name_float(0, "sono", Jogador[playerid][Sono]);
	cache_get_value_name_int(0, "fome", Jogador[playerid][Fome]);
	cache_get_value_name_int(0, "sede", Jogador[playerid][Sede]);
	cache_get_value_name_int(0, "sono", Jogador[playerid][Sono]);
	format(__strstatus, sizeof(__strstatus), "%d%", Jogador[playerid][Fome]);
	PlayerTextDrawSetString(playerid, StatusOP[playerid][3], __strstatus);

	format(__strstatus, sizeof(__strstatus), "%d%", Jogador[playerid][Sede]);
	PlayerTextDrawSetString(playerid, StatusOP[playerid][4], __strstatus);

	format(__strstatus, sizeof(__strstatus), "%d%", Jogador[playerid][Sono]);
	PlayerTextDrawSetString(playerid, StatusOP[playerid][5], __strstatus);

	//call::TD->ShowPlayerHud(playerid);
	//call::TD->ShowPlayerHudStatus(playerid);
	
	cache_get_value_name_int(0, "multas", Jogador[playerid][Multas]);

	cache_get_value_name_int(0, "mercadoria", Jogador[playerid][Mercadoria]);

	cache_get_value_name_int(0, "bloqueado_carga", Jogador[playerid][bCarga]);
	
	cache_get_value_name_int(0, "celular", Jogador[playerid][Celular]);
	cache_get_value_name_int(0, "saldo", Jogador[playerid][SaldoCelular]);
	cache_get_value_name_bool(0, "gps", Jogador[playerid][GPS]);
	cache_get_value_name_bool(0, "agenda", Jogador[playerid][Agenda]);
	cache_get_value_name_int(0, "mp3", Jogador[playerid][MP3]);
	cache_get_value_name_int(0, "galao", Jogador[playerid][Galao]);
	cache_get_value_name_int(0, "kills", Jogador[playerid][Matou]);
	cache_get_value_name_int(0, "deaths", Jogador[playerid][Morreu]);

	cache_get_value_name_int(0, "pin", Jogador[playerid][PIN]);
	cache_get_value_name_int(0, "pinativo", Jogador[playerid][PinAtivo]);

	new value_base;
	cache_get_value_int(0, "baseid", value_base);
	Jogador[playerid][BaseID] = GetBaseIdByRow(value_base);


	//cache_get_value_name_int(0, "kit-favela", Jogador[playerid][KitFavela]);

	// player skills
	/*cache_get_value_name_int(0, "skill_pistol", Jogador[playerid][SkillPistol]);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, Jogador[playerid][SkillPistol]);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, Jogador[playerid][SkillPistol]);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, Jogador[playerid][SkillPistol]);

	cache_get_value_name_int(0, "skill_fuzil", Jogador[playerid][SkillFuzil]);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, Jogador[playerid][SkillFuzil]);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, Jogador[playerid][SkillFuzil]);

	cache_get_value_name_int(0, "skill_mp5", Jogador[playerid][SkillMP5]);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, Jogador[playerid][SkillMP5]);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, Jogador[playerid][SkillMP5]);

	cache_get_value_name_int(0, "skill_shotgun", Jogador[playerid][SkillShotgun]);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, Jogador[playerid][SkillShotgun]);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, Jogador[playerid][SkillShotgun]);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, Jogador[playerid][SkillShotgun]);

	cache_get_value_name_int(0, "skill_rifle", Jogador[playerid][SkillRifle]);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, Jogador[playerid][SkillRifle]);*/


	cache_get_value_name_int(0, "estrelas", value_int);
	SetPlayerWantedLevel(playerid, value_int);
	
	cache_get_value_name_int(0, "avisos", Jogador[playerid][Avisos]);

	cache_get_value_name_int(0, "preso", Jogador[playerid][Preso]);
	cache_get_value_name_int(0, "tempo_preso", Jogador[playerid][TempoPreso]);

	cache_get_value_name_int(0, "cash", Jogador[playerid][Cash]);

	cache_get_value_name_int(0, "plano_saude", Jogador[playerid][Plano]);

	cache_get_value_name_int(0, "habilitacao_a", value_int);
	if ( value_int )
		BitFlag_Set(Jogador[playerid][Habilitacao], HAB_MOTO);

	cache_get_value_name_int(0, "habilitacao_b", value_int);
	if ( value_int )
		BitFlag_Set(Jogador[playerid][Habilitacao], HAB_CARRO);

	cache_get_value_name_int(0, "habilitacao_c", value_int);
	if ( value_int )
		BitFlag_Set(Jogador[playerid][Habilitacao], HAB_CAMINHAO);

	cache_get_value_name_int(0, "habilitacao_d", value_int);
	if ( value_int )
		BitFlag_Set(Jogador[playerid][Habilitacao], HAB_BARCO);

	cache_get_value_name_int(0, "habilitacao_e", value_int);
	if ( value_int )
		BitFlag_Set(Jogador[playerid][Habilitacao], HAB_AVIAO);

	cache_get_value_name_int(0, "sementes", Jogador[playerid][Sementes]);
	cache_get_value_name_int(0, "sementesl", Jogador[playerid][SementesL]);
	
	cache_get_value_name_int(0, "maconha", Jogador[playerid][Maconha]);
	cache_get_value_name_int(0, "cocaina", Jogador[playerid][Cocaina]);
	cache_get_value_name_int(0, "crack", Jogador[playerid][Crack]);
	cache_get_value_name_int(0, "materias", Jogador[playerid][Materias]);
	cache_get_value_name_int(0, "morador_casa_id", Jogador[playerid][pMorador]); // retorna o id da casa na tabela do banco de dados.
	
	// carregar casa
	cache_get_value_name_int(0, "entrou", Jogador[playerid][Entrou]);
	new casaid = GetPlayerHouse(playerid);
	if ( casaid != INVALID_HOUSE_ID )
	{
		Jogador[playerid][TimeContinuar] = gettime() + 20;

		SetSpawnInfo(playerid, NO_TEAM, Jogador[playerid][Skin], Casa[casaid][Saida][X], Casa[casaid][Saida][Y], Casa[casaid][Saida][Z], Casa[casaid][Saida][A], 0, 0, 0, 0, 0, 0);
		SetPlayerInterior(playerid, Casa[casaid][Interior]);
		SetPlayerVirtualWorld(playerid, casaid);
		Jogador[playerid][Entrou] = ENTROU_CASA;
	}

	cache_get_value_name_int(0, "empresaid", value_int);
	Jogador[playerid][EmpresaID] = GetBusinessIdByRow(value_int);

	//	Load player faction.
	cache_get_value_name_int(0, "faccao", value_int);
	LoadPlayerFaction(playerid, value_int);

	cache_get_value_name_int(0, "cargo_faccao", value_int);
	call::PLAYER->SetPlayerVarInt(playerid, pCargo, value_int);

	cache_get_value_name_int(0, "tutorial", value_int);
	if(!value_int){
		call::TUTO->InitPlayerTutorial(playerid);
		return true;
	}

	cache_get_value_name_int(0, "admin", value_int);
	call::ADMIN->SetPlayerAdminLevel(playerid, value_int);

	if(value_int >= AJUDANTE)
	{
		cache_get_value_name_int(0, "admin_trabalhando_horas", Jogador[playerid][TempoAtividade][HORAS]);
		cache_get_value_name_int(0, "admin_trabalhando_minutos", Jogador[playerid][TempoAtividade][MINUTOS]);
		cache_get_value_name_int(0, "admin_trabalhando_segundos", Jogador[playerid][TempoAtividade][SEGUNDOS]);
		cache_get_value_name_int(0, "admin_avisos", Jogador[playerid][AdminAvisos]);
	}
	TogglePlayerSpectating(playerid, false);

	if(call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE)
	{
		Jogador[playerid][AdmTempoLogado] = gettime();
	}

	/*new str[20];
	for(new i=1; i <= 7; i++)
	{
		format(str, sizeof(str), "slot%d", i);
		cache_get_value_name_int(0, str, weaponid);

		format(str, sizeof(str), "slot%d_ammo", i);
		cache_get_value_name_int(0, str, ammo);

		GivePlayerWeapon(playerid, weaponid, ammo);
	}*/

	//SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Olá Sr(a) {"COR_SISTEMA_INC"}%s{"COR_BRANCO_INC"}, nos vimos pela ultima vez em %s", GetUserName(playerid), lastLogin);
	
	SendClientMessage(playerid, COR_VERDE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

	SendClientMessage(playerid, COR_SISTEMA, "| INFO | {ffffff}Bem-vindo(a) novamente, {"COR_VERDE_INC"}%s", GetUserName(playerid));
	SendClientMessage(playerid, COR_SISTEMA, "| INFO | {ffffff}Seu último login foi em {"COR_VERMELHO_INC"}%s", lastLogin);

	new ExpirarVip[128], query[326];
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
	else 
	{
		rHoraMinuto(Jogador[playerid][TempoVip], ExpirarVip, sizeof(ExpirarVip));
		SendClientMessage(playerid, COR_SISTEMA, "| INFO | {ffffff}Faltam {ffff00}%s {ffffff}para seu VIP vencer, aproveite ao máximo!", ExpirarVip);
	}

	if ( Jogador[playerid][TimeContinuar] != 0)
		SendClientMessage(playerid, COR_SISTEMA, "| INFO | {ffffff}Use o comando {"COR_LARANJA_INC"}/Continuar {ffffff}para ir até onde você deslogou!");
	SendClientMessage(playerid, COR_VERDE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

	SetTimerEx("VerifyCommit", 1000, 0, "i", playerid);

	/**
	*
	*	Prender jogador.
	*
	**/
	if ( Jogador[playerid][Preso] != SOLTO )
	{
		EnviarCela(playerid);
		call::PM->ShowPlayerTextDrawPrisonTime(playerid);
		SendClientMessage(playerid, 0xB1DD00FF, "| INFO | Você ainda não cumpriu sua pena.");
	}

	/**
	*
	*	Banir Jogador.
	*
	**/
	new ip[16];
	GetPlayerIp(playerid, ip, 16);
	mysql_format(getConexao(), query, sizeof(query), "SELECT * FROM "TABLE_BANNEDS" WHERE `username`='%s' OR `ip`='%s' LIMIT 1;", GetUserName(playerid), ip);
	mysql_tquery(getConexao(), query, "OnUserBanDataLoad", "i", playerid);

	/*if(Jogador[playerid][Fome] > 100 || Jogador[playerid][Sede] > 100 || Jogador[playerid][Sono] > 100)
	{
		SendClientMessage(playerid, COR_AMARELO, "| INFO | Identificamos que seu Sistema FSS está incorreto. Seu FSS foi setado automaticamente para 100.");
		Jogador[playerid][Fome] = 100;
		Jogador[playerid][Sono] = 100;
		Jogador[playerid][Sede] = 100;

		new String[70];

		format(String, sizeof(String), "%d%", Jogador[playerid][Sede]);
		PlayerTextDrawSetString(playerid, StatusOP[playerid][4], String);

		format(String, sizeof(String), "%d%", Jogador[playerid][Fome]);
		PlayerTextDrawSetString(playerid, StatusOP[playerid][3], String);

		format(String, sizeof(String), "%d%", Jogador[playerid][Sono]);
		PlayerTextDrawSetString(playerid, StatusOP[playerid][5], String);
	}*/

	TimerSede[playerid] = SetTimerEx("Timer@SEDE", 60000, 1, "i", playerid);
	TimerFome[playerid] = SetTimerEx("Timer@FOME", 120000, 1, "i", playerid);
	TimerSono[playerid] = SetTimerEx("Timer@SONO", 300000, 1, "i", playerid);

	TimerATTFSS[playerid] = SetTimerEx("AttFSS", 1000, 1, "i", playerid);

	printf("Timer FSS iniciado pra %s", GetUserName(playerid));

	// carregar veiculo do jogador
	LoadPlayerVehicles(playerid);
	VerifyCooldown(playerid);
	return true;
}

forward VerifyCommit(playerid);
public VerifyCommit(playerid)
{
	if(strfind(GetUserName(playerid), "conectando") != -1)
	{
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode logar com este nick.");
		Kick(playerid);
	}
	return 1;
}

forward OnUserBanDataLoad(playerid);
public OnUserBanDataLoad(playerid)
{
	if (cache_num_rows() == 1) {

		foreach(new i: VehiclePlayers)
		{
			if ( Jogador[playerid][PlayerID] == Vehicle[i][Owner][Id] )
			{
				DestroyVehicle(Vehicle[i][Id]);
				new r[e_VEHICLE_INFO];
				Vehicle[i] = r;
			}
		}
		
		ShowPlayerInfoBanned(playerid);
		SetTimerEx("BanKick", 150, 0, "i", playerid);
	}
	return true;
}

forward BanKick(playerid);
public BanKick(playerid) {
    return Kick(playerid);
}

public OnPlayerRegister(playerid)
{
	CleanChat(playerid);

	new id = cache_insert_id();
	if( cache_affected_rows() != 1 )
	{
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foi possivel registrar sua conta em nosso banco de dados.");
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Por favor tire print apertando a tecla F8 e poste a no fórum.");
		return true;
	}
	
	new _log[128];
	format(_log, sizeof(_log), "A conta de %s foi criada, a inserção demorou %d ms", GetUserName(playerid), cache_get_query_exec_time());
	print(_log);
	
	call::TD->ShowPlayerLogin(playerid);
	call::TD->UpdateTextDrawLogin();
	
	new query[200], codigo[11];

	randomstring(codigo, sizeof(codigo)-1);

	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `codigo_ativacao`='%s' WHERE `id`='%d' LIMIT 1;", codigo, id);
	mysql_tquery(getConexao(), query);
	/*
	new str[200];
	format(str, sizeof(str), "Nick: <b>%s</b><br>Senha: <b>%s</b><br>código: <b>%s</b>", GetUserName(playerid), Jogador[playerid][Senha], codigo);
	SendEmail(SERVER_EMAIL, Jogador[playerid][Email], "Perfect City RPG - Ativar conta", str, "registro.php");
	*/


	new msg[500], Year, Month, Day,Hour, Minute, Second, IP[16];
	gettime(Hour, Minute, Second);
	getdate(Year, Month, Day);
	GetPlayerIp(playerid, IP, sizeof IP);
	format(msg, sizeof(msg), 
		"#PLAYERNAME:%s\
		#PLAYERNAME:%s\
		#PADDRESS:%s\
		#PEMAIL:%s\
		#DREG:%d/%02d/%02d %02d:%02d:%02d\
		#PCODE:%s", GetUserName(playerid), GetUserName(playerid), IP, Jogador[playerid][Email], Year, Month, Day, Hour, Minute, Second, codigo);
	SendEmail("Ativação de sua conta", Jogador[playerid][Email], "Registro - Perfect City RPG", msg, true);

	SendClientMessage(playerid, COR_VERDE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, COR_BRANCO, "| INFO | Bem-vindo(a) {ff8000}%s{ffffff}, sua conta foi criada com sucesso!", GetUserName(playerid));
	SendClientMessage(playerid, COR_BRANCO, "| INFO | Clique em 'Login' para efetuar seu login em nosso servidor");
	//SendClientMessage(playerid, COR_VERMELHO, "| AVISO | {ffffff}Foi enviado para você um e-mail com um código de ativação, verifique sua caixa de entrada/spam");
	SendClientMessage(playerid, COR_VERDE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	//SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Sua conta foi registrada com {"COR_VERDE_INC"}sucesso{"COR_BRANCO_INC"}.");
	//SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Foi enviado para você um email com o código de ativação.");
	//SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Verifique na sua caixa de entrada e Spam.");

	foreach(new i: Player)
	{
		if(call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE && call::ADMIN->IsAdminInJob(i) == 1)
		{
			SendClientMessage(i, -1, "| NOVATO | O(A) jogador(a) {1c88f0}%s[%d] {ffffff}acaba de entrar no servidor.", GetUserName(playerid), playerid);
		}
	}

	TimerSede[playerid] = SetTimerEx("Timer@SEDE", 120000, 1, "i", playerid);
	TimerFome[playerid] = SetTimerEx("Timer@FOME", 240000, 1, "i", playerid);
	TimerSono[playerid] = SetTimerEx("Timer@SONO", 300000, 1, "i", playerid);

	printf("Timer FSS iniciado pra %s", GetUserName(playerid));
	return true;
}


public GetPlayerHospital(playerid)
{
    if(!IsPlayerConnected(playerid))
		return -1;

    new
		Float:dist, prevhosp, Float:distancia = 100000.000;
	for(new hospid = 1; hospid < 7; hospid++)
	{
        if(hospid == 1)
	        dist = GetPlayerDistanceToPoint(playerid, 1173.1145, -1323.7125); // Hospital de Los Santos Perto da Ammu-Nation
        else if(hospid == 2)
			dist = GetPlayerDistanceToPoint(playerid, 2036.5521, -1412.5513); // Hospital de Los Santos Perto da Favela
        else if(hospid == 3)
			dist = GetPlayerDistanceToPoint(playerid, 1607.4396, 1819.1462); // Hspital de Las Venturas
        else if(hospid == 4)
			dist = GetPlayerDistanceToPoint(playerid, -2665.0503, 636.5155); // Hospital de San Fierro
        else if(hospid == 5)
			dist = GetPlayerDistanceToPoint(playerid, -315.0838, 1050.7095); // Hospital de Fort Carson
        else if(hospid == 6)
			dist = GetPlayerDistanceToPoint(playerid, -1514.6455, 2523.4263); // Hospital de El-Quebrados
        else if(hospid == 7)
			dist = GetPlayerDistanceToPoint(playerid, -2208.2485, -2286.8516); // Hospital de Angel Pine

        if((dist < distancia)){
            distancia = dist, prevhosp = hospid;
		}
	}
	return prevhosp;
}

new static TocandoTimer[MAX_PLAYERS][2], TimerCobranca[MAX_PLAYERS] = -1;
forward TocarCelular(playerid);
public TocarCelular(playerid)
{
	if ( call::PLAYER->GetPlayerVarInt(playerid, StateCell) == CHAMANDO )
	{
		PlayerPlaySound(playerid, 3401, 0.0, 0.0, 0.0);
		TocandoTimer[playerid][0] = SetTimerEx("TocarCelular2", 950, false, "i", playerid);
	}
	return 1;
}
forward TocarCelular2(playerid);
public TocarCelular2(playerid)
{
	if ( call::PLAYER->GetPlayerVarInt(playerid, StateCell) == CHAMANDO )
	{
		PlayerPlaySound(playerid, 3402, 0.0, 0.0, 0.0);
		TocandoTimer[playerid][1] = SetTimerEx("TocarCelular", 850, false, "i", playerid);
	}
	return 1;
}

forward ExpirouMaconha(playerid);
public ExpirouMaconha(playerid)
{
	DeletePVar(playerid, "OferecedorMID"), DeletePVar(playerid, "DinheiroMaconha"), DeletePVar(playerid, "MaconhaOferecida"), DeletePVar(playerid, "MQuantidade");
	return true;
}
forward ExpirouCocaina(playerid);
public ExpirouCocaina(playerid)
{
	DeletePVar(playerid, "OferecedorCID"), DeletePVar(playerid, "DinheiroCocaina"), DeletePVar(playerid, "CocainaOferecida"), DeletePVar(playerid, "CQuantidade");
	return true;
}

forward ExpirouCrack(playerid);
public ExpirouCrack(playerid)
{
	DeletePVar(playerid, "OferecedorCraID"), DeletePVar(playerid, "DinheiroCrack"), DeletePVar(playerid, "CrackOferecida"), DeletePVar(playerid, "CraQuantidade");
	return true;
}

stock function CELL::FinalizarChamada(playerid, id)
{
	SendClientMessage(id, COR_SISTEMA, "* Desligaram no outro lado da linha.");
	call::PLAYER->SetPlayerVarInt(id, StateCell, 0);
	SetPlayerSpecialAction(id, SPECIAL_ACTION_NONE);
	RemovePlayerAttachedObject(id, ATTACH_CELL);
	call::PLAYER->SetPlayerVarInt(id, CallerID, INVALID_PLAYER_ID);
	KillTimer(TocandoTimer[id][0]);
	KillTimer(TocandoTimer[id][1]);
	PlayerPlaySound(id, 3402, 0.0, 0.0, 0.0);
	call::CELL->PararCobranca(id);

	call::PLAYER->SetPlayerVarInt(playerid, StateCell, 0);
	SendClientMessage(playerid, COR_SISTEMA, "* Telefone foi desligado");
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	RemovePlayerAttachedObject(playerid, ATTACH_CELL);
	call::PLAYER->SetPlayerVarInt(playerid, CallerID, INVALID_PLAYER_ID);
	KillTimer(TocandoTimer[playerid][0]);
	KillTimer(TocandoTimer[playerid][1]);
	PlayerPlaySound(playerid, 3402, 0.0, 0.0, 0.0);
	call::CELL->PararCobranca(playerid);
	return true;
}

forward CobrarTarifaCelular(playerid);
public CobrarTarifaCelular(playerid)
{
	if ( call::PLAYER->GetPlayerVarInt(playerid, TypeCall) != EMERGENCIA)
	{
		if ( call::PLAYER->GetPlayerVarInt(playerid, SaldoCelular) < TARIFA_LIGACAO )
			return SendClientMessage(playerid, COR_BRANCO, "Você não tem mais créditos para continuar a ligação."), call::CELL->FinalizarChamada(playerid, call::PLAYER->GetPlayerVarInt(playerid, CallerID) );
		
		new str[70];
		format(str, sizeof(str), "~r~Créditos: R$%s", RealStr(call::PLAYER->GetPlayerVarInt(playerid, SaldoCelular)) );
		GameTextForPlayer(playerid, str, 3000, 1);

		call::PLAYER->SetPlayerVarInt(playerid, SaldoCelular, call::PLAYER->GetPlayerVarInt(playerid, SaldoCelular) - TARIFA_LIGACAO);
		TimerCobranca[playerid] = SetTimerEx("CobrarTarifaCelular", 60000, false, "i", playerid);
	}
	return true;
}

stock function CELL::PararCobranca(playerid)
{
	if ( TimerCobranca[playerid] != -1 )
	{
		KillTimer(TimerCobranca[playerid]);
		TimerCobranca[playerid]=-1;
	}
	return true;
}
#pragma unused TocandoTimer, TimerCobranca