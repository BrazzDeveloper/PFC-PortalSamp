// 
Dialog:PLAYER_AUTH_NICK(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		CleanChat(playerid);
		if( isnull(inputtext) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ precisa digitar seu nick.");

		if ( !IsValidName(inputtext) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ digitou um nome inv·lido.");

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
		CleanChat(playerid);
		if( isnull(inputtext) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ precisa digitar sua senha.");

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
			return SendClientMessage(playerid, COR_ERRO, "VocÍ precisa digitar um email v·lido.");

		if ( !call::PLAYER->IsEmailRegistered(inputtext) )
			return SendClientMessage(playerid, COR_ERRO, "O Email digitado n„o foi encontrado em nosso banco de dados.");

		if ( GetPVarInt(playerid, "tmp_recover_password") > 3)
			return SendClientMessage(playerid, COR_ERRO, "VocÍ foi kickado por tentar recuperar a senha muitas vezes.");
		
		SetPVarInt(playerid, "tmp_recover_password", GetPVarInt(playerid, "tmp_recover_password") + 1);
		
		new query[MAX_PLAYER_EMAIL + 100], str[128], code[11];

		/**
		*
		*	gerar cÛdigo aleatÛrio.
		*
		**/
		randomstring(code, sizeof(code)-1);

		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `codigo_recuperacao`='%s' WHERE `email`='%e' LIMIT 1;", code, inputtext);
		
		if ( !mysql_tquery(getConexao(), query) )
			return SendClientMessage(playerid, COR_ERRO, "** OPS! Ocorreu um erro em nosso servidor e n„o poderemos lhe ajudar agora, tire print da tela e mostre a algum administrador.");

		

		format(Jogador[playerid][Email], MAX_PLAYER_EMAIL, inputtext);

		format(str, sizeof(str), "Seu cÛdigo de recuperaÁ„o de senha È <strong>%s</strong>", code);
		SendEmail(SERVER_EMAIL, inputtext, "RecuperaÁ„o da sua conta", str);

		SendClientMessage(playerid, COR_AZUL, "* Enviamos para o seu email um cÛdigo para mudanÁa da sua senha.");
		ShowPlayerDialog(playerid, RECOVER_PASSWORD_CODE, DIALOG_STYLE_INPUT, "DIGITE O C”DIGO", "{FF0000}Digite o cÛdigo que vocÍ recebeu em seu email.", "Confirmar", "Fechar");
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
			return ShowPlayerDialog(playerid, RECOVER_PASSWORD_CODE, DIALOG_STYLE_INPUT, "DIGITE O C”DIGO", "{FF0000}Digite o cÛdigo que vocÍ recebeu em seu email.\n\n{FF0000}* VocÍ digitou um cÛdigo inv·lido.", "Confirmar", "Fechar");
		
		new query[MAX_PLAYER_EMAIL + 100];
		mysql_format(getConexao(), query, sizeof(query), "SELECT codigo_recuperacao FROM "TABLE_USERS" WHERE `email`='%e' AND `codigo_recuperacao`='%e' LIMIT 1;", Jogador[playerid][Email], inputtext);
		new Cache:cache = mysql_query(getConexao(), query, true);

		if ( !cache_num_rows() )
			return cache_delete(cache), ShowPlayerDialog(playerid, RECOVER_PASSWORD_CODE, DIALOG_STYLE_INPUT, "DIGITE O C”DIGO", "{FF0000}Digite o cÛdigo que vocÍ recebeu em seu email.\n\n{FF0000}* N„o encontramos o cÛdigo que vocÍ digitou para sua conta.", "Confirmar", "Fechar");
		
		cache_delete(cache);

		ShowPlayerDialog(playerid, CHANGE_PASSWORD, DIALOG_STYLE_INPUT, "DIGITE SUA NOVA SENHA", "{"COR_BRANCO_INC"}Digite sua nova senha\n\n{FF0000}* AtenÁ„o: Essa senha ficar· visivel na tela para que vocÍ veja oque esteja digitando.", "Alterar", "Cancelar");
		return true;
	}
	SendClientMessage(playerid, COR_ERRO, "VocÍ cancelou a recuperaÁ„o de sua conta.");
	return true;
}

Dialog:CHANGE_PASSWORD(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		if(response)
		{
			if(strlen(inputtext) > MAX_PLAYER_PASSWORD || strlen(inputtext) < 5)
				return call::TD->SendTextMessageRegister(playerid, "~r~VocÍ digitou uma senha inv·lida.Digite uma senha de 5 · "#MAX_PLAYER_PASSWORD#"");

			format(Jogador[playerid][Senha], MAX_PLAYER_PASSWORD, inputtext);

			new query[70 + MAX_PLAYER_EMAIL + MAX_PLAYER_PASSWORD];
			
			mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `senha`='%s' WHERE `email`='%e'", Hash(inputtext), Jogador[playerid][Email]);
			mysql_tquery(getConexao(), query);

			SendClientMessage(playerid, COR_BRANCO, "ª Senha alterada com {"COR_VERDE_INC"}sucesso{"COR_BRANCO_INC"}.");
			return true;
		}
	}
	SendClientMessage(playerid, COR_ERRO, "VocÍ cancelou a recuperaÁ„o de sua conta.");
	return true;
}

Dialog:PLAYER_REGISTER_NICK(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if( !IsValidName(inputtext) )
			return call::TD->SendTextMessageRegister(playerid, "~r~VocÍ digitou um nome inv·lido, use Nome_Sobrenome.");

		new query[100 + MAX_PLAYER_EMAIL];
		mysql_format(getConexao(), query, sizeof(query), "SELECT `username` FROM "TABLE_USERS" WHERE `username`='%s' LIMIT 1;", inputtext);
		new Cache:cache = mysql_query(getConexao(), query, true), rows = cache_num_rows();
		cache_delete(cache);

		if(rows)
			return call::TD->SendTextMessageRegister(playerid, "~r~VocÍ digitou um nick que j· consta em nosso banco de dados.");
			
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
			return call::TD->SendTextMessageRegister(playerid, "~r~VocÍ digitou um email inv·lido.");

		new query[100 + MAX_PLAYER_EMAIL];
		mysql_format(getConexao(), query, sizeof(query), "SELECT `email` FROM "TABLE_USERS" WHERE `email`='%s' LIMIT 1;", inputtext);
		new Cache:cache = mysql_query(getConexao(), query, true), rows = cache_num_rows();
		cache_delete(cache);

		if(rows)
			return call::TD->SendTextMessageRegister(playerid, "~r~VocÍ digitou um email que j· consta em nosso banco de dados.");

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
		if(strlen(inputtext) > MAX_PLAYER_PASSWORD || strlen(inputtext) < 5)
			return call::TD->SendTextMessageRegister(playerid, "~r~VocÍ digitou uma senha inv·lida.Digite uma senha de 5 · "#MAX_PLAYER_PASSWORD#"");

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
			case 1: // Ajuda Profiss„o
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
			case 0: // Propriedades P˙blicas
			{
				new info[1024 * 3], Float:x, Float:y, Float:z, count;
				info = "Local\tDist‚ncia em Metros\n";
				foreach(new i: Propriedades)
				{
					call::PROPERTY->GetPropertyPos(i, x, y, z);
					format(info, sizeof(info), "%s%s\t%0.1f\n", info, call::PROPERTY->GetPropertyName(i), GetPlayerDistanceFromPoint(playerid, x, y, z));

					Select[playerid][count] = i;
					count++;
				}
				ShowPlayerDialog(playerid, PLAYER_GPS_MENU_PROPERTY, DIALOG_STYLE_TABLIST_HEADERS, "GPS ª PROPRIEDADES P⁄BLICAS", info, "Marcar", "Voltar");
				return true;
			}
			case 1: // Minha Empresa
			{
				new businessid = call::PLAYER->GetPlayerVarInt(playerid, EmpresaID);
				
				if(businessid == INVALID_BUSINESS_ID)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o possui uma empresa.");

				static Float:x, Float:y, Float:z;
				call::BUSINESS->GetBusinessPos(businessid, x, y, z);
				call::PLAYER->SetPlayerMarkGPS(playerid, x, y, z);

				SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Destino: {"COR_VERDE_INC"}Sua Empresa");
				SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Dist‚ncia: {"COR_VERDE_INC"}%d{"COR_BRANCO_INC"} Metro(s)", floatround(GetPlayerDistanceFromPoint(playerid, x, y, z)) );
				return true;
			}
			case 2: // Minha casa
			{
				new casaid = GetPlayerHouse(playerid);

				if(casaid == INVALID_HOUSE_ID)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o possui uma casa.");

				static Float:x, Float:y, Float:z;
				call::HOUSE->GetHousePos(casaid, x, y, z);
				call::PLAYER->SetPlayerMarkGPS(playerid, x, y, z);

				SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Destino: {"COR_VERDE_INC"}Sua Casa");
				SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Dist‚ncia: {"COR_VERDE_INC"}%d{"COR_BRANCO_INC"} Metro(s)", floatround(GetPlayerDistanceFromPoint(playerid, x, y, z)));
				return true;
			}
			case 3:	// Profissıes
			{
				new info[1024 * 3], jobname[50], Float:x, Float:y, Float:z, count;
				info = "Local\tDist‚ncia em Metros\n";
				foreach(new i: Profissoes)
				{
					call::JOB->GetJobPos(i, x, y, z);
					call::JOB->GetJobName(i, jobname);
					format(info, sizeof(info), "%s%s\t%0.1f\n", info, jobname, GetPlayerDistanceFromPoint(playerid, x, y, z));

					Select[playerid][count] = i;
					count++;
				}
				ShowPlayerDialog(playerid, PLAYER_GPS_MENU_JOBS, DIALOG_STYLE_TABLIST_HEADERS, "GPS ª PROPRIEDADES PROFISS’ES", info, "Marcar", "Voltar");
				return true;
			}
			case 4: // Concession·ria
			{
				ShowPlayerDialog(playerid, PLAYER_GPS_MENU_CONCE, DIALOG_STYLE_LIST, "GPS ª CONCESSION¡RIA", 
					"Concession·ria de Los Santos\n\
Concession·ria de Los Santos ( {"COR_VERMELHO_INC"}veiculos usados{"COR_BRANCO_INC"} )\n\
Concession·ria de San Fierro\n\
Concession·ria de San Fierro ( {"COR_VERMELHO_INC"}veiculos importados{"COR_BRANCO_INC"} )\n\
Concession·ria de Las Venturas\n\
Concession·ria de Los Santos ( {"COR_VERMELHO_INC"}Lowriders{"COR_BRANCO_INC"} )\n\
Concession·rio de Los Santos ( {"COR_VERMELHO_INC"}Barcos{"COR_BRANCO_INC"} )", "Marcar", "Voltar");
				return true;
			}
			default:
			{
				call::PLAYER->DisablePlayerGPS(playerid);
				DisablePlayerCheckpoint(playerid);
				SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Desligado.");
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

		SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Destino: {"COR_VERDE_INC"}%s", call::PROPERTY->GetPropertyName(propriedadeid));
		SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Dist‚ncia: {"COR_VERDE_INC"}%d{"COR_BRANCO_INC"} Metro(s)", floatround(GetPlayerDistanceFromPoint(playerid, x, y, z)) );
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

		SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Destino: {"COR_VERDE_INC"}%s", jobname);
		SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Dist‚ncia: {"COR_VERDE_INC"}%d{"COR_BRANCO_INC"} Metro(s)", floatround(GetPlayerDistanceFromPoint(playerid, x, y, z)) );
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
			case 0: // Concession·ria de Los Santos
			{
				call::PLAYER->SetPlayerMarkGPS(playerid, 557.0057, -1254.6377, 17.0865);
				SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Destino: {"COR_VERDE_INC"}Concession·ria de Los Santos");
				SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Dist‚ncia: {"COR_VERDE_INC"}%d{"COR_BRANCO_INC"} Metro(s)", floatround(GetPlayerDistanceFromPoint(playerid, 557.0057, -1254.6377, 17.0865)) );
				return true;
			}
			case 1: // Concession·ria de Los Santos Usados
			{
				call::PLAYER->SetPlayerMarkGPS(playerid, 2124.7351, -1121.0001, 25.3511);
				SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Destino: {"COR_VERDE_INC"}Concession·ria de Los Santos ( Veiculos Usados )");
				SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Dist‚ncia: {"COR_VERDE_INC"}%d{"COR_BRANCO_INC"} Metro(s)", floatround(GetPlayerDistanceFromPoint(playerid, 2124.7351, -1121.0001, 25.3511)) );
				return true;
			}
			case 2: // Concession·ria de San Fierro
			{
				call::PLAYER->SetPlayerMarkGPS(playerid, -1992.9824, 284.2329, 33.6549);
				SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Destino: {"COR_VERDE_INC"}Concession·ria de San Fierro");
				SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Dist‚ncia: {"COR_VERDE_INC"}%d{"COR_BRANCO_INC"} Metro(s)", floatround(GetPlayerDistanceFromPoint(playerid, -1992.9824, 284.2329, 33.6549)) );
				return true;
			}
			case 3: // Concession·ria de San Fierro Importadosa
			{
				call::PLAYER->SetPlayerMarkGPS(playerid, -1641.0930, 1202.0807, 7.2399);
				SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Destino: {"COR_VERDE_INC"}Concession·ria de San Fierro ( Importados )");
				SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Dist‚ncia: {"COR_VERDE_INC"}%d{"COR_BRANCO_INC"} Metro(s)", floatround(GetPlayerDistanceFromPoint(playerid, -1641.0930, 1202.0807, 7.2399)) );
				return true;
			}
			case 4: // Las Venturas
			{
				call::PLAYER->SetPlayerMarkGPS(playerid, 1943.2510, 2031.0604, 10.8203);
				SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Destino: {"COR_VERDE_INC"}Concession·ria de Las Venturas");
				SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Dist‚ncia: {"COR_VERDE_INC"}%d{"COR_BRANCO_INC"} Metro(s)", floatround(GetPlayerDistanceFromPoint(playerid, 1943.2510, 2031.0604, 10.8203)) );
				return true;
			}
			case 5: // Los Santos Lowriders
			{
				call::PLAYER->SetPlayerMarkGPS(playerid, 617.0251, -1497.1733, 14.8447);
				SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Destino: {"COR_VERDE_INC"}Concession·ria de Los Santos ( Lowriders )");
				SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Dist‚ncia: {"COR_VERDE_INC"}%d{"COR_BRANCO_INC"} Metro(s)", floatround(GetPlayerDistanceFromPoint(playerid, 617.0251, -1497.1733, 14.8447)) );
				return true;
			}
			case 6: // Los Santos Barcos
			{
				call::PLAYER->SetPlayerMarkGPS(playerid, 2591.8298,-2470.5718,3.0000);
				SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Destino: {"COR_VERDE_INC"}Concession·ria de Los Santos ( Barcos )");
				SendClientMessage(playerid, COR_VERDE, "GPS: {"COR_BRANCO_INC"}Dist‚ncia: {"COR_VERDE_INC"}%d{"COR_BRANCO_INC"} Metro(s)", floatround(GetPlayerDistanceFromPoint(playerid, 2591.8298,-2470.5718,3.0000)) );
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

Dialog:VEHICLE_RADIO_STATION(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if ( !IsPlayerInAnyVehicle(playerid) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o est· em um veiculo.");

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
				
				str = "PosiÁ„o\tNome\tDinheiro\n";
				for(new i, r=cache_num_rows(); i < r; i++)
				{
					cache_get_value_name(i, "username", pName, MAX_PLAYER_NAME);
					cache_get_value_name_int(i, "total", dinheiro);

					format(str, sizeof(str), "%s{"COR_AZUL_INC"}%d∞\t{"COR_LARANJA_INC"}%s\t{"COR_VERDE_INC"}R$%s\n", str, i + 1, pName, RealStr(dinheiro));
				}
				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "TOP GRANA", str, "OK", "");
			}
			case 1: // TOP LEVEL
			{
				new pName[MAX_PLAYER_NAME], level;

				mysql_query(getConexao(), "SELECT `username`,`level` FROM "TABLE_USERS" WHERE `admin`<'1' ORDER BY `level` DESC LIMIT "#MAX_TOPS";"); // "
				
				str = "PosiÁ„o\tNome\tLevel\n";
				for(new i, r=cache_num_rows(); i < r; i++)
				{
					cache_get_value_name(i, "username", pName, MAX_PLAYER_NAME);
					cache_get_value_name_int(i, "level", level);

					format(str, sizeof(str), "%s{"COR_AZUL_INC"}%d∞\t{"COR_LARANJA_INC"}%s\t{"COR_VERDE_INC"}%d\n", str, i + 1, pName, level);
				}
				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "TOP GRANA", str, "OK", "");
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
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o ùest· proximo a uma bomba de combustÌvel.");

		if(!IsPlayerInAnyVehicle(playerid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o ùest· em um veiculo.");
		
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Somente o motorista pode abastecer o veiculo.");

		new vehicleid = GetPlayerVehicleID(playerid), model = GetVehicleModel(vehicleid);

		if(call::VH->GetVehicleFuel(vehicleid) >= GetVehicleMaxFuel(model))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | O Veiculo ùest· com o tanque cheio.");

		if(GetPVarInt(playerid, "abastecendo"))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ ùj· ùest· abastecendo um veiculo.");

		if(GetVehicleParams(vehicleid, VEHICLE_TYPE_ENGINE) == VEHICLE_PARAMS_ON)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Desligue o motor do veiculo para abastecer.");

		if(!IsNumeric(inputtext) || isnull(inputtext))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ deve digitar um valor v·lido."), callcmd::abastecer(playerid);

		new quantidade = strval(inputtext);

		if ( quantidade <= 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ deve digitar um valor maior que 0."), callcmd::abastecer(playerid);

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

				ShowPlayerDialog(playerid, CONFIG_HUD, DIALOG_STYLE_TABLIST, "{"COR_DISABLE_INC"}CONFIGURA«’ES DO USU¡RIO  {"COR_BRANCO_INC"}HUD", "Status\t%s\nData e Hora\t%s", "Selecionar", "Voltar",
					(DOF2::GetInt(file, TAG_MOSTRAR_STATUS) ? ("{"COR_VERDE_INC"}ON") : ("{"COR_VERMELHO_INC"}OFF") ),
					(DOF2::GetInt(file, TAG_MOSTRAR_DATA) ? ("{"COR_VERDE_INC"}ON") : ("{"COR_VERMELHO_INC"}OFF") )
				);
				return true;
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
					call::TD->ShowPlayerHudStatus(playerid);
				else
					call::TD->HidePlayerHudStatus(playerid);

				SendClientMessage(playerid, COR_SISTEMA, "ª VocÍ {"COR_BRANCO_INC"}%s{"COR_SISTEMA_INC"} o status.", (DOF2::GetInt(file, TAG_MOSTRAR_STATUS) ? ("desocultou") : ("ocultou") ) );
			}
			case 1: // data
			{
				DOF2::SetInt(file, TAG_MOSTRAR_DATA, (DOF2::GetInt(file, TAG_MOSTRAR_DATA) ? 0 : 1) );

				if ( DOF2::GetInt(file, TAG_MOSTRAR_DATA) )
					call::TD->ShowPlayerHudData(playerid);
				else
					call::TD->HidePlayerHudData(playerid);

				SendClientMessage(playerid, COR_SISTEMA, "ª VocÍ {"COR_BRANCO_INC"}%s{"COR_SISTEMA_INC"} a data e hora.", (DOF2::GetInt(file, TAG_MOSTRAR_DATA) ? ("desocultou") : ("ocultou") ) );
			}
		}
		ShowPlayerDialog(playerid, CONFIG_HUD, DIALOG_STYLE_TABLIST, "{"COR_DISABLE_INC"}CONFIG CONTA ª {"COR_BRANCO_INC"}HUD", "Status\t%s\nData e Hora\t%s", "Selecionar", "Voltar",
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
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ j· tem um neon instalado, remova-o.");

				SetPVarInt(playerid, "AddNeon", 1);
	            NeonEsquerda[vehicleid] = CreateDynamicObject(18647, 0, 0, 0, 0, 0, 0), NeonDireita[vehicleid] = CreateDynamicObject(18647, 0, 0, 0, 0, 0, 0);
	            AttachDynamicObjectToVehicle(NeonEsquerda[vehicleid], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0), AttachDynamicObjectToVehicle(NeonDireita[vehicleid], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, COR_AVISO, "Info: Neon instalado com sucesso.");
			}
			case 1: //Neon azul
			{
				if(GetPVarInt(playerid, "AddNeon") == 1)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ j· tem um neon instalado, remova-o.");

				SetPVarInt(playerid, "AddNeon", 1);
	            NeonEsquerda[vehicleid] = CreateDynamicObject(18648, 0, 0, 0, 0, 0, 0), NeonDireita[vehicleid] = CreateDynamicObject(18648, 0, 0, 0, 0, 0, 0);
	            AttachDynamicObjectToVehicle(NeonEsquerda[vehicleid], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0), AttachDynamicObjectToVehicle(NeonDireita[vehicleid], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, COR_AVISO, "Info: Neon instalado com sucesso.");
			}
			case 2: //Neon verde
			{
				if(GetPVarInt(playerid, "AddNeon") == 1)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ j· tem um neon instalado, remova-o.");

				SetPVarInt(playerid, "AddNeon", 1);
	            NeonEsquerda[vehicleid] = CreateDynamicObject(18649, 0, 0, 0, 0, 0, 0), NeonDireita[vehicleid] = CreateDynamicObject(18649, 0, 0, 0, 0, 0, 0);
	            AttachDynamicObjectToVehicle(NeonEsquerda[vehicleid], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0), AttachDynamicObjectToVehicle(NeonDireita[vehicleid], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, COR_AVISO, "Info: Neon instalado com sucesso.");
			}
			case 3: //Neon amarelo
			{
				if(GetPVarInt(playerid, "AddNeon") == 1)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ j· tem um neon instalado, remova-o.");

				SetPVarInt(playerid, "AddNeon", 1);
	            NeonEsquerda[vehicleid] = CreateDynamicObject(18650, 0, 0, 0, 0, 0, 0), NeonDireita[vehicleid] = CreateDynamicObject(18650, 0, 0, 0, 0, 0, 0);
	            AttachDynamicObjectToVehicle(NeonEsquerda[vehicleid], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0), AttachDynamicObjectToVehicle(NeonDireita[vehicleid], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, COR_AVISO, "Info: Neon instalado com sucesso.");
			}
			case 4: //Neon rosa
			{
				if(GetPVarInt(playerid, "AddNeon") == 1)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ j· tem um neon instalado, remova-o.");

				SetPVarInt(playerid, "AddNeon", 1);
	            NeonEsquerda[vehicleid] = CreateDynamicObject(18651, 0, 0, 0, 0, 0, 0), NeonDireita[vehicleid] = CreateDynamicObject(18651, 0, 0, 0, 0, 0, 0);
	            AttachDynamicObjectToVehicle(NeonEsquerda[vehicleid], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0), AttachDynamicObjectToVehicle(NeonDireita[vehicleid], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, COR_AVISO, "Info: Neon instalado com sucesso.");
			}
			case 5: //Neon branco
			{
				if(GetPVarInt(playerid, "AddNeon") == 1)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ j· tem um neon instalado, remova-o.");

				SetPVarInt(playerid, "AddNeon", 1);
	            NeonEsquerda[vehicleid] = CreateDynamicObject(18652, 0, 0, 0, 0, 0, 0), NeonDireita[vehicleid] = CreateDynamicObject(18652, 0, 0, 0, 0, 0, 0);
	            AttachDynamicObjectToVehicle(NeonEsquerda[vehicleid], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0), AttachDynamicObjectToVehicle(NeonDireita[vehicleid], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, COR_AVISO, "Info: Neon removido com sucesso.");
			}
			case 6: //Neon policial
			{
				if(GetPVarInt(playerid, "AddNeon") == 1)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ j· tem um neon instalado, remova-o.");

				SetPVarInt(playerid, "AddNeon", 1);
	            NeonEsquerda[vehicleid] = CreateDynamicObject(18646, 0, 0, 0, 0, 0, 0), NeonDireita[vehicleid] = CreateDynamicObject(18646, 0, 0, 0, 0, 0, 0);
	            AttachDynamicObjectToVehicle(NeonEsquerda[vehicleid], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0), AttachDynamicObjectToVehicle(NeonDireita[vehicleid], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, COR_AVISO, "Info: Neon removido com sucesso.");
			}
			case 7:
			{
				if(GetPVarInt(playerid, "AddNeon") == 0)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem um neon instalado.");

				DeletePVar(playerid, "AddNeon");
				DestroyDynamicObject(NeonEsquerda[vehicleid]), DestroyDynamicObject(NeonDireita[vehicleid]);
				NeonEsquerda[vehicleid] = 0, NeonDireita[vehicleid] = 0;     
			}	
		}
	}
	return true;
}


Dialog:MENU_CASH(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		ShowPlayerDialog(playerid, MENU_CASH_ATIVAR, DIALOG_STYLE_INPUT, "MENU BITCOINS {"COR_AZUL_INC"}->{"COR_BRANCO_INC"} ATIVAR", 
			"{"COR_BRANCO_INC"}Digite o cÛdigo recebido pelo paypla.", "Ativar", "voltar");
		return true;
	}
	return true;
}

