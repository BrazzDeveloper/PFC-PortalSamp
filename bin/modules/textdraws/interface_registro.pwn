//Global TextDraws: 


static Text:TDEditor_TD[16], PlayerText:TDEditor_PTD[MAX_PLAYERS][6];

static CLOSE, NICK, EMAIL, SENHA, SEXO, BUTTON, MESSAGE_ERRO;

#include <YSI_Coding\y_hooks>
hook OnGameModeInit()
{
	new i;

	TDEditor_TD[i] = TextDrawCreate(206.603210, 139.650039, "box"); // Base de fora ou border
	TextDrawLetterSize(TDEditor_TD[i], 0.000000, 23.118591);
	TextDrawTextSize(TDEditor_TD[i], 504.000000, 0.000000);
	TextDrawAlignment(TDEditor_TD[i], 1);
	TextDrawColor(TDEditor_TD[i], -1);
	TextDrawUseBox(TDEditor_TD[i], 1);
	TextDrawBoxColor(TDEditor_TD[i], TD_COLOR_BORDER);
	TextDrawSetShadow(TDEditor_TD[i], 0);
	TextDrawSetOutline(TDEditor_TD[i], 0);
	TextDrawBackgroundColor(TDEditor_TD[i], 255);
	TextDrawFont(TDEditor_TD[i], 1);
	TextDrawSetProportional(TDEditor_TD[i], 1);
	TextDrawSetShadow(TDEditor_TD[i], 0);

	++i;
	TDEditor_TD[i] = TextDrawCreate(208.008773, 140.800460, "box"); // Base principal.
	TextDrawLetterSize(TDEditor_TD[i], 0.000000, 22.956035);
	TextDrawTextSize(TDEditor_TD[i], 503.419555, 0.000000);
	TextDrawAlignment(TDEditor_TD[i], 1);
	TextDrawColor(TDEditor_TD[i], 0);
	TextDrawUseBox(TDEditor_TD[i], 1);
	TextDrawBoxColor(TDEditor_TD[i], TD_COLOR_BASE);
	TextDrawSetShadow(TDEditor_TD[i], 0);
	TextDrawSetOutline(TDEditor_TD[i], 0);
	TextDrawBackgroundColor(TDEditor_TD[i], 255);
	TextDrawFont(TDEditor_TD[i], 1);
	TextDrawSetProportional(TDEditor_TD[i], 1);
	TextDrawSetShadow(TDEditor_TD[i], 0);

	++i;
	TDEditor_TD[i] = TextDrawCreate(207.677154, 141.000015, "box"); // box do title primary
	TextDrawLetterSize(TDEditor_TD[i], 0.000000, 0.775838);
	TextDrawTextSize(TDEditor_TD[i], 503.409790, 0.000000);
	TextDrawAlignment(TDEditor_TD[i], 1);
	TextDrawColor(TDEditor_TD[i], -1);
	TextDrawUseBox(TDEditor_TD[i], 1);
	TextDrawBoxColor(TDEditor_TD[i], TD_WIDGET_TITLE_PRIMARY);
	TextDrawSetShadow(TDEditor_TD[i], 0);
	TextDrawSetOutline(TDEditor_TD[i], 0);
	TextDrawBackgroundColor(TDEditor_TD[i], 255);
	TextDrawFont(TDEditor_TD[i], 1);
	TextDrawSetProportional(TDEditor_TD[i], 1);
	TextDrawSetShadow(TDEditor_TD[i], 0);

	++i;
	TDEditor_TD[i] = TextDrawCreate(207.777160, 152.600723, "box"); // box do title secundary
	TextDrawLetterSize(TDEditor_TD[i], 0.000000, 0.775838);
	TextDrawTextSize(TDEditor_TD[i], 503.619781, 0.000000);
	TextDrawAlignment(TDEditor_TD[i], 1);
	TextDrawColor(TDEditor_TD[i], -1);
	TextDrawUseBox(TDEditor_TD[i], 1);
	TextDrawBoxColor(TDEditor_TD[i], TD_WIDGET_TITLE_SECONDARY);
	TextDrawSetShadow(TDEditor_TD[i], 0);
	TextDrawSetOutline(TDEditor_TD[i], 0);
	TextDrawBackgroundColor(TDEditor_TD[i], 255);
	TextDrawFont(TDEditor_TD[i], 1);
	TextDrawSetProportional(TDEditor_TD[i], 1);
	TextDrawSetShadow(TDEditor_TD[i], 0);

	++i;
	TDEditor_TD[i] = TextDrawCreate(207.977218, 141.066558, "box");
	TextDrawLetterSize(TDEditor_TD[i], 0.000000, 2.059177);
	TextDrawTextSize(TDEditor_TD[i], 503.439941, 0.000000);
	TextDrawAlignment(TDEditor_TD[i], 1);
	TextDrawColor(TDEditor_TD[i], -1);
	TextDrawUseBox(TDEditor_TD[i], 1);
	TextDrawBoxColor(TDEditor_TD[i], 50);
	TextDrawSetShadow(TDEditor_TD[i], 0);
	TextDrawSetOutline(TDEditor_TD[i], 0);
	TextDrawBackgroundColor(TDEditor_TD[i], 255);
	TextDrawFont(TDEditor_TD[i], 1);
	TextDrawSetProportional(TDEditor_TD[i], 1);
	TextDrawSetShadow(TDEditor_TD[i], 0);

	++i;
	TDEditor_TD[i] = TextDrawCreate(207.882705, 142.750045, " REGISTRO");
	TextDrawLetterSize(TDEditor_TD[i], 0.400000, 1.580000);
	TextDrawTextSize(TDEditor_TD[i], 503.340087, 0.000000);
	TextDrawAlignment(TDEditor_TD[i], 1);
	TextDrawColor(TDEditor_TD[i], -1);
	TextDrawUseBox(TDEditor_TD[i], 1);
	TextDrawBoxColor(TDEditor_TD[i], 0);
	TextDrawSetShadow(TDEditor_TD[i], 0);
	TextDrawSetOutline(TDEditor_TD[i], 1);
	TextDrawBackgroundColor(TDEditor_TD[i], 255);
	TextDrawFont(TDEditor_TD[i], 2);
	TextDrawSetProportional(TDEditor_TD[i], 1);
	TextDrawSetShadow(TDEditor_TD[i], 0);

	++i, CLOSE = i;
	TDEditor_TD[i] = TextDrawCreate(471.599426, 139.566619, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[i], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[i], 22.000000, 21.339996);
	TextDrawAlignment(TDEditor_TD[i], 1);
	TextDrawColor(TDEditor_TD[i], 0);
	TextDrawSetShadow(TDEditor_TD[i], 0);
	TextDrawSetOutline(TDEditor_TD[i], 0);
	TextDrawBackgroundColor(TDEditor_TD[i], 255);
	TextDrawFont(TDEditor_TD[i], 4);
	TextDrawSetProportional(TDEditor_TD[i], 0);
	TextDrawSetShadow(TDEditor_TD[i], 0);
	TextDrawSetSelectable(TDEditor_TD[i], true);

	++i;
	TDEditor_TD[i] = TextDrawCreate(477.408691, 143.133316, "X");
	TextDrawLetterSize(TDEditor_TD[i], 0.400000, 1.600000);
	TextDrawAlignment(TDEditor_TD[i], 1);
	TextDrawColor(TDEditor_TD[i], -1);
	TextDrawSetShadow(TDEditor_TD[i], 0);
	TextDrawSetOutline(TDEditor_TD[i], 1);
	TextDrawBackgroundColor(TDEditor_TD[i], 255);
	TextDrawFont(TDEditor_TD[i], 1);
	TextDrawSetProportional(TDEditor_TD[i], 1);
	TextDrawSetShadow(TDEditor_TD[i], 0);

	++i;
	TDEditor_TD[i] = TextDrawCreate(213.162429, 187.083328, "nick");
	TextDrawLetterSize(TDEditor_TD[i], 0.325973, 1.203333);
	TextDrawAlignment(TDEditor_TD[i], 1);
	TextDrawColor(TDEditor_TD[i], -1);
	TextDrawSetShadow(TDEditor_TD[i], 0);
	TextDrawSetOutline(TDEditor_TD[i], 1);
	TextDrawBackgroundColor(TDEditor_TD[i], 255);
	TextDrawFont(TDEditor_TD[i], 2);
	TextDrawSetProportional(TDEditor_TD[i], 1);
	TextDrawSetShadow(TDEditor_TD[i], 0);

	++i, NICK = i;
	TDEditor_TD[i] = TextDrawCreate(212.862625, 201.666656, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[i], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[i], 110.000000, 13.000000);
	TextDrawAlignment(TDEditor_TD[i], 1);
	TextDrawColor(TDEditor_TD[i], TD_COLOR_SELECT_NORMAL);
	TextDrawSetShadow(TDEditor_TD[i], 0);
	TextDrawSetOutline(TDEditor_TD[i], 0);
	TextDrawBackgroundColor(TDEditor_TD[i], 255);
	TextDrawFont(TDEditor_TD[i], 4);
	TextDrawSetProportional(TDEditor_TD[i], 0);
	TextDrawSetShadow(TDEditor_TD[i], 0);
	TextDrawSetSelectable(TDEditor_TD[i], true);


	++i;
	TDEditor_TD[i] = TextDrawCreate(213.162429, 218.585250, "email");
	TextDrawLetterSize(TDEditor_TD[i], 0.325973, 1.203333);
	TextDrawAlignment(TDEditor_TD[i], 1);
	TextDrawColor(TDEditor_TD[i], -1);
	TextDrawSetShadow(TDEditor_TD[i], 0);
	TextDrawSetOutline(TDEditor_TD[i], 1);
	TextDrawBackgroundColor(TDEditor_TD[i], 255);
	TextDrawFont(TDEditor_TD[i], 2);
	TextDrawSetProportional(TDEditor_TD[i], 1);
	TextDrawSetShadow(TDEditor_TD[i], 0);

	++i, EMAIL = i;
	TDEditor_TD[i] = TextDrawCreate(212.862625, 233.168579, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[i], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[i], 110.000000, 13.000000);
	TextDrawAlignment(TDEditor_TD[i], 1);
	TextDrawColor(TDEditor_TD[i], TD_COLOR_SELECT_NORMAL);
	TextDrawSetShadow(TDEditor_TD[i], 0);
	TextDrawSetOutline(TDEditor_TD[i], 0);
	TextDrawBackgroundColor(TDEditor_TD[i], 255);
	TextDrawFont(TDEditor_TD[i], 4);
	TextDrawSetProportional(TDEditor_TD[i], 0);
	TextDrawSetShadow(TDEditor_TD[i], 0);
	TextDrawSetSelectable(TDEditor_TD[i], true);

	++i;
	TDEditor_TD[i] = TextDrawCreate(213.162429, 251.587265, "senha");
	TextDrawLetterSize(TDEditor_TD[i], 0.325973, 1.203333);
	TextDrawAlignment(TDEditor_TD[i], 1);
	TextDrawColor(TDEditor_TD[i], -1);
	TextDrawSetShadow(TDEditor_TD[i], 0);
	TextDrawSetOutline(TDEditor_TD[i], 1);
	TextDrawBackgroundColor(TDEditor_TD[i], 255);
	TextDrawFont(TDEditor_TD[i], 2);
	TextDrawSetProportional(TDEditor_TD[i], 1);
	TextDrawSetShadow(TDEditor_TD[i], 0);

	++i, SENHA = i;
	TDEditor_TD[i] = TextDrawCreate(212.862625, 266.170593, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[i], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[i], 110.000000, 13.000000);
	TextDrawAlignment(TDEditor_TD[i], 1);
	TextDrawColor(TDEditor_TD[i], TD_COLOR_SELECT_NORMAL);
	TextDrawSetShadow(TDEditor_TD[i], 0);
	TextDrawSetOutline(TDEditor_TD[i], 0);
	TextDrawBackgroundColor(TDEditor_TD[i], 255);
	TextDrawFont(TDEditor_TD[i], 4);
	TextDrawSetProportional(TDEditor_TD[i], 0);
	TextDrawSetShadow(TDEditor_TD[i], 0);
	TextDrawSetSelectable(TDEditor_TD[i], true);

	++i, BUTTON = i;
	TDEditor_TD[i] = TextDrawCreate(213.000000, 283.733184, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[i], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[i], 65.000000, 26.229995);
	TextDrawAlignment(TDEditor_TD[i], 1);
	TextDrawColor(TDEditor_TD[i], TD_COLOR_SELECT_NORMAL);
	TextDrawSetShadow(TDEditor_TD[i], 0);
	TextDrawSetOutline(TDEditor_TD[i], 0);
	TextDrawBackgroundColor(TDEditor_TD[i], 255);
	TextDrawFont(TDEditor_TD[i], 4);
	TextDrawSetProportional(TDEditor_TD[i], 0);
	TextDrawSetShadow(TDEditor_TD[i], 0);
	TextDrawSetSelectable(TDEditor_TD[i], true);

	++i;
	TDEditor_TD[i] = TextDrawCreate(246.000000, 288.583251, "registrar");
	TextDrawLetterSize(TDEditor_TD[i], 0.200000, 1.500000);
	TextDrawTextSize(TDEditor_TD[i], 0.000000, 61.000000);
	TextDrawAlignment(TDEditor_TD[i], 2);
	TextDrawColor(TDEditor_TD[i], -1);
	TextDrawUseBox(TDEditor_TD[i], 1);
	TextDrawBoxColor(TDEditor_TD[i], 0);
	TextDrawSetShadow(TDEditor_TD[i], 0);
	TextDrawSetOutline(TDEditor_TD[i], 0);
	TextDrawBackgroundColor(TDEditor_TD[i], 255);
	TextDrawFont(TDEditor_TD[i], 2);
	TextDrawSetProportional(TDEditor_TD[i], 1);
	TextDrawSetShadow(TDEditor_TD[i], 0);
}

