// aa
Dialog:PLAYER_AUTH_NICK(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		//CleanChat(playerid);
		if( isnull(inputtext) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa digitar seu nick.");

		if ( !IsValidName(inputtext) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você digitou um nome inválido.");

		format(Jogador[playerid][Nome], MAX_PLAYER_NAME, inputtext);		
		call::TD->UpdateColumm(playerid, 0, inputtext);
		return true;
	}
	return true;
}

Dialog:PLAYER_AUTH_SENHA(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		//CleanChat(playerid);
		if( isnull(inputtext) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa digitar sua senha.");

		format(Jogador[playerid][Senha], MAX_PLAYER_PASSWORD, inputtext);
		
		new senha[14];

		str_replace_to_char(senha, strlen(inputtext), sizeof(senha));

		call::TD->UpdateColumm(playerid, 1, senha);
		return true;
	}
	return true;
}

Dialog:RECOVER_PASSWORD_ACCOUNT(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		if ( isnull(inputtext) || !IsValidEmail(inputtext) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa digitar um email válido.");

		if ( !call::PLAYER->IsEmailRegistered(inputtext) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | O email digitado não foi encontrado em nosso banco de dados.");

		if ( GetPVarInt(playerid, "tmp_recover_password") > 3)
			return SendClientMessage(playerid, COR_ERRO, "| INFO | Você foi kickado por tentar recuperar a senha muitas vezes.");
		
		SetPVarInt(playerid, "tmp_recover_password", GetPVarInt(playerid, "tmp_recover_password") + 1);
		
		new query[MAX_PLAYER_EMAIL + 100], str[128], code[11];

		/**
		*
		*	gerar código aleatório.
		*
		**/
		randomstring(code, sizeof(code)-1);

		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `codigo_recuperacao`='%s' WHERE `email`='%e' LIMIT 1;", code, inputtext);
		
		if ( !mysql_tquery(getConexao(), query) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Houve um erro. Tire um PrintScreen desta mensagem e envie à um memmbro da administração.");

		

		format(Jogador[playerid][Email], MAX_PLAYER_EMAIL, inputtext);

		format(str, sizeof(str), "Seu código de recuperação de senha é <strong>%s</strong>", code);
		SendEmail(SERVER_EMAIL, inputtext, "Recuperação da sua conta", str);

		SendClientMessage(playerid, COR_AZUL, "| INFO | Enviamos para o seu email um código para mudança da sua senha.");
		ShowPlayerDialog(playerid, RECOVER_PASSWORD_CODE, DIALOG_STYLE_INPUT, "DIGITE O CÓDIGO", "{FF0000}Digite o código que você recebeu em seu email.", "Confirmar", "Fechar");
		TempoInativo[playerid] = gettime() + (60 * 10);
		return true;
	}
	return true;
}

Dialog:RECOVER_PASSWORD_CODE(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		if ( isnull(inputtext) || strlen(inputtext) > 10 )
			return ShowPlayerDialog(playerid, RECOVER_PASSWORD_CODE, DIALOG_STYLE_INPUT, "DIGITE O CÓDIGO", "{FF0000}Digite o código que você recebeu em seu email.\n\n{FF0000}* Você digitou um código inválido.", "Confirmar", "Fechar");
		
		new query[MAX_PLAYER_EMAIL + 100];
		mysql_format(getConexao(), query, sizeof(query), "SELECT codigo_recuperacao FROM "TABLE_USERS" WHERE `email`='%e' AND `codigo_recuperacao`='%e' LIMIT 1;", Jogador[playerid][Email], inputtext);
		new Cache:cache = mysql_query(getConexao(), query, true);

		if ( !cache_num_rows() )
			return cache_delete(cache), ShowPlayerDialog(playerid, RECOVER_PASSWORD_CODE, DIALOG_STYLE_INPUT, "DIGITE O CÓDIGO", "{FF0000}Digite o código que você recebeu em seu email.\n\n{FF0000}* Não encontramos o código que você digitou para sua conta.", "Confirmar", "Fechar");
		
		cache_delete(cache);

		ShowPlayerDialog(playerid, CHANGE_PASSWORD, DIALOG_STYLE_INPUT, "DIGITE SUA NOVA SENHA", "{"COR_BRANCO_INC"}Digite sua nova senha\n\n{FF0000}* Atenção: Essa senha ficará visivel na tela para que você veja oque esteja digitando.", "Alterar", "Cancelar");
		return true;
	}
	SendClientMessage(playerid, COR_ERRO, "| INFO | Você cancelou a recuperação de sua conta.");
	return true;
}

//Dialog:CHANGE_PASSWORD(playerid, response, listitem, inputtext[])
//{
//	if ( response )
//	{
//		if(response)
//		{
//			if(strlen(inputtext) > MAX_PLAYER_PASSWORD || strlen(inputtext) < 5)
//				return call::TD->SendTextMessageRegister(playerid, "~r~Você digitou uma senha inválida.Digite uma senha de 5 á "#MAX_PLAYER_PASSWORD#"");
//
//			format(Jogador[playerid][Senha], MAX_PLAYER_PASSWORD, inputtext);
//
//			new query[70 + MAX_PLAYER_EMAIL + MAX_PLAYER_PASSWORD];
//			
//			mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `senha`='%s' WHERE `email`='%e'", Hash(inputtext), Jogador[playerid][Email]);
//			mysql_tquery(getConexao(), query);
//
//			SendClientMessage(playerid, COR_BRANCO, "» Senha alterada com {"COR_VERDE_INC"}sucesso{"COR_BRANCO_INC"}.");
//			return true;
//		}
//	}
//	SendClientMessage(playerid, COR_ERRO, "Você cancelou a recuperação de sua conta.");
//	return true;
//}

Dialog:PLAYER_REGISTER_NICK(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if( !IsValidName(inputtext) )
			return call::TD->SendTextMessageRegister(playerid, "~r~Você digitou um nome inválido.");

		new query[100 + MAX_PLAYER_EMAIL];
		mysql_format(getConexao(), query, sizeof(query), "SELECT `username` FROM "TABLE_USERS" WHERE `username`='%s' LIMIT 1;", inputtext);
		new Cache:cache = mysql_query(getConexao(), query, true), rows = cache_num_rows();
		cache_delete(cache);

		if(rows)
			return call::TD->SendTextMessageRegister(playerid, "~r~Você digitou um nick que já consta em nosso banco de dados.");
			
		format(Jogador[playerid][Nome], MAX_PLAYER_NAME, inputtext);
		call::TD->UpdateTextDrawsRegister(playerid);
		return true;
	}
	return false;
}

Dialog:PLAYER_REGISTER_EMAIL(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(!IsValidEmail(inputtext))
			return call::TD->SendTextMessageRegister(playerid, "~r~Você digitou um email inválido.");

		new query[100 + MAX_PLAYER_EMAIL];
		mysql_format(getConexao(), query, sizeof(query), "SELECT `email` FROM "TABLE_USERS" WHERE `email`='%s' LIMIT 1;", inputtext);
		new Cache:cache = mysql_query(getConexao(), query, true), rows = cache_num_rows();
		cache_delete(cache);

		if(rows)
			return call::TD->SendTextMessageRegister(playerid, "~r~Você digitou um email que já consta em nosso banco de dados.");

		format(Jogador[playerid][Email], MAX_PLAYER_EMAIL, inputtext);
		call::TD->UpdateTextDrawsRegister(playerid);
		return true;
	}
	return true;
}
Dialog:PLAYER_REGISTER_PASSWORD(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(strlen(inputtext) > MAX_PLAYER_PASSWORD || strlen(inputtext) < 4)
			return call::TD->SendTextMessageRegister(playerid, "~r~Você digitou uma senha inválida. Digite uma senha de 4 à "#MAX_PLAYER_PASSWORD#"");

		format(Jogador[playerid][Senha], MAX_PLAYER_PASSWORD, inputtext);
		call::TD->UpdateTextDrawsRegister(playerid);
		return true;
	}
	return true;
}
Dialog:PLAYER_REGISTER_SEXO(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		Jogador[playerid][Sexo] = (!listitem ? SEXO_MASCULINO : SEXO_FEMININO);
		Jogador[playerid][Skin] = (!listitem ? SKIN_MASCULINA : SKIN_FEMININA);
		call::TD->UpdateTextDrawsRegister(playerid);
		return true;
	}
	return true;
}
Dialog:TERM_OF_USE(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		call::TD->ShowPlayerRegister(playerid);
		return true;
	}
	return true;	
}
/**/
Dialog:PLAYER_MENU_AJUDA_R(playerid, response, listitem, inputtext[])
{
	callcmd::ajuda(playerid, "\0");
	return true;
}

