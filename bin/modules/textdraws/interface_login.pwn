
static 
	Text:TDEditor_TD[14], PlayerText:TDEditor_PTD[MAX_PLAYERS][2],
	bool:InLogin[MAX_PLAYERS char]

;


/**
*
*	Hooks
*
**/
#include <YSI_Coding\y_hooks>
hook OnGameModeInit()
{
	TDEditor_TD[0] = TextDrawCreate(206.603210, 139.650039, "box"); // Base de fora ou border
	TextDrawLetterSize(TDEditor_TD[0], 0.000000, 23.118591);
	TextDrawTextSize(TDEditor_TD[0], 504.000000, 0.000000);
	TextDrawAlignment(TDEditor_TD[0], 1);
	TextDrawColor(TDEditor_TD[0], -1);
	TextDrawUseBox(TDEditor_TD[0], 1);
	TextDrawBoxColor(TDEditor_TD[0], TD_COLOR_BORDER);
	TextDrawSetShadow(TDEditor_TD[0], 0);
	TextDrawSetOutline(TDEditor_TD[0], 0);
	TextDrawBackgroundColor(TDEditor_TD[0], 255);
	TextDrawFont(TDEditor_TD[0], 1);
	TextDrawSetProportional(TDEditor_TD[0], 1);
	TextDrawSetShadow(TDEditor_TD[0], 0);

	TDEditor_TD[1] = TextDrawCreate(208.008773, 140.800460, "box"); // Base principal.
	TextDrawLetterSize(TDEditor_TD[1], 0.000000, 22.956035);
	TextDrawTextSize(TDEditor_TD[1], 503.419555, 0.000000);
	TextDrawAlignment(TDEditor_TD[1], 1);
	TextDrawColor(TDEditor_TD[1], 0);
	TextDrawUseBox(TDEditor_TD[1], 1);
	TextDrawBoxColor(TDEditor_TD[1], TD_COLOR_BASE);
	TextDrawSetShadow(TDEditor_TD[1], 0);
	TextDrawSetOutline(TDEditor_TD[1], 0);
	TextDrawBackgroundColor(TDEditor_TD[1], 255);
	TextDrawFont(TDEditor_TD[1], 1);
	TextDrawSetProportional(TDEditor_TD[1], 1);
	TextDrawSetShadow(TDEditor_TD[1], 0);

	TDEditor_TD[2] = TextDrawCreate(207.977218, 141.066558, "box"); // widget do titulo principal
	TextDrawLetterSize(TDEditor_TD[2], 0.000000, 2.059175);
	TextDrawTextSize(TDEditor_TD[2], 503.439941, 0.000000);
	TextDrawAlignment(TDEditor_TD[2], 1);
	TextDrawColor(TDEditor_TD[2], -1);
	TextDrawUseBox(TDEditor_TD[2], 1);
	TextDrawBoxColor(TDEditor_TD[2], TD_WIDGET_TITLE_PRIMARY);
	TextDrawSetShadow(TDEditor_TD[2], 0);
	TextDrawSetOutline(TDEditor_TD[2], 0);
	TextDrawBackgroundColor(TDEditor_TD[2], 255);
	TextDrawFont(TDEditor_TD[2], 1);
	TextDrawSetProportional(TDEditor_TD[2], 1);
	TextDrawSetShadow(TDEditor_TD[2], 0);

	TDEditor_TD[3] = TextDrawCreate(207.882705, 142.750045, " login"); // Titulo
	TextDrawLetterSize(TDEditor_TD[3], 0.400000, 1.580000);
	TextDrawTextSize(TDEditor_TD[3], 503.340087, 0.000000);
	TextDrawAlignment(TDEditor_TD[3], 1);
	TextDrawColor(TDEditor_TD[3], -1);
	TextDrawUseBox(TDEditor_TD[3], 1);
	TextDrawBoxColor(TDEditor_TD[3], 0);
	TextDrawSetShadow(TDEditor_TD[3], 0);
	TextDrawSetOutline(TDEditor_TD[3], 1);
	TextDrawBackgroundColor(TDEditor_TD[3], 255);
	TextDrawFont(TDEditor_TD[3], 2);
	TextDrawSetProportional(TDEditor_TD[3], 1);
	TextDrawSetShadow(TDEditor_TD[3], 0);

	TDEditor_TD[4] = TextDrawCreate(471.599426, 139.566619, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[4], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[4], 22.000000, 21.339996);
	TextDrawAlignment(TDEditor_TD[4], 1);
	TextDrawColor(TDEditor_TD[4], 0);
	TextDrawSetShadow(TDEditor_TD[4], 0);
	TextDrawSetOutline(TDEditor_TD[4], 0);
	TextDrawBackgroundColor(TDEditor_TD[4], 255);
	TextDrawFont(TDEditor_TD[4], 4);
	TextDrawSetProportional(TDEditor_TD[4], 0);
	TextDrawSetShadow(TDEditor_TD[4], 0);
	TextDrawSetSelectable(TDEditor_TD[4], true);

	TDEditor_TD[5] = TextDrawCreate(477.408691, 143.133316, "X"); // Botï¿½o de fechar
	TextDrawLetterSize(TDEditor_TD[5], 0.400000, 1.600000);
	TextDrawAlignment(TDEditor_TD[5], 1);
	TextDrawColor(TDEditor_TD[5], -1);
	TextDrawSetShadow(TDEditor_TD[5], 0);
	TextDrawSetOutline(TDEditor_TD[5], 1);
	TextDrawBackgroundColor(TDEditor_TD[5], 255);
	TextDrawFont(TDEditor_TD[5], 1);
	TextDrawSetProportional(TDEditor_TD[5], 1);
	TextDrawSetShadow(TDEditor_TD[5], 0);

	TDEditor_TD[6] = TextDrawCreate(355.882263, 169.583404, "Por favor digite seus dados abaixo para efetuar o login."); // Titulo de informaï¿½ï¿½o.
	TextDrawLetterSize(TDEditor_TD[6], 0.220235, 1.075000);
	TextDrawTextSize(TDEditor_TD[6], 0.000000, 295.000000);
	TextDrawAlignment(TDEditor_TD[6], 2);
	TextDrawColor(TDEditor_TD[6], -1);
	TextDrawUseBox(TDEditor_TD[6], 1);
	TextDrawBoxColor(TDEditor_TD[6], 0);
	TextDrawSetShadow(TDEditor_TD[6], 1);
	TextDrawSetOutline(TDEditor_TD[6], 0);
	TextDrawBackgroundColor(TDEditor_TD[6], 255);
	TextDrawFont(TDEditor_TD[6], 1);
	TextDrawSetProportional(TDEditor_TD[6], 1);
	TextDrawSetShadow(TDEditor_TD[6], 1);

	TDEditor_TD[7] = TextDrawCreate(251.411712, 200.867019, "nick");
	TextDrawLetterSize(TDEditor_TD[7], 0.323764, 1.191666);
	TextDrawAlignment(TDEditor_TD[7], 1);
	TextDrawColor(TDEditor_TD[7], -1);
	TextDrawSetShadow(TDEditor_TD[7], 1);
	TextDrawSetOutline(TDEditor_TD[7], 0);
	TextDrawBackgroundColor(TDEditor_TD[7], 255);
	TextDrawFont(TDEditor_TD[7], 2);
	TextDrawSetProportional(TDEditor_TD[7], 1);
	TextDrawSetShadow(TDEditor_TD[7], 1);

	TDEditor_TD[8] = TextDrawCreate(252.000000, 217.000000, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[8], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[8], 190.000000, 15.000000);
	TextDrawAlignment(TDEditor_TD[8], 1);
	TextDrawColor(TDEditor_TD[8], TD_COLOR_SELECT_NORMAL);
	TextDrawSetShadow(TDEditor_TD[8], 0);
	TextDrawSetOutline(TDEditor_TD[8], 0);
	TextDrawBackgroundColor(TDEditor_TD[8], 255);
	TextDrawFont(TDEditor_TD[8], 4);
	TextDrawSetProportional(TDEditor_TD[8], 0);
	TextDrawSetSelectable(TDEditor_TD[8], true);

	TDEditor_TD[9] = TextDrawCreate(251.411712, 236.267333, "senha");
	TextDrawLetterSize(TDEditor_TD[9], 0.323764, 1.191666);
	TextDrawAlignment(TDEditor_TD[9], 1);
	TextDrawColor(TDEditor_TD[9], -1);
	TextDrawSetShadow(TDEditor_TD[9], 1);
	TextDrawSetOutline(TDEditor_TD[9], 0);
	TextDrawBackgroundColor(TDEditor_TD[9], 255);
	TextDrawFont(TDEditor_TD[9], 2);
	TextDrawSetProportional(TDEditor_TD[9], 1);
	TextDrawSetShadow(TDEditor_TD[9], 1);

	TDEditor_TD[10] = TextDrawCreate(252.000000, 252.000000, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[10], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[10], 190.000000, 15.000000);
	TextDrawAlignment(TDEditor_TD[10], 1);
	TextDrawColor(TDEditor_TD[10], TD_COLOR_SELECT_NORMAL);
	TextDrawSetShadow(TDEditor_TD[10], 0);
	TextDrawSetOutline(TDEditor_TD[10], 0);
	TextDrawBackgroundColor(TDEditor_TD[10], 255);
	TextDrawFont(TDEditor_TD[10], 4);
	TextDrawSetProportional(TDEditor_TD[10], 0);
	TextDrawSetSelectable(TDEditor_TD[10], true);

	TDEditor_TD[11] = TextDrawCreate(251.903106, 287.948242, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[11], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[11], 190.000000, 26.000000);
	TextDrawAlignment(TDEditor_TD[11], 1);
	TextDrawColor(TDEditor_TD[11], TD_COLOR_SELECT_NORMAL);
	TextDrawSetShadow(TDEditor_TD[11], 0);
	TextDrawSetOutline(TDEditor_TD[11], 0);
	TextDrawBackgroundColor(TDEditor_TD[11], 255);
	TextDrawFont(TDEditor_TD[11], 4);
	TextDrawSetProportional(TDEditor_TD[11], 0);
	TextDrawSetShadow(TDEditor_TD[11], 0);
	TextDrawSetSelectable(TDEditor_TD[11], true);

	TDEditor_TD[12] = TextDrawCreate(344.117706, 292.583038, "conectar");
	TextDrawLetterSize(TDEditor_TD[12], 0.400000, 1.600000);
	TextDrawAlignment(TDEditor_TD[12], 2);
	TextDrawColor(TDEditor_TD[12], -1);
	TextDrawSetShadow(TDEditor_TD[12], 0);
	TextDrawSetOutline(TDEditor_TD[12], 0);
	TextDrawBackgroundColor(TDEditor_TD[12], 255);
	TextDrawFont(TDEditor_TD[12], 2);
	TextDrawSetProportional(TDEditor_TD[12], 1);
	TextDrawSetShadow(TDEditor_TD[12], 0);

	TDEditor_TD[13] = TextDrawCreate(253.294174, 268.750061, "Esqueceu sua senha?");
	TextDrawLetterSize(TDEditor_TD[13], 0.295529, 0.865000);
	TextDrawTextSize(TDEditor_TD[13], 353.000000, 10.000000);
	TextDrawAlignment(TDEditor_TD[13], 1);
	TextDrawColor(TDEditor_TD[13], -1);
	TextDrawUseBox(TDEditor_TD[13], 1);
	TextDrawBoxColor(TDEditor_TD[13], 0);
	TextDrawSetShadow(TDEditor_TD[13], 0);
	TextDrawSetOutline(TDEditor_TD[13], 0);
	TextDrawBackgroundColor(TDEditor_TD[13], 255);
	TextDrawFont(TDEditor_TD[13], 1);
	TextDrawSetProportional(TDEditor_TD[13], 1);
	TextDrawSetShadow(TDEditor_TD[13], 0);
	TextDrawSetSelectable(TDEditor_TD[13], true);
}