hook OnPlayerConnect(playerid)
{
	new i;

	TDEditor_PTD[playerid][i] = CreatePlayerTextDraw(playerid, 431.309204, 189.250076, "sexo: ~b~masculino");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][i], 0.200000, 0.700000);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][i], 0.000000, 85.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][i], 2);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][i], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][i], 1);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][i], 150);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][i], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][i], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][i], 2);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][i], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][i], 1);

	++i, SEXO = i;
	TDEditor_PTD[playerid][i] = CreatePlayerTextDraw(playerid, 387.448425, 187.567047, ""); // Skin
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][i], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][i], 88.000000, 91.809982);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][i], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][i], -1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][i], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][i], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][i], TD_COLOR_SELECT_NORMAL);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][i], 5);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][i], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][i], 0);
	PlayerTextDrawSetSelectable(playerid, TDEditor_PTD[playerid][i], true);
	PlayerTextDrawSetPreviewModel(playerid, TDEditor_PTD[playerid][i], Jogador[playerid][Skin] = SKIN_MASCULINA );
	PlayerTextDrawSetPreviewRot(playerid, TDEditor_PTD[playerid][i], 0.000000, 0.000000, 0.000000, 1.000000);

	++i;
	TDEditor_PTD[playerid][i] = CreatePlayerTextDraw(playerid, 268.185455, 203.783386, "digite seu nick" ); // max len 25 - nick
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][i], 0.200000, 0.900000);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][i], 0.000000, 106.359985);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][i], 2);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][i], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][i], 1);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][i], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][i], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][i], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][i], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][i], 2);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][i], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][i], 0);

	++i;
	TDEditor_PTD[playerid][i] = CreatePlayerTextDraw(playerid, 268.185455, 235.635330, "digite seu email"); // max len 25 - email
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][i], 0.200000, 0.900000);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][i], 5.610000, 106.359985);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][i], 2);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][i], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][i], 1);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][i], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][i], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][i], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][i], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][i], 2);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][i], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][i], 0);

	++i;
	TDEditor_PTD[playerid][i] = CreatePlayerTextDraw(playerid, 268.185455, 268.483520, "digite sua senha"); // max len 9 - senha
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][i], 0.200000, 0.900000);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][i], 5.610000, 106.359985);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][i], 2);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][i], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][i], 1);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][i], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][i], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][i], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][i], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][i], 2);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][i], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][i], 0);

	++i, MESSAGE_ERRO = i;
	TDEditor_PTD[playerid][i] = CreatePlayerTextDraw(playerid, 208.000000, 319.000000, ""); // Erro mensagem
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][i], 0.200000, 1.300000);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][i], 503.359924, 0.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][i], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][i], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][i], 1);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][i], 50);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][i], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][i], 1);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][i], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][i], 1);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][i], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][i], 0);
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	call::TD->HideTextMessageRegister(playerid);
	if(Dialog_Opened(playerid))
		return false;

	if(playertextid == TDEditor_PTD[playerid][SEXO])
	{
		ShowPlayerDialog(playerid, PLAYER_REGISTER_SEXO, DIALOG_STYLE_LIST, "{"COR_DISABLE_INC"}REGISTRO » {"COR_BRANCO_INC"}SEXO", "{2EB8FF}Masculino\n{DB46E0}Feminino", "Confirmar", "Voltar");
		return true;
	}
	return false;
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(INVALID_TEXT_DRAW == _:clickedid)
	{
		if(GetPVarInt(playerid, "ShowPlayerRegister"))
		{
			Jogador[playerid][Nome] = EOS;
			Jogador[playerid][Email] = EOS;
			Jogador[playerid][Senha] = EOS;

			call::TD->HidePlayerRegister(playerid);
		}

		return true;
	}
	
	if( Dialog_Opened(playerid) )
		return false;

	call::TD->HideTextMessageRegister(playerid);
	if(clickedid == TDEditor_TD[CLOSE]) // Fechar
	{
		Jogador[playerid][Nome] = EOS;
		Jogador[playerid][Email] = EOS;
		Jogador[playerid][Senha] = EOS;
		
		call::TD->HidePlayerRegister(playerid);
		return true;
	}
	else if(clickedid == TDEditor_TD[NICK])
	{
		ShowPlayerDialog(playerid, PLAYER_REGISTER_NICK, DIALOG_STYLE_INPUT, "{"COR_DISABLE_INC"}REGISTRO » {"COR_BRANCO_INC"}NICK", "{"COR_BRANCO_INC"}Digite um {"COR_SISTEMA_INC"}NOME{"COR_BRANCO_INC"} para seu personagem.", "Confirmar", "Sair");
		return true;
	}
	else if(clickedid == TDEditor_TD[EMAIL])
	{
		ShowPlayerDialog(playerid, PLAYER_REGISTER_EMAIL, DIALOG_STYLE_INPUT, "{"COR_DISABLE_INC"}REGISTRO » {"COR_BRANCO_INC"}EMAIL", "{"COR_BRANCO_INC"}Digite um {"COR_SISTEMA_INC"}EMAIL{"COR_BRANCO_INC"} para cadastrarmos em nosso banco de dados.", "Confirmar", "Sair");
		return true;
	}
	else if(clickedid == TDEditor_TD[SENHA])
	{
		ShowPlayerDialog(playerid, PLAYER_REGISTER_PASSWORD, DIALOG_STYLE_PASSWORD, "{"COR_DISABLE_INC"}REGISTRO » {"COR_BRANCO_INC"}SENHA", "{"COR_BRANCO_INC"}Digite uma senha para protegermos sua conta.", "Confirmar", "Voltar");
		return true;
	} 
	else if(clickedid == TDEditor_TD[BUTTON])
	{
		new query[1024], Cache:cache, rows;
		
		mysql_format(getConexao(), query, sizeof(query), "SELECT `username` FROM "TABLE_USERS" WHERE `username`='%s' LIMIT 1;", Jogador[playerid][Nome]);
		cache = mysql_query(getConexao(), query, true), rows = cache_num_rows(), cache_delete(cache);
		if(rows)
			return call::TD->SendTextMessageRegister(playerid, "~r~Você digitou um nick que já consta em nosso banco de dados.");

		if(isnull(Jogador[playerid][Email]))
			return call::TD->SendTextMessageRegister(playerid, "~r~Você precisa digitar um email.");

		if ( !IsValidName(Jogador[playerid][Nome]) )
			return call::TD->SendTextMessageRegister(playerid, "~r~Você precisa escolher um nome válido, como ex: Nome_Sobrenome.");

		mysql_format(getConexao(), query, sizeof(query), "SELECT `email` FROM "TABLE_USERS" WHERE `email`='%s' LIMIT 1;", Jogador[playerid][Email]);
		cache = mysql_query(getConexao(), query, true), rows = cache_num_rows(), cache_delete(cache);
		if(rows)
			return call::TD->SendTextMessageRegister(playerid, "~r~Você digitou um email que já consta em nosso banco de dados.");

		if(isnull(Jogador[playerid][Senha]))
			return call::TD->SendTextMessageRegister(playerid, "~r~Você precisa digitar uma senha.");

		CleanChat(playerid);
		SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Registrando...");
		call::TD->HidePlayerLogin(playerid);
		call::TD->HidePlayerRegister(playerid, true);

		new ip[16];
		GetPlayerIp(playerid, ip, sizeof(ip));
		mysql_format(getConexao(), query, sizeof(query), "INSERT INTO "TABLE_USERS" (`username`,`email`,`senha`,`ip`,`sexo`,`skin`,`data_registro`,`ultimo_login`,`spawn_x`,`spawn_y`,`spawn_z`,`spawn_a`,`level`,`dinheiro`)VALUES('%e','%e','%s','%s','%d','%d',NOW(),NOW(),'%0.3f','%0.3f','%0.3f','%0.3f','1','%d');",
			Jogador[playerid][Nome], Jogador[playerid][Email], Hash(Jogador[playerid][Senha]), ip, Jogador[playerid][Sexo], Jogador[playerid][Skin], SPAWN_X, SPAWN_Y, SPAWN_Z, SPAWN_A, SPAWN_MONEY);
		
		if ( !mysql_tquery(getConexao(), query, "OnPlayerRegister", "i", playerid) )
			return SendClientMessage(playerid, TD_COLOR_BORDER, "| ERRO | Não foi possivel criar sua conta, por favor informe o erro ao Administrador.");
		return true;
	}
	return true;
}

