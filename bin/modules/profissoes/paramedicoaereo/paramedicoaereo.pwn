// NEW JOB: PARAMÉDICO AÉREO

/* ----         Started at 12/05/2021 - 17:18                                                     */
/* ----         Author: Luiz "LuizM" Henrique                                                     */
/* ----         Credits: Thiago (suggestion) and Morgana_ (map design)                            */
/* ----         Finished at 11/05/2021 - 16:57                                                    */
/* ----         First patch: 11/05/2021 - 16:57 - 233 lines                                       */

#include <YSI\y_hooks>
#undef DEFINE_HOOK_REPLACEMENT
DEFINE_HOOK_REPLACEMENT(OnPlayer, OP_);

enum ParamedicoAereo
{
    bool:Working,
    bool:Uniformizado,
    Orgao,
    LevelParamedico,
    Valor
}
new pJobPARAMEDICO_A[MAX_PLAYERS][ParamedicoAereo];

function PARAMEDICOA::ResetVariables(playerid, bool:dveiculo=false)
{
    if(dveiculo == true)
    {
        DestroyVehicle(Jogador[playerid][VeiculoLocado]);
        Jogador[playerid][VeiculoLocado] = INVALID_VEHICLE_ID;
    }

    DisablePlayerRaceCheckpoint(playerid);

    pJobPARAMEDICO_A[playerid][Working] = false;
    pJobPARAMEDICO_A[playerid][Uniformizado] = false;
    pJobPARAMEDICO_A[playerid][Orgao] = -1;
    pJobPARAMEDICO_A[playerid][LevelParamedico] = 0;
    pJobPARAMEDICO_A[playerid][Valor] = 0;
    return 1;
}

function PARAMEDICOA::CreateMap()
{
    CreateDynamicObject(9241, 2031.65417, -1381.32520, 48.99147,   0.00000, 0.00000, 0.42000);
    CreateDynamicObject(9241, 2071.93652, -1421.91418, 48.96100,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3666, 2020.89783, -1392.89929, 49.99087,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3666, 2042.82349, -1393.01318, 49.88718,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3666, 2043.08606, -1370.05371, 49.88344,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3666, 2020.58875, -1370.56030, 49.88567,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3666, 2083.68481, -1410.38159, 49.78523,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3666, 2083.34766, -1433.15588, 49.78320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3666, 2061.20166, -1433.22839, 49.78405,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3666, 2060.70020, -1410.83765, 49.78436,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19289, 6073.30908, 6843.80664, -4141.51172,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19289, 2048.01245, -1406.98364, 67.30216,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19289, 2048.08130, -1397.68689, 67.31658,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19289, 2039.59058, -1397.69934, 67.32391,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19289, 2039.57056, -1406.97192, 67.22047,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19289, 2088.14673, -1403.28296, 47.33208,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19289, 2088.16309, -1440.11218, 47.32357,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19289, 2006.93115, -1417.64038, 15.95891,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19289, 2048.28003, -1365.26758, 47.30273,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19289, 2008.95630, -1365.26440, 47.30605,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19289, 2008.91406, -1396.44055, 47.29097,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(5467, 2026.07971, -1404.74829, 45.87090,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3785, 2044.08936, -1410.25342, 20.66180,   0.00000, 0.00000, -179.00000);
    CreateDynamicObject(3785, 2044.08496, -1420.56738, 20.72770,   0.00000, 0.00000, -180.00000);
    CreateDynamicObject(3785, 2044.12549, -1429.96704, 20.76170,   0.00000, 0.00000, -165.00000);
    CreateDynamicObject(3785, 2019.51013, -1408.14966, 20.84150,   0.00000, 0.00000, -68.00000);
    CreateDynamicObject(3785, 2005.42188, -1408.14746, 20.80310,   0.00000, 0.00000, -66.00000);
    CreateDynamicObject(19976, 2009.04065, -1455.35767, 12.53220,   0.00000, 0.00000, 84.48000);
    CreateDynamicObject(19976, 1992.30798, -1437.48669, 13.02564,   0.00000, 0.00000, -163.20009);
    CreateDynamicObject(19976, 1958.82996, -1471.25317, 12.54370,   0.00000, 0.00000, -109.14001);
    CreateDynamicObject(19290, 1789.62268, -1551.59180, 38.85567,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19290, 1958.81226, -1471.23328, 14.80036,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19290, 2009.06299, -1455.35449, 14.77714,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19290, 1992.28979, -1437.46973, 15.32490,   0.00000, 0.00000, 0.00000);

    CreateDynamicPickup(1239, 1, 2041.3875,-1408.8801,17.1641);
    CreateDynamic3DTextLabel("Paramédico Aéreo\nAperte '{ffff00}Y{ffffff}' para subir no telhado", -1, 2041.3875,-1408.8801,17.1641, 10.0);

    CreateDynamicPickup(1239, 1, 2050.5420,-1409.3772,48.3359);
    CreateDynamic3DTextLabel("Paramédico Aéreo\nAperte '{ffff00}Y{ffffff}' para descer", -1, 2050.5420,-1409.3772,48.3359, 10.0);

    CreateDynamicPickup(1239, 1, 2061.3135,-1432.9227,50.7891);
    CreateDynamic3DTextLabel("Paramédico Aéreo\nAperte '{ffff00}Y{ffffff}' para locar um veículo", -1, 2061.3135,-1432.9227,50.7891, 10.0);
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    call::PARAMEDICOA->ResetVariables(playerid);
    return 1;
}

hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 739, 2096.5234, -1427.0781, 22.6641, 0.25);
    RemoveBuildingForPlayer(playerid, 714, 2118.4766, -1369.5938, 22.5078, 0.25);
    RemoveBuildingForPlayer(playerid, 5467, 2026.1172, -1404.6406, 46.0000, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 2025.7500, -1357.2188, 22.2500, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 2054.5859, -1365.4063, 22.2500, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 2099.0859, -1412.4141, 22.2500, 0.25);
    return 1;
}

