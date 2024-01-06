// ================================================== [ defines, vars & enums ] ================================================== //

enum e_CREATE_BUSINESS
{
	Nome[MAX_BUSINESS_NAME],
	Float:Entrada[e_POSITION],
	Float:Saida[e_POSITION],
	Interior,
	InteriorID,
	Preco,
	MapIcon,
	bool:Showed
}
static CreateBusiness[MAX_PLAYERS][e_CREATE_BUSINESS];


enum e_MODELID_MAPICON
{
	mapicon_ID,
	mapicon_Nome[25],
}
static MapIconModel[][e_MODELID_MAPICON] =
{
	// 19200
	{32, "Default"},
	{45, "Loja de Skins"},
	{29, "Pizzaria"},
	{50, "Restaurante"},
	{55, "Posto de Gasolina"},
	{54, "Academia"},
	{49, "Bar"},
	{25, "Casino"},
	{18, "Ammunation"},
	{17, "24/7"},
	{14, "Cluckin' Bell"},
	{10, "Burger Shot"},
	{7, "Barbearia"}
};

static 
	PlayerText:TDEditor_PTD[MAX_PLAYERS][4], Text:TDEditor_TD[16];

// ================================================== [ commands ] ================================================== //

flags:irempresa(ADMINISTRADOR);
CMD:irempresa(playerid, params[])
{
	if(isnull(params) || !IsNumeric(params))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/irempresa [empresaid]");

	new businessid = strval(params);
	
	/*if(!call::BUSINESS->IsValidBusiness(businessid))
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esta empresa n�o existe.");*/

	if( IsPlayerInAnyVehicle(playerid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Voc� n�o pode usar este comando dentro de um veiculo.");

	new Float:x, Float:y, Float:z;

	for(new i; i < MAX_BUSINESS; i++)
	{
		if(call::BUSINESS->GetBusinessParamsInt(i, ID) == strval(params))
		{
			call::BUSINESS->GetBusinessPos(i, x, y, z);
		}
	}
	
	Teleport(playerid, x, y, z, 0.0, 0, 0, ENTROU_NONE);
	SendClientMessage(playerid, COR_AZUL, "| PFC - ADMIN | {"COR_BRANCO_INC"}Voc� foi at� a empresa {"COR_SISTEMA_INC"}%s{"COR_BRANCO_INC"}", call::BUSINESS->GetBusinessName(businessid));
	return true;
}

flags:criarempresa(DIRECAO);
CMD:criarempresa(playerid)
{
	call::CREATE_B->ShowPlayerCreateB(playerid);
	return true;
}

flags:editarempresa(DIRECAO);
CMD:editarempresa(playerid)
{
	new businessid = call::BUSINESS->GetBusinessInRangeP(playerid, 3.0);
	if(businessid == INVALID_BUSINESS_ID)
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo a uma empresa.");

	call::CREATE_B->ShowPlayerManagerB(playerid, businessid);	
	return true;

}

// ================================================== [ functions ] ================================================== //

static function CREATE_B::ShowPlayerManagerB(playerid, businessid)
{
	ShowPlayerDialog(playerid, CB_MANAGER, DIALOG_STYLE_TABLIST, "GERENCIAR EMPRESA", "Alterar Nome\t%s\nAlterar Entrada\t-\nAlterar Saida\t-\nAlterar Valor\t{"COR_VERDE_INC"}R$%s\n{"COR_ERRO_INC"}Excluir", "Selecionar", "Sair",
		call::BUSINESS->GetBusinessName(businessid), RealStr(call::BUSINESS->GetBusinessParamsInt(businessid, Valor)));
	return true;
}

static function CREATE_B::CreateBusinessForTable(playerid)
{
	SendClientMessage(playerid, COR_SISTEMA, "Criando propriedade por favor aguarde.");
	GetPlayerPos(playerid, CreateBusiness[playerid][Entrada][X], CreateBusiness[playerid][Entrada][Y], CreateBusiness[playerid][Entrada][Z]);
	GetPlayerFacingAngle(playerid, CreateBusiness[playerid][Entrada][A]);

	new query[512];
	mysql_format(getConexao(), query, sizeof(query), "INSERT INTO "TABLE_BUSINESS" (`nome`,`entrada_x`,`entrada_y`,`entrada_z`,`entrada_a`,`saida_x`,`saida_y`,`saida_z`,`saida_a`,`interior`,`valor`,`mapicon`)\
		VALUES('%s','%f','%f','%f','%f','%f','%f','%f','%f','%d','%d','%d');", 
		CreateBusiness[playerid][Nome],
		CreateBusiness[playerid][Entrada][X], CreateBusiness[playerid][Entrada][Y], CreateBusiness[playerid][Entrada][Z], CreateBusiness[playerid][Entrada][A],
		CreateBusiness[playerid][Saida][X], CreateBusiness[playerid][Saida][Y], CreateBusiness[playerid][Saida][Z], CreateBusiness[playerid][Saida][A], CreateBusiness[playerid][Interior],
		CreateBusiness[playerid][Preco],
		CreateBusiness[playerid][MapIcon]
	);
	
	CleanChat(playerid);
	SendClientMessage(playerid, COR_SISTEMA, "Info: Criando empresa...");

	if(!mysql_tquery(getConexao(), query, "OnLoadBusiness", "d", playerid)){
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foi posivel criar a empresa.");
	}else{
		SendClientMessage(playerid, COR_SISTEMA, "Empresa: {"COR_BRANCO_INC"}Empresa criado com {"COR_VERDE_INC"}exito{"COR_BRANCO_INC"}.");
	}
	// Esconder textdraws.
	call::CREATE_B->HidePlayerCreateB(playerid);

	// empty vars;
	new rst[e_CREATE_BUSINESS];
	CreateBusiness[playerid] = rst;
	CreateBusiness[playerid][InteriorID] = -1;
	return true;
}

static function CREATE_B::ShowPlayerCreateB(playerid)
{
	call::CREATE_B->CreatePTD(playerid);

	for(new i; i < sizeof(TDEditor_TD); i++){
		TextDrawShowForPlayer(playerid, TDEditor_TD[i]);
	}
	for(new i; i < sizeof(TDEditor_PTD[]); i++){
		PlayerTextDrawShow(playerid, TDEditor_PTD[playerid][i]);
	}
	CreateBusiness[playerid][Showed] = true;
	SelectTextDraw(playerid, TD_COLOR_SELECT_HOVER);
}

static function CREATE_B::HidePlayerCreateB(playerid)
{
	for(new i; i < sizeof(TDEditor_TD); i++){
		TextDrawHideForPlayer(playerid, TDEditor_TD[i]);
	}
	for(new i; i < sizeof(TDEditor_PTD[]); i++){
		PlayerTextDrawDestroy(playerid, TDEditor_PTD[playerid][i]);
	}
	CreateBusiness[playerid][Showed] = false;
	CancelSelectTextDraw(playerid);
}

static function CREATE_B::CreatePTD(playerid)
{
	if(!CreateBusiness[playerid][Showed])
	{
		TDEditor_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 335.800354, 178.716598, ""); // mapicon
		PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][0], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][0], 55.000000, 65.000000);
		PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][0], 1);
		PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][0], -1);
		PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][0], 0);
		PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][0], 0);
		PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][0], 100);
		PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][0], 5);
		PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][0], 0);
		PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][0], 0);
		PlayerTextDrawSetSelectable(playerid, TDEditor_PTD[playerid][0], true);
		PlayerTextDrawSetPreviewModel(playerid, TDEditor_PTD[playerid][0], MapIconModel[0][mapicon_ID]);
		PlayerTextDrawSetPreviewRot(playerid, TDEditor_PTD[playerid][0], 90.000000, 0.000000, 0.000000, 0.242566);

		TDEditor_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 205.000000, 180.917053, "Digite o nome da empresa"); // name
		PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][1], 0.200000, 1.000000);
		PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][1], (204 + 100.000000), 100.000000);
		PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][1], 1);
		PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][1], TD_COLOR_TEXT);
		PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][1], 1);
		PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][1], 0);
		PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][1], 0);
		PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][1], 0);
		PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][1], 255);
		PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][1], 1);
		PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][1], 1);
		PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][1], 0);

		TDEditor_PTD[playerid][2] = CreatePlayerTextDraw(playerid, 205.000000, 213.017196, "Digite o valor da empresa"); // valor
		PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][2], 0.218500, 1.004998);
		PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][2], (204 + 100.000000), 0.000000);
		PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][2], 1);
		PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][2], TD_COLOR_TEXT);
		PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][2], 1);
		PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][2], 20);
		PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][2], 0);
		PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][2], 0);
		PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][2], 255);
		PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][2], 1);
		PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][2], 1);
		PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][2], 0);

		TDEditor_PTD[playerid][3] = CreatePlayerTextDraw(playerid, 205.000000, 244.717300, "Escolha um interior"); // Interior
		PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][3], 0.218500, 1.004998);
		PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][3], (204 + 100.000000), 0.000000);
		PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][3], 1);
		PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][3], TD_COLOR_TEXT);
		PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][3], 1);
		PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][3], 20);
		PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][3], 0);
		PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][3], 0);
		PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][3], 255);
		PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][3], 1);
		PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][3], 1);
		PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][3], 0);
	}
}