function TD::ShowPlayerRegister(playerid)
{
	for(new i; i < sizeof(TDEditor_TD); i++){
		TextDrawShowForPlayer(playerid, TDEditor_TD[i]);
	}
	for(new i; i < sizeof(TDEditor_PTD[]); i++){
		PlayerTextDrawShow(playerid, TDEditor_PTD[playerid][i]);
	}
	SetPVarInt(playerid, "ShowPlayerRegister", 1);
}

function TD::HidePlayerRegister(playerid, bool:destroyed=false)
{
	for(new i; i < sizeof(TDEditor_TD); i++){
		TextDrawHideForPlayer(playerid, TDEditor_TD[i]);
	}
	for(new i; i < sizeof(TDEditor_PTD[]); i++){
		PlayerTextDrawHide(playerid, TDEditor_PTD[playerid][i]);
		if(destroyed)
			PlayerTextDrawDestroy(playerid, TDEditor_PTD[playerid][i]), TDEditor_PTD[playerid][i] = PlayerText:0;
	}
	DeletePVar(playerid, "ShowPlayerRegister");
}

function TD::SendTextMessageRegister(playerid, str[])
{
	PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][MESSAGE_ERRO], str);
	return true;
}

function TD::HideTextMessageRegister(playerid)
{
	PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][MESSAGE_ERRO], "_");
	return true;
}

