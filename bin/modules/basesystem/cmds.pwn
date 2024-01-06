// NEW SYSTEM: BASES

/* ----         Started at 20/05/2021 - 10:02                                                     */
/* ----         Author: Luiz "LuizM" Henrique                                                     */
/* ----         Credits:                                                                          */
/* ----         Finished at xx/xx/xxxx - xx:xx                                                    */
/* ----         First patch: xx/xx/xxxx - xx:xx - xxx lines                                       */


#include <YSI_Coding\y_hooks>

CMD:menubase(playerid)
{
    new baseid = call::BASE->GetBaseInRangeOfP(playerid, 2.0);

    if(baseid == INVALID_BASE_ID)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de nenhuma base.");
    
    if(!call::BASE->CheckBaseMember(playerid, baseid))
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte desta base.");
    
    call::BASE->ShowPlayerBaseMenu(playerid, baseid);

    return 1;
}

CMD:comprarbase(playerid)
{
    new baseid = call::BASE->GetBaseInRangeOfP(playerid, 2.0);

    if(baseid == INVALID_BASE_ID)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de nenhuma base.");
    
    if(call::PLAYER->GetPlayerVarInt(playerid, BaseID) != INVALID_BASE_ID)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já possui ou faz parte de uma base.");
    
    if(GetPlayerMoney(playerid) < call::BASE->GetBaseParamsInt(baseid, Valor))
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui dinheiro suficiente.");
    
    new name[MAX_PLAYER_NAME];
    call::BASE->GetBaseParams(baseid, Lider, name, MAX_PLAYER_NAME);

    if(!strcmp(name, "Ninguem", true))
    {
        GivePlayerMoney(playerid, -call::BASE->GetBaseParamsInt(baseid, Valor));

        SendClientMessageToAll(-1, "| BASE | O(A) jogador(a) %s[%d] comprou a Base ID %d localizada em %s", GetUserName(playerid), playerid, call::BASE->GetBaseParamsInt(baseid, ID), \
        call::BASE->GetBaseLocalName(baseid));

        call::PLAYER->SetPlayerVarInt(playerid, BaseID, baseid);

        new query[350];
        mysql_format(getConexao(), query, 350, "UPDATE `usuarios` SET `baseid`='%d' WHERE `id`='%d'", call::BASE->GetBaseParamsInt(baseid, ID), call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
        mysql_tquery(getConexao(), query);

        mysql_format(getConexao(), query, 350, "UPDATE `bases` SET `lider`='%s', `up`=1, `nome`='N/A', `tag`='N/A', `vencimento`=%d, `cofre`='0' WHERE `id`='%d'", \
        GetUserName(playerid), ( gettime() + 86400 * 30 ), call::BASE->GetBaseParamsInt(baseid, ID));
        mysql_tquery(getConexao(), query);

        call::BASE->BuyBase(playerid, baseid);

    }
    else 
    {
        SendClientMessage(playerid, COR_ERRO, "| ERRO | Esta base não está a venda.");
    }
    return 1;
}

flags:setvencimento(DEV);
CMD:setvencimento(playerid)
{
    new baseid = call::BASE->GetBaseInRangeOfP(playerid, 2.0);

    if(baseid == INVALID_BASE_ID)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de nenhuma base.");
    
    call::BASE->SetBaseParamsInt(baseid, Vencimento, gettime() + 3600);
    return 1;
}