/*flags:comandosadmin(AJUDANTE); alias:comandosadmin("cmdsadm", "cargo", "aa");
CMD:comandosadmin(playerid, params[])
{
    new string[300], admlevel = call::ADMIN->GetPlayerAdminLevel(playerid);

    if(admlevel == AJUDANTE) { strcat(string, "Comandos de Ajudante\n"); } // Ajudante
    if(admlevel == MODERADOR) { strcat(string, "Comandos de Ajudante\nComandos de Moderador(a)\n"); } // Moderador(a)
    if(admlevel == ADMINISTRADOR) { strcat(string, "Comandos de Ajudante\nComandos de Moderador(a)\nComandos de Administrador(a)\n"); } // Administrador(a)
    if(admlevel == DIRECAO) { strcat(string, "Comandos de Ajudante\nComandos de Moderador(a)\nComandos de Administrador(a)\nComandos de Diretor(a)\n"); }
    if(admlevel == DEV) { strcat(string, "Comandos de Ajudante\nComandos de Moderador(a)\nComandos de Administrador(a)\nComandos de Diretor(a)\nComandos de Desenvolvedor(a)"); } // Diretor(a)

    ShowPlayerDialog(playerid, DIALOG_CMDSADM, DIALOG_STYLE_LIST, "Comandos Admin - Início", string, "Selecionar", "Cancelar");

    return 1;
}*/

flags:comandosadm(AJUDANTE); alias:comandosadm("cmdsadm", "cargo", "aa");
CMD:comandosadm(playerid, params[])
{
	new string[4000], admlevel = call::ADMIN->GetPlayerAdminLevel(playerid);

	SetPVarInt(playerid, "PagCmdAdm", 1);

	strcat(string, "{ff8000}Comando\t{ffffff}Função\n");
	strcat(string, "{ff8000}/Ca [Mensagem]\t{ffffff}Para falar no chat admin.\n");
	strcat(string, "{ff8000}/CC [Mensagem]\t{ffffff}Para falar no chat do cargo admin.\n");
	strcat(string, "{ff8000}/Ir [ID]\t{ffffff}Para ir até a posição de algum(a) jogador(a).\n");
	strcat(string, "{ff8000}/Trazer [ID]\t{ffffff}Para trazer um(a) jogador(a) até a sua posição.\n");
	strcat(string, "{ff8000}/A [Texto]\t{ffffff}Para enviar uma mensagem no chat global do servidor.\n");
	strcat(string, "{ff8000}/Desbugar [ID]\t{ffffff}Para desbugar um(a) jogador(a).\n");
	strcat(string, "{ff8000}/Congelar [ID]\t{ffffff}Para congelar um(a) jogador(a).\n");
	strcat(string, "{ff8000}/Descongelar [ID]\t{ffffff}Para descongelar um(a) jogador(a).\n");
    strcat(string, "{ff8000}/TrabalharAdm\t{ffffff}Para entrar no Modo Admin.\n");
	strcat(string, "{ff8000}/Reparar\t{ffffff}Para reparar o veículo que está usando.\n");
	strcat(string, "{ff8000}/Atividade\t{ffffff}Para ver seu tempo total de administração.\n");
	strcat(string, "{ff8000}/PM [ID] [Mensagem]\t{ffffff}Para enviar uma mensagem privada para algum(a) jogador(a).\n");
	strcat(string, "{ff8000}/BPM\t{ffffff}Para bloquear e desbloquear suas mensagens privadas.\n");
	strcat(string, "{ff8000}/Interiores\t{ffffff}Para ver a lista de interiores do servidor.\n");
	strcat(string, "{ff8000}/GodMod\t{ffffff}Para ficar com a vida infinita.\n");
	strcat(string, "{ff8000}/GodCar\t{ffffff}Para deixar seu veículo indestrutivel.\n");
	strcat(string, "{ff8000}/Espiar [ID]\t{ffffff}Para espiar um(a) jogador(a).\n");
	strcat(string, "{ff8000}/PararEspiar\t{ffffff}Para parar de espiar algum(a) jogador(a).\n");
	strcat(string, "{ff8000}/Calar [ID] [Motivo]\t{ffffff}Para mutar um(a) jogador(a) no servidor.\n");
	strcat(string, "{ff8000}/Descalar [ID]\t{ffffff}Para desmutar um(a) jogador(a) no servidor.\n");
	strcat(string, "{ff8000}/Cadeia [ID] [Tempo] [Motivo]\t{ffffff}Para prender algum(a) jogador(a) na cadeia administrativa.\n");
	strcat(string, "{ff8000}/Liberar [ID] [Motivo]\t{ffffff}Para soltar algum(a) jogador(a) da cadeia administrativa.\n");
	strcat(string, "{ff8000}/Kick [ID] [Motivo]\t{ffffff}Para kickar um(a) jogador(a) do servidor.\n");
	strcat(string, "{ff8000}/Aviso [ID] [Motivo]\t{ffffff}Para avisar um(a) jogador(a).\n");
	strcat(string, "{ff8000}/RetirarAviso [ID] [Quantia]\t{ffffff}Para retirar avisos de um(a) jogador(a).\n");
	strcat(string, "{ff8000}/Vida [ID]\t{ffffff}Para recuperar a vida de algum(a) jogador(a).\n");
	strcat(string, "{ff8000}/DarCarona [ID]\t{ffffff}Para colocar algum(a) jogador(a) de carona em seu veículo.\n");
	strcat(string, "{ff8000}/Guinchar\t{ffffff}Para guinchar um veículo que esteja próximo de você.\n");
	strcat(string, "{ff8000}/Desguinchar\t{ffffff}Para desguinchar um veículo que esteja próximo de você.\n");
	strcat(string, "{ff8000}/VerSaldo [ID]\t{ffffff}Para ver o saldo em mãos e no banco de um(a) jogador(a).\n");
	strcat(string, "{ff8000}/CV [ID]\t{ffffff}Para criar um veículo administrativo.\n");
	strcat(string, "{ff8000}/DV\t{ffffff}Para deletar um veículo administrativo.\n");
	strcat(string, "{ff8000}/DVs\t{ffffff}Para deletar todos os veículos administrativos criados por você.\n");
	strcat(string, "{ff8000}/SetarFSS [ID] [Quantia]\t{ffffff}Para setar Fome/Sede/Sono para algum(a) jogador(a).\n");
	strcat(string, "{ff8000}/Cnn [Texto]\t{ffffff}Para enviar uma mensagem na tela dos(as) jogadores(as) (com nick).\n");
	strcat(string, "{ff8000}/Ann [Texto]\t{ffffff}Para enviar uma mensagem na tela dos(as) jogadores(as) (sem nick)\n");
	strcat(string, "{ff8000}/CnnLista\t{ffffff}Para ver os auxilios de CNN Disponíveis.\n");
	strcat(string, "{ff8000}/Contar [SEGUNDOS]\t{ffffff}Para iniciar uma contagem na tela.\n");
	strcat(string, "{ff8000}/CorNick [Código-Html]\t{ffffff}Para trocar a cor de seu nick.\n");
	strcat(string, "{ff8000}/Players\t{ffffff}Para ver os players online.\n");
	strcat(string, "{ff8000}/Desarmar [ID]\t{ffffff}Para desarmar um jogador(a).\n");
	strcat(string, "{ff8000}/Proximos\t{ffffff}Para ver os jogadores próximos a você.\n");
	strcat(string, "{ff8000}/Novatos\t{ffffff}Para ver os jogadores novatos do servidor.\n");
	strcat(string, "{ff8000}/LimparChat\t{ffffff}Para limpar o chat log do servidor.\n");
	strcat(string, "{ff8000}/Tapa [ID]\t{ffffff}Para dar um tapa em um jogador(a).\n");
	strcat(string, "{ff8000}/RV\t{ffffff}Para respawnar um veículo.\n");
	if(admlevel > 1) { strcat(string, "{ff0000}Próxima Página"); }

	ShowPlayerDialog(playerid, DIALOG_CMDSADM, DIALOG_STYLE_TABLIST_HEADERS, "Comandos Admin - Ajudante", string, "Selecionar", "Cancelar");

	return 1;
}

flags:darcarona(AJUDANTE); alias:darcarona("carona");
CMD:darcarona(playerid, params[])
{
    new id, motorista = GetPlayerState(playerid), Carro = GetPlayerVehicleID(playerid);

    if(sscanf(params, "u", id)) 
    	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /DarCarona (id)");

    if(!IsPlayerInAnyVehicle(playerid)) 
    	return SendClientMessage(playerid, COR_ERRO, "| ERRO | É preciso estar em um veículo!");

    else if(motorista !=  PLAYER_STATE_DRIVER) 
    	return SendClientMessage(playerid, COR_ERRO, "| ERRO | É preciso ser o motorista do veículo!");

    else if(!IsPlayerConnected(id)) 
    	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a)!");

	SetPlayerInterior(id, GetPlayerInterior(playerid));
	if(!IsVehicleSeatOccupied(Carro, 1)){
		PutPlayerInVehicle(id, Carro, 1);
	}
	else if(!IsVehicleSeatOccupied(Carro, 3)){
		PutPlayerInVehicle(id, Carro, 3);
	}
	else if(!IsVehicleSeatOccupied(Carro, 4)){
		PutPlayerInVehicle(id, Carro, 4);
	}
	else{
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Não tem mais vaga no veiculo.");
		return true;
	}

	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s te deu uma carona!", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
    SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você deu uma carona para o(a) jogador(a) %s[%d]!", GetUserName(id), id);
	return true;
}

flags:d(AJUDANTE);
CMD:d(playerid, params[])
{
    new id, resposta[128];

    if(sscanf(params, "ds[128]", id, resposta))
    	return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/d (id) (resposta)");

    if(!IsPlayerConnected(id))
    	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a)!");

    SendClientMessage(id, COR_AZUL, "| DÚVIDA | Dúvida respondida do(a) %s %s ( %s )", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), resposta);
	SendClientMessage(playerid, COR_AZUL, "| DÚVIDA | Você respondeu a dúvida do(a) jogador(a) %s[%d] ( %s )", GetUserName(id), id, resposta);

	foreach(new i: Player)
	{
		if(call::ADMIN->GetPlayerAdminLevel(i) >= AJUDANTE && call::ADMIN->IsAdminInJob(i))
		{
			SendClientMessage(i, COR_AZUL, "| PFC - ADMIN | O(A) %s %s respondeu a dúvida do(a) jogador(a) %s[%d] ( %s )", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), GetUserName(id), id, resposta);
		}
	}

    GameTextForPlayer(id, "~g~Duvida Respondida", 5000, 3);
    PlayerPlaySound(id, 1085, -1, -1, -1);
    return true;
}

flags:global(AJUDANTE); alias:global("a", "g");
CMD:global(playerid, params[])
{
	if(isnull(params))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/anunciar [mensagem]");

	SendClientMessageToAll(0xFFFF00AA, "| AVISO | O(A) %s %s diz: {ffffff}%s", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), params);
	return true;
}

flags:interiores(AJUDANTE);
CMD:interiores(playerid)
{
	new str[1024 * 3];
	for(new i; i < MAX_INTERIORS; i++)
	{
		format(str, sizeof(str), "%s%s\n", str, InteriorInfo[i][iName]);
	}
	ShowPlayerDialog(playerid, D_INTERIORES, DIALOG_STYLE_LIST, "LISTA DE INTERIORES", str, "Ir", "Fechar");
}

flags:contar(AJUDANTE);
CMD:contar(playerid, params[])
{
	//new ContagemNormal;
	//if(sscanf(params, "d", ContagemNormal)) return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /Contar (segundos)");
//
	//if(ContagemNormal < 1 || ContagemNormal > 30)
	//	return SendClientMessage(playerid, COR_ERRO, "Para de trollar fela da puta");

	SendClientMessage(playerid, COR_AMARELO, "| PFC - ADMIN | Você iniciou uma contagem de 5 segundos");

	CreateCountdown(5, 1);
	return true;
}

flags:infoconta(ADMINISTRADOR);
CMD:infoconta(playerid, params[])
{
	if( isnull(params) )
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/infoconta [username]");

	new query[256];
	mysql_format(getConexao(), query, sizeof(query), "SELECT *,DATEDIFF(`vencimento_vip`, CURRENT_DATE) as `dias_vip` FROM "TABLE_USERS" WHERE `username`='%s' AND `admin`<'%d' LIMIT 1;", params, call::ADMIN->GetPlayerAdminLevel(playerid) );
	mysql_query(getConexao(), query);

	if(cache_num_rows())
	{
		new email[MAX_PLAYER_EMAIL], vip, cargo, dinheiro, profissao, jobname[50], dataR[40], dataL[40], ip[16];

		cache_get_value_name(0, "email", email, sizeof(email));
		cache_get_value_name_int(0, "dias_vip", vip);
		cache_get_value_name_int(0, "admin", cargo);
		cache_get_value_name_int(0, "dinheiro", dinheiro);

		cache_get_value_name_int(0, "profissao", profissao);
		call::JOB->GetJobName(profissao, jobname, sizeof(jobname));

		cache_get_value_name(0, "data_registro", dataR, sizeof(dataR));
		cache_get_value_name(0, "ultimo_login", dataL, sizeof(dataL));

		cache_get_value_name(0, "ip", ip, sizeof(ip));

		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "INFORMAÇÕES DO JOGADOR", 
			"{"COR_BRANCO_INC"}Nome: {"COR_SISTEMA_INC"}%s{"COR_BRANCO_INC"}\n\
Email: {"COR_SISTEMA_INC"}%s{"COR_BRANCO_INC"}\n\
Função: {"COR_SISTEMA_INC"}%s{"COR_BRANCO_INC"}\n\
VIP: %s{"COR_BRANCO_INC"}\n\
Dinheiro: {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}\n\
Profissão: {"COR_SISTEMA_INC"}%s{"COR_BRANCO_INC"}\n\
Último Login: {"COR_SISTEMA_INC"}%s{"COR_BRANCO_INC"}\n\
Registro: {"COR_SISTEMA_INC"}%s{"COR_BRANCO_INC"}\n\
IP: {"COR_ERRO_INC"}%s{"COR_BRANCO_INC"}",
			"OK", "", params, email, call::ADMIN->CargoAdmin(cargo), (vip ? ("{"COR_VERDE_INC"}sim"):("{"COR_ERRO_INC"}não")), RealStr(dinheiro), jobname, dataL, dataR, ip);
		return true;
	}
	SendClientMessage(playerid, COR_ERRO, "| ERRO | Usúario não encontrado no banco de dados.");
	return true;
}

flags:versenhas(DEV);
CMD:versenhas(playerid, params[])
{

	new id;

	if(sscanf(params, "u", id))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/agendarprisao [username] [tempo] [motivo]");

	if ( !IsPlayerConnected(id) )
		return SendClientMessage(playerid, -1, "nao conectado");

	SendClientMessage(playerid, -1, "Usuario: {"COR_AZUL_INC"}%s {ff0000}|| {ffffff}Senha: {"COR_AZUL_INC"}%s", GetUserName(id), Jogador[id][Senha]);

	return true;
}

