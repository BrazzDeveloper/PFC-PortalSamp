// aa
CMD:ativarconta(playerid, params[])
{
	new query[256], code[20];

	if(sscanf(params, "s[20]", code))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use /AtivarConta ( código ) ");

	new Cache:__cache;
	mysql_format(getConexao(), query, sizeof(query), "SELECT `codigo_ativacao` FROM "TABLE_USERS" WHERE `username`='%s' AND `codigo_ativacao`='%s' LIMIT 1;", GetUserName(playerid), code);
	__cache = mysql_query(getConexao(), query, true);


	if(cache_num_rows())
	{
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `codigo_ativacao`='ativado' WHERE `username`='%s' LIMIT 1;", GetUserName(playerid));
		mysql_tquery(getConexao(), query), cache_delete(__cache);

		SendClientMessage(playerid, COR_VERDE, "| CONTA | {"COR_BRANCO_INC"}Sua conta foi ativada com {"COR_VERDE_INC"}sucesso{"COR_BRANCO_INC"}.");
		SendClientMessage(playerid, COR_VERDE, "| CONTA | {"COR_BRANCO_INC"}Tenha um bom jogo!");
	}
	else
	{
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Verifique sua {ffffff}/Identidade {"COR_ERRO_INC"}para ter certeza se já ativou sua conta.");
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Caso contrário, contate um desenvolvedor.");
	}

	return true;
}


