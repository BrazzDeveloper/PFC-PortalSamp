
/*
*			@title 		Interface Login
*			@author: 	SammyJ
*			@date: 		08/10/2017
*
*/



/*
*
*			variaveis
*
*/

static 
	Text:TDEditor_TD[26];


/*
*
*			hooks callbacks
*
*/
#include <YSI_Coding\y_hooks>


hook OnGameModeInit()
{
	new str[100], Cache:cache, count;

	TDEditor_TD[0] = TextDrawCreate(1.099997, 1.700021, "box");
	TextDrawLetterSize(TDEditor_TD[0], 0.000000, 49.237392);
	TextDrawTextSize(TDEditor_TD[0], 128.000000, 0.000000);
	TextDrawAlignment(TDEditor_TD[0], 1);
	TextDrawColor(TDEditor_TD[0], -1);
	TextDrawUseBox(TDEditor_TD[0], 1);
	TextDrawBoxColor(TDEditor_TD[0], TD_COLOR_BASE);
	TextDrawSetShadow(TDEditor_TD[0], 0);
	TextDrawSetOutline(TDEditor_TD[0], 0);
	TextDrawBackgroundColor(TDEditor_TD[0], 255);
	TextDrawFont(TDEditor_TD[0], 1);
	TextDrawSetProportional(TDEditor_TD[0], 1);
	TextDrawSetShadow(TDEditor_TD[0], 0);

	TDEditor_TD[1] = TextDrawCreate(5.900074, 49.686676, "Perfect City");
	TextDrawLetterSize(TDEditor_TD[1], 0.298400, 1.906133);
	TextDrawAlignment(TDEditor_TD[1], 1);
	TextDrawColor(TDEditor_TD[1], -1);
	TextDrawSetShadow(TDEditor_TD[1], 0);
	TextDrawSetOutline(TDEditor_TD[1], 1);
	TextDrawBackgroundColor(TDEditor_TD[1], 255);
	TextDrawFont(TDEditor_TD[1], 2);
	TextDrawSetProportional(TDEditor_TD[1], 1);
	TextDrawSetShadow(TDEditor_TD[1], 0);

	TDEditor_TD[2] = TextDrawCreate(68.899993, 67.386886, "RPG");
	TextDrawLetterSize(TDEditor_TD[2], 0.305599, 0.890666);
	TextDrawAlignment(TDEditor_TD[2], 1);
	TextDrawColor(TDEditor_TD[2], -1);
	TextDrawSetShadow(TDEditor_TD[2], 0);
	TextDrawSetOutline(TDEditor_TD[2], 1);
	TextDrawBackgroundColor(TDEditor_TD[2], 255);
	TextDrawFont(TDEditor_TD[2], 3);
	TextDrawSetProportional(TDEditor_TD[2], 1);
	TextDrawSetShadow(TDEditor_TD[2], 0);

	TDEditor_TD[3] = TextDrawCreate(-1.000000, 110.926147, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[3], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[3], 131.000000, 22.000000);
	TextDrawAlignment(TDEditor_TD[3], 1);
	TextDrawColor(TDEditor_TD[3], TD_COLOR_SELECT_NORMAL);
	TextDrawSetShadow(TDEditor_TD[3], 0);
	TextDrawSetOutline(TDEditor_TD[3], 0);
	TextDrawBackgroundColor(TDEditor_TD[3], 255);
	TextDrawFont(TDEditor_TD[3], 4);
	TextDrawSetProportional(TDEditor_TD[3], 0);
	TextDrawSetShadow(TDEditor_TD[3], 0);
	TextDrawSetSelectable(TDEditor_TD[3], true);

	TDEditor_TD[4] = TextDrawCreate(64.100074, 114.876464, "LOGIN");
	TextDrawLetterSize(TDEditor_TD[4], 0.400000, 1.600000);
	TextDrawTextSize(TDEditor_TD[4], 0.000000, 127.000000);
	TextDrawAlignment(TDEditor_TD[4], 2);
	TextDrawColor(TDEditor_TD[4], -1);
	TextDrawUseBox(TDEditor_TD[4], 1);
	TextDrawBoxColor(TDEditor_TD[4], 0);
	TextDrawSetShadow(TDEditor_TD[4], 0);
	TextDrawSetOutline(TDEditor_TD[4], 1);
	TextDrawBackgroundColor(TDEditor_TD[4], 255);
	TextDrawFont(TDEditor_TD[4], 1);
	TextDrawSetProportional(TDEditor_TD[4], 1);
	TextDrawSetShadow(TDEditor_TD[4], 0);

	TDEditor_TD[5] = TextDrawCreate(-1.000000, 148.676986, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[5], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[5], 130.910598, 23.000000);
	TextDrawAlignment(TDEditor_TD[5], 1);
	TextDrawColor(TDEditor_TD[5], TD_COLOR_SELECT_NORMAL);
	TextDrawSetShadow(TDEditor_TD[5], 0);
	TextDrawSetOutline(TDEditor_TD[5], 0);
	TextDrawBackgroundColor(TDEditor_TD[5], 255);
	TextDrawFont(TDEditor_TD[5], 4);
	TextDrawSetProportional(TDEditor_TD[5], 0);
	TextDrawSetShadow(TDEditor_TD[5], 0);
	TextDrawSetSelectable(TDEditor_TD[5], true);

	TDEditor_TD[6] = TextDrawCreate(64.100090, 152.570495, "REGISTRO");
	TextDrawLetterSize(TDEditor_TD[6], 0.400000, 1.600000);
	TextDrawTextSize(TDEditor_TD[6], 0.000000, 127.000000);
	TextDrawAlignment(TDEditor_TD[6], 2);
	TextDrawColor(TDEditor_TD[6], -1);
	TextDrawUseBox(TDEditor_TD[6], 1);
	TextDrawBoxColor(TDEditor_TD[6], 0);
	TextDrawSetShadow(TDEditor_TD[6], 0);
	TextDrawSetOutline(TDEditor_TD[6], 1);
	TextDrawBackgroundColor(TDEditor_TD[6], 255);
	TextDrawFont(TDEditor_TD[6], 1);
	TextDrawSetProportional(TDEditor_TD[6], 1);
	TextDrawSetShadow(TDEditor_TD[6], 0);

	TDEditor_TD[7] = TextDrawCreate(-1.000000, 187.676849, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[7], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[7], 130.940032, 23.000000);
	TextDrawAlignment(TDEditor_TD[7], 1);
	TextDrawColor(TDEditor_TD[7], TD_COLOR_SELECT_NORMAL);
	TextDrawSetShadow(TDEditor_TD[7], 0);
	TextDrawSetOutline(TDEditor_TD[7], 0);
	TextDrawBackgroundColor(TDEditor_TD[7], 255);
	TextDrawFont(TDEditor_TD[7], 4);
	TextDrawSetProportional(TDEditor_TD[7], 0);
	TextDrawSetShadow(TDEditor_TD[7], 0);
	TextDrawSetSelectable(TDEditor_TD[7], true);

	TDEditor_TD[8] = TextDrawCreate(64.400085, 191.914566, "CREDITOS");
	TextDrawLetterSize(TDEditor_TD[8], 0.400000, 1.600000);
	TextDrawTextSize(TDEditor_TD[8], 0.000000, 127.000000);
	TextDrawAlignment(TDEditor_TD[8], 2);
	TextDrawColor(TDEditor_TD[8], -1);
	TextDrawUseBox(TDEditor_TD[8], 1);
	TextDrawBoxColor(TDEditor_TD[8], 0);
	TextDrawSetShadow(TDEditor_TD[8], 0);
	TextDrawSetOutline(TDEditor_TD[8], 1);
	TextDrawBackgroundColor(TDEditor_TD[8], 255);
	TextDrawFont(TDEditor_TD[8], 1);
	TextDrawSetProportional(TDEditor_TD[8], 1);
	TextDrawSetShadow(TDEditor_TD[8], 0);

	TDEditor_TD[9] = TextDrawCreate(-1.000000, 226.576843, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[9], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[9], 130.940032, 23.000000);
	TextDrawAlignment(TDEditor_TD[9], 1);
	TextDrawColor(TDEditor_TD[9], TD_COLOR_SELECT_NORMAL);
	TextDrawSetShadow(TDEditor_TD[9], 0);
	TextDrawSetOutline(TDEditor_TD[9], 0);
	TextDrawBackgroundColor(TDEditor_TD[9], 255);
	TextDrawFont(TDEditor_TD[9], 4);
	TextDrawSetProportional(TDEditor_TD[9], 0);
	TextDrawSetShadow(TDEditor_TD[9], 0);
	TextDrawSetSelectable(TDEditor_TD[9], true);

	TDEditor_TD[10] = TextDrawCreate(64.400085, 230.814559, "SAIR");
	TextDrawLetterSize(TDEditor_TD[10], 0.400000, 1.600000);
	TextDrawTextSize(TDEditor_TD[10], 0.000000, 127.000000);
	TextDrawAlignment(TDEditor_TD[10], 2);
	TextDrawColor(TDEditor_TD[10], -1);
	TextDrawUseBox(TDEditor_TD[10], 1);
	TextDrawBoxColor(TDEditor_TD[10], 0);
	TextDrawSetShadow(TDEditor_TD[10], 0);
	TextDrawSetOutline(TDEditor_TD[10], 1);
	TextDrawBackgroundColor(TDEditor_TD[10], 255);
	TextDrawFont(TDEditor_TD[10], 1);
	TextDrawSetProportional(TDEditor_TD[10], 1);
	TextDrawSetShadow(TDEditor_TD[10], 0);
	
	TDEditor_TD[11] = TextDrawCreate(67.920906, 272.833374, "informacoes");
	TextDrawLetterSize(TDEditor_TD[11], 0.206032, 1.296665);
	TextDrawAlignment(TDEditor_TD[11], 2);
	TextDrawColor(TDEditor_TD[11], -1);
	TextDrawSetShadow(TDEditor_TD[11], 0);
	TextDrawSetOutline(TDEditor_TD[11], 1);
	TextDrawBackgroundColor(TDEditor_TD[11], 255);
	TextDrawFont(TDEditor_TD[11], 2);
	TextDrawSetProportional(TDEditor_TD[11], 1);
	TextDrawSetShadow(TDEditor_TD[11], 0);

	TDEditor_TD[12] = TextDrawCreate(1.390851, 289.166595, "I");
	TextDrawLetterSize(TDEditor_TD[12], 10.004215, 0.113333);
	TextDrawAlignment(TDEditor_TD[12], 1);
	TextDrawColor(TDEditor_TD[12], -1);
	TextDrawSetShadow(TDEditor_TD[12], 0);
	TextDrawSetOutline(TDEditor_TD[12], 0);
	TextDrawBackgroundColor(TDEditor_TD[12], 255);
	TextDrawFont(TDEditor_TD[12], 1);
	TextDrawSetProportional(TDEditor_TD[12], 1);
	TextDrawSetShadow(TDEditor_TD[12], 0);

	TDEditor_TD[13] = TextDrawCreate(1.859366, 304.916656, "- ultima conta registrada");
	TextDrawLetterSize(TDEditor_TD[13], 0.175108, 0.911665);
	TextDrawTextSize(TDEditor_TD[13], 128.000000, 0.000000);
	TextDrawAlignment(TDEditor_TD[13], 1);
	TextDrawColor(TDEditor_TD[13], -1);
	TextDrawUseBox(TDEditor_TD[13], 1);
	TextDrawBoxColor(TDEditor_TD[13], 0);
	TextDrawSetShadow(TDEditor_TD[13], 0);
	TextDrawSetOutline(TDEditor_TD[13], 0);
	TextDrawBackgroundColor(TDEditor_TD[13], 255);
	TextDrawFont(TDEditor_TD[13], 2);
	TextDrawSetProportional(TDEditor_TD[13], 1);
	TextDrawSetShadow(TDEditor_TD[13], 0);

	new pName[MAX_PLAYER_NAME];
	cache = mysql_query(getConexao(), "SELECT `username` FROM "TABLE_USERS" ORDER BY id DESC LIMIT 1;");
	if( cache_num_rows() )
		cache_get_value_name(0, "username", pName, MAX_PLAYER_NAME), cache_delete(cache);
	else
		pName = "Não há registros.";
	format(str, sizeof(str), "- ~g~%s", pName);

	TDEditor_TD[14] = TextDrawCreate(1.859366, 313.217163, str);
	TextDrawLetterSize(TDEditor_TD[14], 0.175108, 0.911665);
	TextDrawTextSize(TDEditor_TD[14], 128.000000, 0.000000);
	TextDrawAlignment(TDEditor_TD[14], 1);
	TextDrawColor(TDEditor_TD[14], -1);
	TextDrawUseBox(TDEditor_TD[14], 1);
	TextDrawBoxColor(TDEditor_TD[14], 0);
	TextDrawSetShadow(TDEditor_TD[14], 0);
	TextDrawSetOutline(TDEditor_TD[14], 0);
	TextDrawBackgroundColor(TDEditor_TD[14], 255);
	TextDrawFont(TDEditor_TD[14], 2);
	TextDrawSetProportional(TDEditor_TD[14], 1);
	TextDrawSetShadow(TDEditor_TD[14], 0);

	TDEditor_TD[15] = TextDrawCreate(1.859366, 329.517089, "- Total de contas registradas");
	TextDrawLetterSize(TDEditor_TD[15], 0.175108, 0.911665);
	TextDrawTextSize(TDEditor_TD[15], 128.000000, 0.000000);
	TextDrawAlignment(TDEditor_TD[15], 1);
	TextDrawColor(TDEditor_TD[15], -1);
	TextDrawUseBox(TDEditor_TD[15], 1);
	TextDrawBoxColor(TDEditor_TD[15], 0);
	TextDrawSetShadow(TDEditor_TD[15], 0);
	TextDrawSetOutline(TDEditor_TD[15], 0);
	TextDrawBackgroundColor(TDEditor_TD[15], 255);
	TextDrawFont(TDEditor_TD[15], 2);
	TextDrawSetProportional(TDEditor_TD[15], 1);
	TextDrawSetShadow(TDEditor_TD[15], 0);

	cache = mysql_query(getConexao(), "SELECT count(`id`) FROM "TABLE_USERS";"), cache_get_value_name_int(0, "count(`id`)", count), cache_delete(cache);
	format(str, sizeof(str), "- ~g~%s", RealStr(count));
	
	TDEditor_TD[16] = TextDrawCreate(1.859366, 337.465454, str);
	TextDrawLetterSize(TDEditor_TD[16], 0.175108, 0.911665);
	TextDrawTextSize(TDEditor_TD[16], 128.000000, 0.000000);
	TextDrawAlignment(TDEditor_TD[16], 1);
	TextDrawColor(TDEditor_TD[16], -1);
	TextDrawUseBox(TDEditor_TD[16], 1);
	TextDrawBoxColor(TDEditor_TD[16], 0);
	TextDrawSetShadow(TDEditor_TD[16], 0);
	TextDrawSetOutline(TDEditor_TD[16], 0);
	TextDrawBackgroundColor(TDEditor_TD[16], 255);
	TextDrawFont(TDEditor_TD[16], 2);
	TextDrawSetProportional(TDEditor_TD[16], 1);
	TextDrawSetShadow(TDEditor_TD[16], 0);

	TDEditor_TD[17] = TextDrawCreate(2.000000, 354.600463, "- total de casas criadas");
	TextDrawLetterSize(TDEditor_TD[17], 0.175108, 0.911665);
	TextDrawTextSize(TDEditor_TD[17], 128.000000, 0.000000);
	TextDrawAlignment(TDEditor_TD[17], 1);
	TextDrawColor(TDEditor_TD[17], -1);
	TextDrawUseBox(TDEditor_TD[17], 1);
	TextDrawBoxColor(TDEditor_TD[17], 0);
	TextDrawSetShadow(TDEditor_TD[17], 0);
	TextDrawSetOutline(TDEditor_TD[17], 0);
	TextDrawBackgroundColor(TDEditor_TD[17], 255);
	TextDrawFont(TDEditor_TD[17], 2);
	TextDrawSetProportional(TDEditor_TD[17], 1);
	TextDrawSetShadow(TDEditor_TD[17], 0);

	cache = mysql_query(getConexao(), "SELECT count(`id`) FROM "TABLE_HOUSES";"), cache_get_value_name_int(0, "count(`id`)", count), cache_delete(cache);
	format(str, sizeof(str), "- ~g~%s", RealStr(count));

	TDEditor_TD[18] = TextDrawCreate(2.000000, 362.600463, str);
	TextDrawLetterSize(TDEditor_TD[18], 0.175108, 0.911665);
	TextDrawTextSize(TDEditor_TD[18], 128.000000, 0.000000);
	TextDrawAlignment(TDEditor_TD[18], 1);
	TextDrawColor(TDEditor_TD[18], -1);
	TextDrawUseBox(TDEditor_TD[18], 1);
	TextDrawBoxColor(TDEditor_TD[18], 0);
	TextDrawSetShadow(TDEditor_TD[18], 0);
	TextDrawSetOutline(TDEditor_TD[18], 0);
	TextDrawBackgroundColor(TDEditor_TD[18], 255);
	TextDrawFont(TDEditor_TD[18], 2);
	TextDrawSetProportional(TDEditor_TD[18], 1);
	TextDrawSetShadow(TDEditor_TD[18], 0);

	TDEditor_TD[19] = TextDrawCreate(1.859366, 378.966705, "- total de empresas criadas");
	TextDrawLetterSize(TDEditor_TD[19], 0.175108, 0.911665);
	TextDrawTextSize(TDEditor_TD[19], 128.000000, 0.000000);
	TextDrawAlignment(TDEditor_TD[19], 1);
	TextDrawColor(TDEditor_TD[19], -1);
	TextDrawUseBox(TDEditor_TD[19], 1);
	TextDrawBoxColor(TDEditor_TD[19], 0);
	TextDrawSetShadow(TDEditor_TD[19], 0);
	TextDrawSetOutline(TDEditor_TD[19], 0);
	TextDrawBackgroundColor(TDEditor_TD[19], 255);
	TextDrawFont(TDEditor_TD[19], 2);
	TextDrawSetProportional(TDEditor_TD[19], 1);
	TextDrawSetShadow(TDEditor_TD[19], 0);

	cache = mysql_query(getConexao(), "SELECT count(`id`) FROM "TABLE_BUSINESS";"), cache_get_value_name_int(0, "count(`id`)", count), cache_delete(cache);
	format(str, sizeof(str), "- ~g~%s", RealStr(count));

	TDEditor_TD[20] = TextDrawCreate(1.859366, 386.716369, str);
	TextDrawLetterSize(TDEditor_TD[20], 0.175108, 0.911665);
	TextDrawTextSize(TDEditor_TD[20], 128.000000, 0.000000);
	TextDrawAlignment(TDEditor_TD[20], 1);
	TextDrawColor(TDEditor_TD[20], -1);
	TextDrawUseBox(TDEditor_TD[20], 1);
	TextDrawBoxColor(TDEditor_TD[20], 0);
	TextDrawSetShadow(TDEditor_TD[20], 0);
	TextDrawSetOutline(TDEditor_TD[20], 0);
	TextDrawBackgroundColor(TDEditor_TD[19], 255);
	TextDrawFont(TDEditor_TD[20], 2);
	TextDrawSetProportional(TDEditor_TD[20], 1);
	TextDrawSetShadow(TDEditor_TD[20], 0);

	TDEditor_TD[21] = TextDrawCreate(1.859366, 402.915435, "- total de profissões criadas");
	TextDrawLetterSize(TDEditor_TD[21], 0.175108, 0.911665);
	TextDrawTextSize(TDEditor_TD[21], 128.000000, 0.000000);
	TextDrawAlignment(TDEditor_TD[21], 1);
	TextDrawColor(TDEditor_TD[21], -1);
	TextDrawUseBox(TDEditor_TD[21], 1);
	TextDrawBoxColor(TDEditor_TD[21], 0);
	TextDrawSetShadow(TDEditor_TD[21], 0);
	TextDrawSetOutline(TDEditor_TD[21], 0);
	TextDrawBackgroundColor(TDEditor_TD[21], 255);
	TextDrawFont(TDEditor_TD[21], 2);
	TextDrawSetProportional(TDEditor_TD[21], 1);
	TextDrawSetShadow(TDEditor_TD[21], 0);

	format(str, sizeof(str), "- ~g~%d", call::JOB->CountJobs() );
	TDEditor_TD[22] = TextDrawCreate(2.327887, 409.065002, str);
	TextDrawLetterSize(TDEditor_TD[22], 0.175108, 0.911665);
	TextDrawTextSize(TDEditor_TD[22], 128.000000, 0.000000);
	TextDrawAlignment(TDEditor_TD[22], 1);
	TextDrawColor(TDEditor_TD[22], -1);
	TextDrawUseBox(TDEditor_TD[22], 1);
	TextDrawBoxColor(TDEditor_TD[22], 0);
	TextDrawSetShadow(TDEditor_TD[22], 0);
	TextDrawSetOutline(TDEditor_TD[22], 0);
	TextDrawBackgroundColor(TDEditor_TD[22], 255);
	TextDrawFont(TDEditor_TD[22], 2);
	TextDrawSetProportional(TDEditor_TD[22], 1);
	TextDrawSetShadow(TDEditor_TD[22], 0);

	TDEditor_TD[23] = TextDrawCreate(129.000000, -7.750006, "LD_SPAC:white"); // Barrinha lateral
	TextDrawLetterSize(TDEditor_TD[23], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[23], 1.400000, 438.000000);
	TextDrawAlignment(TDEditor_TD[23], 1);
	TextDrawColor(TDEditor_TD[23], TD_COLOR_BORDER);
	TextDrawSetShadow(TDEditor_TD[23], 0);
	TextDrawSetOutline(TDEditor_TD[23], 0);
	TextDrawBackgroundColor(TDEditor_TD[23], 255);
	TextDrawFont(TDEditor_TD[23], 4);
	TextDrawSetProportional(TDEditor_TD[23], 0);
	TextDrawSetShadow(TDEditor_TD[23], 0);

	TDEditor_TD[24] = TextDrawCreate(-7.212689, 431.000000, "LD_SPAC:white"); // Barrinha em cima dos direitos.
	TextDrawLetterSize(TDEditor_TD[24], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[24], 647.000000, -1.400000);
	TextDrawAlignment(TDEditor_TD[24], 1);
	TextDrawColor(TDEditor_TD[24], TD_COLOR_BORDER);
	TextDrawSetShadow(TDEditor_TD[24], 0);
	TextDrawSetOutline(TDEditor_TD[24], 0);
	TextDrawBackgroundColor(TDEditor_TD[24], 255);
	TextDrawFont(TDEditor_TD[24], 4);
	TextDrawSetProportional(TDEditor_TD[24], 0);
	TextDrawSetShadow(TDEditor_TD[24], 0);

	TDEditor_TD[25] = TextDrawCreate(319.985382, 433.000000, "Perfect City RPG Todos os direitos reservados.");
	TextDrawLetterSize(TDEditor_TD[25], 0.319882, 1.424998);
	TextDrawTextSize(TDEditor_TD[25], 0.000000, 639.000000);
	TextDrawAlignment(TDEditor_TD[25], 2);
	TextDrawColor(TDEditor_TD[25], -1);
	TextDrawUseBox(TDEditor_TD[25], 1);
	TextDrawBoxColor(TDEditor_TD[25], 255);
	TextDrawSetShadow(TDEditor_TD[25], 1);
	TextDrawSetOutline(TDEditor_TD[25], 0);
	TextDrawBackgroundColor(TDEditor_TD[25], 255);
	TextDrawFont(TDEditor_TD[25], 2);
	TextDrawSetProportional(TDEditor_TD[25], 1);
	TextDrawSetShadow(TDEditor_TD[25], 1);
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(INVALID_TEXT_DRAW == _:clickedid){
		if(call::PLAYER->IsPlayerLoggin(playerid))
			call::TD->ShowPlayerLogin(playerid);
	}
	else
	{
		if(Dialog_Opened(playerid))
			return false;
			
		if(clickedid == TDEditor_TD[3]) // Login
		{
			SoundForPlayer(playerid, SOUND_CLICK_SUCESS);
			call::TD->ShowPlayerConnect(playerid);
			return true;
		}
		else if(clickedid == TDEditor_TD[5])// registro
		{
			new query[200];
			mysql_format(getConexao(), query, sizeof(query), "SELECT `username` FROM "TABLE_USERS" WHERE `username`='%s' LIMIT 1;", GetUserName(playerid));
			new Cache:cache = mysql_query(getConexao(), query, true), rows = cache_num_rows();
			cache_delete(cache);
			
			CleanChat(playerid);
			if(rows)
				return SendClientMessage(playerid, COR_AVISO, "Aviso: {"COR_BRANCO_INC"}Você já possui uma conta criada, por favor clique em login para entrar."), SoundForPlayer(playerid, SOUND_CLICK_ERROR);

			new str[1024*2];
			ReadFile("textos/interface.login/term-of-use.txt", str, sizeof(str));
			ShowPlayerDialog(playerid, TERM_OF_USE, DIALOG_STYLE_MSGBOX, "{"COR_VERMELHO_INC"}TERMO DE USO", str, "aceito", "não aceito");
			SoundForPlayer(playerid, SOUND_CLICK_SUCESS);
			return true;
		}
		else if(clickedid == TDEditor_TD[7]) // créditos
		{
			static str[1024 * 4];
			str[0] = EOS;
			ReadFile("textos/interface.login/sobre.txt", str, sizeof(str));
			SoundForPlayer(playerid, SOUND_CLICK_SUCESS);
			return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "SOBRE", str, "OK", "");
		}
		else if(clickedid == TDEditor_TD[9]) // Sair
		{
			SendClientMessage(playerid, COR_ERRO, "| INFO | Você foi desconectado(a) do servidor.");
			return Quit(playerid);
		}
	}
	return false;
}