flags:bpm(AJUDANTE);
CMD:bpm(playerid)
{
	call::PLAYER->SetPlayerVarBool(playerid, bPM, (call::PLAYER->GetPlayerVarBool(playerid, bPM) ? false : true));
	SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Você %s o PM.", (call::PLAYER->GetPlayerVarBool(playerid, bPM)?("{"COR_ERRO_INC"}bloqueou{"COR_BRANCO_INC"}"):("{"COR_VERDE_INC"}desbloqueou{"COR_BRANCO_INC"}")));
	return true;
}

flags:pm(AJUDANTE);
CMD:pm(playerid, params[])
{
	new id, mensagem[100];
	if(sscanf(params, "us[100]", id, mensagem))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/pm [playerid/username] [mensagem]");

	if(id == playerid)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode enviar uma PM a você mesmo.");

	if(!call::PLAYER->IsPlayerLogged(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a).");

	if(call::PLAYER->GetPlayerVarBool(id, bPM))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Este(a) Admin está com os PMs bloqueados.");
	
	/*if ( call::ADMIN->GetPlayerAdminLevel(id) < AJUDANTE )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você só pode usar esse comando para enviar PM a membros da administração.");*/
		
	SendClientMessage(id, COR_VERMELHO, "| PM | O(A) %s %s enviou um PM: %s", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), mensagem);
	SendClientMessage(playerid, COR_VERMELHO, "| PM | PM enviado para o(a) jogador(a) %s[%d]: %s", GetUserName(id), id, mensagem);
	
	printf("[PM] %s[%d] enviou: %s", GetUserName(playerid), playerid, mensagem);

	new str[128];
	format(str, sizeof(str), "[PM] %s enviou uma mensagem para %s: %s", GetUserName(playerid), GetUserName(id), mensagem);
	WriteLog("PMs.txt", str, sizeof(str));
	return true;
}

flags:atividade(AJUDANTE);
CMD:atividade(playerid)
{
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "BEM VINDO ADMIN", 
			"{"COR_BRANCO_INC"}Você é %s deste servidor.\n\n\
Atividade no servidor: {"COR_AZUL_INC"}%02d:%02d:%02d{"COR_BRANCO_INC"}\n\
Avisos: {"COR_AZUL_INC"}%d{"COR_BRANCO_INC"}/8\n\n\t\
Você pode digitar {"COR_AZUL_INC"}/cmdsadm{"COR_BRANCO_INC"} para ver os comandos administrativos.", 
			"OK", "", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid), true, COR_BRANCO_INC), Jogador[playerid][TempoAtividade][HORAS], Jogador[playerid][TempoAtividade][MINUTOS], Jogador[playerid][TempoAtividade][SEGUNDOS], Jogador[playerid][AdminAvisos]);
	return true;
}