// ================================================== [ hooks & callbacks ] ================================================== //

#include <YSI_Coding\y_hooks>
hook OnGameModeInit()
{
	print("� Carregando criador de empresas.\n");
	TDEditor_TD[0] = TextDrawCreate(201.000000, 120.000030, "box"); // border
	TextDrawLetterSize(TDEditor_TD[0], 0.000000, 21.049995);
	TextDrawTextSize(TDEditor_TD[0], 402.000000, 0.000000);
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

	TDEditor_TD[1] = TextDrawCreate(201.900054, 120.900016, "box"); // base
	TextDrawLetterSize(TDEditor_TD[1], 0.000000, 20.796993);
	TextDrawTextSize(TDEditor_TD[1], 400.639648, 0.000000);
	TextDrawAlignment(TDEditor_TD[1], 1);
	TextDrawColor(TDEditor_TD[1], -1);
	TextDrawUseBox(TDEditor_TD[1], 1);
	TextDrawBoxColor(TDEditor_TD[1], TD_COLOR_BASE);
	TextDrawSetShadow(TDEditor_TD[1], 0);
	TextDrawSetOutline(TDEditor_TD[1], 0);
	TextDrawBackgroundColor(TDEditor_TD[1], 255);
	TextDrawFont(TDEditor_TD[1], 1);
	TextDrawSetProportional(TDEditor_TD[1], 1);
	TextDrawSetShadow(TDEditor_TD[1], 0);

	TDEditor_TD[2] = TextDrawCreate(199.699981, 118.833351, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[2], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[2], 203.019989, 10.089993);
	TextDrawAlignment(TDEditor_TD[2], 1);
	TextDrawColor(TDEditor_TD[2], TD_WIDGET_TITLE_PRIMARY);
	TextDrawSetShadow(TDEditor_TD[2], 0);
	TextDrawSetOutline(TDEditor_TD[2], 0);
	TextDrawBackgroundColor(TDEditor_TD[2], 255);
	TextDrawFont(TDEditor_TD[2], 4);
	TextDrawSetProportional(TDEditor_TD[2], 0);
	TextDrawSetShadow(TDEditor_TD[2], 0);

	TDEditor_TD[3] = TextDrawCreate(199.699981, 129.333297, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[3], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[3], 203.019989, 10.089993);
	TextDrawAlignment(TDEditor_TD[3], 1);
	TextDrawColor(TDEditor_TD[3], TD_WIDGET_TITLE_SECONDARY);
	TextDrawSetShadow(TDEditor_TD[3], 0);
	TextDrawSetOutline(TDEditor_TD[3], 0);
	TextDrawBackgroundColor(TDEditor_TD[3], 255);
	TextDrawFont(TDEditor_TD[3], 4);
	TextDrawSetProportional(TDEditor_TD[3], 0);
	TextDrawSetShadow(TDEditor_TD[3], 0);

	TDEditor_TD[4] = TextDrawCreate(201.800018, 120.833404, "box");
	TextDrawLetterSize(TDEditor_TD[4], 0.000000, 1.811999);
	TextDrawTextSize(TDEditor_TD[4], 400.680175, 0.000000);
	TextDrawAlignment(TDEditor_TD[4], 1);
	TextDrawColor(TDEditor_TD[4], -1);
	TextDrawUseBox(TDEditor_TD[4], 1);
	TextDrawBoxColor(TDEditor_TD[4], 100);
	TextDrawSetShadow(TDEditor_TD[4], 0);
	TextDrawSetOutline(TDEditor_TD[4], 0);
	TextDrawBackgroundColor(TDEditor_TD[4], 255);
	TextDrawFont(TDEditor_TD[4], 1);
	TextDrawSetProportional(TDEditor_TD[4], 1);
	TextDrawSetShadow(TDEditor_TD[4], 0);

	TDEditor_TD[5] = TextDrawCreate(201.799835, 122.916648, "criador de empresas");
	TextDrawLetterSize(TDEditor_TD[5], 0.197500, 1.389999);
	TextDrawTextSize(TDEditor_TD[5], 401.000000, 0.000000);
	TextDrawAlignment(TDEditor_TD[5], 1);
	TextDrawColor(TDEditor_TD[5], TD_COLOR_TEXT);
	TextDrawUseBox(TDEditor_TD[5], 1);
	TextDrawBoxColor(TDEditor_TD[5], 0);
	TextDrawSetShadow(TDEditor_TD[5], 0);
	TextDrawSetOutline(TDEditor_TD[5], 1);
	TextDrawBackgroundColor(TDEditor_TD[5], 255);
	TextDrawFont(TDEditor_TD[5], 2);
	TextDrawSetProportional(TDEditor_TD[5], 1);
	TextDrawSetShadow(TDEditor_TD[5], 0);

	TDEditor_TD[6] = TextDrawCreate(204.000000, 166.666549, "nome");
	TextDrawLetterSize(TDEditor_TD[6], 0.296500, 1.098332);
	TextDrawAlignment(TDEditor_TD[6], 1);
	TextDrawColor(TDEditor_TD[6], TD_COLOR_TEXT);
	TextDrawSetShadow(TDEditor_TD[6], 0);
	TextDrawSetOutline(TDEditor_TD[6], 1);
	TextDrawBackgroundColor(TDEditor_TD[6], 255);
	TextDrawFont(TDEditor_TD[6], 2);
	TextDrawSetProportional(TDEditor_TD[6], 1);
	TextDrawSetShadow(TDEditor_TD[6], 0);

	TDEditor_TD[7] = TextDrawCreate(204.000000, 179.016708, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[7], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[7], 100.000000, 13.000000);
	TextDrawAlignment(TDEditor_TD[7], 1);
	TextDrawColor(TDEditor_TD[7], TD_COLOR_SELECT_NORMAL);
	TextDrawSetShadow(TDEditor_TD[7], 0);
	TextDrawSetOutline(TDEditor_TD[7], 0);
	TextDrawBackgroundColor(TDEditor_TD[7], 255);
	TextDrawFont(TDEditor_TD[7], 4);
	TextDrawSetProportional(TDEditor_TD[7], 0);
	TextDrawSetShadow(TDEditor_TD[7], 0);
	TextDrawSetSelectable(TDEditor_TD[7], true);

	TDEditor_TD[8] = TextDrawCreate(204.000000, 198.649734, "valor");
	TextDrawLetterSize(TDEditor_TD[8], 0.296500, 1.098332);
	TextDrawAlignment(TDEditor_TD[8], 1);
	TextDrawColor(TDEditor_TD[8], TD_COLOR_TEXT);
	TextDrawSetShadow(TDEditor_TD[8], 0);
	TextDrawSetOutline(TDEditor_TD[8], 1);
	TextDrawBackgroundColor(TDEditor_TD[8], 255);
	TextDrawFont(TDEditor_TD[8], 2);
	TextDrawSetProportional(TDEditor_TD[8], 1);
	TextDrawSetShadow(TDEditor_TD[8], 0);

	TDEditor_TD[9] = TextDrawCreate(204.000000, 210.999893, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[9], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[9], 100.000000, 13.000000);
	TextDrawAlignment(TDEditor_TD[9], 1);
	TextDrawColor(TDEditor_TD[9], TD_COLOR_SELECT_NORMAL);
	TextDrawSetShadow(TDEditor_TD[9], 0);
	TextDrawSetOutline(TDEditor_TD[9], 0);
	TextDrawBackgroundColor(TDEditor_TD[9], 255);
	TextDrawFont(TDEditor_TD[9], 4);
	TextDrawSetProportional(TDEditor_TD[9], 0);
	TextDrawSetShadow(TDEditor_TD[9], 0);
	TextDrawSetSelectable(TDEditor_TD[9], true);

	TDEditor_TD[10] = TextDrawCreate(204.000000, 230.349517, "interior");
	TextDrawLetterSize(TDEditor_TD[10], 0.296500, 1.098332);
	TextDrawAlignment(TDEditor_TD[10], 1);
	TextDrawColor(TDEditor_TD[10], TD_COLOR_TEXT);
	TextDrawSetShadow(TDEditor_TD[10], 0);
	TextDrawSetOutline(TDEditor_TD[10], 1);
	TextDrawBackgroundColor(TDEditor_TD[10], 255);
	TextDrawFont(TDEditor_TD[10], 2);
	TextDrawSetProportional(TDEditor_TD[10], 1);
	TextDrawSetShadow(TDEditor_TD[10], 0);

	TDEditor_TD[11] = TextDrawCreate(204.000000, 242.699722, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[11], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[11], 100.000000, 13.000000);
	TextDrawAlignment(TDEditor_TD[11], 1);
	TextDrawColor(TDEditor_TD[11], TD_COLOR_SELECT_NORMAL);
	TextDrawSetShadow(TDEditor_TD[11], 0);
	TextDrawSetOutline(TDEditor_TD[11], 0);
	TextDrawBackgroundColor(TDEditor_TD[11], 255);
	TextDrawFont(TDEditor_TD[11], 4);
	TextDrawSetProportional(TDEditor_TD[11], 0);
	TextDrawSetShadow(TDEditor_TD[11], 0);
	TextDrawSetSelectable(TDEditor_TD[11], true);

	TDEditor_TD[12] = TextDrawCreate(335.049774, 167.016052, "mapicon");
	TextDrawLetterSize(TDEditor_TD[12], 0.296500, 1.098332);
	TextDrawAlignment(TDEditor_TD[12], 1);
	TextDrawColor(TDEditor_TD[12], TD_COLOR_TEXT);
	TextDrawSetShadow(TDEditor_TD[12], 0);
	TextDrawSetOutline(TDEditor_TD[12], 1);
	TextDrawBackgroundColor(TDEditor_TD[12], 255);
	TextDrawFont(TDEditor_TD[12], 2);
	TextDrawSetProportional(TDEditor_TD[12], 1);
	TextDrawSetShadow(TDEditor_TD[12], 0);

	TDEditor_TD[13] = TextDrawCreate(389.000000, 121.749969, "X");
	TextDrawLetterSize(TDEditor_TD[13], 0.400000, 1.600000);
	TextDrawTextSize(TDEditor_TD[13], 13.000000, 17.000000);
	TextDrawAlignment(TDEditor_TD[13], 2);
	TextDrawColor(TDEditor_TD[13], TD_COLOR_SELECT_NORMAL);
	TextDrawUseBox(TDEditor_TD[13], 0);
	TextDrawBoxColor(TDEditor_TD[13], 120);
	TextDrawSetShadow(TDEditor_TD[13], 0);
	TextDrawSetOutline(TDEditor_TD[13], 1);
	TextDrawBackgroundColor(TDEditor_TD[13], 255);
	TextDrawFont(TDEditor_TD[13], 1);
	TextDrawSetProportional(TDEditor_TD[13], 1);
	TextDrawSetShadow(TDEditor_TD[13], 0);
	TextDrawSetSelectable(TDEditor_TD[13], true);

	TDEditor_TD[14] = TextDrawCreate(204.000000, 265.098693, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[14], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[14], 87.000000, 28.000000);
	TextDrawAlignment(TDEditor_TD[14], 1);
	TextDrawColor(TDEditor_TD[14], TD_COLOR_SELECT_NORMAL);
	TextDrawSetShadow(TDEditor_TD[14], 0);
	TextDrawSetOutline(TDEditor_TD[14], 0);
	TextDrawBackgroundColor(TDEditor_TD[14], 255);
	TextDrawFont(TDEditor_TD[14], 4);
	TextDrawSetProportional(TDEditor_TD[14], 0);
	TextDrawSetShadow(TDEditor_TD[14], 0);
	TextDrawSetSelectable(TDEditor_TD[14], true);

	TDEditor_TD[15] = TextDrawCreate(247.249832, 272.250061, "criar");
	TextDrawLetterSize(TDEditor_TD[15], 0.400000, 1.600000);
	TextDrawTextSize(TDEditor_TD[15], 0.000000, 84.000000);
	TextDrawAlignment(TDEditor_TD[15], 2);
	TextDrawColor(TDEditor_TD[15], TD_COLOR_TEXT);
	TextDrawUseBox(TDEditor_TD[15], 1);
	TextDrawBoxColor(TDEditor_TD[15], 0);
	TextDrawSetShadow(TDEditor_TD[15], 0);
	TextDrawSetOutline(TDEditor_TD[15], 1);
	TextDrawBackgroundColor(TDEditor_TD[15], 255);
	TextDrawFont(TDEditor_TD[15], 2);
	TextDrawSetProportional(TDEditor_TD[15], 1);
	TextDrawSetShadow(TDEditor_TD[15], 0);
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if(playertextid == TDEditor_PTD[playerid][0]) // Map Icon
	{
		new info[150];
		for(new i; i < sizeof(MapIconModel); i++)
		{
			format(info, sizeof(info), "%s%s\n", info, MapIconModel[i][mapicon_Nome]);
		}
		ShowPlayerDialog(playerid, CB_MAPICON, DIALOG_STYLE_LIST, "{"COR_DISABLE_INC"}CRIAR EMPRESA » {"COR_BRANCO_INC"}MAP ICON", info, "Selecionar", "Cancelar");
		return true;
	}
	return true;
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(Dialog_Opened(playerid))
		return false;

	if(INVALID_TEXT_DRAW == _:clickedid)
	{
		if(CreateBusiness[playerid][Showed])
			call::CREATE_B->HidePlayerCreateB(playerid);
	}
	else if(clickedid == TDEditor_TD[7]) // Nome
	{
		ShowPlayerDialog(playerid, CB_NAME, DIALOG_STYLE_INPUT, "{"COR_DISABLE_INC"}CRIAR EMPRESA » {"COR_BRANCO_INC"}NOME", "{"COR_BRANCO_INC"}\tDigite o nome da empresa.", "Confirmar", "Cancelar");
		return true;
	}
	else if(clickedid == TDEditor_TD[9]) // Valor
	{
		ShowPlayerDialog(playerid, CB_VALUE, DIALOG_STYLE_INPUT,  "{"COR_DISABLE_INC"}CRIAR EMPRESA » {"COR_BRANCO_INC"}VALOR", "{"COR_BRANCO_INC"}\tDigite o valor da empresa.", "Confirmar", "Cancelar");
		return true;
	}
	else if(clickedid == TDEditor_TD[11]) // interior
	{
		new str[4096], name[70], interior;
		str = "id.Nome\tInterior\n";
		for(new i; i < MAX_INTERIORS; i++)
		{
			GetInteriorInformation(i, name, .Interior = interior);
			format(str, sizeof(str), "%s%d.%s\t%d\n", str, i, name, interior);
		}
		ShowPlayerDialog(playerid, CB_INTERIORS, DIALOG_STYLE_TABLIST_HEADERS,  "{"COR_DISABLE_INC"}CRIAR EMPRESA » {"COR_BRANCO_INC"}INTERIORES", str, "Confirmar", "Cancelar");
		return true;
	}
	else if(clickedid == TDEditor_TD[14])
	{
		if(isnull(CreateBusiness[playerid][Nome]))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você deve digitar um nome para empresa.");

		if(CreateBusiness[playerid][Preco] <= 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você deve digitar um valor para a empresa.");

		if(CreateBusiness[playerid][InteriorID] < 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você tem que escolher um interior.");

		if(CreateBusiness[playerid][MapIcon] <= 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você tem que escolher um map icon para a empresa.");

		call::CREATE_B->CreateBusinessForTable(playerid);
		return true;
	}
	else if(clickedid == TDEditor_TD[13])
	{
		call::CREATE_B->HidePlayerCreateB(playerid);
		return true;
	}
	return true;
}

hook OnPlayerConnect(playerid)
{
	// empty vars
	new rst[e_CREATE_BUSINESS];
	CreateBusiness[playerid] = rst;

	CreateBusiness[playerid][InteriorID] = -1;
	return true;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(!GetPVarInt(playerid, "keyLiberada"))
		return false;
	
	if(PRESSED(KEY_CROUCH))
	{
		new Float:x, Float:y, Float:z, Float:a, BUSINESSID = GetPVarInt(playerid, "businessid");
		
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);
		
		call::BUSINESS->SetBusinessExitPos(BUSINESSID, x, y, z, a, GetPlayerInterior(playerid));
		DeletePVar(playerid, "keyLiberada");
		DeletePVar(playerid, "businessid");
		
		new str[4];
		valstr(str, BUSINESSID);
		callcmd::irempresa(playerid, str);
		call::CREATE_B->ShowPlayerManagerB(playerid, BUSINESSID);

		call::BUSINESS->UpdateBusinessData(BUSINESSID);

		SendClientMessage(playerid, COR_SISTEMA, "CMD-ADMIN: {"COR_BRANCO_INC"}Interior alterado com {"COR_VERDE_INC"}sucesso{"COR_BRANCO_INC"}.");
		return true;		
	}
	return true;
}
/*				Dialogs 				*/

Dialog:CB_NAME(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		for(new i; i < strlen(inputtext); i++)
			if(inputtext[i] == '\'')inputtext[i] = ' ';//'
		
		format(CreateBusiness[playerid][Nome], MAX_BUSINESS_NAME, inputtext);
		PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][1], inputtext);
		return true;
	}
	return false;
}