Dialog:PLAYER_MENU_AJUDA(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0:// Ajuda Geral
			{
				callcmd::ajuda(playerid, "geral");
				return true;
			}
			case 1: // Ajuda Profissão
			{
				callcmd::profissao(playerid);
				return true;
			}
			case 2: // Ajuda Veiculo
			{
				callcmd::ajuda(playerid, "veiculo");
				return true;
			}
			case 3: // Ajuda Casa
			{
				callcmd::ajuda(playerid, "casa");
				return true;
			}
			case 4: // Ajuda Empresa
			{
				callcmd::ajuda(playerid, "empresa");
				return true;
			}
			case 5: // Ajuda Celular
			{
				callcmd::ajuda(playerid, "celular");
				return true;
			}
			case 6: // Ajuda VIP
			{
				callcmd::ajuda(playerid, "vip");
				return true;
			}
			case 7: // Ajuda contato
			{
				callcmd::ajuda(playerid, "contato");
				return true;
			}			
		}
		return true;
	}
	return true;
}

static Select[MAX_PLAYERS][100];
Dialog:PLAYER_GPS_MENU(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: // Propriedades Públicas
			{
				new info[1024 * 3], Float:x, Float:y, Float:z, count;
				info = "Local\tDistância em Metros\n";
				foreach(new i: Propriedades)
				{
					call::PROPERTY->GetPropertyPos(i, x, y, z);
					format(info, sizeof(info), "%s%s\t%0.1f\n", info, call::PROPERTY->GetPropertyName(i), GetPlayerDistanceFromPoint(playerid, x, y, z));

					Select[playerid][count] = i;
					count++;
				}
				ShowPlayerDialog(playerid, PLAYER_GPS_MENU_PROPERTY, DIALOG_STYLE_TABLIST_HEADERS, "GPS » PROPRIEDADES PÚBLICAS", info, "Marcar", "Voltar");
				return true;
			}
			case 1: // Minha Empresa
			{
				new businessid = call::PLAYER->GetPlayerVarInt(playerid, EmpresaID);
				
				if(businessid == INVALID_BUSINESS_ID)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui uma empresa.");

				static Float:x, Float:y, Float:z;
				call::BUSINESS->GetBusinessPos(businessid, x, y, z);
				call::PLAYER->SetPlayerMarkGPS(playerid, x, y, z);

				SendClientMessage(playerid, COR_AMARELO, "| GPS | Destino: {ffffff}Sua Empresa");
				SendClientMessage(playerid, COR_AMARELO, "| GPS | Distância: {ffffff}%d {"COR_AMARELO_INC"}Metro(s)", floatround(GetPlayerDistanceFromPoint(playerid, x, y, z)) );
				return true;
			}
			case 2: // Minha casa
			{
				new casaid = GetPlayerHouse(playerid);

				if(casaid == INVALID_HOUSE_ID)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui uma casa.");

				static Float:x, Float:y, Float:z;
				call::HOUSE->GetHousePos(casaid, x, y, z);
				call::PLAYER->SetPlayerMarkGPS(playerid, x, y, z);

				SendClientMessage(playerid, COR_AMARELO, "| GPS | Destino: {ffffff}Sua Casa");
				SendClientMessage(playerid, COR_AMARELO, "| GPS | Distância: {ffffff}%d {"COR_AMARELO_INC"}Metro(s)", floatround(GetPlayerDistanceFromPoint(playerid, x, y, z)));
				return true;
			}
			case 3:	// Profissões
			{
				new info[1024 * 3], jobname[50], Float:x, Float:y, Float:z, count;
				info = "Local\tDistância em Metros\n";
				foreach(new i: Profissoes)
				{
					call::JOB->GetJobPos(i, x, y, z);
					call::JOB->GetJobName(i, jobname);
					format(info, sizeof(info), "%s%s\t%0.1f\n", info, jobname, GetPlayerDistanceFromPoint(playerid, x, y, z));

					Select[playerid][count] = i;
					count++;
				}
				ShowPlayerDialog(playerid, PLAYER_GPS_MENU_JOBS, DIALOG_STYLE_TABLIST_HEADERS, "GPS » PROPRIEDADES PROFISSÕES", info, "Marcar", "Voltar");
				return true;
			}
			case 4: // Concessionária
			{
				ShowPlayerDialog(playerid, PLAYER_GPS_MENU_CONCE, DIALOG_STYLE_LIST, "GPS » CONCESSIONÁRIA", 
					"Concessionária de Los Santos\n\
Concessionária de Los Santos ( {"COR_VERMELHO_INC"}veiculos usados{"COR_BRANCO_INC"} )\n\
Concessionária de San Fierro\n\
Concessionária de San Fierro ( {"COR_VERMELHO_INC"}veiculos importados{"COR_BRANCO_INC"} )\n\
Concessionária de Las Venturas\n\
Concessionária de Los Santos ( {"COR_VERMELHO_INC"}Lowriders{"COR_BRANCO_INC"} )\n\
Concessionário de Los Santos ( {"COR_VERMELHO_INC"}Barcos{"COR_BRANCO_INC"} )", "Marcar", "Voltar");
				return true;
			}
			default:
			{
				call::PLAYER->DisablePlayerGPS(playerid);
				DisablePlayerCheckpoint(playerid);
				SendClientMessage(playerid, COR_AMARELO, "| GPS | {"COR_BRANCO_INC"}Desligado.");
				return true;
			}
		}
		return true;
	}
	return true;
}

