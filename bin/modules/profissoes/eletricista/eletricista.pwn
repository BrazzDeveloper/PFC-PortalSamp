// NEW JOB: ELETRICISTA

/* ----         Started at 08/05/2021 - 21:01                                                     */
/* ----         Author: Luiz "LuizM" Henrique                                                     */
/* ----         Credits: Sr.OtavioL (suggestion), Cowboy_ (suggestion) and Morgana_ (map design)  */
/* ----         Finished at 08/05/2021 - 23:40                                                    */
/* ----         First patch: 08/05/2021 - 23:41 - 427 lines                                       */

#define SKIN_ELETRICISTA_M    27
#define SKIN_ELETRICISTA_F    69
#define INVALID_STATE_ID -1


#include <YSI_Coding\y_hooks>

enum Eletricista
{
    bool:Working,
    bool:Uniformizado,
    StateID,
    CheckpointID,
    Valor
}
new pJobELETRICISTA[MAX_PLAYERS][Eletricista];

new GateEletricista;


static Float:placesSpawn[][] =
{
    {-2096.2974,-2250.2930,30.7110, 52.9856},
    {-2093.2866,-2246.5112,30.7805, 53.4145},
    {-2090.2905,-2242.4080,31.0585, 54.4433},
    {-2104.3713,-2232.2097,30.7110, 230.6928},
    {-2107.9197,-2236.4766,30.7096, 233.9684},
    {-2111.2043,-2241.1274,30.7093, 229.9171}
};


