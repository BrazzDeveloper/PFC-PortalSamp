

// ============================== [ VARI√ùVEIS ] ============================== //

static stock
	CP_BURGESHOT,
	CP_CLUCKINBELL,
	CP_PIZZARIA,
	CP_UTILITARIOS, CP_UTILITARIOS_2,
	CP_AMMU[2],
	CP_BINCO,
	CP_ZIP,
	CP_SUBURBAN,
	CP_PROLABS,
	CP_DS,
	CP_VICTIM,
	CP_BAR, CP_BAR_2,
	CP_JIMS,
	CP_GYM,
	CP_JAYS
;

static stock
	SKINS_BINCO = mS_INVALID_LISTID,
	SKINS_DS = mS_INVALID_LISTID,
	SKINS_PROLAPS = mS_INVALID_LISTID,
	SKINS_SUBURBAN = mS_INVALID_LISTID,
	SKINS_VICTIM = mS_INVALID_LISTID,
	SKINS_ZIP = mS_INVALID_LISTID,
	SKINS_VIP = mS_INVALID_LISTID
;


// ============================== [ PUBLICS ] ============================== //
#include <YSI_Coding\y_hooks>
hook OnGameModeInit()
{


	CP_BAR = CreateDynamicCP(495.8783,-75.6523,998.7578, 1.1, .streamdistance=20.0); 	// Bar 1
	CreateDynamic3DTextLabel("Utilize {ffffff}/comprar bebidas{ffff00} para abrir o menu de produtos.", 0xFFFF00FF, 495.8783,-75.6523,998.7578, 2.0, .testlos=1, .interiorid=11);

	CP_BAR_2 = CreateDynamicCP(-225.4222, 1403.9116, 27.7734, 1.1, .streamdistance=20.0); 	// Bar 2
	CreateDynamic3DTextLabel("Utilize {ffffff}/comprar bebidas{ffff00} para abrir o menu de produtos.", 0xFFFF00FF, -225.4222, 1403.9116, 27.7734, 2.0, .testlos=1, .interiorid=18);
	
	CP_BURGESHOT = CreateDynamicCP(377.1304,-68.7387,1001.5151, 1.1, .streamdistance=20.0); 		// Lanchonete
	CreateDynamic3DTextLabel("Utilize {ffffff}/comprar comida{ffff00} para pegar o cardapio do Burger Shot", 0xFFFF00FF, 377.1304, -68.7387, 1001.5151, 2.0, .testlos=1, .interiorid=10);

	CP_CLUCKINBELL = CreateDynamicCP(368.0383, -6.5484, 1001.8516, 1.1, .streamdistance=20.0);
	CreateDynamic3DTextLabel("Utilize {ffffff}/comprar comida{ffff00} para pegar o cardapio do Cluckin Bell", 0xFFFF00FF, 368.0383, -6.5484, 1001.8516, 2.0, .testlos=1, .interiorid=9);

	CP_PIZZARIA = CreateDynamicCP(373.8690,-119.5492,1001.4922, 1.1, .streamdistance=20.0); 	// Pizzaria
	CreateDynamic3DTextLabel("Utilize {ffffff}/comprar comida{ffff00} para pegar o cardapio da Pizzaria", 0xFFFF00FF, 373.8690, -119.5492, 1001.4922, 2.0, .testlos=1, .interiorid=5);

	CP_UTILITARIOS = CreateDynamicCP(-29.3294,-184.5978,1003.5469, 1.1, .streamdistance=20.0); 	// Utilit√°rios 1
	CreateDynamic3DTextLabel("Utilize {ffffff}/comprar produtos{ffff00} para abrir o menu de produtos.", 0xFFFF00FF, -29.3294, -184.5978, 1003.5469, 2.0, .testlos=1, .interiorid=17);

	CP_UTILITARIOS_2 = CreateDynamicCP(1.9196,-28.3772,1003.5494, 1.1, .streamdistance=20.0); 	// Utilit√°rios 2
	CreateDynamic3DTextLabel("Utilize {ffffff}/comprar produtos{ffff00} para abrir o menu de produtos.", 0xFFFF00FF, 1.9196, -28.3772, 1003.5494, 2.0, .testlos=1, .interiorid=10);

	CP_AMMU[0] = CreateDynamicCP(313.6173,-133.7305,999.6016, 1.1, .streamdistance=20.0); 		// Ammunation 1
	CreateDynamic3DTextLabel("Utilize {ffffff}/comprar armas{ffff00} para comprar uma armas", 0xFFFF00FF, 313.6173, -133.7305, 999.6016, 2.0, .testlos=1, .interiorid=7);
	
	CP_AMMU[1] = CreateDynamicCP(295.9034,-38.3043,1001.5156, 1.1, .streamdistance=20.0); 		// Ammunation 2
	CreateDynamic3DTextLabel("Utilize {ffffff}/comprar armas{ffff00} para comprar uma armas", 0xFFFF00FF, 295.9034, -38.3043, 1001.5156, 2.0, .testlos=1, .interiorid=1);
	

	CP_BINCO = CreateDynamicCP(207.5478,-101.1524,1005.2578, 1.1, .streamdistance=20.0, .interiorid=15); 		// binco
	CreateDynamic3DTextLabel("Utilize {ffffff}/comprar skin{ffff00} para comprar uma skin", 0xFFFF00FF, 207.5478, -101.1524, 1005.2578, 2.0, .testlos=1, .interiorid=15);

	CP_ZIP = CreateDynamicCP(161.5397,-84.0958,1001.8047, 1.1, .streamdistance=20.0); 		// zip
	CreateDynamic3DTextLabel("Utilize {ffffff}/comprar skin{ffff00} para comprar uma skin", 0xFFFF00FF, 161.5397, -84.0958, 1001.8047, 2.0, .testlos=1, .interiorid=18);

	CP_SUBURBAN = CreateDynamicCP(203.5868,-43.7100,1001.8047, 1.1, .streamdistance=20.0); 		// suburban
	CreateDynamic3DTextLabel("Utilize {ffffff}/comprar skin{ffff00} para comprar uma skin", 0xFFFF00FF, 203.5868, -43.7100, 1001.8047, 2.0, .testlos=1, .interiorid=1);

	CP_PROLABS = CreateDynamicCP(207.1793,-129.7463,1003.5078, 1.1, .streamdistance=20.0); 	// Prolabs
	CreateDynamic3DTextLabel("Utilize {ffffff}/comprar skin{ffff00} para comprar uma skin", 0xFFFF00FF, 207.1793, -129.7463, 1003.5078, 2.0, .testlos=1, .interiorid=3);

	CP_DS = CreateDynamicCP(204.4262,-159.6460,1000.5234, 1.1, .streamdistance=20.0);     // Ds
	CreateDynamic3DTextLabel("Utilize {ffffff}/comprar skin{ffff00} para comprar uma skin", 0xFFFF00FF, 204.4262, -159.6460, 1000.5234, 2.0, .testlos=1, .interiorid=14);

	CP_VICTIM = CreateDynamicCP(209.9792,-8.2455,1005.2109, 1.1, .streamdistance=20.0);     // Victim
	CreateDynamic3DTextLabel("Utilize {ffffff}/comprar skin{ffff00} para comprar uma skin", 0xFFFF00FF, 209.9792, -8.2455, 1005.2109, 2.0, .testlos=1, .interiorid=5);

	CP_JIMS = CreateDynamicCP(379.1111,-190.7090,1000.6328, 1.1, .streamdistance=20.0);
	CreateDynamic3DTextLabel("Utilize {ffffff}/comprar comida {ffff00}para pegar o card·pio da Jim's Sticky Ring", 0xFFFF00FF, 379.1111,-190.7090,1000.6328, 2.0, .testlos=1, .interiorid=17);
	
	CP_JAYS = CreateDynamicCP(379.1111,-190.7090,1000.6328, 1.1, .streamdistance=20.0);
	CreateDynamic3DTextLabel("Utilize {ffffff}/comprar comida {ffff00}para pegar o card·pio da Jay's Dinner", 0xFFFF00FF, 450.2151,-84.5274,999.5547, 2.0, .testlos=1, .interiorid=4);

	CP_GYM = CreateDynamicCP(767.1169,11.2481,1000.7061, 1.1, .streamdistance=20.0);
	CreateDynamic3DTextLabel("Utilize {ffffff}/lutas {ffff00}para aprender um novo estilo de luta", 0xFFFF00FF, 767.1169,11.2481,1000.7061, 2.0, .testlos=1, .interiorid=5);

	// ================ [ LOAD SELECTIONs ] ========= //
	SKINS_BINCO = LoadModelSelectionMenu("skins/skins_binco.txt");
	SKINS_DS = LoadModelSelectionMenu("skins/skins_didiersachs.txt");
	SKINS_PROLAPS = LoadModelSelectionMenu("skins/skins_prolaps.txt");
	SKINS_SUBURBAN = LoadModelSelectionMenu("skins/skins_suburban.txt");
	SKINS_VICTIM = LoadModelSelectionMenu("skins/skins_victim.txt");
	SKINS_ZIP = LoadModelSelectionMenu("skins/skins_zip.txt");
	SKINS_VIP = LoadModelSelectionMenu("skins/skins_vip.txt");
}

