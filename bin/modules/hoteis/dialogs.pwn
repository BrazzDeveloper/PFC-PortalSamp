Dialog:ALUGAR_HOTEL(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new hotelid = strval(inputtext);
        SetPVarInt(playerid, "hotelid", hotelid);

        if( GetPlayerHouse(playerid) != INVALID_HOUSE_ID )
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já possui uma casa.");

        if( GetPlayerHotel(playerid) != INVALID_HOTEL_ID )
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já possui um apartamento.");

        new info[236];
        format(info, sizeof(info), "{"COR_BRANCO_INC"}Você deseja alugar o quarto %d por R$%d", Hotel[hotelid][ID], Hotel[hotelid][Valor]);

        ShowPlayerDialog(playerid, COMPRAR_QUARTO, DIALOG_STYLE_MSGBOX, "Alugar Quarto", info, "Comprar", "Cancelar");
    }
    return true;
}

Dialog:COMPRAR_QUARTO(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new hotelid = GetPVarInt(playerid, "hotelid");
        DeletePVar(playerid, "hotelid");
        
        if (  !IsValidHotel(hotelid) )
        {
            SendClientMessage(playerid, COR_ERRO, "| ERRO | Hotel inválido.");
            return 0;
        }

        if( Hotel[hotelid][Owner][Id] != 0 )
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Este quarto já tem um dono.");
        
        if ( Hotel[hotelid][Owner][Id] == Jogador[playerid][PlayerID] )
        {
            SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já é dono desse quarto.");
            return 0;
        }

        if(Hotel[hotelid][Valor] > GetPlayerMoney(playerid))
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem o dinheiro suficiente para comprar um apartamento.");

        if( GetPlayerHotel(playerid) != INVALID_HOTEL_ID )
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já possui um apartamento.");

        GivePlayerMoney(playerid, -Hotel[hotelid][Valor], true);
        SendClientMessage(playerid, COR_BRANCO, "APARTAMENTO: Você alugou o apartamento {"COR_AZUL_INC"}%d{"COR_BRANCO_INC"} por {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}.", Hotel[hotelid][ID], RealStr(Hotel[hotelid][Valor]));

        format(Hotel[hotelid][Owner][Name], MAX_PLAYER_NAME, GetUserName(playerid));

        new query[130];
        mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_HOTEIS" SET `proprietario_id`='%d' WHERE `id`='%d' LIMIT 1;", Jogador[playerid][PlayerID], Hotel[hotelid][ID]);
        mysql_tquery(getConexao(), query);

        UpdateLabelHotel(hotelid);
    }
    return true;
}

Dialog:SELL_HOTEL(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new hotelid = strval(inputtext);
        
        if (  !IsValidHotel(hotelid) )
        {
            SendClientMessage(playerid, COR_ERRO, "[X] Hotel inválido.");
            return 0;
        }

        SendClientMessage(playerid, COR_BRANCO, "APARTAMENTO: Você deixou de ser o locatário do apartamento {"COR_AMARELO_INC"}%d{"COR_BRANCO_INC"}.", Hotel[hotelid][ID]);

        format(Hotel[hotelid][Owner][Name], MAX_PLAYER_NAME, "Ninguem");
       	Hotel[hotelid][Owner][Id] = 0;

        new query[512];
        mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_HOTEIS" SET `proprietario_id`=NULL,`impostos`=0,`trancado`=0 WHERE `id`='%d'", Hotel[hotelid][ID]);
        mysql_tquery(getConexao(), query);

        UpdateLabelHotel(hotelid);
    }
    return true;
}

Dialog:PAGAR_IMPOSTOS_HOTEL(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new hotelid = GetPlayerHotel(playerid), valorapagar = (Hotel[hotelid][Valor]*Hotel[hotelid][Impostos]);
		
		if ( valorapagar > GetPlayerMoney(playerid) )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente para pagar seus aluguel.");

		if ( valorapagar <= 0 )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Seu apartamento não tem aluguel pendentes a pagar.");

		new query[128];
		mysql_format(getConexao(), query, sizeof(query), "UPDATE "TABLE_HOTEIS" SET `impostos`='0' WHERE `id`='%d' LIMIT 1;", Hotel[hotelid][ID]);
		mysql_tquery(getConexao(), query);

		GivePlayerMoney(playerid, -valorapagar);
		SendClientMessage(playerid, COR_AZUL, "» Você quitou as parcelas do seu apartamento no valor de {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}.", RealStr(valorapagar));
        Hotel[hotelid][Impostos] = 0;

        if ( call::PLAYER->GetPlayerVarInt(playerid, Entrou) == ENTROU_EMPRESA )
        {
            new id = GetPlayerVirtualWorld(playerid);

            if ( call::BUSINESS->IsValidBusiness(id) )
            {
                call::BUSINESS->SetBusinessParamsInt(id, Cofre, call::BUSINESS->GetBusinessParamsInt(id, Cofre) + valorapagar);
            }
        }
        return true;
	}
	return false;
}