function TD::UpdateTextDrawsRegister(playerid)
{
	new str[200];

	format(str, sizeof(str), "sexo: %s", (Jogador[playerid][Sexo] == SEXO_FEMININO ? ("~h~~h~~p~Feminino"):("~h~~h~~b~Masculino") ));
	PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][0], str); // Muda texto da skin

	PlayerTextDrawSetPreviewModel(playerid, TDEditor_PTD[playerid][SEXO], (Jogador[playerid][Sexo] != SEXO_FEMININO ? SKIN_MASCULINA : SKIN_FEMININA));
	PlayerTextDrawShow(playerid, TDEditor_PTD[playerid][SEXO]);

	if(isnull(Jogador[playerid][Nome]))
		PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][2], "digite seu nick"); 
	else
		PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][2], Jogador[playerid][Nome]); 

	if(isnull(Jogador[playerid][Email]))
		PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][3], "digite seu email"); 
	else
		PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][3], Jogador[playerid][Email]); 

	if(isnull(Jogador[playerid][Senha]))
		PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][4], "digite sua senha"); 
	else
	{
		new senha[9];
		for(new i, len = strlen(Jogador[playerid][Senha]); i < len; i++){

			if(i >= sizeof(senha))
				break;

			senha[i] = ']';
		}
		PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][4], senha); 
	}
	
	return true;
}