hook OnPlayerModelSelection(playerid, response, listid, modelid)
{
	if(listid == SKINS_BINCO)
	{
	    if(response)
	    {
	    	Jogador[playerid][Skin] = modelid, SetPlayerSkin(playerid, modelid);
			SendClientMessage(playerid, -1, "| SKIN | VocÍ comprou a skin ID {1c88f0}%d{ffffff} e pagou {31b404}R$500{ffffff}.", modelid);
			
			GameTextForPlayer(playerid, "~b~~h~COMPRA DE SKIN EFETUADA!", 3000, 4);
			GivePlayerMoney(playerid, -500, true);

			/**
			*
			*	setar valor ao cofre.
			*
			**/
			if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
			{
				new businessid = GetPlayerVirtualWorld(playerid);
				if ( call::BUSINESS->IsValidBusiness(businessid) )
				{
					call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 500);
				}
			}
	    }
    	return Y_HOOKS_BREAK_RETURN_1;
	}
	if(listid == SKINS_DS)
	{
	    if(response)
	    {
	    	Jogador[playerid][Skin] = modelid, SetPlayerSkin(playerid, modelid);
			SendClientMessage(playerid, -1, "| SKIN | VocÍ comprou a skin ID {1c88f0}%d {ffffff}e pagou {31b404}R$500{ffffff}.", modelid);
			GameTextForPlayer(playerid, "~b~~h~COMPRA DE SKIN EFETUADA!", 3000, 4);
			GivePlayerMoney(playerid, -500, true);

			/**
			*
			*	setar valor ao cofre.
			*
			**/
			if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
			{
				new businessid = GetPlayerVirtualWorld(playerid);
				if ( call::BUSINESS->IsValidBusiness(businessid) )
				{
					call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 500);
				}
			}
	    }
    	return Y_HOOKS_BREAK_RETURN_1;
	}
	if(listid == SKINS_PROLAPS)
	{
	    if(response)
	    {
	    	Jogador[playerid][Skin] = modelid, SetPlayerSkin(playerid, modelid);
			SendClientMessage(playerid, -1, "| SKIN | VocÍ comprou a skin ID {1c88f0}%d {ffffff}e pagou {31b404}R$500{ffffff}.", modelid);
			GameTextForPlayer(playerid, "~b~~h~COMPRA DE SKIN EFETUADA!", 3000, 4);
			GivePlayerMoney(playerid, -500, true);

			/**
			*
			*	setar valor ao cofre.
			*
			**/
			if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
			{
				new businessid = GetPlayerVirtualWorld(playerid);
				if ( call::BUSINESS->IsValidBusiness(businessid) )
				{
					call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 500);
				}
			}
	    }
    	return Y_HOOKS_BREAK_RETURN_1;
	}
	if(listid == SKINS_SUBURBAN)
	{
	    if(response)
	    {
	    	Jogador[playerid][Skin] = modelid, SetPlayerSkin(playerid, modelid);
			SendClientMessage(playerid, -1, "| SKIN | VocÍ comprou a skin ID {1c88f0}%d {ffffff}e pagou {31b404}R$500{ffffff}.", modelid);
			GameTextForPlayer(playerid, "~b~~h~COMPRA DE SKIN EFETUADA!", 3000, 4);
			GivePlayerMoney(playerid, -500, true);

			/**
			*
			*	setar valor ao cofre.
			*
			**/
			if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
			{
				new businessid = GetPlayerVirtualWorld(playerid);
				if ( call::BUSINESS->IsValidBusiness(businessid) )
				{
					call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 500);
				}
			}
	    }
    	return Y_HOOKS_BREAK_RETURN_1;
	}
	if(listid == SKINS_VICTIM)
	{
	    if(response)
	    {
	    	Jogador[playerid][Skin] = modelid, SetPlayerSkin(playerid, modelid);
			SendClientMessage(playerid, -1, "| SKIN | VocÍ comprou a skin ID {1c88f0}%d {ffffff}e pagou {31b404}R$500{ffffff}.", modelid);
			GameTextForPlayer(playerid, "~b~~h~COMPRA DE SKIN EFETUADA!", 3000, 4);
			GivePlayerMoney(playerid, -500, true);

			/**
			*
			*	setar valor ao cofre.
			*
			**/
			if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
			{
				new businessid = GetPlayerVirtualWorld(playerid);
				if ( call::BUSINESS->IsValidBusiness(businessid) )
				{
					call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 500);
				}
			}
	    }
    	return Y_HOOKS_BREAK_RETURN_1;
	}
	if(listid == SKINS_ZIP)
	{
	    if(response)
	    {
	    	Jogador[playerid][Skin] = modelid, SetPlayerSkin(playerid, modelid);
			SendClientMessage(playerid, -1, "| SKIN | VocÍ comprou a skin ID {1c88f0}%d {ffffff}e pagou {31b404}R$500{ffffff}.", modelid);
			GameTextForPlayer(playerid, "~b~~h~COMPRA DE SKIN EFETUADA!", 3000, 4);
			GivePlayerMoney(playerid, -500, true);

			/**
			*
			*	setar valor ao cofre.
			*
			**/
			if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
			{
				new businessid = GetPlayerVirtualWorld(playerid);
				if ( call::BUSINESS->IsValidBusiness(businessid) )
				{
					call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 500);
				}
			}
	    }
    	return Y_HOOKS_BREAK_RETURN_1;
	}
	if(listid == SKINS_VIP)
	{
	    if(response)
	    {
	    	Jogador[playerid][Skin] = modelid, SetPlayerSkin(playerid, modelid);
			SendClientMessage(playerid, -1, "| SKIN | VocÍ comprou a skin ID {1c88f0}%d {ffffff}e pagou {31b404}R$500{ffffff}.", modelid);
			GameTextForPlayer(playerid, "~b~~h~COMPRA DE SKIN EFETUADA!", 3000, 4);
			GivePlayerMoney(playerid, -500, true);
			
			/**
			*
			*	setar valor ao cofre.
			*
			**/
			if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
			{
				new businessid = GetPlayerVirtualWorld(playerid);
				if ( call::BUSINESS->IsValidBusiness(businessid) )
				{
					call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 500);
				}
			}
	    }
    	return Y_HOOKS_BREAK_RETURN_1;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

static used[MAX_PLAYERS];

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_FIRE) && used[playerid] > 0)
	{
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DRINK_SPRUNK)
		{
			if(call::PLAYER->GetPlayerVarInt(playerid, FoodTime) > gettime()){
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
				return Y_HOOKS_BREAK_RETURN_1;
			}

			used[playerid] -= 3;
			call::PLAYER->SetPlayerVarFloat(playerid, Sede, call::PLAYER->GetPlayerVarFloat(playerid, Sede) + 3);

			if(used[playerid] <= 0)
			{
				used[playerid] = 0;
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
				return Y_HOOKS_BREAK_RETURN_1;
			}
			call::PLAYER->SetPlayerVarInt(playerid, FoodTime, gettime() + 3);
			return Y_HOOKS_BREAK_RETURN_1;
		}
		return Y_HOOKS_CONTINUE_RETURN_1;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}
// ============================== [ COMANDOS ] ============================== //