Dialog:CB_VALUE(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(!IsNumeric(inputtext) || isnull(inputtext) || strval(inputtext) <= 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você tem que digitar um valor maior 0.");

		if(strval(inputtext) > 900000000)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode colocar um valor maior que R$90.000.000.");

		CreateBusiness[playerid][Preco] = strval(inputtext);

		new str[20];
		format(str, 20, "~g~R$%s", RealStr(CreateBusiness[playerid][Preco]));
		PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][2], str);
		return true;
	}
	return false;
}

Dialog:CB_INTERIORS(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new nome[128];
		CreateBusiness[playerid][InteriorID] = listitem;
		GetInteriorInformation(CreateBusiness[playerid][InteriorID], nome, CreateBusiness[playerid][Saida][X], CreateBusiness[playerid][Saida][Y], CreateBusiness[playerid][Saida][Z], CreateBusiness[playerid][Saida][A], CreateBusiness[playerid][Interior]);
		PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][3], nome);
		return true;
	}
	return false;
}

Dialog:CB_MAPICON(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		CreateBusiness[playerid][MapIcon] = MapIconModel[listitem][mapicon_ID];
		PlayerTextDrawSetPreviewModel(playerid, TDEditor_PTD[playerid][0], MapIconModel[listitem][mapicon_ID] + 19200);
		PlayerTextDrawShow(playerid, TDEditor_PTD[playerid][0]);
		return true;
	}
	return true;
}

