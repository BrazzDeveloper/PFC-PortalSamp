// NEW JOB: REBOQUE

/* ----         Started at 13/05/2021 - 23:27                                                     */
/* ----         Author: Luiz "LuizM" Henrique                                                     */
/* ----         Credits: HarryPotter (suggestion)                                                 */
/* ----         Finished at 14/05/2021 - 03:02                                                    */
/* ----         First patch: 14/05/2021 - 03:02 - 508 lines                                       */

#include <YSI_Coding\y_hooks>
//DEFINE_HOOK_REPLACEMENT(OnVehicle, OV_);

#undef SKIN_MASCULINA
#undef SKIN_FEMININA

#define SKIN_MASCULINA  50
#define SKIN_FEMININA 195

enum Reboque
{
    bool:Uniformizado,
    bool:Working,
    LevelProf,
    Valor,
    CheckVeh
}
new pJobREBOQUE[MAX_PLAYERS][Reboque];

#define MAX_ATENDIMENTOS 10

enum Atendimento 
{
    bool:EmAtendimento,
    VeiculoAtendimento,
    ActorAtendimento,
    IDResponsavel
}
new pAtendimento[MAX_ATENDIMENTOS][Atendimento];

function REBOQUE::CreateMap()
{
    CreateDynamicPickup(1239, 1, 1916.6346,-1583.7509,14.4309); // Pickup locar
    CreateDynamic3DTextLabel("Reboque\nAperte '{ffff00}Y{ffffff}' para locar seu veículo", -1, 1916.6346,-1583.7509,14.4309, 10.0);

    CreateDynamicPickup(1275, 1, 1916.2867,-1579.7153,14.4409); // Pickup Uniforme
    CreateDynamic3DTextLabel("Reboque\nAperte '{ffff00}Y{ffffff}' para se uniformizar", -1, 1916.2867,-1579.7153,14.4409, 10.0);

    return 1;
}

function REBOQUE::ResetVariables(playerid, bool:dveiculo=false, bool:duniforme=false)
{
    if(dveiculo == true)
    {
        DestroyVehicle(Jogador[playerid][VeiculoLocado]);
        Jogador[playerid][VeiculoLocado] = INVALID_VEHICLE_ID;
    }

    if(duniforme == true)
    {
        SetPlayerSkin(playerid, Jogador[playerid][Skin]);
        pJobREBOQUE[playerid][Uniformizado] = false;
    }

    DisablePlayerRaceCheckpoint(playerid);
    call::PLAYER->DisablePlayerGPS(playerid);

    pJobREBOQUE[playerid][Working] = false;
    pJobREBOQUE[playerid][LevelProf] = 0;
    pJobREBOQUE[playerid][Valor] = 0;
    pJobREBOQUE[playerid][CheckVeh] = 0;

    for(new i; i < MAX_ATENDIMENTOS; i++)
    {
        if(pAtendimento[i][IDResponsavel] == playerid)
        {
            DestroyVehicle(pAtendimento[i][VeiculoAtendimento]);
            DestroyDynamicActor(pAtendimento[i][ActorAtendimento]);
            pAtendimento[i][EmAtendimento] = false;
            pAtendimento[i][IDResponsavel] = INVALID_PLAYER_ID;

            pAtendimento[i][VeiculoAtendimento] = INVALID_VEHICLE_ID;
            pAtendimento[i][ActorAtendimento] = INVALID_ACTOR_ID;
        }
    }

    return 1;
}