CMD:comprar(playerid, params[])
{
	new tmp[20];
	if(sscanf(params, "s[20]", tmp))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/comprar [ armas/ comida / skin / produtos ]");

	if(strcmp(tmp, "armas", true) == 0)
	{
		if(IsPlayerInDynamicCP(playerid, CP_AMMU[0]) || IsPlayerInDynamicCP(playerid, CP_AMMU[1]) ){
			return ShowPlayerDialog(playerid, COMPRAR_ARMAS_AMMUNATION, DIALOG_STYLE_TABLIST_HEADERS, "{1c88f0}Ammu-Nation", "Arma\tValor\n9MM\t{088A08}R$1.000\n9MM-Silenciador\t{088A08}R$1.300\nDesert Eagle\t{088A08}R$2.500\nM4\t{088A08}R$7.000\nAK47\t{088A08}R$6.000\nUzi\t{088A08}R$4.000\nMP5\t{088A08}R$5.000\nShotgun\t{088A08}R$3.500\nSniper Rifle\t{088A08}R$6.500", "Comprar", "Cancelar");
		}
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o est· na Ammu-Nation");
	}
	else if(strcmp(tmp, "comida", true) == 0)
	{
		if(IsPlayerInDynamicCP(playerid, CP_BURGESHOT))
		{
			ShowPlayerDialog(playerid, CATEGORIA_COMIDA_BURGE, DIALOG_STYLE_LIST, "{"COR_DISABLE_INC"}COMPRAR ª COMIDA ª {"COR_BRANCO_INC"}BURGER SHOT",
			"Lanches\nRefrigerantes\nSucos", "Comprar", "Fechar");
			return true;
		}

		else if(IsPlayerInDynamicCP(playerid, CP_JIMS))
		{
			ShowPlayerDialog(playerid, CATEGORIA_COMIDA_BURGE, DIALOG_STYLE_LIST, "{"COR_DISABLE_INC"}COMPRAR ª COMIDA ª {"COR_BRANCO_INC"}JIM'S STICKY RING",
			"Lanches\nRefrigerantes\nSucos", "Comprar", "Fechar");
			return true;
		}

		else if(IsPlayerInDynamicCP(playerid, CP_JAYS))
		{
			ShowPlayerDialog(playerid, CATEGORIA_COMIDA_BURGE, DIALOG_STYLE_LIST, "{"COR_DISABLE_INC"}COMPRAR ª COMIDA ª {"COR_BRANCO_INC"}JIM'S STICKY RING",
			"Lanches\nRefrigerantes\nSucos", "Comprar", "Fechar");
			return true;
		}

		else if(IsPlayerInDynamicCP(playerid, CP_PIZZARIA))
		{
			ShowPlayerDialog(playerid, CATEGORIA_COMIDA_PIZZA, DIALOG_STYLE_LIST, "{"COR_DISABLE_INC"}COMPRAR ª COMIDA ª {"COR_BRANCO_INC"}PIZZARIA",
			"Pizzas\nRefrigerantes\nSucos", "Comprar", "Fechar");
			return true;
		}
		else if(IsPlayerInDynamicCP(playerid, CP_CLUCKINBELL))
		{
			ShowPlayerDialog(playerid, COMPRAR_COMIDA_CLUCKIN, DIALOG_STYLE_TABLIST_HEADERS, "{"COR_DISABLE_INC"}COMPRAR ª COMIDA ª {"COR_BRANCO_INC"}CLUCKIN BELL",
				"Comida\tValor\t-\n\
				PedaÁo de Frango\t{"COR_VERDE_INC"}R$20\t{"COR_VERDE_INC"}+{"COR_BRANCO_INC"}20 Fome\n\
				Sprunk\t{"COR_VERDE_INC"}R$5\t{"COR_VERDE_INC"}+{"COR_BRANCO_INC"}15 Sede\n\
				", "Comprar", "Fechar");
			return true;
		}
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o est· em uma pizzaria ou lanchonete.");
	}
	else if(strcmp(tmp, "bebidas", true) == 0)
	{
		if( IsPlayerInDynamicCP(playerid, CP_BAR) || IsPlayerInDynamicCP(playerid, CP_BAR_2))
		{
			ShowPlayerDialog(playerid, CATEGORIA_BEBIDAS_BAR, DIALOG_STYLE_LIST, "{"COR_DISABLE_INC"}COMPRAR ª BEBIDAS ª {"COR_BRANCO_INC"}BAR",
				"Cervejas\nCigarros", "Comprar", "Fechar");
			return true;
		}
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o est· em um bar.");
	}
	else if(strcmp(tmp, "skin", true) == 0)
	{
		if(IsPlayerInDynamicCP(playerid, CP_BINCO))
	    {
	        SendClientMessage(playerid, COR_AVISO, "Bem-vindo(a) · loja de roupas {FFFFFF}Binco.");
	        ShowModelSelectionMenu(playerid, SKINS_BINCO, "Skins ~w~~h~Binco");
	        return true;
	    }
	    else if(IsPlayerInDynamicCP(playerid, CP_ZIP))
	    {
	        SendClientMessage(playerid, COR_AVISO, "Bem-vindo(a) · loja de roupas {FFFFFF}ZIP.");
	        ShowModelSelectionMenu(playerid, SKINS_ZIP, "Skins ~w~~h~ZIP");
	        return true;
	    }
	    else if(IsPlayerInDynamicCP(playerid, CP_VICTIM))
	    {
	        SendClientMessage(playerid, COR_AVISO, "Bem-vindo(a) · loja de roupas {FFFFFF}VICTIM.");
	        ShowModelSelectionMenu(playerid, SKINS_VICTIM, "Skins ~w~~h~Victim");
	        return true;
	    }
	    else if(IsPlayerInDynamicCP(playerid, CP_PROLABS))
	    {
	        SendClientMessage(playerid, COR_AVISO, "Bem-vindo(a) · loja de roupas {FFFFFF}TRAINHARD e PROLAPS.");
	        ShowModelSelectionMenu(playerid, SKINS_PROLAPS, "~w~~h~Train Hard e Pro Laps");
	        return true;
	    }
	    else if(IsPlayerInDynamicCP(playerid, CP_DS))
	    {
	        SendClientMessage(playerid, COR_AVISO, "Bem-vindo(a) · loja de roupas {FFFFFF}DIDIERSACHS.");
	        ShowModelSelectionMenu(playerid, SKINS_DS, "Skins ~w~~h~DidierSachs");
	        return true;
		}
		else if(IsPlayerInDynamicCP(playerid, CP_SUBURBAN))
	    {
	        SendClientMessage(playerid, COR_AVISO, "Bem-vindo(a) · loja de roupas {FFFFFF}SUB URBAN.");
	        ShowModelSelectionMenu(playerid, SKINS_SUBURBAN, "Skins ~w~~h~Sub Urban");
	        return true;
		}
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o est· em uma loja de skins.");
	}
	else if ( strcmp(tmp, "produtos", true) == 0)
	{
		if ( IsPlayerInDynamicCP(playerid, CP_UTILITARIOS) || IsPlayerInDynamicCP(playerid, CP_UTILITARIOS_2) )
		{
			ShowPlayerDialog(playerid, COMPRAR_UTILITARIOS, DIALOG_STYLE_TABLIST, "LOJA DE UTILIT¡RIOS", "{"COR_BRANCO_INC"}GPS\t{"COR_VERDE_INC"}R$800\nCelular\t{"COR_VERDE_INC"}R$1.200\nCrÈditos\t{"COR_VERMELHO_INC"}+\nAgenda TelefÙnica\t{"COR_VERDE_INC"}R$20\nMP3 Player\t{"COR_VERDE_INC"}R$150\nGal„o de Gasolina\t{"COR_VERDE_INC"} R$60", "Comprar", "Fechar");
			return true;
		}
		SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o est· em uma loja de utilit·rios.");
		return true;
	}
	return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/comprar [ armas/ comida / skin / produtos / bebidas ]");
}


Dialog:COMPRAR_ARMAS_AMMUNATION(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0:// 9MM R$2.000
			{
				if(GetPlayerScore(playerid) < 15 )
					return SendClientMessage(playerid, 0xFF0000FF, "| ERRO | VocÍ n„o tem level suficiente.");
				
				if(GetPlayerMoney(playerid) < 1000)
					return SendClientMessage(playerid, 0xFF0000FF, "| ERRO | VocÍ n„o tem dinheiro suficiente.");

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 1000);
					}
				}
				GivePlayerWeapon(playerid, WEAPON_COLT45, 80), GivePlayerMoney(playerid, -1000, true);
				return SendClientMessage(playerid, -1, "| AMMU-NATION | VocÍ adquiriu a arma {1c88f0}9MM {ffffff}com {1c88f0}80 {ffffff}balas no valor de {00ff00}R$1.000{ffffff}.");
			}
			case 1:// 9mm-Silenciador  R$4.500
			{
				if(GetPlayerScore(playerid) < 15 )
					return SendClientMessage(playerid, 0xFF0000FF, "| ERRO | VocÍ n„o tem level suficiente.");
				
				if(GetPlayerMoney(playerid) < 1300)
					return SendClientMessage(playerid, 0xFF0000FF, "| ERRO | VocÍ n„o tem dinheiro suficiente.");

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 1300);
					}
				}
				GivePlayerWeapon(playerid, WEAPON_SILENCED, 80), GivePlayerMoney(playerid, -1300, true);
				return SendClientMessage(playerid, -1, "| AMMU-NATION | VocÍ adquiriu a arma {1C88F0}9MM-SILENCIADOR {ffffff}com {1c88f0}80 {ffffff}balas no valor de {00ff00}R$1.300{ffffff}.");
			}
			case 2:// Desert Eagle  R$8.000
			{
				if(GetPlayerScore(playerid) < 15 )
					return SendClientMessage(playerid, 0xFF0000FF, "| ERRO | VocÍ n„o tem level suficiente.");
				
				if(GetPlayerMoney(playerid) < 2500)
					return SendClientMessage(playerid, 0xFF0000FF, "| ERRO | VocÍ n„o tem dinheiro suficiente.");

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 2500);
					}
				}
				GivePlayerWeapon(playerid, WEAPON_DEAGLE, 90), GivePlayerMoney(playerid, -2500, true);
				return SendClientMessage(playerid, -1, "| AMMU-NATION | VocÍ adquiriu a arma {1c88f0}Desert Eagle {ffffff}com {1c88f0}90 {ffffff}balas no valor de {00ff00}R$2.500{ffffff}.");
			}
			case 3:// M4 R$32.000
			{
				if(GetPlayerScore(playerid) < 15 )
					return SendClientMessage(playerid, 0xFF0000FF, "| ERRO | VocÍ n„o tem level suficiente.");
				
				if(GetPlayerMoney(playerid) < 7000)
					return SendClientMessage(playerid, 0xFF0000FF, "| ERRO | VocÍ n„o tem dinheiro suficiente.");

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 7000);
					}
				}
				GivePlayerWeapon(playerid, WEAPON_M4, 999), GivePlayerMoney(playerid, -7000, true);
				return SendClientMessage(playerid, -1, "| AMMU-NATION | VocÍ adquiriu a arma {1C88F0}M4 {ffffff}com {1c88f0}999 {ffffff}balas no valor de {00ff00}R$7.000{ffffff}.");
			}
			case 4:// AK47 R$30.000
			{
				if(GetPlayerScore(playerid) < 15 )
					return SendClientMessage(playerid, 0xFF0000FF, "| ERRO | VocÍ n„o tem level suficiente.");
				
				if(GetPlayerMoney(playerid) < 6000)
					return SendClientMessage(playerid, 0xFF0000FF, "| ERRO | VocÍ n„o tem dinheiro suficiente.");

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 6000);
					}
				}
				GivePlayerWeapon(playerid, WEAPON_AK47, 220), GivePlayerMoney(playerid, -6000, true);
				return SendClientMessage(playerid, -1, "| AMMU-NATION | VocÍ adquiriu a arma {1c88f0}AK-47 {ffffff}com {1c88f0}220 {ffffff}balas no valor de {00ff00}R$6.000{ffffff}.");
			}
			case 5:// Uzi R$ 13.000
			{
				if(GetPlayerScore(playerid) < 15 )
					return SendClientMessage(playerid, 0xFF0000FF, "| ERRO | VocÍ n„o tem level suficiente.");
				
				if(GetPlayerMoney(playerid) < 4000)
					return SendClientMessage(playerid, 0xFF0000FF, "| ERRO | VocÍ n„o tem dinheiro suficiente.");

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 4000);
					}
				}
				GivePlayerWeapon(playerid, WEAPON_UZI, 300), GivePlayerMoney(playerid, -4000, true);
				return SendClientMessage(playerid, -1, "| AMMU-NATION | VocÍ adquiriu a arma {1c88f0}Uzi {ffffff}com {1c88f0}300 {ffffff}balas no valor de {00ff00}R$4.000{ffffff}.");
			}
			case 6: // MP5 R$18.000
			{
				if(GetPlayerScore(playerid) < 15 )
					return SendClientMessage(playerid, 0xFF0000FF, "| ERRO | VocÍ n„o tem level suficiente.");

				if(GetPlayerMoney(playerid) < 5000)
					return SendClientMessage(playerid, 0xFF0000FF, "| ERRO | VocÍ n„o tem dinheiro suficiente.");

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 5000);
					}
				}
				GivePlayerWeapon(playerid, WEAPON_MP5, 300), GivePlayerMoney(playerid, -5000, true);
				return SendClientMessage(playerid, -1, "| AMMU-NATION | VocÍ adquiriu a arma {1c88f0}MP5 {ffffff}com {1c88f0}300 {ffffff}balas no valor de {00ff00}R$5.000{ffffff}.");
			}
			case 7: // Doze R$15.000
			{
				if(GetPlayerScore(playerid) < 15 )
					return SendClientMessage(playerid, 0xFF0000FF, "| ERRO | VocÍ n„o tem level suficiente.");

				if(GetPlayerMoney(playerid) < 3500)
					return SendClientMessage(playerid, 0xFF0000FF, "| ERRO | VocÍ n„o tem dinheiro suficiente.");

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 3500);
					}
				}
				GivePlayerWeapon(playerid, WEAPON_SHOTGUN, 100), GivePlayerMoney(playerid, -3500, true);
				return SendClientMessage(playerid, -1, "| AMMU-NATION | VocÍ adquiriu a arma {1c88f0}Shotgun {ffffff}com {1c88f0}100 {ffffff}balas no valor de {00ff00}R$3.500{ffffff}.");
			}
			case 8: // sniper rifle R$45.000
			{
				if(GetPlayerScore(playerid) < 15 )
					return SendClientMessage(playerid, 0xFF0000FF, "| ERRO | VocÍ n„o tem level suficiente.");

				if(GetPlayerMoney(playerid) < 6500)
					return SendClientMessage(playerid, 0xFF0000FF, "| ERRO | VocÍ n„o tem dinheiro suficiente.");

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 6500);
					}
				}
				GivePlayerWeapon(playerid, WEAPON_SNIPER, 20), GivePlayerMoney(playerid, -6500, true);
				return SendClientMessage(playerid, -1, "| AMMU-NATION | VocÍ adquiriu a arma {1c88f0}Sniper Rifle {ffffff}com {1c88f0}20 {ffffff}balas no valor de {00ff00}R$6.500{ffffff}.");
			}
			default:
				return SendClientMessage(playerid, 0xFF0000FF, "Sorry, sistema ainda em construÁ„o.");
		}
		return true;
	}
	return true;
}