Dialog:PLAYER_GPS_MENU_PROPERTY(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		static Float:x, Float:y, Float:z;

		new propriedadeid = Select[playerid][listitem];
		Select[playerid][listitem]=0;

		call::PROPERTY->GetPropertyPos(propriedadeid, x,y,z);
		call::PLAYER->SetPlayerMarkGPS(playerid, x, y, z);

		SendClientMessage(playerid, COR_AMARELO, "| GPS | Destino: {ffffff}%s", call::PROPERTY->GetPropertyName(propriedadeid));
		SendClientMessage(playerid, COR_AMARELO, "| GPS | Distância: {ffffff}%d {"COR_AMARELO_INC"}Metro(s)", floatround(GetPlayerDistanceFromPoint(playerid, x, y, z)) );
		return true;
	}
	callcmd::gps(playerid);
	return true;
}

Dialog:PLAYER_GPS_MENU_JOBS(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		static Float:x, Float:y, Float:z;

		new i = Select[playerid][listitem], jobname[50];
		Select[playerid][listitem]=0;
		
		call::JOB->GetJobPos(i, x,y,z);
		call::JOB->GetJobName(i, jobname, sizeof(jobname));
		call::PLAYER->SetPlayerMarkGPS(playerid, x, y, z);

		SendClientMessage(playerid, COR_AMARELO, "| GPS | Destino: {ffffff}%s", jobname);
		SendClientMessage(playerid, COR_AMARELO, "| GPS | Distância: {ffffff}%d {"COR_AMARELO_INC"}Metro(s)", floatround(GetPlayerDistanceFromPoint(playerid, x, y, z)) );
		return true;
	}
	callcmd::gps(playerid);
	return true;
}
#pragma unused Select

Dialog:PLAYER_GPS_MENU_CONCE(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		switch(listitem)
		{
			case 0: // Concessionária de Los Santos
			{
				call::PLAYER->SetPlayerMarkGPS(playerid, 557.0057, -1254.6377, 17.0865);
				SendClientMessage(playerid, COR_AMARELO, "| GPS | Destino: {ffffff}Concessionária de Los Santos");
				SendClientMessage(playerid, COR_AMARELO, "| GPS | Distância: {ffffff}%d {"COR_AMARELO_INC"}Metro(s)", floatround(GetPlayerDistanceFromPoint(playerid, 557.0057, -1254.6377, 17.0865)) );
				return true;
			}
			case 1: // Concessionária de Los Santos Usados
			{
				call::PLAYER->SetPlayerMarkGPS(playerid, 2124.7351, -1121.0001, 25.3511);
				SendClientMessage(playerid, COR_AMARELO, "| GPS | Destino: {ffffff}Concessionária de Los Santos ( Veiculos Usados )");
				SendClientMessage(playerid, COR_AMARELO, "| GPS | Distância: {ffffff}%d {"COR_AMARELO_INC"}Metro(s)", floatround(GetPlayerDistanceFromPoint(playerid, 2124.7351, -1121.0001, 25.3511)) );
				return true;
			}
			case 2: // Concessionária de San Fierro
			{
				call::PLAYER->SetPlayerMarkGPS(playerid, -1992.9824, 284.2329, 33.6549);
				SendClientMessage(playerid, COR_AMARELO, "| GPS | Destino: {ffffff}Concessionária de San Fierro");
				SendClientMessage(playerid, COR_AMARELO, "| GPS | Distância: {ffffff}%d {"COR_AMARELO_INC"}Metro(s)", floatround(GetPlayerDistanceFromPoint(playerid, -1992.9824, 284.2329, 33.6549)) );
				return true;
			}
			case 3: // Concessionária de San Fierro Importadosa
			{
				call::PLAYER->SetPlayerMarkGPS(playerid, -1641.0930, 1202.0807, 7.2399);
				SendClientMessage(playerid, COR_AMARELO, "| GPS | }Destino: {ffffff}Concessionária de San Fierro ( Importados )");
				SendClientMessage(playerid, COR_AMARELO, "| GPS | }Distância: {ffffff}%d {"COR_AMARELO_INC"}Metro(s)", floatround(GetPlayerDistanceFromPoint(playerid, -1641.0930, 1202.0807, 7.2399)) );
				return true;
			}
			case 4: // Las Venturas
			{
				call::PLAYER->SetPlayerMarkGPS(playerid, 1943.2510, 2031.0604, 10.8203);
				SendClientMessage(playerid, COR_AMARELO, "| GPS |Destino: {ffffff}Concessionária de Las Venturas");
				SendClientMessage(playerid, COR_AMARELO, "| GPS |Distância: {ffffff}%d {"COR_AMARELO_INC"}Metro(s)", floatround(GetPlayerDistanceFromPoint(playerid, 1943.2510, 2031.0604, 10.8203)) );
				return true;
			}
			case 5: // Los Santos Lowriders
			{
				call::PLAYER->SetPlayerMarkGPS(playerid, 617.0251, -1497.1733, 14.8447);
				SendClientMessage(playerid, COR_AMARELO, "| GPS | Destino: {ffffff}Concessionária de Los Santos ( Lowriders )");
				SendClientMessage(playerid, COR_AMARELO, "| GPS | Distância: {ffffff}%d {"COR_AMARELO_INC"}Metro(s)", floatround(GetPlayerDistanceFromPoint(playerid, 617.0251, -1497.1733, 14.8447)) );
				return true;
			}
			case 6: // Los Santos Barcos
			{
				call::PLAYER->SetPlayerMarkGPS(playerid, 2591.8298,-2470.5718,3.0000);
				SendClientMessage(playerid, COR_AMARELO, "| GPS | Destino: {ffffff}Concessionária de Los Santos ( Barcos )");
				SendClientMessage(playerid, COR_AMARELO, "| GPS | Distância: {ffffff}%d {"COR_AMARELO_INC"} Metro(s)", floatround(GetPlayerDistanceFromPoint(playerid, 2591.8298,-2470.5718,3.0000)) );
				return true;
			}
		}
		return true;
	}
	callcmd::gps(playerid);
	return true;
}

Dialog:PLAYER_MENU_RADIO(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if ( listitem >= CountStations())
			return SendClientMessage(playerid, COR_BRANCO, "MP3 desligado."), StopAudioStreamForPlayer(playerid);

		new name[MAX_STATION_NAME], url[MAX_STATION_URL];
		GetStationName(listitem, name), GetStationUrl(listitem, url);
		PlayAudioStreamForPlayer(playerid, url);
		SendClientMessage(playerid, COR_BRANCO, "%s{"COR_SISTEMA_INC"} sintonizada com sucesso!", name);
		return true;
	}
	return true;
}