function REBOQUE::StartAtendimento(playerid, id)
{
    new count;

    for(new i; i < MAX_ATENDIMENTOS; i++)
    {
        if(pAtendimento[i][EmAtendimento] == false)
        {
            count++;
        }
    }

    if(count == 0)
    {
        SendClientMessage(playerid, COR_ERRO, "| ERRO | Todos atendimentos já estão em andamento. Aguarde um pouco.");
        return 1;
    }

    if(pAtendimento[id][EmAtendimento] == true)
    {
        new Rand = random(11);
        call::REBOQUE->StartAtendimento(playerid, Rand);
        return 1;
    }

    new ender[50];

    if(id == 0)
    {
        pAtendimento[id][VeiculoAtendimento] = CreateVehicle(405,1722.5201,425.1391,30.9439,340.1164, random(255), random(255), 0);
        pAtendimento[id][ActorAtendimento] = CreateDynamicActor(15,1722.4114,428.6410,31.0602,143.0671);

        call::PLAYER->SetPlayerMarkGPS(playerid, 1722.5201,425.1391,30.9439);

        pJobREBOQUE[playerid][Valor] = floatround ( GetPlayerDistanceFromPoint(playerid, 1722.5201,425.1391,30.9439) * 40 / 100);

        GetLocalName(1722.5201,425.1391, ender, sizeof(ender));
    }

    else if(id == 1)
    {
        pAtendimento[id][VeiculoAtendimento] = CreateVehicle(410,1337.9791,-2625.7314,13.1987,209.1718, random(255), random(255), 0);
        pAtendimento[id][ActorAtendimento] = CreateDynamicActor(15,1340.7819,-2627.7361,13.5469,5.6216);

        call::PLAYER->SetPlayerMarkGPS(playerid, 1337.9791,-2625.7314,13.1987);

        pJobREBOQUE[playerid][Valor] = floatround ( GetPlayerDistanceFromPoint(playerid, 1337.9791,-2625.7314,13.1987) * 40 / 100);

        GetLocalName(1337.9791,-2625.7314, ender, sizeof(ender));
    }

    else if(id == 2)
    {
        pAtendimento[id][VeiculoAtendimento] = CreateVehicle(401,-90.3371,-1196.4230,2.1207,345.2471, random(255), random(255), 0);
        pAtendimento[id][ActorAtendimento] = CreateDynamicActor(15,-87.8371,-1194.3269,2.0774,51.9176);

        call::PLAYER->SetPlayerMarkGPS(playerid, -90.3371,-1196.4230,2.1207);

        pJobREBOQUE[playerid][Valor] = floatround ( GetPlayerDistanceFromPoint(playerid, -90.3371,-1196.4230,2.1207) * 40 / 100);

        GetLocalName(-90.3371,-1196.4230, ender, sizeof(ender));
    }

    else if(id == 3)
    {
        pAtendimento[id][VeiculoAtendimento] = CreateVehicle(422,739.4399,-1169.8370,20.9023,131.8588, random(255), random(255), 0);
        pAtendimento[id][ActorAtendimento] = CreateDynamicActor(15,735.9269,-1170.9008,20.9095,215.6971);

        call::PLAYER->SetPlayerMarkGPS(playerid, 739.4399,-1169.8370,20.9023);

        pJobREBOQUE[playerid][Valor] = floatround ( GetPlayerDistanceFromPoint(playerid, 739.4399,-1169.8370,20.9023) * 40 / 100);

        GetLocalName(739.4399,-1169.8370, ender, sizeof(ender));
    }

    else if(id == 4)
    {
        pAtendimento[id][VeiculoAtendimento] = CreateVehicle(420,667.8325,-464.5672,16.1153,90.8302, 6, 6, 0);
        pAtendimento[id][ActorAtendimento] = CreateDynamicActor(15,664.8719,-462.9568,16.3359,161.6866);

        call::PLAYER->SetPlayerMarkGPS(playerid, 667.8325,-464.5672,16.1153);

        pJobREBOQUE[playerid][Valor] = floatround ( GetPlayerDistanceFromPoint(playerid, 667.8325,-464.5672,16.1153) * 40 / 100);

        GetLocalName(667.8325,-464.5672, ender, sizeof(ender));
    }

    else if(id == 5)
    {
        pAtendimento[id][VeiculoAtendimento] = CreateVehicle(439,-277.7225,-2196.7905,28.5771,113.8100, random(255), random(255), 0);
        pAtendimento[id][ActorAtendimento] = CreateDynamicActor(15,-278.8945,-2199.3667,28.6821,91.4215);

        call::PLAYER->SetPlayerMarkGPS(playerid, -277.7225,-2196.7905,28.5771);

        pJobREBOQUE[playerid][Valor] = floatround ( GetPlayerDistanceFromPoint(playerid, -277.7225,-2196.7905,28.5771) * 40 / 100);

        GetLocalName(-277.7225,-2196.7905, ender, sizeof(ender));
    }

    else if(id == 6)
    {
        pAtendimento[id][VeiculoAtendimento] = CreateVehicle(466,2896.8601,-1014.0971,10.7891,358.3611, random(255), random(255), 0);
        pAtendimento[id][ActorAtendimento] = CreateDynamicActor(15,2895.3462,-1011.1345,11.0476,150.5635);

        call::PLAYER->SetPlayerMarkGPS(playerid, 2896.8601,-1014.0971,10.7891);

        pJobREBOQUE[playerid][Valor] = floatround ( GetPlayerDistanceFromPoint(playerid, 2896.8601,-1014.0971,10.7891) * 40 / 100);

        GetLocalName(2896.8601,-1014.0971, ender, sizeof(ender));
    }

    else if(id == 7)
    {
        pAtendimento[id][VeiculoAtendimento] = CreateVehicle(400,59.4321,-222.8363,1.6651,358.0325, random(255), random(255), 0);
        pAtendimento[id][ActorAtendimento] = CreateDynamicActor(15,57.8615,-220.9487,1.5724,3.1598);

        call::PLAYER->SetPlayerMarkGPS(playerid, 59.4321,-222.8363,1.6651);

        pJobREBOQUE[playerid][Valor] = floatround ( GetPlayerDistanceFromPoint(playerid, 59.4321,-222.8363,1.6651) * 40 / 100);

        GetLocalName(59.4321,-222.8363, ender, sizeof(ender));
    }

    else if(id == 8)
    {
        pAtendimento[id][VeiculoAtendimento] = CreateVehicle(475,1232.0452,103.9489,20.8319,175.5202, random(255), random(255), 0);
        pAtendimento[id][ActorAtendimento] = CreateDynamicActor(15,1228.5883,97.2577,21.3695,213.9193);

        call::PLAYER->SetPlayerMarkGPS(playerid, 1232.0452,103.9489,20.8319);

        pJobREBOQUE[playerid][Valor] = floatround ( GetPlayerDistanceFromPoint(playerid, 1232.0452,103.9489,20.8319) * 40 / 100);

        GetLocalName(1232.0452,103.9489, ender, sizeof(ender));
    }

    else if(id == 9)
    {
        pAtendimento[id][VeiculoAtendimento] = CreateVehicle(479,-428.3424,-640.2731,11.8390,284.8177, random(255), random(255), 0);
        pAtendimento[id][ActorAtendimento] = CreateDynamicActor(15,1228.5883,97.2577,21.3695,213.9193);

        call::PLAYER->SetPlayerMarkGPS(playerid, -428.3424,-640.2731,11.8390);

        pJobREBOQUE[playerid][Valor] = floatround ( GetPlayerDistanceFromPoint(playerid, -428.3424,-640.2731,11.8390) * 40 / 100);

        GetLocalName(-428.3424,-640.2731, ender, sizeof(ender));
    }   

    SetVehicleHealth(pAtendimento[id][VeiculoAtendimento], 300.0);

	SetVehicleParams(pAtendimento[id][VeiculoAtendimento], VEHICLE_TYPE_BONNET, VEHICLE_PARAMS_ON);

    pAtendimento[id][EmAtendimento] = true;

    pAtendimento[id][IDResponsavel] = playerid;


    pJobREBOQUE[playerid][Working] = true;

    SendClientMessage(playerid, -1, "| ATENDIMENTO | Há um veículo quebrado nas localidades de {1c88f0}%s{ffffff}.", ender);
    SendClientMessage(playerid, -1, "| ATENDIMENTO | Siga o {ff0000}ponto vermelho {ffffff}em seu mapa para guinchar o veículo. Use: {"COR_LARANJA_INC"}/GuincharVeiculo{ffffff}.");
    SendClientMessage(playerid, -1, "| ATENDIMENTO | Atendimento ID: {1c88f0}%d{ffffff}.", id);
    return 1;   
}

