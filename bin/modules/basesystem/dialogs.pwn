// NEW SYSTEM: BASES

/* ----         Started at 20/05/2021 - 10:02                                                     */
/* ----         Author: Luiz "LuizM" Henrique                                                     */
/* ----         Credits:                                                                          */
/* ----         Finished at xx/xx/xxxx - xx:xx                                                    */
/* ----         First patch: xx/xx/xxxx - xx:xx - xxx lines                                       */


#include <YSI_Coding\y_hooks>

new SelectedMember[MAX_PLAYERS][MAX_MEMBROS_BASE+1];

Dialog:DIALOG_MENU_BASE(playerid, response, listitem, inputtext[])
{
    new baseid = call::BASE->GetBaseInRangeOfP(playerid, 2.0);

    if(baseid == INVALID_BASE_ID)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de nenhuma base.");

    if(response)
    {
        switch(listitem)
        {
            case 0: // Nome do Clã
            {
                if(!call::BASE->CheckBaseLeader(playerid, baseid))
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é Líder da base.");
                
                ShowPlayerDialog(playerid, DIALOG_BASE_NOME, DIALOG_STYLE_INPUT, "{ffffff}Alterar Nome", "{ffffff}Digite abaixo o novo nome do Clã.", "Alterar", "Voltar");
            }

            case 1: // Vencimento
            {

            }

            case 2: // Líder
            {
                call::BASE->ShowPlayerBaseMenu(playerid, baseid);
            }

            case 3: // TAG
            {
                if(!call::BASE->CheckBaseLeader(playerid, baseid))
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é Líder da base.");
                
                ShowPlayerDialog(playerid, DIALOG_BASE_TAG, DIALOG_STYLE_INPUT, "{ffffff}Alterar TAG", "{ffffff}Digite abaixo a nova TAG do Clã.", "Alterar", "Voltar");
            }

            case 4: // Nível
            {

            }

            case 5: // Cofre
            {
                if(!call::BASE->CheckBaseMember(playerid, baseid))
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é membro desta base.");
                
                new titulo[150];
                format(titulo, 150, "{ffffff}Cofre: {31b404}R$%s", RealStr(call::BASE->GetBaseParamsInt(baseid, Cofre)));

                ShowPlayerDialog(playerid, DIALOG_BASE_COFRE, DIALOG_STYLE_LIST, titulo, "{ffffff}Depositar no Cofre\n{ffffff}Sacar Fundos", "Selecionar", "Voltar");
            }

            case 6: // Membros
            {
                if(!call::BASE->CheckBaseMember(playerid, baseid))
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é membro desta base.");
                
                new query[350];
                format(query, 350, "SELECT * FROM `usuarios` WHERE `baseid`='%d'", call::BASE->GetBaseParamsInt(baseid, ID));
                new Cache:result = mysql_query(getConexao(), query, true), rows = cache_num_rows();
                
                new String[1000], Str[1000], titulo[150];

                strcat(String, "{ffffff}Membro\t{ffffff}Nome\t{ffffff}Level\n");

                if(rows > 0)
                {
                    for(new i; i < rows; i++)
                    {
                        new nome[MAX_PLAYER_NAME], level;
                        cache_get_value_name(i, "username", nome, MAX_PLAYER_NAME);
                        cache_get_value_int(i, "level", level);

                        cache_get_value_int(i, "id", SelectedMember[playerid][i]);

                        format(Str, 1000, "{"COR_LARANJA_INC"}Membro %d\t{ffffff}%s\t{ffff00}%d\n", i+1, nome, level);
                        strcat(String, Str);
                    }

                    new basename[50];
                    call::BASE->GetBaseParams(baseid, Nome, basename, 50);

                    format(titulo, 150, "{ffffff}Membros - %s [ {31b404}%d {ffffff}]", basename, rows);

                    ShowPlayerDialog(playerid, DIALOG_BASE_MEMBROS, DIALOG_STYLE_TABLIST_HEADERS, titulo, String, "Expulsar", "Cancelar");
                }

                cache_delete(result);
            }

            case 7: // Veículos
            {

            }

            case 8: // Adicionar um(a) membro
            {
                if(!call::BASE->CheckBaseLeader(playerid, baseid))
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é membro desta base.");
                
                new query[350];
                format(query, 350, "SELECT * FROM `usuarios` WHERE `baseid`='%d'", call::BASE->GetBaseParamsInt(baseid, ID));
                new Cache:result = mysql_query(getConexao(), query, true), rows = cache_num_rows();
                
                if(rows > 0)
                {
                    if(rows >= MAX_MEMBROS_BASE)
                        return SendClientMessage(playerid, COR_ERRO, "| ERRO | A base já está no limite de membros.");
                }

                ShowPlayerDialog(playerid, DIALOG_ADD_MEMBER, DIALOG_STYLE_INPUT, "{FFFFFF}Adicionar Membro", "{ffffff}Digite o ID do(a) jogador(a) que deseja adicionar na base.", "Adicionar", "Cancelar");

                cache_delete(result);
            }
        }
    }
    return 1;
}