Dialog:DIALOG_MP3(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				SendClientMessage(playerid, COR_ERRO, "| ERRO | Não possuimos uma rádio ainda.");
				//SendClientMessage(playerid, COR_LARANJA, "» {FFFFFF}Você está escutando a Rádio {"COR_VERDE_INC"}Perfect City");
				//PlayAudioStreamForPlayer(playerid, "http://stm13.voxtreaming.com.br:6730/;");
				return 1;
			}
			case 1:
			{
				ShowPlayerDialog(playerid, DIALOG_MP3BRASIL, DIALOG_STYLE_LIST, "Rádios Brasil", "Antena 1\nHunterFM\t\t>", "Selecionar", "Fechar");
				return 1;
			}
			case 2:
			{
				SendClientMessage(playerid, COR_ERRO, "| ERRO | Não tem nenhuma rádio ainda.");
				return 1;
			}
			case 3:
			{
				SendClientMessage(playerid, COR_ERRO, "| ERRO | Não tem nenhuma rádio ainda.");
				return 1;
			}
			case 4:
			{
				StopAudioStreamForPlayer(playerid);
			}
		}
		return true;
	}
	return true;
}

Dialog:DIALOG_MP3BRASIL(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: {
				SendClientMessage(playerid, COR_LARANJA, "» {FFFFFF}Você está escutando a Rádio {"COR_VERDE_INC"}Antena 1");
				PlayAudioStreamForPlayer(playerid, "https://antenaone.crossradio.com.br/listen.pls?sid=1;");
				return true;
			}
			case 1: {
				ShowPlayerDialog(playerid, DIALOG_MP3HUNTER, DIALOG_STYLE_LIST, "Rádios HunterFM", "Pop\nSertanejo\nRock\nPop2K\nLo-fi\nTropical\n80s\nSmash", "Selecionar", "Fechar");
				return true;
			}
		}
		return true;
	}
	return true;
}

Dialog:DIALOG_MP3HUNTER(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				SendClientMessage(playerid, COR_LARANJA, "» {FFFFFF}Você está escutando a Rádio {"COR_VERDE_INC"}Hunter POP");
				PlayAudioStreamForPlayer(playerid, "https://live.hunter.fm/pop_normal");
				return 1;
			}
			case 1:
			{
				SendClientMessage(playerid, COR_LARANJA, "» {FFFFFF}Você está escutando a Rádio {"COR_VERDE_INC"}Hunter Sertanejo");
				PlayAudioStreamForPlayer(playerid, "https://live.hunter.fm/sertanejo_normal");
				return 1;
			}
			case 2:
			{
				SendClientMessage(playerid, COR_LARANJA, "» {FFFFFF}Você está escutando a Rádio {"COR_VERDE_INC"}Hunter Rock");
				PlayAudioStreamForPlayer(playerid, "https://live.hunter.fm/rock_normal");
				return 1;
			}
			case 3:
			{
				SendClientMessage(playerid, COR_LARANJA, "» {FFFFFF}Você está escutando a Rádio {"COR_VERDE_INC"}Hunter POP2K");
				PlayAudioStreamForPlayer(playerid, "https://live.hunter.fm/pop2k_normal");
				return 1;
			}
			case 4:
			{
				SendClientMessage(playerid, COR_LARANJA, "» {FFFFFF}Você está escutando a Rádio {"COR_VERDE_INC"}Hunter LO-FI");
				PlayAudioStreamForPlayer(playerid, "https://live.hunter.fm/lofi_normal");
				return 1;
			}
			case 5:
			{
				SendClientMessage(playerid, COR_LARANJA, "» {FFFFFF}Você está escutando a Rádio {"COR_VERDE_INC"}Hunter TROPICAL");
				PlayAudioStreamForPlayer(playerid, "https://live.hunter.fm/tropical_normal");
				return 1;
			}
			case 6:
			{
				SendClientMessage(playerid, COR_LARANJA, "» {FFFFFF}Você está escutando a Rádio {"COR_VERDE_INC"}Hunter 80s");
				PlayAudioStreamForPlayer(playerid, "https://live.hunter.fm/80s_normal");
				return 1;
			}
			case 7:
			{
				SendClientMessage(playerid, COR_LARANJA, "» {FFFFFF}Você está escutando a Rádio {"COR_VERDE_INC"}Hunter SMASH");
				PlayAudioStreamForPlayer(playerid, "https://live.hunter.fm/smash_normal");
				return 1;
			}
		}
		return true;
	}
	return true;
}

Dialog:VEHICLE_RADIO_STATION(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if ( !IsPlayerInAnyVehicle(playerid) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo.");

		new vehicleid = GetPlayerVehicleID(playerid);

		if ( listitem >= CountStations())
			return SendClientMessage(playerid, COR_BRANCO, "MP3 desligado."), StopAudioStreamForPlayer(playerid), Vehicle[vehicleid][RadioOn] = false;

		new name[MAX_STATION_NAME], url[MAX_STATION_URL];
		
		Vehicle[vehicleid][RadioID] = listitem;
		Vehicle[vehicleid][RadioOn] = true;

		GetStationName(listitem, name), GetStationUrl(listitem, url);
		PlayAudioStreamForPlayer(playerid, url);
		SendClientMessage(playerid, COR_BRANCO, "%s{"COR_SISTEMA_INC"} sintonizada com sucesso!", name);
		return true;
	}
	return true;
}

Dialog:SERVER_STATICS(playerid, response, listitems, inputtext[])
{
	if(response)
	{
		new str[1024];
		switch(listitems)
		{
			case 0: // TOP GRANA
			{
				new pName[MAX_PLAYER_NAME], dinheiro;

				mysql_query(getConexao(), "SELECT u.username, u.dinheiro + b.saldo as total FROM "TABLE_USERS" u LEFT JOIN "TABLE_BANK" b ON b.id = u.id WHERE u.admin < '1' ORDER BY total DESC LIMIT "#MAX_TOPS";"); // "
				
				str = "Posição\tNome\tDinheiro\n";
				
				for(new i, r=cache_num_rows(); i < r; i++)
				{
					cache_get_value_name(i, "username", pName, MAX_PLAYER_NAME);
					cache_get_value_name_int(i, "total", dinheiro);

					format(str, sizeof(str), "%s{"COR_AZUL_INC"}%d°\t{"COR_LARANJA_INC"}%s\t{"COR_VERDE_INC"}R$%s\n", str, i + 1, pName, RealStr(dinheiro));
				}
				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "{ffffff}TOP Grana", str, "OK", "");
			}
			case 1: // TOP LEVEL
			{
				new pName[MAX_PLAYER_NAME], level;

				mysql_query(getConexao(), "SELECT `username`,`level` FROM "TABLE_USERS" WHERE `admin`<'1' ORDER BY `level` DESC LIMIT "#MAX_TOPS";"); // "
				
				str = "Posição\tNome\tLevel\n";
				for(new i, r=cache_num_rows(); i < r; i++)
				{
					cache_get_value_name(i, "username", pName, MAX_PLAYER_NAME);
					cache_get_value_name_int(i, "level", level);

					format(str, sizeof(str), "%s{"COR_AZUL_INC"}%d°\t{"COR_LARANJA_INC"}%s\t{"COR_VERDE_INC"}%d\n", str, i + 1, pName, level);
				}
				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "{ffffff}TOP Level", str, "OK", "");
			}
		}
		return true;
	}
	return true;
}
Dialog:ABASTECENDO_VEICULO(playerid, response, listitem, inputtext[])
{
	if(response)
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

		if(!IsNumeric(inputtext) || isnull(inputtext))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você deve digitar um valor válido."), callcmd::abastecer(playerid);

		new quantidade = strval(inputtext);

		if ( quantidade <= 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você deve digitar um valor maior que 0."), callcmd::abastecer(playerid);

		SetPVarInt(playerid, "abastecendo", 1);
		TogglePlayerControllable(playerid, false);
		//PlayerPlaySound(playerid, 6000, 0.0, 0.0, 0.0);
		call::VH->AbastecerVeiculo(playerid, vehicleid, (quantidade > GetVehicleMaxFuel(model) ? GetVehicleMaxFuel(model) : quantidade ) );
		return true;
	}
	return true;
}