Dialog:CB_MANAGER(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: // alterar nome
			{
				ShowPlayerDialog(playerid, CB_ALTER_NAME, DIALOG_STYLE_INPUT, "{"COR_DISABLE_INC"}GERENCIAR EMPRESA » {"COR_BRANCO_INC"}ALTERAR NOME", "{"COR_BRANCO_INC"}Digite um novo nome.", "Alterar", "Cancelar");
				return true;
			}
			case 1: // Alterar Entrada
			{
				callcmd::editarempresa(playerid);
				return true;
			}
			case 2: // Alterar Saida
			{
				new str[4096], name[70], interior;
				str = "id.Nome\tInterior\n";
				for(new i; i < MAX_INTERIORS; i++)
				{
					GetInteriorInformation(i, name, .Interior = interior);
					format(str, sizeof(str), "%s%d.%s\t%d\n", str, i, name, interior);
				}
				ShowPlayerDialog(playerid, CB_ALTER_INTERIORS, DIALOG_STYLE_TABLIST_HEADERS,  "{"COR_DISABLE_INC"}EDITAR EMPRESA » {"COR_BRANCO_INC"}INTERIORES", str, "Confirmar", "Cancelar");
				return true;
			}
			case 3: // Alterar Valor
			{
				ShowPlayerDialog(playerid, CB_ALTER_VALUE, DIALOG_STYLE_INPUT, "{"COR_DISABLE_INC"}GERENCIAR EMPRESA » {"COR_BRANCO_INC"}ALTERAR VALOR", "{"COR_BRANCO_INC"}Digite o novo valor da empresa.", "Alterar", "Cancelar");
				return true;
			}
			case 4: // Excluir Empresa
			{
				ShowPlayerDialog(playerid, CB_DELETE, DIALOG_STYLE_MSGBOX, "{"COR_DISABLE_INC"}GERENCIAR EMPRESA » {"COR_BRANCO_INC"}EXCLUIR", "{"COR_BRANCO_INC"}Você tem certeza que deseja excluir essa empresa?\n\n\t{"COR_ERRO_INC"}Essa ação é irreversível.", "Deletar", "Cancelar");
				return true;
			}
		}
		return true;
	}
	return true;
}