/*
	ApplyAnimation(playerid, "FOOD", "EAT_BURGER", 4.1, false, false, false, false, 0, false); // hamburguer
	ApplyAnimation(playerid, "FOOD", "EAT_CHICKEN", 4.1, false, false, false, false, 0, false); // chicken
	ApplyAnimation(playerid, "FOOD", "EAT_PIZZA", 4.1, false, false, false, false, 0, false); // pizza
	ApplyAnimation(playerid, "FOOD", "EAT_VOMIT_P", 4.1, false, false, false, false, 0, false); // farto
*/

Dialog:CATEGORIA_BEBIDAS_BAR(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
		    case 0:
			{
				ShowPlayerDialog(playerid, COMPRAR_BEBIDAS_BAR, DIALOG_STYLE_TABLIST_HEADERS, "{"COR_DISABLE_INC"}COMPRAR ª BEBIDAS ª {"COR_BRANCO_INC"}BAR",
					"Sabores\tValor\t-\n\
					ª Ant·rctica\t{006400}R$3\t{"COR_BRANCO_INC"}\n\
					ª Brahma\t{006400}R$3\t{"COR_BRANCO_INC"}\n\
					ª Skol\t{006400}R$3\t{"COR_BRANCO_INC"}\n\
					ª Skol Beats\t{006400}R$4\t{"COR_BRANCO_INC"}\n\
					ª Kaiser\t{006400}R$3\t{"COR_BRANCO_INC"}\n\
					ª Crystal\t{006400}R$3\t{"COR_BRANCO_INC"}\n\
					ª BoÍmia\t{006400}R$3\t{"COR_BRANCO_INC"}\n\
					ª ColÙnia\t{006400}R$3\t{"COR_BRANCO_INC"}\n\
					ª Proibida\t{006400}R$4\t{"COR_BRANCO_INC"}\n\
					ª Itaipava\t{006400}R$4\t{"COR_BRANCO_INC"}\n\
					ª Heineken\t{006400}R$5\t{"COR_BRANCO_INC"}\
					", "Comprar", "Fechar");
				return true;
			}
			case 1:
			{
				ShowPlayerDialog(playerid, COMPRAR_CIGARROS_BAR, DIALOG_STYLE_TABLIST_HEADERS, "{"COR_DISABLE_INC"}COMPRAR ª CIGARROS ª {"COR_BRANCO_INC"}BAR",
					"Sabores\tValor\t-\n\
					ª Marlboro\t{006400}R$5\t{"COR_BRANCO_INC"}\n\
					ª Calton\t{006400}R$5\t{"COR_BRANCO_INC"}\n\
					ª Derby\t{006400}R$4\t{"COR_BRANCO_INC"}\n\
					ª Free\t{006400}R$4\t{"COR_BRANCO_INC"}\n\
					ª Classic\t{006400}R$2\t{"COR_BRANCO_INC"}\n\
					ª Hilton\t{006400}R$3\t{"COR_BRANCO_INC"}\n\
					ª Gudan\t{006400}R$10\t{"COR_BRANCO_INC"}\n\
					ª Hollywood\t{006400}R$6\t{"COR_BRANCO_INC"}\n\
					ª Ministro\t{006400}R$6\t{"COR_BRANCO_INC"}\
					", "Comprar", "Fechar");
				return true;
			}
		}
		return true;
	}
	return true;
}

Dialog:CATEGORIA_COMIDA_BURGE(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
		 	case 0: // Pizza R$20 e +20 FOME.
			{
				ShowPlayerDialog(playerid, COMPRAR_COMIDA_BURGESHOT, DIALOG_STYLE_TABLIST_HEADERS, "{"COR_DISABLE_INC"}COMPRAR ª COMIDA ª {"COR_BRANCO_INC"}BURGER SHOT",
					"Sabores\tValor\tStatus\n\
					ª X-Salada\t{006400}R$10\t{"COR_BRANCO_INC"}+12 {FFFF00}Fome\n\
					ª X-Calabresa\t{006400}R$12\t{"COR_BRANCO_INC"}+16 {FFFF00}Fome\n\
					ª X-Picanha\t{006400}R$18\t{"COR_BRANCO_INC"}+25 {FFFF00}Fome\n\
					ª X-Bacon\t{006400}R$15\t{"COR_BRANCO_INC"}+20 {FFFF00}Fome\n\
					ª X-Presunto\t{006400}R$8\t{"COR_BRANCO_INC"}+10 {FFFF00}Fome\n\
					ª X-Frango\t{006400}R$11\t{"COR_BRANCO_INC"}+14 {FFFF00}Fome\
					", "Comprar", "Fechar");
				return true;
			}
			case 1: // Sprunk
			{
				ShowPlayerDialog(playerid, COMPRAR_REFRIGERANTES, DIALOG_STYLE_TABLIST_HEADERS, "{"COR_DISABLE_INC"}COMPRAR ª REFRIGERANTES ª {"COR_BRANCO_INC"}BURGER SHOT",
					"Sabores\tValor\tStatus\n\
					ª Coca-Cola\t{006400}R$8\t{"COR_BRANCO_INC"}+22 {0080FF}Sede\n\
					ª Fanta Uva\t{006400}R$5\t{"COR_BRANCO_INC"}+18 {0080FF}Sede\n\
					ª Fanta Laranja\t{006400}R$3\t{"COR_BRANCO_INC"}+15 {0080FF}Sede\n\
					ª Sprite\t{006400}R$5\t{"COR_BRANCO_INC"}+15 {0080FF}Sede\n\
					ª Guaran·\t{006400}R$4\t{"COR_BRANCO_INC"}+18 {0080FF}Sede\n\
					ª H2O Lim„o\t{006400}R$3\t{"COR_BRANCO_INC"}+12 {0080FF}Sede\n\
					ª Pepsi\t{006400}R$6\t{"COR_BRANCO_INC"}+20 {0080FF}Sede\n\
					ª Dollynho\t{006400}R$4\t{"COR_BRANCO_INC"}+18 {0080FF}Sede\n\
					", "Comprar", "Fechar");
				return true;
			}
			case 2:
			{
				ShowPlayerDialog(playerid, COMPRAR_SUCOS, DIALOG_STYLE_TABLIST_HEADERS, "{"COR_DISABLE_INC"}COMPRAR ª SUCO ª {"COR_BRANCO_INC"}BURGER SHOT",
					"Sabores\tValor\tStatus\n\
					ª Abacaxi\t{006400}R$2\t{"COR_BRANCO_INC"}+6 {0080FF}Sede\n\
					ª Lim„o\t{006400}R$1\t{"COR_BRANCO_INC"}+4 {0080FF}Sede\n\
					ª Uva\t{006400}R$2\t{"COR_BRANCO_INC"}+6 {0080FF}Sede\n\
					ª Laranja\t{006400}R$2\t{"COR_BRANCO_INC"}+4 {0080FF}Sede\n\
					ª Morango\t{006400}R$2\t{"COR_BRANCO_INC"}+4 {0080FF}Sede\n\
					ª Melancia\t{006400}R$1\t{"COR_BRANCO_INC"}+2 {0080FF}Sede\n\
					ª Caju\t{006400}R$3\t{"COR_BRANCO_INC"}+6 {0080FF}Sede\n\
					ª Maracuj·\t{006400}R$4\t{"COR_BRANCO_INC"}+10 {0080FF}Sede\n\
					", "Comprar", "Fechar");
			}
		}
		return true;
	}
	return true;
}