/*
*
*		FUNCTIONS
*
*
*/
function TD::ShowPlayerLogin(playerid)
{
	for(new i; i < sizeof(TDEditor_TD); i++){
		TextDrawShowForPlayer(playerid, TDEditor_TD[i]);
	}
	SelectTextDraw(playerid, TD_COLOR_SELECT_HOVER);
	return true;
}

function TD::HidePlayerLogin(playerid)
{
	for(new i; i < sizeof(TDEditor_TD); i++){
		TextDrawHideForPlayer(playerid, TDEditor_TD[i]);
	}
	CancelSelectTextDraw(playerid);
	return true;
}

function TD::UpdateTextDrawLogin()
{
	new pName[MAX_PLAYER_NAME], str[10 + MAX_PLAYER_NAME], Cache:cache, count;
	cache = mysql_query(getConexao(), "SELECT `username` FROM "TABLE_USERS" ORDER BY id DESC LIMIT 1;"), cache_get_value_name(0, "username", pName, MAX_PLAYER_NAME), cache_delete(cache);
	format(str, sizeof(str), "- ~g~%s", pName);
	TextDrawSetString(TDEditor_TD[14], str);

	cache = mysql_query(getConexao(), "SELECT count(`id`) FROM "TABLE_USERS";"), cache_get_value_name_int(0, "count(`id`)", count), cache_delete(cache);
	format(str, sizeof(str), "- ~g~%s", RealStr(count));
	TextDrawSetString(TDEditor_TD[16], str);
	return true;
}

function TD::UpdateJobsNumber(number)
{
	new str[10];
	format(str, sizeof(str), "- ~g~%d", number);
	TextDrawSetString(TDEditor_TD[22], str);
	return true;
}