// NEW MAFIA: ASSALTANTE

/* ----         Started at 16/05/2021 - 00:25                                                     */
/* ----         Author: Luiz "LuizM" Henrique                                                     */
/* ----         Credits: Kettler (suggestion)                                                     */
/* ----         Finished at 16/05/2021 - 04:24                                                    */
/* ----         First patch: 16/05/2021 - 04:24 - 625 lines                                       */

#include <YSI_Coding\y_hooks>

enum _ASSALTANTE
{
    bool:Assaltando,
    Valor,
    Min_A,
    Seg_A,
    Timer_A,
    cooldown,
    bool:InCooldown,
    Type
}
new pAssaltante[MAX_PLAYERS][_ASSALTANTE];

static Actor247[MAX_BUSINESS], ActorStacked[MAX_BUSINESS], ActorCluckin[MAX_BUSINESS], ActorBurger[MAX_BUSINESS], ActorBinco[MAX_BUSINESS], ActorZIP[MAX_BUSINESS], ActorDidierSachs[MAX_BUSINESS], 
    ActorVictim[MAX_BUSINESS], ActorSubUrban[MAX_BUSINESS];

static PlayerText:T_Assaltante[MAX_PLAYERS][9];

new timer_Verify[MAX_PLAYERS];

forward ResetarCooldown(playerid);
public ResetarCooldown(playerid)
{
    pAssaltante[playerid][InCooldown] = false;

    new query[350];

    format(query, 350, "UPDATE `usuarios` SET `cooldown_a`='0' WHERE `id`='%d'", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
    mysql_query(getConexao(), query, false);

    call::ASSALTANTE->ResetVariables(playerid);

    return 1;
}

function ASSALTANTE::CreateActors()
{
    for(new i; i < MAX_BUSINESS; i++)
    {
        Actor247[i] = CreateDynamicActor(211,-29.2779,-186.8141,1003.5469,359.7358, .worldid=i);
        ActorStacked[i] = CreateDynamicActor(155,373.8592,-117.2788,1001.4995,180.0867, .worldid=i);
        ActorCluckin[i] = CreateDynamicActor(167,367.9739,-4.4923,1001.8516,179.0993, .worldid=i);
        ActorBurger[i] = CreateDynamicActor(205,377.1293,-65.8491,1001.5078,179.5816, .worldid=i);
        ActorBinco[i] = CreateDynamicActor(211,207.5419,-98.7045,1005.2578,178.3556, .worldid=i);
        ActorZIP[i] = CreateDynamicActor(211,161.5681,-81.1919,1001.8047,178.5048, .worldid=i);
        ActorDidierSachs[i] = CreateDynamicActor(211,204.3892,-157.8294,1000.5234,178.6021, .worldid=i);
        ActorVictim[i] = CreateDynamicActor(211,206.4900,-8.2934,1005.2109,270.4899, .worldid=i);
        ActorSubUrban[i] = CreateDynamicActor(211,203.5354,-41.6710,1001.8047,181.0656, .worldid=i);
    }

    CreateDynamic3DTextLabel("24/7\n{"COR_LARANJA_INC"}Mire para assaltar.", -1, -29.2779,-186.8141,1003.5469,10.0);
    CreateDynamic3DTextLabel("The Well Stacked Pizza Co.\n{"COR_LARANJA_INC"}Mire para assaltar.", -1, 373.8592,-117.2788,1001.4995,10.0);
    CreateDynamic3DTextLabel("Cluckin' Bell\n{"COR_LARANJA_INC"}Mire para assaltar.", -1, 367.9739,-4.4923,1001.8516,10.0);
    CreateDynamic3DTextLabel("Burger Shot\n{"COR_LARANJA_INC"}Mire para assaltar.", -1, 377.1293,-65.8491,1001.5078,10.0);
    CreateDynamic3DTextLabel("Binco\n{"COR_LARANJA_INC"}Mire para assaltar.", -1, 207.5419,-98.7045,1005.2578,10.0);
    CreateDynamic3DTextLabel("ZIP\n{"COR_LARANJA_INC"}Mire para assaltar.", -1, 161.5681,-81.1919,1001.8047,10.0);
    CreateDynamic3DTextLabel("Didier Sachs\n{"COR_LARANJA_INC"}Mire para assaltar.", -1, 204.3892,-157.8294,1000.5234,10.0);
    CreateDynamic3DTextLabel("Victim\n{"COR_LARANJA_INC"}Mire para assaltar.", -1, 206.4900,-8.2934,1005.2109,10.0);
    CreateDynamic3DTextLabel("Sub Urban\n{"COR_LARANJA_INC"}Mire para assaltar.", -1, 203.5354,-41.6710,1001.8047,10.0);
    return 1;
}

function ASSALTANTE::CreateTDs(playerid)
{
    T_Assaltante[playerid][0] = CreatePlayerTextDraw(playerid, 16.666675, 150.177780, "box");
    PlayerTextDrawLetterSize(playerid, T_Assaltante[playerid][0], 0.000000, 6.299990);
    PlayerTextDrawTextSize(playerid, T_Assaltante[playerid][0], 85.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, T_Assaltante[playerid][0], 1);
    PlayerTextDrawColor(playerid, T_Assaltante[playerid][0], -1);
    PlayerTextDrawUseBox(playerid, T_Assaltante[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid, T_Assaltante[playerid][0], 105);
    PlayerTextDrawSetShadow(playerid, T_Assaltante[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, T_Assaltante[playerid][0], 255);
    PlayerTextDrawFont(playerid, T_Assaltante[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, T_Assaltante[playerid][0], 1);

    T_Assaltante[playerid][2] = CreatePlayerTextDraw(playerid, 3.333309, 163.711151, "");
    PlayerTextDrawTextSize(playerid, T_Assaltante[playerid][2], 49.000000, 49.000000);
    PlayerTextDrawAlignment(playerid, T_Assaltante[playerid][2], 1);
    PlayerTextDrawColor(playerid, T_Assaltante[playerid][2], -1);

    PlayerTextDrawSetShadow(playerid, T_Assaltante[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, T_Assaltante[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, T_Assaltante[playerid][2], 0xFFFFFF00);

    //PlayerTextDrawBoxColor(playerid, T_Assaltante[playerid][2], 0);
    PlayerTextDrawSetShadow(playerid, T_Assaltante[playerid][2], 0);
    PlayerTextDrawFont(playerid, T_Assaltante[playerid][2], 5);
    PlayerTextDrawSetProportional(playerid, T_Assaltante[playerid][2], 0);
    PlayerTextDrawSetPreviewModel(playerid, T_Assaltante[playerid][2], 1550);
    PlayerTextDrawSetPreviewRot(playerid, T_Assaltante[playerid][2], 0.000000, 0.000000, 45.000000, 1.000000);

    T_Assaltante[playerid][1] = CreatePlayerTextDraw(playerid, 17.000007, 150.177719, "box");
    PlayerTextDrawLetterSize(playerid, T_Assaltante[playerid][1], 0.000000, 0.024334);
    PlayerTextDrawTextSize(playerid, T_Assaltante[playerid][1], 85.059799, 0.000000);
    PlayerTextDrawAlignment(playerid, T_Assaltante[playerid][1], 1);
    PlayerTextDrawColor(playerid, T_Assaltante[playerid][1], -1);
    PlayerTextDrawUseBox(playerid, T_Assaltante[playerid][1], 1);
    PlayerTextDrawBoxColor(playerid, T_Assaltante[playerid][1], 65535);
    PlayerTextDrawSetShadow(playerid, T_Assaltante[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, T_Assaltante[playerid][1], 255);
    PlayerTextDrawFont(playerid, T_Assaltante[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, T_Assaltante[playerid][1], 1);

    T_Assaltante[playerid][3] = CreatePlayerTextDraw(playerid, 29.466680, 152.896301, "Assaltando...");
    PlayerTextDrawLetterSize(playerid, T_Assaltante[playerid][3], 0.238335, 1.560000);
    PlayerTextDrawAlignment(playerid, T_Assaltante[playerid][3], 1);
    PlayerTextDrawColor(playerid, T_Assaltante[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, T_Assaltante[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, T_Assaltante[playerid][3], 1);
    PlayerTextDrawBackgroundColor(playerid, T_Assaltante[playerid][3], 255);
    PlayerTextDrawFont(playerid, T_Assaltante[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, T_Assaltante[playerid][3], 1);

    T_Assaltante[playerid][4] = CreatePlayerTextDraw(playerid, 52.166511, 170.259353, "Tempo:");
    PlayerTextDrawLetterSize(playerid, T_Assaltante[playerid][4], 0.267001, 1.270000);
    PlayerTextDrawAlignment(playerid, T_Assaltante[playerid][4], 1);
    PlayerTextDrawColor(playerid, T_Assaltante[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, T_Assaltante[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, T_Assaltante[playerid][4], 1);
    PlayerTextDrawBackgroundColor(playerid, T_Assaltante[playerid][4], 255);
    PlayerTextDrawFont(playerid, T_Assaltante[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, T_Assaltante[playerid][4], 1);

    T_Assaltante[playerid][5] = CreatePlayerTextDraw(playerid, 53.066497, 181.060012, "00:00");
    PlayerTextDrawLetterSize(playerid, T_Assaltante[playerid][5], 0.267001, 1.270000);
    PlayerTextDrawAlignment(playerid, T_Assaltante[playerid][5], 1);
    PlayerTextDrawColor(playerid, T_Assaltante[playerid][5], -5963521);
    PlayerTextDrawSetShadow(playerid, T_Assaltante[playerid][5], 0);
    PlayerTextDrawSetOutline(playerid, T_Assaltante[playerid][5], 1);
    PlayerTextDrawBackgroundColor(playerid, T_Assaltante[playerid][5], 255);
    PlayerTextDrawFont(playerid, T_Assaltante[playerid][5], 1);
    PlayerTextDrawSetProportional(playerid, T_Assaltante[playerid][5], 1);

    T_Assaltante[playerid][6] = CreatePlayerTextDraw(playerid, 48.899959, 194.022079, "Perfect");
    PlayerTextDrawLetterSize(playerid, T_Assaltante[playerid][6], 0.207001, 1.230000);
    PlayerTextDrawAlignment(playerid, T_Assaltante[playerid][6], 1);
    PlayerTextDrawColor(playerid, T_Assaltante[playerid][6], -1);
    PlayerTextDrawSetShadow(playerid, T_Assaltante[playerid][6], 0);
    PlayerTextDrawSetOutline(playerid, T_Assaltante[playerid][6], 1);
    PlayerTextDrawBackgroundColor(playerid, T_Assaltante[playerid][6], 255);
    PlayerTextDrawFont(playerid, T_Assaltante[playerid][6], 1);
    PlayerTextDrawSetProportional(playerid, T_Assaltante[playerid][6], 1);

    T_Assaltante[playerid][7] = CreatePlayerTextDraw(playerid, 70.632949, 193.862915, "City");
    PlayerTextDrawLetterSize(playerid, T_Assaltante[playerid][7], 0.207001, 1.230000);
    PlayerTextDrawAlignment(playerid, T_Assaltante[playerid][7], 1);
    PlayerTextDrawColor(playerid, T_Assaltante[playerid][7], 65535);
    PlayerTextDrawSetShadow(playerid, T_Assaltante[playerid][7], 0);
    PlayerTextDrawSetOutline(playerid, T_Assaltante[playerid][7], 1);
    PlayerTextDrawBackgroundColor(playerid, T_Assaltante[playerid][7], 255);
    PlayerTextDrawFont(playerid, T_Assaltante[playerid][7], 1);
    PlayerTextDrawSetProportional(playerid, T_Assaltante[playerid][7], 1);

    T_Assaltante[playerid][8] = CreatePlayerTextDraw(playerid, 44.000011, 173.407394, "box");
    PlayerTextDrawLetterSize(playerid, T_Assaltante[playerid][8], 0.000000, 3.366660);
    PlayerTextDrawTextSize(playerid, T_Assaltante[playerid][8], 43.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, T_Assaltante[playerid][8], 1);
    PlayerTextDrawColor(playerid, T_Assaltante[playerid][8], -1);
    PlayerTextDrawUseBox(playerid, T_Assaltante[playerid][8], 1);
    PlayerTextDrawBoxColor(playerid, T_Assaltante[playerid][8], -2139062017);
    PlayerTextDrawSetShadow(playerid, T_Assaltante[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, T_Assaltante[playerid][8], 255);
    PlayerTextDrawFont(playerid, T_Assaltante[playerid][8], 1);
    PlayerTextDrawSetProportional(playerid, T_Assaltante[playerid][8], 1);

    return 1;
}

function ASSALTANTE::ShowTD(playerid)
{
    new String[20];
    format(String, 20, "%02d:%02d", pAssaltante[playerid][Min_A], pAssaltante[playerid][Seg_A]);

    PlayerTextDrawSetString(playerid, PlayerText:T_Assaltante[playerid][5], String);

    for(new i; i < 8; i++)
    {
        PlayerTextDrawShow(playerid, PlayerText:T_Assaltante[playerid][i]);
    }
    return 1;
}

function ASSALTANTE::ResetVariables(playerid)
{
    pAssaltante[playerid][Assaltando] = false;
    pAssaltante[playerid][Valor] = 0;
    pAssaltante[playerid][Min_A] = 0;
    pAssaltante[playerid][Seg_A] = 0;
    pAssaltante[playerid][InCooldown] = false;
    pAssaltante[playerid][Type] = 0;

    for(new i; i < 9; i++)
    {
        PlayerTextDrawHide(playerid, PlayerText:T_Assaltante[playerid][i]);
    }

    return 1;
}

forward VerifyCooldown(playerid);
public VerifyCooldown(playerid)
{
    new query[350];
    format(query, 350, "SELECT `cooldown_a` FROM `usuarios` WHERE `id`='%d'", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
    new Cache:result = mysql_query(getConexao(), query, true), rows = cache_num_rows();

    if(rows)
    {   
        new incooldown;
        cache_get_value_int(0, "cooldown_a", incooldown);
        if(incooldown == 1)
        {
            pAssaltante[playerid][cooldown] = SetTimerEx("ResetarCooldown", 10 * 60000, 0, "i", playerid);
            pAssaltante[playerid][InCooldown] = true;
        }
    }

    cache_delete(result);
    return 1;
}

function ASSALTANTE::RobBusiness(playerid)
{
    SendClientMessage(playerid, -1, "| ASSALTO | Você assaltou com sucesso a Empresa ID {"COR_LARANJA_INC"}%d{ffffff}. Você recebeu {31b404}R$%s {ffffff}pelo assalto.", GetPlayerVirtualWorld(playerid), RealStr(pAssaltante[playerid][Valor]));

    GivePlayerMoney(playerid, pAssaltante[playerid][Valor]);

    new tempo;
    switch(pAssaltante[playerid][Type])
    {
        case 1:
        {
            tempo = 10;
        }
        case 2:
        {
            tempo = 7;
        }
        case 3:
        {
            tempo = 5;
        }
    }

    KillTimer(pAssaltante[playerid][cooldown]);

    pAssaltante[playerid][cooldown] = SetTimerEx("ResetarCooldown", tempo * 60000, 0, "i", playerid);

    new query[350];
    format(query, 350, "UPDATE `usuarios` SET `cooldown_a`='1' WHERE `id`='%d'", call::PLAYER->GetPlayerVarInt(playerid, PlayerID));
    mysql_query(getConexao(), query, true);

    call::ASSALTANTE->ResetVariables(playerid);

    pAssaltante[playerid][InCooldown] = true;
    return 1;
}


forward bool:IsValidWeaponToRob(playerid);
public bool:IsValidWeaponToRob(playerid)
{
    new id = GetPlayerWeapon(playerid);
    if(id >= 22 && id <= 38)
    {
        return true;
    }
    return false;
}

hook OnGameModeInit()
{
    call::ASSALTANTE->CreateActors();
    return 1;
}

hook OnPlayerConnect(playerid)
{
    timer_Verify[playerid] = SetTimerEx("OnPlayerAimActor", 1000, 1, "i", playerid);

    call::ASSALTANTE->CreateTDs(playerid);
    call::ASSALTANTE->ResetVariables(playerid);
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    KillTimer(timer_Verify[playerid]);

    call::ASSALTANTE->ResetVariables(playerid);
    return 1;
}

forward OnPlayerAimActor(playerid);
public OnPlayerAimActor(playerid)
{
    new actorid = GetPlayerTargetDynamicActor(playerid);

    if(actorid != INVALID_ACTOR_ID)
    {
        for(new i; i < MAX_BUSINESS; i++)
        {
            if(actorid == Actor247[i])
            {
                if(Jogador[playerid][Profissao] == POLICIA_MILITAR)
                {
                    if(call::JOB->IsPlayerInWorking(playerid))
                    {
                        SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode assaltar uma empresa estando uniformizado.");
                        return 1;
                    }
                }

                if(IsValidWeaponToRob(playerid) == false)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar com uma arma.");
                
                if(pAssaltante[playerid][Assaltando] == true)
                    return true;
                
                if(pAssaltante[playerid][InCooldown] == true)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa esperar antes de assaltar uma empresa de novo.");

                if(GetPlayerScore(playerid) < 100)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa ter ao menos Level 100 para assaltar uma empresa.");
                
                pAssaltante[playerid][Valor] = 4000 + random(3000);

                SendClientMessage(playerid, -1, "| ASSALTO | Você está assaltando a Empresa ID {"COR_LARANJA_INC"}%d{ffffff}. Você irá receber {31b404}R$%s{ffffff} em {1c88f0}3 {ffffff}minutos.", GetPlayerVirtualWorld(playerid), RealStr(pAssaltante[playerid][Valor]));
                SendClientMessage(playerid, COR_VERMELHO, "| ASSALTO | Se você sair da empresa, seu assalto será cancelado automaticamente.");

                SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+5);

                pAssaltante[playerid][Assaltando] = true;

                pAssaltante[playerid][Min_A] = 2;
                pAssaltante[playerid][Seg_A] = 59;

                pAssaltante[playerid][Type] = 1;

                call::ASSALTANTE->ShowTD(playerid);
                pAssaltante[playerid][Timer_A] = SetTimerEx("OnPlayerRobBusiness", 1000, 0, "i", playerid);

                foreach(new id: Player)
                {
                    if(Jogador[id][Profissao] == POLICIA_MILITAR && call::JOB->IsPlayerInWorking(id))
                    {
                        SendClientMessage(id, COR_AZUL, "| COPOM | O(A) jogador(a) %s[%d] está realizando um assalto na Empresa ID %d.", GetUserName(playerid), playerid, GetPlayerVirtualWorld(playerid));
                    }
                }
            }

            if(actorid == ActorStacked[i])
            {
                if(Jogador[playerid][Profissao] == POLICIA_MILITAR)
                {
                    if(call::JOB->IsPlayerInWorking(playerid))
                    {
                        SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode assaltar uma empresa estando uniformizado.");
                    }
                }

                if(IsValidWeaponToRob(playerid) == false)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar com uma arma.");
                
                if(pAssaltante[playerid][Assaltando] == true)
                    return true;
                
                if(pAssaltante[playerid][InCooldown] == true)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa esperar antes de assaltar uma empresa de novo.");

                if(GetPlayerScore(playerid) < 100)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa ter ao menos Level 100 para assaltar uma empresa.");
                
                pAssaltante[playerid][Valor] = 3000 + random(1000);

                SendClientMessage(playerid, -1, "| ASSALTO | Você está assaltando a Empresa ID {"COR_LARANJA_INC"}%d{ffffff}. Você irá receber {31b404}R$%s{ffffff} em {1c88f0}3 {ffffff}minutos.", GetPlayerVirtualWorld(playerid), RealStr(pAssaltante[playerid][Valor]));
                SendClientMessage(playerid, COR_VERMELHO, "| ASSALTO | Se você sair da empresa, seu assalto será cancelado automaticamente.");

                SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+3);

                pAssaltante[playerid][Assaltando] = true;

                pAssaltante[playerid][Type] = 2;

                pAssaltante[playerid][Min_A] = 2;
                pAssaltante[playerid][Seg_A] = 59;

                call::ASSALTANTE->ShowTD(playerid);
                pAssaltante[playerid][Timer_A] = SetTimerEx("OnPlayerRobBusiness", 1000, 0, "i", playerid);
            }

            if(actorid == ActorCluckin[i])
            {
                if(Jogador[playerid][Profissao] == POLICIA_MILITAR)
                {
                    if(call::JOB->IsPlayerInWorking(playerid))
                    {
                        SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode assaltar uma empresa estando uniformizado.");
                    }
                }

                if(IsValidWeaponToRob(playerid) == false)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar com uma arma.");
                
                if(pAssaltante[playerid][Assaltando] == true)
                    return true;
                
                if(pAssaltante[playerid][InCooldown] == true)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa esperar antes de assaltar uma empresa de novo.");

                if(GetPlayerScore(playerid) < 100)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa ter ao menos Level 100 para assaltar uma empresa.");
                
                pAssaltante[playerid][Valor] = 3000 + random(1000);

                SendClientMessage(playerid, -1, "| ASSALTO | Você está assaltando a Empresa ID {"COR_LARANJA_INC"}%d{ffffff}. Você irá receber {31b404}R$%s{ffffff} em {1c88f0}3 {ffffff}minutos.", GetPlayerVirtualWorld(playerid), RealStr(pAssaltante[playerid][Valor]));
                SendClientMessage(playerid, COR_VERMELHO, "| ASSALTO | Se você sair da empresa, seu assalto será cancelado automaticamente.");

                SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+3);

                pAssaltante[playerid][Assaltando] = true;

                pAssaltante[playerid][Type] = 2;

                pAssaltante[playerid][Min_A] = 2;
                pAssaltante[playerid][Seg_A] = 59;

                call::ASSALTANTE->ShowTD(playerid);
                pAssaltante[playerid][Timer_A] = SetTimerEx("OnPlayerRobBusiness", 1000, 0, "i", playerid);
            }

            if(actorid == ActorBurger[i])
            {
                if(Jogador[playerid][Profissao] == POLICIA_MILITAR)
                {
                    if(call::JOB->IsPlayerInWorking(playerid))
                    {
                        SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode assaltar uma empresa estando uniformizado.");
                    }
                }

                if(IsValidWeaponToRob(playerid) == false)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar com uma arma.");
                
                if(pAssaltante[playerid][Assaltando] == true)
                    return true;
                
                if(pAssaltante[playerid][InCooldown] == true)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa esperar antes de assaltar uma empresa de novo.");

                if(GetPlayerScore(playerid) < 100)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa ter ao menos Level 100 para assaltar uma empresa.");
                
                pAssaltante[playerid][Valor] = 3000 + random(1000);

                SendClientMessage(playerid, -1, "| ASSALTO | Você está assaltando a Empresa ID {"COR_LARANJA_INC"}%d{ffffff}. Você irá receber {31b404}R$%s{ffffff} em {1c88f0}3 {ffffff}minutos.", GetPlayerVirtualWorld(playerid), RealStr(pAssaltante[playerid][Valor]));
                SendClientMessage(playerid, COR_VERMELHO, "| ASSALTO | Se você sair da empresa, seu assalto será cancelado automaticamente.");

                SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+3);

                pAssaltante[playerid][Assaltando] = true;

                pAssaltante[playerid][Type] = 2;

                pAssaltante[playerid][Min_A] = 2;
                pAssaltante[playerid][Seg_A] = 59;

                call::ASSALTANTE->ShowTD(playerid);
                pAssaltante[playerid][Timer_A] = SetTimerEx("OnPlayerRobBusiness", 1000, 0, "i", playerid);
            }

            if(actorid == ActorBinco[i])
            {
                if(Jogador[playerid][Profissao] == POLICIA_MILITAR)
                {
                    if(call::JOB->IsPlayerInWorking(playerid))
                    {
                        SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode assaltar uma empresa estando uniformizado.");
                    }
                }

                if(IsValidWeaponToRob(playerid) == false)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar com uma arma.");
                
                if(pAssaltante[playerid][Assaltando] == true)
                    return true;
                
                if(pAssaltante[playerid][InCooldown] == true)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa esperar antes de assaltar uma empresa de novo.");

                if(GetPlayerScore(playerid) < 100)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa ter ao menos Level 100 para assaltar uma empresa.");
                
                pAssaltante[playerid][Valor] = 2000 + random(1000);

                SendClientMessage(playerid, -1, "| ASSALTO | Você está assaltando a Empresa ID {"COR_LARANJA_INC"}%d{ffffff}. Você irá receber {31b404}R$%s{ffffff} em {1c88f0}3 {ffffff}minutos.", GetPlayerVirtualWorld(playerid), RealStr(pAssaltante[playerid][Valor]));
                SendClientMessage(playerid, COR_VERMELHO, "| ASSALTO | Se você sair da empresa, seu assalto será cancelado automaticamente.");

                SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+2);

                pAssaltante[playerid][Assaltando] = true;

                pAssaltante[playerid][Type] = 3;

                pAssaltante[playerid][Min_A] = 2;
                pAssaltante[playerid][Seg_A] = 59;

                call::ASSALTANTE->ShowTD(playerid);
                pAssaltante[playerid][Timer_A] = SetTimerEx("OnPlayerRobBusiness", 1000, 0, "i", playerid);
            }

            if(actorid == ActorZIP[i])
            {
                if(Jogador[playerid][Profissao] == POLICIA_MILITAR)
                {
                    if(call::JOB->IsPlayerInWorking(playerid))
                    {
                        SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode assaltar uma empresa estando uniformizado.");
                    }
                }

                if(IsValidWeaponToRob(playerid) == false)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar com uma arma.");
                
                if(pAssaltante[playerid][Assaltando] == true)
                    return true;
                
                if(pAssaltante[playerid][InCooldown] == true)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa esperar antes de assaltar uma empresa de novo.");

                if(GetPlayerScore(playerid) < 100)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa ter ao menos Level 100 para assaltar uma empresa.");
                
                pAssaltante[playerid][Valor] = 2000 + random(1000);

                SendClientMessage(playerid, -1, "| ASSALTO | Você está assaltando a Empresa ID {"COR_LARANJA_INC"}%d{ffffff}. Você irá receber {31b404}R$%s{ffffff} em {1c88f0}3 {ffffff}minutos.", GetPlayerVirtualWorld(playerid), RealStr(pAssaltante[playerid][Valor]));
                SendClientMessage(playerid, COR_VERMELHO, "| ASSALTO | Se você sair da empresa, seu assalto será cancelado automaticamente.");

                SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+2);

                pAssaltante[playerid][Assaltando] = true;

                pAssaltante[playerid][Type] = 3;

                pAssaltante[playerid][Min_A] = 2;
                pAssaltante[playerid][Seg_A] = 59;

                call::ASSALTANTE->ShowTD(playerid);
                pAssaltante[playerid][Timer_A] = SetTimerEx("OnPlayerRobBusiness", 1000, 0, "i", playerid);
            }

            if(actorid == ActorDidierSachs[i])
            {
                if(Jogador[playerid][Profissao] == POLICIA_MILITAR)
                {
                    if(call::JOB->IsPlayerInWorking(playerid))
                    {
                        SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode assaltar uma empresa estando uniformizado.");
                    }
                }

                if(IsValidWeaponToRob(playerid) == false)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar com uma arma.");
                
                if(pAssaltante[playerid][Assaltando] == true)
                    return true;
                
                if(pAssaltante[playerid][InCooldown] == true)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa esperar antes de assaltar uma empresa de novo.");

                if(GetPlayerScore(playerid) < 100)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa ter ao menos Level 100 para assaltar uma empresa.");
                
                pAssaltante[playerid][Valor] = 2000 + random(1000);

                SendClientMessage(playerid, -1, "| ASSALTO | Você está assaltando a Empresa ID {"COR_LARANJA_INC"}%d{ffffff}. Você irá receber {31b404}R$%s{ffffff} em {1c88f0}3 {ffffff}minutos.", GetPlayerVirtualWorld(playerid), RealStr(pAssaltante[playerid][Valor]));
                SendClientMessage(playerid, COR_VERMELHO, "| ASSALTO | Se você sair da empresa, seu assalto será cancelado automaticamente.");

                SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+2);

                pAssaltante[playerid][Assaltando] = true;

                pAssaltante[playerid][Type] = 3;

                pAssaltante[playerid][Min_A] = 2;
                pAssaltante[playerid][Seg_A] = 59;

                call::ASSALTANTE->ShowTD(playerid);
                pAssaltante[playerid][Timer_A] = SetTimerEx("OnPlayerRobBusiness", 1000, 0, "i", playerid);
            }

            if(actorid == ActorVictim[i])
            {
                if(Jogador[playerid][Profissao] == POLICIA_MILITAR)
                {
                    if(call::JOB->IsPlayerInWorking(playerid))
                    {
                        SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode assaltar uma empresa estando uniformizado.");
                    }
                }

                if(IsValidWeaponToRob(playerid) == false)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar com uma arma.");
                
                if(pAssaltante[playerid][Assaltando] == true)
                    return true;
                
                if(pAssaltante[playerid][InCooldown] == true)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa esperar antes de assaltar uma empresa de novo.");

                if(GetPlayerScore(playerid) < 100)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa ter ao menos Level 100 para assaltar uma empresa.");
                
                pAssaltante[playerid][Valor] = 2000 + random(1000);

                SendClientMessage(playerid, -1, "| ASSALTO | Você está assaltando a Empresa ID {"COR_LARANJA_INC"}%d{ffffff}. Você irá receber {31b404}R$%s{ffffff} em {1c88f0}3 {ffffff}minutos.", GetPlayerVirtualWorld(playerid), RealStr(pAssaltante[playerid][Valor]));
                SendClientMessage(playerid, COR_VERMELHO, "| ASSALTO | Se você sair da empresa, seu assalto será cancelado automaticamente.");

                SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+2);

                pAssaltante[playerid][Assaltando] = true;

                pAssaltante[playerid][Type] = 3;

                pAssaltante[playerid][Min_A] = 2;
                pAssaltante[playerid][Seg_A] = 59;

                call::ASSALTANTE->ShowTD(playerid);
                pAssaltante[playerid][Timer_A] = SetTimerEx("OnPlayerRobBusiness", 1000, 0, "i", playerid);
            }

            if(actorid == ActorSubUrban[i])
            {
                if(Jogador[playerid][Profissao] == POLICIA_MILITAR)
                {
                    if(call::JOB->IsPlayerInWorking(playerid))
                    {
                        SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode assaltar uma empresa estando uniformizado.");
                    }
                }

                if(IsValidWeaponToRob(playerid) == false)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar com uma arma.");
                
                if(pAssaltante[playerid][Assaltando] == true)
                    return true;
                
                if(pAssaltante[playerid][InCooldown] == true)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa esperar antes de assaltar uma empresa de novo.");

                if(GetPlayerScore(playerid) < 100)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa ter ao menos Level 100 para assaltar uma empresa.");
                
                pAssaltante[playerid][Valor] = 2000 + random(1000);

                SendClientMessage(playerid, -1, "| ASSALTO | Você está assaltando a Empresa ID {"COR_LARANJA_INC"}%d{ffffff}. Você irá receber {31b404}R$%s{ffffff} em {1c88f0}3 {ffffff}minutos.", GetPlayerVirtualWorld(playerid), RealStr(pAssaltante[playerid][Valor]));
                SendClientMessage(playerid, COR_VERMELHO, "| ASSALTO | Se você sair da empresa, seu assalto será cancelado automaticamente.");

                SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+2);

                pAssaltante[playerid][Assaltando] = true;

                pAssaltante[playerid][Type] = 3;

                pAssaltante[playerid][Min_A] = 2;
                pAssaltante[playerid][Seg_A] = 59;

                call::ASSALTANTE->ShowTD(playerid);
                pAssaltante[playerid][Timer_A] = SetTimerEx("OnPlayerRobBusiness", 1000, 0, "i", playerid);
            }
        }
    }
    return 1;
}

forward OnPlayerRobBusiness(playerid);
public OnPlayerRobBusiness(playerid)
{
    if(GetPlayerVirtualWorld(playerid) == 0)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você saiu da empresa e o assalto foi cancelado automaticamente."), call::ASSALTANTE->ResetVariables(playerid);
    
    if(pAssaltante[playerid][Assaltando] == true)
    {
        pAssaltante[playerid][Seg_A]--;

        if(pAssaltante[playerid][Seg_A] > 0 && pAssaltante[playerid][Min_A] >= 0) { pAssaltante[playerid][Timer_A] = SetTimerEx("OnPlayerRobBusiness", 1000, 0, "i", playerid), call::ASSALTANTE->ShowTD(playerid); }

        if(pAssaltante[playerid][Seg_A] == 0)
        {
            if(pAssaltante[playerid][Min_A] != 0)
            {
                pAssaltante[playerid][Min_A]--;
                pAssaltante[playerid][Seg_A] = 59;
                pAssaltante[playerid][Timer_A] = SetTimerEx("OnPlayerRobBusiness", 1000, 0, "i", playerid);
            }

            else if(pAssaltante[playerid][Min_A] <= 0)
            {
                call::ASSALTANTE->RobBusiness(playerid);
            }
        }
    }
    return 1;   
}

CMD:reset(playerid)
{
    ResetarCooldown(playerid);
    return 1;
}