hook OnGameModeInit()
{
    call::PARAMEDICOA->CreateMap();
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == KEY_YES)
    {
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 2041.3875,-1408.8801,17.1641))
        {
            if(Jogador[playerid][Profissao] != PARAMEDICO_AEREO)
                return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
            
            Teleport(playerid, 2051.8711,-1416.8270,48.3359,191.7089, 0, 0, 0);

            SetCameraBehindPlayer(playerid);
        }

        if(IsPlayerInRangeOfPoint(playerid, 2.0, 2050.5420,-1409.3772,48.3359))
        {
            if(Jogador[playerid][Profissao] != PARAMEDICO_AEREO)
                return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
            
            Teleport(playerid, 2041.3875,-1408.8801,17.1641, 0.0, 0, 0, 0);
            SetCameraBehindPlayer(playerid);
        }

        if(IsPlayerInRangeOfPoint(playerid, 2.0, 2061.3135,-1432.9227,50.7891))
        {
            if(Jogador[playerid][Profissao] != PARAMEDICO_AEREO)
                return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
            
            if(Jogador[playerid][VeiculoLocado] == INVALID_VEHICLE_ID)
            {
                ShowPlayerDialog(playerid, DIALOG_LOCAR_PARAMEDICOA, DIALOG_STYLE_MSGBOX, "{ffffff}Locar Veículo", "{ffffff}Você deseja locar um '{1c88f0}Raindance{ffffff}'?\n{ff0000}OBS: Existe somente um spawn. Cuidado para não locar enquanto já estiver um veículo no heliponto.", "Sim", "Não");
            }

            else 
            {
                ShowPlayerDialog(playerid, DIALOG_DESLOCAR_PARAMEDICOA, DIALOG_STYLE_MSGBOX, "{ffffff}Devolver Veículo", "{ffffff}Você deseja devolver seu '{1c88f0}Raindance{ffffff}'?", "Sim", "Não");
            }
        }
    }
    return 1;
}

forward CarregarOrgaos(playerid);
public CarregarOrgaos(playerid)
{
    if(Jogador[playerid][Profissao] == PARAMEDICO_AEREO)
    {
        if(pJobPARAMEDICO_A[playerid][LevelParamedico] == 1)
        {
            TogglePlayerControllable(playerid, true);

            new orgao[30];
            if(pJobPARAMEDICO_A[playerid][Orgao] == 0) { orgao = "Coração"; }
            else if(pJobPARAMEDICO_A[playerid][Orgao] == 1) { orgao = "Fígado"; }
            else if(pJobPARAMEDICO_A[playerid][Orgao] == 2) { orgao = "Rim"; }

            static Float:placesEntrega[][] = 
            {
                {-2571.2122,597.0159,15.1831},
                {-295.4856,1027.4480,20.3265},
                {1607.7573,1845.9868,11.5484},
                {1233.0402,321.1379,24.7578}
            };

            new Rand = random(sizeof(placesEntrega));

            new cidade[30];
            if(Rand == 0) { cidade = "San Fierro"; }
            else if(Rand == 1) { cidade = "Fort Carson"; }
            else if(Rand == 2) { cidade = "Las Venturas"; }
            else if(Rand == 3) { cidade = "Montgomery"; }

            SendClientMessage(playerid, -1, "| HOSPITAL | Descarregue {"COR_LARANJA_INC"}%s {ffffff}no {1c88f0}Hospital de %s{ffffff}.", orgao, cidade);

            SetPlayerRaceCheckpoint(playerid, 1, placesEntrega[Rand][0], placesEntrega[Rand][1], placesEntrega[Rand][2], 0.0, 0.0, 0.0, 5.0);

            pJobPARAMEDICO_A[playerid][LevelParamedico] = 2;

            pJobPARAMEDICO_A[playerid][Valor] = floatround(GetPlayerDistanceFromPoint(playerid, placesEntrega[Rand][0], placesEntrega[Rand][1], placesEntrega[Rand][2]) * 60 / 100);

            return 1;
        }

        if(pJobPARAMEDICO_A[playerid][LevelParamedico] == 2)
        {
            TogglePlayerControllable(playerid, true);

            new orgao[30];
            if(pJobPARAMEDICO_A[playerid][Orgao] == 0) { orgao = "Coração"; }
            else if(pJobPARAMEDICO_A[playerid][Orgao] == 1) { orgao = "Fígado"; }
            else if(pJobPARAMEDICO_A[playerid][Orgao] == 2) { orgao = "Rim"; }

            SendClientMessage(playerid, -1, "| TRANSPORTE | Você transportou {"COR_LARANJA_INC"}%s {ffffff}e recebeu {31b404}R$%s {ffffff}pelo seu serviço.", orgao, RealStr(pJobPARAMEDICO_A[playerid][Valor]));
            GivePlayerMoney(playerid, pJobPARAMEDICO_A[playerid][Valor]);

            call::PARAMEDICOA->ResetVariables(playerid);
        }
    }
    return 1;
}