Dialog:CONFIGURACOES_JOGADOR(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		switch(listitem)
		{
			case 0: // HUD
			{
				new file[MAX_FILE_CONFIG_LEN];
				format(file, sizeof(file), CONFIG_PLAYER_PATH, GetUserName(playerid));

				ShowPlayerDialog(playerid, CONFIG_HUD, DIALOG_STYLE_TABLIST, "{"COR_DISABLE_INC"}CONFIGURAÇÕES DO USUÁRIO  {"COR_BRANCO_INC"}HUD", "Status\t%s\nData e Hora\t%s", "Selecionar", "Voltar",
					(DOF2::GetInt(file, TAG_MOSTRAR_STATUS) ? ("{"COR_VERDE_INC"}ON") : ("{"COR_VERMELHO_INC"}OFF") ),
					(DOF2::GetInt(file, TAG_MOSTRAR_DATA) ? ("{"COR_VERDE_INC"}ON") : ("{"COR_VERMELHO_INC"}OFF") )
				);
				return true;
			}
			case 1: // PIN de Segurança
			{
				if(Jogador[playerid][PinAtivo])
				{
					SetPVarInt(playerid, "pin_seguranca", PIN_DESATIVAR);
					ShowPlayerDialog(playerid, DESATIVAR_PIN, DIALOG_STYLE_INPUT, "{ffffff}PIN de Segurança", "{ffffff}Para desativar o seu PIN de Segurança, digite o PIN atual:", "Desativar", "Cancelar");
				}
				Jogador[playerid][PinAtivo] = true;
				SendClientMessage(playerid, COR_AMARELO, "| PIN | O PIN de Segurança foi ativado.");

				if(Jogador[playerid][PIN] == 0)
				{
					//new _str[600];

					Jogador[playerid][PIN] = gerarPIN();

					SendClientMessage(playerid, COR_AMARELO, "| PIN | Seu PIN foi gerado, anote-o: %i", Jogador[playerid][PIN]);

					//format(_str, sizeof(_str), 
					//						"#USUARIO:%s\
					//						#CODE:%i", GetUserName(playerid), Jogador[playerid][PIN]);
					//SendEmailPIN("Seu PIN de Segurança", Jogador[playerid][Email], "PIN - Perfect City RPG", _str, true);

				}
				else
					ShowPlayerDialog(playerid, NOVO_PIN, DIALOG_STYLE_MSGBOX, "{ffffff}PIN de Segurança", "{ffffff}Você ainda lembra de seu PIN?\nSe por acaso não se lembrar, podemos gerar um novo pin caso deseje.\n\nVocê deseja um novo PIN?", "Sim", "Não");
			
				new query[128], atividade[128];
				mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `pin`='%i', `pinativo`='1' WHERE `id`='%d' LIMIT 1;", Jogador[playerid][PIN], call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
				mysql_tquery(getConexao(), query);

				format(atividade, sizeof(atividade), "ativou o pin (IP: %s)", GetPlayerIpEx(playerid));
				RegistrarAtividade(Jogador[playerid][PlayerID], "Segurança PIN", atividade);
			}
		}
		return true;
	}
	return true;
}

Dialog:CONFIG_HUD(playerid, response, listitem, inputtext[])
{		
	if ( response )
	{
		new file[MAX_FILE_CONFIG_LEN];
		format(file, sizeof(file), CONFIG_PLAYER_PATH, GetUserName(playerid));

		switch(listitem)
		{
			case 0: // status
			{
				DOF2::SetInt(file, TAG_MOSTRAR_STATUS, (DOF2::GetInt(file, TAG_MOSTRAR_STATUS) ? 0 : 1) );

				if ( DOF2::GetInt(file, TAG_MOSTRAR_STATUS) )
					call::TD->ShowPlayerHudStatus(playerid), call::TD->ShowPlayerHud(playerid);
				else
					call::TD->HidePlayerHudStatus(playerid), call::TD->HidePlayerHud(playerid);

				SendClientMessage(playerid, COR_SISTEMA, "» Você {"COR_BRANCO_INC"}%s{"COR_SISTEMA_INC"} o status.", (DOF2::GetInt(file, TAG_MOSTRAR_STATUS) ? ("desocultou") : ("ocultou") ) );
			}
			case 1: // data
			{
				DOF2::SetInt(file, TAG_MOSTRAR_DATA, (DOF2::GetInt(file, TAG_MOSTRAR_DATA) ? 0 : 1) );

				if ( DOF2::GetInt(file, TAG_MOSTRAR_DATA) )
					call::TD->ShowPlayerHudData(playerid);
				else
					call::TD->HidePlayerHudData(playerid);

				SendClientMessage(playerid, COR_SISTEMA, "» Você {"COR_BRANCO_INC"}%s{"COR_SISTEMA_INC"} a data e hora.", (DOF2::GetInt(file, TAG_MOSTRAR_DATA) ? ("desocultou") : ("ocultou") ) );
			}
		}
		ShowPlayerDialog(playerid, CONFIG_HUD, DIALOG_STYLE_TABLIST, "{"COR_DISABLE_INC"}CONFIG CONTA » {"COR_BRANCO_INC"}HUD", "Status\t%s\nData e Hora\t%s", "Selecionar", "Voltar",
			(DOF2::GetInt(file, TAG_MOSTRAR_STATUS) ? ("{"COR_VERDE_INC"}ON") : ("{"COR_VERMELHO_INC"}OFF") ),
			(DOF2::GetInt(file, TAG_MOSTRAR_DATA) ? ("{"COR_VERDE_INC"}ON") : ("{"COR_VERMELHO_INC"}OFF") )
		);
		return true;
	}
	callcmd::config(playerid);
	return true;
}