Dialog:DIALOG_BASE_NOME(playerid, response, listitem, inputtext[])
{
    new baseid = call::BASE->GetBaseInRangeOfP(playerid, 2.0);

    if(!response)
        return call::BASE->ShowPlayerBaseMenu(playerid, baseid);
    
    if(response)
    {
        if(baseid == INVALID_BASE_ID)
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de nenhuma base.");
    
        if(!call::BASE->CheckBaseMember(playerid, baseid))
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte desta base.");

        if(strlen(inputtext) > 20) 
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você só pode digitar até 20 caracteres.");
        
        if( strfind("{", inputtext, true) != -1 || strfind("}", inputtext, true) != -1)
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar '{ }' no nome da base.");
        
        call::BASE->SetBaseParams(baseid, Nome, inputtext);

        SendClientMessage(playerid, -1, "| BASE | Você alterou o nome da base para: {"COR_LARANJA_INC"}%s{ffffff}", inputtext);

        new query[350];
        mysql_format(getConexao(), query, 350, "UPDATE `bases` SET `nome`='%s' WHERE `id`='%d' LIMIT 1", inputtext, call::BASE->GetBaseParamsInt(baseid, ID));
        mysql_tquery(getConexao(), query);

        call::BASE->UpdateBaseTexts(baseid);
    }
    return 1;
}

Dialog:DIALOG_BASE_TAG(playerid, response, listitem, inputtext[])
{
    new baseid = call::BASE->GetBaseInRangeOfP(playerid, 2.0);

    if(!response)
        return call::BASE->ShowPlayerBaseMenu(playerid, baseid);
    
    if(response)
    {
        if(baseid == INVALID_BASE_ID)
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de nenhuma base.");
    
        if(!call::BASE->CheckBaseMember(playerid, baseid))
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte desta base.");

        if(strlen(inputtext) > 20) 
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você só pode digitar até 20 caracteres.");
        
        if( strfind("[", inputtext, true) != -1 || strfind("]", inputtext, true) != -1)
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar '[ ]' no nome da base.");
        
        call::BASE->SetBaseParams(baseid, TAG, inputtext);

        SendClientMessage(playerid, -1, "| BASE | Você alterou a TAG da base para: [%s{ffffff}]", inputtext);

        new query[350];
        mysql_format(getConexao(), query, 350, "UPDATE `bases` SET `tag`='%s' WHERE `id`='%d' LIMIT 1", inputtext, call::BASE->GetBaseParamsInt(baseid, ID));
        mysql_tquery(getConexao(), query);

        call::BASE->UpdateBaseTexts(baseid);
    }
    return 1;
}