function REBOQUE::GenerateAtendimento(playerid)
{
    new Rand = random(11);
    
    call::REBOQUE->StartAtendimento(playerid, Rand);
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    call::REBOQUE->ResetVariables(playerid, true, true);
    return 1;
}

hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 1226, 1908.2813, -1608.1172, 16.3906, 0.25);
    return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    for(new i; i < MAX_ATENDIMENTOS; i++)
    {
        if(vehicleid == pAtendimento[i][VeiculoAtendimento])
        {
            ClearAnimations(playerid);
            SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode entrar em um veículo de atendimento de reboque.");
        }
    }
    return 1;
}

hook OnGameModeInit()
{
    for(new i; i < MAX_ATENDIMENTOS; i++)
    {
        pAtendimento[i][IDResponsavel] = INVALID_PLAYER_ID;
        pAtendimento[i][VeiculoAtendimento] = INVALID_VEHICLE_ID;
        pAtendimento[i][ActorAtendimento] = INVALID_ACTOR_ID;
    }

    call::REBOQUE->CreateMap();
    
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == KEY_YES)
    {
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 1916.6346,-1583.7509,14.4309))
        {
            if(Jogador[playerid][Profissao] != REBOQUE)
                return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
            
            if(Jogador[playerid][VeiculoLocado] == INVALID_VEHICLE_ID)
            {
                if(pJobREBOQUE[playerid][Uniformizado] == false)
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar uniformizado para locar um veículo.");
                
                ShowPlayerDialog(playerid, DIALOG_LOCAR_REBOQUE, DIALOG_STYLE_MSGBOX, "{ffffff}Locar Veículo", "{ffffff}Você deseja locar um '{1c88f0}Towtruck{ffffff}'?\n{ff0000}OBS: Existe somente um spawn. Cuidado para não locar enquanto já estiver um veículo no local.", "Sim", "Não");
            }   
            else 
            {
                ShowPlayerDialog(playerid, DIALOG_DESLOCAR_REBOQUE, DIALOG_STYLE_MSGBOX, "{ffffff}Devolver Veículo", "{ffffff}Você deseja devolver seu '{1c88f0}Towtruck{ffffff}'?", "Sim", "Não");
            }
        }

        if(IsPlayerInRangeOfPoint(playerid, 2.0, 1916.2867,-1579.7153,14.4409))
        {
            if(Jogador[playerid][Profissao] != REBOQUE)
                return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
            
            if(pJobREBOQUE[playerid][Uniformizado] == false)
            {
                ShowPlayerDialog(playerid, DIALOG_UNIFORME_REBOQUE, DIALOG_STYLE_LIST, "{ffffff}Uniformes Disponíveis [ {31b404}2 {ffffff}]", "Uniforme Masculino\nUniforme Feminino", "Selecionar", "Cancelar");
                return 1;
            }
            else 
            {
                SendClientMessage(playerid, -1, "| UNIFORME | Você removeu seu uniforme de {6E6E6E}Reboque{ffffff}.");
                SetPlayerSkin(playerid, Jogador[playerid][Skin]);
                pJobREBOQUE[playerid][Uniformizado] = false;
                return 1;
            }
        }
    }
    return 1;
}