Dialog:COMPRAR_COMIDA_BURGESHOT(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: // Hamburguer R$20 e +20 FOME.
			{

				if(GetPlayerMoney(playerid) < 10)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				ApplyAnimation(playerid, "FOOD", "EAT_BURGER", 4.1, false, false, false, false, 0, false);

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}


				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· comendo um X-Salada.");

				Jogador[playerid][Fome] = Jogador[playerid][Fome] + 12;

				if(Jogador[playerid][Fome] > 100)
				{
					Jogador[playerid][Fome] = 100;
				}

				AtualizarFSS(playerid);

				GivePlayerMoney(playerid, -10, true);

				if(IsPlayerAttachedObjectSlotUsed(playerid, 0))
					RemovePlayerAttachedObject(playerid, 0);

				SetPlayerAttachedObject(playerid, 0, 2703, 6, 0.071000, 0.061000, 0.006999, 99.200004, 1.400002, -74.099891, 1.000000, 1.000000, 1.000000, 0, 0);
				call::PLAYER->SetPlayerVarInt(playerid, ObjectAttached, gettime() + 3);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 10);
					}
				}
				return true;
			}
			case 1: // Hamburguer R$20 e +20 FOME.
			{

				if(GetPlayerMoney(playerid) < 12)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				ApplyAnimation(playerid, "FOOD", "EAT_BURGER", 4.1, false, false, false, false, 0, false);

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· comendo um X-Calabresa.");

				Jogador[playerid][Fome] = Jogador[playerid][Fome] + 16;

				if(Jogador[playerid][Fome] > 100)
				{
					Jogador[playerid][Fome] = 100;
				}

				AtualizarFSS(playerid);

				GivePlayerMoney(playerid, -12, true);

				if(IsPlayerAttachedObjectSlotUsed(playerid, 0))
					RemovePlayerAttachedObject(playerid, 0);

				SetPlayerAttachedObject(playerid, 0, 2703, 6, 0.071000, 0.061000, 0.006999, 99.200004, 1.400002, -74.099891, 1.000000, 1.000000, 1.000000, 0, 0);
				call::PLAYER->SetPlayerVarInt(playerid, ObjectAttached, gettime() + 3);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 12);
					}
				}
				return true;
			}
			case 2: // Hamburguer R$20 e +20 FOME.
			{

				if(GetPlayerMoney(playerid) < 18)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				
				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				ApplyAnimation(playerid, "FOOD", "EAT_BURGER", 4.1, false, false, false, false, 0, false);

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· comendo um X-Picanha.");

				Jogador[playerid][Fome] = Jogador[playerid][Fome] + 25;

				if(Jogador[playerid][Fome] > 100)
				{
					Jogador[playerid][Fome] = 100;
				}

				AtualizarFSS(playerid);

				GivePlayerMoney(playerid, -18, true);

				if(IsPlayerAttachedObjectSlotUsed(playerid, 0))
					RemovePlayerAttachedObject(playerid, 0);

				SetPlayerAttachedObject(playerid, 0, 2703, 6, 0.071000, 0.061000, 0.006999, 99.200004, 1.400002, -74.099891, 1.000000, 1.000000, 1.000000, 0, 0);
				call::PLAYER->SetPlayerVarInt(playerid, ObjectAttached, gettime() + 3);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 18);
					}
				}
				return true;
			}
			case 3: // Hamburguer R$20 e +20 FOME.
			{

				if(GetPlayerMoney(playerid) < 15)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");
				
				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				ApplyAnimation(playerid, "FOOD", "EAT_BURGER", 4.1, false, false, false, false, 0, false);

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· comendo um X-Bacon.");

				Jogador[playerid][Fome] = Jogador[playerid][Fome] + 20;

				if(Jogador[playerid][Fome] > 100)
				{
					Jogador[playerid][Fome] = 100;
				}

				AtualizarFSS(playerid);

				GivePlayerMoney(playerid, -15, true);

				if(IsPlayerAttachedObjectSlotUsed(playerid, 0))
					RemovePlayerAttachedObject(playerid, 0);

				SetPlayerAttachedObject(playerid, 0, 2703, 6, 0.071000, 0.061000, 0.006999, 99.200004, 1.400002, -74.099891, 1.000000, 1.000000, 1.000000, 0, 0);
				call::PLAYER->SetPlayerVarInt(playerid, ObjectAttached, gettime() + 3);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 15);
					}
				}
				return true;
			}
			case 4: // Hamburguer R$20 e +20 FOME.
			{

				if(GetPlayerMoney(playerid) < 8)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");
				
				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				ApplyAnimation(playerid, "FOOD", "EAT_BURGER", 4.1, false, false, false, false, 0, false);

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· comendo um X-Presunto.");

				Jogador[playerid][Fome] = Jogador[playerid][Fome] + 10;

				if(Jogador[playerid][Fome] > 100)
				{
					Jogador[playerid][Fome] = 100;
				}

				GivePlayerMoney(playerid, -8, true);

				if(IsPlayerAttachedObjectSlotUsed(playerid, 0))
					RemovePlayerAttachedObject(playerid, 0);

				SetPlayerAttachedObject(playerid, 0, 2703, 6, 0.071000, 0.061000, 0.006999, 99.200004, 1.400002, -74.099891, 1.000000, 1.000000, 1.000000, 0, 0);
				call::PLAYER->SetPlayerVarInt(playerid, ObjectAttached, gettime() + 3);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 8);
					}
				}
				return true;
			}
			case 5: // Hamburguer R$20 e +20 FOME.
			{

				if(GetPlayerMoney(playerid) < 11)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");
				
				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				ApplyAnimation(playerid, "FOOD", "EAT_BURGER", 4.1, false, false, false, false, 0, false);

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· comendo um X-Frango.");

				Jogador[playerid][Fome] = Jogador[playerid][Fome] + 14;

				if(Jogador[playerid][Fome] > 100)
				{
					Jogador[playerid][Fome] = 100;
				}

				GivePlayerMoney(playerid, -11, true);

				if(IsPlayerAttachedObjectSlotUsed(playerid, 0))
					RemovePlayerAttachedObject(playerid, 0);

				SetPlayerAttachedObject(playerid, 0, 2703, 6, 0.071000, 0.061000, 0.006999, 99.200004, 1.400002, -74.099891, 1.000000, 1.000000, 1.000000, 0, 0);
				call::PLAYER->SetPlayerVarInt(playerid, ObjectAttached, gettime() + 3);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 11);
					}
				}
				return true;
			}
		}	
		return true;
	}
	return true;
}

Dialog:CATEGORIA_COMIDA_PIZZA(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: // Pizza R$20 e +20 FOME.
			{
				ShowPlayerDialog(playerid, COMPRAR_COMIDA_PIZZARIA, DIALOG_STYLE_TABLIST_HEADERS, "{"COR_DISABLE_INC"}COMPRAR ª COMIDA ª {"COR_BRANCO_INC"}PIZZARIA",
					"Sabores\tValor\tStatus\n\
					ª Mussarela\t{006400}R$14\t{"COR_BRANCO_INC"}+14 {FFFF00}Fome\n\
					ª Presunto\t{006400}R$15\t{"COR_BRANCO_INC"}+15 {FFFF00}Fome\n\
					ª Milho com Ervilha\t{006400}R$15\t{"COR_BRANCO_INC"}+15 {FFFF00}Fome\n\
					ª Portuguesa\t{006400}R$18\t{"COR_BRANCO_INC"}+18 {FFFF00}Fome\n\
					ª Frango com Catupiry\t{006400}R$20\t{"COR_BRANCO_INC"}+20 {FFFF00}Fome\n\
					ª Frango com Bacon\t{006400}R$20\t{"COR_BRANCO_INC"}+20 {FFFF00}Fome\n\
					ª Calabresa\t{006400}R$20\t{"COR_BRANCO_INC"}+20 {FFFF00}Fome\n\
					ª 4 Queijos\t{006400}R$23\t{"COR_BRANCO_INC"}+23 {FFFF00}Fome\
					", "Comprar", "Fechar");
				return true;
			}
			case 1: // Sprunk
			{
				ShowPlayerDialog(playerid, COMPRAR_REFRIGERANTES, DIALOG_STYLE_TABLIST_HEADERS, "{"COR_DISABLE_INC"}COMPRAR ª REFRIGERANTES ª {"COR_BRANCO_INC"}PIZZARIA",
					"Sabores\tValor\tStatus\n\
					ª Coca-Cola\t{006400}R$8\t{"COR_BRANCO_INC"}+22 {0080FF}Sede\n\
					ª Fanta Uva\t{006400}R$5\t{"COR_BRANCO_INC"}+18 {0080FF}Sede\n\
					ª Fanta Laranja\t{006400}R$3\t{"COR_BRANCO_INC"}+15 {0080FF}Sede\n\
					ª Sprite\t{006400}R$5\t{"COR_BRANCO_INC"}+15 {0080FF}Sede\n\
					ª Guaran·\t{006400}R$4\t{"COR_BRANCO_INC"}+18 {0080FF}Sede\n\
					ª H2O Lim„o\t{006400}R$3\t{"COR_BRANCO_INC"}+12 {0080FF}Sede\n\
					ª Pepsi\t{006400}R$6\t{"COR_BRANCO_INC"}+20 {0080FF}Sede\n\
					ª Dollynho\t{006400}R$4\t{"COR_BRANCO_INC"}+18 {0080FF}Sede\
					", "Comprar", "Fechar");
				return true;
			}
			case 2:
			{
				ShowPlayerDialog(playerid, COMPRAR_SUCOS, DIALOG_STYLE_TABLIST_HEADERS, "{"COR_DISABLE_INC"}COMPRAR ª SUCO ª {"COR_BRANCO_INC"}PIZZARIA",
					"Sabores\tValor\tStatus\n\
					ª Abacaxi\t{006400}R$2\t{"COR_BRANCO_INC"}+6 {0080FF}Sede\n\
					ª Lim„o\t{006400}R$1\t{"COR_BRANCO_INC"}+4 {0080FF}Sede\n\
					ª Uva\t{006400}R$2\t{"COR_BRANCO_INC"}+6 {0080FF}Sede\n\
					ª Laranja\t{006400}R$2\t{"COR_BRANCO_INC"}+4 {0080FF}Sede\n\
					ª Morango\t{006400}R$2\t{"COR_BRANCO_INC"}+4 {0080FF}Sede\n\
					ª Melancia\t{006400}R$1\t{"COR_BRANCO_INC"}+2 {0080FF}Sede\n\
					ª Caju\t{006400}R$3\t{"COR_BRANCO_INC"}+6 {0080FF}Sede\n\
					ª Maracuj·\t{006400}R$4\t{"COR_BRANCO_INC"}+10 {0080FF}Sede\
					", "Comprar", "Fechar");
			}
		}	
		return true;
	}
	return true;
}