hook OnPlayerEnterRaceCP(playerid)
{
    if(pJobPARAMEDICO_A[playerid][Working] == true)
    {
        if(GetPlayerVehicleID(playerid) != Jogador[playerid][VeiculoLocado])
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar em seu veículo locado.");
        
        new servico[40];
        if(pJobPARAMEDICO_A[playerid][LevelParamedico] == 1) { servico = "carregar"; }
        else if(pJobPARAMEDICO_A[playerid][LevelParamedico] == 2) { servico = "descarregar"; }
        
        if(GetPlayerSpeed(playerid) > 30)
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar parado para %s. Saia e entra do checkpoint mais devagar.", servico);

        if(pJobPARAMEDICO_A[playerid][LevelParamedico] == 1)
        { 
            DisablePlayerRaceCheckpoint(playerid);

            GameTextForPlayer(playerid, "~r~carregando ~w~orgaos", 3000, 5);
            TogglePlayerControllable(playerid, false);

            SetTimerEx("CarregarOrgaos", 3000, 0, "i", playerid);

            return 1;
        }

        else if(pJobPARAMEDICO_A[playerid][LevelParamedico] == 2)
        {
            DisablePlayerRaceCheckpoint(playerid);

            GameTextForPlayer(playerid, "~r~descarregando ~w~orgaos", 3000, 5);
            TogglePlayerControllable(playerid, false);

            SetTimerEx("CarregarOrgaos", 3000, 0, "i", playerid);
            return 1;
        }
    }
    return 1;
}

Dialog:DIALOG_LOCAR_PARAMEDICOA(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        Jogador[playerid][VeiculoLocado] = CreateVehicle(563, 2070.5720,-1421.7799,51.4628,89.6191, 3, 1, 300000);
        SendClientMessage(playerid, -1, "| VEÍCULO | Seu veículo '{1c88f0}Raindance{ffffff}' foi locado com sucesso. Siga o {ff0000}ponto vermelho {ffffff}em seu mapa para pegá-lo!");
        call::PLAYER->SetPlayerMarkGPS(playerid, 2070.5720,-1421.7799,51.4628);
    }
    return 1;
}

Dialog:DIALOG_DESLOCAR_PARAMEDICOA(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        SendClientMessage(playerid, -1, "| VEÍCULO | Seu veículo '{1c88f0}Raindance{ffffff}' foi devolvido com sucesso.");
        DestroyVehicle(Jogador[playerid][VeiculoLocado]);
        Jogador[playerid][VeiculoLocado] = INVALID_VEHICLE_ID;
        call::PARAMEDICOA->ResetVariables(playerid);

    }
    return 1;
}

CMD:transportarorgao(playerid)
{
    if(Jogador[playerid][Profissao] != PARAMEDICO_AEREO)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
    
    if(Jogador[playerid][VeiculoLocado] == INVALID_VEHICLE_ID)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa locar um veículo primeiro.");
    
    if(GetPlayerVehicleID(playerid) != Jogador[playerid][VeiculoLocado])
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar em seu 'Raindance' para transportar órgãos.");
    
    if(pJobPARAMEDICO_A[playerid][Working] == true)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está trabalhando.");
    
    new Rand = random(3);

    new orgao[30];
    if(Rand == 0) { orgao = "Coração"; }
    else if(Rand == 1) { orgao = "Fígado"; }
    else if(Rand == 2) { orgao = "Rim"; }

    pJobPARAMEDICO_A[playerid][Orgao] = Rand;


    SendClientMessage(playerid, -1, "| HOSPITAL | Carregue {"COR_LARANJA_INC"}%s {ffffff}no {1c88f0}Hospital de Los Santos{ffffff}.", orgao);

    pJobPARAMEDICO_A[playerid][Working] = true;

    SetPlayerRaceCheckpoint(playerid, 1, 2026.3485,-1381.1617,50.8906, 0.0, 0.0, 0.0, 5.0);

    pJobPARAMEDICO_A[playerid][LevelParamedico] = 1;
    return 1;   
}