CMD:regras(playerid) {
	new StringCat[2000];
	strcat(StringCat, "\n{FF0000}Vaga de ADM {FFFFFF}- Nunca fique pedindo se tem vagas para ajudante/Moderador/Administrador, todos jogadores são avaliados\n");
	strcat(StringCat, "{FFFFFF}aquele que joga direito e ajuda os demais jogadores sempre tem uma grande chance quando abrirmos vagas\n");
	strcat(StringCat, "\n{FF0000}Vantagens sobre usuários {FFFFFF}- É extremamente proibido pedir grana, level, VIP, cash para qualquer membro da Administração,a insistência poderá resultar no ban do mesmo.\n");
    strcat(StringCat, "\n{FF0000}Drive By DB {FFFFFF}- Nunca mate um jogador de dentro de um veículo, é proibido e receberá punições\n");
	strcat(StringCat, "\n{FF0000}Death Match DM {FFFFFF}- Não faca DM em Locais Públicos ( Ex: Agência de Empregos, Bancos, etc... ) Pois receberá punições.\n");
	strcat(StringCat, "\n{FF0000}Anti-RPG {FFFFFF}- Nunca se atire na frente de veículos, não saia do servidor ( algemado, perseguições, etc... ) Caso Contrario receberá punições, até Banimento\n");
    strcat(StringCat, "\n{FF0000}Anti-AFK {FFFFFF}- Nunca tente sabotar o AFK se algum adm pegar você, será banido sem aviso\n");
    strcat(StringCat, "\n{FF0000}Favela {FFFFFF}- Não matar na parte de cima ( local de respawn ), bugar armas na favela ou fazer 2-2-2 é proibido e o mesmo receberá punições, até Banimento.\n");
	strcat(StringCat, "\n{FF0000}Agência de Empregos {FFFFFF}- Extremamente proibido entrar com qualquer veiculo dentro da agência!\n");
	strcat(StringCat, "\n{FF0000}CheckPoints {FFFFFF}-Ficar no CheckPoint de qualquer lugar em ESC ou em Anime você será avisado 1 vez, se persistir será kickado e logo após preso 3 - 10 minutos\n");
	strcat(StringCat, "\n{32CD32}VIPs serão julgados da mesma forma que os demais jogadores\n");
	return ShowPlayerDialog(playerid, DIALOG_REGRAS, DIALOG_STYLE_MSGBOX, "{00bbff}»{ffffff} REGRAS", StringCat, "Confirmar", #);
}

/*CMD:ativarconta(playerid, params[])
{

	if ( isnull(tmpCodeactivation[playerid]) )
	{
		SendClientMessage(playerid, COR_ERRO, "* Sua conta já está ativada.");
		return 1;
	}

	new code[18];
	if ( sscanf(params, "s[18]", code) )
	{
		SendClientMessage(playerid, COR_ERRO, getCorrectUseCMD("ativarconta [código]"));
		return 1;
	}

	if ( !strcmp(tmpCodeactivation[playerid], code, false) && !isnull(code) && !isnull(tmpCodeactivation[playerid]) )
	{
		mysql_format(conexao, query, sizeof(query), "UPDATE "TABELA_USUARIOS" SET codigo_ativacao='' WHERE `codigo_ativacao`='%e' AND `id`='%d' LIMIT 1;", code, Jogador[playerid][Id]);
		new Cache:cache_id = mysql_query(conexao, query), rows = cache_affected_rows();
		cache_delete(cache_id);

		if ( rows )
		{
			SendClientMessage(playerid, COR_AZUL, "* {ffffff}Sua conta foi ativada permanentemente.");
			//Conquest:ShowConquest(playerid, "Voce concluiu o registro e recebeu +0.30000 XP como recompensa");
			//Jogador[playerid][XP] += 0.3;
			tmpCodeactivation[playerid][0] = EOS;
		}
		else
		{
			SendClientMessage(playerid, COR_ERRO, "* Sua conta não foi ativada, verifique os dados digitados.");
			SendClientMessage(playerid, COR_ERRO, "* Caso o problema persista, informe o mesmo a qualquer membro da administração.");
		}
		return 1;
	}
	SendClientMessage(playerid, COR_ERRO, "* Não foi possivel ativar sua conta.");
	SendClientMessage(playerid, COR_ERRO, "* Verifique o código digitado.");
	return 1;
}*/

CMD:creditos(playerid)
{
    new StringCat[1000];
    strcat(StringCat, "{80FFFF}----------------------------------------------------------------------------------------------------------------\n\n");
    strcat(StringCat, "{FF8000}Desenvolvedores\n");
    strcat(StringCat, "{FF0000}» {FFFFFF}NelsonC.\n\n");

    strcat(StringCat, "{FF8000}Agredecimentos\n");
    strcat(StringCat, "{FF0000}» {FFFFFF}blueN\n");
    strcat(StringCat, "{FF0000}» {FFFFFF}LuizM\n");
    strcat(StringCat, "{FF0000}» {FFFFFF}DelK\n");
	strcat(StringCat, "{FF0000}» {FFFFFF}SammyJ\n");
    strcat(StringCat, "{FF0000}» {FFFFFF}DiegoR\n");
	strcat(StringCat, "{FF0000}» {FFFFFF}Vaca_Marinha\n");
	strcat(StringCat, "{FF0000}» {FFFFFF}DuduPlay\n");
	strcat(StringCat, "{FF0000}» {FFFFFF}Darth\n");
	strcat(StringCat, "{FF0000}» {FFFFFF}Math\n");
	strcat(StringCat, "{FF0000}» {FFFFFF}Jhuan\n");
    strcat(StringCat, "{FF0000}» {FFFFFF}rootcause\n\n");

    strcat(StringCat, "{FF8000} Perfect City RPG\n");
    strcat(StringCat, "{FFFFFF}\tCopyright © All Rights Reserved 2021\n\n");
    strcat(StringCat, "{80FFFF}----------------------------------------------------------------------------------------------------------------\n\n");
    ShowPlayerDialog(playerid, CREDITOS, DIALOG_STYLE_MSGBOX, "{1E90FF}Créditos", StringCat, "Fechar", #);
    return 1;
}

alias:ajuda("help");
CMD:ajuda(playerid, params[])
{
	new tmp[20];
	if(!sscanf(params, "s[20]", tmp))
	{
		static str[1024 * 3];
		if(strcmp(tmp, "geral", true) == 0)
		{
			str[0] = EOS;
			ReadFile("textos/help/geral.txt", str, sizeof(str));
			ShowPlayerDialog(playerid, PLAYER_MENU_AJUDA_R, DIALOG_STYLE_MSGBOX, "AJUDA » {00BBFF}GERAL", str, "OK", "Voltar");
			return true;
		}
		else if(strcmp(params ,"profissao", true) == 0)
		{
			callcmd::profissao(playerid);
			return true;
		}
		else if(strcmp(tmp, "veiculo", true) == 0)
		{
			str[0] = EOS;
			ReadFile("textos/help/veiculo.txt", str, sizeof(str));
			ShowPlayerDialog(playerid, PLAYER_MENU_AJUDA_R, DIALOG_STYLE_MSGBOX, "AJUDA » {00BBFF}VEICULO", str, "OK", "Voltar");
			return true;
		}
		else if(strcmp(tmp, "casa", true) == 0)
		{
			str[0] = EOS;
			ReadFile("textos/help/casa.txt", str, sizeof(str));
			ShowPlayerDialog(playerid, PLAYER_MENU_AJUDA_R, DIALOG_STYLE_MSGBOX, "AJUDA » {00BBFF}CASA", str, "OK", "Voltar");
			return true;
		}
		else if ( strcmp(tmp, "empresa", true) == 0 )
		{
			str[0] = EOS;
			ReadFile("textos/help/empresa.txt", str, sizeof(str));
			ShowPlayerDialog(playerid, PLAYER_MENU_AJUDA_R, DIALOG_STYLE_MSGBOX, "AJUDA » {00BBFF}EMPRESA", str, "OK", "Voltar");
			return true;
		}
		else if ( strcmp(tmp, "celular", true) == 0 )
		{
			str[0] = EOS;
			ReadFile("textos/help/celular.txt", str, sizeof(str));
			ShowPlayerDialog(playerid, PLAYER_MENU_AJUDA_R, DIALOG_STYLE_MSGBOX, "AJUDA » {00BBFF}CELULAR", str, "OK", "Voltar");
			return true;
		}
		else if ( strcmp(tmp, "vip", true) == 0 )
		{
			str[0] = EOS;
			ReadFile("textos/help/vip.txt", str, sizeof(str));
			ShowPlayerDialog(playerid, PLAYER_MENU_AJUDA_R, DIALOG_STYLE_MSGBOX, "AJUDA » {00BBFF}VIP", str, "OK", "Voltar");
			return true;
		}
		else if ( strcmp(tmp, "contato", true) == 0 )
		{
			str[0] = EOS;
			ReadFile("textos/help/contato.txt", str, sizeof(str));
			ShowPlayerDialog(playerid, PLAYER_MENU_AJUDA_R, DIALOG_STYLE_MSGBOX, "AJUDA » {00BBFF}CONTATO", str, "OK", "Voltar");
			return true;
		}
		SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/ajuda");
		return true;
	}
	ShowPlayerDialog(playerid, PLAYER_MENU_AJUDA, DIALOG_STYLE_LIST, "AJUDA", "Ajuda Geral\nAjuda Profissão\nAjuda Veiculo\nAjuda Casa\nAjuda Empresa\nAjuda Celular\nAjuda VIP\nAjuda Contato", "Selecionar", "Cancelar");
	return true;
}

CMD:vips(playerid) {
	new ContarVips, __str[1024];
	format(__str, sizeof(__str), "Nome(id)");
	foreach(new i: Player) {
	    if(Jogador[i][Vip] == true) {
	        format(__str, sizeof(__str), "%s\n%s(%d)", __str, GetUserName(i), i);
	        ContarVips++;
	    }
	}
	if(ContarVips > 0) {
	    ShowPlayerDialog(playerid, DIALOG_VIPS, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Vips Online", __str, "Fechar", #);
	} else {
	    SendClientMessage(playerid, COR_ERRO, "| ERRO |  Não tem nenhum(a) VIP online no momento!");
	}
	return true;
}

/*CMD:mp3(playerid)
{
	if ( !call::PLAYER->GetPlayerVarBool(playerid, MP3) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem um mp3, você precisa comprar um em uma loja de utilitários.");

	new str[512], nome[MAX_STATION_NAME];
	for(new i, stations = CountStations(); i < stations; i++)
	{
		GetStationName(i, nome);
		format(str, sizeof(str), "%s%s\n", str, nome);
	}
	format(str, sizeof(str), "%s{F05555}Desligar", str);
	ShowPlayerDialog(playerid, PLAYER_MENU_RADIO, DIALOG_STYLE_LIST, "LISTA DE RÁDIOS", str, "Ouvir", "Sair");
	return true;
}*/

CMD:mp3(playerid, params[])
{
	if ( !call::PLAYER->GetPlayerVarBool(playerid, MP3) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem um mp3, você precisa comprar um em uma loja de utilitários.");
	
	ShowPlayerDialog(playerid, DIALOG_MP3, DIALOG_STYLE_LIST, "MP3", "Rádio Perfect City\nBrasil\t\t\t>\nPortugal\t\t>\nAlemanha\t\t>", "Escolher", "Sair");
	return true;
}

CMD:usargalao(playerid)
{
	new Float:fuel = 15, vehicleid = GetPlayerVehicleID(playerid);
	if ( !call::PLAYER->GetPlayerVarBool(playerid, Galao) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem um Galão de Gasolina, você precisa comprar um em uma loja de utilitários.");

	if( !IsPlayerInAnyVehicle(playerid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo.");

	if(call::VH->GetVehicleFuel(vehicleid) >= GetVehicleMaxFuel(GetVehicleModel(GetPlayerVehicleID(playerid))))
  		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Veiculo está com o tanque cheio.");

  	if(call::VH->GetVehicleFuel(vehicleid) > 15)
  		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse veiculo não está na reserva.");

	new Float:max_fuel = GetVehicleMaxFuel(GetVehicleModel(GetPlayerVehicleID(playerid)));
	
	fuel = ( fuel >  max_fuel ? max_fuel : fuel );
	call::VH->SetVehicleFuel(GetPlayerVehicleID(playerid), fuel);

	SendClientMessage(playerid, COR_AMARELO, "| GALÃO | Você usou galão de gasolina e o combustivel do seu veiculo foi para {"COR_BRANCO_INC"}%d%{"COR_SISTEMA_INC"}.", floatround(fuel));

	call::PLAYER->SetPlayerVarBool(playerid, Galao, false);

	new query[128];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `galao`='0' WHERE `id`='%d' LIMIT 1;", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
	mysql_tquery(getConexao(), query);

	return true;
}

CMD:tops(playerid)
{
	ShowPlayerDialog(playerid, SERVER_STATICS, DIALOG_STYLE_LIST, "ESTATÍSTICAS", "Top Grana\nTop Level", "Selecionar", "Fechar");
	return true;
}

CMD:gps(playerid)
{
	if ( !call::PLAYER->GetPlayerVarBool(playerid, GPS) && GetPlayerScore(playerid) > 5 )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem um gps");

	if ( GetPlayerScore(playerid) < 5 && !call::PLAYER->GetPlayerVarBool(playerid, GPS))
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você poderá usar gps até o level 5, após isso deverá comprar o seu.");

	ShowPlayerDialog(playerid, PLAYER_GPS_MENU, DIALOG_STYLE_LIST, "GPS", "Propriedades Públicas\nMinha Empresa\nMinha Casa\nProfissões\nConcessionárias\n{"COR_ERRO_INC"}Desligar", "Selecionar", "Sair");
	return true;
}

CMD:chamartaxi(playerid, params[])
{
	call::TAXI->CallTaxi(playerid);
	return true;
}

CMD:abastecer(playerid)
{
	if(!call::PLAYER->IsPlayerInPosto(playerid, 4.5))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo a uma bomba de combustível.");

	if(!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo.");
	
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Somente o motorista pode abastecer o veiculo.");

	new vehicleid = GetPlayerVehicleID(playerid), model = GetVehicleModel(vehicleid);

	if(call::VH->GetVehicleFuel(vehicleid) >= GetVehicleMaxFuel(model))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Veiculo está com o tanque cheio.");

	if(GetPVarInt(playerid, "abastecendo"))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está abastecendo um veiculo.");

	if(GetVehicleParams(vehicleid, VEHICLE_TYPE_ENGINE) == VEHICLE_PARAMS_ON)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Desligue o motor do veiculo para abastecer.");

	new valor, tipo[50];
	switch(call::VH->GetVehicleFuelType(model))
	{
		case TYPE_GASOLINA:
			valor = VALOR_GASOLINA, tipo = "da {"COR_AZUL_INC"}Gasolina{"COR_BRANCO_INC"}";
		case TYPE_DIESEL:
			valor = VALOR_DIESEL, tipo = "do {"COR_AZUL_INC"}Diesel{"COR_BRANCO_INC"}";
		case TYPE_AVG:
			valor =  VALOR_AVG, tipo = "do {"COR_AZUL_INC"}AVGás{"COR_BRANCO_INC"}";
	}
	new str[200];
	format(str, sizeof(str), "{"COR_BRANCO_INC"}Você deseja abastecer seu veiculo?\n\nO Valor %s está {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"} por litro.\n\n{"COR_ERRO_INC"}* digite a quantidade de litros que deseja abastecer.", tipo, RealStr(valor));
	ShowPlayerDialog(playerid, ABASTECENDO_VEICULO, DIALOG_STYLE_INPUT, "ABASTECIMENTO", str, "Abastecer", "Cancelar");
	return true;
}

alias:admins("staff", "adms", "equipe");
CMD:admins(playerid)
{
	new info[1036];
	info = "Cargo\tNome\tStatus\n";

	foreach(new i: Player)
	{
		if(call::ADMIN->GetPlayerAdminLevel(i) >= AJUDANTE)
		{
			format(info, sizeof(info), "%s%s\t%s\t%s\n", info, call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(i), true), GetUserName(i), (call::PLAYER->IsPlayerLogged(i) ?(call::ADMIN->IsAdminInJob(i) ? ("{0F7EC4}Administrando"):("{37DF62}Jogando") ):("{E23131}Offline") ));
		}
	}

	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "{"COR_VERMELHO_INC"}"SERVER_NAME"» {"COR_BRANCO_INC"}ADMINS", info, "OK", "");
	return true;
}



CMD:dormir(playerid)
{
	if(call::PLAYER->GetPlayerVarFloat(playerid, Sono) >= 100.0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está com sono.");
	
	if(call::PLAYER->GetPlayerVarInt(playerid, pDormindo) != 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está dormindo.");

	TogglePlayerControllable(playerid, false);
	call::PLAYER->SetPlayerVarInt(playerid, pDormindo, 1);

	call::PLAYER->InitPlayerFadeEffect(playerid);
	ApplyAnimation(playerid, "CRACK", "CRCKIDLE2", 4.1, 1, 1, 1, 1, 0);
	
	SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Você está dormindo...");
	return true;
}

CMD:acordar(playerid)
{
	if(call::PLAYER->GetPlayerVarInt(playerid, pDormindo) == 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está dormindo.");

	call::PLAYER->DestroyPlayerFadeSono(playerid, 0);
	call::PLAYER->SetPlayerVarInt(playerid, pDormindo, 0);

	ClearAnimations(playerid);
	SetCameraBehindPlayer(playerid);
	TogglePlayerControllable(playerid, true);
	SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Você está acordando...");
	return true;
}

CMD:duvida(playerid, params[])
{
    new
    	duvida[128];

    if(Jogador[playerid][Preso])
    	return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE"| ERRO | Você não pode mandar uma dúvida estando preso!");

    if(sscanf(params, "s[140]", duvida))
    	return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/duvida (mensagem)");

    if ( GetPVarInt(playerid, "PlayerUserDuvida") > gettime() )
	{
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você mandou uma dúvida recentemente, aguarde {"COR_BRANCO_INC"}%d{"COR_ERRO_INC"} segundos para mandar outra.", gettime() - GetPVarInt(playerid, "PlayerUserDuvida"));
		return 0;
	}
    new AdminOn;
    foreach(new i: PlayersAdmin)
    {
        if( call::ADMIN->IsAdminInJob(i) )
        {
            GameTextForPlayer(i, "~b~Duvida Recebida", 3000, 4);
            PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
            AdminOn++;
            SendClientMessage(i, COR_AZUL, "| DUVIDA | Duvida de {ffffff}%s{"COR_AZUL_INC"}({ffffff}%d{"COR_AZUL_INC"}) ( {ffffff}%s {"COR_AZUL_INC"})", GetUserName(playerid), playerid, duvida);
        }
    }
    if(AdminOn) {
    	SendClientMessage(playerid, 0xffffffff, "| DUVIDA | Sua dúvida foi enviada para a Administração, aguarde uma resposta!");
    	SetPVarInt(playerid, "PlayerUserDuvida", gettime() + 180);
    }
    else {
    	SendClientMessage(playerid, COR_ERRO, "| DUVIDA | Não há administradores online. Procure ajuda no fórum!");
    }
    return true;
}

alias:relatorio("reportar", "report");
CMD:relatorio(playerid, params[])
{
	new id, motivo[140];
	if ( sscanf(params, "ds[140]", id, motivo) )
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/relatorio [id] [motivo]");

	if ( !IsPlayerConnected(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) Jogador(a) reportado não está online.");

	if ( GetPVarInt(playerid, "PlayerUserReport") > gettime() )
	{
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você fez um reporte recentemente, aguarde {"COR_BRANCO_INC"}%d{"COR_ERRO_INC"} segundos para fazer outro reporte.", gettime() - GetPVarInt(playerid, "PlayerUserReport"));
		return 0;
	}

	foreach(new i: PlayersAdmin)
	{
		if( call::ADMIN->IsAdminInJob(i) )
		{
			//SendClientMessage(i, 0xFF6B6BFF, "RELATO: {"COR_BRANCO_INC"}%s[%d]{FF6B6} reportou o jogador {"COR_BRANCO_INC"}%s[%d]{FF6B6}:", GetUserName(playerid), playerid, GetUserName(id), id);
			//SendClientMessage(i, 0xFF6B6BFF, "» {"COR_BRANCO_INC"}%s", motivo);
			SendClientMessage(i, COR_VERMELHO, "| RELATÓRIO | {ffffff}%s{"COR_VERMELHO_INC"}({ffffff}%d{"COR_VERMELHO_INC"}) acusou {ffffff}%s{"COR_VERMELHO_INC"}({ffffff}%d{"COR_VERMELHO_INC"})", GetUserName(playerid), playerid, GetUserName(id), id);
			SendClientMessage(i, COR_VERMELHO, "| RELATÓRIO | Motivo: ( {ffffff}%s {"COR_VERMELHO_INC"})", motivo);
			GameTextForPlayer(i, "~h~~h~~h~~r~REPORT", 3000, 4);
			PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
		}
	}
	SetPVarInt(playerid, "PlayerUserReport", gettime() + 180);
	SendClientMessage(playerid, COR_BRANCO, "| RELATÓRIO | Seu relatório foi enviado.");
	return true;
}
CMD:ejetar(playerid, params[])
{
	if(isnull(params) || !IsNumeric(params))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/ejetar [playerid]");

	if(!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo");

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é motorista deste veiculo");

	new pid = strval(params), vehicleid = GetPlayerVehicleID(playerid);

	if(!call::PLAYER->IsPlayerLogged(pid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Jogador não está conectado.");

	if(!IsPlayerInVehicle(pid, vehicleid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Jogador não está no seu veiculo.");

	RemovePlayerFromVehicle(pid);
	SendClientMessage(pid, COR_AVISO, "Você foi expulso do veiculo.");

	SendClientMessage(playerid, COR_SISTEMA, "» {1FDA9A}Você expulsou o jogador do seu veiculo.");
	return true;
}

CMD:kill(playerid)
{
	if (call::PLAYER->GetPlayerVarInt(playerid, Perseguido) || call::PLAYER->GetPlayerVarInt(playerid, Algemado))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em perseguição ou algemado.");

	if(GetPlayerWantedLevel(playerid) >= 1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando enquanto está sendo procurado pela policia.");

	SetPlayerHealth(playerid, 0);
	SendClientMessage(playerid, COR_ERRO, "* Você se suicidou.");
	return true;
}

CMD:config(playerid)
{
	ShowPlayerDialog(playerid, CONFIGURACOES_JOGADOR, DIALOG_STYLE_LIST, "CONFIGURAÇÕES DE USUÁRIO", "Hud", "Selecionar", "Fechar");
	return true;
}

CMD:sms(playerid, params[])
{
	if ( !call::PLAYER->GetPlayerVarInt(playerid, Celular) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem um celular.");

	if ( call::PLAYER->GetPlayerVarInt(playerid, SaldoCelular) < 1 )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem créditos para enviar um sms.");

	new number, mensagem[100];

	if ( GetPVarInt(playerid, "number_sms") == 0 )
	{
		if (sscanf(params, "ds[100]", number, mensagem) )
			return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/sms [numero] [mensagem]");
	}
	else
	{
		if (sscanf(params, "s[100]", mensagem) )
			return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/sms [mensagem]");

		number = GetPVarInt(playerid, "number_sms");
	}

	if ( isnull(mensagem) )
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/sms [numero] [mensagem]");

	if ( number == call::PLAYER->GetPlayerVarInt(playerid, Celular) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode enviar sms para sí mesmo.");

	foreach(new i: Player)
	{
		if ( number == call::PLAYER->GetPlayerVarInt(i, Celular))
		{
			GameTextForPlayer(i, "~b~Mensagem Recebida!", 3000, 1);
			//SendClientMessage(i, 0xBBCC00FF, "| MENSAGEM | SMS recebido de {"COR_BRANCO_INC"}%s %d{BBCC00}: (( {"COR_BRANCO_INC"}%s{BBCC00} ))", GetUserName(playerid), call::PLAYER->GetPlayerVarInt(playerid, Celular), mensagem);
			//SendClientMessage(playerid, 0xBBCC00FF, "| MENSAGEM | SMS enviado para {"COR_BRANCO_INC"}%s %d{BBCC00}: (( {"COR_BRANCO_INC"}%s{BBCC00} ))", GetUserName(i), number, mensagem);
			SendClientMessage(playerid, COR_LARANJA, "| SMS | Você mandou um sms para {ffffff}%s{"COR_LARANJA_INC"} (Nr.:{ffffff}%d{"COR_LARANJA_INC"}) ( {ffffff}%s {"COR_LARANJA_INC"}).", GetUserName(i), number, mensagem);
			SendClientMessage(i, COR_LARANJA, "| SMS | {ffffff}%s {"COR_LARANJA_INC"}(Nr.: {ffffff}%d{"COR_LARANJA_INC"}) lhe enviou um sms ( {ffffff}%s {"COR_LARANJA_INC"}).", GetUserName(playerid), call::PLAYER->GetPlayerVarInt(playerid, Celular), mensagem);
			GameTextForPlayer(playerid, "~b~Mensagem Enviada!", 3000, 1);


			call::PLAYER->SetPlayerVarInt(playerid, SaldoCelular, call::PLAYER->GetPlayerVarInt(playerid, SaldoCelular) - 1);
			/*SetPVarInt(playerid, "number_sms", number);

			if ( GetPVarInt(playerid, "number_sms") == 0 )
				SendClientMessage(playerid, COR_AMARELO, "Se quiser enviar mensagem para esse número novamente é só usar /sms [mensagem]");*/

			return true;
		}
	}
	SendClientMessage(playerid, COR_ERRO, "O Telefone está desligado ou fora da area de cobertura.");
	return true;
}

CMD:discar(playerid, params[])
{
	if ( !call::PLAYER->GetPlayerVarInt(playerid, Celular) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem um celular.");

	if ( isnull(params) || !IsNumeric(params))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/discar [numero]");	

	new number = strval(params);
	if ( number == call::PLAYER->GetPlayerVarInt(playerid, Celular) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode ligar para sí mesmo.");
	

	switch(number)
	{
		case 190:
		{
			new count;

			foreach(new i: Player)
			{
				if ( call::PLAYER->GetPlayerVarInt(i, Profissao) == POLICIA_MILITAR )
				{
					SendClientMessage(i, 0x221296FF, "O Telefone de denúncia está tocando. Use /atender para respoder a denúncia.");
					call::PLAYER->SetPlayerVarInt(i, StateCell, CHAMANDO);
					call::PLAYER->SetPlayerVarInt(i, CallerID, playerid);

					TocarCelular(i);
					++count;
				}
			}

			if ( count )
			{
				call::PLAYER->SetPlayerVarInt(playerid, StateCell, CHAMANDO);
				call::PLAYER->SetPlayerVarInt(playerid, TypeCall, EMERGENCIA);
				
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
				SetPlayerAttachedObject(playerid, 9, 18868, 6);
				SendClientMessage(playerid, COR_BRANCO, "Chamando... Use {"COR_AZUL_INC"}/finalizar{"COR_BRANCO_INC"} para cancelar a discagem.");
				return true;
			}

			SendClientMessage(playerid, COR_ERRO, "| ERRO | Desculpe mais não temos nenhum policial disponivel no momento.");
			return true;
		}
		default:
		{
			if ( call::PLAYER->GetPlayerVarInt(playerid, SaldoCelular) < TARIFA_LIGACAO )
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem créditos para fazer uma ligação.");


			foreach(new i: Player)
			{
				if ( number == call::PLAYER->GetPlayerVarInt(i, Celular) )
				{
					if ( call::PLAYER->GetPlayerVarInt(i, CallerID) != INVALID_PLAYER_ID )
						return SendClientMessage(playerid, COR_ERRO, "O Número chamado está ocupado.");

					call::PLAYER->SetPlayerVarInt(playerid, StateCell, CHAMANDO);
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
					SetPlayerAttachedObject(playerid, ATTACH_CELL, 18868, 6);
					SendClientMessage(playerid, COR_BRANCO, "Chamando... Use {"COR_AZUL_INC"}/finalizar{"COR_BRANCO_INC"} para cancelar a discagem.");

					call::PLAYER->SetPlayerVarInt(i, CallerID, playerid);
					call::PLAYER->SetPlayerVarInt(i, StateCell, CHAMANDO);
					
					SendClientMessage(i, COR_AZUL, "Seu celular está tocando, use /atender para pegar o telefone.");
					TocarCelular(i);			
					return true;
				}
			}
		}
	}
	return true;
}

CMD:atender(playerid)
{
	if ( call::PLAYER->GetPlayerVarInt(playerid, StateCell) != CHAMANDO )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está recebendo uma ligação.");

	new id = call::PLAYER->GetPlayerVarInt(playerid, CallerID);
	
	if ( playerid == id)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode atender sua prÃ³pria ligação.");

	call::PLAYER->SetPlayerVarInt(playerid, CallerID, id);
	call::PLAYER->SetPlayerVarInt(playerid, StateCell, EM_CHAMADA);
	SendClientMessage(playerid, 0x4F0A9CFF, "Você atendeu o telefone.");
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
	SetPlayerAttachedObject(playerid, ATTACH_CELL, 18868, 6);
	PlayerPlaySound(playerid, 3402, 0.0, 0.0, 0.0);
	
	SendClientMessage(id, 0x4F0A9CFF, "* Atenderam o telefone no outro lado da linha.");
	call::PLAYER->SetPlayerVarInt(id, StateCell, EM_CHAMADA);
	CobrarTarifaCelular(playerid);
	return true;
}

CMD:finalizar(playerid)
{
	if ( !call::PLAYER->GetPlayerVarInt(playerid, StateCell) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em uma ligação.");

	call::CELL->FinalizarChamada( playerid, call::PLAYER->GetPlayerVarInt(playerid, CallerID) );
	return true;
}

CMD:meucelular(playerid)
{
	if ( !call::PLAYER->GetPlayerVarInt(playerid, Celular) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem um telefone.");

	SendClientMessage(playerid, COR_SISTEMA, "Seu número é {"COR_AMARELO_INC"}%d{"COR_SISTEMA_INC"} 	| 	Créditos: {"COR_AMARELO_INC"}%d{"COR_SISTEMA_INC"}", call::PLAYER->GetPlayerVarInt(playerid, Celular), call::PLAYER->GetPlayerVarInt(playerid, SaldoCelular));
	return true;
}

CMD:agenda(playerid, params[])
{
	if ( !call::PLAYER->GetPlayerVarBool(playerid, Agenda) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem uma agenda telefónica.");

	new id;
	if ( sscanf(params, "u", id))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/agenda [id/username]");

	if ( !call::PLAYER->IsPlayerLogged(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O jogador não está conectado.");

	if ( !call::PLAYER->GetPlayerVarInt(id, Celular) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse jogador não está na lista telefónica.");

	SendClientMessage(playerid, COR_SISTEMA, "» {FFFFFF}O número do telefone de {00CCFF}%s{FFFFFF} é {DBED15}%d", GetUserName(id), call::PLAYER->GetPlayerVarInt(id, Celular));
	return true;
}

CMD:continuar(playerid, params[])
{
	if ( Jogador[playerid][TimeContinuar] < gettime() )
		return SendClientMessage(playerid, COR_ERRO, "O seu tempo para usar o comando '{"COR_BRANCO_INC"}/continuar{"COR_ERRO_INC"}', expirou!");

	Jogador[playerid][TimeContinuar] = 0;
	
	Teleport(
		playerid,
		Jogador[playerid][Spawn][X],
		Jogador[playerid][Spawn][Y],
		Jogador[playerid][Spawn][Z],
		Jogador[playerid][Spawn][A],
		Jogador[playerid][Interior],
		Jogador[playerid][World],
		GetPlayerTableValueInt(playerid, "entrou")
	);
	SendClientMessage(playerid, COR_AZUL, "Você foi levado até sua ultima posição salva.");
	return true;
}

alias:identidade("rg");
CMD:identidade(playerid, params[])
{
	new str[1050 * 2], title[512];

	format(title, sizeof(title), "{"COR_LARANJA_INC"}Identidade de: {ffffff}%s", GetUserName(playerid));

	format(str, sizeof(str), "{"COR_LARANJA_INC"}» {ffffff}Registro Geral: {"COR_AZUL_INC"}%06d\n", Jogador[playerid][PlayerID]);
	format(str, sizeof(str), "%s{"COR_LARANJA_INC"}» {ffffff}Level: {"COR_AZUL_INC"}%d\n{"COR_LARANJA_INC"}» {ffffff}Experiência: {"COR_AZUL_INC"}%d\n{"COR_LARANJA_INC"}» {ffffff}Avisos: {"COR_VERMELHO_INC"}%d{"COR_BRANCO_INC"}/{"COR_AZUL_INC"}3\n{"COR_LARANJA_INC"}» {ffffff}BitCoins: {"COR_LARANJA_INC"}%d\n{"COR_LARANJA_INC"}» {ffffff}SkinID: {"COR_AZUL_INC"}%d\n", str, GetPlayerScore(playerid), Jogador[playerid][EXP], call::PLAYER->GetPlayerVarInt(playerid, Avisos), Jogador[playerid][Cash], GetPlayerSkin(playerid));
	if(Jogador[playerid][Vip])
		format(str, sizeof(str), "%s{"COR_LARANJA_INC"}» {ffffff}VIP: {"COR_VERDE_INC"}Sim {ffffff}- {"COR_BRANCO_INC"}({"COR_AZUL_INC"}%d{"COR_BRANCO_INC"}) dias\n", str, IsPlayerTimeVip(playerid));
	else
		format(str, sizeof(str), "%s{"COR_LARANJA_INC"}» {ffffff}VIP: {"COR_VERMELHO_INC"}Não\n", str);
	format(str, sizeof(str), "%s{"COR_LARANJA_INC"}» {ffffff}Habilitações: ", str);
	if ( BitFlag_Get(Jogador[playerid][Habilitacao], HAB_MOTO) ||
		BitFlag_Get(Jogador[playerid][Habilitacao], HAB_CARRO) ||
		BitFlag_Get(Jogador[playerid][Habilitacao], HAB_CAMINHAO) ||
		BitFlag_Get(Jogador[playerid][Habilitacao], HAB_BARCO) ||
		BitFlag_Get(Jogador[playerid][Habilitacao], HAB_AVIAO) )
	{
		if ( BitFlag_Get(Jogador[playerid][Habilitacao], HAB_MOTO) )
			format(str, sizeof(str), "%s{"COR_AMARELO_INC"}A{"COR_BRANCO_INC"} ", str);
		if ( BitFlag_Get(Jogador[playerid][Habilitacao], HAB_CARRO) )
			format(str, sizeof(str), "%s{"COR_AMARELO_INC"}B{"COR_BRANCO_INC"} ", str);
		if ( BitFlag_Get(Jogador[playerid][Habilitacao], HAB_CAMINHAO) )
			format(str, sizeof(str), "%s{"COR_AMARELO_INC"}C{"COR_BRANCO_INC"} ", str);
		if ( BitFlag_Get(Jogador[playerid][Habilitacao], HAB_BARCO) )
			format(str, sizeof(str), "%s{"COR_AMARELO_INC"}D{"COR_BRANCO_INC"} ", str);
		if ( BitFlag_Get(Jogador[playerid][Habilitacao], HAB_AVIAO) )
			format(str, sizeof(str), "%s{"COR_AMARELO_INC"}E{"COR_BRANCO_INC"}", str);
	}
	else
		format(str, sizeof(str), "%s{"COR_VERMELHO_INC"}Nenhuma{"COR_BRANCO_INC"}", str);
	format(str, sizeof(str), "%s\n", str);

	if ( call::PLAYER->GetPlayerVarInt(playerid, GPS) || call::PLAYER->GetPlayerVarInt(playerid, MP3) || call::PLAYER->GetPlayerVarInt(playerid, Celular) || call::PLAYER->GetPlayerVarInt(playerid, Agenda) )
	{
		if ( call::PLAYER->GetPlayerVarInt(playerid, GPS) )
			format(str, sizeof(str), "%s{"COR_LARANJA_INC"}» {ffffff}GPS: {"COR_VERDE_INC"}Sim{"COR_BRANCO_INC"}\n", str);

		if ( call::PLAYER->GetPlayerVarInt(playerid, MP3) )
			format(str, sizeof(str), "%s{"COR_LARANJA_INC"}» {ffffff}MP3: {"COR_VERDE_INC"}Sim{"COR_BRANCO_INC"}\n", str);
		
		if (  call::PLAYER->GetPlayerVarInt(playerid, Celular) != 0 )
		{
			format(str, sizeof(str), "%s{"COR_LARANJA_INC"}» {ffffff}Celular: {"COR_VERDE_INC"}Sim{"COR_BRANCO_INC"}\n", str);
			format(str, sizeof(str), "%s{"COR_VERMELHO_INC"}** {ffffff}Número: {"COR_AMARELO_INC"}%d\n", str, call::PLAYER->GetPlayerVarInt(playerid, Celular));
			format(str, sizeof(str), "%s{"COR_VERMELHO_INC"}** {ffffff}Créditos: {"COR_AMARELO_INC"}%d\n", str, call::PLAYER->GetPlayerVarInt(playerid, SaldoCelular));
		}

		if ( call::PLAYER->GetPlayerVarInt(playerid, Agenda) )
			format(str, sizeof(str), "%s{"COR_LARANJA_INC"}» {ffffff}Agenda: {"COR_VERDE_INC"}Sim{"COR_BRANCO_INC"}\n", str);
	}

	if ( call::PLAYER->GetPlayerVarInt(playerid, Sementes) )
	{
		format(str, sizeof(str), "%s{"COR_LARANJA_INC"}» {ffffff}Sementes: {"COR_VERDE_INC"}%d{"COR_BRANCO_INC"}\n", str, call::PLAYER->GetPlayerVarInt(playerid, Sementes));
	}

	if ( call::PLAYER->GetPlayerVarInt(playerid, Maconha) )
	{
		format(str, sizeof(str), "%s{"COR_LARANJA_INC"}» {ffffff}Maconha: {"COR_VERDE_INC"}%d{"COR_BRANCO_INC"}\n", str, call::PLAYER->GetPlayerVarInt(playerid, Maconha));
	}

	if ( call::PLAYER->GetPlayerVarInt(playerid, Cocaina) )
	{
		format(str, sizeof(str), "%s{"COR_LARANJA_INC"}» {ffffff}Cocaina: {"COR_VERDE_INC"}%d{"COR_BRANCO_INC"}\n", str, call::PLAYER->GetPlayerVarInt(playerid, Cocaina));
	}

	if ( call::PLAYER->GetPlayerVarInt(playerid, Crack) )
	{
		format(str, sizeof(str), "%s{"COR_LARANJA_INC"}» {ffffff}Crack: {"COR_VERDE_INC"}%d{"COR_BRANCO_INC"}\n", str, call::PLAYER->GetPlayerVarInt(playerid, Crack));
	}

	format(str, sizeof(str), "%s{"COR_LARANJA_INC"}» {ffffff}E-mail Registrado: {"COR_AZUL_INC"}%s\n", str, Jogador[playerid][Email]);
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, title, str, "OK", "");
}

CMD:solicitar(playerid, params[])
{
	new Tipo[30];

	if(sscanf(params, "s[30]", Tipo))
			return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/solicitar [mecanico]");

	if(!strcmp(Tipo, "mecanico", true))
	{
		new zone[MAX_ZONE_NAME], Float: _pos[3];
		GetPlayerPos(playerid, _pos[0], _pos[1], _pos[2]);
		GetLocalName(_pos[0], _pos[1], zone, MAX_ZONE_NAME);

		foreach(new i: Player)
	 	{
	  		if(call::PLAYER->GetPlayerVarInt(i, Profissao) == MECANICO)
	    	{
	     		SendClientMessage(i, COR_SISTEMA, "* {"COR_BRANCO_INC"}O(a) jogador(a) {"COR_VERDE_INC"}%s{"COR_BRANCO_INC"} está solicitando um MecÃ¢nico ( Local: {"COR_AVISO_INC"}%s ).", GetUserName(playerid), zone);
	       	}
	    }
	}
	return true;
}

CMD:presos(playerid)
{
	new str[1045] = "id\tnome\ttempo\tprisão\tcrime\n", count, presotxt[10];
	if(IsPlayerInRangeOfPoint(playerid, 2.0, 248.7233, 67.9884, 1003.6406) || IsPlayerInRangeOfPoint(playerid, 2.0, 298.5375,178.8100,1007.1719) || IsPlayerInRangeOfPoint(playerid, 2.0, 246.5317,118.3733,1003.2188))
	{
		foreach(new i: Player)
		{
			if ( call::PLAYER->GetPlayerVarInt(i, Preso) > 0 )
			{
				new hours, minutes, seconds, str2[50];
				
				formatSeconds(call::PLAYER->GetPlayerVarInt(i, TempoPreso), hours, minutes, seconds);

				if(call::PLAYER->GetPlayerVarInt(i, Preso) == PRESO_POLICIA) { presotxt = "Municipal"; }
				if(call::PLAYER->GetPlayerVarInt(i, Preso) == PRESO_ADM) { presotxt = "Federal"; }

				format(str2, sizeof(str2), "%02d:%02d:%02d", hours, minutes, seconds);
				format(str, sizeof(str), "%s%d\t{"COR_VERMELHO_INC"}%s\t{"COR_BRANCO_INC"}%s\t{"COR_AMARELO_INC"}%s{"COR_BRANCO_INC"}{"COR_VERMELHO_INC"}%s{"COR_BRANCO_INC"}\n", str, i, GetUserName(i), str2, presotxt, Jogador[i][Crime]);
				count++;
			}
		}
		if(count)
			return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "LISTA DE PRESOS", str, "OK", "");

		SendClientMessage(playerid, COR_ERRO, "Não há nenhum preso online.");
	}
	else SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em Departamento de Polícia.");
	return true;
}


// ============================== [ COMANDOS VIP ] ============================== //

alias:cmdsvip("comandosvip");
CMD:cmdsvip(playerid, params[])
{
	if ( Jogador[playerid][Vip] )
	{
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{1FB1AF}COMANDOS VIP",
"{"COR_VERMELHO_INC"}» {"COR_LARANJA_INC"}/VencimentoVip{"COR_BRANCO_INC"} » Para visualizar seu vencimento vip.\n\
{"COR_VERMELHO_INC"}» {"COR_LARANJA_INC"}/V{"COR_BRANCO_INC"} » Chat vip\n\
{"COR_VERMELHO_INC"}» {"COR_LARANJA_INC"}/Virar{"COR_BRANCO_INC"} » Para virar seu veiculo.\n\
{"COR_VERMELHO_INC"}» {"COR_LARANJA_INC"}/Pintar{"COR_BRANCO_INC"} » Para pintar seu veiculo.\n\
{"COR_VERMELHO_INC"}» {"COR_LARANJA_INC"}/AutoTuning{"COR_BRANCO_INC"} » Auto tunar seu veiculo.\n\
{"COR_VERMELHO_INC"}» {"COR_LARANJA_INC"}/Neon{"COR_BRANCO_INC"} » Colocar luz no seu veiculo.\n\
{"COR_VERMELHO_INC"}» {"COR_LARANJA_INC"}/Tunar{"COR_BRANCO_INC"} » Tunar seu veiculo.\n\
{"COR_VERMELHO_INC"}» {"COR_LARANJA_INC"}/RepararV{"COR_BRANCO_INC"} » Para reparar seu veiculo.\n",
		"OK", #);
		return true;
	}
	SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);
	return true;
}

CMD:vencimentovip(playerid, params[])
{
	if ( Jogador[playerid][Vip] )
	{
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{1FB1AF}VENCIMENTO VIP", "{"COR_VERMELHO_INC"}»{"COR_BRANCO_INC"} Seus dia(s) vip acabam em {"COR_AZUL_INC"}%d{"COR_BRANCO_INC"} dias.", "OK", "", IsPlayerTimeVip(playerid));
		return true;
	}
	SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);
	return true;
}

CMD:vantagensvip(playerid)
{
	new str[1024 * 4];
	ReadFile("textos/help/vip.txt", str, sizeof(str));
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "AJUDA » {00BBFF}VIP", str, "Fechar", "");
	return true;
}

CMD:v(playerid, params[])
{
	if(Jogador[playerid][Vip] || call::ADMIN->GetPlayerAdminLevel(playerid) < AJUDANTE)
	{
		if ( isnull(params) )
			return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/v [mensagem]");

		checaXingamento(playerid, params);

		foreach(new i: Player)
		{
			if ( Jogador[playerid][Vip] == true )
			{
				SendClientMessage(i, 0x01A9DBFF, "| CHAT - VIP | %s[%d]: %s", GetUserName(playerid), playerid, params);
			}
		}
		return true;
	}
	SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);
	return true;
}

CMD:jetpack(playerid)
{
	if(!Jogador[playerid][Vip] && call::ADMIN->GetPlayerAdminLevel(playerid) < AJUDANTE)
		return SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);

	if(GetPlayerWantedLevel(playerid) != 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar jetpack, pois está sendo procurado pela policia.");

	if (IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando dentro de um veiculo.");
	
	if ( call::PLAYER->GetPlayerVarBool(playerid, Perseguido) || call::PLAYER->GetPlayerVarBool(playerid, Perseguindo) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em perseguição.");

	if ( call::PLAYER->GetPlayerVarBool(playerid, Algemado) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando algemado.");

	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
	{
		static Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		SetPlayerPos(playerid, x, y, z);
		SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP |  Jetpack foi {"COR_VERMELHO_INC"}destruido{"COR_AMARELO_INC"}.");
		return true;
	}
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
	SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Jetpack criado com {"COR_VERDE_INC"}sucesso{"COR_AMARELO_INC"}, use o comando novamente se quiser destrui-lo.");
	return true;	
}

CMD:autotuning(playerid)
{
	if(!Jogador[playerid][Vip] && call::ADMIN->GetPlayerAdminLevel(playerid) < AJUDANTE)
		return SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);

	if(GetPlayerWantedLevel(playerid) != 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar autotuning, pois está sendo procurado pela policia.");

	if( call::PLAYER->GetPlayerVarBool(playerid, Perseguido) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode tunar o veículo em uma perseguição.");

	if(Autotunning[playerid] == 0) {
		Autotunning[playerid] = 1;
		if(call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE || Jogador[playerid][Vip] == true) {
			SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Você ativou o modo AutoTuning para seus veículos!");
		}
	}
	else if(Autotunning[playerid] == 1) {
		Autotunning[playerid] = 0;
		if(call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE || Jogador[playerid][Vip] == true) {
			SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Você desativou o modo AutoTuning!");
		}
	}
	return true;
}

cmd:tunar(playerid)
{
	if(!Jogador[playerid][Vip] && call::ADMIN->GetPlayerAdminLevel(playerid) < AJUDANTE)
		return SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);

	if( call::PLAYER->GetPlayerVarBool(playerid, Perseguido) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode tunar o veículo em uma perseguição.");

	if(!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar em um veículo.");
	
	if(GetPlayerVehicleSeat(playerid) != 0)
        return SendClientMessage(playerid,  COR_ERRO, "| ERRO | Você precisa estar dirigindo o veículo");
	
	if(!GetVehicleModelEx(GetVehicleModel(GetPlayerVehicleID(playerid))))
	    return SendClientMessage(playerid,  COR_ERRO, "| ERRO | Este veículo não pode ser tunado.");
	if(wTuning[playerid] == true)
	    return SendClientMessage(playerid,  COR_ERRO, "| ERRO | Você já esá tunando um veículo.");
	    
    static
		nome_veiculo[40]
	;

	format(nome_veiculo, sizeof(nome_veiculo), "Veiculo: %s", veiculoNome[GetVehicleModel(GetPlayerVehicleID(playerid)) - 400]);
    PlayerTextDrawSetString(playerid, PlayerText:wMenu[0], nome_veiculo);
    
    for(new i; i < sizeof(wBase); i++) { TextDrawShowForPlayer(playerid, Text:wBase[i]); }
	for(new i; i < sizeof(wMenu); i++) { PlayerTextDrawShow(playerid, PlayerText:wMenu[i]); }
	for(new i; i < sizeof(wMenuRodas); i++) { PlayerTextDrawShow(playerid, PlayerText:wMenuRodas[i]); }

	SelectTextDraw(playerid, 0x4F4F4FFF);
	wTuning[playerid] = true;
	return 1;
}

CMD:cortag(playerid, params[])
{
	if ( !Jogador[playerid][Vip] )
		return SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);

 	if( isnull(params) )
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/cortag [Código-Html]");
	
	if ( !IsValidHex(params, VERIFY_HEX_8) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Voce não digitou um código html válido, use o tipo RRGGBBAA.");

	Jogador[playerid][CorTag] = HexToInt(params);
	SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Você alterou a cor da tag vip para ( {%06x}Cor{"COR_BRANCO_INC"} ).", (Jogador[playerid][CorTag] >>> 8) );
	
	new file[MAX_FILE_CONFIG_LEN];
	format(file, sizeof(file), CONFIG_PLAYER_PATH, GetUserName(playerid));
	
	if ( !fexist(file) )
		DOF2::CreateFile(file);

    DOF2::SetInt(file, TAG_CORTAGVIP, Jogador[playerid][CorTag]);     
    DOF2::SaveFile(); 
	return 1;
}

CMD:motivos(playerid)
{
	new info[1024];
	info = "Crime\tAbreviação\tEstrelas\tTempo\n";
	for(new i; i < sizeof(MotivosSu); i++)
	{
		format(info, sizeof(info), "%s%s\t%s\t%d\t%s\n", info, MotivosSu[i][Crime], MotivosSu[i][Abreviacao], MotivosSu[i][Estrelas], MotivosSu[i][Penalidade]);
	}
	ShowPlayerDialog(playerid, DIALOG_INFOCRIME, DIALOG_STYLE_TABLIST_HEADERS, "| CRIMES |", info, "Fechar", "");
	return 0;
}

CMD:virar(playerid, params[])
{
	if(!Jogador[playerid][Vip] && call::ADMIN->GetPlayerAdminLevel(playerid) < AJUDANTE)
		return SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);

	new Float: _pos[4];
	if(IsPlayerInAnyVehicle(playerid))
	{
		SetCameraBehindPlayer(playerid);
		GetPlayerPos(playerid, _pos[0], _pos[1], _pos[2]);
		SetVehiclePos(GetPlayerVehicleID(playerid), _pos[0], _pos[1], _pos[2]);
		GetPlayerFacingAngle(playerid, _pos[3]);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), _pos[3]);
		SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Veículo desvirado com sucesso.");
	}
	return true;
}

CMD:pintar(playerid, params[])
{
	if(!Jogador[playerid][Vip] && call::ADMIN->GetPlayerAdminLevel(playerid) < AJUDANTE)
		return SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);

	if (!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veículo.");
	
	new id, id2;
	if ( sscanf(params, "dd", id, id2))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/pintar [cor1] [cor2]");

	if(id < 0 || id > 255)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Apenas ids de 0 a 255.");

	if(id2 < 0 || id2 > 255)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Apenas ids de 0 a 255.");

	ChangeVehicleColor(GetPlayerVehicleID(playerid), id, id2);
	SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Você alterou as cores para ID's %d e %d.", id, id2);
	return true;
}

CMD:neon(playerid, params[])
{
	if(!Jogador[playerid][Vip] && call::ADMIN->GetPlayerAdminLevel(playerid) < AJUDANTE)
		return SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);

	if (!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veículo.");

 	ShowPlayerDialog(playerid, Dialog_Neons, DIALOG_STYLE_LIST, "Neons", "Vermelho\nAzul\nVerde\nAmarelo\nRosa\nBranco\nSirene\nRemover Neon", "Confirmar", "Fechar");
	return true;
}

CMD:repararv(playerid, params[])
{
	if(!Jogador[playerid][Vip] && call::ADMIN->GetPlayerAdminLevel(playerid) < AJUDANTE)
		return SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);

	if (!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veículo.");

	if ( call::PLAYER->GetPlayerVarBool(playerid, Perseguido) || call::PLAYER->GetPlayerVarBool(playerid, Perseguindo) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em perseguição.");
		
	RepairVehicle(GetPlayerVehicleID(playerid));
 	SetVehicleHealth(GetPlayerVehicleID(playerid), 1000);
  	SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Veículo reparado com sucesso.");
	return true;
}

/*CMD:radio(playerid)
{
	if ( !IsPlayerInAnyVehicle(playerid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo.");

	new str[512], nome[MAX_STATION_NAME];
	for(new i, stations = CountStations(); i < stations; i++){
		GetStationName(i, nome);
		format(str, sizeof(str), "%s%s\n", str, nome);
	}
	format(str, sizeof(str), "%s{F05555}Desligar", str);
	ShowPlayerDialog(playerid, VEHICLE_RADIO_STATION, DIALOG_STYLE_TABLIST, "ESTAÃ‡Ã•ES DE RÃDIO", str, "Sintonizar", "Sair");
	return true;
}*/


CMD:world(playerid)
{
	SendClientMessage(playerid, 0xB9C9BFFF, "Current World: %d", GetPlayerVirtualWorld(playerid));
	return true;
}

/*alias:me("y");
CMD:me(playerid, params[])
{
	if( !isnull(params) )
	{
		static Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		
		checaXingamento(playerid, params);

		foreach(new i: Player)
		{
			if ( !call::PLAYER->IsPlayerLogged(i) )
				continue;

			if ( IsPlayerInRangeOfPoint(i, 15.0, x, y, z) )
			{
				SendClientMessage(i, 0xDA68FFFF, "** %s %s", GetUserName(playerid), params);
			}
		}
		return true;
	}
	SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/me [texto]");
	return true;
}*/

static pagarTime[MAX_PLAYERS];
alias:pagar("dardinheiro");
CMD:pagar(playerid, params[])
{
	new id, valor;
	if ( sscanf(params, "dd", id, valor) )
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/pagar [id] [valor]");

	if(GetPlayerScore(id) < 10) 
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Este jogador não tem level suficiente.");

	if ( !call::PLAYER->IsPlayerLogged(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) não está logado.");

	new Float:x, Float:y, Float:z;

	GetPlayerPos(playerid, x, y, z);

	if ( GetPlayerDistanceFromPoint(id, x, y, z) > 10 )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) não está prÃ³ximo a você.");

	if ( valor <= 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode retirar dinheiro do jogador.");

	if ( valor > 20000 )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você sÃ³ pode pagar no máximo R$20.000 ao jogador.");

	if ( GetPlayerMoney(playerid) < valor )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem o dinheiro suficiente.");

	if ( pagarTime[playerid] > gettime() )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Aguarde %d segundos para usar o comando novamente.", pagarTime[playerid] - gettime() );
	
	pagarTime[playerid] = gettime() + (60 * 5);

	GivePlayerMoney(playerid, -valor);
	GivePlayerMoney(id, valor);

	new Horas, Minutos, Anos, Meses, Dias, StringMes[128];
	gettime(Horas, Minutos), getdate(Anos, Meses, Dias);
	switch(Meses)
    {
	   	case 1: StringMes = "Janeiro";
	   	case 2: StringMes = "Fevereiro";
	   	case 3: StringMes = "Marco";
	   	case 4: StringMes = "Abril";
	   	case 5: StringMes = "Maio";
	   	case 6: StringMes = "Junho";
	   	case 7: StringMes = "Julho";
	   	case 8: StringMes = "Agosto";
		case 9: StringMes = "Setembro";
		case 10: StringMes = "Outubro";
		case 11: StringMes = "Novembro";
		case 12: StringMes = "Dezembro";
	}

	
	//SendClientMessage(playerid, COR_AZUL, "* {"COR_BRANCO_INC"}Você deu {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"} para o(a) jogador(a) {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"}.", RealStr(valor), GetUserName(id));
	//SendClientMessage(id, COR_AZUL, "* {"COR_BRANCO_INC"}O(A) jogador {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"} deu {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"} para você.", GetUserName(playerid), RealStr(valor));
	SendClientMessage(playerid, COR_AMARELO, "Você transferiu o valor {"COR_VERDE_INC"}R$%s {"COR_AMARELO_INC"}para {ffffff}%s({ffffff}%d{"COR_AMARELO_INC"}).", RealStr(valor), GetUserName(id), id);
	SendClientMessage(id, COR_AMARELO, "O(A) {ffffff}%s({ffffff}%d{"COR_AMARELO_INC"}) transferiu o valor {"COR_VERDE_INC"}R$%s {"COR_AMARELO_INC"}para você.", GetUserName(playerid), playerid, RealStr(valor));

	foreach(new i: Player)
	{
	    if(call::ADMIN->GetPlayerAdminLevel(i))
	    {	
	    	SendClientMessage(i, COR_AMARELO, "| PFC - INFO | O(A) {ffffff}%s {"COR_AMARELO_INC"}transferiu {"COR_VERDE_INC"}R$%s {"COR_AMARELO_INC"}para {ffffff}%s {"COR_AMARELO_INC"}", GetUserName(playerid), RealStr(valor), GetUserName(id));
			SendClientMessage(i, COR_AMARELO, "| PFC - INFO | ( {ffffff}%02d {"COR_AMARELO_INC"}de {ffffff}%s %04d {"COR_AMARELO_INC"}às {ffffff}%02d{"COR_AMARELO_INC"}:{ffffff}%02d {"COR_AMARELO_INC"})", Dias, StringMes, Anos, Horas, Minutos);
		}
	    return true;
	}

	new str[128];
	format(str, sizeof(str), "O jogador %s deu R$%s para %s ( %02d de %s %04d às %02d:%02d )", GetUserName(playerid), RealStr(valor), GetUserName(id), Dias, StringMes, Anos, Horas, Minutos);
	WriteLog("pagar.txt", str);
	return true;
}

CMD:vender(playerid, params[])
{
	new id, valor, tipo[15], qtd;
	if ( sscanf(params, "s[15]idi", tipo, qtd, id, valor))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/vender [Maconha/Cocaina/Crack] [quantidade] [id] [valor cada uma]");

	if(!strcmp(tipo, "Maconha", true))
	{
		if(qtd > call::PLAYER->GetPlayerVarInt(playerid, Maconha)) 
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem toda essa quantia de maconha.");

		if(valor < 200 || valor > 600) 
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você sÃ³ pode digitar valores de 200$ a 600$.");

		new valorapagar = qtd * valor;
		SendClientMessage(playerid, COR_AVISO, "* Você ofereceu ao %s %d kgs de {"COR_VERMELHO_INC"}Maconha{"COR_AVISO_INC"} no Valor de: R$%s.", GetUserName(id), qtd, RealStr(valorapagar));

		SendClientMessage(id, COR_BRANCO, "* %s Está te oferecendo %d kgs de {"COR_VERMELHO_INC"}Maconha{"COR_BRANCO_INC"} no Valor de: {088A08}R$%s.", GetUserName(playerid), qtd, RealStr(valorapagar));
		SendClientMessage(id, COR_AZUL, "* Para aceitar digite: /aceitar maconha e para recusar digite: /recusa rmaconha.");
		SetTimerEx("ExpirouMaconha", 30000, true, "i", id);
		SetPVarInt(id, "OferecedorMID", playerid), SetPVarInt(id, "DinheiroMaconha", valorapagar), SetPVarInt(id, "MaconhaOferecida", 1), SetPVarInt(id, "MQuantidade", qtd);
	}
	else if(!strcmp(tipo, "Cocaina", true))
	{
		if(qtd > call::PLAYER->GetPlayerVarInt(playerid, Cocaina)) 
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem toda essa quantia de cocaina.");

		if(valor < 200 || valor > 600) 
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você sÃ³ pode digitar valores de 200$ a 600$.");

		new valorapagar = qtd * valor;
		SendClientMessage(playerid, COR_AVISO, "* Você ofereceu ao %s %d kgs de {"COR_VERMELHO_INC"}Cocaina{"COR_AVISO_INC"} no Valor de: R$%s.", GetUserName(id), qtd, RealStr(valorapagar));

		SendClientMessage(id, COR_BRANCO, "* %s Está te oferecendo %d kgs de {"COR_VERMELHO_INC"}Cocaina{"COR_BRANCO_INC"} no Valor de: {088A08}R$%s.", GetUserName(playerid), qtd, RealStr(valorapagar));
		SendClientMessage(id, COR_AZUL, "* Para aceitar digite: /aceitar cocaina e para recusar digite: /recusar cocaina.");
		SetTimerEx("ExpirouCocaina", 30000, true, "i", id);
		SetPVarInt(id, "OferecedorCID", playerid), SetPVarInt(id, "DinheiroCocaina", valorapagar), SetPVarInt(id, "CocainaOferecida", 1), SetPVarInt(id, "CQuantidade", qtd);
	}
	else if(!strcmp(tipo, "Crack", true))
	{
		if(qtd > call::PLAYER->GetPlayerVarInt(playerid, Crack)) 
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem toda essa quantia de crack.");

		if(valor < 200 || valor > 600) 
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você sÃ³ pode digitar valores de 200$ a 600$.");

		new valorapagar = qtd * valor;
		SendClientMessage(playerid, COR_AVISO, "* Você ofereceu ao %s %d kgs de {"COR_VERMELHO_INC"}Crack{"COR_AVISO_INC"} no Valor de: R$%s.", GetUserName(id), qtd, RealStr(valorapagar));

		SendClientMessage(id, COR_BRANCO, "* %s Está te oferecendo %d kgs de {"COR_VERMELHO_INC"}Crack{"COR_BRANCO_INC"} no Valor de: {088A08}R$%s.", GetUserName(playerid), qtd, RealStr(valorapagar));
		SendClientMessage(id, COR_AZUL, "* Para aceitar digite: /aceitar crack e para recusar digite: /recusar crack.");
		SetTimerEx("ExpirouCrack", 30000, true, "i", id);
		SetPVarInt(id, "OferecedorCraID", playerid), SetPVarInt(id, "DinheiroCrack", valorapagar), SetPVarInt(id, "CrackOferecida", 1), SetPVarInt(id, "CraQuantidade", qtd);
	}
	return true;
}

CMD:aceitar(playerid, params[])
{
	new Tipo[30];

	if(sscanf(params, "s[30]", Tipo))
			return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/aceitar [servico/conserto/maconha/cocaina/crack]");
		
	if(!strcmp(Tipo, "servico", true))
	{
		if( call::PLAYER->GetPlayerVarInt(playerid, AdvogadoID) == INVALID_PLAYER_ID ) 
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Nenhum advogado lhe ofereceu serviço.");

		new valor = call::PLAYER->GetPlayerVarInt(playerid, AdvogadoValor), valor_advogado = ( valor > 15000 ? 15000 : valor ), ad_id = call::PLAYER->GetPlayerVarInt(playerid, AdvogadoID);

		if ( call::BANK->IsPlayerAccountOpenned(playerid) )
		{
			if ( valor > call::BANK->GetPlayerValueBankAccount(playerid, "saldo") )
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem o saldo suficiente para pagar o advogado.");

			new query[128];
			mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_BANK" SET `saldo`=`saldo`-'%d' WHERE `id`='%d' LIMIT 1;", valor, call::PLAYER->GetPlayerVarInt(playerid, PlayerID) );
			mysql_tquery(getConexao(), query);
		}
		else
		{

			if ( valor > GetPlayerMoney(playerid) )
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem {"COR_BRANCO_INC"}R$%s{"COR_ERRO_INC"} em mãos para pagar o advogado.", RealStr(valor));

			GivePlayerMoney(playerid, -valor);
		}
		

		/**
		*
		* 	advogado set's
		*
		**/
		call::PLAYER->SetPlayerVarInt(playerid, AdvogadoID, INVALID_PLAYER_ID);
		call::PLAYER->SetPlayerVarInt(playerid, AdvogadoValor, 0);

		call::PM->SoltarPrisioneiro(playerid);


		/**
		*
		* 	advogado set's
		*
		**/
		
		call::PLAYER->SetPlayerVarInt(ad_id, PrisioneiroID, INVALID_PLAYER_ID);
		GivePlayerMoney(ad_id, valor_advogado);
		SendClientMessage(ad_id, COR_AVISO, "* O(A) jogador(a) {"COR_BRANCO_INC"}%s{"COR_AVISO_INC"} aceitou seus serviços e você ganhou {"COR_VERDE_INC"}%s.", GetUserName(playerid), RealStr(valor_advogado));
		return true;
	}
	else if(!strcmp(Tipo, "conserto", true))
	{
		if(GetPVarInt(playerid, "MecSolicitado") < 1)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não te ofereceram uma reparação.");

		new valorapagar = GetPVarInt(playerid, "DinheiroReparo"), mecanicoid = GetPVarInt(playerid, "MecanicoID"), vehicleid = Jogador[mecanicoid][ReparandoVeiculo];

		if(GetPlayerMoney(playerid) < valorapagar)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente.");

		if(mecanicoid == playerid)
		{
			SetVehicleHealth(vehicleid, 1000.0), RepairVehicle(vehicleid);
			SendClientMessage(playerid, COR_BRANCO, "* Você consertou seu veículo.");
			call::MECANICO->CancelarServico(mecanicoid);
			DeletePVar(playerid, "MecanicoID"), DeletePVar(playerid, "DinheiroReparo"), DeletePVar(playerid, "MecSolicitado");
		}
		else
		{
			SendClientMessage(mecanicoid, COR_BRANCO, "* {"COR_AMARELO_INC"}%s{"COR_BRANCO_INC"} Aceitou seu conserto e você recebeu: {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}.", GetUserName(playerid), RealStr(valorapagar));
			GivePlayerMoney(mecanicoid, valorapagar);
			RepairVehicle(vehicleid), SetVehicleHealth(vehicleid, 1000.0);
			SendClientMessage(playerid, COR_BRANCO, "* Você aceitou o conserto de {"COR_VERDE_INC"}%s{"COR_BRANCO_INC"} e pagou o Valor de: {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}.", GetUserName(mecanicoid), RealStr(valorapagar));
			GivePlayerMoney(playerid, -valorapagar);
			call::MECANICO->CancelarServico(mecanicoid);
			DeletePVar(playerid, "MecanicoID"), DeletePVar(playerid, "DinheiroReparo"), DeletePVar(playerid, "MecSolicitado");
		}
		return true;
	}
	else if(!strcmp(Tipo, "maconha", true))
	{
		if(GetPVarInt(playerid, "MaconhaOferecida") < 1)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não te ofereceram Maconha.");

		new valorapagar = GetPVarInt(playerid, "DinheiroMaconha");

		SendClientMessage(GetPVarInt(playerid, "OferecedorMID"), COR_BRANCO, "* %s Aceitou sua Maconha e você recebeu: {088A08}R$%s", GetUserName(playerid), RealStr(valorapagar));
		GivePlayerMoney(GetPVarInt(playerid, "OferecedorMID"), valorapagar);
		call::PLAYER->SetPlayerVarInt(GetPVarInt(playerid, "OferecedorMID"), Maconha, call::PLAYER->GetPlayerVarInt(GetPVarInt(playerid, "OferecedorMID"), Maconha) - GetPVarInt(playerid, "MQuantidade"));

		SendClientMessage(playerid, COR_AVISO, "* Você aceitou a Maconha de %s e pagou o Valor de: {088A08}R$%s", GetUserName(GetPVarInt(playerid, "OferecedorMID")), RealStr(valorapagar));
		GivePlayerMoney(playerid, -valorapagar);
		call::PLAYER->SetPlayerVarInt(playerid, Maconha, call::PLAYER->GetPlayerVarInt(playerid, Maconha) + GetPVarInt(playerid, "MQuantidade"));

		DeletePVar(playerid, "OferecedorMID"), DeletePVar(playerid, "DinheiroMaconha"), DeletePVar(playerid, "MaconhaOferecida"), DeletePVar(playerid, "MQuantidade");
	}
	else if(!strcmp(Tipo, "cocaina", true))
	{
		if(GetPVarInt(playerid, "CocainaOferecida") < 1)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não te ofereceram Cocaina.");

		new valorapagar = GetPVarInt(playerid, "DinheiroCocaina");

		SendClientMessage(GetPVarInt(playerid, "OferecedorCID"), COR_BRANCO, "* %s Aceitou sua Cocaina e você recebeu: {088A08}R$%s", GetUserName(playerid), RealStr(valorapagar));
		GivePlayerMoney(GetPVarInt(playerid, "OferecedorCID"), valorapagar);
		call::PLAYER->SetPlayerVarInt(GetPVarInt(playerid, "OferecedorCID"), Cocaina, call::PLAYER->GetPlayerVarInt(GetPVarInt(playerid, "OferecedorCID"), Cocaina) - GetPVarInt(playerid, "CQuantidade"));

		SendClientMessage(playerid, COR_AVISO, "* Você aceitou a Cocaina de %s e pagou o Valor de: {088A08}R$%s", GetUserName(GetPVarInt(playerid, "OferecedorCID")), RealStr(valorapagar));
		GivePlayerMoney(playerid, -valorapagar);
		call::PLAYER->SetPlayerVarInt(playerid, Cocaina, call::PLAYER->GetPlayerVarInt(playerid, Cocaina) + GetPVarInt(playerid, "CQuantidade"));

		DeletePVar(playerid, "OferecedorCID"), DeletePVar(playerid, "DinheiroCocaina"), DeletePVar(playerid, "CocainaOferecida"), DeletePVar(playerid, "CQuantidade");
	}
	else if(!strcmp(Tipo, "crack", true))
	{
		if(GetPVarInt(playerid, "CrackOferecida") < 1)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não te ofereceram Crack.");

		new valorapagar = GetPVarInt(playerid, "DinheiroCrack");

		SendClientMessage(GetPVarInt(playerid, "OferecedorCraID"), COR_BRANCO, "* %s Aceitou seu Crack e você recebeu: {088A08}R$%s", GetUserName(playerid), RealStr(valorapagar));
		GivePlayerMoney(GetPVarInt(playerid, "OferecedorCraID"), valorapagar);
		call::PLAYER->SetPlayerVarInt(GetPVarInt(playerid, "OferecedorCraID"), Crack, call::PLAYER->GetPlayerVarInt(GetPVarInt(playerid, "OferecedorCraID"), Crack) - GetPVarInt(playerid, "CraQuantidade"));

		SendClientMessage(playerid, COR_AVISO, "* Você aceitou o Crack de %s e pagou o Valor de: {088A08}R$%s", GetUserName(GetPVarInt(playerid, "OferecedorCraID")), RealStr(valorapagar));
		GivePlayerMoney(playerid, -valorapagar);
		call::PLAYER->SetPlayerVarInt(playerid, Crack, call::PLAYER->GetPlayerVarInt(playerid, Crack) + GetPVarInt(playerid, "CraQuantidade"));

		DeletePVar(playerid, "OferecedorCraID"), DeletePVar(playerid, "DinheiroCrack"), DeletePVar(playerid, "CrackOferecida"), DeletePVar(playerid, "CraQuantidade");
	}
	return true;
}

CMD:recusar(playerid, params[])
{
	new Tipo[30];

	if(sscanf(params, "s[30]", Tipo))
			return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/recusar [servico/conserto/maconha/cocaina/crack]");

	if(!strcmp(Tipo, "conserto", true))
	{
		if(GetPVarInt(playerid, "MecSolicitado") < 1)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não te ofereceram uma reparação.");

		new mecanicoid = GetPVarInt(playerid, "MecanicoID"), vehicleid = Jogador[mecanicoid][ReparandoVeiculo];

		UpdateVehicleDoorsDamageStatus(vehicleid, State[vehicleid][Doors][0], State[vehicleid][Doors][1], State[vehicleid][Doors][2], State[vehicleid][Doors][3]);
		UpdateVehicleLightsDamageStatus(vehicleid, State[vehicleid][Lights][0], State[vehicleid][Lights][1], State[vehicleid][Lights][2], State[vehicleid][Lights][3]);
		UpdateVehicleTiresDamageStatus(vehicleid, State[vehicleid][Tires][0], State[vehicleid][Tires][1], State[vehicleid][Tires][2], State[vehicleid][Tires][3]);

		SendClientMessage(mecanicoid, COR_AVISO, "* %s Recusou o conserto do veículo.", GetUserName(playerid));

		SendClientMessage(playerid, COR_AVISO, "* Você recusou a reparação de %s e seu carro voltou ao estado normal.", GetUserName(mecanicoid));

		call::MECANICO->CancelarServico(mecanicoid);
		DeletePVar(playerid, "MecanicoID"), DeletePVar(playerid, "DinheiroReparo"), DeletePVar(playerid, "MecSolicitado");
		return true;
	}
	else if(!strcmp(Tipo, "servico", true))
	{
		if(GetPVarInt(playerid, "AdvSolicitado") == 0) 
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Serviços inexistentes.");

		SendClientMessage(GetPVarInt(playerid, "AdvogadoID"), COR_AVISO, "* O jogador {"COR_BRANCO_INC"}%s{"COR_AVISO_INC"} recusou seus serviços.", GetUserName(playerid));
		DeletePVar(playerid, "AdvSolicitado"), DeletePVar(playerid, "AdvogadoID");
		return true;
	}
	else if(!strcmp(Tipo, "maconha", true))
	{
		if(GetPVarInt(playerid, "MaconhaOferecida") < 1)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não te ofereceram Maconha.");

		SendClientMessage(GetPVarInt(playerid, "OferecedorID"), COR_VERMELHO, "* %s Recusou sua Maconha.", GetUserName(playerid));

		SendClientMessage(playerid, COR_VERMELHO, "* Você recusou a Maconha de %s.", GetUserName(GetPVarInt(playerid, "OferecedorID")));

		DeletePVar(playerid, "OferecedorMID"), DeletePVar(playerid, "DinheiroMaconha"), DeletePVar(playerid, "MaconhaOferecida"), DeletePVar(playerid, "MQuantidade");
	}
	else if(!strcmp(Tipo, "cocaina", true))
	{
		if(GetPVarInt(playerid, "CocainaOferecida") < 1)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não te ofereceram Cocaina.");

		SendClientMessage(GetPVarInt(playerid, "OferecedorCID"), COR_VERMELHO, "* %s Recusou sua Cocaina.", GetUserName(playerid));

		SendClientMessage(playerid, COR_VERMELHO, "* Você recusou a Cocaina de %s.", GetUserName(GetPVarInt(playerid, "OferecedorCID")));

		DeletePVar(playerid, "OferecedorCID"), DeletePVar(playerid, "DinheiroCocaina"), DeletePVar(playerid, "CocainaOferecida"), DeletePVar(playerid, "CQuantidade");
	}
	else if(!strcmp(Tipo, "crack", true))
	{
		if(GetPVarInt(playerid, "CrackOferecida") < 1)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não te ofereceram Crack.");

		SendClientMessage(GetPVarInt(playerid, "OferecedorCraID"), COR_VERMELHO, "* %s Recusou seu Crack.", GetUserName(playerid));

		SendClientMessage(playerid, COR_VERMELHO, "* Você recusou o Crack de %s.", GetUserName(GetPVarInt(playerid, "OferecedorCraID")));

		DeletePVar(playerid, "OferecedorCraID"), DeletePVar(playerid, "DinheiroCrack"), DeletePVar(playerid, "CrackOferecida"), DeletePVar(playerid, "CraQuantidade");
	}
	return true;
}


CMD:usar(playerid, params[])
{
	if ( isnull(params) )
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/usar [maconha/crack/cocaina]");

	if ( strcmp(params, "maconha", true) == 0 )
	{
		if ( !Jogador[playerid][Maconha] )
		{
			SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem maconha para fumar.");
			return 1;
		}

		static Float:health;
		GetPlayerHealth(playerid, health);
		if ( health < 100 )
			SetPlayerHealth(playerid, health + 3.5);

		--Jogador[playerid][Maconha];
		SendClientMessage(playerid, 0x009264FF, "* Você fumou um baseado.");
		return true;
	}
	else if ( strcmp(params, "cocaina", true) == 0 )
	{
		if ( !Jogador[playerid][Cocaina] )
		{
			SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem cocaina para cheirar.");
			return 0;
		}

		static Float:health, Float:armour;

		GetPlayerHealth(playerid, health);

		GetPlayerArmour(playerid, armour);
		
		if ( health < 100 )
			SetPlayerHealth(playerid, health + 5.0);

		if ( armour < 50 )
			SetPlayerArmour(playerid, armour + 3.0);

		SendClientMessage(playerid, 0x009264FF, "* Você cheirou sua cocaina.");
		--Jogador[playerid][Cocaina];
		return true;
	}
	else if ( strcmp(params, "crack", true) == 0 )
	{
		if ( !Jogador[playerid][Crack] )
		{
			SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem crack para fumar.");
			return 1;
		}

		static Float:armour;
		GetPlayerArmour(playerid, armour);

		if ( armour < 60 )
			SetPlayerArmour(playerid, armour + 10.0);

		--Jogador[playerid][Crack];
		SendClientMessage(playerid, 0x009264FF, "* Você fumou uma pedra de crack.");
		return true;
	}
	return true;
}

CMD:mudaremail(playerid, params[])
{
	new email[100];

	if(sscanf(params, "s[100]", email))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /MudarEmail [email].");
	
	if ( call::PLAYER->IsEmailRegistered(email) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O email {"COR_BRANCO_INC"}%s{"COR_ERRO_INC"} já existe cadastrado em nosso banco de dados.", email);

	if(!IsValidEmail(email))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa digitar um email válido.");
	
	new string[200];
	format(string, sizeof(string), "{ffffff}Você está prestes a alterar seu email para: {"COR_AZUL_INC"}%s\n{ffffff}Confirma?", email);
	ShowPlayerDialog(playerid, DIALOG_MUDAR_EMAIL, DIALOG_STYLE_MSGBOX, "{ff0000}Alteração de Email", string, "Alterar", "Cancelar");

	SetPVarString(playerid, "NewEmail", email);
	return 1;
}

CMD:meunivel(playerid, params[])
{
	new _str[500];

	format(_str, sizeof(_str), "{"COR_AZUL_INC"}Nível: {ffffff}%d\n\
{"COR_AZUL_INC"}Experiência: {ffffff}%d{"COR_AZUL_INC"}/{ffffff}%d", GetPlayerScore(playerid), Jogador[playerid][EXP], call::PLAYER->requestXP(playerid));
	ShowPlayerDialog(playerid, DIALOG_MEUNIVEL, DIALOG_STYLE_MSGBOX, "Meu Nível", _str, "Ok", #);
	return true;
}


/*CMD:menubtc(playerid)
{
	ShowPlayerDialog(playerid, MENU_CASH, DIALOG_STYLE_TABLIST, "MENU BITCOINS", "Ativar BitCoins", "Confirmar", "Fechar");
	return true;
}*/