Dialog:COMPRAR_COMIDA_PIZZARIA(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
		    case 0:
		    {
		    	if(GetPlayerMoney(playerid) < 14) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");
			
				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}
				
				ApplyAnimation(playerid, "FOOD", "EAT_PIZZA", 4.1, false, false, false, false, 0, false);

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· comendo uma pizza de Mussarela.");

				GivePlayerMoney(playerid, -14, true);

				Jogador[playerid][Fome] = Jogador[playerid][Fome] + 14;

				if(Jogador[playerid][Fome] > 100)
				{
					Jogador[playerid][Fome] = 100;
				}

				AtualizarFSS(playerid);

				if(IsPlayerAttachedObjectSlotUsed(playerid, 0))
					RemovePlayerAttachedObject(playerid, 0);

				SetPlayerAttachedObject(playerid, 0, 2881, 6, -0.013999, -0.055999, 0.078999, 16.499998, 6.000010, 22.599998, 1.000000, 1.000000, 1.000000, 0, 0);
				call::PLAYER->SetPlayerVarInt(playerid, ObjectAttached, gettime() + 4);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 14);
					}
				}
				return true;
		    }

		    case 1:
		    {
		    	if(GetPlayerMoney(playerid) < 15) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");
			
				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				ApplyAnimation(playerid, "FOOD", "EAT_PIZZA", 4.1, false, false, false, false, 0, false);

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· comendo uma pizza de Presunto.");

				GivePlayerMoney(playerid, -15, true);

				Jogador[playerid][Fome] = Jogador[playerid][Fome] + 15;

				if(Jogador[playerid][Fome] > 100)
				{
					Jogador[playerid][Fome] = 100;
				}

				AtualizarFSS(playerid);

				if(IsPlayerAttachedObjectSlotUsed(playerid, 0))
					RemovePlayerAttachedObject(playerid, 0);

				SetPlayerAttachedObject(playerid, 0, 2881, 6, -0.013999, -0.055999, 0.078999, 16.499998, 6.000010, 22.599998, 1.000000, 1.000000, 1.000000, 0, 0);
				call::PLAYER->SetPlayerVarInt(playerid, ObjectAttached, gettime() + 4);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 15);
					}
				}
				return true;
		    }
		    case 2:
		    {
		    	if(GetPlayerMoney(playerid) < 15) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				ApplyAnimation(playerid, "FOOD", "EAT_PIZZA", 4.1, false, false, false, false, 0, false);

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· comendo uma pizza de Milho com Ervilha.");

				GivePlayerMoney(playerid, -15, true);

				Jogador[playerid][Fome] = Jogador[playerid][Fome] + 15;

				if(Jogador[playerid][Fome] > 100)
				{
					Jogador[playerid][Fome] = 100;
				}

				AtualizarFSS(playerid);

				if(IsPlayerAttachedObjectSlotUsed(playerid, 0))
					RemovePlayerAttachedObject(playerid, 0);

				SetPlayerAttachedObject(playerid, 0, 2881, 6, -0.013999, -0.055999, 0.078999, 16.499998, 6.000010, 22.599998, 1.000000, 1.000000, 1.000000, 0, 0);
				call::PLAYER->SetPlayerVarInt(playerid, ObjectAttached, gettime() + 4);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 15);
					}
				}
				return true;
		    }
		    case 3:
		    {
		    	if(GetPlayerMoney(playerid) < 18) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");
			
				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				ApplyAnimation(playerid, "FOOD", "EAT_PIZZA", 4.1, false, false, false, false, 0, false);

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· comendo uma pizza de Portuguesa.");

				GivePlayerMoney(playerid, -18, true);

				Jogador[playerid][Fome] = Jogador[playerid][Fome] + 18;

				if(Jogador[playerid][Fome] > 100)
				{
					Jogador[playerid][Fome] = 100;
				}

				AtualizarFSS(playerid);

				if(IsPlayerAttachedObjectSlotUsed(playerid, 0))
					RemovePlayerAttachedObject(playerid, 0);

				SetPlayerAttachedObject(playerid, 0, 2881, 6, -0.013999, -0.055999, 0.078999, 16.499998, 6.000010, 22.599998, 1.000000, 1.000000, 1.000000, 0, 0);
				call::PLAYER->SetPlayerVarInt(playerid, ObjectAttached, gettime() + 4);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 18);
					}
				}
				return true;
		    }
		    case 4:
		    {
		    	if(GetPlayerMoney(playerid) < 20) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				ApplyAnimation(playerid, "FOOD", "EAT_PIZZA", 4.1, false, false, false, false, 0, false);

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· comendo uma pizza de Frango com Catupiry.");

				GivePlayerMoney(playerid, -18, true);

				Jogador[playerid][Fome] = Jogador[playerid][Fome] + 20;

				if(Jogador[playerid][Fome] > 100)
				{
					Jogador[playerid][Fome] = 100;
				}

				AtualizarFSS(playerid);

				if(IsPlayerAttachedObjectSlotUsed(playerid, 0))
					RemovePlayerAttachedObject(playerid, 0);

				SetPlayerAttachedObject(playerid, 0, 2881, 6, -0.013999, -0.055999, 0.078999, 16.499998, 6.000010, 22.599998, 1.000000, 1.000000, 1.000000, 0, 0);
				call::PLAYER->SetPlayerVarInt(playerid, ObjectAttached, gettime() + 4);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 20);
					}
				}
				return true;
		    }
		    case 5:
		    {
		    	if(GetPlayerMoney(playerid) < 20) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				ApplyAnimation(playerid, "FOOD", "EAT_PIZZA", 4.1, false, false, false, false, 0, false);

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· comendo uma pizza de Frango com Bacon.");

				GivePlayerMoney(playerid, -20, true);

				Jogador[playerid][Fome] = Jogador[playerid][Fome] + 20;

				if(Jogador[playerid][Fome] > 100)
				{
					Jogador[playerid][Fome] = 100;
				}

				AtualizarFSS(playerid);

				if(IsPlayerAttachedObjectSlotUsed(playerid, 0))
					RemovePlayerAttachedObject(playerid, 0);

				SetPlayerAttachedObject(playerid, 0, 2881, 6, -0.013999, -0.055999, 0.078999, 16.499998, 6.000010, 22.599998, 1.000000, 1.000000, 1.000000, 0, 0);
				call::PLAYER->SetPlayerVarInt(playerid, ObjectAttached, gettime() + 4);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 20);
					}
				}
				return true;
		    }
		    case 6:
		    {
		    	if(GetPlayerMoney(playerid) < 20) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				ApplyAnimation(playerid, "FOOD", "EAT_PIZZA", 4.1, false, false, false, false, 0, false);

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· comendo uma pizza de Calabresa.");

				GivePlayerMoney(playerid, -20, true);

				Jogador[playerid][Fome] = Jogador[playerid][Fome] + 20;

				if(Jogador[playerid][Fome] > 100)
				{
					Jogador[playerid][Fome] = 100;
				}

				AtualizarFSS(playerid);

				if(IsPlayerAttachedObjectSlotUsed(playerid, 0))
					RemovePlayerAttachedObject(playerid, 0);

				SetPlayerAttachedObject(playerid, 0, 2881, 6, -0.013999, -0.055999, 0.078999, 16.499998, 6.000010, 22.599998, 1.000000, 1.000000, 1.000000, 0, 0);
				call::PLAYER->SetPlayerVarInt(playerid, ObjectAttached, gettime() + 4);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 20);
					}
				}
				return true;
		    }
		    case 7:
		    {
		    	if(GetPlayerMoney(playerid) < 23) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				ApplyAnimation(playerid, "FOOD", "EAT_PIZZA", 4.1, false, false, false, false, 0, false);

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· comendo uma pizza de Quatro Queijos.");

				GivePlayerMoney(playerid, -23, true);

				Jogador[playerid][Fome] = Jogador[playerid][Fome] + 23;

				if(Jogador[playerid][Fome] > 100)
				{
					Jogador[playerid][Fome] = 100;
				}

				AtualizarFSS(playerid);

				if(IsPlayerAttachedObjectSlotUsed(playerid, 0))
					RemovePlayerAttachedObject(playerid, 0);

				SetPlayerAttachedObject(playerid, 0, 2881, 6, -0.013999, -0.055999, 0.078999, 16.499998, 6.000010, 22.599998, 1.000000, 1.000000, 1.000000, 0, 0);
				call::PLAYER->SetPlayerVarInt(playerid, ObjectAttached, gettime() + 4);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 23);
					}
				}
				return true;
		    }
		}
	}
	return true;
}

// 

Dialog:COMPRAR_COMIDA_CLUCKIN(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: // Peda√ßo de frango
			{
				if(GetPlayerMoney(playerid) < 20)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				ApplyAnimation(playerid, "FOOD", "EAT_CHICKEN", 4.1, false, false, false, false, 0, false);

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· comendo um PedaÁo de Frango.");

				Jogador[playerid][Fome] = Jogador[playerid][Fome] + 20;

				if(Jogador[playerid][Fome] > 100)
				{
					Jogador[playerid][Fome] = 100;
				}

				AtualizarFSS(playerid);

				GivePlayerMoney(playerid, -20, true);

				if(IsPlayerAttachedObjectSlotUsed(playerid, 0))
					RemovePlayerAttachedObject(playerid, 0);

				SetPlayerAttachedObject(playerid, 0, 19847, 6, 0.054000, 0.024000, 0.082000, -82.800010, 0.000000, 0.600000, 0.543000, 0.609000, 0.818999, 0, 0);
				call::PLAYER->SetPlayerVarInt(playerid, ObjectAttached, gettime() + 3);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 20);
					}
				}
				return true;
			}
			case 1: // Sprunk
			{
				if(GetPlayerMoney(playerid) < 5)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");
				
				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· bebendo uma Sprunk.");

				Jogador[playerid][Sede] = Jogador[playerid][Sede] + 15;

				if(Jogador[playerid][Sede] > 100)
				{
					Jogador[playerid][Sede] = 100;
				}

				AtualizarFSS(playerid);
				GivePlayerMoney(playerid, -5, true);


				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 5);
					}
				}
				return true;
			}
		}
		return true;
	}
	return true;
}