forward EntregarVeiculo(playerid);
public EntregarVeiculo(playerid)
{
    TogglePlayerControllable(playerid, true);
    SendClientMessage(playerid, -1, "| GUINCHO | Você entregou o veículo e recebeu {31b404}R$%s {ffffff}pelo seu serviço.", RealStr(pJobREBOQUE[playerid][Valor]));

    GivePlayerMoney(playerid, pJobREBOQUE[playerid][Valor]);

    call::REBOQUE->ResetVariables(playerid, false, false);
    return 1;
}

hook OnVehicleSpawn(vehicleid)
{
    new id;
    for(new i; i < MAX_ATENDIMENTOS; i++)
    {
        if(vehicleid == pAtendimento[i][VeiculoAtendimento])
        {
            id = pAtendimento[i][IDResponsavel];
        }
    }

    SendClientMessage(id, COR_ERRO, "| ERRO | Seus serviços foram cancelados pelo veículo do atendimento explodir / respawnar.");
    call::REBOQUE->ResetVariables(id, false, false);
    return 1;
}

hook OnPlayerEnterRaceCP(playerid)
{
    if(Jogador[playerid][Profissao] == REBOQUE)
    {
        if(pJobREBOQUE[playerid][Working] == true)
        {
            if(pJobREBOQUE[playerid][LevelProf] == 1)
            {
                new id;
                for(new i; i < MAX_ATENDIMENTOS; i++)
                {
                    if(pAtendimento[i][IDResponsavel] == playerid)
                    {
                        id = i;
                    }   
                }

                if(GetVehicleTrailer(GetPlayerVehicleID(playerid)) != pAtendimento[id][VeiculoAtendimento])
                    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar com o veículo guinchado no seu 'Towtruck'.");

                GameTextForPlayer(playerid, "~r~entregando ~w~veiculo", 3000, 5);
                SetTimerEx("EntregarVeiculo", 3000, 0, "i", playerid);

                TogglePlayerControllable(playerid, false);
            }
        }
    }
    return 1;
}

Dialog:DIALOG_UNIFORME_REBOQUE(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        SendClientMessage(playerid, -1, "| UNIFORME | Você vestiu seu uniforme de {6E6E6E}Reboque{ffffff}.");
        switch(listitem)
        {
            case 0: // Masculino
            {
                SetPlayerSkin(playerid, SKIN_MASCULINA);
                pJobREBOQUE[playerid][Uniformizado] = true;
            }
            case 1: // Feminino
            {
                SetPlayerSkin(playerid, SKIN_FEMININA);
                pJobREBOQUE[playerid][Uniformizado] = true;
            }
        }
    }
    return 1;
}

