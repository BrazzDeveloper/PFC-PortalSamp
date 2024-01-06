new PlayerBar: AssaltBar[MAX_PLAYERS];
new ValueBar[MAX_PLAYERS];
static SendoRoubado[MAX_BUSINESS];

#include <YSI_Coding\y_hooks>

hook OnPlayerText(playerid, text[])
{
	new hotellid = GetPlayerHotel(playerid);

	if(IsPlayerInRangeOfPoint(playerid, 5.0, 1318.75, -1048.67, 3359.71))
	{
		if(!strcmp(text, "Olá Maria", true) || !strcmp(text, "Ola Maria", true))
		{
			SendClientMessage(playerid, COR_BRANCO, "Maria_Eduarda disse: Olá Sr. %s, você deseja 'Alugar' ou 'Desalugar' seu apartamento?", GetUserName(playerid));
	        return Y_HOOKS_CONTINUE_RETURN_0;
		}
		if(!strcmp(text, "Alugar", true))
		{
			new info[2048], count;
			info = "Número\tValor\tProprietario\n";

			foreach(new hotelid: Hotel)
			{
				format(info, sizeof(info), "{"COR_BRANCO_INC"}%s%d\t{"COR_VERDE_INC"}R$%d{"COR_BRANCO_INC"}\t%s\n", info, Hotel[hotelid][ID], Hotel[hotelid][Valor], Hotel[hotelid][Owner][Name]);			
				count++;
			}
			if(count)
				return ShowPlayerDialog(playerid, ALUGAR_HOTEL, DIALOG_STYLE_TABLIST_HEADERS, "{"COR_VERMELHO_INC"}"SERVER_NAME"» {"COR_BRANCO_INC"}HOTEL", info, "Confirmar", "Cancelar");
			if(count <= 0)
				return SendClientMessage(playerid, COR_ERRO, "Maria_Eduarda disse: Desculpe Sr. %s, não há quartos disponíveis no momento.", GetUserName(playerid));
		}
		if(!strcmp(text, "Desalugar", true))
		{
			new info[236];

			if(Hotel[hotellid][Impostos] >= 1)
            	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você possui %d parcelas atrasadas no total de {"COR_VERDE_INC"}R$%s{"COR_VERDE_INC"}", Hotel[hotellid][Impostos], RealStr(Hotel[hotellid][Valor]*Hotel[hotellid][Impostos]));

			if(hotellid == INVALID_HOTEL_ID)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui um apartamento."); 

			format(info, sizeof(info), "Você realmente deseja deixar de ser o locatário do apartamento %d?", Hotel[hotellid][ID]);

			ShowPlayerDialog(playerid, SELL_HOTEL, DIALOG_STYLE_MSGBOX, "{"COR_VERMELHO_INC"}"SERVER_NAME"» {"COR_BRANCO_INC"}HOTEL", info, "Confirmar", "Cancelar");
			return Y_HOOKS_CONTINUE_RETURN_0;
		}
	}
	if(IsPlayerInRangeOfPoint(playerid, 5.0, 1321.52, -1048.75, 3359.71))
	{
		if(!strcmp(text, "Olá Bruno", true) || !strcmp(text, "Ola Bruno", true))
		{
			SendClientMessage(playerid, COR_BRANCO, "Bruno_Almeida disse: Olá Sr. %s, você deseja 'Pagar Contas' de seu apartamento?", GetUserName(playerid));
		}
		if(!strcmp(text, "Pagar Contas", true))
		{
			new valorapagar = (Hotel[hotellid][Valor]*Hotel[hotellid][Impostos]);

			if(Hotel[hotellid][Impostos] < 1)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui parcelas atrasadas.");

			if(hotellid == INVALID_HOTEL_ID)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui um apartamento.");

			ShowPlayerDialog(playerid, PAGAR_IMPOSTOS_HOTEL, DIALOG_STYLE_MSGBOX, "Hotel Perfect City", "{"COR_BRANCO_INC"}Você tem {"COR_VERMELHO_INC"}%d{"COR_BRANCO_INC"} parcelas totalizando {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}\nDeseja quitar as dividas agora?", "Confirmar", "Cancelar", Hotel[hotellid][Impostos], RealStr(valorapagar));
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid)
{
	AssaltBar[playerid] = CreatePlayerProgressBar(playerid, 500.00, 277.00, 45.45, 3.20, COR_ERRO, 50.0);
	SetPlayerProgressBarValue(playerid, AssaltBar[playerid], 50);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

CMD:trancarquarto(playerid)
{
	new hotelid = GetHotelIdInRange(playerid, 2.0);

	if(hotelid != GetPlayerHotel(playerid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui a chave deste apartamento.");

	if(Hotel[hotelid][Trancado])
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O apartamento já está trancado.");

	Hotel[hotelid][Trancado] = true;
	SendClientMessage(playerid, COR_SISTEMA, "APARTAMENTO: {"COR_BRANCO_INC"}Você {"COR_VERDE_INC"}trancou{"COR_BRANCO_INC"} o apartamento.");

	new query[128];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_HOTEIS" SET `trancado`='1' WHERE `id`='%d' LIMIT 1;", Hotel[hotelid][ID]);
	mysql_tquery(getConexao(), query);

	return true;
}

CMD:destrancarquarto(playerid)
{
	new hotelid = GetHotelIdInRange(playerid, 2.0);

	if(hotelid != GetPlayerHotel(playerid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui a chave deste apartamento.");

	if(!Hotel[hotelid][Trancado])
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | O apartamento já está destrancada.");

	Hotel[hotelid][Trancado] = false;
	SendClientMessage(playerid, COR_SISTEMA, "APARTAMENTO: {"COR_BRANCO_INC"}Você {"COR_VERDE_INC"}destrancou{"COR_BRANCO_INC"} o apartamento.");

	new query[128];
	mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_HOTEIS" SET `trancado`='0' WHERE `id`='%d' LIMIT 1;", Hotel[hotelid][ID]);
	mysql_tquery(getConexao(), query);


	return true;
}

stock OnPlayerTargetDynamicActor(playerid)
{
	new actorid = GetPlayerTargetDynamicActor(playerid), empresaid = GetPlayerVirtualWorld(playerid);

	if(IsValidDynamicActor(actorid) && GetPlayerWeapon(playerid) >= 22)
	{
		if(actorid == 367 || actorid == 368)
		{
			if(ValueBar[playerid] < 50)
			{
				if ( SendoRoubado[empresaid] > gettime())
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse hotel já foi assaltado recentemente, aguarde {"COR_BRANCO_INC"}%d{"COR_ERRO_INC"} segundos", SendoRoubado[empresaid] - gettime() );

				++ValueBar[playerid];
				ShowPlayerProgressBar(playerid, AssaltBar[playerid]);
				SetPlayerProgressBarValue(playerid, AssaltBar[playerid], ValueBar[playerid]);
				SetTimerEx("ExpirouAssalto", minutos(10), false, "i", playerid);
			}
			else
			{
				ValueBar[playerid] = 0;
				HidePlayerProgressBar(playerid, AssaltBar[playerid]);
				SendClientMessage(playerid, -1, "Terminou assalto.");
				SendoRoubado[empresaid] = gettime() + (10 * 60);

				if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
				{
					if ( call::BUSINESS->IsValidBusiness(empresaid) )
					{
						new valorroubado = floatround(call::BUSINESS->GetBusinessParamsInt(empresaid, Cofre)) / 2;

						call::BUSINESS->SetBusinessParamsInt(empresaid, Cofre, call::BUSINESS->GetBusinessParamsInt(empresaid, Cofre) - valorroubado);

						SendClientMessage(playerid, COR_BRANCO, "* Você assaltou o hotel e ganhou: {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}.", RealStr(valorroubado));
						GivePlayerMoney(playerid, valorroubado);

						SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid) + 2);
					}
				}
			}
		}
	}
	return true;
}

forward ExpirouAssalto(playerid);
public ExpirouAssalto(playerid)
{
	ValueBar[playerid] = 0;
	HidePlayerProgressBar(playerid, AssaltBar[playerid]);
	return true;
}