Dialog:COMPRAR_UTILITARIOS(playerid, response, listitem, inputtext[])
{
	if ( response )
	{
		switch(listitem)
		{
			case 0: // GPS
			{
				if ( call::PLAYER->GetPlayerVarBool(playerid, GPS) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ j· tem um GPS.");

				if ( GetPlayerMoney(playerid) < 800 )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro suficiente para comprar este produto.");

				call::PLAYER->SetPlayerVarBool(playerid, GPS, true);

				new query[100];
				mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `gps`='1' WHERE `id`='%d' LIMIT 1;", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
				mysql_tquery(getConexao(), query);

				GivePlayerMoney(playerid, -800, true);
				SendClientMessage(playerid, -1, "| UTILIT¡RIOS | VocÍ comprou um {"COR_LARANJA_INC"}GPS {ffffff}no valor de {31b404}R$800{ffffff}.");
				
				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 800);
					}
				}
				return true;
			}

			case 1: // Celular
			{
				if ( call::PLAYER->GetPlayerVarInt(playerid, Celular) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ j· tem um celular.");

				if ( GetPlayerMoney(playerid) < 1200 )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro suficiente para comprar este produto.");

				new query[100], number[11];

				format(number, sizeof(number), "%d%d", call::PLAYER->GetPlayerVarInt(playerid, PlayerID), random(9999));

				mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `celular`='%d' WHERE `id`='%d' LIMIT 1;", strval(number), call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
				mysql_tquery(getConexao(), query);
				
				call::PLAYER->SetPlayerVarInt(playerid, Celular, strval(number));

				GivePlayerMoney(playerid, -1200, true);
				SendClientMessage(playerid, -1, "| UTILIT¡RIOS | VocÍ comprou um {"COR_LARANJA_INC"}Celular {ffffff}no valor de {31b404}R$1.200{ffffff}.");
				
				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 1200);
					}
				}
				return true;
			}
			case 2: // CrÈditos
			{
				ShowPlayerDialog(playerid, UTILITARIOS_CREDITOS, DIALOG_STYLE_TABLIST, "{"COR_DISABLE_INC"}LOJA DE UTILIT¡RIOS ª {"COR_BRANCO_INC"}CR…DITOS", "CrÈditos\t{"COR_VERDE_INC"}R$15\nCrÈditos\t{"COR_VERDE_INC"}R$25\nCrÈditos\t{"COR_VERDE_INC"}R$50", "Comprar", "Voltar");
				return true;
			}
			case 3: // Agenda Telefonica
			{
				if ( call::PLAYER->GetPlayerVarBool(playerid, Agenda) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ j· possui uma agenda telefÙnica.");

				if ( GetPlayerMoney(playerid) < 20 )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro suficiente para comprar uma agenda.");

				GivePlayerMoney(playerid, -20, true);
				call::PLAYER->SetPlayerVarBool(playerid, Agenda, true);

				new query[128];
				mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `agenda`='1' WHERE `id`='%d' LIMIT 1;", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
				mysql_tquery(getConexao(), query);

				SendClientMessage(playerid, -1, "| UTILIT¡RIOS | VocÍ comprou uma {"COR_LARANJA_INC"}Agenda TelefÙnica {ffffff}no valor de {31b404}R$20{ffffff}.");
				
				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 20);
					}
				}
				return true;
			}
			case 4: // MP3
			{
				if ( call::PLAYER->GetPlayerVarBool(playerid, MP3) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ j· possui um MP3.");

				if ( GetPlayerMoney(playerid) < 150 )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro suficiente para comprar um MP3.");

				GivePlayerMoney(playerid, -150, true);
				call::PLAYER->SetPlayerVarBool(playerid, MP3, true);

				new query[128];
				mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `mp3`='1' WHERE `id`='%d' LIMIT 1;", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
				mysql_tquery(getConexao(), query);

				SendClientMessage(playerid, -1, "| UTILIT¡RIOS | VocÍ comprou um {"COR_LARANJA_INC"}MP3 {ffffff}no valor de {31b404}R$150{ffffff}.");
				
				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 150);
					}
				}
				return true;
			}
			case 5: // GALAO
			{
				if ( call::PLAYER->GetPlayerVarBool(playerid, Galao) )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ j· possui um Gal„o de Gasolina.");

				if ( GetPlayerMoney(playerid) < 60 )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro suficiente para comprar um Gal„o de Gasolina.");

				GivePlayerMoney(playerid, -60, true);
				call::PLAYER->SetPlayerVarBool(playerid, Galao, true);

				new query[128];
				mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `galao`='1' WHERE `id`='%d' LIMIT 1;", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
				mysql_tquery(getConexao(), query);

				SendClientMessage(playerid, -1, "| UTILIT¡RIOS | VocÍ comprou um {"COR_LARANJA_INC"}Gal„o de CombustÌvel {ffffff}no valor de {31b404}R$60{ffffff}.");

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 60);
					}
				}

			}
		}
		return true;
	}
	return true;
}

Dialog:UTILITARIOS_CREDITOS(playerid, response, listitem, inputtext[])
{
	callcmd::comprar(playerid, "produtos");
	if ( response )
	{
		if ( !call::PLAYER->GetPlayerVarBool(playerid, Celular) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem um celular.");

		switch(listitem)
		{
			case 0: // R$15
			{
				if ( GetPlayerMoney(playerid) < 15 )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem o dinheiro suficiente para comprar essa quantidade de crÈditos.");

				GivePlayerMoney(playerid, -15, true);
				call::PLAYER->SetPlayerVarInt(playerid, SaldoCelular, call::PLAYER->GetPlayerVarInt(playerid, SaldoCelular) + 15);
				
				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 15);
					}
				}
				return true;
			}

			case 1: // R$25
			{
				if ( GetPlayerMoney(playerid) < 25 )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem o dinheiro suficiente para comprar essa quantidade de crÈditos.");

				GivePlayerMoney(playerid, -25, true);
				SendClientMessage(playerid, COR_SISTEMA, "ª {"COR_BRANCO_INC"}VocÍ adquiriu R$25 em crÈditos.");
				call::PLAYER->SetPlayerVarInt(playerid, SaldoCelular, call::PLAYER->GetPlayerVarInt(playerid, SaldoCelular) + 25);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 25);
					}
				}
				return true;
			}

			case 2: // R$50
			{
				if ( GetPlayerMoney(playerid) < 50 )
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem o dinheiro suficiente para comprar essa quantidade de crÈditos.");

				GivePlayerMoney(playerid, -50, true);
				SendClientMessage(playerid, COR_SISTEMA, "ª {"COR_BRANCO_INC"}VocÍ adquiriu R$50 em crËditos.");
				call::PLAYER->SetPlayerVarInt(playerid, SaldoCelular, call::PLAYER->GetPlayerVarInt(playerid, SaldoCelular) + 50);
				
				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 50);
					}
				}
				return true;
			}
		}
		new query[128];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_USERS" SET `saldo`='%d' WHERE `id`='%d' LIMIT 1;", call::PLAYER->GetPlayerVarInt(playerid, SaldoCelular), call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
		mysql_tquery(getConexao(), query);
		SendClientMessage(playerid, COR_BRANCO, "ª VocÍ tem {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"} de crÈditos.", RealStr( call::PLAYER->GetPlayerVarInt(playerid, SaldoCelular) ) );
		return true;
	}
	return true;
}

//

Dialog:COMPRAR_REFRIGERANTES(playerid, response, listitem, intputtext[])
{
	if(response)
	{
		switch(listitem)
		{
		    case 0:
		    {
		    	if(GetPlayerMoney(playerid) < 8) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· bebendo uma Coca-Cola.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				Jogador[playerid][Sede] = Jogador[playerid][Sede] + 22;

				if(Jogador[playerid][Sede] > 100)
				{
					Jogador[playerid][Sede] = 100;
				}

				AtualizarFSS(playerid);

				GivePlayerMoney(playerid, -8, true);

				
				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 8);
					}
				}
				return true;
		    }
		    case 1:
		    {
		    	if(GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· bebendo uma Fanta Uva.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				Jogador[playerid][Sede] = Jogador[playerid][Sede] + 18;

				if(Jogador[playerid][Sede] > 100)
				{
					Jogador[playerid][Sede] = 100;
				}

				AtualizarFSS(playerid);

				GivePlayerMoney(playerid, -5, true);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 5);
					}
				}
				return true;
		    }
		    case 2:
		    {
		    	if(GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· bebendo uma Fanta Laranja.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				Jogador[playerid][Sede] = Jogador[playerid][Sede] + 15;

				if(Jogador[playerid][Sede] > 100)
				{
					Jogador[playerid][Sede] = 100;
				}

				AtualizarFSS(playerid);

				GivePlayerMoney(playerid, -3, true);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 3);
					}
				}
				return true;
		    }
		    case 3:
		    {
		    	if(GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· bebendo um Sprite.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				Jogador[playerid][Sede] = Jogador[playerid][Sede] + 15;

				if(Jogador[playerid][Sede] > 100)
				{
					Jogador[playerid][Sede] = 100;
				}

				AtualizarFSS(playerid);

				GivePlayerMoney(playerid, -5, true);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 5);
					}
				}
				return true;
		    }
		    case 4:
		    {
		    	if(GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· bebendo um Guaran·.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				Jogador[playerid][Sede] = Jogador[playerid][Sede] + 18;

				if(Jogador[playerid][Sede] > 100)
				{
					Jogador[playerid][Sede] = 100;
				}

				AtualizarFSS(playerid);

				GivePlayerMoney(playerid, -4, true);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 4);
					}
				}
				return true;
		    }
		    case 5:
		    {
		    	if(GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· bebendo um H2O Lim„o.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				Jogador[playerid][Sede] = Jogador[playerid][Sede] + 12;

				if(Jogador[playerid][Sede] > 100)
				{
					Jogador[playerid][Sede] = 100;
				}

				AtualizarFSS(playerid);

				GivePlayerMoney(playerid, -3, true);


				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 3);
					}
				}
				return true;
		    }
		    case 6:
		    {
		    	if(GetPlayerMoney(playerid) < 6) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· bebendo uma Pepsi.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				Jogador[playerid][Sede] = Jogador[playerid][Sede] + 20;

				if(Jogador[playerid][Sede] > 100)
				{
					Jogador[playerid][Sede] = 100;
				}

				AtualizarFSS(playerid);

				GivePlayerMoney(playerid, -6, true);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 6);
					}
				}
				return true;
		    }
		    case 7:
		    {
		    	if(GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· bebendo um Dollynho.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				Jogador[playerid][Sede] = Jogador[playerid][Sede] + 18;

				if(Jogador[playerid][Sede] > 100)
				{
					Jogador[playerid][Sede] = 100;
				}

				AtualizarFSS(playerid);

				GivePlayerMoney(playerid, -4, true);


				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 4);
					}
				}
				return true;
		    }
		}
		return true;
	}
	return true;
}