Dialog:DIALOG_BASE_COFRE(playerid, response, listitem, inputtext[])
{
    new baseid = call::BASE->GetBaseInRangeOfP(playerid, 2.0);

    if(!response)
        return call::BASE->ShowPlayerBaseMenu(playerid, baseid);
    
    if(response)
    {
        if(baseid == INVALID_BASE_ID)
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de nenhuma base.");

        if(!call::BASE->CheckBaseMember(playerid, baseid))
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é membro desta base.");

        switch(listitem)
        {
            case 0: // Depositar Fundos
            {
                ShowPlayerDialog(playerid, DIALOG_COFRE_ADD, DIALOG_STYLE_INPUT, "{ffffff}Depositar no Cofre", "{ffffff}Digite o valor que deseja depositar no cofre.", "Depositar", "Cancelar");
            }

            case 1: // Sacar Fundos
            {
                if(!call::BASE->CheckBaseLeader(playerid, baseid))
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é Líder da base.");

                if(call::BASE->GetBaseParamsInt(baseid, Cofre) == 0)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esta base não possui fundos para serem sacados.");
                
                SendClientMessage(playerid, -1, "| BASE | Você sacou {31b404}R$%s {ffffff}do cofre da base.", RealStr(call::BASE->GetBaseParamsInt(baseid, Cofre)) );

                GivePlayerMoney(playerid, call::BASE->GetBaseParamsInt(baseid, Cofre));

                call::BASE->SetBaseParamsInt(baseid, Cofre, 0);

            }
        }
    }
    return 1;
}

Dialog:DIALOG_COFRE_ADD(playerid, response, listitem, inputtext[])
{
    new baseid = call::BASE->GetBaseInRangeOfP(playerid, 2.0);

    if(response)
    {
        if(baseid == INVALID_BASE_ID)
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de nenhuma base.");

        if(!call::BASE->CheckBaseMember(playerid, baseid))
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é membro desta base.");
        
        if(!IsNumeric(inputtext))
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Digite apenas números.");
        
        new valor = strval(inputtext);
        if(valor > GetPlayerMoney(playerid))
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui dinheiro suficiente.");
        
        if(valor > 20000)
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você pode depositar até no máximo R$20.000 no cofre da base.");
        
        SendClientMessage(playerid, -1, "| BASE | Você depositou {31b404}R$%s {ffffff}no cofre da base.", RealStr(valor));

        call::BASE->SetBaseParamsInt(baseid, Cofre, call::BASE->GetBaseParamsInt(baseid, Cofre)+valor);
        
        GivePlayerMoney(playerid, -valor);
    }
    return 1;
}

Dialog:DIALOG_BASE_MEMBROS(playerid, response, listitem, inputtext[])
{
    new baseid = call::BASE->GetBaseInRangeOfP(playerid, 2.0);

    if(!response)
        return call::BASE->ShowPlayerBaseMenu(playerid, baseid);
    
    if(response)
    {
        if(baseid == INVALID_BASE_ID)
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de nenhuma base.");

        if(!call::BASE->CheckBaseLeader(playerid, baseid))
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é Líder da base.");
        
        new selected = SelectedMember[playerid][listitem];
        for(new i; i < sizeof(SelectedMember[]); i++)
            SelectedMember[playerid][i] = -1;

        SetPVarInt(playerid, "SelectedMember", selected);
        
        new query[350];
        format(query, 350, "SELECT * FROM `usuarios` WHERE `id`='%d'", selected);
        new Cache:result = mysql_query(getConexao(), query, true), rows = cache_num_rows();
        
        if(rows > 0)
        {
            new nome[MAX_PLAYER_NAME];
            cache_get_value_name(0, "username", nome);

            ShowPlayerDialog(playerid, DIALOG_MEMBER_REMOVE, DIALOG_STYLE_MSGBOX, "{ffffff}Remover Membro", "{ffffff}Deseja remover o(a) jogador(a) {1c88f0}%s {ffffff}da base?", "Sim", "Não", nome);
        }

        cache_delete(result);
    }
    return 1;
}