flags:fakecmd(DIRECAO);
CMD:fakecmd(playerid, params[])
{
	new id, command[128];
	if(sscanf(params, "ds[128]", id, command))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/fakecmd [playerid] [command]");

	if (IsPlayerNPC(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em NPCs do servidor.");

	if(!call::PLAYER->IsPlayerLogged(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a).");

	PC_EmulateCommand(id, command);
	return true;
}

flags:setarfss(AJUDANTE);
CMD:setarfss(playerid, params[])
{
	new id, qtd;
	if(sscanf(params, "ud", id, qtd))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/setarfss [playerid/username] [quantidade]");

	if(!call::PLAYER->IsPlayerLogged(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Jogador não está conectado");

	if (IsPlayerNPC(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em NPCs do servidor.");

	if(qtd < 0 || qtd > 100)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você pode digitar valores 0 a 100.");

	call::PLAYER->SetPlayerVarInt(id, Fome, qtd);
	call::PLAYER->SetPlayerVarInt(id, Sono, qtd);
	call::PLAYER->SetPlayerVarInt(id, Sede, qtd);

	AtualizarFSS(id);

	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s setou seu Fome/Sede/Sono para %d.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), qtd);
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você setou o Fome/Sede/Sono do(a) jogador(a) %s[%d] para %d.", GetUserName(id), id, qtd);
	new str[128];
	format(str, sizeof(str), "[FSS] O(A) %s %s setou o FSS de %s para %f", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), GetUserName(id), qtd);
	WriteLog(FILE_ADMINS_SETS, str);
	return true;
}

flags:vida(AJUDANTE);
CMD:vida(playerid, params[])
{
	new id;
	if(sscanf(params, "uf", id))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/vida [playerid / username]");

	if(!call::PLAYER->IsPlayerLogged(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Jogador não está conectado.");

	if (IsPlayerNPC(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em NPCs do servidor.");

	SetPlayerHealth(id, 100);

	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s recuperou sua vida!", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você recuperou a vida do(a) jogador(a) %s[%d]!", GetUserName(id), id);

	new str[128];
	format(str, sizeof(str), "[VIDA] O(A) %s %s recuperou a vida de %s", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), GetUserName(id));
	WriteLog(FILE_ADMINS_SETS, str);
	return true;
}

flags:darcolete(DIRECAO);
CMD:darcolete(playerid, params[])
{
	new id, colete;
	if(sscanf(params, "ud", id, colete))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/darcolete [playerid / username] [colete]");

	if(colete > 100)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Só pode usar números entre 0 e 100.");

	if(!call::PLAYER->IsPlayerLogged(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Jogador não está conectado.");

	if (IsPlayerNPC(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em NPCs do servidor.");
	
	SetPlayerArmour(id, colete);

	new str[128];
	format(str, sizeof(str), "| PFC - ADMIN | O %s %s setou o colete de %s para %f", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), GetUserName(id), colete);
	WriteLog(FILE_ADMINS_SETS, str);

	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s setou seu colete para %d", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), colete);
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você setou o colete do(a) jogador(a) %s[%d] para %d.", GetUserName(id), id, colete);

	return true;
}

flags:skin(MODERADOR);
CMD:skin(playerid, params[])
{
	new id, skinid;
	if(sscanf(params, "ud", id, skinid))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/setarskin [playerid / username] [skinid]");

	if (IsPlayerNPC(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em NPCs do servidor.");

	if(!call::PLAYER->IsPlayerLogged(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Jogador não está conectado no momento.");

	
	SetPlayerSkin(id, skinid);
	call::PLAYER->SetPlayerVarInt(id, Skin, skinid);

	new str[128];
	format(str, sizeof(str), "| PFC - ADMIN | O(A) %s %s setou a skin id %d para %s", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), skinid, GetUserName(id));
	WriteLog(FILE_ADMINS_SETS, str);

	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você setou a skin do(a) jogador(a) %s[%d] para %d.", GetUserName(id), id, skinid);
	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s setou a skin %d para você!", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), skinid);
	return true;
}


alias:logaradm("trabalharadm");
CMD:logaradm(playerid)
{
	if(call::ADMIN->GetPlayerAdminLevel(playerid) < AJUDANTE)
		return SendClientMessage(playerid, COR_AMARELO, "| AVISO | Você digitou ( {"COR_BRANCO_INC"}/logaradm {"COR_AMARELO_INC"}) e o comando não foi encontrado, use {"COR_BRANCO_INC"}/Ajuda {"COR_AMARELO_INC"}ou {"COR_BRANCO_INC"}/Duvida"), false;
	
	switch(call::ADMIN->IsAdminInJob(playerid))
	{
		case true:
		{
			SendClientMessage(playerid, 0xff6800ff, "| PFC - LOGIN | Você saiu do modo administração!");
			call::ADMIN->ToggleAdminInJob(playerid, false);
			SendLog(LOG_LOGINADMIN, "| PFC-Logs | O(A) %s %s saiu do modo administrativo.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), \
					GetUserName(playerid));
		}
		case false:
		{
			new query[350];
			format(query, 350, "SELECT `senhaadmin` FROM `usuarios` WHERE `id`='%d'", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
			new Cache:result = mysql_query(getConexao(), query, true), rows = cache_num_rows();
			if(rows > 0)
			{
				new senha[10];
				cache_get_value_name(0, "senhaadmin", senha);
				if(strlen(senha) < 3)
				{
	
					SendClientMessage(playerid, 0xff6800ff, "| PFC - LOGIN | Bem vindo(a) à Administração {ffffff}%s", GetUserName(playerid));
					SendClientMessage(playerid, 0xff6800ff, "| PFC - LOGIN | Você logou como {ffffff}%s {ff6800}no servidor", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)));
					call::ADMIN->ToggleAdminInJob(playerid, true);

					new hash[6];

					new Rand = random(10000);
					new str[10];

					format(str, 10, "%d", Rand);

					SHA256_PassHash(str, "78sdjs86d2h", hash, sizeof(hash));

					SendClientMessage(playerid, COR_ERRO, "| PFC - ADMIN | Sua senha administrativa: ( %s ). Anote-a!", hash);

					format(query, sizeof(query), "UPDATE `usuarios` SET `senhaadmin`='%s' WHERE `id`='%d'", hash, call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
					mysql_query(getConexao(), query, false);

					SendLog(LOG_LOGINADMIN, "| PFC-Logs | O(A) %s %s entrou no modo administrativo.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), \
					GetUserName(playerid));

					return 1;
				}
			}

			new Str[100], String[500];
			format(Str, 100, "{ffffff}Nick: {1c88f0}%s\n", GetUserName(playerid));
			strcat(String, Str);

			format(Str, 100, "{ffffff}Cargo: %s\n", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid), true));
			strcat(String, Str);

			strcat(String, "{ffffff}Digite sua senha.");

			ShowPlayerDialog(playerid, DIALOG_LOGAR_ADM, DIALOG_STYLE_PASSWORD, "{ffffff}Logar Admin", String, "Logar", "Cancelar");

			cache_delete(result);
		}
	}
	return true;
}

flags:ircasa(ADMINISTRADOR);
CMD:ircasa(playerid, params[])
{
	if(isnull(params) || !IsNumeric(params))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/ircasa [casaid]");

	new casaid = strval(params);

	if ( !call::HOUSE->IsValidHouse(casaid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Está casa não existe.");
	
	Teleport(
		playerid,
		Casa[casaid][Entrada][X],
		Casa[casaid][Entrada][Y],
		Casa[casaid][Entrada][Z],
		Casa[casaid][Entrada][A],
		0,
		0,
		ENTROU_NONE
	);

	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | {"COR_BRANCO_INC"}Você foi até a casa id {"COR_AZUL_INC"}%d{"COR_BRANCO_INC"}.", casaid);
	return true;
}

flags:irgaragem(ADMINISTRADOR);
CMD:irgaragem(playerid, params[])
{
	if( isnull(params) || !IsNumeric(params) )
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/irgaragem [casaid]");

	new casaid = strval(params);

	if ( !call::HOUSE->IsValidHouse(casaid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Está casa não existe.");

	if ( !Casa[casaid][Garagem][Id] )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Essa casa não tem garagem");

	Teleport(
		playerid,
		Casa[casaid][Garagem][pEntrada][X],
		Casa[casaid][Garagem][pEntrada][Y],
		Casa[casaid][Garagem][pEntrada][Z],
		Casa[casaid][Garagem][pEntrada][A],
		0,
		0,
		ENTROU_NONE
	);
	SendClientMessage(playerid, COR_SISTEMA, "| PFC - ADMIN |{"COR_BRANCO_INC"}Você foi até a garagem da casa {"COR_AZUL_INC"}%d{"COR_BRANCO_INC"}.", casaid);
	return true;
}

flags:dargrana(ADMINISTRADOR); alias:dargrana("givemoney");
CMD:dargrana(playerid, params[])
{
	new id, valor;
	if(sscanf(params, "ud", id, valor))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/dargrana [playerid/username] [valor]");

	if (IsPlayerNPC(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em NPCs do servidor.");

	if(!call::PLAYER->IsPlayerLogged(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Jogador não está conectado.");

	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você deu R$%s de grana para o(a) jogador(a) %s[%d].", RealStr(valor), GetUserName(id), id);
	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s te deu R$%s de grana!", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), RealStr(valor));

	GivePlayerMoney(id, valor);

	new fileLog[128 + (MAX_PLAYER_NAME * 2)];
	format(fileLog, sizeof(fileLog), "[ MONEY ] O(A) %s %s deu R$%s de dinheiro para %s", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), RealStr(valor), GetUserName(id));
	WriteLog(FILE_GIVE, fileLog);
	return true;
}

flags:dararma(ADMINISTRADOR);
CMD:dararma(playerid, params[])
{
	new id, weaponid, ammo;
	if(sscanf(params, "udd", id, weaponid, ammo))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/dararma [playerid/username] [weaponid] [ammo]");

	if (IsPlayerNPC(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em NPCs do servidor.");

	if ( !call::PLAYER->IsPlayerLogged(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) Jogador(a) não está conectado(a).");
	
	if(weaponid == 38 || weaponid == 35)
	{
		if(call::ADMIN->GetPlayerAdminLevel(id) < ADMINISTRADOR)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode dar esta arma a este(a) jogador(a).");
	}

	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você deu a arma ID %d com %d de munições para o(a) jogador(a) %s[%d]!", weaponid, ammo, GetUserName(id), id);
	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s te deu a arma ID %d  com %d de munições!", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), weaponid, ammo);

	GivePlayerWeapon(id, weaponid, ammo);

	new fileLog[128 + (MAX_PLAYER_NAME * 2)];
	format(fileLog, sizeof(fileLog), "[ WEAPON ] O(A) %s %s deu a arma id %d com %d munições para %s", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), weaponid, ammo, GetUserName(id));
	WriteLog(FILE_GIVE, fileLog);
	return true;
}

flags:removergrana(ADMINISTRADOR); alias:removergrana("removemoney");
CMD:removergrana(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/dargrana [playerid]");

	if (IsPlayerNPC(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em NPCs do servidor.");

	if(!call::PLAYER->IsPlayerLogged(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Jogador não está conectado.");

	if(call::ADMIN->GetPlayerAdminLevel(id) >= call::ADMIN->GetPlayerAdminLevel(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar neste administrador.");
	
	GivePlayerMoney(id, -GetPlayerMoney(id));
	ResetPlayerMoney(id);

	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s resetou seu dinheiro em mãos.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você resetou o dinheiro em mãos de %s[%d]", GetUserName(id), id);

	new query[80];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `dinheiro`='0' WHERE `id`='%d' LIMIT 1;", call::PLAYER->GetPlayerVarInt(id, PlayerID));
	mysql_tquery(getConexao(), query);

	new fileLog[130];
	format(fileLog, sizeof(fileLog), "O %s %s resetou o dinheiro de %s", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
	WriteLog(FILE_REMOVE_MONEY, fileLog);
	return true;
}

flags:setarcombustivel(MODERADOR); alias:setarcombustivel("setcomb", "setfuel");
CMD:setarcombustivel(playerid, params[])
{
	new id, Float:fuel;
	if(sscanf(params, "uf", id, fuel))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/setarcombustivel [playerid/username] [quantidade]");

	if ( IsPlayerNPC(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em NPCs do servidor.");
 
	if ( !call::PLAYER->IsPlayerLogged(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) Jogador(a) não está conectado(a).");

	if( !IsPlayerInAnyVehicle(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Jogador não está no veiculo");

	if( fuel < 1 )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode setar uma valor menor que 1.");

	new Float:max_fuel = GetVehicleMaxFuel(GetVehicleModel(GetPlayerVehicleID(id)));
	
	fuel = ( fuel >  max_fuel ? max_fuel : fuel );
	call::VH->SetVehicleFuel(GetPlayerVehicleID(id), fuel);

	new str[128];
	format(str, sizeof(str), "[COMBUSTIVEL] O %s %s setou %f de combustivel para %s", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), fuel, GetUserName(id));
	WriteLog(FILE_ADMINS_SETS, str);

	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você setou %d de combustível para o(a) jogador(a) %d[%d]!", floatround(fuel), GetUserName(id), id);
	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s setou %d de combustível para você!", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), floatround(fuel));
	
	return true;
}

flags:desbugar(AJUDANTE);
CMD:desbugar(playerid, params[])
{
	static id;//, Float:x, Float:y, Float:z, int, world, entrada;

	if(sscanf(params, "u", id))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/desbugar [playerid/username]");
	
	if ( IsPlayerNPC(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em NPCs do servidor.");

	if ( !call::PLAYER->IsPlayerLogged(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) Jogador(a) não está conectado(a).");

	//GetPlayerPos(id, x,y,z);
	//int = GetPlayerInterior(id);
	//world = GetPlayerVirtualWorld(id);
	//entrada = Jogador[id][Entrou];<

	Teleport(id, 1684.6536,-2240.9868,13.5469, 0.0, 0, 0, ENTROU_NONE);
	
	TogglePlayerControllable(id, true);
	ClearAnimations(id);

	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s desbugou você!", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você desbugou o(a) jogador(a) %s[%d]!", GetUserName(id), id);
	return true;
}

flags:setarbeta(DIRECAO);
CMD:setarbeta(playerid, params[])
{
	new id, level, query[255], str[MAX_PLAYER_NAME * 2 + 128];

	if(sscanf(params, "ud", id, level))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/setarbeta (id / nome) (level 0-4) ");

	if ( level < 0 || level > 4)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você tem que digitar um valor entre 0 e 4");

	if ( !IsPlayerConnected(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a).");

	if ( IsPlayerNPC(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode promover um BOT.");

	if(!call::PLAYER->IsPlayerLogged(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a).");

	if(level == 0)
    {
        SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você tirou o(a) {ffffff}%s {"COR_AZUL_INC"}de Beta-Tester!", GetUserName(id));
        SendClientMessage(id, COR_ERRO, "O(A) {ffffff}%s %s {"COR_ERRO_INC"}tirou você de Beta-Tester!", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
		
        //call::ADMIN->SetPlayerAdminLevel(id, 0);
        //call::ADMIN->RemovePlayerAdmin(id);
        call::PLAYER->SetPlayerBetaLevel(id, 0);
        call::PLAYER->RemovePlayerBeta(id);

        mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `beta`='%d' WHERE `id`='%d' LIMIT 1;", level, call::PLAYER->GetPlayerVarInt(id, PlayerID));
		mysql_tquery(getConexao(), query);

		format(str, sizeof(str), "O %s %s retirou o jogador %s de beta-tester", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)),  GetUserName(playerid), GetUserName(id) );
		WriteLog(FILE_SET_ADMIN, str);
        return true;
    }

	if(level == 1)
	{
		call::PLAYER->SetPlayerBetaLevel(id, level);

		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `beta`='%d' WHERE `id`='%d' LIMIT 1;", level, call::PLAYER->GetPlayerVarInt(id, PlayerID));
		mysql_tquery(getConexao(), query);

		SendClientMessage(id, COR_AZUL, "| PFC - BETA | O(A) {ffffff}%s %s {"COR_AZUL_INC"}adicionou você de Beta-Tester.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
		SendClientMessage(id, COR_AZUL, "| PFC - BETA | Para ver os comandos de seu cargo use {ffffff}/Cargo");
		
		SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você setou o(a) jogador(a) {ffffff}%s(%d) {"COR_AZUL_INC"}de beta-tester {"COR_AZUL_INC"}no servidor.", GetUserName(id), id);

		format(str, sizeof(str), "O %s %s setou o jogador %s de beta-tester", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)),  GetUserName(playerid), GetUserName(id));
		WriteLog(FILE_SET_ADMIN, str);
	}
	else if(level == 2)
	{
		call::PLAYER->SetPlayerBetaLevel(id, level);

		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `beta`='%d' WHERE `id`='%d' LIMIT 1;", level, call::PLAYER->GetPlayerVarInt(id, PlayerID));
		mysql_tquery(getConexao(), query);

		SendClientMessage(id, COR_AZUL, "| PFC - MAPPER | O(A) {ffffff}%s %s {"COR_AZUL_INC"}adicionou você de Mapper.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
		SendClientMessage(id, COR_AZUL, "| PFC - BETA | Para ver os comandos de seu cargo use {ffffff}/Cargo");

		SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você setou o(a) jogador(a) {ffffff}%s[%d] {"COR_AZUL_INC"}de Mapper no servidor.", GetUserName(id), id);
		format(str, sizeof(str), "O %s %s setou o jogador %s de mapper", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)),  GetUserName(playerid), GetUserName(id));
		WriteLog(FILE_SET_ADMIN, str);
	}
	else if(level == 3)
	{
		call::PLAYER->SetPlayerBetaLevel(id, level);

		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `beta`='%d' WHERE `id`='%d' LIMIT 1;", level, call::PLAYER->GetPlayerVarInt(id, PlayerID));
		mysql_tquery(getConexao(), query);

		SendClientMessage(id, COR_AZUL, "| PFC - MAPPER | O(A) {ffffff}%s %s {"COR_AZUL_INC"}adicionou você de DJ.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
		SendClientMessage(id, COR_AZUL, "| PFC - BETA | Para ver os comandos de seu cargo use {ffffff}/Cargo");

		SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você setou o(a) jogador(a) {ffffff}%s[%d] {"COR_AZUL_INC"}de DJ no servidor.", GetUserName(id), id);
		format(str, sizeof(str), "O %s %s setou o jogador %s de DJ", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)),  GetUserName(playerid), GetUserName(id));
		WriteLog(FILE_SET_ADMIN, str);
	}
	else if(level == 4)
	{
		call::PLAYER->SetPlayerBetaLevel(id, level);

		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `beta`='%d' WHERE `id`='%d' LIMIT 1;", level, call::PLAYER->GetPlayerVarInt(id, PlayerID));
		mysql_tquery(getConexao(), query);

		SendClientMessage(id, COR_AZUL, "| PFC - MAPPER | O(A) {ffffff}%s %s {"COR_AZUL_INC"}adicionou você de YouTuber.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
		SendClientMessage(id, COR_AZUL, "| PFC - BETA | Para ver os comandos de seu cargo use {ffffff}/Cargo");

		SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você setou o(a) jogador(a) {ffffff}%s[%d] {"COR_AZUL_INC"}de YouTuber no servidor.", GetUserName(id), id);
		format(str, sizeof(str), "O %s %s setou o jogador %s de YouTuber", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)),  GetUserName(playerid), GetUserName(id));
		WriteLog(FILE_SET_ADMIN, str);
	}
	return true;
}

flags:darcargo(DIRECAO);
CMD:darcargo(playerid, params[])
{
	new id, level, query[255], str[MAX_PLAYER_NAME * 2 + 128], tmpcode[16], msg[600];

	randomstring(tmpcode, sizeof(tmpcode));
	if ( sscanf ( params, "ud", id, level) )
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/darcargo (id / nome) (level) ");

	if( level == DEV)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode se promover ao cargo mais alto do servidor.");

	if ( level < 0 || level > DIRECAO)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você tem que digitar um valor entre 0 e %d", DIRECAO);

	if ( !IsPlayerConnected(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a).");

	if ( IsPlayerNPC(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode promover um BOT.");

	if(!call::PLAYER->IsPlayerLogged(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) ainda não logado(a).");

	if(level == 0)
    {
        SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você tirou o(a) %s da administração!", GetUserName(id));
        SendClientMessage(id, COR_ERRO, "O(A) {ffffff}%s %s {"COR_ERRO_INC"}tirou você da administração!", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
		
        call::ADMIN->SetPlayerAdminLevel(id, 0);
        call::ADMIN->RemovePlayerAdmin(id);
		

        mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `admin`='%d' WHERE `id`='%d' LIMIT 1;", level, call::PLAYER->GetPlayerVarInt(id, PlayerID));
		mysql_tquery(getConexao(), query);

		format(str, sizeof(str), "O %s %s retirou o jogador %s da administração", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)),  GetUserName(playerid), GetUserName(id) );
		WriteLog(FILE_SET_ADMIN, str);
        return true;
    }

    call::ADMIN->SetPlayerAdminLevel(id, level);

    mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `admin`='%d' WHERE `id`='%d' LIMIT 1;", level, call::PLAYER->GetPlayerVarInt(id, PlayerID));
	mysql_tquery(getConexao(), query);

	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) {ffffff}%s %s {"COR_AZUL_INC"}adicionou você na administração do servidor.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | Agora você é um(a) {ffffff}%s", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(id)));
	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | Para ver os comandos administrativos use {ffffff}/Cargo");
	SendClientMessage(id, COR_LARANJA, "| PFC - INFO | Um e-mail foi enviado para a sua caixa de entrada com informações de seu admin. ( Sistema incompleto )");
	
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você setou o(a) jogador(a) {ffffff}%s(%d) {"COR_AZUL_INC"}de {ffffff}%s {"COR_AZUL_INC"}no servidor.", GetUserName(id), id, call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(id)));


	format(msg, sizeof(msg), 
		"PLAYERNAME:%s\
		#PLAYERNAME:%s\
		#PLAYERADMIN:%s\
		#ADMINCODE:%s", GetUserName(id), GetUserName(id), call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(id)), tmpcode);
	SendEmailAdmin("Código Administrativo", Jogador[id][Email], "Perfect City RPG - Admin", msg, true);

	format(str, sizeof(str), "O %s %s setou o jogador %s de %s", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)),  GetUserName(playerid), GetUserName(id), call::ADMIN->CargoAdmin(level) );
	WriteLog(FILE_SET_ADMIN, str);
	return true;
}

flags:espiar(AJUDANTE); 		alias:espiar("spectate");
CMD:espiar(playerid, params[])
{
	new id;
	if(sscanf(params, "u", id))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/espiar [username/playerid]");

	if(!call::PLAYER->IsPlayerLogged(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Jogador não está conectado.");

	if (IsPlayerNPC(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em NPCs do servidor.");

	if(call::ADMIN->GetPlayerAdminLevel(id) >= call::ADMIN->GetPlayerAdminLevel(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode espiar esse administrador.");

	if(playerid == id)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode espiar você mesmo.");

	if ( id == INVALID_PLAYER_ID )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | ID Inválido.");

	if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
	{
		static
			Float:x, Float:y, Float:z;
		
		/**
		 *
		 *	@Pegar posição atual do administrador.
		 *
		 */
		GetPlayerPos(playerid, x, y, z);
		SetPVarFloat(playerid, "spectating-x", x);
		SetPVarFloat(playerid, "spectating-y", y);
		SetPVarFloat(playerid, "spectating-z", z);
		SetPVarInt(playerid, "spectating-interior", GetPlayerInterior(playerid));
		SetPVarInt(playerid, "spectating-world", GetPlayerVirtualWorld(playerid));
		SetPVarInt(playerid, "spectating-skin", GetPlayerSkin(playerid));

		/**
		 *
		 *	@Setar o interior do jogador(a) a ser monitorado(a).
		 *
		 */

		TogglePlayerSpectating(playerid, true);
	}
	
	SetPlayerVirtualWorld(playerid, GetPlayerInterior(id));
	SetPlayerInterior(playerid, GetPlayerInterior(id));

	if( IsPlayerInAnyVehicle(id) )
		PlayerSpectateVehicle(playerid, GetPlayerVehicleID(id), SPECTATE_MODE_NORMAL);
	else
		PlayerSpectatePlayer(playerid, id, SPECTATE_MODE_NORMAL);
	
	call::TD->ShowPlayerMonitoramento(playerid, id);
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você está espiando o(a) jogador(a) %s[%d]!", GetUserName(id), id);
	return true;
}

flags:pararespiar(AJUDANTE); 		alias:espiaroff("pararespiar");
CMD:pararespiar(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está espiando ninguém.");
	
	TogglePlayerSpectating(playerid, false);

	SetPlayerSkin(playerid, GetPVarInt(playerid, "spectating-skin"));
	SetPlayerPos(playerid, GetPVarFloat(playerid, "spectating-x"), GetPVarFloat(playerid, "spectating-y"), GetPVarFloat(playerid, "spectating-z"));
	SetPlayerInterior(playerid, GetPVarInt(playerid, "spectating-interior"));
	SetPlayerVirtualWorld(playerid, GetPVarInt(playerid, "spectating-world"));
	
	DeletePVar(playerid, "spectating-x");
	DeletePVar(playerid, "spectating-y");
	DeletePVar(playerid, "spectating-z");
	DeletePVar(playerid, "spectating-interior");
	DeletePVar(playerid, "spectating-world");
	DeletePVar(playerid, "spectating-skin");

	call::TD->HidePlayerMonitoramento(playerid);
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você parou de espiar.");
	return true;
}

// mexendo dnv
// mexendo dnvv

flags:criarveiculo(AJUDANTE); 		alias:criarveiculo("cv", "createvehicle");
CMD:criarveiculo(playerid, params[])
{
	if ( isnull(params) || !IsNumeric(params) )
		ShowModelSelectionMenu(playerid, mS_CarAdmins, "Veiculos Admin", 150, 0xA4A4A4FF, 0x00FFCCAA);
	else
	{
		new modelid =  strval(params);
		if ( modelid < 400 || modelid > 611 )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você digitou um modelo inválido.");

		if(call::ADMIN->CreateVehicleToAdmin(playerid, modelid)){
				SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você criou um '{ffffff}%s{"COR_AZUL_INC"}' (%d).", GetVehicleModelName(modelid), modelid);
			}	
		}
	return true;
}


flags:skins(MODERADOR);
CMD:skins(playerid, params[])
{
	ShowModelSelectionMenu(playerid, mS_AllSkins, "Skins Admin", 150, 0xA4A4A4FF, 0x00FFCCAA);
	return true;
}


/*flags:armas(AJUDANTE);
CMD:armas(playerid, params[])
{

	ShowModelSelectionMenu(playerid, mS_AllWeapons, "Armas Admin", 150, 0xA4A4A4FF, 0x00FFCCAA);
	return true;
}*/

flags:destruirveiculos(AJUDANTE); alias:destruirveiculos("dvs", "destroyvehicles");
CMD:destruirveiculos(playerid)
{
	if(call::ADMIN->DestroyAllVehicleToAdmin(playerid)){
		SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você destruiu todos os seus veículos criados.");
	}
	return true;
}

flags:destruirveiculo(AJUDANTE); alias:destruirveiculo("dv", "destroyvehicle");
CMD:destruirveiculo(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você deve entrar no veiculo que criou para destrui-lo.");

	if(call::ADMIN->DestroyVehicleToAdmin(playerid, GetPlayerVehicleID(playerid))){
		SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Veículo destruído com sucesso.");
	}
	return true;
}

flags:tempban(MODERADOR);
CMD:tempban(playerid, params[])
{
	new id, reason[100], tempo, gip[16];
	if(sscanf(params, "us[100]d", id, reason, tempo))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/tempban [playerid / username] [rasão] [tempo]");

	if (!IsPlayerConnected(id) || IsPlayerNPC(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Jogador não está conectado! Você pode usar o /banip ou /banconta");

	if ( call::ADMIN->GetPlayerAdminLevel(playerid) < call::ADMIN->GetPlayerAdminLevel(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode banir um administrador.");

	GetPlayerIp(id, gip, sizeof(gip));

	CleanChat(id);

	new banLog[128 + (MAX_PLAYER_NAME * 2) + sizeof(reason)];
	format(banLog, sizeof(banLog), "%s baniu o jogador %s pelo motivo %s", GetUserName(playerid), GetUserName(id), reason);
	WriteLog(FILE_BAN, banLog);
		
	SendLog(LOG_BANIMENTOS, "| PFC-Logs | O(A) %s %s baniu o(a) jogador(a) %s por %d dias ( Motivo: %s )", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), \
	GetUserName(playerid), GetUserName(id), tempo, reason);

	SendClientMessageToAll(COR_VERMELHO, "| PFC - ADMIN | O(A) %s %s baniu o(a) jogador(a) %s por %d dias ( Motivo: %s )", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), GetUserName(id), tempo, reason);

	SendClientMessage(id, COR_VERMELHO, "| PFC - BAN | Você foi banido(a) do servidor por %d dia(s) ( Motivo: %s )", tempo, reason);
	SendClientMessage(id, COR_VERMELHO, "| PFC - BAN | Se você achar que o banimento foi injusto, faça uma revisão em nosso fórum!");
	SendClientMessage(id, COR_BRANCO, "| FÓRUM | www.perfectcityrpg.com.br/forum");

	AccountBanTemp(GetUserName(id), reason, GetUserName(playerid), gip, tempo);

	Kick(id);
	return true;
}

flags:ban(MODERADOR);
CMD:ban(playerid, params[])
{
	new id, reason[100];
	if(sscanf(params, "us[100]", id, reason))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/ban [playerid / username] [razão]");


	if (!IsPlayerConnected(id) || IsPlayerNPC(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a).");

	if ( call::ADMIN->GetPlayerAdminLevel(playerid) < call::ADMIN->GetPlayerAdminLevel(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode banir um administrador.");

	new gip[16];
	GetPlayerIp(id, gip, sizeof(gip));

	CleanChat(id);
	new banLog[128 + (MAX_PLAYER_NAME * 2) + sizeof(reason)];
	format(banLog, sizeof(banLog), "%s baniu o jogador %s pelo motivo %s", GetUserName(playerid), GetUserName(id), reason);
	WriteLog(FILE_BAN, banLog);

	SendLog(LOG_BANIMENTOS, "| PFC-Logs | O(A) %s %s baniu o(a) jogador(a) %s ( Motivo: %s )", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)),\
	GetUserName(playerid), GetUserName(id), reason);

	SendClientMessageToAll(COR_VERMELHO, "| PFC - ADMIN | O(A) %s %s baniu o(a) jogador(a) %s ( Motivo: %s )", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), GetUserName(id), reason);

	SendClientMessage(id, COR_VERMELHO, "| PFC - BAN | Você foi banido(a) do servidor ( Motivo: %s )", reason);
	SendClientMessage(id, COR_VERMELHO, "| PFC - BAN | Se você achar que o banimento foi injusto, faça uma revisão em nosso fórum!");
	SendClientMessage(id, COR_BRANCO, "| FÓRUM | www.perfectcityrpg.com.br/forum");
	
	AccountBanOff(GetUserName(id), reason, GetUserName(playerid), gip);
	Kick(id);
	return true;
}

flags:banip(ADMINISTRADOR);
CMD:banip(playerid, params[])
{
	new id, reason[100], ip[20];

	if ( sscanf ( params, "us[100]", id, reason ) )
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/banip [playerid / username] [razão]");

	if(!IsPlayerNPC(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a).");

	if ( IsPlayerConnected(id) )
		Kick(id);

	GetPlayerIp(id, ip, sizeof(ip));

	new banLog[128 + MAX_PLAYER_NAME + sizeof(reason)];
	format(banLog, sizeof(banLog), "%s baniu o ip do jogador(a) %s(%s) pelo motivo: %s", GetUserName(playerid), GetUserName(id), ip, reason);
	WriteLog(FILE_BAN, banLog);

	SendLog(LOG_BANIMENTOS, "| PFC-Logs | O(A) %s %s baniu o IP do(a) jogador(a) %s ( Motivo: %s ) ( IP: %s )", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), \
	GetUserName(playerid), GetUserName(id), ip);

	SendClientMessage(playerid, COR_VERMELHO, "| PFC - ADMIN | O(A) IP do(a) jogador(a) %s foi banido. ( Motivo: %s )", GetUserName(id), reason);

	new query[MAX_PLAYER_NAME + 255];
	mysql_format(getConexao(), query, sizeof(query), "INSERT INTO "TABLE_BANNEDS" (`admin`,`ip`,`data`,`motivo`, `temp-ban`)VALUES('%s','%s',NOW(),'%s', 0)", GetUserName(playerid), ip, reason);
	mysql_tquery(getConexao(), query);

	return true;
}

flags:banipoff(MODERADOR);
CMD:banipoff(playerid, params[])
{
	new ip[20], reason[100];
	if(sscanf(params, "s[20]s[100]", ip, reason))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/banip [ip] [motivo]");

	if( strcmp(ip, "127.0.0.1", true) == 0 && !isnull(ip))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode banir este IP.");

	new banLog[128 + MAX_PLAYER_NAME + sizeof(reason)];
	format(banLog, sizeof(banLog), "%s baniu o ip %s pelo motivo %s", GetUserName(playerid), ip, reason);
	WriteLog(FILE_BAN, banLog);

	SendLog(LOG_BANIMENTOS, "| PFC-Logs | O(A) %s %s baniu o IP %s ( Motivo: %s )", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), \
	GetUserName(playerid), ip, reason);

	SendClientMessage(playerid, COR_VERMELHO, "| PFC - ADMIN | IP %s banido com sucesso.", ip);

	new query[MAX_PLAYER_NAME + 255];
	mysql_format(getConexao(), query, sizeof(query), "INSERT INTO "TABLE_BANNEDS" (`admin`,`ip`,`data`,`motivo`, `temp-ban`)VALUES('%s','%s',NOW(),'%s', 0)", GetUserName(playerid), ip, reason);
	mysql_tquery(getConexao(), query);
	return true;
}

flags:banconta(MODERADOR);
CMD:banconta(playerid, params[])
{
	new username[MAX_PLAYER_NAME], reason[100];
	if(sscanf(params, "s[25]s[100]" , username, reason))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/banconta [nick] [motivo]");

	if ( !call::PLAYER->IsNickRegistered(username) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não encontramos a conta {"COR_BRANCO_INC"}%s{"COR_ERRO_INC"} no banco de dados.", username);

	new banLog[255], id = GetPlayerIDByName(username);

	if ( IsPlayerConnected(id) )
		Kick(id);

	SendLog(LOG_BANIMENTOS, "| PFC-Logs | O(A) %s %s baniu a conta %s ( Motivo: %s )", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), \
	GetUserName(playerid), username, reason);
			
	format(banLog, sizeof(banLog), "%s baniu o jogador %s pelo motivo %s", GetUserName(playerid), username, reason);
	WriteLog(FILE_BAN, banLog);

	SendClientMessage(playerid, COR_VERMELHO, "| PFC - ADMIN | Você baniu o(a) jogador(a) %s ( Motivo: %s )", username, reason);
	AccountBanOff(username, reason, GetUserName(playerid), "");
	return true;
}

flags:desban(MODERADOR); alias:desban("desbanir", "unban");
CMD:desban(playerid, params[])
{

	new playername[MAX_PLAYER_NAME];
	if(sscanf(params, "s[25]", playername))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /desban [nick]");
	new query[144];
	mysql_format(getConexao(), query, sizeof(query), "SELECT `username` FROM "TABLE_BANNEDS" WHERE `username`='%s' LIMIT 1;", playername);
	new Cache:__cache = mysql_query(getConexao(), query, true);
	if(cache_num_rows())
	{
		mysql_format(getConexao(), query, sizeof(query), "DELETE FROM "TABLE_BANNEDS" WHERE `username`='%s'", playername);
		mysql_tquery(getConexao(), query);
		SendClientMessage(playerid, COR_LARANJA, "| PFC - ADMIN | Você desbaniu o(a) jogador(a) %s", playername);

		SendLog(LOG_BANIMENTOS, "| PFC-Logs | O(A) %s %s desbaniu o(a) jogador(a) %s.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), \
		GetUserName(playerid), playername);

		//SendClientMessageToAll(COR_VERMELHO, "| PFC - UNBAN | O(A) {ffffff}%s %s {"COR_VERMELHO_INC"}desbaniu o(a) jogador(a) {ffffff}%s", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), playername);
		return cache_delete(__cache);
	}
	new banLog[14 + MAX_PLAYER_NAME];
	SendClientMessage(playerid, 0xFF0000FF, "| ERRO | Não foi encontrado nenhum jogador com o nick {ffffff}%s{ff0000} banido.", playername);
	format(banLog, sizeof(banLog), "O(A) %s %s desbaniu %s", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), playername);
    WriteLog(FILE_BAN, banLog);
	return cache_delete(__cache);
}

flags:desbanip(MODERADOR); alias:desbanip("desbanirip", "unbanip");
CMD:desbanip(playerid, params[])
{
	new ip[64];
	if(sscanf(params, "s", ip))
	    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Uso Correto: /desbanirip (ip)");

	new query[144];
	mysql_format(getConexao(), query, sizeof(query), "SELECT `ip` FROM "TABLE_BANNEDS" WHERE `ip`='%s' LIMIT 1;", ip);
	new Cache:__cache = mysql_query(getConexao(), query, true);
	if(cache_num_rows())
	{
	    mysql_format(getConexao(), query, sizeof(query), "DELETE FROM "TABLE_BANNEDS" WHERE `ip`='%s'", ip);
	    mysql_tquery(getConexao(), query);
	    SendClientMessage(playerid, COR_LARANJA, "| PFC - ADMIN | Você desbaniu o IP %s com sucesso.", ip);

		SendLog(LOG_BANIMENTOS, "| PFC-Logs | O(A) %s %s desbaniu o IP %s.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), \
		GetUserName(playerid), ip);

		foreach(new i: Player)
		{
		    if(call::ADMIN->GetPlayerAdminLevel(i))
		    	SendClientMessage(i, COR_VERMELHO, "| PFC - ADMIN | O(A) %s %s desbaniu o IP {ffffff}%s", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), ip);
		}
		return cache_delete(__cache);
	}
	SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foi encontrado nenhum banimento com esse ip ( {ffffff}%s {"COR_ERRO_INC"}).", ip);
	return cache_delete(__cache);
}

flags:kick(AJUDANTE); alias:kick("kickar", "kickplayer");
CMD:kick(playerid, params[])
{
	new pid, motivo[64];
	if(sscanf(params, "ds[64]", pid, motivo))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/kick [playerid] [motivo]");

	if (IsPlayerNPC(pid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em NPCs do servidor.");

	if(!call::PLAYER->IsPlayerLogged(pid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a).");

	SendClientMessageToAll(COR_VERMELHO, "| PFC - ADMIN | O(A) %s %s kickou o(a) jogador(a) %s ( Motivo: %s )", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), GetUserName(pid), motivo);

	Kick(pid);


	new str[128];
	format(str, sizeof(str), "O(A) %s %s kickou o(a) jogador(a) %s pelo motivo %s", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), GetUserName(pid), motivo);
	WriteLog(FILE_KICK, str, sizeof(str));
	return true;
}

flags:limparchat(AJUDANTE); alias:limparchat("lc", "cleanchat");
CMD:limparchat(playerid, params[])
{
	if ( IsUsedCommandTime() )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Aguarde o comando ser executado no tempo.");

	if ( isnull(params) ){
		CleanChat();
		//SendClientMessageToAll(COR_AMARELO, " O(A) {"COR_BRANCO_INC"}%s %s{"COR_AMARELO_INC"} Limpou o chat log..", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
		/*foreach(new i: Player)
		{
			if(call::ADMIN->GetPlayerAdminLevel(i) >= AJUDANTE)
			{
				SendClientMessage(i, COR_AMARELO, "| PFC - ADMIN | O(A) %s %s excluiu o chat do servidor.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
			}
		}*/
	}
	else
	{
		if ( !IsNumeric(params) )
			return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/limparchat [segundos]");

		if ( strval(params) > 60 )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não pode usar mais que 1 minuto.");

		ExecuteToTime(playerid, CMD_TYPE_LIMPARCHAT, strval(params));
	}
	return true;
}

flags:ir(AJUDANTE);
CMD:ir(playerid, params[])
{
	
	if(isnull(params))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/ir [playerid/username]");

	new id;
	if(!IsNumeric(params))
		id = GetPlayerIDByName(params);
	else 
		id = strval(params);

	if ( IsPlayerNPC(id) && call::ADMIN->GetPlayerAdminLevel(playerid) < DIRECAO)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em NPCs do servidor.");

	if(!call::PLAYER->IsPlayerLogged(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a).");

	if(id == playerid)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode ir até você mesmo!");


	if ( GetPlayerState(id) == PLAYER_STATE_SPECTATING )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) está em modo espectador e você não poderá ir até ele.");

	static Float:x, Float:y, Float:z;

	GetPlayerPos(id, x, y, z);

	if(IsPlayerInAnyVehicle(playerid)){
		SetVehiclePos(GetPlayerVehicleID(playerid),x, y, z);
		LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(id)), SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), GetPlayerInterior(id));
		Jogador[playerid][Entrou] = Jogador[id][Entrou];
	}else{
		SetPlayerPos(playerid, x, y, z);
		SetPlayerInterior(playerid, GetPlayerInterior(id)), SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
		Jogador[playerid][Entrou] = Jogador[id][Entrou];
	}
	//Teleport(playerid, x, y, z, 0.0, GetPlayerInterior(id), GetPlayerVirtualWorld(id), Jogador[id][Entrou]);



	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s foi até você!", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você foi até o(a) jogador(a) %s[%d]!", GetUserName(id), id);
	return true;
}

flags:trazertodos(MODERADOR);
CMD:trazertodos(playerid, params[])
{
	static Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	foreach(new i: Player)
	{
		if ( IsPlayerNPC(i) )
			return false;

		if(!call::PLAYER->IsPlayerLogged(i))
			return false;

		if(Jogador[i][Perseguido] == true)
			return false;

		if ( GetPlayerState(i) == PLAYER_STATE_SPECTATING )
			return false;

		SetPlayerPos(i, x, y, z);
		SetPlayerInterior(i, GetPlayerInterior(playerid));
		SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
		Jogador[i][Entrou] = Jogador[playerid][Entrou];
	}
	SendClientMessageToAll(COR_AZUL, "| PFC - ADMIN | O(A) %s %s trouxe todos até a sua posição.",  call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você trouxe todos os jogadores até a sua posição.");
	return true;
}

flags:trazer(AJUDANTE);
CMD:trazer(playerid, params[])
{
	if(isnull(params))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/trazer [playerid/username]");

	new id;
	if(!IsNumeric(params))
		id = GetPlayerIDByName(params);
	else 
		id = strval(params);

	if ( IsPlayerNPC(id) && call::ADMIN->GetPlayerAdminLevel(playerid) < DIRECAO )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em NPCs do servidor.");

	if(!call::PLAYER->IsPlayerLogged(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a).");

	if(id == playerid)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode trazer você mesmo!");

	if ( GetPlayerState(id) == PLAYER_STATE_SPECTATING )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) está em modo espectador e você não poderá trazer ele.");

	static Float:x, Float:y, Float:z;

	GetPlayerPos(playerid, x, y, z);
	//Teleport(id, x, y, z, 0.0, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid), Jogador[playerid][Entrou]);

	//if(IsPlayerInAnyVehicle(id)){
	//	SetVehiclePos(GetPlayerVehicleID(id), x, y, z);
	//	LinkVehicleToInterior(GetPlayerVehicleID(id), GetPlayerInterior(playerid)), SetVehicleVirtualWorld(GetPlayerVehicleID(id), GetPlayerInterior(playerid));
	//	Jogador[id][Entrou] = Jogador[playerid][Entrou];
	//}else{
	SetPlayerPos(id, x, y, z);
	SetPlayerInterior(id, GetPlayerInterior(playerid)), SetPlayerVirtualWorld(id, GetPlayerVirtualWorld(playerid));
	Jogador[id][Entrou] = Jogador[playerid][Entrou];
	//}

	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você trouxe o(a) jogador(a) %s[%d] até a sua posição.", GetUserName(id), id);
	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s trouxe você até a sua posição.",  call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));

	return true;
}

flags:agendarcadeia(AJUDANTE);
CMD:agendarcadeia(playerid, params[])
{
	new nick[MAX_PLAYER_NAME], tempo, motivo[64];

	if(sscanf(params, "s[70]is[50]", nick, tempo, motivo))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/agendarcadeia [username] [tempo] [motivo]");

	new id = GetPlayerIDByName(nick);

	if ( IsPlayerConnected(id) )
		Kick(id);

	if ( tempo <= 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você tem que digitar um valor maior que 0.");

	if ( !call::PLAYER->IsNickRegistered(nick) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não encontramos a conta {"COR_BRANCO_INC"}%s{"COR_ERRO_INC"} no banco de dados.", nick);

	SendLog(LOG_PRISOES, "| PFC-Logs | O(A) %s %s agendou a prisão do(a) jogador(a) %s por %02d minutos ( Motivo: %s )", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), \
	GetUserName(playerid), nick, tempo, motivo);

	SendClientMessageToAll(COR_AMARELO, "| PFC - ADMIN | O(A) %s %s agendou a prisão do(a) jogador(a) %s por %d minutos ( Motivo: %s ).", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), nick, tempo, motivo);

	tempo = ( tempo * 60);

	new query[255];
    mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `tempo_preso`='%d', `preso`='%d' WHERE `username`='%s'", tempo, PRESO_ADM, nick);
	mysql_tquery(getConexao(), query);
	return true;
}

flags:cadeia(AJUDANTE);
CMD:cadeia(playerid, params[])
{
	new pid, tempo, motivo[50];

	if(sscanf(params, "uis[50]", pid, tempo, motivo))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/cadeia [playerid / username] [tempo] [motivo]");

	if ( tempo <= 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você tem que digitar um valor maior que 0.");

	if ( IsPlayerNPC(pid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em NPCs do servidor.");

	if ( !call::PLAYER->IsPlayerLogged(pid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) Jogador(a) não está conectado.");

	/*if(call::ADMIN->GetPlayerAdminLevel(pid) >= call::ADMIN->GetPlayerAdminLevel(playerid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode prender esse administrador.");*/

	SendLog(LOG_PRISOES, "| PFC-Logs | O(A) %s %s prendeu o(a) jogador(a) %s por %02d minutos ( Motivo: %s )", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), \
	GetUserName(playerid), GetUserName(pid), tempo, motivo);

	SendClientMessageToAll(COR_VERMELHO, "| PFC - ADMIN | O(A) %s %s prendeu o(a) jogador(a) %s por %02d minutos ( Motivo: %s )", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), GetUserName(pid), tempo, motivo);
	
	EnviarCela(pid);
	ResetPlayerWeapons(pid);
	call::PM->ShowPlayerTextDrawPrisonTime(pid);

	new str[128];
	format(str, sizeof(str), "O %s %s prendeu o(a) %s por %d minutos pelo motivo %s", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), GetUserName(pid), tempo, motivo);
	WriteLog(FILE_APRENDER_PRISAO, str, sizeof(str));

	tempo = ( tempo * 60);
	Jogador[pid][Preso] = PRESO_ADM;
	Jogador[pid][TempoPreso] = tempo;

	new query[128];
    mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `tempo_preso`='%d', `preso`='%d' WHERE `id`=%d", tempo, PRESO_ADM, call::PLAYER->GetPlayerVarInt(pid, PlayerID));
	mysql_tquery(getConexao(), query);
	return true;
}

flags:hotel(DEV);
CMD:hotel(playerid, params[])
{
	SetPlayerPos(playerid, 1321.52, -1048.75, 3359.71);
	SetPlayerInterior(playerid, 3);
}

flags:liberar(AJUDANTE);
CMD:liberar(playerid, params[])
{
	new pid;
	if(sscanf(params, "ds[50]", pid))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/liberar [playerid]");

	if ( IsPlayerNPC(pid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em NPCs do servidor.");

	if(!call::PLAYER->IsPlayerLogged(pid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) não está conectado.");

	if(Jogador[pid][TempoPreso] < 1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) não está preso.");

	call::PM->SoltarPrisioneiro(pid);

	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você soltou o(a) jogador(a) %s[%d] da cadeia!", GetUserName(pid), pid);
	SendClientMessage(pid, COR_AZUL, "| PFC - ADMIN | O(A) %s %s soltou você da cadeia!", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));

	new str[128];
	format(str, sizeof(str), "O(A) %s %s soltou o(a) prisioneiro(a) %s", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), GetUserName(pid));
	WriteLog(FILE_SOLTAR_PRISAO, str, sizeof(str));
	return true;
}

flags:tapa(AJUDANTE);
CMD:tapa(playerid, params[])
{
	new pid, Float:x, Float:y, Float:z;
	
	if(sscanf(params, "u", pid))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/tapa [playerid / username]");
	
	if ( IsPlayerNPC(pid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em NPCs do servidor.");

	if( !call::PLAYER->IsPlayerLogged(pid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) Jogador(a) não está conectado.");

	//if(call::ADMIN->GetPlayerAdminLevel(pid) >= call::ADMIN->GetPlayerAdminLevel(playerid))
	//	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode tapear esse administrador.");

	GetPlayerPos(pid, x, y, z);
	SetPlayerPos(pid, x, y, z + 100);
	
	SendClientMessage(pid, COR_AZUL, "| PFC - ADMIN | O(A) %s %s te deu um tapa!", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você deu um tapa no(a) jogador(a) %s[%d]!", GetUserName(pid), pid);

	return 1;
}

flags:aviso(AJUDANTE);
CMD:aviso(playerid, params[])
{
	new pid, motivo[50];

	if ( sscanf(params, "us[50]", pid, motivo) )
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/aviso [playerid / username] [motivo]");

	if ( IsPlayerNPC(pid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em NPCs do servidor.");

	if ( !call::PLAYER->IsPlayerLogged(pid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) não está conectado.");

	if ( call::ADMIN->GetPlayerAdminLevel(playerid) < call::ADMIN->GetPlayerAdminLevel(pid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode avisar esse jogador.");

	call::PLAYER->SetPlayerVarInt(pid, Avisos, call::PLAYER->GetPlayerVarInt(pid, Avisos) + 1);

	SendLog(LOG_AVISOS, "| PFC-Logs | O(A) %s %s avisou o(a) jogador(a) %s ( Motivo: %s ) ( %d/3 )", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), \
	GetUserName(playerid), GetUserName(pid), motivo, call::PLAYER->GetPlayerVarInt(pid, Avisos));

	SendClientMessageToAll(COR_VERMELHO, "| PFC - ADMIN | O(A) %s %s avisou o(a) jogador(a) %s ( Motivo: %s ) ( %d / 3 )", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), GetUserName(pid), motivo, call::PLAYER->GetPlayerVarInt(pid, Avisos));
	
	if ( call::PLAYER->GetPlayerVarInt(pid, Avisos) >= 3 )
	{
		new tempo;

		SendClientMessageToAll(COR_VERMELHO, "| PFC - ADMIN | Por receber 3 avisos, o(a) jogador(a) %s foi preso por 40 minutos.", GetUserName(pid));

		EnviarCela(pid);
		ResetPlayerWeapons(pid);
		call::PM->ShowPlayerTextDrawPrisonTime(pid);

		tempo = ( 40 * 60);
		Jogador[pid][Preso] = PRESO_ADM;
		Jogador[pid][TempoPreso] = tempo;

		new query[128];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `tempo_preso`='%d', `preso`='%d' WHERE `id`=%d", tempo, PRESO_ADM, call::PLAYER->GetPlayerVarInt(pid, PlayerID));
		mysql_tquery(getConexao(), query);

		call::PLAYER->SetPlayerVarInt(pid, Avisos, 0);


	}

	new str[128];
	format(str, sizeof(str), "O(A) %s %s avisou o(a) jogador(a) %s pelo motivo %s", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), GetUserName(pid), motivo);
	WriteLog(FILE_AVISO, str, sizeof(str));

	new query[128];
    mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `avisos`='%d' WHERE `id`=%d", call::PLAYER->GetPlayerVarInt(pid, Avisos), call::PLAYER->GetPlayerVarInt(pid, PlayerID));
	mysql_tquery(getConexao(), query);
	return true;
}

flags:retiraraviso(AJUDANTE);
CMD:retiraraviso(playerid, params[])
{
	new pid, quantia;

	if ( sscanf(params, "ud", pid, quantia) )
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/retiraraviso [playerid / username] [quantia|1|2|3]");

	if ( IsPlayerNPC(pid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando em NPCs do servidor.");

	if ( !call::PLAYER->IsPlayerLogged(pid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) não está conectado.");

	if(quantia > 3)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode remover mais de 3 avisos.");

	if(call::PLAYER->GetPlayerVarInt(pid, Avisos) == 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse(a) jogador(a) não contém avisos.");

	if(call::PLAYER->GetPlayerVarInt(pid, Avisos) == 2)
	{
		if(quantia == 3)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) contém apenas 2 avisos.");
	} 
	else if(call::PLAYER->GetPlayerVarInt(pid, Avisos) == 1)
	{
		if(quantia >= 2)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) contém apenas 1 aviso.");
	}

	call::PLAYER->SetPlayerVarInt(pid, Avisos, call::PLAYER->GetPlayerVarInt(pid, Avisos) - quantia);

	SendClientMessage(playerid, COR_LARANJA, "| PFC - ADMIN | Você retirou %d aviso(s) do(a) jogador(a) %s[%d].", quantia, GetUserName(pid), pid);
	SendClientMessage(pid, COR_VERMELHO, "| PFC - ADMIN | O(A) %s %s retirou %d aviso(s) de você.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), quantia);

	new str[128];
	format(str, sizeof(str), "O(A) %s %s retirou %d aviso(s) do(a) jogador(a) %s", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), quantia, GetUserName(pid));
	WriteLog(FILE_AVISO, str, sizeof(str));


	new query[128];
    mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `avisos`='%d' WHERE `id`=%d", call::PLAYER->GetPlayerVarInt(pid, Avisos), call::PLAYER->GetPlayerVarInt(pid, PlayerID));
	mysql_tquery(getConexao(), query);
	return true;
}

flags:rv(AJUDANTE);
CMD:rv(playerid, params[])
{

	if(IsPlayerInAnyVehicle(playerid))
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if ( !IsValidVehicle(vehicleid) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo.");
	
		new trailer = GetVehicleTrailer(vehicleid);
		if ( IsValidVehicle(trailer) )
			SetVehicleToRespawn(trailer);
	
		SetVehicleToRespawn(vehicleid);
    	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Veículo respawnado com sucesso!");
    } else {
    	new Car;

		if(sscanf(params, "d", Car))
			return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/Rv (id-carro)");
	
		SetVehicleToRespawn(Car);
    	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você respawnou o veículo {ffffff}%d", Car);
    }
    return true;
}

/*flags:rvs(AJUDANTE); alias:rvs("respawnveiculos");
CMD:rvs(playerid, params[])
{
	if ( IsUsedCommandTime() )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Aguarde o comando ser executado no tempo.");

	if ( isnull(params) )
	{
		new bool:IsTrailerAttached[MAX_VEHICLES];

		// verificar trailer attachado 
		foreach(new i: Vehicles)
		{
			if ( IsTrailerAttachedToVehicle(i) ){
				new trailer = GetVehicleTrailer(i);
				IsTrailerAttached[trailer] = true;
			}
		}
		//		 verificar veiculos desocupados 
	    //foreach(new vehicleid: Vehicles)
	    //{
	    //    if ( !IsVehicleOccupied(vehicleid) && !IsTrailerAttached[vehicleid] )
		//		SetVehicleToRespawn(vehicleid);
	    //}
	    //SendClientMessageToAll(COR_AMARELO, "| PFC - ADMIN | O(A) {"COR_BRANCO_INC"}%s %s{"COR_AMARELO_INC"} deu respawn em todos os veiculos desocupados.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
	    foreach(new i: Player)
	    {
	    	call::TD->ShowCnnMessage(i, "~G~Respawn de Veículos~n~~w~~r~>>~w~Veículos não utilizados serão respawnados em ~r~30~w~ segundos! ~r~<<");
	    	return 1;
	    }
		SetTimer("Respawn10", 20000, false);
	    return true;
	}
	else
	{
		if ( !IsNumeric(params))
			return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/rvs [segundos]");

		if ( strval(params) > 60 )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não pode usar mais que 1 minuto.");
			
		ExecuteToTime(playerid, CMD_TYPE_RVS, strval(params));

	}
    return true;
}*/

flags:cnn(AJUDANTE);
CMD:cnn(playerid, params[])
{
	if ( isnull(params) )
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/cnn [mensagem]");

	call::TD->ShowCnnMessage(playerid, params);
	return true;
}

flags:ann(AJUDANTE);
CMD:ann(playerid, params[])
{
	new string[128];

	if ( isnull(params) )
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/cnn [mensagem]");

	format(string, sizeof(string), "~w~%s", params);
    GameTextForAll(string, 2000, 3);
	return true;
}

/*
CMD:cornick(playerid, params[])
{
	if(Jogador[playerid][Admin] < 2)
		return false;
	
	if(!Jogador[playerid][LogadoAdm])
		return MsgLogarAdm(playerid);
	
	new cor[30];
	if(sscanf(params, "s[30]", cor))
		return SCM(playerid, COR_ERRO, "| ERRO | Use: /CorNick [cor].");
	
	if(strlen(cor) > 6 || strlen(cor) < 6)
		return SCM(playerid, COR_ERRO, "| ERRO | Cor inválida.");
	
	SCM(playerid, COR_VERDE, "| INFO | Cor alterada com sucesso.");

	new color[30];
	format(color, sizeof(color), "0x%sAA", ConvertUppercase(cor));
	SetPlayerColor(playerid, HexToInt(color));

	FormatLog("ComandosAdmin", "[Comando] O(A) %s %s[%d] trocou a cor de seu nick.", Cargo(playerid), Jogador[playerid][Nome], playerid);
	return 1;
}
*/


stock ConvertUppercase(string[])
{
    new dest[128];

    strcat(dest, string);

    for (new i = strlen(dest) - 1; i >= 0; i--) {

        dest[i] = toupper(dest[i]);
    }
    return dest;
}

CMD:setnick(playerid, params[])
{
	new id, nick[MAX_PLAYER_NAME];
	if(sscanf(params, "us[25]", id, nick))
		return false;
	
	SetPlayerName(id, nick);
	
	return 1;
}


flags:cornick(AJUDANTE);
CMD:cornick(playerid, params[])
{
 	new cor[10];
	if(sscanf(params, "s[10]", cor))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /CorNick [código-html]");
		
	/*if ( !IsValidHex(params, VERIFY_HEX_8) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não digitou um código HTML válido, use o tipo RRGGBBAA.");*/

	if(strlen(cor) > 6 || strlen(cor) < 6)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Cor inválida.");

	new color[30];

	format(color, sizeof(color), "0x%sAA", ConvertUppercase(cor));
	SetPlayerColor(playerid, HexToInt(color));

	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você alterou a cor do seu nick com sucesso!");

	SetPVarInt(playerid, "ColorChanged", 1);
	return 1;
}

flags:setarvip(DIRECAO);
CMD:setarvip(playerid, params[])
{
	new id, dias, query[255];

	if(sscanf(params, "dd", id, dias))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /SetarVip (id) (dias)");

	if( dias < 1 )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode setar vip com menos de 1 dia.");

	if ( dias > 365)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não é possivel setar vip com mais de um ano de duração.");

	Jogador[id][Vip] = true;
	Jogador[id][TempoVip] += (Jogador[id][TempoVip] > 0 ? (dias * 86400) : (gettime() + (dias * 86400)));

	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `vip`='1',`vencimento_vip`='%d' WHERE `id`='%d';", Jogador[id][TempoVip], Jogador[id][PlayerID]);
	mysql_tquery(getConexao(), query);

	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s setou %d dias de VIP para você!", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), dias);
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você setou %d dias de VIP para o(a) jogador(a) %s[%d]!", dias, GetUserName(id), id );

	new str[128];
	format(str, sizeof(str), "O %s %s setou vip para o jogador %s de %d dias.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), GetUserName(id), dias);
	WriteLog(FILE_SET_VIP, str);
	return true;
}

flags:retirarvip(DIRECAO);
CMD:retirarvip(playerid, params[])
{
	new id = strval(params);
	new query[255];

	if(sscanf(params, "d", id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /RetirarVip (id)");

	if ( !call::PLAYER->IsPlayerLogged(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) Jogador(a) não está logado(a).");

	Jogador[id][Vip] = false, Jogador[id][TempoVip] = 0;
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `vencimento_vip`='0',`vip`='0' WHERE `id`='%d'", Jogador[id][PlayerID]);
	mysql_tquery(getConexao(), query);

	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você retirou o vip do(a) jogador(a) %s(%d)", GetUserName(id), id);
	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s retirou seu VIP.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
	
	new str[128];
	format(str, sizeof(str), "O %s %s retirou o vip de %s", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), GetUserName(id));
	WriteLog(FILE_SET_VIP, str);
	return true;
}

flags:setarnivel(DIRECAO); alias:setarnivel("setscore");
CMD:setarnivel(playerid, params[])
{
	new id, score;
	if (sscanf(params, "dd", id, score))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/setarnivel [playerid] [score]");

	if ( !call::PLAYER->IsPlayerLogged(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) Jogador(a) não está logado(a).");

	SetPlayerScore(id, score);
	
	new query[128];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `level`='%d' WHERE `id`='%d' LIMIT 1;", GetPlayerScore(id), call::PLAYER->GetPlayerVarInt(id, PlayerID));
	mysql_tquery(getConexao(), query);
	//call::TD->UpdateTextDrawHudLevel(playerid);
	//call::TD->UpdateTextDrawHudExp(playerid);
	
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você setou o nível do(a) jogador(a) %s[%d] para %d!", GetUserName(id), id, score);
	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s setou seu nível para %d!", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), score);
	

	new teste_msg[256];
	format(teste_msg, sizeof(teste_msg), "%s setou o nivel de %s para %d", GetUserName(playerid), GetUserName(id), score);
	RegistrarAtividade_Admin(Jogador[playerid][PlayerID], "Nivel", teste_msg);
	return true;
}

flags:descalar(AJUDANTE); alias:desmutar("desmutar");
CMD:descalar(playerid, params[])
{
	new id, str[128];
	if (sscanf(params, "d", id))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/descalar [playerid]");

	if ( !call::PLAYER->IsPlayerLogged(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) Jogador(a) não está logado(a).");

	if ( call::ADMIN->GetPlayerAdminLevel(playerid) < call::ADMIN->GetPlayerAdminLevel(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode descalar esse administrador.");

	if(Jogador[id][Calado] != true)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) não está calado(a).");

	Jogador[id][TempoCalado] = 0, Jogador[id][Calado] = false;

	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s descalou você!", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));

	format(str, sizeof(str), "O(A) %s desmutou o jogador %s ", GetUserName(playerid), GetUserName(id));
	WriteLog("admins/calar.txt", str);
	return true;
}

flags:calar(AJUDANTE); alias:mutar("mutar");
CMD:calar(playerid, params[])
{
	new id, motivo[64], tempo;
	if (sscanf(params, "dds[64]", id, tempo, motivo))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/calar [playerid] [tempo] [motivo]");

	if ( tempo <= 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você tem que digitar um valor maior que 0.");

	if ( !call::PLAYER->IsPlayerLogged(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) não está logado(a).");

	if ( call::ADMIN->GetPlayerAdminLevel(playerid) < call::ADMIN->GetPlayerAdminLevel(id) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode calar esse administrador.");

	if(Jogador[id][Calado] != false)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) já está calado(a).");

	SendClientMessageToAll(COR_VERMELHO, "| PFC - ADMIN | O(A) %s %s calou o(a) jogador(a) %s por %d minutos ( Motivo: %s )", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), GetUserName(id), tempo, motivo);
	
	new str[128];
	format(str, sizeof(str), "O(A) %s mutou o jogador %s pelo motivo (( %s )) tempo (( %d ))", GetUserName(playerid), GetUserName(id), motivo, tempo);
	WriteLog("admins/calar.txt", str);

	SetTimerEx("TimerMute", 1000, false, "i", id);

	tempo = ( tempo * 60);
	Jogador[id][TempoCalado] = tempo, Jogador[id][Calado] = true;
	return true;
}

flags:tempo(MODERADOR);
CMD:tempo(playerid, params[])
{
	new climaid;

	if (sscanf(params, "d", climaid))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/tempo [tempoid]");

	if(climaid < 0 || climaid > 23)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Tempo inexistente.");

	foreach(new i: Player)
	{
		SetPlayerWeather(i, climaid);
	}

	SendClientMessageToAll(COR_AZUL, "| PFC - ADMIN | O(A) %s %s mudou o clima do servidor.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
	return true;
}

flags:desguinchar(AJUDANTE);
CMD:desguinchar(playerid, parmas[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if ( GetVehicleModel(vehicleid) != 525 )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um caminhão guincho");

	if ( !IsTrailerAttachedToVehicle(vehicleid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O veiculo não está em um guincho.");

	if((IsPlayerInAnyVehicle(playerid)) && (GetPlayerState(playerid) == PLAYER_STATE_DRIVER))
	{
		new vehid = GetVehicleIdToRadiu(vehicleid, 15.0);
		if ( vehid != INVALID_VEHICLE_ID )
		{
			DetachTrailerFromVehicle(vehicleid);
			SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Veiculo retirado do guincho.");
		}
		return true;
	}

	return true;
}

flags:guinchar(AJUDANTE);
CMD:guinchar(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if ( GetVehicleModel(vehicleid) != 525 )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um caminhão guincho");

	if ( IsTrailerAttachedToVehicle(vehicleid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O veiculo já está com um veiculo no guincho.");

	if((IsPlayerInAnyVehicle(playerid)) && (GetPlayerState(playerid) == PLAYER_STATE_DRIVER))
	{
		new vehid = GetVehicleIdToRadiu(vehicleid, 15.0);
		if ( vehid != INVALID_VEHICLE_ID )
		{
			AttachTrailerToVehicle(vehid, vehicleid);
			SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Veiculo colocado no guincho.");
		}
		return true;
	}
	return true;
}

//flags:verip(MODERADOR);
//CMD:verip(playerid, params[])
//{
//	new pid, gip[16];
//
//	if (sscanf(params, "d", pid))
//		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/verip [playerid]");
//
//	if ( call::ADMIN->GetPlayerAdminLevel(playerid) < call::ADMIN->GetPlayerAdminLevel(pid) )
//		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode ver ip de um administrador.");
//
//	GetPlayerIp(pid, gip, sizeof(gip));
//	SendClientMessage(playerid, COR_AVISO, "Nick: %s IP: %s", GetUserName(pid), gip);
//	return true;
//}

flags:godcar(AJUDANTE); alias:godcar("gc");
CMD:godcar(playerid)
{
	if (IsPlayerInAnyVehicle(playerid))
	{
		if(GodCar[playerid] == false)
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			GodCar[playerid] = true;
			RepairVehicle(vehicleid);
			SetVehicleHealth(vehicleid, 99999.0);
			SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | GodCar ativado!");
		}
		else
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			GodCar[playerid] = false;
			SetVehicleHealth(vehicleid, 1000.0);
			RepairVehicle(vehicleid);
			SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | GodCar desativado!");
		}
	}
	return true;
}

flags:godmod(AJUDANTE); alias:godmod("gm");
CMD:godmod(playerid)
{
	if(GodMod[playerid] == false)
	{
		GodMod[playerid] = true;
		SetPlayerHealth(playerid, 0x24FF0AB9);
		SetPlayerArmour(playerid, 999999);
		SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | GodMod ativado!");

		call::PLAYER->SetPlayerVarInt(playerid, Fome, 999);
		call::PLAYER->SetPlayerVarInt(playerid, Sede, 999);
		call::PLAYER->SetPlayerVarInt(playerid, Sono, 999);
	}
	else
	{
		GodMod[playerid] = false;
		SetPlayerHealth(playerid, 100);
		//SetPlayerArmour(playerid, 100);
		SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | GodMod desativado!");

		call::PLAYER->SetPlayerVarInt(playerid, Fome, 100);
		call::PLAYER->SetPlayerVarInt(playerid, Sede, 100);
		call::PLAYER->SetPlayerVarInt(playerid, Sono, 100);
	}
	return true;
}

flags:explodir(ADMINISTRADOR);
CMD:explodir(playerid, params[])
{
	new pid, Float: pos[3];

	if (sscanf(params, "d", pid))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/explodir [id]");

	if ( call::ADMIN->GetPlayerAdminLevel(playerid) < call::ADMIN->GetPlayerAdminLevel(pid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode explodir um administrador.");

	GetPlayerPos(pid, pos[0], pos[1], pos[2]);
    CreateExplosion(pos[0], pos[1], pos[2], 12, 25.0);
    CreateExplosion(pos[0], pos[1], pos[2], 12, 25.0);

    SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você explodiu o(a) jogador(a) %s[%d].", GetUserName(pid), pid);
    SendClientMessage(pid, COR_AZUL, "| PFC - ADMIN | O(A) %s %s explodiu você.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
    return true;
}

/*flags:players(AJUDANTE);
CMD:players(playerid)
{
	new str[1024 * 2];
	foreach(new i: Player)
	{
		format(str, sizeof(str), "%s{"COR_VERMELHO_INC"}%d\t{"COR_AZUL_INC"}%s\t%s\n", str, i, GetUserName(i), call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(i)));
	}
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST, "PLAYERS ONLINE", str, "OK", "");
	return true;
}*/

flags:exit(DEV);
CMD:exit(playerid)
{
	SendClientMessage(playerid, -1, "Fechando o servidor.");
	SendRconCommand(#exit);
	return true;
}


flags:gmx(DIRECAO);
CMD:gmx(playerid)
{
	SendClientMessage(playerid, -1, "Reiniciando o servidor.");
	SendRconCommand(#gmx);
	return true;
}

flags:darbitcoins(DIRECAO);
CMD:darbitcoins(playerid, params[])
{
	new pid, cash;
	if ( sscanf(params, "ud", pid, cash) )
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/darbitcoins [id] [quantidade]");


	Jogador[pid][Cash] += cash;

	new query[128];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `cash`='%d' WHERE `id`='%d' LIMIT 1;", Jogador[pid][Cash], Jogador[pid][PlayerID]);
	mysql_tquery(getConexao(), query);

	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você setou {"COR_LARANJA_INC"}%d {"COR_AZUL_INC"}BitCoins para o(a) {ffffff}%s{"COR_AZUL_INC"}({ffffff}%d{"COR_AZUL_INC"})", cash, GetUserName(pid), pid);
	SendClientMessage(pid, COR_AZUL, "| PFC - ADMIN | O(A) {ffffff}%s %s {"COR_AZUL_INC"}lhe setou {"COR_LARANJA_INC"}%d {"COR_AZUL_INC"}BitCoins", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), cash);
	//SendClientMessage(playerid, COR_BRANCO, "Você setou {"COR_AZUL_INC"}%d{"COR_BRANCO_INC"} de BitCoins para o jogador {"COR_LARANJA_INC"}%s{"COR_BRANCO_INC"}.", cash, GetUserName(pid));
	//SendClientMessage(pid, COR_BRANCO, "Você ganhou {"COR_LARANJA_INC"}%d{"COR_BRANCO_INC"} BitCoins pelo %s %s", Jogador[pid][Cash], call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
	return true;
}

//flags:ca(AJUDANTE);
CMD:ca(playerid, params[])
{

	if(Jogador[playerid][Beta] > 0 || call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE)
	{
		if(isnull(params))
			return SendClientMessage(playerid, 0xFF0000FF, "Uso Correto: /ca [mensagem]");
	
		foreach(new i: Player)
		{
			if(call::ADMIN->GetPlayerAdminLevel(i) && call::ADMIN->IsAdminInJob(i))
				SendClientMessage(i, 0x00FF00AA, "| CHAT - ADMIN | %s %s(%d): {ffffff}%s",  call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), playerid, params);
		}
	} else SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);
	return true;
}

flags:cc(AJUDANTE);
CMD:cc(playerid, params[])
{
	new texto[128];
	if(sscanf(params, "s[128]", texto))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /CC [texto].");
	
	foreach(new i: Player)
	{
		if(call::ADMIN->GetPlayerAdminLevel(playerid) <= call::ADMIN->GetPlayerAdminLevel(i))
		{
			SendClientMessage(i, COR_AZUL, "| CHAT - CARGO | %s %s[%d] diz: {ffffff}%s", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), playerid, texto);
		}
	}
	return 1;
}

flags:cnnlista(AJUDANTE);
CMD:cnnlista(playerid, params[])
{
	ShowPlayerDialog(playerid, DIALOG_ANUNCIOS, DIALOG_STYLE_LIST, "Auxílio de CNN Disponíveis", "{ffffff}Anúncio de Ajuda\n{ffffff}Anúncio de Relatório\n{ffffff}Anúncio de Respawn Veículos\n{ffffff}Anúncio de Evento {ff0000} Não finalizado\n{ffffff}Anúncio de Bug Bounty\n", "Anunciar", "Fechar");
	return true;
}

flags:estrelas(ADMINISTRADOR);
CMD:estrelas(playerid, params[])
{
	new id, estrela;
	if(sscanf(params, "ud", id, estrela)) return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /Estrelas [id] [quantidade]");

	if(estrela < 1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Quantia inválida.");

	SetPlayerWantedLevel(id, estrela);
	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s colocou %d estrelas de procurado em você!",  call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), estrela);
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você colocou %d estrelas de procurado em %s[%d]!", estrela, GetUserName(id), id);
	return true;
}

flags:removerestrelas(MODERADOR);
CMD:removerestrelas(playerid, params[])
{
	new id;

	if(sscanf(params, "u", id)) return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /RemoverEstrelas [id]");

	if(GetPlayerScore(id) >= 16)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse(a) jogador(a) já é level superior a 15");

	SetPlayerWantedLevel(id, 0);
	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s removeu suas estrelas de procurado!", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você removeu as estrelas de procurado do(a) jogador(a) %s[%d]!", GetUserName(id), id);
	
	SetPlayerSpecialAction(id, SPECIAL_ACTION_NONE), call::PLAYER->SetPlayerVarBool(id, Algemado, false);
	call::PLAYER->SetPlayerVarBool(id, Perseguido, false);
	return true;
}

flags:desarmar(MODERADOR);
CMD:desarmar(playerid, params[])
{
	new id;

	if(sscanf(params, "d", id))
	    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Uso Correto: /Desarmar (id)");

	ResetPlayerWeapons(id);
	//SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s desarmou você.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você desarmou o(a) jogador(a) %s[%d].", GetUserName(id), id);
	return true;
}

flags:desarmartodos(MODERADOR);
CMD:desarmartodos(playerid, params[])
{
	foreach(new i: Player)
	{
		if(IsPlayerConnected(i))
		{
			ResetPlayerWeapons(i);
		}
	}
	//SendClientMessageToAll(COR_AZUL, "| PFC - ADMIN | O(A) %s %s desarmou todos do servidor.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você desarmou todos do servidor.");
	return true;
}

flags:congelar(AJUDANTE);
CMD:congelar(playerid, params[])
{
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /Congelar (id)");
	TogglePlayerControllable(id, 0);
	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s congelou você!", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você congelou o(a) jogador(a) %s[%d]!", GetUserName(id), id);
	return true;
}

//flags:descongelar(AJUDANTE);
CMD:descongelar(playerid, params[])
{
	if(Jogador[playerid][Beta] > 0 || call::ADMIN->GetPlayerAdminLevel(playerid) >= AJUDANTE)
	{
		new id;
		if(Jogador[playerid][Beta] > 0)
		{
			TogglePlayerControllable(playerid, true);
			return 1;
		}

		if(sscanf(params, "u", id)) return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /Descongelar [id]");
		TogglePlayerControllable(id, 1);
		
		SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s descongelou você!", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
		SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você descongelou o(a) jogador(a) %s[%d]!", GetUserName(id), id);

	} else SendClientMessage(playerid, COR_ERRO, CMD_NOT_PERMISSION);
	return true;
}

flags:proximos(AJUDANTE);
CMD:proximos(playerid, params[])
{
    
    new count=0, sstring[500], string[500], titulo[80];

    strcat(string, "{ffffff}Nick\t{ffffff}Level\t{ffffff}Proximidade\n");

    static Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, Float:x, Float:y, Float:z);

    for(new i; i < MAX_PLAYERS; i++)
    {
        if(!IsPlayerNPC(i) && IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i, 100.0, Float:x, Float:y, Float:z) && i != playerid)
        {
            format(sstring, sizeof(sstring), "%s\t%d\t%0.1f\n", GetUserName(i), GetPlayerScore(i), GetPlayerDistanceFromPoint(i, Float:x, Float:y, Float:z));
            strcat(string, sstring);

            count++;
        }
    }

    format(titulo, sizeof(titulo), "{ffffff}Quantidade de próximos: [{008000} %d {ffffff}]", count);

    if(count > 0)
    {
        ShowPlayerDialog(playerid, DIALOG_MSG, DIALOG_STYLE_TABLIST_HEADERS, titulo, string, "Fechar", "");
    }
    else 
    {
        ShowPlayerDialog(playerid, DIALOG_MSG, DIALOG_STYLE_MSGBOX, "{ffffff}Quantidade de próximos: [{008000} 0 {ffffff}]", "{ff0000}Não há nenhum jogador próximo no momento!", "Fechar", "");
    }

    return 1;
}

flags:novatos(AJUDANTE);
CMD:novatos(playerid, params[])
{    
    new count=0, sstring[500], string[500], titulo[50];

    strcat(string, "{ffffff}Nick\t{ffffff}Level\t{ffffff}Profissão\n");

    for(new i; i < MAX_PLAYERS; i++)
    {
        if(!IsPlayerNPC(i) && IsPlayerConnected(i) && GetPlayerScore(i) < 15)
        {
			new jobname[70];
			call::JOB->GetJobName(Jogador[i][Profissao], jobname, 70);
            format(sstring, sizeof(sstring), "%s\t%d\t%s\n", GetUserName(i), GetPlayerScore(i), jobname);
            strcat(string, sstring);

            count++;
        }
    }

    format(titulo, sizeof(titulo), "{ffffff}Novatos online: [{008000} %d {ffffff}]", count);

    if(count > 0)
    {
        ShowPlayerDialog(playerid, DIALOG_MSG, DIALOG_STYLE_TABLIST_HEADERS, titulo, string, "Fechar", "");
    }
    else 
    {
        ShowPlayerDialog(playerid, DIALOG_MSG, DIALOG_STYLE_MSGBOX, "{ffffff}Novatos online: [{008000} 0 {ffffff}]", "{ff0000}Não há nenhum novato online no momento!", "Fechar", "");
    }

    return 1;
}


flags:setworld(AJUDANTE);
CMD:setworld(playerid, params[])
{

	new interior, world, id;

	if (sscanf ( params, "ddd", id, interior, world))
		return SendClientMessage(playerid, COR_ERRO, "/SetWorld [id] [interior] [world]");

	if(!IsPlayerConnected(id))
		return true;

	SetPlayerInterior(id, interior);
	SetPlayerVirtualWorld(id, world);
	return true;
}

flags:pagarevento(ADMINISTRADOR);
CMD:pagarevento(playerid, params[])
{
	new id, quantia;
	if(sscanf(params, "ud", id, quantia))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /PagarEvento [id] [quantia].");

	if(!IsPlayerConnected(id) || IsPlayerNPC(playerid) == 1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a).");

	if(quantia > 50000)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Quantia máxima é de R$50.000");

	//if(id == call::ADMIN->GetPlayerAdminLevel(id) >= AJUDANTE)
	//	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode premiar um admin.");

	new str[200];
	format(str, sizeof(str), "~b~%s ~w~foi o(a) ~g~vencedor(a) ~w~do evento no valor de ~g~$%s~w~!", GetUserName(id), RealStr(quantia));
	call::TD->ShowCnnMessage(playerid, str);

	SendClientMessage(id, COR_AZUL, "| EVENTO | O(A) %s %s pagou para você R$%s em prêmio!", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), RealStr(quantia));

	GivePlayerMoney(id, quantia);	
	return 1;
}

flags:versaldo(AJUDANTE);
CMD:versaldo(playerid, params[])
{
	new id;
	if(sscanf(params, "u", id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /VerSaldo [id].");
	
	if(!IsPlayerConnected(id) || IsPlayerNPC(id) == 1)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a).");
	
	new str[300];
	strcat(str, "{ffffff}Opção\t{"COR_VERDE_INC"}Valor\n");

	new query[350];
	mysql_format(getConexao(), query, sizeof(query), "SELECT `saldo` FROM "TABLE_BANK" WHERE `id`='%d' LIMIT 1", call::PLAYER->GetPlayerVarInt(id, PlayerID));
	new Cache:result = mysql_query(getConexao(), query, true);
	new rows = cache_num_rows();

	new titulo[50];
	format(titulo, sizeof(titulo), "{ffffff}Saldo de {"COR_AZUL_INC"}%s[%d]", GetUserName(id), id);

	new stringformat[100];
	format(stringformat, sizeof(stringformat), "{ffffff}Dinheiro em Mãos\t{"COR_VERDE_INC"}$%s\n", RealStr(GetPlayerMoney(id)));
	strcat(str, stringformat);

	if(rows)
	{
		for(new i; i < rows; i++)
		{
			new saldobanco;
			cache_get_value_int(i, "saldo", saldobanco);
			

			format(stringformat, sizeof(stringformat), "{ffffff}Saldo no Banco\t{"COR_VERDE_INC"}$%s\n", RealStr(saldobanco));
			strcat(str, stringformat);

			ShowPlayerDialog(playerid, DIALOG_MSG, DIALOG_STYLE_TABLIST_HEADERS, titulo, str, "Fechar", "");
		}

	}

	if(!rows)
	{

		strcat(str, "{ffffff}Saldo no Banco\t{ff0000}O(A) jogador(a) não possui uma conta bancária.\n");

		ShowPlayerDialog(playerid, DIALOG_MSG, DIALOG_STYLE_TABLIST_HEADERS, titulo, str, "Fechar", "");
	}

	cache_delete(result);	
	return 1;
}

flags:abrirservidor(DIRECAO);
CMD:abrirservidor(playerid)
{
	foreach(new i: Player)
	{
		if(call::ADMIN->GetPlayerAdminLevel(i) >= AJUDANTE)
		{
			SendClientMessage(i, COR_AMARELO, "| PFC - ADMIN | O(A) {ffffff}%s %s {"COR_AMARELO_INC"}destrancou o servidor para o público.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
			SendRconCommand("password 0");
		}
	}

	return 1;
}
flags:inaugurar(DEV);
CMD:inaugurar(playerid)
{
	SendRconCommand("hostname "SERVER_NAME" - Inauguração!");
	SendRconCommand("gamemodetext Brasil RPG - ("SERVER_VERSION")");
	SendRconCommand("language Português Brasil");
	SendRconCommand("password 0");
	return 1;
}

flags:fecharservidor(DIRECAO);
CMD:fecharservidor(playerid, params[])
{
	new senha[40];

	if(sscanf(params, "s[40]", senha))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /FecharServidor [senha].");

	new comando[60];
	format(comando, sizeof(comando), "password %s", senha);
	SendRconCommand(comando);

	SendClientMessage(playerid, -1, "Você trancou o servidor para o público. ( Senha: {"COR_AMARELO_INC"}%s {ffffff})", senha);
	
	//foreach(new i: Player)
	//{
	//	if(call::ADMIN->GetPlayerAdminLevel(i) >= AJUDANTE)
	//	{
	//		SendClientMessage(i, COR_AMARELO, "| PFC - ADMIN | O(A) {ffffff}%s %s {"COR_AMARELO_INC"}trancou o servidor para o público. ( Senha: {ffffff}%s {"COR_AMARELO_INC"})", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), senha);
	//		
	//		new comando[60];
	//		format(comando, sizeof(comando), "password %s", senha);
	//		SendRconCommand(comando);
	//	}
	//}

	return 1;
}

flags:resetarsaldo(ADMINISTRADOR);
CMD:resetarsaldo(playerid, params[])
{
	new id;
	if(sscanf(params, "u", id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /ResetarSaldo [id].");
	
	if(call::PLAYER->IsPlayerLogged(id) == 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a).");
	
	new query[350];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_BANK" SET `saldo`='0' WHERE `id`='%d' LIMIT 1", call::PLAYER->GetPlayerVarInt(id, PlayerID));
	mysql_tquery(getConexao(), query);

	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s resetou seu saldo do banco.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você resetou o saldo do banco do(a) jogador(a) %s[%d]!", GetUserName(id), id);
	return 1;
}

flags:setarsaldo(ADMINISTRADOR);
CMD:setarsaldo(playerid, params[])
{
	new id, quantia;
	if(sscanf(params, "ud", id, quantia))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /SetarSaldo [id] [quantia].");
	
	if(call::PLAYER->IsPlayerLogged(id) == 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a).");
	
	new query[350];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_BANK" SET `saldo`='%d' WHERE `id`='%d' LIMIT 1", quantia, call::PLAYER->GetPlayerVarInt(id, PlayerID));
	mysql_tquery(getConexao(), query);

	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s setou seu saldo bancário para R$%s!", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), RealStr(quantia));
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você setou o saldo bancário do(a) jogador(a) %s[%d] para $%s!", GetUserName(id), id, RealStr(quantia));
	return 1;
}

flags:profissoes(ADMINISTRADOR);
CMD:profissoes(playerid)
{
	new str[1000];
	strcat(str, "Profissão\tID\n");

	for(new i; i < MAX_PROFISSOES; i++)
	{

		new jobname[50], strr[1000];
		call::JOB->GetJobName(i, jobname, 50);
		format(strr, sizeof(strr), "{ffff00}%s\t{"COR_VERDE_INC"}%d\n", jobname, i);
		strcat(str, strr);

		ShowPlayerDialog(playerid, DIALOG_MSG, DIALOG_STYLE_TABLIST_HEADERS, "{ffffff}ID das Profissões", str, "Fechar", "");
	}
	return 1;
}

flags:setarprof(ADMINISTRADOR);
CMD:setarprof(playerid, params[])
{
	new id, idprof;
	if(sscanf(params, "dd", id, idprof))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /SetarProf [id] [id da profissão].");
	
	if(call::PLAYER->IsPlayerLogged(id) == 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a).");
	
	new nomejob[50];
	call::JOB->GetJobName(idprof, nomejob, 50);

	new query[350];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `profissao`='%d' WHERE `id`='%d' LIMIT 1", idprof, Jogador[id][PlayerID]);
	mysql_tquery(getConexao(), query);

	//SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você alterou sua profissão para {ffffff}%s", nomejob);
	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s setou a profissão de '%s' para você!", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), nomejob);
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você setou a profissão '%s (%d)' para o(a) jogador(a) %s[%d]!", nomejob, idprof, GetUserName(id), id);

	Jogador[id][Profissao] = idprof;
	call::JOB->LogarProf(id);
	return 1;
}

flags:setarhabilitacao(MODERADOR);
CMD:setarhabilitacao(playerid, params[])
{
	new id, categoria;
	if(sscanf(params, "ud", id, categoria))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /SetarHabilitacao [id] [id da categoria]."), SendClientMessage(playerid, COR_ERRO, "| INFO | Categorias: 1 (Moto), 2 (Carro), 3 (Caminhão), 4 (Barco), 5 (Avião).");
	
	if(call::PLAYER->IsPlayerLogged(id) == 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a).");
	
	if(categoria < 1 || categoria > 5)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Categoria inválida.");
	
	new habilitacao[30], query[350], sqlhab[50];

	if(categoria == 1) { BitFlag_Set(Jogador[id][Habilitacao], HAB_MOTO), habilitacao = "Moto", sqlhab = "habilitacao_a"; }
	else if(categoria == 2) { BitFlag_Set(Jogador[id][Habilitacao], HAB_CARRO), habilitacao = "Carro", sqlhab = "habilitacao_b"; }
	else if(categoria == 3) { BitFlag_Set(Jogador[id][Habilitacao], HAB_CAMINHAO), habilitacao = "Caminhão", sqlhab = "habilitacao_c"; }
	else if(categoria == 4) { BitFlag_Set(Jogador[id][Habilitacao], HAB_BARCO), habilitacao = "Barco", sqlhab = "habilitacao_d"; }
	else if(categoria == 5) { BitFlag_Set(Jogador[id][Habilitacao], HAB_AVIAO), habilitacao = "Avião", sqlhab = "habilitacao_e"; }

	mysql_format(getConexao(), query, 350, "UPDATE "TABLE_USERS" SET `%s`='1' WHERE `id`='%d' LIMIT 1", sqlhab, call::PLAYER->GetPlayerVarInt(id, PlayerID));
	mysql_tquery(getConexao(), query);

	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | O(A) %s %s setou Habilitação de '%s' para você!", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), habilitacao);
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você setou Habilitação de '%s' para o(a) jogador(a) %s[%d]!", habilitacao, GetUserName(id), id);
	return 1;
}

flags:irpos(DEV);
CMD:irpos(playerid, params[]) {
	new Float:TmpPos[3];
	if(sscanf(params, "fff", TmpPos[0], TmpPos[1], TmpPos[2])) return SendClientMessage(playerid, -1, "USE: /irpos [ X ] [ Y ] [ Z ]");
	SetPlayerPos(playerid, TmpPos[0], TmpPos[1], TmpPos[2]);
	return true;
}

flags:teles(AJUDANTE); alias:teles("tps", "teleportes", "tp");
CMD:teles(playerid, params[])
{
	new str[1024 * 3];
	for(new i; i < 26; i++)
	{
		format(str, sizeof(str), "%s%s\n", str, TeleporteInfo[i][tpName]);
	}
	ShowPlayerDialog(playerid, D_TELEPORTES, DIALOG_STYLE_LIST, "LISTA DE TELEPORTES", str, "Ir", "Fechar");
	return true;
}

CMD:gerarimpostos(playerid)
{
	GerarImpostos();
	return 1;
}


flags:hextoint(DEV);
CMD:hextoint(playerid, params[])
{
	new cor[25];
	if(sscanf(params, "s", cor))
		return true;

	SendClientMessage(playerid, -1, "COR: %d", HexToInt(cor));
	return true;
}

/*
CMD:sant(playerid)
{
	SetPlayerPos(playerid, 1377.552734, -35.870326, 1000.536315);
	return 1;
}*/

flags:novarota(DIRECAO);
CMD:novarota(playerid, params[]) {
    static Rota[64], Float:ValorRota, inMafia, Query[200], Cache:qq, str[128], prof_carga;
    if(sscanf(params, "s[64]fii", Rota, ValorRota,prof_carga, inMafia)) return SendClientMessage(playerid, -1, "{FF0000}Use: /novarota [nome] [valor da rota] [carga] [interesse da mafia 0/1]"), SendClientMessage(playerid, -1, "{FF0000}Cargas: 1 (Minério); 2 (Fluídos); 3 (Baú); 4 (C. Cimento); 5 (C. Comum); 6 (Aviões); 7 (Helicópteros); 8 (Mafia); 8 (Barcos)");
    if(inMafia > 1 || inMafia < 0) return SendClientMessage(playerid, -1, "{FF0000}0 = Não | 1 = Sim");
    if(prof_carga < 0 || prof_carga > 8) return SendClientMessage(playerid, -1, "{FF0000}Cargas: 1 (Minério); 2 (Fluídos); 3 (Baú); 4 (C. Cimento); 5 (C. Comum); 6 (Aviões); 7 (Helicópteros); 8 (Mafia); 8 (Barcos)");
    mysql_format(getConexao(), Query, sizeof(Query), "INSERT INTO rotas (produto, valor, mafia, carga) VALUES ('%e', %f, %i, %i)", Rota, ValorRota, inMafia, prof_carga);
    qq = mysql_query(getConexao(), Query, true);
    SetPVarInt(playerid, "edit_rota", cache_insert_id());
    format(str, sizeof(str), "{FF0000}# {FFFFFF}Rota: %s", Rota);
    ShowPlayerDialog(playerid, EditarRota, DIALOG_STYLE_LIST, str, "Editar nome\nApagar rota\nEditar valor da rota\nAdicionar Carregamentos\nAdicionar Descarregamentos\nRetirar algum carregamento\nRetirar algum descarregamento\nRota de interesse de mafia\nTipo de Veiculo\n", "Selecionar", "Cancelar");
    cache_delete(qq);
    return 1;
}

flags:editarrota(DIRECAO);
CMD:editarrota(playerid, params[]) {
    SetPVarInt(playerid, "rotas_pag", 0);
    return TodasRotas(playerid, 0);
}

flags:novolocal(DIRECAO);
CMD:novolocal(playerid, params[]) {
    static NomeLocal[64], Float:rPos[3], Query[200], Cache:qq, Msg[144];
    if(sscanf(params, "s[64]", NomeLocal)) return SendClientMessage(playerid, -1, "{FF0000}Use: /novolocal [nome]");
    if(GetPlayerVehicleID(playerid) == 0)
        GetPlayerPos(playerid, rPos[0], rPos[1], rPos[2]);
    else
        GetVehiclePos(GetPlayerVehicleID(playerid), rPos[0], rPos[1], rPos[2]);
    mysql_format(getConexao(), Query, sizeof(Query), "INSERT INTO rotas_locais (nome, XYZ) VALUES ('%e','%4.2f,%4.2f,%4.2f')", NomeLocal, rPos[0], rPos[1], rPos[2]);
    qq = mysql_query(getConexao(), Query, true);
    format(Msg, 144, "{ffff00}Novo local de carregamento/descarregamento adicionado! Nome: %s | ID: %i", NomeLocal, cache_insert_id());
    SendClientMessage(playerid, -1, Msg);
    cache_delete(qq);
    return 1;
}

flags:recarregarrotas(DIRECAO);
CMD:recarregarrotas(playerid, params[]) {
    return ObterRotas(), SendClientMessage(playerid, -1, "{FFFF00}Rotas recarregadas.");
}

flags:buscaratividades(DIRECAO); alias:buscaratividades("logs");
CMD:buscaratividades(playerid) {
    SetPVarInt(playerid, "buscar_reg", 0);
    return ShowPlayerDialog(playerid, BuscaAtividades, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Buscar Registro de Atividades", "Atividades do Jogador\nAtividades do Administrador\n", "Buscar", "Cancelar");
}

flags:trazerveiculo(AJUDANTE);
CMD:trazerveiculo(playerid, params[])
{
	new Car, Float:x, Float:y, Float:z;

	if (sscanf(params, "i", Car)) return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /trazerveiculo [id]");
    if(Car <= 0 || Car >= MAX_VEHICLES) return SendClientMessage(playerid, COR_ERRO, "| ERRO | Veículo inválido!");
    GetPlayerPos(playerid, x, y, z);
    SetVehiclePos(Car, x+2.0, y+1.0, z);
    SetVehicleVirtualWorld(Car, GetPlayerVirtualWorld(playerid));

    SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você trouxe o veículo ID %i até você.", Car);
	return 1;
}

flags:minigun(MODERADOR);
CMD:minigun(playerid)
{

	GivePlayerWeapon(playerid, 38, 99999);
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você criou a arma '{ffffff}Minigun{"COR_AZUL_INC"}'");
	return 1;
}

flags:bazuca(MODERADOR);
CMD:bazuca(playerid)
{

	GivePlayerWeapon(playerid, 35, 99999);
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você criou a arma '{ffffff}Bazuca{"COR_AZUL_INC"}'");
	return 1;
}

flags:praagencia(AJUDANTE);
CMD:praagencia(playerid, params[])
{
	new id;

	if(sscanf(params, "d", id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use /PraAgencia (id)");

	if(IsPlayerNPC(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode mandar um NPC para a Agência");

	if(!IsPlayerConnected(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse jogador(a) não está online");

	Teleport(id, 1216.93, -1812.98, 16.5938, 3.1705, 0, 0, ENTROU_NONE);


	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s teleportou você para a Agência de Empregos", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você teleportou o(a) jogador(a) %s[%d] para a Agência de Empregos", GetUserName(id), id);
	return true;
}

flags:ircarro(AJUDANTE);
CMD:ircarro(playerid, params[])
{
	new id;

	if(sscanf(params, "u", id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /IrCarro [id].");
	
	if(!IsPlayerConnected(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a).");
	
	if(IsPlayerNPC(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a).");
	
	if(GetPlayerState(id) != PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) não está como motorista.");
	
	SetPlayerInterior(playerid, GetPlayerInterior(id));

	new Carro = GetPlayerVehicleID(id);

	if(!IsVehicleSeatOccupied(Carro, 1)){
		PutPlayerInVehicle(playerid, Carro, 1);
	}
	else if(!IsVehicleSeatOccupied(Carro, 3)){
		PutPlayerInVehicle(playerid, Carro, 3);
	}
	else if(!IsVehicleSeatOccupied(Carro, 4)){
		PutPlayerInVehicle(playerid, Carro, 4);
	}
	else{
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Não tem mais vaga no veiculo.");
		return true;
	}

	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você entrou de carona no veículo do(a) jogador(a) %s[%d]!", GetUserName(id), id);

	return 1;
}

flags:forceup(DEV);
CMD:forceup(playerid, params[])
{
	new id;
	if(sscanf(params, "u", id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /ForceUP [id].");
	
	if(!IsPlayerConnected(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a).");
	
	if(IsPlayerNPC(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a).");
	
	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s forçou você a upar de level.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você forçou o(a) jogador(a) %s[%d] a upar de level.", GetUserName(id), id);

	SetPlayerScore(id, GetPlayerScore(id)+1);
	Jogador[id][PorcLevel] = 1;
	
	new query[128];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `level`='%d' WHERE `id`='%d' LIMIT 1;", GetPlayerScore(id), call::PLAYER->GetPlayerVarInt(id, PlayerID));
	mysql_tquery(getConexao(), query);

	new _strporc[20];
	format(_strporc, sizeof(_strporc), "%d%", Jogador[id][PorcLevel]);
	PlayerTextDrawSetString(id, ExpOP[id][0], _strporc);
	
	
	return 1;
}

flags:forcesalario(DEV);
CMD:forcesalario(playerid)
{
	SetTimer("OnPlayerPay", 5000, false);
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você forçou o salário.");
	return 1;
}


flags:reiniciar(DEV);
CMD:reiniciar(playerid)
{
	SendClientMessageToAll(-1, "| PFC - ADMIN | O servidor irá reiniciar dentro de 3 minutos.");

	SetTimer("RestartarServer", 3*60000, 0);

	return 1;
}

forward RestartarServer();
public RestartarServer()
{
	SendClientMessageToAll(-1, "| INFO | Servidor reiniciando. Voltamos já.");

	foreach(new i: Player)
	{
		Kick(i);
	}

	HTTP(0, HTTP_POST, "localhost/metropolitan/backup", "backup", "OnBackupReturn");
	return 1;
}

flags:gerarsenha(DEV);
CMD:gerarsenha(playerid, params[])
{
	new id;
	if(sscanf(params, "u", id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Use: /GerarSenha [id]");
	
	if(!IsPlayerConnected(id))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a).");
	
	call::ADMIN->GeneratePass(playerid, id);
	return 1;
}

function ADMIN::GeneratePass(playerid, id)
{
	new hash[6];

	new Rand = random(10000);
	new str[10];

	format(str, 10, "%d", Rand);

	SHA256_PassHash(str, "78sdjs86d2h", hash, sizeof(hash));

	if(strval(hash)) return call::ADMIN->GeneratePass(playerid, id);

	SendClientMessage(id, COR_AZUL, "| PFC - ADMIN | O(A) %s %s lhe gerou uma senha administrativa. ( Senha: %s )", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), hash);
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você gerou uma senha para o(a) %s %s[%d]. ( Senha: %s )", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(id)), GetUserName(id), id, hash);

	new query[350];
	format(query, sizeof(query), "UPDATE `usuarios` SET `senhaadmin`='%s' WHERE `id`='%d'", hash, call::PLAYER->GetPlayerVarInt(id, PlayerID));
	mysql_query(getConexao(), query, false);
	return 1;
}

Dialog:DIALOG_LOGAR_ADM(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(isnull(inputtext))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Senha incorreta.");
		
		new query[350];
		format(query, 350, "SELECT `senhaadmin` FROM `usuarios` WHERE `id`='%d'", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
		new Cache:result = mysql_query(getConexao(), query, true), rows = cache_num_rows();
		if(rows > 0)
		{
			new senha[10];
			cache_get_value_name(0, "senhaadmin", senha);
			if(!strcmp(senha, inputtext, false))
			{
				SendClientMessage(playerid, 0xff6800ff, "| PFC - LOGIN | Bem vindo(a) à Administração {ffffff}%s", GetUserName(playerid));
				SendClientMessage(playerid, 0xff6800ff, "| PFC - LOGIN | Você logou como {ffffff}%s {ff6800}no servidor", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)));
				call::ADMIN->ToggleAdminInJob(playerid, true);

				SendLog(LOG_LOGINADMIN, "| PFC-Logs | O(A) %s %s entrou no modo administrativo.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), \
				GetUserName(playerid));
			}
			else 
			{
				SendClientMessage(playerid, COR_ERRO, "| ERRO | Senha incorreta.");

				SendLog(LOG_LOGINADMIN, "| PFC-Logs | O(A) %s %s errou a senha administrativa ( Senha inserida: %s )", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), \
				GetUserName(playerid), inputtext);
			}
		}

		cache_delete(result);
	}
	return 1;	
}

stock converttime(time)
{
	new newtime;
	if(time >= 86400)
	{
		newtime = (time / 60 / 60 / 24); // Conversão de Segundos para Dias
	}
	else 
	{
		if(time >= 3600)
		{
			newtime = (time / 60 / 60); // Conversão de Segundos para Horas
		}

		else if(time < 3600)
		{
			if(time >= 60)
			{
				newtime = (time / 60); // Conversão de Segundos para Minutos
			}
			else if(time < 60)
			{
				newtime = time; // Conversão de Segundos para Segundos
			}
		}
	}
	return newtime;
}

new vencimentovip[MAX_PLAYERS];

CMD:testvencimento(playerid, params[])
{
	new tempo;
	if(sscanf(params, "d", tempo))
		return false;

	vencimentovip[playerid] = gettime() + tempo;
	return 1;
}

CMD:vvencimento(playerid, params[])
{	
	new string[50];

	new time = vencimentovip[playerid]-gettime();

	if(time  >= 86400) { string = "Dias"; }
	else if(time < 84600 && time >= 3600) { string = "Horas"; }
	else if(time < 3600 && time >= 60) { string = "Minutos"; }
	else if(time < 60) { string = "Segundos"; }

	SendClientMessage(playerid, -1, "Faltam %d %s para a base vencer.", converttime(time), string);
	return 1;
}