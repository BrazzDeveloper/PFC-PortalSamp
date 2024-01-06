// NEW JOB: DESPACHANTE DE BAGAGENS

/* ----         Started at 11/05/2021 - 15:16                                                     */
/* ----         Author: Luiz "LuizM" Henrique                                                     */
/* ----         Credits: Thiago (suggestion) and Morgana_ (map design)                            */
/* ----         Finished at 11/05/2021 - 16:57                                                    */
/* ----         First patch: 11/05/2021 - 16:57 - 233 lines                                       */

#include <YSI_Coding\y_hooks>

#define OnPlayerEnterDRaceCP  OnPlayerEnterDynamicRaceCP

enum Despachante 
{
    bool:Working,
    TrailerLocado,
    RaceCP,
    Malas,
    LevelDespachante
}
new pJobDESPACHANTE[MAX_PLAYERS][Despachante];

function DESPACHANTE::CreateMap(playerid)
{
    RemoveBuildingForPlayer(playerid, 3769, 1961.4453, -2216.1719, 14.9844, 0.25);
    RemoveBuildingForPlayer(playerid, 3664, 1960.6953, -2236.4297, 19.2813, 0.25);
    RemoveBuildingForPlayer(playerid, 1412, 1954.6172, -2227.4844, 13.6875, 0.25);
    RemoveBuildingForPlayer(playerid, 1412, 1965.1719, -2227.4141, 13.7578, 0.25);
    RemoveBuildingForPlayer(playerid, 1412, 1959.8984, -2227.4453, 13.7266, 0.25);
    RemoveBuildingForPlayer(playerid, 3625, 1961.4453, -2216.1719, 14.9844, 0.25);
    RemoveBuildingForPlayer(playerid, 1412, 1970.4453, -2227.4141, 13.7578, 0.25);

    CreateDynamicPickup(1239, 1, 2053.3010,-2225.1411,13.5469);
    CreateDynamic3DTextLabel("Despachante de Bagagens\nAperte '{ffff00}Y{ffffff}' para locar seu veículo.", -1, 2053.3010,-2225.1411,13.5469, 15.0);

    return 1;
}

function DESPACHANTE::ChoosePlace(playerid)
{
    static Float:locaisSpawn[][] =
    {
        {1730.4332,-2374.5513,12.9502},
        {1685.5281,-2374.5007,12.9381},
        {1642.2305,-2374.3999,12.9491}
    };

    new Rand = random(sizeof(locaisSpawn));

    pJobDESPACHANTE[playerid][RaceCP] = CreateDynamicRaceCP(1, locaisSpawn[Rand][0], locaisSpawn[Rand][1], locaisSpawn[Rand][2], 0.0, 0.0, 0.0, 5.0, -1, -1, playerid, 3000);

    pJobDESPACHANTE[playerid][LevelDespachante] = 1;

    SendClientMessage(playerid, 0x008b8bAA, "| DESPACHANTE | Vá para o ponto marcado em seu mapa para carregar as malas.");
    return 1;
}

forward CarregarMalas(playerid);
public CarregarMalas(playerid)
{
    TogglePlayerControllable(playerid, true);
    DestroyDynamicRaceCP(pJobDESPACHANTE[playerid][RaceCP]);

    pJobDESPACHANTE[playerid][LevelDespachante] = 2;

    static Float:locaisSpawn[][] =
    {
        {1894.1859,-2243.5461,13.1194},
        {1895.2975,-2328.4836,13.1164},
        {1767.9628,-2434.8552,13.1228},
        {1686.1210,-2434.2329,13.1118},
        {1606.6511,-2434.9607,13.1277},
        {1525.6823,-2436.5400,13.1204}
    };

    new Rand = random(sizeof(locaisSpawn));

    pJobDESPACHANTE[playerid][RaceCP] = CreateDynamicRaceCP(1, locaisSpawn[Rand][0], locaisSpawn[Rand][1], locaisSpawn[Rand][2], 0.0, 0.0, 0.0, 5.0, -1, -1, playerid, 3000.0);

    new malas = 30 + random(10);

    SendClientMessage(playerid, -1, "| MALAS | Você pegou {"COR_LARANJA_INC"}%d {ffffff}malas. Leve-as para o local indicado em seu mapa.", malas);

    pJobDESPACHANTE[playerid][Malas] = malas;

    return 1;
}