new 
	NeonEsquerda[MAX_VEHICLES], NeonDireita[MAX_VEHICLES];
Dialog:Dialog_Neons(playerid, response, listitem, inputtext[])
{		
	if (response)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		switch(listitem)
		{
			case 0: //Neon vermelho
			{
				if(GetPVarInt(playerid, "AddNeon") == 1)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já tem um neon instalado, remova-o.");

				SetPVarInt(playerid, "AddNeon", 1);
	            NeonEsquerda[vehicleid] = CreateDynamicObject(18647, 0, 0, 0, 0, 0, 0), NeonDireita[vehicleid] = CreateDynamicObject(18647, 0, 0, 0, 0, 0, 0);
	            AttachDynamicObjectToVehicle(NeonEsquerda[vehicleid], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0), AttachDynamicObjectToVehicle(NeonDireita[vehicleid], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Neon instalado com sucesso.");
			}
			case 1: //Neon azul
			{
				if(GetPVarInt(playerid, "AddNeon") == 1)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já tem um neon instalado, remova-o.");

				SetPVarInt(playerid, "AddNeon", 1);
	            NeonEsquerda[vehicleid] = CreateDynamicObject(18648, 0, 0, 0, 0, 0, 0), NeonDireita[vehicleid] = CreateDynamicObject(18648, 0, 0, 0, 0, 0, 0);
	            AttachDynamicObjectToVehicle(NeonEsquerda[vehicleid], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0), AttachDynamicObjectToVehicle(NeonDireita[vehicleid], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Neon instalado com sucesso.");
			}
			case 2: //Neon verde
			{
				if(GetPVarInt(playerid, "AddNeon") == 1)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já tem um neon instalado, remova-o.");

				SetPVarInt(playerid, "AddNeon", 1);
	            NeonEsquerda[vehicleid] = CreateDynamicObject(18649, 0, 0, 0, 0, 0, 0), NeonDireita[vehicleid] = CreateDynamicObject(18649, 0, 0, 0, 0, 0, 0);
	            AttachDynamicObjectToVehicle(NeonEsquerda[vehicleid], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0), AttachDynamicObjectToVehicle(NeonDireita[vehicleid], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Neon instalado com sucesso.");
			}
			case 3: //Neon amarelo
			{
				if(GetPVarInt(playerid, "AddNeon") == 1)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já tem um neon instalado, remova-o.");

				SetPVarInt(playerid, "AddNeon", 1);
	            NeonEsquerda[vehicleid] = CreateDynamicObject(18650, 0, 0, 0, 0, 0, 0), NeonDireita[vehicleid] = CreateDynamicObject(18650, 0, 0, 0, 0, 0, 0);
	            AttachDynamicObjectToVehicle(NeonEsquerda[vehicleid], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0), AttachDynamicObjectToVehicle(NeonDireita[vehicleid], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Neon instalado com sucesso.");
			}
			case 4: //Neon rosa
			{
				if(GetPVarInt(playerid, "AddNeon") == 1)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já tem um neon instalado, remova-o.");

				SetPVarInt(playerid, "AddNeon", 1);
	            NeonEsquerda[vehicleid] = CreateDynamicObject(18651, 0, 0, 0, 0, 0, 0), NeonDireita[vehicleid] = CreateDynamicObject(18651, 0, 0, 0, 0, 0, 0);
	            AttachDynamicObjectToVehicle(NeonEsquerda[vehicleid], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0), AttachDynamicObjectToVehicle(NeonDireita[vehicleid], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Neon instalado com sucesso.");
			}
			case 5: //Neon branco
			{
				if(GetPVarInt(playerid, "AddNeon") == 1)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já tem um neon instalado, remova-o.");

				SetPVarInt(playerid, "AddNeon", 1);
	            NeonEsquerda[vehicleid] = CreateDynamicObject(18652, 0, 0, 0, 0, 0, 0), NeonDireita[vehicleid] = CreateDynamicObject(18652, 0, 0, 0, 0, 0, 0);
	            AttachDynamicObjectToVehicle(NeonEsquerda[vehicleid], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0), AttachDynamicObjectToVehicle(NeonDireita[vehicleid], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Neon instalado com sucesso.");
			}
			case 6: //Neon policial
			{
				if(GetPVarInt(playerid, "AddNeon") == 1)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já tem um neon instalado, remova-o.");

				SetPVarInt(playerid, "AddNeon", 1);
	            NeonEsquerda[vehicleid] = CreateDynamicObject(18646, 0, 0, 0, 0, 0, 0), NeonDireita[vehicleid] = CreateDynamicObject(18646, 0, 0, 0, 0, 0, 0);
	            AttachDynamicObjectToVehicle(NeonEsquerda[vehicleid], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0), AttachDynamicObjectToVehicle(NeonDireita[vehicleid], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Neon instalado com sucesso.");
			}
			case 7:
			{
				if(GetPVarInt(playerid, "AddNeon") == 0)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem um neon instalado.");

				DeletePVar(playerid, "AddNeon");
				DestroyDynamicObject(NeonEsquerda[vehicleid]), DestroyDynamicObject(NeonDireita[vehicleid]);
				NeonEsquerda[vehicleid] = 0, NeonDireita[vehicleid] = 0;
				SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Neon removido com sucesso.");  
			}	
		}
	}
	return true;
}

Dialog:DIALOG_MUDAR_EMAIL(playerid, response, listitem, inputtext[])
{
	if(!response)
		return SendClientMessage(playerid, COR_ERRO, "| ALTERAÇÃO DE EMAIL | Você cancelou a alteração do email.");
	
	new email[100];
	GetPVarString(playerid, "NewEmail", email, sizeof(email));

	format(Jogador[playerid][Email], 100, "%s", email);

	SendClientMessage(playerid, -1, "| ALTERAÇÃO DE EMAIL | Você alterou com sucesso seu email para: {"COR_AZUL_INC"}%s{ffffff}!", email);

	new query[350];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `email`='%s' WHERE `id`='%d' LIMIT 1", email, call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
	mysql_tquery(getConexao(), query);
	return 1;
}


Dialog:MENU_CASH(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		ShowPlayerDialog(playerid, MENU_CASH_ATIVAR, DIALOG_STYLE_INPUT, "MENU BITCOINS {"COR_AZUL_INC"}->{"COR_BRANCO_INC"} ATIVAR", 
			"{"COR_BRANCO_INC"}Digite o código recebido pelo paypal.", "Ativar", "voltar");
		return true;
	}
	return true;
}

Dialog:COR_TAG_VIP(playerid, response, listitem, inputtext[])
{
	if ( response ) {
		switch(listitem) {
			case 0: 
			{
				Jogador[playerid][CorTag] = HexToInt("FF0000FF");

				new file[MAX_FILE_CONFIG_LEN];
				format(file, sizeof(file), CONFIG_PLAYER_PATH, GetUserName(playerid));
				SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Você alterou a cor da tag vip para ( {FF0000}TAG{"COR_AMARELO_INC"} ).");
				if ( !fexist(file) )
					DOF2::CreateFile(file);

			    DOF2::SetInt(file, TAG_CORTAGVIP, Jogador[playerid][CorTag]);     
			    DOF2::SaveFile(); 
			    return true;
			}
			case 1: 
			{
				Jogador[playerid][CorTag] = HexToInt("0080FFFF");

				new file[MAX_FILE_CONFIG_LEN];
				format(file, sizeof(file), CONFIG_PLAYER_PATH, GetUserName(playerid));
				SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Você alterou a cor da tag vip para ( {0080FF}TAG{"COR_AMARELO_INC"} ).");
				if ( !fexist(file) )
					DOF2::CreateFile(file);

			    DOF2::SetInt(file, TAG_CORTAGVIP, Jogador[playerid][CorTag]);     
			    DOF2::SaveFile(); 
			    return true;
			}
			case 2: 
			{
				Jogador[playerid][CorTag] = HexToInt("BF00FFFF");

				new file[MAX_FILE_CONFIG_LEN];
				format(file, sizeof(file), CONFIG_PLAYER_PATH, GetUserName(playerid));
				SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Você alterou a cor da tag vip para ( {BF00FF}TAG{"COR_AMARELO_INC"} ).");
				if ( !fexist(file) )
					DOF2::CreateFile(file);

			    DOF2::SetInt(file, TAG_CORTAGVIP, Jogador[playerid][CorTag]);     
			    DOF2::SaveFile(); 
			    return true;
			}
			case 3: 
			{
				Jogador[playerid][CorTag] = HexToInt("2EFE64FF");

				new file[MAX_FILE_CONFIG_LEN];
				format(file, sizeof(file), CONFIG_PLAYER_PATH, GetUserName(playerid));
				SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Você alterou a cor da tag vip para ( {2EFE64}TAG{"COR_AMARELO_INC"} ).");
				if ( !fexist(file) )
					DOF2::CreateFile(file);

			    DOF2::SetInt(file, TAG_CORTAGVIP, Jogador[playerid][CorTag]);     
			    DOF2::SaveFile(); 
			    return true;
			}
			case 4: 
			{
				Jogador[playerid][CorTag] = HexToInt("FF8000FF");

				new file[MAX_FILE_CONFIG_LEN];
				format(file, sizeof(file), CONFIG_PLAYER_PATH, GetUserName(playerid));
				SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Você alterou a cor da tag vip para ( {FF8000}TAG{"COR_AMARELO_INC"} ).");
				if ( !fexist(file) )
					DOF2::CreateFile(file);

			    DOF2::SetInt(file, TAG_CORTAGVIP, Jogador[playerid][CorTag]);     
			    DOF2::SaveFile(); 
				return true;
			}
			case 5: 
			{
				Jogador[playerid][CorTag] = HexToInt("58FAACFF");

				new file[MAX_FILE_CONFIG_LEN];
				format(file, sizeof(file), CONFIG_PLAYER_PATH, GetUserName(playerid));
				SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Você alterou a cor da tag vip para ( {58FAAC}TAG{"COR_AMARELO_INC"} ).");
				if ( !fexist(file) )
					DOF2::CreateFile(file);

			    DOF2::SetInt(file, TAG_CORTAGVIP, Jogador[playerid][CorTag]);     
			    DOF2::SaveFile(); 
			    return true;
			}
			case 6: 
			{
				Jogador[playerid][CorTag] = HexToInt("FFFF00FF");

				new file[MAX_FILE_CONFIG_LEN];
				format(file, sizeof(file), CONFIG_PLAYER_PATH, GetUserName(playerid));
				SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Você alterou a cor da tag vip para ( {FFFF00}TAG{"COR_AMARELO_INC"} ).");
				if ( !fexist(file) )
					DOF2::CreateFile(file);

			    DOF2::SetInt(file, TAG_CORTAGVIP, Jogador[playerid][CorTag]);     
			    DOF2::SaveFile(); 
			    return true;
			}
			case 7:
			{
				ShowPlayerDialog(playerid, COR_TAG_HTML, DIALOG_STYLE_INPUT, "Escolha sua tag em HTML", "Digite um código html válido, use o tipo RRGGBBAA.", "Confirmar", "Sair");
				/*if( isnull(inputtext) )
					return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/cortag [Código-Html]");
				
				if ( !IsValidHex(inputtext, VERIFY_HEX_8) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Voce não digitou um código html válido, use o tipo RRGGBBAA.");

				Jogador[playerid][CorTag] = HexToInt(inputtext);
				SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Você alterou a cor da tag vip para ( {%06x}Cor{"COR_BRANCO_INC"} ).", (Jogador[playerid][CorTag] >>> 8) );
				
				new file[MAX_FILE_CONFIG_LEN];
				format(file, sizeof(file), CONFIG_PLAYER_PATH, GetUserName(playerid));
				
				if ( !fexist(file) )
					DOF2::CreateFile(file);

			    DOF2::SetInt(file, TAG_CORTAGVIP, Jogador[playerid][CorTag]);     
			    DOF2::SaveFile();*/
			    return true;
			}
		}
		return true;
	}
	return true;
}

Dialog:COR_TAG_HTML(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		if( isnull(inputtext) )
			return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/cortag [Código-Html]");
		
		if ( !IsValidHex(inputtext, VERIFY_HEX_8) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Voce não digitou um código html válido, use o tipo RRGGBBAA.");

		Jogador[playerid][CorTag] = HexToInt(inputtext);
		SendClientMessage(playerid, COR_AMARELO, "| PFC - VIP | Você alterou a cor da tag vip para ( {%06x}Cor{"COR_AMARELO_INC"} ).", (Jogador[playerid][CorTag] >>> 8) );
		
		new file[MAX_FILE_CONFIG_LEN];
		format(file, sizeof(file), CONFIG_PLAYER_PATH, GetUserName(playerid));
		
		if ( !fexist(file) )
			DOF2::CreateFile(file);

		DOF2::SetInt(file, TAG_CORTAGVIP, Jogador[playerid][CorTag]);     
		DOF2::SaveFile();
		return true;
	}
	return true;
}

Dialog:PIN_SEGURANCA(playerid, response, listitem, inputtext[])
{
	if(!response || strlen(inputtext) == 0)
		return DeletePVar(playerid, "pin_seguranca");

	if(GetPVarInt(playerid, "tempo_pin") > gettime())
		return DeletePVar(playerid, "pin_seguranca"), SendClientMessage(playerid, COR_ERRO, "| ERRO | Por motivos de segurança esta ação foi cancelada, tente novamente mais tarde."), SetPVarInt(playerid, "tempo_pin", gettime() + (60 * 5));

	if(Jogador[playerid][PIN] != strval(inputtext))
		return DeletePVar(playerid, "pin_seguranca"), SendClientMessage(playerid, COR_ERRO, "| ERRO | Você digitou o PIN incorreto, tente novamente mais tarde."), SetPVarInt(playerid, "tempo_pin", gettime() + (60 * 5));

	switch(GetPVarInt(playerid, "pin_seguranca")) {
		case PIN_MUDAR_SENHA: {
			ShowPlayerDialog(playerid, SENHA_ANTIGA, DIALOG_STYLE_PASSWORD, "{ffffff}Digite sua senha atual", "{ffffff}Para fazer a mudança de senha, você precisa digitar sua senha atual\nSua senha atual:", "Continuar", "Cancelar");
			return 1;
		}
		case PIN_DESATIVAR: {
			Jogador[playerid][PIN] = 0;
			Jogador[playerid][PinAtivo] = false;
			SendClientMessage(playerid, COR_ERRO, "| PIN | Você desativou o seu PIN de Segurança.");

			new query[128], atividade[128];
			mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `pin`='0',`pinativo`='0' WHERE `id`='%d' LIMIT 1;", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
			mysql_tquery(getConexao(), query);

			format(atividade, sizeof(atividade), "desativou o pin (IP: %s)", GetPlayerIpEx(playerid));
			RegistrarAtividade(Jogador[playerid][PlayerID], "Segurança PIN", atividade);
		}
	}
	DeletePVar(playerid, "pin_seguranca");
	return true;
}

Dialog:SENHA_ANTIGA(playerid, response, listitem, inputtext[])
{

	if(!response)
		return 1;

	new senhaatual[64];

	sscanf(inputtext, "s[64]", senhaatual);

	if(strlen(senhaatual) < 4)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Senha inválida.");

	if(strcmp(Jogador[playerid][Senha], senhaatual, false) != 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Senha inválida.");

	ShowPlayerDialog(playerid, SENHA_NOVA, DIALOG_STYLE_PASSWORD, "{ffffff}Digite sua nova senha", "{ffffff}Você digitou sua senha atual corretamente\nAgora digite sua nova senha:", "Continuar", "Cancelar");

	return true;
}

Dialog:SENHA_NOVA(playerid, response, listitem, inputtext[])
{
	if(!response)
		return 1;

	new _msg[700], novasenha[64];

	sscanf(inputtext, "s[64]", novasenha);

	if(strlen(novasenha) < 4)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Digite uma senha mais forte.");

	if(strcmp(Hash(Jogador[playerid][Senha]), novasenha, false) == 0)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Sua nova senha não pode ser a mesma que a atual.");

	SetPVarString(playerid, "NovaSenha", novasenha);

	format(_msg, 700, "{ffffff}Senha Antiga: {"COR_LARANJA_INC"}%s\n", Jogador[playerid][Senha]);
	format(_msg, 700, "%s{ffffff}Senha Nova: {"COR_VERDE_INC"}%s\n\n", _msg, novasenha);
	format(_msg, 700, "%s{ffffff}Tem certeza que deseja alterar sua senha?", _msg);

	ShowPlayerDialog(playerid, CONFIRMAR_SENHA, DIALOG_STYLE_MSGBOX, "Confirmação", _msg, "Sim", "Não");
	return true;
}

Dialog:CONFIRMAR_SENHA(playerid, response, listitem, inputtext[])
{
	if(!response)
		return SendClientMessage(playerid, COR_ERRO, "| SENHA | Você cancelou a mudança de senha.");

	new senhanova[64];
	GetPVarString(playerid, "NovaSenha", senhanova, sizeof(senhanova));

	format(Jogador[playerid][Senha], 64, "%s", senhanova);

	SendClientMessage(playerid, -1, "| SENHA | Você alterou com sucesso sua senha para: {"COR_AZUL_INC"}%s{ffffff}!", senhanova);
	new query[350];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `senha`='%s' WHERE `id`='%d' LIMIT 1;", Hash(senhanova), call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
	mysql_tquery(getConexao(), query);
	return true;
}

Dialog:NOVO_PIN(playerid, response, listitem, inputtext[])
{
	if(!response)
		return 1;

	Jogador[playerid][PIN] = gerarPIN();

	SendClientMessage(playerid, COR_AMARELO, "| PIN | Seu novo PIN foi gerado, anote-o: %i", Jogador[playerid][PIN]);

	new query[128], atividade[128];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `pin`='%i' WHERE `id`='%d' LIMIT 1;", Jogador[playerid][PIN], call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
	mysql_tquery(getConexao(), query);

	format(atividade, sizeof(atividade), "gerou um novo pin (IP: %s)", GetPlayerIpEx(playerid));
	RegistrarAtividade(Jogador[playerid][PlayerID], "Segurança PIN", atividade);
	return true;
}

/*Dialog:ArmasFavela(playerid, response, listitem, inputtext[])
{
	if(!response)
		return 1;

	switch(listitem)
	{
		case 0:
		{
			new query[256];
			if(GetPlayerMoney(playerid) < VALOR_KIT1)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente");

			//GivePlayerKitFavela(playerid, listitem + 1);
			Jogador[playerid][KitFavela] = listitem+1;
			GivePlayerMoney(playerid, -VALOR_KIT1);
			mysql_format(getConexao(), query, sizeof(query), "UPDATE `usuarios` SET `kit-favela`='1' WHERE `username`='%s'", GetUserName(playerid));
			mysql_tquery(getConexao(), query);
			return SendClientMessage(playerid, COR_AMARELO, "| FAVELA | Você adquiriu o kit 1");
		}
		case 1: 
		{
			new query[256];
			if(GetPlayerMoney(playerid) < VALOR_KIT2)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente");

			Jogador[playerid][KitFavela] = listitem+1;
			//GivePlayerKitFavela(playerid, listitem + 1);
			GivePlayerMoney(playerid, -VALOR_KIT2);
			mysql_format(getConexao(), query, sizeof(query), "UPDATE `usuarios` SET `kit-favela`='2' WHERE `username`='%s'", GetUserName(playerid));
			mysql_tquery(getConexao(), query);
			return SendClientMessage(playerid, COR_AMARELO, "| FAVELA | Você adquiriu o kit 2");
		}
		case 2: 
		{
			new query[256];
			if(GetPlayerMoney(playerid) < VALOR_KIT3)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente");

			Jogador[playerid][KitFavela] = listitem+1;
			//GivePlayerKitFavela(playerid, listitem + 1);
			GivePlayerMoney(playerid, -VALOR_KIT3);
			mysql_format(getConexao(), query, sizeof(query), "UPDATE `usuarios` SET `kit-favela`='3' WHERE `username`='%s'", GetUserName(playerid));
			mysql_tquery(getConexao(), query);
			return SendClientMessage(playerid, COR_AMARELO, "| FAVELA | Você adquiriu o kit 3");
		}
	}
	return true;
}*/