//

Dialog:COMPRAR_SUCOS(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
		    case 0:
		    {
		    	if(GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· bebendo um Suco de Abacaxi.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}


				Jogador[playerid][Sede] = Jogador[playerid][Sede] + 6;

				if(Jogador[playerid][Sede] > 100)
				{
					Jogador[playerid][Sede] = 100;
				}

				AtualizarFSS(playerid);

				GivePlayerMoney(playerid, -2, true);


				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 2);
					}
				}
				return true;
		    }
		    case 1:
		    {
		    	if(GetPlayerMoney(playerid) < 1) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· bebendo um Suco de Lim„o.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				Jogador[playerid][Sede] = Jogador[playerid][Sede] + 4;

				if(Jogador[playerid][Sede] > 100)
				{
					Jogador[playerid][Sede] = 100;
				}

				AtualizarFSS(playerid);

				GivePlayerMoney(playerid, -1, true);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 1);
					}
				}
				return true;
		    }
		    case 2:
		    {
		    	if(GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· bebendo um Suco de Uva.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				Jogador[playerid][Sede] = Jogador[playerid][Sede] + 6;

				if(Jogador[playerid][Sede] > 100)
				{
					Jogador[playerid][Sede] = 100;
				}

				AtualizarFSS(playerid);

				GivePlayerMoney(playerid, -3, true);


				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 3);
					}
				}
				return true;
		    }
		    case 3:
		    {
		    	if(GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· bebendo um Suco de Laranja.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				Jogador[playerid][Sede] = Jogador[playerid][Sede] + 4;

				if(Jogador[playerid][Sede] > 100)
				{
					Jogador[playerid][Sede] = 100;
				}

				AtualizarFSS(playerid);

				GivePlayerMoney(playerid, -2, true);


				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 2);
					}
				}
				return true;
		    }
		    case 4:
		    {
		    	if(GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· bebendo um Suco de Morango.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				Jogador[playerid][Sede] = Jogador[playerid][Sede] + 4;

				if(Jogador[playerid][Sede] > 100)
				{
					Jogador[playerid][Sede] = 100;
				}

				AtualizarFSS(playerid);

				GivePlayerMoney(playerid, -2, true);


				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 2);
					}
				}
				return true;
		    }
		    case 5:
		    {
		    	if(GetPlayerMoney(playerid) < 1) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· bebendo um Suco de Melancia.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				Jogador[playerid][Sede] = Jogador[playerid][Sede] + 2;

				if(Jogador[playerid][Sede] > 100)
				{
					Jogador[playerid][Sede] = 100;
				}

				AtualizarFSS(playerid);

				GivePlayerMoney(playerid, -1, true);


				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 1);
					}
				}
				return true;
		    }
		    case 6:
		    {
		    	if(GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· bebendo um Suco de Caju.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				Jogador[playerid][Sede] = Jogador[playerid][Sede] + 6;

				if(Jogador[playerid][Sede] > 100)
				{
					Jogador[playerid][Sede] = 100;
				}

				AtualizarFSS(playerid);

				GivePlayerMoney(playerid, -3, true);


				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 3);
					}
				}
				return true;
		    }
		    case 7:
		    {
		    	if(GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ est· bebendo um Suco de Maracuj·.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				Jogador[playerid][Sede] = Jogador[playerid][Sede] + 10;

				if(Jogador[playerid][Sede] > 100)
				{
					Jogador[playerid][Sede] = 100;
				}

				AtualizarFSS(playerid);

				GivePlayerMoney(playerid, -4, true);


				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 4);
					}
				}
				return true;
		    }
		}
		return true;
	}
	return true;
}

Dialog:COMPRAR_BEBIDAS_BAR(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
		    case 0:
		    {
		    	if(GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ comprou uma Ant·rctica.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				GivePlayerMoney(playerid, -3, true);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 3);
					}
				}
				return true;
		    }
		    case 1:
		    {
		    	if(GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ comprou uma Brahma.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				GivePlayerMoney(playerid, -3, true);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 3);
					}
				}
				return true;
		    }
		    case 2:
		    {
		    	if(GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ comprou uma Skol.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}


				GivePlayerMoney(playerid, -3, true);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 3);
					}
				}
				return true;
		    }
		    case 3:
		    {
		    	if(GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ comprou uma Skol Beats.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				GivePlayerMoney(playerid, -4, true);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 4);
					}
				}
				return true;
		    }
		    case 4:
		    {
		    	if(GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ comprou uma Kaiser.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				GivePlayerMoney(playerid, -3, true);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 3);
					}
				}
				return true;
		    }
		    case 5:
		    {
		    	if(GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ comprou uma Crystal.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				GivePlayerMoney(playerid, -3, true);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 3);
					}
				}
				return true;
		    }
		    case 6:
		    {
		    	if(GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ comprou uma BoÍmia.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				GivePlayerMoney(playerid, -3, true);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 3);
					}
				}
				return true;
		    }
		    case 7:
		    {
		    	if(GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ comprou um ColÙnia.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				GivePlayerMoney(playerid, -3, true);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 3);
					}
				}
				return true;
		    }
		    case 8:
		    {
		    	if(GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ comprou uma Proibida.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				GivePlayerMoney(playerid, -4, true);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 4);
					}
				}
				return true;
		    }
		    case 9:
		    {
		    	if(GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ comprou uma Itaipava.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}

				GivePlayerMoney(playerid, -4, true);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 4);
					}
				}
				return true;
		    }
		    case 10:
		    {
		    	if(GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ comprou uma Heineken.");

				new Float:health;
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health+20);

				GetPlayerHealth(playerid, health);
				if(health > 100)
				{
					SetPlayerHealth(playerid, 100);
				}
				
				GivePlayerMoney(playerid, -5, true);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 5);
					}
				}
				return true;
		    }
		}
		return true;
	}
	return true;
}
//

Dialog:COMPRAR_CIGARROS_BAR(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
		    case 0:
		    {
		    	if(GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ comprou um Marlboro.");
				
				GivePlayerMoney(playerid, -5, true);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 5);
					}
				}
				return true;
		    }
		    case 1:
		    {
		    	if(GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ comprou um Calton.");
				GivePlayerMoney(playerid, -5, true);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 5);
					}
				}
				return true;
		    }
		    case 2:
		    {
		    	if(GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ comprou um Derby.");
				GivePlayerMoney(playerid, -4, true);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 4);
					}
				}
				return true;
		    }
		    case 3:
		    {
		    	if(GetPlayerMoney(playerid) < 4) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ comprou um Free.");
				GivePlayerMoney(playerid, -4, true);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 4);
					}
				}
				return true;
		    }
		    case 4:
		    {
		    	if(GetPlayerMoney(playerid) < 2) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ comprou um Classic.");
				GivePlayerMoney(playerid, -2, true);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 2);
					}
				}
				return true;
		    }
		    case 5:
		    {
		    	if(GetPlayerMoney(playerid) < 3) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ comprou um Hilton.");
				GivePlayerMoney(playerid, -3, true);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 3);
					}
				}
				return true;
		    }
		    case 6:
		    {
		    	if(GetPlayerMoney(playerid) < 10) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ comprou um Gudan.");
				GivePlayerMoney(playerid, -10, true);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 10);
					}
				}
				return true;
		    }
		    case 7:
		    {
		    	if(GetPlayerMoney(playerid) < 6) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ comprou um Hollywood.");
				GivePlayerMoney(playerid, -6, true);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 6);
					}
				}
				return true;
		    }
		    case 8:
		    {
		    	if(GetPlayerMoney(playerid) < 6) return SendClientMessage(playerid, COR_ERRO, "| ERRO | VocÍ n„o tem dinheiro para comprar este produto.");

				SendClientMessage(playerid, COR_AMARELO, "| INFO | VocÍ comprou um Ministro.");
				GivePlayerMoney(playerid, -6, true);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);

				/**
				*
				*	setar valor ao cofre.
				*
				**/
				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					new businessid = GetPlayerVirtualWorld(playerid);
					if ( call::BUSINESS->IsValidBusiness(businessid) )
					{
						call::BUSINESS->SetBusinessParamsInt(businessid, Cofre, call::BUSINESS->GetBusinessParamsInt(businessid, Cofre) + 6);
					}
				}
				return true;
		    }
		}
		return true;
	}
	return true;
}