forward DescarregarMalas(playerid);
public DescarregarMalas(playerid)
{
    TogglePlayerControllable(playerid, true);

    new valor = 20*pJobDESPACHANTE[playerid][Malas];

    SendClientMessage(playerid, -1, "| MALAS | Você descarregou {"COR_LARANJA_INC"}%d {ffffff}malas e recebeu {31b404}R$%s {ffffff}pelo seu serviço.", pJobDESPACHANTE[playerid][Malas], RealStr(valor));

    GivePlayerMoney(playerid, valor);

    DestroyDynamicRaceCP(pJobDESPACHANTE[playerid][RaceCP]);

    pJobDESPACHANTE[playerid][Working] = false;
    pJobDESPACHANTE[playerid][RaceCP] = -1;
    pJobDESPACHANTE[playerid][Malas] = 0;
    pJobDESPACHANTE[playerid][LevelDespachante] = 0;

    return 1;
}

public OnPlayerEnterDRaceCP(playerid, checkpointid)
{
    if(checkpointid == pJobDESPACHANTE[playerid][RaceCP])
    {
        if(GetPlayerVehicleID(playerid) != Jogador[playerid][VeiculoLocado])
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar em seu 'Baggage'.");

        if(GetVehicleTrailer(GetPlayerVehicleID(playerid)) != pJobDESPACHANTE[playerid][TrailerLocado])
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar com seu 'Luggage Trailer B' conectado ao seu 'Baggage'.");

        if(pJobDESPACHANTE[playerid][LevelDespachante] == 1)
        {
            GameTextForPlayer(playerid, "~r~Carregando ~w~malas", 3000, 5);
            SetTimerEx("CarregarMalas", 3000, 0, "i", playerid);
            TogglePlayerControllable(playerid, false);
        }
        else if(pJobDESPACHANTE[playerid][LevelDespachante] == 2)
        {
            GameTextForPlayer(playerid, "~r~descarregando ~w~malas", 3000, 5);
            SetTimerEx("DescarregarMalas", 3000, 0, "i", playerid);
            TogglePlayerControllable(playerid, false);
        }
    }
    return 1;
}

hook OnPlayerConnect(playerid)
{
    call::DESPACHANTE->CreateMap(playerid);
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    call::DESPACHANTE->ResetVariables(playerid);
    return 1;
}

function DESPACHANTE::ResetVariables(playerid)
{
    DestroyVehicle(pJobDESPACHANTE[playerid][TrailerLocado]);
    DestroyVehicle(Jogador[playerid][VeiculoLocado]);

    if(pJobDESPACHANTE[playerid][RaceCP] != -1)
    {
        DestroyDynamicRaceCP(pJobDESPACHANTE[playerid][RaceCP]);
    }

    pJobDESPACHANTE[playerid][RaceCP] = -1;
    pJobDESPACHANTE[playerid][Working] = false;
    pJobDESPACHANTE[playerid][TrailerLocado] = -1;
    pJobDESPACHANTE[playerid][Malas] = 0;
    pJobDESPACHANTE[playerid][LevelDespachante] = 0;

    //CancelarServicos(playerid);
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == KEY_YES)
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0, 2053.3010,-2225.1411,13.5469))
        {
            if(Jogador[playerid][Profissao] != DESPACHANTE)
                return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
            
            if(Jogador[playerid][VeiculoLocado] == INVALID_VEHICLE_ID)
            {
                ShowPlayerDialog(playerid, DIALOG_LOCAR_DESPACHANTE, DIALOG_STYLE_MSGBOX, "{ffffff}Locar Veículo", "{ffffff}Você deseja locar um 'Baggage'?", "Sim", "Não");
            }
            else 
            {
                ShowPlayerDialog(playerid, DIALOG_DESLOCAR_DESPACHANTE, DIALOG_STYLE_MSGBOX, "{ffffff}Devolver Veículo", "{ffffff}Você deseja devolver seu 'Baggage'?", "Sim", "Não");
            }
        }
    }
    return 1;
}