Dialog:CB_ALTER_NAME(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(strlen(inputtext) < 5 || isnull(inputtext) || strlen(inputtext) > MAX_BUSINESS_NAME)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você digitou um nome inválido."), callcmd::editarempresa(playerid);

		new businessid = call::BUSINESS->GetBusinessInRangeP(playerid, 3.0);
		call::BUSINESS->SetBusinessParams(businessid, Nome, inputtext);
		call::BUSINESS->UpdateBusinessTexts(businessid);

		new query[200];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_BUSINESS" SET `nome`='%e' WHERE `id`='%d' LIMIT 1;", inputtext, call::BUSINESS->GetBusinessColumID(businessid));
		mysql_tquery(getConexao(), query);

		SendClientMessage(playerid, COR_SISTEMA, "» Nome da empresa alterado para %s", inputtext);
	}
	callcmd::editarempresa(playerid);
	return true;
}

Dialog:CB_ALTER_INTERIORS(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new Float:x, Float:y, Float:z, Float:a, interior;
		GetInteriorInformation(listitem, .eX=x, .eY=y, .eZ=z, .eA=a, .Interior=interior);
		
		SetPVarInt(playerid, "businessid", call::BUSINESS->GetBusinessInRangeP(playerid, 2.0));
		SetPVarInt(playerid, "keyLiberada", true);

		SetPlayerPos(playerid, x, y, z);
		SetPlayerInterior(playerid, interior);

		CleanChat(playerid);
		SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Agora vá onde você quer que fique a saida e clique no botão '{"COR_BRANCO_INC"}C{"COR_BRANCO_INC"}'.");
		return true;
	}
	callcmd::editarempresa(playerid);
	return true;
}

