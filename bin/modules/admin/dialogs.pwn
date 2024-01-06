Dialog:DIALOG_INFOPUNICAO(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		ShowPlayerDialog(playerid, DIALOG_PUNICAO, DIALOG_STYLE_LIST, "{"COR_AZUL_INC"}| PFC - ADMIN |", "Kick\nRetirar de 0 a 3 leveis\nPrisão por 45 minutos", "Confirmar", "Cancelar");
	}
	return true;
}

Dialog:DIALOG_PUNICAO(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: { //Kickar
				new pid = GetPVarInt(playerid, "PunindoID");

				SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você kickou o {"COR_BRANCO_INC"}%s{"COR_AZUL_INC"} do servidor por acumular 3 avisos.", GetUserName(pid));
				SendClientMessage(pid, COR_VERMELHO, "| PFC - ADMIN | O(A) {"COR_BRANCO_INC"}%s %s {"COR_VERMELHO_INC"}kickou você do servidor por acumular: 3 avisos.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid));
				SendClientMessageToAll(COR_VERMELHO, "| PFC - ADMIN | O(A) {"COR_BRANCO_INC"}%s %s {"COR_VERMELHO_INC"}kickou o {"COR_BRANCO_INC"}%s{"COR_VERMELHO_INC"} do servidor por acumular: 3 avisos.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), GetUserName(pid));

				call::PLAYER->SetPlayerVarInt(pid, Avisos, 0);
				SetPVarInt(playerid, "PunindoID", -1);

				new query[128];
			    mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `avisos`='%d' WHERE `id`=%d", call::PLAYER->GetPlayerVarInt(pid, Avisos), call::PLAYER->GetPlayerVarInt(pid, PlayerID));
				mysql_tquery(getConexao(), query);

				Kick(pid);
			}
			case 1: { //Remover Score
				ShowPlayerDialog(playerid, DIALOG_PUNSCORE, DIALOG_STYLE_INPUT, "{"COR_SISTEMA_INC"}| PFC - ADMIN |", "Digite abaixo um valor entre 1 a 3, para retirar do score do jogador(a)", "Confirmar", "");
			}
			case 2: { //Prender 
				new pid = GetPVarInt(playerid, "PunindoID");

				SendClientMessage(pid, COR_ERRO, "| ERRO | Você foi preso por 45 minutos por acumular: 3 avisos.");
				SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você prendeu o {"COR_BRANCO_INC"}%s{"COR_AZUL_INC"} por 45 minutos Motivo: acumulou 3 avisos.", GetUserName(pid));
				SendClientMessageToAll(COR_VERMELHO, "| PFC - ADMIN | O(A) {"COR_BRANCO_INC"}%s %s {"COR_VERMELHO_INC"}prendeu o {"COR_BRANCO_INC"}%s{"COR_VERMELHO_INC"} por 45 minutos, Motivo: acumulou 3 avisos.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), GetUserName(pid));

				SetPVarInt(playerid, "PunindoID", -1);

				call::PLAYER->SetPlayerVarInt(pid, Preso, PRESO_ADM);
				call::PLAYER->SetPlayerVarInt(pid, TempoPreso, (45 * 60));
				EnviarCela(pid);
				call::PM->ShowPlayerTextDrawPrisonTime(pid);
				call::PLAYER->SetPlayerVarInt(pid, Avisos, 0);	
				call::PM->resetVarsPerseguicao(pid);

				new query[128];
			    mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `avisos`='%d' WHERE `id`=%d", call::PLAYER->GetPlayerVarInt(pid, Avisos), call::PLAYER->GetPlayerVarInt(pid, PlayerID));
				mysql_tquery(getConexao(), query);
			}
		}
	}
	return true;
}

Dialog:DIALOG_PUNSCORE(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new scor = strval(inputtext), pid = GetPVarInt(playerid, "PunindoID");

		if( scor < 1 || scor > 3 )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você deve só pode enviar valores entre 1 e 3."), ShowPlayerDialog(playerid, DIALOG_PUNSCORE, DIALOG_STYLE_INPUT, "{"COR_SISTEMA_INC"}| PFC - ADMIN |", "Digite abaixo um valor entre 1 a 3, para retirar do score do jogador(a)", "Confirmar", "");

		SetPlayerScore(pid, GetPlayerScore(pid) -scor);

		SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | Você retirou %d leveis do jogador(a) {"COR_BRANCO_INC"}%s{"COR_AZUL_INC"} por acumular 3 avisos.", scor, GetUserName(pid));
		SendClientMessage(pid, COR_VERMELHO, "| PFC - ADMIN | O(A) {"COR_BRANCO_INC"}%s %s {"COR_VERMELHO_INC"}retirou %d leveis seu por acumular: 3 avisos.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), scor);
		SendClientMessageToAll(COR_VERMELHO, "| PFC - ADMIN | O(A) {"COR_BRANCO_INC"}%s %s {"COR_VERMELHO_INC"}retirou %d leveis do jogador(a) {"COR_BRANCO_INC"}%s{"COR_VERMELHO_INC"} por acumular: 3 avisos.", call::ADMIN->CargoAdmin(call::ADMIN->GetPlayerAdminLevel(playerid)), GetUserName(playerid), scor, GetUserName(pid));

		SetPVarInt(playerid, "PunindoID", -1);
		call::PLAYER->SetPlayerVarInt(pid, Avisos, 0);

		new query[128];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `avisos`='%d', `level`='%d' WHERE `id`=%d", call::PLAYER->GetPlayerVarInt(pid, Avisos), GetPlayerScore(pid), call::PLAYER->GetPlayerVarInt(pid, PlayerID));
		mysql_tquery(getConexao(), query);
		return true;
	}
	return true;
}

Dialog:MENU_PLAYER_CLICKED(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0:{ // ir até o jogador
				new id = GetPVarInt(playerid, "clickedplayerid"), str[10];
				format(str, sizeof( str), "%d", id);
				callcmd::ir(playerid, str);
				return true;
			}
			case 1:{ // Trazer o jogador
				new id = GetPVarInt(playerid, "clickedplayerid"), str[10];
				format(str, sizeof(str), "%d", id);
				callcmd::trazer(playerid, str);
				return true;
			}
		}
		return true;
	}
	return true;
}

Dialog:D_INTERIORES(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		SetPlayerPos(playerid, InteriorInfo[listitem][iX], InteriorInfo[listitem][iY], InteriorInfo[listitem][iZ]);
		SetPlayerInterior(playerid, InteriorInfo[listitem][iInterior]);
		return true;
	}
	return true;
}

Dialog:D_TELEPORTES(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		SetPlayerPos(playerid, TeleporteInfo[listitem][tpX], TeleporteInfo[listitem][tpY], TeleporteInfo[listitem][tpZ]);
		return true;
	}
	return true;
}