hook OnPlayerConnect(playerid)
{
	TDEditor_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 253.441009, 218.716751, "Digite seu Nick");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][0], 0.406588, 0.853333);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][0], 439.668701, 0.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][0], 0);

	TDEditor_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 254.000000, 255.000000, "Digite sua Senha");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][1], 0.406588, 0.853333);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][1], 439.668701, 0.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][1], -1);
	PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][1], 0);
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if ( Dialog_Opened(playerid) )
		return Y_HOOKS_CONTINUE_RETURN_1;

	if ( InLogin{playerid} )
	{
		if(INVALID_TEXT_DRAW == _:clickedid)
		{
			Jogador[playerid][Nome] = EOS;
			Jogador[playerid][Senha] = EOS;
			
			call::TD->HidePlayerConnect(playerid);
			return Y_HOOKS_CONTINUE_RETURN_1;
		}

		if ( clickedid == TDEditor_TD[4] ) // close
		{
			Jogador[playerid][Nome] = EOS;
			Jogador[playerid][Senha] = EOS;
			
			call::TD->HidePlayerConnect(playerid);
			SoundForPlayer(playerid, SOUND_CLICK_SUCESS);
			return Y_HOOKS_CONTINUE_RETURN_1;
		}
		else if ( clickedid == TDEditor_TD[8] ) // Nick
		{
			SoundForPlayer(playerid, SOUND_CLICK_SUCESS);
			ShowPlayerDialog(playerid, PLAYER_AUTH_NICK, DIALOG_STYLE_INPUT, "{66C2D3}NICK", "{"COR_BRANCO_INC"}Digite o seu nick", "Confirmar", "Fechar");
			return Y_HOOKS_CONTINUE_RETURN_1;
		}
		else if ( clickedid == TDEditor_TD[10]) // Senha
		{
			SoundForPlayer(playerid, SOUND_CLICK_SUCESS);
			ShowPlayerDialog(playerid, PLAYER_AUTH_SENHA, DIALOG_STYLE_PASSWORD, "{66C2D3}SENHA", "{"COR_BRANCO_INC"}Digite a sua senha", "Confirmar", "Fechar");
			return Y_HOOKS_CONTINUE_RETURN_1;
		}
		else if( clickedid == TDEditor_TD[11] ) // Conectar
		{
			CleanChat(playerid);

			if( isnull(Jogador[playerid][Nome]) )
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa digitar seu nick."), SoundForPlayer(playerid, SOUND_CLICK_ERROR);

			if ( !IsValidName(Jogador[playerid][Nome]) )
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa digitar um nick vï¿½lido."), SoundForPlayer(playerid, SOUND_CLICK_ERROR);

			if ( isnull(Jogador[playerid][Senha]) )
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa digitar sua senha"), SoundForPlayer(playerid, SOUND_CLICK_ERROR);

			new query[200 + MAX_PLAYER_NAME + MAX_PLAYER_PASSWORD];
			mysql_format(getConexao(), query, sizeof(query), "SELECT *, \
				DATE_FORMAT(`ultimo_login`, '%%d/%%m/%%Y') as `lastLogin`,\
				DATEDIFF(`vencimento_vip`, CURRENT_DATE) as `dias_vip`\
				FROM "TABLE_USERS" WHERE `username`='%s' AND `senha`='%s' LIMIT 1;", Jogador[playerid][Nome], Hash(Jogador[playerid][Senha]));
			mysql_tquery(getConexao(), query, "OnPlayerAuthLogin", "i", playerid);

			SoundForPlayer(playerid, SOUND_CLICK_SUCESS);
			return Y_HOOKS_CONTINUE_RETURN_1;
		}
		else if ( clickedid == TDEditor_TD[13] ) // recuperar senha
		{
			ShowPlayerDialog(playerid, RECOVER_PASSWORD_ACCOUNT, DIALOG_STYLE_INPUT, "{16879B}DIGITE O EMAIL", "{"COR_VERMELHO_INC"}Por favor digite o email cadastrado na conta. Para enviarmos o sua senha.", "Enviar", "Fechar");
			return Y_HOOKS_CONTINUE_RETURN_1;
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

/**
*
*	Funções
*
**/

stock function TD::ShowPlayerConnect(playerid)
{
	for(new i; i < sizeof(TDEditor_TD); i++)
	{
		TextDrawShowForPlayer(playerid, TDEditor_TD[i]);
	}
	PlayerTextDrawShow(playerid, TDEditor_PTD[playerid][0]);
	PlayerTextDrawShow(playerid, TDEditor_PTD[playerid][1]);
	InLogin{playerid} = true;
	return true;
}

stock function TD::HidePlayerConnect(playerid)
{
	for(new i; i < sizeof(TDEditor_TD); i++)
	{
		TextDrawHideForPlayer(playerid, TDEditor_TD[i]);
	}
	PlayerTextDrawHide(playerid, TDEditor_PTD[playerid][0]);
	PlayerTextDrawHide(playerid, TDEditor_PTD[playerid][1]);
	InLogin{playerid} = false;
	return true;
}

stock function TD::DestroyPlayerConnect(playerid)
{
	for(new i; i < sizeof(TDEditor_TD); i++)
	{
		TextDrawHideForPlayer(playerid, TDEditor_TD[i]);
	}
	PlayerTextDrawDestroy(playerid, TDEditor_PTD[playerid][0]);
	PlayerTextDrawDestroy(playerid, TDEditor_PTD[playerid][1]);
	InLogin{playerid} = false;
	return true;
}

stock function TD::UpdateColumm(playerid, index, string[])
{
	if ( index < 0 || index >= sizeof(TDEditor_PTD[]) )
		return false;

	PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][index], string);

	return true;
}