hook OnGameModeInit()
{
    CreatePickup(1239, 1, -2096.2788,-2254.8608,30.6250); // Pickup Locar
    CreateDynamic3DTextLabel("Eletricista\nAperte {ffff00}Y {ffffff}para locar seu veículo", -1, -2096.2788,-2254.8608,30.6250, 30.0); // Label locar

    CreatePickup(1275, 1, -2083.8020,-2266.3435,30.7724); // Pickup Uniforme
    CreateDynamic3DTextLabel("Eletricista\nAperte {ffff00}Y {ffffff}para se uniformizar", -1, -2083.8020,-2266.3435,30.7724, 30.0); // Label  uniforme

    // MAP
    CreateDynamicObject(966, -2105.22363, -2251.93628, 29.64610,   0.00000, 0.00000, -40.00010);
    GateEletricista = CreateDynamicObject(968, -2105.27686, -2251.87866, 30.46250,   0.00000, -90.00000, -40.00000);
    CreateDynamicObject(3459, -2118.72974, -2243.46216, 34.54955,   0.00000, 0.00000, -33.35999);
    CreateDynamicObject(3638, -2060.89600, -2276.03589, 32.96340,   0.00000, 0.00000, -37.56000);
    CreateDynamicObject(1687, -2080.98315, -2269.01123, 30.53564,   0.00000, 0.00000, -38.04007);
    CreateDynamicObject(10675, -2049.39697, -2284.92139, 32.93597,   0.00000, 0.00000, -37.62003);
    CreateDynamicObject(1697, -2071.31616, -2267.87500, 37.02480,   0.00000, 0.00000, 141.60008);
    CreateDynamicObject(1697, -2081.50439, -2262.68823, 36.69121,   0.00000, 0.00000, 141.60008);
    CreateDynamicObject(1697, -2090.12671, -2255.02002, 36.82654,   0.00000, 0.00000, 143.40025);
    CreateDynamicObject(8674, -2055.26343, -2257.83667, 31.89744,   0.30000, 0.30000, -36.72001);
    CreateDynamicObject(8674, -2047.01868, -2264.03662, 31.89740,   0.00000, 0.00000, -37.00000);
    CreateDynamicObject(8674, -2038.81421, -2270.21069, 31.89740,   0.00000, 0.00000, -37.00000);
    CreateDynamicObject(8674, -2032.91211, -2278.08301, 31.89740,   0.00000, 0.00000, -69.70002);
    CreateDynamicObject(8674, -2034.20691, -2286.99731, 31.89740,   0.00000, 0.00000, -126.58002);
    CreateDynamicObject(8674, -2040.26135, -2295.26196, 30.75783,   0.00000, 0.00000, -126.58002);
    CreateDynamicObject(8674, -2042.72461, -2298.39795, 30.78269,   0.00000, 0.00000, -126.58002);
    CreateDynamicObject(8674, -2050.13965, -2299.74854, 30.77736,   0.00000, 0.00000, -212.79941);
    CreateDynamicObject(8674, -2058.79883, -2294.18799, 30.79464,   0.00000, 0.00000, -212.79941);
    CreateDynamicObject(8674, -2066.91919, -2287.88916, 30.88790,   0.00000, -1.04000, -223.00000);
    CreateDynamicObject(8674, -2071.32495, -2279.30835, 30.98240,   0.00000, 0.00000, -263.07819);
    CreateDynamicObject(8674, -2063.52759, -2251.69507, 31.89744,   0.30000, 0.30000, -36.72001);
    CreateDynamicObject(8674, -2071.76782, -2245.59302, 31.89744,   0.30000, 0.30000, -36.72001);
    CreateDynamicObject(8674, -2080.02759, -2239.42773, 31.58771,   0.30000, 0.30000, -36.72001);
    CreateDynamicObject(8674, -2087.62231, -2232.66382, 31.39530,   0.00000, 0.00000, -46.11998);
    CreateDynamicObject(8674, -2094.62744, -2225.13647, 31.03944,   0.30000, 0.30000, -47.94003);
    CreateDynamicObject(8674, -2097.42871, -2222.04248, 31.04716,   0.30000, 0.30000, -47.94003);
    CreateDynamicObject(8674, -2104.00439, -2222.22388, 31.05267,   0.30000, 0.30000, -127.68004);
    CreateDynamicObject(8674, -2109.19507, -2228.86353, 31.01987,   0.30000, 0.30000, -128.81999);
    CreateDynamicObject(8674, -2115.68579, -2236.85327, 31.00255,   0.30000, 0.30000, -129.29997);
    CreateDynamicObject(8674, -2114.90503, -2244.03320, 31.02921,   0.30000, 0.30000, -218.81966);
    CreateDynamicObject(8674, -2101.08643, -2255.49438, 31.02921,   0.30000, 0.30000, -218.81966);
    CreateDynamicObject(8674, -2093.68872, -2254.86963, 31.02921,   0.30000, 0.30000, -311.27911);
    CreateDynamicObject(677, -2117.39038, -2240.40234, 29.61762,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(677, -2113.33496, -2235.27393, 29.60214,   0.00000, 0.00000, -0.66000);
    CreateDynamicObject(677, -2108.40771, -2229.39795, 29.60214,   0.00000, 0.00000, -0.66000);
    CreateDynamicObject(678, -2115.69580, -2238.03345, 29.61967,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(678, -2110.45996, -2231.50293, 29.61967,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(678, -2101.13550, -2219.72339, 29.97116,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(677, -2103.30737, -2222.92798, 29.60214,   0.00000, 0.00000, -0.66000);
    CreateDynamicObject(682, -2116.80762, -2239.38770, 29.61646,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(682, -2106.35864, -2226.32642, 29.61703,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(859, -2114.67603, -2236.54883, 29.61659,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(861, -2112.11694, -2233.54736, 29.61669,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(861, -2104.70679, -2224.61401, 29.61593,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2011, -2099.57520, -2220.78931, 29.33540,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1294, -2093.49365, -2253.25195, 29.37836,   0.00000, 0.00000, -43.92000);
    CreateDynamicObject(1294, -2090.59180, -2249.12598, 29.37836,   0.00000, 0.00000, -43.92000);
    CreateDynamicObject(1294, -2087.22241, -2244.75342, 29.37836,   0.00000, 0.00000, -43.92000);
    CreateDynamicObject(1294, -2091.62476, -2259.81982, 28.45482,   0.00000, 0.00000, 49.61995);
    CreateDynamicObject(1294, -2075.65283, -2271.48926, 28.45482,   0.00000, 0.00000, 49.61995);
    CreateDynamicObject(3666, -2051.19214, -2288.73901, 32.24549,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3666, -2061.38257, -2275.28979, 32.23630,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(18644, -2105.19556, -2252.53271, 32.40480,   90.00000, 0.00000, -30.00000);
    CreateDynamicObject(19294, -2105.22095, -2252.56787, 32.41707,   0.00000, 0.00000, 0.00000);
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    DestroyDynamicCP(pJobELETRICISTA[playerid][CheckpointID]);
    DestroyVehicle(Jogador[playerid][VeiculoLocado]);

    Jogador[playerid][VeiculoLocado] = INVALID_VEHICLE_ID;
    pJobELETRICISTA[playerid][Working] = false;
    pJobELETRICISTA[playerid][Uniformizado] = false;
    pJobELETRICISTA[playerid][StateID] = -1;
    pJobELETRICISTA[playerid][CheckpointID] = -1;
    pJobELETRICISTA[playerid][Valor] = 0;
    /*
    bool:Working,
    bool:Uniformizado,
    StateID,
    CheckpointID,
    Valor
    */
    return 1;
}

hook OnPlayerConnect(playerid)
{
    // MAP
    RemoveBuildingForPlayer(playerid, 1413, -2068.2422, -2277.3984, 30.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 1413, -2064.0703, -2274.0234, 30.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 1413, -2059.9219, -2270.6094, 30.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 1413, -2053.1328, -2259.9766, 30.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 1413, -2056.5078, -2267.5313, 30.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 1413, -2052.8438, -2263.6875, 30.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 698, -2051.9688, -2293.1172, 34.8125, 0.25);
    RemoveBuildingForPlayer(playerid, 1413, -2057.2813, -2256.5547, 30.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 1413, -2065.4922, -2249.6484, 30.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 1413, -2061.3438, -2253.0703, 30.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 1308, -2118.3828, -2246.4922, 29.7891, 0.25);
    RemoveBuildingForPlayer(playerid, 1413, -2115.8359, -2243.3984, 30.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 1413, -2069.6172, -2246.3125, 30.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 1413, -2116.0703, -2239.5781, 30.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 1413, -2112.5625, -2235.5078, 30.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 1413, -2109.1563, -2231.4375, 30.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 1413, -2082.0078, -2236.3672, 30.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 1413, -2077.8828, -2239.6016, 30.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 1413, -2073.7578, -2242.8906, 30.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 1413, -2090.2813, -2229.6094, 30.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 1413, -2086.1563, -2232.9453, 30.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 790, -2109.8594, -2221.5313, 34.7578, 0.25);
    RemoveBuildingForPlayer(playerid, 1413, -2105.6484, -2227.3672, 30.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 1413, -2102.2813, -2223.3125, 30.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 1413, -2094.4219, -2226.1875, 30.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 1413, -2098.5469, -2222.8984, 30.8984, 0.25);
    return 1;
}

forward BackGateEletricista();
public BackGateEletricista()
{
    MoveDynamicObject(GateEletricista, -2105.27686, -2251.87866, 30.46250-0.0001, 0.0001, 0.00000, -90.00000, -40.00000);
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == KEY_CROUCH)
    {
        if(IsPlayerInRangeOfPoint(playerid, 10.0, -2105.27686, -2251.87866, 30.46250))
        {
            if(Jogador[playerid][Profissao] != ELETRICISTA)
                return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");

            MoveDynamicObject(GateEletricista, -2105.27686, -2251.87866, 30.46250+0.0001, 0.0001, 0.0, -10.0, -40.0);
            SetTimer("BackGateEletricista", 10000, 0);
        }
    }

    if(newkeys == KEY_YES)
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0, -2096.2788,-2254.8608,30.6250)) // Pickup de Locar Veículo
        {
            if(Jogador[playerid][Profissao] != ELETRICISTA)
                return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
            
            if(pJobELETRICISTA[playerid][Uniformizado] == false)
                return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar uniformizado para locar um veículo.");
            
            if(Jogador[playerid][VeiculoLocado] == INVALID_VEHICLE_ID)
            {
                ShowPlayerDialog(playerid, DIALOG_LOCAR_ELETRICISTA, DIALOG_STYLE_MSGBOX, "{ffffff}Locar veículo", "{ffffff}Você deseja locar um 'Yosemite'?", "Sim", "Não");
                return 1;
            }
            else 
            {
                ShowPlayerDialog(playerid, DIALOG_DESLOCAR_ELETRICISTA, DIALOG_STYLE_MSGBOX, "{ffffff}Devolver veículo", "{ffffff}Você deseja devolver seu 'Yosemite'?", "Sim", "Não");
            }
        }   

        else if(IsPlayerInRangeOfPoint(playerid, 3.0, -2083.8020,-2266.3435,30.7724))
        {
            if(Jogador[playerid][Profissao] != ELETRICISTA)
                return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
                
            if(pJobELETRICISTA[playerid][Uniformizado] == false)
            {
                ShowPlayerDialog(playerid, DIALOG_UNIFORME_ELETRICISTA, DIALOG_STYLE_LIST, "{ffffff}Uniformes Disponíveis [ {31b404}2 {ffffff}]", "Masculino\nFeminino", "Selecionar", "Cancelar");
                return 1;
            }
            else 
            {
                SendClientMessage(playerid, -1, "| UNIFORME | Você retirou seu uniforme de {778899}eletricista{ffffff}.");
                if(pJobELETRICISTA[playerid][Working] == true)
                {
                    SendClientMessage(playerid, COR_ERRO, "| ERRO | Seus serviços foram cancelados por você retirar seu uniforme.");
                }
                SetPlayerSkin(playerid, Jogador[playerid][Skin]);
                pJobELETRICISTA[playerid][Uniformizado] = false;
                CancelarServicos(playerid);

            }
        }
    }
    return 1;
}

Dialog:DIALOG_UNIFORME_ELETRICISTA(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        switch(listitem)
        {
            case 0: // Masculino
            {
                SetPlayerSkin(playerid, SKIN_ELETRICISTA_M);
                pJobELETRICISTA[playerid][Uniformizado] = true;
            }

            case 1: // Feminino
            {
                SetPlayerSkin(playerid, SKIN_ELETRICISTA_F);
                pJobELETRICISTA[playerid][Uniformizado] = true;
            }   
        }
        SendClientMessage(playerid, -1, "| UNIFORME | Você vestiu seu uniforme de {778899}eletricista{ffffff}.");
    }
    return 1;
}

Dialog:DIALOG_LOCAR_ELETRICISTA(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        SendClientMessage(playerid, -1, "| VEÍCULO | Seu '{1c88f0}Yosemite{ffffff}' foi locado com sucesso. Siga o {ff0000}ponto vermelho {ffffff}em seu mapa para pegá-lo!");
        new Rand = random(sizeof(placesSpawn));
        Jogador[playerid][VeiculoLocado] = CreateVehicle(554, placesSpawn[Rand][0], placesSpawn[Rand][1], placesSpawn[Rand][2], placesSpawn[Rand][3], 1, 1, 300000);
        call::PLAYER->SetPlayerMarkGPS(playerid, placesSpawn[Rand][0], placesSpawn[Rand][1], placesSpawn[Rand][2]);
    }   
    return 1;
}

Dialog:DIALOG_DESLOCAR_ELETRICISTA(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(Jogador[playerid][VeiculoLocado] == INVALID_VEHICLE_ID)
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem nenhum veículo locado.");
        
        if(GetPlayerVehicleID(playerid) != Jogador[playerid][VeiculoLocado])  
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar no seu veículo locado.");
        
        SendClientMessage(playerid, -1, "| VEÍCULO | Seu veículo '{1c88f0}Yosemite{ffffff}' foi devolvido com sucesso.");
        DestroyVehicle(Jogador[playerid][VeiculoLocado]);
        CancelarServicos(playerid);
    }
    return 1;
}

forward RepairGenerator(playerid);
public RepairGenerator(playerid)
{
    TogglePlayerControllable(playerid, true);
    ClearAnimations(playerid);

    SendClientMessage(playerid, -1, "| GERADOR | Você reparou o gerador com sucesso. Você recebeu {31b404}R$%s {ffffff}pelo seu serviço.", RealStr(pJobELETRICISTA[playerid][Valor]));
    GivePlayerMoney(playerid, pJobELETRICISTA[playerid][Valor]);

    DestroyDynamicCP(pJobELETRICISTA[playerid][CheckpointID]);

    pJobELETRICISTA[playerid][Working] = false;
    pJobELETRICISTA[playerid][StateID] = INVALID_STATE_ID;
    pJobELETRICISTA[playerid][CheckpointID] = -1;
    pJobELETRICISTA[playerid][Valor] = 0;

    call::PLAYER->DisablePlayerGPS(playerid);

    RemovePlayerMapIcon(playerid, 90);

    return 1;
}

hook OnPlayerEnterDynamicCP(playerid, checkpointid)
{
    if(checkpointid == pJobELETRICISTA[playerid][CheckpointID])
    {
        new Float:Posicao[4];
        GetVehiclePos(Jogador[playerid][VeiculoLocado], Posicao[0], Posicao[1], Posicao[2]);

        if(!IsPlayerInRangeOfPoint(playerid, 30.0, Posicao[0], Posicao[1], Posicao[2]))
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar mais próximo de seu veículo.");
        
        if(IsPlayerInAnyVehicle(playerid))
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa sair do seu veículo para reparar o gerador.");

        SendClientMessage(playerid, -1, "| GERADOR | Você está reparando o gerador. Aguarde alguns segundos...");
        SetTimerEx("RepairGenerator", 3000, 0, "i", playerid);
        TogglePlayerControllable(playerid, false);
        ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 3000, 0);
    }
    return 1;
}

function ELETRICISTA::GenerateStations(playerid)
{
    static Float:placesStations[][] =
    {
        {2689.7200,-1959.8210,13.5469},
        {2689.6499,-1955.3818,13.5469},
        {2689.9500,-1951.0752,13.5469},
        {2669.1299,-1951.0613,13.5469},
        {2668.7759,-1955.3024,13.5469},
        {2669.0696,-1959.7900,13.5469},
        {2647.3640,-1959.8105,13.5469},
        {2647.5007,-1955.3256,13.5469},
        {2647.0000,-1951.0416,13.5469},
        {761.6103,2075.5686,6.7109},
        {753.1098,2075.4255,6.7109},
        {773.1314,2075.6599,6.7109},
        {781.6212,2075.5703,6.7109},
        {770.9528,2031.3914,6.7109},
        {776.5106,2031.3352,6.7109},
        {756.4436,2031.2924,6.7109},
        {750.8932,2031.3213,6.7109},
        {-1837.1654,2056.2603,9.8457},
        {-1837.0479,2064.1011,9.7141},
        {-2531.5942,-711.7257,139.3203},
        {-2526.7400,-711.9260,139.3203}
    };

    new Rand = random(sizeof(placesStations));

    if(IsPlayerInRangeOfPoint(playerid, 50.0, placesStations[Rand][0], placesStations[Rand][1], placesStations[Rand][2]))
        return call::ELETRICISTA->GenerateStations(playerid);
    
    SendClientMessage(playerid, -1, "| GERADOR | Foi detectada uma falha em um gerador em {1c88f0}%s{ffffff}.", call::ELETRICISTA->GetStateName(placesStations[Rand][0], placesStations[Rand][1]) );
    SendClientMessage(playerid, -1, "| GERADOR | Siga o {ff0000}ponto vermelho {ffffff}em seu mapa para consertá-lo!");

    pJobELETRICISTA[playerid][CheckpointID] = CreateDynamicCP(placesStations[Rand][0], placesStations[Rand][1], placesStations[Rand][2], 1.1, -1, -1, playerid);
    SetPlayerMapIcon(playerid, 90, placesStations[Rand][0], placesStations[Rand][1], placesStations[Rand][2], 0, 0xFF0000AA, MAPICON_GLOBAL);

    pJobELETRICISTA[playerid][Valor] = floatround(GetPlayerDistanceFromPoint(playerid, placesStations[Rand][0], placesStations[Rand][1], placesStations[Rand][2]) * 30 / 100);

    return 1;
}

function ELETRICISTA::GetStateName(Float:PosicaoX, Float:PosicaoY)
{
    new ender[MAX_ZONE_NAME];

	GetLocalName(Float:PosicaoX, Float:PosicaoY, ender, sizeof(ender));
	return ender;
}


CMD:iniciarreparo(playerid)
{
    if(Jogador[playerid][Profissao] != ELETRICISTA)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
    
    if(pJobELETRICISTA[playerid][Working] == true)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está trabalhando.");
    
    if(pJobELETRICISTA[playerid][Uniformizado] == false)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está uniformizado.");
    
    if(Jogador[playerid][VeiculoLocado] == INVALID_VEHICLE_ID)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa locar um veículo primeiro.");
    
    if(GetPlayerVehicleID(playerid) != Jogador[playerid][VeiculoLocado])
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar em seu 'Yosemite' para iniciar o reparo.");

    call::ELETRICISTA->GenerateStations(playerid);

    pJobELETRICISTA[playerid][Working] = true;

    return 1;
}