Dialog:DIALOG_ANUNCIOS(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: // Ajuda
			{
				call::TD->ShowCnnMessage(playerid, "~G~Bem-vindo(a)~N~~w~Necessitando de ajuda ? ~Y~Chame um administrador!");
			}
			case 1: // Relatório
			{
				call::TD->ShowCnnMessage(playerid, "~R~Relatório~N~~w~Tem algum(a) jogador(a) desrespeitando as regras ? ~R~/Relatorio");
			}
			case 2: // Respawn de Veículos
			{
				foreach(new i: Player)
				{
					call::TD->ShowCnnMessage(playerid, "~G~Respawn de Veículos~n~~w~~r~>>~w~Veículos não utilizados serão respawnados em ~r~30~w~ segundos! ~r~<<");
				}
				
				SetTimer("Respawn10", 20000, false);
				//SetTimer("HideTextDrawRV", 5000, false);
			}
			case 3: // Evento ( Não finalizado )
			{
				call::TD->ShowCnnMessage(playerid, "~g~Evento Criado~n~~w~Para ir ao evento, use o comando ~y~/IrEvento~n~~w~Status: ~r~Fechado~n~~w~Prêmio: ~g~50.000");
			}
			case 4: // Bugs
			{
				call::TD->ShowCnnMessage(playerid, "~r~Bug Bounty~n~~n~~w~Encontrou algum bug? Reporte em nosso forum e seja recompensado por isso!~n~Acesse~n~~y~www.perfectcityrpg.com.br");
			}
		}
		return true;
	}
	return true;
}

Dialog:DIALOG_CMDSADM(playerid, response, listitem, inputtext[])
{
	if(!response) { SetPVarInt(playerid, "PagCmdAdm", 0); }

	if(response)
	{
		new admLevel = call::ADMIN->GetPlayerAdminLevel(playerid);
		if(GetPVarInt(playerid, "PagCmdAdm") == 1)
		{
			switch(listitem)
			{
				case 46:
				{
					SetPVarInt(playerid, "PagCmdAdm", 2);
					new string[1600];
					strcat(string, "{ff8000}Comando\t{ffffff}Função\n");
					strcat(string, "{ff8000}/TempBan [ID] [Motivo] [TEMPO]\t{ffffff}Para banir um(a) jogador(a) temporário do servidor.\n");
					strcat(string, "{ff8000}/Ban [ID] [Motivo]\t{ffffff}Para banir um(a) jogador(a) online no servidor.\n");
					strcat(string, "{ff8000}/BanConta [Nick] [Motivo]\t{ffffff}Para banir um(a) jogador(a) offline no servidor.\n");
					strcat(string, "{ff8000}/BanIP [IP] [Motivo]\t{ffffff}Para banir um IP do servidor.\n");
					strcat(string, "{ff8000}/VerIP [ID]\t{ffffff}Para ver o IP de algum(a) jogador(a).\n");
					strcat(string, "{ff8000}/SetarSkin [ID] [ID da Skin]\t{ffffff}Para setar skin para algum(a) jogador(a).\n");
					strcat(string, "{ff8000}/SetarColete [ID] [Quantia]\t{ffffff}Para setar colete para algum(a) jogador(a).\n");
					strcat(string, "{ff8000}/AgendarPrisao [Nick] [Tempo] [Motivo]\t{ffffff}Para prender um(a) jogador(a) offline na cadeia administrativa.\n");
					strcat(string, "{ff8000}/RVS\t{ffffff}Para respawnar todos os veículos sem uso.\n");
					strcat(string, "{ff8000}/Estrelas\t{ffffff}Para colocar estrelas de procurado em um jogador(a).\n");
					strcat(string, "{ff8000}/RemoverEstrelas\t{ffffff}Para remover estrelas de procurado de um jogador(a).\n");
					strcat(string, "{ff8000}/Desarmartodos\t{ffffff}Para desarmar todos do servidor.\n");
					strcat(string, "{ff8000}/SetarHabilitacao\t{ffffff}Para setar habilitações a um jogador(a).\n");
					if(admLevel > 2) { strcat(string, "{ff0000}Próxima Página"); }
				
					ShowPlayerDialog(playerid, DIALOG_CMDSADM, DIALOG_STYLE_TABLIST_HEADERS, "Comandos Admin - Moderador(a)", string, "Selecionar", "Cancelar");
				}
			}
		}

		else if(GetPVarInt(playerid, "PagCmdAdm") == 2)
		{
			switch(listitem)
			{
				case 13:
				{
					SetPVarInt(playerid, "PagCmdAdm", 3);
					new string[1500];
					strcat(string, "{ff8000}Comando\t{ffffff}Função\n");
					strcat(string, "{ff8000}/Explodir [ID]\t{ffffff}Para explodir algum(a) jogador(a).\n");
					strcat(string, "{ff8000}/SetarVIP [ID] [Dias]\t{ffffff}Para setar VIP para algum(a) jogador(a).\n");
					strcat(string, "{ff8000}/Desban [Nick]\t{ffffff}Para desbanir um(a) jogador(a) do servidor.\n");
					strcat(string, "{ff8000}/DesbanIP [IP]\t{ffffff}Para desbanir um IP do servidor.\n");
					strcat(string, "{ff8000}/DarGrana [ID] [Quantia]\t{ffffff}Para dar dinheiro para algum(a) jogador(a).\n");
					strcat(string, "{ff8000}/RemoverGrana [ID]\t{ffffff}Para retirar todo o dinheiro de um jogador(a).\n");
					strcat(string, "{ff8000}/ResetarGrana [ID] [Quantia]\t{ffffff}Para resetar o dinheiro em mãos de algum(a) jogador(a).\n");
					strcat(string, "{ff8000}/DarArma [ID] [ID da Arma] [Munição]\t{ffffff}Para dar arma para algum(a) jogador(a).\n");
					strcat(string, "{ff8000}/IrEmpresa [ID da Empresa]\t{ffffff}Para ir até alguma empresa.\n");
					strcat(string, "{ff8000}/IrCasa [ID da Casa]\t{ffffff}Para ir até alguma casa.\n");
					strcat(string, "{ff8000}/IrGaragem [ID da Casa]\t{ffffff}Para ir até alguma garagem.\n");
					strcat(string, "{ff8000}/PagarEvento [ID] [Quantia]\t{ffffff}Para pagar o prêmio de um evento para um(a) jogador(a).\n");
					strcat(string, "{ff8000}/ResetarSaldo [ID]\t{ffffff}Para resetar o saldo bancário de um jogador(a).\n");
					strcat(string, "{ff8000}/SetarSaldo [ID]\t{ffffff}Para setar saldo bancário a um jogador(a).\n");
					strcat(string, "{ff8000}/Profissoes\t{ffffff}Para ver os IDS das Profissões.\n");
					strcat(string, "{ff8000}/SetarProf [ID] [ID da Profissão]\t{ffffff}Para setar uma profissão ao jogador(a).\n");
					if(admLevel > 3) { strcat(string, "{ff0000}Próxima Página"); }
				
					ShowPlayerDialog(playerid, DIALOG_CMDSADM, DIALOG_STYLE_TABLIST_HEADERS, "Comandos Admin - Administrador(a)", string, "Selecionar", "Cancelar");
				}
			}
		}

		else if(GetPVarInt(playerid, "PagCmdAdm") == 3)
		{
			switch(listitem)
			{
				case 16:
				{
					SetPVarInt(playerid, "PagCmdAdm", 4);
					new string[800];
					strcat(string, "{ff8000}Comando\t{ffffff}Função\n");
					strcat(string, "{ff8000}/FakeCmd [ID] [Comando]\t{ffffff}Para forçar algum(a) jogador(a) a usar um comando.\n");
					strcat(string, "{ff8000}/JogadorInfo [ID]\t{ffffff}Para ver as informações de algum(a) jogador(a).\n");
					strcat(string, "{ff8000}/SetarVIPTodos [Dias]\t{ffffff}Para setar VIP para todos(as) os(as) jogadores(as) online no servidor.\n");
					strcat(string, "{ff8000}/SetarNivel [ID] [Quantia]\t{ffffff}Para setar nível para algum(a) jogador(a).\n");
					if(admLevel > 4) { strcat(string, "{ff0000}Próxima Página"); }
				
					ShowPlayerDialog(playerid, DIALOG_CMDSADM, DIALOG_STYLE_TABLIST_HEADERS, "Comandos Admin - Diretor(a)", string, "Selecionar", "Cancelar");
				}
			}
		}

		else if(GetPVarInt(playerid, "PagCmdAdm") == 4)
		{
			switch(listitem)
			{
				case 4:
				{
					SetPVarInt(playerid, "PagCmdAdm", 5);
					new string[1000];
					strcat(string, "{ff8000}Comando\t{ffffff}Função\n");
					strcat(string, "{ff8000}/Exit\t{ffffff}Para desligar o servidor.\n");
					strcat(string, "{ff8000}/GMX\t{ffffff}Para reiniciar o servidor.\n");
					strcat(string, "{ff8000}/DarBitCoins [ID] [Quantia]\t{ffffff}Para dar BitCoins para algum(a) jogador(a).\n");
					strcat(string, "{ff8000}/FecharServidor [Senha]\t{ffffff}Para trancar o servidor com senha para o público.\n");
					strcat(string, "{ff8000}/AbrirServidor\t{ffffff}Para destrancar o servidor para o público.\n");
					strcat(string, "{ff8000}/DarAdmin [ID] [level]\t{ffffff}Para setar um level de administração a um jogador(a) (0 para retirar).\n");
				
					ShowPlayerDialog(playerid, DIALOG_CMDSADM, DIALOG_STYLE_TABLIST, "Comandos Admin - Desenvolvedor(a)", string, "Selecionar", "Cancelar");
				}
			}
		}
	}
	return 1;
}