Dialog:CB_ALTER_VALUE(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(isnull(inputtext) || !IsNumeric(inputtext))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa digitar um número."),callcmd::editarempresa(playerid);
		
		new valor = strval(inputtext), businessid = call::BUSINESS->GetBusinessInRangeP(playerid, 3.0);
		
		if(!call::BUSINESS->IsValidBusiness(businessid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está proximo a propriedade."),callcmd::editarempresa(playerid);

		if(valor > 900000000)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Digite um valor abaixo de R$900.000.000"),callcmd::editarempresa(playerid);
		if(valor <= 0)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Digite um valor acima de R$0"),callcmd::editarempresa(playerid);

		call::BUSINESS->SetBusinessParamsInt(businessid, Valor, valor);
		call::BUSINESS->UpdateBusinessTexts(businessid);

		new query[200];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_BUSINESS" SET `valor`='%d' WHERE `id`='%d' LIMIT 1;", valor, call::BUSINESS->GetBusinessColumID(businessid));
		mysql_tquery(getConexao(), query);

		SendClientMessage(playerid, COR_SISTEMA, "CMD-ADMIN: {"COR_BRANCO_INC"}Valor da empresa alterado com {"COR_VERDE_INC"}sucesso{"COR_BRANCO_INC"}.");
	}
	callcmd::editarempresa(playerid);
	return true;
}

Dialog:CB_DELETE(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new businessid = call::BUSINESS->GetBusinessInRangeP(playerid, 2.0);
		
		if(!call::BUSINESS->IsValidBusiness(businessid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não foi possivel excluir a empresa.");

		new query[128];
		mysql_format(getConexao(), query, sizeof(query), "DELETE FROM "TABLE_BUSINESS" WHERE `id`='%d' LIMIT 1;", call::BUSINESS->GetBusinessColumID(businessid));
		mysql_tquery(getConexao(), query);
		call::BUSINESS->DestroyBusiness(businessid);

		SendClientMessage(playerid, COR_SISTEMA, "CMD-ADMIN: {"COR_BRANCO_INC"}A Empresa foi excluida do banco de dados do servidor.");
		return true;
	}
	return true;
}