Dialog:DIALOG_MEMBER_REMOVE(playerid, response, listitem, inputtext[])
{
    new baseid = call::BASE->GetBaseInRangeOfP(playerid, 2.0);

    if(!response)
        return DeletePVar(playerid, "SelectedMember");

    if(response)
    {
        if(baseid == INVALID_BASE_ID)
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de nenhuma base.");

        if(!call::BASE->CheckBaseLeader(playerid, baseid))
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é Líder da base.");
        
        if(call::PLAYER->GetPlayerVarInt(playerid, PlayerID) == GetPVarInt(playerid, "SelectedMember"))
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode remover o Líder da base.");
        
        foreach(new i: Player)
        {
            if(call::PLAYER->GetPlayerVarInt(i, PlayerID) == GetPVarInt(playerid, "SelectedMember"))
            {
                SendClientMessage(i, COR_ERRO, "| BASE | Você foi expulso(a) da Base ID %d pelo(a) Líder %s[%d].", call::BASE->GetBaseParamsInt(baseid, ID), GetUserName(playerid), playerid);
                SendClientMessage(playerid, -1, "| BASE | Você removeu o(a) jogador(a) {1c88f0}%s[%d] {ffffff}da Base ID {"COR_LARANJA_INC"}%d{ffffff}.", GetUserName(i), i, call::BASE->GetBaseParamsInt(baseid, ID));

                call::PLAYER->SetPlayerVarInt(i, BaseID, INVALID_BASE_ID);
                
                new query[350];
                mysql_format(getConexao(), query, 350, "UPDATE `usuarios` SET `baseid`=0 WHERE `id`='%d'", call::PLAYER->GetPlayerVarInt(i, PlayerID));
                mysql_tquery(getConexao(), query);
                return 1;
            }
        }

        new query[350];
        format(query, 350, "SELECT * FROM `usuarios` WHERE `id`='%d'", GetPVarInt(playerid, "SelectedMember"));
        new Cache:result = mysql_query(getConexao(), query, true), rows = cache_num_rows();
        
        if(rows > 0)
        {
            new nome[MAX_PLAYER_NAME];
            cache_get_value_name(0, "username", nome, MAX_PLAYER_NAME);

            SendClientMessage(playerid, -1, "| BASE | Você removeu o(a) jogador(a) {1c88f0}%s {ffffff}da Base ID {"COR_LARANJA_INC"}%d{ffffff}.", nome, \
            call::BASE->GetBaseParamsInt(baseid, ID));

            mysql_format(getConexao(), query, 350, "UPDATE `usuarios` SET `baseid`=0 WHERE `id`='%d'", GetPVarInt(playerid, "SelectedMember"));
            mysql_tquery(getConexao(), query);

            DeletePVar(playerid, "SelectedMember");
        }

        cache_delete(result);
    }
    return 1;
}

Dialog:DIALOG_ADD_MEMBER(playerid, response, listitem, inputtext[])
{
    new baseid = call::BASE->GetBaseInRangeOfP(playerid, 2.0);

    if(response)
    {
        if(baseid == INVALID_BASE_ID)
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo de nenhuma base.");

        if(!call::BASE->CheckBaseLeader(playerid, baseid))
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é Líder da base.");
        
        if(!IsNumeric(inputtext))
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Digite um ID.");
        
        new id = strval(inputtext);

        new Float:Posicao[4];
        GetPlayerPos(playerid, Posicao[0], Posicao[1], Posicao[2]);

        if(!IsPlayerConnected(id))
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Jogador(a) não conectado(a).");

        if(!IsPlayerInRangeOfPoint(id, 5.0, Posicao[0], Posicao[1], Posicao[2]))
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) precisa estar próximo de você.");
        
        if(call::PLAYER->GetPlayerVarInt(id, BaseID) != INVALID_BASE_ID)
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | O(A) jogador(a) já está em uma base.");
        
        SendClientMessage(id, -1, "| BASE | O(A) Líder {1c88f0}%s[%d] {ffffff}adicionou você na Base ID {"COR_LARANJA_INC"}%d{ffffff}.", GetUserName(playerid), playerid, call::BASE->GetBaseParamsInt(baseid, ID));
        SendClientMessage(playerid, -1, "| BASE | Você adicionou o(a) jogador(a) {1c88f0}%s[%d] {ffffff}na Base ID {"COR_LARANJA_INC"}%d{ffffff}.", GetUserName(id), id, call::BASE->GetBaseParamsInt(baseid, ID));

        call::PLAYER->SetPlayerVarInt(id, BaseID, baseid);

        new query[350];
        mysql_format(getConexao(), query, 350, "UPDATE `usuarios` SET `baseid`='%d' WHERE `id`='%d'", call::BASE->GetBaseParamsInt(baseid, ID), call::PLAYER->GetPlayerVarInt(id, PlayerID));
        mysql_tquery(getConexao(), query);


    }
    return 1;
}