/*Dialog:DIALOG_CMDSADM(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: // Comandos Ajudante
			{
				new string[4000];
				strcat(string, "{ff8000}/Ca [Mensagem]\t{ffffff}Para falar no chat admin.\n");
				strcat(string, "{ff8000}/CC [Mensagem]\t{ffffff}Para falar no chat do cargo admin.\n");
				strcat(string, "{ff8000}/Ir [ID]\t{ffffff}Para ir até a posição de algum(a) jogador(a).\n");
				strcat(string, "{ff8000}/Trazer [ID]\t{ffffff}Para trazer um(a) jogador(a) até a sua posição.\n");
				strcat(string, "{ff8000}/A [Texto]\t{ffffff}Para enviar uma mensagem no chat global do servidor.\n");
				strcat(string, "{ff8000}/Desbugar [ID]\t{ffffff}Para desbugar um(a) jogador(a).\n");
				strcat(string, "{ff8000}/SetarCombustivel [ID] [Quantidade]\t{ffffff}Para setar combustível para um(a) jogador(a).\n");
				strcat(string, "{ff8000}/Congelar [ID]\t{ffffff}Para congelar um(a) jogador(a).\n");
				strcat(string, "{ff8000}/Descongelar [ID]\t{ffffff}Para descongelar um(a) jogador(a).\n");
				strcat(string, "{ff8000}/TrabalharAdm\t{ffffff}Para entrar no Modo Admin.\n");
				strcat(string, "{ff8000}/RVeh\t{ffffff}Para reparar o veículo que está usando.\n");
				strcat(string, "{ff8000}/Atividade\t{ffffff}Para ver seu tempo total de administração.\n");
				strcat(string, "{ff8000}/PM [ID] [Mensagem]\t{ffffff}Para enviar uma mensagem privada para algum(a) jogador(a).\n");
				strcat(string, "{ff8000}/BPM\t{ffffff}Para bloquear e desbloquear suas mensagens privadas.\n");
				strcat(string, "{ff8000}/Interiores\t{ffffff}Para ver a lista de interiores do servidor.\n");
				strcat(string, "{ff8000}/GodMod\t{ffffff}Para ficar com a vida infinita.\n");
				strcat(string, "{ff8000}/GodCar\t{ffffff}Para deixar seu veículo indestrutivel.\n");
				strcat(string, "{ff8000}/Espiar [ID]\t{ffffff}Para espiar um(a) jogador(a).\n");
				strcat(string, "{ff8000}/EspiarOff\t{ffffff}Para parar de espiar algum(a) jogador(a).\n");
				strcat(string, "{ff8000}/Mutar [ID] [Motivo]\t{ffffff}Para mutar um(a) jogador(a) no servidor.\n");
				strcat(string, "{ff8000}/Desmutar [ID]\t{ffffff}Para desmutar um(a) jogador(a) no servidor.\n");
				strcat(string, "{ff8000}/Cadeia [ID] [Tempo] [Motivo]\t{ffffff}Para prender algum(a) jogador(a) na cadeia administrativa.\n");
				strcat(string, "{ff8000}/Liberar [ID] [Motivo]\t{ffffff}Para soltar algum(a) jogador(a) da cadeia administrativa.\n");
				strcat(string, "{ff8000}/Kick [ID] [Motivo]\t{ffffff}Para kickar um(a) jogador(a) do servidor.\n");
				strcat(string, "{ff8000}/Aviso [ID] [Motivo]\t{ffffff}Para avisar um(a) jogador(a).\n");
				strcat(string, "{ff8000}/RetirarAviso [ID] [Quantia]\t{ffffff}Para retirar avisos de um(a) jogador(a).\n");
				strcat(string, "{ff8000}/Vida [ID] [Quantia]\t{ffffff}Para setar vida para algum(a) jogador(a).\n");
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
				strcat(string, "{ff8000}/Skins\t{ffffff}Para ver todas as skins do servidor.\n");
				strcat(string, "{ff8000}/Armas\t{ffffff}Para ver todas as armas do servidor.\n");
				strcat(string, "{ff8000}/Cnnlista\t{ffffff}Para ver os auxilios de CNN Disponíveis.\n");
				strcat(string, "{ff8000}/Contar [SEGUNDOS]\t{ffffff}Para iniciar uma contagem na tela.\n");
				strcat(string, "{ff8000}/CorNick [Código-Html]\t{ffffff}Para trocar a cor de seu nick.\n");
				strcat(string, "{ff8000}/Tempo [tempoid]\t{ffffff}Para mudar o clima do servidor.\n");
				strcat(string, "{ff8000}/players\t{ffffff}Para ver os players online.\n");
				strcat(string, "{ff8000}/desarmar [ID]\t{ffffff}Para desarmar um jogador(a).\n");
				strcat(string, "{ff8000}/Proximos\t{ffffff}Para ver os jogadores próximos a você.\n");
				strcat(string, "{ff8000}/Novatos\t{ffffff}Para ver os jogadores novatos do servidor.\n");
				strcat(string, "{ff8000}/LimparChat\t{ffffff}Para limpar o chat log do servidor.\n");
				strcat(string, "{ff8000}/Tapa [ID]\t{ffffff}Para dar um tapa em um jogador(a).\n");
				strcat(string, "{ff8000}/RV\t{ffffff}Para respawnar um veículo.\n");
				
				ShowPlayerDialog(playerid, DIALOG_MSG, DIALOG_STYLE_TABLIST, "Comandos Admin - Ajudante", string, "Selecionar", "Cancelar");
			}
			case 1: // Comandos Moderador
			{
				new string[1600];
				strcat(string, "{ff8000}/TempBan [ID] [Motivo] [TEMPO]\t{ffffff}Para banir um(a) jogador(a) temporário do servidor.\n");
				strcat(string, "{ff8000}/Ban [ID] [Motivo]\t{ffffff}Para banir um(a) jogador(a) online no servidor.\n");
				strcat(string, "{ff8000}/BanConta [Nick] [Motivo]\t{ffffff}Para banir um(a) jogador(a) offline no servidor.\n");
				strcat(string, "{ff8000}/BanIP [IP] [Motivo]\t{ffffff}Para banir um IP do servidor.\n");
				strcat(string, "{ff8000}/VerIP [ID]\t{ffffff}Para ver o IP de algum(a) jogador(a).\n");
				strcat(string, "{ff8000}/SetarSkin [ID] [ID da Skin]\t{ffffff}Para setar skin para algum(a) jogador(a).\n");
				strcat(string, "{ff8000}/SetarColete [ID] [Quantia]\t{ffffff}Para setar colete para algum(a) jogador(a).\n");
				strcat(string, "{ff8000}/AgendarPrisao [Nick] [Tempo] [Motivo]\t{ffffff}Para prender um(a) jogador(a) offline na cadeia administrativa.\n");
				strcat(string, "{ff8000}/RVS\t{ffffff}Para respawnar todos os veículos sem uso.\n");
				strcat(string, "{ff8000}/Estrelas\t{ffffff}Para colocar estrelas de procurado em um jogador(a).\n");
				strcat(string, "{ff8000}/RemoverEstrelas\t{ffffff}Para remover estrelas de procurado de um jogador(a).\n");
				strcat(string, "{ff8000}/Desarmartodos\t{ffffff}Para desarmar todos do servidor.\n");
				strcat(string, "{ff8000}/SetarHabilitacao\t{ffffff}Para setar habilitações a um jogador(a).\n");
			
				ShowPlayerDialog(playerid, DIALOG_MSG, DIALOG_STYLE_TABLIST, "Comandos Admin - Moderador(a)", string, "Selecionar", "Cancelar");
			}
			case 2: // Comandos Administrador
			{
				new string[1500];
				strcat(string, "{ff8000}/Explodir [ID]\t{ffffff}Para explodir algum(a) jogador(a).\n");
				strcat(string, "{ff8000}/SetarVIP [ID] [Dias]\t{ffffff}Para setar VIP para algum(a) jogador(a).\n");
				strcat(string, "{ff8000}/Desban [Nick]\t{ffffff}Para desbanir um(a) jogador(a) do servidor.\n");
				strcat(string, "{ff8000}/DesbanIP [IP]\t{ffffff}Para desbanir um IP do servidor.\n");
				strcat(string, "{ff8000}/DarGrana [ID] [Quantia]\t{ffffff}Para dar dinheiro para algum(a) jogador(a).\n");
				strcat(string, "{ff8000}/RemoverGrana [ID]\t{ffffff}Para retirar todo o dinheiro de um jogador(a).\n");
				strcat(string, "{ff8000}/ResetarGrana [ID] [Quantia]\t{ffffff}Para resetar o dinheiro em mãos de algum(a) jogador(a).\n");
				strcat(string, "{ff8000}/DarArma [ID] [ID da Arma] [Munição]\t{ffffff}Para dar arma para algum(a) jogador(a).\n");
				strcat(string, "{ff8000}/IrEmpresa [ID da Empresa]\t{ffffff}Para ir até alguma empresa.\n");
				strcat(string, "{ff8000}/IrCasa [ID da Casa]\t{ffffff}Para ir até alguma casa.\n");
				strcat(string, "{ff8000}/IrGaragem [ID da Casa]\t{ffffff}Para ir até alguma garagem.\n");
				strcat(string, "{ff8000}/PagarEvento [ID] [Quantia]\t{ffffff}Para pagar o prêmio de um evento para um(a) jogador(a).\n");
				strcat(string, "{ff8000}/ResetarSaldo [ID]\t{ffffff}Para resetar o saldo bancário de um jogador(a).\n");
				strcat(string, "{ff8000}/SetarSaldo [ID]\t{ffffff}Para setar saldo bancário a um jogador(a).\n");
				strcat(string, "{ff8000}/Profissoes\t{ffffff}Para ver os IDS das Profissões.\n");
				strcat(string, "{ff8000}/SetarProf [ID] [ID da Profissão]\t{ffffff}Para setar uma profissão ao jogador(a).\n");
			
				ShowPlayerDialog(playerid, DIALOG_MSG, DIALOG_STYLE_TABLIST, "Comandos Admin - Administrador(a)", string, "Selecionar", "Cancelar");
			}
			case 3: // Comandos Diretor(a)
			{
				new string[800];
				strcat(string, "{ff8000}/FakeCmd [ID] [Comando]\t{ffffff}Para forçar algum(a) jogador(a) a usar um comando.\n");
				strcat(string, "{ff8000}/JogadorInfo [ID]\t{ffffff}Para ver as informações de algum(a) jogador(a).\n");
				strcat(string, "{ff8000}/SetarVIPTodos [Dias]\t{ffffff}Para setar VIP para todos(as) os(as) jogadores(as) online no servidor.\n");
				strcat(string, "{ff8000}/SetarNivel [ID] [Quantia]\t{ffffff}Para setar nível para algum(a) jogador(a).\n");
			
				ShowPlayerDialog(playerid, DIALOG_MSG, DIALOG_STYLE_TABLIST, "Comandos Admin - Diretor(a)", string, "Selecionar", "Cancelar");
			}
			case 4: // Comandos Desenvolvedor(a)
			{
				new string[1000];
				strcat(string, "{ff8000}/Exit\t{ffffff}Para desligar o servidor.\n");
				strcat(string, "{ff8000}/GMX\t{ffffff}Para reiniciar o servidor.\n");
				strcat(string, "{ff8000}/DarBitCoins [ID] [Quantia]\t{ffffff}Para dar BitCoins para algum(a) jogador(a).\n");
				strcat(string, "{ff8000}/FecharServidor [Senha]\t{ffffff}Para trancar o servidor com senha para o público.\n");
				strcat(string, "{ff8000}/AbrirServidor\t{ffffff}Para destrancar o servidor para o público.\n");
				strcat(string, "{ff8000}/DarAdmin [ID] [level]\t{ffffff}Para setar um level de administração a um jogador(a) (0 para retirar).\n");
			}
		}
		return 1;
	}
	return 1;
}*/