Dialog:DIALOG_LOCAR_DESPACHANTE(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        static Float:locaisSpawn[][] = 
        {
            {2046.7065,-2218.6006,13.2031,92.7399},
            {2046.6226,-2214.0479,13.2048,90.9569},
            {2046.5183,-2209.9539,13.2049,92.1905},
            {2046.4899,-2205.4692,13.2039,91.1607},
            {2046.5675,-2200.8225,13.2037,91.2974},
            {2046.5216,-2196.0027,13.2064,91.6702}
        };
        new Rand = random(sizeof(locaisSpawn));

        pJobDESPACHANTE[playerid][TrailerLocado] = CreateVehicle(607, locaisSpawn[Rand][0]+4.0, locaisSpawn[Rand][1], locaisSpawn[Rand][2], locaisSpawn[Rand][3], 1, 1, 300000);
        Jogador[playerid][VeiculoLocado] = CreateVehicle(485, locaisSpawn[Rand][0], locaisSpawn[Rand][1], locaisSpawn[Rand][2], locaisSpawn[Rand][3], 1, 1, 300000);

        call::PLAYER->SetPlayerMarkGPS(playerid, locaisSpawn[Rand][0], locaisSpawn[Rand][1], locaisSpawn[Rand][2]);

        SetTimerEx("AttachTrailer", 500, 0, "i", playerid);

        SendClientMessage(playerid, -1, "| VEÍCULO | Seu '{1c88f0}Baggage{ffffff}' foi locado com sucesso. Siga o {ff0000}ponto vermelho {ffffff}em seu mapa para pegá-lo!");
    }
    return 1;
}

Dialog:DIALOG_DESLOCAR_DESPACHANTE(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(GetPlayerVehicleID(playerid) != Jogador[playerid][VeiculoLocado])
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar em seu veículo locado para devolvê-lo!");
        
        CancelarServicos(playerid);
        SendClientMessage(playerid, -1, "| VEÍCULO | Seu veículo '{1c88f0}Baggage{ffffff}' foi devolvido com sucesso.");
    }
    return 1;
}

forward AttachTrailer(playerid);
public AttachTrailer(playerid)
{
    AttachTrailerToVehicle(pJobDESPACHANTE[playerid][TrailerLocado], Jogador[playerid][VeiculoLocado]);
    return 1;
}

CMD:iniciarcoleta(playerid)
{
    if(Jogador[playerid][Profissao] != DESPACHANTE)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
    
    if(Jogador[playerid][VeiculoLocado] == INVALID_VEHICLE_ID)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa locar um veículo primeiro.");
    
    if(pJobDESPACHANTE[playerid][TrailerLocado] == INVALID_VEHICLE_ID)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa locar um trailer primeiro.");
    
    if(GetPlayerVehicleID(playerid) != Jogador[playerid][VeiculoLocado])
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar em seu 'Baggage' para iniciar a coleta.");
    
    if(!IsTrailerAttachedToVehicle(Jogador[playerid][VeiculoLocado]))
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa ter um 'Luggage Trailer B' conectado ao seu 'Baggage'.");

    if(pJobDESPACHANTE[playerid][Working] == true)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está trabalhando.");
    
    pJobDESPACHANTE[playerid][Working] = true;

    call::DESPACHANTE->ChoosePlace(playerid);
    return 1;
}