Dialog:DIALOG_LOCAR_REBOQUE(playerid, response, listitem, inputtext[])
{
    if(response)
    {

        Jogador[playerid][VeiculoLocado] = CreateVehicle(525, 1911.3934,-1586.1658,14.3097,180.3930, 0, 0, 300000);
        SendClientMessage(playerid, -1, "| VEÍCULO | Seu veículo '{1c88f0}Towtruck{ffffff}' foi locado com sucesso. Siga o {ff0000}ponto vermelho {ffffff}em seu mapa para pegá-lo.");
        call::PLAYER->SetPlayerMarkGPS(playerid, 1911.3934,-1586.1658,14.3097);
    }
    return 1;
}

Dialog:DIALOG_DESLOCAR_REBOQUE(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(GetPlayerVehicleID(playerid) != Jogador[playerid][VeiculoLocado])
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar em seu 'Towtruck'.");
        
        call::PLAYER->DisablePlayerGPS(playerid);

        call::REBOQUE->ResetVariables(playerid, true, true);
        SendClientMessage(playerid, -1, "| VEÍCULO | Seu veículo '{1c88f0}Towtruck{ffffff}' foi devolvido com sucesso.");
    }
    return 1;
}

CMD:atendimento(playerid)
{
    if(Jogador[playerid][Profissao] != REBOQUE)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
    
    if(Jogador[playerid][VeiculoLocado] == INVALID_VEHICLE_ID)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa locar um veículo primeiro.");
    
    if(GetPlayerVehicleID(playerid) != Jogador[playerid][VeiculoLocado])
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar em seu veículo locado.");
    
    if(pJobREBOQUE[playerid][Working] == true)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está trabalhando.");
    
    if(!IsPlayerInRangeOfPoint(playerid, 40.0, 1914.6030,-1591.5121,14.4309))
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar na HQ para utilizar este comando.");
    
    call::REBOQUE->GenerateAtendimento(playerid);
    return 1;
}

CMD:guincharveiculo(playerid)
{
    if(Jogador[playerid][Profissao] != REBOQUE)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");
    
    if(pJobREBOQUE[playerid][Working] == false)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");

    if(Jogador[playerid][VeiculoLocado] == INVALID_VEHICLE_ID)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa locar um veículo primeiro.");
    
    if(GetPlayerVehicleID(playerid) != Jogador[playerid][VeiculoLocado])
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa estar em seu veículo locado.");
    
    new vehicleid = GetPlayerVehicleID(playerid);

    new vehid = GetVehicleIdToRadiu(vehicleid, 15.0);

    if(vehid == INVALID_VEHICLE_ID)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Não há nenhum veículo perto de você.");

    new id;

	if ( vehid != INVALID_VEHICLE_ID )
	{
        for(new i; i < MAX_ATENDIMENTOS; i++)
        {
            if(pAtendimento[i][IDResponsavel] == playerid)
            {
                id = i;
            }
        }

        DestroyDynamicActor(pAtendimento[id][ActorAtendimento]);
        pAtendimento[id][ActorAtendimento] = INVALID_ACTOR_ID;

        if(vehid != pAtendimento[id][VeiculoAtendimento])
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você só pode guinchar veículos que necessitam de atendimento.");
        
        AttachTrailerToVehicle(vehid, vehicleid);
        SendClientMessage(playerid, -1, "| GUINCHO | Você guinchou o veículo. Siga para o {ff0000}ponto vermelho {ffffff}em seu mapa para entregá-lo.");

        pJobREBOQUE[playerid][CheckVeh] = 1;

        call::PLAYER->DisablePlayerGPS(playerid);

        pJobREBOQUE[playerid][Valor] = pJobREBOQUE[playerid][Valor] + floatround ( GetPlayerDistanceFromPoint(playerid, 1914.9159,-1591.5262,14.3156) * 40 / 100);

        SetPlayerRaceCheckpoint(playerid, 1, 1914.9159,-1591.5262,14.3156, 0.0, 0.0, 0.0, 5.0);
        pJobREBOQUE[playerid][LevelProf] = 1;
	}
    return 1;
}

flags:check(DEV);
CMD:check(playerid, params[])
{
    new id;
    if(sscanf(params, "d", id))
        return false;
    

    SendClientMessage(playerid, -1, "VeiculoAtendimento: %d", pAtendimento[id][VeiculoAtendimento]);
    SendClientMessage(playerid, -1, "EmAtendimento: %d", pAtendimento[id][EmAtendimento]);
    SendClientMessage(playerid, -1, "ActorAtendimento: %d", pAtendimento[id][ActorAtendimento]);
    SendClientMessage(playerid, -1, "IDResponsavel: %d", pAtendimento[id][IDResponsavel]);

    return 1;   
}