Dialog:EditarRota(playerid, response, listitem, inputtext[])
{
	if(!response) return callcmd::editarrota(playerid, "");
    new str[1000], Cache:qr, Query[128];
    switch(listitem) {
        case 0: ShowPlayerDialog(playerid, RotaNome, DIALOG_STYLE_INPUT, "{FF0000}# {FFFFFF}Alterar nome da rota:", "Insira o novo nome da rota", "Ok", "Cancelar"); // Editar nome
        case 1: ShowPlayerDialog(playerid, ApagarRota, DIALOG_STYLE_MSGBOX, "{FF0000}# {FFFFFF}Você tem certeza?", "Você realmente deseja apagar esta rota?\nOBS: Os locais de carregamento e descarregamento não serão apagados!", "Sim", "Não"); // apagar
        case 2: ShowPlayerDialog(playerid, RotaValor, DIALOG_STYLE_INPUT, "{FF0000}# {FFFFFF}Valor da ROTA", "Insira o novo valor da rota:", "Ok", "Cancelar"); // editar valor
        case 3: { // adicionar carregamentos
            SetPVarInt(playerid, "rotas_locais_pag", 0);
            qr = mysql_query(getConexao(),  "SELECT nome FROM rotas_locais ORDER BY id ASC LIMIT 0,40", true);
            if(cache_num_rows() > 0) {
                new NomeLocal[64];
                for(new i; i < cache_num_rows(); i++) {
                    cache_get_value_name(i, "nome", NomeLocal, 64);
                    format(str, sizeof(str), "%s%s\n", str, NomeLocal);
                }
                if(cache_num_rows() >= 40)
                    strcat(str, "\n{FFFF00}Próxima Página");
                ShowPlayerDialog(playerid, RotaAddCarregamento, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Adicionar Carregamento", str, "Selecionar", "Cancelar");
            }
            cache_delete(qr);
        }
        case 4: { // adicionar descarregamentos
            SetPVarInt(playerid, "rotas_locais_pag", 0);
            qr = mysql_query(getConexao(),  "SELECT nome FROM rotas_locais ORDER BY id ASC LIMIT 0,40", true);
            if(cache_num_rows() > 0) {
                new NomeLocal[64];
                for(new i; i < cache_num_rows(); i++) {
                    cache_get_value_name(i, "nome", NomeLocal, 64);
                    format(str, sizeof(str), "%s%s\n", str, NomeLocal);
                }
                if(cache_num_rows() >= 40)
                    strcat(str, "\n{FFFF00}Próxima Página");
                ShowPlayerDialog(playerid, RotaAddDescarregamento, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Adicionar Descarregamento", str, "Selecionar", "Cancelar");
            }
            cache_delete(qr);
        }
        case 5: { // retirar carregamento
            new Ca[150], Carregamentos[75], NomeLocal[64];
            mysql_format(getConexao(), Query, sizeof(Query), "SELECT carregamentos FROM rotas WHERE id=%i", GetPVarInt(playerid, "edit_rota"));
            qr = mysql_query(getConexao(), Query, true);
            cache_get_value_name(0, "carregamentos", Ca, 150);
            unformat(Ca, "p<|>a<i>[75]", Carregamentos);
            cache_delete(qr);
            for(new i; i < sizeof(Carregamentos); i++) {
                if(Carregamentos[i] == 0) continue;
                mysql_format(getConexao(), Query, sizeof(Query), "SELECT nome FROM rotas_locais WHERE id=%i", Carregamentos[i]);
                qr = mysql_query(getConexao(), Query, true);
                if(cache_num_rows() > 0) {
                    cache_get_value_name(0, "nome", NomeLocal, 64);
                    format(str, sizeof(str), "%s%s\n", str, NomeLocal);
                }
                cache_delete(qr);
            }
            ShowPlayerDialog(playerid, RotaDelCarregamento, DIALOG_STYLE_LIST, "{FF0000}# {FFFFFF}Retirar carregamento", str, "Selecionar", "Cancelar");
        }
        case 6: { // retirar descarregamento
            new De[150], Descarregamentos[75], NomeLocal[64];
            mysql_format(getConexao(), Query, sizeof(Query), "SELECT descarregamentos FROM rotas WHERE id=%i", GetPVarInt(playerid, "edit_rota"));
            qr = mysql_query(getConexao(), Query, true);
            cache_get_value_name(0, "descarregamentos", De, 150);
            unformat(De, "p<|>a<i>[75]", Descarregamentos);
            cache_delete(qr);
            for(new i; i < sizeof(Descarregamentos); i++) {
                if(Descarregamentos[i] == 0) continue;
                mysql_format(getConexao(), Query, sizeof(Query), "SELECT nome FROM rotas_locais WHERE id=%i", Descarregamentos[i]);
                qr = mysql_query(getConexao(), Query, true);
                if(cache_num_rows() > 0) {
                    cache_get_value_name(0, "nome", NomeLocal, 64);
                    format(str, sizeof(str), "%s%s\n", str, NomeLocal);
                }
                cache_delete(qr);
            }
            ShowPlayerDialog(playerid, RotaDelDescarregamento, DIALOG_STYLE_LIST, "{FF0000}# {FFFFFF}Retirar descarregamento", str, "Selecionar", "Cancelar");
        }
        case 7: ShowPlayerDialog(playerid, RotaMafia, DIALOG_STYLE_TABLIST_HEADERS, "{FFFF00}# {FFFFFF}Interesse de mafia:", "Esta rota é de interesse de mafia?\nNão\nSim", "Ok", "Cancelar");// interesse de mafia
        case 8: ShowPlayerDialog(playerid, RotaTipoVeiculo, DIALOG_STYLE_TABLIST_HEADERS, "{FF0000}# {FFFFFF}Tipo de Veiculo:", "Qual tipo de veiculo é necessário para usar esta rota?\nCaminhão com trailer de minério\nCaminhão com trailer de fluídos\nCaminhão com trailer baú\nCaminhão de Cimento\nCaminhão comum\nAviões\nHelicópteros\nVeículos de Mafia\nBarcos", "Selecionar", "Cancelar");
    }
	return 1;
}

Dialog:ApagarRota(playerid, response, listitem, inputtext[])
{
	if(!response) return ShowPlayerDialog(playerid,EditarRota, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Editando Rota", "Editar nome\nApagar rota\nEditar valor da rota\nAdicionar Carregamentos\nAdicionar Descarregamentos\nRetirar algum carregamento\nRetirar algum descarregamento\nRota de interesse de mafia\nTipo de Veiculo\n", "Selecionar", "Cancelar");
    new Query[128], Msg[144];
    mysql_format(getConexao(), Query, sizeof(Query), "DELETE FROM rotas WHERE id=%i", GetPVarInt(playerid, "edit_rota"));
    mysql_query(getConexao(), Query, false);
    format(Msg, sizeof(Msg), "Apagou a rota %i", GetPVarInt(playerid, "edit_rota"));
    RegistrarAtividade_Admin(Jogador[playerid][PlayerID], "Rota", Msg);
    DeletePVar(playerid, "edit_rota");
    return SendClientMessage(playerid, -1, "{FFFF00}Rota apagada com sucesso!");
}

Dialog:RotaNome(playerid, response, listitem, inputtext[]){
	if(!response) return ShowPlayerDialog(playerid,EditarRota, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Editando Rota", "Editar nome\nApagar rota\nEditar valor da rota\nAdicionar Carregamentos\nAdicionar Descarregamentos\nRetirar algum carregamento\nRetirar algum descarregamento\nRota de interesse de mafia\nTipo de Veiculo\n", "Selecionar", "Cancelar");
    new Query[200], Msg[144];
    mysql_format(getConexao(), Query, sizeof(Query), "UPDATE rotas SET produto='%e' WHERE id=%i", inputtext, GetPVarInt(playerid, "edit_rota"));
    mysql_query(getConexao(), Query, false);
    format(Msg, 144, "{FFFF00}Nome da rota alterado para %s", inputtext);
    SendClientMessage(playerid, -1, Msg);
    format(Msg, sizeof(Msg), "Nome da rota %i alterado para %s", GetPVarInt(playerid, "edit_rota"), inputtext);
    RegistrarAtividade_Admin(Jogador[playerid][PlayerID], "Rota", Msg);
    return ShowPlayerDialog(playerid,EditarRota, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Editando Rota", "Editar nome\nApagar rota\nEditar valor da rota\nAdicionar Carregamentos\nAdicionar Descarregamentos\nRetirar algum carregamento\nRetirar algum descarregamento\nRota de interesse de mafia\nTipo de Veiculo\n", "Selecionar", "Cancelar");
}

Dialog:RotaMafia(playerid, response, listitem, inputtext[]){
	if(!response) return ShowPlayerDialog(playerid,EditarRota, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Editando Rota", "Editar nome\nApagar rota\nEditar valor da rota\nAdicionar Carregamentos\nAdicionar Descarregamentos\nRetirar algum carregamento\nRetirar algum descarregamento\nRota de interesse de mafia\nTipo de Veiculo\n", "Selecionar", "Cancelar");
	new Query[200];
	mysql_format(getConexao(), Query, sizeof(Query), "UPDATE rotas SET mafia='%i' WHERE id=%i", listitem, GetPVarInt(playerid, "edit_rota"));
	mysql_query(getConexao(), Query, false);
	SendClientMessage(playerid, -1, (listitem == 0 ? ("{FFFF00}Esta rota não é de interesse de mafia") : ("{FFFF00}Esta rota é de interesse de mafia")));
	return ShowPlayerDialog(playerid,EditarRota, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Editando Rota", "Editar nome\nApagar rota\nEditar valor da rota\nAdicionar Carregamentos\nAdicionar Descarregamentos\nRetirar algum carregamento\nRetirar algum descarregamento\nRota de interesse de mafia\nTipo de Veiculo\n", "Selecionar", "Cancelar");
}


Dialog:RotaValor(playerid, response, listitem, inputtext[]){
	if(!response) return ShowPlayerDialog(playerid, EditarRota, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Editando Rota", "Editar nome\nApagar rota\nEditar valor da rota\nAdicionar Carregamentos\nAdicionar Descarregamentos\nRetirar algum carregamento\nRetirar algum descarregamento\nRota de interesse de mafia\nTipo de Veiculo\n", "Selecionar", "Cancelar");
	new Query[200], Msg[144];
	mysql_format(getConexao(), Query, sizeof(Query), "UPDATE rotas SET valor='%f' WHERE id=%i", floatstr(inputtext), GetPVarInt(playerid, "edit_rota"));
	mysql_query(getConexao(), Query, false);
	format(Msg, 144, "{FFFF00}Valor da rota: %f", floatstr(inputtext));
	SendClientMessage(playerid, -1, Msg);
	//format(Msg, sizeof(Msg), "Valor da rota %i para %1.2f editada", GetPVarInt(playerid, "edit_rota"), floatstr(inputtext));
	//RegistrarAtividade_Admin(Jogador[playerid][PlayerID], "Rota", Msg);
	return ShowPlayerDialog(playerid,EditarRota, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Editando Rota", "Editar nome\nApagar rota\nEditar valor da rota\nAdicionar Carregamentos\nAdicionar Descarregamentos\nRetirar algum carregamento\nRetirar algum descarregamento\nRota de interesse de mafia\nTipo de Veiculo\n", "Selecionar", "Cancelar");
}


Dialog:RotaTipoVeiculo(playerid, response, listitem, inputtext[]){
	if(!response) return ShowPlayerDialog(playerid,EditarRota, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Editando Rota", "Editar nome\nApagar rota\nEditar valor da rota\nAdicionar Carregamentos\nAdicionar Descarregamentos\nRetirar algum carregamento\nRetirar algum descarregamento\nRota de interesse de mafia\nTipo de Veiculo\n", "Selecionar", "Cancelar");
	new PCV_R = (listitem + 1), Query[128];//, Msg[144];
	mysql_format(getConexao(), Query, sizeof(Query), "UPDATE rotas SET carga=%i WHERE id=%i", PCV_R, GetPVarInt(playerid, "edit_rota"));
	mysql_query(getConexao(), Query, false);
	SendClientMessage(playerid, -1, "{FFFF00}Tipo de veículo alterado.");
	//format(Msg, sizeof(Msg), "Tipo de veiculo da rota %i alterado", GetPVarInt(playerid, "edit_rota"));
	//RegistrarAtividade_Admin(Jogador[playerid][PlayerID], "Rota", Msg);
	return ShowPlayerDialog(playerid,EditarRota, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Editando Rota", "Editar nome\nApagar rota\nEditar valor da rota\nAdicionar Carregamentos\nAdicionar Descarregamentos\nRetirar algum carregamento\nRetirar algum descarregamento\nRota de interesse de mafia\nTipo de Veiculo\n", "Selecionar", "Cancelar");
}

Dialog:RotaAddCarregamento(playerid, response, listitem, inputtext[]){
	if(!response) return ShowPlayerDialog(playerid,EditarRota, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Editando Rota", "Editar nome\nApagar rota\nEditar valor da rota\nAdicionar Carregamentos\nAdicionar Descarregamentos\nRetirar algum carregamento\nRetirar algum descarregamento\nRota de interesse de mafia\nTipo de Veiculo\n", "Selecionar", "Cancelar");
    new Query[260], Cache:qr, str[1000], Ca[150], De[150], Carregamentos[75], Descarregamentos[75];
    if(listitem >= 40) {
        SetPVarInt(playerid, "rotas_locais_pag", GetPVarInt(playerid, "rotas_locais_pag") + 40);
        mysql_format(getConexao(), Query, sizeof(Query), "SELECT nome FROM rotas_locais ORDER BY id ASC LIMIT %i,40", GetPVarInt(playerid, "rotas_locais_pag"));
        qr = mysql_query(getConexao(), Query, true);
        if(cache_num_rows() > 0) {
            new NomeLocal[64];
            for(new i; i < cache_num_rows(); i++) {
                cache_get_value_name(i, "nome", NomeLocal, 64);
                format(str, sizeof(str), "%s%s\n", str, NomeLocal);
            }
            if(cache_num_rows() >= 40)
                strcat(str, "\nPróxima Página");
            ShowPlayerDialog(playerid, RotaAddCarregamento, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Adicionar Carregamento", str, "Selecionar", "Cancelar");
        }
        return cache_delete(qr);
    }
    mysql_format(getConexao(), Query, sizeof(Query), "SELECT carregamentos,descarregamentos FROM rotas WHERE id=%i", GetPVarInt(playerid, "edit_rota"));
    qr = mysql_query(getConexao(), Query, true);
    cache_get_value_name(0, "carregamentos", Ca, 150);
    unformat(Ca, "p<|>a<i>[75]", Carregamentos);
    cache_get_value_name(0, "descarregamentos", De, 150);
    unformat(De, "p<|>a<i>[75]", Descarregamentos);
    cache_delete(qr);

    mysql_format(getConexao(), Query, sizeof(Query), "SELECT id,nome FROM rotas_locais ORDER BY id ASC LIMIT %i,40", GetPVarInt(playerid, "rotas_locais_pag"));
    qr = mysql_query(getConexao(), Query, true);
    if(cache_num_rows() > 0 && listitem < cache_num_rows()) {
        new id, LocalNome[64], bool:add = true, Msg[144];
        cache_get_value_name_int(listitem, "id", id);
        cache_get_value_name(listitem, "nome", LocalNome, 64);
        for(new i; i < 75; i++) {
            if(id == Carregamentos[i]) { add = false; break; }
            if(id == Descarregamentos[i]) { add = false; break; }
        }
        if(add == true) { // pode adicionar
            for(new i; i < 75; i++)
                if(Carregamentos[i] == 0) {
                    Carregamentos[i] = id;
                    break;
                }
            strdel(Query, 0, sizeof(Query));
            for(new i; i < 75; i++) {
                if(Carregamentos[i] != 0)
                    format(Query, sizeof(Query), "%s%i|",Query,Carregamentos[i]);
            }
            mysql_format(getConexao(), Query, sizeof(Query), "UPDATE rotas SET carregamentos='%s' WHERE id=%i", Query, GetPVarInt(playerid, "edit_rota"));
            mysql_query(getConexao(), Query, false);
            format(Msg, 144, "{FFFF00}Novo local de carregamento adicionado: %s", LocalNome);
            SendClientMessage(playerid, -1, Msg);
            //format(Msg, sizeof(Msg), "Rota %i editada (carregamento adc: %s)", GetPVarInt(playerid, "edit_rota"), LocalNome);
            //RegistrarAtividade_Admin(Jogador[playerid][PlayerID], "Rota", Msg);
        }
        else
            SendClientMessage(playerid, -1, "{FF0000}Este local não pode ser adicionado, pois já é um carregamento/descarregamento!");
    }
    cache_delete(qr);
    return ShowPlayerDialog(playerid,EditarRota, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Editando Rota", "Editar nome\nApagar rota\nEditar valor da rota\nAdicionar Carregamentos\nAdicionar Descarregamentos\nRetirar algum carregamento\nRetirar algum descarregamento\nRota de interesse de mafia\nTipo de Veiculo\n", "Selecionar", "Cancelar");
}

Dialog:RotaAddDescarregamento(playerid, response, listitem, inputtext[]){
	if(!response) return ShowPlayerDialog(playerid,EditarRota, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Editando Rota", "Editar nome\nApagar rota\nEditar valor da rota\nAdicionar Carregamentos\nAdicionar Descarregamentos\nRetirar algum carregamento\nRetirar algum descarregamento\nRota de interesse de mafia\nTipo de Veiculo\n", "Selecionar", "Cancelar");
	new Query[260], Cache:qr, str[1000], Ca[150], De[150], Carregamentos[75], Descarregamentos[75];
	if(listitem >= 40) {
	    SetPVarInt(playerid, "rotas_locais_pag", GetPVarInt(playerid, "rotas_locais_pag") + 40);
	    mysql_format(getConexao(), Query, sizeof(Query), "SELECT nome FROM rotas_locais ORDER BY id ASC LIMIT %i,40", GetPVarInt(playerid, "rotas_locais_pag"));
	    qr = mysql_query(getConexao(), Query, true);
	    if(cache_num_rows() > 0) {
	        new NomeLocal[64];
	        for(new i; i < cache_num_rows(); i++) {
	            cache_get_value_name(i, "nome", NomeLocal, 64);
	            format(str, sizeof(str), "%s%s\n", str, NomeLocal);
	        }
	        if(cache_num_rows() >= 40)
	            strcat(str, "\nPróxima Página");
	        ShowPlayerDialog(playerid, RotaAddDescarregamento, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Adicionar Descarregamento", str, "Selecionar", "Cancelar");
	    }
	    return cache_delete(qr);
	}
	mysql_format(getConexao(), Query, sizeof(Query), "SELECT carregamentos,descarregamentos FROM rotas WHERE id=%i", GetPVarInt(playerid, "edit_rota"));
	qr = mysql_query(getConexao(), Query, true);
	cache_get_value_name(0, "carregamentos", Ca, 150);
	unformat(Ca, "p<|>a<i>[75]", Carregamentos);
	cache_get_value_name(0, "descarregamentos", De,150);
	unformat(De, "p<|>a<i>[75]", Descarregamentos);
	cache_delete(qr);

	mysql_format(getConexao(), Query, sizeof(Query), "SELECT id,nome FROM rotas_locais ORDER BY id ASC LIMIT %i,40", GetPVarInt(playerid, "rotas_locais_pag"));
	qr = mysql_query(getConexao(), Query, true);
	if(cache_num_rows() > 0 && listitem < cache_num_rows()) {
	    new LocalNome[64], bool:add = true, Msg[144], id;
	    cache_get_value_int(listitem, "id", id);
	    cache_get_value_name(listitem, "nome", LocalNome, 64);
	    for(new i; i < 75; i++) {
	        if(id == Carregamentos[i]) { add = false; break; }
	        if(id == Descarregamentos[i]) { add = false; break; }
	    }
	    if(add == true) { // pode adicionar
	        for(new i; i < 75; i++)
	            if(Descarregamentos[i] == 0) {
	                Descarregamentos[i] = id;
	                break;
	            }
	        strdel(Query, 0, sizeof(Query));
	        for(new i; i < 75; i++)   {
	            if(Descarregamentos[i] != 0)
	                format(Query, sizeof(Query), "%s%i|",Query,Descarregamentos[i]);
	        }
	        mysql_format(getConexao(), Query, sizeof(Query), "UPDATE rotas SET descarregamentos='%s' WHERE id=%i", Query, GetPVarInt(playerid, "edit_rota"));
	        mysql_query(getConexao(), Query, false);
	        format(Msg, 144, "{FFFF00}Novo local de descarregamento adicionado: %s", LocalNome);
	        SendClientMessage(playerid, -1, Msg);
	        //format(Msg, sizeof(Msg), "Rota %i editada (descarregamento adc: %s)", GetPVarInt(playerid, "edit_rota"), LocalNome);
	        //RegistrarAtividade_Admin(Jogador[playerid][PlayerID], "Rota", Msg);
	    }
	    else
	        SendClientMessage(playerid, -1, "{FF0000}Este local não pode ser adicionado, pois já é um carregamento/descarregamento!");
	}
	cache_delete(qr);
	return ShowPlayerDialog(playerid,EditarRota, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Editando Rota", "Editar nome\nApagar rota\nEditar valor da rota\nAdicionar Carregamentos\nAdicionar Descarregamentos\nRetirar algum carregamento\nRetirar algum descarregamento\nRota de interesse de mafia\nTipo de Veiculo\n", "Selecionar", "Cancelar");
}

Dialog:RotaDelCarregamento(playerid, response, listitem, inputtext[]){
	if(!response) return ShowPlayerDialog(playerid,EditarRota, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Editando Rota", "Editar nome\nApagar rota\nEditar valor da rota\nAdicionar Carregamentos\nAdicionar Descarregamentos\nRetirar algum carregamento\nRetirar algum descarregamento\nRota de interesse de mafia\nTipo de Veiculo\n", "Selecionar", "Cancelar");
    new Query[260], Cache:qq, Ca[150], Carregamentos[75], Count; // Msg[144],
    mysql_format(getConexao(), Query, sizeof(Query), "SELECT carregamentos FROM rotas WHERE id=%i", GetPVarInt(playerid, "edit_rota"));
    qq = mysql_query(getConexao(), Query, true);
    cache_get_value_name(0, "carregamentos", Ca, 150);
    unformat(Ca, "p<|>a<i>[75]", Carregamentos);
    cache_delete(qq);

    for(new i; i < 75; i++) {
        if(Carregamentos[i] == 0) continue;
        if(listitem == Count) {
            Carregamentos[i] = 0;
            break;
        }
        Count++;
    }
    strdel(Query, 0, sizeof(Query));
    for(new i; i < 75; i++)
        if(Carregamentos[i] != 0)
            format(Query, sizeof(Query), "%s%i|", Query, Carregamentos[i]);
    mysql_format(getConexao(), Query, sizeof(Query), "UPDATE rotas SET carregamentos='%s' WHERE id=%i", Query, GetPVarInt(playerid, "edit_rota"));
    mysql_query(getConexao(), Query, false);
    //format(Msg, sizeof(Msg), "Rota %i editada (carregamento removido)", GetPVarInt(playerid, "edit_rota"));
    //RegistrarAtividade_Admin(Jogador[playerid][PlayerID], "Rota", Msg);
    SendClientMessage(playerid, -1, "{FFFF00}Local de carregamento removido.");
    return ShowPlayerDialog(playerid,EditarRota, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Editando Rota", "Editar nome\nApagar rota\nEditar valor da rota\nAdicionar Carregamentos\nAdicionar Descarregamentos\nRetirar algum carregamento\nRetirar algum descarregamento\nRota de interesse de mafia\nTipo de Veiculo\n", "Selecionar", "Cancelar");
}

Dialog:RotaDelDescarregamento(playerid, response, listitem, inputtext[]){
	if(!response) return ShowPlayerDialog(playerid,EditarRota, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Editando Rota", "Editar nome\nApagar rota\nEditar valor da rota\nAdicionar Carregamentos\nAdicionar Descarregamentos\nRetirar algum carregamento\nRetirar algum descarregamento\nRota de interesse de mafia\nTipo de Veiculo\n", "Selecionar", "Cancelar");
	new Query[260], Cache:qq, De[150], Descarregamentos[75], Count; //Msg[144],
	mysql_format(getConexao(), Query, sizeof(Query), "SELECT descarregamentos FROM rotas WHERE id=%i", GetPVarInt(playerid, "edit_rota"));
	qq = mysql_query(getConexao(), Query, true);
	cache_get_value_name(0, "descarregamentos", De, 150);
	unformat(De, "p<|>a<i>[75]", Descarregamentos);
	cache_delete(qq);
	
	for(new i; i < 75; i++) {
	    if(Descarregamentos[i] == 0) continue;
	    if(listitem == Count) {
	        Descarregamentos[i] = 0;
	        break;
	    }
	    Count++;
	}
	strdel(Query, 0, sizeof(Query));
	for(new i; i < 75; i++)
	    if(Descarregamentos[i] != 0)
	        format(Query, sizeof(Query), "%s%i|", Query, Descarregamentos[i]);
	mysql_format(getConexao(), Query, sizeof(Query), "UPDATE rotas SET descarregamentos='%s' WHERE id=%i", Query, GetPVarInt(playerid, "edit_rota"));
	mysql_query(getConexao(), Query, false);
	//format(Msg, sizeof(Msg), "Rota %i editada (descarregamento removido)", GetPVarInt(playerid, "edit_rota"));
	//RegistrarAtividade_Admin(Jogador[playerid][PlayerID], "Rota", Msg);
	SendClientMessage(playerid, -1, "{FFFF00}Local de descarregamento removido.");
	return ShowPlayerDialog(playerid,EditarRota, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Editando Rota", "Editar nome\nApagar rota\nEditar valor da rota\nAdicionar Carregamentos\nAdicionar Descarregamentos\nRetirar algum carregamento\nRetirar algum descarregamento\nRota de interesse de mafia\nTipo de Veiculo\n", "Selecionar", "Cancelar");
}

Dialog:TodasRotas(playerid, response, listitem, inputtext[]){
	if(!response) return 1;
    
    new Cache:qr, top[128], Query[128], id;
    if(listitem >= 25) {
        SetPVarInt(playerid, "rotas_pag", GetPVarInt(playerid, "rotas_pag") + 25);
        return TodasRotas(playerid, GetPVarInt(playerid, "rotas_pag"));
    }
    mysql_format(getConexao(), Query, sizeof(Query), "SELECT id,produto FROM rotas ORDER BY id ASC LIMIT %i,25", GetPVarInt(playerid, "rotas_pag"));
    qr = mysql_query(getConexao(), Query, true);
    new Produto[64];
    cache_get_value_name(listitem, "produto", Produto, 64);
    //SetPVarInt(playerid, "edit_rota", cache_get_field_content_int(listitem, "id", getConexao()));
    //cache_get_value_name_int(listitem, "id", SetPVarInt(playerid, "edit_rota"));
    cache_get_value_name_int(listitem, "id", id);
    SetPVarInt(playerid, "edit_rota", id);
    //SetPVarInt(playerid, "edit_rota", cache_get_field_name_int(listitem, "id", id));
    format(top, sizeof(top), "{FF0000}# {FFFFFF}Rota: %s", Produto);
    ShowPlayerDialog(playerid,EditarRota, DIALOG_STYLE_LIST, top, "Editar nome\nApagar rota\nEditar valor da rota\nAdicionar Carregamentos\nAdicionar Descarregamentos\nRetirar algum carregamento\nRetirar algum descarregamento\nRota de interesse de mafia\nTipo de Veiculo\n", "Selecionar", "Cancelar");
    cache_delete(qr);
	return 1;
}

Dialog:RegAtividades(playerid, response, listitem, inputtext[])
{
	if(!response) return 1;
	if(listitem >= 30) return PaginaAtividades(playerid, (GetPVarInt(playerid, "buscar_reg_pag") + 30), (GetPVarInt(playerid, "buscar_reg") == 1 ? false : true));
    return 1;
}

Dialog:BuscaAtividades(playerid, response, listitem, inputtext[])
{
	if(!response) return 1;
	if(GetPVarInt(playerid, "buscar_reg") != 0) {
        switch(GetPVarInt(playerid, "buscar_reg")) {
            case 1: { // Jogador
                SetPVarString(playerid, "buscar_reg_player", inputtext);
                PaginaAtividades(playerid, 0, false);
            }
            case 2: { // Admin
                SetPVarString(playerid, "buscar_reg_player", inputtext);
                PaginaAtividades(playerid, 0, true);
            }
        }
        return 1;
    }
    switch(listitem) {
        case 0: { // Jogador
            SetPVarInt(playerid, "buscar_reg", 1);
            ShowPlayerDialog(playerid, DialogBuscaAtividades, DIALOG_STYLE_INPUT, "{FFFF00}# {FFFFFF}Registro de Atividades do Jogador", "Digite o nickname do jogador para que possamos verificar o registro de atividades:", "Buscar", "Cancelar");
        }
        case 1: { // Admin
             SetPVarInt(playerid, "buscar_reg", 2);
             ShowPlayerDialog(playerid, DialogBuscaAtividades, DIALOG_STYLE_INPUT, "{FF0000}# {FFFFFF}Registro de Atividades do Administrador", "Digite o nickname do administrador para que possamos verificar os registros:", "Buscar", "Cancelar");
        }
    }
    return 1;
}